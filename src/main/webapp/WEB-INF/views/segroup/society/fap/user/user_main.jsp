<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://kit.fontawesome.com/f4ead7948d.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta property="og:type" content="website">
    <meta property="og:title" content="Soft Engineer Society">
    <meta property="og:image" content="http://www.softsociety.net/edu/apply/ckeditor/ses_main_image.png">
	<title>Bridge Job Fair</title>
   	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script> 
	<script src="<c:url value="/resources/segroup/society/fap/js/swiper.js" />" charset="utf-8"></script>
    <script src="<c:url value="/resources/segroup/society/fap/js/index.js" />"  charset="utf-8"></script>
	<script type="text/javascript" src="<c:url value="/resources/segroup/society/fap/js/lightslider.js" />"></script>
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/lightslider.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
 	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/main.header.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/all.css" />">
	<!--  <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/reset.css" />">-->
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/swiper.min.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/fa_style.css" />">
	<!--  <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/index.css" />">
    <!-- <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/common.css" />"> -->
     
  
	</head>
	
	<script type="text/javascript">
	$(function() {
			//지원불가 공고 알림
			if('${msg}' !== undefined && '${msg}' != '') {
				alert('${msg}');
			}
		      //신청하러 가기 - 잡페어 신청 게시판으로 이동
			  var registerNow = $("#registerNow");
			  registerNow.on('click',function(){
				  location.href="/fap/user/user_jobfair_apply_to_attend_form";
			  })
		
			  //공지사항 게시판으로 이동
			  var userNotice = $("#userNotice");
			  userNotice.on('click',function(){
				  location.href= "/fap/user/user_board_content_list?board=notice";
			  })
		
			  //FAQ로 이동
			  var faqLink = $("#faqLink");
			  faqLink.on('click',function(){
				  location.href= "/fap/user/user_faq";
			  })

			  //SES회원서비스(작업중)
			  var sesUserService = $("#sesUserService");
			  sesUserService.on('click',function(){
				  alert('<spring:message code="fap.main.under_construction"/>');
				  //  location.href= "/fap/user/user_ses_user_service";
			  })	
			  
			  //2020 Fair 일정(작업중)
			  var FairSchedule = $("#2020FairSchedule");
			  FairSchedule.on('click',function(){
				  alert('<spring:message code="fap.main.under_construction"/>');
				//  location.href= "/fap/user/user_2020_fair_schedule";
			  })	
			  
			   //전형절차
			  var step = $("#step");
			  step.on('click',function(){
				  //alert('<spring:message code="fap.main.under_construction"/>');
				  location.href= "/fap/user/user_step";				 
			  })	
			  
			  //취업정보&전략 게시판으로 이동
			  var openJobInfo =$("#openJobInfo");
			  openJobInfo.on('click',function(){
				 location.href = "/fap/user/user_board_content_list?board=jobinfo";
			  })
		
			   //채용기업&파트너사(작업중)
			  var comp_partner = $("#comp_partner");
			  comp_partner.on('click',function(){				
				   location.href= "/fap/user/user_comps_and_partners";							 
			  })
			  
			  //미국인턴십
			  var internship = $("#internship");
			  internship.on('click',function(){
				 location.href= "/fap/user/user_board_content_list?board=internship";
			  })
				/*
				$('#image-gallery').lightSlider({
					item : 1,
					slideMargin : 0,
					speed : 500,
					auto : true,
					loop : true,
					controls: false,
					onSliderLoad : function() { 
						$('#image-gallery').removeClass('cS-hidden');
					}
				});
				*/
			   var popupCount = 0;
			  
				$.ajax({
					url : '/fap/user/user_popup_check'
					, type : 'get'
					, success : function(response) { 
						$.each(response,function(index,item){
							var left = (popupCount%2)*615;
							var top = Math.floor(popupCount/2) * 505;
							if(item.fap_popup_gb == 'D1500'){
								if(getCookie(item.fap_popup_link)!="Y"){
									if(popupCount != 0 && popupCount%2 == 1){
										window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
										popupCount++;
									}else if(popupCount != 0 && popupCount%2 == 0){
										window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
										popupCount++;
									}else{
										window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no");
										popupCount++;
									}
								}
							}else{
								if(getCookie(item.fap_popup_link)!="Y"){
									if(popupCount != 0 && popupCount%2 == 1){
										window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
										popupCount++;										
									}else if(popupCount != 0 && popupCount%2 == 0){
										window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
										popupCount++;		
									}else{
										window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no");
										popupCount++;		
									}
								}
							}
						});
					}
					, error : function (e) {
						console.log(e);
					}					
				});
		
				
				//세션체크
				var divide_session = $("#divide_session").val();
				
				if(divide_session != ''){
					alert("화면 상단의 메뉴에서 잡페어를 선택해 주세요.");
				}
	 		
  });	

		//쿠키 가져오기
		function getCookie(name){
			var cName = name + "=";
			var x = 0;
			var i = 0;
			while ( i <= document.cookie.length){
				var y = (x+cName.length);
				if(document.cookie.substring(x,y) == cName){
					if((endOfCookie=document.cookie.indexOf(";",y)) == -1){
						endOfCookie=document.cookie.length;
					}
					return unescape(document.cookie.substring(y,endOfCookie));
				}
				x = document.cookie.indexOf(" ",x) + 1;
				if( x == 0){
					break;
				}
			}
			return "";
		}
		
		var myApp = angular.module('myapp', []);
		myApp.controller('MainController', ['$scope','$compile','$http', function($scope,$compile,$http){
			
		}]);
		
		myApp.directive('selectcode', ['$http',function($http){
			return {
				restrict: "A",
				replace: true,
				scope : {
					value : '@'
				},
				controller: function ($scope, $element, $attrs) {				
					$http({
						method: 'POST',
						url: '/codeconverter',
				  		responseType: 'text',
						params : {
							code : $attrs.value
						}
					}).then(function successCallback(response) {
			    		$scope.filterParams = response.data;
					}, function errorCallback(response) {
						console.log(response);
					});
				}
				,template: "<option>{{filterParams}}</option>"
			}
		}]);
		
		
		myApp.directive('code', [ '$http', function($http) {
			return {
				restrict : "E",
				replace : true,
				scope : {
					value : '@'
				},
				controller : function($scope, $element, $attrs) {
					$http({
						method : 'POST',
						url : '/codeconverter',
						responseType : 'text',
						params : {
							code : $attrs.value
						}
					}).then(function successCallback(response) {
						$scope.filterParams = response.data;
					}, function errorCallback(response) {
						console.log(response);
					});
				},
				template : "<span>{{filterParams}}</span>"
			}			
		}]);
			 
		//잡페어 참가하기 화면으로 이동
		function requestJobfairJoin() {
			window.location.href = '<c:url value="/fap/user/user_jobfair_apply_to_attend_form" />';
		}
		
		
		function readAd(fap_job_ad_seq,fap_jobfair_seq,fap_jobfair_divide_seq,fap_jobfair_title, category){
			url = encodeURI('/fap/user/mainpage_content_read?fap_job_ad_seq='+fap_job_ad_seq+'&fap_jobfair_seq='+fap_jobfair_seq+'&fap_jobfair_divide_seq='+fap_jobfair_divide_seq+'&fap_jobfair_title='+fap_jobfair_title);  								
			window.location.href = url;							 
		}
		
		
