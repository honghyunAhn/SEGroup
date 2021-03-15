<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>

<style type="text/css">
.valdation_message_container .error {color:red}
</style>

<!-- <script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
 -->
<%--kcp 결제 --%>
<script type="text/javascript">
/****************************************************************/
/* m_Completepayment  설명                                      */
/****************************************************************/
/* 인증완료시 재귀 함수                                         */
/* 해당 함수명은 절대 변경하면 안됩니다.                        */
/* 해당 함수의 위치는 payplus.js 보다먼저 선언되어여 합니다.    */
/* Web 방식의 경우 리턴 값이 form 으로 넘어옴                   */
/* EXE 방식의 경우 리턴 값이 json 으로 넘어옴                   */
/****************************************************************/
function m_Completepayment( FormOrJson, closeEvent )
{
	var frm = document.kcp_form;

	/********************************************************************/
	/* FormOrJson은 가맹점 임의 활용 금지                               */
	/* frm 값에 FormOrJson 값이 설정 됨 frm 값으로 활용 하셔야 됩니다.  */
	/* FormOrJson 값을 활용 하시려면 기술지원팀으로 문의바랍니다.       */
	/********************************************************************/
	GetField( frm, FormOrJson );


	if( frm.res_cd.value == "0000" )
	{
		copyKcpResponse();
		$('#applyForm').submit();
	}
	else
	{
		alert( "[" + frm.res_cd.value + "] " + frm.res_msg.value );

		closeEvent();
	}
}
</script>
<%-- <script type="text/javascript" src="${kcpConfig.g_conf_js_url }"></script> --%>
<script type="text/javascript">
/* 플러그인 설치(확인) */
//kcpTx_install(); // Plugin 결제창 호출 방식인 경우 적용하시기 바랍니다.

/* Payplus Plug-in 실행 */
function jsf__pay( form )
{
   try
   {
	   KCP_Pay_Execute( form );
   }
   catch (e)
   {
	console.log(e);
	   /* IE 에서 결제 정상종료시 throw로 스크립트 종료 */
   }
}

</script>
<%--kcp 결제 --%>
<script type="text/javascript">
$(function(){
	
	
	$("input[name=gopaymethod]").on("change",function(){
		
		$("#payMethod").val($(this).val());
		
	});
	
	
});


