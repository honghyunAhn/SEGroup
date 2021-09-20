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
            <div class="courseWrapper">
                <div class="courseWrap textAlign_center" id="courseFilter">
                	<%@include file="../../include/course04.jsp"%>
                </div>
            </div>
            <%@include file="../../include/banner_full.jsp"%>
        </div>
        <%@include file="../../include/rainbow_footer.jsp"%>
    </div>
</body>

</html>