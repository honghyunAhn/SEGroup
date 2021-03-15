<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<style type="text/css">
 .temporarilyhide{ display:none; } /* 중요도 / 글종류는 기능 만들때까지 보이지 않게 처리 */
</style>
<title>Bridge Job Fair</title>

<script type="text/javascript">
	$(function() {
		CKEDITOR.replace('board_content_ct', {
			filebrowserUploadUrl : '/board/imageUpload',
			enterMode: CKEDITOR.ENTER_BR,
			shiftEnterMode:  CKEDITOR.ENTER_P,
			fullPage: true,
			allowedContent:  true
		});
	})
</script>
<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
	myApp.controller('UpdateController',['$scope','$compile', function($scope, $compile) {
		
		var jobInfo_Map  = '${jobInfo_Map}';
		jobInfo_Map = jobInfo_Map.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
		var parsed_jobInfo_Map = JSON.parse(jobInfo_Map);
		$scope.parsed_jobInfo_Map = JSON.parse(jobInfo_Map);
		console.log(parsed_jobInfo_Map);
		
		
		var content_Map  = '${content_Map}';
		content_Map = content_Map.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
		var parsed_content_Map = JSON.parse(content_Map);
		$scope.parsed_content_Map = JSON.parse(content_Map);
		console.log(parsed_content_Map);

		var board_detail_gb =$('input[name=board_detail_gb]').val(); 
		// 취업정보&전략게시판의 경우 중요도 & 글종류는 기능 만들때까지 보이지 않게 함
		 if(board_detail_gb =='A1701'){	
			 $("#importance_update").addClass("temporarilyhide");
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
			if(board_detail_gb =='A1700'){	
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
					//취업정보
					if(parsed_jobInfo_Map.fap_open_job_info_kind == 'B4200'){
						$(".fap-open-job-info-kind.notice").children("input:radio[name='fap_open_job_info_kind']").prop("checked", true);
						$(".fap-open-job-info-kind.notice").addClass("ck");
					}
					//취업전략
					if(parsed_jobInfo_Map.fap_open_job_info_kind == 'B4201'){
						$(".fap-open-job-info-kind.news").children("input:radio[name='fap_open_job_info_kind']").prop("checked", true);
						$(".fap-open-job-info-kind.news").addClass("ck");
					}
			}
		
		var file_seq = $('.boardFileList').length;
		
		// 파일 첨부 추가
		$scope.file_add = function() {
						
			var file_add_content = '';
			file_add_content += '<div class="common_file">';
			file_add_content += '사진';
			file_add_content += '<input type="file" class="boardFileList" name="boardFileList['+file_seq+'].board_file">';
			file_add_content += "</div>";
			
			$("#file_div").append(file_add_content);
			file_seq++;
		}
		
		// 영상 첨부 추가
		$scope.video_add = function() {
			
			var video_add_content = '';
			video_add_content += '<div class="video_file">';
			video_add_content += '영상';
			video_add_content += '<input type="file" class="boardFileList" name="boardFileList['+file_seq+'].board_file">';
			video_add_content += "</div>";
			
			$("#video_div").append(video_add_content);
			file_seq++;		
		}
		
		// 파일 첨부 제거
		$scope.file_remove = function(){
			var file_length = $('.notice_file').find('.common_file').length;			
			if(file_length > 0){
				$('.notice_file').find('.common_file').last().remove();
				file_seq--;
			}			
		}
		
		// 영상 첨부 제거
		$scope.video_remove = function(){
			var video_length = $('.notice_video').find('.video_file').length;
			if(video_length > 0){
				$('.notice_video').find('.video_file').last().remove();
				file_seq--;
			}			
		}
		
		
	}]);
	
	
</script>

<script type="text/javascript">
$(document).ready(function(){
	var board_detail_gb =$('input[name=board_detail_gb]').val(); 
	/*중요도*/	
	$(".board-content-imp").on("click",function(){		
		$(".board-content-imp").removeClass("ck");
		$(".board-content-imp").find("input:radio[name='board_content_imp']").prop("checked", false);
		$(this).addClass("ck");
		$(this).find("input:radio[name='board_content_imp']").prop("checked", true);		
	});
	
	/*공개대상*/
		//1)공지사항 
		if(board_detail_gb =='A1700'){
			$(".fap-notice-view-target").on("click",function(){		
				$(".fap-notice-view-target").removeClass("ck");
				$(".fap-notice-view-target").find("input:radio[name='fap_notice_view_target_ck']").prop("checked", false);
				$(this).addClass("ck");
				$(this).find("input:radio[name='fap_notice_view_target_ck']").prop("checked", true);		
			});
		}
		//2)취업전략게시판 	
		 if(board_detail_gb =='A1701'){
				$(".fap-open-job-info-view-target").on("click",function(){		
					$(".fap-open-job-info-view-target").removeClass("ck");
					$(".fap-open-job-info-view-target").find("input:radio[name='fap_open_job_info_view_target_ck']").prop("checked", false);
					$(this).addClass("ck");
					$(this).find("input:radio[name='fap_open_job_info_view_target_ck']").prop("checked", true);		
				});
		 }
	//공지종류
	 /*글 종류*/
	     //1)공지사항 
		 if(board_detail_gb =='A1700'){
			  $(".fap-notice-kind").on("click",function(){		
					$(".fap-notice-kind").removeClass("ck");
					$(".fap-notice-kind").find("input:radio[name='fap_notice_kind']").prop("checked", false);
					$(this).addClass("ck");
					$(this).find("input:radio[name='fap_notice_kind']").prop("checked", true);		
				});		
		 }
		 //2)취업전략게시판 	
		 if(board_detail_gb =='A1701'){
				$(".fap-open-job-info-kind").on("click",function(){		
					$(".fap-open-job-info-kind").removeClass("ck");
					$(".fap-open-job-info-kind").find("input:radio[name='fap_open_job_info_kind']").prop("checked", false);
					$(this).addClass("ck");
					$(this).find("input:radio[name='fap_open_job_info_kind']").prop("checked", true);		
				});
		 }

	//파일 삭제
	$(".x_icon").on("click", function(){
		var board_file_seq = $(this).prevAll(".board_file_seq").attr('value');
		var board_file_saved = $(this).prevAll(".board_file_saved").attr('value');
		$(this).parent(".boardFileList").remove();
		
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, type : "POST"
			, url : "/fap/admin/delete_board_file"
			, data : {board_file_seq : board_file_seq, board_file_saved : board_file_saved}
			, success : function(data) {
	
			},
			error : function(e) {
				console.log(e);
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			}
		});
		
	});
	
	//메인으로
	$("#boardMainBtn").on("click", function() {
		location.href="/fap/admin/admin_main";
		
	});
	//목록으로
	$("#boardListBtn").on("click", function() {
		$("#boardForm").submit();
	});
	
	//수정하기
	$('#boardUpdateBtn').on("click", function() {		
	 $("#boardUpdateForm").submit();
	});
	
});

