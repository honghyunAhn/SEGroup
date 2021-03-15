<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="cl-popup-overlay" id="popupPoll">
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
						<h3 class="popup-title">연수 설문 조사</h3>
					</div>
					<div class="popup-body">
						<form id="pollForm">
							<input type="hidden" name="cardinal" value="${classParam.cardinal }">
							<input type="hidden" name="course" value="${classParam.course }">
							<input type="hidden" name="learn_app_id" value="${classParam.id }" >
							<input type="hidden" name="type"><%--설문유형(강의평가,만족도) --%>

							<h3 class="popup-title" id="pollTitle"></h3>
							<div class="poll-top section" id="pollGuide"></div>
							<ol class="poll-list" id="pollList">
							<%--
								<li class="typeObjL">
									<div class="item-header">
										연수 설문에 대한 질문 출력 부분.
									</div>
									<div class="item-body">
										<label><input type="radio" name="P001-1">보기 1번. 객관식이며 1개만 선택할 수 있을 때는 라디오 버튼으로 출력</label>
										<label><input type="radio" name="P001-1">보기 2번.객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</label>
										<label><input type="radio" name="P001-1">보기 3번. 객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </label>
										<label><input type="radio" name="P001-1">보기 4번.</label>
										<label><input type="radio" name="P001-1">보기 5번.</label>
									</div>
								</li>
								<li class="typeObjL">
									<div class="item-header">
										연수 설문에 대한 질문 출력 부분.
									</div>
									<div class="item-body">
										<label><input type="checkbox" name="P001-2">보기 1번. 객관식이며 답을 여러개 체크 할 수 있는 경우 체크박스로 출력</label>
										<label><input type="checkbox" name="P001-2">보기 2번.객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</label>
										<label><input type="checkbox" name="P001-2">보기 3번. 객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </label>
										<label><input type="checkbox" name="P001-2">보기 4번.</label>
										<label><input type="checkbox" name="P001-2">보기 5번.</label>
									</div>
								</li>
								<li class="typeObjS">
									<div class="item-header">
										연수 설문중 객관식이며 보기의 각 항의 내용 길이가 매우 짧을 때는 아래의 형태로 출력.
									</div>
									<div class="item-body">
										<label><input type="radio" name="P001-3">매우 그렇다.</label>
										<label><input type="radio" name="P001-3">그렇다.</label>
										<label><input type="radio" name="P001-3">보통이다.</label>
										<label><input type="radio" name="P001-3">불만족</label>
										<label><input type="radio" name="P001-3">매우 불만족</label>
									</div>
								</li>
								<li class="typeSbjC">
									<div class="item-header">
										연수 설문중 주관식이며 답변의 형태가 숫자 혹은 글자단위 일때의 출력 모양
									</div>
									<div class="item-body">
										<label><input type="text"> 단위</label>
									</div>
								</li>
								<li class="typeSbjW">
									<div class="item-header">
										연수 설문중 주관식이며 답변의 형태가 단어일 때 출력 모양:
									</div>
									<div class="item-body">
										<input type="text">
									</div>
								</li>
								<li class="typeSbjS">
									<div class="item-header">
										연수 설문중 주관식이며 답변의 형태가 짧은 서술형일 때 출력 모양
									</div>
									<div class="item-body">
										<textarea></textarea>
									</div>
								</li>
								<li class="typeSbjL">
									<div class="item-header">
										연수 설문중 주관식이며 답변의 형태가 서술형일 때 출력 모양
									</div>
									<div class="item-body">
										<textarea></textarea>
									</div>
								</li>
								 --%>
							</ol>
							<div class="list-bottom alignC">
								<a href="#" onclick="savePoll()" class="btn primary">제출</a>
								<a href="#" onclick="popupClose('popupPoll')" class="btn">취소</a>
							</div>
						</form>
					</div><!--//.popup-body-->
				</div><!--//.cl-popup-box-->
			</div><!--//.cl-popup-wrap-->
			<button class="cl-popup-closer">
				<span class="sr-only">닫기</span>
			</button>
		</div><!--//.cl-popup-overlay-->