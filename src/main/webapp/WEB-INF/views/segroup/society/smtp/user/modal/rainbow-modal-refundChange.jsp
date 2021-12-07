<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="modal refundChange">
    <div class="sub-content modal-content course-point05" id="main">
        <div class="modal-header d-flex justify_between">
            <h3 class="h3">환불현황</h3>
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
                    <td>${refundInfo.course_name}</td>

                    <!-- 기수 -->
                    <td>${refundInfo.cardinal_name}</td>

                    <!-- 교육비 -->
                    <td>
                        <fmt:formatNumber value="${refundInfo.price}" pattern="#,###" />원
                    </td>

                    <!-- 마일리지사용 -->
                    <c:if test="${refundInfo.dis_point == '' || refundInfo.dis_point == null}">
                        <td>0점</td>
                    </c:if>
                    <!-- <c:if test="${refundInfo.dis_point != '' && refundInfo.dis_point != null}">
                        <td>
                            <fmt:formatNumber value="${refundInfo.dis_point }" pattern="#,###" />점
                        </td>
                    </c:if> -->

                    <!-- 결제금액 -->
                    <c:if test="${refundInfo.real_payment == '' || refundInfo.real_payment == null}">
                        <td>0원</td>
                    </c:if>
                    <!-- <c:if test="${refundInfo.real_payment != '' && refundInfo.real_payment != null}">
                        <td>
                            <fmt:formatNumber value="${refundInfo.real_payment }" pattern="#,###" />원
                        </td>
                    </c:if> -->
                </tr>
            </tbody>
        </table>
        <input type="hidden" id="serverMessage" value="${message}">
        <div class="section_formStyle">
            <form class="formStyle login" action="/smtp/user/sub05-04-01-submit" method="post" id="refund_form">
                <input type="hidden" name="id" value="${refundInfo.learn_id}">
                <input type="hidden" name="pay_user_seq" value="${refundInfo.pay_user_seq}">
                <input type="hidden" name="pay_user_method" value="${refundInfo.pay_user_method}">

                <div class="formWrap">
                    <label class="label" for="bank">은행명</label>
                    <input type="text" class="input" id="bank" name="bank" placeholder="은행명을 입력하세요.">
                </div>
                <div class="formWrap">
                    <label class="label" for="account">계좌번호</label>
                    <input type="text" class="input" id="account" name="account" placeholder="계좌번호를 입력하세요.">
                </div>
                <div class="formWrap">
                    <label class="label" for="owner">예금주</label>
                    <input type="text" class="input" id="owner" name="owner" placeholder="예금주를 입력하세요.">
                </div>
            </form>
        </div>
        <div class="section_btnWrap d-flex justify_center">
            <input type="button" id="refund_submit" class="btn_default btn_xlarge margin-right10" value="환불수정">
            <input type="button" id="refund_cancel" class="btn_normal btn_xlarge bgc_point" value="환불취소">
        </div>
    </div>
</div>
<!-- 기존 레인보우사이트 text/javascript 복사 -->
<!-- <script type="text/javascript">
    $(function () {

        $('#refund_submit').on('click', function () {
            if ($('#bank').val() == '' || $('#bank').val() == null) {
                alert('은행이름을 기입해주세요');
                return;
            }
            if ($('#account').val() == '' || $('#account').val() == null) {
                alert('계좌번호를 기입해주세요');
                return;
            }
            if ($('#owner').val() == '' || $('#owner').val() == null) {
                alert('예금주를 기입해주세요');
                return;
            }

            if (confirm('환불정보를 수정하시겠습니까?')) {
                $('#refund_form').submit();
            }
        });

        $('#refund_cancel').on('click', function () {
            var pay_user_seq = '${accInfo.PAY_USER_SEQ}';
            if (confirm('환불신청을 취소하시겠습니까?')) {
                $.ajax({
                    type: "post",
                    url: "/smtp/user/paymentCancel",
                    data: {
                        'pay_user_seq': pay_user_seq
                    },
                    success: function (flag) {
                        if (flag) {
                            alert('환불취소 성공했습니다.');
                            window.location.href = "/segroup/society/smtp/user/sub07-02";
                        } else {
                            alert('환불취소 실패했습니다.');
                            window.location.href = "/segroup/society/smtp/user/sub07-02";
                        }
                    }
                });
            }
        });

    });
</script> -->