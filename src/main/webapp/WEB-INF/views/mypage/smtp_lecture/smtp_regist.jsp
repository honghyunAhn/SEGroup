<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Soft Engineer Society</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
<link rel="stylesheet" href="<c:url value="/resources/css/reset.css" />">
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<link rel="stylesheet" href="<c:url value="/resources/css/user_02_myPage_style.css" />">
<script src="<c:url value="/resources/lms/js/common.js" />"></script>
<script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>
<link rel='stylesheet' href='/resources/js/ext/fullcalendar/css/jquery-ui.min.css' /> 
<link href='/resources/js/ext/fullcalendar/css/fullcalendar.css' rel='stylesheet' />
<link href='/resources/js/ext/fullcalendar/css/fullcalendar.print.css' rel='stylesheet' media='print' /> 
 <script src='/resources/js/ext/fullcalendar/js/moment.min.js'></script>
<!--<script src='/resources/js/ext/fullcalendar/js/jquery.min.js'></script> -->
<script src='/resources/js/ext/fullcalendar/js/fullcalendar.min.js'></script>
<script src='/resources/js/ext/fullcalendar/js/lang-all.js'></script>
<script src="<c:url value="/resources/js/jquery-3.3.1.min.js" />"></script>
<script src="<c:url value="/resources/js/Chart.js" />"></script> <!-- chart 라이브러리 -->
<script src="<c:url value="/resources/js/user_02_myPage_script.js" />"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/fullcalendar-main.css" />"> <!-- fullcalendar 라이브러리 -->
<script src="<c:url value="/resources/js/fullcalendar-main.js" />"></script> <!-- fullcalendar 라이브러리 -->

<script type="text/javascript">
	

document.addEventListener("DOMContentLoaded", function() {
	
	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	
	var date = new Date();
	var currentMonth = date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2);
	
	var calendarEl = document.getElementById("calendar");

    var lastClicked;
	var eventDatas=[];
	
	var flag = true;
	
	$.ajax({
		type: "GET"
		, url: "/attendance_smtp"
		, data: 
			{
				"course_id": course,
				"cardinal_id": cardinal
			}
		, success: function(data) {
			
			if(data == "" || data == NaN) {
				alert("출석 데이터가 없습니다.");
				flag = false;
			} else {
			
				$.each(data, function(index, item) {
					var status= item.ATT_FINAL_GUBUN;
					var inTime = item.IN_TIME;
					var outTime = item.OUT_ITME;
					var status_nm;
					var ecolor;
					
					if(status=='B4701'){
						ecolor='#54f542';
					}else if(status=='B4702'){
						ecolor='#eb3477';
					}else if(status=='B4703'){
						ecolor='#3440eb';
					}else if(status=='지각'){
						ecolor='#ebdc34';
					}
					
					switch(status) {
					case "B4701":
						status_nm = "출석"
						break;
					case "B4702":
						status_nm ="결석"
						break;
					case "B4703":
						status_nm ="지각/조퇴"
						break;	
					}
					
					if(status_nm != '결석') {
						var titles = status_nm + " : " + item.IN_TIME + " - " + item.OUT_TIME;
						eventDatas.push({
							"title": titles,
							"start": item.ATT_DATE,
							"color": ecolor
						});
					} else {
						eventDatas.push({
							"title":status_nm, 
							"start": item.ATT_DATE,
							"color":ecolor
						});
					}
				});
			}
				
				var calendar = new FullCalendar.Calendar(calendarEl, {
			    	
		    	locale: 'ko',
		        contentHeight: 450,
		        initialView: 'dayGridMonth',
		        editable: true,
		        selectable: true,
		        events: eventDatas
		    });
				calendar.render();
				$(".fc-next-button").addClass('nextMonth');
				$(".fc-prev-button").addClass('preMonth');
				
				if(flag) {getSisuCheck(course, cardinal, currentMonth);}
		}
		, error: function(e) {
			alert("출결정보가 없습니다.");
		}
	});
});
	
var allContentsNum=0;
var doneContents=0;

