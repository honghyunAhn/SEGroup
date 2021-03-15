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
<!-- 홈페이지의 대략적인 설명 >> 검색 결과 제목 하단에 설명으로 노출 -->
<meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Do it campus!">
<!-- 홈페이지 키워드 >> 키워드 검색했을 때 검색결과로 노출 -->
<meta name="keywords" content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
<title>Let's Do it 두잇캠퍼스</title>
<link rel="stylesheet" href="/resources/lms/css/reset.css">
<link rel="stylesheet" href="/resources/lms/css/common.css">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
<link rel="stylesheet" href="/resources/lms/css/style.css">
<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
<script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>

<link rel='stylesheet' href='/resources/js/ext/fullcalendar/css/jquery-ui.min.css' /> 
<link href='/resources/js/ext/fullcalendar/css/fullcalendar.css' rel='stylesheet' />
<link href='/resources/js/ext/fullcalendar/css/fullcalendar.print.css' rel='stylesheet' media='print' /> 
 <script src='/resources/js/ext/fullcalendar/js/moment.min.js'></script>
<!--<script src='/resources/js/ext/fullcalendar/js/jquery.min.js'></script> -->
<script src='/resources/js/ext/fullcalendar/js/fullcalendar.min.js'></script>
<script src='/resources/js/ext/fullcalendar/js/lang-all.js'></script>
<!-- Pagination을 위한 js -->
<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>



<script src="<c:url value="/resources/lms/js/common.js" />"></script>
<style type="text/css">
.class-list {
	height: 50px;
}
</style>
<script type="text/javascript">


var allContentsNum=0;
var doneContents=0;

//학습현황 list
var data;

//진도율 변수 : timeChk function과 설문조사 탭에서 사용
var calStatus=0;

function goPlayer(id, course, cardinal, chapterId, chasi, progYn, portYn) {
	$("#chapterForm #id").val(id);
	$("#chapterForm #cardinal").val(cardinal);
	$("#chapterForm #course").val(course);
	$("#chapterForm #chapter").val(chapterId);
	$("#chapterForm #chasi").val(chasi);
	$("#chapterForm #portYn").val(portYn);
	
	var width = 1200;
	var height = 700;
	
	var popOption = "width="+width+"px, height="+height+"px";
		popOption += ", toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, directories=no";
		popOption += ", top=0, left=0";

	var playerWindow = window.open("about:blank","playerWindow",popOption);
	if ((width == 0 || height == 0 ) && (playerWindow.outerWidth < screen.availWidth || playerWindow.outerHeight < screen.availHeight)) {
		playerWindow.moveTo(0,0);
		playerWindow.resizeTo(screen.availWidth, screen.availHeight);
	}
	
	$('#chapterForm')
	.attr('action','/lms/user/player')
	.attr('method','POST')
	.attr('target','playerWindow')
	.submit();
	
	// 학습 여부 아이콘 변경
// 	$('.progYn').eq(chasi-1).attr('class', 'img-icon attendanceY progYn');
}

//학습현황 리스트
function getList (j, search) {
	
	var startPage = $('#startPage').val();
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		url : "/lms/user/sub07-01-01-list",
		data : {
			"search" : search,
			"listNum" : j,
			"startPage" : startPage
		},
		async : false,
		success : function(list) {
			data = list;
		}
	})
}

//탭에 따른 content 세팅
function setContent(j) {
	
	var search = $('input[name=search').val();
	if('${search}' != null && '${search}' != '') {
		search = '${search}';
	}
	
	if(j == 0) {
		getList (j, search);
		setProgressList (j, search);
	} else if (j == 1) {
		getList (j, search);
		setWaitingList (j, search);
	} else if (j == 2) {
		getList (j, search);
		setCompleteList (j, search);
	}
}


//학습 중 content 세팅
function setProgressList (j, search) {
	
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
			content += 		'<input type="hidden" name="portYn" value="'+ item.PORT_YN + '"/>';
			content += 		'<input type="hidden" name="reviewPeriod" value="'+ item.REVIEW_PERIOD + '"/>';
			content += '</form>';
			content += '<div class="class-list d-flex">';
			content += 		'<div class="c-table-num">'+(index+1)+ '</div>';
			content += 		'<div class="c-table-name">' + item.CARDINAL_NAME +'</div>';
			content += 		'<div class="c-table-03">'+ item.LEARN_START_DATE + "  ~  " + item.LEARN_END_DATE + '</div>';
			content += 		'<div class="c-table-01 c-table-btn">';
			content += 			'<a class="btn_point btn_normal btn_xsmall classRoom modal-popup">';
			content +=			'<span class="h5">강의실</span></a>';
			content +=		'</div>';
			content +=	'</div>';
			content +=	'</li>'
		})
	}
	if(content == "") {
		content += '<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>';
	}
	$('.progressUl').html(content);
	setModal();
	pagingFunc(j,search);
}

//학습 예정 content 세팅
function setWaitingList (j, search) {
	
	var content = "";
	if(data.waitingList != null && data.waitingList.length != 0) {
		$.each(data.waitingList, function(index, item) {
			content += '<li class="listAndWrap">';
			content += 		'<div class="class-list d-flex">';
			content += 			'<div class="c-table-num">'+(index+1)+ '</div>';
			content += 			'<div class="c-table-name">' + item.CARDINAL_NAME +'</div>';
			content += 			'<div class="c-table-04">'+ item.LEARN_START_DATE + "  ~  " + item.LEARN_END_DATE + '</div>';
			if(item.PAYMENT_STATE == '1') {
				content += 		'<div class="c-table-01 payment-wait">대기</div>';
			} else if (item.PAYMENT_STATE == '2') {
				content += 		'<div class="c-table-01 payment-complete">완료</div>';
			}
			content +=		'</div>';
			content +=	'</li>'
		})
	}
	if(content == "") {
		content += '<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>';
	}
	$('.waitingUl').html(content);
	setModal();
	pagingFunc(j,search);
}

