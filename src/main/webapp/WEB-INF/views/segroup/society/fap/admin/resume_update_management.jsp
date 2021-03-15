<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<body>
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>이력서 수정여부 관리(임시)</h2>
	</div>
	<br>
<form action="/fap/admin/resume_update_gb" method="post">
	<input type="radio" name="fap_job_resume_update_gb" value="D1700"> 불가능 <br>
	<input type="radio" name="fap_job_resume_update_gb" value="D1701"> 가능 <br>
	<input type="submit" value="변경">
</form>
</body>
</html>