<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix = "fn"  uri = "http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
var examCount = 0;
$(document).ready(function(){
	$(".btnTakeExam").click(function(event){
		if (!confirm("시험에 응시하시겠습니까?")) {
			return;
		}

		$("#quizForm #quiz").val($(this).attr("quiz"));

		var params = $("#quizForm").serialize();
		$.ajax({
			url:'examListAjax',
			type:'POST',
			data:params,
			dataType:'json',
			success:function(data){
				var list = data.list;

				if (list.length < 1) {
					alert("온라인 시험 준비 중입니다.");
					return;
				}

				// 확정전까지 주석처리
				/* if (data.examInfo.TAKE_COUNT > 0) {
					alert('이미 응시하셨습니다.');
					return;
				} */

				//서버시간(데이터베이스)을 기준으로 시험실 입자시간을 출력함.
				$("#takeExamTime").text(data.examInfo.TIME);

				$("#question-list").empty(); // 문제항목 초기화
				examCount = list.length;//문항수 저장
				for (var i = 0; i < list.length; i++) {
					if (list[i].OS_TYPE == "O") { //O:객관식
						var quiz = "<li>";
						quiz += "<input type='hidden' name='item"+(i+1)+"' value='"+list[i].ID+"' />";
						quiz += "<input type='hidden' name='bank"+(i+1)+"' value='"+list[i].QUIZ_BANK_ID+"' />";
						quiz += "<div class='item-header'>"+list[i].TITLE+"</div>";
						quiz += "<ol class='item-body'>";
						quiz += "<li><label><input type='radio' name='answer"+(i+1)+"' value='1'>"+list[i].EXAM1+"</label></li>";
						quiz += "<li><label><input type='radio' name='answer"+(i+1)+"' value='2'>"+list[i].EXAM2+"</label></li>";
						quiz += "<li><label><input type='radio' name='answer"+(i+1)+"' value='3'>"+list[i].EXAM3+"</label></li>";
						quiz += "<li><label><input type='radio' name='answer"+(i+1)+"' value='4'>"+list[i].EXAM4+"</label></li>";

						if(list[i].EXAM_TYPE == 2)
							quiz += "<li><label><input type='radio' name='answer"+(i+1)+"' value='5'>"+list[i].EXAM5+"</label></li>";

						quiz += "</ol>";
						quiz += "</li>";
						$("#question-list").append(quiz);

						/* 다지 선다형
						var quiz = "<li>";
						quiz += "<div class='item-header'></div>";
						quiz += "<ol class='item-body'>";
						quiz += "<li><label><input type='checkbox' name='quiz'></label></li>";
						quiz += "<li><label><input type='checkbox' name='quiz'></label></li>";
						quiz += "<li><label><input type='checkbox' name='quiz'></label></li>";
						quiz += "<li><label><input type='checkbox' name='quiz'></label></li>";
						quiz += "<li><label><input type='checkbox' name='quiz'></label></li>";
						quiz += "</ol>";
						quiz += "</li>";
						*/
					} else { //S:주관식
						/*TODO - 미구현 : 온라인시험은 무조건 객관식만 이용한다고함. */
					}
				}

				eventReassign();
				setLimits(data.examInfo.LIMITS, data.examInfo.REGIST_PC_COUNT);
				setLimitkeys(data.examInfo.LIMIT_KEYS);
				startTime(data.examInfo.EXAM_TIME);
				setCheatPrevent();

				popupOpenExam();
				setTimeout(saveExamHistory, 1000);


			}
		});
	});

	//quizForm
	$("#btnSubmit").click(function(event){
		unsetCheatPrevent();
		if (!confirm("제츨하시겠습니까?")) {
			setCheatPrevent();
			return;
		}


		if(!checkInputExam()) {//답안선택여부 확인
			alert("답안을 선택해 주십시오.");
			setCheatPrevent();
			return;
		}

		submitExam();
	});

	$("#btnCancel").click(function(event){
		popupCloseExam();
	});
});

