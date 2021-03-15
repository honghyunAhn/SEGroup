<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi" />
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">
$(function () {
	$('#check_btn').attr('href', '<c:url value="/edu/user/user_login_form" />');
});
</script>
</head>
<body>
	<%@include file="../menu.jsp"%>
	
	<section class="join_section">
		<article>
			<h3>회원 가입하기</h3>
			
			<ul class="join_system">
				<li class="join_box active">1.ID/비밀번호 설정</li>
				<li class="join_line"></li>
				<li class="join_box active">2.약관 동의</li>
				<li class="join_line"></li>
				<li class="join_box active">3.가입완료</li>
			</ul>  <!-- join_system -->
			
			<h3>회원 가입완료</h3>
			
			<div class="fin_box">
				<p class="fin_title">ICT 교육센터 회원이 되신 것을 환영합니다!<br>
				가입하신 정보를 확인해주세요.
				</p>
				
				<div class="fin_in_box">
					<p class="fin_id"><b>ID</b><span>${ user_id }</span></p>
					<p class="fin_email"><b>이메일</b><span>${ user_email }</span></p>             
				</div>
			</div> <!-- fin_box -->
			
			<div class="btn_wrap">
				<a class="btn btn_b btn_center" style="color: white;" type="button" id="check_btn">확인</a>
			</div> 
		</article>
	</section>  <!--  join_section -->
	
	<%@include file="../footer.jsp"%>
</body>
</html>