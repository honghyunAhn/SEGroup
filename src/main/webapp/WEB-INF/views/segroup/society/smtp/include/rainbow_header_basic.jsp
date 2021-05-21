<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">

	$(document).ready(function(){
		$('.logout').on("click", function() {
	         $('#logoutForm').submit();
	         return false;
	    });
	});
	
    function page_move(url, some_data) {
        var form = document.createElement("form");
        var input;

        form.action = url;
        form.method = "post";

        input = document.createElement("input");
        input.setAttribute("type", "hidden");
        input.setAttribute('name', "course_id");
        input.setAttribute("value", some_data);
        form.appendChild(input);
        
        document.body.appendChild(form);
        form.submit();
        form.remove();
    }
</script>
	<div class="headerWrap">
		<!-- rainbow_header_basic -->
		<header class="header d-flex justify_between">
		    <div class="img-icon bars-2line_bk" id="showNav"></div>
		    <h1 class="header-logo">
		        <a href="/rainbow" title="메인">
		            <!-- 웹용 로고 -->
		            <img class="logoImg" src="/resources/segroup/society/smtp/img/SES_logo-basic.png" alt="Soft Engineer Society">
		            <!-- 모바일용 로고 -->
		            <img src="/resources/segroup/society/smtp/img/SES_symbol_basic.png" alt="Soft Engineer Society" class="logoImg_mobile">
		        </a>
		    </h1>
		    <ul class="header-menu d-flex fz16 justify_end">
	<%-- 	    	<sec:authorize access="isAuthenticated()"> --%>
	<%-- 				<sec:authentication property="details" var="check" /> --%>
	<%-- 			</sec:authorize> --%>
	<%-- 			<c:choose> --%>
	<%-- 				<c:when test="${empty check }"> --%>
	<!-- 			        <li class="hdrMenu login fc_fff"><a href="/smtp/user/sub01-01">로그인</a></li> -->
	<!-- 			        <li class="hdrMenu join fc_eg"><a href="/smtp/user/sub01-02">회원가입</a></li> -->
	<%-- 				</c:when> --%>
	<%-- 				<c:otherwise> --%>
	<%-- 					<li class="hdrMenu userInfo fc_fff" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li> --%>
	<!-- 		            <li class="hdrMenu logout fc_fff"><a>로그아웃</a></li> -->
	<!-- 		            <li class="hdrMenu join fc_eg"><a href="/smtp/user/sub05-01">나의강의실</a></li> -->
	<%-- 				</c:otherwise> --%>
	<%-- 			</c:choose> --%>
				<c:choose>
					<c:when test="${sessionScope.user_id eq null}">
				        <li class="hdrMenu login"><a href="/smtp/user/sub01-01">로그인</a></li>
				        <li class="hdrMenu join point_fc01"><a href="/smtp/user/sub01-02">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<li class="hdrMenu userInfo" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li>
			            <li class="hdrMenu logout"><a>로그아웃</a></li>
			            <li class="hdrMenu join point_fc01"><a href="/smtp/user/sub05-01">나의강의실</a></li>
					</c:otherwise>
				</c:choose>
		    </ul>
		</header>
		<div class="fullWrapper">
	    <div class="full-navGroup">
	        <div class="d-flex justify_between">
	            <ul class="header-menu d-flex fz16 fc_fff">
	            
<%-- 	            	<c:choose> --%>
<%-- 	               		<c:when test="${empty check }"> --%>
<!-- 		                    <li class="hdrMenu login"><a href="/smtp/user/sub01-01">로그인</a></li> -->
<!-- 		                    <li class="hdrMenu join fc_eg"><a href="/smtp/user/sub01-02" class="">회원가입</a></li> -->
<%-- 	               		</c:when> --%>
<%-- 	               		<c:otherwise> --%>
<%-- 	               			<li class="hdrMenu userInfo fc_fff" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li> --%>
<!-- 				            <li class="hdrMenu logout fc_fff"><a>로그아웃</a></li> -->
				            <form id="logoutForm" action="/smtp/logout" method="post" style="display: none">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
