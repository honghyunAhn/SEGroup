<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/resources/js/printThis.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#receiptpop .printThis').click(function() {
		$('#receiptpop .print-wrap').printThis();
	});

	$(".btnReceiptClose").click(function(event){
		popupClose("receiptpop");
	});
});

function showReceiptPopup(id) {
	if(!id) return;

	var params = {};
	params.learnAppId = id;

	$.ajax({
		url:'selectReceiptAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data){
			if(data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var receipt = data.receipt;
			$("#receiptpop #course_name").text(receipt.COURSE_NAME);
			$("#receiptpop #learn_start_date").text(receipt.LEARN_START_DATE+'.');
			$("#receiptpop #learn_end_date").text(receipt.LEARN_END_DATE+'.');
			$("#receiptpop #learn_time").text(receipt.COMPLETE_TIME);
			$("#receiptpop #credit").text(receipt.CREDIT);
			$("#receiptpop #real_payment").text(receipt.REAL_PAYMENT);
			$("#receiptpop #payment_date").text(receipt.PAYMENT_DATE);

			popupOpen("receiptpop");
		},
		error:function(e){
			alert("영수증 조회시 문제가 발생했습니다.");
		}
	});
}
</script>

<div class="cl-popup-overlay" id="receiptpop">
		<div class="cl-popup-wrap">
			<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mid" style="width: 446px; margin-left:-223px">
				</c:otherwise>
			</c:choose>
				<div class="popup-body">
					<!-- 출력 기능을 하는 팝업에서만 불러오는 스타일 시트-->

					<div id="receipt" class="print-wrap section">
						<h3 class="print-title">영 수 증</h3>
						<ul class="group-list">
							<%/*
							<li>
								<ul>
									<li><em class="label">발행번호</em> 발행번호 생략</li>
								</ul>
							</li>
							*/%>
							<li>
								<h5>공급자</h5>
								<ul>
									<li><em class="label">사업자 등록번호</em> 105-88-04459</li>
									<li><em class="label">상호/대표</em> (주)창비교육 / 강일우</li>
									<li><em class="label">업태</em> 제조, 서비스</li>
									<li><em class="label">종목</em> 일반서적출판, 교육서비스업</li>
									<li><em class="label">사업장 주소지</em> 서울특별시 마포구 월드컵로 12길 7</li>
								</ul>
							</li>
							<li>
								<h5>공급받는 자</h5>
								<ul>
									<li>
										<em class="label">성명</em>
										<sec:authorize access="isAuthenticated()"><sec:authentication property="principal.name"/></sec:authorize>
										/ <input type="text" placeholder="소속 기관명을 입력하세요">
									</li>
									<li><em class="label">과정명</em> <span id="course_name" style="display:inline-flex;width:230px;"></span></li>
									<li><em class="label">연수 기간</em>
											<span id="learn_start_date"></span> ~
											<span id="learn_end_date"></span>
											(<span id="learn_time"></span>시간/<span id="credit"></span>학점)</li>
									<li><em class="label">금액</em> <strong><span id="real_payment"></span></strong>원</li>
								</ul>
							</li>
						</ul>
						<div class="section receipt-issue">
							<p>위 연수과정에 대한 수강료를 정히 영수함</p>
							<p class="date"><span id="payment_date"></span></p>
							<p class="issuer"><em>(주)창비교육</em><img src="/resources/images/stamp.png" alt="직인"></p>
						</div>
					</div><!--//.print-wrap-->
					<div class="screen-only alignC">
							<button class="btn primary w5em printThis">인쇄</button>
							<button class="btn w5em btn-closePopup btnReceiptClose">닫기</button>
					</div>
				</div><!--//.popup-body-->
			</div><!--//.cl-popup-box-->
		</div><!--//.cl-popup-wrap-->
		<button class="cl-popup-closer">
			<span class="sr-only">닫기</span>
		</button>
	</div>