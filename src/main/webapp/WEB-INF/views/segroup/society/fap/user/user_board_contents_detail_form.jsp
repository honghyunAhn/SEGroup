<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
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
			location.href="/fap/user/user_main"
		});
		//목록으로
		$("#boardListBtn").on("click", function() {
			location.href="/fap/user/user_board_content_list?board=same_board&board_detail_gb=${contentDetail.board_detail_gb}"
		});
		//미국인턴십인 경우 - 지원하기
		$('#internshipApplyBtn').on('click', function() {
			var form = $('form[name=internshipApplyForm]');
			
			if(!internship_formCheck(form)) return false;
			
			$.ajax({
				type	: "post",
				url		: "/fap/user/internship_apply",
				data: form.serialize(),
				success	: function(result) {
					if(result > 0) {
						alert('지원 완료되었습니다.');
						location.reload();
					}
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		});
		
		//미국인턴십인 경우 - 지원취소
		$('#internshipCancelBtn').on('click', function() {
			
			if(confirm('지원을 취소하시겠습니까?')) {
				var form = $('form[name=internshipCancelForm]');
				$.ajax({
					type	: "post",
					url		: "/fap/user/internship_cancel",
					data: form.serialize(),
					success	: function(result) {
						console.log(result);
						if(result > 0) {
							alert('지원 취소되었습니다.');
							location.reload();
						}
					},
					error	: function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
				});
			}
			
		});
	})
	//인턴십 지원 유효성 검사
	function internship_formCheck(form) {
		
		//핸드폰 번호 정규식
		var phoneRegExp = /^\d{3}-\d{3,4}-\d{4}$/;
		//이메일 정규식
		var emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if($(form).find('input[name=user_nm]').val() == '') {
			alert('성명을 입력해주세요.');
			return false;
		}
		if($(form).find('input[name=user_phone]').val() == '') {
			alert('연락처를 입력해주세요.');
			return false;
		} else if(!phoneRegExp.test($(form).find('input[name=user_phone]').val())) {
			alert('연락처는 000-0000-0000 형식으로 입력해주시기 바랍니다.');
			return false;
		}
		if($(form).find('input[name=user_email]').val() == '') {
			alert('이메일을 입력해주세요.');
			return false;
		} else if (!emailRegExp.test($(form).find('input[name=user_email]').val())) {
			alert('이메일을 형식에 맞게 입력해주세요.');
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>
<div class="join-wrap">
	<div id="subcontents">	    
		 <h1>
			<c:if test = "${contentDetail.board_detail_gb =='A1700'}"><spring:message code="fap.main_menu.notice" /></c:if>
			<c:if test = "${contentDetail.board_detail_gb =='A1701'}"><spring:message code="fap.main_menu.jobinfo" /></c:if>
			<c:if test = "${contentDetail.board_detail_gb =='A1706'}"><spring:message code="fap.main_menu.internship" /></c:if> 
		</h1>
	  
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
					<a href="/file_download?origin=${data.board_file_origin }&saved=${data.board_file_saved }&path=/fap/admin/notice_file/">${data.board_file_origin }</a><br>
				</c:forEach>
			</td>
		</tr>
		</tbody>
	</table>
	<c:if test = "${contentDetail.board_detail_gb =='A1706'}">
		<c:choose>
			<c:when test="${internship_apply eq null }">
				<br>
				<form method="post" name="internshipApplyForm" onsubmit="return false;">
					<input type="hidden" name="board_content_seq" value="${contentDetail.board_content_seq}">
					<h2>미국인턴십 지원하기</h2>
					<span>해당 공고에 지원을 희망하는 경우, 아래의 양식을 작성 후 제출바랍니다.</span>
					<br><br>
					<table class="board_view">
						<colgroup>
							<col width="15%"/>
							<col width="35%"/>
						</colgroup>
						<tbody>
						    <tr>
						        <th scope="row"><spring:message code="fap.jobfair.main.board.internship.name" /></th>
						        <td colspan="3" class="internshipApplyInputTd">
						        	<input type="text" name="user_nm" placeholder="성명 입력">
								</td>
							</tr>
							<tr>
							    <th scope="row"><spring:message code="fap.jobfair.main.board.internship.phone" /></th>
							    <td colspan="3" class="internshipApplyInputTd">
							    	<input type="text" name="user_phone" placeholder="휴대폰 번호 입력: 000-0000-0000">
							    </td>
							</tr>
							<tr>
							    <th scope="row"><spring:message code="fap.jobfair.main.board.internship.email" /></th>
							    <td colspan="3" class="internshipApplyInputTd">
							    	<input type="text" name="user_email" placeholder="이메일 입력: emailsample@email.com">
							    </td>
							</tr>
							<tr>
								<td colspan="4" class="internshipApplyBtnTd">
									<button id="internshipApplyBtn">
										<spring:message code="fap.jobfair.main.board.internship.apply" />
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</c:when>
			<c:otherwise>
				<form method="post" name="internshipCancelForm" onsubmit="return false;">
					<input type="hidden" name="internship_seq" value="${internship_apply.internship_seq}">
					<h2>
						미국인턴십 지원하기
					</h2>
					<span>지원내역이 있습니다. 지원취소를 원하는 경우 아래의 지원취소를 클릭해주세요.</span>
					<br><br>
					<table class="board_view">
						<colgroup>
							<col width="15%"/>
							<col width="35%"/>
						</colgroup>
						<tbody>
							<tr>
						        <th scope="row"><spring:message code="fap.jobfair.main.board.internship.date" /></th>
						        <td colspan="3" class="internshipApplyInputTd">
						        	${internship_apply.internship_apply_dt}
								</td>
							</tr>
							<tr>
								<td colspan="4" class="internshipApplyBtnTd">
									<button id="internshipCancelBtn">
										<spring:message code="fap.jobfair.main.board.internship.cancel" />
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</c:otherwise>
		</c:choose>
	</c:if>
	<div class="boardManagerDiv">
		<button id="boardListBtn"><spring:message code="fap.jobfair.main.board.list" /></button>
		<button id="boardMainBtn"><spring:message code="fap.jobfair.main.board.main" /></button>
	</div>
	<br><br><br><br>
</div>
</div>
</div>
	
	<%@include file="../common_footer_fap.jsp"%>
</body>
</html>