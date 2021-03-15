<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cl-popup-overlay" id="reportpop">
	<div class="cl-popup-wrap">
			<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
				</c:otherwise>
			</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">온라인 과제물 제출</h3>
			</div>
			<div class="popup-body">
				<form name="quizForm" id="quizForm" enctype="multipart/form-data">
					<input type="hidden" name="quiz" id="quiz"/>
					<input type="hidden" name="course" id="course" value="${classParam.course }" />
					<input type="hidden" name="cardinal" id="cardinal" value="${classParam.cardinal }" />
					<input type="hidden" name="id" id="id"  value="${classParam.id }"/>

					<ul class="notice-list section">
						<li>작성하신 후 반드시 [제출] 버튼을 클릭하세요.</li>
						<li>제출 기간 경과시 제출 할 수 없습니다.</li>
						<!-- <li>아래의 주제 중 1개의 주제를 작성해 제출하시면 됩니다.</li> -->
					</ul>
					<!-- 온라인 과제 섹션-->
					<div class="section qna" id="question-list">
<!--
						온라인 과제 질문 영역
						<div class="section-header">
							<h5 id="reportTitle"></h5>
							<div class="html-view" id="reportComment"></div>
						</div>
						온라인 과제 답변 영역
						<div class="section-body">
							<textarea name="answer1"></textarea>
						</div> -->


					</div><!--//.section-->
					<div class="section qna" id="question-list">
						<!-- 첨부파일 -->
						<div class="section-body">
							<dl>
								<dt>첨부 파일</dt>
								<dd>
									<input type="file" id="reportfile" name="reportfile" accept=".hwp, .doc, .docx">
									<ul style="line-height:20px">
										<li>hwp, doc, docx 파일만 제출 가능합니다.</li>
										<li>용량은 최대 50M입니다.</li>
										<li>파일명은 "과제_성명"으로 제출해주세요.</li>
									</ul>
								</dd>
							</dl>
						</div>
					</div>
				</form>

				<div class="list-bottom alignC">
						<button class="btn primary w5em" id="btnSubmit">제출</button>
						<button class="btn w5em btn-closePopup" id="btnCancel">취소</button>
				</div>

			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>