<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/resources/js/printThis.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#registerpop .printThis').click(function() {
		$('#registerpop .print-wrap').printThis();
	});

	$(".btnRegisterClose").click(function(event){
		popupClose("registerpop");
	});
});

function showRegisterPopup(id) {
	if(!id) return;

	var params = {};
	params.learnAppId = id;

	$.ajax({
		url:'selectRegisterAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if(data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var register = data.register;
			$("#registerpop #birth_day").text(register.BIRTH_DAY);
			$("#registerpop #learn_type").text(register.COURSE_CODE_NAME);
			$("#registerpop #course_name").text(register.COURSE_NAME);
			$("#registerpop #credit").text(register.CREDIT);
			$("#registerpop #learn_time").text(register.COMPLETE_TIME);
			$("#registerpop #learn_start_date").text(register.LEARN_START_DATE);
			$("#registerpop #learn_end_date").text(register.LEARN_END_DATE);
			$("#registerpop #issue_date").text(register.CURR_DATE);

			popupOpen("registerpop");
		},
		error:function(e){
			alert("수강확인증 조회시 문제가 발생했습니다.");
		}
	});
}
</script>
<div class="cl-popup-overlay" id="registerpop">
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
				<div id="register-certificate" class="print-wrap section certificate">
					<h3 class="print-title">
						<img src="/resources/images/logo.png" alt="창비교육 원격교육연수원"><br>
						수강 확인증
					</h3>
					<ul class="info-list">
						<li><em class="label">성명</em><span id="user_name"><sec:authorize access="isAuthenticated()"><sec:authentication property="principal.name"/></sec:authorize></span></li>
						<li><em class="label">생년월일</em><span id="birth_day"></span></li>
						<li><em class="label">연수 영역</em><span id="learn_type"></span></li>
						<li><em class="label">연수 과정명</em><span id="course_name" style="display:inline-flex;line-height:2rem;"></span></li>
						<li><em class="label">학점</em><span id="credit"></span>학점(<span id="learn_time"></span>시간)</li>
						<li><em class="label">연수 기간</em><span id="learn_start_date"></span> ~ <span id="learn_end_date"></span></li>
					</ul>
					<div class="section receipt-issue">
						<p>위와 같이 교육 연수를 수강하였음을 증명합니다.</p>
						<p class="date"><span id="issue_date"></span></p>
						<p class="issuer"><span></span><br><em>(주)창비교육</em><img src="/resources/images/stamp.png" alt="직인"></p>
					</div>
					<img class="between-stamp" src="/resources/images/stamp.png" alt="직인">
				</div><!--//.print-wrap-->
				<div class="screen-only alignC">
						<button class="btn primary w5em printThis">인쇄</button>
						<button class="btn w5em btn-closePopup btnRegisterClose">닫기</button>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>