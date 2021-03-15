<%@page import="java.util.Date"%>
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
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/reset.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/user_02_myPage_style.css" />">
<script src="<c:url value="/resources/lms/js/common.js" />"></script>
<script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>
<link rel='stylesheet' href='/resources/js/ext/fullcalendar/css/jquery-ui.min.css' /> 
<link href='/resources/js/ext/fullcalendar/css/fullcalendar.css' rel='stylesheet' />
<link href='/resources/js/ext/fullcalendar/css/fullcalendar.print.css' rel='stylesheet' media='print' /> 
<script src='/resources/js/ext/fullcalendar/js/moment.min.js'></script>
<!--<script src='/resources/js/ext/fullcalendar/js/jquery.min.js'></script> -->
<script src='/resources/js/ext/fullcalendar/js/fullcalendar.min.js'></script>
<script src='/resources/js/ext/fullcalendar/js/lang-all.js'></script>
<script src="<c:url value="/resources/js/Chart.js" />"></script>
<script src="<c:url value="/resources/js/user_02_myPage_script.js" />"></script>

<script type="text/javascript">
var allContentsNum=0;
var doneContents=0;


function goPlayer(id, course, cardinal, chapterId, chasi, progYn) {
	
	$("#chapterForm #id").val(id);
	$("#chapterForm #cardinal").val(cardinal);
	$("#chapterForm #course").val(course);
	$("#chapterForm #chapter").val(chapterId);
	
	var width = 1000;
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
	.attr('action','/smtp/user/player')
	.attr('method','POST')
	.attr('target','playerWindow')
	.submit();
	
	// 학습 여부 아이콘 변경
	$('.progYn').eq(chasi-1).attr('class', 'img-icon attendanceY progYn');
}

//탭클릭시 나오는 데이터
function myLectureInfo(course,cardinal,id,i) {
	if(i == '1') {
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			cache: false,
			url		: "/smtp/user/getLessonInfo",
			data    : {
				"course" : course
				,"cardinal" : cardinal
				, "id" : id
			},
			success : function(data) {
			
				//1. 차시정보 보여주기 2.학습시작버튼을 누르면 차시정보에 있는 url을 띄워준다. 
				var content ="";
				if(data !='') {
					$.each(data, function(index, lessonList) {
						allContentsNum+=1;
						var prevProgYn = 'N'
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
	                    content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +',\''+lessonList.PROG_YN+'\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';


					});
                       
				} else {
					content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>차시정보가 존재하지 않습니다.</p></div></li>';
				}
				timeChk();
				$('.class-list-wrap.modal-ovflowY').html(content);
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
					url		: "/smtp/user/selectExamList",
					cache: false,
					data    : {
						"course" : course
						,"cardinal" : cardinal
						,"quiz_type" : "3"
					},
					success : function (data) {
						
						var bContent = "";
							
						if(data != '') {
								$.each(data, function(index, asList) {

										bContent += '<li class="class-list d-flex">';
	                                    bContent += '<div class="c-table-name-w text-over-lh20">' + asList.GUIDE + '</div>';
	                                    bContent += '<div class="c-table-02 c-table-date">'+ asList.START_DATE + '-' + asList.END_DATE + '</div>';
	                                    bContent += '<div class="c-table-01 cDanger">미제출</div>';
	                                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></li>';
	                                   
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
	
		} else if(i == '3') { //평가 탭
	
	   	 $.ajax({
					contentType : "application/json",
					dataType : "json",
					type	: "get",
					url		: "/smtp/user/selectExamList",
					cache : false,
					data    : {
						"course" : course
						,"cardinal" : cardinal
						,"quiz_type" : "2"
					},
					success : function(data) {
							
						var bContent = "";
						if(data != '') {
								$.each(data, function(index, asList) {
									bContent += '<li class="listAndwrap">';
				                    bContent += '<div class="class-list board-list open-answer d-flex"> <div class="c-table-name text-over-lh20">' + asList.TITLE + '</div>';
				                    bContent += '<div class="c-table-02 c-table-date">'+ asList.START_DATE + '-' + asList.END_DATE + '</div>';
				                    bContent += '<div class="c-table-01 cDanger">미제출</div>';
				                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></div>';
				                    bContent +='<div class="open-asw open-ctt"> <ul class="class-list-wrap"> <li class="icon-align aswr-box d-flex">';
				                    bContent +='<div class="c999">결과<br>답안<br>보기</div>';
				                    bContent +=' <div class="text-over-lh20"> </div></li>';
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
			url		: "/smtp/user/courseBoardList",
			cache : false,
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
							bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>게시글정보가 존재하지 않습니다.</p></div></li>';
					}
							$('.class-list-wrap.boardType01').empty().append(bContent);
			},
			error : function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		});
	  
	} else if(i == '5') { //자료실 탭

		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/smtp/user/courseBoardList",
			cache: false,
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
								bContent += '<div class="c-table-01"><a href="/smtp/user/downloadFile?file_1='+cbList.ATTACH1_FILE+'&file_2='+cbList.ATTACH2_FILE+'"><div class="img-icon save"></div></a></div>';
							}else {
								bContent += '<div class="c-table-01"></div>';
							}
							bContent += '<div class="c-table-02">'+cbList.REG_DATE.substring(0,4)+"-"+cbList.REG_DATE.substring(4,6)+"-"+cbList.REG_DATE.substring(6,8)+'</div></div>';
							bContent += ' <div class="open-asw open-ctt"><ul class="class-list-wrap">';
							bContent += '<li class="aswr-box"><div class="">'+cbList.COMMENT+'</div></li></ul></div></li>';
						});
					}else {
							
							bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>게시글정보가 존재하지 않습니다.</p></div></li>';
					}
							
							$('.class-list-wrap.boardType02').empty().append(bContent);
					
			},
			error :  function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
		
		});
	}else if(i == '6') { //출결사항

		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/smtp/user/attendanceList",
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
							
							bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>출결정보가 존재하지 않습니다.</p></div></li>';
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
	}
}//함수 종료

