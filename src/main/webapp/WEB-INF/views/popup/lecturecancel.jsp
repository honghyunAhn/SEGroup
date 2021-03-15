<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(document).ready(function(){
	$("#cancelForm #selectMail li").click(function(event){
		$("#cancelForm input[name='mail2']").val($(this).attr("data"));
		$(this).parent().toggleClass('off');
	});

	$("#cancelForm #selectBank li").click(function(event){
		$("#cancelForm input[name='bank']").val($(this).attr("data"));
		$(this).parent().toggleClass('off');
	});

	$(".btnLecCanSubmit").click(function(event){
		if(!confirm("취소 신청 하시겠습니까?")) return;

		var phone = concatArray([$('#cancelForm select[name="phone1"]').val(),$('#cancelForm input[name="phone2"]').val(),$('#cancelForm input[name="phone3"]').val()],'-');
		var tel = concatArray([$('#cancelForm select[name="tel1"]').val(),$('#cancelForm input[name="tel2"]').val(),$('#cancelForm input[name="tel3"]').val()],'-');
		var email = $('#cancelForm input[name="email1"]').val() + (isEmpty($('#cancelForm input[name="email1"]').val()) || isEmpty($('#cancelForm input[name="email2"]').val())?"":"@") + $('#cancelForm input[name="email2"]').val();
		$("#cancelForm input[name='tel']").val(tel);
		$("#cancelForm input[name='phone']").val(phone);
		$("#cancelForm input[name='email']").val(email);

		if (!validateCancelForm()) {
			return;
		}

		var params = $("#cancelForm").serialize();
		$.ajax({
			url:'saveCancelLectureAjax',
			type:'POST',
			data:params,
			dataType:'json',
			success:function(data) {
				if(data.result == "SUCCESS") {
					alert("신청 되었습니다.");
				} else {
					alert("신청시 문제가 발생했습니다.");
				}

				location.reload();
			},
			error:function(e) {
				alert("수강 취소 신청시 문제가 발생했습니다.");
				location.reload();
			}
		});
	});

	$(".btnLecCanClose").click(function(event){
		popupClose("lectureCancelPopup");
	});
});

function validateCancelForm() {
	if(!$("#cancelForm input[name='tel']").val()) {
		alert("일반전화를 입력해 주십시오.");
		return false;
	}

	if(!$("#cancelForm input[name='phone']").val()) {
		alert("휴대 전화를 입력해 주십시오");
		return false;
	}

	if(!$("#cancelForm input[name='email']").val()) {
		alert("전자우편을 입력해 주십시오.");
		return false;
	}

	if(!$("#cancelForm input[name='bookReturn']:checked").val()) {
		alert("교재 구매/반송여부를 선택해 주십시오.");
		return false;
	}

	if(!$("#cancelForm select[name='bank'] option:selected").val()) {
		alert("은행명을 입력해 주십시오.");
		return false;
	}

	if(!$("#cancelForm input[name='account']").val()) {
		alert("계좌 번호를 입력해 주십시오.");
		return false;
	}

	if(!isNumDash($("#cancelForm input[name='account']").val())){
		alert("계좌 번호를 정확히 입력해 주십시오.");
		return false;
	}

	if(!$("#cancelForm input[name='owner']").val()) {
		alert("예금주를 입력해 주십시오.");
		return false;
	}

	return true;
}
</script>

