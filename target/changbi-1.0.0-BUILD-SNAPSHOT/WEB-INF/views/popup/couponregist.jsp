<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$(".btnCouponRegistClose").click(function(event){
		popupClose('couponRegistPop');
	});

	$("#btnCouponRegist").click(function(event){
		if(!$("#coupon").val()){
			alert("쿠폰번호를 입력해 주십시오.");
			return;
		}

		var params = {};
		params.coupon_num = $("#coupon").val();
		console.log(params);

		$.ajax({
			url:'couponRegistAjax',
			type:'POST',
			data:params,
			dataType:'json',
			success:function(data) {
				console.log(data);
				if (data.result == "FAIL") {
					alert(data.message);
					return;
				}

				alert("쿠폰이 등록되었습니다.");
				popupClose('couponRegistPop');
			},
			error:function(e) {
				alert("쿠폰등록시 오류가 발생했습니다.");
			}
		});
	});
});
</script>

<div class="cl-popup-overlay" id="couponRegistPop">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mini" style="width:580px; height:420px; margin-left:-290px; margin-top:-210px">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">쿠폰 등록하기</h3>
			</div>
			<div class="popup-body">
				<form class="group" id="couponForm">
					<ul class="notice-list section">
						<li>쿠폰번호를 입력하신 후 쿠폰 등록하기 버튼을 클릭하시면 나의 쿠폰으로 등록됩니다.</li>
						<li>쿠폰은 유효기간이 있으므로 등록된 쿠폰에 대한 정볼를 나의 쿠폰함에서 확인하여 사용하시기 바랍니다.</li>
					</ul>
					<dl class="section">
						<dt>쿠폰 번호</dt>
						<dd>
							<input type="text" class="w20em" id="coupon" maxlength="20">
							<button class="btn primary" id="btnCouponRegist" >쿠폰 등록</button>
							<p>※ 쿠폰 번호 입력 시 대소문자는 구분하지 않습니다.</p>
						</dd>
					</dl>
				</form><!--//.section-->
				<div class="alignC">
						<button class="btn w5em btnCouponRegistClose">닫기</button>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>