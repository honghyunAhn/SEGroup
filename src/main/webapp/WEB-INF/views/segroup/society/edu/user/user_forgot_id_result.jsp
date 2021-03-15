<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/login.css" />">
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<title>글로벌 엔지니어 양성</title>
</head>
<body>
	<%@include file="../menu.jsp"%>
	
	<section class="result_section">
		<div style="height:76px; "></div> <!-- 제목높이 보정용 -->
		
		<div class="login_wrap">
			<h2>아이디 찾기</h2>
	
			<c:choose>
				<c:when test="${found == null}">
					결과를 찾을 수 없습니다
					<a href=""></a>
				</c:when>
				<c:otherwise>

					<div style="width: 100%; height: 100px; border: 1px 1px 1px 1px;">
						<dd>찾으시는 아이디는 <span style="color: blue;">${found}</span>입니다</dd>
					</div>
					
					<div style="width: 100%; height: 100px; border: 1px 1px 1px 1px;">
					<ul class="login_menu2">
						<li>
							<a href="/edu/user/user_login_form">로그인 화면으로</a>
						</li>
						<li>
							<a href="/edu/user/user_forgot_password">비밀번호 찾기　</a>
						</li>
					</ul>
					</div>	
				</c:otherwise>
			</c:choose>
		</div>
	</section>
	<div style="height:327px; "></div> <!-- 바닥높이 보정용 -->
	<%@include file="../footer.jsp"%>
</body>
</html>