/*$(document).ready(function(){

	$("#region").minimalect({ placeholder: "지역 선택", class_container:"minict_wrapper body-select width20"});

	// NEIS번호 처리
	var neis_num = $('#neis_num').val();
	if(!isEmpty(neis_num)) {
		if(neis_num.length != 10) {
			$('#neis_num').val('');
		} else {
			$('#neis_local').val(neis_num.substr(0,3));
			$("input.neis_piece").each(function(i, obj){
				$(obj).val(neis_num.charAt(i+3));
			 });
		}
	}
	$("input.neis_piece").on({
	 click:function(){
		 $(this).val("");
	 },keyup:function(){
		 $(this).next().focus();
		 setNeisNum();
	 }
	});
	$("select.neis_piece").change(function() {
		if ($(this).val() == 'Z99') {
			$("input.neis_piece").each(function(i, obj){
				$(obj).val('9');
		 	});
		}
		setNeisNum();
	});

	$("#neis_numChk").click(function(){
		 if($(this).is(":checked")){
			 $("#neis_num").val("");
			 $(".neis_piece").attr("readonly", true).css("background-color","#ccc").val("");
		 }else{
			 $(".neis_piece").attr("readonly", false).css("background-color","");
		 }
	});

	// neis 변경시 중복체크여부 N
	$('.neis_piece').change(function() {
		$('#checkDuplNeisYn').val('N');
	});

	$('#btnCheckDuplNeis').click(function() {	// NEIS번호 중복체크
		if($("#neis_numChk").is(":checked")) return;

		if(isEmpty($('#neis_local').val())) {
			alert('지역구분을 먼저 선택하여 주십시오.');
			$('#neis_local').focus();
			return;
		};

		var neis_num = $('#neis_local').val();
		$('input.neis_piece').each(function(idx, obj) {
			neis_num += $(obj).val().toUpperCase();
		});

		if (!isValidNeis(neis_num)) {
			alert('유효하지 않은  NEIS 개인 번호입니다.');
			return;
		}

		$('#neis_num').val(neis_num);

		if(!checkDuplNeis(neis_num)) {
			$('#checkDuplNeisYn').val('N');
			alert('이미 등록된 NEIS 개인 번호입니다.')
		} else {
			$('#checkDuplNeisYn').val('Y');
			alert('사용 가능한 NEIS 개인 번호입니다.');
		}

		$('#checkDuplNeisYn').valid();	// validate one field
	});
	$("#btnGenNeis").click(function(event) {	
		*/
		// 임시 NEIS번호 발급
		/*

		if($("#neis_numChk").is(":checked")) return;

		$("#neis_num").val("");
		var landom = generateRandom(1,10000000000);
		var lanarry = landom.split("");

		if(lanarry.length == 9){
			landom = landom+"0";
			lanarry.push("0");
		}
		$(".neis_piece").each(function(idx,obj){
			$(obj).val(lanarry[idx]);
		});
		$("#neis_num").val(landom);
		
	});*/

	// 연수지명번호 없음
	/*
	$("#des_numChk").click(function(){
		 if($(this).is(":checked")){
			 $("#des_num").val("");
			 $(".des_piece").attr("readonly", true).css("background-color","#ccc").val("");
		 }else{
			 $(".des_piece").attr("readonly", false).css("background-color","");
		 }
	});
	$('#btnCheckDuplDesNum').click(function() {	// 지명연수번호 중복체크
		if($("#des_numChk").is(":checked")) return;

		var des_num = '';
		$('.des_piece').each(function(idx, obj) {
			des_num += (des_num != ''?'-':'') + $(obj).val();
		});

		if (isEmpty(des_num)) {
			alert('유효하지 않은 지명 연수 번호입니다.');
			return;
		}

		$('#des_num').val(des_num);

		if(!checkDuplDesNum(des_num)) {
			$('#checkDuplDesNumYn').val('N');
			alert('동일한 연수 지명 번호가 존재합니다.\n관리자에게 직접 문의 부탁드립니다.')
		} else {
			$('#checkDuplDesNumYn').val('Y');
			alert('사용 가능한 지명 연수 번호입니다.');
		}

		$('#checkDuplDesNumYn').valid();	// validate one field
	});

	// 연수 기간 변경
	$(".notation").click(function(event){
		popCourseCardinalSelect($('#applyForm input[name="course_id"]').val());
	});

	// 연수지명번호 처리
	$(".des_piece").on({
		 click:function(){
			 $(this).val("");
		 },keyup:function(){
			 var des_num = "";
			 $("#des_num").val("");
			 $(".des_piece").each(function(idx,obj){
				 des_num += (des_num != ''?'-':'') + $(obj).val();
			 });
			 $("#des_num").val(des_num);
		 }
	});

	// 교재선택 처리
	$('input[name="chkBook"]').click(function () {
		var yn = $(this).val();
		if ($(this).val() == 'Y') {	// 교재(주/부) 선택
			$('#main_tb_id').val($('#bookInfo').data('maintbid'));
			$('#main_price').val(Number($('#bookInfo').data('mainprice')));
		} else {
			$('#main_tb_id').val('');
			$('#main_price').val(0);
		}

		var book_price = Number($('#main_price').val());
		$('#book_price_v').text(addComma(book_price));

		refreshAmount();	// 금액갱신
	});

	// 쿠폰함 팝업
	$('#couponBtn').click(function() {
		var layerId  = 'layerMyCoupon';
		if($('#'+layerId).length < 1) {
			var course_id = $('#applyForm input[name="course_id"]').val();
			$.ajax({
				type: "POST",
				url: "/common/layer/learn/mycoupon",
				dataType: "text",
				data: {'course_id': course_id},
				success: function(txt) {
					$(document.body).append(txt);
					popupOpen(layerId);
				}
			});
		} else {
			popupOpen(layerId);
		}
	})

	// 포인트 처리
	$("#dis_point").change(function(){
		$("#chkUsePointAll").prop('checked', false);

		if (isNaN($(this).val())) {
			$(this).val(0);
		}
		var availPoint = Number($('#myPoint').data('avail')); // 가용포인트
		var usePoint = Number($(this).val());
		if (usePoint < 0 || availPoint == 0) {
			$(this).val(0);
			refreshAmount();
			return;
		}

		if (usePoint > availPoint) {
			alert('가용한 포인트가 부족합니다.')
			$(this).val(0);
			refreshAmount();
			return;
		}

		var useMin = Number($('#pointPolicy').data('min'));
		var useUnit = Number($('#pointPolicy').data('unit'));
		var useYn = $('#pointPolicy').data('useyn');

		if (useYn == 'Y') {
			if(usePoint%(useUnit==0?1:useUnit) > 0) {
				alert(useUnit+' 포인트 단위로 사용할 수 있습니다.');
				$(this).val(0);
				refreshAmount();
				return;
			}
		}

		refreshAmount();
	});

	$("#chkUsePointAll").click(function(){
		if($(this).is(':checked')) {
			var usePoint = getUsablePointMax();
			$('#dis_point').val(usePoint).trigger('change');
		}
	});

	// 결제 및 신청등록
	$("#applyBtn").click(function(event){
		// 중복 등록 방지
		$("#applyBtn").prop('disbled',true);
		setTimeout(500, function() {
			$("#applyBtn").prop('disbled',false);
		});

		if (!validateForm()) {
			alert('입력항목을 확인하여 주십시오.');
			return;
		}

		if (!confirm('수강 신청하시겠습니까?')) return;

		var $applyForm = $('#applyForm');
		var payment_type = $applyForm.find('input[name="payment_type"]:checked').val() || '';

		if (payment_type == "1") {
			$('#applyForm').submit();
		} else {	// kcp결제진행
			copyToKcp();

			jsf__pay(document.kcp_form);
		}

	});

	// validator 연결
	$.validator.addMethod("checkNeis",function(value, element) {
		return this.optional(element) || isValidNeis(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkDuplNeis",function(value, element) {
		return this.optional(element) || $('#neis_num').val() == '' || $('#checkDuplNeisYn').val() === 'Y';
	}, "NEIS 개인 번호 중복확인을 하여 주십시오.");
	$.validator.addMethod("checkDesNum",function(value, element) {
		var des_num;
		var empty_cnt = 0;
		$('.des_piece').each(function(idx, obj) {
			if (isEmpty($(obj).val())) ++empty_cnt;
			des_num += $(obj).val();
		});
		return this.optional(element) || isEmpty(des_num) || (empty_cnt == 0);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkDuplDesNum",function(value, element) {
		return this.optional(element) || $('#des_num').val() == '' || $('#checkDuplDesNumYn').val() === 'Y';
	}, "지명 연수 번호 중복확인을 하여 주십시오.");
	$.validator.addMethod("chkPaymentType",function(value, element) {
		var real_payment = Number($('#real_payment').val());
		var payment_type = $('input[name="payment_type"]:checked').val();
		return this.optional(element) || (real_payment > 0 || real_payment == 0 && payment_type == '1');
	}, "결제 금액이 0원은 무통장입금 선택만 가능합니다.");
	validator  = $("#applyForm").validate({
		ignore: ".ignore",
		errorPlacement: function(error, element) {  // 입력 에러메시지 출력 위치 설정
			var holder = $(element).parent().find(".alert" );
			if (holder.length < 1) {
				holder = $("<p>").addClass('alert');
				var $p = $(element).closest('dd');
				if ($p.length > 0) {
					$p.append(holder);
				} else {
					$p = $(element).closest('.valdation_message_container');
					$p.append(holder);
				}
			}
			if(holder.length > 0) {
				$(holder).append(error);
			}
		},
		rules: {	// 입력체크 룰
			neis_num: {"checkNeis":true},
			checkDuplNeisYn: {"checkDuplNeis":true},
			des_num: {"checkDesNum":true},
			checkDuplDesNumYn: {"checkDuplDesNum":true},
			chkBook: {"required":true},
			payment_type: {"required":true,"chkPaymentType":true},
			learnPlanViewYn: {"required":true},
			chkLearnPlan: {"required":true}
		},
		messages: {
			learnPlanViewYn: '연수 계획서를 확인하여 주십시오.',
			chkLearnPlan: '연수 계획서 확인체크하여 주십시오.'
		}
	});

});
*/
function setNeisNum() {
	var neis_num = $('#neis_local').val();
	 $("#neis_num").val("");
	 $("input.neis_piece").each(function(idx,obj){
		 neis_num += $(obj).val();
	 });

	 $("#neis_num").val(neis_num);
}

