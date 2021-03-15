<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Soft Engineer Society</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
</head>

<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../header.jsp"%>


    <div class="container sub05" id="main">
        <!-- sub06 고객센터-include -->
        <%@include file="../community/menu/leftmenu.jsp"%>
        <div class="sub-content write-post sub05-04">
        	<div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                    -->
                    <li class="img-icon  home"><a href="index.html"></a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="category-menu"><a href="/lms/community/sub05-01-01">커뮤니티</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="/lms/community/sub05-04">자유게시판</a></li>
                    <!-- <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="sub05-03-02.html">1:1상담</a></li> -->
                </ul>
                <div class="img-icon  chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>
            <div class="header-box">
                <!-- image로 구성 될 경우에 .header-box에 background 처리하기 -->
                <!-- <div class="box-titleBar"></div>
                <h3 class="h3">자유게시판</h3>
                <p class="c999">
                    레인보우 회원들과 자유롭게 나눌 수 있는 공간<br>함께 나누고 싶은 이야기라면 무엇이든 좋아요!
                </p> -->
            </div>
        
            <div class="section">
                <header class="article-title">
                    <div class="titleBar-hdr h4">자유게시판</div>
                    <!-- <h4 class="h4"></h4> -->
                </header>

                <!--
                span.retrieve : 저장된 데이터 불러오기
            -->
                <form action="" id="" class="formStyle" method="post">
                    <div class="d-flex post-titleWrap">
                        <label class="label" for="post-title">제 목</label>
                        <div class="post-title">${detail.title}</div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="date">작성일</label>
                        <div clss="date">${detail.reg_date_format2}</div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="user-name">작성자</label>
                        <c:choose>
							<c:when test="${!empty detail.user_name}">
								<div class="user-name">${detail.user_name}</div>
							</c:when>
							<c:otherwise>
								<div class="user-name">${detail.reg_name}</div>
							</c:otherwise>
						</c:choose>
                    </div>
                    <div class="post-content">${detail.comment}</div>
                </form>
                <div class="button-wrap d-flex">
                    <button type="button" onclick="toPrev(${prevId});" class="button btn-wh btn-prev prev-step">이전</button>
                    <button type="button" onclick="toList();" class="button btn-pColor btn-list">글 목록</button>
                    <button type="button" onclick="toNext(${nextId});" class="button btn-wh btn-prev next-step">다음</button>
                </div>
            </div>
        </div>
    </div>
    
    <form id="moveForm" name="moveForm" action="post">
		<input type="hidden" name="startPage" value="<c:out value="${startPage}"/>"/>
		<input type="hidden" name="visiblePages" value="<c:out value="${visiblePages}"/>">
		<input type="hidden" name="board_type" value="8"/>
		<input type="hidden" name="id" value="${prevId}"/>
	</form>
    
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>

    <script type="text/javascript">
        function toList(){
        	$("#moveForm").attr("action", "/lms/community/sub05-04");
        	$('#moveForm input[name="id"]').val("");
        	moveForm.submit();
        }
        
        function toPrev(id){
        	if (id != null) {
        		$('#moveForm input[name="id"]').val(id);
            	$("#moveForm").attr("action", "/lms/community/sub05-04-view");
            	moveForm.submit();
			} else {
				return alert("이전 글이 없습니다.");
			}
        }
        
        function toNext(id){
        	if (id != null) {
        		$('#moveForm input[name="id"]').val(id);
            	$("#moveForm").attr("action", "/lms/community/sub05-04-view");
            	moveForm.submit();
			} else {
				return alert("다음 글이 없습니다.");
			}
        }
    </script>
</body>

</html>