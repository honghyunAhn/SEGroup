<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/resources/js/printThis.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#certificatepop .printThis').click(function() {
		$('#certificatepop .print-wrap').printThis();
	});

	$(".btnCertificateClose").click(function(event){
		popupClose("certificatepop")
	});

	$("#certificatepop #score_yn").change(function(event){
		if($(this).val() == "Y") {
			$("#certificatepop #score_area").show();
		} else {
			$("#certificatepop #score_area").hide();
		}
	});
});

function showCertificationPopup(id) {
	if(!id) 	return;

	var params = {};
	params.learnAppId = id;

	$.ajax({
		url:'selectCertificateAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if(data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var certificate = data.certificate;
			$("#certificatepop #des_num").text(certificate.DES_NUM);
			$("#certificatepop #issue_num").text(certificate.ISSUE_NUM);
			$("#certificatepop #neis_num").text(certificate.NEIS_NUM);
			$("#certificatepop #learn_type").text(certificate.LEARN_TYPE_NAME);
			$("#certificatepop #credit").text(certificate.CREDIT);
			$("#certificatepop #learn_time").text(certificate.COMPLETE_TIME);
			$("#certificatepop #course_name").text(certificate.COURSE_NAME);
			$("#certificatepop #learn_start_date").text(certificate.LEARN_START_DATE);
			$("#certificatepop #learn_end_date").text(certificate.LEARN_END_DATE);
			$("#certificatepop #total_score").text(certificate.TOTAL_SCORE);
			$("#certificatepop #issue_date").text(certificate.ISSUE_DATE);
			popupOpen("certificatepop");
		},
		error:function(e){
			alert("인증서 조회시 문제가 발생했습니다.");
		}
	});
}
</script>

<div class="cl-popup-overlay" id="certificatepop">
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
				<p class="section alignR screen-only">
					<select id="score_yn">
						<option selected value="Y">연수 성적 포함</option>
						<option value="N">연수 성적 미포함</option>
					</select>
				</p>
				<div id="certificate" class="print-wrap section certificate">
					<h3 class="print-title">
						<img src="/resources/images/logo.png" alt="창비교육 원격교육연수원"><br>
						연수 이수증
					</h3>
					<ul class="info-list">
						<li><em class="label">연수 지명 번호:</em> <span id="des_num"></span></li>
						<li><em class="label">연수 이수 번호:</em> <span id="issue_num"></span></li>
						<li class="halfW"><em class="label">성　 　명:</em> <sec:authorize access="isAuthenticated()"><sec:authentication property="principal.name"/></sec:authorize></li>
						<li class="halfW"><em class="label">NEIS 개인 번호:</em> <span id="neis_num"></span></li>
						<li class="halfW clearL"><em class="label">연수 구분:</em> <span id="learn_type"></span></li>
						<li class="halfW"><em class="label">학　 　점:</em> <span id="credit"></span>학점(<span id="learn_time"></span>시간)</li>
						<li class="clearL" style="min-height:48px;"><em class="label">연수 과정명:</em> <span id="course_name"></span></li>
						<li><em class="label">연수 기간:</em> <span id="learn_start_date"></span> ~ <span id="learn_end_date"></span></li>
						<li id="score_area"><em class="label">연수 성적:</em> <span id="total_score"></span>점</li>
					</ul>
					<div class="section receipt-issue">
						<p>위와 같이 교육 연수를 이수하였음을 증명합니다.</p>
						<p class="date"><span id="issue_date"></span></p>
						<p class="issuer"><span> </span><br><em>(주)창비교육</em><img src="/resources/images/stamp.png" alt="직인"></p>
					</div>
					<img class="between-stamp" src="/resources/images/stamp.png" alt="직인">
				</div><!--//.print-wrap-->
				<div class="screen-only alignC">
						<button class="btn primary w5em printThis">인쇄</button>
						<button class="btn w5em btn-closePopup btnCertificateClose">닫기</button>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>