//학습 종료 content 세팅
function setCompleteList (j, search) {
	
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
			content += 		'<div class="c-table-name">' + item.CARDINAL_NAME +'</div>';
			if(item.REVIEW_PERIOD != 0) {
				content += 		'<div class="c-table-04">'+ item.REAL_START_DATE + "  ~  " + item.REAL_END_DATE + '</div>';	
			} else {
				content +=	'<div class="c-table-04"></div>';
			}
			if(item.ISSUE_YN == 'Y') {
				content += '<div class="c-table-01 c-table-btn">';
				content += 		'<a href="#" class="button btn-certificate" onclick="javascript:showCertificationPopup(\'' + item.ID + '\')">';
				content += 		'<span class="h5">수료증</span>';
				content += 		'</a>';
				content += '</div>';
				var now = new Date();
				var yyyy = item.REAL_END_DATE.substr(0,4);
				var mm = item.REAL_END_DATE.substr(5,2);
				var dd = item.REAL_END_DATE.substr(8,2);
				var realEndDate = new Date(yyyy, mm-1, dd);
				if(now > realEndDate) {
					content += '<div class="c-table-01 c-table-btn">';
					content += 		'<a class="button btn-not2">';
					content += 		'<span class="h5">기간만료</span></a>';
					content += '</div>';
				} else {
					content += '<div class="c-table-01 c-table-btn">';
					content += 		'<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">복습하기</span></a>';
					content += '</div>';
				}
			} else {
				content += '<div class="c-table-01 c-table-btn">';
				content += 		'<a class="button btn-not"><span class="h5">미수료</span></a>';
				content += '</div>';
				var now = new Date();
				var yyyy = item.REAL_END_DATE.substr(0,4);
				var mm = item.REAL_END_DATE.substr(5,2);
				var dd = item.REAL_END_DATE.substr(8,2);
				var realEndDate = new Date(yyyy, mm-1, dd);
				if(now > realEndDate) {
					content += '<div class="c-table-01 c-table-btn">';
					content += 		'<a class="button btn-not2">';
					content += 		'<span class="h5">기간만료</span></a>';
					content += '</div>';
				} else {
					content += '<div class="c-table-01 c-table-btn">';
					content += 		'<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">복습하기</span></a>';
					content += '</div>';
				}
			}
			content += '</div>';
			content += '</li>';
		})
	}
	if(content == "") {
		content += '<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>';
	}
	$('.completeUl').html(content);
	setModal();
	pagingFunc(j,search);
}