</script>
	
<body  ng-app="myapp" ng-controller="MainController" class="userMainBody">
	<input type="hidden" id="divide_session" value="${divide_session }">
	<%@include file="user_menu.jsp"%>
     <!-- W3C 이 문서는 HTML5 규약을 준수 합니다! -->
    <!--웹접근성/content로 이동-->
    <div class="skip-navigation">
        <p><a href="#main" class="goToMain">콘텐츠 바로가기</a></p>
    </div>

    <!-- content -->
    <div class="content" id="main">
    
      <!-- 메인 배너_ 슬라이딩 갤러리 -->
        <div class="swiper-container gallery">
            <ul class="swiper-wrapper slidePic">
            	<c:if test = "${pageContext.response.locale.language == 'ko'}">
                <li class="swiper-slide pic01"><a href="#"></a></li>
                </c:if>
                <c:if test = "${pageContext.response.locale.language == 'ja'}">
                <li class="swiper-slide pic01JA"><a href="#"></a></li>
                </c:if>
                <!-- <li class="swiper-slide pic02"><a href="#"></a></li> -->
            </ul>
            <div class="swiper-pagination pageWrap"></div>
        </div>
     
    
		<!-- 버튼 퀵 메뉴 -->
        <div class="quickMenuWrap btnWrap">
            <div class="btn-menu d-flex">
                <a href="#" class="menu-btn" id="userNotice">
                    <div class="img-icon bullhorn"  ></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.notice" /></div>
                </a>
                <a href="#" class="menu-btn" id="faqLink">
                    <div class="img-icon comments"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.faq" /></div>
                </a>
