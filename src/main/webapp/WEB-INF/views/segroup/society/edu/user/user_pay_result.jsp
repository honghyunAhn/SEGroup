<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">




</script>
</head>
<body>
	<%@include file="../menu.jsp"%>
	
	<!-- section -->
	<section class="join_section" style="margin-left:20%;">
		<article>
		<br><br>
			<h2>결제를 완료하였습니다.</h2><br>
			<h2>돌아가기</h2><br>
		    <h2></h2><br>
      <%--  <h5>거래 번호 : ${tid}</h5><br>
       <h5>결제방법(지불수단) : ${payMethod}</h5><br>
       <h5>결제완료금액 : ${TotPrice}</h5><br>
       <h5>주문 번호 : ${MOID}</h5><br>
       <h5>승인날짜 : ${applDate}</h5><br>
       <h5>승인시간 : ${applTime}</h5><br>
       <h5>입금 계좌번호 : ${VACT_Num}</h5><br>
       <h5>입금 은행코드 : ${VACT_BankCode}</h5><br>
       <h5>결과코드 : ${resultCode}</h5><br> --%>
    
		</article>
	</section>  <!--  join_section -->
	
	<!-- footer -->
	<%@include file="../footer.jsp"%>
</body>
</html>