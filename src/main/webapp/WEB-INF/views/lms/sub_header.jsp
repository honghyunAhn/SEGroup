<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script type="text/javascript">
   $(function() {
      $('#logout').off("click").on("click", function() {
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
	<p>
		<a class="goToMain" href="/lms/main">콘텐츠 바로가기</a>
	</p>
</div>
<header class="headerContainer subPage_header">
	<div class="headerWrapper subHeader">
		<div class="hdrWrap">
			<div class="header d-flex justify_between">
				<h1 class="header-logo">
					<a href="/lms/main" title="메인"> <img src="/resources/lms/img/DIC_logo.png" alt="두잇캠퍼스로고">
					</a>
				</h1>
				<form action="/lms/course/search/sub05-01" class="header-search d-flex">
					<input type="text" class="cusPHIn input" name="keyWord" value="${keyWord}" placeholder="Online class, 두잇을 검색해보세요.">
					<input type="hidden" name="startPage" value="1"/>
					<input type="hidden" name="viewPages" value="10"/>
					<button class="button img-icon search"></button>
				</form>
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="details" var="check" />
				</sec:authorize>
				<form id="logoutForm" action="/lms/user/logout" method="post" style="display: none">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				<c:choose>
					<c:when test="${empty check }">
						<!-- login시 .login_after 활성화, logout시 .login_before 활성화 -->
						<ul class="header-menu d-flex login_before">
							<li class="hdrMenu login"><a href="/lms/user/sub00-01">로그인</a></li>
							<li class="hdrMenu hdrMenu_emph join"><a href="/lms/user/sub00-02" class="bgc_yeL">회원가입</a>
								<div class="join_sub bgc_333">
									<a href="#">가입시 5,000마일리지 혜택</a>
								</div></li>
						</ul>
					</c:when>
					<c:otherwise>
						<!-- login시 .login_after 활성화, logout시 .login_before 활성화 -->
						<ul class="header-menu d-flex login_after">
							<li class="userInfo" id="userInfo"><span>${sessionScope.user_id} 님 환영합니다.</span></li>
							<li class="hdrMenu logout" id="logout">로그아웃</li>
							<li class="hdrMenu hdrMenu_emph myCampus"><a href="/lms/user/sub07-01-01" class="bgc_orD">마이캠퍼스</a></li>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="navWrapper subNav">
		<nav class="nav">
			<ul class="navGroup d-flex justify_between">
				<li class="gnb subMenu01"><a href="/lms/course/it/sub01-01">디지털·AI</a>
					<ul class="lnb navIt">
					</ul>
				</li>
				<li class="gnb subMenu02"><a href="/lms/course/foreign/sub02-01">외국어</a>
					<ul class="lnb navForeign">
					</ul>
				</li>
				<li class="gnb subMenu03"><a href="/lms/course/business/sub03-01">직무</a>
					<ul class="lnb navBusiness">
					</ul>
				</li>
				<li class="gnb subMenu04"><a href="/lms/course/license/sub05-01">자격증</a>
					<ul class="lnb navLicense">
					</ul>
				</li>
				<!-- <li class="gnb subMenu05"><a href="/lms/course/jobmarket/sub06-01">JOB-Market</a>
					<ul class="lnb navJobMarket">
					</ul>
				</li> -->
				<li class="gnb subMenu09"><a href="/lms/course/toefl/sub_toefl">모의토플</a>
					<ul class="lnb navToefl">
					</ul>
				</li>
				<li class="gnb subMenu06"><a href="/lms/community/sub05-01-01">커뮤니티</a>
					<ul class="lnb">
						<li><a href="/lms/community/sub05-01-01">공지사항</a></li>
						<li><a href="/lms/community/sub05-01-02">이벤트</a></li>
					</ul></li>
				<li class="gnb subMenu07"><a href="/lms/support/sub06-01-01">고객센터</a>
					<ul class="lnb">
						<li><a href="/lms/support/sub06-01-01">고객지원</a></li>
						<li><a href="/lms/support/sub06-02">FAQ</a></li>
						<li><a href="/lms/support/sub06-03">단체/제휴문의</a></li>
						<li><a href="/lms/support/sub06-04">오시는길</a></li>
					</ul></li>
				<!-- <li class="gnb subMenu08">
                        <a href="sub08-01.html">나의강의실</a>
                        <ul class="lnb">
                            <li><a href="sub08-01.html">학습현황</a></li>
                            <li><a href="sub08-02.html">결제환불/환불</a></li>
                            <li><a href="sub08-03.html">마일리지</a></li>
                            <li><a href="sub08-04.html">개인정보수정</a></li>
                            <li><a href="sub08-05.html">회원탈퇴</a></li>
                        </ul>
                    </li> -->
			</ul>
		</nav>
	</div>
</header>
