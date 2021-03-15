<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){
	var totalPages = ${searchVO.totalPages};//전체 페이지
    var visiblePages = ${searchVO.visiblePages};//리스트 보여줄 페이지
    var startPage = ${searchVO.startPage};//현재 페이지

    if(totalPages != 0){
    	$('#pagination').twbsPagination({
	        totalPages: totalPages,
	        visiblePages: visiblePages,
	        startPage: startPage,
	        first : "",
	        prev : "«",
	        next : "»",
	        last : "",
	        initiateStartPageClick : false,
	        onPageClick: function (event, page) {
	            $('#searchForm input[name="startPage"]').val(page);
	            $("#searchForm").submit();
	        }
    	});
 	};
});

// KCP 영수증 팝업 열기
function showKcpReceiptPopup(params) {
	
	if(!params) return;
	
	$.ajax({
		url:'selectKcpReceiptAjax', // KCP 영수증 조회를 위한 데이터 가져오는 서비스 
		type:'POST',
		data:params,
		dataType:'json',
		success:function(result){
			
			if(result.result == "FAIL") {
				alert(result.message);
				return;
			}
			
			// KCP 베이스 주소
			var popup_url = 'https://admin8.kcp.co.kr/assist/bill.BillActionNew.do?';
			
			// KCP 영수증 조회를 위한 파라미터
			var popup_param = {};
			
			// 팝업 옵션
			var popup_opt = '';
			
			switch (params.paymentType) {
			case '1' : // 무통장입금 인 경우
				popup_param.cmd = 'cash_bill'; 
				popup_param.cash_no = result.receipt.APP_NUM;			// 결제승인번호 (= KCP 현금영수증 거래번호)
				popup_param.order_no = result.receipt.ORDER_IDX			// 주문번호
				popup_param.trade_mony = result.receipt.REAL_PAYMENT	// 실 거래금액
				popup_opt = 'width=420, height=670'; 					// 권장크기
				break;
			case '2' : // 계좌이체 인 경우
				popup_param.cmd = 'cash_bill'; 							// KCP 결제분류 (현금영수증)
				popup_param.cash_no = result.receipt.CASH_NO; 			// KCP 현금영수증 거래번호
				popup_param.order_no = result.receipt.ORDR_IDXX; 		// KCP 주문번호
				popup_param.trade_mony = result.receipt.GOOD_MNY; 		// KCP 거래금액
				popup_opt = 'width=420, height=670'; // 권장크기
				break;
			case '4' : // 신용카드 인 경우
				popup_param.cmd = 'card_bill'; 							// KCP 결제분류 (신용카드)
				popup_param.tno = result.receipt.TNO; 					// KCP 거래번호
				popup_param.trade_mony = result.receipt.GOOD_MNY; 		// KCP 거래금액
				popup_param.order_no = result.receipt.ORDR_IDXX; 		// KCP 주문번호
				popup_opt = 'width=470, height=815'; 					// 권장크기
				break;
			}
			
			popup_param = $.param(popup_param); // 오브젝트 -> 쿼리스트링 변환
			
			var popup = window.open(popup_url + popup_param, '_blank', popup_opt);
			
		},
		error:function(e){
			alert("영수증 조회시 문제가 발생했습니다.");
		}
	});
}
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a class="nth-last" href="${contextPath}">영수증/이수증 정보</a>
		</p>
		<h2 class="sub-title">영수증/이수증 정보</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<ul class="tab-header sub x3">
			<li><a <c:if test="${searchVO.learn_type eq null }">class="nth-1st on"</c:if> href="receipt">전체</a></li>
			<li><a <c:if test="${searchVO.learn_type eq 'J' }">class="nth-1st on"</c:if> href="receipt?learn_type=J">직무</a></li>
			<li><a <c:if test="${searchVO.learn_type eq 'S' }">class="nth-1st on"</c:if> href="receipt?learn_type=S">자율</a></li>
		</ul>
		<div class="tab-body group">
			<form id="searchForm">
					<input type="hidden" name="startPage" value="${searchVO.startPage }"/>
					<input type="hidden" name="learn_type" value="${searchVO.learn_type }"  />
					<input type="hidden" name="id"  />
			</form>
			<table class="list" id="list-doc">
				<colgroup>
					<col width="120">
					<col width="">
					<col width="200">
					<col width="100">
					<col width="100">
					<col width="100">
					<col width="100">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="item-type">연수 구분</th>
						<th scope="col" class="item-title">연수 과정명</th>
						<th scope="col" class="item-date">연수 기간</th>
						<th scope="col" class="item-doc">성적표</th>
						<th scope="col" class="item-doc">수강 확인증</th>
						<th scope="col" class="item-doc">영수증</th>
						<th scope="col" class="item-doc">이수/수료증</th>
					</tr>
				</thead>
				<tbody>
					<%-- <tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
						<td class="item-type">연수 구분</td>
						<td class="item-title"><strong>연수 과정 명</strong></td>
						<td class="item-date">2018. 03. 01 ~ 2018. 04. 01</td>
						<td class="item-doc"><a class="btn" href="javascript:popupOpen('scorecardpop')" ><span>성적표</span></a></td>
						<td class="item-doc"><a class="btn" href="javascript:popupOpen('registerpop')" ><span>수강 확인증</span></a></td>
						<td class="item-doc"><a class="btn" href="javascript:popupOpen('receiptpop')" ><span>영수증</span></a></td>
						<td class="item-doc"><a class="btn" href="javascript:popupOpen('certificatepop')" ><span>이수증</span></a></td>
					</tr> --%>

					<c:if test="${!empty list }">
						<c:forEach var="item" items="${list}" varStatus="status">
						<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
							<td class="item-type">${item.LEARN_TYPE_NAME }</td>
							<td class="item-title"><strong>${item.NAME }</strong></td>
							<td class="item-date">${item.LEARN_START_DATE }. ~ ${item.LEARN_END_DATE }.</td>
							<td class="item-doc">
								<c:if test="${ 'Y' eq item.ISSUE_YN && '' ne item.ISSUE_NUM  }">
									<a class="btn" onclick="javascript:showScorecardPopup('${item.ID }')" ><span>성적표</span></a>
								</c:if>
								<c:if test="${'N' eq item.ISSUE_YN}"></c:if>
							</td>
							<td class="item-doc">
								<c:if test="${'N' eq item.END_YN}">
									<a class="btn"onclick="javascript:showRegisterPopup('${item.ID }')" ><span>수강 확인증</span></a>
								</c:if>
								<c:if test="${'Y' eq item.END_YN}"></c:if>
							</td>
							<td class="item-doc">
								<c:if test="${item.REAL_PAYMENT != 0 }">
									<%-- <a class="btn" onclick="javascript:showReceiptPopup('${item.ID }')" ><span>영수증</span></a> --%>
									<a class="btn" onclick="javascript:showKcpReceiptPopup({learnAppId:'${item.ID}', paymentType:'${item.PAYMENT_TYPE}'})" ><span>영수증</span></a>
									
								</c:if>
								<c:if test="${item.REAL_PAYMENT == 0 }"></c:if>
							</td>
							<td class="item-doc">
								<c:if test="${'Y' eq item.ISSUE_YN && '' ne item.ISSUE_NUM }">
									<a class="btn" onclick="javascript:showCertificationPopup('${item.ID }')" ><span>이수증</span></a>
								</c:if>
								<c:if test="${'N' eq item.ISSUE_YN}">-</c:if>
							</td>
						</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list }">
						<tr class="nth-1st">
							<td colspan='7'>조회된 데이터가 없습니다.</td>
						</tr>
					</c:if>

				</tbody>
			</table>
			<div class="list-bottom">
				<!-- <div class="pagination">
					<a href="#">«</a>
					<a class="on" href="#">1</a>
					<a href="#">2</a>
					<a href="#">3</a>
					<a href="#">»</a>
				</div> -->
			</div>
		</div><!--.tab-body-->
		<ul class="notice-list">
			<li><em>모든 연수가 조회되며,  각종 출력을 할 수 있는 조건은 다음과 같습니다.</em>
				<ol class="subList">
					<li>성적표 : 정상 이수를 하여 이수 번호가 부여된 경우 출력 가능 (단, 성적 발표 후 출력 가능하며 연수가 종료되었어도 과거 성적표 출력 가능)</li>
					<li>수강 확인증 : 수강 상태가 정상 인증인 경우 수강 확인증 출력 가능(연수 기간에만 출력 가능)</li>
					<li>이수증 : 정상 이수하여 이수 번호가 부여된 경우 출력 가능하며, 연수 기간중이라도 이수증이 발행된 경우 “수강 확인증”은 사라지며 이수증이 표시되어야 함 / 이수를 하지 못한 과락의 경우 '-'으로 표기됨</li>
					<li>영수증: 결제 상태가 결제 완료이고, 실 납입 금액이 '0'이 아닌 경우 영수증 출력 가능</li>
				</ol>
			</li><li><em>위 출력물은 다음 페이지에 모두 표시되어 있으며, 모두 팝업으로 표시 후 인쇄합니다.</em></li>
		</ul>
	</div><!--//.sub-body-->
</div>
<!--// 1.3. 본문 -->
