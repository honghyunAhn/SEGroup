<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<script type="text/javascript">
$(function() {
	$('#logout').off("click").on("click",function() {
	    $('#logoutForm').submit();
	    return false;
	});
});
</script>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check"/>
</sec:authorize>

<form id="logoutForm" action="/edu/logout" method="post" style="display:none">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

<div class="header">
	<div class="header_mainlogo_ses">
<%-- 		<a href="/"><img src="<c:url value="/resources/ses/image/ses_logo.png" />"></a> --%>
		<a href="/"><img src="<c:url value="/resources/segroup/society/edu/image/sub/logo/logo.jpg" />" alt="main_logo" style="max-width:100%; height:50px;"></a>
	</div>
<!-- 	<div class="header_navimenu"> -->
<!-- 		<ul> -->
<!-- 			<li class=ico_global_language><a href="">LANGUAGE</a></li> -->
<!-- 		</ul> -->
<!-- 	</div> -->
</div>
<div class="mobile_header">
	<ul>
		<li class="mh_allmenu">
		<p><img src="<c:url value="/resources/segroup/society/edu/image/main/ico_hamburger.png" />"></p>
            <!-- 전체메뉴 -->
            <spring:message code="menu.menu_button_name" />
		</li>
		<li style="height: 98px;">
			<h1><a href="/"><img src="<c:url value="/resources/segroup/society/edu/image/sub/logo/logo_01.jpg" />" alt="main_logo" style="height: 98px;"></a></h1>
		</li>
	</ul>
</div>
<div class="hidden_hamburger">
	<dl class="hamb_wrap">
		<dd class="ham_first_step">
			<ul>
				<li class="ham_on">
					<p>Vision</p>
				</li>
				<li>
					<p>Business</p>
				</li>
				<li>
					<p>History</p>
				</li>									
				<li>
					<p>Language</p>
				</li>
			</ul>
		</dd>
		<dd class="ham_sec_step">
			<div class="ham_menu_con">
				<h1><spring:message code="menu.vision" /><span>X</span></h1>
				<ul>
					<li>
						<p><spring:message code="menu.vision_text" arguments=" " /></p>
						<div style="text-align: center;">
							<img src="<c:url value="/resources/ses/image/vision_sub.jpg" />" alt="" style="max-width:100%; max-height:100%; margin:20px"/>
						</div>
					</li>
<!-- 					<li><a style="text-decoration: none; color: black;"> 한국의 인적자원이 글로벌 기업에 진출하여 우수한 역량을 발휘할 수 있는 기회를 확장하고 -->
<!-- 상호 소통과 협력을 지원하는 네트워크 운영</a></li> -->
				</ul>
			</div>
			<div class="ham_menu_con">
				<h1><spring:message code="menu.business" /><span>X</span></h1>
				<ul>
					<li><a href="/hr">
                            <!-- 해외취업지원 -->
                            <spring:message code="menu.business_menu1" />
                    </a></li>
					<li class="photogal"><p>
                            <!-- 해외취업 인재양성 과정 -->
                            <spring:message code="menu.business_menu2" />
					</p>
						<ol class="photo_con_down">
								<li><a href="http://blog.naver.com/scitmaster">
                                        <!--  SC IT마스터 블로그 -->
                                        - <spring:message code="menu.business_menu_sub1" />
								</a></li>
								<li><a href="ictcenter">
                                        <!-- 사전학습반 -->
                                        - <spring:message code="menu.business_menu_sub2" />
								</a></li>
								<li><a href="http://www.itmasters.org">
                                        <!-- SC IT마스터 -->
                                        - <spring:message code="menu.business_menu_sub3" />
								</a></li>
						</ol>
					</li>
					<li><a href="http://www.etradecampus.com">
                           <!-- 스마트러닝 -->
                           <spring:message code="menu.business_menu3" />
					</a></li>
					<li><a href="/ictcenter">
                           <!-- 단기과정 -->
                           <spring:message code="menu.business_menu4" />
					</a></li>
					<li><a href="/test">
                           <!-- 시험센터 -->
                           <spring:message code="menu.business_menu5" />
					</a></li>
					<li><a href="/system">
                           <!-- SI -->
                           <spring:message code="menu.business_menu6" />
					</a></li>
				</ul>
			</div>
			<div class="ham_menu_con">
				<h1><spring:message code="menu.history" /><span>X</span></h1>
				<ul>
					<li>
                        <p><spring:message code="history_text01" /><br/>
                        <p><spring:message code="history_text02" /><br/>
                        <p><spring:message code="history_text03" /><br/>
                        <p><spring:message code="history_text04" /><br/>
                        <p><spring:message code="history_text05" /><br/>
                        <p><spring:message code="history_text06" /><br/>
                        <p><spring:message code="history_text07" /><br/>
                        <p><spring:message code="history_text08" /><br/>
                        <p><spring:message code="history_text09" /><br/>
                        <p><spring:message code="history_text10" /><br/>
                        <p><spring:message code="history_text11" /><br/>
                        <p><spring:message code="history_text12" /><br/>
                        <p><spring:message code="history_text13" /><br/>
                        <p><spring:message code="history_text14" /><br/>
                        <p><spring:message code="history_text15" /><br/>
                        <p><spring:message code="history_text16" /><br/>
                        <p><spring:message code="history_text17" /><br/>
                        <p><spring:message code="history_text18" /><br/>
                        <p><spring:message code="history_text19" /><br/>
                        <p><spring:message code="history_text20" /><br/>
                        <p><spring:message code="history_text21" /><br/>
                        <p><spring:message code="history_text22" /><br/>
                        <p><spring:message code="history_text23" /><br/>
                        <p><spring:message code="history_text24" /><br/>
                        <p><spring:message code="history_text25" /><br/>
                        <p><spring:message code="history_text26" /><br/>
                        <p><spring:message code="history_text27" /><br/>
                        <p><spring:message code="history_text28" /><br/>
                        <p><spring:message code="history_text29" /><br/>
                        <p><spring:message code="history_text30" /><br/>
                        <p><spring:message code="history_text31" /><br/>
                        <p><spring:message code="history_text32" /><br/>
                        <p><spring:message code="history_text33" /><br/>
                        <p><spring:message code="history_text34" /><br/>
