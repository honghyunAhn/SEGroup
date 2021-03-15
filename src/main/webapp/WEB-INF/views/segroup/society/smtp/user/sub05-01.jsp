<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    
	<!--full calendar -->
    <link rel='stylesheet' href='/resources/js/ext/fullcalendar/css/jquery-ui.min.css' /> 
	<link href='/resources/js/ext/fullcalendar/css/fullcalendar.css' rel='stylesheet' />
	<link href='/resources/js/ext/fullcalendar/css/fullcalendar.print.css' rel='stylesheet' media='print' /> 
	<script src='/resources/js/ext/fullcalendar/js/moment.min.js'></script>
	<script src='/resources/js/ext/fullcalendar/js/fullcalendar.min.js'></script>
	<script src='/resources/js/ext/fullcalendar/js/lang-all.js'></script>
	
	<!-- Pagination을 위한 js -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
	<script type="text/javascript">
		//학습현황 list
		var data;
		
		$(document).ready(function(){
			
			setContent(0);
			
			var classTabMenu = $('#mainDisplay >.tabGroup >li');
			var j = 0;
			classTabMenu.on('click', function () {
				$('#pagination').twbsPagination('destroy');
				$('#startPage').val(1);
				j = $(this).index();
				if(j == '0' || j == '1' || j == '2') {
					setContent(j);
				}
			});
			
			setEvent();
		});
		
		//탭에 따른 content 세팅
		function setContent(j) {
			
			if(j == 0) {
				getList (j);
				setProgressList (j);
			} else if (j == 1) {
				getList (j);
				setWaitingList (j);
			} else if (j == 2) {
				getList (j);
				setCompleteList (j);
			}
		}
		//학습현황 리스트
		function getList (j) {
			
			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				url : "/smtp/user/sub05-01-list",
				data : {
					"listNum" : j,
					"startPage" : startPage
				},
				async : false,
				success : function(list) {
					data = list;
				}
			})
		}
		
		//학습 중 content 세팅
		function setProgressList (j) {
			
			var content = "";
			if(data.progressList != null && data.progressList.length != 0) {
				$.each(data.progressList, function(index, item) {
					content += '<li class="listAndwrap">';
					content += '<form name="listForm" method="post" onsubmit="return false;">';
					content += 		'<input type="hidden" name="courseName" value="'+ item.NAME + '"/>';
					content += 		'<input type="hidden" name="realStartDate" value="'+ item.REAL_START_DATE + '"/>';
					content += 		'<input type="hidden" name="realEndDate" value="'+ item.REAL_END_DATE +'"/>';
					content += 		'<input type="hidden" name="learnStartDate" value="'+ item.LEARN_START_DATE + '"/>';
					content += 		'<input type="hidden" name="learnEndDate" value="'+ item.LEARN_END_DATE + '"/>';
					content += 		'<input type="hidden" name="cardinalId" value="'+ item.CARDINAL_ID +'"/>';
					content += 		'<input type="hidden" name="id" value="'+ item.ID +'"/>';
					content += 		'<input type="hidden" name="courseId" value="'+ item.COURSE_ID +'"/>';
					content += 		'<input type="hidden" name="compQuizPercent" value="'+ item.QUPERCENT + '"/>';
					content += 		'<input type="hidden" name="compExamPercent" value="'+ item.EXPERCENT+ '"/>';
					content += 		'<input type="hidden" name="compProgPercent" value="'+ item.PRPERCENT + '"/>';
					content += 		'<input type="hidden" name="compQuizScore" value="'+ item.QUSCORE + '"/>';
					content += 		'<input type="hidden" name="compExamScore" value="'+ item.EXSCORE + '"/>';
					content += 		'<input type="hidden" name="compProgScore" value="'+ item.PRSCORE + '"/>';
					content += 		'<input type="hidden" name="completeTotal" value="'+ item.TOTAL + '"/>';
					content += 		'<input type="hidden" name="reviewPeriod" value="'+ item.REVIEW_PERIOD + '"/>';
					content += '</form>';
					content += '<div class="class-list d-flex">';
					content += 		'<div class="c-table-num justify_center">'+(index+1)+ '</div>';
					content += 		'<div class="c-table-name-w">'+ item.NAME+ '<br>'+ item.CARDINAL_NAME +'</div>';
					content += 		'<div class="c-table-03 justify_center">'+ item.LEARN_START_DATE + "  ~  " + item.LEARN_END_DATE + '</div>';
					content += 		'<div class="c-table-01 c-table-btn myCourse">';
					content += 			'<a class="btn_normal btn_pp_bg btn_small myCourse">';
					content +=			'<span class="h5">강의실</span></a>';
					content +=		'</div>';
					content +=	'</div>';
					content +=	'</li>'
				})
			}
			if(content == "") {
				content += '<li class="listAndwrap">';
				content += 		'<div class="class-list justify_center">조회된 내용이 없습니다.</div>';
				content += '</li>';
			}
			$('.progressUl').html(content);
			pagingFunc(j);
		}

		//학습 예정 content 세팅
		function setWaitingList (j) {
			
			var content = "";
			if(data.waitingList != null && data.waitingList.length != 0) {
				$.each(data.waitingList, function(index, item) {
					content += '<li class="class-list d-flex">';
					content += 		'<div class="c-table-num">'+(index+1)+ '</div>';
					content += 		'<div class="c-table-name">'+ item.NAME+ '<br>'+ item.CARDINAL_NAME +'</div>';
					content += 		'<div class="c-table-04">'+ item.LEARN_START_DATE + "  ~  " + item.LEARN_END_DATE + '</div>';
					if(item.PAYMENT_STATE == '1') {
						content += '<div class="c-table-01 payment-wait">대기</div>';
					} else if (item.PAYMENT_STATE == '2') {
						content += '<div class="c-table-01 payment-complete">완료</div>';
					}
					content +=	'</li>'
				})
			}
			if(content == "") {
				content += '<li class="listAndwrap">';
				content += 		'<div class="class-list justify_center">조회된 내용이 없습니다.</div>';
				content += '</li>';
			}
			$('.waitingUl').html(content);
			pagingFunc(j);
		}
		
		//학습 종료 content 세팅
		function setCompleteList (j) {
			
			var content = "";
			if(data.completeList != null && data.completeList.length != 0) {
				$.each(data.completeList, function(index, item) {
					content += '<li class="listAndwrap">';
					content += '<form name="listForm" method="post" onsubmit="return false;">';
					content += 		'<input type="hidden" name="courseName" value="'+ item.NAME + '"/>';
					content += 		'<input type="hidden" name="realStartDate" value="'+ item.REAL_START_DATE + '"/>';
					content += 		'<input type="hidden" name="realEndDate" value="'+ item.REAL_END_DATE +'"/>';
					content += 		'<input type="hidden" name="learnStartDate" value="'+ item.LEARN_START_DATE + '"/>';
					content += 		'<input type="hidden" name="learnEndDate" value="'+ item.LEARN_END_DATE + '"/>';
					content += 		'<input type="hidden" name="cardinalId" value="'+ item.CARDINAL_ID +'"/>';
					content += 		'<input type="hidden" name="id" value="'+ item.ID +'"/>';
					content += 		'<input type="hidden" name="courseId" value="'+ item.COURSE_ID +'"/>';
					content += 		'<input type="hidden" name="compQuizPercent" value="'+ item.QUPERCENT + '"/>';
					content += 		'<input type="hidden" name="compExamPercent" value="'+ item.EXPERCENT+ '"/>';
					content += 		'<input type="hidden" name="compProgPercent" value="'+ item.PRPERCENT + '"/>';
					content += 		'<input type="hidden" name="compQuizScore" value="'+ item.QUSCORE + '"/>';
					content += 		'<input type="hidden" name="compExamScore" value="'+ item.EXSCORE + '"/>';
					content += 		'<input type="hidden" name="compProgScore" value="'+ item.PRSCORE + '"/>';
					content += 		'<input type="hidden" name="completeTotal" value="'+ item.TOTAL + '"/>';
					content += 		'<input type="hidden" name="portYn" value="'+ item.PORT_YN + '"/>';
					content += '</form>';
					content += '<div class="class-list d-flex">';
					content += 		'<div class="c-table-num">'+(index+1)+ '</div>';
					content += 		'<div class="c-table-name-w">'+ item.NAME+ '/'+ item.CARDINAL_NAME +'</div>';
					if(item.REVIEW_PERIOD != 0) {
						content += 		'<div class="c-table-02">'+ item.REAL_START_DATE + "  ~  " + item.REAL_END_DATE + '</div>';	
					} else {
						content +=	'<div class="c-table-02">기간만료</div>';
					}
					if(item.ISSUE_YN == 'Y') {
						content += '<div class="c-table-01 c-table-btn">';
						content += 		'<a href="#" class="btn_normal btn_default btn_xsmall">';
						content += 		'<span class="h5">기간만료</span>';
						content += 		'</a>';
						content += '</div>';
						var now = new Date();
						var yyyy = item.REAL_END_DATE.substr(0,4);
						var mm = item.REAL_END_DATE.substr(5,2);
						var dd = item.REAL_END_DATE.substr(8,2);
						var realEndDate = new Date(yyyy, mm-1, dd);
						if(now > realEndDate) {
							content += '<div class="c-table-01 c-table-btn">';
							content += 		'<a href="/smtp/user/sub05-03" class="btn_normal btn_pp btn_small">';
							content += 		'<span class="h5">서류발급</span></a>';
							content += '</div>';
						} else {
							content += '<div class="c-table-01 c-table-btn">';
							content += 		'<a href="#" class="btn_normal btn_pp btn_small"><span class="h5">복습하기</span></a>';
							content += '</div>';
						}
					} else {
						content += '<div class="c-table-01 c-table-btn">';
						content += 		'<a href="#" class="btn_normal btn_default btn_xsmall"><span class="h5">미수료</span></a>';
						content += '</div>';
						var now = new Date();
						var yyyy = item.REAL_END_DATE.substr(0,4);
						var mm = item.REAL_END_DATE.substr(5,2);
						var dd = item.REAL_END_DATE.substr(8,2);
						var realEndDate = new Date(yyyy, mm-1, dd);
						if(now > realEndDate) {
							content += '<div class="c-table-01 c-table-btn">';
							content += 		'<a href="#" class="btn_normal btn_default btn_xsmall">';
							content += 		'<span class="h5">기간만료</span></a>';
							content += '</div>';
						} else {
							content += '<div class="c-table-01 c-table-btn">';
							content += 		'<a href="#" class="btn_normal btn_default btn_xsmall"><span class="h5">강의실</span></a>';
							content += '</div>';
						}
					}
					content += '</div>';
					content += '</li>';
				})
			}
			if(content == "") {
				content += '<li class="listAndwrap">';
				content += 		'<div class="class-list justify_center">조회된 내용이 없습니다.</div>';
				content += '</li>';
			}
			$('.completeUl').html(content);
			pagingFunc(j);
		}
		//pagination에 필요한 값 세팅
		function pagingFunc(j) {
			
			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type : "get",
				url : "/lms/lecture/pageInfo",
				data : {
					"listNum" : j,
					"startPage" : startPage
				},
				success : function(data) {
					var totalPages = data.totalPages;
					var visiblePages = data.visiblePages;
					var startPage = Number(data.startPage) + 1;
					pagination(totalPages, visiblePages, startPage, j);
				},
				error : function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
			});
		}
		//pagination
		function pagination(totalPages, visiblePages, startPage, j) {
			if(totalPages != 0 && totalPages != null) {
				$('#pagination').twbsPagination({
			        totalPages: totalPages,
			        visiblePages: visiblePages,
			        startPage: startPage,
			        first : "",
				    prev : '<a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a>',
					next : '<a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a>',
					last : "",
			        initiateStartPageClick : false,
			        onPageClick: function (event, page) {
			        	$('#startPage').val(page);
						setContent(j);
			        }
				})
			}
			//pagination css 포맷에 맞게 설정하는 작업
		 	$('.page-item').children().addClass('num');
			$('.page-item.active').children().addClass('active'); 
			
		}
		function setEvent() {
			//강의실로
			$('.myCourse').click(function() {
				var idx = $('.myCourse').index($(this));
				var course_id = $(':hidden[name="courseId"]').eq(idx).val();
				var cardinal_id = $(':hidden[name="cardinalId"]').eq(idx).val();
				
	            var form = document.createElement("form");

	            form.action = "/smtp/mypage/sub05-01-01";
	            form.method = "post";

	            var input1 = document.createElement("input");
	            input1.setAttribute("type", "hidden");
	            input1.setAttribute('name', "course_id");
	            input1.setAttribute("value", course_id);
	            form.appendChild(input1);
	            var input2 = document.createElement("input");
	            input2.setAttribute("type", "hidden");
	            input2.setAttribute('name', "cardinal_id");
	            input2.setAttribute("value", cardinal_id);
	            form.appendChild(input2);
	            document.body.appendChild(form);
	            form.submit();
				form.remove();
				//location.href = "/smtp/mypage/sub05-01-01?course_id="+course_id+"&cardinal_id="+cardinal_id;
			});
		}
	</script>
