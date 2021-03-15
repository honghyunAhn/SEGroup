<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<script type="text/javascript">
   $(function() {
      $('#logout').off("click").on("click", function() {
         $('#logoutForm').submit();
         return false;
      });

      init();
      
      function init(){

/* ------------------네비게이션 탭 화면세팅변수--------------------- */    	  
    	var itParentList = new Array();
    	var itSonList = new Array();
    	var foreignParentList = new Array();
    	var foreignSonList = new Array();
    	var businessParentList = new Array();
    	var businessSonList = new Array();
    	var jobtrainingParentList = new Array();
    	var jobtrainingSonList = new Array();
    	
    <c:forEach var="courseList" items="${courseList}">
     
     if(${courseList.grand == "글로벌 S/W Master"}){
 		itSonList.push({
 			parent : "${courseList.parent}",
 			son : "${courseList.son}"
 		});
 		if(!itParentList.includes("${courseList.parent}")){
				itParentList.push("${courseList.parent}")
			}        	        	        			
		}
		if(${courseList.grand == "Biz Expert(지역전문가)"}){
 		foreignSonList.push({
 			parent : "${courseList.parent}",
 			son : "${courseList.son}"
 		});
 		if(!foreignParentList.includes("${courseList.parent}")){
				foreignParentList.push("${courseList.parent}")
			}        	        	        			
		}
		if(${courseList.grand == "단기과정"}){
 		businessSonList.push({
 			parent : "${courseList.parent}",
 			son : "${courseList.son}"
 		});
 		if(!businessParentList.includes("${courseList.parent}")){
				businessParentList.push("${courseList.parent}")
			}        	        	        			
		}
    	</c:forEach>		 
 
    	setMobileTabs(itParentList, itSonList, '1', 'mobileItCate');		
		setMobileTabs(foreignParentList, foreignSonList, '2', 'mobileForeignCate');		
		setMobileTabs(businessParentList, businessSonList, '3', 'mobileBusinessCate');		
		setMobileTabs(jobtrainingParentList, jobtrainingSonList, '4', 'mobileJobtrainingCate');		

   	
    	setNav(itParentList, '1');	 
    	setNav(foreignParentList, '2');	 
    	setNav(businessParentList, '3');	 
    	setNav(jobtrainingParentList, '4');	 

    	
    	setWebTabs(itParentList, itSonList, '1', 'webItCate');
		setWebTabs(foreignParentList, foreignSonList, '2', 'webForeignCate');
		setWebTabs(businessParentList, businessSonList, '3', 'webBusinessCate');
		setWebTabs(jobtrainingParentList, jobtrainingSonList, '4', 'webJobtrainingCate');


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
	  			comment += '<li><a href="/smtp/course/scmaster/scmaster?parent_menu=' + parent + '">' + parent +'</a></li>';				
			    break;
			  case '2':
	  			comment += '<li><a href="/smtp/course/biz/biz?parent_menu=' + parent + '">' + parent +'</a></li>';				
			    break;
			  case '3':
	  			comment += '<li><a href="/smtp/course/short-term/short-term?parent_menu=' + parent + '">' + parent +'</a></li>';				
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
			$('.navJobtraining').html(comment);
			break;
		  default :
			break;

		}	
	}      

	function setWebTabs(parentList, sonList, flag, className){

		var menuHtml = '';

 		$.each(parentList, function(index, parent){
		
			menuHtml += '<li class="lnb fz14">';

			if(flag=='1'){  
				menuHtml += '<a href="/smtp/course/scmaster/scmaster?parent_menu=' + parent +'">' + parent + '</a>';				
			} else if(flag=='2'){
				menuHtml += '<a href="/smtp/course/biz/biz?parent_menu=' + parent +'">' + parent + '</a>';								
			} else if(flag=='3'){
				menuHtml += '<a href="/smtp/course/short-term/short-term?parent_menu=' + parent +'">' + parent + '</a>';				
			}

			menuHtml += '<ul class="menu-sub h5">';

		    $.each(sonList, function(index, parSon){
	
		    	if(parent == parSon.parent){						

					if(flag=='1'){
			    		menuHtml += '<li><a href="/smtp/course/scmaster/scmaster?son_menu=' + parSon.son + '">' + parSon.son + '</a></li>';                                     
					} else if(flag=='2'){
			    		menuHtml += '<li><a href="/smtp/course/biz/biz?son_menu=' + parSon.son + '">' + parSon.son + '</a></li>';                                     
					} else if(flag=='3'){
			    		menuHtml += '<li><a href="/smtp/course/short-term/short-term?son_menu=' + parSon.son + '">' + parSon.son + '</a></li>';                                     
					}

		    	}                	                	
		    });                
		    menuHtml += '</ul>';
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
			    		menuHtml += '<li><a href="/smtp/course/scmaster/scmaster?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';                                     
					} else if(flag=='2'){
			    		menuHtml += '<li><a href="/smtp/course/biz/biz?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';                                     
					} else if(flag=='3'){
			    		menuHtml += '<li><a href="/smtp/course/short-term/short-term?son_menu=' + parSon.son + '">- ' + parSon.son + '</a></li>';                                     
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
	/* $('.manualMove').on('click', function(){
		$('.manualMove').each(function(){
			$(this).children('.menu-sub').css('display', 'none');
			$(this).children('.img-icon').removeClass('angle-down').addClass('angle-right');			
		});

		var check = $(this).children('.img-icon').prop('class');

		$(this).children('.img-icon').removeClass('angle-right').addClass('angle-down');
		$(this).children('.menu-sub').css('display', 'block');
		
	}); 
		*/
   
   });
</script>
<!-- common.js를 모바일 환경에서 적용시키기 위해, header.jsp에서 link하도록 세팅한다. -->
<script src="<c:url value="/resources/lms/js/common.js" />"></script>

    <div class="header-include">
    
        <%-- 
        <!-- 슬라이드다운 탑배너 : 회사소개 -->
        <!-- 20-08-18 top-bannerWrap 삭제 -->
        <div class="top-bannerWrap" style="cursor:pointer;">
        	<!-- <div class="top-banner"></div> -->
            <c:forEach var="item" items="${topBannerList }">
            	<c:set var = "theURL" value = "${item.URL}"/>
            	<c:choose>
    				<c:when test="${fn:contains(theURL, 'http')}">
     					<div class="top-banner" style="background-image: url('<c:url value="${item.IMG_URL }"/>');" onclick="openWindow('${item.URL }', '${item.TARGET }');">
        				</div>
    				</c:when>    
    				<c:otherwise>
    					<div class="top-banner" style="background-image: url('<c:url value="${item.IMG_URL }"/>');" onclick="openWindow('http://${item.URL }', '${item.TARGET }');">
        				</div>
    				</c:otherwise>
				</c:choose>
        		
			</c:forEach>
            <div class="btn btn-down">
                <div class="img-icon angle-down"></div>
                <div class="img-icon times close"></div>
            </div>
        </div> 
        --%>
        
        <div class="mobile-headerWrap">
            <div class="mobile-header d-flex">
                <div class="nav-menu">
                    <div class="img-icon bars"></div>
                </div>

                <h1 class="header-logo">
                    <a href="/smtp/main" title="메인">
                        <img src="/resources/lms/img/society_logo.png" alt="회사로고">             
                    </a>
                </h1>
                <!-- 로그인 하면 나의강의실로 연결 -->
                <div class="img-icon user" onclick='location.href="/smtp/user/sub07-01-01"'>                    
                </div>
            </div>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="details" var="check" />
			</sec:authorize>
			<form id="logoutForm" action="/smtp/logout" method="post" style="display: none">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
            <div class="mobile-hdr-loginWrap">
                <ul class="user-menu d-flex">
                    <li class="menu-list logon d-n h5"><a href="/smtp/user/login">로그인</a></li>
                    <li class="menu-list myclass d-b h5"><a href="/smtp/user/sub07-01-01">나의 강의실</a></li>
                    <li class="menu-list logout d-b h5">로그아웃</li>
                    <li class="menu-list join d-n h5"><a href="/smtp/user/tos">회원가입</a></li>
                </ul>
            </div>
            <div class="m-navBg">
                <div class="m-navGroup">
                    <div class="mobile-user">
                        <p class="user-msg welcome d-b">
                            <span class="user-name">${sessionScope.user_id}</span>님 환영합니다.
                        </p>
                        <ul class="user-menu d-flex">
                            <li class="menu-list logon d-n h5"><a href="/smtp/user/login">로그인</a></li>
                            <li class="menu-list myclass d-b h5"><a href="/smtp/user/sub07-01-01">나의 강의실</a></li>
                            <li class="menu-list logout d-b h5">로그아웃</li>
                            <li class="menu-list join d-n h5"><a href="/smtp/user/tos">회원가입</a></li>
                        </ul>
                    </div>
                    <div class="mobile-navGroup">
                        <ul class="menu-title-division">
                            <li class="gnb fz14 mobileItCate "><a href="/smtp/course/scmaster/scmaster">글로벌 S/W Master
                                    <!--<div class="img-icon angle-right angle-down"></div>--></a></li>
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14 mobileForeignCate">
                                <a href="/smtp/course/biz/biz">
                                    Biz Expert
                                    <!--<div class="img-icon angle-right angle-down"></div>-->
                                </a>
                            </li>
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14 mobileBusinessCate"><a href="/smtp/course/short-term/short-term">단기과정</a></li>
<!--                             <li class="lnb fz14"><a href="/lms/course/business/sub03-01">경영/금융</a></li>
                            <li class="lnb fz14"><a href="/lms/course/business/sub03-02">리더십/코칭</a></li>
                            <li class="lnb fz14"><a href="/lms/course/business/sub03-03">마케팅/CS</a></li>
                            <li class="lnb fz14"><a href="/lms/course/business/sub03-04">자기관리/대인관계</a></li> -->
                        </ul>             
                       <!--  <ul class="menu-title-division">
                            <li class="gnb fz14 mobileJobtrainingCate"><a href="/lms/course/jobtraining/sub04-01">취업연계</a></li>
                        </ul>   -->        
                        <ul class="menu-title-division">
                            <li class="gnb fz14">
                            	<a href="/smtp/community/notice">커뮤니티</a>
                            	<ul class="menu-sub">
                                    <li><a href="/smtp/community/notice">- 공지사항</a></li>
                                    <li><a href="/smtp/community/event">- 이벤트</a></li>
                                </ul>
                             </li>
                             <%-- 
                            <li class="lnb fz14">
                                <!-- <a href="sub05-01-01.html"> -->
                                    공지사항/이벤트
                                    <div class="img-icon angle-right angle-down"></div>
                                <!-- </a> -->
                                <ul class="menu-sub">
                                    <li><a href="/lms/community/sub05-01-01">- 공지사항</a></li>
                                    <li><a href="/lms/community/sub05-01-02">- 이벤트</a></li>
                                </ul>
                            </li>--%>
<!--                             <li class="lnb fz14"><a href="/lms/community/sub05-02">수강후기/인터뷰</a></li> -->
                           <!--  <li class="lnb fz14"><a href="/lms/community/sub05-03">특강/설명회</a></li> -->
<!--                             <li class="lnb fz14"><a href="/lms/community/sub05-04">자유게시판</a></li> -->
                        </ul>
                        <ul class="menu-title-division">
                            <li class="gnb fz14"><a href="/smtp/support/customersupport">고객센터
                                    <!--<div class="img-icon angle-right angle-down"></div>--></a></li>
                            <li class="lnb fz14">
                                <!-- <a href="sub06-01-01.html"> -->
                                    고객지원
                                    <div class="img-icon angle-right angle-down"></div>
                                    <ul class="menu-sub">
                                        <li><a href="/smtp/support/customersupport">- 학습자 PC 환경설정</a></li>
                                        <!-- <li><a href="/lms/support/sub06-01-02">- PC 원격지원</a></li> -->
                                    </ul>
                                <!-- </a> -->
                            </li>
                            <li class="lnb fz14">
                                <a href="/smtp/support/faq">
                                    FAQ
                                    <!-- <div class="img-icon angle-right angle-down"></div> -->
                                </a>
                            </li>
                            <li class="lnb fz14">
                                <a href="/smtp/support/inquiry">
                                    단체/제휴문의
                                    <!-- <div class="img-icon angle-right angle-down"></div> -->
                                </a>
                            </li>
                            <li class="lnb fz14">
                                <a href="/smtp/support/map">
                                    오시는길
                                    <!-- <div class="img-icon angle-right angle-down"></div> -->
                                </a>
                                <!-- <ul class="menu-sub">
                                    <li><a href="sub06-05-01.html">대중교통</a></li>
                                    <li><a href="sub06-05-02.html">자가용</a></li>
                                </ul> -->
                            </li>
                        </ul>
                        <ul class="menu-title-division bl">
                            <li class="gnb fz14"><a href="/smtp/user/sub07-01">나의강의실</a></li>
                            <li class="lnb fz14"><a href="/smtp/user/sub07-01-01">학습현황</a></li>
                            <li class="lnb fz14"><a href="/smtp/user/payback">결제현황/환불</a></li>
                            <li class="lnb fz14"><a href="/smtp/user/mileage">마일리지</a></li>
                            <li class="lnb fz14"><a href="/smtp/user/update-information">개인정보수정</a></li>
                            <li class="lnb fz14"><a href="/smtp/user/withdrawal">회원탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- userMenu / header -->
        <div class="hdrWrap topMenu-wrapper">
            <header class="header">
                <div class="header-topMenu-wrap  d-flex">
                    <div class="topMenu-notice-wrap d-flex">
                        <div class="listWrap block">
                            <div class="topMenu-notice">
                            	<c:forEach var="item" items="${headerNoticeList}" varStatus="status">
                            		<div class="notice">
                            			<a class="text-over" href="<c:url value="/smtp/community/notice-view"/>?id=${item.ID}&notice_type=${item.NOTICE_TYPE }&board_type=1">
                            				&#91;공지${status.index+1 }&#93; ${item.TITLE }
                    					</a>
                            		</div>
								</c:forEach>
                            </div>
                        </div>

                        <div class="button-wrap d-flex">
                            <div class="btn btn-prev prev img-icon angle-left" title="이전"></div>
                            <div class="btn btn-next next img-icon angle-right" title="다음"></div>
                            <!-- <div class="floatL img-icon pause" title="정지"></div> -->
                            <!-- <div class="btn-next floatL img-icon play" title="재생"></div> -->
                        </div>
                    </div>
                    <ul class="user-menu d-flex">
                        <!-- 로그인시 바뀌는 부분

                        (1)로그인 전
                        : (.logon)로그인, (.join)회원가입 버튼 표시됨

                        (2) 로그인 후
                        : (.welcome)사용자환영(>.user-name에 사용자이름 넣어주기),(.myclass)나의강의실,(.logout)로그아웃 버튼 표시됨
                        -->
                        
                        <c:choose>
							<c:when test="${empty check }">
		                        <li class="menu-list d-n h5"><a href="/smtp/user/login">로그인</a></li>
		                        <li class="menu-list d-n h5"><a href="/smtp/user/tos">회원가입</a></li>
	                        </c:when>
	                        <c:otherwise>
	                        	<li class="menu-list welcome d-b h5">
                            	<span class="user-name">${sessionScope.user_id}</span>님 환영합니다.
                       			 </li>
		                        <li class="menu-list d-b h5"><a href="/smtp/user/sub07-01-01">나의 강의실</a></li>
		                        <li class="menu-list d-b h5" id="logout">로그아웃</li>
	                        </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </header>
        </div>
        <div class="hdrWrap midMenu-wrapper">

            <header class="header">
                <div class="header-wrap">
                    <h1 class="header-logo">
                        <a href="/smtp/main" title="메인">
                            <img src="/resources/lms/img/society_logo.png" alt="회사로고">
                        </a>
                    </h1>
                    <!-- 검색어입력 -->
                     <form class="header-search d-flex" action="/smtp/course/search/search_lecture" method="GET"> 
                        <input type="text" class="cusPHIn input" name="keyWord" id="searchBar" value placeholder="과정명을 검색하세요">
                        <!-- 검색버튼 -->
                        <button class="button img-icon search"></button>
                     </form>

                    <ul class="header-sns d-flex">
                        <li class="img-icon youtube">
                            <a href="#">
                                <!-- <img src="img/header-sns-youtube.png" alt="유튜브" title="유튜브"> -->
                            </a>
                        </li>
                        <!-- <li class="menu-divBar cccc">|</li> -->
                        <li class="img-icon Nblog">
                            <a href="https://blog.naver.com/e-tradecampus" target="_blank">
                                <!-- <img src="img/header-sns-naverBlog.png" alt="네이버 블로그" title="네이버 블로그"> -->
                            </a>
                        </li>
                        <!-- <li class="menu-divBar cccc">|</li> -->
                        <li class="img-icon Ncafe">
                            <a href="https://cafe.naver.com/goitjapan" target="_blank">
                                <!-- <img src="img/header-sns-naverCafe.png" alt="네이버 카페" title="네이버 카페"> -->
                            </a>
                        </li>
                    </ul>
                </div>
            </header>
        </div>

        <!-- nav fullWrapper 삽입-->

        <div class="navWrap">
            <nav class="nav">
                <!--메뉴바 클릭시 full menu 슬라이드 다운 -->
                <div class="nav-menu">
                    <div class="btn-toggle">
                        <div class="img-icon bars"></div>
                        <div class="hide-show-txt fz14">
                            전체 메뉴 보기
                        </div>
                    </div>

                    <!-- 헤더 -->
                    <ul class="navGroup d-flex">
                        <!-- ↓ IT -->
                        <li class="gnb sub01 fz16">
                            <a href="/smtp/course/scmaster/scmaster">글로벌 S/W Master</a>
                            <ul class="lnb fz14 navIt">
                            </ul>
                        </li>
                        <!-- ↓ 외국어 -->
                        <li class="gnb sub02 fz16">
                            <a href="/smtp/course/biz/biz">Biz Expert</a>
                            <ul class="lnb fz14 navForeign">
                            </ul>
                        </li>
                        <!-- ↓ 직무역량 -->
                        <li class="gnb sub03 fz16">
                            <a href="/smtp/course/short-term/short-term">단기과정</a>
                            <ul class="lnb fz14 navBusiness">
                            </ul>
                        </li>            
                        <!-- ↓ 취업연계 -->
                        <!-- <li class="gnb sub04 fz16">
                            <a href="/lms/course/jobtraining/sub04-01">취업연계</a>
                            <ul class="lnb fz14 navJobtraining">                           	 
                            </ul>
                        </li>      -->       
                        <!-- ↓ 커뮤니티 -->
                        <li class="gnb sub05 fz16">
                            <a href="/smtp/community/notice">커뮤니티</a>
                            <ul class="lnb fz14">                                 
                                <li><a href="/smtp/community/notice">공지사항</a></li>
                                <li><a href="/smtp/community/event">이벤트</a></li>
<!--                                 <li><a href="/lms/community/sub05-02">수강후기/인터뷰</a></li> -->
                                <!-- <li><a href="/lms/community/sub05-03">특강/설명회</a></li> -->
<!--                                 <li><a href="/lms/community/sub05-04">자유게시판</a></li> -->
                            </ul>
                        </li>
                        <!-- ↓ 고객센터 -->
                        <li class="gnb sub06 fz16">
                            <a href="/smtp/support/customersupport">고객센터</a>
                            <ul class="lnb fz14">
                                <li><a href="/smtp/support/customersupport">고객지원</a></li>
                                <li><a href="/smtp/support/faq">FAQ</a></li>
                                <li><a href="/smtp/support/inquiry">단체/제휴문의</a></li>
                                <li><a href="/smtp/support/map">오시는길</a></li>
                            </ul>
                        </li>
                         <li class="gnb sub06 fz16">
                            <a href="/smtp/user/sub07-01-01">나의강의실</a> 
                            <ul class="lnb fz14">
                                <li><a href="/smtp/user/sub07-01-01">학습현황</a></li>
                                <li><a href="/smtp/user/payback">결제현황/환불</a></li>
                                <li><a href="/smtp/user/mileage">마일리지</a></li>
                                <li><a href="/smtp/user/update-information">개인정보수정</a></li>
                                 <li><a href="/smtp/user/withdrawal">회원탈퇴</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </div>
        <div class="fullWrapper">
            <div class="full-background">
                <!-- <div class="close-menu">x</div> -->
                <div class="full-navGroup">
                    <ul class="menu-title-division">
                        <li class="gnb fz14 webItCate"><a href="/smtp/course/scmaster/scmaster">글로벌 S/W Master</a></li>
<!--                         <li class="lnb fz14">
                            <a href="/lms/course/it/sub01-01?parent_menu=프로그래밍 언어">프로그래밍 언어</a>
                            <ul class="menu-sub h5 ">
                                 <li><a href="/lms/course/it/sub01-01-01">C</a></li>
                                <li><a href="/lms/course/it/sub01-01-02">C++</a></li>
                                <li><a href="/lms/course/it/sub01-01-03">C#</a></li>
                                <li><a href="/lms/course/it/sub01-01-04">Java</a></li>
                                <li><a href="/lms/course/it/sub01-01-05">JavaScript</a></li>
                                <li><a href="/lms/course/it/sub01-01-06">PHP</a></li>
                                <li><a href="/lms/course/it/sub01-01-07">파이썬</a></li>
                                <li><a href="/lms/course/it/sub01-01-08">기타</a></li> 
                            </ul>
                        <li class="lnb fz14">
                            <a href="/lms/course/it/sub01-01?parent_menu=프로그래밍 활용">프로그래밍 활용</a>
                            <ul class="menu-sub h5 ">
                                 <li><a href="/lms/course/it/sub01-02-01">PHP</a></li>
                                <li><a href="/lms/course/it/sub01-02-02">파이썬</a></li>
                                <li><a href="/lms/course/it/sub01-02-03">리눅스</a></li>
                                <li><a href="/lms/course/it/sub01-02-04">기타</a></li> 
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/lms/course/it/sub01-01?parent_menu=AI/빅데이터">AI/빅데이터</a>
                            <ul class="menu-sub h5 ">
                                <li><a href="/lms/course/it/sub01-03-01">인공지능 프로그래밍</a></li>
                                <li><a href="/lms/course/it/sub01-03-02">데이터베이스</a></li>
                                <li><a href="/lms/course/it/sub01-03-03">R</a></li>
                                <li><a href="/lms/course/it/sub01-03-04">HADOOP(하둡) 프로그래밍</a></li>
                                <li><a href="/lms/course/it/sub01-03-05">기타</a></li> 
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/lms/course/it/sub01-01?parent_menu=기타">기타</a>
                            <ul class="menu-sub h5 ">
                                <li><a href="/lms/course/it/sub01-04-01">IOS(스위프트)</a></li>
                                <li><a href="/lms/course/it/sub01-04-02">안드로이드(센서)</a></li>
                                <li><a href="/lms/course/it/sub01-04-03">안드로이드(코틀린)</a></li> 
                            </ul>
                        </li> -->
                    </ul>
                    <!-- <hr> -->
                    <ul class="menu-title-division">
                        <li class="gnb fz14 webForeignCate"><a href="/smtp/course/biz/biz">Biz Expert</a></li>
<!--                         <li class="lnb fz14">
                            <a href="/lms/course/foreign/sub02-01?parent_menu=영어">영어</a>
                            <ul class="menu-sub h5 ">
                                <li><a href="/lms/course/foreign/sub02-01-01">문법/어휘</a></li>
                                <li><a href="/lms/course/foreign/sub02-01-02">비즈니스</a></li>
                                <li><a href="/lms/course/foreign/sub02-01-03">시험대비</a></li>
                                <li><a href="/lms/course/foreign/sub02-01-04">일반</a></li>
                                <li><a href="/lms/course/foreign/sub02-01-05">회화</a></li> 
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/lms/course/foreign/sub02-01?parent_menu=일본어">일본어</a>
                            <ul class="menu-sub h5 ">
                                <li><a href="/lms/course/foreign/sub02-02-01">문법/어휘</a></li>
                                <li><a href="/lms/course/foreign/sub02-02-02">비즈니스</a></li>
                                <li><a href="/lms/course/foreign/sub02-02-03">시험대비</a></li>
                                <li><a href="/lms/course/foreign/sub02-02-04">일반</a></li>
                                <li><a href="/lms/course/foreign/sub02-02-05">회화</a></li> 
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/lms/course/foreign/sub02-01?parent_menu=중국어">중국어</a>
                            <ul class="menu-sub h5 ">
                                <li><a href="/lms/course/foreign/sub02-03-01">문법/어휘</a></li>
                                <li><a href="/lms/course/foreign/sub02-03-02">비즈니스</a></li>
                                <li><a href="/lms/course/foreign/sub02-03-03">시험대비</a></li>
                                <li><a href="/lms/course/foreign/sub02-03-04">일반</a></li>
                                <li><a href="/lms/course/foreign/sub02-03-05">회화</a></li> 
                            </ul>
                        </li> -->
                    </ul>
                    <!-- <hr> -->
                    <ul class="menu-title-division">
                        <li class="gnb fz14 webBusinessCate"><a href="/smtp/course/short-term/short-term">단기과정</a></li>
<!--                         <li class="lnb fz14">
                        	<a href="/lms/course/business/sub03-01?parent_menu=경영/금융">경영/금융</a>
                            <ul class="menu-sub h5 "></ul>
                        </li>
                        <li class="lnb fz14">
                        	<a href="/lms/course/business/sub03-01?parent_menu=리더십/코칭">리더십/코칭</a>
                        	<ul class="menu-sub h5 "></ul>
                        </li>
                        <li class="lnb fz14">
                        	<a href="/lms/course/business/sub03-01?parent_menu=마케팅/CS">마케팅/CS</a>
                            <ul class="menu-sub h5 "></ul>
                        </li>
                        <li class="lnb fz14">
                        	<a href="/lms/course/business/sub03-01?parent_menu=자기관리/대인관계">자기관리/대인관계</a>
                        	<ul class="menu-sub h5 "></ul>
                        </li> -->
                    </ul>
                    <!-- <hr> -->
                  
                    <!-- <ul class="menu-title-division">
                        <li class="gnb fz14 webJobtrainingCate"><a href="/lms/course/jobtraining/sub04-01">취업연계</a></li> -->
<!--                         <li class="lnb fz14">
                            <a href="/lms/course/jobtraining/sub04-01?parent_menu=취업연계 과정">취업연계 과정</a>
                            <ul class="menu-sub h5 ">
                                 <li><a href="/lms/course/jobtraining/sub04-01-01">국내</a></li>
                                <li><a href="/lms/course/jobtraining/sub04-01-02">해외</a></li> 
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/lms/course/jobtraining/sub04-01?parent_menu=단기교육 과정">단기교육 과정</a>
                            <ul class="menu-sub h5 ">
                                 <li><a href="/lms/course/jobtraining/sub04-02-01">백엔드(웹 개발)</a></li>
                                <li><a href="/lms/course/jobtraining/sub04-02-02">프론트엔드(웹 코딩)</a></li>
                                <li><a href="/lms/course/jobtraining/sub04-02-03">앱개발</a></li>
                                <li><a href="/lms/course/jobtraining/sub04-02-04">인공지능/빅데이터</a></li>
                                <li><a href="/lms/course/jobtraining/sub04-02-05">웹디자인</a></li> 
                            </ul>
                        </li> -->
                    <!-- </ul> -->
                     
                    <!-- <hr> -->
                    <ul class="menu-title-division">
                        <li class="gnb fz14">
                        	<a href="/smtp/community/notice">커뮤니티</a>
	                         <li class="lnb fz14">
	                            <a href="/smtp/community/notice">공지사항</a>              
	                        </li>
	                         <li class="lnb fz14">
	                            <a href="/smtp/community/event">이벤트</a>              
	                        </li>                    
                        <!-- <li class="lnb fz14">
                            <a href="sub05-01-01.html">자료실</a>
                            <ul class="menu-sub h5">
                                <li><a href="sub05-01-01.html">자료실</a></li>
                                <li><a href="sub05-01-02.html">학습지원프로그램</a></li>
                                <li><a href="sub05-01-03.html">동영상지원프로그램</a></li>
                                <li><a href="sub05-01-04.html">파일뷰어프로그램</a></li>
                            </ul>
                        </li> -->
                        <!--<li class="lnb fz14">
                            <a href="/lms/community/sub05-01-01">공지사항/이벤트</a>  -->
                           <!--  <ul class="menu-sub h5">
                                <li><a href="/lms/community/sub05-01-01">공지사항</a></li>
                                <li><a href="/lms/community/sub05-01-02">이벤트</a></li>
                            </ul> 
                        </li>-->
<!--                         <li class="lnb fz14"><a href="/lms/community/sub05-02">수강후기/인터뷰</a></li> -->
                        <!-- <li class="lnb fz14"><a href="/lms/community/sub05-03">특강/설명회</a></li> -->
<!--                         <li class="lnb fz14"><a href="/lms/community/sub05-04">자유게시판</a></li> -->
                    </ul>
                    <!-- <hr> -->
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="/smtp/support/customersupport">고객센터</a></li>
                        <li class="lnb fz14">
                            <a href="/smtp/support/customersupport">고객지원</a>
                            <ul class="menu-sub h5">
                                <li><a href="/smtp/support/customersupport">학습자 PC 환경설정</a></li>
                                <!-- <li><a href="/lms/support/sub06-01-02">PC원격지원</a></li> -->
                            </ul>
                        </li>
                        <li class="lnb fz14">
                            <a href="/smtp/support/faq">FAQ</a>
                            <!-- <ul class="menu-sub h5">
                                        <li><a href="sub06-02-01.html">전체</a></li>
                                        <li><a href="sub06-02-02.html">회원가입/변경/탈퇴</a></li>
                                        <li><a href="sub06-02-03.html">수강신청/취소</a></li>
                                    </ul> -->
                        </li>
                        <li class="lnb fz14">
                            <a href="/smtp/support/inquiry">단체/제휴문의</a>
                            <!-- <ul class="menu-sub h5">
                                <li><a href="sub06-04-01.html">단체문의</a></li>
                                <li><a href="sub06-04-02.html">제휴문의</a></li>
                            </ul> -->
                        </li>
                        <li class="lnb fz14">
                            <a href="/smtp/support/map">오시는길</a>
                            <!-- <ul class="menu-sub h5">
                                <li><a href="sub06-05-01.html">대중교통</a></li>
                                <li><a href="sub06-05-02.html">자가용</a></li>
                            </ul> -->
                        </li>
                    </ul>
                    
                    <!--  -->
                    <ul class="menu-title-division">
                        <li class="gnb fz14"><a href="/smtp/user/sub07-01-01">나의강의실</a></li>
                        <li class="lnb fz14">
                            <a href="/smtp/support/sub07-01-01">학습현황</a>              
                        </li>
                        <li class="lnb fz14">
                            <a href="/smtp/user/payback">결제현황/환불</a>              
                        </li>
                        <li class="lnb fz14">
                            <a href="/smtp/user/mileage">마일리지</a>              
                        </li>
                        <li class="lnb fz14">
                            <a href="/smtp/user/update-information">개인정보수정</a>
                        </li>
                        <li class="lnb fz14">
                            <a href="/smtp/user/withdrawal">회원탈퇴</a>              
                        </li>
                    </ul>
                    <!--  -->
                    
                </div>
            </div>
        </div>
    </div>
