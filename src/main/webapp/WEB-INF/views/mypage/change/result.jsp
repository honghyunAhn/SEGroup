<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

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
	        		$('#startPage').val(page);
	            $("#searchForm").submit();
	        }
    	});
	}
});
</script>

<t:insertDefinition name="mypageleftmenu"/>

	<!-- 1.3. 본문 -->
			<div class="body">
				<div class="sub-header">
					<p class="sub-nav">
						<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
						<a href="#">나의 강의실</a>
						<a href="#">강의실</a>
						<a class="nth-last" href="${contextPath}">연수 연기/취소</a>
					</p>
					<h2 class="sub-title">연수 연기/취소</h2>
					<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
				</div><!--//.sub-header-->
				<div class="sub-body">
					<div class="tab-group">
						<ul class="tab-header sub x2">
							<li><a class="nth-1st" href="change">연수 연기/취소</a></li>
							<li><a class="on" href="result">신청 처리 결과 조회</a></li>
						</ul>
						<div class="tab-body">
							<table id="myclass-list" class="list">
								<colgroup>
									<col width="100">
									<col width="120">
									<col width="">
									<col width="120">
									<col width="120">
									<col width="130">
									<col width="120">
								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="item-type">신청 구분</th>
										<th scope="col" class="item-course">연수 영역</th>
										<th scope="col" class="item-title">연수 과정명</th>
										<th scope="col" class="item-notation">기수</th>
										<th scope="col" class="item-date">연수 기간</th>
										<th scope="col" class="item-state">상태</th>
										<th scope="col" class="item-state">비고</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${!empty list }">
										<c:forEach var="item" items="${list }" varStatus="status">
											<tr <c:if test="${status.index == 0 }"> class="nth-1st" </c:if>>
												<td class="item-type">
													<c:if test="${item.CHANGE_STATE ne null}">변경 신청</c:if>
													<c:if test="${item.DELAY_STATE ne null}">연기 신청</c:if>
													<c:if test="${item.CANCEL_STATE ne null}">취소 신청</c:if>
												</td>
												<td class="item-course">${item.COURSE_CODE_NAME }</td>
												<td class="item-title">${item.NAME }</td>
												<td class="item-notation">${item.CARDINAL_NAME }</td>
												<td class="item-date">${item.LEARN_START_DATE } ~ ${item.LEARN_END_DATE }</td>
												<td class="item-state">
													<c:if test="${item.CHANGE_STATE ne null }">
														<c:if test="${item.CHANGE_STATE eq 1 }">접수 처리 중</c:if>
														<c:if test="${item.CHANGE_STATE eq 2 }">변경완료</c:if>
														<c:if test="${item.CHANGE_STATE eq 3 }">변경불가</c:if>
													</c:if>
													<c:if test="${item.DELAY_STATE ne null }">
														<c:if test="${item.DELAY_STATE eq 1 }">접수 처리 중</c:if>
														<c:if test="${item.DELAY_STATE eq 2 }">연기 완료</c:if>
														<c:if test="${item.DELAY_STATE eq 3 }">연기 불가</c:if>
													</c:if>
													<c:if test="${item.CANCEL_STATE ne null }">
														<c:if test="${item.CANCEL_STATE eq 1 }">접수 처리 중</c:if>
														<c:if test="${item.CANCEL_STATE eq 2 }">취소 완료</c:if>
														<c:if test="${item.CANCEL_STATE eq 3 }">취소 불가</c:if>
													</c:if>
												</td>
												<td class="item-state">-</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty list }">
										<tr class="nth-1st">
											<td colspan=7>조회된 연수과정이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
							<div class="list-bottom">
								<ul id="pagination"></ul>
							</div>
						</div><!--//.tab-body-->
					</div><!--.tab-group-->
				</div><!--//.sub-body-->
			</div><!--//.body-->
	<!--// 1.3. 본문 -->