<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<script type="text/javascript">
function setCookie(name,value,expiredays){
	var today = new Date();
	today.setDate(today.getDate() + expiredays);
	document.cookie = name+'='+escape(value)+'; path=/; expires='+today.toGMTString()+';';
}

function closePopupNotToday(){
	var cName = '${popup.fap_popup_link}';
	setCookie(cName,'Y',1);
	self.close();
}
</script>
</head>
<body>
	<div class="text-align-center fap_popup">
		<img src="/fap/admin/popup_file/${popup.fap_popup_img_saved }">
		<div class="server_time">
			${popup.fap_popup_ct }
		</div>
	</div>
	<div class="popup_bottom">
		<a href="javascript:closePopupNotToday()">오늘하루 그만보기</a>
	</div>
</body>
</html>