function pagingFunc(j, search) {
	
	var startPage = $('#startPage').val();
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		type : "get",
		url : "/lms/lecture/pageInfo",
		data : {
			"search" : search,
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


//탭클릭시 나오는 데이터
function myLectureInfo(course,cardinal,id,i, portYn) {
	if(i == '1') {
		var urlStr;
		if(portYn == 'Y') {
			urlStr = "/lms/user/getLessonInfo2";
		} else {
			urlStr = "/lms/user/getLessonInfo";
		}
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			cache: false,
			async : false,
			url		: urlStr,
			data    : {
				"course" : course
				,"cardinal" : cardinal
				, "id" : id
			},
			success : function(data) {
				//1. 차시정보 보여주기 2.학습시작버튼을 누르면 차시정보에 있는 url을 띄워준다. 
				var content ="";
				if(data !='') {
					if(portYn =='Y') {
						$.each(data, function(index, item) {
							content += '<li class="class-list board-list d-flex">';
							if(item.ORDER_NUM == 1) {
								allContentsNum+=1;
								content+= '<div class="c-table-num">' + item.CHASI;
								content+= '<input type="hidden" name="seq" value="'+ item.SEQ +'">'
								content+= '</div>';
								content+= '<div class="c-table-name text-over-lh20">' + item.CHAP_NAME + '</div>';
								content+= '<div class="c-table-num"></div>';
								content += '<div class="c-table-num"></div>';
								content += '<div class="c-table-num"></div>';
								content+= '<div class="c-table-02 c-table-btn"></div></li>'
								
								content+= '<li class="class-list board-list d-flex"><div class="c-table-num"><input type="hidden" name="seq" value="'+ item.SEQ +'"></div>';
								content+= '<div class="c-table-name text-over-lh20">' + item.SUBCHAP_NAME + '</div>';
								content+= '<div class="c-table-num">' + item.STUDY + '분</div>';
								content += '<div class="c-table-num"></div>';
								content += '<div class="c-table-num">';
								if(item.PROG_YN == 'Y') {
									doneContents+=1;
			                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
			                    }else if(item.PROG_YN == 'N') {
			                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
			                    }
								content+= '<div class="c-table-02 c-table-btn">'
								content+= '<a class="btn_normal btn_medium btn_orangeD" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+ item.SEQ +','+item.CHASI +',\''+item.PROG_YN+'\',\''+ portYn +'\');">학습하기</a></div></li>';
								return true;
							} else {
								allContentsNum+=1;
								content+= '<div class="c-table-num"><input type="hidden" name="seq" value="'+ item.SEQ +'"></div>';
								content+= '<div class="c-table-name text-over-lh20">' + item.SUBCHAP_NAME + '</div>';
							}
							content+= '<div class="c-table-num">' + item.STUDY + '분</div>';
							content += '<div class="c-table-num"></div>';
							content += '<div class="c-table-num">';
							if(item.PROG_YN == 'Y') {
								doneContents+=1;
		                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
		                    }else if(item.PROG_YN == 'N') {
		                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
		                    }
							content+= '<div class="c-table-02 c-table-btn">'
							content+= '<a class="btn_normal btn_medium btn_orangeD" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+ item.SEQ +','+item.CHASI +',\''+item.PROG_YN+'\',\''+ portYn +'\');">학습하기</a></div></li>';
						});
					} else if(portYn =='N') {
						$.each(data, function(index, lessonList) {
	 						allContentsNum+=1;
	 						var prevProgYn = 'N';
	 						content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
	 						content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
	 						content += '<div class="c-table-num">'+lessonList.STUDY+'분</div>';
	 						content += '<div class="c-table-num"></div>'
	 	                    content += '<div class="c-table-num">'; //수강확인 Y/N
		                    
	 		                    if(lessonList.PROG_YN == 'Y') {
	 		                    	doneContents+=1;
	 		                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
	 		                    }else if(lessonList.PROG_YN == 'N') {
	 		                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
	 		                    }
		                    
	 	                  	// content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="window.open(\''+lessonList.MAIN_URL+'\',\'video\',\'width=1000,height=700,location=no,status=no,scrollbars=yes\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';
	 	                    //content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goStudy('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +','+lessonList.STUDY+','+lessonList.CHK+',\''+lessonList.PROG_YN+'\',\''+lessonList.MAIN_URL+'\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';
	 	                    //content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +',\''+lessonList.PROG_YN+'\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';
	 	                    content += '<div class="c-table-02 c-table-btn"><a class="btn_normal btn_medium btn_orangeD" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +',\''+lessonList.PROG_YN+'\',\''+ portYn +'\');">학습하기</a></div></li>';
	 					});
					}
				} else {
					content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>차시정보가 존재하지 않습니다.</p></div></li>';
				}
				timeChk();
				$('.class-list-wrap.occasion').html(content);
				doneContents=0;
				allContentsNum=0;
			},
			error : function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
			
		});
		
	} else if(i == '2') { //과제 탭
		
   		 $.ajax({
					contentType : "application/json",
					dataType : "json",
					type	: "get",
					url		: "/lms/user/selectExamList",
					cache: false,
					async : false,
					data    : {
						"course" : course
						,"cardinal" : cardinal
						,"quiz_type" : "3"
						, "id" : id
					},
					success : function (data) {
						
						var bContent = "";
						
						if(data != '') {
								$.each(data, function(index, asList) {
									
									bContent += '<li class="listAndwrap reportup">';
									bContent += '<form name="reportForm" method="post" class="form-inline report'+index+'" onsubmit="return false;">';
									bContent += '<input type="hidden" name="id" value="'+id+'" />'
									bContent += '<input type="hidden" name="pagingYn" value="N" />';
									bContent += '<input type="hidden" name="useYn" value="Y" />'
									bContent += '<input type="hidden" name="quiz_type" value="3" />';
									bContent += '<input type="hidden" name="course" value="'+course+'" />';
									bContent += '<input type="hidden" name="cardinal" value="'+cardinal+'" />';
									bContent += '<input type="hidden" name="quiz" value="'+asList.ID+'">';
									bContent += '<input type="hidden" name="takeYn" value="'+asList.TAKE_YN+'">';
									bContent += '<input type="hidden" name="ready" value="'+asList.IS_READY+'">';
									bContent += '<input type="hidden" name="correct" value="'+asList.CORRECT+'">';
									bContent += '</form>';
									bContent += '<div class="class-list board-list open-answer d-flex"><div class="c-table-name-w text-over-lh20">' + /* asList.GUIDE */ asList.TITLE+ '</div>';
	                                if(asList.IS_READY == 'Y') {
	                                    bContent += '<div class="c-table-02 c-table-date">'+ asList.START_DATE + '-' + asList.END_DATE + '</div>';	
	                                } else {
	                                    bContent += '<div class="c-table-02 c-table-date">기간이 끝나 제출이 마감되었습니다.</div>';
	                                }
	                                    
	                                if(asList.TAKE_YN != '0' && asList.USE_YN == 'Y') {
	                                    bContent += '<div class="c-table-01 cDanger">제출</div>';
	                                } else {
	                                    bContent += '<div class="c-table-01 cDanger">미제출</div>';
	                                }
	                                if(!asList.QUIZ_SCORE) {
	                                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></li>';
	                                } else {
	                                    bContent += '<div class="c-table-01"><strong class="score">'+asList.QUIZ_SCORE+'</strong>/'+asList.SCORE+'</div></li>';	
	                                }
								});
						} else {
							bContent += '<li class="class-list d-flex"><div class="c-table-03 not"><p>과제정보가 존재하지 않습니다.</p></div></li>';
						}
						$('.class-list-wrap.assignment').empty().append(bContent);
					},
					error :  function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
					
				}); 
	
		} else if(i == '3') { //시험 탭
// 		<!-- 온라인시험 정답 확인 부분 디자인 >> user/mycampus_onlineTest.html -->
	   	 $.ajax({
					contentType : "application/json",
					dataType : "json",
					type	: "get",
					url		: "/lms/user/selectExamList",
					cache : false,
					async : false,
					data    : {
						"course" : course
						,"cardinal" : cardinal
						,"quiz_type" : "2"
						, "id" : id
					},
					success : function(data) {
							
						var bContent = "";
						if(data != '') {
								$.each(data, function(index, asList) {
									
									if(asList.IS_READY == 'Y') {
										bContent += '<li class="listAndwrap examup">';	
									} else {
										bContent += '<li class="listAndwrap">';
									}
									bContent += '<form name="examForm" method="post" class="form-inline exam'+index+'" onsubmit="return false;">';
									bContent += '<input type="hidden" name="id" value="'+id+'" />'
									bContent += '<input type="hidden" name="pagingYn" value="N" />';
									bContent += '<input type="hidden" name="useYn" value="Y" />'
										bContent += '<input type="hidden" name="quiz_type" value="2" />';
										bContent += '<input type="hidden" name="course" value="'+course+'" />';
										bContent += '<input type="hidden" name="cardinal" value="'+cardinal+'" />';
										bContent += '<input type="hidden" name="quiz" value="'+asList.ID+'">';
										bContent += '<input type="hidden" name="takeYn" value="'+asList.TAKE_YN+'">';
										bContent += '<input type="hidden" name="ready" value="'+asList.IS_READY+'">';
										bContent += '</form>';
				                    bContent += '<div class="class-list board-list open-answer d-flex"> <div class="c-table-name text-over-lh20">' + asList.TITLE + '</div>';
				                    if(asList.IS_READY == 'Y') {
	                                    bContent += '<div class="c-table-02 c-table-date">'+ asList.START_DATE + '-' + asList.END_DATE + '</div>';	
	                                } else {
	                                    bContent += '<div class="c-table-02 c-table-date">기간이 끝나 제출이 마감되었습니다.</div>';
	                                }
				                    if(asList.TAKE_YN != '0' && asList.USE_YN == 'Y') {
	                                    bContent += '<div class="c-table-01 cDanger">제출</div>';
	                                } else {
	                                    bContent += '<div class="c-table-01 cDanger">미제출</div>';
	                                }
				                    if(!asList.QUIZ_SCORE) {
	                                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></div>';
	                                } else {
	                                    bContent += '<div class="c-table-01"><strong class="score">'+asList.QUIZ_SCORE+'</strong>/'+asList.SCORE+'</div></div>';	
	                                }
				                    if(asList.IS_READY != 'Y') {
				                    	bContent +='<div class="open-asw open-ctt"><ul class="class-list-wrap"><li class="aswr-box">';
					                    //bContent +='<li class="icon-align aswr-box d-flex"><div class="c999">결과<br>답안<br>보기</div>';
					                    bContent += "<table class='table table_onlineTest'><thead class='thead'><tr><th colspan='27'>객관식</th><td colspan='3' class='fc_orD'>정답 표기 ○</td></tr></thead>";
					                    
					                     $.ajax({
					                    	url:'<c:url value="/smtp/mypage/selectMyOnlineExamAnswerAjax" />',
					                    	async: false,
					                    	data:{"id":id, "quiz_type":"2","course":course,"cardinal":cardinal,"quiz":asList.ID},
					                    	success: function(result) {
					                    		if(result["result"] == "FAIL") {
					                    			bContent += '<tbody class="tbody"><tr><td>결과값이 없습니다.</td></tr></tbody>'
					                    		} else {
					                    		
					                    		bContent += '<tbody class="tbody">';
					                    		
					                    		for(var i = 0; i < result.quizList.length; i++) {
					                    			var reply = result.replyList[i];
					                    			
					                    			if(i % 5 == 0) {
					                    				bContent += '<tr>';
					                    			}
					                    			
					                    			bContent += '<th class="numberQ">'+(i+1)+'</th>';
					                    			if(result.quizList.EXAM_TYPE == 2) {
					                    				switch(reply.O_ANSWER) {
					                    				case 1:
					                    					switch(reply.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_correct answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td class="answer_correct">1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td>4</td>';
					                    						break;
					                    					}
					                    					break;
					                    				case 2:
					                    					switch(reply.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_correct answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td class="answer_correct">1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td>4</td>';
					                    						break;
					                    					}
					                    					break;
					                    				case 3:
					                    					switch(reply.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_correct answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td class="answer_correct">1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td>4</td>';
					                    						break;
					                    					}
					                    					break;
					                    				case 4:
					                    					switch(reply.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_correct answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td class="answer_correct">1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td>4</td>';
					                    						break;
					                    					}
					                    					break;
					                    				}
					                    			} else {
					                    				switch(reply.O_ANSWER) {
					                    				case 1:
					                    					switch(reply.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_correct answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 5:
					                    						bContent += '<td class="answer_correct">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td class="answer_user">5</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td class="answer_correct">1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td>4</td>';
				                    							bContent += '<td>5</td>';
					                    						break;
					                    					}
					                    					break;
					                    				case 2:
					                    					switch(result.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_user">1</td>';
					                    						bContent += '<td class="answer_correct">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td class="answer_correct answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td class="answer_correct">2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td class="answer_correct">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 5:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td class="answer_correct">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td class="answer_user">5</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td>1</td>';
				                    							bContent += '<td class="answer_correct">2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td>4</td>';
				                    							bContent += '<td>5</td>';
					                    						break;
					                    					}
					                    					break;
					                    				case 3:
					                    					switch(result.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_correct">3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td class="answer_correct">3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_correct answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_correct">3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 5:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_correct">3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td class="answer_user">5</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td >1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td class="answer_correct">3</td>';
				                    							bContent += '<td>4</td>';
				                    							bContent += '<td>5</td>';
					                    						break;
					                    					}
					                    					break;
					                    				case 4:
					                    					switch(result.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_correct">4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_correct">4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td class="answer_correct">4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_correct answer_user">4</td>';
					                    						bContent += '<td>5</td>';
					                    						break;
					                    					case 5:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_correct">4</td>';
					                    						bContent += '<td class="answer_user">5</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td>1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td class="answer_correct">4</td>';
				                    							bContent += '<td>5</td>';
					                    						break;
					                    					}
					                    					break;
					                    				case 5:
					                    					switch(result.O_REPLY) {
					                    					case 1:
					                    						bContent += '<td class="answer_user">1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td class="answer_correct">5</td>';
					                    						break;
					                    					case 2:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td class="answer_user">2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td class="answer_correct">5</td>';
					                    						break;
					                    					case 3:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td class="answer_user">3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td class="answer_correct">5</td>';
					                    						break;
					                    					case 4:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td class="answer_user">4</td>';
					                    						bContent += '<td class="answer_correct">5</td>';
					                    						break;
					                    					case 5:
					                    						bContent += '<td>1</td>';
					                    						bContent += '<td>2</td>';
					                    						bContent += '<td>3</td>';
					                    						bContent += '<td>4</td>';
					                    						bContent += '<td class="answer_correct answer_user">5</td>';
					                    						break;
					                    					default:
					                    						bContent += '<td>1</td>';
				                    							bContent += '<td>2</td>';
				                    							bContent += '<td>3</td>';
				                    							bContent += '<td>4</td>';
				                    							bContent += '<td class="answer_correct">5</td>';
					                    						break;
					                    					}
					                    					break;
					                    				}
					                    			}
					                    			
					                    			if((i+1) % 5 == 0) {
					                    				bContent += '</tr>';
					                    			}
					                    		}
					                    		
					                    		bContent += '</tbody></table></li></ul></div>';
					                    		}
					                    	}
					                    });
				                    } else {
				                    	bContent +='<li></li>';
				                    }
								});
						} else {
							bContent += '<li class="class-list d-flex"><div class="c-table-03 not"><p>시험정보가 존재하지 않습니다.<p></div></li>';
						}
							$('.class-list-wrap.exam').empty().append(bContent);
					},
					error :  function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}
	   	 });
	   
	} else if(i == '4') { //공지사항 탭
		
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/lms/user/courseBoardList",
			cache : false,
			async : false,
			data    : {
				"course" : course
				,"index" : "1" //board_type (공지사항) : 1
			},
			success : function(data) {
				var bContent = "";
				
				if(data != '') {
					$.each(data, function(index, cbList) {
							bContent +='<li class="listAndWrap">';
							bContent += '<div class="class-list board-list open-answer d-flex">';
							bContent += '<div class="c-table-num">' + (index + 1) + '</div>';
							bContent += '<div class="c-table-name-wide "><div class="d-flex icon-align"><div class="img-icon bullhorn-s"></div>';
							bContent += '<p class="text-over-lh20">'+cbList.TITLE+'</p></div></div>';
							bContent += '<div class="c-table-02">'+cbList.REG_DATE.substring(0,4)+"-"+cbList.REG_DATE.substring(4,6)+"-"+cbList.REG_DATE.substring(6,8)+'</div></div>';
							bContent += '<div class="open-asw open-ctt"><ul class="class-list-wrap">';
                            bContent += '<li class="aswr-box">';
                            bContent += '<div class="">'+cbList.COMMENT+'</div>';
                            bContent += '</li></ul></div></li>';
						
						});
					} else {
							bContent += '<li class="class-list board-list d-flex justify_between"><div class="c-table-03 not"><p>게시글정보가 존재하지 않습니다.</p></div></li>';
					}
							$('.class-list-wrap.boardType01').empty().append(bContent);
			},
			error : function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	  
	} else if(i == '5') { //설문조사 탭
		
		if(calStatus < 50) return; // LMS는 진도율이 50%이상일 경우만 설문조사 노출
	
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/lms/user/surveyList",
			cache: false,
			async : false,
			data    : {
				"course" : course
				,"cardinal" : cardinal
			},
			success : function(data) {
				
					var bContent = "";
					if(data != '') {
						$.each(data, function(index, sList) {
							
							if(sList.SURVEY_STATE == 'OPEN'){
								bContent += '<li class="listAndwrap surveyItem">';
								bContent += '<form method="post" class="form-inline survey'+index+'" onsubmit="return false;">';
								bContent += '<input type="hidden" name="survey_seq" value="'+sList.SURVEY_SEQ+'" />'
								bContent += '<input type="hidden" name="survey_title" value="'+sList.SURVEY_TITLE+'" />';
								bContent += '<input type="hidden" name="survey_content" value="'+sList.SURVEY_CONTENT+'" />';
								bContent += '<input type="hidden" name="survey_et" value="'+sList.SURVEY_ET+'" />';
								bContent += '<input type="hidden" name="survey_state" value="OPEN" />';
								bContent += '<input type="hidden" name="survey_answer_state" value="'+sList.SURVEY_ANSWER_STATE+'" />';
								bContent += '<input type="hidden" name="course_id" value="'+course+'" />';
								bContent += '<input type="hidden" name="cardinal_id" value="'+cardinal+'" />';
								bContent += '</form>';
								bContent += '<div class="class-list board-list open-answer d-flex">';
								bContent += '<div class="c-table-num">' + (index + 1) + '</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.COURSE_NM+'</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.SURVEY_TITLE+'</div>';
								bContent += '<div class="c-table-03">'+ sList.SURVEY_ET +'</div>';
								bContent += '<div class="c-table-02">진행중</div>';
								bContent += '</div>';
								
							}else if(sList.SURVEY_STATE == 'CLOSED'){
								bContent += '<li class="listAndwrap surveyItem">';
								bContent += '<form method="post" class="form-inline survey'+index+'" onsubmit="return false;">';
								bContent += '<input type="hidden" name="survey_seq" value="'+sList.SURVEY_SEQ+'" />'
								bContent += '<input type="hidden" name="survey_title" value="'+sList.SURVEY_TITLE+'" />';
								bContent += '<input type="hidden" name="survey_content" value="'+sList.SURVEY_CONTENT+'" />';
								bContent += '<input type="hidden" name="survey_et" value="'+sList.SURVEY_ET+'" />';
								bContent += '<input type="hidden" name="survey_state" value="CLOSED" />';
								bContent += '<input type="hidden" name="survey_answer_state" value="'+sList.SURVEY_ANSWER_STATE+'" />';
								bContent += '<input type="hidden" name="course_id" value="'+course+'" />';
								bContent += '<input type="hidden" name="cardinal_id" value="'+cardinal+'" />';
								bContent += '</form>';
								bContent += '<div class="class-list board-list open-answer d-flex">';
								bContent += '<div class="c-table-num">' + (index + 1) + '</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.COURSE_NM+'</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.SURVEY_TITLE+'</div>';
								bContent += '<div class="c-table-03">'+sList.SURVEY_ST+" - "+sList.SURVEY_ET +'</div>';
								bContent += '<div class="c-table-02">마감</div>';
								bContent += '</div>';
								
							}
						});
				
					/* var bContent = "";
					if(data != '') {
						$.each(data, function(index, sList) {
							
							if(sList.SURVEY_STATE == 'OPEN'){
								bContent += '<li class="listAndwrap surveyItem">';
								bContent += '<form method="post" class="form-inline survey'+index+'" onsubmit="return false;">';
								bContent += '<input type="hidden" name="survey_seq" value="'+sList.SURVEY_SEQ+'" />'
								bContent += '<input type="hidden" name="survey_title" value="'+sList.SURVEY_TITLE+'" />';
								bContent += '<input type="hidden" name="survey_content" value="'+sList.SURVEY_CONTENT+'" />';
								bContent += '<input type="hidden" name="survey_st" value="'+sList.SURVEY_ST+'" />';
								bContent += '<input type="hidden" name="survey_et" value="'+sList.SURVEY_ET+'" />';
								bContent += '<input type="hidden" name="survey_state" value="OPEN" />';
								bContent += '<input type="hidden" name="survey_answer_state" value="'+sList.SURVEY_ANSWER_STATE+'" />';
								bContent += '<input type="hidden" name="course_id" value="'+course+'" />';
								bContent += '<input type="hidden" name="cardinal_id" value="'+cardinal+'" />';
								bContent += '</form>';
								bContent += '<div class="class-list board-list open-answer d-flex">';
								bContent += '<div class="c-table-num">' + (index + 1) + '</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.GISU_NM+'</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.SURVEY_TITLE+'</div>';
								bContent += '<div class="c-table-03">'+sList.SURVEY_ST+" - "+sList.SURVEY_ET +'</div>';
								bContent += '<div class="c-table-02">진행중</div>';
								bContent += '</div>';
								
							}else if(sList.SURVEY_STATE == 'CLOSED'){
								bContent += '<li class="listAndwrap surveyItem">';
								bContent += '<form method="post" class="form-inline survey'+index+'" onsubmit="return false;">';
								bContent += '<input type="hidden" name="survey_seq" value="'+sList.SURVEY_SEQ+'" />'
								bContent += '<input type="hidden" name="survey_title" value="'+sList.SURVEY_TITLE+'" />';
								bContent += '<input type="hidden" name="survey_content" value="'+sList.SURVEY_CONTENT+'" />';
								bContent += '<input type="hidden" name="survey_st" value="'+sList.SURVEY_ST+'" />';
								bContent += '<input type="hidden" name="survey_et" value="'+sList.SURVEY_ET+'" />';
								bContent += '<input type="hidden" name="survey_state" value="CLOSED" />';
								bContent += '<input type="hidden" name="survey_answer_state" value="'+sList.SURVEY_ANSWER_STATE+'" />';
								bContent += '<input type="hidden" name="course_id" value="'+course+'" />';
								bContent += '<input type="hidden" name="cardinal_id" value="'+cardinal+'" />';
								bContent += '</form>';
								bContent += '<div class="class-list board-list open-answer d-flex">';
								bContent += '<div class="c-table-num">' + (index + 1) + '</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.GISU_NM+'</div>';
								bContent += '<div class="c-table-name-wide text-over-lh20">'+sList.SURVEY_TITLE+'</div>';
								bContent += '<div class="c-table-03">'+sList.SURVEY_ST+" - "+sList.SURVEY_ET +'</div>';
								bContent += '<div class="c-table-02">마감</div>';
								bContent += '</div>';
								
							}
						}); */
					}else {
						bContent += '<li class="class-list board-list d-flex justify_between"><div class="c-table-03 not"><p>게시글정보가 존재하지 않습니다.</p></div></li>';
					}
					$('.class-list-wrap.survey').empty().append(bContent);
			},
			error :  function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		
		});
	} else if(i == '6') { //자료실 탭

		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/lms/user/courseBoardList",
			cache: false,
			async : false,
			data    : {
				"course" : course
				,"index" : "2" //board_type (자료실) : 2
			},
			success : function(data) {
				
					var bContent = "";
					data =="";
					if(data != '') {
						
						$.each(data, function(index, cbList) {
							
							bContent +='<li class="listAndWrap">';
							bContent += '<div class="class-list board-list open-answer d-flex">';
							bContent += '<div class="c-table-num">' + (index + 1) + '</div>';
							bContent += '<div class="c-table-name-wide text-over-lh20">'+cbList.TITLE+'</div>';
							//첨부파일 유무
							if(cbList.ATTACH1_FILE != null || cbList.ATTACH2_FILE != null) {
								bContent += '<div class="c-table-01"><a href="/lms/user/downloadFile?file_1='+cbList.ATTACH1_FILE+'&file_2='+cbList.ATTACH2_FILE+'"><div class="img-icon save"></div></a></div>';
							}else {
								bContent += '<div class="c-table-01"></div>';
							}
							bContent += '<div class="c-table-02">'+cbList.REG_DATE.substring(0,4)+"-"+cbList.REG_DATE.substring(4,6)+"-"+cbList.REG_DATE.substring(6,8)+'</div></div>';
							bContent += ' <div class="open-asw open-ctt"><ul class="class-list-wrap">';
							bContent += '<li class="aswr-box"><div class="">'+cbList.COMMENT+'</div></li></ul></div></li>';
						});
					}else {
							
							bContent += '<li class="class-list board-list d-flex justify_between"><div class="c-table-03 not"><p>게시글정보가 존재하지 않습니다.</p></div></li>';
					}
							
							$('.class-list-wrap.boardType02').empty().append(bContent);
					
			},
			error :  function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		
		});
	}/* else if(i == '6') { //출결사항

		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/lms/user/attendanceList",
			cache: false,
			data    : {
				"course" : course
				,"cardinal" : cardinal
			},
			success : function(data) { 
				
					var eventsData=[];
					var startDate;
					var isData=false;
					
					var bContent = "<div id='calendar'></div>";
					
					data =="";
					if(data != '') {
						
						isData=true;
						startDate=data[0].PRESENT_DATE;
						
						$.each(data, function(index, dateList) {
							var status=dateList.STATUS;
							var ecolor;
							if(status=='출석'){
								ecolor='#54f542';
							}else if(status=='결석'){
								ecolor='#eb3477';
							}else if(status=='조퇴'){
								ecolor='#3440eb';
							}else if(status=='지각'){
								ecolor='#ebdc34';
							}
							
							if(dateList.ISGONE=='Y'){
								status+="/외출";
							}
							 
					
							eventsData.push({
								
								start: dateList.PRESENT_DATE,
								end: dateList.PRESENT_DATE+" 22:00:00",
								title:status,
								color:ecolor
								
								
							});
							
						});
						
						
					}else {
							
							bContent += '<li class="class-list board-list d-flex justify_between"><div class="c-table-03 not"><p>출결정보가 존재하지 않습니다.</p></div></li>';
					}
							
							$('.class-list-wrap.attend').empty().append(bContent);
							
							
							if(isData){
							
							$('#calendar').fullCalendar({

								header: {
									left: 'prev,next today',
									center: 'title',
									right: 'year,month,agendaWeek,agendaDay'
								},
							
								firstMonth: new Date().getMonth(), 
								lang:"ko", 
								defaultView: 'month',
								selectable: false,
								selectHelper: true,
								displayEventTime: false,
								firstDay: 0, 
								editable: false,
								eventLimit: true, // allow "more" link when too many events
								events: eventsData
								
							});
							$(".fc-time").hide();
							}
							
							
					
			},
			error :  function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		
		});
	} */
}//함수 종료

