<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="/resources/js/jsrender.js"></script><!-- template lib  -->
<script type="text/javascript">
$(document).ready(function() {
	$('#layerSearchSchool .cl-popup-closer').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});

	$('#schoolSearchForm input[name="searchKeyword"]').keydown(function(event) {
	    if (event.keyCode === 13) {
	    	searchSchool(1);
	    	return false;
	    }

	});

	$('#schoolSearchForm input[name="searchKeyword"]').focus();

	// 검색어가 주어졌을 때 검색
	var keyword = $('#schoolSearchForm input[name="searchKeyword"]').val();
	if (!isEmpty(keyword)) {
		searchSchool(1);
	}
});

function searchSchool(page) {
	page = page?page:1;
	var searchKeyword = $.trim($('#schoolSearchForm input[name="searchKeyword"]').val());

	if(searchKeyword.length < 2) {
		alert('검색어를 두자 이상 입력하여 주십시오.');
		return;
	}

	$('#schoolSearchForm input[name="searchKeyword"]').val(searchKeyword);	// trim된 keyword
	$('#schoolSearchForm input[name="startPage"]').val(page);
	$.getJSON('<c:url value="/common/ajaxSchoolSearchList"/>', $('#schoolSearchForm').serialize(), function(data) {
		if (typeof(data.searchVo) == 'undefined' || typeof(data.schoolList) == 'undefined') {
			$('#schoolSearchPagination').twbsPagination('destroy');
			return;
		}
		// list display
		if (data.schoolList.length > 0) {
			$("#schoolSearchList").html($("#schoolSearchListTmpl").render(data.schoolList));
		} else {
			$("#schoolSearchList").html('<tr><td colspan="4">조회된 내역이 없습니다.</td></tr>');
		}


		// paging
		var searchVo = data.searchVo;;
		var totalPages = searchVo.totalPages;
		var currentPage = $('#schoolSearchPagination').twbsPagination('getCurrentPage');
		$('#schoolSearchPagination').twbsPagination('destroy');
		if (totalPages > 0) {
			$('#schoolSearchPagination').twbsPagination($.extend({}, {
		        totalPages: 1,
		        visiblePages: 5,
		        startPage: 1,
		        first : "",
		        prev : "«",
		        next : "»",
		        last : "",
		        initiateStartPageClick : false,
		        onPageClick: function (event, page) {
		        	searchSchool(page);
		        }
		   	}, {
				startPage: currentPage > totalPages ? totalPages : currentPage,
				totalPages: totalPages
			}));
		}
	});
}

// 학교선택
function selectSchool(schoolId) {
	var $tr = $('#school'+schoolId);
	onSearchSchool({
		'name': $tr.data('name'),
		'post_code': ''+$tr.data('postcode'),
		'addr1': $tr.data('addr1'),
		'addr2': $tr.data('addr2'),
		'region_code': ''+$tr.data('regioncode'),
		'jurisdiction': ''+$tr.data('jurisdiction'),
		's_type': ''+$tr.data('stype'),
		'e_type': ''+$tr.data('etype')
	});
	$(".cl-popup-overlay").removeClass("on");
}
</script>
<!-- 학교찾기 템플릿 -->
<script id="schoolSearchListTmpl" type="text/x-jsrender">
<tr id="school{{:ID}}" data-stype="{{:S_TYPE}}" data-etype="{{:E_TYPE}}" data-name="{{:NAME}}" data-regioncode="{{:REGION_CODE}}" data-jurisdiction="{{:JURISDICTION}}" data-postcode="{{:POST_CODE}}" data-addr1="{{:ADDR1}}" data-addr2="{{:ADDR2}}">
	<td class="item-title"><strong>{{:NAME}}</strong></td>
	<td>{{:REGION_NAME}}</td>
	<td>{{:JURISDICTION}}</td>
	<td><button class="btn primary" onclick="selectSchool({{:ID}})">선택</button></td>
</tr>
</script>

<!--// 학교찾기 팝업 -->
<div class="cl-popup-overlay" id="layerSearchSchool">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:700px; margin-left:-350px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">학교 및 기관 찾기</h3>
			</div>
			<div class="popup-body">
				<form class="group" id="schoolSearchForm" name="schoolSearchForm">
					<input type="hidden" name="startPage" value="1">
					<div class="singleRow alignC">
					<input type="text" name="searchKeyword" class="width60" placeholder="학교 및 기관 성명을 입력해 주세요" value="${param.searchKeyword }">
					<button type="button" class="btn primary w4em" onclick="searchSchool(1)">검색</button>
					<p>예) 안양초등학교 - "안양", "안양초", "안양초등학교"</p>
					</div>
				</form>
				<div id="searchResult-wrap" class="group">
					<ul class="check-list">
						<li>
							<strong class="label w15em">학교 및 기관을 선택하세요.</strong>
								<span class="floatR">해당 학교명이나 기관명이 없을 경우 <strong class="primary">1833-7247</strong>로 연락하시기 바랍니다.</span>
						</li>
					</ul>
					<table class="list">
						<thead>
							<tr>
								<th class="item-title" scope="col">학교 기관명</th>
								<th scope="col">시도 교육청</th>
								<th scope="col">교육 지원청</th>
								<th scope="col">선택</th>
							</tr>
						</thead>
						<tbody id="schoolSearchList">
							<tr><td colspan="4">검색어를 입력하여 주십시오.</td></tr>
						</tbody>
					</table>
					<div class="list-bottom">
						<div class="pagination" id="schoolSearchPagination"></div>
					</div>
				</div><!--//.section-->
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 2.학교찾기팝업 END -->
