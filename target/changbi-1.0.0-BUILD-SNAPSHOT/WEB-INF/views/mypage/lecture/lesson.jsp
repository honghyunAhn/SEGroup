<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript" src="/resources/js/jsrender.js"></script><!-- template lib  -->
<script type="text/javascript">
function jsrenderTrimFunction(value) {
	return value.trim();
}
var jsrenderHelpers = {trim: jsrenderTrimFunction};

function goPlayer(chapterId, idx, width, height, op) {

  var isMobile = ${currentDevice.mobile };

  // 모바일 수강 가능 여부 체크
  if(isMobile && '${classInfo.MOBILE_YN }' != 'Y' ) {
	  alert('본 과정은 모바일에서 수강할 수 없습니다.\nPC에서 수강하여 주십시오.');
	  return;
  }

  $("#chapterForm #chapter").val(chapterId);
  $("#chapterForm #idx").val(idx);
  $("#chapterForm #op").val(op);

  if(isMobile) {	// 어플에서 팝업문제로 분기 처리
	  var popOption = "width="+screen.availWidth+"px, height="+screen.availHeight+"px";
	  popOption += ", toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, directories=no";
	  popOption += ", top=0, left=0";

	  var playerWindow = window.open("/class/study/player?"+$('#chapterForm').serialize(),"",popOption);
  } else {
	  var popOption = "width="+width+"px, height="+height+"px";
	  popOption += ", toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, directories=no";
	  popOption += ", top=0, left=0";

	   var playerWindow = window.open("about:blank","playerWindow",popOption);
	  if ((width == 0 || height == 0 ) && (playerWindow.outerWidth < screen.availWidth || playerWindow.outerHeight < screen.availHeight)) {
		  playerWindow.moveTo(0,0);
		  playerWindow.resizeTo(screen.availWidth, screen.availHeight);
	  }


		$('#chapterForm')
		.attr('action','/class/study/player')
		.attr('method','POST')
		.attr('target','playerWindow')
		.submit();
  }

}

function showReviewPopup() {
	var params = $("#reviewForm").serialize();
	$.ajax({
		url:'checkLessonReviewAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if (data.result == "SUCCESS") {
				popupOpen("popupReview");
			} else {
				alert("이미 해당 과정에 대한 연수 후기를 작성하셨습니다.");
			}
		},
		error:function(e){
			alert("데이터 조회시 문제가 발생했습니다.");
		}
	});
}

function saveReview() {
	var params = $("#reviewForm").serialize();
	$.ajax({
		url:'saveLessonReview',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if (data.result == "SUCCESS") {
				alert("저장되었습니다.");
				popupClose("popupReview");
				location.reload();
			} else {
				alert("연수 후기 저장 도중 문제가 발생했습니다.");
				location.reload();
			}
		},
		error:function(e){
			alert("연수 후기 저장 도중 문제가 발생했습니다.");
			location.reload();
		}
	});
}

function showPollPopup(type) {
	$("#pollForm input[name='type']").val(type);
	var params = $("#pollForm").serialize();
	$.ajax({
		url:'classPollAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			console.log(data);

			var info = data.info;
			var list = data.list;
			if(!info || !list) {
				alert("설문이 없습니다."); return;
			}

			if(info.ACCEPT_CNT) {
				alert("이미 설문을 제출하셨습니다. "); return;
			}

			/* 설문정보 - 제목/안내 */
			//$("#pollTitle").empty().append(info.TITLE)
			$("#pollGuide").empty().append(info.A_LEAD);

			/* 설문항목 - 질의/보기 */
			for(var i = 0; i < list.length; i++) {
				console.log(list[i]);
				var item = list[i];

			}

			$("#pollList").html($("#surveyTypeTmpl").render(list, jsrenderHelpers));
			popupOpen("popupPoll");
		},
		error:function(e){
			alert("데이터 조회시 문제가 발생했습니다.");
		}
	});
}

function savePoll() {
	var params = $("#pollForm").serialize();

	$.ajax({
		url:'saveClassPollAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if (data.result == "SUCCESS") {
				alert("저장되었습니다.");
				popupClose("popupPoll");
				location.reload();
			} else {
				alert("설문 저장 도중 문제가 발생했습니다.");
				location.reload();
			}
		},
		error:function(e){
			alert("데이터 조회시 문제가 발생했습니다.");
			location.reload();
		}
	});
}

</script>

