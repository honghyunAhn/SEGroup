<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){

	$(".save").click(function(event){
		$("#saveForm").submit();
	});

});

function goList() {
	$('#moveForm input[name="listQuery"]').val(getListQuery(document.getElementById('moveForm'), ['board_type','startPage','searchbox','search','id','cardinal','course']));
	$('#moveForm').attr('action', 'qna');
	$('#moveForm').submit();
}

function doDeleteFile(board_id, file_id) {
	if(confirm('정말 삭제하시겠습니까?')) {
		location.href = 'deleteAttachFile?board_id='+board_id + '&file_id='+file_id;
	}
}
</script>

<t:insertDefinition name="mypageleftmenu"/>
<!-- 1.3. 본문 -->
	<div class="body">
			<div class="sub-header">
				<p class="sub-nav">
					<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
					<a href="#">나의 강의실</a>
					<a class="nth-last" href="${contextPath}">강의실</a>
				</p>
				<h2 class="sub-title">${classInfo.NAME }</h2>
				<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
			</div><!--//.sub-header-->
			<div class="sub-body">
				<div class="tab-group">
					<ul class="tab-header sub x7">
							<li><a href="classroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">홈</a></li>
							<li><a href="lesson?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">강의 보기</a></li>
							<li><a href="report?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 과제</a></li>
							<li><a href="exam?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 시험</a></li>
							<li><a href="notice?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">공지 사항</a></li>
							<li><a href="dataroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">자료실</a></li>
							<li><a class="nth-1st on"  href="qna?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">질의 답변</a></li>
						</ul>
					<div class="tab-body">
				<!-- 탭별 로드되는 부분 Start -->
							<div class="group">
								<div class="group-header">
									<h3>질의 답변</h3>
								</div>

								<form id="saveForm" name="saveForm" action="writeSave" method="POST" enctype="multipart/form-data">
									<input type="hidden" name="cardinal" value="${classParam.cardinal }" />
									<input type="hidden" name="course" value="${classParam.course }"  />
									<input type="hidden" name="id" value="${classParam.id }"  />
									<input type="hidden" name="listQuery" value="${param.listQuery}"> <!-- 리스트페이지 검색조건 파라메터 유지 -->
									<input type="hidden" name="afterUrl"> <!-- 저장 후 return될 url -->
									<input type="hidden" name="bbsid" value="${detail.id}">
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
											<div class="Attachments"><span>첨부 파일</span>
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
														<a href="javascript:goList();" class="btn float_left primary">취소</a>
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
								</div><!--//.group-body-->
							</div><!--//.group-->
				<!--// 탭별 로드되는 부분 END -->
						</div>
				</div><!--.tab-group-->
			</div><!--//.sub-body-->
<!-- 1.3. 본문 -->

		<form id="moveForm" name="moveForm" action="post">
		<input type="hidden" name="startPage" value="<c:out value="${bbsParam.startPage }"/>"/>
		<input type="hidden" name="searchbox" value="<c:out value="${bbsParam.searchbox }"/>"/>
		<input type="hidden" name="search" value="<c:out value="${bbsParam.search }"/>"/>
		<input type="hidden" name="listQuery"/>
		<input type="hidden" name="bbsid" value="<c:out value="${detail.id }"/>"/>
		<input type="hidden" name="cardinal" value="${classParam.cardinal }" />
		<input type="hidden" name="course" value="${classParam.course }"  />
		<input type="hidden" name="id" value="${classParam.id }"  />
		</form>