function checkInputExam() {
	for (var i = 0; i < examCount; i++) {
		if(!$("input:radio[name='answer"+(i+1)+"']:checked").val()) return false;
	}

	return true;
}

function saveExamHistory() {
	var params = $("#quizForm").serialize();
	$.ajax({
			url:'examTakeHistAjax',
			type:'POST',
			data:params,
			dataType:'json'
	});
}

function submitExam() {
	var params = $("#quizForm").serialize();
	$.ajax({
			url:'examTakeAjax',
			type:'POST',
			data:params,
			dataType:'json',
			success:function(data){
				if(data.result == "SUCCESS") {
				  	alert("제출되었습니다.");
				} else {
					alert("제출에 문제가 발생하였습니다. 관리자에게 문의바랍니다.");
				}
			  	location.reload();
			}
	});
}

var timer;
var seconds = 0;//초기0초
var pad = function(x) { return (x < 10) ? "0"+x : x; }
function startTime(timeLimit) {
	var cname = "quiz_timer_" + $("#quizForm #quiz").val();
	var savedSeconds = getCookie(cname);

	if (savedSeconds < 1) savedSeconds = null;	// 시간 만료시 다음 응시 때 부자연스러운 엑션으로 추가

	seconds = savedSeconds!=null ? savedSeconds : timeLimit*60;

	calculateTime(); //최초 1회 실행

	if (timer != null) {
		clearInterval(timer);
		timer = null;
	}
	timer = setInterval(calculateTime, 1000); //1초후 1초마다 반복 실행
}

function calculateTime() {
	seconds--;
	var time = pad(parseInt(seconds / (60*60))) + ":" + pad(parseInt(seconds / 60 % 60)) + ":" + pad(seconds % 60);
	$("#timeLimit").text(time);

	var cname = "quiz_timer_" + $("#quizForm #quiz").val();
	setCookie(cname, seconds, 365);

	if(seconds < 1){	//시간소요에 따른 자동 제출 진행.
		unsetCheatPrevent();
		alert("시험시간이 종료되어 자동 제출됩니다.");
		submitExam();
	}
}

function eventReassign() {
	/*화면에 엘리먼트가 추가되면서 이벤트 재할당이 필요.*/
	$(".question-list .item-body input[type=radio]").click(function(){
		$(this).parent('label').parent('li').parent('ol').children().removeClass("check");
		$(this).parent('label').parent('li').addClass("check");
	});
	$(".question-list .item-body input[type=checkbox]").click(function(){
			$(this).parent('label').parent('li').toggleClass("check");
	});
	$('#exampop .cl-popup-closer').off('click');
}

function popupOpenExam() {
	popupOpen("exampop");
}

function popupCloseExam() {
	if (timer != null) {
		clearInterval(timer);
		timer = null;
	}
	unsetCheatPrevent();

	popupClose("exampop");
}

