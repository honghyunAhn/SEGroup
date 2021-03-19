<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Bridge Job Fair</title>
<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/fa_style.css" />">
<script type="text/javascript">
$(function(){			
	
	 //채용하러 가기 - 잡페어 신청 게시판으로 이동
	  var registerNow = $("#hireNow");
	  registerNow.on('click',function(){
	  location.href="/fap/company/company_jobfair_apply_to_attend_form";
	  })				 

	  //공지사항 게시판으로 이동
	  var userNotice = $("#companyNotice");
	  userNotice.on('click',function(){
		  location.href= "/fap/company/company_board_content_list?board=notice";
	  })

	  //FAQ로 이동
	  var faqLink = $("#faqLink");
	  faqLink.on('click',function(){
		  location.href= "/fap/company/company_faq?page="+1+"&fap_faq_gb_cd="+"C5301";
	  })	
	  
	  /* //SES회원서비스(작업중)
	  var sesUserService = $("#sesUserService");
	  sesUserService.on('click',function(){
		 alert('<spring:message code="fap.main.under_construction"/>');
		 //  location.href= "/fap/company/company_ses_user_service";
	  }) */	
	  
	  /* //2020 Fair 일정(작업중)
	  var FairSchedule = $("#2020FairSchedule");
	    FairSchedule.on('click',function(){
		  alert('<spring:message code="fap.main.under_construction"/>');
		  // location.href= "/fap/company/company_2020_fair_schedule";
	  }) */	
	  
	  //전형절차(작업중)
	  var step = $("#step");
	  step.on('click',function(){
		   alert('<spring:message code="fap.main.under_construction"/>');
		   // location.href= "/fap/company/company_step";	
	  })	
	  
	  /* //취업정보&전략 게시판으로 이동
	  var openJobInfo =$("#openJobInfo");
	  openJobInfo.on('click',function(){
		  location.href = "/fap/company/company_board_content_list?board=jobinfo";
	  }) */

	  //채용기업&파트너사(작업중)
	  var companies = $("#companies");
	  companies.on('click',function(){				
		    location.href= "/fap/company/company_comps_and_partners";	
	  })	
	  
	  /* //취업연계과정(작업중)
	  var empConnection  = $("#empConnection");
	  empConnection.on('click',function(){				
		  alert('<spring:message code="fap.main.under_construction"/>');
	  }) */
	  
		var popupCount = 0;
	  
	//팝업
	$.ajax({
		url : '/fap/company/company_popup_check'
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
	  
})	
</script>
</head>
<body>
	<div class="content" id="main">
		<div class="quickMenuWrap btnWrap">
			<div class="btn-menu d-flex">
				<a href="#" class="menu-btn" id="companyNotice">
					<div class="img-icon bullhorn"></div>
					<div class="menu-txt fz16">
						<spring:message code="fap.main_menu.notice" />
					</div>
				</a> <a href="#" class="menu-btn" id="faqLink">
					<div class="img-icon comments"></div>
					<div class="menu-txt fz16">
						<spring:message code="fap.main_menu.faq" />
					</div>
				</a>
				<%-- <a href="#" class="menu-btn" id="sesUserService">
                    <div class="img-icon user" ></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.ses_user_service" /></div>
                </a> --%>
				<%-- <a href="#" class="menu-btn" id="2020FairSchedule">
                    <div class="img-icon calendar-alt"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.2020fair_schedule" /></div>
                </a> --%>
				<a href="#" class="menu-btn" id="step">
					<div class="img-icon chart-line"></div>
					<div class="menu-txt fz16">
						<spring:message code="fap.main_menu.step" />
					</div>
				</a>
				<%--  <a href="#" class="menu-btn"  id="openJobInfo">
                    <div class="img-icon info-circle"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.jobinfo" /></div>
                </a> --%>
				<a href="#" class="menu-btn" id="companies">
					<div class="img-icon handshake"></div>
					<div class="menu-txt fz16">
						<spring:message code="fap.main_menu.companies" />
					</div>
				</a>
				<%-- <a href="#" class="menu-btn"  id="empConnection">
                    <div class="img-icon globe"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.job.training.course" /></div>
                </a> --%>
			</div>
		</div>
	</div>
</body>
</html>