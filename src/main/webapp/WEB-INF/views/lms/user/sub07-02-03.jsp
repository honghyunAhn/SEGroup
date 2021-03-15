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
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Let's Do it 두잇캠퍼스</title>
	<link rel="stylesheet" href="/resources/lms/css/reset.css">
	<link rel="stylesheet" href="/resources/lms/css/common.css">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
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


    <div class="container subPage_container sub07 d-flex" id="main">
        <!-- sub07 나의강의실-include -->
        <%@include file="../user/menu/leftmenu07.jsp"%>

        <div class="subPage_content sub-content margin-left20 sub07 sub07-02">
            <div class="header">
                <div class="titleBar h3">결제현황/환불</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section sub07-02">
                <div class="sub-segment">
                    <ul class="class-list-title thead d-flex">
                        <!-- <li class="c-table-02">과정명</li> -->
                        <li class="c-table-02">과정명(기수)</li>
                        <li class="c-table-01">교육비</li>
                        <li class="c-table-01">마일리지사용</li>
                        <li class="c-table-01">결제금액</li>
                    </ul>
                    <ul class="class-list-wrap">

                        <li class="class-list d-flex text-center">
                            <%-- <div class="c-table-02 text-over-lh20" style="text-align:center; align-self:center;">${bankInfo.course_name}</div> --%>
                            <div class="c-table-02 text-over-lh20" style="text-align:center; align-self:center;">${bankInfo.cardinal_name }</div>
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${bankInfo.price}" pattern="#,###" />원</div>

                            <c:if test="${empty bankInfo.dis_point || bankInfo.dis_point == 'undefined'}">
                            <div class="c-table-01" style="text-align:center; align-self:center;">0점</div>
                            </c:if>
                            <c:if test="${not empty bankInfo.dis_point && bankInfo.dis_point != 'undefined'}">
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${bankInfo.dis_payment}" pattern="#,###" />점</div>
                            </c:if>

                            <c:if test="${empty bankInfo.real_payment || bankInfo.real_payment == 'undefined'}">
							<div class="c-table-01" style="text-align:center; align-self:center;">0원</div>
                            </c:if>
                            <c:if test="${not empty bankInfo.real_payment && bankInfo.real_payment != 'undefined'}">
							<div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${bankInfo.real_payment}" pattern="#,###" />원</div>
                            </c:if>

                        </li>
                    </ul>
                </div>
            </div>
            <div class="section sub07-02">
            <div class="h3" style="text-align:center; align-self:center;">가상계좌정보</div><br>
            <div class="sub-segment">
                    <table border="1" class="table">
                        <tbody>
                            <tr>
                                <th class="th">은행명</th>
                                <td>${bankInfo.bank_name }</td>
                                <!-- 아이디 전체공개할지? 일부공개할지? -->
                            </tr>
                            <tr>
                                <th class="th">계좌번호</th>
                                <td>${bankInfo.accnum }</td>
                            </tr>
                            <tr>
                            	<th class="th">결제기간</th>
                            	<td>${bankInfo.start} ~ ${bankInfo.end}</td>
                            </tr>
                            <tr>
                                <th class="th">결제하실 금액</th>
                                <td>
                                	<c:choose>
                                		<c:when test="${not empty bankInfo.dis_point && bankInfo.dis_point != 'undefined'}">
                                			<fmt:formatNumber value="${bankInfo.price - bankInfo.dis_point}" pattern="#,###" />원	
                                		</c:when>
                                		<c:otherwise>
                                			<fmt:formatNumber value="${bankInfo.price}" pattern="#,###" />원	
                                		</c:otherwise>
                                	</c:choose>
                                	
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="modal">
    	<div class="modal-layer"></div>
    	<div class="modal-content  printReceipt">
    		<%@include file="../user/modal/modal-sub07-02-01.jsp" %>
    	</div>
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