function timeChk(){
	
	//var calStatus=0; 설문조사 탭에서도 사용하게 되어서, 맨 위에 공통변수로 선언함.
	
	if(allContentsNum==0){
		calStatus=0;
		$('.progress').html('<span class="checkScore">0</span>점 / <span class="condtnScore">0</span>점');
		$('.graphWrap>.graphGroup>.graph>.graph1').css('width', '0');
	}else{
		calStatus=doneContents/allContentsNum*100;
		$('.progress').html('<span class="checkScore">'+doneContents+'</span> / <span class="condtnScore">'+allContentsNum+'</span>');
		$('.graphWrap>.graphGroup>.graph>.graph1').css('width', 'calc((100% / '+allContentsNum+') *'+ doneContents+'');
	}
// 	console.log("cal"+calStatus);
	
	
	var total=$("input[name=completeTotal]").val();
	calStatus=calStatus.toFixed(1);

	$('.fz34').html(calStatus);
	$('.cMain').html('<span class="calStatus">'+calStatus+'</span>');
	$(".calStatus").html(calStatus);
	$('.learnTotal').html('<strong class="classStatus cDanger">'+doneContents+'</strong>/'+allContentsNum);
	if(calStatus!= 0 && total != 0 && calStatus>=total){
		$(".cDanger").html("수료 기준 달성");
	}
	
	var j = $('.chart .calStatus').text();
    var degRight = 0;
    var degLeft = 180;
    j = parseInt(j);

$('.chart .calStatus').text(calStatus+'%');

$({percent:0}).delay(500).animate({percent : j}, {
    duration : 1500,
    progress : function(){
        var now = parseInt(this.percent),
            deg = now * 360 / 100; //환산식
        degRight = Math.min(180, deg);
        degLeft = Math.max(180, deg);

        $('.chart .calStatus').text(now +'%');

        $('.chart .right li').css({
            transform : 'rotate('+degRight+'deg)'
        });
        $('.chart .left li').css({
            transform : 'rotate('+degLeft+'deg)'
        });
    }
});
}
function setModal() {
	
	$('.modal-popup').click(function() {
		
		//팝업정보 세팅
		var idx = $('.modal-popup').index($(this));
		
		var course = $(':hidden[name="courseId"]').eq(idx).val();
		var cardinal = $(':hidden[name="cardinalId"]').eq(idx).val();
		var learnStartDate = $(':hidden[name="learnStartDate"]').eq(idx).val();
		var learnEndDate = $(':hidden[name="learnEndDate"]').eq(idx).val();
		var realStartDate = $(':hidden[name="realStartDate"]').eq(idx).val();
		var realEndDate = $(':hidden[name="realEndDate"]').eq(idx).val();
		var id = $(':hidden[name="id"]').eq(idx).val();
		var courseName = $(':hidden[name="courseName"]').eq(idx).val();//과정명
		var completeQuizPercent = $(':hidden[name="compQuizPercent"]').eq(idx).val();//평가 반영비율 과제
		var completeExamPercent = $(':hidden[name="compExamPercent"]').eq(idx).val();//평가 반영비율 시험
		var completeProgPercent = $(':hidden[name="compProgPercent"]').eq(idx).val();//평가 반영비율 진도율
		var completeQuizScore = $(':hidden[name="compQuizScore"]').eq(idx).val();//평가 과제 배점
		var completeExamScore = $(':hidden[name="compExamScore"]').eq(idx).val();//평가 시험 배점
		var completeProgScore = $(':hidden[name="compProgScore"]').eq(idx).val();//평가 진도율 배점
		var completeTotal = $(':hidden[name="completeTotal"]').eq(idx).val();//수료조건 총점
		var portYn = $(':hidden[name="portYn"]').eq(idx).val();//포팅여부
		var reviewPeriod = $(':hidden[name="reviewPeriod"]').eq(idx).val();

		//모달>>탭 기능
		var $modaltab = $('#modalTab>.modal-tabGroup>li');
		var $modalsub = $('#modalTab>.modal-subGroup>div');
        var  i = 0;
       	$modaltab.on('click', function(t) {
    	   i = $(this).index(); //자료실,공지사항,과목QnA
    	   $modalsub.hide();
           $modalsub.eq(i).show();
           $('.section .modal-tabGroup>li*').removeClass('active');
           $(this).addClass('active');
            if(i == '1' || i == '2' || i == '3' || i == '4' || i == '5' || i=='6') {
            	myLectureInfo(course,cardinal,id,i, portYn);
            }
        }); 
      
		const oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
		const firstDate = new Date();
		const secondDate = new Date(learnEndDate);
		const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));
		
		//학습현황 정보
		$('.classTitle').html(courseName);
		$('.learn').html(learnStartDate+' - '+learnEndDate);//학습기간
		if(reviewPeriod != 0) {
			$('.recap').html(realStartDate+' - '+realEndDate);//복습기간	
		} else {
			$('.recap').prev().remove();
			$('.recap').remove();
		}
		$('.completeQuizPercent').html(completeQuizPercent);
		$('.completeExamPercent').html(completeExamPercent);
		$('.completeProgPercent').html(completeProgPercent);
		$('.completeQuizScore').html(completeQuizScore);
		$('.completeExamScore').html(completeExamScore);
		$('.completeProgScore').html(completeProgScore);
		$('.completeTotal').html("<b class='c666'>총점 "+completeTotal+"점 이상</b>");
	
		
		$('.countDay').html(diffDays+"일");
		var calStatus=0;
// 		console.log("info :  all"+allContentsNum+"  :  cal"+calStatus+"  :  done"+doneContents);
		if(allContentsNum==0){
			calStatus=0;
			$('.progress').html('<span class="checkScore">0</span>점 / <span class="condtnScore">0</span>점');
			$('.graphWrap>.graphGroup>.graph>.graph1').css('width', '0');
		}else{
			calStatus=doneContents/allContentsNum*100;
			$('.progress').html('<span class="checkScore">'+doneContents+'</span>점 / <span class="condtnScore">'+allContentsNum+'</span>점');
			$('.graphWrap>.graphGroup>.graph>.graph1').css('width', 'calc((100% / '+allContentsNum+') *'+ doneContents+'');
		}
		
		$('.exampro').html('<span class="checkScore">0</span>점 / <span class="conditionScore">'+completeQuizScore+'</span>점');
		$('.graphWrap>.graphGroup>.graph>.graph2').css('width', '0');
		
		$('.workpro').html('<span class="checkScore">0</span>점 / <span class="conditionScore">'+completeExamScore+'</span>점');
		$('.graphWrap>.graphGroup>.graph>.graph3').css('width', '0');
		
		$('.totalScore').html('/ '+completeTotal+'점');
		
		//모달 창이 처음 떴을 때 부모창의 첫번째 탭 데이터가 로드되므로 두번째 탭 눌러서 데이터 로드하고 첫번째 탭 누르게 함
     	timeChk();
      	$('#modalTab>.modal-tabGroup>li:eq(1)').trigger('click');
     	$('#modalTab>.modal-tabGroup>li:eq(0)').trigger('click');
		$('#modal').show();
	});
	
}
$(function() {
	
	setContent(0);
	
	var classTabMenu = $('#mainDisplay >.tabGroup >li');
	var j = 0;
	classTabMenu.on('click', function () {
		$('#pagination').twbsPagination('destroy');
		$('#startPage').val(1);
		$('input[name=search]').val('');
		j = $(this).index();
		if(j == '0' || j == '1' || j == '2') {
			setContent(j);
		}
	});
	setModal();
	$('#searchBtn').on('click', function() {
		$('#pagination').twbsPagination('destroy');
		$('#startPage').val(1);
		setContent(j);
	})

	$(document).on('click', '.board-list.open-answer',function(){
		$(this).next().slideToggle();
  	});
	
	$(document).on('click', '.reportup', function(){
		var idx = $('.reportup').index($(this));
		
		var reportForm = $(".report"+idx+"")[0];
		
// 		console.log(reportForm);
		
		window.open("", "openWindow", "width=900, height=800, resizable=no, scrollbars=yes");
		
		reportForm.action = "<c:url value='/popup/lmsReport' />"; 
		reportForm.target = "openWindow"; 
		
		reportForm.submit();
	});
	
	$(document).on('click', '.examup', function(){
		var a = $(this).find('form[name$=examForm]');
		var idx = $('form[name$=examForm]').index(a);
		
// 		console.log(idx);
		
		var examForm = $(".exam"+idx+"")[0];
		
// 		console.log(examForm);
		
		window.open("", "openWindow", "width=900, height=800, resizable=no, scrollbars=yes");
		
		examForm.action = "<c:url value='/popup/lmsExam' />";
		examForm.target = "openWindow";
		examForm.submit();
	});
	
	$(document).on('click', '.surveyItem', function(){
		var idx = $('.surveyItem').index($(this));
		var surveyForm = $(".survey"+idx+"")[0];
		
		window.open("", "openWindow", "width=900, height=800, resizable=no, scrollbars=yes");
		
		surveyForm.action = "<c:url value='/popup/lmsSurveyDetail' />"; 
		surveyForm.target = "openWindow"; 
		surveyForm.submit();
	});
	
	$('.modal .close-modal').click(function() {
		//모달 닫을때 모달 탭의 데이터가 기존 부모 탭에 append 되므로 부모창 tab 클릭시킴
		$('#mainDisplay > ul.tabGroup > li:eq(0)').trigger('click');
	});
});

