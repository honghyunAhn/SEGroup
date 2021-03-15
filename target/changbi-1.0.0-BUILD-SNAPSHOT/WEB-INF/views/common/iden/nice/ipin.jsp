<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>NICE평가정보 가상주민번호 서비스</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<script language='javascript'>
	window.name ="Parent_window";

	function fnPopup(){
		window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		document.form_ipin.target = "popupIPIN2";
		document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
		document.form_ipin.submit();
	}
	</script>
</head>

<body>

	<div style="text-align: center"><c:out value="${error }"/></div>
	<!-- 가상주민번호 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="form_ipin" method="post" action="https://cert.vno.co.kr/ipin.cb">
		<input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="enc_data" value="${EncodeData }">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->

		<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
			 해당 파라미터는 추가할 수 없습니다. -->
		<input type="hidden" name="param_r1" value="${iden_gbn }">	<%-- 본인 인증수단 구분 --%>
		<input type="hidden" name="param_r2" value="">
		<input type="hidden" name="param_r3" value="">
	</form>

	<c:if test="${empty error }">
	<script type="text/javascript">
	document.form_ipin.submit();
	</script>
	</c:if>

	<!-- 가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
		 따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="vnoform" method="post">
		<input type="hidden" name="enc_data">								<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->

		<!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
			 해당 파라미터는 추가할 수 없습니다. -->
		<input type="hidden" name="param_r1" value="">
		<input type="hidden" name="param_r2" value="">
		<input type="hidden" name="param_r3" value="">
	</form>

</body>
</html>