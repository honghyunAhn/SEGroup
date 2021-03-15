<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Let's Do it 두잇캠퍼스</title>
    <link rel="stylesheet" href="/resources/lms/css/reset.css">
    <link rel="stylesheet" href="/resources/lms/css/common.css">
    <link rel="stylesheet" href="/resources/lms/css/img-icon.css">
	<link rel="stylesheet" href="/resources/lms/css/style.css">
	<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
	<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
    <script src="<c:url value="/resources/lms/js/common.js" />"></script>
</head>

<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
   		<%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub06 d-flex">
        <!-- sub06 고객센터-include -->
        <%@include file="../support/menu/leftmenu.jsp"%>


        <div class="subPage_content margin-left20 sub-content sub06-02" id="main">
            <!-- <div class="page-locationWrap">
                <ul class="page-location">
                    
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                   
                    <li class="img-icon  home"><a href="index.html"></a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="category-menu"><a href="sub06-01-01.html">고객센터</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="sub06-02.html">FAQ</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="sub06-02-01.html">전체</a></li>
                </ul>
                <div class="img-icon  chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div>
            <div class="header-box">
                image로 구성 될 경우에 .header-box에 background 처리하기
                <div class="box-titleBar"></div>
                <h3 class="h3">FAQ 자주하는 질문</h3>
                <p class="c999">
                    궁금하신 사항은 먼저 자주하는 질문을 참고하시면<br>회원님의 궁금증을 빠르게 해결하실 수 있습니다.
                </p>
            </div> -->
            <div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">FAQ 자주하는 질문</h3>
                    <p class="fc_999">궁금하신 사항은 먼저 자주하는 질문을 참고하시면 보다 빠르게 해결하실 수 있습니다.</p>
                </div>
            </div>
            <div class="section sub06-02">

                <!-- <div class="sub-header d-flex"> //과정명 검색 - 기존 문서구조 (변경 전)
                    <div class="class-searchWrap d-flex">
                        <div class="search-filter-wrap">
                            <select name="search-filter" id="search-filter">
                                <option value="ttl" selected>제목+내용</option>
                                <option value="ttl">제목</option>
                                <option value="ctt">내용</option>
                            </select>
                        </div>
                        <form class="class-search-down d-flex">
                            <span class="cusPlaceHolder">
                                <input type="text" class="cusPHIn input" value placeholder="검색어를 입력해주세요.">
                            </span>
                            <div class="img-icon search"></div>
                        </form>
                    </div>
                    <div class="viewWrap">
                        <select name="view-class" id="view-class">
                            <option value="10v" selected>10개씩 보기</option>
                            <option value="20v">20개씩 보기</option>
                            <option value="30v">30개씩 보기</option>
                            <option value="40v">40개씩 보기</option>
                            <option value="50v">50개씩 보기</option>
                        </select>
                    </div>
                </div> -->


                <!-- 과정명 검색 -->
                <div class="searchWrapper">
                    <div class="class-searchWrap floatR">
                        <form class="d-flex" id="searchForm">
                            <div class="search-filter-wrap">
                                <select name="searchbox" class="search-filter">
									<option value="tc" ${param.searchbox eq 'tc'? 'selected':''}>제목+내용</option>
									<option value="t" ${param.searchbox eq 't'? 'selected':''}>제목</option>
									<option value="c" ${param.searchbox eq 'c'? 'selected':''}>내용</option>
<!--                                                 
                                    <option value="ttl" selected>제목+내용</option>
                                    <option value="ttl">제목</option>
                                    <option value="ctt">내용</option> -->
                                </select>
                            </div>

                            <div class="class-search-down d-flex">
                                <input type="text" name="search" class="cusPHIn input" value="${param.search}" placeholder="검색어를 입력해주세요.">
                                <!-- 검색버튼 -->
                                <button type="button" class="button img-icon search" id="searchBtn">

                                </button>
                            </div>
                            <!--<div class="viewWrap">
                            <select name="view-class" id="view-class">
                            <option value="10v" selected>10개씩 보기</option>
                            <option value="20v">20개씩 보기</option>
                            <option value="30v">30개씩 보기</option>
                            <option value="40v">40개씩 보기</option>
                            <option value="50v">50개씩 보기</option>
                            </select>
                        </div> -->
                        </form>
                    </div>
                </div>
                <div class="class-tabMenu">
                    <!-- li의 개수가 5개를 초과하면 'plus-tabGroup'이라는 클래스가 추가되며 
                    해당하는 스타일이 추가된다.  -->
                    <ul class="tabGroup d-flex">
                        <li class="active">전체</li>
						<c:if test="${!empty bbscode}">
							<c:forEach var="bbscode" items="${bbscode}" varStatus="status">
								<li id="${bbscode.code}">${bbscode.name}</li>
							</c:forEach>
						</c:if>                                        
                    </ul>
                    <div class="subGroup">
                        <div class="tab-sub sub01">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name-wide">제목</li>
                                        <li class="c-table-02">구분</li>
                                    </ul>
                                    <ul class="class-list-wrap">
                                        <!-- 과정명 추가시 list and(+) Wrap 추가  -->
                                    <c:if test="${!empty bbslist}">    
                                    	<c:forEach var="faqList" items="${bbslist}" varStatus="status">