</script>
<style type="text/css">
.c-table-03.not {
	line-height : 45px;
	margin : 0 auto;
}

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
	<%@include file="../sub_header.jsp"%>


	<div class="container subPage_container sub07 d-flex">
		<!-- sub07 나의강의실-include -->
		<%@include file="../user/menu/leftmenu07.jsp"%>
		<div class="subPage_content sub-content margin-left20 sub07 sub07-01" id="main">
			<div class="sp_header">
                <div class="header_textWrap">
                    <h3 class="h3">학습현황</h3>
                </div>
            </div>
            <br>
			<div class="section sub07-01 sub07-01-01">
				<!-- 학습현황 탭 -->
				<div class="class-tabMenu" id="mainDisplay">
					<ul class="tabGroup d-flex">
						<li class="active">학습 중</li>
						<li>학습 예정</li>
						<li>학습 종료</li>
					</ul>
					<!-- 과정명 검색 -->
		            <div class="searchWrapper">
		                <div class="class-searchWrap floatR">
		                    <form class="d-flex" id="searchForm">
		                        <div class="class-search-down d-flex">
		                            <input type="text" name="search" class="cusPHIn input" value="${search}" placeholder="과정명을 입력해주세요.">
		                            <!-- 검색버튼 -->
		                            <button type="button" class="button img-icon search" id="searchBtn">
		                            </button>
		                        </div>
		                    </form>
		                </div>
		            </div>
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
						<div class="tab-sub">
							<div class="sub-section">
								<div class="sub-segment">
									<ul class="class-list-title thead d-flex justify_between">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명/기수명</li>
										<li class="c-table-03">학습기간</li>
										<li class="c-table-01">강의실</li>
									</ul>
									<br>
									<ul class="progressUl"></ul>
								</div>
							</div>
						</div>
						<div class="tab-sub hideTab">
							<div class="sub-section">
								<div class="sub-segment">
									<ul class="class-list-title thead d-flex justify_between">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명/기수명</li>
										<li class="c-table-04">학습기간</li>
										<li class="c-table-01">결제상태</li>
									</ul>
									<br>
									<ul class="waitingUl"></ul>
								</div>
							</div>
						</div>
						<div class="tab-sub hideTab">
							<div class="sub-section">
								<div class="sub-segment">
									<ul class="class-list-title thead d-flex justify_between">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명/기수명</li>
										<li class="c-table-04">복습기간</li>
										<li class="c-table-01">수료여부</li>
										<li class="c-table-01"></li>
									</ul>
									<br>
									<ul class="completeUl"></ul>
								</div>
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

	<div class="modal" id="modal">
		<div class="modal-layer"></div>
		<div class="modal-content myClass">
			<!-- 19.11.21 myClass라는 클래스가 추가되었습니다. -->
			<!-- modal 수강신청 1단계 include -->
			<%@include file="../user/modal/modal-sub07-01-01.jsp"%>
		</div>
	</div>
	<!-- footer-include -->
	<%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
