<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 나의강의실 >> 학습현황 -->
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
    <script type="text/javascript">
        //학습현황 list
		var data;
		
		$(document).ready(function(){
		    navLinks[4].parentElement.classList.add('current')
		    subNav[4].classList.add('active');
		    
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
					content += '<li class="list d-flex">';
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
					content += '<div class="w50">'+(index+1)+ '</div>';
					content += '<div class="w500"><p>'+ item.NAME+ ' / '+ item.CARDINAL_NAME +'</p>';
					content += '<p>'+ item.LEARN_START_DATE + "  ~  " + item.LEARN_END_DATE + '</p></div>';
					content += 		'<div class="w100 myCourse">';
					content += 			'<a class="w50 btn_normal btn_xsmall bgc_point myCourse">';
					content +=			'<span class="h5">강의실</span></a>';
					content +=		'</div>';
					content +=	'</li>'
				})
			}
			if(content == "") {
				content += '<li class="list not fc_999">';
				content += 		'조회된 내용이 없습니다.';
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
					content += '<li class="list d-flex">';
					content += 		'<div class="w50">'+(index+1)+ '</div>';
					content += 		'<div class="w550"><p>'+ item.NAME+ ' / '+ item.CARDINAL_NAME +'</p>';
					content += 		'<p>'+ item.LEARN_START_DATE + "  ~  " + item.LEARN_END_DATE + '</p></div>';
					if(item.PAYMENT_STATE == '1') {
						content += '<div class="c-table-01 payment-wait">대기</div>';
					} else if (item.PAYMENT_STATE == '2') {
						content += '<div class="c-table-01 payment-complete">완료</div>';
					}
					content +=	'</li>'
				})
			}
			if(content == "") {
				content += '<li class="list not fc_999">';
				content += 		'조회된 내용이 없습니다.';
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
					content += '<li class="list d-flex">';
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
					content += 		'<div class="w50">'+(index+1)+ '</div>';
					content += 		'<div class="w450"><p>'+ item.NAME+ '/'+ item.CARDINAL_NAME + "</p>";
					if(item.REVIEW_PERIOD != 0) {
						content += 		'<p>'+ item.REAL_START_DATE + "  ~  " + item.REAL_END_DATE + '</p></div>';	
					} else {
						content +=	'<p>기간만료<p></div>';
					}
					if(item.ISSUE_YN == 'Y') {
						content += '<div class="w100">';
						content += 		'<p>수료</p>';
						var now = new Date();
						var yyyy = item.REAL_END_DATE.substr(0,4);
						var mm = item.REAL_END_DATE.substr(5,2);
						var dd = item.REAL_END_DATE.substr(8,2);
						var realEndDate = new Date(yyyy, mm-1, dd);
						if(now > realEndDate) {
							content += 		'<a href="/smtp/user/rainbow-class03-01" class="w50 btn_default btn_xsmall fc_point">';
							content += 		'<span class="h5">수료증</span></a>';
							content += '</div>';
						} else {
							content += 		'<a href="#" class="w50 btn_default btn_xsmall fc_point"><span class="h5">복습하기</span></a>';
							content += '</div>';
						}
					} else {
						content += '<div class="w100">';
						content += 		'<p>미수료</p>';
						content += '</div>';
					}
					content += '</div>';
					content += '</li>';
				})
			}
			if(content == "") {
				content += '<li class="list not fc_999">';
				content += 		'조회된 내용이 없습니다.';
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
			        first : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&lt&lt" />',
	    	        prev : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&lt" />',
	    	        next : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&gt" />',
	    	        pageClass: 'btn_default twPaging',
	    	        activeClass : 'btn_default fc_point',
	    	        last : '<input type="button" style="margin: 0 5px;" class="btn_default fc_point" value="&gt&gt" />',
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
    	<%@include file="../include/rainbow_header.jsp"%>
        <div class="content myClass course-point05" id="main">
            <div class="sub-content class01-01">
                <div class="section_header">
                    <h3 class="h3">✎ 학습현황</h3>
                    <p class="margin-top10 fc_999">
                       	레인보우 학습과정을 확인할 수 있습니다.
                    </p>
                </div>
                <div class="section_tab" id="mainDisplay">
                    <ul class="tab_headerWrap d-flex justify_center fc_point tabGroup">
                        <li class="tab_header fz16 active">
                            <a tab="#tab1">학습 중</a>
                        </li>
                        <li class="tab_header fz16">
                            <a tab="#tab2">학습 예정</a>
                        </li>
                        <li class="tab_header fz16">
                            <a tab="#tab3">학습 종료</a>
                        </li>
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
                    <ul class="tab_bodyWrap">
                        <li id="tab1" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>학습기간</li>
                                    <li class="w100">강의실</li>
                                </ul>
                                <ul class="table-list tbody progressUl"></ul>
                            </div>
                        </li>
                        <li id="tab2" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w550">과정명/기수명<br>학습기간</li>
                                </ul>
                                <ul class="table-list tbody waitingUl"></ul>
                            </div>
                        </li>
                        <li id="tab3" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>복습기간</li>
                                    <li class="w100">수료여부</li>
                                </ul>
                                <ul class="table-list tbody completeUl"></ul>
                            </div>
                        </li>
                    </ul>
                </div>
                <!-- pagenation  -->
				<div class="page">
					<ul class="pagination d-flex justify_between" id="pagination"></ul>
				</div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
</body>
</html>