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
var examCount;
var takecount = 0;
$(function() {
	
	$(".modal-popup").on("click", function() {
//		var course = $(':hidden[name="course"]').val();
//		var cardinal = $(':hidden[name="cardinal"]').val();
//		var quiz = $(this).find('.exam_id').val();
//		var learnAppId = '${classInfo.ID}';
		
//		console.log(quiz);
		
//		var allData = {"course": course, "cardinal" : cardinal, "quiz" : quiz, "quiz_type" : '3', "id" : learnAppId};
		
		var end = $(this).find('input[name="report_end"]').attr('value');
		var state = $(this).find('input[name="state"]').attr('value');
		
		if(end != "end" && state != "completed") {
			if (!confirm("시험에 응시하시겠습니까?")) {
				$('.modal').hide();
				location.reload(true);
				return;
			}
		}
		
		var quiz = $(this).find('.exam_id').val();
		$("#quizForm #quiz").val(quiz);
		
		var params = $("#quizForm").serialize();
		
		$.ajax({
			url		: '<c:url value="/smtp/mypage/examListAjax" />',
			type	: "POST",
			data: params,
			success: function(result) {
				var str = "";
				var examInfo = result.examInfo;
				var list = result.list;
				
				/* if (list.length < 1) {
					alert("온라인 시험 준비 중입니다.");
					$('.modal').hide();
					location.reload(true);
					return;
				} */
				
				// 확정전까지 주석처리
/* 				if (examInfo.TAKE_COUNT > takecount) {
					$('.modal').hide();
					location.reload(true);
					alert('이미 응시하셨습니다.');
					return;
				}
 */				
				
				//서버시간(데이터베이스)을 기준으로 시험실 입자시간을 출력함.
				$("#question-list").empty();
				examCount = list.length;//문항수 저장
				
				str += '<div class="h3 classTitle"><' + examInfo.TITLE + '></div>';
				str += "<p> 문제당 배점 : " + examInfo.ITEM_SCORE + " 점</p>";
				str += "<p> 시험 시간 : " + examInfo.EXAM_TIME + " 분</p>"
				str += '<input type="hidden" id="quiz_seq" value="' + examInfo.SEQ + '"><br>';
				$("#modal_title").append(str);
				
				str = "";
				switch(state) {
				case 'notyet':
					if(end == "end") {
						$("#takeExamTime").remove();
						$(".label").remove();
						
						for(var i = 0; i < list.length; i++) {
							var item = list[i];
							
						switch(item.OS_TYPE) {
							case 'O':
								str += '<li>';
								str += "<div class='item-header'>"+item.TITLE+"</div>";
								str += "<ol class='item-body'>";
								str += '<li><label><input disabled type="radio" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
								str += '<li><label><input disabled type="radio" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
								str += '<li><label><input disabled type="radio" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
								str += '<li><label><input disabled type="radio" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
							
								if(item.EXAM_TYPE == '2') {
									str += '<li><label><input disabled type="radio" name="answer'+(i+1)+'" value="5">' + item.EXAM5+ '</label></li>';
								}
								str += '</ol>';
								break;
							case 'S' :
								str += '<div class="item-body">';
								str += '<div class="html-view">'+item.COMMENT+'</div>';
								str += '<textarea disabled style="resize: none;" name="answer'+(i+1)+'" rows="8" cols="80"></textarea></div>';
								break;
							}
							str += '</li>';
							str += '<br>';
						}
						$('#btnSubmit').remove();
						$('#btnCancel').remove();
						$("#question-list").append(str);
					} else {
						for(var i = 0; i < list.length; i++) {
							var item = list[i];
							
						switch(item.OS_TYPE) {
							case 'O':
								str += '<li>';
								str += '<input type="hidden" name="item'+(i+1)+'" value="'+item.ID+'">';
								str += '<input type="hidden" name="bank'+(i+1)+'" value="'+item.QUIZ_BANK_ID+'">';
								str += '<input type="hidden" name="count" value="'+list.length+'">';
								str += '<div class="item-header">'+item.TITLE+"</div>";
								str += '<ol class="item-body">';
								if(result.replyList == '' || result.replyList == null || result.replyList == 'undefined' || result.replyList == undefined || result.replyList == 'null') {
									str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
									str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
									str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
									str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
								
									if(item.EXAM_TYPE == '2') {
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="5">' + item.EXAM5+ '</label></li>';
									}
								} else {
									var reply = result.replyList[i].O_REPLY;
									switch(reply) {
									case 1:
										str += '<li><label><input type="radio" onclick="updateReply(value)" checked="checked" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
										break;
									case 2:
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" checked="checked" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
										break;
									case 3:
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" checked="checked" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
										break;
									case 4:
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" checked="checked" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
										break;
									case 5:
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" checked="checked" name="answer'+(i+1)+'" value="5">' + item.EXAM5+ '</label></li>';
										break;
									default:
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
								
										if(item.EXAM_TYPE == '2') {
											str += '<li><label><input type="radio" onclick="updateReply(value)" name="answer'+(i+1)+'" value="5">' + item.EXAM5+ '</label></li>';
										}
										break;
									}
								}
								str += '</ol>';
								break;
							case 'S' :
								str += '<div class="item-body">';
								str += '<div class="html-view">'+item.COMMENT+'</div>';
								str += '<textarea name="answer'+(i+1)+'" rows="8" cols="80"></textarea></div>';
								break;
							}
							str += '</li>';
							str += '<br>';
						}
						$("#question-list").append(str);
						eventReassign();
						
						setLimits(examInfo.LIMITS);
						
						if(takecount == 1 || state == "notyet") {
							saveExamHistory();
						}
						
						var date = takeExamTime();
						var diff = getDiffDatetime(date.date);
						$("#takeExamTime").text(date.start);
						startTime(examInfo.EXAM_TIME, diff);
						
						
						if(takecount != 1) {
							$('.modal').hide();
							location.reload(true);
							alert('이미 응시하셨습니다.');
							return;
						}
						
						setLimitkeys(examInfo.LIMIT_KEYS);
						
						//setCheatPrevent();
					}
					break;
				case 'completed':
					$.ajax({
						url		: '<c:url value="/smtp/mypage/selectMyOnlineExamAnswerAjax" />',
						type	: "POST",
						data: params,
						success: function(data) {
							if(data["result"] == "FAIL") {
								alert("응답을 가져오는 데 실패했습니다");
								return;
							}
							
							var classInfo = data.classInfo;
							// var examInfo = data.examInfo;
							var reportInfo = data.reportInfo;
							var list = data.quizList;
							var answerList = data.replyList;
							
							str = '';
						
							if(end == "end") {
								$('.header .classTitle').text("온라인 시험 결과 확인");
								
								$('#modal_content').empty();
								str += '<ul class="myanswer-summary group">';
								str += '<li><em class="label">점수</em>&nbsp;<span class="danger"><strong><span id="total_score">'+reportInfo.SCORE+'</span>점</strong>(<span id="right_count"></span>/<span id="total_count">'+list.length+'</span>)</span></li>';
								str += '</ul>';
								str += '<ol class="question-list" id="question-list">';
								str += '</ol>';
								
								$('#modal_content').append(str);
								
								var right_count = 0;	
								for(var i = 0; i < list.length; i++) {
								
									switch(list[i].OS_TYPE) {
									case 'O':
										if (list[i].O_ANSWER==answerList[i].O_REPLY) right_count++;
										
										var quiz = "<li class='"+(list[i].O_ANSWER==answerList[i].O_REPLY?"answer-right":"answer-unright")+"'>";
										quiz += "<div class='item-header'>"+list[i].TITLE+"<strong class='right-answer'>(기재: "+answerList[i].O_REPLY+"번 / 정답: "+list[i].O_ANSWER+"번)</strong></div>";
										quiz += "<ol class='item-body'>";
										quiz += "<li class='"+(list[i].O_ANSWER=="1"?"right ":"") +(answerList[i].O_REPLY=="1"?"check  ":"") +"'><span>"+list[i].EXAM1+"</span></li>";
										quiz += "<li class='"+(list[i].O_ANSWER=="2"?"right ":"") +(answerList[i].O_REPLY=="2"?"check   ":"") +"'><span>"+list[i].EXAM2+"</span></li>";
										quiz += "<li class='"+(list[i].O_ANSWER=="3"?"right ":"") +(answerList[i].O_REPLY=="3"?"check   ":"") +"'><span>"+list[i].EXAM3+"</span></li>";
										quiz += "<li class='"+(list[i].O_ANSWER=="4"?"right ":"") +(answerList[i].O_REPLY=="4"?"check   ":"") +"'><span>"+list[i].EXAM4+"</span></li>";

										if(list[i].EXAM_TYPE == 2)
											quiz += "<li class='"+(list[i].O_ANSWER=="5"?"right ":"") +(answerList[i].O_REPLY=="5"?"check   ":"") +"'><span>"+list[i].EXAM5+"</span></li>";

										quiz += "</ol>";
										quiz += "</li>";
										$("#question-list").append(quiz);
										break;
									case 'S' :
										str += '<div class="item-body">';
										str += '<div class="html-view">'+item.COMMENT+'</div>';
										str += '<textarea disabled name="answer'+(i+1)+'" rows="8" cols="80">'+reply[i].S_REPLY+'</textarea></div>';
										break;
									}
								}
								
								$("#right_count").text(right_count);
								$('.right').css('font-weight', 'bold').css('color', 'blue');
							} else {
								/* for(var i = 0; i < list.length; i++) {
									var item = list[i];
									
									switch(item.OS_TYPE) {
									case 'O':
										str += '<li>';
										str == '<input type="hidden" name="item"'+(i+1)+' value="'+item.ID+'">';
										str == '<input type="hidden" name="bank"'+(i+1)+' value="'+item.QUIZ_BANK_ID+'">';
										str += '<div class="item-header">'+item.TITLE+"</div>";
										str += '<ol class="item-body">';
										str += '<li><label><input type="radio" name="answer'+(i+1)+'" value="1">' + item.EXAM1+ '</label></li>';
										str += '<li><label><input type="radio" name="answer'+(i+1)+'" value="2">' + item.EXAM2+ '</label></li>';
										str += '<li><label><input type="radio" name="answer'+(i+1)+'" value="3">' + item.EXAM3+ '</label></li>';
										str += '<li><label><input type="radio" name="answer'+(i+1)+'" value="4">' + item.EXAM4+ '</label></li>';
									
										if(item.EXAM_TYPE == '2') {
											str += '<li><label><input type="radio" name="answer"'+(i+1)+' value="5">' + item.EXAM5+ '</label></li>';
										}
										str += '</ol>';
										break;
									case 'S' :
										str += '<div class="item-body">';
										str += '<div class="html-view">'+item.COMMENT+'</div>';
										str += '<textarea name="answer'+(i+1)+'" rows="8" cols="80"></textarea></div>';
										break;
									}
									str += '</li>';
									str += '<br>';
								}
								$("#question-list").append(str); */
/* 								eventReassign();
								startTime(examInfo.EXAM_TIME, diff);
								setLimits(examInfo.LIMITS);
								
								console.log(examInfo.TAKE_COUNT);
								console.log(takecount); */
								
								
									$('.modal').hide();
									location.reload(true);
									alert('이미 응시하셨습니다.');
									return;
								
								
/* 								setLimitkeys(examInfo.LIMIT_KEYS);
								
								setCheatPrevent(); */
							}
						}
					});
					break;
				}
			}
		});
	});
	
	//*********모달 창 닫는 x아이콘 나오게!
	$('.modal .close-modal').click(function() {
	 //모달 닫을때 모달 탭의 데이터가 기존 부모 탭에 append 되므로 새로고침 해주었음
		$('.modal').hide();
		location.reload(true);
	});

	//quizForm
	$(document).on("click","#btnSubmit", function(event){
		unsetCheatPrevent();
		if (!confirm("제츨하시겠습니까?")) {
			setCheatPrevent();
			return;
		}
		
		if(!checkInputExam()) {//답안선택여부 확인
			alert("답안을 선택해 주십시오.");
			setCheatPrevent();
			return;
		}
		
		submitExam();
		var cname = "quiz_timer_" + $("#quizForm #quiz").val();
		deleteCookie(cname);
		clearInterval(timer);
		timer = null;
		$('.modal').hide();
		location.reload(true);
	});

	$(document).on("click","#btnCancel", function(event){
		if(!confirm("취소하시겠습니까?")) {
			return;
		}
		
		popupCloseExam();
	});
	
}); //ready ftn끝

