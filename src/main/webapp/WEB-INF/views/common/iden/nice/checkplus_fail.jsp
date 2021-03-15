<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
var iframe = window.parent;
var p = window.opener;
if(iframe != null) {
	p = iframe.opener;
}
if (p && p.onIdentityFail) {
	p.onIdentityFail('phone', {'errorMessage':'${message}'});
} else {
	console.log('not found onIdentityFail');
	alert('본인 인증에 실패하였습니다.');
}
</script>
<body>
</body>
</html>