<!-- 통합처리 -->
<script id="surveyTypeTmpl" type="text/x-jsrender">
{{if ITEM_TYPE == '1'}}
	{{include tmpl="#surveyTypeTmpl1"/}}
</li>
{{else ITEM_TYPE == '2'}}
	{{include tmpl="#surveyTypeTmpl2"/}}
</li>
{{else}}
	{{include tmpl="#surveyTypeTmpl3"/}}
{{/if}}
</script>

<!-- //객관식 설문 유형 -->
<script id="surveyTypeTmpl1" type="text/x-jsrender">
<li class="typeObjL">
	<input type="hidden" name="survey[{{:#getIndex()}}].item_id" value="{{:ID}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].survey_id" value="{{:SURVEY_ID}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].item_type" value="{{:ITEM_TYPE}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].order_num" value="{{:ORDER_NUM}}">
	<div class="item-header">{{:TITLE}}</div>
		<div class="item-body">
		{{if ~trim(EXAM1) != ""}}
			<label><input type="radio" name="survey[{{:#getIndex()}}].exam" value="1">{{:EXAM1}}</label>
		{{/if}}
		{{if ~trim(EXAM2) != ""}}
			<label><input type="radio" name="survey[{{:#getIndex()}}].exam" value="2">{{:EXAM2}}</label>
		{{/if}}
		{{if ~trim(EXAM3) != ""}}
			<label><input type="radio" name="survey[{{:#getIndex()}}].exam" value="3">{{:EXAM3}}</label>
		{{/if}}
		{{if ~trim(EXAM4) != ""}}
			<label><input type="radio" name="survey[{{:#getIndex()}}].exam" value="4">{{:EXAM4}}</label>
		{{/if}}
		{{if ~trim(EXAM5) != ""}}
			<label><input type="radio" name="survey[{{:#getIndex()}}].exam" value="5">{{:EXAM5}}</label>
		{{/if}}
		{{if ~trim(EXAM6) != ""}}
			<label><input type="radio" name="survey[{{:#getIndex()}}].exam" value="6">{{:EXAM6}}</label>
		{{/if}}
		{{if ~trim(EXAM7) != ""}}
			<label><input type="radio" name="survey[{{:#getIndex()}}].exam" value="7">{{:EXAM7}}</label>
		{{/if}}
	</div>
</li>
</script>

<!-- //주관식 설문 유형 -->
<script id="surveyTypeTmpl2" type="text/x-jsrender">
<li class="typeSbjW">
	<input type="hidden" name="survey[{{:#getIndex()}}].item_id" value="{{:ID}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].survey_id" value="{{:SURVEY_ID}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].item_type" value="{{:ITEM_TYPE}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].order_num" value="{{:ORDER_NUM}}">
	<div class="item-header">{{:TITLE}}</div>
	<div class="item-body">
		<textarea name="survey[{{:#getIndex()}}].answer"></textarea>
	</div>
</li>
</script>

<!-- //주관+객관식 설문 유형 -->
<script id="surveyTypeTmpl3" type="text/x-jsrender">
<li class="typeObjL">
	<input type="hidden" name="survey[{{:#getIndex()}}].item_id" value="{{:ID}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].survey_id" value="{{:SURVEY_ID}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].item_type" value="{{:ITEM_TYPE}}">
	<input type="hidden" name="survey[{{:#getIndex()}}].order_num" value="{{:ORDER_NUM}}">
	<div class="item-header">{{:TITLE}}</div>
		<div class="item-body">
		{{if ~trim(EXAM1) != ""}}
			<label>
				<input type="radio" name="survey[{{:#getIndex()}}].exam" value="1">{{:EXAM1}}
				{{if EXAM1_YN == 'Y'}} <input type="text" name="survey[{{:#getIndex()}}].exam1"> {{/if}}
			</label>
		{{/if}}
		{{if ~trim(EXAM2) != ""}}
			<label>
				<input type="radio" name="survey[{{:#getIndex()}}].exam" value="2">{{:EXAM2}}
				{{if EXAM2_YN == 'Y'}} <input type="text" name="survey[{{:#getIndex()}}].exam2"> {{/if}}
			</label>
		{{/if}}
		{{if ~trim(EXAM3) != ""}}
			<label>
				<input type="radio" name="survey[{{:#getIndex()}}].exam" value="3">{{:EXAM3}}
				{{if EXAM3_YN == 'Y'}} <input type="text" name="survey[{{:#getIndex()}}].exam3"> {{/if}}
			</label>
		{{/if}}
		{{if ~trim(EXAM4) != ""}}
			<label>
				<input type="radio" name="survey[{{:#getIndex()}}].exam" value="4">{{:EXAM4}}
				{{if EXAM4_YN == 'Y'}} <input type="text" name="survey[{{:#getIndex()}}].exam4"> {{/if}}
			</label>
		{{/if}}
		{{if ~trim(EXAM5) != ""}}
			<label>
				<input type="radio" name="survey[{{:#getIndex()}}].exam" value="5">{{:EXAM5}}
				{{if EXAM5_YN == 'Y'}} <input type="text" name="survey[{{:#getIndex()}}].exam5"> {{/if}}
			</label>
		{{/if}}
		{{if ~trim(EXAM6) != ""}}
			<label>
				<input type="radio" name="survey[{{:#getIndex()}}].exam" value="6">{{:EXAM6}}
				{{if EXAM6_YN == 'Y'}} <input type="text" name="survey[{{:#getIndex()}}].exam6"> {{/if}}
			</label>
		{{/if}}
		{{if ~trim(EXAM7) != ""}}
			<label>
				<input type="radio" name="survey[{{:#getIndex()}}].exam7_yn" value="Y">{{:EXAM7}}
				{{if EXAM7_YN == 'Y'}} <input type="text" name="survey[{{:#getIndex()}}].exam7"> {{/if}}
			</label>
		{{/if}}
	</div>