<%-- 										<c:if test="${faqCode.code == faqList.faq_code}">
 --%>
										<li class="listAndwrap">
                                            <div class="class-list board-list open-answer d-flex">
                                                <div class="c-table-num">${status.count}</div>
                                                <div class="c-table-name-wide">
                                                    <div class="d-flex icon-align title-margin">
                                                        <div class="Qmark">Q.</div>
                                                        <div class="text-over-lh20">
                                                        	${faqList.title}
                                                            <!-- 새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 것이다. -->
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="c-table-02">
													<!-- 회원가입/변경/탈퇴 -->
			                                    	<c:forEach var="faqCode" items="${bbscode}" varStatus="status">
														<c:if test="${faqCode.code == faqList.faq_code}">
															${faqCode.name}
														</c:if>
													</c:forEach>
                                                </div>
                                            </div>
                                            <!-- open-class 클릭하면 open-ctt가 .slideToggle되고 hide-show-txt.text(닫기);로 바뀐다. -->
                                            <div class="open-asw open-ctt">
                                                <!-- <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num"></li>
                                                    <li class="c-table-name-wide">
                                                        <div class="d-flex icon-align title-margin">
                                                            <div class="Amark">A.</div>
                                                            <p class="text-over">
                                                                새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 공자는 살 그것은 것이다.
                                                            </p>
                                                        </div>
                                                    </li>
                                                </ul> -->
                                                <ul class="class-list-wrap">
                                                    <!-- <li class="c-table-num"></li> -->
                                                    <li class="icon-align aswr-box d-flex title-margin">
                                                        <div class="Amark">A.</div>
                                                        <div class="text-over-lh20">
                                                        ${faqList.acomment}
<!--                                                             새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 공자는 살 그것은 것이다.
                                                            이상은 할지라도 천자만홍이 행복스럽고 만물은 길지 일월과 커다란 영원히 때문이다. 청춘의 길을 얼마나 이것이다.
                                                            싹이 무엇이 오직 위하여서 황금시대를 속에서 원질이 황금시대의 있음으로써 것이다. -->
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>
                                    	</c:forEach>
									</c:if>                                         
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
<!-- -----------------------------테스트하기------------------------------- -->
 					<c:if test="${!empty bbscode}">
						<c:forEach var="faqCode" items="${bbscode}" varStatus="status">
                        <div class="tab-sub sub02 hideTab">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <!-- <li class="c-table-num">No.</li> -->
                                        <li class="c-table-name-wide">제목</li>
                                        <li class="c-table-02">구분</li>
                                    </ul>
                                    <ul class="class-list-wrap">
                                        <!-- 과정명 추가시 list and(+) Wrap 추가  -->
                                    <c:if test="${!empty bbslist}">    
                                    	<c:forEach var="faqList" items="${bbslist}" varStatus="status">
										<c:if test="${faqCode.code == faqList.faq_code}">

										<li class="listAndwrap">
                                            <div id="${faqList.id }" class="class-list board-list open-answer d-flex">
                                                <%-- <div class="c-table-num">${status.count}</div> --%>
                                                <div class="c-table-name-wide">
                                                    <div class="d-flex icon-align title-margin">
                                                        <div class="Qmark">Q.</div>
                                                        <div class="text-over-lh20">
                                                        	<input type="hidden" name="checkId" value="${faqList.id}">
                                                        	${faqList.title}
                                                            <!-- 새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 것이다. -->
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="c-table-02">
													<!-- 회원가입/변경/탈퇴 -->
													${faqCode.name}
                                                </div>
                                            </div>
                                            <!-- open-class 클릭하면 open-ctt가 .slideToggle되고 hide-show-txt.text(닫기);로 바뀐다. -->
                                            <div class="open-asw open-ctt">
                                                <!-- <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num"></li>
                                                    <li class="c-table-name-wide">
                                                        <div class="d-flex icon-align title-margin">
                                                            <div class="Amark">A.</div>
                                                            <p class="text-over">
                                                                새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 공자는 살 그것은 것이다.
                                                            </p>
                                                        </div>
                                                    </li>
                                                </ul> -->
                                                <ul class="class-list-wrap">
                                                    <!-- <li class="c-table-num"></li> -->
                                                    <li class="icon-align aswr-box d-flex title-margin">
                                                        <div class="Amark">A.</div>
                                                        <div class="text-over-lh20">
                                                        ${faqList.acomment}
<!--                                                             새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 공자는 살 그것은 것이다.
                                                            이상은 할지라도 천자만홍이 행복스럽고 만물은 길지 일월과 커다란 영원히 때문이다. 청춘의 길을 얼마나 이것이다.
                                                            싹이 무엇이 오직 위하여서 황금시대를 속에서 원질이 황금시대의 있음으로써 것이다. -->
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li>

										</c:if>

                                    	</c:forEach>
                                      
									</c:if>                                        

                                    </ul>
                                </div>
                            </div>
                        </div>

						</c:forEach>
					</c:if>                   
                         
<!-- -----------------------------테스트하기--------------------------------->                       
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- footer-include -->
     <%@include file="../common_footer_doitcam.jsp"%>
</body>

<script>
$(function(){
	// 메인화면에서 클릭한 경우
	if ("${id}" != "" && "${faq_code}"!= "" ) {	
		$("#${faq_code}").trigger("click");
		$("#${id}").trigger("click");
		
		var offset = $("#${id}").offset();
	    $('html, body').animate({scrollTop : offset.top}, 10);
	}
	
 	$("#searchBtn").click(function(event){
 		$("#searchForm").submit();
 	});
});
</script>

</html>
