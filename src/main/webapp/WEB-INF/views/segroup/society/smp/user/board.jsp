<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<!-- 페이징관련 css 시작 -->
<!-- bxSlider CSS file -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/smp/css/noticeBoard.css" />">
<!-- 페이징 관련 css 끝 -->

<jsp:include page="../import.jsp" flush="true" />

<title>board</title>
<script>
	function ilist(page) {
		location.href = "${path}/smp/user/board.do?curPage=" + page + "&searchOption=${map.searchOption}" + "&keyword=${map.keyword}"+"&gisu_seq=${gisu_seq}";
	}

	function goBoardDetail(seq) {
		location.href = "${path}/smp/user/board_detail.do?seq=" + seq;
	}

	function searchList() {
		location.href = "${path}/smp/user/board.do?curPage=" + page + "&searchOption=${map.searchOption}" + "&keyword=${map.keyword}"+"&gisu_seq=${gisu_seq}";
	}

	function mySelection() {
		$('input[id="searchOption"]').val(document.getElementById("mySelect").value);
	}


	function search() {
		var searchword = document.getElementById("searchword").value;
		var searchoption = document.getElementById("searchOption").value;
		if (searchoption == "") {
			searchoption = "contents";
		}

		location.href = "${path}/smp/user/board.do?searchOption=" + searchoption + "&keyword=" + searchword+"&gisu_seq=${gisu_seq}";
	}

	$(function() {
		
		$('select[id="selectGisuBoard"]').val("${gisu_seq}");

		$("#boardInsertBtn").on("click", function() {
			$("#boardInsertForm").submit();
		});
		
		$('select[id="selectGisuBoard"]').on('change', function() {
			$('input[id="gisu_seq"]').val(document.getElementById("selectGisuBoard").value);
			$("#selectGisuForm").submit();
		});
		
		$("#searchword").keydown(function(key) {
	         if (key.keyCode == 13) {// 엔터
	            search();
	         }
	      });
	})
</script>

</head>
<body id="myBody">
	<div id="page">
		<div class="page-inner">
		<c:if test="${Admin eq 'Admin'}">
			<%@include file="../admin/adminmenu.jsp"%>
		</c:if>
		<c:if test="${User eq 'User'}">
			<%@include file="usermenu.jsp"%>
		</c:if>
			<div class="gtco-section border-bottom">
				<div class="gtco-container">
					<div class="page_title">
						<h2>${gisu_num} 게시판</h2>
					</div>

					<div class="sub_m_contents">
						<div class="notice_wrap">
						<c:if test="${Admin eq 'Admin'}">
							<select id="selectGisuBoard">
									<c:forEach var="data" items="${seaCurList}">
												<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
									</c:forEach>
							</select>
							</c:if>
							<form id="selectGisuForm" action="/smp/user/board">
								<input type="hidden" id="gisu_seq" name="gisu_seq" value="${gisu_seq}" >

							</form>
							<table class="table">
								<tr>
									<th style="text-align: center;">날짜</th>
									<th style="text-align: center;">제목</th>
									<th style="text-align: center;">글쓴이</th>
									<th style="text-align: center;">조회수</th>
								</tr>
								<c:if test="${fn:length(mainBoardList) gt 0}">
									<c:forEach var="data" items="${mainBoardList}" varStatus="status">
										<tr class="smp_notice_top_imp">
											<td class="notice_icon1">${data.board_content_udt_dt}</td>
											<td
												style="text-align: left; padding-top: 10px; padding-bottom: 10px;"><a
												href="javascript:goBoardDetail('${data.board_content_seq}')">
													<c:out value="${data.board_content_title}" />
											</a></td>
											<td><c:out value="${data.board_content_udt_id}" /></td>
											<td><c:out value="${data.board_content_hit}" /></td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(boardList) gt 0}">
									<c:forEach var="data" items="${boardList}" varStatus="status">
										<tr class="smp_notice_top">
											<td>${data.board_content_udt_dt}</td>
											<td
												style="text-align: left; padding-top: 10px; padding-bottom: 10px;"><a
												href="javascript:goBoardDetail('${data.board_content_seq}')">
													<c:out value="${data.board_content_title}" />
											</a></td>
											<td><c:out value="${data.board_content_udt_id}" /></td>
											<td><c:out value="${data.board_content_hit}" /></td>
										</tr>
									</c:forEach>
								</c:if>
							</table>
						</div>
						<div class="pagination_wrap">
							<div class="pagination_con">
								<span id="page"
									style="display: inline; margin: auto; display: table;"><h4>
										<ul>
											<li>
												<ol>
													<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
													<c:if test="${map.navi.currentPage > 1}">
														<li><input type="button"
															onclick="javascript:ilist('1')" name="" value="&lt&lt"></li>
													</c:if>

													<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
													<c:if test="${map.navi.currentPage > 1}">
														<li><input type="button"
															onclick="javascript:ilist('${map.navi.currentPage-1}')"
															name="" value="&lt"></li>
													</c:if>

													<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->

													<c:forEach var="num" begin="${map.navi.startPageGroup}"
														end="${map.navi.endPageGroup}">
														<!-- **현재페이지이면 하이퍼링크 제거 -->

														<c:choose>
															<c:when test="${num == map.navi.currentPage}">
																<li><input type="button" style="color: red" name=""
																	value="${num}"></li>
															</c:when>
															<c:otherwise>
																<li><input type="button" onclick="ilist('${num}')"
																	name="" value="${num}"></li>
															</c:otherwise>
														</c:choose>
													</c:forEach>


													<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
													<c:if
														test="${map.navi.currentPage <= map.navi.endPageGroup}">
														<li><input type="button"
															onclick="javascript:ilist('${map.navi.currentPage+1}')"
															name="" value="&gt"></li>
													</c:if>

													<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
													<c:if
														test="${map.navi.currentPage <= map.navi.endPageGroup}">
														<li><input type="button"
															onclick="javascript:ilist('${map.navi.endPageGroup}')"
															name="" value="&gt&gt"></li>
													</c:if>
												</ol>
									</h4> </span>
							</div>
						</div>
						<div class="gal_last" style="text-align: center;">
							<div class="gal_search">
								<span style="display: inline-flex;">
								<input type="search" id="searchword"> 
								<input type="image" onclick="search()" name=""
									src="<c:url value="/resources/segroup/society/edu/image/sub/btn_searchs.png" />">
								<input type="hidden" id="searchOption" />
								</span>
							</div>
							<!-- **관리자 계정일때만 공지사항 글쓰기가 보이도록 설정 -->
							<c:if test="${Admin eq 'Admin'}">
								<input type="button" id="boardInsertBtn" value="등록하기" style="background: #000; color: #fff; width: 136px; height: 42px; border: 0; font-size: 14px; font-weight: bold;">	
							</c:if>
						</div>
					</div>

					<form action="/smp/admin/board_insert_form" method="post"id="boardInsertForm">
						<input type="hidden" name="search_division" id="search_division"value="${search_division}" /> 
						<input type="hidden" name="search_type" id="search_type" value="${search_type}" /> 
						<input type="hidden" name="board_nm" id="board_nm"	value="${boardGroup.board_nm}" /> 
						<input type="hidden" name="board_seq" value="${boardGroup.board_seq}" /> 
						<input type="hidden" name="board_gb" value="${boardGroup.board_gb}" />
						<input type="hidden" name="board_tp"value="${boardGroup.board_tp}" />
						<input type="hidden" id="gisu_seq" name="gisu_seq" value="${gisu_seq}" >
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>