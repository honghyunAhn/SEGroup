<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
<c:if test="${empty error }">
var iframe = window.parent;
var p = window.opener;
if(iframe != null) {
	p = iframe.opener;
}
if (p.onIdentitySuccess) {
	p.onIdentitySuccess('phone', {
		name : '${result.name}',
		birth : '${result.birth}',
		sex : '${result.sex}',
		phone : '',
		vnumber : '${result.vnumber}',
		ci : '',
		di : '${result.di}'
	});
} else {
	console.log('not found onIdentitySuccess');
	alert('본인 인증에 성공하였습니다.');
}
</c:if>
<c:if test="${not empty error }">
	alert('오류가발생하였습니다.\n'+'<c:out value="${error }"/>');
</c:if>
</script>
</head>
<body>
<div style="text-align: center"><c:out value="${error }"/></div>
</body>
</html>