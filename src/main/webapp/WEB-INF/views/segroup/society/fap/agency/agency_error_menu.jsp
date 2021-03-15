<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
$(function() {

	$('#logout').off("click").on("click", function() {
		$('#logoutForm').submit();
		return false;
	});

	$(".fap_nav li").mouseenter(function() {

		$.each($(".fap_nav li"), function(index, item) {
			var width = $(this).width();
			$(".nav-column").eq(index).width(width);
			$(".nav-column").eq(index).css("padding", "1px");
		});
		var contents = $("#menu-contents").clone().css("display", "block");

		$(this).find(".menu-area").html(contents);
	}).mouseleave(function() {
		$(this).find(".menu-area").html('');
	});

	$("#langSelect").on("change", function() {
		var lang = $(this).val();

		if (lang != "0") {
			location.href = "/fap/agency/language_change?lo=" + lang;
		}

	});
});
</script>
<title>Bridge Job Fair</title>
</head>
<body>
	<div>
	<ul id="infoMenu">
		<c:choose>
			<c:when test="${empty check }">
				<li><a href="/fap/agency/agency_login">Login</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="#none" id="logout">Logout</a></li>
			</c:otherwise>
		</c:choose>
		<li><a href="/fap/agency/agency_insert_form">Join</a></li>
		<li><a href="member/qna.html">Q&amp;A</a></li>
		<li class=""><select id="langSelect">
				<option value="" selected="selected" disabled="disabled">언어
					선택</option>
				<option value="ko">한국어(KR)</option>
				<option value="ja">日本語(JP)</option>
		</select></li>
	</ul>
</div>
</body>
</html>