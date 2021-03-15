<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko" class="mv-html">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">
function closeThis(){
	 window.close();
}
//본인인증 (서브도메인 처리)
document.domain = 'softsociety.net'; //(운영서버 적용시)
 

jQuery(document).ready(function(){
	
	$('#user_phone',opener.document).val("${mobileVerification[3]}"); //휴대전화
    $('#user_nm',opener.document).val("${mobileVerification[8]}"); //이름
    $('#birth_year',opener.document).val("${mobileVerification[5]}".substring(0, 4)); //생년
    $('#birth_month',opener.document).val("${mobileVerification[5]}".substring(4, 6)); //월
    $('#birth_date',opener.document).val("${mobileVerification[5]}".substring(6, 8)); //일
  
	if('${mobileVerification[6]}'=='1'){ // 성별 설정
		$('#user_sex',opener.document).val('A0000');   
		$('#veriGender',opener.document).val('A0000');	
	}else{
		$('#user_sex',opener.document).val('A0001');  
		$('#veriGender',opener.document).val('A0001');
	}
    
    if('${mobileVerification[7]}'=='0'){
    	$('#veriNation',opener.document).val('A1000');
    }else{
    	$('#veriNation',opener.document).val('A1001');
    }

	    $('#veriCi',opener.document).val('${mobileVerification[1]}');
	    $('#veriDi',opener.document).val('${mobileVerification[2]}');
		$('#veriPhone',opener.document).val('${mobileVerification[3]}');
		$('#veriCom',opener.document).val('${mobileVerification[4]}');
	    $('#veriBirth',opener.document).val('${mobileVerification[5]}');
		$('#veriName',opener.document).val('${mobileVerification[8]}');
		$('#veriNum',opener.document).val('${mobileVerification[9]}');
		$('#veriTime',opener.document).val('${mobileVerification[10]}');
		
	opener.CallVerified();
	//setTimeout(function () { window.close();}, 3000); 
});

 
</script>
</head>
<body>
	<div class="mv-wrap">
       <div class="mv-logo"></div>
       <div class="mv-text"><p>본인인증에 성공하셨습니다.</p></div>
        <p class="mv-button" onclick="closeThis()">닫기</p>
    </div>   
</body>
</html>