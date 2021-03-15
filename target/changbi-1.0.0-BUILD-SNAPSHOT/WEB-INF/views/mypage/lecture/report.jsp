<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix = "fn"  uri = "http://java.sun.com/jsp/jstl/functions" %>
<c:set var="newline" value="<%= \"\n\" %>" /><%--cr to br --%>

<style type="text/css">
ul#list-exam span.item-title {width:300px; width:calc(100% - 42rem); font-weight:700; font-size:14px; font-size: .875rem}
ul#list-exam span.item-date {width:240px; width:15rem}
ul#list-exam span.item-state,
ul#list-exam span.item-score,
ul#list-exam span.item-function {width:140px; width:7.75rem}
</style>

<script type="text/javascript">
var ckplus	= "http://admin.changbiedu.com:8083/ckplus/copykiller.jsp";
var examCount = 0;
$(document).ready(function(){
	//과제제출진행 클릭이벤트
	$(".btnTakeExam").click(function(event){
		if (!confirm("과제를 제출하시겠습니까?")) {
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

				if(list.length < 1) {
					alert("온라인 과제 준비중입니다.");
					return;
				}

				$("#question-list").empty(); // 문제항목 초기화
				examCount = list.length;//문항수 저장
				for(var i = 0; i < list.length; i++) {
					var quiz = "";
					quiz += "<input type='hidden' name='item"+(i+1)+"' value='"+list[i].ID+"' />";
					quiz += "<input type='hidden' name='bank"+(i+1)+"' value='"+list[i].QUIZ_BANK_ID+"' />";
					quiz += "<div class='section-header'>";
					quiz += "<h5>"+list[i].TITLE+"</h5>";
					quiz += "<div class='html-view'>"+list[i].COMMENT+"</div>";
					quiz += "</div>";
					quiz += "<div class='section-body'>";
					quiz += "<textarea name='answer"+(i+1)+"'></textarea>";
					quiz += "</div>";
					$("#question-list").append(quiz);
				}

				setLimitkeys(data.examInfo.LIMIT_KEYS);
				//데이터 설정이 끝나고 팝업창 오픈
				popupOpen("reportpop");
			}
		});
	});

	//과제제출버튼 클릭이벤트
	$("#btnSubmit").click(function(){
		if(!confirm("제출하시겠습니까?")) {
			return;
		}

		if(!checkInputReport()) {
			alert("내용 또는 파일을 입력하여 주십시오.");
			return;
		}

		submitReport();

	});

	//과제제출취소버튼 클릭이벤트
	$("#btnCancel").click(function(){
		popupClose("reportpop");
	});

	$(".btn-copyratio").click(function(){
		var uri = $(this).attr("data-uri");
		var property = $(this).attr("data-property");
		window.open(ckplus+"?uri="+uri+"&property_id="+property);
	});
});

function checkInputReport() {
	var isAnswer = false;
	for (var i = 0; i < examCount; i++) {
		console.log($("textarea[name='answer"+(i+1)+"']").val());
		if($("textarea[name='answer"+(i+1)+"']").val()) {
			isAnswer = true;		// 한 항목이라도 입력한 경우
			break;
		}
	}

	var isFile = true;
	if( !$("#reportfile").val()) isFile =  false; // 파일이 선택이 안된 경우에는

	if(!isAnswer && !isFile) return false; //모두 입력이 안된 경우에는

	return true;
}

function submitReport() {
	var formData = new FormData($('#quizForm')[0]);
  $.ajax({
  	url:"reportTakeAjax",
  	type:'POST',
		data:formData,
		dataType:'json',
		processData: false,
    contentType: false,
		success:function(data){
			if(data.result == "SUCCESS") {
				alert("제출되었습니다.");
			  location.reload();
			} else {
				alert("제출에 문제가 발생하였습니다. 관리자에게 문의바랍니다.");
			}
		}
	});
}