function showExamMyAnswer(quiz) {
	$("#popOnlineExamMyAnswer #myAnswerForm input[name='quiz']").val(quiz);
	var params = $("#popOnlineExamMyAnswer #myAnswerForm").serialize();
	$.ajax({
		url:'selectMyOnlineExamAnswerAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data) {
			if (data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var classInfo = data.classInfo;
			var examInfo = data.examInfo;
			var reportInfo = data.reportInfo;
			var list = data.quizList;
			var answerList = data.replyList;

			$("#popOnlineExamMyAnswer #question-list").empty();
			var right_count = 0;
			for (var i = 0; i < list.length; i++) {
				if (list[i].OS_TYPE == "O") { //O:객관식
					if (list[i].O_ANSWER==answerList[i].O_REPLY) right_count++;

					var quiz = "<li class='"+(list[i].O_ANSWER==answerList[i].O_REPLY?"answer-right":"answer-unright")+"'>";
					quiz += "<div class='item-header'>"+list[i].TITLE+"<strong class='right-answer'>(기재: "+answerList[i].O_REPLY+"번 / 정답: "+list[i].O_ANSWER+"번)</strong></div>";
					quiz += "<ol class='item-body'>";
					quiz += "<li class='"+(list[i].O_ANSWER=="1"?"right ":"") +(answerList[i].O_REPLY=="1"?"check  ":"") +"'><span>"+list[i].EXAM1+"</span></li>";
					quiz += "<li class='"+(list[i].O_ANSWER=="2"?"right ":"") +(answerList[i].O_REPLY=="2"?"check   ":"") +"'><span>"+list[i].EXAM2+"</span></li>";
					quiz += "<li class='"+(list[i].O_ANSWER=="3"?"right ":"") +(answerList[i].O_REPLY=="3"?"check   ":"") +"'><span>"+list[i].EXAM3+"</span></li>";
					quiz += "<li class='"+(list[i].O_ANSWER=="4"?"right ":"") +(answerList[i].O_REPLY=="4"?"check   ":"") +"'><span>"+list[i].EXAM4+"</span></li>";

					if(list[i].EXAM_TYPE == 2)
						quiz += "<li class='"+(list[i].O_ANSWER=="5"?"right ":"") +(answerList[i].O_REPLY=="5"?"check   ":"") +"'><span>"+list[i].EXAM5+"</span></li>";

					quiz += "</ol>";
					quiz += "</li>";
					$("#popOnlineExamMyAnswer #question-list").append(quiz);
				} else { //S:주관식
					/*TODO - 미구현 : 온라인시험/출석 고사는 무조건 객관식만 이용한다고함. */
				}
			}

			$("#popOnlineExamMyAnswer #cardinal_name").text(classInfo.CARDINAL_NAME);
			$("#popOnlineExamMyAnswer #course_name").text(classInfo.NAME);
			$("#popOnlineExamMyAnswer #exam_num").text(examInfo.TITLE);
			$("#popOnlineExamMyAnswer #total_score").text(reportInfo.SCORE);
			$("#popOnlineExamMyAnswer #right_count").text(right_count);
			$("#popOnlineExamMyAnswer #total_count").text(list.length);

			popupOpen('popOnlineExamMyAnswer');
		},
		error:function(e) {
		}
	});
}

// 시험응시 부정방지
var cheatCount = 0;
function setCheatPrevent() {
	cheatCount = 0;
	$(window).on('blur', function() {
		unsetCheatPrevent();
		_cheatCatch();

		setTimeout(function() {
			$(window).on('blur', function() {
				unsetCheatPrevent();
				_cheatCatch();
			});
		}, 100);
	});
}

function _cheatCatch() {
	/* alert("마우스 이탈로 자동 제출됩니다.");
	submitExam(); */
	++cheatCount;

	if(cheatCount == 1) {
		alert('부정이 감지되었습니다.\n부정 감지 2회시 시험 응시가 제한됩니다.');
	} else {
		popupCloseExam();
		alert('부정 감지로 응시가 제한되었습니다.');
	}
}

// 시험응시 부정방지 해제
function unsetCheatPrevent() {
	$(window).off('blur');
}

</script>