<!-- 						<p>2017.11  광주전남 대학일자리센터 해외진출지원협의회 협력기관 MOU 협약 체결</p><br/> -->
<!-- 						<p>2017.11  제 4회 Soft Engineer Job Fair 개최 (Tokyo TKP 市ヶ谷, 11.20∼24)</p><br/> -->
<!-- 						<p>2017.08  2017년 산인공 민간 해외취업알선기관 승인</p><br/> -->
<!-- 						<p>2017.06  제3회 Soft Engineer Job Fair 개최 (Tokyo 神楽坂HC 스튜디오, 6.19∼23)</p><br/> -->
<!-- 						<p>2017.05  2017 서울시 청년 해외일자리 민관협력사업 수행기관 선정</p><br/> -->
<!-- 						<p>2017.05  한국산업기술대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원)</p><br/> -->
<!-- 						<p>2017.05  국민대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원)</p><br/> -->
<!-- 						<p>2017.04  금강대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원)</p><br/> -->
<!-- 						<p>2016.12  전남대학과 MOU체결 (글로벌ICT인재육성 및 해외취업지원)</p><br/> -->
<!-- 						<p>2016.12  원격평생교육시설 인가</p><br/> -->
<!-- 						<p>2016.11  제2회 Soft Engineer Job Fair 개최 (Tokyo TKP 永町田, 11.21∼25)</p><br/> -->
<!-- 						<p>2016.06  제1회 Soft Engineer Job Fair 개최 (Tokyo Haneda Turtle Service, 6.20∼24)</p><br/> -->
<!-- 						<p>2016.03  SESchool의 대외협력사업부문 분사 - 전담법인설립 (&lt;주&gt;Soft Engineer Society)</p><br/>  -->
<!-- 						<p> ㆍ해외취업알선, 글로벌ICT인재 육성대상자선발, 공인시험센터 등</p><br/>  -->
<!-- 						<p>2015.08  미래창조과학부 SW전문인력양성기관 지정</p><br/> -->
<!-- 						<p>2015.04  직업소개사업등록</p><br/> -->
<!-- 						<p>2014.12  최근5년간(2010∼14) 교육생 취업율 100% 달성</p><br/> -->
<!-- 						<p>2014.07  평생교육시설인가</p><br/> -->
<!-- 						<p>2013.04  Opic공인시험센터 지정</p><br/> -->
<!-- 						<p>2013.01  K-Move 스쿨 운영컨소시움 체결</p><br/> -->
<!-- 						<p>2011.01  한국무역협회 무역아카데미 ICT교육센터 운영기관지정</p><br/> -->
<!-- 						<p>2010.12  한국무역협회 통합연수시스템 개발 (PM 및 QA지원)</p><br/>  -->
<!-- 						<p>2010.11  소프트웨어사업자 등록</p><br/>  -->
<!-- 						<p>2008.11  무역진흥기여(글로벌인재양성) 국무총리 표창</p><br/>  -->
<!-- 						<p>2008.10  Prometric Loyal Partner Award 수상 </p><br/> -->
<!-- 						<p>2008.06  소프트웨어ㆍ외국어교육 평생직업교육학원 등록</p><br/> -->
<!-- 						<p>2007.08  ETS 공인 토플시험센터 지정</p><br/> -->
<!-- 						<p>2005.03  Sun Educational Service Partnership 체결</p><br/> -->
<!-- 						<p>2005.11  해외인력양성특수유공 산업자원부장관 표창</p><br/> -->
<!-- 						<p>2003.07  美 카네기멜론대(CMU) 석사과정 사전교육프로그램 설계ㆍ운영</p><br/> -->
<!-- 						<p>2002.09  프로메트릭(Prometric) 공인시험센터 지정</p><br/> -->
<!-- 						<p>2002.06  오라클 공인교육센터지정 (Oracle University)</p><br/> -->
<!-- 						<p>2001.12  창업(법인명변경 &lt;주&gt;에프앤텍 </p><br/> -->
<!-- 						<p> -&gt; &lt;주&gt;Soft Engineer School/16.3월부 ,</p><br/> -->
<!-- 						<p> 법인합병 &lt;주&gt;Soft Engineer Society로 기업합병/17.12월)</p> -->
					</li>
				</ul>
			</div>
			<div class="ham_menu_con">
				<h1>
				    <!-- 언어설정 -->
				    <spring:message code="menu.langage_title" />
				    <span>X</span>
				</h1>
				<ul>
					<li><a href="/changeLocale?lang=en">English</a></li>
					<li><a href="/changeLocale?lang=ja">日本語</a></li>
					<li><a href="/changeLocale?lang=ko">한국어</a></li>
				</ul>
			</div>
		</dd>
	</dl>