$(function() {
	$(".modal-popup").on("click", function() {
		var course = $(':hidden[name="course"]').val();
		var cardinal = $(':hidden[name="cardinal"]').val();
		var quiz = $(this).find('.exam_id').val();
		var learnAppId = '${classInfo.ID}';
		
		
		var allData = {"course": course, "cardinal" : cardinal, "quiz" : quiz, "quiz_type" : '3', "id" : learnAppId};
		
		var end = $(this).find('input[name="report_end"]').attr('value');
		var state = $(this).find('input[name="state"]').attr('value');
		var correct = $(this).find('input[name="correct"]').attr('value');
		
		$.ajax({
			url		: '<c:url value="/smtp/mypage/examListAjax" />',
			type	: "POST",
			data: allData,
			success: function(result) {
				var str = "";
				var examInfo = result.examInfo;
				var list = result.list;
				examCount = list.length;
				str += '<div class="h3 classTitle"><' + examInfo.TITLE + '></div>';
				str += "<p> 문제당 배점 : " + examInfo.ITEM_SCORE + "</p>";
				$("#modal_title").append(str);
				
				str = "";
				switch(state) {
				case 'notyet':
					if(end == "end") {
						str += '<ul class="question-list">';
						for(var i = 0; i < list.length; i++) {
							var item = list[i];
							str += '<li>';
							str += '<div class="itme-header">'+ (i+1) +'. '+item.TITLE+'</div>';
						switch(item.OS_TYPE) {
							case 'O':
								str += '<ul class="item-body">';
								str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="'+item.EXAM1+'">' + item.EXAM1+ '</label></li>';
								str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="'+item.EXAM2+'">' + item.EXAM2+ '</label></li>';
								str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="'+item.EXAM3+'">' + item.EXAM3+ '</label></li>';
								str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="'+item.EXAM4+'">' + item.EXAM4+ '</label></li>';
							
								if(item.EXAM_TYPE == '2') {
									str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="'+item.EXAM5+'">' + item.EXAM5+ '</label></li>';
								}
								str += '</ul>';
								break;
							case 'S' :
								str += '<div class="item-body">';
								str += '<div class="html-view">'+item.COMMENT+'</div>';
								str += '<textarea disabled name="answer'+(i+1)+'" rows="8" cols="80"></textarea></div>';
								break;
							}
							str += '</li>';
						}
						str += '</ul>';
					} else {
						str += '<form name="replyForm" id="replyForm" enctype="multipart/form-data">'
						str += '<ul class="question-list">';
						str += '<input type="hidden" name="id" value="'+learnAppId+'">';
						str += '<input type="hidden" name="course" value="'+course+'">';
						str += '<input type="hidden" name="cardinal" value="'+cardinal+'">';
						str += '<input type="hidden" name="quiz" value="'+quiz+'">';
						str += '<input type="hidden" name="quiz_type" value="3">';
						for(var i = 0; i < list.length; i++) {
							var item = list[i];
							str += '<li>';
							str += '<div class="itme-header">'+ (i+1) +'. '+item.TITLE+'</div>';
						switch(item.OS_TYPE) {
							case 'O':
								str += '<ul class="item-body">';
								str += '<li><label><input type="radio" name="answer"'+(i+1)+' value="'+item.EXAM1+'">' + item.EXAM1+ '</label></li>';
								str += '<li><label><input type="radio" name="answer"'+(i+1)+' value="'+item.EXAM2+'">' + item.EXAM2+ '</label></li>';
								str += '<li><label><input type="radio" name="answer"'+(i+1)+' value="'+item.EXAM3+'">' + item.EXAM3+ '</label></li>';
								str += '<li><label><input type="radio" name="answer"'+(i+1)+' value="'+item.EXAM4+'">' + item.EXAM4+ '</label></li>';
							
								if(item.EXAM_TYPE == '2') {
									str += '<li><label><input type="radio" name="answer"'+(i+1)+' value="'+item.EXAM5+'">' + item.EXAM5+ '</label></li>';
								}
								str += '</ul>';
								break;
							case 'S' :
								str += '<div class="item-body">';
								str += '<div class="html-view">'+item.COMMENT+'</div>';
								str += '<textarea name="answer'+(i+1)+'" rows="8" cols="80"></textarea></div>';
								str += '<span>zip, hwp, doc, docx, xlsx, jpg, png, jpeg, txt 파일로 제한합니다.</span><br>';
								str += '<input type="file" class="reportfile" name="reportfile" accept=".zip, .hwp, .doc, .docx, .jpg, .jpeg, .txt, .xlsx">'
								break;
							}
							str += '</li>';
						}
						str += '</ul>';
						str += '</form>';
						str += '<input type="button" id="submitBtn" value="제출">';
						str += '<input type="button" id="cancelBtn" value="취소">';
					}
					$("#modal_content").append(str);
					setLimitkeys(examInfo.LIMIT_KEYS);
					break;
				case 'completed':
					var str = '';
					$.ajax({
						url		: '<c:url value="/smtp/mypage/selectMyOnlineExamAnswerAjax" />',
						type	: "POST",
						data: allData,
						success: function(data) {
							if(data["result"] == "FAIL") {
								alert("응답을 가져오는 데 실패했습니다");
								return;
							}
							
							str = '';
							var reply = data["replyList"];
							var exam = data.examInfo;
						
							if(end == "end") {
								str += '<ul class="question-list">';
							for(var i = 0; i < list.length; i++) {
								var item = list[i];
								str += '<li>';
								str += '<div class="itme-header">'+ (i+1) +'. '+item.TITLE+'</div>';
								switch(item.OS_TYPE) {
								case 'O':
									str += '<ul class="item-body">';
									switch(reply[i].O_REPLY) {
									case item.EXAM1:
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';	
										break;
									case item.EXAM2:
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';
										break;
									case item.EXAM3:
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';
										break;
									case item.EXAM4:
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="4">' + item.EXAM4+ '</label></li>';
										break;
									case item.EXAM5:
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';
										str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="5">' + item.EXAM5+ '</label></li>';
										break;
									}
									
									str += '</ul>';
									break;
								case 'S' :
									str += '<div class="item-body">';
									if(reply[i].SAVED_FILE_NM != null && reply[i].SAVED_FILE_NM != "") {
										str+='<input type="hidden" class="saved" name="saved'+(i+1)+'" value="'+reply[i].SAVED_FILE_NM+'">';
										str+='<input type="hidden" class="origin" name="original'+(i+1)+'" value="'+reply[i].ORIGINAL_FILE_NM+'">';
									}
									str += '<div class="html-view">'+item.COMMENT+'</div>';
									if(reply[i].S_REPLY == null || reply[i].S_REPLY == 'undefined' || reply[i].S_REPLY == undefined || reply[i].S_REPLY == 'null' || reply[i].S_REPLY == '') {
										str += '<textarea name="answer'+(i+1)+'" rows="8" cols="80"></textarea></div>';	
									} else {
										str += '<textarea name="answer'+(i+1)+'" rows="8" cols="80">'+reply[i].S_REPLY+'</textarea></div>';	
									}
									if(reply[i].ORIGINAL_FILE_NM != null && reply[i].ORIGINAL_FILE_NM != "") {
										str+='<div class="download"><span>업로드 파일:</span>&nbsp;&nbsp;<span class="origin_nm"style="cursor:pointer">'+reply[i].ORIGINAL_FILE_NM+'</span></div>';
									}
									break;
								}
								str += '</li>';
							}
							if(correct) {
								str += '<br><li><div class="item-body"><div class="html-view">'+"<첨삭>"+'</div><textarea disabled rows="8" cols="80">'+correct+'</textarea></div></li>';	
							} 
							str += '</ul>';
							} else {
								str += '<form name="replyForm" id="replyForm" enctype="multipart/form-data">'
								str += '<ul class="question-list">';
/* 									str += '<input type="hidden" name="report_id" value="'+reply[0].REPORT_ID+'">';
									str += '<input type="hidden" name="count" value="'+reply.length+'">'; */
								str += '<input type="hidden" name="id" value="'+learnAppId+'">';
								str += '<input type="hidden" name="course" value="'+course+'">';
								str += '<input type="hidden" name="cardinal" value="'+cardinal+'">';
								str += '<input type="hidden" name="quiz" value="'+quiz+'">';
								str += '<input type="hidden" name="quiz_type" value="3">';
								for(var i = 0; i < list.length; i++) {
									var item = list[i];
									str += '<li>';
									str += '<div class="itme-header">'+ (i+1) +'. '+item.TITLE+'</div>';
									switch(item.OS_TYPE) {
									case 'O':
										str += '<ul class="item-body">';
										switch(reply[i].O_REPLY) {
										case item.EXAM1:
											str += '<input type="hidden" name="os_type'+(i+1)+'" value="'+item.OS_TYPE+'">';
											str += '<input type="hidden" name="id'+(i+1)+'" value="'+reply[i].ID+'">';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="1">' + item.EXAM1+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';	
											break;
										case item.EXAM2:
											str += '<input type="hidden" name="os_type'+(i+1)+'" value="'+item.OS_TYPE+'">';
											str += '<input type="hidden" name="id'+(i+1)+'" value="'+reply[i].ID+'">';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="2">' + item.EXAM2+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';
											break;
										case item.EXAM3:
											str += '<input type="hidden" name="os_type'+(i+1)+'" value="'+item.OS_TYPE+'">';
											str += '<input type="hidden" name="id'+(i+1)+'" value="'+reply[i].ID+'">';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="3">' + item.EXAM3+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';
											break;
										case item.EXAM4:
											str += '<input type="hidden" name="os_type'+(i+1)+'" value="'+item.OS_TYPE+'">';
											str += '<input type="hidden" name="id'+(i+1)+'" value="'+reply[i].ID+'">';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="4">' + item.EXAM4+ '</label></li>';
											break;
										case item.EXAM5:
											str += '<input type="hidden" name="os_type'+(i+1)+'" value="'+item.OS_TYPE+'">';
											str += '<input type="hidden" name="id'+(i+1)+'" value="'+reply[i].ID+'">';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="1">' + item.EXAM1+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="2">' + item.EXAM2+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="3">' + item.EXAM3+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' value="4">' + item.EXAM4+ '</label></li>';
											str += '<li><label><input disabled type="radio" name="answer"'+(i+1)+' checked="checked" value="5">' + item.EXAM5+ '</label></li>';
											break;
										}
										
										str += '</ul>';
										break;
									case 'S' :
										str += '<div class="item-body">';
										str += '<input type="hidden" name="os_type'+(i+1)+'" value="'+item.OS_TYPE+'">';
										str += '<input type="hidden" name="id'+(i+1)+'" value="'+reply[i].ID+'">';
										if(reply[i].SAVED_FILE_NM != null && reply[i].SAVED_FILE_NM != "") {
											str+='<input type="hidden" class="saved" name="saved'+(i+1)+'" value="'+reply[i].SAVED_FILE_NM+'">';
											str+='<input type="hidden" class="origin" name="original'+(i+1)+'" value="'+reply[i].ORIGINAL_FILE_NM+'">';
										}
										str += '<div class="html-view">'+item.COMMENT+'</div>';
										if(reply[i].S_REPLY == null || reply[i].S_REPLY == 'undefined' || reply[i].S_REPLY == undefined || reply[i].S_REPLY == 'null' || reply[i].S_REPLY == '') {
											str += '<textarea name="answer'+(i+1)+'" rows="8" cols="80"></textarea></div>';	
										} else {
											str += '<textarea name="answer'+(i+1)+'" rows="8" cols="80">'+reply[i].S_REPLY+'</textarea></div>';	
										}

										str += '<span>zip, hwp, doc, docx, xlsx, jpg, png, jpeg, txt 파일로 제한합니다.</span><br>';
										str += '<input type="file" class="reportfile" name="reportfile" accept=".zip, .hwp, .doc, .docx, .jpg, .jpeg, .txt, .xlsx">';
										if(reply[i].ORIGINAL_FILE_NM != null && reply[i].ORIGINAL_FILE_NM != "") {
											str+='<div class="download"><span>업로드 파일:</span>&nbsp;&nbsp;<span class="origin_nm" style="cursor:pointer">'+reply[i].ORIGINAL_FILE_NM+'</span></div>';
										}
										break;
									}
									str += '</li>';
								}
								str += '</ul>';
								str += '</form>';
								str += '<input type="button" id="submitBtn" value="제출">';
								str += '<input type="button" id="cancelBtn" value="취소">';
							}
							$("#modal_content").append(str);
							setLimitkeys(examInfo.LIMIT_KEYS);
						}
					});
					break;
				}
			}
		});
		
	});
	
	$(document).on("click", ".download", function(){
		var user = '${sessionScope.user_id}'; 
		var cardinal = $(':hidden[name="cardinal"]').val();
		var origin = $(this).children('.origin_nm').text();
		var saved = $(this).parent().find('.saved').val();
		
		location.href = "/file_download?origin="+origin+"&saved="+saved+"&path=report/files/"+ user + "_" + cardinal;
	})
	
	/* $(document).on('click', "#updateBtn", function(){
		if(!confirm("다시 제출하시겠습니까?")) {
			return;
		}
		
		$.ajax({
			url		: '<c:url value="/smtp/mypage/updateReply" />',
			type	: "POST",
			data: $("form[name='replyForm']").serialize(),
			success: function(result) {
					if(result["result"] == "SUCCESS") {
						alert("제출 성공");
					} else {
						alert("제출 실패");
					}
			},
			complete: function() {
				$('.modal').hide();
				location.reload(true);
			}
		});
	}); */
	
	$(document).on("click","#submitBtn",function(){
		if(!confirm("제출하시겠습니까?")) {
			return;
		}
		
		if(!checkInputReport()) {
			alert("내용 또는 파일을 입력하여 주십시오.");
			return;
		}
		var formData = new FormData($('#replyForm')[0]);
		$.ajax({
			url		: '<c:url value="/smtp/mypage/reportTakeAjax" />',
			type	: "POST",
			data: formData,
			dataType:'json',
			processData: false,
	    	contentType: false,
			success: function(result) {
					
					if(result["result"] == "SUCCESS") {
						alert("제출 성공");
					} else {
						alert("제출 실패");
					}
			},
			complete: function() {
				$('.modal').hide();
				location.reload(true);
			}
		});
		//모달 닫을때 모달 탭의 데이터가 기존 부모 탭에 append 되므로 새로고침 해주었음
	});
	
	//submitBtn event 끝
	
	$(document).on("click","#cancelBtn",function(){
		$('.modal').hide();
		location.reload(true);
		//모달 닫을때 모달 탭의 데이터가 기존 부모 탭에 append 되므로 새로고침 해주었음
	}); 
	
	//*********모달 창 닫는 x아이콘 나오게!
	$('.modal .close-modal').click(function() {
	 //모달 닫을때 모달 탭의 데이터가 기존 부모 탭에 append 되므로 새로고침 해주었음
		location.reload(true);
	});
	
}); //ready ftn끝

