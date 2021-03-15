<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="message" value="본 모바일앱은 고화질 스트리밍 방식으로 출퇴근시간 또는 네트워크 상태가 고르지 못할 경우 교육수강이 어려울수 있습니다." />
<c:choose>
	<c:when test="${requestScope.platform == 'android'}">
		{"version":"1.0", "link":"market://details?id=changbi.com.changbi_android", "new":"new version android","flag":"SERVICE","message":"" }
	</c:when>
	<c:otherwise>
		{"version":"1.0", "link":"https://teacher.changbiedu.com/app/app_down.jsp", "new":"new version iOS", "flag":"SERVICE","message":"" }
	</c:otherwise>
</c:choose>