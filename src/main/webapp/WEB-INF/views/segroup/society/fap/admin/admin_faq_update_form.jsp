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
	CKEDITOR.replace('consulting_ct', {
		filebrowserUploadUrl : '/board/imageUpload',
		enterMode: CKEDITOR.ENTER_BR,
		shiftEnterMode:  CKEDITOR.ENTER_P,
		fullPage: true,
		allowedContent:  true
	});
	
	var gb = $("#fap_faq_gb_cd").val();
	if(gb == 'C5300'){
		$("#job-seeker").attr("checked","checked");
	}else if(gb == 'C5301'){
		$("#company").attr("checked","checked");
	}
})

function formCheck(){
	//제목
	var title = $("#consulting_title").val();
	if(title == '' || title.length == 0){
		alert("제목을 입력해 주세요");
		return false;
	}
	//구분
	if($("input:radio[name='fap_faq_gb_cd']").is(":checked") == false){
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
		<h2>FAQ 수정</h2>
	</div>
	<br>
<form action="/fap/admin/admin_faq_update" method="post" onsubmit="return formCheck();">
		제목 : <input type="text" name="consulting_title" id="consulting_title" value="${result.consulting_title }"> <br>
		내용 : <textarea rows="6" cols="100" name="consulting_ct" id="consulting_ct">${result.consulting_ct }</textarea><br>
		구분 : <input type="radio" name="fap_faq_gb_cd" id="job-seeker" value="C5300"> 구직자 <input type="radio" name="fap_faq_gb_cd" id="company" value="C5301"> 채용기업 <br>
		<input type="hidden" name="consulting_tp" value="A0504">
		<input type="hidden" name="consulting_seq" value="${result.consulting_seq }">
		<input type="hidden" name="fap_faq_gb_seq" value="${result.fap_faq_gb_seq }">
		<input type="hidden" id="fap_faq_gb_cd" value="${result.fap_faq_gb_cd }">
		<input type="submit" value="수정">
</form>
</body>
</html>