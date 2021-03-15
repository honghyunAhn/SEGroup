<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(document).ready(function(){

	$("#delayForm #selectMail li").click(function(event){
		$("#delayForm input[name='email2']").val($(this).attr("data"));
		$(this).parent().toggleClass('off');
	});

	$(".btnLecDelSubmit").click(function(event){
		var phone = concatArray([$('#delayForm select[name="phone1"]').val(),$('#delayForm input[name="phone2"]').val(),$('#delayForm input[name="phone3"]').val()],'-');
		var tel = concatArray([$('#delayForm select[name="tel1"]').val(),$('#delayForm input[name="tel2"]').val(),$('#delayForm input[name="tel3"]').val()],'-');
		var email = $('#delayForm input[name="email1"]').val() + (isEmpty($('#delayForm input[name="email1"]').val()) || isEmpty($('#delayForm input[name="email2"]').val())?"":"@") + $('#delayForm input[name="email2"]').val();
		$("#delayForm input[name='tel']").val(tel);
		$("#delayForm input[name='phone']").val(phone);
		$("#delayForm input[name='email']").val(email);

		if (!validateDelayForm()) {
			return;
		}

		var params = $("#delayForm").serialize();
		$.ajax({
			url:'saveDelayLectureAjax',
			type:'POST',
			data:params,
			dataType:'json',
			success:function(data) {
				if(data.result == "SUCCESS") {
					alert("신청되었습니다.");
				} else {
					alert("신청시 문제가 발생했습니다.");
				}

				location.reload();
			},
			error:function(e) {
				alert("수강 연기 신청시 문제가 발생했습니다.");
				location.reload();
			}
		});
	});

	$(".btnLecDelClose").click(function(event){
		popupClose("lectureDelayPopup");
	});
});

//입력값 체크
function validateDelayForm() {
	if (!$("#delayForm input[name='tel']").val()) {
		alert("일반전화를 입력해 주십시오.");
		return false;
	}

	if (!$("#delayForm input[name='phone']").val()) {
		alert("휴대 전화를 입력해 주십시오.");
		return false;
	}

	if (!$("#delayForm input[name='email']").val()) {
		alert("전자우편을 입력해 주십시오.");
		return false;
	}

	return true;
}
</script>

<div class="cl-popup-overlay" id="lectureDelayPopup">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:700px; margin-left:-350px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">수강 연기 신청</h3>
			</div>
			<div class="popup-body">
				<form id="delayForm">
					<input type="hidden" name="tel" required />
					<input type="hidden" name="phone" required/>
					<input type="hidden" name="email" required/>
					<input type="hidden" name="learnAppId" required/>
					<input type="hidden" name="oldCardinalId" required/>

					<dl>
						<dt>신청 구분</dt>
						<dd><strong class="primary">수강 연기</strong></dd>
						<dt>연수 과정명</dt>
						<dd><strong id="courseName"></strong></dd>
						<dt>기수</dt>
						<dd>
							<select class="nth-1st width95" id="newCardinalId" name="newCardinalId"></select>
						</dd>
						<dt>성명</dt>
						<dd class="width30" id="userName"></dd>
						<dt class="border">아이디</dt>
						<dd class="width30" id="userId"></dd>
						<dt>휴대 전화</dt>
						<dd>
							<select class="nth-1st" name="phone1">
								<c:forEach var="item" items="${phone1List }">
									<option value="${item.NAME}">${item.NAME}</option>
								</c:forEach>
							</select>
							-
							<input type="text" maxlength="4" class="w5em" name="phone2">
							-
							<input type="text" maxlength="4" class="w5em" name="phone3">
						</dd>
						<dt>자택 전화</dt>
						<dd>
							<select class="nth-1st" name="tel1">
								<c:forEach var="item" items="${tel1List }">
									<option value="${item.NAME}">${item.NAME}</option>
								</c:forEach>
							</select>
							-
							<input type="text" maxlength="4" class="w5em" name="tel2">
							-
							<input type="text" maxlength="4" class="w5em" name="tel3">
						</dd>
						<dt>전자 우편</dt>
						<dd>
							<input class="nth-1st" type="text" name="email1">@
							<input type="text" name="email2">

							<div class="body-select width25">
								<a class="btn-toggle" href="#selectMail"><span>선택</span></a>
								<ul class="select-option off" id="selectMail">
									<li>직접 입력</li>
									<c:forEach var="item" items="${emailList }">
										<li data="${item.NAME}">${item.NAME}</li>
									</c:forEach>
								</ul>
							</div>
						</dd>
						<dt>사유</dt>
						<dd><textarea name="memo"></textarea></dd>
					</dl>
					<div class="list-bottom alignC">
						<a href="#" class="btn primary btnLecDelSubmit">신청</a>
						<a href="#" class="btn btnLecDelClose">취소</a>
					</div>
				</form>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>