function popupOpen(popup){
	$("#"+popup).addClass("on");
}
function popupClose(popup){
	$("#"+popup).removeClass("on");
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
							<li><a class="nth-1st on" href="report?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 과제</a></li>
							<li><a href="exam?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 시험</a></li>
							<li><a href="notice?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">공지 사항</a></li>
							<li><a href="dataroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">자료실</a></li>
							<li><a href="qna?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">질의 답변</a></li>
						</ul>
					<div class="tab-body">
				<!-- 탭별 로드되는 부분 Start -->
							<div class="group">
								<div class="group-header">
									<h3>온라인 과제</h3>
								</div>
								<div class="section">
									<ul id="list-exam" class="spread-list">
										<li class="list-header">
											<span class="item-title">과제명</span>
											<!--span class="item-type">유형</span-->
											<span class="item-date">과제 기간</span>
											<span class="item-state">제출 여부</span>
											<span class="item-score">과제 점수</span>
											<!--span class="item-memo">비고</span-->
										</li>
										<c:if test="${empty examList }">
											<li class="list-item">
												<p class="list-item-header">
													<span class="item-title">준비중인 온라인 과제가 없습니다.</span>
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
																<c:if test="${item.USE_YN eq 'Y'  && item.TAKE_YN eq '0'}"><em class="danger">미제출</em></c:if>
																<c:if test="${item.USE_YN eq 'Y'  && item.TAKE_YN ne '0'}"><em class="primary">제출</em></c:if>
															</span>
															<span class="item-score">${item.QUIZ_SCORE }</span>
															<!--span class="item-memo">참여 점수 감점</span-->
														</p><!--.list-item-header-->
														<div class="section list-item-body">
															<div class="section-header">
																<h5>온라인 과제 안내</h5>
																<p class="ctrl-btnSet">
																	<button class="btn-close">닫기</button>
																</p>
															</div>
															<div class="section-body borderT">
																<ul class="info-list">
																	<li><em class="label">과제명</em> <em class="primary">${item.TITLE }</em></li>
																	<li class="clearL"><em class="label">과제 기간</em>
																		[${item.START_DATE } 00:00 ~ ${item.END_DATE } 23:59] 기간내 제출
																		<c:if test="${fn:contains(item.LIMITS, '2') }">(재응시 가능)</c:if>
																	  <c:if test="${!fn:contains(item.LIMITS, '2') }">(응시 기회는 1회)</c:if>
																	</li>
																	<li><em class="label">과제 안내</em>
																		<div class="html-view"> ${item.GUIDE }</div>
																	</li>
																	<li><em class="label">배점</em> 총 ${item.SCORE }점 만점</li>
																	<li><em class="label">모사 결과</em>
																		<c:if test="${!empty item.copyRatioList }">
																			<c:forEach items="${item.copyRatioList}" var="copyRatio">
																				<c:if test="${copyRatio.CHECK_TYPE eq 'report'}">
																					${copyRatio.DISP_TOTAL_COPY_RATIO } <a class="btn XS btn-copyratio" href="#" data-uri="${copyRatio.URI }" data-property="4">내용 확인</a>
																				</c:if>
																			</c:forEach>
																		</c:if>
																	</li>
																	<li><em class="label">첨삭 지도</em>
																		${fn:replace(item.CORRECT, newline, '<br />')}
																	</li>
																</ul>
															</div>
															<p class="btnSet">
													<!-- 응시기간이 아닌경우 -->
																<c:if test="${item.USE_YN eq 'N' && item.IS_READY ne 'Y' }">
																	<span>현재 제출기간이 아닙니다.</span>
																</c:if>
																<c:if test="${not currentDevice.mobile }">
																<c:if test="${item.USE_YN eq 'Y' && item.IS_READY eq 'Y'}">
																	<c:if test="${item.TAKE_YN eq '0'}">
																			<button class="btn M primary btnTakeExam" quiz="${item.ID }">제출하기</button>
																			<button class="btn M">다음에 보기</button>
																	</c:if>
																	<c:if test="${item.TAKE_YN ne '0'}">
																		<c:if test="${fn:contains(item.LIMITS, '2') }">
																			<button class="btn M primary btnTakeExam" quiz="${item.ID }">다시 제출하기</button>
																			<button class="btn M">다음에 보기</button>
																		</c:if>
																		<c:if test="${!fn:contains(item.LIMITS, '2') }">
																			<span>이미 제출하셨습니다.</span>
																		</c:if>

																	</c:if>
																</c:if>
																</c:if>
															</p>
														</div><!--//.list-item-body-->
													</li>
												</c:forEach>
											</c:if>
										<%/*

									<!-- ITEM 기본 형식 START-->
										<li class="list-item">
											<p class="list-item-header">
												<span class="item-title">온라인 과제</span>
												<!--span class="item-type">객관식</span-->
												<span class="item-date">2018. 03. 11 ~ 2018. 04. 01</span>
												<span class="item-state"><em class="danger">미응시</em></span>
												<span class="item-score">-</span>
												<!--span class="item-memo">참여 점수 감점</span-->
												<span class="item-function"><!--a class="btn primary" href="#" target="_blank">평가 보기</a--><!--버튼이 나오는 공간인지 확인 필요--> - </span>
											</p><!--.list-item-header-->
											<div class="section list-item-body">
												<div class="section-header">
													<h5>온라인 과제 안내</h5>
													<p class="ctrl-btnSet">
														<button class="btn-close">닫기</button>
													</p>
												</div>
												<div class="section-body borderT">
													<ul class="info-list">
														<li><em class="label">과제명</em> <em class="primary">온라인 과제</em></li>
														<li><em class="label">과제 기간</em> [2018. 03. 11 00:00 ~ 2018. 04. 01 23:59] 기간내 제출</li>
														<li><em class="label">과제 안내</em>
															<div class="html-view"> 내용입력<br> 내용입력<br>내용입력</div>
														</li>
														<li><em class="label">배점</em> 총 100점 만점</li>
													</ul>
												</div>
												<p class="btnSet">
													<button class="btn M primary">제출하기</button>
													<button class="btn M">다음에 보기</button>
												</p>
											</div><!--//.list-item-body-->
										</li>
									<!--//ITEM 기본 형식 END-->
									*/ %>
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
											<tr class="on">
												<td>
													<span class="danger">*</span>
													<strong class="primary">온라인 과제</strong>
												</td>
												<td>주관식</td>
												<td>40%</td>
												<td>40점</td>
												<td>40%</td>
												<td>40점</td>
												<td>40%</td>
												<td>40점</td>
												<td>과정당 과제물 1회 부과</td>
											</tr>
											<tr>
												<td><strong> 온라인 시험</strong></td>
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


<!-- localecode popup : 연수지명번호 수정 -->
<t:insertDefinition name="report"/>