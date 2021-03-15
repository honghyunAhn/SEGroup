<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1, maximum=1, user-scalable=yes"/>	
	<meta name="google-site-verification" content="3dzueafX404RxMNP8UgYjEcWgIDoeFBAeqNAKYnNcMo" /> <!-- 구글 사이트 소유권 확인  -->
    <meta name="naver-site-verification" content="aaee198d137d99ef28306248f9e40026f77041e7"/>   <!-- 네이버 사이트 소유권 확인 -->
	<meta name="Generator" content="Notepad++"/>	    
    <meta name="Author" content="김희승" />
    <meta property="og:type" content="website">
    <meta property="og:title" content="Soft Engineer Society">
    <meta property="og:image" content="http://www.softsociety.net/edu/apply/ckeditor/ses_main_image.png">
    
	<title>SoftEngineerSociety</title>
	<link rel="shortcut icon" href="<c:url value="/resources/segroup/main/img/favicon.ico" />" type="image/x-icon">
	<link rel="icon" href="<c:url value="/resources/segroup/main/img/favicon.ico" />" type="image/x-icon">
	<!-- 슬라이드css -->
	<link rel="stylesheet" href="<c:url value="/resources/segroup/main/css/slider.css" />" type="text/css" media="screen" />
	<link rel="stylesheet" href="<c:url value="/resources/segroup/main/css/flexslider.css" />" type="text/css" media="screen" />	
	<!-- 전체 css -->
	<link rel="stylesheet" href="<c:url value="/resources/segroup/main/css/reset.css" />"/>
    <link rel="stylesheet" href="<c:url value="/resources/segroup/main/css/style.css" />" />	
	<!-- 지도js -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
	<!-- 슬라이드js -->
	<script src="<c:url value="/resources/segroup/main/js/jquery.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/main/js/jquery-1.9.1.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/segroup/main/js/jquery-latest.js" />"></script>	
	<script>
		jQuery(document).ready(function(){
			$('.tabItem1').show(); 
			$('.tabItem2').hide(); 
			$('.button1').addClass('buttonEffect1');
			$('.button2').addClass('buttonEffect2');
			
			$('.button1').click(function(){
				$('.tabItem1').show(); 
				$('.tabItem2').hide(); 
				$('.button2').removeClass('buttonEffect1');
				$('.button2').addClass('buttonEffect2');				
				$('.button1').removeClass('buttonEffect2');				
				$('.button1').addClass('buttonEffect1');
			});
			$('.button2').click(function(){
				$('.tabItem2').show(); 
				$('.tabItem1').hide(); 
				$('.button1').removeClass('buttonEffect1');
				$('.button1').addClass('buttonEffect2');				
				$('.button2').removeClass('buttonEffect2');				
				$('.button2').addClass('buttonEffect1');
			});		
			$('.btn1').click(function(){
				var offset = $('.contentsBox1').offset();
				$('html').animate({scrollTop : offset.top}, 400);
			});		
			$('.btn2').click(function(){
				var offset = $('.contentsBox2').offset();
				$('html').animate({scrollTop : offset.top}, 400);
			});
			$('.btn3').click(function(){
				var offset = $('.contentsBox3').offset();
				$('html').animate({scrollTop : offset.top}, 400);
			});	
			 
			$('#kita2').click(function(){
				location.href='https://newtradecampus.kita.net/page/user_job_japan_school_apply?course_category=JOBS&course_code=3159&class_seq=1&site_id=KITAACAD&viewMode=detail#appView_courseDetailView';
			})
			 
		});
		
		function language_chage(language){
			if(language == 'ko') location.href="/main_lang_change?lo=ko";
			if(language == 'ja') location.href="/main_lang_change?lo=ja";
		}
		
		function goPa(){
			location.href="/fap/company/company_main";
		}
		
		function goSw(){
			location.href="/ictcenter";
		}
		
    </script>	
</head>
<body>
	<nav role="navigation">
	  <div id="menuToggle">
		<input type="checkbox" />
		<span></span>
		<span></span>
		<span></span>
		<ul id="menu">
			<li class="btn1" tabindex="6">Home</li>
			<li class="btn2" tabindex="5">About us</li>
			<li class="btn3" tabindex="4">History</li>
			<li><a onclick="language_chage('ja');" tabindex="1">Japan</a></li>
		</ul>
	  </div>
	  <img src="<c:url value="/resources/segroup/main/img/logo.png" />" alt=""/>
	</nav>
	<header>
		<ul class="gnb">
			<li class="fr"><a onclick="language_chage('ja');" tabindex="1"><img src="<c:url value="/resources/segroup/main/img/japan.png" />" alt="japanese"/></a></li>
			<li class="fr"><a onclick="language_chage('ko');" tabindex="2"><img src="<c:url value="/resources/segroup/main/img/korea.png" />" alt="korean"/></a></li>
		</ul><!-- <ul id="gnb"> -->
		<div class="logoLnb">
			<div class="logo fl" tabindex="3" onclick="location.href='/mainpage';">
				<h1>logo</h1>
			</div><!-- <div id="logo"> -->
			<ul class="lnb fl">
				<li class="btn3 fr" tabindex="4">History</li>
				<li class="btn2 fr" tabindex="5">About us</li>
				<li class="btn1 fr" tabindex="6">Home</li>				
			</ul><!-- <ul id="lnb"> -->
		</div>
	</header>
	<div class="container cf">
		<div id="main" role="main" tabindex="-1">
		  <section class="slider">
			<div class="flexslider">
			  <ul class="slides">
				  <li>
			         <img  src="<c:url value="/resources/segroup/main/img/1_2.png" />" alt="청춘 나의 Biz Career는 도쿄에서 출발한다~"/>
			         <div class="slide-txt slide-txt01"><spring:message code="ses.main.tx101" /><div>		
			      </li>
			      <%-- 
			      <li>
			         <img  id="kita2" src="<c:url value="/resources/segroup/main/img/main_banner_200513_01.jpg" />" style="cursor:pointer;" alt="KITA 일본 취업학교 2기"/>			        			      	  
			      </li>
			       --%>
			      <li>
			          <img src="<c:url value="/resources/segroup/main/img/main_banner_191028_02.png" />" alt="대한민국은 좁다. 나는 세계로 간다!"/>
				      <div class="slide-txt slide-txt02"><spring:message code="ses.main.tx102" /><div>
			      </li>
			      <%--
			      <li>
			         <img src="<c:url value="/resources/segroup/main/img/main_banner_191028_03.png" />" alt="어서와, 베트남은 처음이지?"/>
			         <div class="slide-txt slide-txt03"><spring:message code="ses.main.tx103" /><div>
			      </li>
			        --%>
			      			     
			  </ul>
			</div>
		  </section>
		</div>
	</div><!-- <div class="container cf"> -->
	<section>
			<div class="contentsBox1">
			<h2>
				<span>Soft Engineer Society</span>
				<spring:message code="ses.main.tx01.sub2" />
				<spring:message code="ses.main.tx01.sub1" />
				<spring:message code="ses.main.tx01.sub3" />
				<br>
				<spring:message code="ses.main.tx01.sub4" />
			</h2>
<%-- 			<h2><span><spring:message code="ses.main.tx01.sub1" /></span> · <span>Soft Engineer Society</span>&nbsp;<spring:message code="ses.main.tx01.sub2" /></h2> --%>
			<div class="noticeBox1">
				<h3><spring:message code="ses.main.tx02" /></h3>
				<h4><spring:message code="ses.main.tx03" /></h4>
				<div class="noticeText1">
					<h5><spring:message code="ses.main.tx04" /></h5>
					<p>
						<spring:message code="ses.main.tx05" /><br>
						<spring:message code="ses.main.tx06" />
					</p>
					</br>
					<h5><spring:message code="ses.main.tx07" /></h5>
					<p>
						<spring:message code="ses.main.tx08" /><br>
						<spring:message code="ses.main.tx09" /><br>
						<spring:message code="ses.main.tx10" />
					</p>
					</br>
					<h5><spring:message code="ses.main.tx11" /></h5>
					<p>
						<spring:message code="ses.main.tx12" /><br>
						<spring:message code="ses.main.tx13" /><br>
						<spring:message code="ses.main.tx14" />
					</p>
					</br>
				</div><!-- <div class="noticeText1"> -->
				<div class="buttonWrap">
					<button onclick="goPa()" tabindex="7">
						<spring:message code="ses.main.tx18" />
					</button>
				</div>
			</div><!-- <div class="noticeBox1"> -->
			<div class="noticeBox2">
				<h3><spring:message code="ses.main.tx90" /></h3>
				<h3><spring:message code="ses.main.tx91" /></h3>
				<h4><spring:message code="ses.main.tx92.sub01" /></h4>
				<div class="noticeText2">
					<p>
						<spring:message code="ses.main.tx92" />
					</p>
					<!-- <p>글로벌기업, 일본증시상장기업 등 중견기업 다수&lt;<a onclick="window.open('popup.html','_blank','width=480px,height=557px,top=200px,left=400px')">기업리스트보기</a>&gt;</p> -->
					<p>
						<spring:message code="ses.main.tx93" />
					</p>
					<%--  <p>
						<spring:message code="ses.main.tx94" />
					</p> --%>
					<p>
						<spring:message code="ses.main.tx95" />
					</p>
					<p>
						<spring:message code="ses.main.tx96" /> 
						<div class="textAlign">
							<spring:message code="ses.main.tx97" /></br>
							<spring:message code="ses.main.tx98" /></br>
							<spring:message code="ses.main.tx99" /></br>
							<spring:message code="ses.main.tx100" />
						</div><!-- <div class="textAlign"> -->
					</p>
				</div><!-- <div class="noticeText2"> -->
				<div class="buttonWrap">
					<button onclick="goSw()" tabindex="8">
						<spring:message code="ses.main.tx18" />	
					</button>
				</div>				
			</div><!-- <div class="noticeBox2"> -->
			<p><spring:message code="ses.main.tx28" /></p>
		</div><!-- <div class="contentsBox1"> -->

		<div class="contentsBox2">
			<div class="sectionHeaderwrap1">					
				<h2><span class="titleHead1"></span>ABOUT US</h2>
			</div>
			<div class="subTitleBox">
				<p>
					<spring:message code="ses.main.tx29" />
				</p>
			</div>
			<div class="introduceBoxes">
				<div class="introduceBox1">
					<br><span><spring:message code="ses.main.tx30" /></span>
					<ul>
						<li><spring:message code="ses.main.tx31" /></li>
						<li><spring:message code="ses.main.tx32" /></li>
						<br>
						<li><spring:message code="ses.main.tx33" /></li>
						<li><spring:message code="ses.main.tx34" /></li>
						<li><spring:message code="ses.main.tx35" /></li> 
						<br>
						<li><spring:message code="ses.main.tx36" /></li>
						<br><br>
					</ul>
					<span><spring:message code="ses.main.tx37" /></span>
						<ul>
							<li><spring:message code="ses.main.tx38" /></li>
							<li><spring:message code="ses.main.tx39" /></li>
							<li><spring:message code="ses.main.tx40" /></li>
							<li><spring:message code="ses.main.tx41" /></li>
							<br><br>
						</ul>
					<span><spring:message code="ses.main.tx42" /></span>	
					<ul>
<%-- 						<li><spring:message code="ses.main.tx43" /></li> --%>
<%-- 						<li><spring:message code="ses.main.tx44" /></li> --%>
<!-- 						<br> -->
						<li><spring:message code="ses.main.tx45" /></li>
						<li><spring:message code="ses.main.tx46" /></li>
						<br>
						<li><spring:message code="ses.main.tx47" /></li>
						<li><spring:message code="ses.main.tx48" /></li>
						<br>
						<li><spring:message code="ses.main.tx49" /></li>					
				   </ul>
