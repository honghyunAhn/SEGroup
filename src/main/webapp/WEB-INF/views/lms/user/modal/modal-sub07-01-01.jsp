<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<body>
    <div class="sub-content modal-content">
        <div class="header d-flex justify_end">
        	<div class="titleBar h3 classTitle"></div>
            <!-- <div class="titleBar h3" style="text-align:left">수강신청</div> -->
            <!-- <h3 class="h3"></h3> -->
            <div class="img-icon times close-modal"></div>
        </div>
        <!-- <div class="modal-sectionWrap"> -->
        <div class="section section-margin modal-sub07-01 sub07-01 sub07-01-01">
            <!-- 학습현황 탭 -->
            <div class="class-tabMenu" id="modalTab">
                <ul class="modal-tabGroup tabGroup d-flex">
                    <li class="active">학습현황</li>
                    <li>학습하기</li>
                    <li>온라인 과제</li>
                    <li>온라인 시험</li>
                    <li>공지사항</li>
                    <li>설문조사</li>
                    <li>자료실</li>
                    <!-- <li>출결현황</li> -->
                </ul>
                <!-- 내용이 많아 스크롤이 필요할 경우 modal-sectionWrap클래스 활성화할 것 -->
                <div class="modal-subGroup subGroup modal-ovflowY">
                    <div class="tab-sub sub01">
                        <!-- <div class="sub-section d-flex">
                            <div class="titleBar-hdr">학습기간</div>
                              <div class="sub-segment c999 learn">
                                
                            </div>
                        </div>
                        <div class="sub-section d-flex">
                            <div class="titleBar-hdr">복습기간</div>
                            <div class="sub-segment c999 recap">
                                
                            </div>
                        </div>
                        <div class="sub-section d-flex">
                            <div class="titleBar-hdr">학습현황</div>
                            <div class="sub-segment">
                                	
                               <table class="table table-standard" border="1">
                                <thead>
                                        <tr>
                                            <th colspan="2">평가방법</th>
                                            <th>비중(%)</th>
                                            <th>배점</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td rowspan="3">평가항목</td>
                                            <td>과제</td>
                                            <td class="completeQuizPercent"></td>
                                            <td class="completeQuizScore"></td>
                                        </tr>
                                        <tr>
                                            <td>시험</td>
                                            <td class="completeExamPercent"></td>
                                            <td class="completeExamScore"></td>
                                        </tr>
                                        <tr>
                                            <td>진도율</td>
                                            <td class="completeProgPercent"></td>
                                            <td class="completeProgScore"></td>
                                        </tr>
                                        <tr>
                                            <td colspan=2><b class="c666">수료기준</b></td>
                                            <td class="completeTotal" colspan=2></td>
                                        </tr>
                                    </tbody>
                            </table>
                            </div>
                        </div> -->
                        
                         <div class="statusWrap d-flex">
                                <article class="chart">
                                    <ul class="floatL left">
                                        <li></li>
                                    </ul>
                                    <ul class="floatL right">
                                        <li></li>
                                    </ul>
                                    <div class="pannel">
                                        <!-- .calStatus 학습한 차시에 계산식(전체학습일/실제학습일*100%) 도입 -->
                                        <p class="fz34 cMain fc_orD"><span class="calStatus">20</span></p>
                                    </div>
                                </article>
                                <div class="sub-sectionWrap">
                                    <div class="sub-section">
                                        <div class="titleBar-hdr">학습진도현황</div>
                                        <div class="sub-segment c666 learnTotal">
                                          <!--   학습 완료 -->
                                            <!-- .classStatus에 진도현황(학습일수) 대입 -->
                                           <!--  <strong class="classStatus cDanger">15</strong>
                                            / 20 -->
                                        </div>
                                    </div>
                                    <div class="sub-section">
                                        <div class="titleBar-hdr">학습기간</div>
                                        <div class="sub-segment c666 learn">
                                            
                                        </div>
                                       <span class="cDanger">학습종료
                                                <!-- .countDay에 학습기간에 따른 남은 학습기간일 대입 -->
                                                <strong class="countDay">7일</strong>
                                                전 입니다.</span>
                                    </div>
                                    <div class="sub-section">
                                        <div class="titleBar-hdr">복습기간</div>
                                        <div class="sub-segment c666 recap">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <div class="completionWrap d-flex">
                                <div class="completion">
                                    <div class="sub-section d-flex">
                                        <div class="titleBar-hdr">수료조건</div>
                                        <!-- .compltScore 수료 조건 점수 -->
                                        <div class="sub-segment c666 completeTotal">총점 <stong class="compltScore">80</stong>점 이상</div>
                                    </div>
                                    <div class="graphWrap">
                                        <ul class="graphGroup d-flex">
                                            <li class="condition">진도율</li>
                                            <li class="graph">
                                                <!-- div.graph 점수 계산
                                                width: calc((그래프너비 100% / 비중 배점) * 현재 점수); -->
                                                <div class="graph graph1"></div>
                                            </li>
                                            <li class="scoreWrap progress">
                                                <!-- .checkScore 현재 점수
                                                     .condtnScore 수료조건 -->
                                                <!-- <span class="checkScore">35</span>점 / <span class="condtnScore">50</span>점 -->
                                                
                                            </li>
                                        </ul>
                                        <ul class="graphGroup d-flex">
                                            <li class="condition">시험</li>
                                            <li class="graph">
                                                <div class="graph graph2"></div>
                                            </li>
                                            <li class="scoreWrap exampro">
                                                <span class="checkScore">10</span>점 /
                                                <span class="conditionScore">20</span>점
                                            </li>
                                        </ul>
                                        <ul class="graphGroup d-flex">
                                            <li class="condition">과제</li>
                                            <li class="graph">
                                                <div class="graph graph3"></div>
                                            </li>
                                            <li class="scoreWrap workpro">
                                                <span class="checkScore">-</span> / <span class="conditionScore">30</span>점</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="scoreSum">
                                    <div class="titleBar-hdr">점수합계</div>
                                    <div class="scoreWrap">
                                        <div class="score">
                                            <!-- .sumCondition 수료조건 점수 합계 -->
                                            <div class="sumCondition fz34">45</div>
                                            <!-- .totlaScore 총 점수 -->
                                            <div class="totalScore"> / 100점</div>
                                        </div>
                                        <div class="showTxt">
                                            <!-- 수료조건 충족시 .cMain show 나머지 hide
                                                 수료조건 미충족시 .cDanger show 나머지 hide -->
                                                 <div class="cDanger fc_false">수료 기준 미달</div>
                                                 <div class="cMain fc_true">수료 기준 달성</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <!-- player submit form -->
					<form id="chapterForm" name="chapterForm">
						<input type="hidden" name="id" id="id" value="">
						<input type="hidden" name="cardinal" id="cardinal" value="">
						<input type="hidden" name="course" id="course" value="">
						<input type="hidden" name="chapter" id="chapter" value="">
						<input type="hidden" name="chasi" id="chasi" value="">
						<input type="hidden" name="portYn" id="portYn" value="">
					</form>
                    <div class="tab-sub sub02 hideTab">
                        <div class="sub-section">
                            <!-- <div class="titleBar-hdr">학습현황</div> -->
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">차시</li>
                                    <li class="c-table-name">차시명</li>
                                    <li class="c-table-num">학습시간</li>
                                    <li class="c-table-num"></li><!--정렬을 위해 넣어주었음 -->
                                    <li class="c-table-num">학습여부</li>
                                    <li class="c-table-02">강의보기</li>
                                </ul>
                                <ul class="class-list-wrap occasion">
                                        <!-- 차시 리스트 위치 -->
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="tab-sub sub03 hideTab">
                         <div class="sub-section">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-name-w">과제명</li>
                                    <li class="c-table-02">과제기간</li>
                                    <li class="c-table-01">제출여부</li>
                                    <li class="c-table-01">과제점수</li>
                                </ul>
                                <ul class="class-list-wrap assignment">
                                   <!--  <li class="class-list d-flex">
                                        <div class="c-table-name-w text-over-lh20">
                                            새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                            새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                            새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                        </div>
                                        <div class="c-table-02 c-table-date">2019.12.05 - 2020.01.05</div>
                                        <div class="c-table-01 cDanger">미제출</div>
                                        <div class="c-table-01"><strong class="score">-</strong>/40</div>
                                    </li>
                                    <li class="class-list d-flex">
                                        <div class="c-table-name-w text-over-lh20">
                                            새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                        </div>
                                        <div class="c-table-02 c-table-date">2019.12.05 - 2020.01.05</div>
                                        <div class="c-table-01 cMain">제출</div>
                                        <div class="c-table-01"><strong class="score">37</strong>/40</div>
                                    </li> -->
                                </ul>
                            </div>
                             <!-- <table class="table table-standard" border="1">
                                <thead class="thead">
                                    <tr class="bgcCCC">
                                        <th colspan="9">평가기준안내</th>
                                    </tr>
                                </thead>
                                <tbody class="tbody">
                                    <tr class="bgcEEE">
                                        <th rowspan="2">구분</th>
                                        <th rowspan="2">평가 방법</th>
                                        <th colspan="2">45시간(3학점)</th>
                                        <th colspan="2">30시간(2학점)</th>
                                        <th colspan="2">15시간(1학점)</th>
                                        <th rowspan="2">내용</th>
                                    </tr>
                                    <tr class="bgcEEE">
                                        <th>비율</th>
                                        <th>점수</th>
                                        <th>비율</th>
                                        <th>점수</th>
                                        <th>비율</th>
                                        <th>점수</th>
                                    </tr>
                                    <tr class="highlight">
                                        <td>* 온라인 과제</td>
                                        <td>주관식</td>
                                        <td>40%</td>
                                        <td>40점</td>
                                        <td>40%</td>
                                        <td>40점</td>
                                        <td>40%</td>
                                        <td>40점</td>
                                        <td>과정당 과제물 1회 부과</td>
                                    </tr>
                                    <tr class="">
                                        <td>온라인 시험</td>
                                        <td>객관식</td>
                                        <td>40%</td>
                                        <td>40점</td>
                                        <td>40%</td>
                                        <td>40점</td>
                                        <td>40%</td>
                                        <td>40점</td>
                                        <td>온라인 평가 시험 1회 실시</td>
                                    </tr>
                                    <tr class="">
                                        <td>참여도 평가</td>
                                        <td>강의 참여도</td>
                                        <td>20%</td>
                                        <td>20점</td>
                                        <td>20%</td>
                                        <td>20점</td>
                                        <td>20%</td>
                                        <td>20점</td>
                                        <td>진도율 90% 이상</td>
                                    </tr>
                                    <tr class="bgcF9">
                                        <th colspan="2">합계</th>
                                        <th colspan="2">100점</th>
                                        <th colspan="2">100점</th>
                                        <th colspan="2">100점</th>
                                        <th></th>
                                    </tr>
                                </tbody>
                            </table> -->
                        </div>
                    </div>
                    <div class="tab-sub sub04 hideTab">
                        <div class="sub-section">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-name">시험명</li>
                                    <li class="c-table-02">시험기간</li>
                                    <li class="c-table-num">제출여부</li>
                                    <li class="c-table-01">시험점수</li>
                                </ul>
                                <ul class="class-list-wrap exam">
                                    <!-- <li class="listAndwrap">
                                        <div class="class-list board-list open-answer d-flex">
                                            <div class="c-table-name text-over-lh20">
                                                새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                                새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                                새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                            </div>
                                            <div class="c-table-02 c-table-date">2019.12.05 - 2020.01.05</div>
                                            <div class="c-table-num cDanger">미제출</div>
                                            <div class="c-table-num"><strong class="score">-</strong>/40</div>
                                        </div>
                                        <div class="open-asw open-ctt">
                                            <ul class="class-list-wrap">
                                                <li class="icon-align aswr-box d-flex">
                                                    <div class="c999">결과<br>답안<br>보기</div>
                                                    <div class="text-over-lh20">
                                                        새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 공자는 살 그것은 것이다.
                                                        이상은 할지라도 천자만홍이 행복스럽고 만물은 길지 일월과 커다란 영원히 때문이다. 청춘의 길을 얼마나 이것이다.
                                                        싹이 무엇이 오직 위하여서 황금시대를 속에서 원질이 황금시대의 있음으로써 것이다.
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                    <li class="listAndwrap">
                                        <div class="class-list board-list open-answer d-flex">
                                            <div class="c-table-name text-over-lh20">
                                                새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                            </div>
                                            <div class="c-table-02 c-table-date">2019.12.05 - 2020.01.05</div>
                                            <div class="c-table-num cMain">제출</div>
                                            <div class="c-table-num"><strong class="score">37</strong>/40</div>
                                        </div>
                                        <div class="open-asw open-ctt">
                                            <ul class="class-list-wrap">
                                                <li class="icon-align aswr-box d-flex">
                                                    <div class="c999">결과<br>답안<br>보기</div>
                                                    <div class="text-over-lh20">
                                                        새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 공자는 살 그것은 것이다.
                                                        이상은 할지라도 천자만홍이 행복스럽고 만물은 길지 일월과 커다란 영원히 때문이다. 청춘의 길을 얼마나 이것이다.
                                                        싹이 무엇이 오직 위하여서 황금시대를 속에서 원질이 황금시대의 있음으로써 것이다.
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </li> -->
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="tab-sub sub05 hideTab">
                        <div class="sub-section">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-wide ">제목</li>
                                    <li class="c-table-02">작성일</li>
                                </ul>
                                <ul class="class-list-wrap boardType01">
                                  <!-- 공지사항 컨텐츠 추가 -->
                                    <!-- 과정명 추가시 list and(+) Wrap 추가  -->
                                    <!-- <li class="class-list board-list d-flex">
                                        <div class="c-table-num">1</div>
                                        <div class="c-table-name-wide ">
                                            <div class="d-flex icon-align">
                                                <div class="img-icon bullhorn-s"></div>
                                                <p class="text-over-lh20">
                                                    새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다.
                                                </p>
                                            </div>
                                        </div>
                                        <div class="c-table-02">2019.08.05</div>
                                    </li>
                                    <li class="class-list board-list d-flex">
                                        <div class="c-table-num">2</div>
                                        <div class="c-table-name-wide ">
                                            <div class="d-flex icon-align">
                                                <div class="img-icon bullhorn-s"></div>
                                                <p class="text-over-lh20">
                                                    새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 주는 사랑의 온갖 공자는 살 그것은 것이다.
                                                </p>
                                            </div>
                                        </div>
                                        <div class="c-table-02">2019.08.05</div>
                                    </li> -->
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="tab-sub sub06 hideTab">
                        <div class="sub-section">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-wide">과정</li>
                                    <li class="c-table-name-wide">설문조사명</li>
                                    <li class="c-table-03">설문 종료일</li>
                                    <!-- <li class="c-table-03">설문기간</li> -->
                                    <li class="c-table-02">진행여부</li>
                                </ul>
                                <ul class="class-list-wrap survey">
                                 
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="tab-sub sub07 hideTab">
                        <div class="sub-section">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-wide ">제목</li>
                                    <li class="c-table-01">첨부파일</li>
                                    <li class="c-table-02">작성일</li>
                                </ul>
                                <ul class="class-list-wrap boardType02">
                                  <!-- 자료실 컨텐츠 추가 -->
                                    <!-- 과정명 추가시 list and(+) Wrap 추가  -->
                                    <!-- <li class="class-list board-list d-flex">
                                        <div class="c-table-num">1</div>
                                        <div class="c-table-name-wide  text-over-lh20">새가 인간은 사랑의 않는 뿐이다.</div>
                                        <div class="c-table-01">
                                            <a href="#">
                                                <div class="img-icon save"></div>
                                            </a>
                                        </div>
                                        <div class="c-table-02">2019.09.10</div>
                                    </li>
                                    <li class="class-list board-list d-flex">
                                        <div class="c-table-num">2</div>
                                        <div class="c-table-name-wide  text-over-lh20">새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 얼음이 밝은 웅대한 뿐이다. 얼음이 밝은 웅대한 뿐이다.</div>
                                        <div class="c-table-01">
                                            <a href="#">
                                                <div class="img-icon save"></div>
                                            </a>
                                        </div>
                                        <div class="c-table-02">2019.10.10</div>
                                    </li> -->
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!-- 
                    <div class="tab-sub sub07 hideTab">
                        <div class="sub-section">
                            <div class="sub-segment">
                                <ul class="class-list-wrap attend">
                                  자료실 컨텐츠 추가
                                    과정명 추가시 list and(+) Wrap 추가 
                                    <li class="class-list board-list d-flex">
                                        <div class="c-table-num">1</div>
                                        <div class="c-table-name-wide  text-over-lh20">새가 인간은 사랑의 않는 뿐이다.</div>
                                        <div class="c-table-01">
                                            <a href="#">
                                                <div class="img-icon save"></div>
                                            </a>
                                        </div>
                                        <div class="c-table-02">2019.09.10</div>
                                    </li>
                                    <li class="class-list board-list d-flex">
                                        <div class="c-table-num">2</div>
                                        <div class="c-table-name-wide  text-over-lh20">새가 인간은 사랑의 않는 뿐이다. 얼음이 밝은 웅대한 뿐이다. 얼음이 밝은 웅대한 뿐이다. 얼음이 밝은 웅대한 뿐이다.</div>
                                        <div class="c-table-01">
                                            <a href="#">
                                                <div class="img-icon save"></div>
                                            </a>
                                        </div>
                                        <div class="c-table-02">2019.10.10</div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                     -->
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
