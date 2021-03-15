<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<script src="<c:url value="/resources/segroup/ckeditor/ckeditor.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
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
.board_view tbody td.view_text {border-top:1px solid #ccc; border-bottom:1px solid #ccc; padding-top:10px; padding-bottom:10px; padding-left:0px;}
.board_view tbody th.th_file {padding:0 0 0 15px; vertical-align:middle}
 
.wdp_90 {width:90%}

#board_content_title{width:95%;}
#board_content_ct{width:100%;height:100%;}
.boardManagerDiv{margin-top:20px; margin-right:8%; margin-bottom:6%;width:20%; float:right;}
#boardUpdateBtn,#boardManagerBtn{display:inline-block; width: 45%; height: 40px; font-size: 18.67px; color: #fff; border: 0; background: #212121; border-radius: 7px; outline: none; cursor: pointer;}
.page_title,.page_sub_title{margin-left:10%; margin-top:20px;}
</style>
<script type="text/javascript">
$(function(){
	CKEDITOR.replace( 'board_content_ct',{
		filebrowserUploadUrl: '/board/imageUpload',
	});
	
	//목록으로
	$("#boardManagerBtn").on("click",function(){
		$("#boardHiddenManagerForm").submit();
	});
})
function gotolist() {
    $("#boardHiddenManagerForm").submit();
}
	var myApp = angular.module('myapp', []);
	myApp.controller('BoardController', ['$scope', function($scope){
		
		var boardJson = '${fileList }';
		$scope.boardFile = JSON.parse(boardJson);
		
		$scope.file_change = function(file){
			var val = file.files[0].name;
			var size = file.files[0].size;
			
			if(val == ""){
			    file.value = '';
	       		return;
			}
			if(!fileSizeCheck(size)){
				file.value = '';
				alert("파일 사이즈는 10MB 까지 입니다.");
				return;
			}
		}
		
	}]);
	
	function fileSizeCheck(size){
		//10MB
		var maxSize = 10485760;
		var fileSize = Math.round(size);
		if(fileSize > maxSize){
			return false;
		}
		return true;
	}
	
	function formCheck(){
		var title = $("#board_content_title").val();
		
		if(title.length == 0){
			alert("제목을 입력해 주세요.");
			return false;
		}
		var check = confirm("수정하시겠습니까?");
		if(!check){
			return false;
		}
		return true;
	}
</script>
<style type="text/css">
.x_icon{
	width: 20px;
}
</style>
</head>
<body ng-app="myapp" ng-controller="BoardController">
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>게시판 관리 페이지</h2>
        <h5>
            <a href="/edu/admin/board_manager_form#${search_division},${search_type}">게시판 관리 페이지</a>
            &nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="#none" onclick="gotolist()">${boardGroup.board_nm}</a>
            &nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="#" onclick="history.go(0)">게시글 수정</a>
        </h5>
	</div>
	<form action="/edu/admin/board_contents_update" method="post"  enctype="multipart/form-data" onsubmit="return formCheck();">
		<table class="board_view">
			<colgroup>
			<col width="15%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">조회수</th>
					<td>${contentDetail.board_content_hit }</td>
					<th scope="row">작성자</th>
				    <td>${contentDetail.board_content_nm }</td>
				</tr>
				<tr>
				    <th scope="row">첨부파일</th>
				    <td colspan="3">
				    	<div ng-repeat="i in [1,2,3]">
							<div ng-switch="!!boardFile[{{$index}}].board_file_origin">
								<div ng-switch-when="true">
									<input type="hidden" name="boardFileList[{{$index}}].board_file_origin" value="{{boardFile[$index].board_file_origin}}">
									<input type="hidden" name="boardFileList[{{$index}}].board_file_saved" value="{{boardFile[$index].board_file_saved}}">
									<a ng-href="/file_download?origin={{boardFile[$index].board_file_origin}}&saved={{boardFile[$index].board_file_saved}}&path=${path }">
										{{boardFile[$index].board_file_origin}}
									</a>
									<img class="x_icon" ng-click="boardFile[$index].board_file_origin=false" src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />" alt=""/>
								</div>
								<div ng-switch-default>
									<input type="hidden" name="boardFileList[{{$index}}].board_file_saved" value="{{boardFile[$index].board_file_saved}}">
									<input type="file" class="board_files"  name="boardFileList[{{$index}}].board_file" onchange="angular.element(this).scope().file_change(this)">
								</div>
							</div>
						</div>
						<input type="hidden" name="boardFilePath" value="${path }">
						<input type="hidden" name="board_content_seq" value="${contentDetail.board_content_seq }">
				    </td>
				</tr>
				<tr>
				    <th scope="row">제목</th>
				    <td colspan="3">
				        <input type="text" name="board_content_title" id="board_content_title" value="${contentDetail.board_content_title }"/>
				    </td>
				</tr>
				<tr>
				    <td colspan="4" class="view_text">
						<textarea id="board_content_ct" name="board_content_ct" rows="40" cols="60">${contentDetail.board_content_ct } </textarea>
				    </td>
				</tr>
			</tbody>
		</table>
		<div class="boardManagerDiv">
			<input type="submit" id="boardUpdateBtn" value="수정하기" />
			<input type="button" id="boardManagerBtn" value="목록으로" />
			<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
			<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		</div>
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
		<input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}"/>
	</form>
	<form action="/edu/admin/board_contents_search" id="boardHiddenManagerForm" method="post">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />
        <input type="hidden" name="board_gb" id="board_gb" value="${boardGroup.board_gb}"/>
        <input type="hidden" name="board_tp" id="board_tp" value="${boardGroup.board_tp}"/>
		<input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}"/>
	</form>
	<%-- <form action="/edu/admin/board_contents_update" method="post"  enctype="multipart/form-data" onsubmit="return formCheck();">
		제목 : <input type="text" name="board_content_title" id="board_content_title" value="${contentDetail.board_content_title }"/> <br/>
		내용<br/>
		<textarea id="board_content_ct" name="board_content_ct" rows="40" cols="60">${contentDetail.board_content_ct } </textarea><br/>
		작성자 : ${contentDetail.board_content_nm } <br/>
		조회수 : ${contentDetail.board_content_hit } <br/>
		첨부파일<br/>
			<div ng-repeat="i in [1,2,3]">
				<div ng-switch="!!boardFile[{{$index}}].board_file_origin">
					<div ng-switch-when="true">
						<input type="hidden" name="boardFileList[{{$index}}].board_file_origin" value="{{boardFile[$index].board_file_origin}}">
						<input type="hidden" name="boardFileList[{{$index}}].board_file_saved" value="{{boardFile[$index].board_file_saved}}">
						<a ng-href="/file_download?origin=${data.board_file_origin }&saved=${data.board_file_saved }&path=${path }">
							{{boardFile[$index].board_file_origin}}
						</a>
						<img class="x_icon" ng-click="boardFile[$index].board_file_origin=false" src="<c:url value="/resources/segroup/society/edu/image/sub/x_icon.png" />" alt=""/>
					</div>
					<div ng-switch-default>
						<input type="hidden" name="boardFileList[{{$index}}].board_file_saved" value="{{boardFile[$index].board_file_saved}}">
						<input type="file" class="board_files"  name="boardFileList[{{$index}}].board_file" onchange="angular.element(this).scope().file_change(this)">
					</div>
				</div>
			</div>
			<input type="hidden" name="boardFilePath" value="${path }">
			<input type="hidden" name="board_content_seq" value="${contentDetail.board_content_seq }">
			<input type="submit" value="수정하기">
			<input type="button" id="boardManagerBtn" value="목록으로" />
	</form> --%>
</body>
</html>