function getSisuCheck(course_id, cardinal_id, currentMonth) {
	
	$.ajax({
		type: "GET"
		, url: "/sisuCount"
		, data: 
			{
				"course_id": course_id,
				"cardinal_id": cardinal_id,
				"currentMonth": currentMonth
			} 
		, success: function(data){
			
			var sb = '';
			
			sb += "<thead><tr><th>구분</th><th>총 수업시수</th><th>정상출석</th><th>결석</th><th>공결처리</th><th>잔여시수</th><th>출석률(잔여시수 제외)</th></tr></thead>"
			sb += "<tbody>";
			$.each(data, function(index, item){
				if(item.status == "month") {
					var monthCount = item.monthCount;
					var attend = item.attend;
					var absence = item.absence;
					var accepted = item.accepted;
					var restSisu = monthCount - (attend + absence + accepted);
					
					sb += "<tr>";
					sb += "<td>월별</td>";
					sb += "<td class='total-sisu'>" + monthCount + "</td>";
					sb +="<td class='total-safe'>" + attend + "</td>";
					sb +="<td class='total-absence'>" + absence + "</td>";
					sb += "<td class='total-accepted'>" + accepted + "</td>";
					sb += "<td class='rest-sisu'>" + restSisu + "</td>";
					var t = monthCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
					sb += "<td class='attendance-avg'>" + m + "</td></tr>";
				} else if(item.status == "all") {
					var allCount = item.allCount;
					var attend = item.attend;
					var absence = item.absence;
					var accepted = item.accepted;
					var restSisu = allCount - (attend + absence + accepted);
					
					sb += "<tr>";
					sb += "<td>전체</td>";
					sb += "<td class='all-total-sisu'>" + allCount + "</td>";
					sb +="<td class='all-total-safe'>" + attend + "</td>";
					sb +="<td class='all-total-absence'>" + absence + "</td>";
					sb += "<td class='all-total-accepted'>" + accepted + "</td>";
					sb += "<td class='all-rest-sisu'>" + restSisu + "</td>";
					var t = allCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
					sb += "<td class='all-attendance-avg'>" + m + "</td></tr>";
				}
			});
			sb += "</tbody>";
			$(".sisuTable").html(sb);
			
		}
		, error: function(data) {
			alert("실패하였습니다.");
		}
	});
}

$(document).on("click", ".nextMonth", function(){
	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	
	var date = $(".fc-toolbar-title").html();
	var temp = date.replace("년 ", "-");
	var temp2 = temp.replace("월", " ");
	var cMonth = temp2.trim();
	
	$.ajax({
		type: "GET"
		, url: "/sisuCount"
		, data: {
			"course_id": course,
			"cardinal_id": cardinal,
			"currentMonth": cMonth
		}
		, success: function(data) {
			$.each(data, function(index, item) {
				if(item.status == "month") {
					var monthCount = item.monthCount;
					var attend = item.attend;
					var absence = item.absence;
					var late = item.late;
					var accepted = item.accepted;
					var restSisu = monthCount - (attend + absence + late + accepted);
					
					$(".total-sisu").html(monthCount);
					$(".total-safe").html(attend);
					$(".total-absence").html(absence);
					$(".total-late").html(late);
					$(".total-accepted").html(accepted);
					$(".rest-sisu").html(restSisu);
					var t = monthCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
	 				$(".attendance-avg").html(m);
				}
			});
			
		}
		, error: function(data) {
			alert("실패");
		}
	});
	
});

/* $(document).on('click', '.fc-event-time', function() { */
$(document).on('click', '.fc-event-title-container', function() {

	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	var date = $(this).parent().parent().parent().parent().parent().parent().parent().attr('data-date');
	
	window.open("/smtp/user/certiSubmit?courseId="+course+"&cardinalId="+cardinal+"&attDate="+date, "출결확인", "width=800px, height=900px,scrollbars=yes");
});

$(document).on("click", ".preMonth", function(){

	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	
	var date = $(".fc-toolbar-title").html();
	var temp = date.replace("년 ", "-");
	var temp2 = temp.replace("월", " ");
	var cMonth = temp2.trim();
	
	$.ajax({
		type: "GET"
		, url: "/sisuCount"
		, data: {
			"course_id": course,
			"cardinal_id": cardinal,
			"currentMonth": cMonth
		}
		, success: function(data) {
			$.each(data, function(index, item) {
				if(item.status == "month") {
					var monthCount = item.monthCount;
					var attend = item.attend;
					var absence = item.absence;
					var late = item.late;
					var accepted = item.accepted;
					var restSisu = monthCount - (attend + absence + late + accepted);
					
					$(".total-sisu").html(monthCount);
					$(".total-safe").html(attend);
					$(".total-absence").html(absence);
					$(".total-late").html(late);
					$(".total-accepted").html(accepted);
					$(".rest-sisu").html(restSisu);
					var t = monthCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
	 				$(".attendance-avg").html(m);
 				}
			}); 
			
		}
		, error: function(data) {
			alert("실패");
		}
	});
	
});