function updateReply(value) {
	var params = $("#quizForm").serialize();
	$.ajax({
		url:'<c:url value="/smtp/mypage/updateReply" />',
		type:'POST',
		async:false,
		data:params,
		dataType:'json'
});
}

function getDiffDatetime(time) { 

   	var year = time.substring(0, 4);

   	var month = time.substring(5, 7) - 1  //서버와의 '월'데이터 불일치. -1로 보정

   	var day = time.substring(8, 10)

   	var hour = time.substring(11, 13)

   	var minute = time.substring(14, 16)

   	var second = time.substring(17, 19)

   	var d = new Date(year, month, day, hour, minute, second)

   	var mTime =  d.getTime();

   	var now = new Date();
   
   	var diff;
   	if(mTime > now.getTime()) {
		diff = 0;
   	} else {
   		diff = (now.getTime() - mTime)/1000;
   	}
   	
   	return diff.toFixed(0);
}

function checkInputExam() {
	for (var i = 0; i < examCount; i++) {
		if(!$("input:radio[name='answer"+(i+1)+"']:checked").val()) return false;
	}

	return true;
}

function saveExamHistory() {
	var params = $("#quizForm").serialize();
	$.ajax({
			url:'<c:url value="/smtp/mypage/examTakeHistAjax" />',
			type:'POST',
			async: false,
			data:params,
			dataType:'json'
	});
}

