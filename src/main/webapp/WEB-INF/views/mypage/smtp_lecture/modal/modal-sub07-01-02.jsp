<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<body>
    <div class="sub-content modal-content">
        <div class="header">
            <div class="titleBar h3 classTitle">온라인 시험</div>
            <!-- <h3 class="h3"></h3> -->
            <div class="img-icon times close-modal"></div>
        </div>
        <!-- <div class="modal-sectionWrap"> -->
        <div class="section section-margin modal-sub07-01 sub07-01 sub07-01-01">
            <!-- 학습현황 탭 -->
            <div class="class-tabMenu">
                <!-- 내용이 많아 스크롤이 필요할 경우 modal-sectionWrap클래스 활성화할 것 -->
                <div class="modal-subGroup subGroup modal-ovflowY">
                    <div class="tab-sub sub01">
                        
                         <div class="statusWrap modal-sectionWrap" id="modal_title">
                            </div>
                        <div class="completionWrap modal-sectionWrap" id="modal_content">
                        	<form name="quizForm" id="quizForm">
							<input type="hidden" name="quiz" id="quiz" />
							<input type="hidden" name="course" id="course" value="${course_id }"/>
							<input type="hidden" name="cardinal" id="cardinal" value="${cardinal_id }" />
							<input type="hidden" name="id" id="id"  value="${classInfo.ID }"/>
							<input type="hidden" name="quiz_type" id="quiz_type"  value="2"/>

							<ul id="exam-timer" class="fix-state">
								<li>
									<span class="label">남은 시간</span>
									<em id="timeLimit"></em>
								</li>
								<li>
									<span class="label">시험실 입장 시간</span>
									<em id="takeExamTime">2018-03-12 오후 5:01:27</em>
								</li>
							</ul>
							<ul class="notice-list section">
								<li>모든 문제의 답안을 꼼꼼히 체크하신 후 화면 맨 아래 [제출] 버튼을 꼭 클릭하시기 바랍니다.</li>
								<li>[제출] 버튼을 클릭하지 않고 시험창을 닫을 시 답안 제출이 되지 않은 상태이니 이 점 유의 바랍니다.</li>
							</ul><br>
							<ol class="question-list" id="question-list">
								<li>
									<div class="item-header">
										다지선택형 문제 출력
									</div>
									<ol class="item-body">
										<li><label><input type="radio" name="P001-1">객관식이며 1개만 선택할 수 있을 때는 라디오 버튼으로 출력</label></li>
										<li><label><input type="radio" name="P001-1">객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</label></li>
										<li><label><input type="radio" name="P001-1">객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% 객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </label></li>
										<li><label><input type="radio" name="P001-1">보기 4번.</label></li>
										<li><label><input type="radio" name="P001-1">보기 5번.</label></li>
									</ol>
								</li>
								<li>
									<div class="item-header">
										다지 선다형 문제 출력
									</div>
									<ol class="item-body">
										<li><label><input type="checkbox" name="P001-2">객관식이며 답을 여러개 체크 할 수 있는 경우 체크박스로 출력</label></li>
										<li><label><input type="checkbox" name="P001-2">객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</label></li>
										<li><label><input type="checkbox" name="P001-2">객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </label></li>
										<li><label><input type="checkbox" name="P001-2">보기 4번.</label></li>
										<li><label><input type="checkbox" name="P001-2">보기 5번.</label></li>
									</ol>
								</li>
							</ol>
							<div class="list-bottom alignC">
								<a href="#" class="btn primary w5em btnSubmission" id="btnSubmit">제출</a>
								<a href="#" class="btn w5em"  id="btnCancel">취소</a>
							</div>
						</form>                   
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- </div> -->
       <!--  <div class="button-wrap d-flex">
            <button class="button btn-myClass" type="button">학습시작</button>
        </div> -->
    </div>
</body>

</html>
