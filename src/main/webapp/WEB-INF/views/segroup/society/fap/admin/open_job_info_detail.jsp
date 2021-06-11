<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<style type="text/css">
 .temporarilyhide{ display:none; } /* 취업전략 게시판의 경우 중요도 & 글종류는 기능 만들때까지 보이지 않게 처리 */
</style>
<script type="text/javascript">

var myApp = angular.module('myapp', []);

myApp.controller('JobInfoController',['$scope','$compile', function($scope, $compile) {
	
	var board_detail_gb =$('input[name=board_detail_gb]').val(); 
	console.log(board_detail_gb);
	
	var jobInfo_Map  = '${jobInfo_Map}';	
	jobInfo_Map = jobInfo_Map.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	var parsed_jobInfo_Map = JSON.parse(jobInfo_Map);
	$scope.parsed_jobInfo_Map = JSON.parse(jobInfo_Map);
	console.log('parsed_jobInfo_Map>>>>>>>>>>>>>>');
	console.log(parsed_jobInfo_Map)
	
	
	var content_Map  = '${content_Map}';
	console.log(content_Map);
	content_Map = content_Map.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	var parsed_content_Map = JSON.parse(content_Map);
	$scope.parsed_content_Map = JSON.parse(content_Map);
	console.log(parsed_content_Map);
	
	// 취업정보&전략게시판의 경우 중요도 & 글종류는 기능 만들때까지 보이지 않게 함
	 if(board_detail_gb =='A1701'){	
		 $("#importance").addClass("temporarilyhide");
		 $("#content_kind_jobinfo").addClass("temporarilyhide");
	 }
	 
	/*중요도*/	
			//주요공지
			if(parsed_content_Map.board_content_imp == 'A1100'){
				$(".board-content-imp.important").children("input:radio[name='board_content_imp']").prop("checked", true);
				$(".board-content-imp.important").addClass("ck");
			}
			//일반공지
			if(parsed_content_Map.board_content_imp == 'A1101'){
				$(".board-content-imp.normal").children("input:radio[name='board_content_imp']").prop("checked", true);
				$(".board-content-imp.normal").addClass("ck");
			}
	
	
	/*공개대상*/
			//1)공지사항
			if(board_detail_gb =='A1700' || board_detail_gb =='A1706'){	
				//전체공개
				if(parsed_jobInfo_Map.fap_notice_view_target_ck == 'B2600'){
					$(".fap-notice-view-target.all").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
					$(".fap-notice-view-target.all").addClass("ck");
				}
				//회원공개
				if(parsed_jobInfo_Map.fap_notice_view_target_ck == 'B2602'){
					$(".fap-notice-view-target.user").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
					$(".fap-notice-view-target.user").addClass("ck");
				}
				//기업공개
				if(parsed_jobInfo_Map.fap_notice_view_target_ck == 'B2603'){
					$(".fap-notice-view-target.company").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
					$(".fap-notice-view-target.company").addClass("ck");
				}
				//비공개
				if(parsed_jobInfo_Map.fap_notice_view_target_ck == 'B2601'){
					$(".fap-notice-view-target.secret").children("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);
					$(".fap-notice-view-target.secret").addClass("ck");
				}
			//2)취업전략게시판 	
			}else if(board_detail_gb =='A1701'){		
		
				//전체공개
				if(parsed_jobInfo_Map.fap_open_job_info_view_target_ck == 'B2600'){
					$(".fap-open-job-info-view-target.all").children("input:radio[name='fap_open_job_info_view_target_ck']").prop("checked", true);
					$(".fap-open-job-info-view-target.all").addClass("ck");
				}
				//회원공개
				if(parsed_jobInfo_Map.fap_open_job_info_view_target_ck == 'B2602'){
					$(".fap-open-job-info-view-target.user").children("input:radio[name='fap_open_job_info_view_target_ck']").prop("checked", true);
					$(".fap-open-job-info-view-target.user").addClass("ck");
				}
				//기업공개
				if(parsed_jobInfo_Map.fap_open_job_info_view_target_ck == 'B2603'){
					$(".fap-open-job-info-view-target.company").children("input:radio[name='fap_open_job_info_view_target_ck']").prop("checked", true);
					$(".fap-open-job-info-view-target.company").addClass("ck");
				}
				//비공개
				if(parsed_jobInfo_Map.fap_open_job_info_view_target_ck == 'B2601'){
					$(".fap-open-job-info-view-target.secret").children("input:radio[name='fap_open_job_info_view_target_ck']").prop("checked", true);
					$(".fap-open-job-info-view-target.secret").addClass("ck");
				}	
		}	
		
	/*글 종류*/
	    //1)공지사항
		if(board_detail_gb =='A1700'){	
			//공지알림
			if(parsed_jobInfo_Map.fap_notice_kind == 'B2700'){
				$(".fap-notice-kind.notice").children("input:radio[name='fap_notice_kind']").prop("checked", true);
				$(".fap-notice-kind.notice").addClass("ck");
			}
			//보도자료
			if(parsed_jobInfo_Map.fap_notice_kind == 'B2701'){
				$(".fap-notice-kind.news").children("input:radio[name='fap_notice_kind']").prop("checked", true);
				$(".fap-notice-kind.news").addClass("ck");
			}
			//취업동향
			if(parsed_jobInfo_Map.fap_notice_kind == 'B2702'){
				$(".fap-notice-kind.recruit").children("input:radio[name='fap_notice_kind']").prop("checked", true);
				$(".fap-notice-kind.recruit").addClass("ck");
			}	
	    //2)취업전략게시판
		}else if(board_detail_gb =='A1701'){					 
				//공지종류
				if(parsed_jobInfo_Map.fap_open_job_info_kind == 'B4200'){
					$(".fap-open-job-info-kind.notice").children("input:radio[name='fap_open_job_info_kind']").prop("checked", true);
					$(".fap-open-job-info-kind.notice").addClass("ck");
				}
				//보도자료
				if(parsed_jobInfo_Map.fap_open_job_info_kind == 'B4201'){
					$(".fap-open-job-info-kind.news").children("input:radio[name='fap_open_job_info_kind']").prop("checked", true);
					$(".fap-open-job-info-kind.news").addClass("ck");
				}	 
		}
	 
}]);

	$(function(){

		//메인으로
		$("#boardMainBtn").on("click", function() {
			location.href="/fap/admin/admin_main"			
		});
		//목록으로
		$("#boardListBtn").on("click", function() {		 
			$('#boardForm').submit();
		});
		//수정하기
		$('#boardUpdateBtn').on("click", function() {
			$('#boardUpdateForm').submit();
		});
	})
	
	function delete_jobInfo() {
		var flag = confirm('글을 삭제하시겠습니까?');
		if(flag){
					var board_content_seq = $('#board_content_seq').val();		
					var board_detail_gb =$('input[name=board_detail_gb]').val(); 
					var board_file_seq_list = [];
					var board_file_saved_list = []; 
					
					$("input:hidden[name=board_file_seq]").each(function(index, item){
						board_file_seq_list.push($(item).val());
					});
					
					$("input:hidden[name=board_file_saved]").each(function(index, item){
						board_file_saved_list.push($(item).val());
					});
					
					jQuery.ajaxSettings.traditional = true; // jquery로 배열넘길때 
					
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
							, url : '/fap/admin/open_job_info_delete'
							, type : 'post'
							, data : {
								board_content_seq : board_content_seq
								, board_detail_gb : board_detail_gb
							}
							, success : function() {								 
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
</head>
<body ng-app="myapp" ng-controller="JobInfoController">
<%@include file="admin_menu.jsp"%>
<div class="join-wrap">

	<div id="subcontents">
	<h2>
		<c:if test = "${boardGroup.board_detail_gb =='A1700'}"><spring:message code="fap.main_menu.notice" /></c:if>
		<c:if test = "${boardGroup.board_detail_gb =='A1701'}"><spring:message code="fap.main_menu.jobinfo" /></c:if>
		<c:if test = "${boardGroup.board_detail_gb =='A1706'}"><spring:message code="fap.main_menu.internship" /></c:if> 상세
	</h2>
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
		            ${contentMap.board_content_seq}
				</td>		 
			  <th scope="row"><spring:message code="fap.jobfair.main.board.indate" /></th>
		    <td>${contentMap.board_content_udt_dt}</td>
			</tr>
			<tr>
			    <th scope="row"><spring:message code="fap.jobfair.main.board.title" /></th>
			    <td colspan="3">
			        ${contentMap.board_content_title }
			    </td>
			</tr>
			<tr id="importance">
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
		 <c:if test = "${boardGroup.board_detail_gb =='A1700' || boardGroup.board_detail_gb == 'A1706'}">
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
		 </c:if>
		 <c:if test = "${boardGroup.board_detail_gb =='A1701'}"> 
				<tr >
					<th scope="row">공개대상</th>
					<td colspan="3">
						<span class="fap-open-job-info-view-target all">
							<label class="fap-open-job-info-view-target-label">
								<code value="B2600"></code>
							</label>						
							<input type="radio" name="fap_open_job_info_view_target_ck" value="B2600">전체공개&emsp;&emsp;&emsp;						
						</span>
						<span class="fap-open-job-info-view-target user">
							<label class="fap-open-job-info-view-target-label">
								<code value="B2602"></code>
							</label>
							<input type="radio" name="fap_open_job_info_view_target_ck" value="B2602">회원공개&emsp;&emsp;&emsp;
						</span>
						<span class="fap-open-job-info-view-target company">
							<label class="fap-open-job-info-view-target-label">
								<code value="B2603"></code>
							</label>
							<input type="radio" name="fap_open_job_info_view_target_ck" value="B2603">기업공개&emsp;&emsp;&emsp;
						</span>
						<span class="fap-open-job-info-view-target secret">
							<label class="fap-open-job-info-view-target-label">
								<code value="B2601"></code>
							</label>
							<input type="radio" name="fap_open_job_info_view_target_ck" value="B2601">비공개
						</span>
					</td>
				</tr>
			</c:if> 
		<c:if test = "${boardGroup.board_detail_gb =='A1700'}">
			<tr id="content_kind_notice">
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
		 </c:if>	
		 <c:if test = "${boardGroup.board_detail_gb =='A1701'}">	
			<tr id="content_kind_jobinfo" >
				<th scope="row">글 종류</th>
				<td colspan="3">
					<span class="fap-open-job-info-kind notice">
						<label class="fap-open-job-info-kind-label">
							<code value="B4200"></code>
						</label>
						<input type="radio" name="fap_open_job_info_kind" value="B4200">취업정보&emsp;&emsp;&emsp;
					</span>
					<span class="fap-open-job-info-kind news">
						<label class="fap-open-job-info-kind-label">
							<code value="B4201"></code>
						</label>
						<input type="radio" name="fap_open_job_info_kind" value="B4201">취업전략&emsp;&emsp;&emsp;
					</span>
				</td>
			</tr>
	   </c:if>	
			<tr>
			    <td colspan="4" class="view_text">
					<div id="view_text_div" style="min-height:400px;">
						${contentMap.board_content_ct}
					</div>
			    </td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="fap.jobfair.main.board.file" /></th>
				<td colspan="3">
					 <c:forEach var="data" items="${contentMap.fileList}" varStatus="status">
					 	<input type="hidden" class="board_file_seq" name="board_file_seq" value="${data.board_file_seq }">
					 	<input type="hidden" class="board_file_saved" name="board_file_saved" value="${data.board_file_saved }">
						<a href="/file_download?origin=${data.board_file_origin}&saved=${data.board_file_saved }&path=/fap/admin/notice_file/">${data.board_file_origin }</a><br>						 
					</c:forEach>
				</td>
			</tr>
		</tbody>
	</table>
	<c:if test="${fn:length(jobInfoMap.internship_apply_list) ne 0}">
		<h2>지원현황</h2>
		<table class="board_view">
			<tbody>
				<c:forEach var="list" items="${jobInfoMap.internship_apply_list}" varStatus="status">
				    <tr>
				    	<th>${status.index + 1}</th>
				    	<th scope="row">아이디</th>
				        <td>${list.user_id}</td>
				        <th scope="row">성명</th>
				        <td>${list.user_nm}</td>
				        <th scope="row">연락처</th>
				        <td>${list.user_phone}</td>
				        <th scope="row">이메일</th>
				        <td>${list.user_email}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
	<div class="boardManagerDiv" style="margin-right: 52px;">
		<button id="boardUpdateBtn">수정하기</button>
		<button id="boardDeleteBtn" onclick="delete_jobInfo()">삭제하기</button>
		<button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button>
		<button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button>		
	</div>
	<br><br><br><br>
</div>
</div>
</div>

	<form action="/fap/admin/open_job_info_list" method="post" id="boardForm">
		<input type="hidden" name="board_seq" value="${boardGroup.board_seq}"/>
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="board_nm" value="${board_nm}" >	 
		<input type="hidden" name="board_detail_gb" id="board_detail_gb" value="${boardGroup.board_detail_gb}" />
	</form>

	
	<form action="/fap/admin/open_job_info_update_form" method="post" id="boardUpdateForm">
		<input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq}"/>
		<input type="hidden" name="board_content_seq" id="board_content_seq" value="${board_content_seq}">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="board_nm" value="${board_nm}" >	 
		<input type="hidden" name="board_detail_gb" id="board_detail_gb" value="${boardGroup.board_detail_gb}" />
	</form>

</body>
</html>