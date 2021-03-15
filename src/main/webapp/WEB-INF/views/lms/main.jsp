<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- 홈페이지의 대략적인 설명 >> 검색 결과 제목 하단에 설명으로 노출 -->
<meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Do itcampus!">
<!-- 홈페이지 키워드 >> 키워드 검색했을 때 검색결과로 노출 -->
<meta name="keywords" content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
<title>Let's Do it 두잇캠퍼스</title>
<link rel="stylesheet" href="/resources/lms/css/swiper.min.css">
<link rel="stylesheet" href="/resources/lms/css/reset.css">
<link rel="stylesheet" href="/resources/lms/css/common.css">
<link rel="stylesheet" href="/resources/lms/css/img-icon.css">
<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
<script src="/resources/lms/js/jquery-3.3.1.min.js"></script>
<script src="/resources/lms/js/swiper.js"></script>
<script src="/resources/lms/js/renewal_script.js"></script>

</head>

<script type="text/javascript">
	
	$( document ).ready(function() {
		var state=$("#serverMessage").val();
		var dormancy_msg = "${dormancy_msg}";
		if("${dormancy_msg}" != null && "${dormancy_msg}" != '') {
			alert("${dormancy_msg}");
		}
	});
	

	function openWindow(url, target){
		   window.open(url, target);
		   window.focus();
	}
    
    function toFaq(id, faqCode){
    	$('#selectFaq input[name="id"]').attr("value", id);
    	$('#selectFaq input[name="faqCode"]').attr("value", faqCode);
    	$('#selectFaq').submit();
    }
        
    
        
</script>

