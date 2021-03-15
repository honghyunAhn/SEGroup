<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
   $(function() {
      $('#logoutPc').off("click").on("click", function() {
         $('#logoutForm').submit();
         return false;
      });

      init();
      
      function init(){

/* ------------------네비게이션 탭 화면세팅변수--------------------- */    	  
    	var itParentList = new Array();				// IT
    	var itSonList = new Array();				
    	var foreignParentList = new Array();		// 외국어
    	var foreignSonList = new Array();
    	var businessParentList = new Array();		// 직무역량
    	var businessSonList = new Array();
    	var jobtrainingParentList = new Array();
    	var jobtrainingSonList = new Array();
    	var licenseParentList = new Array();		// 자격증
    	var licenseSonList = new Array();
    	var jobMarketParentList = new Array();		// 잡마켓
    	var jobMarketSonList = new Array();
    	var toeflParentList = new Array();		// 모의토플
    	var toeflSonList = new Array();

     	<c:forEach var="courseList" items="${courseList}">
    		if(${courseList.grand == "ICT"}){
        		itSonList.push({
        			parent : "${courseList.parent}",
        			son : "${courseList.son}"
        		});
        		if(!itParentList.includes("${courseList.parent}")){
					itParentList.push("${courseList.parent}")
				}        	        	        			
    		}
    		if(${courseList.grand == "외국어"}){
        		foreignSonList.push({
        			parent : "${courseList.parent}",
        			son : "${courseList.son}"
        		});
        		if(!foreignParentList.includes("${courseList.parent}")){
					foreignParentList.push("${courseList.parent}")
				}		
    		}
    		if(${courseList.grand == "직무역량"}){
        		businessSonList.push({
        			parent : "${courseList.parent}",
        			son : "${courseList.son}"
        		});
        		if(!businessParentList.includes("${courseList.parent}")){
					businessParentList.push("${courseList.parent}")
				}        	        	        			
    		}
    		if(${courseList.grand == "자격증"}){
        		licenseSonList.push({
        			parent : "${courseList.parent}",
        			son : "${courseList.son}"
        		});
        		if(!licenseParentList.includes("${courseList.parent}")){
        			licenseParentList.push("${courseList.parent}")
				}        	        	        			
    		}
    		if(${courseList.grand == "JOB-Market"}){
        		jobMarketSonList.push({
        			parent : "${courseList.parent}",
        			son : "${courseList.son}"
        		});
        		if(!jobMarketParentList.includes("${courseList.parent}")){
					jobMarketParentList.push("${courseList.parent}")
				}        	        	        			
    		}
    		if(${courseList.grand == "모의토플"}){
    			toeflSonList.push({
        			parent : "${courseList.parent}",
        			son : "${courseList.son}"
        		});
        		if(!toeflParentList.includes("${courseList.parent}")){
        			toeflParentList.push("${courseList.parent}")
				}        	        	        			
    		}
    	</c:forEach>		
    	setMobileTabs(itParentList, itSonList, '1', 'mobileItCate');		
		setMobileTabs(foreignParentList, foreignSonList, '2', 'mobileForeignCate');		
		setMobileTabs(businessParentList, businessSonList, '3', 'mobileBusinessCate');		
		setMobileTabs(licenseParentList, licenseSonList, '4', 'mobileLicenseCate');
		setMobileTabs(jobMarketParentList, jobMarketSonList, '5', 'mobileJobMarketCate');
		setMobileTabs(jobtrainingParentList, jobtrainingSonList, '6', 'mobileJobtrainingCate');		
		setMobileTabs(toeflParentList, toeflSonList, '7', 'mobileToeflCate');
   	
    	setNav(itParentList, '1');	 
    	setNav(foreignParentList, '2');	 
    	setNav(businessParentList, '3');	 
    	setNav(licenseParentList, '4');
    	setNav(jobMarketParentList, '5');
    	setNav(jobtrainingParentList, '6');	
    	setNav(toeflParentList, '7');

    	
    	setWebTabs(itParentList, '1', 'webItCate');
		setWebTabs(foreignParentList, '2', 'webForeignCate');
		setWebTabs(businessParentList, '3', 'webBusinessCate');
		setWebTabs(licenseParentList, '4', 'webLicenseCate');
		setWebTabs(jobMarketParentList, '5', 'webJobMarketCate');
		setWebTabs(jobtrainingParentList, '6', 'webJobtrainingCate');
		setWebTabs(toeflParentList, '7', 'webToeflCate');

/*         var fileref=document.createElement("link");
        fileref.setAttribute("rel", "stylesheet");
        fileref.setAttribute("type", "text/css");
        fileref.setAttribute("href", '<c:url value="/resources/lms/css/style_responsive.css" />');	 */


      }
		
	function setNav(parentList, flag){

		var comment = "";

		$.each(parentList, function(index, parent){

			switch (flag) {
			  case '1':
	  			comment += '<li><a href="/lms/course/it/sub01-01?parent_menu=' + parent + '">' + parent +'</a></li>';				
			    break;
			  case '2':
	  			comment += '<li><a href="/lms/course/foreign/sub02-01?parent_menu=' + parent + '">' + parent +'</a></li>';				
			    break;
			  case '3':
	  			comment += '<li><a href="/lms/course/business/sub03-01?parent_menu=' + parent + '">' + parent +'</a></li>';				
			    break;
			  case '4':
		  		comment += '<li><a href="/lms/course/license/sub05-01?parent_menu=' + parent + '">' + parent +'</a></li>';				
				break;
			  case '5':
		  		comment += '<li><a href="/lms/course/jobmarket/sub06-01?parent_menu=' + parent + '">' + parent +'</a></li>';				
				break;
			  case '6':
	  			comment += '<li><a href="/lms/course/jobtraining/sub04-01?parent_menu=' + parent + '">' + parent +'</a></li>';				
				break;
			  case '7':
		  		comment += '<li><a href="/lms/course/toefl/sub_toefl?parent_menu=' + parent + '">' + parent +'</a></li>';				
				break;		
			  default :
				break;
			}	
		});    

		switch (flag) {
		  case '1':
			$('.navIt').html(comment);
		    break;
		  case '2':
			$('.navForeign').html(comment);
		    break;
		  case '3':
			$('.navBusiness').html(comment);
		    break;
		  case '4':
			$('.navLicense').html(comment);
			break;
		  case '5':
			$('.navJobMarket').html(comment);
			break;
		  case '6':
			$('.navJobtraining').html(comment);
			break;
		  case '7':
			$('.navToefl').html(comment);
			break;
		  default :
			break;

		}	
	}      

	function setWebTabs(parentList, flag, className){

		var menuHtml = '';

 		$.each(parentList, function(index, parent){
		
			menuHtml += '<li class="lnb">';

			if(flag=='1'){  
				menuHtml += '<a href="/lms/course/it/sub01-01?parent_menu=' + parent +'">' + parent + '</a>';				
			} else if(flag=='2'){
				menuHtml += '<a href="/lms/course/foreign/sub02-01?parent_menu=' + parent +'">' + parent + '</a>';								
			} else if(flag=='3'){
				menuHtml += '<a href="/lms/course/business/sub03-01?parent_menu=' + parent +'">' + parent + '</a>';
			} else if(flag=='4'){
				menuHtml += '<a href="/lms/course/license/sub05-01?parent_menu=' + parent +'">' + parent + '</a>';				
			} else if(flag=='5'){
				menuHtml += '<a href="/lms/course/jobmarket/sub06-01?parent_menu=' + parent +'">' + parent + '</a>';				
			} else if(flag=='6'){
				menuHtml += '<a href="/lms/course/jobtraining/sub04-01?parent_menu=' + parent +'">' + parent + '</a>';								
			} else {
				menuHtml += '<a href="/lms/course/toefl/sub_toefl?parent_menu=' + parent +'">' + parent + '</a>';
			}

		    menuHtml += '</li>';   	            
		});    
	
		$(menuHtml).insertAfter("." + className);

	}
	
	function setMobileTabs(parentList, sonList, flag, className){

		var menuHtml = '';

 		$.each(parentList, function(index, parent){
		
			menuHtml += '<li class="lnb fz14 manualMove">' + parent;
			menuHtml += '<div class="img-icon angle-right"></div>';								
			menuHtml += '<ul class="menu-sub ">';

		    $.each(sonList, function(index, parSon){
	
		    	if(parent == parSon.parent){						

					if(flag=='1'){
			    		menuHtml += '<li><a href="/lms/course/it/sub01-01?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';                                     
					} else if(flag=='2'){
			    		menuHtml += '<li><a href="/lms/course/foreign/sub02-01?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';                                     
					} else if(flag=='3'){
			    		menuHtml += '<li><a href="/lms/course/business/sub03-01?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';                                     
					} else if(flag=='4'){
			    		menuHtml += '<li><a href="/lms/course/license/sub05-01?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';
					} else if(flag=='5'){
			    		menuHtml += '<li><a href="/lms/course/jobmarket/sub06-01?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';
					} else if(flag=='6'){
			    		menuHtml += '<li><a href="/lms/course/jobtraining/sub04-01?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';                                     
					} else {
						menuHtml += '<li><a href="/lms/course/toefl/sub_toefl?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';
					}

		    	}                	                	
		    });                
		    menuHtml += '</ul>';
		    menuHtml += '</li>';   	            
		});    

 		
		$(menuHtml).insertAfter("." + className);
/* 
        var head = document.getElementsByTagName('HEAD')[0];  
  
        var link = document.createElement('link'); 
  
        link.rel = 'stylesheet';  
        link.type = 'text/css'; 
        link.href = '<c:url value="/resources/lms/css/style_responsive.css" />';  
        head.appendChild(link);  		 */
/*          link.href = '<c:url value="/resources/lms/css/style.css" />';  
        head.appendChild(link);  		          */
	}	

	//css 처리가 안되니까 임시방편으로 처리
/* 	$('.manualMove').on('click', function(){
		$('.manualMove').each(function(){
			$(this).children('.menu-sub').css('display', 'none');
			$(this).children('.img-icon').removeClass('angle-down').addClass('angle-right');			
		});

		var check = $(this).children('.img-icon').prop('class');

		$(this).children('.img-icon').removeClass('angle-right').addClass('angle-down');
		$(this).children('.menu-sub').css('display', 'block');
		
	}); */

   
   });
