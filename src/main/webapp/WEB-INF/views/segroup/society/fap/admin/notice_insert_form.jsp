<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/backgroundTransition.css" />" />
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/lightslider.css" />" />

<script src="<c:url value="/resources/segroup/ckeditor/ckeditor.js" />"></script>
<script type="text/javascript">

	$(function() {
		CKEDITOR.replace('board_content_ct', {
			filebrowserUploadUrl : '/board/imageUpload',
			enterMode: CKEDITOR.ENTER_BR,
			shiftEnterMode:  CKEDITOR.ENTER_P,
			fullPage: true,
			allowedContent:  true
		});		
	});
	
	var myApp = angular.module('myapp', []);
	
	var file_seq = 0;
	
	myApp.controller('MainController', ['$scope','$http', function($scope,$http) {
		
		// 파일 첨부 추가
		$scope.file_add = function() {
			
			var file_add_content = "<div class='common_file'>사진";
			file_add_content += "<input class='boardFileList' id='";
			file_add_content += "file_id_" + file_seq;
			file_add_content += "' type='file'";
			/* 
			file_add_content += "name = '";
			file_add_content += "boardFileList[" + file_seq + "].board_file"
			file_add_content += "'";
			 */
			file_add_content += "onchange=\"getThumbnailPrivew(this, \'avatar_info_" + file_seq + "\')\"";
			file_add_content += ">";
			file_add_content += "<br><img";
			file_add_content += "id='";
			file_add_content += "avatar_info_" + file_seq + "'>";
			file_add_content += "</div>";
			
			$("#file_div").append(file_add_content);
			file_seq++;
		}
		
		// 영상은 한개만 업로드 가능
		// 영상 첨부 추가
		$scope.video_add = function() {
			var video_length = $('.notice_video').find('.video_file').length;
			
			if(video_length == 0){
				var video_add_content = "<div class='video_file'>영상";
				video_add_content += "<input class='boardFileList' id='video'";
				video_add_content += " type='file'>";
				/* 
				video_add_content += "name = '";
				video_add_content += "boardFileList[" + file_seq + "].board_file"
				video_add_content += "'";
				 */
				video_add_content += "</div>";
				
				$("#video_div").append(video_add_content);
				file_seq++;				
			} else {
				alert("영상은 한개만 추가할 수 있습니다.");
			}
			
		}
		
		// 파일 첨부 제거
		$scope.file_remove = function(){
			var file_length = $('.notice_file').find('.common_file').length;
			
			if(file_length > 0){
				// var file_remove_id = "#file_id_" + (file_seq - 1);
				// $(file_remove_id).parent().remove();
				// file_seq--;
				$('.notice_file').find('.common_file').last().remove();
				file_seq--;
			}
			
		}
		
		// 영상 첨부 제거
		$scope.video_remove = function(){
			var video_length = $('.notice_video').find('#video').length;
			if(video_length > 0){
				$('.notice_video').find('.video_file').remove();
			}
			
		}
	
	}]);
	

	// input태그에 넣어야함
	function getThumbnailPrivew(input, targetId) {
		// 용량 체크
	}
	
	function insert_name() {
		
		var length = $('.boardFileList').length;
		
		for(var i = 0; i < length; i++){
			var name = 'boardFileList[' + i + '].board_file';
			var odd = '.boardFileList:eq(' + i + ')';
			$(odd).prop('name', name);
		}
		
		return true;
	}
	
