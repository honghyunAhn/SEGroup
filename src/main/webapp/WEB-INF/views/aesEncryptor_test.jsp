<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#btn_in").on("click", function(){
		var str_in = $('#str_in').val();
		$.ajax({
			type: "post",
			url: "aesEncryptor_encrypt",
			data: {
				str_in : str_in
			},
			success: function(str_en){
				$('#str_en').val(str_en);
			},
			error: function(e){
				console.log(e);
			}		
		});
	});
	
	$("#btn_de_in").on("click", function(){
		var str_de = $("#str_de").val();
		$.ajax({
			type: "post",
			url: "aesEncryptor_decrypt",
			data: {
				str_de: str_de
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
</head>
<body>

</body>
	<input type="text" id="str_in" name="str_in" placeholder="암호화할 String">
	<input type="button" id="btn_in" name="btn_in" value="암호화제출"> <br>
	<input type="text" id="str_en" name="str_en" placeholder="암호화 된 String"> <br>
	<hr>
	<input type="text" id="str_de" name="str_de" placeholder="복호화 test">
	<input type="button" id="btn_de_in" name="btn_de_in" value="복호화제출"> <br>
	<input type="text" id="result" name="result" placeholder="복호화결과"> <br>
</html>