</script>

<!-- 00. 콘텐츠 바로가기(웹 접근성) -->
<div class="skip-navigation">
	<p><a class="goToMain" href="/lms/main">콘텐츠 바로가기</a></p>
</div>
<div class="fullWrapper">
	<div class="full-background">
		<div class="full-navGroup">
			<div class="img-icon close times"></div>
			
			<div class="mobile-menuWrap d-flex">
<!-- 				<div clas="mobile-menu"></div> -->
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="details" var="check" />
				</sec:authorize>
				<form id="logoutForm" action="/lms/user/logout" method="post" style="display: none">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				<!-- login시 .login_after 활성화, logout시 .login_before 활성화 -->
				<c:choose>
					<c:when test="${empty check }">
						<ul class="header-menu d-flex login_before">
							<li class="hdrMenu login"><a href="/lms/user/sub00-01">로그인</a></li>
							<li class="hdrMenu hdrMenu_emph join"><a href="/lms/user/sub00-02" class="bgc_yeL">회원가입</a>
								<div class="join_sub bgc_333">
									<a href="#">가입시 5,000마일리지 혜택</a>
								</div>
							</li>
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="header-menu d-flex login_after">
							<li class="userInfo" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li>
							<li class="hdrMenu logout" id="logout">로그아웃</li>
							<li class="hdrMenu hdrMenu_emph myCampus"><a href="/lms/user/sub07-01-01" class="bgc_orD">마이캠퍼스</a></li>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="menuDivWrap d-flex flexWrap">
				<ul class="menu-title-division">
					<li class="gnb webItCate"><a href="/lms/course/it/sub01-01">디지털·AI</a></li>
				</ul>
				<ul class="menu-title-division">
					<li class="gnb webForeignCate"><a href="/lms/course/foreign/sub02-01">외국어</a></li>
				</ul>
				<ul class="menu-title-division">
					<li class="gnb webBusinessCate"><a href="/lms/course/business/sub03-01">직무</a></li>
				</ul>
				<ul class="menu-title-division">
					<li class="gnb webLicenseCate"><a href="/lms/course/license/sub05-01">자격증</a></li>
				</ul>
				<ul class="menu-title-division">
					<li class="gnb webToeflCate"><a href="/lms/course/toefl/sub_toefl">모의토플</a></li>
				</ul>
				<!-- <ul class="menu-title-division">
					<li class="gnb webJobMarketCate"><a href="/lms/course/jobmarket/sub06-01">JOB-Market</a></li>
				</ul> -->
				<ul class="menu-title-division">
					<li class="gnb"><a href="/lms/community/sub05-01-01">커뮤니티</a></li>
					<li class="lnb"><a href="/lms/community/sub05-01-01">공지사항</a></li>
					<li class="lnb"><a href="/lms/community/sub05-01-02">이벤트</a></li>
				</ul>
				<ul class="menu-title-division">
					<li class="gnb"><a href="/lms/support/sub06-01-01">고객센터</a></li>
					<li class="lnb"><a href="/lms/support/sub06-01-01">고객지원</a></li>
					<li class="lnb"><a href="/lms/support/sub06-02">FAQ</a></li>
					<li class="lnb"><a href="/lms/support/sub06-03">단체/제휴문의</a></li>
					<li class="lnb"><a href="/lms/support/sub06-04">오시는길</a></li>
				</ul>
				<ul class="menu-title-division">
					<li class="gnb"><a href="/lms/user/sub07-01">나의강의실</a></li>
					<li class="lnb"><a href="/lms/user/sub07-01-01">학습현황</a></li>
					<li class="lnb"><a href="/lms/user/sub07-02">결제현황/환불</a></li>
					<li class="lnb"><a href="/lms/user/sub07-03">마일리지</a></li>
					<li class="lnb"><a href="/lms/user/sub07-04">개인정보수정</a></li>
					<li class="lnb"><a href="/lms/user/sub07-05">회원탈퇴</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- Header -->
