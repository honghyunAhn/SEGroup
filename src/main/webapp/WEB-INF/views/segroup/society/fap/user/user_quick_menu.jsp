<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/fa_style.css" />">
<title>Insert title here</title>
<script type="text/javascript">
	
	$(function() {
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
  });	
			 
		//잡페어 참가하기 화면으로 이동
		function requestJobfairJoin() {
			window.location.href = '<c:url value="/fap/user/user_jobfair_apply_to_attend_form" />';
		}
		
		
		function readAd(fap_job_ad_seq,fap_jobfair_seq,fap_jobfair_divide_seq,fap_jobfair_title){
				url = encodeURI('/fap/user/mainpage_content_read?fap_job_ad_seq='+fap_job_ad_seq+'&fap_jobfair_seq='+fap_jobfair_seq+'&fap_jobfair_divide_seq='+fap_jobfair_divide_seq+'&fap_jobfair_title='+fap_jobfair_title);  								
				window.location.href = url;							 
		}
		
		
</script>
</head>
<body>
	<div class="content" id="main">
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
                <a href="http://rainbow.ac" class="menu-btn" id="empConnection">
                    <div class="img-icon globe"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.job.training.course" /></div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>