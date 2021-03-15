<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/main.footer.css" />">
<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/kakao.css" />">
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-YYRQ5XMKQN"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	
	  gtag('config', 'G-YYRQ5XMKQN');
	</script>
</head>
<body>

<%-- 200521이후 footer 
<div class="footer">
	<div class="footer_wrap">
	
		<a href="javascript:void plusFriendChat()">
		  <img class="kakaotalk-fixed" src="https://developers.kakao.com/assets/img/about/logos/plusfriend/consult_small_yellow_pc.png" alt="카카오톡 채팅상담" title="채팅상담" />
		</a>
		<div class="footer_logo">
			<div class="footer_logo_imgWrap">
		    	<img src="/resources/segroup/society/fap/images/userOpenMain/footer_logo.png">
		    	<img src="/resources/segroup/society/fap/images/userOpenMain/footer_fineLogo.png">
	    	</div>	
		</div>
		<div class="footer_contents">
			<div class="footer_menu">
				<ul>
					<li><a href="/fap/agency/agency_terms_and_condition_policy"><spring:message code="fap.footer.privacy.info.handling_policy" /></a></li>
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
				<p>
					<spring:message code="fap.footer.copyright" />
				</p>
			</div>
		</div>
	</div>
</div>
--%>

<%-- 200521 이전 footer  --%>
	<div class="footer">
		<div class="footer_wrap">
		<a href="javascript:void plusFriendChat()">
		  <img class="kakaotalk-fixed" src="https://developers.kakao.com/assets/img/about/logos/plusfriend/consult_small_yellow_pc.png" alt="카카오톡 채팅상담" title="채팅상담" />
		</a>
		
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

<!-- <script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>

<script type="text/javascript">
	if(!wcs_add) var wcs_add = {};
	wcs_add["wa"] = "215b38fd85e58";
	wcs_do();
</script> -->

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('0a2be72636126326e38e6e491518d271');
    function plusFriendChat() {
      Kakao.PlusFriend.chat({
        plusFriendId: '_xawxkxbT' // 플러스친구 홈 URL에 명시된 id로 설정합니다.
      });
    }
  //]]>
</script>
</body>
</html>