<!--                 <a href="#" class="menu-btn"> -->
<!--                     <div class="img-icon user"  id="sesUserService"></div> -->
<%--                     <div class="menu-txt fz16"><spring:message code="fap.main_menu.ses_user_service" /></div> --%>
<!--                 </a> -->
<!--                 <a href="#" class="menu-btn"> -->
<!--                     <div class="img-icon calendar-alt" id="2020FairSchedule"></div> -->
<%--                     <div class="menu-txt fz16"><spring:message code="fap.main_menu.2020fair_schedule" /></div> --%>
<!--                 </a> -->
                <a href="#" class="menu-btn" id="step">
                    <div class="img-icon chart-line"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.step" /></div>
                </a>
                <a href="#" class="menu-btn"   id="openJobInfo">
                    <div class="img-icon info-circle"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.jobinfo" /></div>
                </a>
                <a href="#" class="menu-btn" id="comp_partner">
                    <div class="img-icon handshake"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.companies" /></div>
                </a>
                <a href="#" class="menu-btn" id="internship">
                    <div class="img-icon user"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.internship" /></div>
                </a>
                <a href="http://rainbow.ac" class="menu-btn" id="empConnection">
                    <div class="img-icon globe"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.job.training.course" /></div>
                </a>
            </div>
        </div>

        <!-- 잡페어 참가 기업 -->
        <div class="fairWrapper">
            <div class="fairWrap">
                <header class="title h2 baseColor">
                    <spring:message code="fap.user_main_content.text08" />
                </header>
                
                <div class="fairListWrap">
                	<c:if test="${fap_mainpage_ct_imp_code eq '가'}">
                    <div class="subTitle bgcBase fz16"><spring:message code="fap.user_main_content.text10" /></div>
                    </c:if>
                    <c:if test="${fap_mainpage_ct_imp_code eq '나'}">
                    <div class="subTitle bgcBase fz16"><spring:message code="fap.user_main_content.text09" /></div>
                    </c:if>
                   <!-- <h2 style="text-align: center;">현재 모집중인 공고가 없습니다.</h2> -->
                    <ul class="fairList notIT d-flex">  
	                     <c:forEach items="${mainpage_ct_notIT }" var="item" begin="0" end="7" varStatus="status">
	                        <li class="list">
	                        		<c:choose>
		                        		<c:when test="${user_flag eq 'A0102'}">
		                        		</c:when>
		                        		<c:otherwise>
		                        			<a href="#" onclick="readAd('${item.fap_job_ad_seq}','${item.fap_jobfair_seq }','${item.fap_jobfair_divide_seq }','${item.fap_jobfair_title }','notIT')">
		                        		</c:otherwise>
	                        		</c:choose>
	                                <div class="logoImgWrap">
	                                <!-- 원래주석되던것임<img src="/fap/company/user_logo_image/${item.fap_comp_id }/${item.fap_comp_log_saved }" alt="기업로고이미지 230*80px" class="logo-img"> -->
	                                <div alt="기업로고이미지 230*80px" class="logo-img" style="background-image: url('/fap/company/user_logo_image/${item.fap_comp_id }/${item.fap_comp_log_saved }')" >&nbsp;</div>
	                                </div>
	                                <div class="occupation text-over" title="">
	                                   <c:forEach items="${item.fap_job_cate }" var="cate">										 
											 <c:choose>
												 <c:when test="${cate.fap_job_category_gb == 'C3704'}">
													 ${cate.fap_job_category_etc_dtl }
												 </c:when>
												 <c:otherwise>
													<code value="${cate.fap_job_category_gb }"></code>&nbsp;
												 </c:otherwise>
											 </c:choose>											 
										 </c:forEach>
	                                </div>
	                                <ul class="jobInfo">
	                                    <!-- 채용일정 -->
	                                   <li class="h5 c666">&#91;${item.fap_mainpage_ct_quarter }&#93;</li>
	                                    <!-- 위치 -->
	                                    <li class="d-flex">
	                                        <div class="img-icon"></div>
	                                        <span class="fz16">
												<c:forEach items="${item.fap_job_work }" var="work">
													 <code value="${work.fap_job_workplace_gb }"></code>&nbsp;
												</c:forEach>
											</span>
	                                    </li>
	                                    <!-- 채용예정인원 -->
	                                    <li class="d-flex">
	                                        <div class="img-icon"></div>
	                                        <span class="fz16">  
	                                        	<spring:message code="fap.mainpage.recruit" /> ${item.fap_job_ad_recruit_num }  <spring:message code="fap.mainpage.num" />
	                                        </span>
	                                    </li>
	                                </ul>
	                            </a>
	                            <c:if test="${status.index % 7== 0 && status.index != 0 && user_flag ne 'A0102'}">
	                            	<div  class="adListEtc" onclick='location.href="/fap/user/user_job_advertisement_list_form"'>VIEW MORE</div>
	                       		</c:if>
	                        </li>	                    
	                       </c:forEach>                        
                    </ul>
                </div>

                <div class="fairListWrap">
                    <c:if test="${fap_mainpage_ct_imp_code eq '나'}">
                    	<div class="subTitle bgcBase fz16"><spring:message code="fap.user_main_content.text10" /></div>
                    </c:if>
                   	<c:if test="${fap_mainpage_ct_imp_code eq '가'}">
						<div class="subTitle bgcBase fz16"><spring:message code="fap.user_main_content.text09" /></div>
					</c:if>
