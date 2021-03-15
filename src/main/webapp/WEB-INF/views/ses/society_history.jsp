<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page session="false"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<!-- <meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " /> -->
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<title>Soft Engineer Society</title>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">

<style>
.info4 li:first-child{ margin-left: 0px;)}

*{
    margin: 0px;
    padding: 0px;
}
body, html{
    height: 100%;
}
.main_bg_img{
    position: relative;
    background-image: url(/resources/ses/image/web-top.jpg);  
      width: 100%;
      height: 270px;
    background-size: cover;
}
.main_bg_img .content{
     position: absolute;
     top:50%;
     left:50%;
     transform: translate(-50%, -50%);                                                                   
     font-size:2rem;
     color: white;
     z-index: 2;
     text-align: center;
}

/* History 전용 CSS 적용 */
.info4 .history_left{
	padding-top: 50px;
	float: left;
	line-height: 2;
	padding-left: 2%;
}
.info4 .history_left .history_header{
	font-size: 25px;
	font-weight: bold;
}
.info4 .history_left .history_body{
	letter-spacing : 0px;
	font-size: 15px;
}
.info4 .history_left .history_body .history_year{
	font-weight: bold;
}
.info4 .history_left .history_body .history_blank{
	padding-right: 11%;
}
.info4 .history_right{
	padding-top: 50px;
	float: right;
	line-height: 2;
	padding-right: 2%;
}
.info4 .history_right .history_header{
	font-size: 25px;
	font-weight: bold;
}
.info4 .history_right .history_body{
	font-size: 15px;
}
.info4 .history_right .history_body .history_year{
	font-weight: bold;
}
.info4 .history_right .history_body .history_blank{
	padding-right: 11%;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$('.slider').bxSlider({
		  slideWidth: 825,
		  auto: true,
		  autoControls: true
		});
		$('.slider1').bxSlider({
		  slideWidth: 350,
		  auto: true,
		  autoControls: true,
		  maxSlides: 3,
		  minSlides: 3		 
		});
		$('.slider2').bxSlider({
		  slideWidth: 350,
		  auto: true,
		  autoControls: true,
		  maxSlides: 2,
		  minSlides: 2
		 
		});
		$('.slider3').bxSlider({
		  slideWidth: 510,
		  auto: true,
		  autoControls: true,
		});
		$('.slider4').bxSlider({
		  slideWidth: 350,
		  auto: true,
		  autoControls: true,
		  maxSlides: 3,
		  minSlides: 3,
		  slideMargin: 24	
		});		
		$('.slider5').bxSlider({
			  slideWidth: 220,
			  auto: true,
			  autoControls: true,
			  maxSlides: 5,
			  minSlides: 5,
//			  slideMargin: 5,
			  pager:false,
			  controls:false
		});		
		$('.slider6').bxSlider({
			  slideWidth: 1100,
			  auto: true,
			  pager:false,
			  controls:false
		});
		$('.slider7').bxSlider({
			  slideWidth: 1100,
			  auto: true,
			  pager:false,
			  controls:false
		});
		$('.slider8').bxSlider({
			adaptiveHeight: false,
			auto: true,
			autoControls: true,
			autoHover: true
		});
		$('.bxslider').bxSlider({
			pager: false
		});
	})
</script>
</head>
<body>

<%@include file="menu.jsp"%>

<div class="main_bg_img">
	<div class="content">
		<h1>History<h1>
	</div>