// 결제에 필요한 데이터를 kcp폼으로 복사
function copyToKcp() {
	// 결제에 필요한 값 copy
	var $applyForm = $('#applyForm');
	var $kcpForm = $('#kcp_form');
	var payment_type = $applyForm.find('input[name="payment_type"]:checked').val() || '';

	var pay_method = '';
	switch(payment_type) {
	case '2': pay_method = '010000000000'; break;
	case '3': pay_method = '001000000000'; break;
	case '4': pay_method = '100000000000'; break;
	default:
		alert('이용할 수 없는 결제 수단입니다.');
	}

	var ordr_idxx = $applyForm.find('input[name="order_idx"]').val();
	var good_mny = $applyForm.find('input[name="real_payment"]').val();
	var good_name = $applyForm.find('input[name="good_name"]').val();
	var buyr_name = $applyForm.find('input[name="user_name"]').val();
	var buyr_mail = $applyForm.find('input[name="email"]').val();
	var buyr_tel1 = '';
	var buyr_tel2 = $applyForm.find('input[name="phone"]').val();

	$kcpForm.find('input[name="pay_method"]').val(pay_method);
	$kcpForm.find('input[name="ordr_idxx"]').val(ordr_idxx);
	$kcpForm.find('input[name="good_mny"]').val(good_mny);
	$kcpForm.find('input[name="good_name"]').val(good_name);
	$kcpForm.find('input[name="buyr_name"]').val(buyr_name);
	$kcpForm.find('input[name="buyr_mail"]').val(buyr_mail);
	$kcpForm.find('input[name="buyr_tel1"]').val(buyr_tel1);
	$kcpForm.find('input[name="buyr_tel2"]').val(buyr_tel2);
}

// kcp응답을 신청폼으로 복사
function copyKcpResponse() {
	$kcpForm = $('#kcp_form');
	$('#applyForm .pgresponse').each(function(idx, obj) {
		$(this).val($kcpForm.find('input[name="'+$(this).attr('name')+'"]').val() || '');
	});
}

// 쿠폰선택
function onSelectCoupon(data) {
	$('#use_coupon').data('cond', data.cond);
	$('#use_coupon').data('coupon', data.coupon);
	$('#use_coupon').data('coupontype', data.coupon_type);
	$('#coupon_num').val(data.coupon_num);

	$('#use_coupon').text(data.name + ' ('+ addComma(data.cond) + ' 원 이상 ' + data.coupon + (data.coupon_type=='2'?'%':'원') + ' 할인)');

	refreshAmount();
}

