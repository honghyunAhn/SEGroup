<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script language="javascript" type="text/javascript"
	src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">
	/**
	 * 결제를 진행한다
	 */
	function paybegin() {
		if (isCheckboxCorrect()) {
	        $("#gopaymethod").val(
	                document.querySelector('input[name="paykind"]:checked').value);
	        $("#payreq").click();
		}
	}
    /**
     * 동의체크를 확인한다
     */
    function isCheckboxCorrect() {
        var checkbox = $('.agree_line b.check_box');
        if (checkbox.hasClass('check_box_a') == false) {
            alert('수강취소 및 환불관련 규정에 동의하지 않으시면, 수강신청을 할 수 없습니다.');
            return false;
        }
        return true;
    }
</script>
<style type="text/css">
/* reset */
*{margin: 0; padding: 0}

h4 {
    font-size: 20px;
    margin: 15px 0px 5px 0px;
}
.linner {
    overflow: hidden;
    width: 100%;
    height: 10px;
}
</style>
</head>
<body>
	<%@include file="../menu.jsp"%>

	<!-- section -->
	<section class="join_section">
		<article>
			<h2>결제정보</h2>
            <br/>
			<h4>수강취소 및 환불관련 규정</h4>
            <div class="payform_box">
				<div class="agree agree_1" style="width: 950px; height: 200px;">
	                <p class="agree_title">수강취소 및 환불관련 규정</p>
	                <p class="agree_text">
		                <ul style="list-style-type: none;">
		                    <li>개강 이후 총 수업시간의 50% 초과 경과시에는 수강취소 및 환불이 불가함</li>
							<li>개강 이전 및 개강 후 수업시간의 50% 이하 경과시에는 아래 절차 및 규정에 따라 수강취소 및 환불 가능함.</li>
							<li>수강취소 절차</li>
							<li>1) 홈페이지『마이캠퍼스』에서 해당 과정을 선택한 후, 환불신청서를 작성.</li>
							<li>환불규정</li>
							<li>1) 무통장입금(가상계좌)의 경우</li>
							<li>개강일전 취소 時 : 가상계좌 이용수수료를 제외한 전액환불</li>
							<li>환불액 = 납입수강료 – 가상계좌 이용수수료(330원)</li>
							<li>개강 이후 취소 時 : 수강취소 위약금과 수업경과일수에 해당하는 수강료 일할 공제 후 잔여금액 환불</li>
							<li>환불액 = 납입수강료 – 위약금(수강료의 10%) – 일할 공제금액</li>
							<li>(납입수강료 × 수업경과일수/총 수업일수)</li>
							<li>2) 카드결제의 경우</li>
							<li>개강일전 취소 時 : 전액환불</li>
							<li>환불액 = 납입수강료 전액</li>
							<li>개강 이후 취소 時 : 수강취소 위약금과 수업경과일수에 해당하는 수강료 일할 공제 후 잔여금액 환불</li>
							<li>환불액 = 납입수강료 – 위약금(수강료의 10%) – 일할 공제금액</li>
							<li>(납입수강료 × 수업경과일수/총 수업일수)</li>
							<li>가상계좌 이용수수료 및 신용카드 이용수수료는 카드회사 및 결제대행사와의 계약내용변화에 따라 사전 공지 없이 변경될 수 있습니다.</li>
							<li>카드결제시 영수증은 이니시스 홈페이지에서 가능 ( http://www.inicis.com )</li>
							<li>가상계좌 입금시 계산서신청과 영수증출력은 마이캠퍼스-계산서 및 환급서류 페이지에서 가능</li>
		                </ul>
	                </p>
	            </div>
				<div class="agree_line">
	                <p class="terms">
	                    <b class="check_box"></b>위 내용에 동의합니다
	                </p>
	            </div>
            </div>
            <br/>
			<h4>결제방법 선택</h4>
            <div class="payform_box">
                <div>과정명<span style="margin-left: 26px;">${goodname}</span></div>
                <div class="linner"></div>
                <div>결제금액<span style="margin-left: 10px;"><fmt:formatNumber value="${price}" pattern="#,###" /> 원</span></div>
                <div class="linner"></div>
                <div>결제방법
		            <input id="payChoice1" class="only-sr checked" type="radio" name="paykind" value="Card" checked>
		            <label for="payChoice1">신용카드</label>
		            <input id="payChoice2" class="only-sr" type="radio" name="paykind" value="VBank">
		            <label for="payChoice2">가상계좌</label>
				</div>
                </div>
            </div>
            <br/>
            <div style="display: flex; align-items: center; justify-content: center;">
                <button class="confirms_btn" onclick="paybegin()">결제하기</button>
			</div>
			
			<!-- ActionするFormBox -->
			<form id="SendPayForm_id" name="" method="POST">
				<input type="hidden" name="version" value="1.0"> <input
					type="hidden" name="mid" value="${mid}"> <input
					type="hidden" name="goodname" value="${goodname}">
				<!-- 상품명=과정명 선택후 결정 -->
				<input type="hidden" name="oid" value="${oid}"> <input
					type="hidden" name="price" value="${price}">
				<!-- 사용자선택후 결정 -->
				<input type="hidden" name="currency" value="WON"> <input
					type="hidden" name="buyername" value="${user.user_nm}"> <input
					type="hidden" name="buyertel" value="${user.user_phone}">
				<input type="hidden" name="buyeremail" value="${user.user_email}">
				<input type="hidden" name="timestamp" value="${timestamp}">
				<input type="hidden" name="signature" value="${signature}">
				<input type="hidden" name="returnUrl"
					value="https://www.softsociety.net/edu/user/user_pay_info">
				<!--  <input type="hidden" name="closeUrl" value="www.naver.com" >  -->
				<input type="hidden" name="mKey" value="${mKey}"> <input
					type="hidden" name="gopaymethod" id="gopaymethod" value="">
				<input type="hidden" name="offerPeriod" value="${offerPeriod}">
				<input type="hidden" name="acceptmethod"
					value="CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000">
				<input type="hidden" name="payViewType" value="overlay"> <input
					type="hidden" name="languageView" value=""> <input
					type="hidden" name="charset" value=""> <input
					type="hidden" name="quotabase" value="${cardQuotaBase}"> <input
					type="hidden" name="ini_onlycardcode" value=""> <input
					type="hidden" name="ini_cardcode" value=""> <input
					type="hidden" name="ansim_quota" value=""> <input
					type="hidden" name="vbankRegNo" value=""> <input
					type="hidden" name="merchantData" id="merchantData" value="${seq}">
					<input
					type="hidden" name="merchantData" id="merchantId" value="${user_id}">
			</form>
			<%-- ${seq} --%>
			<button onclick="INIStdPay.pay('SendPayForm_id')" id="payreq"
				style="display: none;">결제하기</button>
		</article>
	</section>
	<!--  join_section -->

	<!-- footer -->
	<%@include file="../footer.jsp"%>
</body>
</html>