<!-- 				            <li class="hdrMenu join margin-left20 fc_eg"><a href="/smtp/user/sub05-01">나의강의실</a></li> -->
<%-- 						</c:otherwise> --%>
<%-- 	               	</c:choose> --%>
					<c:choose>
						<c:when test="${sessionScope.user_id eq null}">
					        <li class="hdrMenu login fc_fff margin-right20"><a href="/smtp/user/sub01-01">로그인</a></li>
					        <li class="hdrMenu join fc_eg"><a href="/smtp/user/sub01-02">회원가입</a></li>
						</c:when>
						<c:otherwise>
							<li class="hdrMenu userInfo fc_fff margin-right20" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li>
				            <li class="hdrMenu logout fc_fff margin-right20"><a>로그아웃</a></li>
				            <li class="hdrMenu join fc_eg"><a href="/smtp/user/sub05-01">나의강의실</a></li>
						</c:otherwise>
					</c:choose>
	            </ul>
	            <div class="img-icon times-large-wh" id="hideNav"></div>
	        </div>
	        <div class="menuDivWrap d-flex fc_fff">
	            <ul class="menu-title-division">
	                <li class="gnb">IT 단기과정</li>
	                <li class="lnb"><a href="javascript:alert('준비중입니다.');">JAVA 기반 웹 개발자 과정</a></li>
	                <li class="lnb"><a href="javascript:alert('준비중입니다.');">파이썬 기초 과정</a></li>
<!-- 	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000538');" href="javascript:void(0);">AI 개요와 딥러닝 개념</a></li> -->
<!-- 	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000539');" href="javascript:void(0);">코딩한줄 없는 AI 활용</a></li> -->
<!-- 	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000535');" href="javascript:void(0);">입문 : 이제부터파이썬<br>- 딥러닝을 위한 파이썬 기초과정</a></li> -->
<!-- 	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000537');" href="javascript:void(0);">파이썬으로 배우는 데이터분석과 시각화</a></li> -->
<!-- 	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000540');" href="javascript:void(0);">파이썬을 이용한 웹 스크래핑</a></li> -->
<!-- 	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000536');" href="javascript:void(0);">파이썬기반 데이터 사이언스 기초</a></li> -->
<!-- 	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000545');" href="javascript:void(0);">(과정평가형)정보처리산업기사 자격 취득과정</a></li> -->
	            </ul>
	            <ul class="menu-title-division">
	                <li class="gnb">96% ICT 취업캠퍼스</li>
	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000543');" href="javascript:void(0);">SWDO 마스터 사전학습반</a></li>
	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526');" href="javascript:void(0);">SWDO 마스터</a></li>
<!-- 	                <li class="lnb"><a href="https://newtradecampus.kita.net/page/user_job_CloudIT_apply?course_category=JOBA&course_code=1498&class_seq=41&site_id=KITAACAD&viewMode=detail#appView_courseDetailView">SCIT 마스터</a></li> -->
	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525');" href="javascript:void(0);">SCIT 마스터</a></li>
	                
	            </ul>
	            <ul class="menu-title-division">
	                <li class="gnb">미국 인턴십</li>
	                <li class="lnb"><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000527');" href="javascript:void(0);">미 융복합 SW인력 양성과정</a></li>
	            </ul>
	            <ul class="menu-title-division">
	                <li class="gnb">취업 스킬업</li>
	                <li class="lnb"><a href="/smtp/course/short-term/short-term-info?course_id=c000000541">일본취업을 위한 JPT & SJPT</a></li>
	                <li class="lnb"><a href="/smtp/course/short-term/short-term-info?course_id=c000000544">일본취업 스킬업</a></li>
	            </ul>
	            <ul class="menu-title-division">
	                <li class="gnb">커뮤니티</li>
	                <li class="lnb"><a href="/smtp/community/sub04-01">공지사항</a></li>
	                <li class="lnb"><a href="/smtp/support/sub04-02">FAQ</a></li>
	                <li class="lnb"><a href="/smtp/support/sub04-04">QnA</a></li>
	                <li class="lnb"><a href="/smtp/community/sub04-05">졸업생 마당</a></li>
	                <li class="lnb"><a href="/smtp/support/sub04-03">오시는길</a></li>
	            </ul>
	            <ul class="menu-title-division">
	                <c:if test="${sessionScope.user_id ne null}">
		                <li class="gnb">나의강의실</li>
		                <li class="lnb"><a href="/smtp/user/sub05-01">학습현황</a></li>
		                <li class="lnb"><a href="/smtp/user/sub05-02">지원현황</a></li>
		                <li class="lnb"><a href="/smtp/user/sub05-03">서류발급</a></li>
		                <li class="lnb"><a href="/smtp/user/sub05-04">결제현황/환불</a></li>
		                <li class="lnb"><a href="/smtp/user/sub05-05">마일리지</a></li>
		                <li class="lnb"><a href="/smtp/user/sub05-06">개인정보수정</a></li>
	           		</c:if>
	            </ul>
	        </div>
	    </div>
	</div>
		
		<div class="header-menuWrap">
        <div class="point_bgTxt01">
            <ul class="header-menu d-flex justify_between">
                <li class="hdrMenu"><a href="#">IT 단기과정</a></li>
                <li class="hdrMenu">
                    <a href="#" class="highlightWrap">
                        <span class="highlight h5 point_fc01">96%</span>
                        <span class="highlightTxt">ICT 취업캠퍼스</span>
                    </a>
                </li>
                <li class="hdrMenu"><a href="#">미국인턴십</a></li>
                <li class="hdrMenu"><a href="#">취업 스킬업</a></li>
                <li class="hdrMenu"><a href="#">커뮤니티</a></li>
                <c:if test="${sessionScope.user_id ne null}">
                	<li class="hdrMenu"><a href="#">나의강의실</a></li>
                </c:if>
            </ul>
        </div>
        <div class="header-subMenuWrap d-flex justify_between">
            <ul class="header-subMenu">
            	<li class="hdrSubMenu"><a href="javascript:alert('준비중입니다.');">JAVA 기반 웹 개발자과정</a></li>
                <li class="hdrSubMenu"><a href="javascript:alert('준비중입니다.');">파이썬 기초 과정</a></li>