</head>

<body>
    <div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub05_content" id="main">
            <div class="header_textWrap">
                <h3 class="h3">학습현황</h3>
                <p class="fc_999">레인보우에서 수강중인 과정들을 확인할 수 있습니다.
            </div>
            <div class="section section_sub05-01">
                <div class="class-tabMenu" id="mainDisplay">
                    <ul class="tabGroup d-flex">
                        <li class="active">학습 중</li>
                        <li>학습 예정</li>
                        <li>학습 종료</li>
                    </ul>
					<!-- pagination용  -->
		            <div class="d-flex floatR">
						<div class="class-search-down d-flex">
							<c:if test="${startpage != '' && startpage != null}">
								<input type="hidden" id="startPage" name="startPage" value="${startPage}">
							</c:if>
							<c:if test="${startpage == '' || startpage == null}">
								<input type="hidden" id="startPage" name="startPage" value="1">
							</c:if>
						</div>
					</div>
                    <div class="subGroup">
                        <div class="tab-sub sub01">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name-w">과정명/기수명</li>
                                        <li class="c-table-03">학습기간</li>
                                        <li class="c-table-01"></li>
                                    </ul>
                                    <ul class="class-list-wrap progressUl"></ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub sub02 hideTab">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name-w">과정명</li>
                                        <li class="c-table-02">기수</li>
                                        <li class="c-table-04">학습기간</li>
                                    </ul>
                                    <ul class="class-list-wrap waitingUl"></ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub sub03 hideTab">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name-w">과정명</li>
                                        <li class="c-table-02">복습기간</li>
                                        <li class="c-table-01">수료여부</li>
                                        <li class="c-table-01"></li>
                                    </ul>
                                    <ul class="class-list-wrap completeUl"></ul>
                                </div>
                            </div>
                        </div>
                        <!-- pagenation  -->
						<div class="page">
							<ul class="pagination d-flex justify_between" id="pagination"></ul>
						</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>

</html>