<%--                     <c:if test="${user_flag eq 'A0101' or user_flag eq 'A0102' or user_flag eq 'A0105' or user_flag eq 'A0106' or user_flag eq 'A0108'}"> --%>
						<ul class="fairList IT d-flex">
							<c:forEach items="${mainpage_ct_IT }" var="itemIT" begin="0" end="7" varStatus="status">
								<c:choose>
									<c:when test="${itemIT.fap_job_ad_allow_common_user_yn eq 'Y'}">
										<li class="list">
											<a href="#" onclick="readAd('${itemIT.fap_job_ad_seq}','${itemIT.fap_jobfair_seq }','${itemIT.fap_jobfair_divide_seq }','${itemIT.fap_jobfair_title }','IT')">
			                        			<div class="logoImgWrap">
				                                	<!-- 원래주석된것임 <img src="/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }" alt="기업로고이미지 230*80px" class="logo-img"> -->
				                                	<div alt="기업로고이미지 230*80px" class="logo-img" style="background-image: url('/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }')" >&nbsp;</div>
				                                </div>
				                                <div class="occupation text-over" title="">
				                                   	<c:forEach items="${itemIT.fap_job_cate }" var="cateIT">										 
														<c:choose>
															<c:when test="${cateIT.fap_job_category_gb == 'C3704'}">
																${cateIT.fap_job_category_etc_dtl }
															</c:when>
															<c:otherwise>
															 <code value="${cateIT.fap_job_category_gb }"></code>&nbsp;
															</c:otherwise>
														</c:choose>											 
													</c:forEach>
				                                </div>
				                                <ul class="jobInfo">
				                                    <!-- 채용일정 -->
				                                     <li class="h5 c666">&#91;${itemIT.fap_mainpage_ct_quarter }&#93;</li>
				                                    <!-- 위치 -->
				                                    <li class="d-flex">
				                                        <div class="img-icon"></div>
				                                        <span class="fz16">
				                                        	<c:forEach items="${itemIT.fap_job_work }" var="workIT">
																 <code value="${workIT.fap_job_workplace_gb }"></code>&nbsp;
															</c:forEach>
														</span>
				                                    </li>
				                                    <!-- 채용예정인원 -->
				                                    <li class="d-flex">
				                                        <div class="img-icon"></div>
				                                        <span class="fz16"> 
				                                        	<spring:message code="fap.mainpage.recruit" /> ${itemIT.fap_job_ad_recruit_num }  <spring:message code="fap.mainpage.num" />
				                                        </span>
				                                    </li>
				                                </ul>
				                            </a>
				                            <c:if test="${status.index % 7== 0 && status.index != 0 && user_flag ne 'A0102'}">
				                            	<div  class="adListEtc" onclick='location.href="/fap/user/user_job_advertisement_list_form"'>VIEW MORE</div>
				                       		</c:if>
										</li>
									</c:when>
									<c:when test="${user_flag eq 'A0101' or user_flag eq 'A0102' or user_flag eq 'A0105' or user_flag eq 'A0106' or user_flag eq 'A0108'}">
										<li class="list">
											<a href="#" onclick="readAd('${itemIT.fap_job_ad_seq}','${itemIT.fap_jobfair_seq }','${itemIT.fap_jobfair_divide_seq }','${itemIT.fap_jobfair_title }','IT')">
			                        			<div class="logoImgWrap">
				                                	<!-- 원래주석된것임 <img src="/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }" alt="기업로고이미지 230*80px" class="logo-img"> -->
				                                	<div alt="기업로고이미지 230*80px" class="logo-img" style="background-image: url('/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }')" >&nbsp;</div>
				                                </div>
				                                <div class="occupation text-over" title="">
				                                   	<c:forEach items="${itemIT.fap_job_cate }" var="cateIT">										 
														<c:choose>
															<c:when test="${cateIT.fap_job_category_gb == 'C3704'}">
																${cateIT.fap_job_category_etc_dtl }
															</c:when>
															<c:otherwise>
															 <code value="${cateIT.fap_job_category_gb }"></code>&nbsp;
															</c:otherwise>
														</c:choose>											 
													</c:forEach>
				                                </div>
				                                <ul class="jobInfo">
				                                    <!-- 채용일정 -->
				                                     <li class="h5 c666">&#91;${itemIT.fap_mainpage_ct_quarter }&#93;</li>
				                                    <!-- 위치 -->
				                                    <li class="d-flex">
				                                        <div class="img-icon"></div>
				                                        <span class="fz16">
				                                        	<c:forEach items="${itemIT.fap_job_work }" var="workIT">
																 <code value="${workIT.fap_job_workplace_gb }"></code>&nbsp;
															</c:forEach>
														</span>
				                                    </li>
				                                    <!-- 채용예정인원 -->
				                                    <li class="d-flex">
				                                        <div class="img-icon"></div>
				                                        <span class="fz16"> 
				                                        	<spring:message code="fap.mainpage.recruit" /> ${itemIT.fap_job_ad_recruit_num }  <spring:message code="fap.mainpage.num" />
				                                        </span>
				                                    </li>
				                                </ul>
				                            </a>
				                            <c:if test="${status.index % 7== 0 && status.index != 0 && user_flag ne 'A0102'}">
				                            	<div  class="adListEtc" onclick='location.href="/fap/user/user_job_advertisement_list_form"'>VIEW MORE</div>
				                       		</c:if>
										</li>
									</c:when>
								</c:choose>
