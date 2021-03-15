<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

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
		copyKcpResponse();	//kcp 응답코드 복사
		savePayment(); //결제완료 저장 처리
	}
	else
	{
		alert( "[" + frm.res_cd.value + "] " + frm.res_msg.value );

		closeEvent();
	}
}
</script>
<script type="text/javascript" src="${kcpConfig.g_conf_js_url }"></script>
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

<script>
$(document).ready(function(){
	// 우편 번호 조회 버튼 클릭 시
	$("a.search_addr").unbind("click").bind("click", function(event) {
		var idx = $("a.search_addr").index($(this));
		daumPostcode(idx);
	});

	$("#btnBookPayment").click(function(event){
		var f = document.getElementById("bookPaymentForm");
		var phone = concatArray([$('#phone1').val(),$('#phone2').val(),$('#phone3').val()],'-');
		var tel = concatArray([$('#tel1').val(),$('#tel2').val(),$('#tel3').val()],'-');
		$(f).find("input[name='phone']").val(phone);
		$(f).find("input[name='tel']").val(tel);

		if (!validateBookPaymentForm()) {
			return;
		}

		var $applyForm = $(f);
		var payment_type = $applyForm.find('input[name="payment_type"]:checked').val() || '';

		if (payment_type == "1") {	// 무통장입금
			savePayment();
		} else {	// kcp결제진행
			copyToKcp();

			jsf__pay(document.kcp_form);	// kcp팝업됨 팝업이후  - m_Completepayment로 결과 return받고 사용자 주문저장 로직 작성해야함
		}
	});

	$("#btnBookCancel").click(function(event){
		popupClose("orderBookPop");
	});

	$.validator.addMethod("checkTel",function(value, element) {
		return this.optional(element) || isValidTel(value);
	}, "유효하지 않은 입력입니다.");
	$("#bookPaymentForm").validate({
		ignore:".ignore",
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
		rules:{
			rec_name:{"required":true},
			phone:{"required":true,"checkTel":true},
			post_code:{"required":true},
			addr2:{"required":true},
			addressType:{"required":true},
			payment_type:{"required":true}
		},
		messages:{
			post_code: "우편 번호를 검색하여 선택하여 주십시오.",
			addr:"상세주소는 필수 항목입니다.",
			addressType:"배송지를 선택하여 주십시오.",
			payment_type:"결제 수단을 선택하여 주십시오."
		}
	});
});

function savePayment() {
	var f = document.getElementById("bookPaymentForm");
	var bookid = $("input[name='book']").attr("book");
	var amount = $("input[name='book']").val();

	var params  = $(f).serialize()+'&'+$.param({ 'bookid': bookid,  'amount':amount});

	$.ajax({
		url:'payBookAjax',
		method:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if (isSuccessAjaxResponse(data)) {
				alert(data.MESSAGE);
				location.reload();
			} else {
				alert("교재 구매에 실패하였습니다.");
			}
		},
		error:function(e) {
			alert("교재 구매에 실패하였습니다.");
		}
	});
}

//결제에 필요한 데이터를 kcp폼으로 복사
function copyToKcp() {
	// 결제에 필요한 값 copy
	var $applyForm = $('#bookPaymentForm');
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
	var good_mny = $applyForm.find('input[name="price"]').val();
	var good_name = $applyForm.find('input[name="good_name"]').val();
	var buyr_name = $applyForm.find('input[name="rec_name"]').val();
	var buyr_mail = $applyForm.find('input[name="email"]').val();
	var buyr_tel1 = $applyForm.find('input[name="tel"]').val();
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
	$('#bookPaymentForm .pgresponse').each(function(idx, obj) {
		//console.log($(this).attr('name'), $kcpForm.find('input[name="'+$(this).attr('name')+'"]').val() || '')
		$(this).val($kcpForm.find('input[name="'+$(this).attr('name')+'"]').val() || '');
	});
}