<!-- 					<br><span>● 글로벌 융복합 S/W 인재양성 (Since 2001)</span> -->
<!-- 					<ul> -->
<!-- 						<li> - S/W 인재양성 컨소시엄 체결, 해외진출 S/W 인재양성과정 운영</li> -->
<!-- 						<li> · 총 2,658 명 교육 및 배출 (2020. 2월)</li> -->
<!-- 						<br> -->
<!-- 						<li>- 교육시설</li> -->
<!-- 						<li>· 서울 ICT 교육센터 : 서울시 강남구 삼성동 코엑스 4층 ICT 교육센터 (2,650㎡)</li> -->
<!-- 						<li>· 광주 ICT 교육센터 : 광주시 광산구 무진대로 282 ,광주무역회관 7층 (423㎡)</li>  -->
<!-- 						<br> -->
<!-- 						<li>- 온라인 교육시스템(e-Learning) 운영 및 콘텐츠 개발</li><br><br> -->
<!-- 					</ul> -->
<!-- 					<span>● 해외 진출희망 인재와 해외기업 매칭 서비스</span> -->
<!-- 						<ul> -->
<!-- 						<li>- O2O 채용지원시스템 구축운영 (www.bridge.career)</li> -->
<!-- 						<li>· 채용희망기업과 구직자 간의 매칭 알고리즘을 통해 높은 구인/구직 성공률 구현</li> -->
<!-- 						<li>· Bridge Job Fair 정례 개최 (년 2회, 6월/11월, Seoul&Tokyo)</li> -->
<!-- 						<li>· 미국과 신남방(동남아시아)지역으로 확대예정</li><br><br> -->
<!-- 						</ul> -->
<!-- 					<span>● 대외협력</span>	 -->
<!-- 						<ul> -->
<!-- 							<li>- 국내 유수 27 개 대학교와의 MOU</li> -->
<!-- 							<li>· 주요내용 : 교육생 모집홍보 및 연수과정에 대한 학점인정 등</li> -->
<!-- 							<br> -->
<!-- 							<li> - 지방자치단체와 MOU (광주시, 강남구, 용산구)</li> -->
<!-- 							<li>· 주요내용 : 해당지역 청년중심 교육과정 선발 및 교육비 지원</li> -->
<!-- 							<br> -->
<!-- 							<li> - 글로벌 기업과의 채용 네트워크</li> -->
<!-- 							<li>· IBM, SOFTBANK, RAKUTEN, LG 히타치, 신한은행-일본, Manpower 등 300여개사 <br><br>&nbsp;&nbsp;(일본, 미국, 베트남, 국내 등)</li> -->
<!-- 							<br> -->
<!-- 							<li> - 글로벌 브릿지 인재교류회 사무국 운영 (회원 : 510명) -일본, 한국, 기타지역 -</li>					 -->
<!-- 					   </ul> -->
				</div>
				<!-- 
				<div class="introduceBox2">
					<span><spring:message code="ses.main.tx39" /></span>
					<ul>
						<li><spring:message code="ses.main.tx40" /></li>
						<li><spring:message code="ses.main.tx41" /></li>
						<li><spring:message code="ses.main.tx42" /></li>
						<li><spring:message code="ses.main.tx43" /></li>
					</ul>					
				</div>
				<div class="introduceBox3">
					<span><spring:message code="ses.main.tx44" /></span>
					<ul>
						<li><spring:message code="ses.main.tx45" /></li>
						<li><spring:message code="ses.main.tx46" /></li>
						<li><spring:message code="ses.main.tx47" /></li>
					</ul>					
				</div>
				<div class="introduceBox4">
					<span><spring:message code="ses.main.tx48" /></span>
					<ul>
						<li><spring:message code="ses.main.tx49" /></li>
						<li><spring:message code="ses.main.tx50" /></li>
						<li><spring:message code="ses.main.tx51" /></li>
					</ul>					
				</div>
				<div class="introduceBox5">
					<span><spring:message code="ses.main.tx52" /></span>
					<ul>
						<li><spring:message code="ses.main.tx53" /></li>
						<li><spring:message code="ses.main.tx54" /></li>
					</ul>
					-->					
				</div>
			</div><!-- <div class="intoduceBoxes"> -->
		</div><!-- <div class="contentsBox2"> -->
		<div class="contentsBox3">
			<div class="sectionHeaderwrap2">
				<h2><span class="titleHead2"></span>HISTORY</h2>
			</div>
			<div class="historyBox1">
				<span>2001~2010</span>
				<ul>
					<li><spring:message code="ses.main.tx55" /></li>
					<li><spring:message code="ses.main.tx56" /></li>
					<li><spring:message code="ses.main.tx57" /></li>
					<li><spring:message code="ses.main.tx58" /></li>
					<li><spring:message code="ses.main.tx59" /></li>
					<li><spring:message code="ses.main.tx60" /></li>
					<li><spring:message code="ses.main.tx61" /></li>
					<li><spring:message code="ses.main.tx62" /></li>
					<li><spring:message code="ses.main.tx63.sub1" /></li>
					<li><spring:message code="ses.main.tx63.sub2" /></li>
				</ul>
			</div><!-- <div class="historyBox1"> -->
			<div class="historyBox2">
				<span>2011~</span>
				<ul>
					<li><spring:message code="ses.main.tx64" /></li>
					<li><spring:message code="ses.main.tx65" /></li>
					<li><spring:message code="ses.main.tx66" /></li>
					<li><spring:message code="ses.main.tx67" /></li>
					<li><spring:message code="ses.main.tx68" /></li>
					<li><spring:message code="ses.main.tx69" /></li>
					<li><spring:message code="ses.main.tx70" /></li>
					<li><spring:message code="ses.main.tx71" /></li>
					<li><spring:message code="ses.main.tx72" /></li>
					<li><spring:message code="ses.main.tx73" /></li>
					<li><spring:message code="ses.main.tx74" /></li>
					<li><spring:message code="ses.main.tx75" /></li>
					<li><spring:message code="ses.main.tx75.sub1" /></li>
					<li><spring:message code="ses.main.tx75.sub2" /></li>
					<li><spring:message code="ses.main.tx75.sub3" /></li>
					<li><spring:message code="ses.main.tx75.sub4" /></li>
					<li><spring:message code="ses.main.tx75.sub5" /></li>
					<li><spring:message code="ses.main.tx75.sub6" /></li>
				</ul>
			</div><!-- <div class="historyBox2"> -->
		</div><!-- <div class="contentsBox3"> -->
		<div class="contentsBox4">
			<div class="sectionHeaderwrap3">
				<h2><span class="titleHead3"></span>CONTACT US</h2>
			</div>
			<div class="mapboxWrap">
				<div class="buttons fl">
					<div class="button1 fl" tabindex="9"><span><spring:message code="ses.main.tx76" /></span></div>
					<div class="button2 fl" tabindex="10"><span><spring:message code="ses.main.tx77" /></span></div>
				</div><!-- <div class="buttons fl"> -->
				<div class="tabItem1">
					<div id="mapBox1">
						<div id="map1" style="width:800px;height:360px;"></div>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0a2be72636126326e38e6e491518d271"></script>
						<script>
							var mapContainer = document.getElementById('map1'), // 지도를 표시할 div 
								mapOption = { 
									center: new daum.maps.LatLng(37.512200, 127.060601), // 지도의 중심좌표
									level: 4 // 지도의 확대 레벨
								};
							<!-- 35.160904, 126.811235 광주좌표 -->
							var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
					
							// 마커가 표시될 위치입니다 
							var markerPosition  = new daum.maps.LatLng(37.512200, 127.060601); 
					
							// 마커를 생성합니다
							var marker = new daum.maps.Marker({
								position: markerPosition
							});
					
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
					
							// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
							// marker.setMap(null);    
						</script>				
						<div class="addressBox">
							<span><spring:message code="ses.main.tx78" /></span>
							<ul>
								<li><spring:message code="ses.main.tx79" /></li>
								<li><spring:message code="ses.main.tx80" /></li>
								<li><spring:message code="ses.main.tx81" /></li>
							</ul>
							<span><spring:message code="ses.main.tx82" /></span>
							<ul>
								<li>hello@softsociety.net</li>
								<li>02-2-6000-6260</li>
							</ul>					
						</div><!-- <div class="addressBox"> -->
					</div><!-- <div id="mapBox"> -->
				</div><!-- <div class="tabItem1"> -->
				<div class="tabItem2">
					<div id="mapBox2">
						<div id="map2" style="width:800px;height:360px;"></div>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0a2be72636126326e38e6e491518d271"></script>
						<script>
							var mapContainer = document.getElementById('map2'), // 지도를 표시할 div 
								mapOption = { 
									center: new daum.maps.LatLng(35.160904, 126.811235), // 지도의 중심좌표
									level: 4 // 지도의 확대 레벨
								};						
							var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
					
							// 마커가 표시될 위치입니다 
							var markerPosition  = new daum.maps.LatLng(35.160904, 126.811235); 
					
							// 마커를 생성합니다
							var marker = new daum.maps.Marker({
								position: markerPosition
							});
					
							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
					
							// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
							// marker.setMap(null);    
						</script>				
						<div class="addressBox">
							<span>주소</span>
							<ul>
								<li><spring:message code="ses.main.tx83" /></li>
								<li><spring:message code="ses.main.tx84" /></li>
								<li><spring:message code="ses.main.tx85" /></li>
							</ul>
							<span><spring:message code="ses.main.tx82" /></span>
							<ul>
								<li>hello@sesoc.global</li>
								<li>062-942-6260</li>
							</ul>					
						</div><!-- <div class="addressBox"> -->
					</div><!-- <div id="mapBox"> --> 
				</div><!-- <div class="tabItem2"> -->
			</div><!-- <div class="mapboxWrap">	 -->			
		</div><!-- <div class="contentsBox4"> -->
	</section>
	<footer>
		<div class="footerWrap">
			<div class="footerLogo fl">
				<img src="<c:url value="/resources/segroup/main/img/logo.png" />" alt=""/>
			</div><!-- <div class="footerLogo"> -->
			<div class="footerText fl">
				<ul>
					<li><spring:message code="ses.main.tx86" /></li>
					<li><spring:message code="ses.main.tx87" /></li>
					<li><spring:message code="ses.main.tx88" /></li>
					<li><spring:message code="ses.main.tx89" /></li>
				</ul>
			</div><!-- <div class="footerText"> -->
		</div><!-- <div class="footerWrap"> -->
	</footer>
  <script defer src="<c:url value="/resources/segroup/main/js/jquery.flexslider.js" />"></script>
  <script type="text/javascript">
    $(window).load(function(){
      $('.flexslider').flexslider({
        animation: "slide"
      });
    });
  </script>
  	
  	<!-- 운영에 적용할때는 주석을 제거해야 함 -->
  
    <!-- <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
	<script type="text/javascript">
		if(!wcs_add) var wcs_add = {};
		wcs_add["wa"] = "215b38fd85e58";
		wcs_do();
	</script> -->
</body>
</html>    
    
<%-- <html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-105593058-2"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	  gtag('config', 'UA-105593058-2');
	</script>
	<!-- 카카오광고 리타게팅 코드_삽입요청_180917 -->
	<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/adfit/static/kp.js"></script>
	<script type="text/javascript">
		kakaoPixel('4900075932325164644').pageView();
	</script>
    <title>Soft Engineer Society</title>
    <script src="./resources/segroup/script/jquery.min.js"></script>
    <link rel="stylesheet" href="./resources/segroup/script/bootstrap/css/bootstrap.css">
    <script src="./resources/segroup/script/script.js"></script>
    <link rel="stylesheet" href="./resources/segroup/css/style.css">
    <link rel="stylesheet" href="./resources/segroup/css/content-box.css">
    <link rel="stylesheet" href="./resources/segroup/css/image-box.css">
    <link rel="stylesheet" href="./resources/segroup/css/animations.css">
    <link rel="stylesheet" href='./resources/segroup/css/components.css'>
    <link rel="stylesheet" href='./resources/segroup/script/flexslider/flexslider.css'>
    <link rel="stylesheet" href='./resources/segroup/script/magnific-popup.css'>
    <link rel="stylesheet" href='./resources/segroup/script/php/contact-form.css'>
    <link rel="stylesheet" href='./resources/segroup/script/jquery.fullPage.css'>
    <link rel="icon" href="./resources/segroup/images/favicon.png">
    <link rel="stylesheet" href="./resources/segroup/css/skin.css">
    <!-- Extra optional content header -->
    <style>
     #pic1.active{
        -webkit-transition: opacity 1.0s ease-in;
       -moz-transition: opacity 1.0s ease-in;
         -o-transition: opacity 1.0s ease-in;
                                opacity: 1;
       
	}
	#pic1{
		opacity: 0;
	} 
	
	.page2div.active{
	 -webkit-transition: opacity 0.8s ease-in;
       -moz-transition: opacity 0.8s ease-in;
         -o-transition: opacity 0.8s ease-in;
                                opacity: 0.85;
	
	}
	.page2div.deactive{
	 -webkit-transition: opacity 0.8s ease-in;
       -moz-transition: opacity 0.8s ease-in;
         -o-transition: opacity 0.8s ease-in;
                                opacity: 0;
	
	}
	
	.page2div{
	
	opacity: 0;
	
	}
		
	#div1_1.active{
        
        -webkit-transition: opacity 0.5s ease-in;
       -moz-transition: opacity 0.5s ease-in;
         -o-transition: opacity 0.5s ease-in;
                                      opacity: 1;
	}
	#div1_1{
		opacity: 0;
	}
	#div1_2.active{
        
        -webkit-transition: opacity 1.0s ease-in;
       -moz-transition: opacity 1.0s ease-in;
         -o-transition: opacity 1.0s ease-in;
                                      opacity: 1;
	}
	#div1_2{
		opacity: 0;
	}
	#div1_3.active{
        
        -webkit-transition: opacity 1.5s ease-in;
       -moz-transition: opacity 1.5s ease-in;
         -o-transition: opacity 1.5s ease-in;
                                      opacity: 1;
	}
	#div1_3{
		opacity: 0;
	}
	
	.vl {
	position:absolute;
    border-left: 3px solid #424242;
    height: 45%;
    position: absolute;
    left: 50%;
    margin-left: -3px;
    top: 40%;
}