</li>
</script>

<t:insertDefinition name="mypageleftmenu"/>
<!-- 1.3. 본문 -->
	<div class="body">
			<!-- player submit form -->
			<form id="chapterForm" name="chapterForm">
				<input type="hidden" name="id" id="id" value="${classParam.id }">
				<input type="hidden" name="cardinal" id="cardinal" value="${classParam.cardinal }">
				<input type="hidden" name="course" id="course" value="${classParam.course }">
				<input type="hidden" name="chapter" id="chapter" value="">
				<input type="hidden" name="idx" id="idx" value="">
				<input type="hidden" name="op" id="op" value="">
			</form>
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
							<li><a  class="nth-1st on" href="lesson?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">강의 보기</a></li>
							<li><a href="report?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 과제</a></li>
							<li><a href="exam?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 시험</a></li>
							<li><a href="notice?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">공지 사항</a></li>
							<li><a href="dataroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">자료실</a></li>
							<li><a href="qna?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">질의 답변</a></li>
						</ul>
					<div class="tab-body">
				<!-- 탭별 로드되는 부분 Start -->
							<div class="section">
								1주에 7차시만 수강 가능합니다.<br>
								해당 일자의 수강하지 못한 차시는 전체 수강 기간 내에 수강하시면 출석이 인정됩니다.<br>
								출석은 강의를 시작하고 일정 시간이 지나야 인정되어 수강이 확인됩니다..
							</div>
							<table id="list-lesson" class="list">
								<thead>
									<tr>
										<th scope="col" class="item-no">차시</th>
										<th scope="col" class="item-title">차시명</th>
										<th scope="col" class="item-time">학습 시간</th>
										<th scope="col" class="item-teacher">강사</th>
										<th scope="col" class="item-attend">출석</th>
										<th scope="col" class="item-function">강의 보기</th>
										<th scope="col" class="item-state">비고</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="openNum" value="${Math.ceil(classInfo.ELAPSE_DAY/chapter_open)*chapter_open  }" />
									<c:forEach var="item" items="${chapterList }" varStatus="status">
											<c:set var="prevProgYn" value="N" />
											<c:if test="${status.index == 0 || 'Y' eq chapterList[status.index-1].PROG_YN }">
												<c:set var="prevProgYn" value="Y" />
											</c:if>

										 <tr class="<c:if test="${status.count == 1 }">nth-1st</c:if> <c:if test="${classInfo.ELAPSE_DAY == (status.count) }">on</c:if> "><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
												<td class="item-no">${status.count }</td>
												<td class="item-title">${item.CHAPTER_NAME }</td>
												<td class="item-time">${item.STUDY }분</td>
												<td class="item-teacher">${item.TEACHER }</td>
												<td class="item-attend">
													<c:if test="${'Y' eq item.PROG_YN}">
														<strong class="iconInvs btnOk"><span class="sr-only">O</span></strong>
													</c:if>
													<c:if test="${'N' eq item.PROG_YN }">
														<strong class="iconInvs btnTimes"><span class="sr-only">X</span></strong>
													</c:if>
												</td>

												<c:choose>
													<c:when test="${openNum < (status.count) }">
														<!-- 수강진행예정일 초과 : 수강없음, 미리 보기-->
														<%-- <c:choose>
															<c:when test="${openNum  >=  (status.count) }">
																<!-- 미리 보기 -->
																<td class="item-function">
																	<a class="btn line icon btnWatch" href="#" onclick="goPlayer('${item.CHAPTER_ID}', '${status.count }', '${item.WIDTH}', '${item.HEIGHT}', 'preview')">강의 보기</a>
																</td>
																<td class="item-state">미리 보기</td>
															</c:when>
															<c:otherwise>
																<!-- 수강없음 -->
																<td class="item-function">
																	<a class="btn line icon btnWatch" href="#">강의 보기</a>
																</td>
																<td class="item-state">&nbsp;</td>
															</c:otherwise>
														</c:choose> --%>
														<!-- 미리 보기 없음. -->
														<td class="item-function">
															<a class="btn line blit btnWatch" href="#">강의 보기</a>
														</td>
														<td class="item-state">&nbsp;</td>
													</c:when>
													<c:otherwise>
														<!-- 수강진행예정일 이하 : 수강완료, 수강요망, 오늘 학습-->
														<c:choose>
															<c:when test="${classInfo.ELAPSE_DAY == (status.count) }">
																<!-- 오늘 학습 -->
																<td class="item-function">
																	<c:if test="${'Y' eq prevProgYn }">
																		<a class="btn line blit btnWatch" href="#" onclick="goPlayer('${item.CHAPTER_ID}', '${status.count }', '${item.WIDTH}', '${item.HEIGHT}', 'today')">강의 보기</a>
																	</c:if>
																	<c:if test="${'N' eq prevProgYn }">
																		<a class="btn line blit btnWatch" href="#" onclick="alert('이전 차시를 진행하셔야 학습이 가능합니다.');">강의 보기</a>
																	</c:if>
																</td>
																<td class="item-state"><em class="txtIcon primary">오늘 학습</em></td>
															</c:when>
															<c:otherwise>
																<!-- 수강완료, 수강요망 -->
																<td class="item-function">
																	<c:if test="${'Y' eq prevProgYn }">
																		<a class="btn line blit btnWatch" href="#" onclick="goPlayer('${item.CHAPTER_ID}', '${status.count }', '${item.WIDTH}', '${item.HEIGHT}', 'review')">강의 보기</a>
																	</c:if>
																	<c:if test="${'N' eq prevProgYn }">
																		<a class="btn line blit btnWatch" href="#" onclick="alert('이전 차시를 진행하셔야 학습이 가능합니다.');">강의 보기</a>
																	</c:if>
																</td>
																<td class="item-state">
																	<c:choose>
																		<c:when test="${'Y' eq item.PROG_YN }">수강 완료</c:when>
																		<c:when test="${'N' eq item.PROG_YN }">수강 요망</c:when>
																	</c:choose>
																</td>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</tr>
									</c:forEach>
									<tr>
										<td class="item-no">-</td>
										<td class="item-title">만족도 및 강의 평가 설문조사</td>
										<td class="item-time"></td>
										<td class="item-teacher"></td>
										<td class="item-attend"></td>
										<td class="item-function">
											<c:if test="${not empty poll_satisfaction }"><a class="btn line blit btnCheck" href="#" onclick="showPollPopup('2')">만족도</a></c:if>
											<c:if test="${not empty poll_evaluation }"><a class="btn line blit btnCheck" href="#" onclick="showPollPopup('1')">강의 평가</a></c:if>
											<c:if test="${empty poll_satisfaction or empty poll_evaluation}">-</c:if>
										</td>
										<td class="item-state">&nbsp;</td>
									</tr>
								</tbody>
							</table>
							<div class="list-bottom">
								<a class="btn primary blit btnWrite float_right" href="#" onclick="showReviewPopup()">연수 후기 쓰기</a>
							</div>
				<!--// 탭별 로드되는 부분 END -->
					</div><!--//.tab-body-->
				</div><!--.tab-group-->
			</div><!--//.sub-body-->
		</div>
<!-- 1.3. 본문 -->

<t:insertDefinition name="poll"/>
<t:insertDefinition name="reviewview"/>
