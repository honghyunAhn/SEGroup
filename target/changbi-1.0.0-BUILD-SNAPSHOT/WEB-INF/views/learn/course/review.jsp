<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<spring:eval expression="@config.getProperty('boardPages')" var="visiblePages" scope="request"/>
<script type="text/javascript">
$(document).ready(function(){
	$("#reviewSearchBtn").click(function(event){
		searchReviewList(1);
	});

	$('#review_search').keydown(function(event) {
	    if (event.keyCode === 13) {
	    	searchReviewList(1);
	    	return false;
	    }

	});

	searchReviewList(1);
});

var reviewpagingOption = {
        totalPages: 1,
        visiblePages: ${visiblePages},
        startPage: 1,
        first : "",
        prev : "«",
        next : "»",
        last : "",
        initiateStartPageClick : false,
        onPageClick: function (evt, page) {
        	searchReviewList(page);
        }
    };

function searchReviewList(page) {
	$('#review_startPage').val(page || 1);
	$.ajax({
		url: 'review',
		type : 'POST',
		data : $('#reviewSearchForm').serialize(),
		dataType: 'json',
		success: function(data) {
			var $reviewpagination = $('#learn-review #pagination');
			var $reviewbodyTarget = $("#learn-review .list tbody");

			var tr = '';
			$reviewbodyTarget.find("tr").remove();
			var pagingParam = jQuery.parseJSON(data.pagingParam);
			var totalCnt = Number(pagingParam.totalCnt);
			var startPage = Number(pagingParam.startPage);
			if(startPage == 0) startPage = 1;
			var visiblePages = Number(pagingParam.visiblePages);
			var list = jQuery.parseJSON(data.list);
			if(list.length > 0){
				$.each(list,function(i,list){
					var seq = totalCnt - (startPage-1)*visiblePages - i;
					tr += '<tr class="nth-1st">'
						+'<td class="item-number">'+seq+'</td>'
						+'<td class="item-title"><a href="javascript:popupReview('+list.id+')"><strong>'+list.title+'</strong></a></td>'
						+'<td class="item-name">'+(isEmpty(list.user_name)?list.reg_name:(list.user_name==null?'':list.user_name))+'</td>'
						+'<td class="item-date">'+list.reg_date_format2+'</td>'
						+'<td scope="col" class="item-view_count">'+list.hits+'</td>'
						+'</tr>'
				});
				$reviewbodyTarget.append(tr);

				totalPages = pagingParam.totalPages;
				startPage = $reviewpagination.twbsPagination('getCurrentPage');
				$('#review_startPage').val(startPage);

				$reviewpagination.twbsPagination('destroy');
 	            $reviewpagination.twbsPagination($.extend({}, reviewpagingOption, {
 	                startPage: startPage,
 	                totalPages: totalPages
 	            }));
			}else{
				tr = '<tr><td colspan="5">조회된 내용이 없습니다.</td></tr>';
				$reviewbodyTarget.append(tr);
			}
		}
	});
}

// 리뷰보기(팝업)
function popupReview(id) {
	var layerId  = 'layerReviewDetail';
	if($('#'+layerId).length > 0) $('#'+layerId).remove();
	$.ajax({
		type: "POST",
		url: "<c:url value='/learn/course/layer/reviewdetail' />",
		dataType: "text",
		data: {'id': id},
		success: function(txt) {
			$(document.body).append(txt);
			popupOpen(layerId);
		}
	});
}

</script>

<div class="group" id="learn-review">
	<div class="group-header">
		<h4>연수 후기</h4>
	</div><!--//.group-header-->
	<div class="list-top">
		<form id="reviewSearchForm" method="POST" onsubmit="return false">
		<input type="hidden" id="review_startPage" name="startPage" value="1">
		<input type="hidden" name="course_id" value="${detail.ID}">
			<div class="body-search">
				<select id="review_searchbox" name="searchbox">
					<option value="tc">제목+내용</option>
					<option value="t">제목</option>
					<option value="c">내용</option>
				</select>
				<input type="text" id="review_search" name="search" placeholder="검색어를 입력하세요.">
				<button type="button" id="reviewSearchBtn"><span class="sr-only">검색</span></button>
			</div>
		</form>
	</div>
	<table id="bbs" class="list">
		<thead>
			<tr>
				<th scope="col" class="item-number">번호</th>
				<th scope="col" class="item-title">제목</th>
				<th scope="col" class="item-name">작성자</th>
				<th scope="col" class="item-date">등록일</th>
				<th scope="col" class="item-view_count">조회수</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	<div class="list-bottom">
		<ul id="pagination"> </ul>
	</div>
</div><!--//.group#learn-review-->
