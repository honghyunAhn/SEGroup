<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/backgroundTransition.css" />" />
<link type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/lightslider.css" />" />
<title>Bridge Job Fair</title>

<script type="text/javascript">
	$(function() {
		//메인으로
		$("#boardMainBtn").on("click", function() {
			location.href="/fap/admin/admin_main"
			
		});
		//목록으로
		$("#boardListBtn").on("click", function() {
			// location.href="/fap/admin/fap_notice_management"
			$('#boardForm').submit();
		});
		
		//수정하기
		$('#boardUpdateBtn').on("click", function() {
			$('#boardUpdateForm').submit();
		});
		
	})
	
	function delete_notice() {
		var flag = confirm('삭제하시겠습니까?');
		if(flag){
			var board_content_seq = $('#board_content_seq').val();
			var board_file_seq_list = [];
			var board_file_saved_list = []; 
			
			$("input:hidden[name=board_file_seq]").each(function(index, item){
				board_file_seq_list.push($(item).val());
			});
			$("input:hidden[name=board_file_saved]").each(function(index, item){
				board_file_saved_list.push($(item).val());
			});
			
			jQuery.ajaxSettings.traditional = true;
			
			//파일 삭제
			if(board_file_seq_list != null){
				$.ajax({
					beforeSend: function(xhr) {
					     xhr.setRequestHeader("AJAX", true);
					}
					, url : '/fap/admin/delete_board_file_list'
					, type : 'post'
					, data : {
						board_file_seq_list : board_file_seq_list
						, board_file_saved_list : board_file_saved_list
					}
					, success : function() {
					
					}
					, error: function(e) {
						if(e.status == 403){
							alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
							location.href = "/fap/admin/admin_login";
						}
					}
				});
			}
			
			//게시글 삭제
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				}
				, url : '/fap/admin/notice_delete'
				, type : 'post'
				, data : {
					board_content_seq : board_content_seq
				}
				, success : function() {
					alert('삭제되었습니다.');
					$('#boardForm').submit();
				}	
				, error : function(e) {
					if(e.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/admin/admin_login";
					}
				}
			});
			
		}else{
			return false;
		}
		
	}
	
</script>
<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
	myApp.controller('NoticeController',['$scope','$compile', function($scope, $compile) {
		
		var content_Detail  = '${content_Detail}';
		content_Detail = content_Detail.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
		var parsed_content_Detail = JSON.parse(content_Detail);
		$scope.parsed_content_Detail = JSON.parse(content_Detail);
		console.log(parsed_content_Detail);
		
		/*중요도*/ 
		//주요공지
		if(parsed_content_Detail.board_content_imp == 'A1100'){
			$(".board-content-imp.important").children("input:radio[name='board_content_imp']").prop("checked", true);
			$(".board-content-imp.important").addClass("ck");
		}
		//일반공지
		if(parsed_content_Detail.board_content_imp == 'A1101'){
			$(".board-content-imp.normal").children("input:radio[name='board_content_imp']").prop("checked", true);
			$(".board-content-imp.normal").addClass("ck");
		}
		
		/*공개대상*/
		//전체공개
		if(parsed_content_Detail.noticeContent.fap_notice_view_target_ck == 'B2600'){
			$(".fap-notice-view-target.all").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
			$(".fap-notice-view-target.all").addClass("ck");
		}
		//회원공개
		if(parsed_content_Detail.noticeContent.fap_notice_view_target_ck == 'B2602'){
			$(".fap-notice-view-target.user").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
			$(".fap-notice-view-target.user").addClass("ck");
		}
		//기업공개
		if(parsed_content_Detail.noticeContent.fap_notice_view_target_ck == 'B2603'){
			$(".fap-notice-view-target.company").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
			$(".fap-notice-view-target.company").addClass("ck");
		}
		//비공개
		if(parsed_content_Detail.noticeContent.fap_notice_view_target_ck == 'B2601'){
			$(".fap-notice-view-target.secret").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
			$(".fap-notice-view-target.secret").addClass("ck");
		}
		
		/*공지종류*/
		//공지알림
		if(parsed_content_Detail.noticeContent.fap_notice_kind == 'B2700'){
			$(".fap-notice-kind.notice").children("input:radio[name='fap_notice_kind']").prop("checked", true);
			$(".fap-notice-kind.notice").addClass("ck");
		}
		//보도자료
		if(parsed_content_Detail.noticeContent.fap_notice_kind == 'B2701'){
			$(".fap-notice-kind.news").children("input:radio[name='fap_notice_kind']").prop("checked", true);
			$(".fap-notice-kind.news").addClass("ck");
		}
		//취업동향
		if(parsed_content_Detail.noticeContent.fap_notice_kind == 'B2702'){
			$(".fap-notice-kind.recruit").children("input:radio[name='fap_notice_kind']").prop("checked", true);
			$(".fap-notice-kind.recruit").addClass("ck");
		}
		
	}]);
</script>
</head>
<body ng-app="myapp" ng-controller="NoticeController">
<%@include file="admin_menu.jsp"%> 
<div class="join-wrap">
	<div id="subcontents">
	<h2>공지사항 상세</h2>
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
		        <th scope="row"><spring:message code="fap.jobfair.main.board.no" /></th>
		        <td>
		            ${contentDetail.board_content_seq}
				</td>
			<%-- <th scope="row"><spring:message code="fap.jobfair.main.board.id" /></th>
			<td>${contentDetail.board_content_nm }</td> --%>
			  <th scope="row"><spring:message code="fap.jobfair.main.board.indate" /></th>
		    <td>${contentDetail.board_content_udt_dt}</td>
			</tr>
			<tr>
			    <th scope="row"><spring:message code="fap.jobfair.main.board.title" /></th>
			    <td colspan="3">
			        ${contentDetail.board_content_title }
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
						${contentDetail.board_content_ct }
					</div>
			    </td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="fap.jobfair.main.board.file" /></th>
				<td colspan="3">
					 <c:forEach var="data" items="${contentDetail.fileList }" varStatus="status">
					 	<input type="hidden" class="board_file_seq" name="board_file_seq" value="${data.board_file_seq }">
					 	<input type="hidden" class="board_file_saved" name="board_file_saved" value="${data.board_file_saved }">
						<a href="/file_download?origin=${data.board_file_origin }&saved=${data.board_file_saved }&path=/fap/admin/notice_file/">${data.board_file_origin }</a><br>
						<img class="boardImage" alt="" src="/fap/admin/notice_file/${data.board_file_saved }"><br>
					</c:forEach>
				</td>
			</tr>
		</tbody>
	
	</table>
		
	<div class="boardManagerDiv" style="margin-right: 52px;">
		<button id="boardUpdateBtn">수정하기</button>
		<button id="boardDeleteBtn" onclick="delete_notice()">삭제하기</button>
		<button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button>
		<button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button>		
	</div>
	<br><br><br><br>
</div>
</div>
</div>

	<form action="/fap/admin/fap_notice_management" method="post" id="boardForm">
		<input type="hidden" name="board_seq" value="${board_seq}"/>
	</form>

	
	<form action="/fap/admin/notice_update_form" method="post" id="boardUpdateForm">
		<input type="hidden" name="board_seq" id="board_seq" value="${board_seq}"/>
		<input type="hidden" name="board_content_seq" id="board_content_seq" value="${board_content_seq}">
	</form>

</body>
</html>