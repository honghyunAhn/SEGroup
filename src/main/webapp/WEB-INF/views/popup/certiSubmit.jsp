<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script type="text/javascript" src="/resources/js/printThis.js"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms//css/reset.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/renewal_style.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/user_02_myPage_style.css" />"> 
<script src="<c:url value="/resources/lms/js/common.js" />"></script> 
<script src="<c:url value="/resources/js/user_02_myPage_script.js" />"></script>

<script type="text/javascript">
	$(function(){
		$(document).on('change', '.certifile', function(){
			var text = $('.certifile').val();
			var text1 = text.replace(/C:\\fakepath\\/i, '');
			 
			$('.certifile_name').val(text1);
		});
		 
		$(document).on('click', '.downloadBtn_user', function(){
			var origin = $(':hidden[class="REG_ORIGIN_FILE"]').val();
			var saved = $(':hidden[class="REG_SAVED_FILE"]').val();
			var userId = $(':hidden[name="userId"]').val();
			var cardinalId = $(':hidden[name="cardinalId"]').val();
			var path = "${filelink}/"+userId+"_"+cardinalId;
			
			location.href = "/file_download?origin="+origin+"&saved="+saved+"&path="+path;
		 });

		$(document).on('click', '.downloadBtn_admin', function(){
			var origin = $(':hidden[class="attach_origin_file_name"]').val();
			var url = $(':hidden[class="attach_url_path"]').val();
			
			location.href = "/file_download?origin="+origin+"&path="+path;
		});
		 
		 $(document).on('click', '.file_del_btn', function(){
			 if(!confirm("삭제하시겠습니까?")) {
				 return;
			 }
			var attInfoTimeSeq = $(':hidden[name="attInfoTimeSeq"]').val();
			var saved = $(':hidden[class="REG_SAVED_FILE"]').val();
			var userId = $(':hidden[name="userId"]').val();
			var cardinalId = $(':hidden[name="cardinalId"]').val();
			
			var obj = {"userId":userId,"regSavedFile":saved,"cardinalId":cardinalId,"attInfoTimeSeq":attInfoTimeSeq}
			
			$.ajax({
				type: "POST"
				, url: '<c:url value="/smtp/user/deleteCertification" />'
				, data: obj
				, success: function() {
					
				}
				, error: function() {
					alert("실패하였습니다.");
				}
				, complete: function(){
					opener.parent.location.reload();
					window.close();
				}
			});
		})
	});
	
	function printWindow() {
		var initBody;
		
		window.onbeforeprint = function(){
			initBody = document.body.innerHTML;
			document.body.innerHTML = document.getElementById("print-body").innerHTML;
		};
		window.onafterprint = function(){
			document.body.innerHTML = initBody;
		};
		
		$(".modal-content").css("margin", "30% auto");
		
		window.print();
		
		$(".modal-content").css("margin", "0px 0px");
		
		return false;
	}
	
	function fileUploadSub() {
		var inp = $('.memo').val();
		$("#certForm").append('<input type="text" class="memo" name="memo" value="'+inp+'">');
		var form = $("#certForm")[0];
		
		var formData = new FormData(form);
		$.ajax({
			type: "POST"
			, url: "/smtp/user/subCertification"
			, data: formData
			, processData: false
            , contentType: false
			, success: function() {
			}
			, error: function() {
				alert("실패");
			}
			, complete : function(){
				opener.parent.location.reload();
				window.close();
			}
		});
	}
	
</script>
<style>
	@page {
		margin: 0;
	}
	
	* {
		margin: 0;
		padding: 0;
	}
	
	.header-content {
		width: 100%;
	}
	
	.header-content > div {
		width: 49%;
		float: left;
		text-align: center;
		background: red;
		border: 1px solid black;
	}
	
	.list-item {
		background: yellow;
	}
	.fileWrap>.fileUpload {
		display: inline-block;    
    	margin-top: 8px;
    	position: relative;
	}
	.fileWrap>.fileUpload>.certifile {
		position: absolute;
		top: 0;
		left: 0;
		height: 25px;
    	width: 75px;
    	overflow: hidden;
		opacity: 0;
		filter: alpha(opacity=0);
	}
	.fileWrap>.certifile_name, .memo {
		border: 1px solid #ddd;
    	height: 25px;
    	width: calc(100% - 82px);
    	cursor: default;
    	text-indent : 5px;
    	margin-left : 5px;
	}
	.btn_D{
    	/* color: #f1651d; */
    	background-color: #fff;
    	border:1px solid;
	}
	.btn_D:hover{
    	color: #fff;
    	background-color: #7733FF;
	}
	
	input {
		font-family:inherit;
	}
