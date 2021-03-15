<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 1.3. 푸터 -->
<div class="footer">
	<hr/>
	<div class="area-top">
		<p class="footer-menu">
			<a class="nth-1st" href="/footer/intro">연수원 소개</a>
			<a href="<c:url value="/footer/terms"/>">이용 약관</a>
			<a href="<c:url value="/footer/privacy"/>">개인 정보 처리 방침</a>
			<a href="<c:url value="/footer/email"/>">이메일 주소 수집 거부</a>
			<a href="<c:url value="/serviceCenter/alliance/alliance"/>">제휴 문의 </a>
			<a href="<c:url value="/serviceCenter/teacher/teacher"/>">강사 지원 </a>
		</p>
	</div><!--//.footer>.area-top-->
	<div class="area-copy">
		<h1 class="footer-logo"><img src="/resources/images/ci.png" alt="창비교육 원격교육연수원"></h1>
		<div class="footer-fms">
			<a class="btn-toggle" href="#fms-links"><span>Family Site</span></a>
			<ul id="fms-links" class="off">
				<li><a class="nth-1st" target="_blank" title="새창으로 이동" href="http://www.changbi.com">창비</a></li>
				<li><a target="_blank" title="새창으로 이동" href="http://changbiedu.com">창비교육</a></li>
				<li><a target="_blank" title="새창으로 이동" class="nth-last" href="http://www.changbi.net">창비서교빌딩 대관 서비스</a></li>
				<li><a target="_blank" title="새창으로 이동" href="http://www.mediachangbi.com/">미디어창비</a></li>
			</ul>
		</div>
		<div class="footer-copy">
			<p class="address">서울특별시 마포구 월드컵로12길 7, 2층(서교동, 창비서교빌딩)　(주)창비교육 |　대표 이사: 강일우</p>
			<p class="lisence">사업자 등록 번호: 105-88-04459　|　연수원 인가 번호 제00-00호</p>
			<p class="lisence">통신 판매 번호: 제 2016-서울마포-0119호 [<a href="http://www.ftc.go.kr/bizCommPop.do?wkr_no=&apv_perm_no=2016313018030200119" target="_blank">정보 조회</a>]</p>
			<p class="contact">대표 전화: 1833-7247　|　팩스: 02-6949-0953　|　전자 우편: teacher@changbi.com</p>
			<p class="copyright">Copyright 2018 (주)창비교육 All Rights Reserved.</p>
		</div>
	</div><!--//.footer>.area-copy-->
</div><!--//.footer-->