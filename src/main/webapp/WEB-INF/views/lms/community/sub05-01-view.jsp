<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Soft Engineer Society</title>
    <link rel="stylesheet" href="/resources/lms/css/reset.css">
	<link rel="stylesheet" href="/resources/lms/css/common.css">
	<link rel="stylesheet" href="/resources/lms/css/img-icon.css">
	<link rel="stylesheet" href="/resources/lms/css/style.css">
	<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
	<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
    <script type="text/javascript" src="/resources/lms/js/lms_community_script.js"></script>
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
<script>
	$(document).ready(function(){
		
		$('.post-content>h2>a').unwrap();
		$('.post-content>a').wrapAll('<div class="d-flex justify_end margin-top40"></div>');
		$('.post-content>.d-flex>a').addClass('btn_normal btn_small btn_orangeD');
		
		<c:forEach items="${prevNext}" var="prevNext">
			if(${prevNext.gubun == "PREV"}){
				$('.prev-step').attr('data-value', ${prevNext.id});
			} else if(${prevNext.gubun == "NEXT"}){
				$('.next-step').attr('data-value', ${prevNext.id});
			} 
		</c:forEach>
		
		
		$('.prev-step').on('click', function(){
			var id = $(this).attr('data-value');
			if(id==null || id==""){
				alert('이전 글이 없습니다.');
				return;
			}
			document.location.href = "/lms/community/sub05-01-view?board_type=" + ${board_type} + "&notice_type=" + ${notice_type} + "&id=" + id;
		});

		
		$('.next-step').on('click', function(){
			var id = $(this).attr('data-value');
			if(id==null || id==""){
				alert('다음 글이 없습니다.');
				return;
			}
			document.location.href = "/lms/community/sub05-01-view?board_type=" + ${board_type} + "&notice_type=" + ${notice_type} + "&id=" + id;
		});
	});
</script>
</head>
<body>
    <div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a class="goToMain" href="#main">콘텐츠 바로가기</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../sub_header.jsp"%>


    <div class="container subPage_container sub05 d-flex">
        <!-- sub05 커뮤니티-include -->
        <%@include file="../community/menu/leftmenu.jsp"%>
        <div class="subPage_content sub-content sub05-01 write-post margin-left20" id="main">
            <div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">공지사항/이벤트</h3>
                    <p class="fc_999">공지사항 및 이벤트를 알려드립니다. 유익하고 풍성한 소식 놓치지 말고 확인하세요</p>
                </div>
            </div>      
            <div class="section">
                <form action="" id="" class="formStyle" method="post">
                    <div class="d-flex post-titleWrap">
                        <label class="label" for="post-title">제 목</label>
                        <div class="post-title">${bbsDetail.board_content_title}</div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="date">작성일</label>
                        <div class="date">
                        	<fmt:formatDate value="${bbslist.board_content_ins_dt}" pattern="yyyy-MM-dd"/>
						</div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="user-name">작성자</label>
                        <div class="user-name">${bbsDetail.board_content_nm}</div>
                    </div>
                    <div class="post-content" style="height:auto">${bbsDetail.board_content_ct}</div>
                </form>
                <div class="button-wrap d-flex">
                    <button type="button" onclick="location.href='/lms/community/sub05-01-01'" class="btn-normal btn_medium btn_orangeD btn-list">글 목록</button>					
                </div>
            </div>
        </div>
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
