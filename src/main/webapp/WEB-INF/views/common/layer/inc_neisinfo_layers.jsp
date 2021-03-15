<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--// NEIS개인 번호안내 팝업 -->
<div class="cl-popup-overlay" id="layerNeisInfo">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:600px;margin-left:-300px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title"><strong class="primary">NEIS 개인 번호</strong>가 무엇인가요?</h3>
			</div>
			<div class="popup-body">
					<div class="section">
						<div class="section-header box strong">
							<h5> NEIS 개인 번호란?</h5>
						</div>
						<div class="section-body box">
							<p>연수를 마친 뒤 교육청에 이수 보고를 할 때 사용되며, 입력하신 NEIS 개인 번호가 교육 행정 정보시스템(나이스 <a href="http://www.neis.go.kr" target="_blank">www.neis.go.kr</a>)과 일치하지 않으면 학점 인정이 되지 않습니다.<br>
								NEIS 개인 번호를 입력하지 않거나 잘못 입력하여 등재되지 않은 연수는 연수원에서 책임지지 않으므로 반드시 입력해 주시기 바랍니다.
							</p>
						</div>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header box strong">
							<h5> NEIS 개인 번호 확인 방법</h5>
						</div>
						<div class="section-body box">
							<p>[나이스]-[기본 메뉴]-[나의 메뉴]-[인사 기록]-[기본 사항]-[근무 사항]에서 10자리 (영문자+7자리 숫자)로 구성된 NEIS 개인 번호를 확인할 수 있습니다.</p>
						</div>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header box strong">
							<h5> NEIS 개인 번호 입력 방법</h5>
						</div>
						<div class="section-body box">
							<ol class="basic-list">
								<li>연수는 NEIS 개인 번호를 입력한 뒤 신청합니다.</li>
								<li>[나의 강의실]-[개인 정보 관리]에서 NEIS 개인 번호를 입력하고 수정할 수 있습니다.</li>
							</ol>
							<p>※ 연수를 신청할 때 NEIS 개인 번호를 입력하지 않았으면 연수를 마치기 전에 [개인 정보 관리]에서 반드시 추가 입력해서 고쳐 주시기 바랍니다. </p>
						</div>
					</div><!--//.section-->
				<div class="alignC">
					<button class="btn w5em close">창 닫기</button>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// NEIS개인 번호안내 팝업 -->

<!--// 연수 지명 번호 안내 팝업 END -->
<div class="cl-popup-overlay" id="layerTrainingNumber">
		<div class="cl-popup-wrap">
			<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mini" style="width:580px; height:490px; margin-left:-290px; margin-top:-245px">
				</c:otherwise>
			</c:choose>
			<div class="popup-header">
				<h3 class="popup-title"><strong class="primary">연수 지명 번호</strong>가 무엇인가요?</h3>
			</div>
			<div class="popup-body">
				<div class="group">
					<p class="alignC img"><img src="/resources/images/popup_localCode.png"></p>
					<ul class="notice-list ">
						<li>기존 원격 직무 연수 및 집합 연수시 행정 서류로 제출하였던 <em>"학교장 추천서"제도</em>가 변경된 것으로 2007년 3월 부로 적용 및 시행되는 제도입니다.</li>
						<li>각 학교별 연수를 관장하는 <em class="primary">연구 부장 선생님</em>의 주관하에 <em>연수 지명 명부를 제작&amp;비치</em>하도록 되어 있으며, <em>지명 양식에 의거 발급</em> 받으시면 됩니다.</li>
				</ul>
				</div>
				<div class="alignC">
					<button class="btn w5em close">창 닫기</button>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 연수 지명 번호 안내 팝업 END -->

<!--// 취소환불안내 팝업 -->
<div class="cl-popup-overlay" id="layerRefundInfo">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:600px;margin-left:-300px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">취소/환불 안내</h3>
			</div>
			<div class="popup-body">
					<div class="section">
						<div class="section-header box strong">
							<h5> 연수 연기/취소 기준</h5>
						</div>
						<div class="section-body box">
							<ul class="basic-list">
								<li>연수 연기/취소는 개강일로부터 7일 이내 통합 1회만 가능</li>
								<li>단, 진도율 20%이상 진행 시 연기/취소 불가</li>
								<li>정해진 연수기간은 절대 연장할 수 없으며, 부득이한 출장/병가 등의 사유 발생 시에는 연수종료일까지 증빙서류 제출 후 다음기수로 연기가 가능합니다.</li>
								<li>연수 개강일 이후 연수를 신청한 경우에도, 연기/취소는 개강일 기준으로 7일 이내만 가능합니다.</li>
								<li>출석시험 또는 진도, 과제, 평가 등의 연수 일부만 연기는 불가합니다.</li>
								<li>연기대기한 연수는 1년 이내 수강해야 합니다.</li>
								<li>금액이 다른 연수로 변경할 경우 환불 또는 추가결제가 이루어질 수 있습니다.</li>
								<li>취소 후 결제 금액 환불은 최대 7일~10일 가량 소요됩니다.</li>
								<li>취소가능 기간이후(연수 개강일 기준 7일)에는 학습을 시작하지 않아도 환불이 불가합니다.</li>
								<li>미이수한 과정은 환불불가하며, 재신청 시 50% 할인된 금액으로 신청할 수 있습니다.</li>
							</ul>
						</div>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header box strong">
							<h5> 교재</h5>
						</div>
						<div class="section-body box">
							<ul class="basic-list">
								<li>본원 실수이거나 파본일 경우 재발송 비용은 본원 부담</li>
								<li>회원의 단순 변심, 강좌 변경, 개인 사유일 경우 재발송(반송)택배비 본인 부담</li>
							</ul>
						</div>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header box strong">
							<h5> 공통</h5>
						</div>
						<div class="section-body box">
							<ul class="basic-list">
								<li>할인 쿠폰을 사용하여 결제 한 후 환불 시, 할인 쿠폰은 소멸</li>
								<li>구매 상품 환불 시, 무료 제공 교재와 이벤트 상품 등은 반송 후 환불</li>
								<li>포인트 사용 결제 시, 환불할 경우 포인트는 환원</li>
							</ul>
						</div>
					</div><!--//.section-->
				<div class="alignC">
					<button class="btn w5em close">창 닫기</button>
				</div>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 취소환불안내 팝업 -->