<div class="cl-popup-overlay" id="lectureCancelPopup">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">수강 취소 신청</h3>
			</div>
			<div class="popup-body">
				<form id="cancelForm">
					<input type="hidden" name="tel"  required />
					<input type="hidden" name="phone" required/>
					<input type="hidden" name="email" required/>
					<input type="hidden" name="learnAppId" required/>

					<dl>
						<dt>신청 구분</dt>
						<dd><strong class="primary">수강 취소</strong></dd>
						<dt>연수 과정명</dt>
						<dd><strong id="courseName"></strong></dd>
						<dt>성명</dt>
						<dd class="width30" id="userName"></dd>
						<dt class="border">아이디</dt>
						<dd class="width30" id="userId"></dd>
						<dt>휴대 전화</dt>
						<dd>
							<select class="nth-1st" name="phone1">
								<c:forEach var="item" items="${phone1List }">
									<option value="${item.NAME}">${item.NAME}</option>
								</c:forEach>
							</select>
							-
							<input type="text" maxlength="4" class="width10" name="phone2">
							-
							<input type="text" maxlength="4" class="width10" name="phone3">
						</dd>
						<dt>자택 전화</dt>
						<dd>
							<select class="nth-1st" name="tel1">
								<c:forEach var="item" items="${tel1List }">
									<option value="${item.NAME}">${item.NAME}</option>
								</c:forEach>
							</select>
							-
							<input type="text" maxlength="4" class="width10" name="tel2">
							-
							<input type="text" maxlength="4" class="width10" name="tel2">
						</dd>
						<dt>전자 우편</dt>
						<dd>
							<input class="nth-1st" type="text" name="mail1">@
							<input type="text" name="mail2">
							<div class="body-select width25">
								<a class="btn-toggle" href="#selectMail"><span>선택</span></a>
								<ul class="select-option off" id="selectMail">
									<li>직접 입력</li>
									<c:forEach var="item" items="${emailList }">
										<li data="${item.NAME}">${item.NAME}</li>
									</c:forEach>
								</ul>
							</div>
						</dd>
						<dt>교재</dt>
						<dd>
							<label><input type="radio" name="bookReturn" value="0">구매</label>
							<label><input type="radio" name="bookReturn" value="1">반송</label>
							<label><input type="radio" name="bookReturn" value="2">교재 없음</label>
						</dd>
						<dt>환불 계좌</dt>
						<dd>
							<label>은행명
							<select class="nth-1st" name="bank">
								<option value="">선택</option>
								<option value="기업은행">기업은행</option>
								<option value="국민은행">국민은행</option>
								<option value="농협중앙회">농협중앙회</option>
								<option value="단위농협">단위농협</option>
								<option value="우리은행">우리은행</option>
								<option value="대구은행">대구은행</option>
								<option value="외환은행">외환은행</option>
								<option value="SC제일은행">SC제일은행</option>
								<option value="부산은행">부산은행</option>
								<option value="새마을금고">새마을금고</option>
								<option value="한국씨티은행">한국씨티은행</option>
								<option value="광주은행">광주은행</option>
								<option value="경남은행">경남은행</option>
								<option value="수협">수협</option>
								<option value="신협">신협</option>
								<option value="전북은행">전북은행</option>
								<option value="제주은행">제주은행</option>
								<option value="산림조합">산림조합</option>
								<option value="우체국">우체국</option>
								<option value="하나은행">하나은행</option>
								<option value="신한은행">신한은행</option>
								<option value="동양종금증권">동양종금증권</option>
								<option value="한국투자증권">한국투자증권</option>
								<option value="삼성증권">삼성증권</option>
								<option value="미래에셋">미래에셋</option>
								<option value="우리투자증권">우리투자증권</option>
								<option value="현대증권">현대증권</option>
								<option value="SK증권">SK증권</option>
								<option value="신한금융투자">신한금융투자</option>
								<option value="하이증권">하이증권</option>
								<option value="HMC증권">HMC증권</option>
								<option value="대신증권">대신증권</option>
								<option value="하나대투증권">하나대투증권</option>
								<option value="동부증권">동부증권</option>
								<option value="유진증권">유진증권</option>
								<option value="메리츠증권">메리츠증권</option>
								<option value="신영증권">신영증권</option>
								<option value="대우증권">대우증권</option>
							</select>
							</label>
							<label>계좌 번호<input type="text" class="w13em" name="account"></label>
							<label>예금주<input type="text" class="w6em" name="owner"></label>
							<div class="note">
								<p class="blit ci-notice"><em>창비교육 원격교육연수원 운영 규정의 환불 기준에 따라 진행됩니다.</em></p>
								<ol>
									<li>무통장 입금/계좌 이체: 입력하신 계좌로 환불해 드립니다.</li>
									<li>신용 카드: 환불 기준에 따라 산출된 금액을 제하고 부분 취소 혹은 전액 취소해 드립니다.</li>
								</ol>
							</div><!--//.notice-->
						</dd>
						<dt>사유</dt>
						<dd><textarea name="memo"></textarea></dd>
					</dl>
					<div class="list-bottom alignC">
						<a href="#" class="btn primary btnLecCanSubmit">신청</a>
						<a href="#" class="btn btnLecCanClose">취소</a>
					</div>
				</form>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>