<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
function localeCodeSave() {
	if (!$("#localeCodeForm #des1").val() || !$("#localeCodeForm #des2").val() || !$("#localeCodeForm #des3").val() || !$("#localeCodeForm #des4").val()) {
		alert("연수지명번호를 입력해 주십시오.");
		return;
	}

	// 중복체크
	var des_num = $("#localeCodeForm #des1").val() + '-' + $("#localeCodeForm #des2").val() + '-' + $("#localeCodeForm #des3").val() + '-' + $("#localeCodeForm #des4").val();
	if(!checkDuplDesNum(des_num)) {
		alert('동일한 연수 지명 번호가 존재합니다.\n관리자에게 직접 문의 부탁드립니다.');
		return;
	}

	var params = $("#localeCodeForm").serialize();
	$.ajax({
		url:"editLocaleCodeAjax",
		type:"POST",
		data:params,
		dataType:'json',
		success:function(data){
				if(data.result == "SUCCESS") {
					alert("수정되었습니다.");
				} else {
					alert("수정 중 문제가 발생하였습니다. 관리자에게 문의하여 주십시오.");
				}

				popupClose("popLocaleCode");
				location.reload();
		}
	});
}


// 연수지명번호 중복체크
function checkDuplDesNum(des_num) {
	var valid = false;
	var learn_id = $('#localeCodeForm input[name="learn"]').val();
	$.ajax({
		type: "post",
		url: "<c:url value='/learn/apply/ajaxUserCheckDuplDesNum' />",
		data: {"des_num": des_num, "learn_id": learn_id},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = (result.DUPL_YN != 'Y');
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
}

</script>
<div class="cl-popup-overlay" id="popLocaleCode">
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
				<h3 class="popup-title">연수 지명 번호 수정/등록</h3>
			</div>
			<div class="popup-body">
				<form class="section" id="localeCodeForm" name="localeCodeForm">
					<input type="hidden" name="learn" id="learn" value="${classInfo.ID }">
					<dl>
						<dt>기수</dt>
						<dd>${classInfo.CARDINAL_NAME }</dd>
						<dt>연수 과정명</dt>
						<dd><strong class="primary">${classInfo.NAME }</strong></dd>
						<dt>연수 기간</dt>
						<dd>${classInfo.LEARN_START_DATE }. ~ ${classInfo.LEARN_END_DATE }.</dd>
						<dt>연수 구분</dt>
						<dd>${classInfo.LEARN_TYPE_NAME }/ ${classInfo.COMPLETE_TIME }시간 / ${classInfo.CREDIT }학점</dd>
						<dt>연수 지명 번호</dt>
						<dd>
							<input type="text" maxlength="2" class="w4em" name="des1" id="des1" value="${fn:split(classInfo.DES_NUM,'-')[0] }">
							-
							<input type="text" maxlength="6" class="w8em" name="des2" id="des2" value="${fn:split(classInfo.DES_NUM,'-')[1] }">
							-
							<input type="text" maxlength="2" class="w3em" name="des3" id="des3" value="${fn:split(classInfo.DES_NUM,'-')[2] }">
							-
							<input type="text" maxlength="4" class="w5em" name="des4" id="des4" value="${fn:split(classInfo.DES_NUM,'-')[3] }">
						</dd>
					</dl>
					<div class="list-bottom alignC">
						<a href="javascript:localeCodeSave()" class="btn primary">저장</a>
						<a href="javascript:popupClose('popLocaleCode')" class="btn">취소</a>
					</div>
				</form>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->