<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/ckeditor/ckeditor.js" />"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace('fap_open_pt_ct', {
		filebrowserUploadUrl : '/board/imageUpload',
		enterMode: CKEDITOR.ENTER_BR,
		shiftEnterMode:  CKEDITOR.ENTER_P,
		fullPage: true,
		allowedContent:  true
	});		
})

function formCheck(){
	//타이틀
	var title = $("#fap_open_pt_title").val();
	if(title == '' || title.length == 0){
		alert("제목을 입력해 주세요");
		return false;
	}
	//구분
	if($("input:radio[name='fap_open_pt_gb']").is(":checked") == false){
		alert("구분을 선택해 주세요");
		return false;
	}
	
	return true;
}
</script>
</head>
<body>
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>오픈잡페어 설명회 등록</h2>
	</div>
	<br>
	<form action="/fap/admin/open_pt_insert" method="post" onsubmit="return formCheck();">
		타이틀 : <input type="text" name="fap_open_pt_title" id="fap_open_pt_title" size="100"> <br>
		내용 : <textarea rows="40" cols="60" name="fap_open_pt_ct" id="fap_open_pt_ct"></textarea><br>
		구분 : <input type="radio" name="fap_open_pt_gb" value="D1000"> 설명회 <input type="radio" name="fap_open_pt_gb" value="D1001"> 구직자교육 <br>
		<input type="submit" value="등록">
	</form>
</body>
</html>