<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){

});
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a class="nth-last" href="#">공인 인증서 정보</a>
		</p>
		<h2 class="sub-title">공인 인증서 정보</h2>
	</div>
	<div class="sub-body">
		<div class="tab-group">
			<ul class="tab-header sub x2">
				<li><a class="nth-1st" href="certificate">인증서 등록(갱신)</a></li>
				<li><a class="on" href="certificate">인증서 해제</a></li>
			</ul>
			<div class="section tab-body">
				<div class="section-header">
					<h5>본인 확인 공인 인증서 삭제 안내</h5>
				</div>
				<ul class="notice-list">
					<li>삭제 하고자 하는 인증서를 선택 후 인증서 암호 입력 후 [확인] 버튼을 클릭합니다.</li>
					<li>등록된 인증서가 아닌 경우 해제할 수 없습니다.</li>
				</ul>
				<div class="list-bottom alignC">
					<a href="#" class="btn primary">인증서 선택</a>
					<a href="#" class="btn danger">취소</a>
				</div>
			</div><!--//.tab-body-->
		</div><!--//.tab-group-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->