<div class="hdrContainer mainPage_header">
	<header class="headerWrapper mainHeader">
		<div class="hdrWrap">
			<div class="header d-flex justify_between">
				<h1 class="header-logo">
					<a href="/lms/main" title="메인"> <img
						src="/resources/lms/img/DIC_logo_bk.png" alt="두잇캠퍼스로고">
					</a>
				</h1>
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="details" var="check" />
				</sec:authorize>
				<form id="logoutForm" action="/lms/user/logout" method="post" style="display: none">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				<!-- login시 .login_after 활성화, logout시 .login_before 활성화 -->
				<c:choose>
					<c:when test="${empty check }">
						<ul class="header-menu d-flex login_before">
							<li class="hdrMenu login"><a href="/lms/user/sub00-01">로그인</a></li>
							<li class="hdrMenu hdrMenu_emph join"><a href="/lms/user/sub00-02" class="bgc_yeL">회원가입</a>
								<div class="join_sub bgc_333">
									<a href="#">가입시 5,000마일리지 혜택</a>
								</div>
							</li>
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="header-menu d-flex login_after">
							<li class="userInfo" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li>
							<li class="hdrMenu logout" id="logoutPc">로그아웃</li>
							<li class="hdrMenu hdrMenu_emph myCampus"><a href="/lms/user/sub07-01-01" class="bgc_orD">마이캠퍼스</a></li>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="hdrWrap hdrWrap_responsive">
			<div class="header d-flex justify_between">
				<h1 class="header-logo">
					<a href="/lms/main" title="메인"> <img
						src="/resources/lms/img/DIC_logo_bk.png" alt="두잇캠퍼스로고">
					</a>
				</h1>
				<%-- <sec:authorize access="isAuthenticated()">
					<sec:authentication property="details" var="check" />
				</sec:authorize>
				<form id="logoutForm" action="/lms/user/logout" method="post" style="display: none">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				<!-- login시 .login_after 활성화, logout시 .login_before 활성화 -->
				<c:choose>
					<c:when test="${empty check }">
						<ul class="header-menu d-flex login_before">
							<li class="hdrMenu login"><a href="/lms/user/sub00-01">로그인</a></li>
							<li class="hdrMenu hdrMenu_emph join"><a href="/lms/user/sub00-02" class="bgc_yeL">회원가입</a>
								<div class="join_sub bgc_333">
									<a href="#">가입시 5,000마일리지 혜택</a>
								</div>
							</li>
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="header-menu d-flex login_after">
							<li class="hdrMenu logout" id="logout">로그아웃</li>
							<li class="hdrMenu hdrMenu_emph myCampus"><a href="/lms/user/sub07-01-01" class="bgc_orD">마이캠퍼스</a></li>
						</ul>
					</c:otherwise>
				</c:choose> --%>
				<div class="menu-btn fullNav">
					<div class="img-icon bars"></div>
				</div>
			</div>
		</div>
	</header>

	<div class="mainWrapper">
		<!-- 01. 메인 배너 -->
		<div class="mainBannerWrap">
			<div class="mainHeader">
				<h4 class="h4">국내 최고 취업률 97% 달성한 SES를 온라인에서 만나보세요!</h4>
				<div class="fz34">We Can Do it! Do it campus!</div>
			</div>
			<!-- 검색창 -->
			<form action="/lms/course/search/sub05-01" class="header-search d-flex" method="get">
				<input type="text" class="cusPHIn input" name="keyWord" value="" placeholder="Online class, 두잇을 검색해보세요.">
				<button class="button img-icon search"></button>
			</form>
		</div>
		<!-- 02. 퀵 메뉴 버튼 -->
		<div class="quickMenuWrap btnWrap">
			<div class="btn-menu d-flex justify_center">
				<div class="menu-btn fullNav">
					<div class="img-icon bars"></div>
					<div class="menu-txt">전체메뉴</div>
				</div>
				<a href="/lms/course/it/sub01-01" class="menu-btn">
					<div class="img-icon robot"></div>
					<div class="menu-txt">디지털·AI</div>
				</a> <a href="/lms/course/foreign/sub02-01" class="menu-btn">
					<div class="img-icon language"></div>
					<div class="menu-txt">외국어</div>
				</a> <a href="/lms/course/business/sub03-01" class="menu-btn">
					<div class="img-icon briefcase"></div>
					<div class="menu-txt">직무</div>
				</a> <a href="/lms/course/license/sub05-01" class="menu-btn">
					<div class="img-icon file-certificate"></div>
					<div class="menu-txt">자격증</div>
				<!-- </a> <a href="/lms/course/jobmarket/sub06-01" class="menu-btn">
					<div class="img-icon city"></div>
					<div class="menu-txt">JOB-Market</div> -->
				</a> <a href="/lms/community/sub05-01-01" class="menu-btn">
					<div class="img-icon bullhorn"></div>
					<div class="menu-txt">커뮤니티</div>
				</a> <a href="/lms/support/sub06-01-01" class="menu-btn">
					<div class="img-icon desktop"></div>
					<div class="menu-txt">고객센터</div>
				</a>
			</div>
		</div>
	</div>
</div>