<!-- 								<li class="list"> -->
<%-- 									<a href="#" onclick="readAd('${itemIT.fap_job_ad_seq}','${itemIT.fap_jobfair_seq }','${itemIT.fap_jobfair_divide_seq }','${itemIT.fap_jobfair_title }','IT')"> --%>
<!-- 	                        			<div class="logoImgWrap"> -->
<!-- 		                                	원래주석된것임 <img src="/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }" alt="기업로고이미지 230*80px" class="logo-img"> -->
<%-- 		                                	<div alt="기업로고이미지 230*80px" class="logo-img" style="background-image: url('/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }')" >&nbsp;</div> --%>
<!-- 		                                </div> -->
<!-- 		                                <div class="occupation text-over" title=""> -->
<%-- 		                                   	<c:forEach items="${itemIT.fap_job_cate }" var="cateIT">										  --%>
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${cateIT.fap_job_category_gb == 'C3704'}"> --%>
<%-- 														${cateIT.fap_job_category_etc_dtl } --%>
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<%-- 													 <code value="${cateIT.fap_job_category_gb }"></code>&nbsp; --%>
<%-- 													</c:otherwise> --%>
<%-- 												</c:choose>											  --%>
<%-- 											</c:forEach> --%>
<!-- 		                                </div> -->
<!-- 		                                <ul class="jobInfo"> -->
<!-- 		                                    채용일정 -->
<%-- 		                                     <li class="h5 c666">&#91;${itemIT.fap_mainpage_ct_quarter }&#93;</li> --%>
<!-- 		                                    위치 -->
<!-- 		                                    <li class="d-flex"> -->
<!-- 		                                        <div class="img-icon"></div> -->
<!-- 		                                        <span class="fz16"> -->
<%-- 		                                        	<c:forEach items="${itemIT.fap_job_work }" var="workIT"> --%>
<%-- 														 <code value="${workIT.fap_job_workplace_gb }"></code>&nbsp; --%>
<%-- 													</c:forEach> --%>
<!-- 												</span> -->
<!-- 		                                    </li> -->
<!-- 		                                    채용예정인원 -->
<!-- 		                                    <li class="d-flex"> -->
<!-- 		                                        <div class="img-icon"></div> -->
<!-- 		                                        <span class="fz16">  -->
<%-- 		                                        	<spring:message code="fap.mainpage.recruit" /> ${itemIT.fap_job_ad_recruit_num }  <spring:message code="fap.mainpage.num" /> --%>
<!-- 		                                        </span> -->
<!-- 		                                    </li> -->
<!-- 		                                </ul> -->
<!-- 		                            </a> -->
<%-- 		                            <c:if test="${status.index % 7== 0 && status.index != 0 && user_flag ne 'A0102'}"> --%>
<!-- 		                            	<div  class="adListEtc" onclick='location.href="/fap/user/user_job_advertisement_list_form"'>VIEW MORE</div> -->
<%-- 		                       		</c:if> --%>
<!-- 								</li> -->
							</c:forEach>
						</ul>