<t:insertDefinition name="mypageleftmenu"/>
<!-- 1.3. 본문 -->
	<div class="body">
			<div class="sub-header">
				<p class="sub-nav">
					<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
					<a href="#">나의 강의실</a>
					<a class="nth-last" href="${contextPath}">강의실</a>
				</p>
				<h2 class="sub-title">${classInfo.NAME }</h2>
				<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
			</div><!--//.sub-header-->
			<div class="sub-body">
				<div class="tab-group">
					<ul class="tab-header sub x7">
							<li><a href="classroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">홈</a></li>
							<li><a href="lesson?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">강의 보기</a></li>
							<li><a href="report?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 과제</a></li>
							<li><a class="nth-1st on" href="exam?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 시험</a></li>
							<li><a href="notice?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">공지 사항</a></li>
							<li><a href="dataroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">자료실</a></li>
							<li><a href="qna?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">질의 답변</a></li>
						</ul>
					<div class="tab-body">
				<!-- 탭별 로드되는 부분 Start -->
							<div class="group">
								<div class="group-header">
									<h3>온라인 시험</h3>
								</div>
								<div class="section">
									<ul id="list-exam" class="spread-list">
										<li class="list-header">
											<span class="item-title">시험명</span>
											<!--span class="item-type">유형</span-->
											<span class="item-date">시험 기간</span>
											<span class="item-state">응시 여부</span>
											<span class="item-score">시험 점수</span>
											<!--span class="item-memo">비고</span-->
											<span class="item-function">결과/답안보기</span>
										</li>
									<!-- ITEM 기본 형식 START-->
									<c:if test="${empty examList }">
										<li class="list-item">
											<p class="list-item-header">
												<span class="item-title">준비중인 온라인시험이 없습니다.</span>
											</p>
										</li>
									</c:if>
									<c:if test="${!empty examList }">
										<c:forEach var="item" items="${examList }" varStatus="status">
											<li class="list-item">
													<p class="list-item-header">
														<span class="item-title">${item.TITLE }</span>
														<!--span class="item-type">객관식</span-->
														<span class="item-date">${item.START_DATE } ~ ${item.END_DATE }</span>
														<span class="item-state">
															<c:if test="${item.USE_YN eq 'Y' && item.TAKE_YN eq '0'}"><em class="danger">미응시</em></c:if>
															<c:if test="${item.USE_YN eq 'Y' && item.TAKE_YN ne '0'}"><em class="primary">응시</em></c:if>
														</span>
														<span class="item-score">${item.QUIZ_SCORE }</span>
														<span class="item-function">
															<!-- <a class="btn primary" href="#" onclick="javascript:showExamMyAnswer();">확인</a> -->
															<c:if test="${item.OPEN_YN eq 'Y' }">확인가능</c:if>
															<c:if test="${item.OPEN_YN ne 'Y' }">-</c:if>
														</span>
													</p><!--.list-item-header-->
													<div class="section list-item-body">
														<div class="section-header">
															<h5>온라인 평가 안내</h5>
															<p class="ctrl-btnSet">
																<button class="btn-close">닫기</button>
															</p>
														</div>
														<div class="section-body borderT">
															<ul class="info-list">
																<li><em class="label">시험명</em> <em class="primary">${item.TITLE }</em></li>
																<li class="halfW"><em class="label">시험 구분</em> 온라인 평가(객관식)</li>
																<li class="halfW"><em class="label">시험 시간</em> 응시 시작부터 <strong class="danger">${item.EXAM_TIME }분</strong></li>
																<li class="clearL"><em class="label">시험 기간</em>
																	 [${item.START_DATE } 00:00 ~ ${item.END_DATE } 23:59] 기간내 응시
																	 <c:if test="${fn:contains(item.LIMITS, '2') }">(재응시 가능)</c:if>
																	 <c:if test="${!fn:contains(item.LIMITS, '2') }">(응시 기회는 1회)</c:if>
																</li>
																<li><em class="label">시험 안내</em>
																	<div class="html-view"> ${item.GUIDE }</div>
																</li>
																<li><em class="label">배점</em> 총 ${item.SCORE }점 만점</li>
															</ul>
														</div>
														<p class="btnSet">
													<!-- 응시기간이 아닌경우 -->
															<c:if test="${item.USE_YN eq 'N'  && item.IS_READY ne 'Y' }">
																<span>현재 응시기간이 아닙니다.</span>
															</c:if>
													<!-- 응시기간인 경우(&& 모바일이 아닌 경우) -->
															<c:if test="${not currentDevice.mobile }">
															<c:if test="${item.USE_YN eq 'Y' && item.IS_READY eq 'Y'}">
																<c:if test="${item.TAKE_YN eq '0'}">
																		<button class="btn M primary btnTakeExam" quiz="${item.ID }">응시하기</button>
																		<button class="btn M btnCloseExam">다음에 보기</button>
																</c:if>
																<c:if test="${item.TAKE_YN ne '0'}">
																	<c:if test="${fn:contains(item.LIMITS, '2') }">
																		<button class="btn M primary btnTakeExam" quiz="${item.ID }">다시 응시하기</button>
																		<button class="btn M btnCloseExam">다음에 보기</button>
																	</c:if>
																	<c:if test="${!fn:contains(item.LIMITS, '2') }">
																		<span>이미 응시하셨습니다.</span>
																	</c:if>
																</c:if>
															</c:if>
															</c:if>
													<!-- 응시하고, 답안 공개인 경우 -->
															<c:if test="${item.TAKE_YN ne '0' && item.OPEN_YN eq 'Y' }">
																<br/><br/><button class="btn M primary" onclick="javascript:showExamMyAnswer('${item.ID}');">결과/답안 확인하기</button>
															</c:if>
														</p>
													</div><!--//.list-item-body-->
												</li>
											</c:forEach>
										</c:if>
									</ul>
									<!-- <p>※ 평가 기간에 PC 홈페이지를 통해 제출할 수 있습니다. <em class="danger">(모바일 미지원)</em></p> -->
								</div><!--//.section-->
								<div class="section mobileScroll" id="learn-contents">
									<div class="section-header box strong">
										<h5>평가 기준 안내</h5>
									</div><!--//.group-header-->
									<table class="table">
										<thead>
											<tr>
												<th scope="col" rowspan="2">구분</th>
												<th scope="col" rowspan="2">평가 방법</th>
												<th scope="col" colspan="2">45시간(3학점)</th>
												<th scope="col" colspan="2">30시간(2학점)</th>
												<th scope="col" colspan="2">15시간(1학점)</th>
												<th scope="col" rowspan="2">내용</th>
											</tr>
											<tr class="subTh">
												<th scope="col">비율</th>
												<th scope="col">점수</th>
												<th scope="col">비율</th>
												<th scope="col">점수</th>
												<th scope="col">비율</th>
												<th scope="col">점수</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><strong>온라인 과제</strong></td>
												<td>주관식</td>
												<td>40%</td>
												<td>40점</td>
												<td>40%</td>
												<td>40점</td>
												<td>40%</td>
												<td>40점</td>
												<td>과정당 과제물 1회 부과</td>
											</tr>
											<tr class="on">
												<td>
													<span class="danger">*</span>
													<strong class="primary"> 온라인 시험</strong></td>
												<td>객관식</td>
												<td>40%</td>
												<td>40점</td>
												<td>40%</td>
												<td>40점</td>
												<td>40%</td>
												<td>40점</td>
												<td>온라인 평가 시험 1회 실시</td>
											</tr>
											<tr>
												<td><strong>참여도 평가</strong></td>
												<td>강의 참여도</td>
												<td>20%</td>
												<td>20점</td>
												<td>20%</td>
												<td>20점</td>
												<td>20%</td>
												<td>20점</td>
												<td>진도율 90% 이상</td>
											</tr>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="2"><strong>합계</strong></td>
												<td colspan="2">100점</td>
												<td colspan="2">100점</td>
												<td colspan="2">100점</td>
												<td colspan="2">&nbsp;</td>
											</tr>
										</tfoot>
									</table>
								</div><!--//.section-->
							</div><!--//.group-->
				<!--// 탭별 로드되는 부분 END -->
						</div>
				</div><!--.tab-group-->
			</div><!--//.sub-body-->
		</div>
<!-- 1.3. 본문 -->

<!-- exam popup -->
<t:insertDefinition name="exam"/>
<t:insertDefinition name="exammyanswer"/>