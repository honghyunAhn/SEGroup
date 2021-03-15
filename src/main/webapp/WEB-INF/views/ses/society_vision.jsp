<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page session="false"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
	<title></title>
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
		<h1>Vision<h1>
	</div>
</div>
<div class="info4">
	<div class="main_sec_con knowhow">
<!-- 		<h2>한국의 인적자원이 글로벌 기업에 진출하여 우수한 역량을 발휘할 수 있는 기회를 확장하고</h2> -->
<!-- 		<h2>상호 소통과 협력을 지원하는 네트워크 운영</h2> -->
            <h2>
                <spring:message code="menu.vision_text" arguments="<br>" />
            </h2>
		<div style="text-align: center;">
			<img src="<c:url value="/resources/ses/image/vision_sub.jpg" />" alt="" />
		</div>
	</div>
</div>

<%@include file="footer.jsp"%>

</body>
</html>