// NEIS 중복체크
function checkDuplNeis(neis_num) {
	var valid = false;
	$.ajax({
		type: "post",
		url: "<c:url value='/member/ajaxUserCheckDuplNeis' />",
		data: {"neis_num": neis_num},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = (result.DUPL_YN != 'Y');
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
}

// 연수지명번호 중복체크
function checkDuplDesNum(des_num) {
	var valid = false;
	$.ajax({
		type: "post",
		url: "<c:url value='/learn/apply/ajaxUserCheckDuplDesNum' />",
		data: {"des_num": des_num},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = (result.DUPL_YN != 'Y');
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
}

// 연수 계획서 팝업
function popLearnPlan() {
	var course_id = $('#applyForm input[name="course_id"]').val();
	var cardinal_id = $('#applyForm input[name="cardinal_id"]').val();

	var layerId  = 'layerLearnPlan';
	if($('#'+layerId).length < 1) {
		$.ajax({
			type: "POST",
			url: "/learn/apply/layer/learnplan",
			dataType: "text",
			data: {'course_id': course_id, 'cardinal_id': cardinal_id},
			success: function(txt) {
				$(document.body).append(txt);
				popupOpen(layerId);
				$('#learnPlanViewYn').val('Y');
				$('#chkLearnPlan').prop('disabled', false).prop('checked', true);
			}
		});
	} else {
		popupOpen(layerId);
	}
}

// 쿠폰적용 취소
function invalidateCoupon() {
	$('#use_coupon').data('cond', 0);
	$('#use_coupon').data('coupon', 0);
	$('#use_coupon').data('coupontype', '');
	$('#coupon_num').val('');
}

// 결제 금액재갱신
function refreshAmount() {
	// 쿠폰,포인트는 수강료에 대해서 적용됨
	var price = Number($('#price').val());	// 수강료
	var book_price = Number($('#main_price').val());	// 주교재금액
	var use_point = Number($('#dis_point').val());	// 사용포인트
	var real_payment = price;	// 실결제 금액
	var discount_price = price;	// 할인적용된수강료

	// 할인율 적용(단체할인)
	var discount = Number($('#discount').val());
	if (discount > 0) {
		real_payment = discount_price = Math.ceil(price*(1-discount/100));

		$('#dis_group').val(price-real_payment);	// 단체할인금액
		$('#discount_info_v').text('('+discount+'% 할인) = '+addComma(discount_price));
	}

	// 쿠폰적용 (수강료에만 적용되며 다른 할인과는 동시에 사용할 수 없다.)
	if (discount > 0 && !isEmpty($('#coupon_num').val())) {	// 쿠폰적용 유효성 재체크
		alert('단체할인이 적용된 연수는 쿠폰을 적용할 수 없습니다. 선택 쿠폰을 취소합니다.');
		invalidateCoupon();	// 쿠폰취소
	}
	if (!isEmpty($('#coupon_num').val())) {
		var cond = Number($('#use_coupon').data('cond'));	// 적용조건(금액)
		var coupon = Number($('#use_coupon').data('coupon'));	// 적용값
		var type = $('#use_coupon').data('coupontype');	// 적용구분[1:금액,2:%]

		// 쿠폰적용조건에 맞을 때 적용
		if(price >= cond) {
			if (type=='2') {	// %할인
				real_payment = discount_price = Math.ceil(price*(1-coupon/100));
			} else {
				real_payment = discount_price = price - coupon;
			}

			if(real_payment < 0) real_payment = discount_price = 0;

			$('#dis_coupon').val(price-real_payment);	// 쿠폰할인금액
			$('#discount_info_v').text('('+ coupon + (type=='2'?'%':'원') + ' 할인) = ' + addComma(discount_price));
		}
	}

	real_payment -= use_point;	// 포인트 적용(포인트 사용은 수강료에 대해서만 적용)
	if (real_payment < 0) {
		alert('수강료 할인금액을 초과하여 포인트를 사용할 수는 없습니다.');
		$('#dis_point').val(0).trigger('change');
		return;
	}

	real_payment += book_price;	// 책값 적용

	if (real_payment == 0) {	// 결제 금액이 0일 경우 무통장입금만 허용
		$('input[name="payment_type"][value="1"]').prop('checked', true);
	}

	$('#payment').val(price + book_price);
	$('#real_payment').val(real_payment);
	$('#real_payment_v').text(addComma(real_payment));
}

// 사용가능한 포인트 최대값(할인된 수강료 및 포인트 정책 적용)
function getUsablePointMax() {
	var availPoint = Number($('#myPoint').data('avail')); // 가용포인트
	if (availPoint == 0) return 0;

	// 1. 할인수강료 계산 (쿠폰,포인트는 수강료에 대해서 적용됨)
	var price = Number($('#price').val());	// 수강료
	var discount_price = price;	// 할인적용된수강료

	// 할인율 적용(단체할인)
	var discount = Number($('#discount').val());
	if (discount > 0) {
		real_payment = discount_price = Math.ceil(price*(1-discount/100));
	} else {
		// 쿠폰할인 적용
		if (!isEmpty($('#coupon_num').val())) {
			var cond = Number($('#use_coupon').data('cond'));	// 적용조건(금액)
			var coupon = Number($('#use_coupon').data('coupon'));	// 적용값
			var type = $('#use_coupon').data('coupontype');	// 적용구분[1:금액,2:%]

			// 쿠폰적용조건에 맞을 때 적용
			if(price >= cond) {
				if (type=='2') {	// %할인
					discount_price = Math.ceil(price*(1-coupon/100));
				} else {
					discount_price = price - coupon;
				}

				if(discount_price < 0) discount_price = 0;
			}
		}
	}

	var usableMax = discount_price > availPoint ? availPoint : discount_price;

	// 2. 사용할 수 있는 포인트 MAX 계산

	var useMin = Number($('#pointPolicy').data('min'));
	var useUnit = Number($('#pointPolicy').data('unit'));
	var useYn = $('#pointPolicy').data('useyn');

	if (useYn == 'Y') {	// 포인트정책 적용
		usableMax = usableMax - usableMax%useUnit;	// 사용단위 적용
		if (usableMax < useMin) usableMax = 0;
	}

	return usableMax;
}

// 입력값 체크
function validateForm() {
	return $('#applyForm').valid();
}
</script>
<%-- 	<!-- 1.3. 본문 -->
			<div class="body">
				<div class="sub-header">
					<p class="sub-nav">
						<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
						<a href="#">연수 신청</a>
						<a class="nth-last" href="${contextPath}">수강 신청</a>
					</p>
					<h2 class="sub-title">수강 신청 </h2>
				</div>
				<div class="sub-body">
					<form id="applyForm" name="applyForm" method="post" action="<c:url value="/learn/apply/doApply"/>">
						<input type="hidden" name="group_id" value="${param.group_id}">
						<input type="hidden" name="course_id" value="${detail.ID}">
						<input type="hidden" name="cardinal_id" value="${detail.CARDINAL_ID}">
						<input type="hidden" name="order_idx" value="${order_idx }"/>
						<input type="hidden" name="good_name" value="<util:strcut len="30" value="${detail.NAME }"/>"/>
						<ul class="group">
							<!--  <li>할인 쿠폰은 지정된 상품을 결제할 때 1회만 사용 가능하며, 사용한 쿠폰은 환불/복원되지 않습니다.</li>
							<li>교재를 구매할 때는 할인 쿠폰을 사용할 수 없습니다.</li>-->
							<li>연수를 연기/취소할 때에는 개강일로부터 7일 이내에 1회만 가능합니다.(진도 20% 미만 진행 시에만 가능)</li>
							<li>개강일 이후에 연수 수강을 신청할 때에도 연기/취소는 개강일 기준 7일 이내에만 가능합니다.</li>
						</ul><!--//.group - 주의사항 TOP -->
						
						<div class="group">
							<h3>신청인구분</h3>
							<dl>
								<dt>연수신청구분</dt>
								<dd>
									<label><input type="radio" name="group">개인</label>
									<label><input type="radio" name="group">단체구성원</label>
									<label><input type="radio" name="group">단체대표</label>
									<a class="btn line primary" href="#">단체신청안내</a>
								</dd>
							</dl>
						</div><!--//.group - 신청인 구분 -->
						
						 <%-- 
						 <%-- 
						<div class="group">
							<h3>NEIS 개인 번호 확인</h3>
							<dl>
								<dt>NEIS 개인 번호</dt>
								<dd class="NEIS">
									<select id="neis_local" class="neis_piece">
									<option value="">지역 선택</option>
									<c:forEach var="item" items="${localEduofficeList}">
									<option value="${item.CODE}">${item.NAME}(${item.CODE })</option>
									</c:forEach>
									</select>
									<c:forEach begin="4" end="10" varStatus="varStatus">
									<input type="text" class="neis_piece" maxlength="1">
									</c:forEach>
									
									 
									 
									 
									 
									<input type="text" class="neis_piece" name="neis_num0" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num1" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num2" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num3" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num4" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num5" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num6" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num7" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num8" maxlength="1">
									<input type="text" class="neis_piece" name="neis_num9" maxlength="1">
									
									 
									 
									 
									 
									<input type="hidden" id="neis_num" name="neis_num" value="${neis_num }">
									<input type="hidden" id="checkDuplNeisYn" name="checkDuplNeisYn" value="N"/>
									<a class="btn primary" href="#none" id="btnCheckDuplNeis">중복 확인</a>
									<a class="btn primary" href="<c:url value="/mypage/private/privateedit"/>" id="btnGenNeis">번호 수정</a>
									<p>
										<input type="checkbox" id="neis_numChk" name="neis_numChk"><label><strong>NEIS 개인 번호가 없습니다.</strong></label><span class="nth-1st">(사립 유치원 교사, 강사, 일반인 등 NEIS 개인 번호가 없는 경우 체크합니다.)</span><br>
										<strong>NEIS 개인 번호</strong><span class="nth-1st">는 <strong>지역(3자리) + 일련번호(7자리)</strong>로 구성된 개인별 고유 번호입니다.</span>
									</p>
									<a class="btn primary" href="javascript:popupOpen('layerNeisInfo')">NEIS 개인 정보 확인 방법 자세히 보기</a>
								</dd>
							</dl>
						</div><!--//.group - NEIS 개인 번호 확인 -->
						--%>
						<div class="group">
						<%--
							<h3>연수 기간 및 연수 지명 번호 확인</h3>
							<dl>
								<dt>연수 과정명</dt>
								<dd>${detail.NAME}</dd>
								<dt>연수 기간</dt>
								<dd>
									<input type="hidden" name="cardinal_id" value="${detail.CARDINAL_ID}">
									${detail.LEARN_START_DATE}. ~ ${detail.LEARN_END_DATE}.
									<!--<c:if test="${empty param.group_id }"><a class="btn primary notation" href="#none">연수 기간 변경</a></c:if>-->
								</dd>
								<dt>연수 지명 번호</dt>
								<dd>
									<input type="hidden" name="des_num" id="des_num" >
									<input type="text" class="w4em nth-1st des_piece"> -
									<input type="text" class="w8em des_piece"> -
									<input type="text" class="w4em des_piece" maxlength="4"> -
									<input type="text" class="w5em des_piece" maxlength="5">
									<input type="hidden" id="checkDuplDesNumYn" name="checkDuplDesNumYn" value="N"/>
									<a href="javascript:popupOpen('layerTrainingNumber')" class="btn primary">연수 지명 번호 안내</a>
									<a class="btn primary" href="#none" id="btnCheckDuplDesNum">중복 확인</a><br/>
									<p>
										<input type="checkbox" id="des_numChk" name="des_numChk"><label><strong>연수 지명 번호가 없습니다.</strong></label><span class="nth-1st">(사립 유치원, 강사, 일반인 등 연수지명 번호가 없는 경우)</span><br>
										<span>예) 서울 - 시금초 - 14(년도) - 1234</span>
									</p>
								</dd>
							</dl>
						</div><!--//.group - 연수 기간 및 연수 지명 번호 확인 -->
						--%>
						<div class="group">
							<h3>개인 정보 확인</h3>
							<ul class="section">
								<li>연수를 이수하신 후에 교육청의 정확한 보고를 위하여 회원의 개인 정보를 다시 한번 확인해 주시기 바랍니다.</li>
								<li>회원의 현재 개인 정보와 입력된 정보가 다를 경우 교육청 이수 보고가 늦어질 수 있습니다.</li>
							</ul>
							<dl>
								<dt>성명</dt>
								<dd class="halfW">
									<input type="hidden" name="user_name" value="${user.name}"/>
									<strong>${user.name}</strong>
								</dd>
								<dt class="border">전자 우편</dt>
								<dd class="halfW"><input type="hidden" name="email" value="${user.email}"/>${user.email}</dd>
								<dt>학교명</dt>
								<dd class="halfW"><input type="hidden" name="school_name" value="${user.school_name}"/>${user.school_name}</dd>
								<dt class="border">휴대 전화</dt>
								<dd class="halfW"><input type="hidden" name="phone" value="${user.phone}"/>${user.phone}</dd>
								<dt>교재/교구 선택
									<input type="hidden" id="main_tb_id" name="main_tb_id"/>
									<input type="hidden" id="main_price" name="main_price" value="0"/>
								</dt>
								<c:if test="${empty detail.MAIN_TB_NAME}">
								<dd>교재 없음<input type="hidden" name="chkBook" value="0"/></dd>
								</c:if>
								<c:if test="${not empty detail.MAIN_TB_NAME}">
								<dd id="bookInfo" data-maintbid="${detail.MAIN_TB_ID }" data-subtbid="${detail.SUB_TB_ID }" data-mainprice="${detail.MAIN_PRICE }" data-subprice="${detail.SUB_PRICE }">
									<span class="nth-1st">
										<label><input type="radio" name="chkBook" value="Y">선택(<fmt:formatNumber value="${detail.MAIN_PRICE}"/>원)</label>
										<label><input type="radio" name="chkBook" value="N">선택안함</label>
									</span>
								</dd>
								</c:if>
								<dt>자택 주소</dt>
								<dd class="address">
									 <span>${userAddress.ADDR1 }</span>
									 <span>${userAddress.ADDR2 }</span>	
									 <span>(&nbsp;우편번호 : ${userAddress.POST_CODE }&nbsp;)</span><br>						 
								</dd>
							</dl>
							<p class="section-body-footer alignR">
								<a class="btn line primary" href="<c:url value="/mypage/private/privateedit"/>">개인 정보 수정</a>
							</p>
						</div><!--//.group - 개인 정보 확인 -->
						<div class="group">
							<h3>포인트 사용</h3>
							<ul class="section">						 
								<li>포인트는 수강료를 우선 적용합니다.
								<c:if test="${pointPolicy.USE_LECTURE_USE == 'Y' }">(<fmt:formatNumber value="${pointPolicy.USE_LECTURE_POINT }"/> 이상부터 <fmt:formatNumber value="${pointPolicy.USE_LECTURE_UNIT }"/> 단위로 사용할 수 있습니다.)</c:if>
								</li>
							</ul>
							<%--현재버전에서는 할인 없음 --%>
							<input type="hidden" id="discount" name="discount" value="0"/>
							<input type="hidden" id="dis_group" name="dis_group" value="0"/>
							<dl>
								<%--
								<dt>할인</dt>
								<dd>
									<span><strong><input type="hidden" id="discount" name="discount" value="0"/>0%</strong> 할인</span>
									<input type="hidden" id="dis_group" name="dis_group" value="0"/>
								</dd>
								
								<dt>쿠폰 사용</dt>
								<dd>
									<span><strong>${availCouponCount }</strong>장 사용 가능</span>
									<a class="btn primary" href="#none" id="couponBtn">쿠폰 조회/적용</a>
									<div id="use_coupon" data-cond="" data-coupon="" data-coupontype=""></div>
									<input type="hidden" id="coupon_num" name="coupon_num"/>
									<input type="hidden" id="dis_coupon" name="dis_coupon" value="0"/>
								</dd>
								 --%>
								<dt>포인트 사용</dt>
								<dd>
									<c:set var="availPoint" value="${totalPoint }"/>
									<c:if test="${pointPolicy.USE_LECTURE_USE == 'Y' }">
										<c:if test="${totalPoint < pointPolicy.USE_LECTURE_POINT }"><c:set var="availPoint" value="0"/></c:if>
									</c:if>
									<input type="hidden" id="pointPolicy" data-min="${pointPolicy.USE_LECTURE_POINT }" data-unit="${pointPolicy.USE_LECTURE_UNIT }" data-useyn="${pointPolicy.USE_LECTURE_USE }"/>
									<input type="hidden" id="myPoint" data-total="${totalPoint }" data-avail="${availPoint }"/>
									<input type="text" class="nth-1st width20" name="dis_point" id="dis_point" value="0" <c:if test="${availPoint < 1 }">readonly="readyonly"</c:if>>
									<input type="checkbox" name="chkUsePointAll" id="chkUsePointAll" <c:if test="${availPoint < 1 }">disabled</c:if>>
									<label>모두 사용</label>
									<span>보유 포인트 : <fmt:formatNumber value="${totalPoint}"/>포인트</span>
									<span>사용 가능 포인트: <fmt:formatNumber value="${availPoint}"/>포인트</span>
								</dd>
								<dt>연수비</dt>
								<dd class="width30">
									<span id="price_v"><fmt:formatNumber value="${detail.PRICE}"/></span>원<span id="discount_info_v" style="margin:0px"><!-- (0% 할인)) = 0원) --></span>
									<input type="hidden" id="price" id="price" value="${detail.PRICE}"/>
									<input type="hidden" name="payment" id="payment" value="${detail.PRICE}"/>
								</dd>
								<dt class="border">교재비</dt>
								<dd class="width30"><span id="book_price_v">0</span>원</dd>
								<dt>최종 결제 금액</dt>
								<dd><span class="nth-last"><strong>
									<input type="hidden" name="real_payment" id="real_payment" value="${detail.PRICE}"/>
									<em id="real_payment_v"><fmt:formatNumber value="${detail.PRICE}"/></em>원</strong></span>
								</dd>
							</dl>
						</div><!--//.group - 쿠폰 및 포인트 -->
						<div class="group">
							<h3>결제 수단 선택</h3>
							<dl>
								<dt>결제 수단</dt>
								<dd class="valdation_message_container">
								<label><input type="radio" name="payment_type" value="1"> 무통장 입금</label>
								<c:if test="${not currentDevice.mobile }">
								<label><input type="radio" name="payment_type" value="2"> 계좌 이체</label>
								<label><input type="radio" name="payment_type" value="3"> 가상 계좌</label>
								<label><input type="radio" name="payment_type" value="4"> 신용 카드</label>
								</c:if>
								</dd>
							</dl>
						</div><!--//.group - 결제 수단 선택 -->
						<div class="btn_wrap">
							<ul class="notice-list">
								<li>연수 연기는 연수 기간 내에 동일 과정으로 1회만 가능합니다.</li>
								<li>연수 변경은 불가능합니다.</li>
								<li>연수 취소 및 환불은 취소/환불 안내를 참조하시기 바랍니다.</li>
							</ul>
							<a class="btn line" href="javascript:popupOpen('layerRefundInfo')">취소/환불 안내</a>
						</div><!--//.group - 주의사항 BOTTOM -->

						<div class="learn_plan valdation_message_container">
							<input type="hidden" id="learnPlanViewYn" name="learnPlanViewYn"/>
							<span>교육부의 <strong>"2014년 원격교육연수원 운영 메뉴"</strong>에 의거 <strong>연수 계획서를 확인하셔야</strong> 수강 신청이 가능합니다.</span>
							<label class="floatR"><input type="checkbox" id="chkLearnPlan" name="chkLearnPlan" disabled><a href="javascript:popLearnPlan()"><strong class="primary">연수 계획서</strong></a> 확인하기</label>
						</div>


						kcp 결제정보
						<input type="hidden" class="pgresponse" name="req_tx" />
						<input type="hidden" class="pgresponse" name="pay_method" />
						<input type="hidden" class="pgresponse" name="ordr_idxx" />
						<input type="hidden" class="pgresponse" name="good_mny" />
						<input type="hidden" class="pgresponse" name="buyr_name" />
						<input type="hidden" class="pgresponse" name="buyr_mail" />
						<input type="hidden" class="pgresponse" name="buyr_tel1" />
						<input type="hidden" class="pgresponse" name="buyr_tel2" />
						<input type="hidden" class="pgresponse" name="res_cd"/>
						<input type="hidden" class="pgresponse" name="res_msg"/>
						<input type="hidden" class="pgresponse" name="enc_info"/>
						<input type="hidden" class="pgresponse" name="enc_data"/>
						<input type="hidden" class="pgresponse" name="ret_pay_method"/>
						<input type="hidden" class="pgresponse" name="tran_cd"/>
						<input type="hidden" class="pgresponse" name="use_pay_method"/>
						<input type="hidden" class="pgresponse" name="cash_yn"/>
						<input type="hidden" class="pgresponse" name="cash_tr_code"/>
						<input type="hidden" class="pgresponse" name="cash_id_info"/>
						kcp 결제정보
					</form>
					<div class="list-bottom  alignR clearB">
						<a href="#" class="btn danger">이전으로(취소)</a>
						<a href="#" class="btn primary" id="applyBtn">결제</a>
					</div>
				</div><!--//.sub-body-->
				<!--본문 내용 출력 공간-->
			</div><!--//.body-->
	<!--// 1.3. 본문 -->

<%-- <form id="kcp_form" name="kcp_form" method="post">
주문정보
<input type="hidden" name="pay_method" />
<input type="hidden" name="ordr_idxx" />
<input type="hidden" name="good_name" />
<input type="hidden" name="good_mny" />
<input type="hidden" name="buyr_name" />
<input type="hidden" name="buyr_mail" />
<input type="hidden" name="buyr_tel1" />
<input type="hidden" name="buyr_tel2" />

가맹점필수정보1 config
<input type="hidden" name="req_tx"          value="pay" />
<input type="hidden" name="site_cd"         value="${kcpConfig.g_conf_site_cd }" />
<input type="hidden" name="site_name"       value="${kcpConfig.g_conf_site_name }" />
<input type="hidden" name="module_type"     value="${kcpConfig.module_type }" />

가맹점필수정보2 
<input type="hidden" name="quotaopt"        value="0"/>
<input type="hidden" name="currency"        value="WON"/>

response
<input type="hidden" name="res_cd"          value=""/>
<input type="hidden" name="res_msg"         value=""/>
<input type="hidden" name="enc_info"        value=""/>
<input type="hidden" name="enc_data"        value=""/>
<input type="hidden" name="ret_pay_method"  value=""/>
<input type="hidden" name="tran_cd"         value=""/>
<input type="hidden" name="use_pay_method"  value=""/>
<input type="hidden" name="ordr_chk"        value=""/>
<input type="hidden" name="cash_yn"         value=""/>
<input type="hidden" name="cash_tr_code"    value=""/>
<input type="hidden" name="cash_id_info"    value=""/>
<input type="hidden" name="good_expr" 		value="0">
</form> 
--%>

 
<script language="javascript" type="text/javascript"
	src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
 
 
<form id="SendPayForm_id" name="" method="POST" >		
				<table border="1" class="info_tbl mb20">
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
					<tbody>
					<tr style="display:block;">
							<th class="td01">지불방법</th>
							<td class="td02"> 
					<!-- 			<select name="gopaymethod">
									<option value="">[ 결제방법 선택 ]
									</option><option value="Card">신용카드 결제
									</option><option value="DirectBank">실시간 은행계좌이체 
									</option><option value="VBank">무통장 입금 
									</option><option value="HPP">핸드폰 결제
									</option><option value="PhoneBill">받는전화결제 
									</option><option value="OCBPoint">OK 캐쉬백포인트 결제
									</option><option value="Culture">문화상품권 결제
									</option><option value="TeenCash">틴캐시 결제
									</option><option value="DGCL">스마트문화 상품권 결제
									</option><option value="BCSH">도서문화 상품권 결제	
									</option><option value="YPAY">옐로페이 결제
									</option><option value="KPAY">케이페이 결제
									</option><option value="EasyPay">간편 결제
									</option><option value="EWallet">전자지갑 결제
									</option><option value="POINT">포인트 결제
									</option><option value="GiftCard">상품권 결제									
								</option></select> -->
								<input type="radio" name="gopaymethod" value="Card" checked/>신용카드 결제
								<input type="radio" name="gopaymethod" value="VBank"/>무통장입금(가상계좌)
								
							</td>
						</tr>
						<tr>
							<td class="td01">상품명</td>
							<td class="td02"> <input name="goodname" value="${detail.NAME}"></td>
						</tr>
						<tr>
							<td class="td01">가격</td>
							<td class="td02"><input name="price" class="textInput" value="${detail.PRICE}"></td>
						</tr>
						<tr> 
							<td class="td01">성명</td>
							<td class="td02"><input name="buyername" value="${user.name}"></td>
				    </tr>
				    <tr> 
  	        	<td class="td01">이동전화</td>
  	        	<td class="td02"><input name="buyertel" value="010-1234-5678"></td>
				    </tr>
						<tr>
							<th class="td01">e-mail</th>
							<td class="td02"><input name="buyeremail" value="test@inicis.com"></td>
						</tr> 
					 	 <tr>
							<th class="td01">옵션</th>
							<td class="td02"><input name="acceptmethod" value="CARDPOINT:HPP(2):va_receipt:below1000:SKIN():KWPY_TYPE(0):KWPY_VAT(0):" class="textInput" size="50">
							<br>ex) CARDPOINT:SLIMQUOTA(코드-개월:개월):no_receipt:va_receipt:vbanknoreg(0):vbank(20150425):va_ckprice:vbanknoreg:<br>KWPY_TYPE(0):KWPY_VAT(10|0) 기타 옵션 정보 및 설명은 연동정의보 참조 구분자 ":"</td>
						</tr>
						<%--'결제창표시방법' 항목 삭제 (hidden) 처리 by sm 2016-01-08
						<tr>
							<th class="td01">결제창표시방법</th>
							<td class="td02"><input name="payViewType" value="" ><br/>[overlay|popup] (default:overlay)</td>
						</tr> --%>
						
						<%-- <tr>
							<th class="td01">무이자 할부 개월</th> 
							<td class="td02"><input name="nointerest" value=""><br>ex) 11-2:3:4,04-2:3:4</td>
						</tr> 
		        <tr class="td01">
		        	<td class="td01">할부 개월</td> 
		            <td class="td02"><input name="quotabase" value="2:3:4:5:6:7:8:9:10:11:12"><br>ex) 2:3:4</td>
		        </tr>  --%>
		        <tr>
					<th class="td01">언어선택 (ko|en) </th>
					<td class="td02"><input name="languageView" value="ko"></td>
				</tr> 
				</tbody>
				</table>
				<input type="hidden" name="version" value="1.0">
				<input type="hidden" name="mid" value="INIpayTest">	<!-- 상점 아이디  -->
				<input type="hidden" name="oid" value="${oid}">	 <!--  주문 번호 -->
				<input type="hidden" name="currency" value="WON">
   		        <input type="hidden" name="timestamp" value="${timestamp}">
		        <input type="hidden" name="signature" value="${signature}">
		        <input type="hidden" name="returnUrl" value="http://localhost:8800/learn/apply/doApply">
		        <input type="hidden" name="mKey" value="${mKey}"> 
		    	<!-- <input type="hidden" name="gopaymethod" value="VBank" > -->
		    	<input type="hidden" name="payMethod" id="payMethod" value="Card">
		        <input type="hidden" name="offerPeriod" value="2016010120160331"> <!-- 가맹점에서 판매상품에 대한 제공기한 설정 -->
		        <input type="hidden" name="charset" value="EUC-KR">
		  		<input type="hidden" name="closeUrl" value="http://localhost:8800/cancelPage1">
		  		<input type="hidden" name="payViewType" value="overlay">
		        <!-- <input type="hidden" name="popupUrl" value="https://www.inicis.com/Support_new/stdpay/INIStdPaySample/popup.php"> -->
		        <input type="hidden" name="vbankRegNo" value="">
		        <input type="hidden" name="merchantData" value="${detail.PRICE}">
		        <input type="hidden" name="merchantData" value="${detail.NameEncode}"> 
		        <input type="hidden" name="merchantData" value="${detail.LEARN_START_DATE}">
		        <input type="hidden" name="merchantData" value="${detail.LEARN_END_DATE}">
		        <input type="hidden" name="merchantData" value="${detail.ID}">
		        <input type="hidden" name="merchantData" value="${detail.CARDINAL_ID}">
		        
		<!--         <input type="hidden" id="payMethod" name="merchantData" value="Card">
		         -->
			
			<button type="button" onclick="INIStdPay.pay('SendPayForm_id')">결제</button>
			</form>
 
 <%-- <section class="join_section">
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
			
			<!-- ActionするFormBox -->
			<form id="SendPayForm_id" name="" method="POST">
			
			<select name="gopaymethod">
									<option value="">[ 결제방법 선택 ]
									</option><option value="Card">신용카드 결제
									</option><option value="DirectBank">실시간 은행계좌이체 
									</option><option value="VBank">무통장 입금 
									</option><option value="HPP">핸드폰 결제
									</option><option value="PhoneBill">받는전화결제 
									</option><option value="OCBPoint">OK 캐쉬백포인트 결제
									</option><option value="Culture">문화상품권 결제
									</option><option value="TeenCash">틴캐시 결제
									</option><option value="DGCL">스마트문화 상품권 결제
									</option><option value="BCSH">도서문화 상품권 결제	
									</option><option value="YPAY">옐로페이 결제
									</option><option value="KPAY">케이페이 결제
									</option><option value="EasyPay">간편 결제
									</option><option value="EWallet">전자지갑 결제
									</option><option value="POINT">포인트 결제
									</option><option value="GiftCard">상품권 결제									
								</option></select>
								
								
				<input type="text" name="version" value="1.0"> <input
					type="text" name="mid" value="INIpayTest"> <input
					type="text" name="goodname" value="${goodname}">
				<!-- 상품명=과정명 선택후 결정 -->
				<input type="text" name="oid" value="${oid}"> <input
					type="text" name="price" value="${price}">
				<!-- 사용자선택후 결정 -->
				<input type="text" name="currency" value="WON"> <input
					type="text" name="buyername" value="1234"> <input
					type="text" name="buyertel" value="1234">
				<input type="text" name="buyeremail" value="test@test.com">
				<input type="text" name="timestamp" value="2019-11-11">
				<input type="text" name="signature" value="${signature}">
				<input type="text" name="returnUrl"
					value="http://localhost:8888/learn/apply/test"> 
				<!--  <input type="hidden" name="closeUrl" value="www.naver.com" >  -->
				<input type="text" name="mKey" value="${mKey}"><!--  <input
					type="text" name="gopaymethod" id="gopaymethod" value=""> -->
				<input type="text" name="offerPeriod" value="${offerPeriod}">
				<input type="text" name="acceptmethod"
					value="CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000">
				<input type="text" name="payViewType" value="overlay"> <input
					type="text" name="languageView" value=""> <input
					type="text" name="charset" value=""> <input
					type="text" name="quotabase" value="${cardQuotaBase}"> <input
					type="text" name="ini_onlycardcode" value=""> <input
					type="text" name="ini_cardcode" value=""> <input
					type="text" name="ansim_quota" value=""> <input
					type="text" name="vbankRegNo" value=""> <input
					type="text" name="merchantData" id="merchantData" value="${seq}">
			</form>
			${seq}
			<button onclick="INIStdPay.pay('SendPayForm_id')" id="payreq"
				style="display: block;">결제하기</button>
		</article>
	</section> --%>
	
	
	
	
	
<!-- 각종 팝업레이어 -->
<%@ include file="/WEB-INF/views/learn/apply/inc_apply_layers.jsp"%>
<!-- // 각종 팝업레이어 -->