<%--                     </c:if> --%>
<%--                     	<c:forEach items="${mainpage_ct_IT }" var="itemIT" begin="0" end="7" varStatus="status"> --%>
<%--                           		<c:choose> --%>
<%--                         		<c:when test="${user_flag eq 'A0101' and user_flag eq 'A0102' and user_flag eq 'A0105' and user_flag eq 'A0106' and user_flag eq 'A0108'}"> --%>
<%-- 				                    <c:if test="${fap_mainpage_ct_imp_code eq '가'}"> --%>
<%-- 				                    	<div class="subTitle bgcBase fz16"><spring:message code="fap.user_main_content.text09" /></div> --%>
<%-- 				                    </c:if> --%>
<!-- 					                 <ul class="fairList IT d-flex"> -->
<!-- 				                        <li class="list"> -->
<%-- 		                        			<a href="#" onclick="readAd('${itemIT.fap_job_ad_seq}','${itemIT.fap_jobfair_seq }','${itemIT.fap_jobfair_divide_seq }','${itemIT.fap_jobfair_title }','IT')"> --%>
<!-- 		                        			<div class="logoImgWrap"> -->
<!-- 			                                	원래주석된것임 <img src="/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }" alt="기업로고이미지 230*80px" class="logo-img"> -->
<%-- 			                                	<div alt="기업로고이미지 230*80px" class="logo-img" style="background-image: url('/fap/company/user_logo_image/${itemIT.fap_comp_id }/${itemIT.fap_comp_log_saved }')" >&nbsp;</div> --%>
<!-- 			                                </div>   -->
<!-- 			                                <div class="occupation text-over" title=""> -->
<%-- 			                                   	<c:forEach items="${itemIT.fap_job_cate }" var="cateIT">										  --%>
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${cateIT.fap_job_category_gb == 'C3704'}"> --%>
<%-- 															${cateIT.fap_job_category_etc_dtl } --%>
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<%-- 														 <code value="${cateIT.fap_job_category_gb }"></code>&nbsp; --%>
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose>											  --%>
<%-- 												</c:forEach> --%>
<!-- 			                                </div> -->
<!-- 			                                <ul class="jobInfo"> -->
<!-- 			                                    채용일정 -->
<%-- 			                                     <li class="h5 c666">&#91;${itemIT.fap_mainpage_ct_quarter }&#93;</li> --%>
<!-- 			                                    위치 -->
<!-- 			                                    <li class="d-flex"> -->
<!-- 			                                        <div class="img-icon"></div> -->
<!-- 			                                        <span class="fz16"> -->
<%-- 			                                        	<c:forEach items="${itemIT.fap_job_work }" var="workIT"> --%>
<%-- 															 <code value="${workIT.fap_job_workplace_gb }"></code>&nbsp; --%>
<%-- 														</c:forEach> --%>
<!-- 													</span> -->
<!-- 			                                    </li> -->
<!-- 			                                    채용예정인원 -->
<!-- 			                                    <li class="d-flex"> -->
<!-- 			                                        <div class="img-icon"></div> -->
<!-- 			                                        <span class="fz16">  -->
<%-- 			                                        	<spring:message code="fap.mainpage.recruit" /> ${itemIT.fap_job_ad_recruit_num }  <spring:message code="fap.mainpage.num" /> --%>
<!-- 			                                        </span> -->
<!-- 			                                    </li> -->
<!-- 			                                </ul> -->
<!-- 			                            </a> -->
<%-- 			                            <c:if test="${status.index % 7== 0 && status.index != 0 && user_flag ne 'A0102'}"> --%>
<!-- 			                            	<div  class="adListEtc" onclick='location.href="/fap/user/user_job_advertisement_list_form"'>VIEW MORE</div> -->
<%-- 			                       		</c:if>	                            --%>
<!-- 			                        </li>                                             -->
<!-- 				                  </ul> -->
<%-- 		                        		</c:when> --%>
<%--                        		</c:choose>	                      --%>
                               
