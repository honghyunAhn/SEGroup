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
		<h2 class="sub-title">연수원 소개</h2>
	</div>
	<div class="sub-body">

		<div class="group">
			<div class="group-header">
				<h3>비전</h3>
			</div><!--//.group-header-->
			<div class="group-body">
				<h4 class="quote-label">비전</h4>
				<p class="single-quote"><span>한결같되 나날이</span> <span>새로워지는 열린 배움터</span></p>
			</div>
		</div><!--.group#intro-vision-->
		<div class="group">
			<div class="group-header">
				<h3>추진 방향 및 전략</h3>
			</div><!--//.group-header-->
			<div id="intro-direction" class="group-body">
				<div class="diagram typeA">
					<h4 class="quote-label">전략</h4>
					<div class="item no1">
						<em class="item-num">01</em>
						<strong class="item-title">창비의 우수한 콘텐츠</strong>
						<ul>
							<li>900여 명 필자, 강사 후보진</li>
							<li>3700여 권, 방대한 콘텐츠</li>
						</ul>
					</div><!--.item-->
					<div class="item no2">
						<em class="item-num">02</em>
						<strong class="item-title">참여와 소통</strong>
						<ul>
							<li>교원연수자문단 운영</li>
							<li>강사/교원 오프라인 행사 지원</li>
						</ul>
					</div><!--.item-->
					<div class="item no3">
						<em class="item-num">03</em>
						<strong class="item-title">차별화된 강좌 개발</strong>
						<ul>
							<li>유명 문인, 학자 강사진으로 섭외</li>
							<li>정보 전달 위주 강좌에서 인문적&middot;예술적 상상력 키우는 강좌 제공</li>
						</ul>
					</div><!--.item-->
					<div class="item no4">
						<em class="item-num">04</em>
						<strong class="item-title">협력 체제 구축</strong>
						<ul>
							<li>교육부/교육청과 협력</li>
							<li>방송 등 미디어 콘텐츠 활용 능력</li>
							<li>전문 학습 공동체, 전문 학회와 협력</li>
						</ul>
					</div><!--.item-->
				</div><!--.diagramA-->
			</div>
		</div><!--.group-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->

