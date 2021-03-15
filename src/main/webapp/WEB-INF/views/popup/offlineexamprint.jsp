<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/resources/js/printThis.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#popOfflineExamPrint .printThis').click(function() {
		$('#popOfflineExamPrint .print-wrap').printThis();
	});

	$(".btn-closePopup").click(function(){
		popupClose("popOfflineExamPrint");
	});
});

function showExamPrint() {
	var params = $("#popOfflineExamPrint #printForm").serialize();
	$.ajax({
		url:'selectExamPrintAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data) {
			if (data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var examInfo = data.examInfo;
			$("#popOfflineExamPrint #exam_date").text(examInfo.DESC_START_DATE);

			var reportInfo = data.reportInfo;
			$("#popOfflineExamPrint #exam_num").text(reportInfo.EXAM_NUM);
			$("#popOfflineExamPrint #spot_name").text(reportInfo.SPOT_NAME);
			//$("#popOfflineExamPrint #user_img").attr("src",reportInfo.USER_URL_PATH );

			var classInfo = data.classInfo;
			$("#popOfflineExamPrint #course_name").text(classInfo.NAME);
			$("#popOfflineExamPrint #exam_period").text(classInfo.EXAM_PERIOD);

			popupOpen('popOfflineExamPrint');
		},
		error:function(e) {
			alert("출석 고사 수험표 정보 조회시 문제가 발생했습니다.");
		}
	});
}
</script>

<div class="cl-popup-overlay" id="popOfflineExamPrint">
	<div class="cl-popup-wrap">
<!-- 팝업 페이지 로드 START -->
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width: 446px; margin-left:-223px">
			</c:otherwise>
		</c:choose>
			<!--div class="popup-header">
				<h3 class="popup-title">출석 고사수험표출력</h3>
			</div-->
			<div class="popup-body">
			<form id='printForm'>
					<input type="hidden" name="id" value="${classParam.id }">
					<input type="hidden" name="cardinal" value="${classParam.cardinal }">
					<input type="hidden" name="course" value="${classParam.course }">
			</form>
				<!-- 출력 기능을 하는 팝업에서만 불러오는 스타일 시트-->
				<div id="offlineTVS" class="print-wrap section"><!--TVS : test verification slips, 수험표 -->
					<h3 class="print-title">수험표</h3>
					<!-- <div class="tvs-photo">
						<img alt="사진" id="user_img">
					</div> -->
					<ul class="info-list section">
						<li><em class="label">성명: </em> <sec:authorize access="isAuthenticated()"><sec:authentication property="principal.name"/></sec:authorize></li>
						<li><em class="label">수험 번호: </em> <span id="exam_num"></span></li>
						<li><em class="label">연수 과정명: </em> <span id="course_name"></span></li>
						<li><em class="label">시험 시간: </em> <span id="exam_date"></span> <span id="exam_period"></span>교시<!--  / 10:00 ~ 10:50 --></li>
						<li><em class="label">시험장명:  </em> <span id="spot_name"></span></li>
					</ul>
					<div>
						<p>※ OMR마킹을 하기위한 컴퓨터사인펜과 신분증을 반드시 지참바랍니다.</p>
						<p>※ 시험시간 20분 전까지 시험장에 표시된 좌석을 확인하시고 착석하여 주시기 바랍니다.</p>
					</div>
				</div>
				<div class="screen-only alignC">
						<a href="#" class="btn primary w5em printThis">인쇄</a>
						<a href="#" class="btn w5em btn-closePopup">닫기</a>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
<!-- 팝업 페이지 로드 END -->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>