<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<title>글로벌 엔지니어 양성</title>
<style>
a:link, a:visited {text-decoration: none;}
 
.board_list {width:100%;border-top:2px solid #252525;border-bottom:1px solid #ccc}
.board_list thead th:first-child{background-image:none}
.board_list thead th {border-bottom:1px solid #ccc;padding:12px 0 13px 0;color:#3b3a3a;vertical-align:middle}
.board_list tbody td {border-top:1px solid #ccc;padding:10px 0;text-align:center;vertical-align:middle}
.board_list tbody tr:first-child td {border:none}
.board_list tbody td.title {text-align:left; padding-left:20px}
.board_list tbody td a {display:inline-block}
 
 
.board_view {width:80%;margin:auto; border-top:2px solid #252525;border-bottom:1px solid #ccc}
.board_view tbody th {text-align:left;background:#D8D8D8;color:#3b3a3a}
.board_view tbody th.list_tit {font-size:13px;color:#000;letter-spacing:0.1px}
.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {border-bottom:none}
.board_view tbody th, .board_view tbody td {padding:15px 0 16px 16px;border-bottom:1px solid #ccc}
.board_view tbody td.view_text {border-top:1px solid #ccc; border-bottom:1px solid #ccc;padding-top:10px; padding-bottom:10px; padding-left:0px;}
.board_view tbody th.th_file {padding:0 0 0 15px; vertical-align:middle}
 
.wdp_90 {width:90%}

.boardManagerDiv{margin-top:20px; margin-right:10.1%;margin-bottom:6%; float:right;}
.crc_submit{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
#tolist{color:white;background-color:#333;}
.page_title,.page_sub_title{margin-left:10%; margin-top:20px;}

#view_text_div{width:100%;}
</style>
<script type="text/javascript">
$(function(){
	//수정하기
	$("#faqUpdateBtn").on("click",function(){
		$("#faqHiddenForm").submit();
	});
	//목록으로
	$("#tolist").on("click",function(){
		$("#faqHiddenManagerForm").submit();
	});
})

var myApp = angular.module('myapp', []);

myApp.directive('code', [ '$http', function($http) {
	return {
		restrict : "E",
		replace : true,
		scope : {
			value : '@'
		},
		controller : function($scope, $element, $attrs) {
			$http({
				method : 'POST',
				url : '/codeconverter',
				responseType : 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
				$scope.filterParams = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
		},
		template : "<span>{{filterParams}}</span>"
	}
} ]);

</script>
<style type="text/css">
.boardImage{
	width: 300px;
}
</style>
</head>
<body ng-app="myapp">

	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>FAQ 상담 게시판 관리 페이지</h2>
		<h5>FAQ 상담 게시판 관리 페이지&nbsp;&nbsp;&gt;&nbsp;&nbsp;제목: ${faqConsultingContents.consulting_ins_id}&nbsp;&nbsp;&gt;&nbsp;&nbsp;게시글 상세</h5>
	</div>
	<table class="board_view">
		<colgroup>
		<col width="15%"/>
		<col width="35%"/>
		<col width="15%"/>
		<col width="35%"/>
		</colgroup>
		<tbody>
		    <tr>
		        <th scope="row">글 번호</th>
		        <td>
		            ${contentDetail.consulting_seq }
				</td>
		</tr>
		<tr>
		    <th scope="row">작성자</th>
		    <td>${contentDetail.consulting_ins_id }</td>
			<th scope="row">작성일</th>
			<td>${contentDetail.consulting_ins_dt }</td>
		</tr>
		<tr>
		    <th scope="row">수정자</th>
		    <td>${contentDetail.consulting_udt_id }</td>
			<th scope="row">수정일</th>
			<td>${contentDetail.consulting_udt_dt }</td>
		</tr>
		<tr>	
			<th scope="row">카테고리</th>
				<td colspan="3">
					<code value="${contentDetail.consulting_tp}"></code>
				</td>
		</tr>
		<tr>
		    <th scope="row">제목</th>
		    <td colspan="3">
		        ${contentDetail.consulting_title }
		    </td>
		</tr>
		<tr>
		    <td colspan="4" class="view_text">
				<div id="view_text_div">
					${contentDetail.consulting_ct }
				</div>
		    </td>
		</tr>
		</tbody>
	</table>
		
	<div class="boardManagerDiv">
		<input type="button" class="crc_submit" id="faqUpdateBtn" value="수정하기" />
		<input type="button" class="crc_submit" id="tolist" value="목록으로" />
	</div>
	<form action="/edu/admin/faq_manager_form" id="faqHiddenManagerForm" method="get">
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
	</form>
	<form action="/edu/admin/faq_manager_update_form" id="faqHiddenForm" method="post">
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="consulting_udt_id" id="consulting_udt_id" value="${faqConsultingContents.consulting_udt_id}"/>
		<input type="hidden" name="consulting_tp" value="${faqConsultingContents.consulting_tp }" />
		<input type="hidden" name="consulting_seq" value="${contentDetail.consulting_seq }" />
	</form>
</body>
</html>