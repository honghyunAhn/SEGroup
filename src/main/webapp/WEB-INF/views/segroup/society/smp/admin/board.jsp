<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../import.jsp" flush="true" />
<title>board</title>
<script>
	function ilist(page) {
		location.href = "${path}/smp/user/board.do?curPage=" + page + "&searchOption=${map.searchOption}" + "&keyword=${map.keyword}"+"&gisu_seq=${gisu_seq}";
	}

	function goBoardDetail(seq) {
		location.href = "${path}/smp/admin/board_detail.do?seq=" + seq;
	}

	function searchList() {
		location.href = "${path}/smp/admin/board.do?curPage=" + page + "&searchOption=${map.searchOption}" + "&keyword=${map.keyword}"+"&gisu_seq=${gisu_seq}";
	}

	function mySelection() {
		$('input[id="searchOption"]').val(document.getElementById("mySelect").value);
	}

	
	function search() {
		var keyword = document.getElementById("keyword").value;
		
		var searchOption = document.getElementById("searchOption").value;
		
		location.href = "${path}/smp/admin/board.do?searchOption=" + searchOption + "&keyword=" + keyword + "&gisu_seq=${gisu_seq}";
	}

	function show(){
		$("#myModal").modal('show');
		
		//라디오버튼 초기값 설정
		$("input:radio[value='${boardGroup.board_icon_pd}']").prop("checked", true);
		
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
		
		$("#keyword").keydown(function(key) {
	         if (key.keyCode == 13) {// 엔터
	            search();
	         }
	      });
	})
	
	function modal_submit(){
		alert('모달클릭');
		var board_icon_pd = $('input[name="board_icon_pd"]:checked').val();
		var board_seq = ${boardGroup.board_seq};
		//var url = '${path}';
		//url += 'smp/admin/update_board_pd'
		$.ajax({
			url: '/smp/admin/update_board_pd'
			,type: 'GET'
			,data: {board_icon_pd : board_icon_pd, board_seq : board_seq}
			,dataType: 'json'
			,success: function(ob){
				alert('성공');
				$('#myModal').modal('hide');
				location.reload(true);
			}
			,error: function(){
				alert('실패');
			}
		})
		
		
		$('#myModal').modal('hide');
	}
	
</script>