function takeExamTime() {
	var params = $("#quizForm").serialize();
	var time;
	$.ajax({
			url:'<c:url value="/smtp/mypage/selectExamTime" />',
			type:'POST',
			data:params,
			async:false,
			dataType:'json',
			success : function(data) {
				time = data;
			}
	});
	return time;
}

function submitExam() {
	var params = $("#quizForm").serialize();
	$.ajax({
			url:'<c:url value="/smtp/mypage/examTakeAjax" />',
			type:'POST',
			data:params,
			async: false,
			dataType:'json',
			success:function(data){
				if(data.result == "SUCCESS") {
				  	alert("제출되었습니다.");
				} else {
					alert("제출에 문제가 발생하였습니다. 관리자에게 문의바랍니다.");
				}
			  /* 	location.reload(); */
			}
	});
}

var timer;
var seconds = 0;//초기0초
var pad = function(x) { return (x < 10) ? "0"+x : x; }
function startTime(timeLimit, diff) {
	var cname = "quiz_timer_" + $("#quizForm #quiz").val();
	var savedSeconds = getCookie(cname);
	
	if (savedSeconds < 1) savedSeconds = null;	// 시간 만료시 다음 응시 때 부자연스러운 엑션으로 추가
	
	seconds = savedSeconds!=null ? savedSeconds : timeLimit*60;

	if(diff != 0) {
		seconds = seconds - diff;
	}
	calculateTime(); //최초 1회 실행

	if (timer != null) {
		clearInterval(timer);
		timer = null;
	}
	timer = setInterval(calculateTime, 1000); //1초후 1초마다 반복 실행
}