<!--                 <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000538');" href="javascript:void(0);">AI 개요와 딥러닝 개념</a></li> -->
<!--                 <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000539');" href="javascript:void(0);">코딩한줄 없는 AI 활용</a></li> -->
<!--                 <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000535');" href="javascript:void(0);">입문 : 이제부터파이썬<br>- 딥러닝을 위한 파이썬 기초과정</a></li> -->
<!--                 <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000537');" href="javascript:void(0);">파이썬으로 배우는 데이터분석과 시각화</a></li> -->
<!--                 <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000540');" href="javascript:void(0);">파이썬을 이용한 웹 스크래핑</a></li> -->
<!--                 <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000536');" href="javascript:void(0);">파이썬기반 데이터 사이언스 기초</a></li> -->
<!--                 <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000545');" href="javascript:void(0);">(과정평가형)정보처리산업기사 자격 취득과정</a></li> -->
            </ul>
            <ul class="header-subMenu">
            	<li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000543');" href="javascript:void(0);">SWDO 마스터 사전학습반</a></li>
                <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526');" href="javascript:void(0);">SWDO 마스터</a></li>
                <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525');" href="javascript:void(0);">SCIT 마스터</a></li>
            </ul>
            <ul class="header-subMenu">
                <li class="hdrSubMenu"><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000527');" href="javascript:void(0);">美 융복합 SW인력 양성과정</a></li>
            </ul>
            <ul class="header-subMenu">
                <li class="hdrSubMenu"><a href="/smtp/course/short-term/short-term-info?course_id=c000000541">일본취업을 위한 JPT & SJPT</a></li>
                <li class="hdrSubMenu"><a href="/smtp/course/short-term/short-term-info?course_id=c000000544">일본취업 스킬업</a></li>
            </ul>
            <ul class="header-subMenu">
                <li class="hdrSubMenu"><a href="/smtp/community/sub04-01">공지사항</a></li>
                <li class="hdrSubMenu"><a href="/smtp/support/sub04-02">FAQ</a></li>
                <li class="hdrSubMenu"><a href="/smtp/support/sub04-04">QnA</a></li>
                <li class="hdrSubMenu"><a href="/smtp/community/sub04-05">졸업생 마당</a></li>
                <li class="hdrSubMenu"><a href="/smtp/support/sub04-03">오시는길</a></li>
            </ul>
            <c:if test="${sessionScope.user_id ne null}">
            	<ul class="header-subMenu">
            		<li class="hdrSubMenu"><a href="/smtp/user/sub05-01">학습현황</a></li>
	                <li class="hdrSubMenu"><a href="/smtp/user/sub05-02">지원현황</a></li>
	                <li class="hdrSubMenu"><a href="/smtp/user/sub05-03">서류발급</a></li>
	                <li class="hdrSubMenu"><a href="/smtp/user/sub05-04">결제현황/환불</a></li>
	                <li class="hdrSubMenu"><a href="/smtp/user/sub05-05">마일리지</a></li>
	                <li class="hdrSubMenu"><a href="/smtp/user/sub05-06">개인정보수정</a></li>
	            </ul>
            </c:if>
        </div>
    </div>
</div>