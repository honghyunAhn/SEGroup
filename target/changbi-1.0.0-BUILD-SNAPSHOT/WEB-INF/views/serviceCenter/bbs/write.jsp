<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<link href="/resources/css/fileinput.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	//저장
    $(".save").click(function(event){
    	var id = $('#saveForm input[name="id"]').val();
    	// 등록/수정 구분에 따른 처리후 이동 URL 설정
    	if(isEmpty(id)) {
    		$('#saveForm input[name="afterUrl"]').val('<c:url value="/serviceCenter/bbs/qna"/>');
    	} else {
    		$('#saveForm input[name="afterUrl"]').val('<c:url value="/serviceCenter/bbs/writeDetail"/>');
    	}

    	$("#saveForm").submit();
    });

});

function doDeleteFile(board_id, file_id) {
	if(confirm('정말 삭제하시겠습니까?')) {
		location.href = '<c:url value="/serviceCenter/bbs/deleteAttachFile"/>?board_id='+board_id + '&file_id='+file_id;
	}
}
</script>

<t:insertDefinition name="centerleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">고객 센터</a>
			<a class="nth-last" href="${contextPath}">1:1 상담</a>
		</p>
		<h2 class="sub-title">1:1 상담</h2>
	</div>
	<div class="sub-body">
		<div class="tab-group">
			<div class="tab-body">
				<form id="saveForm" name="saveForm" action="writeSave" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="listQuery" value="${param.listQuery}"> <!-- 리스트페이지 검색조건 파라메터 유지 -->
				<input type="hidden" name="afterUrl"> <!-- 저장 후 return될 url -->
				<input type="hidden" name="id" value="${detail.id}">
				<input type="hidden" name="mode" id="mode" value="${param.mode}" >
				<input type="hidden" name="board_type" id="board_type" value="4" >
				<input type="hidden" name="old_file" id="old_file" value="${detail.file_name1}" >
				<input type="hidden" name="file_id" id="file_id" value="${detail.attach1_file}" >
				<input type="hidden" name="attach1_file" id="attach1_file" value="${detail.attach1_file}" >
				<input type="hidden" name="attach2_file" id="attach2_file" value="${detail.attach2_file}" >
					<div class="board-view write-page">
						<div class="view-header">
							<input type="text" name="title" placeholder="제목" value="${detail.title}">
						</div>
						<div class="view-body">
							<textarea name="comment" placeholder="내용을 입력하세요.">${detail.comment}</textarea>
						</div>
						<div><span class="Attachments">첨부 파일</span>
							<c:forEach var="list" items="${fileList }">
							<div>
								<strong><a href="<c:url value="${list.url_path}"/>" target="_blank">${list.origin_file_name}</a> </strong>
								<a href="javascript:doDeleteFile('${detail.id }', '${list.file_id}')">삭제</a>
							</div>
							</c:forEach>
						</div>
						<div class="view-bottom">
							<div class="Attachments nth-last">
							<c:forEach begin="1" end="${2-fn:length(fileList) }">
								<input type="file" id="attachFile" name="filedatas">
							</c:forEach>
							</div>
							<div class="view-util">
								<div class="btnSet">
									<a href="qna?board_type=4&faq_code=0" class="btn float_left primary">취소</a>
									<c:if test="${detail.id eq null}">
									<a href="#" class="btn float_right primary save">등록</a>
									</c:if>
									<c:if test="${detail.id ne null}">
										<a href="#" class="btn float_right primary save">수정</a>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->
