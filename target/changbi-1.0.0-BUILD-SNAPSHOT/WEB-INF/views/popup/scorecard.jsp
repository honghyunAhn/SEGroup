<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/resources/js/printThis.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#scorecardpop .printThis').click(function() {
		$('#scorecardpop .print-wrap').printThis();
	});

	$(".btnScorecardClose").click(function(event){
		popupClose("scorecardpop");
	});
});

function showScorecardPopup(id) {
	if(!id) return;

	var params = {};
	params.learnAppId = id;

	$.ajax({
		url:'selectScorecardAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if(data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var score = data.score;

			$("#scorecardpop #learn_type").text(score.LEARN_TYPE_NAME);
			$("#scorecardpop #cardinal_name").text(score.CARDINAL_NAME);
			$("#scorecardpop #school_name").text(score.SCHOOL_NAME);
			$("#scorecardpop #course_name").text(score.COURSE_NAME);

			$("#scorecardpop #score_type1").text(score.SCORE_TYPE1);
			$("#scorecardpop #score_type2").text(score.SCORE_TYPE2);
			$("#scorecardpop #score_type3").text(score.SCORE_TYPE3);
			$("#scorecardpop #score_jindo").text(score.PART_SCORE);
			$("#scorecardpop #total_score").text(score.TOTAL_SCORE);

			$("#scorecardpop #issue_date").text(score.ISSUE_DATE);

			if (score.CREDIT != 4) {//4학점이 아닌 과정에 대해서 화면 UI변경
				$(".offline").hide();
				$("#score_table col").attr("width", "25%");
			}

			popupOpen("scorecardpop");
		},
		error:function(e){
			alert("성적 조회시 문제가 발생했습니다.");
		}
	});
}
</script>

<div class="cl-popup-overlay" id="scorecardpop">
	<div class="cl-popup-wrap">
		<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mid" style="width:740px; margin-left:-370px">
				</c:otherwise>
		</c:choose>
			<div class="popup-body">
				<!-- 출력 기능을 하는 팝업에서만 불러오는 스타일 시트-->
				<div id="scorecard" class="print-wrap section">
					<h3 class="print-title">
						성적표
					</h3>
					<ul class="info-list">
						<li class="halfW"><em class="label">연수 구분</em> <span id="learn_type"></span></li>
						<li class="halfW"><em class="label">성명</em><span id="user_name"><sec:authorize access="isAuthenticated()"><sec:authentication property="principal.name"/></sec:authorize></span></li>
						<li class="halfW clearL"><em class="label">연수 기수</em><span id="cardinal_name"></span></li>
						<li class="halfW"><em class="label">학교/기관명</em><span id="school_name"></span></li>
						<li class="clearL"><em class="label">연수 과정명</em><span id="course_name"></span></li>
					</ul>
					<table class="table" id="score_table">
						<colgroup>
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%" class="offline">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="nth-1st">온라인 과제</th>
								<th scope="col">온라인 평가</th>
								<th scope="col">학습 참여도</th>
								<th scope="col" class="offline">출석 고사</th>
								<th scope="col">최종 성적</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="nth-1st" id="score_type2">0</td>
								<td id="score_type3">0</td>
								<td id="score_jindo">0</td>
								<td id="score_type1" class="offline">0</td>
								<td id="total_score">0</td>
							</tr>
						</tbody>
					</table>
					<div class="section receipt-issue">
						<p class="date">발행일:<span id="issue_date"></span></p>
						<p class="issuer"><em>(주)창비교육</em><img src="/resources/images/stamp.png" alt="직인"></p>
					</div>
				</div><!--//.print-wrap-->
				<div class="screen-only alignC">
						<button class="btn primary w5em printThis">인쇄</button>
						<button class="btn w5em btn-closePopup btnScorecardClose">닫기</button>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
		<button class="cl-popup-closer">
			<span class="sr-only">닫기</span>
		</button>
	</div>