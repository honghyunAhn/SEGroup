<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<style type="text/css">
ul.ox-list {
    font-size: 0;
    text-align: left;
    padding: 1px 0 0 1px;
}
ul.ox-list li {
    list-style: none;
    display: inline-block;
    margin: -1px 0 0 -1px;
    width: calc(6.666% + 1px);
    min-width: 43px;
    font-size: 14px;
    vertical-align: top;
    text-align: center;
    border: 1px solid #d0d0d0;
}
ul.ox-list .list-label {
    background-color: #f5f5f5;
    border-bottom: 1px solid #e0e0e0;
}
ul.ox-list .list-label, ul.ox-list .list-value {
    display: block;
    padding: 5px 0;
    font-weight: 400;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
});
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
							<li><a class="nth-1st on"  href="classroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">홈</a></li>
							<li><a href="lesson?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">강의 보기</a></li>
							<li><a href="report?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 과제</a></li>
							<li><a href="exam?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">온라인 시험</a></li>
							<li><a href="notice?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">공지 사항</a></li>
							<li><a href="dataroom?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">자료실</a></li>
							<li><a href="qna?id=${classParam.id }&cardinal=${classParam.cardinal }&course=${classParam.course }">질의 답변</a></li>
						</ul>
					<div class="tab-body">
			<!-- 탭별 로드되는 부분 Start -->
						<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
						<script type="text/javascript">
							google.charts.load('current', {packages: ['corechart', 'bar']});
							google.charts.setOnLoadCallback(drawBasic);

							function drawBasic() {
								var data1 = google.visualization.arrayToDataTable([
									['구분', '진도', { role: 'style'}],
									['나의 진도',  ${jindoInfo.USER_JINDO}, '#0068b7'],
									['전체 진도',  ${jindoInfo.BASE_JINDO}, '#c39d5f'],
								]);
								var view1 = new google.visualization.DataView(data1);
								view1.setColumns([0, 1,
																{ calc: "stringify",
																	sourceColumn: 1,
																	type: "string",
																	role: "annotation" },
																2]);
								var options1 = {
									title: { position: "none" },
									fontSize: 14,
									chartArea:{left:'15%',top:0,width:'80%',height:'75%'},
									bar: { groupWidth: "70%"},
									legend: { position: "none" },
									height: 110,
									hAxis: {
										title: { position: "none" },
										gridlines: { count: ${(jindoInfo.BASE_JINDO/5)+1}}, // (총 강의수/5) + 1
										format: 'decimal',
										viewWindow: {
											min: 0,
											max: ${jindoInfo.BASE_JINDO}  // 총 강의수
										}
									}
								};
								var data2 = google.visualization.arrayToDataTable([
									['구분', '학습 시간(분)', { role: 'style'}],
									['나의 수강', ${timeInfo.TOT_LEARN_TIME}, '#0068b7'],
									['수강자 평균', ${timeInfo.AVG_LEARN_TIME}, '#c39d5f']
								]);
								var view2 = new google.visualization.DataView(data2);
								view2.setColumns([0, 1,
																{ calc: "stringify",
																	sourceColumn: 1,
																	type: "string",
																	role: "annotation" },
																2]);
								var options2 = {
									title: { position: "none" },
									fontSize: 14,
									chartArea:{left:'15%',top:0,width:'80%',height:'75%'},
									bar: { groupWidth: "70%"},
									legend: { position: "none" },
									height: 110,
									hAxis: {
										title: { position: "none" },
										gridlines: { count: 6},
										format: 'decimal',
										viewWindow: {
											min: 0
										}
									}
								};
								var chart1 = new google.visualization.BarChart(document.getElementById('chart-CourseProgress'));
								chart1.draw( view1, options1);
								var chart2 = new google.visualization.BarChart(document.getElementById('chart-LearningTime'));
								chart2.draw(view2, options2);
							}
						</script>
						<div id="classroom-home-summary" class="group">
							<div class="group-header box strong">
								<h4 class="strong">[${classInfo.CREDIT }학점]${classInfo.NAME }</h4>
							</div>
							<div class="group-body box">
								<ul class="info-list">
									<li class="halfW"><em class="label">연수 기간</em> ${classInfo.LEARN_START_DATE } ~ ${classInfo.LEARN_END_DATE }</li>
									<li class="halfW"><em class="label">복습 기간 </em>
										${classInfo.REAL_START_DATE } ~ ${classInfo.REAL_END_DATE }
									 </li>
									<li class="clearL"><em class="label">평가 방법</em>
										<c:set var="JINDO_SCORE" value="${classInfo.CREDIT==4?10:20 }" />
										<c:set var="OFFLINE_EXAM_SCORE" value="${classInfo.CREDIT==4?60:0 }" />
										<c:set var="ONLINE_REPORT_SCORE" value="${classInfo.CREDIT==4?20:40 }" />
										<c:set var="ONLINE_EXAM_SCORE" value="${classInfo.CREDIT==4?10:40 }" />

										<c:if test="${classInfo.CREDIT==4 }">출석 고사 ${OFFLINE_EXAM_SCORE }점 + </c:if>
										 온라인 과제 ${ONLINE_REPORT_SCORE }점 + 온라인 시험 ${ONLINE_EXAM_SCORE }점 + 학습 참여도 ${JINDO_SCORE }점
									 </li>
									<li class="halfW"><em class="label">이수 기준 </em> 학습 진도율 90% 이상 + 연수 성적 60점 이상
									</li>
									<li class="halfW"><em class="label">연수 지명 번호 </em>
										<u>
											<c:if test="${empty classInfo.DES_NUM }">등록 안 됨</c:if>
											<c:if test="${!empty classInfo.DES_NUM }">${classInfo.DES_NUM }</c:if>
										</u>
										<a class="btn XS" href="#" onclick="javascript:popupOpen('popLocaleCode');return false;">수정</a>
									</li>
									<%-- <li class="clearL"><em class="label">모바일 수강</em>
										<c:choose>
										<c:when test="${classInfo.MOBILE_YN == 'Y' }">본 과정은 모바일로도 수강이 가능합니다.</c:when>
										<c:otherwise>본 과정은 PC로만 수강이 가능합니다.(모바일 미지원)</c:otherwise>
										</c:choose>
									</li> --%>
								</ul>
								<p class="btnSet clearL">
								<c:if test="${classInfo.CREDIT == 4 }">
									<!--// 직무4학점인 경우에만 표시 Start ※ 출력되는 버튼이 없더라도 btnSet는 그대로 출력 -->
									<a class="btn primary" href="#" onclick="javascript:showExamAnswer();">출석 고사 답안 공시</a>
									<a class="btn primary" href="#" onclick="javascript:showExamMyAnswer();">출석 고사 성적 조회</a>
									<a class="btn primary" href="#" onclick="javascript:showExamPrint()">출석 고사 수험표 출력</a>
									<a class="btn primary" href="#" onclick="javascript:showExamSpot();">출석 고사 고사장 지정</a>
									<!--// 직무4학점인 경우에만 표시 End-->
									</c:if>
								</p>
							</div><!--.//.group-body-->
						</div><!--//.group-->
						<div id="classroom-home-group">
								<div class="group-header">
									<h3>전체 학습 진행률</h3>
								</div>
								<div class="group-body">
									<div class="section box">
										<div class="section-header">
											<h5>학습 진도</h5>
											<p class="ctrl-btnSet">(차시)</p>
										</div>
										<div id="chart-CourseProgress" class="section-body"></div>
									</div><!--//.section-->
									<div class="section box">
										<div class="section-header">
											<h5>학습 시간</h5>
											<p class="ctrl-btnSet">(분)</p>
										</div>
										<div id="chart-LearningTime" class="section-body"></div>
									</div><!--//.section-->
									<div class="section box">
										<div class="section-header">
											<h5>학습 진도</h5>
										</div>
										<div class="section-body">
												<ul class="ox-list">
													<c:forEach var="item" items="${jindoList }" varStatus="status">
														<li>
															<span class="list-label">${status.count }강</span>
															<strong class="list-value">${item.PROG_YN=='Y'?'o':'x' }</strong>
														</li>
													</c:forEach>
												</ul>
										</div>
									</div><!--//.section-->
									<div id="classroom-home-history" class="section box">
										<div class="section-header">
											<h5>수강 기록 조회</h5>
										</div>
										<div class="section-body borderT">
										<fmt:formatNumber var="totLearnTime" type="number" value="${timeInfo.TOT_LEARN_TIME }" />
										<fmt:formatNumber var="avgLearnTime" type="number" value="${timeInfo.AVG_LEARN_TIME }" />
										<fmt:formatNumber var="avgChapterTime" type="number" value="${studyHist.AVG_CHAPTER_TIME }"  />

										<fmt:formatNumber var="personJindoPercent" type="number" pattern="0.00" value="${jindoInfo.USER_JINDO/jindoInfo.BASE_JINDO*100!='NaN'?jindoInfo.USER_JINDO/jindoInfo.BASE_JINDO*100:0.00}" />
										<fmt:formatNumber var="totaljindoPercent" type="number" pattern="0.00" value="${studyHist.AVG_JINDO/jindoInfo.BASE_JINDO*100!='NaN'?studyHist.AVG_JINDO/jindoInfo.BASE_JINDO*100:0.00}" />

											<ul class="info-list">
												<li><em class="label">총 학습 시간</em> ${totLearnTime }분 (전체 평균: ${avgLearnTime }분) </li>
												<li><em class="label">차시당 평균</em> ${avgChapterTime }분</li>
												<li><em class="label">학습 진도율</em> ${jindoInfo.USER_JINDO}/${jindoInfo.BASE_JINDO}강  ${personJindoPercent}% (전체 평균: ${totaljindoPercent}%)</li>
												<li><em class="label">최초 접속일</em> ${studyHist.START_DATE }</li>
												<li><em class="label">최종 접속일</em> ${studyHist.END_DATE }</li>
												<li><em class="label">수강 접속 수</em> ${studyHist.ACCESS_COUNT }회</li>
											</ul>
										</div>
									</div><!--//.section-->
								</div>
							</div><!--//.group-->
			<!--// 탭별 로드되는 부분 END -->
					</div><!--//.tab-body-->
				</div><!--.tab-group-->
			</div><!--//.sub-body-->
		</div>
<!-- 1.3. 본문 -->

		<t:insertDefinition name="localecode"/>									<!-- localecode popup : 연수지명번호 수정 -->
		<t:insertDefinition name="offlineexamanswer"/>			<!-- offlineexamanswer popup : 출석 고사 답안 공시 -->
		<t:insertDefinition name="offlineexammyanswer"/><!-- offlineexammyanswer popup :출석 고사 성적 조회-->
		<t:insertDefinition name="offlineexamprint"/>					<!-- offlineexamprint popup : 출석 고사수험표출력 -->
		<t:insertDefinition name="offlineexamhall"/>						<!-- offlineexamhall popup : 출석 고사 고사장 지정-->
