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
    
	<!-- 슬라이드js -->
	<script src="<c:url value="/resources/segroup/main/js/jquery.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/main/js/jquery-1.9.1.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/segroup/main/js/jquery-latest.js" />"></script>	
	
	<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
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
				<br><br>
				<spring:message code="ses.main.tx01.sub4" />
				<br><br>
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
<%-- 			<p><spring:message code="ses.main.tx28" /></p> --%>
		</div><!-- <div class="contentsBox1"> -->

		<div class="contentsBox2">
			<div class="sectionHeaderwrap1">					
				<h2><span class="titleHead1"></span>ABOUT US</h2>
			</div>
			<div class="subTitleBox">
				<p>
<%-- 					<spring:message code="ses.main.tx29" /> --%>
					<spring:message code="ses.main.tx29_1" />
					<br>
					<spring:message code="ses.main.tx29_2" />
					<br>
					<spring:message code="ses.main.tx29_3" />
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
				<table>
					<tr>
						<td>2008.11</td>
						<td><spring:message code="ses.main.tx55" /></td>
					</tr>
					<tr>
						<td>2008.10</td>
						<td><spring:message code="ses.main.tx56" /></td>
					</tr>
					<tr>
						<td>2007.08</td>
						<td><spring:message code="ses.main.tx57" /></td>
					</tr>
					<tr>
						<td>2005.03</td>
						<td><spring:message code="ses.main.tx58" /></td>
					</tr>
					<tr>
						<td>2005.11</td>
						<td><spring:message code="ses.main.tx59" /></td>
					</tr>
					<tr>
						<td>2003.07</td>
						<td><spring:message code="ses.main.tx60" /></td>
					</tr>
					<tr>
						<td>2002.09</td>
						<td><spring:message code="ses.main.tx61" /></td>
					</tr>
					<tr>
						<td>2002.06</td>
						<td><spring:message code="ses.main.tx62" /></td>
					</tr>
					<tr>
						<td>2001.12</td>
						<td>
						<spring:message code="ses.main.tx63.sub1" />
						<spring:message code="ses.main.tx63.sub2" />
						</td>
					</tr>
				</table>
			</div><!-- <div class="historyBox1"> -->
			<div class="historyBox2">
				<span>2011~</span>
				<table>
					<tr>
						<td>2021.01</td>
						<td><spring:message code="ses.main.tx64" /></td>
					</tr>
					<tr>
						<td>2020.11</td>
						<td><spring:message code="ses.main.tx65" /></td>
					</tr>
					<tr>
						<td>2020.05</td>
						<td><spring:message code="ses.main.tx66" /></td>
					</tr>
					<tr>
						<td>2017.06</td>
						<td><spring:message code="ses.main.tx67" /></td>
					</tr>
					<tr>
						<td>2019.07</td>
						<td><spring:message code="ses.main.tx68" /></td>
					</tr>
					<tr>
						<td>2018.11</td>
						<td><spring:message code="ses.main.tx69" /></td>
					</tr>
					<tr>
						<td>2018.06</td>
						<td><spring:message code="ses.main.tx70" /></td>
					</tr>
					<tr>
						<td>2017.11</td>
						<td><spring:message code="ses.main.tx71" /></td>
					</tr>
					<tr>
						<td>2017.06</td>
						<td><spring:message code="ses.main.tx72" /></td>
					</tr>
					<tr>
						<td>2017.02</td>
						<td><spring:message code="ses.main.tx73" /></td>
					</tr>
					<tr>
						<td>2016.11</td>
						<td><spring:message code="ses.main.tx74" /></td>
					</tr>
					<tr>
						<td>2016.06</td>
						<td><spring:message code="ses.main.tx75" /></td>
					</tr>
					<tr>
						<td>2015.12</td>
						<td><spring:message code="ses.main.tx75.sub1" /></td>
					</tr>
					<tr>
						<td>2015.08</td>
						<td><spring:message code="ses.main.tx75.sub2" /></td>
					</tr>
					<tr>
						<td>2013.04</td>
						<td><spring:message code="ses.main.tx75.sub3" /></td>
					</tr>
					<tr>
						<td>2013.01</td>
						<td><spring:message code="ses.main.tx75.sub4" /></td>
					</tr>
					<tr>
						<td>2011.01</td>
						<td><spring:message code="ses.main.tx75.sub5" /></td>
					</tr>
				</table>
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
						<div id="map1" style="width:800px;height:360px;">
							<div id="daumRoughmapContainer1572313765901" class="root_daum_roughmap root_daum_roughmap_landing"></div>
						</div>
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
						<div id="map1" style="width:800px;height:360px;">
							<div id="daumRoughmapContainer1618559807492" class="root_daum_roughmap root_daum_roughmap_landing"></div>
						</div>
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
  <script type="text/javascript" charset="UTF-8">
	  new daum.roughmap.Lander({
	      "timestamp": "1572313765901",
	      "key": "vmfe",
	      "mapWidth": "100%",
	      "mapHeight": "100%"
	  }).render();
	  
	  new daum.roughmap.Lander({
			"timestamp" : "1618559807492",
			"key" : "25eeo",
			"mapWidth" : "100%",
			"mapHeight" : "100%"
		}).render();
    $(window).load(function(){
      $('.flexslider').flexslider({
        animation: "slide"
      });
    });
  </script>
  	
</body>
</html>    