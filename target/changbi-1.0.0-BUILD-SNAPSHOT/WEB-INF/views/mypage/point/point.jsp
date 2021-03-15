<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>

<style type="text/css">
td.item-num, td.item-total { text-align:right; }
</style>
<script type="text/javascript">
$(document).ready(function(){
	var pointTotalPages = ${searchVO.pointTotalPages};
	var pointVisiblePages = ${searchVO.pointVisiblePages};
	var pointStartPage = ${searchVO.pointStartPage};

	if (pointTotalPages != 0) {
		$('#pointPagination').twbsPagination({
	        totalPages: pointTotalPages,
	        visiblePages: pointVisiblePages,
	        startPage: pointStartPage,
	        first : "",
	        prev : "«",
	        next : "»",
	        last : "",
	        initiateStartPageClick : false,
	        onPageClick: function (event, page) {
	            $('#pointStartPage').val(page);
	            $("#searchForm").submit();
	        }
    	});
	}

	var couponTotalPages = ${searchVO.couponTotalPages};
	var couponVisiblePages = ${searchVO.couponVisiblePages};
	var couponStartPage = ${searchVO.couponStartPage};

	if (couponTotalPages != 0) {
		$('#couponPagination').twbsPagination({
	        totalPages: couponTotalPages,
	        visiblePages: couponVisiblePages,
	        startPage: couponStartPage,
	        first : "",
	        prev : "«",
	        next : "»",
	        last : "",
	        initiateStartPageClick : false,
	        onPageClick: function (event, page) {
	            $('#couponStartPage').val(page);
	            $("#searchForm").submit();
	        }
    	});
	}

	$('.tooltip').tooltip();
});
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a href="${contextPath}" class="nth-last">포인트/쿠폰 정보</a>
		</p>
		<h2 class="sub-title">포인트/쿠폰 정보</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<form id="searchForm" method="post">
			<input type="hidden" name="pointStartPage" id="pointStartPage" value="${searchVO.pointStartPage }" />
			<input type="hidden" name="couponStartPage" id="couponStartPage" value="${searchVO.couponStartPage }" />
		</form>
		<div id="mypage-point" class="group">
			<div class="section box">
				<div class="section-header strong"><h4>포인트 현황</h4></div>
				<div class="section-body borderT">
						<ul class="summary-list">
							<li><span class="label">사용 가능 포인트</span><strong class="num primary"><fmt:formatNumber value="${pointSummary.BALANCE }" groupingUsed="true"/></strong>점</li>
							<li><span class="label">익월 소멸 예정 포인트</span><strong class="num danger">0</strong>점</li>
						</ul>
						<table class="list" id="list-deliver">
							<colgroup>
								<col width="85">
								<col width="">
								<col width="70">
								<col width="70">
								<col width="70">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="item-date">일시</th>
									<th scope="col" class="item-type">구분</th>
									<th scope="col" class="item-num">사용 포인트</th>
									<th scope="col" class="item-num">적립 포인트</th>
									<th scope="col" class="item-total">잔여 포인트</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${!empty pointList }">
								<c:forEach var="item" items="${pointList }"  varStatus="status">
									<tr <c:if test="${status.index == 0 }">class="nth-1st"</c:if>><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
									<td class="item-date">${item.REG_DATE }</td>
									<td class="item-type"><a href="#" title="${item.NOTE }" class="tooltip"><util:strcut len="18" value="${item.NOTE }"/></a></td>
									<td class="item-num"><fmt:formatNumber value="${item.WITHDRAW }" groupingUsed="true"/></td>
									<td class="item-num"><fmt:formatNumber value="${item.GIVE }" groupingUsed="true"/></td>
									<td class="item-total"><fmt:formatNumber value="${item.BALANCE}" groupingUsed="true"/><strong></strong></td>
								</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty pointList }">
								<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
									<td colspan=5>포인트 적립 내용이 없습니다.</td>
								</tr>
							</c:if>
							</tbody>
						</table>
						<div class="list-bottom">
							<ul id="pointPagination"></ul>
						</div>
					</div>
			</div><!--//.section-->
			<div class="section box">
				<div class="section-header strong">
					<h4>쿠폰 현황</h4>
					<p class="ctrl-btnSet"><a class="btn primary" href="javascript:popupOpen('couponRegistPop');">쿠폰 등록</a></p>
				</div>
				<div class="section-body borderT">
						<ul class="summary-list">
							<li><span class="label">사용 가능 쿠폰</span><strong class="num danger">${searchVO.couponTotalCnt }</strong>장</li>
						</ul>
						<table class="list" id="list-deliver">
							<colgroup>
								<col width="90">
								<col width="180">
								<col width="">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="item-date">사용 기한</th>
									<th scope="col" class="item-code">쿠폰 번호</th>
									<th scope="col">쿠폰 설명</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${!empty couponList }">
									<c:forEach var="item" items="${couponList }" varStatus="status">
										<tr <c:if test="${status.index == 0 }">class="nth-1st"</c:if>><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
											<td>${item.EXP_DATE }</td>
											<td>${item.COUPON_NUM }</td>
											<td>
												<c:if test="${item.COUPON_TYPE  == 1}">
													${item.COUPON }원 할인
												</c:if>
												<c:if test="${item.COUPON_TYPE  == 2}">
													${item.COUPON }% 할인
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</c:if>

								<c:if test="${empty couponList }">
									<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
										<td colspan="3">보유하신 쿠폰이 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<div class="list-bottom">
							<ul id="couponPagination"></ul>
						</div>
					</div>
			</div><!--//.section-->
		</div><!--//.group-->
		<div class="section clearB">
			<div class="section-header box">
				<h4>포인트 적립 안내</h4>
			</div>
			<table class="table">
				<colgroup>
					<col width="150">
					<col width="">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">세부 내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="alignL">
							<ul class="note">
								<li>회원 가입: 1,000point</li>
								<li>연수 과정 결제: 결제 금액 5% 적립</li>
								<!-- <li>로그인: 10point 적립(1일 1회)</li> -->
								<li>후기 작성: 500point 적립(과정당 1회)</li>
								<!-- <li>추천인: 500point 적립</li> -->
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box">
				<h4>포인트 사용 안내</h4>
			</div>
			<div class="section-body box">
				<ul class="note">
					<li>포인트 사용: 1 포인트 = 1원</li>
					<li>포인트 유효 기간: 포인트는 당해 연도만 사용 가능, 매년 1월 1일 전 연도 포인트 일괄 삭제</li>
				</ul>
			</div>
		</div><!--//.section-->
	</div><!--//.sub-body-->
</div>
<!--// 1.3. 본문 -->
