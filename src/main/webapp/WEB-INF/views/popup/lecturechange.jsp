<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(document).ready(function(){
	$(".btnLecChgSubmit").click(function(event){
		if(!confirm("수강 변경 신청하시겠습니까?")) return;

		if(!$("#changeForm #newCourseId").val()) {
			alert("변경 신청 과정을 선택하여 주십시오.");
			return;
		}

		var params = $("#changeForm").serialize();
		$.ajax({
			url:'saveChangeLectureAjax',
			type:'POST',
			data:params,
			dataType:'json',
			success:function(data){
				if(data.result == "SUCCESS") {
					alert("신청되었습니다.");
				} else {
					alert("신청시 문제가 발생했습니다.");
				}

				location.reload();
			},
			error:function(e){
				alert("신청시 문제가 발생했습니다.");
				location.reload();
			}
		});
	});

	$(".btnLecChgClose").click(function(event){
		popupClose("lectureChangePopup");
	});

});
</script>

<div class="cl-popup-overlay" id="lectureChangePopup">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box" style="width:700px; height:436px; margin-left:-350px; margin-top:-213px">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">수강 변경 신청</h3>
			</div>
			<div class="popup-body">
				<form id="changeForm">
					<input type="hidden" name="learnAppId" id="learnAppId" />
					<input type="hidden" name="cardinalId" id="cardinalId" />
					<input type="hidden" name="oldCourseId" id="oldCourseId" />

					<ul class="notice-list section">
						<li>해당 기수에서 운영하는 과정으로만 변경할 수 있습니다.</li>
						<li>동일 학점으로만 변경할 수 있습니다.</li>
						<li>연수 지명 번호가 초기화 됩니다. 새로 등록 하셔야 이수 처리가 됩니다.</li>
						<li>구매하신 교재는 반송 하셔야 합니다. 반송에 따른 배송비는 회원님께서 부담 하셔야 합니다.</li>
					</ul>
					<dl>
						<dt>현재 신청 과정</dt>
						<dd><strong id="oldCourse">남다른 교구활용의 정석</strong></dd>
						<dt>변경 신청 과정</dt>
						<dd>
							<select class="nth-1st width95" id="newCourseId" name="newCourseId">
							</select>
						</dd>
					</dl>
					<div class="list-bottom alignC">
						<a href="#" class="btn primary btnLecChgSubmit">신청</a>
						<a href="#" class="btn btn btnLecChgClose">취소</a>
					</div>
				</form>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>