.vl2 {
    position:absolute;
    top: 270px;
    width:350px;
    left:51%;
    size:5px;
    height: 5px;
    color: #00a1e4;
    background-color:#00a1e4;
    border:none;
    
    -ms-transform-origin: 20% 40%;
     -webkit-transform-origin: 20% 40%; 
      transform-origin: 20% 40%; 
       transform: rotate(135deg);
}

@media (max-width: 1300px) and (min-width: 993px){
 #fullpage-main .container {
    width: 1026px;
 }
}
    </style>
   
    <script>
    
    $.lang = {};
	
	 $.lang.ko = {
		    0: '새로운 세상을 만들어가는 열정과 도전<br><font style="color:#3ac6ff;">Soft Engineer Society</font>가 함께 합니다.',
			1: '해외취업알선',
			2: '새로운 도전을 위한, 더 높은 성취를 위한 글로벌 커리어 활동을 지원합니다.',
			3: '글로벌엔지니어양성',
			4: '글로벌 비즈니스를 창출하고 수행할 ICT 전문인재를 선발 육성 합니다.',
			5: '스마트러닝',
			6: '무역협회 무역아카데미의 온라인교육 시스템을 위탁 운영하고 있습니다.',
			7: '시험센터',
			8: '글로벌 공인기관의 시험센터를 운영합니다.',
			9: 'Soft Engineer Society의 비전은 다양한 전공의 한국청년들을 21C ICT융복합인재로 양성하여 해외 유수의 기업에서 활동할 기회를 제공하고, 기업 및 산업계간의 글로벌 협력을 통하여 새로운 가치를 창출하는 네트워크를 확대해 가는 것입니다.',
			10: '●  ICT융복합 글로벌 인재양성',
			11: '&nbsp;- 과학기술정보통신부 지정 SW전문인력양성기관 <br>&nbsp;- 한국무역협회와 컨소시움을 체결, 해외진출 ICT인재양성과정 운영 (Since 2001)<br>&nbsp;&nbsp;• 2017.12월현재 총 2,134명 양성 배출 <br>&nbsp;- MOU 체결대학(학점인정 등) :   산기대, 전남대, 금강대, 국민대, 한신대, 경동대 등<br>&nbsp;&nbsp;&nbsp;&nbsp;16개 대학 <br> ',
			12: '●  ICT인재의 해외기업 매칭',
			13: ' &nbsp;- O2O 채용지원시스템 구축운영  <br>&nbsp;&nbsp;• 해외기업의 채용수요 포스팅 (년2회, 4월&9월, www.sesoc.global)  <br>&nbsp;&nbsp;• 사전전형 지원 : 서류전형, 적성검사, 필기시험, 화상면접 (온라인 & 오프라인)  <br>&nbsp;&nbsp;• Tokyo Job Fair 개최 (년2회, 6월&11월) : 사전전형 통과자 최종면접행사  <br>&nbsp;- 일본 ICT기업에 채용 알선한 한국청년 1,510명 (2017 현재)   <br>&nbsp;&nbsp;• 한국정부(고용노동부) 지정 해외취업우수기관 (2010 & 2015)   <br>&nbsp;&nbsp;• 언론 보도 : NHK World - News Room Tokyo (2016.5.31) <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TV Tokyo - World Business Satellite (2016.10.27)<br>',
			14: '●  스마트러닝',
			15: '- 무역협회 무역아카데미 온라인 교육 시스템 운영 <br>- 글로벌 비즈니스 전략, 외국어, 국제무역사 등 300여 컨텐츠<br> ',
			16: '●  글로벌 협력',
			17: '&nbsp;- 在日 ICT인재교류회 사무국 운영 <br> &nbsp;- 공인시험센터 운영 : 토플, 오픽 <br>&nbsp;- 오프쇼어 시스템인티그레이션 (Off-Shore SI)',
			18: '●  사업등록·면허',
			19: ' &nbsp;- 평생교육시설(지식·인력개발 & 원격), 해외취업알선, 직업소개사업, 소프트웨어사업',
			20: '<br>2017.11 제4회 도쿄 Job Fair 개최 (Tokyo TKP 市ヶ谷, 11.20~24) <br>2017.06 제3회 도쿄 Job Fair 개최 (Tokyo 神楽坂HC 스튜디오, 6.19~23) <br>2017.02 오라클 University 공인교육센터&lt;OAEC&gt;지정 및  Reseller 파트너쉽 체결<br>2016.11 제2회 도쿄 Job Fair 개최 (Tokyo TKP 永町田, 11.21~25)<br>2016.06 제1회 도쿄 Job Fair 개최 (Tokyo Haneda Turtle Service,  6.20~24) <br>2015.12 국가경쟁력기여(해외진출지원) 고용노동부 장관 표창 <br>2015.08 과학기술정보통신부(舊미래창조과학부) SW전문인력양성기관 지정<br>2013.04 Opic공인시험센터 지정<br>2013.01 무역협회 K-Move 스쿨 운영 컨소시움 체결 <br>2011.01 무역협회 ICT교육센터•스마트러닝센터 운영기관지정 ',
			21: '<br>2008.11 무역진흥기여(글로벌인재양성) 국무총리 표창<br>2008.10 Prometric Loyal Partner Award 수상 <br>2007.08 ETS/Prometric 공인 토플시험센터 지정<br>2005.03 Sun Educational Service Partnership 체결 <br>2005.11 해외인력양성특수유공 산업자원부장관 표창 <br>2003.07 美 카네기멜론대(CMU) 석사과정 사전교육프로그램 설계 운영 <br>2002.09 프로메트릭(Prometric) 공인시험센터 지정 <br>2002.06 오라클 University 공인교육센터&lt;WDP> 지정 <br>2001.12 창업 (법인명변경 (주)에프앤텍 -> (주)Soft Engineer School/‘16.3월, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;법인합병 (주)Soft Engineer Society로 기업합병/‘17.12월)<br>',
			22: '주소',		
			23: ' 06164 서울특별시<br/>강남구 영동대로 513<br/>(삼성동, 코엑스4층)',
			24: '연락처',
			25: '해외취업알선',
			26: '글로벌엔지니어양성',
			27: '스마트러닝',
			28: '시험센터',
			29: '바로가기'
	};
			
	$.lang.ja = {
			0: '新しい世界を作っていく情熱と挑戦<br><font style="color:#3ac6ff;">Soft Engineer Society</font>が応援します。',
			1: '海外就職サポート',
			2: '新しい挑戦とその達成のためのグローバルキャリア活動をサポートします',
			3: '海外就職人材養成課程',
			4: 'グローバルビジネスを創り出し、実現するICT専門人材を選抜･育成します。',
			5: 'スマートラーニング',
			6: '資格試験、業務、外国語などのオンラインコースを運営します。',
			7: '試験センター',
			8: 'グローバル認証機関の試験センターを運営します。',
			9: 'Soft Engineer Societyのビジョンは、様々な専攻の韓国青年を21世紀のICT融合人材として育成し、世界有数の企業に進出する機会を提供しながら、企業や産業界のグローバルな協力を通して、新しい価値を創出するネットワークを拡大していくことです。',
			10: '●  ICT融合グローバル人材養成',
			11: '&nbsp;- 科学技術情報通信部指定のSW専門人材の養成機関 <br>&nbsp;- 韓国貿易協会とコンソーシアムを締結し、 海外進出のICT人材養成課程を運営 (Since 2001)<br>&nbsp;&nbsp;・ 2017.12月現在、合計2,134名を養成輩出 <br>&nbsp;- MOU締結大学（単位認定制度等）：   産技大、全南大、金剛大、国民大、韓信大、京東大など16校 <br> ',
			12: '●  ICT人材の海外企業とのマッチング',
			13: ' &nbsp;- O2O採用支援システムの構築運用<br>&nbsp;&nbsp;・海外企業の採用ニーズの集約とポスティング(年2回、4月と9月、www.sesoc.global)  <br>&nbsp;&nbsp;・ 事前選考実施のサポート：書類選考、適性検査、筆記試験、画像面接 （オンライン＆オフライン）  <br>&nbsp;&nbsp;・ Tokyo Job Fair定例開催（年2回、6月と11月）： 事前選考通過者の最終面接  <br>&nbsp;- 日本のICT企業に採用斡旋した韓国青年1,510人（2017年現在）  <br>&nbsp;&nbsp;・韓国政府（雇用労働部）指定海外就職優秀機関(2010年と2015年)   <br>&nbsp;&nbsp;・ メディアの報道：NHK World – News Room Tokyo(2016.5.31) <br>&nbsp;TV Tokyo – World Business Satellite(2016.10.27)<br>',
			14: '●  スマートラーニングサービス',
			15: '- 韓国貿易アカデミーオンライン教育のシステム運用 <br>- グローバルビジネス戦略、外国語、国際貿易士など300以上のコンテンツ管理<br> ',
			16: '●  グローバル協力',
			17: '&nbsp;- 在日ICT人材交流会事務局の運営<br> &nbsp;- 公認試験センターの運営：TOEFL, Opic<br>&nbsp;- オフショアシステムインテグレーション（Off-Shore SI）',
			18: '●  事業登録・免許',
			19: ' &nbsp;- 生涯教育施設（知識・人材開発・リモート）、海外就職斡旋、職業紹介事業、ソフトウェア事業',
			20: '<br>2017.11　第4回　東京JOBFair 開催（東京 TKP市ヶ谷,11.20-24） <br>2017.06　第3回　東京JOBFair 開催（東京 神楽坂HCスタジオ,6.19-23） <br>2017.02　ORACLE University 公認教育センター&lt;OAEC&gt;指定及びResellerパートナーシップ締結<br>2016.11  第2回　東京JOBFair 開催（東京 TKP永田町,11.25-25）<br>2016.06  第1回　東京JOBFair 開催（東京 羽田Turtle Service,6.20-24） <br>2015.12  国家競争力寄与(海外進出支援)雇用労働部 長官賞 表彰<br>2015.08  科学技術情報通信部（旧 未来創造科学部）SW専門人力機関 指定<br>2013.04  Opic公認試験センター 指定<br>2013.01  貿易協会K-MOVEスクール運営コンソーシアム 締結<br>2011.01  貿易協会ICT教育センター・スマートラーニングセンター運営機関 指定 ',
			21: '<br>2008.11 貿易振興寄与（グローバル人材養成）国務総理 表彰<br>2008.10 Prometric Loyal Partner Award 受賞<br>2007.08 ETS/Prometric 公認 TOEFL試験センター 指定<br>2005.03 Sun Educational Service Partnership 締結<br>2005.11 海外人力養成特殊有功 産業支援部 長官賞 表彰 <br>2003.07 米 カーネギーメロン大学（CMU）修士課程 事前教育プログラム設計 運営<br>2002.09 Prometric 公認試験センター指定<br>2002.06 ORACLE University 公認教育センター&lt;WDP＞ 指定<br>2001.12 創立（法人名変更（株）F&TECH→（株）Soft Engineer School/2016.3月, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;法人合弁（株）Soft Engineer Societyとして企業合弁/2017.12月<br>',
			22: 'アドレス',		
			23: '06164ソウル特別市<br/> 江南区永東大路で513 <br/>（三成洞、コエックス4階）',
			24: '電話番号',
			25: '海外就職斡旋',
			26: 'グローバルエンジニア育成',
			27: 'スマートランニング',
			28: '試験センター',
			29: 'ショートカット'
	}; 
	
	$.langm = {};
	
	 $.langm.ko = {
		    0: '새로운 세상을 만들어가는<br> 열정과 도전<br><font style="color:#3ac6ff;">Soft Engineer Society</font>가 함께 합니다.',
			1: '해외취업알선',
			2: '새로운 도전을 위한, 더 높은 성취를 위한 글로벌 커리어 활동을 지원합니다.',
			3: '글로벌엔지니어양성',
			4: '글로벌 비즈니스를 창출하고 수행할 ICT 전문인재를 선발 육성 합니다.',
			5: '스마트러닝',
			6: '무역협회 무역아카데미의 온라인교육 시스템을 위탁 운영하고 있습니다.',
			7: '시험센터',
			8: '글로벌 공인기관의 시험센터를 운영합니다.',
			9: 'Soft Engineer Society의 비전은 다양한 전공의 한국청년들을 21C ICT융복합인재로 양성하여 해외 유수의 기업에서 활동할 기회를 제공하고, 기업 및 산업계간의 글로벌 협력을 통하여 새로운 가치를 창출하는 네트워크를 확대해 가는 것입니다.',
			10: '●  ICT융복합 글로벌 인재양성',
			11: '- 과학기술정보통신부 지정 SW전문인력양성기관 <br>- 한국무역협회와 컨소시움을 체결, 해외진출 ICT인재양성과정 운영 (Since 2001)<br>• 2017.12월현재 총 2,134명 양성 배출 <br>- MOU 체결대학(학점인정 등) :   산기대, 전남대, 금강대, 국민대, 한신대, 경동대 등 16개 대학 <br> ',
			12: '●  ICT인재의 해외기업 매칭',
			13: '- O2O 채용지원시스템 구축운영 <br>&nbsp;• 해외기업의 채용수요 포스팅 (년2회, 4월&9월, www.sesoc.global) <br>&nbsp;• 사전전형 지원 : 서류전형, 적성검사, 필기시험, 화상면접 (온라인 & 오프라인) <br>&nbsp;• Tokyo Job Fair 개최 (년2회, 6월&11월) : 사전전형 통과자 최종면접행사 <br>- 일본 ICT기업에 채용 알선한 한국청년 1,510명 (2017 현재) <br>&nbsp;• 한국정부(고용노동부) 지정 해외취업우수기관 (2010 & 2015) <br>&nbsp;• 언론 보도 : NHK World - News Room Tokyo (2016.5.31) <br>TV Tokyo - World Business Satellite (2016.10.27)',
			14: '●  스마트러닝',
			15: '- 무역협회 무역아카데미 온라인 교육 시스템 운영 <br>- 글로벌 비즈니스 전략, 외국어, 국제무역사 등 300여 컨텐츠<br> ',
			16: '●  글로벌 협력',
			17: '- 在日 ICT인재교류회 사무국 운영 <br>- 공인시험센터 운영 : 토플, 오픽 <br>- 오프쇼어 시스템인티그레이션 (Off-Shore SI)',
			18: '●  사업등록·면허',
			19: '- 평생교육시설(지식·인력개발 & 원격), 해외취업알선, 직업소개사업, 소프트웨어사업',
			20: '2017.11 제4회 도쿄 Job Fair 개최 (Tokyo TKP 市ヶ谷, 11.20~24) <br>2017.06 제3회 도쿄 Job Fair 개최 (Tokyo 神楽坂HC 스튜디오, 6.19~23) <br>2017.02 오라클 University 공인교육센터&lt;OAEC&gt;지정 및  Reseller 파트너쉽 체결<br>2016.11 제2회 도쿄 Job Fair 개최 (Tokyo TKP 永町田, 11.21~25)<br>2016.06 제1회 도쿄 Job Fair 개최 (Tokyo Haneda Turtle Service,  6.20~24) <br>2015.12 국가경쟁력기여(해외진출지원) 고용노동부 장관 표창 <br>2015.08 과학기술정보통신부(舊미래창조과학부) SW전문인력양성기관 지정<br>2013.04 Opic공인시험센터 지정<br>2013.01 무역협회 K-Move 스쿨 운영 컨소시움 체결 <br>2011.01 무역협회 ICT교육센터•스마트러닝센터 운영기관지정 ',
			21: '2008.11 무역진흥기여(글로벌인재양성) 국무총리 표창<br>2008.10 Prometric Loyal Partner Award 수상 <br>2007.08 ETS/Prometric 공인 토플시험센터 지정<br>2005.03 Sun Educational Service Partnership 체결 <br>2005.11 해외인력양성특수유공 산업자원부장관 표창 <br>2003.07 美 카네기멜론대(CMU) 석사과정 사전교육프로그램 설계 운영 <br>2002.09 프로메트릭(Prometric) 공인시험센터 지정 <br>2002.06 오라클 University 공인교육센터&lt;WDP> 지정 <br>2001.12 창업 (법인명변경 (주)에프앤텍 -> (주)Soft Engineer School/‘16.3월, <br>법인합병 (주)Soft Engineer Society로 기업합병/‘17.12월)<br>',
			22: '주소',		
			23: ' 06164 서울특별시<br/>강남구 영동대로 513<br/>(삼성동, 코엑스4층)',
			24: '연락처',
			25: '해외취업알선',
			26: '글로벌엔지니어양성',
			27: '스마트러닝',
			28: '시험센터',
			29: '바로가기'
	};
			
	$.langm.ja = {
			0: '新しい世界を作っていく情熱と挑戦<br><font style="color:#3ac6ff;">Soft Engineer Society</font>が応援します。',
			1: '海外就職サポート',
			2: '新しい挑戦とその達成のためのグローバルキャリア活動をサポートします',
			3: 'グローバルエンジニア育成',
			4: 'グローバルビジネスを創り出し、実現するICT専門人材を選抜･育成します。',
			5: 'スマートラーニング',
			6: '資格試験、業務、外国語などのオンラインコースを運営します。',
			7: '試験センター',
			8: 'グローバル認証機関の試験センターを運営します。',
			9: 'Soft Engineer Societyのビジョンは、様々な専攻の韓国青年を21世紀のICT融合人材として育成し、世界有数の企業に進出する機会を提供しながら、企業や産業界のグローバルな協力を通して、新しい価値を創出するネットワークを拡大していくことです。',
			10: '●  ICT融合グローバル人材養成',
			11: '- 科学技術情報通信部指定のSW専門人材の養成機関 <br>- 韓国貿易協会とコンソーシアムを締結し、 海外進出のICT人材養成課程を運営 (Since 2001)<br>・ 2017.12月現在、合計2,134名を養成輩出 <br>- MOU締結大学（単位認定制度等）：   産技大、全南大、金剛大、国民大、韓信大、京東大など16校 <br> ',
			12: '●  ICT人材の海外企業とのマッチング',
			13: '- O2O採用支援システムの構築運用<br>&nbsp;・海外企業の採用ニーズの集約とポスティング(年2回、4月と9月、www.sesoc.global)  <br>&nbsp;・ 事前選考実施のサポート：書類選考、適性検査、筆記試験、画像面接 （オンライン＆オフライン）  <br>&nbsp;・ Tokyo Job Fair定例開催（年2回、6月と11月）： 事前選考通過者の最終面接  <br>- 日本のICT企業に採用斡旋した韓国青年1,510人（2017年現在）  <br>&nbsp;・韓国政府（雇用労働部）指定海外就職優秀機関(2010年と2015年)   <br>&nbsp;・ メディアの報道：NHK World – News Room Tokyo(2016.5.31) <br>TV Tokyo – World Business Satellite(2016.10.27)',
			14: '●  スマートラーニングサービス',
			15: '- 韓国貿易アカデミーオンライン教育のシステム運用 <br>- グローバルビジネス戦略、外国語、国際貿易士など300以上のコンテンツ管理<br> ',
			16: '●  グローバル協力',
			17: '- 在日ICT人材交流会事務局の運営<br> - 公認試験センターの運営：TOEFL, Opic<br>- オフショアシステムインテグレーション（Off-Shore SI）',
			18: '●  事業登録・免許',
			19: '- 生涯教育施設（知識・人材開発・リモート）、海外就職斡旋、職業紹介事業、ソフトウェア事業',
			20: '2017.11　第4回　東京JOBFair 開催（東京 TKP市ヶ谷,11.20-24） <br>2017.06　第3回　東京JOBFair 開催（東京 神楽坂HCスタジオ,6.19-23） <br>2017.02　ORACLE University 公認教育センター&lt;OAEC&gt;指定及びResellerパートナーシップ締結<br>2016.11  第2回　東京JOBFair 開催（東京 TKP永田町,11.25-25）<br>2016.06  第1回　東京JOBFair 開催（東京 羽田Turtle Service,6.20-24） <br>2015.12  国家競争力寄与(海外進出支援)雇用労働部 長官賞 表彰<br>2015.08  科学技術情報通信部（旧 未来創造科学部）SW専門人力機関 指定<br>2013.04  Opic公認試験センター 指定<br>2013.01  貿易協会K-MOVEスクール運営コンソーシアム 締結<br>2011.01  貿易協会ICT教育センター・スマートラーニングセンター運営機関 指定 ',
			21: '2008.11 貿易振興寄与（グローバル人材養成）国務総理 表彰<br>2008.10 Prometric Loyal Partner Award 受賞<br>2007.08 ETS/Prometric 公認 TOEFL試験センター 指定<br>2005.03 Sun Educational Service Partnership 締結<br>2005.11 海外人力養成特殊有功 産業支援部 長官賞 表彰 <br>2003.07 米 カーネギーメロン大学（CMU）修士課程 事前教育プログラム設計 運営<br>2002.09 Prometric 公認試験センター指定<br>2002.06 ORACLE University 公認教育センター&lt;WDP＞ 指定<br>2001.12 創立（法人名変更（株）F&TECH→（株）Soft Engineer School/2016.3月, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;法人合弁（株）Soft Engineer Societyとして企業合弁/2017.12月<br>',
			22: 'アドレス',		
			23: '06164ソウル特別市<br/> 江南区永東大路で513 <br/>（三成洞、コエックス4階）',
			24: '電話番号',
			25: '海外就職斡旋',
			26: 'グローバルエンジニア育成',
			27: 'スマートランニング',
			28: '試験センター',
			29: 'ショートカット'
	}; 
    
    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for(var i = 0; i <ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
    
     function detectmob() { 
    	 
    	 
         var language = getCookie("lang");
         var lang;
    	 
    	if(language=="ko"){
    		lang='ko';
      		  setLanguage("ko"); 
      		 $('#nationFlag').html('<img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR<span class="caret"></span>');
      		
    	}else if(language=="jp"){
    		   lang='ja';
      		  setLanguage("ja"); 
      		  $('#nationFlag').html('<img src="./resources/segroup/images/jp.png" alt="" style="height:15px;"/>JPN<span class="caret"></span>');
      		$('#pageZero').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageOne').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageTwo').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageThree').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageFour').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
    	}else if(language=="kom"){	
    		lang='ko';
    		setLanguagem("ko"); 
 		 	$('#nationFlagm').html('<img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR<span class="caret"></span>');
 		 	
   	 	}else if(language=="jpm"){
   	 		lang='ja';
   	 		setLanguagem("ja"); 
 		 	$('#nationFlagm').html('<img src="./resources/segroup/images/jp.png" alt="" style="height:15px;"/>JPN<span class="caret"></span>');
 		 	$('#pageZero').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageOne').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageTwo').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageThree').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageFour').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
	 	}
    	 
    	 
    	 if( navigator.userAgent.match(/Android/i)
    	 || navigator.userAgent.match(/webOS/i)
    	 || navigator.userAgent.match(/iPhone/i)
    	 || navigator.userAgent.match(/iPad/i)
    	 || navigator.userAgent.match(/iPod/i)
    	 || navigator.userAgent.match(/BlackBerry/i)
    	 || navigator.userAgent.match(/Windows Phone/i)
    	 ){
    		 $("#forMo").css("display","block");
    	  }
    	 else {
    		 $("#forPc").css("display","block");
    	  }
    	 
    	 
    	 $('#jpb').click(function() {
    		 
   		  var lang = $(this).data('lang');
   		  setLanguage(lang); 
   		  $('#nationFlag').html('<img src="./resources/segroup/images/jp.png" alt="" style="height:15px;"/>JPN<span class="caret"></span>');
   		  var d = new Date();
   	      d.setTime(d.getTime() + (1 * 24 * 60 * 60 * 1000));
   	      var expires = "expires="+d.toUTCString();
   	      document.cookie = "lang=jp;" + expires + ";path=/";
   	   	  var lang = 'ja',
          oldScript = document.getElementById("google-maps-script");
          oldScript.parentNode.removeChild(oldScript);

          delete google.maps;
   
          loadScript(lang);
            $('#pageZero').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageOne').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageTwo').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageThree').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
     		$('#pageFour').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
   		});
   	
   		$('#krb').click(function() {
   		  var lang = $(this).data('lang');
   		  setLanguage(lang); 
   		 $('#nationFlag').html('<img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR<span class="caret"></span>');
   		  var d = new Date();
 	      d.setTime(d.getTime() + (1 * 24 * 60 * 60 * 1000));
 	      var expires = "expires="+d.toUTCString();
 	      document.cookie = "lang=ko;" + expires + ";path=/";
 	      
 	     var lang = 'ko',
         oldScript = document.getElementById("google-maps-script");
         oldScript.parentNode.removeChild(oldScript);

         delete google.maps;
  
         loadScript(lang);
         $('#pageZero').css("font-family", "Open Sans, sans-serif");
   		$('#pageOne').css("font-family", "Open Sans, sans-serif");
   		$('#pageTwo').css("font-family","Open Sans, sans-serif");
   		$('#pageThree').css("font-family", "Open Sans, sans-serif");
   		$('#pageFour').css("font-family", "Open Sans, sans-serif");
   		});
   		
   	 	$('#jpbm').click(function() {
  		  var lang = $(this).data('lang');
  		  setLanguagem(lang); 
  		 $('#nationFlagm').html('<img src="./resources/segroup/images/jp.png" alt="" style="height:15px;"/>JPN<span class="caret"></span>');
  		  var d = new Date();
	      d.setTime(d.getTime() + (1 * 24 * 60 * 60 * 1000));
	      var expires = "expires="+d.toUTCString();
	      document.cookie = "lang=jpm;" + expires + ";path=/";
	    $('#pageZero').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
   		$('#pageOne').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
   		$('#pageTwo').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
   		$('#pageThree').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
   		$('#pageFour').css("font-family", "ヒラギノ角ゴ Pro W3, Hiragino Kaku Gothic Pro,Osaka, メイリオ, Meiryo, ＭＳ Ｐゴシック, MS PGothic, sans-serif");
  		});
  	
  		$('#krbm').click(function() {
  		  var lang = $(this).data('lang');
  		  setLanguagem(lang); 
  		 $('#nationFlagm').html('<img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR<span class="caret"></span>');
  		 var d = new Date();
	      d.setTime(d.getTime() + (1 * 24 * 60 * 60 * 1000));
	      var expires = "expires="+d.toUTCString();
	      document.cookie = "lang=kom;" + expires + ";path=/";
	         $('#pageZero').css("font-family", "Open Sans, sans-serif");
	    		$('#pageOne').css("font-family", "Open Sans, sans-serif");
	    		$('#pageTwo').css("font-family","Open Sans, sans-serif");
	    		$('#pageThree').css("font-family", "Open Sans, sans-serif");
	    		$('#pageFour').css("font-family", "Open Sans, sans-serif");
  		});
   		
  		loadScript();
  	        
  		
    	}
    
    $(window).scroll(function() {
        var height = $(window).scrollTop();
 
        if(height  > 180) {
        	$('.page2div').removeClass('deactive').addClass('active');
        }else{
        	$('.page2div').removeClass('active').addClass('deactive');
        }
    });
    
    function goSec1(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0
        }, 500);
     
    }
	function goSec2(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0.30
        }, 500);
     
    }
	function goSec3(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0.54
        }, 500);
    }
	
    function goSec4(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0.12
        }, 500);
    }
	
	
	function goSec1m(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0
        }, 500);
     
    }
	function goSec2m(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0.26
        }, 500);
     
    }
	function goSec3m(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0.61
        }, 500);
    }
	function goSec4m(){
    	
    	$("body").animate({
        	scrollTop:  $(document).height()*0.12
        }, 500);
    }
	
		
	function setLanguage(currentLanguage) {
		  console.log('setLanguage', arguments);
		  
		  $('[data-langNum]').each(function() {
		    var $this = $(this); 
		    $this.html($.lang[currentLanguage][$this.data('langnum')]); 
		  });	
		  
		 
	} 
	
		
	function setLanguagem(currentLanguage) {
		  console.log('setLanguage', arguments);
		  
		  $('[data-langNum]').each(function() {
		    var $this = $(this); 
		    $this.html($.langm[currentLanguage][$this.data('langnum')]); 
		  });	
		  
		 
	} 
	
	function initialize() {
        var mapOptions = {
            zoom:  16,
            center: new google.maps.LatLng(37.511683,127.059108)
        };
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(37.511683,127.059108),
            title:"Soft Engineer Society",
            	icon: {
                    path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
                    strokeColor: "#3ac6ff",
                    scale: 9
                }
        });

        var map = new google.maps.Map(document.getElementById('map-canvas'),
            mapOptions);
        
        marker.setMap(map);
    }

    
   function loadScript(lang){
	  var script = document.createElement('script');
      script.type = 'text/javascript';
      script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAuhhck0_kIRY_cYrR3gHqr4mMZutvuQG0&v=3.exp&sensor=false&' +
          'callback=initialize';
      if (lang) {
          script.src += '&language=' + lang;
      }
      
      script.id = "google-maps-script";
      document.body.appendChild(script);
   }
	
    </script>