</script>
<style type="text/css">
.c-table-03.not {
	line-height : 45px;
	margin : 0 auto;
}

/* .sisuTable {
	border: 1px solid black;
	width: 100%;
	text-align: center;
}

.sisuTable > tr {
	border: 1px solid black;
}

.sisuTable > tr > td {
	border: 1px solid black;
} */

.c-table-03.not p{
	text-align : center;
}
</style>
</head>

<body>
	<div class="skip-navigation">
		<!--웹접근성/content-->
		<p>
			<a class="goToMain" href="#main">콘텐츠 바로가기</a>
		</p>
	</div>

	<!-- header-include -->
	<%@include file="../smtp_lecture/header.jsp"%>


	<div class="container sub07" id="main">
		<!-- sub07 나의강의실-include -->
		<%@include file="../smtp_lecture/menu/leftmenu07.jsp"%>
		<div class="sub-content sub07 sub07-01">
			<!-- 현재 페이지 위치 표시 -->
			<!-- <div class="page-locationWrap">
				<ul class="page-location">
					
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                   
					<li class="img-icon  home"><a href="/"></a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="category-menu"><a href="/smtp/user/sub07-01-01">나의강의실</a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="division-menu"><a href="/smtp/user/sub07-01-01">학습현황</a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="section-menu"><a href="/smtp/user/sub07-01-01">학습중</a></li>
				</ul>
				<div class="img-icon  chevron-right"></div>
				<div class="sub-content sub00-01"></div>
			</div> -->
			<div class="header">
				<div class="titleBar h3">출석체크</div>
				<!-- <h3 class="h3"></h3> -->
			</div>
			<div class="section sub07-01 sub07-01-01">

				<!-- 학습현황 탭 -->
				<!-- <div class="class-tabMenu">
					<ul class="tabGroup d-flex">
						<li class="active">학습 중</li>
						<li>학습 예정</li>
						<li>학습 종료</li>
					</ul>								
					<div class="subGroup">
						<div class="tab-sub sub01">
							<div class="sub-section"> -->
								<%-- <div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명</li>
										<li class="c-table-name">기수</li>
										<li class="c-table-03">학습기간</li>
										<li class="c-table-01">강의실</li>
									</ul>
											<ul class="class-list-wrap">
									<c:if test="${!empty progressList }">
										<c:forEach var="item" items="${progressList }" varStatus="status">
												<!-- 과정명 추가시 list and(+) Wrap 추가  -->
												<li class="listAndwrap">
													<div class="class-list tbody d-flex">
														<div class="c-table-num">${status.count}</div>
														<div class="c-table-name">${item.NAME }</div>
														<div class="c-table-name">${item.CARDINAL_NAME }</div>
														<div class="c-table-03">${item.LEARN_START_DATE } -
															${item.LEARN_END_DATE }</div>
														<div class="c-table-01 c-table-btn">
														<!-- 강의실 버튼 클릭시 모달창으로 넘어가는 정보  -->
														<form name="listForm" method="post" onsubmit="return false;">
															<input type="hidden" name="courseName" value="${item.NAME }"/>
															<input type="hidden" name="realStartDate" value="${item.REAL_START_DATE }"/>
															<input type="hidden" name="realEndDate" value="${item.REAL_END_DATE }"/>
															<input type="hidden" name="learnStartDate" value="${item.LEARN_START_DATE }"/>
															<input type="hidden" name="learnEndDate" value="${item.LEARN_END_DATE }"/>
															<input type="hidden" name="cardinalId" value="${item.CARDINAL_ID }"/>
															<input type="hidden" name="id" value="${item.ID }"/>
															<input type="hidden" name="courseId" value="${item.COURSE_ID }"/>
															<input type="hidden" name="compQuizPercent" value="${item.QUPERCENT}"/>
															<input type="hidden" name="compExamPercent" value="${item.EXPERCENT}"/>
															<input type="hidden" name="compProgPercent" value="${item.PRPERCENT}"/>
															<input type="hidden" name="compQuizScore" value="${item.QUSCORE}"/>
															<input type="hidden" name="compExamScore" value="${item.EXSCORE}"/>
															<input type="hidden" name="compProgScore" value="${item.PRSCORE}"/>
															<input type="hidden" name="completeTotal" value="${item.TOTAL}"/>
														</form>
															<a class="button btn-myClass classRoom modal-popup">
															<span class="h5">강의실</span></a>
														</div>
													</div>
												</li>
										</c:forEach>
									</c:if>
									<c:if test="${empty progressList }">
										<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>
									</c:if>
											</ul> --%>
											<!-- class list wrap -->
								<!-- </div>
							</div>
						</div> -->
						<div class="tab-sub sub02 hideTab">
							<div class="sub-section">
								<%-- <div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명</li>
										<li class="c-table-name">기수</li>
										<li class="c-table-04">학습기간</li>
										<li class="c-table-01">결제상태</li>
									</ul>
									<c:if test="${!empty waitingList }">
										<c:forEach var="item" items="${waitingList }"
											varStatus="status">
											<ul class="class-list-wrap">
												<!-- 과정명 추가시 list and(+) Wrap 추가  -->
												<li class="class-list d-flex">
													<div class="c-table-num">${status.count }</div>
													<div class="c-table-name">${item.NAME }</div>
													<div class="c-table-name">${item.CARDINAL_NAME }</div>
													<div class="c-table-04">${item.LEARN_START_DATE } -
														${item.LEARN_END_DATE }</div>
													<c:choose>
													<c:when test="${item.PAYMENT_STATE eq 1 }">	
													<div class="c-table-01 payment-wait">대기</div>
													<!-- 결제상태 : 가상계좌 선택 시 입금전,입금완료 표시 할 것 -->
													</c:when>
													<c:when test="${item.PAYMENT_STATE eq 2 }">
													<div class="c-table-01 payment-complete">완료</div>
													</c:when>
													</c:choose>
												</li>
											</ul>
										</c:forEach>
									</c:if>
									<c:if test="${empty waitingList }">
										<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>
									</c:if>
								</div> --%>
							</div>
						</div>
						<div class="tab-sub sub03 hideTab">
							<div class="sub-section">
								<%-- <div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명</li>
										<li class="c-table-01">기수</li>
										<li class="c-table-01"></li>
										<li class="c-table-02">복습기간</li>
										<li class="c-table-01">수료여부</li>
										<li class="c-table-01"></li>
									</ul>
									<c:if test="${!empty completeList }">
										<c:forEach var="item" items="${completeList}"
											varStatus="status">
											<ul class="class-list-wrap">
												<!-- 과정명 추가시 list and(+) Wrap 추가  -->
												<li class="listAndwrap">
												
												<!-- 강의실 버튼 클릭시 모달창으로 넘어가는 정보  -->
												<form name="listForm" method="post" onsubmit="return false;">
													<input type="hidden" name="courseName" value="${item.NAME }"/>
													<input type="hidden" name="realStartDate" value="${item.REAL_START_DATE }"/>
													<input type="hidden" name="realEndDate" value="${item.REAL_END_DATE }"/>
													<input type="hidden" name="learnStartDate" value="${item.LEARN_START_DATE }"/>
													<input type="hidden" name="learnEndDate" value="${item.LEARN_END_DATE }"/>
													<input type="hidden" name="cardinalId" value="${item.CARDINAL_ID }"/>
													<input type="hidden" name="id" value="${item.ID }"/>
													<input type="hidden" name="courseId" value="${item.COURSE_ID }"/>
													<input type="hidden" name="compQuizPercent" value="${item.QUPERCENT}"/>
													<input type="hidden" name="compExamPercent" value="${item.EXPERCENT}"/>
													<input type="hidden" name="compProgPercent" value="${item.PRPERCENT}"/>
													<input type="hidden" name="completeTotal" value="${item.TOTAL}"/>
													<input type="hidden" name="compQuizScore" value="${item.QUSCORE}"/>
													<input type="hidden" name="compExamScore" value="${item.EXSCORE}"/>
													<input type="hidden" name="compProgScore" value="${item.PRSCORE}"/>
													<input type="hidden" name="completeTotal" value="${item.TOTAL}"/>
												</form>
												
													<div class="class-list d-flex">
														<div class="c-table-num">${status.count }</div>
														<div class="c-table-name">${item.NAME }</div>
														<div class="c-table-01">${item.CARDINAL_NAME }</div>
														<div class="c-table-01"></div>
														<div class="c-table-02">${item.REAL_START_DATE } - ${item.REAL_END_DATE }</div>
															<c:choose>
																<c:when test="${item.ISSUE_YN eq 'Y'}"><!-- and not empty item.ISSUE_NUM  --> 
																	<div class="c-table-01 c-table-btn">
																		<a href="#" class="button btn-certificate" onclick="javascript:showCertificationPopup('${item.ID}')">
																			<span class="h5">수료증</span>
																		</a>
																	</div>
																	<!-- 수료시 복습기간이 지나지 않았으면 복습하기 처리, 지났으면 만료 처리 -->
																	<c:set var="today" value="<%=new java.util.Date() %>"/>
																	<fmt:parseDate var="realEndDateSt" value="${item.REAL_END_DATE }" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="realEndDate" value="${realEndDateSt}" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="now" type="date" value="${today }" pattern="yyyy-MM-dd"/>
																	<c:choose>
																		<c:when test="${now > realEndDate }">
																			<div class="c-table-01 c-table-btn">
                                                								<a class="button btn-not2">
                                                    							<span class="h5">기간만료</span></a>
                                                    						</div>
																		</c:when>
																		<c:otherwise>
																			<div class="c-table-01 c-table-btn">
					                                                		<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">복습하기</span></a>
					                                            			</div>
																		</c:otherwise>
																	</c:choose>
																	<!-- 수료시 복습기간 처리 완료 -->
																</c:when>
																<c:otherwise>
																	<div class="c-table-01 c-table-btn">
																		<a class="button btn-not"><span class="h5">미수료</span></a>
																	</div>
																	<!-- 수료시 복습기간이 지나지 않았으면 복습하기 처리, 지났으면 만료 처리 -->
																	<c:set var="today" value="<%=new java.util.Date() %>"/>
																	<fmt:parseDate var="realEndDateSt" value="${item.REAL_END_DATE }" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="realEndDate" value="${realEndDateSt}" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="now" type="date" value="${today }" pattern="yyyy-MM-dd"/>
																	<c:choose>
																		<c:when test="${now > realEndDate }">
																			<div class="c-table-01 c-table-btn">
                                                								<a class="button btn-not2">
                                                    							<span class="h5">기간만료</span></a>
                                                    						</div>
																		</c:when>
																		<c:otherwise>
																			<div class="c-table-01 c-table-btn">
					                                                		<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">복습하기</span></a>
					                                            			</div>
																		</c:otherwise>
																	</c:choose>
																	<!-- 수료시 복습기간 처리 완료 -->
                                                				</c:otherwise>
															</c:choose>
													</div>
												</li>
											</ul>
											</c:forEach>
									</c:if>
									<c:if test="${empty completeList }">
										<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>
									</c:if>
								</div> --%>
							</div>
						</div>
						<div class="articleWrapper" id="attendance">