</script>
</head>
<body ng-app="myapp" ng-controller="UpdateController">
<%@include file="admin_menu.jsp"%>
<form  id="boardUpdateForm" action="/fap/admin/open_job_info_update" method="post"  enctype="multipart/form-data" onsubmit="return formCheck();">
<input type="hidden" name="board_content_seq" value="${board_content_seq }">
<input type="hidden" name="board_seq" value="${board_seq }">
<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
<input type="hidden" name="board_nm" value="${board_nm}" >	 
<input type="hidden" name="board_detail_gb" id="board_detail_gb" value="${board_detail_gb}" />
<div class="join-wrap">
	<div id="subcontents">
		<h2>
			<c:if test = "${board_detail_gb =='A1700'}"><spring:message code="fap.main_menu.notice" /></c:if>
			<c:if test = "${board_detail_gb =='A1701'}"><spring:message code="fap.main_menu.jobinfo" /></c:if> 수정
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
			    <td colspan="3" colspan="3" style="padding-top: 0px; padding-bottom: 0px;  padding-top: 0px; padding-bottom: 0px; padding-left: 15px;">
			    	<input type="text" name="board_content_title" value="${contentMap.board_content_title }" style=" height: 30px; width: 700px;">
			    </td>
			</tr>
			<tr id="importance_update">
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
			<c:if test = "${board_detail_gb =='A1700'}">
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
			<c:if test = "${board_detail_gb =='A1701'}">			
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
			<c:if test = "${board_detail_gb =='A1700'}">
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
			<c:if test = "${board_detail_gb =='A1701'}">
					<tr id="content_kind_jobinfo">
						<th scope="row">공지종류</th>
						<td colspan="3">
							<span class="fap-open-job-info-kind notice">
								<label class="fap-open-job-info-kind-label">
									<code value="B2700"></code>
								</label>
								<input type="radio" name="fap_open_job_info_kind" value="B4200">취업정보&emsp;&emsp;&emsp;
							</span>
							<span class="fap-open-job-info-kind news">
								<label class="fap-open-job-info-kind-label">
									<code value="B2701"></code>
								</label>
								<input type="radio" name="fap_open_job_info_kind" value="B4201">취업전략&emsp;&emsp;&emsp;
							</span>
						</td>
					</tr>
			</c:if>
				<tr>
			    <td colspan="4" class="view_text">
					<div id="view_text_div" style="min-height:400px;">
						<textarea id="board_content_ct" name="board_content_ct" rows="40" cols="60">${contentMap.board_content_ct }</textarea>
					</div>
			    </td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="fap.jobfair.main.board.file" /></th>
				<td colspan="3">					
					 <c:forEach var="data" items="${contentMap.fileList }" varStatus="status">					 					 	
						<div class="boardFileList">	
							<input type="hidden" class="board_file_seq" name="boardFileList[${status.index}].board_file_seq" value="${data.board_file_seq }">	
							<input type="hidden" name="boardFileList[${status.index}].board_file_origin" value="${data.board_file_origin }">
						 	<input type="hidden"  class="board_file_saved" name="boardFileList[${status.index}].board_file_saved" value="${data.board_file_saved }">
							<a href="/file_download?origin=${data.board_file_origin }&saved=${data.board_file_saved }&path=/fap/admin/notice_file/">${data.board_file_origin }</a>
							<img class="x_icon" src="<c:url value="/resources/segroup/society/fap/images/main/deletePic.png" />" alt="" />
							<br>
							<img class="boardImage" alt="" src="/fap/admin/notice_file/${data.board_file_saved }"><br>
						</div>
					</c:forEach>
					
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
		<button id="boardUpdateBtn">수정</button>
		<button type="button" id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button>
		<button type="button" id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button>
	</div>
	<br><br><br><br>
</div>
</div>
</div>
</form>
	<form action="/fap/admin/open_job_info_list" method="post" id="boardForm">
		<input type="hidden" name="board_seq" value="${board_seq }">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden" name="board_nm" value="${board_nm}" >	 
		<input type="hidden" name="board_detail_gb" id="board_detail_gb" value="${board_detail_gb}" />
	</form>
	



</body>
</html>