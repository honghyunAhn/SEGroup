<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="details" var="check" />
	</sec:authorize>
<script>
function printCourse(app_id) {
	var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "${path}/smp/user/printCourse");
    
    var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "app_id");
    hiddenField.setAttribute("value", app_id);
    form.appendChild(hiddenField);
    
    document.body.appendChild(form);
    form.submit();
}
</script>
<nav class="gtco-nav" role="navigation">
	<div class="gtco-container">

		<div class="row">
			<div class="col-sm-4 col-xs-12">
				<div id="gtco-logo">
					<a href="/smp/user/usermain" target="_blank"
						title="새 창 열림"><img
						src="/resources/segroup/society/smp/images/SES.png"
						width="150" height="45" alt="SCIT과정"></a>
				</div>
			</div>
			<div class="col-xs-8 text-right menu-1">
				<ul>
					<li><a href="/smp/user/usermain">홈</a></li>
					<li class="has-dropdown"><a href="/smp/user/board">공지</a>
						<ul class="dropdown">
							<li><a href="/smp/user/board">기수공지</a></li>
						</ul></li>
					<li><a href="#">성적관리</a></li>
					<li><a href="/smp/scheduleStart">일정</a></li>
					<li class="has-dropdown"><a href="#" onclick="printCourse('${check.getUser().getUser_id()}');">증명서</a>
						<ul class="dropdown">
							<li><a href="#" onclick="printCourse('${check.getUser().getUser_id()}');">수강확인서</a></li>
							<li><a href="#">출결확인서</a></li>
						</ul></li>
					<li class="btn-cta"><a href="#"><span>문의사항</span></a></li>
				</ul>
			</div>
		</div>

	</div>
</nav>

<header id="gtco-header" class="gtco-cover" role="banner">
	<div class="overlay" style="height: 85px;"></div>
	<div class="gtco-container"></div>
</header>