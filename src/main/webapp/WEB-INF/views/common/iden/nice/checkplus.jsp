<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript">
	/*
	window.name ="Parent_window";

	function fnPopup(){
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();

	}
	*/
	</script>
</head>
<body>
	<div style="text-align: center"><c:out value="${error }"/></div>
	<!-- 본인 인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="form_chk" method="post" action="https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb">
		<input type="hidden" name="m" value="checkplusSerivce">				<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="${EncodeData }">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

		<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
			 해당 파라미터는 추가할 수 없습니다. -->
		<input type="hidden" name="param_r1" value="${iden_gbn }">	<%-- 본인 인증수단 구분 --%>
		<input type="hidden" name="param_r2" value="${iden_callback_success }">
		<input type="hidden" name="param_r3">
	</form>

	<c:if test="${empty error }">
	<script type="text/javascript">
	document.form_chk.submit();
	</script>
	</c:if>
</body>
</html>