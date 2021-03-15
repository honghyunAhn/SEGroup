<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    <script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
	<!-- bxSlider CSS file -->
	<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
	<script>
		$(document).ready(function() {
			$("#btnWrite").click(function() {
				// 페이지 주소 변경(이동)
				location.href = "/board/write.do";
			});
	
		});
	
		function goToNear(seq, nearType) {
			location.href = "/smtp/community/sub04-01-01.do?seq=" + seq + "&searchOption=" + nearType;
		}
	
		function goToList() {
			location.href = "/smtp/community/sub04-01.do";
		}
	</script>
</head>
<body>
	<div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub04_content" id="main">
            <div class="header_textWrap">
                <h3 class="h3">공지사항</h3>
                <p class="fc_999">
                	SES에서 알려드립니다!
                </p>
            </div>
            <div class="section section_sub04-01">
            	<hr>
            	<header style="background: #f5f5f5;">
					<h2 style="padding: 20px;">${boardDetail.board_content_title}</h2>
				</header>
				<hr>
				<span style="display: inline; text-align: right;">
					<div>
						<h5>
							<span style="padding-right: 20px;"> 게시자 : ${boardDetail.board_content_nm } </span>
							<span style="padding-right: 20px;"> 날짜 : ${boardDetail.board_content_udt_dt } </span>
							<span style="padding-right: 20px;"> 조회수 : ${boardDetail.board_content_hit } </span>
						</h5>
					</div>
				</span>
				<br> <br>
				<span class="imageContent"> ${boardDetail.board_content_ct } </span>
				<br> <br>
				<hr>
				<br>
				<c:if test="${fn:length(files) gt 0}">
					<h3>첨부파일</h3>
					<c:forEach var="data" items="${files}" varStatus="status">
						<br>
						<table>
							<tr class="notice_top" style="text-align: left;">
								<td class="notice_icon1">
									<a href="/file_download?origin=${data.board_file_origin}&saved=${data.board_file_saved}&path=${path}">${data.board_file_origin}</a>
								</td>
							</tr>
						</table>
					</c:forEach>
					<br>
					<hr>
					<br>
				</c:if>
				<div class="gal_last button-wrap">
					<div class="gal_write">
						<span style="width: 100%;">
							<c:if test="${boardDetail.board_content_seq_min != boardDetail.board_content_seq}">
								<input type="button" class="btn_normal btn_medium btn_pp btn-agree btn-wh" onclick="goToNear('${boardDetail.board_content_seq}' ,'previous')" name="" value="이전글">
							</c:if>
							<c:if test="${boardDetail.board_content_seq_max != boardDetail.board_content_seq}">
								<input type="button" class="btn_normal btn_medium btn_pp btn-agree btn-wh" onclick="goToNear('${boardDetail.board_content_seq}', 'next')" name="" value="다음글">
							</c:if>
							<input type="button" class="btn_normal btn_medium btn_pp btn-agree btn-wh"  onclick="goToList()" name="" value="목록">
						</span>
					</div>
				</div>
            </div>
        </div>
        <!-- footer-include -->
	    <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>
</html>