<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
form label.error {color:red}
</style>
<script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#layerPasswordChange .cl-popup-closer').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});

	// 다음에변경
	$('#btnChangeNext').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});

	// 변경
	$('#btnChangeNow').click(function() {
		if (!$('#pwChangeForm').valid()) {
			return;
		}

		$.ajax({
			type: "POST",
			url: "<c:url value='/member/ajaxChangePw' />",
			data: $('#pwChangeForm').serialize(),
			success: function(result) {
				if (result.CODE == 'SUCCESS') {
					alert('정상적으로 변경되었습니다.');
					$('#layerPasswordChange').remove();
				} else {
					alert(result.MESSAGE);
				}
			},
			error: function(e) {
				alert('오류가 발생하였습니다.');
			}
		});
	});

	// 입력값 체크 설정
	$.validator.addMethod("checkPasswd",function(value, element) {
		return this.optional(element) || isValidPassword(value);
	}, "유효하지 않은 입력입니다.");
	$("#pwChangeForm").validate({
		rules: {	// 입력체크 룰
			cpw: {"required":true},
			pw: {"required":true, "checkPasswd":true},
			pw_confirm: {"required":true, "equalTo":"#pwChangeForm input[name='pw']"}
		}
	});
});
</script>
<!--// 비밀번호변경 팝업 -->
<div class="cl-popup-overlay" id="layerPasswordChange">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:600px; margin-left:-300px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">비밀번호 변경</h3>
			</div>
			<div class="popup-body">
				<form id="pwChangeForm">
				<dl>
					<dt>현재 비밀번호</dt>
					<dd><input type="password" placeholder="현재 비밀번호" name="cpw"></dd>
				</dl>
				<dl>
					<dt>새 비밀번호</dt>
					<dd><input type="password" placeholder="새 비밀번호" name="pw"><div>※ 영문, 숫자, 특수 기호(!, @, # 등)을 모두 사용하여 최소 8자 이상</div></dd>
				</dl>
				<dl>
					<dt>새 비밀번호 확인</dt>
					<dd><input type="password" placeholder="새 비밀번호확인" name="pw_confirm"></dd>
				</dl>
				<div class="list-bottom alignC">
					<a class="btn standby" href="#" id="btnChangeNext">다음에변경</a>
					<a class="btn primary" href="#" id="btnChangeNow">변경</a>
				</div>
				</form>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 비밀번호변경 END -->