</style>

<div class="main-body">
	<div id="wrapper" class="articleWrapper">
		<div class="articleWrap">
       		<div  class="col-lg-12 tabTableWrap article" style='margin-top: 10px;'>     	
        	<!-- popupUserSearchForm start -->
        		<table class="table dataTable table-bordered table-hover tab_table table">
					<thead>
					<tr>
						<th>출결사항</th>
						<th>정보</th>
					</tr>
					</thead>
					<tbody>
					<tr>
        				<td >이름</td>
        				<td >${infoTime.USER_NM}</td>
        			</tr>
        			<tr>
        				<td>입실시간</td>
        				<td><span class='inTime' id='inTime'>${infoTime.IN_TIME}</span></td>
        			</tr>
        			<!-- <tr>
        				<td>인증수단</td>
        				<td>컬럼 없음</td>
        			</tr> -->
        			<tr>
        				<td>퇴실시간</td>
        				<td><span class='outTime' id='outTime'>${infoTime.OUT_TIME}</span></td>
        			</tr>
        			<!-- <tr>
        				<td>인증수단</td>
        				<td>컬럼없음</td>
        			</tr> -->
        			<tr>
        				<td>출결상태</td>
        				<td>
        					<span class='attFinalGubun' id='attFinalGubun'>
        					<c:choose>
        						<c:when test="${infoTime.ATT_FINAL_GUBUN eq 'B4701'}">
        							출석
        						</c:when>
        						<c:when test="${infoTime.ATT_FINAL_GUBUN eq 'B4702'}">
        							결석
        						</c:when>
        						<c:otherwise>
        							지각/조퇴
        						</c:otherwise>
        					</c:choose>
        					</span>
        				</td>
        			</tr>
        			<tr>
        				<td>첨부파일</td>
        				<td>
        				<%-- <input type="file" class="file_upload_btn" name="certiAttachFile" value="${info.regSavedFile}"> --%>
        					<div class='attach_file_area' style="clear: both;">
								<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
								<input type='hidden' class='attach_file_id'	name='FILE_ID' value="${infoTime.FILE_ID}"/> <!-- 디비에 파일 저장된 이름 -->
								<input type='hidden' class='upload_dir' />
					
								<div class='file_upload_btn_area' style="clear: both;">
									<form id="certForm" name="certForm" enctype="multipart/form-data" method="POST">
										<input type='hidden' class='att_info_time_seq' name='attInfoTimeSeq' value='${infoTime.ATT_INFO_TIME_SEQ}'>
										<input type='hidden' class='cardinal_id' name='cardinalId' value='${infoTime.CARDINAL_ID}'>											
										<input type='hidden' class='user_id' name='userId' value='${infoTime.USER_ID}'>
										<c:choose>
											<c:when test="${infoTime.REG_SAVED_FILE != '' || infoTime.REG_SAVED_FILE ne null}">
												<input type='hidden' class='reg_saved_file' name='regSavedFile' value='${infoTime.REG_SAVED_FILE}'>
												<input type='hidden' class='reg_origin_file' name='regOriginFile' value='${infoTime.REG_ORIGIN_FILE}'>
											</c:when>
										</c:choose>
										<div class="h5 fc_999">
								 			파일 형식은 zip, pdf, jpg, png, jpeg 파일로 제한합니다.
							 			</div>
										<div class="fileWrap">
											<div class="fileUpload btn_normal btn_D btn_small">
												<span class='file_upload_info' style="cursor: pointer;">파일 선택</span>
												<input type='file' accept=".pdf, .jpg, .jpeg, .png, .zip" class='file_upload_btn certifile' name='regFile' value='파일검색' />
											</div>
											<input type='text' class='certifile_name' readonly placeholder="파일명 : 과목명_과제명_성명" />
										</div>
									</form>
								</div>
									
								<c:if test="${infoTime.FILE_ID ne null and infoTime.FILE_ID ne ''.toString() and infoTime.ORIGIN_FILE_NAME ne null and infoTime.ORIGIN_FILE_NAME ne ''.toString()}">
									<div class='file_info_area' id="area1" style='float: left;'>
										<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
											<input type="button" class="downloadBtn_admin" id="btn1" style="width: 200px; height: 30px;" value="${infoTime.ORIGIN_FILE_NAME}"/> <!-- 파일 오리지널 네임 -->
										</div>
										<div class="file_info" style="padding-left: 5px;">
											<input type="hidden" class="attach_file_name" value="${infoTime.FILE_ID}"/>
											<input type="hidden" class="attach_file_path" value="${infoTime.FILE_PATH}"/>
											<input type="hidden" class="attach_origin_file_name" value="${infoTime.ORIGIN_FILE_NAME}"/>
											<input type="hidden" class="attach_url_path" value="${infoTime.URL_PATH}"/>
											<!-- <input type="button" class="attach_file_del_btn"	value="삭제" style="width: 200px; height: 30px;" /> -->
										</div>
									</div>
								</c:if>
									
								<c:if test="${infoTime.REG_ORIGIN_FILE ne null and infoTime.REG_SAVED_FILE ne null and infoTime.REG_ORIGIN_FILE ne ''.toString() and infoTime.REG_SAVED_FILE ne ''.toString()}">
									<div class='file_info_area' id="area1" style='float: left;'>
										<div class="file_view" style="padding-left: 5px; padding-top: 5px;">
											<input type="button" class="downloadBtn_user" id="btn1" style="width: 200px; height: 30px;" value="${infoTime.REG_ORIGIN_FILE}"/> <!-- 파일 오리지널 네임 -->
										</div>
										<div class="file_info" style="padding-left: 5px;">
											<input type="hidden" class="REG_SAVED_FILE" value="${infoTime.REG_SAVED_FILE}"/>
											<input type="hidden" class="REG_ORIGIN_FILE" value="${infoTime.REG_ORIGIN_FILE}"/>
											<input type="button" class="file_del_btn"	value="삭제" style="width: 200px; height: 30px;" />
										</div>
									</div>
								</c:if>
							</div>
        				</td>
        			</tr>
        			<tr>
        				<td>메모</td>
        				<td><input type="text" class='memo' name="memo" value="${infoTime.USER_MEMO}"></td>
        			</tr>
        			</tbody>
        			<!-- <tr>
        				<td colspan='2' class="popup_content_edit"><button class='sub-btn'>수정</button></td>
        			</tr> -->
        		</table>
        	</div>
		</div>
	<hr>
	<div class="articleWrap">
		<div class="col-lg-12 tabTableWrap article" style='margin-top: 10px;'>
			<form name="InfoForm">
				<table class="table dataTable table-bordered table-hover tab_table table">
					<thead>
					<tr>
						<th class="tt_w5">No</th>
						<th class="tt_w10">날짜</th>
						<th class="tt_w10">start</th>
						<th class="tt_w10">end</th>
						<th class="tt_w10">출결상태</th>
					</tr>
					</thead>
					<tbody id="popupDataListBody">
					<c:forEach  var="user" items="${infoList}" varStatus="status">
						<tr>
							<td class="tt_w5">${status.index+1}</td>
							<td>${user.ATT_DATE}</td>
							<td>${user.STAND_IN_TIME}</td>
							<td>${user.STAND_OUT_TIME}</td>
							<td>
								<%-- <input type='hidden' class='currentDate' name='updDate'>
								<input type='hidden' name='attInfoSeq' value='${user.ATT_INFO_SEQ}'> --%>
								<span class='attInfoGubun'>
									<c:choose>
        						<c:when test="${user.ATT_INFO_GUBUN eq 'B4701'}">
        							출석
        						</c:when>
        						<c:when test="${user.ATT_INFO_GUBUN eq 'B4702'}">
        							결석
        						</c:when>
        						<c:otherwise>
        							공결
        						</c:otherwise>
        					</c:choose>
								</span>
							</td>
							
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<div style="text-align: center;">
		<input type="button" class="btn_normal btn_D btn_bg" id="fileUploadBtn" value="제출" onclick="fileUploadSub()" style="width: 300px; height: 50px;">
	</div>
</div>
</div>