<!--                     <div class="articleHdr pointBg d-flex"> -->
<!--                         <a href="#" class="d-flex"> -->
<!--                             <div class="img-icon calendar-alt_wh"></div> -->
<!--                             <div class="HdrTitle">출결관리</div> -->
<!--                         </a> -->
<!--                     </div> -->
                    		<div class="articleWrap">
	                        	<div id='calendar'></div>
	                        	<br><br>
	                        	<div class="tabTableWrap article">
	                        		<table class='sisuTable tab_table table'>
	                        			
	                        		</table>
	                        	</div>
                    		</div>
                		</div>
					</div>
				</div>
				<input type="hidden" name="course_id" value="${course_id}"/>
				<input type="hidden" name="cardinal_id" value="${cardinal_id}"/>
			</div>
		<!-- </div> -->
	<div class="modal" id="modal">
		<div class="modal-layer"></div>
		<div class="modal-content myClass">
			<!-- 19.11.21 myClass라는 클래스가 추가되었습니다. -->
			<!-- modal 수강신청 1단계 include -->
			<%-- <%@include file="../user/modal/modal-sub07-01-01.jsp"%> --%>
		</div>
	</div>
	<!-- footer-include -->
	<%@include file="../smtp_lecture/footer.jsp"%>
</body>


</html>