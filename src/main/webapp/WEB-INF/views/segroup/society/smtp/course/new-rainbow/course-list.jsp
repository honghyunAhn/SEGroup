<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../../include/rainbow_head.jsp"%>
</head>

<body>
    <div class="container_rainbow">
    	<%@include file="../../include/rainbow_header.jsp"%>
        <div class="content course-list" id="main">
            <!-- 광고 배너 -->
            <%@include file="../../include/banner_add.jsp"%>
            <!-- 과정 더보기를 클릭하면 해당 아이디만 보여지게 하는거...!  -->
            <div class="courseWrapper">
                <div class="courseWrap textAlign_center" id="courseFilter">
                	<%@include file="../../include/course01.jsp"%>
                	<%@include file="../../include/course02.jsp"%>
                	<%-- <%@include file="../../include/course03.jsp"%> --%>
                	<%@include file="../../include/course04.jsp"%>
                </div>
            </div>
            <%@include file="../../include/banner_full.jsp"%>
        </div>
        <%@include file="../../include/rainbow_footer.jsp"%>
    </div>

</body>

</html>
