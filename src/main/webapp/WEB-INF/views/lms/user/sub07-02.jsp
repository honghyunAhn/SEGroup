<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">

<head>
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
<!-- Pagination을 위한 js -->
<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>

<script>
	
	$(document).ready(function() {
		
		var state =$("#serverMessage").val();
		
		if(state=="payComplete"){
			alert("결제에 성공하셨습니다. 나의 강의실에서 확인해주세요.");
		}else if(state=="payError"){
			alert("결제에 실패하셨습니다.");
		}
		
 		var classTabMenu = $('#mainDisplay >.tabGroup >li');
		var j = 0;
		classTabMenu.on('click', function () {
			$('#startPage').val(1);
			$('input[name=search]').val('');
			j = $(this).index();
			
			switch(j) {
			case 0:
				getPaymentList(j);
				break;
			case 1:	
				getToeflPaymentList(j);
				break;
			}
		});
		
		function getPaymentList (index) {
			
			//페이징 처리용 변수
			var search = $('input[name=search]').val();
			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				data : {
					"startPage" : startPage,
					"search" : search
				},
				url		: "/lms/user/sub07-02-list",
				async:false,
				success	: function(data) {
					var content = "";
					console.log(data);
					$.each(data, function(index, item) {
/* 						content += '<form name="listForm" method="post" onsubmit="return false;">';
						content += '<input type="hidden" name="course_id" value="'+ item.COURSE_ID + '" />';
						content += '<input type="hidden" name="cardinal_id" value="'+ item.CARDINAL_ID + '" />';
						content += '<input type="hidden" name="realPayment" value="'+ item.REAL_PAYMENT+'" />';
						content += '<input type="hidden" name="courseName" value="'+ item.COURSE_NAME + '" />';
						content += '<input type="hidden" name="user_nm" value="${user_nm}" />';
						content += '</form>'; */
						content += '<li class="class-list d-flex text-center">';
						content += 		'<div class="c-table-num" style="align-self: center;">'+ (index+1) + '</div>';
						content += 		'<div class="c-table-02 text-over-lh20" style="text-align: center; align-self: center;">'+ item.CARDINAL_NAME + '</div>';
						content += 		'<div class="c-table-01" style="text-align: center; align-self: center;">';
						
						if(item.PAY_CRC_AMOUNT =='' || item.PAY_CRC_AMOUNT == null) {
							content +=  '0원</div>';	
						} else if(item.PAY_CRC_AMOUNT !='' || item.PAY_CRC_AMOUNT != null) {
							content += 		(item.PAY_CRC_AMOUNT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원</div>';	
						}
						
						if(item.DIS_POINT =='' || item.DIS_POINT == null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">0점</div>';
						} else if(item.DIS_POINT !='' || item.DIS_POINT != null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">';
							content += (item.DIS_POINT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원</div>'
						}
						if(item.REAL_PAY_AMOUNT =='' || item.REAL_PAY_AMOUNT == null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">0원</div>';
						} else if(item.REAL_PAY_AMOUNT !='' || item.REAL_PAY_AMOUNT != null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">';
							content += (item.REAL_PAY_AMOUNT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원</div>'
						}
						
						if(item.payment_type == 'VBank') {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">가상계좌</div>';
						} else if (item.payment_type == 'Card') {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">신용카드</div>';
						} else if (item.PAY_CRC_AMOUNT == item.DIS_POINT && item.DIS_POINT != '' && item.DIS_POINT != null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">마일리지</div>';
						} else {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">무료</div>';
						}
						
						if (item.payment_type == 'VBank' && item.PAYMENT_STATUS == "F0000") {
							content += '<div class="c-table-num payment-wait" style="text-align: center; align-self: center;">대기</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="paymentForm'+ item.ID + '" action="/lms/user/sub07-02-03" method="post">';
							content += 		'<input type="hidden" name="learn_id" value="'+ item.ID + '">';
							content += 		'<input type="hidden" name="user_nm" value="${user_nm}">';
							content += 		'<input type="hidden" name="course_id" value="'+ item.COURSE_ID + '">';
							content += 		'<input type="hidden" name="cardinal_id" value="'+ item.CARDINAL_ID + '">';
							content += 		'<input type="hidden" name="course_name" value="'+ item.COURSE_NAME + '">';
							content += 		'<input type="hidden" name="cardinal_name" value="'+ item.CARDINAL_NAME +'">'
							content += 		'<input type="hidden" name="price" value="'+ item.PAY_CRC_AMOUNT + '">';
							content += 		'<input type="hidden" name="dis_point" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="real_payment" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="accnum" value="' + item.ACCNUM + '">';
							content += 		'<input type="hidden" name="bank_name" value="' + item.BANKNAME + '">';
							content += 		'<input type="hidden" name="start" value="' + item.PAY_CRC_START + '">';
							content += 		'<input type="hidden" name="end" value="' + item.PAY_CRC_END + '">';
							content += 		'<a onclick="document.getElementById(\'paymentForm'+ item.ID + '\').submit();" class="refundBox btn_normal btn_small btn_default h5">계좌 정보</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num" style="test-align: center; align-self: center;"></div>';
						} else if (item.payment_type == 'VBank' && item.PAYMENT_STATUS == "F0001") {
							content += '<div class="c-table-num payment-wait" style="text-align: center; align-self: center;">완료</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="refundForm'+ item.ID + '" action="/lms/user/sub07-02-01" method="post">';
							content += 		'<input type="hidden" name="learn_id" value="'+ item.ID + '">';
							content += 		'<input type="hidden" name="user_nm" value="${user_nm}">';
							content += 		'<input type="hidden" name="pay_user_seq" value="'+ item.PAY_USER_SEQ +'">';
							content += 		'<input type="hidden" name="course_id" value="'+ item.COURSE_ID + '">';
							content += 		'<input type="hidden" name="cardinal_id" value="'+ item.CARDINAL_ID + '">';
							content += 		'<input type="hidden" name="course_name" value="'+ item.COURSE_NAME + '">';
							content += 		'<input type="hidden" name="cardinal_name" value="'+ item.CARDINAL_NAME +'">'
							content += 		'<input type="hidden" name="price" value="'+ item.PAY_CRC_AMOUNT + '">';
							content += 		'<input type="hidden" name="pay_crc_seq" value="'+ item.PAY_CRC_SEQ +'">';
							content += 		'<input type="hidden" name="dis_point" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="real_payment" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="accnum" value="' + item.ACCNUM + '">';
							content += 		'<input type="hidden" name="bank_name" value="' + item.BANKNAME + '">';
							content += 		'<a onclick="document.getElementById(\'refundForm'+ item.ID  +  '\').submit();" class="refundBox btn_normal btn_small btn_orangeD h5" id="refund_button">환불 신청</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num print-icon modal-popup">';
							content += '<a href="#" class="btn_normal btn_default btn_small">';
							content += '<div class="img-icon print"></div>';
							content += '<h5 class="h5 margin-left5">출력</h5>';
							content += '</a>';
							content += '</div>';
						}
						else if(item.PAYMENT_STATUS == "F0000") {
							content += '<div class="c-table-num payment-wait btn_refund" style="text-align: center; align-self: center;">대기</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<a href="#" class="refundBox btn_normal btn_small h5" style="text-align: center; align-self: center;">불가</a>';
							content += '</div>';
							content += '<div class="c-table-num" style="test-align: center; align-self: center;"></div>';
						} else if (item.PAYMENT_STATUS == "F0001") {
							content += '<div class="c-table-num payment-complete" style="text-align: center; align-self: center;">완료</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="refundForm'+ item.ID  +'" action="/lms/user/sub07-02-01" method="post">';
							content += 		'<input type="hidden" name="learn_id" value="'+ item.ID + '">';
							content += 		'<input type="hidden" name="user_nm" value="${user_nm}">';
							content += 		'<input type="hidden" name="pay_user_seq" value="'+ item.PAY_USER_SEQ +'">';
							content += 		'<input type="hidden" name="course_id" value="'+ item.COURSE_ID + '">';
							content += 		'<input type="hidden" name="cardinal_id" value="'+ item.CARDINAL_ID + '">';
							content += 		'<input type="hidden" name="course_name" value="'+ item.COURSE_NAME + '">';
							content += 		'<input type="hidden" name="cardinal_name" value="'+ item.CARDINAL_NAME +'">'
							content += 		'<input type="hidden" name="price" value="'+ item.PAY_CRC_AMOUNT + '">';
							content += 		'<input type="hidden" name="pay_crc_seq" value="'+ item.PAY_CRC_SEQ +'">';
							content += 		'<input type="hidden" name="dis_point" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="real_payment" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="accnum" value="' + item.ACCNUM + '">';
							content += 		'<input type="hidden" name="bank_name" value="' + item.BANKNAME + '">';
							content += 		'<a onclick="document.getElementById(\'refundForm'+ item.ID + '\').submit();" class="refundBox btn_normal btn_small btn_orangeD h5" id="refund_button">환불 신청</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num print-icon modal-popup">';
							content += '<a href="#" class="btn_normal btn_default btn_small">';
							content += '<div class="img-icon print"></div>';
							content += '<h5 class="h5 margin-left5">출력</h5>';
							content += '</a>';
							content += '</div>';
						} else if (item.PAYMENT_STATUS == "F0002") {
							content += '<div class="c-table-num payment-complete" style="text-align: center; align-self: center;">환불요청</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="refundUpdateForm'+ item.ID  +'" action="/lms/user/sub07-02-02" method="post">';
							content += 		'<input type="hidden" name="learn_id" value="'+ item.ID + '">';
							content += 		'<input type="hidden" name="user_nm" value="${user_nm}">';
							content += 		'<input type="hidden" name="pay_user_seq" value="'+ item.PAY_USER_SEQ +'">';
							content += 		'<input type="hidden" name="pay_crc_seq" value="'+ item.PAY_CRC_SEQ +'">';
							content += 		'<input type="hidden" name="course_id" value="'+ item.COURSE_ID + '">';
							content += 		'<input type="hidden" name="cardinal_id" value="'+ item.CARDINAL_ID + '">';
							content += 		'<input type="hidden" name="course_name" value="'+ item.COURSE_NAME + '">';
							content += 		'<input type="hidden" name="cardinal_name" value="'+ item.CARDINAL_NAME +'">'
							content += 		'<input type="hidden" name="price" value="'+ item.PAY_CRC_AMOUNT + '">';
							content += 		'<input type="hidden" name="dis_point" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="real_payment" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="accnum" value="' + item.ACCNUM + '">';
							content += 		'<input type="hidden" name="bank_name" value="' + item.BANKNAME + '">';
							content += 		'<a onclick="document.getElementById(\'refundUpdateForm'+ item.ID  +  '\').submit();" class="refundBox btn_normal btn_small btn_mintL h5" id="refund_button">수정&#47;취소</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num print-icon modal-popup">';
							content += '<a href="#" class="btn_normal btn_default btn_small">';
							content += '<div class="img-icon print"></div>';
							content += '<h5 class="h5 margin-left5">출력</h5>';
							content += '</a>';
							content += '</div>';
						} else if (item.PAYMENT_STATUS == "F0003") {
							content += '<div class="c-table-num payment-complete" style="text-align: center; align-self: center;">완료</div>';
							content += '<div class="c-table-num d-flex btn_refund">';
							content += '<a class="refundBox btn_normal btn_small btn_mintL h5">환불완료</a>';
							content += '</div>';
							content += '<div class="c-table-num"></div>';
						} else {
							content += '<div class="c-table-num" style="text-align: center; align-self: center;"></div>';
							content += '<div class="c-table-num d-flex btn_refund">';
							content += '</div>';
							content += '<div class="c-table-num"></div>';
						}
						content += '</li>';
					});
					
					if(content=="") {
						content += '<li class="listAndwrap"><div class="class-list not"><p>결제정보가 없습니다.</p></div></li>';
					}
					$('.class-list-wrap.load-data').html(content);
				}
				
			})
			
			pagingFunc(index, search);
		}
		
		function getToeflPaymentList(index) {
			
			//페이징 처리용 변수
			var search = $('input[name="search"]').val();
			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				data : {
					"startPage" : startPage,
					"search" : search
				},
				url		: "/lms/user/sub07-02-toefl",
				async:false,
				success	: function(data) {
					var content = "";
					$.each(data, function(index, item) {
/* 						content += '<form name="listForm" method="post" onsubmit="return false;">';
						content += '<input type="hidden" name="course_id" value="'+ item.COURSE_ID + '" />';
						content += '<input type="hidden" name="cardinal_id" value="'+ item.CARDINAL_ID + '" />';
						content += '<input type="hidden" name="realPayment" value="'+ item.REAL_PAYMENT+'" />';
						content += '<input type="hidden" name="courseName" value="'+ item.COURSE_NAME + '" />';
						content += '<input type="hidden" name="user_nm" value="${user_nm}" />';
						content += '</form>'; */
						content += '<li class="class-list d-flex text-center">';
						content += 		'<div class="c-table-num" style="align-self: center;">'+ (index+1) + '</div>';
						content += 		'<div class="c-table-02 text-over-lh20" style="text-align: center; align-self: center;">'+ item.TOEFL_TITLE + '</div>';
						content += 		'<div class="c-table-01" style="text-align: center; align-self: center;">';
						
						if(item.TOEFL_PRICE =='' || item.TOEFL_PRICE == null) {
							content +=  '0원</div>';	
						} else if(item.TOEFL_PRICE !='' || item.TOEFL_PRICE != null) {
							content += 		(item.TOEFL_PRICE).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원</div>';	
						}
						
						if(item.DIS_POINT =='' || item.DIS_POINT == null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">0점</div>';
						} else if(item.DIS_POINT !='' || item.DIS_POINT != null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">';
							content += (item.DIS_POINT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원</div>'
						}
						if(item.REAL_PAY_AMOUNT =='' || item.REAL_PAY_AMOUNT == null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">0원</div>';
						} else if(item.REAL_PAY_AMOUNT !='' || item.REAL_PAY_AMOUNT != null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">';
							content += (item.REAL_PAY_AMOUNT).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '원</div>'
						}
						
						if(item.PAYMENT_TYPE == 'VBank') {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">가상계좌</div>';
						} else if (item.PAYMENT_TYPE == 'Card') {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">신용카드</div>';
						} else if (item.TOEFL_PRICE == item.DIS_POINT && item.DIS_POINT != '' && item.DIS_POINT != null) {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">마일리지</div>';
						} else {
							content += '<div class="c-table-01" style="text-align: center; align-self: center;">무료</div>';
						}
						
						if (item.PAYMENT_TYPE == 'VBank' && item.PAYMENT_STATUS == "F0000") {
							content += '<div class="c-table-num payment-wait" style="text-align: center; align-self: center;">대기</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="paymentToeflForm'+ item.PAY_TOEFL_SEQ + '" action="/lms/user/sub07-02-04" method="post">';
							content += 		'<input type="hidden" name="TOEFL_TITLE" value="'+ item.TOEFL_TITLE + '">';
							content += 		'<input type="hidden" name="TOEFL_PRICE" value="'+ item.TOEFL_PRICE + '">';
							content += 		'<input type="hidden" name="DIS_POINT" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="REAL_PAY_AMOUNT" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="ACCNUM" value="' + item.ACCNUM + '">';
							content += 		'<input type="hidden" name="BANKNAME" value="' + item.BANKNAME + '">';
							content += 		'<a onclick="document.getElementById(\'paymentToeflForm'+ item.PAY_TOEFL_SEQ + '\').submit();" class="refundBox btn_normal btn_small btn_default h5">계좌 정보</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num" style="test-align: center; align-self: center;"></div>';
						} else if (item.PAYMENT_TYPE == 'VBank' && item.PAYMENT_STATUS == "F0001") {
							content += '<div class="c-table-num payment-wait" style="text-align: center; align-self: center;">완료</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="refundToeflForm'+ item.PAY_TOEFL_SEQ + '" action="/lms/user/sub07-02-05" method="post">';
							content += 		'<input type="hidden" name="user_nm" value="${user_nm}">';
							content += 		'<input type="hidden" name="PAY_TOEFL_SEQ" value="'+ item.PAY_TOEFL_SEQ + '">';
							content += 		'<input type="hidden" name="TOEFL_TITLE" value="'+ item.TOEFL_TITLE + '">';
							content += 		'<input type="hidden" name="TOEFL_PRICE" value="'+ item.TOEFL_PRICE + '">';
							content += 		'<input type="hidden" name="DIS_POINT" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="REAL_PAY_AMOUNT" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="TOEFL_ID" value="'+ item.TOEFL_ID+ '">';
							content += 		'<a onclick="document.getElementById(\'refundToeflForm'+ item.PAY_TOEFL_SEQ  +  '\').submit();" class="refundBox btn_normal btn_small btn_orangeD h5" id="refund_button">환불 신청</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num print-icon toefl-popup">';
							content += '<a href="#" class="btn_normal btn_default btn_small">';
							content += '<div class="img-icon print"></div>';
							content += '<h5 class="h5 margin-left5">출력</h5>';
							content += '</a>';
							content += '</div>';
						}
						else if(item.PAYMENT_STATUS == "F0000") {
							content += '<div class="c-table-num payment-wait btn_refund" style="text-align: center; align-self: center;">대기</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<a href="#" class="btn_normal btn_small h5" style="text-align: center; align-self: center;">불가</a>';
							content += '</div>';
							content += '<div class="c-table-num" style="test-align: center; align-self: center;"></div>';
						} else if (item.PAYMENT_STATUS == "F0001") {
							content += '<div class="c-table-num payment-complete" style="text-align: center; align-self: center;">완료</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="refundToeflForm'+ item.PAY_TOEFL_SEQ  +'" action="/lms/user/sub07-02-05" method="post">';
							content += 		'<input type="hidden" name="user_nm" value="${user_nm}">';
							content += 		'<input type="hidden" name="PAY_TOEFL_SEQ" value="'+ item.PAY_TOEFL_SEQ + '">';
							content += 		'<input type="hidden" name="TOEFL_TITLE" value="'+ item.TOEFL_TITLE + '">';
							content += 		'<input type="hidden" name="TOEFL_PRICE" value="'+ item.TOEFL_PRICE + '">';
							content += 		'<input type="hidden" name="DIS_POINT" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="REAL_PAY_AMOUNT" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="TOEFL_ID" value="'+ item.TOEFL_ID+ '">';
							content += 		'<a onclick="document.getElementById(\'refundToeflForm'+ item.PAY_TOEFL_SEQ + '\').submit();" class="refundBox btn_normal btn_small btn_orangeD h5" id="refund_button">환불 신청</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num print-icon toefl-popup">';
							content += '<a href="#" class="btn_normal btn_default btn_small">';
							content += '<div class="img-icon print"></div>';
							content += '<h5 class="h5 margin-left5">출력</h5>';
							content += '</a>';
							content += '</div>';
						} else if (item.PAYMENT_STATUS == "F0002") {
							content += '<div class="c-table-num payment-complete" style="text-align: center; align-self: center;">환불요청</div>';
							content += '<div class="c-table-num btn_refund">';
							content += '<form id="refundToeflUpdateForm'+ item.PAY_TOEFL_SEQ  +'" action="/lms/user/sub07-02-06" method="post">';
							content += 		'<input type="hidden" name="user_nm" value="${user_nm}">';
							content += 		'<input type="hidden" name="PAY_TOEFL_SEQ" value="'+ item.PAY_TOEFL_SEQ + '">';
							content += 		'<input type="hidden" name="TOEFL_TITLE" value="'+ item.TOEFL_TITLE + '">';
							content += 		'<input type="hidden" name="TOEFL_PRICE" value="'+ item.TOEFL_PRICE + '">';
							content += 		'<input type="hidden" name="DIS_POINT" value="'+ item.DIS_POINT+ '">';
							content += 		'<input type="hidden" name="REAL_PAY_AMOUNT" value="'+ item.REAL_PAY_AMOUNT+ '">';
							content += 		'<input type="hidden" name="TOEFL_ID" value="'+ item.TOEFL_ID+ '">';
							content += 		'<a onclick="document.getElementById(\'refundToeflUpdateForm'+ item.PAY_TOEFL_SEQ  +  '\').submit();" class="refundBox btn_normal btn_small btn_mintL h5" id="refund_button">수정&#47;취소</a>';
							content += '</form>';
							content += '</div>';
							content += '<div class="c-table-num print-icon toefl-popup">';
							content += '<a href="#" class="btn_normal btn_default btn_small">';
							content += '<div class="img-icon print"></div>';
							content += '<h5 class="h5 margin-left5">출력</h5>';
							content += '</a>';
							content += '</div>';
						} else if (item.PAYMENT_STATUS == "F0003") {
							content += '<div class="c-table-num payment-complete" style="text-align: center; align-self: center;">완료</div>';
							content += '<div class="c-table-num d-flex btn_refund">';
							content += '<a class="refundBox btn_normal btn_small btn_mintL h5">환불완료</a>';
							content += '</div>';
							content += '<div class="c-table-num"></div>';
						} else {
							content += '<div class="c-table-num" style="text-align: center; align-self: center;"></div>';
							content += '<div class="c-table-num d-flex btn_refund">';
							content += '</div>';
							content += '<div class="c-table-num"></div>';
						}
						content += '</li>';
					});
					
					if(content=="") {
						content += '<li class="listAndwrap"><div class="class-list not"><p>결제정보가 없습니다.</p></div></li>';
					}
					$('.class-list-wrap.load-toefl-data').html(content);
				}
				
			})
			
			pagingFunc(index, search);
		}
		
		function pagingFunc(index, search) {
			var startPage = $("#startPage").val();
			var listUrl = (index == 0) ? "/lms/user/pageInfo" : "/lms/user/pageToeflInfo"; 

			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type : "get",
				url : listUrl,
				data : {
					"search" : search,
					"startPage" : startPage
				},
				success : function(data) {
					var totalPages = data.totalPages;
					var visiblePages = data.visiblePages;
					var startPage = Number(data.startPage) + 1;
					pagination(totalPages, visiblePages, startPage, index);
				},
				error : function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			})
		}
		
		function pagination(totalPages, visiblePages, startPage, index) {
			if(totalPages != 0 && totalPages != null){
				$('#pagination').twbsPagination({
			        totalPages: totalPages,
			        visiblePages: visiblePages,
			        startPage: startPage,
			        first : "",
				    prev : '<a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a>',
					next : '<a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a>',
					last : "",
			        initiateStartPageClick : false,
			        onPageClick: function (event, page) {
			        	$('#startPage').val(page);
			        	if(index == 0) {
			        		getPaymentList(index);	
			        	} else {
			        		getToeflPaymentList(index);
			        	}
			        }
				});
			}
			//pagination css 포맷에 맞게 설정하는 작업		
		 	$('.page-item').children().addClass('num');
			$('.page-item.active').children().addClass('active'); 
		}
		
		$(document).on('click','.modal-popup',function() {
			$(':hidden[name="m_course_id"]').val('');
			$(':hidden[name="m_cardinal_id"]').val('')
			$(':hidden[name="m_toefl_id"]').val('')
			var idx = $('.modal-popup').index($(this))
			var realPayment = $(':hidden[name="real_payment"]').eq(idx).val();
			var courseName = $(':hidden[name="course_name"]').eq(idx).val();
			var user_nm = $(':hidden[name="user_nm"]').eq(idx).val();
			var course_id = $(':hidden[name="course_id"]').eq(idx).val();
			var cardinal_id  = $(':hidden[name="cardinal_id"]').eq(idx).val(); 
				realPayment = numberWithCommas(realPayment);
				//무료과정 처리
				if(realPayment =="") {
					realPayment = "0";
				}
				//기존 영수증정보 조회, 없을시 생성
				$.ajax({
					type	: "post",
					url		: "/lms/user/select_receipt_num",
					data    : {
								'course_id' : course_id
								,'cardinal_id' : cardinal_id
							  },
					success	: function(data) {
						$('.receiptNum').html(data.RECEIPT_NUM);//영수증 일련번호
						$('.receiptDate').html(data.RECEIPT_DATE);//발행일
						//모달창의 hidden값에 넣기
						$(':hidden[name="m_course_id"]').val(course_id);
						$(':hidden[name="m_cardinal_id"]').val(cardinal_id);
						$(':hidden[name="receiptNum"]').val(data.RECEIPT_NUM);
						$(':hidden[name="receiptDate"]').val(data.RECEIPT_DATE);
						
					},
					error : function (request, status, error) {
							alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
				});
				
				
			
			//단가 표기
			var array = realPayment.toString().replace(",","").split('');
			array = array.reverse();
			var splitArray = new Array();
			for(i=0 ; i<array.length ; i++) {
				splitArray.push(array[i]);
			}
			for(i=7 ; i>=0 ; i--) {
				$("tr.priceIdx").children("td").eq(i).empty();
				$("tr.priceIdx").children("td").eq(i).html(splitArray[7-i]);
			}
			
			function numberWithCommas(realPayment) {
    			return realPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    		}
    		
    		$('.receiptItemList').html(courseName);//과정명
    		$('.receiptItemPrice').html(numberWithCommas(realPayment)+"원");//단가
			$('.user_nm').html(user_nm+'<span>&nbsp;귀하</span>');
			
		 	$('.modal').show();
		});
		
		$(document).on('click','.toefl-popup',function() {
			var idx = $('.toefl-popup').index($(this))
			$(':hidden[name="m_course_id"]').val('');
			$(':hidden[name="m_cardinal_id"]').val('')
			$(':hidden[name="m_toefl_id"]').val('')
			var realPayment = $(':hidden[name="REAL_PAY_AMOUNT"]').eq(idx).val();
			var courseName = $(':hidden[name="TOEFL_TITLE"]').eq(idx).val();
			var user_nm = $(':hidden[name="user_nm"]').eq(idx).val();
			var toefl_id = $(':hidden[name="TOEFL_ID"]').eq(idx).val();
			console.log(toefl_id)
				realPayment = numberWithCommas(realPayment);
				//무료과정 처리
				if(realPayment =="") {
					realPayment = "0";
				}
				 	//기존 영수증정보 조회, 없을시 생성
				$.ajax({
					type	: "post",
					url		: "/lms/user/select_receipt_num",
					data    : {
								"toefl_id" : toefl_id	
							  },
					success	: function(data) {
						$('.receiptNum').html(data.RECEIPT_NUM);//영수증 일련번호
						$('.receiptDate').html(data.RECEIPT_DATE);//발행일
						//모달창의 hidden값에 넣기
						$(':hidden[name="m_toefl_id"]').val(toefl_id);
						$(':hidden[name="receiptNum"]').val(data.RECEIPT_NUM);
						$(':hidden[name="receiptDate"]').val(data.RECEIPT_DATE);
						
					},
					error : function (request, status, error) {
							alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
				}); 
				

			
			//단가 표기
			var array = realPayment.toString().replace(",","").split('');
			array = array.reverse();
			var splitArray = new Array();
			for(i=0 ; i<array.length ; i++) {
				splitArray.push(array[i]);
			}
			for(i=7 ; i>=0 ; i--) {
				$("tr.priceIdx").children("td").eq(i).empty();
				$("tr.priceIdx").children("td").eq(i).html(splitArray[7-i]);
			}
			
			function numberWithCommas(realPayment) {
    			return realPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    		}
    		
    		$('.receiptItemList').html(courseName);//과정명
    		$('.receiptItemPrice').html(numberWithCommas(realPayment)+"원");//단가
			$('.user_nm').html(user_nm+'<span>&nbsp;귀하</span>'); 
			
		 	$('.modal').show();
		});
		 
		$('#refund_button').on('click', function(){
			if(confirm('환불 페이지로 이동하시겠습니까?')){
			} else {
			}
			
		});
		
		$('#searchBtn').on('click', function(){
			$('#pagination').twbsPagination('destroy');
			$('#startPage').val('1');
			
			var classTabMenu = $('#mainDisplay >.tabGroup >li');
			var j = 0;
			classTabMenu.each(function(index, item){
				if($(this).hasClass('active') == true) {
					j = index;
				}
			})
			
			switch(j) {
			case 0:
				getPaymentList(j);
				break;
			case 1:	
				getToeflPaymentList(j);
				break;
			}
		});
		
		getPaymentList(0);
	});
	
	function numberWithCommas(realPayment) {
	    return realPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

</script>

</head>
<body>
	<input type="hidden" id="serverMessage" value="${message}">
	<div class="skip-navigation">
		<!--웹접근성/content-->
		<p>
			<a class="goToMain" href="#main">콘텐츠 바로가기</a>
		</p>
	</div>

	<!-- header-include -->
	<%@include file="../sub_header.jsp"%>


	<div class="container subPage_container sub07 d-flex">
		<!-- sub07 나의강의실-include -->
		<%@include file="../user/menu/leftmenu07.jsp"%>

		<div class="subPage_content sub-content margin-left20 sub07 sub07-02" id="main">
			<div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">결제현황/환불</h3>
                </div>
            </div>
            <div class="section sub07-02">
				<div class="class-tabMenu" id="mainDisplay">
            		<ul class="tabGroup d-flex">
            			<li class="active">온라인 과정</li>
            			<li>모의토플</li>
            		</ul>
            		<!-- 과정명 검색 -->
            		<div class="searchWrapper">
                		<div class="class-searchWrap floatR">
                    		<form class="d-flex" id="searchForm">
                        		<div class="class-search-down d-flex">
                            		<input type="text" name="search" class="cusPHIn input" value="${search}" placeholder="과정명을 입력해주세요.">
                            		<!-- 검색버튼 -->
                            		<button type="button" class="button img-icon search" id="searchBtn">
                            		</button>
                        		</div>
                    		</form>
                		</div>
            		</div>
            		<div class="d-flex floatR">
						<div class="class-search-down d-flex">
							<c:if test="${startpage != '' && startpage != null}">
								<input type="hidden" id="startPage" name="startPage" value="${startPage}">
							</c:if>
							<c:if test="${startpage == '' || startpage == null}">
								<input type="hidden" id="startPage" name="startPage" value="1">
							</c:if>
						</div>
					</div>
            		<div class="subGroup">
            			<div class="tab-sub">
            				<div class="sub-section">
            					<div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-02">과정명(기수)</li>
										<li class="c-table-01">교육비</li>
										<li class="c-table-01">마일리지사용</li>
										<li class="c-table-01">결제금액</li>
										<li class="c-table-01">결제방식</li>
										<li class="c-table-num">결제상태</li>
										<li class="c-table-num">환불</li>
										<li class="c-table-num">영수증</li>
									</ul>
									<ul class="class-list-wrap load-data"></ul>
								</div>
            				</div>
            			</div>
            			<div class="tab-sub hideTab">
            				<div class="sub-section">
            					<div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-02">시험명</li>
										<li class="c-table-01">시험응시비</li>
										<li class="c-table-01">마일리지사용</li>
										<li class="c-table-01">결제금액</li>
										<li class="c-table-01">결제방식</li>
										<li class="c-table-num">결제상태</li>
										<li class="c-table-num">환불</li>
										<li class="c-table-num">영수증</li>
									</ul>
									<ul class="class-list-wrap load-toefl-data"></ul>
								</div>
            				</div>
            			</div>
            		</div>
            	</div>
				
				<!-- pagenation  -->
				<div class="page">
					<ul class="pagination d-flex justify_between" id="pagination">
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="modal" id="modal">
		<div class="modal-layer"></div>
		<div class="modal-content  printReceipt">
			<%@include file="../user/modal/modal-sub07-02-01.jsp"%>
		</div>
	</div>
	<!-- footer-include -->
	<%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
