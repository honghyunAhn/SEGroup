<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<style type="text/css">
label.error {color:red}
</style>
<script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#searchBtn").click(function(event){
 		$("#searchForm").submit();
 	});

	$("#cancelBtn").click(function(event){
 		$("#saveForm")[0].reset();
 	});

	$("#sendBtn").click(function(event){
 		if(!validateForm()) {
 			return;
 		}

 		$("#saveForm").submit();
 	});

	// validation rule
	$.validator.addMethod("checkExistId",function(value, element) {
		return this.optional(element) || checkExistId(value);
	}, "존재하지 않는 사용자 입니다.");
	$("#saveForm").validate({
		rules: {	// 입력체크 룰
			to_user_id: {"required":true, "email":true, "checkExistId":true},
			title: {"required":true},
			note: {"required":true}
		}
	});

	$('#to_user_id').focus();
});

// 입력값 체크
function validateForm() {
	return $('#saveForm').valid();
}

// 아이디 존재 여부 체크
function checkExistId(id) {
	var valid = false;
	$.ajax({
		type: "POST",
		url: "<c:url value='/member/ajaxCheckExistId' />",
		data: {"id": id},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = (result.EXIST_YN == 'Y');
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
}
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a class="nth-last" href="#">쪽지함</a>
		</p>
		<h2 class="sub-title">쪽지함 </h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="list-top">
			<form id="searchForm" class="body-search" method="post" action="<c:url value="/mypage/note/sent"/>">
				<select id="searchbox" name="searchCondition">
					<option value="TC" ${(empty searchVo.searchCondition or searchVo.searchCondition == 'TC') ? 'selected':''}>제목+내용</option>
					<option value="T" ${searchVo.searchCondition == 'T' ? 'selected':''}>제목</option>
					<option value="C" ${searchVo.searchCondition == 'C' ? 'selected':''}>내용</option>
				</select>
				<input type="text" name="searchKeyword" value="${searchVo.searchKeyword}" placeholder="검색어를 입력하세요.">
				<button type="button" id="searchBtn"><span class="sr-only">검색</span></button>
				<input type="hidden" id="startPage" name="startPage" value="1">
				<input type="hidden" name="gubun" value="${searchVo.gubun}">
			</form>
		</div>
		<div class="tab-group">
			<ul class="tab-header sub x3">
				<li><a class="nth-1st" href="<c:url value="/mypage/note/received"/>">받은 쪽지함</a></li>
				<li><a href="<c:url value="/mypage/note/sent"/>">보낸 쪽지함</a></li>
				<li><a class="on" href="<c:url value="/mypage/note/form"/>">쪽지 쓰기</a></li>
			</ul>
			<div class="tab-body">
				<form id="saveForm" name="saveForm" method="post" action="<c:url value="/mypage/note/send"/>">
					<div class="board-view write-page">
						<div class="view-header">
							<input type="text" id="to_user_id" name="to_user_id" value="<c:out value="${note.FROM_USER_ID }"/>" placeholder="받는 사람" maxlength="50">
							<!--<button class="btn alignR">아이디 찾기</button>-->
							<c:if test="${not empty note.ID }">
							<input type="text" id="title" name="title" value="RE: <c:out value="${note.TITLE }"/>"  placeholder="제목" maxlength="100">
							</c:if>
							<c:if test="${empty note.ID }">
							<input type="text" id="title" name="title"  placeholder="제목" maxlength="100">
							</c:if>
						</div>
						<div class="view-body">
							<textarea id="note" name="note" placeholder="내용을 입력하세요."></textarea>
						</div>
						<div class="view-bottom">
							<div class="view-util">
								<div class="btnSet">
									<a href="#" class="btn float_right line" id="cancelBtn">취소</a>
									<a href="#" class="btn float_right primary" id="sendBtn">보내기</a>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
