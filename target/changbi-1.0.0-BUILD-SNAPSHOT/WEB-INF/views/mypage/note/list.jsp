<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<script type="text/javascript">
$(document).ready(function(){
	var totalPages = ${searchVo.totalPages};//전체 페이지
    var visiblePages = ${searchVo.visiblePages};//리스트 보여줄 페이지
    var startPage = ${searchVo.startPage};//현재 페이지

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
	            $('#startPage').val(page);
	            $("#searchForm").submit();
	        }
    	});
 	};

	$("#searchBtn").click(function(event){
 		$("#searchForm").submit();
 	});

	$("#deleteBtn").click(function(event){
 		if ($('input[name="ids"]:checked').length < 1) {
 			alert('선택된 항목이 없습니다.');
 			return;
 		}

 		if (!confirm('정말 삭제하시겠습니까?')) return;

 		$("#deleteForm").submit();
 	});

	// 전체 선택/전체 해제 처리
	$(".chkAll").click(function() {
		$("input[name='ids']").prop("checked", $(this).data('checked')==='Y');
	});
});


function goDetail(id) {
	$('#detailForm input[name="id"]').val(id);
	$('#detailForm').submit();

}
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a class="nth-last" href="#">쪽지함</a>
		</p>
		<h2 class="sub-title">쪽지함 </h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="list-top">
			<form id="searchForm" class="body-search" method="post">
				<select id="searchbox" name="searchCondition">
					<option value="TC" ${(empty searchVo.searchCondition or searchVo.searchCondition == 'TC') ? 'selected':''}>제목+내용</option>
					<option value="T" ${searchVo.searchCondition == 'T' ? 'selected':''}>제목</option>
					<option value="C" ${searchVo.searchCondition == 'C' ? 'selected':''}>내용</option>
				</select>
				<input type="text" name="searchKeyword" value="${searchVo.searchKeyword}" placeholder="검색어를 입력하세요.">
				<button type="button" id="searchBtn"><span class="sr-only">검색</span></button>
				<input type="hidden" id="startPage" name="startPage" value="${searchVo.startPage}">
				<input type="hidden" name="gubun" value="${searchVo.gubun}">
			</form>
		</div>
		<div class="tab-group">
			<ul class="tab-header sub x3">
				<li><a class="nth-1st <c:if test="${searchVo.gubun == 'R'}">on</c:if>" href="<c:url value="/mypage/note/received"/>">받은 쪽지함</a></li>
				<li><a class="<c:if test="${searchVo.gubun == 'S'}">on</c:if>" href="<c:url value="/mypage/note/sent"/>">보낸 쪽지함</a></li>
				<li><a href="<c:url value="/mypage/note/form"/>">쪽지 쓰기</a></li>
			</ul>
			<div class="tab-body">
				<form id="deleteForm" method="post" action="<c:url value="/mypage/note/delete"/>">
				<input type="hidden" name="gubun" value="${searchVo.gubun}">
				<input type="hidden" name="ids" value="${searchVo.id}">
				<table class="list" id="list-doc">
				<colgroup>
					<col width="100">
					<col width="150">
					<col width="00">
					<col width="150">
					<col width="100">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="item-check">선택</th>
						<c:if test="${searchVo.gubun == 'R' }"><th scope="col" class="item-person">보낸 사람</th></c:if>
						<c:if test="${searchVo.gubun == 'S' }"><th scope="col" class="item-person">받는 사람</th></c:if>
						<th scope="col" class="item-title">제목</th>
						<th scope="col" class="item-date">날짜</th>
						<th scope="col" class="item-state">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${noteList }">
					<tr class="nth-1st"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
						<td class="item-check"><input type="checkbox" name="ids" value="${item.ID }"></td>
						<c:if test="${searchVo.gubun == 'R' }"><td class="item-person"><c:out value="${item.FROM_USER_NAME }"/></td></c:if>
						<c:if test="${searchVo.gubun == 'S' }"><td class="item-person"><c:out value="${item.TO_USER_NAME }"/></td></c:if>
						<td class="item-title"><a href="javascript:goDetail('${item.ID }')"><c:out value="${item.TITLE }"/></a></td>
						<td class="item-date"><c:out value="${item.SEND_DATE_FORMAT1 }"/></td>
						<td class="item-state"><c:out value="${item.PROC_NAME }"/></td>
					</tr>
					</c:forEach>
				<!-- ITEM 반복 START-->
				<!--//ITEM 반복 END-->
					</tbody>
				</table>
		 		<c:if test="${empty noteList}">
				<div class="alignC" style="padding:10px">쪽지가 없습니다.</div>
		 		</c:if>
				</form>

				<div class="list-bottom">
			 		<ul id="pagination"></ul>
					<div class="btnSet">
						<a href="#" class="btn float_left primary chkAll" data-checked="Y">전체 선택</a>
						<a href="#" class="btn float_left line chkAll" data-checked="N">선택 해제</a>
						<a href="#" class="btn float_right danger" id="deleteBtn">삭제</a>
					</div>
				</div>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->

<form id="detailForm" method="post" action='<c:url value="/mypage/note/view"/>'>
<input type="hidden" id="startPage" name="startPage" value="${searchVo.startPage}">
<input type="hidden" name="gubun" value="${searchVo.gubun}">
<input type="hidden" name="searchCondition" value="${searchVo.searchCondition}">
<input type="hidden" name="searchKeyword" value="${searchVo.searchKeyword}">
<input type="hidden" name="id">
</form>