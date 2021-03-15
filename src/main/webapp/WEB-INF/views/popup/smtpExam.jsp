<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

<script>
var takecount = 0;
$(function(){	
	var date = new Date();
	
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	var day = date.getDate();
	
	if(month < 10) month = "0" + month;
    if(day < 10) day = "0" + day;
    
    $('#today').html(year+"-"+month+"-"+day);
	
	var takeyn = "${result.examInfo.TAKE_COUNT}";
	var take = "${params.takeYn}";
	
	if(take != 0) {
		window.close();
		alert('이미 제출하셨습니다.');
		return;
	} 
	
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
		
		var cname = "quiz_timer_" + $("#quizForm #quiz").val();
		deleteCookie(cname);
		clearInterval(timer);
		timer = null;
		submitExam();
	});

	$(document).on("click","#btnCancel", function(event){
		if(!confirm("취소하시겠습니까? 바로 제출됩니다.")) {
			return;
		}
		
		popupCloseExam();
	});
	
	var limit_keys = "${result.examInfo.LIMIT_KEYS}";
	var time = "${result.examInfo.EXAM_TIME}";
	var limit = "${result.examInfo.LIMITS}";
	//var take_count = "${result.examInfo.TAKE_COUNT}";
	
	eventReassign();
	setLimits(limit);
	
	if(takecount == 1 || takeyn == 0) {
		saveExamHistory();
	}
	
 	if(takeyn != 0 && takecount != 1) {
		window.close();
		alert('이미 응시하셨습니다.');
		return;
	} 
	
	if(takecount != 1) {
		$(window).bind("beforeunload", function (e){
			submitExam();
		});	
	}
	
	var date = takeExamTime();
	
	var diff = getDiffDatetime(date.date);
	
	$("#takeExamTime").text(date.start);
	startTime(time, diff);
	
	setLimitkeys(limit_keys);
	//setCheatPrevent();
});