<body>
	<!-- header-include -->
	<%@include file="header.jsp"%>

	<div class="content" id="main">
		<!-- 03. 분야별 추천 강좌 -->
		<div class=" recommend-class">
			<div class="swiper-container field-wrap field01">
				<div class="ctt-hdr d-flex justify_between">
					<div class="title h4 fc_mtL">디지털·AI 추천</div>
					<div class="btnWrap d-flex">
						<div class="swiper-button-prev img-icon angle-left btn_left"></div>
						<div class="swiper-button-next img-icon angle-right btn_right margin-left5"></div>
					</div>
				</div>
				<div class="swiper-wrapper class-cardWrap d-flex">
					<c:forEach var="it_recommends" items="${it_recommends}" varStatus="status">
						<div class="swiper-slide class-card classCard${status.count}">
							<a href="/lms/course/it/sub01-01-01-01?course_id=${it_recommends.course_id}">
								<div class="class-img" style="background-image:url(${it_recommends.photo_url});">
									<div class="img-icon heart_grBG"></div>
								</div>
								<div class="class-seg">
								<div class="class-divWrap filterWrap d-flex">
									<c:if test="${it_recommends.icon_1 == 'Y' }">
										<div class="class-division filter new">신규</div>
									</c:if>
									<c:if test="${it_recommends.icon_2 == 'Y' }">
										<div class="class-division filter recommend">추천</div>
									</c:if>
									<c:if test="${it_recommends.icon_3 == 'Y' }">
										<div class="class-division filter popular">인기</div>
									</c:if>
									<c:if test="${it_recommends.icon_4 == 'Y' }">
										<div class="class-division filter book">교재</div>
									</c:if>
									<c:if test="${it_recommends.icon_5 == 'Y' }">
										<div class="class-division filter sale">할인</div>
									</c:if>
								</div>
								<div class="class-title small">
									<h5 class="h5 fc_666">e러닝</h5>
									<p class="class-ttl">${it_recommends.name}</p>
								</div>
								<div class="class-info">
									<div class="price fc_666">
										<c:if test="${it_recommends.price == 0}">
											무료
										</c:if>
										<c:if test="${it_recommends.price > 0}">
											<fmt:formatNumber value="${it_recommends.price}" pattern="#,###" />원
										</c:if>
									</div>
								</div>
							</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="swiper-container field-wrap field02">
				<div class="ctt-hdr d-flex justify_between">
					<div class="title h4 fc_orL">외국어 추천</div>
					<div class="btnWrap d-flex">
						<div class="swiper-button-prev img-icon angle-left btn_left"></div>
						<div class="swiper-button-next img-icon angle-right btn_right margin-left5"></div>
					</div>
				</div>
				<div class="swiper-wrapper class-cardWrap d-flex">
					<c:forEach var="foreign_recommends" items="${foreign_recommends}" varStatus="status">
						<div class="swiper-slide class-card classCard${status.count}">
							<a href="/lms/course/foreign/sub02-01-01-01?course_id=${foreign_recommends.course_id}">
								<div class="class-img" style="background-image:url(${foreign_recommends.photo_url});">
									<div class="img-icon heart_grBG"></div>
								</div>
								<div class="class-seg">
									<div class="class-divWrap filterWrap d-flex">
										<c:if test="${foreign_recommends.icon_1 == 'Y' }">
											<div class="class-division filter new">신규</div>
										</c:if>
										<c:if test="${foreign_recommends.icon_2 == 'Y' }">
											<div class="class-division filter recommend">추천</div>
										</c:if>
										<c:if test="${foreign_recommends.icon_3 == 'Y' }">
											<div class="class-division filter popular">인기</div>
										</c:if>
										<c:if test="${foreign_recommends.icon_4 == 'Y' }">
											<div class="class-division filter book">교재</div>
										</c:if>
										<c:if test="${foreign_recommends.icon_5 == 'Y' }">
											<div class="class-division filter sale">할인</div>
										</c:if>
									</div>
									<div class="class-title small">
										<h5 class="h5 fc_666">e러닝</h5>
										<p class="class-ttl">${foreign_recommends.name}</p>
									</div>
									<div class="class-info">
										<div class="price fc_666">
											<c:if test="${foreign_recommends.price == 0}">
												무료
											</c:if>
											<c:if test="${foreign_recommends.price > 0}">
												<fmt:formatNumber value="${foreign_recommends.price}" pattern="#,###" />원
											</c:if>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="swiper-container field-wrap field03">
				<div class="ctt-hdr d-flex justify_between">
					<div class="title h4 fc_mtD">직무 추천</div>
					<div class="btnWrap d-flex">
						<div class="swiper-button-prev img-icon angle-left btn_left"></div>
						<div class="swiper-button-next img-icon angle-right btn_right margin-left5"></div>
					</div>
				</div>
				<div class="swiper-wrapper class-cardWrap d-flex">
					<c:forEach var="business_recommends" items="${business_recommends}" varStatus="status">
						<div class="swiper-slide class-card classCard${status.count}">
							<a href="/lms/course/business/sub03-01-01-01?course_id=${business_recommends.course_id}">
								<div class="class-img" style="background-image:url(${business_recommends.photo_url});">
									<div class="img-icon heart_grBG"></div>
								</div>
								<div class="class-seg">
									<div class="class-divWrap filterWrap d-flex">
										<c:if test="${business_recommends.icon_1 == 'Y' }">
											<div class="class-division filter new">신규</div>
										</c:if>
										<c:if test="${business_recommends.icon_2 == 'Y' }">
											<div class="class-division filter recommend">추천</div>
										</c:if>
										<c:if test="${business_recommends.icon_3 == 'Y' }">
											<div class="class-division filter popular">인기</div>
										</c:if>
										<c:if test="${business_recommends.icon_4 == 'Y' }">
											<div class="class-division filter book">교재</div>
										</c:if>
										<c:if test="${business_recommends.icon_5 == 'Y' }">
											<div class="class-division filter sale">할인</div>
										</c:if>
									</div>
									<div class="class-title small">
										<h5 class="h5 fc_666">e러닝</h5>
										<p class="class-ttl">${business_recommends.name}</p>
									</div>
									<div class="class-info">
										<div class="price fc_666">
											<c:if test="${business_recommends.price == 0}">
												무료
											</c:if>
											<c:if test="${business_recommends.price > 0}">
												<fmt:formatNumber value="${business_recommends.price}" pattern="#,###" />원
											</c:if>
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="swiper-container field-wrap field03">
				<div class="ctt-hdr d-flex justify_between">
					<div class="title h4 fc_mtD">자격증 추천</div>
					<div class="btnWrap d-flex">
						<div class="swiper-button-prev img-icon angle-left btn_left"></div>
						<div class="swiper-button-next img-icon angle-right btn_right margin-left5"></div>
					</div>
				</div>
				<div class="swiper-wrapper class-cardWrap d-flex">
					<c:forEach var="license_recommends" items="${license_recommends}" varStatus="status">
						<div class="swiper-slide class-card classCard${status.count}">
							<a href="/lms/course/license/sub05-01-01-01?course_id=${license_recommends.course_id}">
								<div class="class-img" style="background-image:url(${license_recommends.photo_url});">
									<div class="img-icon heart_grBG"></div>
								</div>
								<div class="class-seg">
								<div class="class-divWrap filterWrap d-flex">
									<c:if test="${license_recommends.icon_1 == 'Y' }">
										<div class="class-division filter new">신규</div>
									</c:if>
									<c:if test="${license_recommends.icon_2 == 'Y' }">
										<div class="class-division filter recommend">추천</div>
									</c:if>
									<c:if test="${license_recommends.icon_3 == 'Y' }">
										<div class="class-division filter popular">인기</div>
									</c:if>
									<c:if test="${license_recommends.icon_4 == 'Y' }">
										<div class="class-division filter book">교재</div>
									</c:if>
									<c:if test="${license_recommends.icon_5 == 'Y' }">
										<div class="class-division filter sale">할인</div>
									</c:if>
								</div>
								<div class="class-title small">
									<h5 class="h5 fc_666">e러닝</h5>
									<p class="class-ttl">${license_recommends.name}</p>
								</div>
								<div class="class-info">
									<div class="price fc_666">
										<c:if test="${license_recommends.price == 0}">
											무료
										</c:if>
										<c:if test="${license_recommends.price > 0}">
											<fmt:formatNumber value="${license_recommends.price}" pattern="#,###" />원
										</c:if>
									</div>
								</div>
							</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<!-- 04. 미들 배너1 -->
		<div class="swiper-container bannerImg_responsive">
			<!-- <div class="btnWrap d-flex">
				<div class="swiper-button-prev img-icon angle-left btn_left"></div>
				<div class="swiper-button-next img-icon angle-right btn_right margin-left5"></div>
			</div> -->
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<!-- <a class="bannerImg" href="/lms/user/.."> -->
						<div class="bannerImg banner1"></div>
					<!-- </a> -->
				</div>
				<div class="swiper-slide">
					<a class="bannerImg" href="/lms/user/sub00-02">
						<div class="bannerImg banner2"></div>
					</a>
				</div>
			</div>
		</div>
		<!-- <a class="bannerImg" href="#"> -->
		<div class="bannerImg banner1"></div>
		<!-- </a> -->

		<!-- 05. 기업소개 -->
		<div class="companyInfoWrap">
			<div class="ctt-hdr">
				<div class="title h4">Soft Engineer Society 사업분야</div>
				<p class="fc_666">
					다양한 전공의 한국청년들을 21C ICT융복합 인재로 양성하여 해외 우수기업에서 활동할 기회를 제공하고 
					기업 및 산업계간의 글로벌 협력을 통하여 새로운 가치를 창출합니다.
				</p>
			</div>
			<div class="companyInfo d-flex">
				<div class="company-card company-card01">
					<a href="http://bridge.career" target="_blank">
						<div class="company-img"></div>
						<p class="company-seg">글로벌 기업 리쿠르팅</p>
					</a>
				</div>
				<div class="company-card company-card02">
					<a href="http://bridge.career" target="_blank">
						<div class="company-img"></div>
						<p class="company-seg">교육·잡매칭 플랫폼 운영</p>
					</a>
				</div>
				<div class="company-card company-card03">
					<a href="#">
						<div class="company-img"></div>
						<p class="company-seg">글로벌협력</p>
					</a>
				</div>
			</div>
		</div>
		<!-- 06. 미들 배너2 -->
		<a class="bannerImg" href="/lms/user/sub00-02">
			<div class="bannerImg banner2"></div>
		</a>
	</div>

	<!-- footer-include -->
	<%@include file="common_footer_doitcam.jsp"%>
</body>

</html>