</head>
<body onload="detectmob()">
        <script src='./resources/segroup/script/jquery.fullPage.min.js'></script>
        <script src='./resources/segroup/script/social.stream.min.js'></script> 
<div id="forPc" style="display:none;">
    <div id="preloader"></div>
    <header class="fixed-top bg-transparent menu-transparent" data-menu-anima="fade-in">
        <div class="navbar navbar-default mega-menu-fullwidth navbar-fixed-top" role="navigation">
            <div class="navbar navbar-main"style="padding-top:0px; height:87px; background: #636363 !important;">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a style="width:500px; margin-left:-15%;" class="navbar-brand" href="http://www.sesoc.global/"><img id="logoImage" style="width:240px;" src="./resources/segroup/images/classic/logo_w.png" alt="logo" /></a>
                    </div>
                    <div class="collapse navbar-collapse">
                        <div class="nav navbar-nav navbar-right">
                            <ul class="nav navbar-nav">
                                <li class="active" >
                                    <a onclick="goSec1()"  style="color:white;">Home</a>
                                </li>
                                <li class="active" >
                                    <a onclick="goSec2()"  style="color:white;">About us</a>
                                </li>
                                <li class="dropdown">
                                    <!-- <a href="#">Bussiness</a> -->
                                    <a  class="dropdown-toggle" onclick="goSec4()"  style="color:white;">Business<span class="caret"></span></a>
                                    <!-- <ul class="dropdown-menu">
                                        <li><a href="http://job.sesoc.global/society/index" class="sub" data-langNum="25">해외취업알선</a></li>
                                    	<li><a href="http://ict.sesoc.global/edu/apply/kmove" class="sub" data-langNum="26">글로벌엔지니어양성</a></li>
                                        <li><a href="http://cyber.tradecampus.com/" class="sub" data-langNum="27">스마트러닝</a></li>
                                    	<li><a href="https://www.softsociety.net/main" class="sub" data-langNum="28">시험센터</a></li>
                                    </ul> -->
                                </li>
                            
                                <li class="active">
                                    <a onclick="goSec3()"  style="color:white;">History</a>
                                </li>
                                <li class="active">
                                </li>
                            </ul>
                            <ul class="nav navbar-nav lan-menu">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" role="button"  style="color:white;"  id="nationFlag"><img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR<span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                    
                                        <li><a id="krb" data-lang="ko" style="color:white;"><img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR</a></li>
                                    
                                        <li style=" padding-top:7px;"><a id="jpb" data-lang="ja" style="color:white;"><img src="./resources/segroup/images/jp.png" alt="" style="height:15px;"/>JPN</a></li>
                                    
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <nav class="fullpage-varrow varrow-circle right">
        <div class="arrow down"><span>GO DOWN</span><i class="fa fa-angle-down"></i></div>
    </nav>
   <!--  <nav id="fullpage-menu" class="fullpage-menu menu-dots">
        <ul>
            <li>
                <a data-toggle="tooltip" data-placement="left" title="Welcome"></a>
            </li>
            <li>
                <a data-toggle="tooltip" data-placement="left" title="Preview"></a>
            </li>
            <li>
                <a data-toggle="tooltip" data-placement="left" title="Specifications"></a>
            </li>
            <li>
                <a data-toggle="tooltip" data-placement="left" title="Contacts"></a>
            </li>
        </ul>
    </nav> -->
    <div id="fullpage-main" data-options="verticalCentered:false" data-offset="-30">
        <div class="section overlay-container" style="  background-image:url('./resources/segroup/images/classic/bbg6.png');   background-color:white; height:990px;">
            <div class="container" style="margin-top:40px; width:100%; height:88%;">
                  <!--<div class="row">
                
                    <div class="col-md-12 col-sm-12" style="padding:0px;">
                        <div class="flexslider slider nav-inner visible-dir-nav" data-options="controlNav:false,directionNav:true,animation:fade" style="height:70%;">
                            <ul class="slides">
                              
                                <li  style="height:100%; margin:auto;">
                                    <a class="img-box thumbnail lightbox" href="./resources/images/classic/image-3.jpg" data-lightbox-anima="fade-right" style="padding:0px; height:100%;">
                                        <span>
                                            <img src="./resources/images/classic/image-3.jpg" alt="" style="width:100%;">
                                        </span>
                                    </a>
                                </li>
                               
                            </ul>
                        </div>
                    
                 
                    </div> 
                
                
                  </div>-->
                 <div id="pageZero" class="row" style="height:85% ;">
                 <div class="col-md-6">
                  </div>
                  <div class="col-md-6" style="margin-top:8%;">
                  <h1 id='mainTitle' style="font-weight:800; color:white; line-height: 1.6em;" data-langNum="0">새로운 세상을 만들어가는 열정과 도전<br>
                  <font style="color:#3ac6ff;">Soft Engineer Society</font>가 함께 합니다.</h1>
                  </div>
                 </div>
                 <div class="row">
                    <!-- <div class="col-md-2"  style="width: 16.66666667%;padding:0px; z-index: 1;-webkit-clip-path: polygon(0 0, 100% 9%, 100% 100%, 0% 100%);
								clip-path: polygon(0 0, 100% 9%, 100% 100%, 0% 100%);">
                       <div class="advs-box-top-icon boxed-inverse"  style="padding:0px !important; z-index: -1; opacity:0.85;background-size:100% 100%;">
                            <div style=" width:100%;height:37%; background-color:#1c5a87; opacity:0.85; z-index: -2; padding: 50px 30px !important;">
                            
                            </div>
                        </div> 
                    </div>
                    
                    <div class="col-md-2"  style="width: 16.66666667%;padding:0px;  z-index: 1;-webkit-clip-path: polygon(0 9%, 100% 18%, 100% 100%, 0% 100%);
								clip-path: polygon(0 9%, 100% 18%, 100% 100%, 0% 100%);">
                       <div class="advs-box-top-icon boxed-inverse"  style="padding:0px !important; z-index: -1; opacity:0.85;background-size:100% 100%;">
                            <div style=" width:100%;height:37%;background-color:#f0783e; opacity:0.85; z-index: -2; padding: 50px 30px !important;">
                            
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-2"  style="width: 16.66666667%;padding:0px;  z-index: 1;-webkit-clip-path: polygon(0 18%, 100% 27%, 100% 100%, 0% 100%);
								clip-path: polygon(0 18%, 100% 27%, 100% 100%, 0% 100%);">
                        <div class="advs-box-top-icon boxed-inverse"  style="padding:0px !important; z-index: -1; opacity:0.85;background-size:100% 100%;">
                            <div style=" width:100%;height:37%; background-color:#732571; opacity:0.85; z-index: -2; padding: 50px 30px !important;">
                           
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2"  style="width: 16.66666667%;padding:0px;  z-index: 1;-webkit-clip-path: polygon(0 27%, 100% 36%, 100% 100%, 0% 100%);
							clip-path: polygon(0 27%, 100% 36%, 100% 100%, 0% 100%);">
                       <div class="advs-box-top-icon boxed-inverse" style="padding:0px !important;z-index: -1; opacity:0.85;background-size:100% 100%;">
                            <div style="width:100%;height:37%;background-color:#2180bd; opacity:0.85; z-index: -2; padding: 50px 30px !important;">
                          
                            
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-2"  style="width: 16.66666667%;padding:0px; z-index: 1;-webkit-clip-path: polygon(0 36%, 100% 27%, 100% 100%, 0% 100%);
							clip-path: polygon(0 36%, 100% 27%, 100% 100%, 0% 100%);">
                        <div class="advs-box-top-icon boxed-inverse"  style="padding:0px !important; z-index: -1; opacity:0.85;background-size:100% 100%;">
                            <div style="width:100%;height:37%; background-color:#f5a23e; opacity:0.85; z-index: -2; padding: 50px 30px !important;">
                              
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2"  style="width: 16.66666667%;padding:0px; z-index: 1;-webkit-clip-path: polygon(0 27%, 100% 18%, 100% 100%, 0% 100%);
								clip-path: polygon(0 27%, 100% 18%, 100% 100%, 0% 100%);">
                        <div class="advs-box-top-icon boxed-inverse"  style="padding:0px !important;z-index: -1; opacity:0.85;background-size:100% 100%;">
                            <div style=" width:100%;height:37%;background-color:#a82556; opacity:0.85; z-index: -2; padding: 50px 30px !important;">
                           
                            
                            </div>
                        </div> 
                    </div>
                     -->
                     
                       
                   
                    <div class="col-md-2"  style="width: 25%;padding:0px; z-index: 1;">
                        
                            <svg  width='100%' height='100%'>
  								<polygon points="0 0, 585 25, 850 850, 0 850" style="fill:#1c5a87; height:100%; width:100%;opacity:0.85;" />
							</svg>
                    </div>
                    
                    <div class="col-md-2"  style="width: 25%;padding:0px; z-index: 1;">
                       
                            <svg  width='100%' height='100%'>
  								<polygon points="0 20, 585 50, 850 850, 0 850" style="fill:#f0783e; height:100%; width:100%;opacity:0.85;" />
							</svg>
                    </div>
                    
                    <div class="col-md-2"  style="width: 25%;padding:0px; z-index: 1;">
                       
                            <svg  width='100%' height='100%'>
  								<polygon points="0 45, 585 75, 850 850, 0 850" style="fill:#732571; height:100%; width:100%;opacity:0.85;" />
							</svg>
                    </div>
                    <div class="col-md-2"  style="width: 25%;padding:0px; z-index: 1;">
                       
                            <svg  width='100%' height='100%'>
  								<polygon points="0 69, 585 50 850 850, 0 850" style="fill:#f5a23e; height:100%; width:100%;opacity:0.85;" />
							</svg>
                    </div>
                    <!--  <div class="col-md-2"  style="width: 16.66666667%;padding:0px; z-index: 1;">
                       
                            <svg  width='100%' height='100%'>
  								<polygon points=" 0 95,385 50, 450 450, 0 450" style="fill:#f5a23e; height:100%; width:100%;opacity:0.85;" />
							</svg>
                    </div>
				    <div class="col-md-2"  style="width: 16.66666667%;padding:0px; z-index: 1;">
                       
                            <svg  width='100%' height='100%'>
  								<polygon points="0 60, 385 25, 450 450, 0 450" style="fill:#a82556; height:100%; width:100%;opacity:0.85;" />
							</svg>
                    </div> -->
					 
                    
                    
                    
                    
                </div>
                
                 
                
                
            </div>
            
        </div>
        
        
        <div class="section overlay-container" style="height: 1180px;;  background-image:url('./resources/segroup/images/classic/hd-1.jpg');   background-color:white;">
            <div class="container" style="margin-top:0px; width:100%; height:80%; padding-top:0px;padding-bottom:0px;">
                  <!--<div class="row">
                
                    <div class="col-md-12 col-sm-12" style="padding:0px;">
                        <div class="flexslider slider nav-inner visible-dir-nav" data-options="controlNav:false,directionNav:true,animation:fade" style="height:70%;">
                            <ul class="slides">
                              
                                <li  style="height:100%; margin:auto;">
                                    <a class="img-box thumbnail lightbox" href="./resources/images/classic/image-3.jpg" data-lightbox-anima="fade-right" style="padding:0px; height:100%;">
                                        <span>
                                            <img src="./resources/images/classic/image-3.jpg" alt="" style="width:100%;">
                                        </span>
                                    </a>
                                </li>
                               
                            </ul>
                        </div>
                    
                 
                    </div> 
                
                
                  </div>-->
                 <div  id="pageOne" class="row" style="height:40%;">
                    <div class="col-md-2"  style="padding:0px; z-index: 1;width: 25%;">
                       <div class="advs-box-top-icon boxed-inverse"  style="height:75%;padding:0px !important; z-index: -1; opacity:0.85;/* background: url(./resources/images/classic/bbg1.jpg) center center; *//* background-size:100% 100%; */">
                            <div onclick="location.href='http://job.sesoc.global/society/index'" style="cursor: pointer; width:100%;height:100%; background-color:#1c5a87; /* opacity:0.85; */ z-index: -2; padding: 20px 30px !important;">
                            
                            <h3 style="margin-top:0%;"  class="page2div"><a class="btn-text" href="http://job.sesoc.global/society/index" style="color:white !important; " data-langNum="1">해외취업알선<br></a></h3>
                            <hr style="color:white;     margin-top: 0px !important;"  class="page2div">
                            <p style="color:white; text-align:left;"  class="page2div"><a href="http://job.sesoc.global/society/index" style="color:white !important;" data-langNum="2">
                                새로운 도전을 위한, 더 높은 성취를 위한 글로벌 커리어 활동을 지원합니다.</a>
                            </p> 
                            </div>
                        </div> 
                    </div>
                    <div class="col-md-2"  style="padding:0px;  z-index: 1;width: 25%;">
                       <div class="advs-box-top-icon boxed-inverse"  style="height:75%;padding:0px !important; z-index: -1; opacity:0.85;/* background: url(./resources/images/classic/bbg2.jpg) center center; *//* background-size:100% 100%; */">
                            <div onclick="location.href='https://www.softsociety.net/ictcenter'" style="cursor: pointer; width:100%;height:100%;background-color:#f0783e; opacity:0.85; z-index: -2; padding: 20px 30px !important;">
                            
                            <h3 style="margin-top:0%;"  class="page2div"><a class="btn-text" href="https://www.softsociety.net/ictcenter" style="color:white !important;" data-langNum="3">글로벌엔지니어양성<br></a></h3>
                            <hr style="color:white;     margin-top: 0px !important;"  class="page2div">
                            <p style="color:white; text-align:left;"  class="page2div"><a href="https://www.softsociety.net/ictcenter" style="color:white !important;text-align:left;"data-langNum="4">
                                글로벌 비즈니스를 창출하고 수행할 ICT 전문인재를 선발 육성 합니다.</a>
                            </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2"  style="padding:0px;  z-index: 1;width: 25%;">
                        <div class="advs-box-top-icon boxed-inverse"  style="height:75%;padding:0px !important; z-index: -1; opacity:0.85;/* background: url(./resources/images/classic/bbg3.jpg) center center; *//* background-size:100% 100%; */">
                            <div onclick="location.href='window.open('http://cyber.tradecampus.com/','_blank');'" style="cursor: pointer; width:100%;height:100%; background-color:#732571; opacity:0.85; z-index: -2; padding: 20px 30px !important;">
                           
                            <h3 style="margin-top:0%;"  class="page2div"><a class="btn-text" href="http://cyber.tradecampus.com/" style="color:white !important;"  target="_blank" data-langNum="5">스마트러닝<br></a></h3>
                            <hr style="color:white;    margin-top: 0px !important;" class="page2div">
                            <p style="color:white; text-align:left;" class="page2div"><a href="http://cyber.tradecampus.com/" style="color:white !important;text-align:left;" target="_blank" data-langNum="6">
                              무역협회 무역아카데미의 온라인교육 시스템을 위탁 운영하고 있습니다.</a>
                            </p>
                            </div>
                        </div>
                    </div>
                   <!--  <div class="col-md-2"  style="padding:0px;  z-index: 1;width: 16.66666667%;">
                       <div class="advs-box-top-icon boxed-inverse" style="height:75%;padding:0px !important;z-index: -1; opacity:0.85;/* background: url(./resources/images/classic/bbg4.jpg) center center; *//* background-size:100% 100%; */">
                            <div style="width:100%;height:100%;background-color:#2180bd; opacity:0.85; z-index: -2; padding: 20px 30px !important;">
                          
                            <h3 style="margin-top:0%;" class="page2div"><a class="btn-text" href="http://ict.sesoc.global/edu/apply/it101_menu" style="color:white !important;">단기과정<br></a></h3>
                            <hr style="color:white;    margin-top: 0px !important;" class="page2div">
                            <p style="color:white;" class="page2div"> <a href="http://ict.sesoc.global/edu/apply/it101_menu" style="color:white !important;text-align:left;">
                               ICT의 기초부터 AI, 빅데이터 등 고급강좌까지 한번에!!</a>
                            </p>
                            </div>
                        </div>
                    </div> -->
                    <div class="col-md-2"  style="padding:0px; z-index: 1;width: 25%;">
                        <div class="advs-box-top-icon boxed-inverse"  style="height:75%;padding:0px !important; z-index: -1; opacity:0.85;/* background: url(./resources/images/classic/bbg5.jpg) center center; *//* background-size:100% 100%; */">
                            <div onclick="location.href='https://www.softsociety.net/main'" style="cursor: pointer; width:100%;height:100%; background-color:#f5a23e; opacity:0.85; z-index: -2; padding: 20px 30px !important;">
                            
                            <h3 style="margin-top:0%;" class="page2div"><a class="btn-text" href="https://www.softsociety.net/main" style="color:white !important;" data-langNum="7">시험센터<br></a></h3>
                            <hr style="color:white;   margin-top: 0px !important;" class="page2div">
                            <p style="color:white; text-align:left;" class="page2div"><a href="https://www.softsociety.net/main" style="color:white !important;text-align:left;" data-langNum="8">
                                 글로벌 공인기관의 시험센터를 운영합니다.</a> 
                            </p>
                            </div>
                        </div>
                    </div>
                    <!-- <div class="col-md-2"  style="padding:0px; z-index: 1;width: 16.66666667%;">
                        <div class="advs-box-top-icon boxed-inverse"  style="height:75%;padding:0px !important;z-index: -1; opacity:0.85;/* background: url(./resources/images/classic/bbg6.jpg) center center; *//* background-size:100% 100%; */">
                            <div style=" width:100%;height:100%;background-color:#a82556; opacity:0.85; z-index: -2; padding: 20px 30px !important;">
                           
                            <h3 style="margin-top:0%;" class="page2div"><a class="btn-text" href="#" style="color:white !important;">SI<br></a></h3>
                            <hr style="color:white;    margin-top: 0px !important;" class="page2div">
                            <p style="color:white;" class="page2div"> <a href="#" style="color:white !important;text-align:left;">
                              IT컨설팅과 시스템 구축에서 운영까지 최적의 솔루션을 제공합니다.</a>
                            </p>
                            </div>
                        </div> 
                    </div>  -->
                </div>
                <div class="row" style="height:12%;">
                 <h1 style="text-align:center; font-size:70px; "><b style="font-weight:900;"><font style="color:#3ac6ff;">A</font>BOUT US</b></h1>
                </div>
                
                  <div  id="pageTwo" class="container" style=" padding-top:0%; margin-top:1px !important;">
                <p class="block-quote quote-1 quote-color-2"  data-langNum="9">
                    Soft Engineer Society의 비전은 다양한 전공의 한국청년들을 21C ICT융복합인재로 양성하여 해외 유수의 기업에서 활동할 기회를 제공하고, 기업 및 산업계간의 글로벌 협력을 통하여 새로운 가치를 창출하는 네트워크를 확대해 가는 것입니다. 
                   
                </p>
                <hr class="space m" style="padding-top:13px;" />
                <div class="row">
                    
                    <div class="col-md-6">
                       <font style="color:#3ac6ff;    font-size: 20px;"><b  data-langNum="12">●  ICT인재의 해외기업 매칭</b></font>
                           <br>   
                            <p>
                            <b  data-langNum="13">
                           &nbsp;- O2O 채용지원시스템 구축운영  <br>    
                           &nbsp;&nbsp;• 해외기업의 채용수요 포스팅 (년2회, 4월&9월, www.sesoc.global)  <br> 
                           &nbsp;&nbsp;• 사전전형 지원 : 서류전형, 적성검사, 필기시험, 화상면접 (온라인 & 오프라인)  <br>  
                           &nbsp;&nbsp;• Tokyo Job Fair 개최 (년2회, 6월&11월) : 사전전형 통과자 최종면접행사  <br>
                           &nbsp;- 일본 ICT기업에 채용 알선한 한국청년 1,510명 (2017 현재)   <br>
                           &nbsp;&nbsp;• 한국정부(고용노동부) 지정 해외취업우수기관 (2010 & 2015)   <br>
                           &nbsp;&nbsp;• 언론 보도 : NHK World - News Room Tokyo (2016.5.31) <br>                           
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TV Tokyo - World Business Satellite (2016.10.27)<br>
                           </b>
                           </p>
                           <font style="color:#3ac6ff;     font-size: 20px;"><b  data-langNum="10">●  ICT융복합 글로벌 인재양성</b></font>
                           <br>   
                            <p><b  data-langNum="11">
                               &nbsp;- 과학기술정보통신부 지정 SW전문인력양성기관 <br>
                               &nbsp;- 한국무역협회와 컨소시움을 체결, 해외진출 ICT인재양성과정 운영 (Since 2001)<br>   
                               &nbsp;&nbsp;• 2017.12월현재 총 2,134명 양성 배출 <br> 
                               &nbsp;- MOU 체결대학(학점인정 등) :   산기대, 전남대, 금강대, 국민대, 한신대, 경동대 등<br> &nbsp;&nbsp;&nbsp;&nbsp;16개 대학 <br> 
                            </b></p>
                    </div>
                    <div class="col-md-6">
                           
                            <font style="color:#3ac6ff;    font-size: 20px;"><b  data-langNum="14">●  스마트러닝</b></font>
                           <br>   
                            <p>
                            <b  data-langNum="15">
                             &nbsp;- 무역협회 무역아카데미 온라인 교육 시스템 운영 <br>  
                             &nbsp;- 글로벌 비즈니스 전략, 외국어, 국제무역사 등 300여 컨텐츠<br>  
                            </b>
                           </p>
                            <font style="color:#3ac6ff;    font-size: 20px;"><b  data-langNum="16">●  글로벌 협력 </b></font>
                           <br>   
                            <p>
                            <b  data-langNum="17">
                             &nbsp;- 在日 ICT인재교류회 사무국 운영 <br>
                             &nbsp;- 공인시험센터 운영 : 토플, 오픽 <br>
                             &nbsp;- 오프쇼어 시스템인티그레이션 (Off-Shore SI)   
                            </b> 
                           </p>
                           <font style="color:#3ac6ff; font-size: 20px;"><b  data-langNum="18">●  사업등록·면허</b></font>
                           <br>   
                            <p><b  data-langNum="19">
                             &nbsp;- 평생교육시설(지식·인력개발 & 원격), 해외취업알선,  
                                                  직업소개사업, 소프트웨어사업   
                           </b></p>
                    </div>
                    <!-- <div class="col-md-4">
                        
                           
                          <br>
                           
                           <br>
                    </div> -->
                </div>
            </div>
                 
            </div>
           
        </div> 
        
         
        
        
        <div class="section overlay-container" style="background-image:url('./resources/segroup/images/classic/hd-2.jpg'); height:100%;">
            <div class="container" style="margin-top:0px; width:100%; height:80%; padding-top:10%; padding-bottom:0;">
               
                   <h1 style="text-align:center; font-size:70px; "><b style="font-weight:900;"><font style="color:#3ac6ff;">H</font>ISTORY</b></h1>
              
                <hr class="space m" />
                
                 
                <div  id="pageThree" class="row" style="height:30%;padding-top: 5%;">
               		<div class="col-md-6">
               		 <div style="padding-left:35%;">
               		  <h1 style="padding-left:25%;">2011~</h1><br><b data-langNum="20">
               		 2017.11 제4회 도쿄 Job Fair 개최 (Tokyo TKP 市ヶ谷, 11.20~24) <br>
               		 2017.06 제3회 도쿄 Job Fair 개최 (Tokyo 神楽坂HC 스튜디오, 6.19~23) <br>
               		 2017.02 오라클 University 공인교육센터&lt;OAEC&gt;지정 및  Reseller 파트너쉽 체결<br>
               		 2016.11 제2회 도쿄 Job Fair 개최 (Tokyo TKP 永町田, 11.21~25)<br>
               		 2016.06 제1회 도쿄 Job Fair 개최 (Tokyo Haneda Turtle Service,  6.20~24) <br>
               		 2015.12 국가경쟁력기여(해외진출지원) 고용노동부 장관 표창 <br>
               		 2015.08 과학기술정보통신부(舊미래창조과학부) SW전문인력양성기관 지정<br>
               		 2013.04 Opic공인시험센터 지정<br>
               		 2013.01 무역협회 K-Move 스쿨 운영 컨소시움 체결 <br>
               		 2011.01 무역협회 ICT교육센터•스마트러닝센터 운영기관지정 </b><br>
               		 </div>
               		 
               		 
               		   
               		</div>
               		<div class="col-md-6">
                        <div style="padding-left:12%;">
                        <h1 style="padding-left:13%;">2001~2010</h1><br><b data-langNum="21">
                        2008.11 무역진흥기여(글로벌인재양성) 국무총리 표창<br>
                     2008.10 Prometric Loyal Partner Award 수상 <br>
                     2007.08 ETS/Prometric 공인 토플시험센터 지정<br>
                     2005.03 Sun Educational Service Partnership 체결 <br>
                     2005.11 해외인력양성특수유공 산업자원부장관 표창 <br>
                     2003.07 美 카네기멜론대(CMU) 석사과정 사전교육프로그램 설계 운영 <br>
                     2002.09 프로메트릭(Prometric) 공인시험센터 지정 <br>
                     2002.06 오라클 University 공인교육센터&lt;WDP> 지정 <br>
                     2001.12 창업 (법인명변경 (주)에프앤텍 -> (주)Soft Engineer School/‘16.3월, <br>
                                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;법인합병 (주)Soft Engineer Society로 기업합병/‘17.12월)<br></b>
                        </div>
                     </div>
                     
                      
               
               </div>
                
            </div>
        </div>
       
        <div class="section overlay-container section-bg-color" style="background-image:url('./resources/segroup/images/classic/hd-4.jpg');">
        <h1 style="text-align:center; font-size:70px; margin-top:5%; margin-bottom:5%;"><b style="font-weight:900;"><font style="color:#3ac6ff;">C</font>ONTACT</b></h1>
            <div class="container content box-middle" style="margin-top:100px; padding-top:0px;">
             
                <div class="row proporzional-row"  id="pageFour">
                
                    <div class="col-md-3 boxed-inverse" style="height:450px;">
                        <h4 class="text-m" data-langNum="22">주소</h4>
                        <hr class="space xs" />
                        <p data-langNum="23">
                            06164 서울특별시<br />
                            	강남구 영동대로 513<br />
                            (삼성동, 코엑스4층)
                        </p>
                        <hr class="space s" />
                        <h4 class="text-m" data-langNum="24">연락처</h4>
                        <hr class="space xs" />
                        <ul class="fa-ul">
                            <li><i class="fa-li im-email"></i> hello@sesoc.global</li>
                            <li><i class="fa-li im-phone"></i> 82-2-6000-6260</li>
                            <li><i class="fa-li im-calendar"></i> 82-2-6000-6261</li>
                        </ul>
                    </div>
                    <div class="col-md-9" style="height:450px;">
                        <!-- <div class="google-map shadow-1" data-skin="" data-zoom="16" data-address="coex korea seoul" data-marker="http://templates.framework-y.com/elon/images/marker-map.png"></div> -->
                       <div  id="map-canvas" style="height:100%;width:100%;"></div>
                    </div>
                    <hr class="space visible-sm" />
                    <!--<div class="col-md-4 col-sm-12">
                        <h4 class="text-m">CONTACT US</h4>
                        <hr class="space s" />
                        <p>
                                              상담을 위해 연락처와 정보를 남겨주세요.
                        </p>
                        <hr class="space m" />
                         <form action="/edu/sendmail" class="form-box form-ajax" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <input id="name" name="name" placeholder="이름" type="text" class="form-control form-value" required>
                                </div>
                                <div class="col-md-6">
                                    <input id="email" name="email" placeholder="이메일" type="email" class="form-control form-value" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <hr class="space m" />
                                    <input id="phone" name="phone" placeholder="전화번호" type="text" class="form-control form-value">
                                    <hr class="space m" />
                                    <textarea id="messagge" name="messagge" placeholder="메세지 남기기" class="form-control form-value" required></textarea>
                                    <hr class="space m" />
                                    <button class="anima-button circle-button btn-sm btn" type="submit"><i class="im-mail-send"></i>메세지 보내기</button>
                                </div>
                            </div>
                            <div class="success-box">
                                <div class="alert alert-success">Congratulations. Your message has been sent successfully</div>
                            </div>
                            <div class="error-box">
                                <div class="alert alert-warning">Error, please retry. Your message has not been sent</div>
                            </div>
                        </form>
                    </div> -->
                </div>
            </div>
        </div>
    </div>
    <footer class="footer-base" style=" background: #636363 !important; text-align:center; color:white;">
    
    <div class="footer_wrap" style="display: -webkit-inline-box; ">
		<div class="footer_logo" style="padding:6%; padding-left:0%;">
			<img
				src="<c:url value="/resources/segroup/society/edu/image/sub/ses_footer.png" />">
		</div>
		<div class="footer_contents">
			<!-- <div class="footer_menu">
					<a onclick="goSec1()">회사소개</a> |
					<a href="/privacy_policy">개인정보처리방침</a> |
					<a href="/usage_policy">이용약관</a> |
					<a onclick="goSec1()">사업자등록번호 : 468-81-00409</a> |
					<a onclick="goSec1()">통신판매업신고번호 : 제 강남-03736호</a><br><br>
			</div> -->
			<div class="footer_desc">
				<br>
					(주) 소프트엔지니어소사이어티(Soft Engineer Society)<br>
					135-731 서울특별시 강남구 영동대로 513(삼성동, 코엑스 4층 ICT교육센터)<br>
				    대표자:김치중 | 사업자번호:468-81-00409 | 연락처:02-6000-6260<br>  
				<p>Copyrightⓒ2018 (주)소프트엔지니어소사이어티(Soft Engineer Society) All
					right reserved.</p><br>
			</div>
		</div>
	</div>
        <link rel="stylesheet" href="./resources/segroup/script/iconsmind/line-icons.min.css">
        <script>

        $('ul > li > a').css('font-size','18px');
        
        </script>
        <script async src="./resources/segroup/script/bootstrap/js/bootstrap.min.js"></script>
        <script src='./resources/segroup/script/google.maps.min.js'></script>
        <!-- <script src='https://maps.googleapis.com/maps/api/js?key=AIzaSyAuhhck0_kIRY_cYrR3gHqr4mMZutvuQG0&sensor=false'></script> -->
        <script type="text/javascript" src="./resources/segroup/script/imagesloaded.min.js"></script>
        <script type="text/javascript" src="./resources/segroup/script/parallax.min.js"></script>
        <script type="text/javascript" src='./resources/segroup/script/flexslider/jquery.flexslider-min.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/isotope.min.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/php/contact-form.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/jquery.progress-counter.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/jquery.tab-accordion.js'></script>
        <script type="text/javascript" async src="./resources/segroup/script/bootstrap/js/bootstrap.popover.min.js"></script>
        <script type="text/javascript" async src="./resources/segroup/script/jquery.magnific-popup.min.js"></script>
        <!-- <script src='./resources/segroup/script/jquery.fullPage.min.js'></script>
        <script src='./resources/segroup/script/social.stream.min.js'></script>  -->
    </footer>
