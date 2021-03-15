<%@page import="org.springframework.mobile.device.DeviceUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%
String siteUrl = request.getScheme() + "://" + request.getServerName() + (request.getLocalPort()==80||request.getLocalPort()==443?"":":"+ request.getLocalPort());
request.setAttribute("siteUrl", siteUrl);
request.setAttribute("currentUrl", siteUrl + request.getAttribute("javax.servlet.forward.request_uri") + "?" + (request.getQueryString()== null?"":request.getQueryString()));
%>
<c:set var="contextPath" value='${requestScope["javax.servlet.forward.request_uri"]}'/>
<c:set var="pageTitle" value="창비교육 원격교육연수원" scope="request"/>
<c:if test="${not empty detail.NAME }"><c:set var="pageTitle" value="${detail.NAME }" scope="request"/></c:if>
<!doctype html>
<html>
	<head>
		<title>${pageTitle }</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width">
		<c:if test="${not empty ogdata }">
		<meta property="og:url" content="${currentUrl }">
		<meta property="og:title" content="${pageTitle }">
		<meta property="og:site_name" content="창비교육 원격교육연수원">
		<meta property="og:description" content="${ogdata.description }">
		<c:if test="${not empty ogdata.image }"><meta property="og:image" content="${siteUrl }/${ogdata.image }"></c:if>
		</c:if>
		<link rel="stylesheet" href="/resources/css/slick.css"/>
		<link rel="stylesheet" href="/resources/css/jquery.minimalect.css"/>
		<link rel="stylesheet" href="/resources/css/changbilms.css" />
		<c:if test="${currentDevice.mobile }"><link rel="stylesheet" href="/resources/css/changbilms_mobile.css" /></c:if>
		<link rel="stylesheet" href="/resources/css/print_popup.css"/>
		<link rel="stylesheet" href="/resources/css/jquery-ui/jquery-ui.min.css"/>
		<!--[if lte IE 9]><script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script><![endif]-->
		<!--[if (gt IE 9) | (!IE)]><!--><script type="text/javascript" src="/resources/js/jquery-3.2.1.min.js"></script><!--<![endif]-->
		<!--[if lte IE 8]>
		<script src="/resources/js/ie8/html5shiv.min.js"></script>
		<script src="/resources/js/ie8/es5-shim.min.js"></script>
		<![endif]-->
		<script src="/resources/js/ie8/jquery.xdomainrequest.min.js"></script>
		<script type="text/javascript" src="/resources/js/slick.js"></script>
		<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
		<script type="text/javascript" src="/resources/js/jquery.minimalect.js"></script>
		<script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="/resources/js/jquery-ui.min.js"></script>
		<c:choose>
			<c:when test="${currentDevice.mobile }"><script type="text/javascript" src="/resources/js/changbilms_mobile.js"></script></c:when>
			<c:otherwise><script type="text/javascript" src="/resources/js/changbilms.js"></script></c:otherwise>
		</c:choose>


		<script type="text/javascript">
			$.datepicker.setDefaults({
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear: true,
		    //changeMonth: true,
		    //changeYear: true,
		    yearSuffix: '년'
		  });

			$(function () {
				// 포커스
				// 검색창 홀더
				$.fn.cusPlaceHolder = function () {
					return this.each(function () {
					var $obj = $(this);
					$in = $obj.find(".cusPHIn");
					txt = $in.attr("data-placeholder");

					$obj.append("<span class='placeholder off'>"+txt+"</span>");
					if ($in.val() == "") {
						$obj.find(".placeholder").removeClass("off");
					}

					$obj.on("click", ".placeholder", function () {
						$(this).addClass("off");
						$in.focus();
					});

					$in.on("blur", function () {
						if ($(this).val() == "") {
						$obj.find(".placeholder").removeClass("off");
						}
					});
					});
				};
				$(function () {
					$(".cusPlaceHolder").cusPlaceHolder();
				});
			})
		</script>
	</head>
  <body>

	<div id="u_skip">
		<a href="#main-menu">사이트 메뉴</a>
		<a href="#main-search">검색</a>
		<a href="#">강사 소개</a>
		<a href="#">분야별 연수과정</a>
		<a href="#">최근 게시물</a>
		<a href="#">퀵메뉴</a>
	</div>
  	<div class="page">
		<t:insertAttribute name="header" />
		<t:insertAttribute name="content" />
		<t:insertAttribute name="footer" />
  	</div>
  	<!-- popup -->
  	<t:insertDefinition name="notation"/>
  	<t:insertDefinition name="plan"/>

		<t:insertDefinition name="receipt"/>												<!-- receipt popup : 영수증 팝업 -->
		<t:insertDefinition name="certificate"/>										<!-- certificate popup : 이수증 팝업 -->
		<t:insertDefinition name="scorecard"/>										<!-- scorecard popup : 성적표 팝업 -->
		<t:insertDefinition name="register"/>											<!-- register popup : 수강확인증 팝업 -->
		<t:insertDefinition name="couponregist"/>							<!-- couponregist popup : 쿠폰등록 팝업 -->

  </body>
</html>
