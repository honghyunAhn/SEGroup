<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<t:insertDefinition name="footerleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">연수원 소개</a>
			<a class="nth-last" href="#">찾아오시는 길</a>
		</p>
		<h2 class="sub-title">찾아오시는 길</h2>
	</div>
	<div class="sub-body">
		<div class="intro-map">
			<div id="daumRoughmapContainer1521529975244" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%;margin-bottom:15px;"></div>
			<!-- <script charset="UTF-8" class="daum_roughmap_loader_script" src="http://dmaps.daum.net/map_js_init/roughmapLoader.js"></script> -->
			<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>

			<script charset="UTF-8">
				new daum.roughmap.Lander({
					"timestamp" : "1521529975244",
					"key" : "naqc",
					"mapHeight" : "450"
				}).render();
			</script>
			<ul class="basic-list">
				<li><strong>회사주소</strong> 서울특별시 마포구 월드컵로12길 7, 2층 (서교동, 창비서교빌딩)</li>
				<li><strong>대표 전화</strong> 1833-7247</li>
				<li><strong>팩스</strong> 02-6949-0953</li>
				<li><strong>전자 우편</strong> <a href="mailto:teacher@changbi.com">teacher@changbi.com</a></li>
			</ul>
		</div>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->