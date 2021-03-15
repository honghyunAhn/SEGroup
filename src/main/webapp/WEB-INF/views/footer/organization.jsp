<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){

});
</script>

<t:insertDefinition name="footerleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">연수원 소개</a>
			<a class="nth-last" href="#">조직도</a>
		</p>
		<h2 class="sub-title">조직도</h2>
	</div>
	<div class="sub-body">
		<div><img src="/resources/images/introduce-group.png" alt="조직도"></div>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->
