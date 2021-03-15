<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="qnaDiv" style="max-height: 100%; max-width: 100%;">
	<div class="header_textWrap">
		<h3 class="h3 courseHQna"></h3>
		<p class="fc_999 cardinalPQna"></p>
	</div>
	<br>
	<div class="qnaViewDiv">
		<div class="searchWrapper">
			<form class="formStyle d-flex" id="qnaSearchForm" method="POST">
				<div class="class-searchWrap d-flex justify_end">
					<select name="searchCondition" class="select">
						<option value="all" <c:if test="${search.searchCondition eq 'all'}">selected</c:if>>제목+내용</option>
						<option value="title" <c:if test="${search.searchCondition eq 'title'}">selected</c:if>>제목</option>
						<option value="content" <c:if test="${search.searchCondition eq 'content'}">selected</c:if>>내용</option>
					</select>
					<input type="text" class="cusPHIn input" name="searchKeyword" value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
					<!-- 검색버튼 -->
					<button type="button" class="button img-icon search" id="qnaSearchBtn"></button>
					<input type="hidden" id="qnaStartPage" name="startPage" value='<c:out value="${search.startPage}" default="1" />'>
				</div>
			</form>
		</div>
		<div class="sub-segment table">
			<ul class="class-list-title thead d-flex">
				<li class="c-table-num">No.</li>
				<li class="c-table-name-wide">제목</li>
				<li class="c-table-01">첨부</li>
				<li class="c-table-num">조회수</li>
				<li class="c-table-02">작성자</li>
				<li class="c-table-02 c-table-date">등록일</li>
			</ul>
			<ul class="class-list-wrap" id="qnaListUl"></ul>
		</div>
		<div class="page">
		    <ul class="pagination d-flex justify_between" id="qnaPagination">
		    </ul>
		</div>
		<div class="button-wrap">
			<input type="button" id="insQnaView" class="margin-left10 margin-top10 btn_normal btn_medium btn_pp_bg " value="등록">
		</div>
	</div>
	<div class="qnaFormDiv" hidden="hidden">
		<form id="qnaActionForm" class="formStyle" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="0">
			<input type="hidden" name="lang" value="ko">
			<input type="hidden" name="board_type" value="6">
			<div class="d-flex post-titleWrap">
				<label class="label" for="post-title">제 목</label>
				<div class="post-title d-flex">
					<div class="view">
						<label class="label"></label>
					</div>
					<div class="edit" hidden="hidden">
						<div class="d-flex">
							<input type="text" name="title" class="input" style="width: 450px;">
<!-- 							<div style="padding-left: 5px; padding-top: 17px;"> -->
<!-- 								<input type="checkbox" name="secret_yn" value="Y">비밀글 -->
<!-- 							</div> -->
						</div>
					</div>
				</div>
			</div>
			<div class="view">
				<div class="d-flex">
					<label class="label" for="post-author">작성자</label>
					<div class="post-author d-flex">
						<label class="label view"></label>
					</div>
				</div>
				<div class="d-flex">
					<label class="label" for="post-date">작성일</label>
					<div class="post-date d-flex">
						<label class="label view"></label>
					</div>
				</div>
			</div>
			<div class="d-flex">
				<label class="label" for="post-content">내용</label>
				<div class="post-content d-flex">
					<div class="view">
						<label class="label"></label>
					</div>
					<div class="edit" hidden="hidden">
						<textarea name="comment" class="input" style="height: 350px; width: 450px; resize: none;"></textarea>
					</div>
				</div>
			</div>
			<div class="d-flex">
				<label class="label" for="post-file">첨부파일</label>
				<div class="post-file">
					<div class="view margin-top10 margin-bottom20">
						<div class="d-flex"></div>
					</div>
					<div class="edit" hidden="hidden">
						<div class='attach_file_area' style="clear: both;">
							<!-- fileId 세팅(저장 시 가지고 가야 할 ID) -->
							<input type='hidden' name='file_id' value='' />
							<input type='hidden' name='upload_url'	value='/upload/board/files' />
							<input type='hidden' name='upload_dir'	value='uploadImage' />
							<input type="file" value="파일선택" id="qna_regFile" name="regFile">
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="qnaReplyFormDiv" hidden="hidden">
			<form id="qnaReplyForm" class="formStyle" method="post">
			<input type="hidden" id="replyStartPage" name="replyStartPage" value='<c:out value="${search.replyStartPage}" default="1" />'>
				<div class="d-flex">
					<div class="replyList" style="width: 100%; margin-top: 20px; margin-bottom: 20px;">
						<div class="sub-segment table">
							<ul class="class-list-wrap" id="replyListUl"></ul>
							<div class="page">
							    <ul class="pagination d-flex justify_between" id="replyPagination">
							    </ul>
							</div>
						</div>
					</div>
				</div>
				<div class="d-flex">
					<label class="label" for="replyForm">댓글</label>
					<div class="replyForm">
						<table>
							<tr>
								<td colspan="2" class="d-flex">
									<textarea name="comment" style="height: 50px; width:700px; resize: none;"></textarea>
									<input type="button" id="insReply" class="margin-left10 btn_normal btn_small btn_pp_bg " value="등록">
								</td>
							</tr>
							<tr>
								<td>
									<span class="countSpan">0</span>/2000
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
		<div class="button-wrap d-flex">
			<input type="button" id="listQna" class="margin-left10 margin-top10 btn_normal btn_medium btn_pp btn-agree btn-wh" value="리스트">
			<div class="modDiv" hidden="hidden" style="margin-left:20%; float: left;">
				<input type="button" id="delQna" class="margin-left10 margin-top10 btn_normal btn_medium btn_pp btn-agree btn-wh" value="삭제">
				<input type="button" id="modQnaView" class="margin-left10 margin-top10 btn_normal btn_medium btn_pp_bg " value="수정">
				<input type="button" id="modQna" class="margin-left10 margin-top10 btn_normal btn_medium btn_pp_bg " value="저장" hidden="hidden">
			</div>
			<div class="edit" hidden="hidden" style="margin-left:20%;">
				<input type="button" id="insQna" class="margin-left10 margin-top10 btn_normal btn_medium btn_pp_bg " value="등록">
			</div>
		</div>
	</div>
</div>