<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<!-- 페이징 관련 css 끝 -->
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/smp/css/noticeBoard.css" />">
	<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/smp/css/boardStyle.css" />">
	
<jsp:include page="../import.jsp" flush="true" />

<title>board</title>
<script type="text/javascript">
	$(function() {
		//수정하기
		$("#boardUpdateBtn").on("click", function() {
			$("#boardHiddenForm").submit();
		});
		//목록으로
		$("#boardManagerBtn").on("click", function() {
			$("#boardHiddenManagerForm").submit();
		});
		//삭제하기
		$("#boardDeleteBtn").on("click", function() {
			
			$("#boardDeleteForm").submit();
			
		});
		
	})
	var myApp = angular.module('myapp', []);
	myApp.controller('BoardController', [ '$scope', function($scope) {

		var boardJson = '${fileList }';
		$scope.boardFile = JSON.parse(boardJson);

		$scope.file_change = function(file) {
			var val = file.files[0].name;
			var size = file.files[0].size;

			if (val == "") {
				file.value = '';
				return;
			}
			if (!fileSizeCheck(size)) {
				file.value = '';
				alert("파일 사이즈는 10MB 까지 입니다.");
				return;
			}
		}

	} ]);

	function fileSizeCheck(size) {
		//10MB
		var maxSize = 10485760;
		var fileSize = Math.round(size);
		if (fileSize > maxSize) {
			return false;
		}
		return true;
	}
	function deleteCheck() {
		var check = confirm("삭제하시겠습니까?");
		if (!check) {
			return false;
		}
		return true;
	}
</script>
<style type="text/css">
p {word-break:pre-wrap;}
</style>
</head>
<body id="myBody" ng-app="myapp" ng-controller="BoardController">
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
					<!-- ********************************************************************************************************** -->
					<div class="page_title">
						<h2>게시물 상세</h2>
					</div>
					<table class="board_view">
						<colgroup>
							<col width="15%" />
							<col width="35%" />
							<col width="15%" />
							<col width="35%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">글 번호</th>
								<td class="view_text_left">${contentDetail.board_content_seq}</td>
								<th scope="row">조회수</th>
								<td class="view_text_left">${contentDetail.board_content_hit }</td>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td class="view_text_left">${contentDetail.board_content_nm }</td>
								<th scope="row">수정일</th>
								<td class="view_text_left">${contentDetail.board_content_udt_dt}</td>
							</tr>
							<tr>
									<th scope="row">첨부파일</th>
									<td colspan="3" class="view_text_file">
										<div ng-repeat="i in [1,2,3]">
											<div ng-switch="!!boardFile[{{$index}}].board_file_origin">
												<div ng-switch-when="true">
													<input type="hidden"name="boardFileList[{{$index}}].board_file_origin"value="{{boardFile[$index].board_file_origin}}"> 
														<input type="hidden"name="boardFileList[{{$index}}].board_file_saved"value="{{boardFile[$index].board_file_saved}}">
														 <a	ng-href="/file_download?origin={{boardFile[$index].board_file_origin}}&saved={{boardFile[$index].board_file_saved}}&path=${path }">
														{{boardFile[$index].board_file_origin}} </a> 
												</div>
												
											</div>
										</div> <input type="hidden" name="boardFilePath" value="${path }">
										<input type="hidden" name="board_content_seq"
										value="${contentDetail.board_content_seq }">
									</td>
								</tr>
							<tr>
								<th scope="row">제목</th>
								<td colspan="3" class="view_text_left">${contentDetail.board_content_title }</td>
							</tr>
							<tr>
								<th scope="row">게시글</th>
								<td colspan="3" class="view_text_content">
									<div id="view_text_div">${contentDetail.board_content_ct }
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					
					
					<div class="boardManagerDiv">
							<c:if test="${Admin eq 'Admin'}">
								<input type="button" id="boardUpdateBtn" value="수정하기" />
								<input type="button" id="boardDeleteBtn" value="삭제하기" />	
							</c:if>
						 
						<input type="button" id="boardManagerBtn" value="목록으로" />
					</div>
					<form action="/smp/user/board"	id="boardHiddenManagerForm" method="get">
						<input type="hidden" name="search_division" id="search_division"value="${search_division}" /> 
						<input type="hidden"name="search_type" id="search_type" value="${search_type}" /> 
						<input	type="hidden" name="board_seq" id="board_seq"	value="${contentDetail.board_seq}" /> 
						<input type="hidden"name="board_nm" id="board_nm" value="${boardGroup.board_nm}" />
						<input type="hidden" id="gisu_seq" name="gisu_seq" value="${gisu_seq}" >					
					</form>
					<form action="/smp/admin/board_update_form"	id="boardHiddenForm" method="post">
						<input type="hidden" name="search_division" id="search_division" value="${search_division}" /> 
						<input type="hidden"name="search_type" id="search_type" value="${search_type}" /> 
						<input type="hidden" name="board_nm" id="board_nm"	value="${boardGroup.board_nm}" /> 
						<input type="hidden"name="board_gb" value="${boardGroup.board_gb }" /> 
						<input	type="hidden" name="board_tp" value="${boardGroup.board_tp }" />
						<input type="hidden" name="board_content_seq"value="${contentDetail.board_content_seq }" />
						<input type="hidden" id="gisu_seq" name="gisu_seq" value="${gisu_seq}" >
					</form>
					<form action="/smp/admin/board_delete_form"
						id="boardDeleteForm" method="post" onsubmit="return deleteCheck();">
						<input type="hidden" name="board_content_seq" value="${contentDetail.board_content_seq }" />
					</form>
					<!-- ************************************************************************************** -->

				</div>
			</div>
		</div>
	</div>
</body>
</html>