</div>
<div class="info4">
	<div class="history_left">
		<span class="history_header">2011 ~ 2017</span> <br />
		<span class="history_body">
		
		<span class="history_year">2017.11</span> 광주전남 대학일자리센터 해외진출지원협의회 협력기관 MOU 협약 체결 <br/>
		<span class="history_year">2017.11</span> 제 4회 Soft Engineer Job Fair 개최 (Tokyo TKP 市ヶ谷, 11.20∼24) <br/>
		<span class="history_year">2017.08</span> 2017년 산인공 민간 해외취업알선기관 승인 <br/>
		<span class="history_year">2017.06</span> 제3회 Soft Engineer Job Fair 개최 (Tokyo 神楽坂HC 스튜디오, 6.19∼23) <br/>
		<span class="history_year">2017.05</span> 2017 서울시 청년 해외일자리 민관협력사업 수행기관 선정 <br/>
		<span class="history_year">2017.05</span> 한국산업기술대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원) <br/>
		<span class="history_year">2017.05</span> 국민대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원) <br/>
		<span class="history_year">2017.04</span> 금강대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원) <br/>
		<span class="history_year">2016.12</span> 전남대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원) <br/>
		<span class="history_year">2016.12</span> 원격평생교육시설 인가 <br/>
		<span class="history_year">2016.11</span> 제2회 Soft Engineer Job Fair 개최 (Tokyo TKP 永町田, 11.21∼25) <br/>
		<span class="history_year">2016.06</span> 제1회 Soft Engineer Job Fair 개최 (Tokyo Haneda Turtle Service, 6.20∼24) <br/>
		<span class="history_year">2016.03</span> SESchool의 대외협력사업부문 분사 - 전담법인설립 (&lt;주&gt;Soft Engineer Society) <br/> 
        <span class="history_blank"></span>ㆍ해외취업알선, 글로벌ICT인재 육성대상자선발, 공인시험센터 등 <br/> 
		<span class="history_year">2015.08</span> 미래창조과학부 SW전문인력양성기관 지정 <br/>
		<span class="history_year">2015.04</span> 직업소개사업등록 <br/>
		<span class="history_year">2014.12</span> 최근5년간(2010∼14) 교육생 취업율 100% 달성 <br/>
		<span class="history_year">2014.07</span> 평생교육시설인가 <br/>
		<span class="history_year">2013.04</span> Opic공인시험센터 지정 <br/>
		<span class="history_year">2013.01</span> K-Move 스쿨 운영컨소시움 체결 <br/>
		<span class="history_year">2011.01</span> 한국무역협회 무역아카데미 ICT교육센터 운영기관지정 <br/>
		</span>
	</div>
	<div class="history_right">
		<span class="history_header">2006~2010</span> <br/>
		<span class="history_body">
			<span class="history_year">2010.12</span> 한국무역협회 통합연수시스템 개발 (PM 및 QA지원) <br/> 
			<span class="history_year">2010.11</span> 소프트웨어사업자 등록 <br/> 
			<span class="history_year">2008.11</span> 무역진흥기여(글로벌인재양성) 국무총리 표창 <br/> 
			<span class="history_year">2008.10</span> Prometric Loyal Partner Award 수상  <br/>
			<span class="history_year">2008.06</span> 소프트웨어ㆍ외국어교육 평생직업교육학원 등록 <br/>
			<span class="history_year">2007.08</span> ETS 공인 토플시험센터 지정 <br/>
			<br/>
		</span>
		<span class="history_header">2001~2005</span> <br/>
		<span class="history_body">
			<span class="history_year">2005.03</span> Sun Educational Service Partnership 체결 <br/>
			<span class="history_year">2005.11</span> 해외인력양성특수유공 산업자원부장관 표창 <br/>
			<span class="history_year">2003.07</span> 美 카네기멜론대(CMU) 석사과정 사전교육프로그램 설계ㆍ운영 <br/>
			<span class="history_year">2002.09</span> 프로메트릭(Prometric) 공인시험센터 지정 <br/>
			<span class="history_year">2002.06</span> 오라클 공인교육센터지정 (Oracle University) <br/>
			<span class="history_year">2001.12</span> 창업(법인명변경 &lt;주&gt;에프앤텍  <br/>
			<span class="history_blank"></span>-&gt; &lt;주&gt;Soft Engineer School/16.3월부 , <br/>
			<span class="history_blank"></span>법인합병 &lt;주&gt;Soft Engineer Society로 기업합병/17.12월)
		</span>
	</div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>