</div>
    
<div id="forMo" style="display:none;">
   
    <header class="fixed-top bg-transparent menu-transparent" data-menu-anima="fade-in">
        <div class="navbar navbar-default mega-menu-fullwidth navbar-fixed-top" role="navigation">
            <div class="navbar navbar-main"style="padding-top:7px; background: #636363 !important;">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a style="width:335px;" class="navbar-brand" href="https://www.softsociety.net/"><img id="logoImage" style="width:240px;" src="./resources/segroup/images/classic/logo_w.png" alt="logo" /></a>
                    </div>
                    <div class="collapse navbar-collapse">
                        <div class="nav navbar-nav navbar-right">
                            <ul class="nav navbar-nav">
                                <li class="active" >
                                    <a onclick="goSec1m()"  style="color:white;">Home</a>
                                </li>
                                <li class="active" >
                                    <a onclick="goSec2m()"  style="color:white;">About us</a>
                                </li>
                                <li class="dropdown">
                                    <!-- <a href="#">Bussiness</a> -->
                                    <a class="dropdown-toggle"  onclick="goSec4m()" style="color:white;">Business<span class="caret"></span></a>
                                    <!-- <ul class="dropdown-menu">
                                        <li><a href="http://job.sesoc.global/society/index" class="sub" data-langNum="25">해외취업알선</a></li>
                                    	<li><a href="http://ict.sesoc.global/edu/apply/kmove" class="sub" data-langNum="26">글로벌엔지니어양성</a></li>
                                        <li><a href="http://cyber.tradecampus.com/" class="sub" data-langNum="27">스마트러닝</a></li>
                                    	<li><a href="https://www.softsociety.net/main" class="sub" data-langNum="28">시험센터</a></li>
                                    </ul> -->
                                </li>
                            
                                <li class="active">
                                    <a onclick="goSec3m()"  style="color:white;">History</a>
                                </li>
                                <li class="active">
                                </li>
                            </ul>
                            <ul class="nav navbar-nav lan-menu">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" role="button"  style="color:white;"  id="nationFlagm"><img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR<span class="caret"></span></a>
                                    <ul class="dropdown-menu">
                                    
                                        <li><a id="krbm" data-lang="ko" style="color:white;"><img src="./resources/segroup/images/kr.png" alt="" style="height:15px;"/>KOR</a></li>
                                    
                                        <li style=" padding-top:7px;"><a id="jpbm" data-lang="ja" style="color:white;"><img src="./resources/segroup/images/jp.png" alt="" style="height:15px;"/>JPN</a></li>
                 
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div id="fullpage-main" data-options="verticalCentered:false" data-offset="-30">
        <div class="section overlay-container" style="background-image:url('./resources/segroup/images/classic/bbg6.png');">
            <div id="pageZero" class="container content box-middle" style="height:50%;">
                <div class="row vertical-row">
                    <div class="col-md-6 col-sm-12">
                        <div class="title-base text-left title-color-2">
                            <hr />
                            <p><h1 id='mainTitle' style="padding-top:18%;font-size:28px; font-weight:800; color:white;" data-langNum="0">새로운 세상을 만들어가는<br> 열정과 도전<br>
                  <font style="color:#3ac6ff;">Soft Engineer Society</font>가 함께 합니다.</h1></p>
                        </div>
                        <hr class="space s" />
                    </div>
                </div>
            </div>
        </div>
        <div class="section overlay-container" style="background-image:url('./resources/segroup/images/classic/hd-3.jpg');">
            <div class="container content box-middle">
               
                <hr class="space m" />
                <div id="pageOne" class="row">
                    <div class="col-md-3">
                        <div class="advs-box advs-box-top-icon boxed-inverse" style="background-color:#1c5a87; color:white; height:250px;">
                            <h3 style="color:white;" data-langNum="1">해외취업알선</h3>
                            <hr>
                            <p style="color:white; text-align:left;" data-langNum="2">
                               	새로운 도전을 위한, 더 높은 성취를 위한 글로벌 커리어 활동을 지원합니다.
                            </p>
                            <a class="btn-text" href="http://job.sesoc.global/society/index" data-langNum="29">바로가기</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="advs-box advs-box-top-icon boxed-inverse" style="background-color:#f0783e; color:white; height:250px;">
                            <h3 style="color:white;" data-langNum="3">글로벌엔지니어양성</h3>
                            <hr>
                            <p style="color:white;text-align:left;" data-langNum="4">
                              	 글로벌 비즈니스를 창출하고 수행할 ICT 전문인재를 선발 육성 합니다.
                            </p>
                            <a class="btn-text" href="https://www.softsociety.net/ictcenter" data-langNum="29">바로가기</a>
                            
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="advs-box advs-box-top-icon boxed-inverse" style="background-color:#732571; color:white; height:250px;">
                            <h3 style="color:white;" data-langNum="5">스마트러닝</h3>
                            <hr>
                            <p style="color:white;text-align:left;" data-langNum="6">
                               	 무역협회 무역아카데미의 온라인교육 시스템을 위탁 운영하고 있습니다.
                            </p>
                            <a class="btn-text" href="http://cyber.tradecampus.com/" data-langNum="29"  target="_blank" >바로가기</a>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="advs-box advs-box-top-icon boxed-inverse" style="background-color:#f5a23e; color:white; height:250px;">
                            <h3 style="color:white;" data-langNum="7">시험센터</h3>
                            <hr>
                            <p style="color:white;text-align:left;" data-langNum="8">
                               	글로벌 공인기관의 시험센터를 운영합니다.
                            </p>
                            <a class="btn-text" href="https://www.softsociety.net/main" data-langNum="29">바로가기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="section overlay-container" style="background-image:url('./resources/segroup/images/classic/hd-3.jpg');">
            <div class="container content box-middle">
            <div class="row" style="height:12%;">
                 <h1 style="text-align:center; font-size:60px; "><b style="font-weight:900;"><font style="color:#3ac6ff;">A</font>BOUT US</b></h1>
                </div>
                <p class="block-quote quote-1 quote-color-2" data-langNum="9">
                    Soft Engineer Society의 비전은 다양한 전공의 한국청년들을 21C ICT융복합인재로 양성하여 해외 유수의 기업에서 활동할 기회를 제공하고, 기업 및 산업계간의 글로벌 협력을 통하여 새로운 가치를 창출하는 네트워크를 확대해 가는 것입니다.
                </p>
                <hr class="space m" />
                <div class="row" id="pageTwo">
                    <div class="col-md-12">
                        <div class="advs-box advs-box-top-icon boxed-inverse">
                            <h3 style="color:#3ac6ff;" data-langNum="12">● ICT인재의 해외기업 매칭 </h3>
                            <p style="text-align:left;" data-langNum="13">
                                - O2O 채용지원시스템 구축운영 <br>
  								&nbsp;• 해외기업의 채용수요 포스팅 (년2회, 4월&9월, www.sesoc.global) <br>
  								&nbsp;• 사전전형 지원 : 서류전형, 적성검사, 필기시험, 화상면접 (온라인 & 오프라인) <br>
  								&nbsp;• Tokyo Job Fair 개최 (년2회, 6월&11월) : 사전전형 통과자 최종면접행사 <br>
 								- 일본 ICT기업에 채용 알선한 한국청년 1,510명 (2017 현재) <br>
  								&nbsp;• 한국정부(고용노동부) 지정 해외취업우수기관 (2010 & 2015) <br>
  								&nbsp;• 언론 보도 : NHK World - News Room Tokyo (2016.5.31) <br>
 								TV Tokyo - World Business Satellite (2016.10.27)
                            </p>
                        </div>
                    </div>
                    <div class="col-md-12">
                    	<div class="advs-box advs-box-top-icon boxed-inverse">
                        <h3 style="color:#3ac6ff;" data-langNum="10">● ICT융복합 글로벌 인재양성  </h3>
                            <p style="text-align:left;" data-langNum="11">
                                - 과학기술정보통신부 지정 SW전문인력양성기관  <br>
 								- 한국무역협회와 컨소시움을 체결, 해외진출 ICT인재양성과정 운영 (Since 2001) <br>
  								&nbsp;• 2017.12월현재 총 2,134명 양성 배출  <br>
 								- MOU 체결대학(학점인정 등) : 산기대, 전남대, 금강대, 국민대, 한신대, 경동대 등 16개 대학 <br>
                            </p>
                           </div>
                    </div>
                    <div class="col-md-12">
                    	<div class="advs-box advs-box-top-icon boxed-inverse">
                        <h3 style="color:#3ac6ff;" data-langNum="14">● 스마트러닝  </h3>
                            <p style="text-align:left;" data-langNum="15">
                                - 무역협회 무역아카데미 온라인 교육 시스템 운영 <br>
								- 글로벌 비즈니스 전략, 외국어, 국제무역사 등 300여 컨텐츠
                            </p>
                           </div>
                    </div>
                    <div class="col-md-12">
                    	<div class="advs-box advs-box-top-icon boxed-inverse">
                        <h3 style="color:#3ac6ff;" data-langNum="16">● 글로벌 협력  </h3>
                            <p style="text-align:left;" data-langNum="17">
                                 - 在日 ICT인재교류회 사무국 운영  <br>
 								- 공인시험센터 운영 : 토플, 오픽  <br>
 								- 오프쇼어 시스템인티그레이션 (Off-Shore SI)
                            </p>
                           </div>
                    </div>
                    <div class="col-md-12">
                    	<div class="advs-box advs-box-top-icon boxed-inverse">
                        <h3 style="color:#3ac6ff;" data-langNum="18">● 사업등록·면허  </h3>
                            <p style="text-align:left;" data-langNum="19">
                               - 평생교육시설(지식·인력개발 & 원격), 해외취업알선, 직업소개사업, 소프트웨어사업
                            </p>
                           </div>
                    </div>
                </div>
            </div>
        </div>
        
        
        <div class="section overlay-container" style="background-image:url('./resources/segroup/images/classic/hd-3.jpg');">
            <div class="container content box-middle">
            <div class="row" style="height:12%;">
                 <h1 style="text-align:center; font-size:60px; "><b style="font-weight:900;"><font style="color:#3ac6ff;">H</font>ISTORY</b></h1>
                </div>
                
                <hr class="space m" />
                <div class="row" id="pageThree">
                
                	<div class="col-md-12">
                    	<div style="padding-left:0%;">
                        <h3 style="text-align:left;">2001~2010</h3>
                            <p style="text-align:left;"><b data-langNum="21">
                                2008.11 무역진흥기여(글로벌인재양성) 국무총리 표창<br>
								2008.10 Prometric Loyal Partner Award 수상 <br>
								2007.08 ETS/Prometric 공인 토플시험센터 지정<br>
								2005.03 Sun Educational Service Partnership 체결 <br>
								2005.11 해외인력양성특수유공 산업자원부장관 표창 <br>
								2003.07 美 카네기멜론대(CMU) 석사과정 사전교육프로그램 설계 운영 <br>
								2002.09 프로메트릭(Prometric) 공인시험센터 지정 <br>
								2002.06 오라클 University 공인교육센터&gt;WDP> 지정 <br>
								2001.12 창업 (법인명변경 (주)에프앤텍 -> (주)Soft Engineer School/‘16.3월, <br>
       							 법인합병 (주)Soft Engineer Society로 기업합병/‘17.12월)<br>
                            </b></p>
                            
                           </div>
                    </div><br>
                    <div class="col-md-12">
                        <div style="padding-left:0%;">
                            <h3 style="text-align:left;">2011~ </h3>
                            <p style="text-align:left;"><b data-langNum="20">
                                2017.11 제4회 도쿄 Job Fair 개최 (Tokyo TKP 市ヶ谷, 11.20~24) <br>
								2017.06 제3회 도쿄 Job Fair 개최 (Tokyo 神楽坂HC 스튜디오, 6.19~23) <br>
								2017.02 오라클 University 공인교육센터&gt;OAEC>지정 및 Reseller 파트너쉽 체결<br>
								2016.11 제2회 도쿄 Job Fair 개최 (Tokyo TKP 永町田, 11.21~25)<br>
								2016.06 제1회 도쿄 Job Fair 개최 (Tokyo Haneda Turtle Service, 6.20~24) <br>
								2015.12 국가경쟁력기여(해외진출지원) 고용노동부 장관 표창 <br>
								2015.08 과학기술정보통신부(舊미래창조과학부) SW전문인력양성기관 지정<br>
								2013.04 Opic공인시험센터 지정<br>
								2013.01 무역협회 K-Move 스쿨 운영 컨소시움 체결 <br>
								2011.01 무역협회 ICT교육센터•스마트러닝센터 운영기관지정<br>
                            </b></p>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
        
        
        <div class="section overlay-container section-bg-color" style="background-image:url('./resources/segroup/images/classic/hd-4.jpg');">
            <div class="container content box-middle">
                <div class="row proporzional-row">
                   <div id="pageFour" class="col-md-3 boxed-inverse" style="height:400px;">
                        <h4 class="text-m" data-langNum="22">주소</h4>
                        <hr class="space xs" />
                        <p data-langNum="23">
                            06164 서울특별시<br />
                            	강남구 영동대로 513<br />
                            (삼성동, 코엑스4층)
                        </p>
                        <hr class="space s" />
                        <h4 class="text-m" data-langNum="24">연락처</h4>
                        <hr class="space xs" />
                       
                        <p>
                            - hello@sesoc.global<br>
                            - 82-2-6000-6260<br>
                            - 82-2-6000-6261
                        </p>
                    </div>
                    <div class="col-md-9" style="height:450px;    width: 100%;">
                        <div class="google-map shadow-1" data-skin="" data-zoom="16" data-address="coex korea seoul" data-marker="http://templates.framework-y.com/elon/images/marker-map.png"></div>
                    </div>
                    
                    <hr class="space visible-sm" />
                    
                </div>
            </div>
        </div>
    </div>
    <footer class="footer-base">
        <link rel="stylesheet" href="./resources/segroup/script/iconsmind/line-icons.min.css">
        <script>

        $('ul > li > a').css('font-size','18px');
        
        </script>
        <script src='./resources/segroup/script/google.maps.min.js'></script>
        <script src='https://maps.googleapis.com/maps/api/js?key=AIzaSyAuhhck0_kIRY_cYrR3gHqr4mMZutvuQG0&sensor=false'></script>
        <script type="text/javascript" src="./resources/segroup/script/imagesloaded.min.js"></script>
        <script type="text/javascript" src="./resources/segroup/script/parallax.min.js"></script>
        <script type="text/javascript" src='./resources/segroup/script/flexslider/jquery.flexslider-min.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/isotope.min.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/php/contact-form.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/jquery.progress-counter.js'></script>
        <script type="text/javascript" async src='./resources/segroup/script/jquery.tab-accordion.js'></script>
        <script type="text/javascript" async src="./resources/segroup/script/bootstrap/js/bootstrap.popover.min.js"></script>
        <script type="text/javascript" async src="./resources/segroup/script/jquery.magnific-popup.min.js"></script>
      <!--  <script src='./resources/segroup/script/jquery.fullPage.min.js'></script>
        <script src='./resources/segroup/script/social.stream.min.js'></script>  -->
    </footer>
</div> 
</body>
</html>
 --%>