function updateReply(value, quiz_bank, index) {
	var params = $("#quizForm").serialize();
	params += '&bank='+ quiz_bank;
	params += '&value='+ index;
	
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
	examCount = ${fn:length(result.list)};
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
			async:false,
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
	var end = "${result.examInfo.END_DATE}";
	var today = new Date();
	var eDate = new Date(end.split("-")[0], (end.split("-")[1])-1,end.split("-")[2]);
	
	if(today.getTime() - eDate.getTime() > 0) {
		alert("제출기한이 지났습니다.");
		opener.parent.location.reload();
		window.close();
		return;
	}
	
	var params = $("#quizForm").serialize();

	$.ajax({
			url:'<c:url value="/smtp/mypage/examTakeAjax" />',
			type:'POST',
			data:params,
			dataType:'json',
			success:function(data){
				if(data.result == "SUCCESS") {
				  	alert("제출되었습니다.");
				} else {
					alert("제출에 문제가 발생하였습니다. 관리자에게 문의바랍니다.");
				}
			},
			complete:function(){
				opener.parent.location.reload();
				window.close();
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
	submitExam();
}

function setLimitkeys(limit_keys) {
	if(limit_keys.includes('1') && limit_keys.includes('2') && limit_keys.includes('3') && limit_keys.includes('4') && limit_keys.includes('5')) {
		
		$("body").on("keydown", function(event){
			 
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
		$("body").on("mousedown", function(event){
			if (event.type == "mousedown" && event.which == 3) {
				event.preventDefault();
				alert("우클릭은 제한됩니다.");
		    }
		})		
	} else if(limit_keys.includes('1') && limit_keys.includes('2') && limit_keys.includes('3') && limit_keys.includes('4')) {
		$("body").on("keydown", function(event){
			
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
		$("body").on("mousedown", function(event){
			if (event.type == "mousedown" && event.which == 3) {
				event.preventDefault();
				alert("우클릭은 제한됩니다.");
		    }
		})
	} else if(limit_keys.includes('1') && limit_keys.includes('2') && limit_keys.includes('3')) {
		$("body").on("keydown", function(event){
			 
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
		$("body").on("keydown", function(event){
			 
			if (event.ctrlKey && event.keyCode == 67) {
				event.preventDefault();
				alert("CTRL + C 는 제한된 키입니다.");
		    } else if(event.ctrlKey && event.keyCode == 80){
		    	event.preventDefault();
		    	alert("CTRL + P 는 제한된 키입니다.");
		    }
		})
	} else if(limit_keys.includes('1')) {
		$("body").on("keydown", function(event){
			 
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

var hideBuf;
function hideBeforePrint() {
hideBuf = document.body.innerHTML;
document.body.innerHTML = '';
}
function showAfterPrint() {
  document.body.innerHTML = hideBuf;
}
window.onbeforeprint = hideBeforePrint;
window.onafterprint = showAfterPrint; 

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
</head>
<body>
	<div class="container_rainbow rainbow_myClass">
        <div class="content sub-content content_myClsss testWrapper" id="main">
            <div class="header test-header d-flex">
                <div class="titleWrap">
                    <div class="fz18 testTitle">${result.examInfo.TITLE}</div>
                    <div class="infoWrap d-flex">
                        <div class="testInfo">
                            <strong>응시일&nbsp;</strong>
                            <span class="today" id="today">
                                <!-- #today 하단부 script --></span>
                        </div>
                        <div class="testInfo">
                            <strong>문항수&nbsp;</strong>
                            <span class="num"><c:out value="${fn:length(result.list)}"></c:out></span>문항
                        </div>
                    </div>
                </div>
                <div class="timerWrap">
                    <div class="d-flex icon-align">
                        <div class="img-icon clock"></div>
                        <p>시험시간</p>
                    </div>
                    <div class="test-timer h2" id="timeLimit"></div>
                </div>
            </div>
            <div class="section section_sub05-01">
                <form name="quizForm" id="quizForm" class="testForm">
					<input type="hidden" name="id" value="${params.id}">
					<input type="hidden" name="course" value="${params.course}">
					<input type="hidden" name="cardinal" value="${params.cardinal}">
					<input type="hidden" name="quiz" id="quiz" value="${params.quiz}">
					<input type="hidden" name="quiz_type" id="quiz_type"  value="2"/>
					<input type="hidden" name="count" value="${fn:length(result.list)}">
                   
                	<c:forEach items="${result.list}" var="item" varStatus="status">
					<c:set value="${status.index}" var="i"></c:set>
					<c:set value="${result.replyList[i].O_REPLY}" var="reply"></c:set>
					<c:choose>
						<c:when test="${item.OS_TYPE eq 'O' && item.EXAM_TYPE eq '2'}">
							<div class="testSet">
								<div class="testQ">
                            		<div class="qWrap d-flex">
                                		<div class="qNumber">문제 <c:out value="${status.index+1}" /></div>
                                		<div class="qScore c666"><span class="score">${result.examInfo.ITEM_SCORE}</span>점</div>
                            		</div>
                            		<div class="question">
	                                	<c:out value="${item.TITLE}" />
       		                		</div>
                        		</div>
							</div>
							<div class="testA">
                           		<div class="aWrap">
                                	<div class="answer d-flex"> 
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 1?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID}, ${status.index+1})" value="1">
                                    	<label for="testB1">
                                       		1. <c:out value="${item.EXAM1}" />
                                    	</label>
                                	</div>
                                	<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 2?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="2">
                                    	<label for="testB2">
                                       		2. <c:out value="${item.EXAM2}" />
                                    	</label>
                                	</div>
                                	<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 3?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="3">
                                    	<label for="testB3">
                                       		3. <c:out value="${item.EXAM3}" />
                                    	</label>
                                	</div>
                                	<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 4?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="4">
                                    	<label for="testB4">
                                       		4. <c:out value="${item.EXAM4}" />
                                    	</label>
                                	</div>
									<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 5?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="5">
                                    	<label for="testB4">
                                       		5. <c:out value="${item.EXAM5}" />
                                    	</label>
                                	</div>
                            	</div>
                        	</div>
						</c:when>
						<c:when test="${item.OS_TYPE eq 'O'}">
							<div class="testSet">
								<div class="testQ">
                            		<div class="qWrap d-flex">
                                		<div class="qNumber">문제 <c:out value="${status.index+1}" /></div>
                                		<div class="qScore c666"><span class="score">${result.examInfo.ITEM_SCORE}</span>점</div>
                            		</div>
                            		<div class="question">
	                                	<c:out value="${item.TITLE}" />
       		                		</div>
                        		</div>
							</div>
							<div class="testA">
                            	<div class="aWrap">
                                	<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 1?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="1">
                                    	<label for="testB1">
                                       		1. <c:out value="${item.EXAM1}" />
                                    	</label>
                                	</div>
                                	<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 2?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="2">
                                    	<label for="testB2">
                                       		2. <c:out value="${item.EXAM2}" />
                                    	</label>
                                	</div>
                                	<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 3?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="3">
                                    	<label for="testB3">
                                       		3. <c:out value="${item.EXAM3}" />
                                    	</label>
                                	</div>
                                	<div class="answer d-flex">
                                    	<input type="radio" name="answer${status.index+1}" ${reply eq 4?'checked="checked"':""} onclick="updateReply(value, ${item.QUIZ_BANK_ID},${status.index+1})" value="4">
                                    	<label for="testB4">
                                       		4. <c:out value="${item.EXAM4}" />
                                    	</label>
                                	</div>
                            	</div>
                        	</div>
						</c:when>
						<c:otherwise>
                    	<div class="testSet">
							<div class="testQ">
                           		<div class="qWrap d-flex">
                               		<div class="qNumber">문제 <c:out value="${status.index+1}" /></div>
                               		<div class="qScore c666"><span class="score">${result.examInfo.ITEM_SCORE}</span>점</div>
                           		</div>
                           		<div class="question">
                                	<c:out value="${item.TITLE}" />
      		                	</div>
                       		</div>
                       		<c:choose>
								<c:when test="${params.takeYn ne '0'}">
									<c:choose>
										<c:when test="${params.ready eq 'Y'}">
											<c:forEach items="${result.reply}" var="reply">
												<c:if test="${reply.TITLE eq item.TITLE}">
													<textarea name="answer${status.index+1}" class="answerBox" rows="10" style="resize: none; width: 99.5%;"><c:out value="${reply.S_REPLY}" /></textarea>
												</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach items="${result.reply}" var="reply">
												<c:if test="${reply.TITLE eq item.TITLE}">
													<textarea disabled="disabled" class="answerBox" rows="10" style="resize: none; width: 99.5%;"><c:out value="${reply.S_REPLY}" /></textarea>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${params.ready eq 'Y'}">
											<textarea name="answer${status.index+1}" class="answerBox" rows="10" style="resize: none; width: 99.5%;"></textarea>
										</c:when>
										<c:otherwise>
											<textarea disabled="disabled" class="answerBox" rows="10" style="resize: none; width: 99.5%;"></textarea>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>
					</c:otherwise>
				</c:choose>
				</c:forEach>
                    <input type="button" value="제출하기" id="btnSubmit" class="submitBtn btn_pp_bg btn_normal btb_medium">

            	</form>
                <!-- <div class="button-wrap d-flex justify_end">
                    <button type="button" class="btn_normal btn_pp btn_medium">취소</button>
                    <button type="button" class="btn_normal btn_pp_bg btn_medium">제출</button>
                </div> -->
            </div>
        </div>
    </div>
</body>

</html>