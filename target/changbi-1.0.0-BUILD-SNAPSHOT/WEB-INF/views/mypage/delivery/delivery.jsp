<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<style type="text/css">
.body-search input[type=text] {margin:0 4px;}
</style>

<script type="text/javascript">
$(document).ready(function(){
	var totalPages = ${searchVO.totalPages};
	var visiblePages = ${searchVO.visiblePages};
	var startPage = ${searchVO.startPage};

	if (totalPages != 0) {
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
	}

	$( "#startDate, #endDate" ).datepicker();

	$("#btnSearch").click(function(event){
		$("#searchForm").submit();
	});

});

function searchDelivery(delivNum) {
	window.open("http://nexs.cjgls.com/web/info.jsp?slipno="+delivNum);
}
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a class="nth-last" href="${contextPath }">배송 정보</a>
		</p>
		<h2 class="sub-title">배송 정보</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
			<div class="list-top">
				<form class="body-search" id="searchForm">
					<input type="hidden" name="startPage" value="${searchVO.startPage }">
					<input type="text" class="w20em" name="searchKeyword" placeholder="과정명 및 송장 번호를 입력하세요" value="${searchVO.searchKeyword }">
					<input type="text" name="startDate" id="startDate" value="${searchVO.startDate }" placeholder="검색 시작 일자">
					<span class="label">~</span>
					<input type="text" name="endDate" id="endDate" value="${searchVO.endDate }" placeholder="검색 종료 일자">
					<button type="button" id="btnSearch"><span class="sr-only">검색</span></button>
				</form>
			</div>
			<table class="list" id="list-deliver">
							<colgroup>
								<col width="120">
								<col width="120">
								<col width="120">
								<col width="">
								<col width="70">
								<col width="70">
								<col width="180">
								<col width="100">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="item-date">신청 일자</th>
									<th scope="col" class="item-date">결제 일자</th>
									<th scope="col" class="item-date">배송 일자</th>
									<th scope="col" class="item-title">연수 과정명</th>
									<th scope="col" class="item-num">교재 수량</th>
									<%-- <th scope="col" class="item-num">교구 수량</th> --%>
									<th scope="col" class="item-code">송장 번호</th>
									<th scope="col" class="item-state">배송 상태</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${!empty list }">
									<c:forEach var="item" items="${list }" varStatus="status">
										<tr <c:if test="${status.index == 0 }"> class="nth-1st"</c:if>><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
											<td class="item-date">${item.REQ_DATE }</td>
											<td class="item-date">${item.PAYMENT_DATE }</td>
											<td class="item-date">${item.DELIV_DATE }</td>
											<td class="item-title"><strong>${item.COURSE_NAME }</strong></td>
											<td class="item-num"><strong>${item.AMOUNT }</strong></td>
											<%-- <td class="item-num"><strong class="danger">1</strong></td> --%>
											<td class="item-code">
												<span class="deliver-code">${item.DELIV_NUM }</span>
												<c:if test="${!empty item.DELIV_NUM }">
													<a class="btn XS primary" href="javascript:searchDelivery('${item.DELIV_NUM }')">조회</a>
												</c:if>
											</td>
											<td class="item-state">
												<c:if test="${item.DELIV_YN eq 'N' && item.DELIV_NUM eq null }">
													<em class="primary">발송 준비중</em>
												</c:if>
												<c:if test="${item.DELIV_YN eq 'N' && item.DELIV_NUM ne null }">
													<em class="primary">배송중</em>
												</c:if>
												<c:if test="${item.DELIV_YN eq 'Y' && item.DELIV_NUM ne null }">
													<em class="primary">배송완료</em>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty list }">
									<tr>
										<td colspan=7>배송 정보가 없습니다.</td>
									</tr>
								</c:if>
								<%-- <tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
									<td class="item-date">2018. 03. 01</td>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-title"><strong>연수 과정 명</strong></td>
									<td class="item-num"><strong>1</strong></td>
									<td class="item-num"><strong class="danger">1</strong></td>
									<td class="item-code">
										<span class="deliver-code">123333333</span>
										<a class="btn XS primary" href="#">조회</a>
									</td>
									<td class="item-state"><em class="primary">배송중</em></td>
								</tr>
						<!-- ITEM 반복 START-->
								<tr>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-title"><strong>연수 과정 명</strong></td>
									<td class="item-num"><strong>1</strong></td>
									<td class="item-num"><strong class="danger">1</strong></td>
									<td class="item-code">
										<span class="deliver-code">123333333</span>
										<a class="btn XS primary" href="#">조회</a>
									</td>
									<td class="item-state"><em class="primary">배송 완료</em></td>
								</tr>
								<tr>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-date">2018. 03. 01</td>
									<td class="item-title"><strong>연수 과정 명</strong></td>
									<td class="item-num"><strong>1</strong></td>
									<td class="item-num"><strong class="danger">1</strong></td>
									<td class="item-code">&nbsp;</td>
									<td class="item-state"><em class="primary">발송 준비중</em></td>
								</tr>
						<!--//ITEM 반복 END--> --%>
							</tbody>
						</table>
			<div class="list-bottom">
				<ul id="pagination"></ul>
			</div>
	</div><!--//.sub-body-->
</div>
<!--// 1.3. 본문 -->