<%--                    	  </c:forEach>  --%>
                </div>
                <div class="fairListWrap">
                	<a href="/fap/user/user_board_content_list?board=internship">
                		<img src="/resources/segroup/society/fap/images/main/210420_BJF_internship_1920px.jpg" style="width: 100%;">
                	</a>
                </div>
            </div>
        </div>
    <!-- 안내 문구(개인 회원) -->
        <div class="userGuideWrap">
            <div class="userGuideBg">
                <header class="title h1 jua">참가안내</header>
            </div>
            <div class="userGuide">
                <article class="guideWrap">
                    <h2 class="subTitle h2">
                       <spring:message code="fap.user_main_content.text02" />
                    </h2>
                    <div class="guide d-flex">
	                    <c:if test = "${pageContext.response.locale.language == 'ko'}">
		                <div class="guide-banner"></div>
		                </c:if>
		                <c:if test = "${pageContext.response.locale.language == 'ja'}">
		                <div class="guide-bannerJA"></div>
		                </c:if>
                        
                        <div class="guide-text">
                            <p class="h4">
                                 <spring:message code="fap.user_main_content.text03" />
                                 <spring:message code="fap.user_main_content.text04" />
                            </p>
                            <h4 class="h4 baseColor">
                               <spring:message code="fap.user_main_content.text05" />
                            </h4>
                            <ul class="guideList">
                                <%-- <li>
                                     <spring:message code="fap.user_main_content.text06" />
                                </li> --%>
                                <li>
                                        <spring:message code="fap.user_main_content.text07" />
                                </li>
                                <li>
                                 <spring:message code="fap.user_main_content.text06_2" />
                                    <h5 class="h5">
                                       <spring:message code="fap.user_main_content.text06_3" />
                                    </h5>
                                </li>
                            </ul>
                            <button class="button bgcPoint" type="button"  id="registerNow"><spring:message code="fap.user_main_content.register_now" />
                            </button> 
                        </div>
                    </div>
                </article>
            </div>
        </div>
      </div>
    
       <%@include file="../common_footer_fap.jsp"%> 
		 	
</body>
</html>