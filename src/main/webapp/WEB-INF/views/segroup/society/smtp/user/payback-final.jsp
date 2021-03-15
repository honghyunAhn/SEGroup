<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<style>
	.labels{
		font-size:25px;
	}

</style>
      <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    
	<!-- 레인보우 기본 세팅 -->
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/lms/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
	<link rel="stylesheet" href="/resources/lms/css/reset.css">
	<link rel="stylesheet" href="/resources/lms/css/common.css">
	<link rel="stylesheet" href="/resources/lms/css/style.css">
	<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
	<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script>  --%>
    <!-- Pagination -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
</head>
<body>
    <div class="container_rainbow">
    	<!-- header-include -->
    	<%@include file="../include/rainbow_header_basic.jsp" %>
    	
        <div class="content sub-content sub05_content" id="main">
            <div class="header">
                <div class="titleBar h3">계좌정보</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section section_sub05-01">
                <div class="sub-segment table">
                    <ul class="class-list-title thead d-flex">
                        <li class="c-table-02">과정명</li>
                        <li class="c-table-02">기수</li>
                        <li class="c-table-01">교육비</li>
						<li class="c-table-01">마일리지사용</li>
                        <li class="c-table-01">결제금액</li>
                    </ul>
                    <ul class="class-list-wrap">

                        <li class="class-list d-flex text-center">
                            <div class="c-table-02 text-over-lh20" style="text-align:center; align-self:center;">${bankInfo.course_name}</div>
                            <div class="c-table-02 text-over-lh20" style="text-align:center; align-self:center;">${bankInfo.cardinal_name }</div>
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${bankInfo.price}" pattern="#,###" />원</div>
	
							<c:if test="${bankInfo.dis_point == '' || bankInfo.dis_point == null}">
                            <div class="c-table-01" style="text-align:center; align-self:center;">0점</div>
                            </c:if>
                            <c:if test="${bankInfo.dis_point != '' && bankInfo.dis_point != null}">
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${bankInfo.dis_point }" pattern="#,###" />점</div>
                            </c:if>

                            <c:if test="${bankInfo.real_payment == '' || bankInfo.real_payment == null}">
							<div class="c-table-01" style="text-align:center; align-self:center;">0원</div>
                            </c:if>
                            <c:if test="${bankInfo.real_payment != '' && bankInfo.real_payment != null}">
							<div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${bankInfo.real_payment }" pattern="#,###" />원</div>
                            </c:if>

                        </li>
                    </ul>
                </div>
            </div>
            <div class="section section_sub05-01">
            <div class="h3" style="text-align:center; align-self:center;">가상계좌정보</div><br>
            <div class="sub-segment table">
                    <table border="1" class="table">
                        <tbody>
                            <tr>
                                <th class="th">은행명</th>
                                <td>${bankInfo.bank_name }</td>
                            </tr>
                            <tr>
                                <th class="th">계좌번호</th>
                                <td>${bankInfo.accnum }</td>
                            </tr>
                            <tr>
                                <th class="th">결제하실 금액</th>
                                <td><fmt:formatNumber value="${bankInfo.real_payment- bankInfo.dis_point}" pattern="#,###" />원</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
               <div class="margin-top40">
					<input type="button" onclick="location.href='/smtp/user/sub05-04'" class="btn_normal btn_pp_bg btn_medium" style="height:30px;" value="돌아가기">
				</div>
            </div>
        </div>
        <!-- footer-include -->
    	<%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>

</html>