//입력값 체크
function validateBookPaymentForm() {
	var valid = checkBookStock();
	return $('#bookPaymentForm').valid() && valid;
}

function checkBookStock() {
	var valid = true;
	if($('.list-item').length > 0) {
		$('.list-item').each(function(idx, obj) {
			var $book = $(obj).find('input[name="book"]').first();
			var num = parseInt($book.val(),10);
			if(num < 1  || num > parseInt($book.attr('max'),10)) {
				$('#itemListErrorHolder').text('구매 수량을 확인하여 주십시오.').show();
				valid = false;
				return false;
			}
		});
	}
	if (valid) $('#itemListErrorHolder').text('').hide();
	return valid;
}

function bookEventReassign() {
	$("#totalPrice").text("0");
	$("#bookPaymentForm input[name='price']").val("0");
	$("#bookPaymentForm input[name='good_name']").val("");

	$("input[name='book']").bind('keyup mouseup', function(){
		var itemPrice = $(this).attr("price");
		var itemCount = $(this).val();
		$(this).attr("total", (itemPrice * itemCount));

		var goodName="[교재/교구] ";
		var totalPrice = 0;
		$("input[name='book']").each(function(index, item){
			totalPrice += parseInt($(this).attr("total"));

			if(parseInt($(this).val()) > 0){
				goodName += itemList[parseInt(index)].NAME;
			}
		});

		$("#totalPrice").text(addComma(totalPrice));
		$("#bookPaymentForm input[name='price']").val(totalPrice);
		$("#bookPaymentForm input[name='good_name']").val(goodName);
	});
	$("input[name='book']").bind('blur', function(){
		checkBookStock();
	});
}
</script>

