<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="principal" />

<script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#withdrawBtn').click(function() {
		if(!$('#form1').valid()) return;

		if(!confirm('정말 탈퇴하시겠습니가?')) {
			return;
		}


		$('#form1').submit();
	});


	// validation rule
	$("#form1").validate({
		rules: {	// 입력체크 룰
			note: {"required":true}
		}
	});
});
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a href="#">개인 정보</a>
			<a class="nth-last" href="#">회원 탈퇴</a>
		</p>
		<h2 class="sub-title">회원 탈퇴</h2>
	</div>
	<div class="sub-body">
		<form id="form1" name="form1" method="post" action="<c:url value="/mypage/private/doWithdraw"/>">
			<div class="group">
				<dl>
					<dt>아이디</dt>
					<dd>${principal.username}</dd>
					<dt>탈퇴사유</dt>
					<dd><textarea name="note" maxlength="500"></textarea></dd>
				</dl>
			</div>
		</form>
		<div class="list-bottom alignC">
				<a href="#" class="btn danger" id="withdrawBtn">회원탈퇴하기</a>
		</div>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->