</div>
<div class="main_top_menu">
	<ul class="main_top_m">
		<li>
			<a href="/society_vision">Vision</a>
		</li>
		<li>
            <a>Business</a>
			<div class="depth2">
				<ul class="sublinks">
					<li>
                        <a href="/hr">
                            <!-- 해외취업지원 -->
                            <spring:message code="menu.business_menu1" />
                        </a></li>
					<li>
                        <a>
                            <!-- 해외취업 인재양성 과정 -->
                            <spring:message code="menu.business_menu2" />
                        </a>
							<ol class="photo_con_down">
								<li>
								    <a href="http://blog.naver.com/scitmaster">
								        <!--  SC IT마스터 블로그 -->
								        <spring:message code="menu.business_menu_sub1" />
								    </a>
								</li>
								<li>
								    <a href="/ictcenter">
								        <!-- 사전학습반 -->
								        <spring:message code="menu.business_menu_sub2" />
								    </a>
								</li>
								<li>
								    <a href="http://www.itmasters.org">
								        <!-- SC IT마스터 -->
								        <spring:message code="menu.business_menu_sub3" />
								    </a>
								</li>
							</ol>
					</li>
					<li>
					   <a href="http://www.etradecampus.com">
					       <!-- 스마트러닝 -->
					       <spring:message code="menu.business_menu3" />
					   </a>
					</li>
					<li>
					   <a href="/ictcenter">
					       <!-- 단기과정 -->
					       <spring:message code="menu.business_menu4" />
					   </a>
					</li>
					<li>
					   <a href="/test">
					       <!-- 시험센터 -->
					       <spring:message code="menu.business_menu5" />
					   </a>
					</li>
					<li>
					   <a href="/system">
					       <!-- SI -->
					       <spring:message code="menu.business_menu6" />
					   </a>
					</li>
				</ul>
			</div>
		</li> 
		<li>
			<a href="/society_history">History</a>
		</li>
		<li style="float:right;">
			<a>Language</a>
			<div class="depth2">
				<ul class="sublinks">
					<li style="float:right;">
						<a href="/changeLocale?lang=en">English</a>
					</li>
					<li style="float:right;">
						<a href="/changeLocale?lang=ja">日本語</a>
					</li>
					<li style="float:right;">
						<a href="/changeLocale?lang=ko">한국어</a>
					</li>
				</ul>
			</div>
		</li>
	</ul>
</div>
<div class="sub_top_hidden">
</div>