</head>
<body id="myBody">
	<%@include file="adminmenu.jsp"%>
	
	<!-- 현재 날짜 -->
	<!-- date 타입 -->
	<jsp:useBean id="now" class="java.util.Date" />	
	<!-- num 타입(사칙연산 가능) -->
	<fmt:parseNumber var="strNow" value="${now.time / (1000*60*60*24)}" integerOnly="true" />
	
	<div class="page_title">
		<h2>${gisu_num} 게시판</h2>
	</div>
	
	<div id="custom_div" class="custom_div">
		<table class="search_box">
			<tr>
				<th>검색조건 선택</th>
				<td>
					<select id="searchOption" class="searchSelect">
						<option value="title">제목</option>
						<option value="name">글쓴이</option>
					</select>
				</td>
				<td>
					<input type="text" id="keyword">
				</td>
				<td class="td_search" colspan="2">
					<button type="button" class="btn_search" onclick="search()">검색</button>
				</td>
			</tr>
		</table>
		
		<select id="selectGisuBoard" class="selectGroup">
			<c:forEach var="data" items="${seaCurList}">
						<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
			</c:forEach>
		</select>
		<button type="button" class="btn_search modalButton" onclick="show()">갱신 표시기간 설정</button>
		<form id="selectGisuForm" action="/smp/admin/board">
			<input type="hidden" id="gisu_seq" name="gisu_seq" value="${gisu_seq}" >
		</form>
		<table class="table">
			<thead>
				<tr>
					<th style="text-align: center;">날짜</th>
					<th style="text-align: center;">제목</th>
					<th style="text-align: center;">글쓴이</th>
					<th style="text-align: center;">조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${fn:length(mainBoardList) gt 0}">
				<c:forEach var="data" items="${mainBoardList}" varStatus="status">
					
					<!-- new, update 계산을 위한 변수들 -->
					<fmt:parseDate value="${data.board_content_udt_dt}" pattern="yyyy-MM-dd" var="udt" />
					<fmt:parseNumber var="strUdt" value="${udt.time / (1000*60*60*24)}" integerOnly="true" />
					<fmt:parseDate value="${data.board_content_ins_dt}" pattern="yyyy-MM-dd" var="ins" />
					<fmt:parseNumber var="strIns" value="${ins.time / (1000*60*60*24)}" integerOnly="true" />
					
					<tr class="smp_notice_top_imp">
						<td class="notice_icon1 text-center">${data.board_content_udt_dt}</td>
						<td style="text-align: left; padding-top: 10px; padding-bottom: 10px;">
							<a href="javascript:goBoardDetail('${data.board_content_seq}')">
								<c:out value="${data.board_content_title}" />
							</a>
							<c:if test="${strNow - strIns <= boardGroup.board_icon_pd}">
								(new)
							</c:if>
							<c:if test="${strNow - strUdt <= boardGroup.board_icon_pd}">
								(update)
							</c:if>
						</td>
						<td class="text-center"><c:out value="${data.board_content_udt_id}" /></td>
						<td class="text-center"><c:out value="${data.board_content_hit}" /></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${fn:length(boardList) gt 0}">
				<c:forEach var="data" items="${boardList}" varStatus="status">
				
					<!-- new, update 계산을 위한 변수들 -->
					<fmt:parseDate value="${data.board_content_udt_dt}" pattern="yyyy-MM-dd" var="udt" />
					<fmt:parseNumber var="strUdt" value="${udt.time / (1000*60*60*24)}" integerOnly="true" />
					<fmt:parseDate value="${data.board_content_ins_dt}" pattern="yyyy-MM-dd" var="ins" />
					<fmt:parseNumber var="strIns" value="${ins.time / (1000*60*60*24)}" integerOnly="true" />
					
					<tr class="smp_notice_top">
						<td class="text-center">${data.board_content_udt_dt}</td>
						<td style="text-align: left; padding-top: 10px; padding-bottom: 10px;">
							<a href="javascript:goBoardDetail('${data.board_content_seq}')">
								<c:out value="${data.board_content_title}" />
							</a>
							<!-- (new), (update) 띄우는 코드 -->					
							<c:if test="${strNow - strIns <= boardGroup.board_icon_pd}">
								(new)
							</c:if>
							<c:if test="${strNow - strUdt <= boardGroup.board_icon_pd}">
								(update)
							</c:if>
						</td>
						<td class="text-center"><c:out value="${data.board_content_udt_id}" /></td>
						<td class="text-center"><c:out value="${data.board_content_hit}" /></td>
					</tr>
				</c:forEach>
			</c:if>
			</tbody>
		</table>
		<div class="insertDiv">
			<input type="button" id="boardInsertBtn" class="insertBtn" value="등록하기">
		</div>
	</div>
	
	<div class="pagination_wrap">
		<div class="pagination_con">
		<span id="page"style="display: inline; margin:auto; display:table; ">
			<h4>
				<ul>
					<li>
						<ol>
						<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
						<c:if test="${map.navi.currentPage > 1}">
							<li><input type="button" onclick="javascript:ilist('1')" name="" value="<<"></li>
						</c:if>
						
						<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
						<c:if test="${map.navi.currentPage > 1}">
							<li><input type="button" onclick="javascript:ilist('${map.navi.currentPage-1}')" name="" value="<"></li>
						</c:if>
						
						<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
						<c:forEach var="num" begin="${map.navi.startPageGroup}" end="${map.navi.endPageGroup}">
							<!-- **현재페이지이면 하이퍼링크 제거 -->
							<c:choose>
								<c:when test="${num == map.navi.currentPage}">
									<li><input type="button" style="color: red"name="" value="${num}"></li>
								</c:when>
								<c:otherwise>
									<li><input type="button" onclick="javascript:ilist('${num}','')" name="" value="${num}"></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
						<c:if test="${map.navi.currentPage < map.navi.endPageGroup}">
							<li><input type="button" onclick="javascript:ilist('${map.navi.currentPage+1}')" name="" value=">"></li>
						</c:if>
						
						<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
						<c:if test="${map.navi.currentPage < map.navi.endPageGroup}">
							<li><input type="button" onclick="javascript:ilist('${map.navi.endPageGroup}')" name="" value=">>"></li>
						</c:if>
						</ol>
					</li>
				</ul>
			</h4>
		</span>
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
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog" id="modal_dialog">
			<!-- Modal content-->
			<div class="modal-content" id="modal_content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h3 class="modal-title text-center" id="title">갱신 표시 기간 설정</h3>
				</div>
				<div class="modal-body" id="modal_body" style="margin: 10 auto;">
					<div class="text-center">
						<h4>수정일 기준으로 표시 기간을 정하실 수 있습니다.</h4>
					</div>
					<div>
						<table class="table selectGroup">
							<tr>
								<td>
									<input type="radio" name="board_icon_pd" value="1" checked>
									수정일 기준 +1일까지
								</td>
								<td>
									<input type="radio" name="board_icon_pd" value="2">
									수정일 기준 +2일까지
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="board_icon_pd" value="3">
									수정일 기준 +3일까지
								</td>
								<td>
									<input type="radio" name="board_icon_pd" value="4">
									수정일 기준 +4일까지
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="board_icon_pd" value="5">
									수정일 기준 +5일까지
								</td>
								<td>
									<input type="radio" name="board_icon_pd" value="7">
									수정일 기준 +7일까지
								</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="board_icon_pd" value="10">
									수정일 기준 +10일까지
								</td>
								<td>
									<input type="radio" name="board_icon_pd" value="15">
									수정일 기준 +15일까지
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modalBtnSave" onclick="javascript:modal_submit()">저장</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>