</script>
<script type="text/javascript">
$(document).ready(function(){
	//중요도
	$(".board-content-imp").on("click",function(){		
		$(".board-content-imp").removeClass("ck");
		$(".board-content-imp").find("input:radio[name='board_content_imp']").prop("checked", false);
		$(this).addClass("ck");
		$(this).find("input:radio[name='board_content_imp']").prop("checked", true);		
	});
	
	//공개대상
	$(".fap-notice-view-target").on("click",function(){		
		$(".fap-notice-view-target").removeClass("ck");
		$(".fap-notice-view-target").find("input:radio[name='fap_notice_view_target_ck']").prop("checked", false);
		$(this).addClass("ck");
		$(this).find("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);		
	});
	
	//공지종류
	$(".fap-notice-kind").on("click",function(){		
		$(".fap-notice-kind").removeClass("ck");
		$(".fap-notice-kind").find("input:radio[name='fap_notice_kind']").prop("checked", false);
		$(this).addClass("ck");
		$(this).find("input:radio[name='fap_notice_kind']").prop("checked", true);		
	});	
	
	//메인으로
	$("#boardMainBtn").on("click", function() {
		location.href="/fap/admin/admin_main";
		
	});
	//목록으로
	$("#boardListBtn").on("click", function() {
		location.href="/fap/admin/fap_notice_management_form?board_seq=21";
	});
});

</script>
<body ng-app="myapp" ng-controller="MainController">
<%@include file="admin_menu.jsp"%> 
<form action="/fap/admin/notice_insert" method="post" enctype="multipart/form-data" onsubmit="return insert_name();">
	<input type="hidden" name="board_seq" value="${board_seq }" >
	<div class="join-wrap">
		<div id="subcontents">
		<h2>공지사항 작성</h2>
			<div class="joinBox">			
			<table class="board_view">
			<colgroup>
			<col width="15%"/>
			<col width="35%"/>
			<col width="15%"/>
			<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
				    <th scope="row"><spring:message code="fap.jobfair.main.board.title" /></th>
				    <td colspan="3" colspan="3" style="padding-top: 0px; padding-bottom: 0px;  padding-top: 0px; padding-bottom: 0px; padding-left: 15px;">
				    	<input type="text" name="board_content_title" style=" height: 30px; width: 700px;">
				    </td>
				</tr>
				<tr>
					<th scope="row">중요도</th>
					<td colspan="3">
						<span class="board-content-imp important">
							<label class="board-content-imp-label">
								<code value="A1100"></code>
							</label>
							<input type="radio" name="board_content_imp" value="A1100">주요공지&emsp;&emsp;&emsp;
						</span>
						<span class="board-content-imp normal">
							<label class="board-content-imp-label">
								<code value="A1101"></code>
							</label>
							<input type="radio" name="board_content_imp" value="A1101">일반공지
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row">공개대상</th>
					<td colspan="3">
						<span class="fap-notice-view-target all">
							<label class="fap-notice-view-target-label">
								<code value="B2600"></code>
							</label>
							<input type="radio" name="fap_notice_view_target_ck" value="B2600">전체공개&emsp;&emsp;&emsp;
						</span>
						<span class="fap-notice-view-target user">
							<label class="fap-notice-view-target-label">
								<code value="B2602"></code>
							</label>
							<input type="radio" name="fap_notice_view_target_ck" value="B2602">회원공개&emsp;&emsp;&emsp;
						</span>
						<span class="fap-notice-view-target company">
							<label class="fap-notice-view-target-label">
								<code value="B2603"></code>
							</label>
							<input type="radio" name="fap_notice_view_target_ck" value="B2603">기업공개&emsp;&emsp;&emsp;
						</span>
						<span class="fap-notice-view-target secret">
							<label class="fap-notice-view-target-label">
								<code value="B2601"></code>
							</label>
							<input type="radio" name="fap_notice_view_target_ck" value="B2601">비공개
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row">공지종류</th>
					<td colspan="3">
						<span class="fap-notice-kind notice">
							<label class="fap-notice-kind-label">
								<code value="B2700"></code>
							</label>
							<input type="radio" name="fap_notice_kind" value="B2700">공지알림&emsp;&emsp;&emsp;
						</span>
						<span class="fap-notice-kind news">
							<label class="fap-notice-kind-label">
								<code value="B2701"></code>
							</label>
							<input type="radio" name="fap_notice_kind" value="B2701">보도자료&emsp;&emsp;&emsp;
						</span>
						<span class="fap-notice-kind recruit">
							<label class="fap-notice-kind-label">
								<code value="B2702"></code>
							</label>
							<input type="radio" name="fap_notice_kind" value="B2702">취업동향
						</span>
					</td>
				</tr>
				<tr>
				    <td colspan="4" class="view_text">
						<div id="view_text_div" style="min-height:400px;">
							<textarea id="board_content_ct" name="board_content_ct" rows="40" cols="60"></textarea>
						</div>
				    </td>
				</tr>
				<tr>
					<th scope="row"><spring:message code="fap.jobfair.main.board.file" /></th>
					<td colspan="3">
						<!-- 파일첨부 -->
						<div class="notice_file" id="file_div">
						
						</div>
						<br>
						<!-- 영상첨부 -->
						<div class="notice_video" id="video_div">
						
						</div>
					</td>
				</tr>
			</tbody>
			
		</table>
		
			<button type="button" ng-click="file_add()" style="margin-left: 85px; margin-top: 30px;">파일첨부 추가</button>
			<button type="button" ng-click="file_remove()">파일첨부 제거</button>
			<button type="button" ng-click="video_add()">영상첨부 추가</button>
			<button type="button" ng-click="video_remove()">영상첨부 제거</button>
			
		<div class="boardManagerDiv">
			<button id="boardInsertBtn">저장</button>
			<button type="button" id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button>
			<button type="button" id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button>
		</div>
		<br><br><br><br>
	</div>
	</div>
</div>

</form>

</body>
</html>