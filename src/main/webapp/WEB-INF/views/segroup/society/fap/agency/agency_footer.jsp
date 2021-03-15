<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/main.footer.css" />">
</head>
<body>

<%-- 200521 이후 footer 
<div class="footerBody">
    <footer class="footer bgcDark">
        <div class="footer_wrap d-flex">
            <div class="footer_logo">
                <img class="logoImg" src="/resources/segroup/society/fap/images/main/footer_logo.png" alt="SES 기업로고">
                <img class="logoImg" src="/resources/segroup/society/fap/images/main/footer_fineLogo.png" alt="PineApple 기업로고">

            </div>
            <div class="footer_contents">
                <p class="corp-name">
                    <spring:message code="fap.footer.ses" />
                </p>
                <div class="footerTextWrap  d-flex">
                    <ul class="footer-left lh30">
                        <li><spring:message code="fap.footer.rep" /></li>
                        <li><spring:message code="fap.footer.business_num" /></li>
                        <li><spring:message code="fap.footer.ses_address" /></li>
                    </ul>
                    <ul class="footer-right lh30">
                        <li>
                            <a href="https://job.sesoc.global/fap/company/company_termccccs_and_condition_policy" target="_blank"><spring:message code="fap.footer.privacy.info.handling_policy" /></a>
                        </li>
                        <li><spring:message code="fap.footer.online_marketing_business_num" /></li>
                        <li><spring:message code="fap.footer.fee_charging_job_placement_service_num" /></li>
                    </ul>
                </div>
            </div>

        </div>
        <p class="copyright">
           <spring:message code="fap.footer.copyright" />
        </p>
    </footer>
    </div>
--%>    
    
<%-- 200521 이전 footer  --%>
<div class="footer">
	<div class="footer_wrap">
		<div class="footer_logo">
			<div class="footer_logo_imgWrap">
				<a href="<c:url value="https://www.softsociety.net/" />">
		    		<img src="/resources/segroup/society/fap/images/userOpenMain/footer_logo.png">
		    	</a>
		    	<img src="/resources/segroup/society/fap/images/userOpenMain/footer_fineLogo.png">
	    	</div>	
		</div>
		<div class="footer_contents">
			<div class="footer_menu">
				<ul>
					<li><a href="/fap/company/company_terms_and_condition_policy"><spring:message code="fap.footer.privacy.info.handling_policy" /></a></li>
					<li><a href=""><spring:message code="fap.footer.business_num" /></a></li>
					<li><a href=""><spring:message code="fap.footer.online_marketing_business_num" /></a></li>
					<li><a href=""><spring:message code="fap.footer.fee_charging_job_placement_service_num" /></a></li>
				</ul>
			</div>
			<div class="footer_desc">
				<ul>
					<li><spring:message code="fap.footer.ses" /></li>
					<li><spring:message code="fap.footer.ses_address" /></li>
                    <li><spring:message code="fap.footer.rep" /></li>
				</ul>
				<p><spring:message code="fap.footer.copyright" /></p>
			</div>
		</div>
	</div>
</div>

<!-- 운영에 적용할때는 주석을 제거해야 함 -->

<!-- <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script> -->

<!-- <script type="text/javascript">
	if(!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "215b38fd85e58";
	wcs_do();
</script> -->
</body>
</html>