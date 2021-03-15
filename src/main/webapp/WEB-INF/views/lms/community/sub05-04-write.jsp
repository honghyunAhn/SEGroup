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
                    <div class="titleBar-hdr h4">게시글 작성</div>
                    <!-- <h4 class="h4"></h4> -->
                </header>

                <!--
                span.retrieve : 저장된 데이터 불러오기
            -->
                <form id="saveForm" name="saveForm" action="/lms/community/writeSave" class="formStyle" method="post">
                	<input type="hidden" name="board_type" id="board_type" value="8" >
                    <div class="d-flex">
                        <label class="label" for="today">작성일</label>
                        <div class="date today" id="today"></div>
                        <!-- #today 오늘 날짜 구하기 - common.js -->
                    </div>
                    <div class="d-flex">
                        <label class="label" for="user-name">작성자</label>
                        <div class="user-name">${userId}</div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="post-title">제목</label>
                        <input type="text" class="post-title input" name="title">
                    </div>
                    <div class="d-flex">
                        <label class="label" for="post-content">내용</label>
                        <textarea class="post-content" name="comment" rows="8" cols="40"></textarea>
                    </div>
                </form>
                <div class="button-wrap d-flex">
                    <button type="button" class="button btn-wh btn-prev prev-step">취소</button>
                    <!-- <button type="button" onclick="location.href='sub-06-03-01.html'" class="button btn-wh btn-prev prev-step">취소</button> -->
                    <button type="button" class="button btn-pColor btn-save">저장</button>
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
        $(document).ready(function() {
            //오늘 날짜 구하기 https://zero-gravity.tistory.com/308
            function getRecentDate() {
                var dt = new Date();
                var recentYear = dt.getFullYear();
                var recentMonth = dt.getMonth() + 1;
                var recentDay = dt.getDate();

                if (recentMonth < 10) recentMonth = "0" + recentMonth;
                if (recentDay < 10) recentDay = "0" + recentDay;

                return recentYear + " 년 " + recentMonth + " 월 " + recentDay + " 일 ";
            }
            $('#today').text(getRecentDate);
            // $('.formStyle .today').text('메롱');
            //오늘 날짜 구하기 끝

            //버튼
            // 취소단계 버튼 클릭
            $('.prev-step').click(function() {
                if (confirm("작성을 취소하시겠습니까?") == true) {
                    moveForm.submit();
                    // 자유게시판 목록으로 가기
                } else {
                    return false;
                }
            });
            // 이전단계 버튼 클릭 끝

            // 저장 버튼 클릭
            $('.btn-save').on('click', function() {
                if (confirm("등록하시겠습니까?") == true) {
                	$("#saveForm").submit();
                    //alert('등록되었습니다.');
                } else {
                    return false;
                }
            });
            // 저장 버튼 클릭 끝


            //모달 닫기 - 다음/이전 단계 넘어갈 시 load로 불러오니 닫기 버튼 안눌렸음 그래서 임시로 넣어둠
            // $('.modal .close-modal').click(function() {
            //     $('html, body').removeClass("not-scroll");
            //     $('#modal').hide();
            // });
            // //모달 닫기 끝
            //

        });
    </script>
</body>

</html>