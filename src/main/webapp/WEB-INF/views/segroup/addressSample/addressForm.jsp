<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script type="text/javascript">
function findAddr(){
	window.open("/group/popupTest","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
}
</script>
</head>
<body>
<form action="" id="joinForm">
	우편번호 : <input type="text" id="zipcode" readonly="readonly"/><br />
	주소 : <input type="text" id="address" readonly="readonly"/><br />
	상세주소 : <input type="text" id="addressDetail" readonly="readonly"/><br />
	<input type="button" id="btn" onclick="findAddr()" value="주소검색">
</form>
</body>
</html>