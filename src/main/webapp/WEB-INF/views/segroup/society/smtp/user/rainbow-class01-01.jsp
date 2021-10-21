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
					content += '<li class="list d-flex">';
					content += 		'<div class="w50">'+(index+1)+ '</div>';
					content += 		'<div class="w450"><p>'+ item.NAME+ '/'+ item.CARDINAL_NAME + "</p>";
					if(item.REVIEW_PERIOD != 0) {
						content += 		'<p>'+ item.REAL_START_DATE + "  ~  " + item.REAL_END_DATE + '</p></div>';	
					} else {
						content +=	'<p>기간만료<p></div>';
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
                <%-- <!-- 기존 레인보우사이트 pagination 복사 >> 확인 필요 -->
                <div class="section_pagination">
                    <ul class="d-flex justify_center" id="pagination">
                        <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button" onclick="javascript:ilist('1')" name=""
                                    value="&lt&lt">
                            </li>
                        </c:if>

                        <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.prevPage}')" name="" value="&lt">
                            </li>
                        </c:if>
                        <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
                        <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
                            <!-- **현재페이지이면 하이퍼링크 제거 -->
                            <c:choose>
                                <c:when test="${num == map.boardPager.curPage}">
                                    <li class="page-item">
                                        <input class="btn_default fc_point" type="button" name="" value="${num}">
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <input class="btn_default" type="button" onclick="ilist('${num}')" name=""
                                            value="${num}">
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.nextPage}')" name="" value="&gt">
                            </li>
                        </c:if>

                        <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.totPage}')" name="" value="&gt&gt">
                            </li>
                        </c:if>
                    </ul>
                </div> --%>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
</body>
</html>