<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>password_encrypt_test</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#btn_in").on("click", function(){
		var password_in = $('#password_in').val();
		$.ajax({
			type: "post",
			url: "password_encrypt",
			data: {
				password_in: password_in
			},
			success: function(password_en){
				$('#password_en').val(password_en);
			},
			error: function(e){
				console.log(e);
			}		
		});
	});
	
	$("#btn_check").on("click", function(){
		var password_check = $('#password_check').val();
		var encodedPassword = $("#password_en").val();
		$.ajax({
			type: "post",
			url: "password_check",
			data: {
				password_check: password_check,
				encodedPassword: encodedPassword
			},
			success: function(result){
				$('#result').val(result);
			},
			error: function(e){
				console.log(e);
			}		
		});
	});
});
</script>

<body>
	<input type="text" id="password_in" name="password_in" placeholder="초기 비밀번호 설정">
	<input type="button" id="btn_in" name="btn_in" value="제출"> <br>
	<input type="text" id="password_en" name="password_en" placeholder="암호화 된 비밀번호" disabled="disabled" size="70"> <br>
	<input type="text" id="password_check" name="password_check" placeholder="비교할 비밀번호 입력">
	<input type="button" id="btn_check" name="btn_check" value="비교"> <br>
	<input type="text" id="result" name="result" placeholder="비교 결과" disabled="disabled"> <br>
</body>
</html>