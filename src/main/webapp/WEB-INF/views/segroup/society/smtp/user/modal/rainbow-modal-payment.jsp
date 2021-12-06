<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="modal payment">
    <div class="sub-content modal-content course-point05" id="main">
        <div class="modal-header d-flex justify_between">
            <h3 class="h3">계좌정보</h3>
            <div class="img-icon times close-modal" onclick="closeModal()"></div>
        </div>
        <table class="modal-table">
            <thead class="table-title thead">
                <tr>
                    <th>과정명</th>
                    <th>기수</th>
                    <th>교육비</th>
                    <th>마일리지사용</th>
                    <th>결제금액</th>
                </tr>
            </thead>
            <tbody class="table-list tbody">
                <tr>
                    <!-- 과정명 -->
                    <td>${bankInfo.course_name}</td>

                    <!-- 기수 -->
                    <td>${bankInfo.cardinal_name}</td>

                    <!-- 교육비 -->
                    <td>
                        <fmt:formatNumber value="${bankInfo.price}" pattern="#,###" />원
                    </td>

                    <!-- 마일리지사용 -->
                    <c:if test="${bankInfo.dis_point == '' || bankInfo.dis_point == null}">
                        <td>0점</td>
                    </c:if>
                    <!-- <c:if test="${bankInfo.dis_point != '' && bankInfo.dis_point != null}">
                        <td>
                            <fmt:formatNumber value="${refundInfo.dis_point }" pattern="#,###" />점
                        </td>
                    </c:if> -->

                    <!-- 결제금액 -->
                    <c:if test="${bankInfo.real_payment == '' || bankInfo.real_payment == null}">
                        <td>0원</td>
                    </c:if>
                    <!-- <c:if test="${bankInfo.real_payment != '' && bankInfo.real_payment != null}">
                        <td>
                            <fmt:formatNumber value="${bankInfo.real_payment}" pattern="#,###" />원
                        </td>
                    </c:if> -->
                </tr>
            </tbody>
        </table>
        <div class="section_header">
            <h3 class="h3">가상계좌정보</h3>
            <p class="margin-top10 fc_999">
                결제 시 입력한 성명과 실제입금자의 성명이 반드시 일치하여야 하며,<br>
                영업일 기준 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.
            </p>
        </div>
        <div class="section_table">
            <ul class="table-title d-flex thead fc_point">
                <li class="w200">은행명</li>
                <li class="w200">계좌번호</li>
                <li class="w200">결제하실 금액</li>
            </ul>
            <ul class="table-list tbody">
                <li class="list d-flex">
                    <div class="w200">${bankInfo.bank_name}</div>
                    <div class="w200">${bankInfo.accnum}</div>
                    <div class="w200">
                        <fmt:formatNumber value="${bankInfo.real_payment- bankInfo.dis_point}" pattern="#,###" />원
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
