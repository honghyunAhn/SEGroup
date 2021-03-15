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
	
	var open_gb = $("#open_gb").val();
	
	if(open_gb == 'D1000'){
		$("#presentation").attr("checked","checked");
	}else if(open_gb == 'D1001'){
		$("#applicant_edu").attr("checked","checked");
	}
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
	
	if(confirm("정보 변경시 노출구분이 비노출 처리로 변경됩니다. 수정하시겠습니까?")){
		return true;
	}else{
		return false;
	}
	
}
</script>
</head>
<body>
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>오픈잡페어 설명회 수정</h2>
	</div>
	<br>
	<form action="/fap/admin/open_pt_update" method="post" onsubmit="return formCheck();">
		타이틀 : <input type="text" name="fap_open_pt_title" id="fap_open_pt_title" size="100" value="${result.fap_open_pt_title }"> <br>
		내용 : <textarea rows="40" cols="60" name="fap_open_pt_ct" id="fap_open_pt_ct">${result.fap_open_pt_ct }</textarea><br>
		구분 : <input type="radio" name="fap_open_pt_gb" id="presentation" value="D1000"> 설명회 <input type="radio" name="fap_open_pt_gb" id="applicant_edu" value="D1001"> 구직자교육 <br>
		<input type="hidden" id="open_gb" value="${result.fap_open_pt_gb }">
		<input type="hidden" name="fap_open_pt_seq" value="${result.fap_open_pt_seq }">
		<input type="submit" value="수정">
	</form>
</body>
</html>