function checkInputReport() {
	var isAnswer = false;
	for (var i = 0; i < examCount; i++) {
		if($("textarea[name='answer"+(i+1)+"']").val()) {
			isAnswer = true;		// 한 항목이라도 입력한 경우
			break;
		}
	}

	var isFile = true;
	
	$(".reportfile").each(function(){
		if(!$(this).val()) {
			isFile = false;
		}
	})
	
	if( !$(".reportfile").val()) isFile =  false; // 파일이 선택이 안된 경우에는

	if(!isAnswer && !isFile) return false; //모두 입력이 안된 경우에는 
	
	return isAnswer || isFile;
}

function setLimitkeys(limit_keys) {
	if(limit_keys.includes('1') && limit_keys.includes('2') && limit_keys.includes('3') && limit_keys.includes('4') && limit_keys.includes('5')) {
		$("#modal_content").on("keydown", function(event){
			 
			if (event.ctrlKey && event.keyCode == 67) {
				event.preventDefault();
				alert("CTRL + C 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 86) {
		    	event.preventDefault();
		    	alert("CTRL + V 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 70) {
		    	event.preventDefault();
		    	alert("CTRL + F 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 80){
		    	event.preventDefault();
		    	alert("CTRL + P 는 제한된 키입니다.");
		    }
		})
		$("#modal_content").on("mousedown", function(event){
			if (event.type == "mousedown" && event.which == 3) {
				event.preventDefault();
				alert("우클릭은 제한됩니다.");
		    }
		})		
	} else if(limit_keys.includes('1') && limit_keys.includes('2') && limit_keys.includes('3') && limit_keys.includes('4')) {
		$("#modal_content").on("keydown", function(event){
			
			if (event.ctrlKey && event.keyCode == 67) {
				event.preventDefault();
				alert("CTRL + C 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 86) {
		    	event.preventDefault();
		    	alert("CTRL + V 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 80){
		    	event.preventDefault();
		    	alert("CTRL + P 는 제한된 키입니다.");
		    }    
		})
		$("#modal_content").on("mousedown", function(event){
			if (event.type == "mousedown" && event.which == 3) {
				event.preventDefault();
				alert("우클릭은 제한됩니다.");
		    }
		})
	} else if(limit_keys.includes('1') && limit_keys.includes('2') && limit_keys.includes('3')) {
		$("#modal_content").on("keydown", function(event){
			 
			if (event.ctrlKey && event.keyCode == 67) {
				event.preventDefault();
				alert("CTRL + C 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 86) {
		    	event.preventDefault();
		    	alert("CTRL + V 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 80){
		    	event.preventDefault();
		    	alert("CTRL + P 는 제한된 키입니다.");
		    }
		})
	} else if(limit_keys.includes('1') && limit_keys.includes('2')) {
		$("#modal_content").on("keydown", function(event){
			 
			if (event.ctrlKey && event.keyCode == 67) {
				event.preventDefault();
				alert("CTRL + C 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 80){
		    	event.preventDefault();
		    	alert("CTRL + P 는 제한된 키입니다.");
		    }
		})
	} else if(limit_keys.includes('1')) {
		$("#modal_content").on("keydown", function(event){
			 
			if (event.ctrlKey && event.keyCode == 67) {
				event.preventDefault();
				alert("CTRL + C 는 제한된 키입니다.");
		    }
		})
	} 
}
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
	<%@include file="header.jsp"%>


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
				<div class="titleBar h3">온라인 과제</div>
				<!-- <h3 class="h3"></h3> -->
			</div>
			<div class="section">
                <div class="articleWrapper" id="assignment">
<!--                     <div class="articleHdr pointBg d-flex"> -->
<!--                         <a href="#" class="d-flex"> -->
<!--                             <div class="img-icon file-alt_wh"></div> -->
<!--                             <div class="HdrTitle">설문관리</div> -->
<!--                         </a> -->
<!--                     </div> -->
                    <div class="articleWrap">
						<table class="tab_table table">
                            <thead>
                                <tr>
                                    <th class="tt_w5">#</th>
                                    <th class="tt_w20">과제명</th>
                                    <th class="tt_w50">과제기간</th>
                                    <th class="tt_w15">제출여부</th>
                                    <th class="tt_w10">점수</th>
                                </tr>
                            </thead>
                            <tbody id="surveyBody">
 								<input type="hidden" value="${course_id}" name="course">
                            	<input type="hidden" value="${cardinal_id}" name="cardinal">
                            	<c:if test="${!empty examList }">
                                	<c:forEach var="item" items="${examList }" varStatus="status">
                             			<c:choose>
                               				<c:when test="${item.IS_READY == 'Y' }">
                               					<tr class="cGray act modal-popup">
                               						<input type="hidden" value="notyet" name="report_end">
		                                			<td class="tt_w5">${status.count }</td>
		                                			<td class="tt_w20 survey_content">
		                                				${item.TITLE }
		                                				<input type="hidden" class="exam_id" value="${item.ID}">
		                                			</td>
		                                			<td class="tt_w50 survey_dt">${item.START_DATE } ~ ${item.END_DATE }</td>
		                                			<td class="tt_w15 survey_title">
		                                				<c:if test="${item.USE_YN eq 'Y'  && item.TAKE_YN eq '0'}">
		                                					<input type="hidden" value="notyet" name="state">
		                                					<em class="cDanger">미제출</em>
		                                				</c:if>
														<c:if test="${item.USE_YN eq 'Y'  && item.TAKE_YN ne '0'}">
															<input type="hidden" value="completed" name="state">
															<em class="cPrimary">제출</em>
														</c:if>
		                                			</td>
		                                			<td class="tt_w10">
														<strong>${item.QUIZ_SCORE}</strong>/${item.SCORE}
		                                			</td>
                               					</tr>
                               		 		</c:when>
                               				<c:otherwise>
		                                		<tr class="cGray die modal-popup">
		                                			<input type="hidden" value="end" name="report_end">
           				                			<td class="tt_w5">${status.count }</td>
                          							<td class="tt_w20 survey_content">
		                                				${item.TITLE }
		                                				<input type="hidden" class="exam_id" value="${item.ID}">
		                                			</td>
                           							<td class="tt_w50 survey_dt">기간이 끝나 제출이 마감되었습니다.</td>
                           							<td class="tt_w15 survey_title">
		                                				<c:if test="${item.USE_YN eq 'Y'  && item.TAKE_YN eq '0'}">
		                                					<input type="hidden" value="notyet" name="state">
		                                					<em class="cDanger">미제출</em>
		                                				</c:if>
														<c:if test="${item.USE_YN eq 'Y'  && item.TAKE_YN ne '0'}">
															<input type="hidden" value="completed" name="state">
															<input type="hidden" value="${item.CORRECT}" name="correct">
															<em class="cPrimary">제출</em>
														</c:if>
		                                			</td>
	                               					<td class="tt_w10">
														<strong>${item.QUIZ_SCORE}</strong>/${item.SCORE}
		                                			</td>
                           						</tr>
                                			</c:otherwise>
                                		</c:choose> 
                                	</c:forEach>
                                </c:if>
                                
                                <!-- <tr>
                                    <td class="tt_w5">1</td>
                                    <td class="tt_w25">20-07-30</td>
                                    <td class="tt_w55">천자만홍이 고행을 교향악이다.</td>
                                    <td class="tt_w25">응답완료</td>
                                </tr>
                                마감된 설문 tr에 class="cGray" 추가
                                <tr class="cGray">
                                    <td class="tt_w5">4</td>
                                    <td class="tt_w25">20-07-29</td>
                                    <td class="tt_w55">별과 구하지 이상의 가는 그들의 속잎나고, 천자만홍이 고행을 교향악이다.</td>
                                    <td class="tt_w25">마감</td>
                                </tr> -->
                            </tbody>
                        </table>
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
			<%@include file="../smtp_lecture/modal/modal-sub07-01-03.jsp"%>
		</div>
	</div>
	<!-- footer-include -->
	<%@include file="../smtp_lecture/footer.jsp"%>
	
</body>

</html>