<div class="cl-popup-overlay" id="orderBookPop" style="z-index:1000;">
				<div class="cl-popup-wrap">
					<c:choose>
						<c:when test="${currentDevice.mobile }">
					<div class="cl-popup-box full">
						</c:when>
						<c:otherwise>
					<div class="cl-popup-box mid" style="width:700px; margin-left:-350px;">
						</c:otherwise>
					</c:choose>
						<div class="popup-header">
							<h3 class="popup-title">교재 구매 신청</h3>
						</div>
						<div class="popup-body">
							<ul id="list-orderBook" class="spread-list section">
								<li class="list-header">
									<span class="item-title">교재명</span>
									<span class="item-price">교재 가격</span>
									<span class="item-max">재고 수량</span>
									<span class="item-buy">구매 수량</span>
								</li>
								<!-- ITEM 기본 형식 START-->
								<!--
								<li class="list-item">
									<span class="item-title">과정명 출력 본교재 - 교재명 출력</span>
									<span class="item-price"><strong>20,000</strong> 원</span>
									<span class="item-max"><strong>28</strong> 권</span>
									<span class="item-buy"><input type="number" class="w4em"> 권</span>
								</li>
								 -->
								<!-- ITEM 기본 형식 END-->
								<li class="list-footer" id="bookListFooter">
									<div id="itemListErrorHolder" style="display:none;color:red;text-align:center;font-weight: normal"></div>
									<p><span class="label">총 결제 금액</span>
										<span class="item-price"><strong class="danger" id="totalPrice">0</strong>원</span></p>
								</li>
							</ul>

							<form class="section" id="bookPaymentForm" onsubmit="return false;">
								<input type="hidden" name="order_idx">
								<input type="hidden" name="price">
								<input type="hidden" name="email" value="${userInfo.EMAIL }">
								<input type="hidden" name="good_name">
								<input type="hidden" name="learn_app_id">
								<input type="hidden" name="course_id">
								<input type="hidden" name="cardinal_id">

								<div class="section-header">
									<h5>배송 및 결제 정보</h5>
								</div>
								<dl>
									<dt>수령자</dt>
									<dd><input type="text" class="nth-1st" name="rec_name" id="rec_name"></dd>
									<dt>휴대 전화</dt>
									<dd>
										<select class="nth-1st required" name="phone1" id="phone1">
											<c:forEach var="item" items="${phone1List}">
												<option value="${item.NAME}">${item.NAME}</option>
											</c:forEach>
										</select>
										- <input type="text" maxlength="4" class="w4em" name="phone2" id="phone2">
										- <input type="text" maxlength="4" class="w4em" name="phone3" id="phone3">
										<input type="hidden" name="phone" id="phone"  />
									</dd>
									<dt>자택 전화</dt>
									<dd>
										<select class="nth-1st" name="tel1" id="tel1">
											<c:forEach var="item" items="${tel1List}"  >
												<option value="${item.NAME}">${item.NAME}</option>
											</c:forEach>
										</select>
										- <input type="text" maxlength="4" class="w4em" name="tel2" id="tel2">
										- <input type="text" maxlength="4" class="w4em" name="tel3" id="tel3">
										<input type="hidden" name="tel" id="tel" value="" />
									</dd>
									<dt>배송지</dt>
									<dd>
										<label><input type="radio" name="deliv_type" value="H">자택</label>
										<label><input type="radio" name="deliv_type" value="O">학교(직장)</label>
									</dd>
									<dt>주소</dt>
									<dd class="address">
										<input type="text" class="width20 nth-1st zipcode" id="post_code" name="post_code" readonly="readonly"><a class="btn primary search_addr" href="#none">우편 번호 검색</a><br>
										<input type="text" class="width100 nth-1st addr" id="addr1" name="addr1" ><br>
										<input type="text" class="width100 nth-1st etc_addr" id="addr2" name="addr2"></dd>
									<dt>요청 사항</dt>
									<dd><textarea class="h4em" name="remarks" id="remarks" ></textarea></dd>
									<dt>결제 수단</dt>
									<dd>
										<label><input type="radio" name="payment_type" value="1">무통장 입금</label>
										<c:if test="${not currentDevice.mobile }">
										<label><input type="radio" name="payment_type" value="2"> 계좌 이체</label>
										<%--<label><input type="radio" name="payment_type" value="3"> 가상 계좌</label> --%>
										<label><input type="radio" name="payment_type" value="4"> 신용 카드</label>
										</c:if>
									</dd>
								</dl>
								<div class="list-bottom alignC">
										<button class="btn primary w5em" id="btnBookPayment">결제</button>
										<button class="btn w5em btn-closePopup" id="btnBookCancel">취소</button>
								</div>

								<%--kcp 결제정보 --%>
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
								<%--kcp 결제정보 --%>
							</form>
						</div><!--//.popup-body-->
					</div><!--//.cl-popup-box-->
				</div><!--//.cl-popup-wrap-->
				<button class="cl-popup-closer">
					<span class="sr-only">닫기</span>
				</button>
			</div>

<form id="kcp_form" name="kcp_form" method="post">
<%-- 주문정보 --%>
<input type="hidden" name="pay_method" />
<input type="hidden" name="ordr_idxx" />
<input type="hidden" name="good_mny" />
<input type="hidden" name="good_name" />
<input type="hidden" name="buyr_name" />
<input type="hidden" name="buyr_mail" />
<input type="hidden" name="buyr_tel1" />
<input type="hidden" name="buyr_tel2" />
<%-- 가맹점필수정보1 config --%>
<input type="hidden" name="req_tx"          value="pay" />
<input type="hidden" name="site_cd"         value="${kcpConfig.g_conf_site_cd }" />
<input type="hidden" name="site_name"       value="${kcpConfig.g_conf_site_name }" />
<input type="hidden" name="module_type"     value="${kcpConfig.module_type }" />
<%--가맹점필수정보2  --%>
<input type="hidden" name="quotaopt"        value="0"/>
<input type="hidden" name="currency"        value="WON"/>
<%-- response --%>
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