function calculateTime() {
	seconds--;
	var hour = pad(parseInt(seconds / (60*60)));
	var minute = pad(parseInt(seconds / 60 % 60));
	var second = pad(seconds % 60);
	var time = hour + ":" + minute + ":" + second;
	$("#timeLimit").text(time);
	
	var cname = "quiz_timer_" + $("#quizForm #quiz").val();
	setCookie(cname, seconds, 365);

	if(seconds < 1){	//시간소요에 따른 자동 제출 진행.
		unsetCheatPrevent();
		alert("시험시간이 종료되어 자동 제출됩니다.");
		submitExam();
		$('.modal').hide();
		location.reload(true);
	}
}

function eventReassign() {
	/*화면에 엘리먼트가 추가되면서 이벤트 재할당이 필요.*/
	$(".question-list .item-body input[type=radio]").click(function(){
		$(this).parent('label').parent('li').parent('ol').children().removeClass("check");
		$(this).parent('label').parent('li').addClass("check");
	});
	$(".question-list .item-body input[type=checkbox]").click(function(){
			$(this).parent('label').parent('li').toggleClass("check");
	});
}

function popupCloseExam() {
	if (timer != null) {
		clearInterval(timer);
		timer = null;
	}
	unsetCheatPrevent();
	
	$('.modal').hide();
	location.reload(true);
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

function setLimits(limits) {
	if(!limits.includes('1')) {
		clearInterval(timer);
		timer = null;
		$("#timeLimit").text("");
		var cname = "quiz_timer_" + $("#quizForm #quiz").val();
		deleteCookie(cname);
	}
	if(limits.includes('2')) {
		takecount = 1;
	}
}

// 시험응시 부정방지
var cheatCount = 0;
function setCheatPrevent() {
	cheatCount = 0;
	$(window).on('blur', function() {
		unsetCheatPrevent();
		_cheatCatch();

		setTimeout(function() {
			$(window).on('blur', function() {
				unsetCheatPrevent();
				_cheatCatch();
			});
		}, 100);
	});
}

function _cheatCatch() {
	/* alert("마우스 이탈로 자동 제출됩니다.");
	submitExam(); */
	++cheatCount;

	if(cheatCount == 1) {
		alert('부정이 감지되었습니다.\n부정 감지 2회시 시험 응시가 제한됩니다.');
	} else {
		alert('부정 감지로 응시가 제한되었습니다.');
		popupCloseExam();
	}
}

// 시험응시 부정방지 해제
function unsetCheatPrevent() {
	$(window).off('blur');
}

function getCookie(c_name) {

	var i,x,y,ARRcookies=document.cookie.split(";");

	for (i=0;i<ARRcookies.length;i++) {

	  x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
	  y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);

	  x=x.replace(/^\s+|\s+$/g,"");

		if (x==c_name){
			return unescape(y);
		}
	}
}

function setCookie(c_name,value,exdays) {

	var exdate=new Date();

	exdate.setDate(exdate.getDate() + exdays);

	var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());

	document.cookie=c_name + "=" + c_value;
}

var deleteCookie = function(name) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
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
				<div class="titleBar h3">온라인 시험</div>
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
                                    <th class="tt_w20">시험명</th>
                                    <th class="tt_w50">시험기간</th>
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
                           							<td class="tt_w50 survey_dt">기간이 끝나 응시가 마감되었습니다.</td>
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
			<%@include file="../smtp_lecture/modal/modal-sub07-01-02.jsp"%>
		</div>
	</div>
	<!-- footer-include -->
	<%@include file="../smtp_lecture/footer.jsp"%>
</body>

</html>