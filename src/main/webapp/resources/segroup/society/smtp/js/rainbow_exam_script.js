var examCount;
var takecount = 0;

$(function() {
	userExam();
/*	$(".modal-popup").on("click", function() {
		
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
			url		: '/smtp/mypage/examListAjax',
			type	: "POST",
			data: params,
			success: function(result) {
				var str = "";
				var examInfo = result.examInfo;
				var list = result.list;
				
				 if (list.length < 1) {
					alert("온라인 시험 준비 중입니다.");
					$('.modal').hide();
					location.reload(true);
					return;
				} 
				
				// 확정전까지 주석처리
 				if (examInfo.TAKE_COUNT > takecount) {
					$('.modal').hide();
					location.reload(true);
					alert('이미 응시하셨습니다.');
					return;
				}
 				
				//서버시간(데이터베이스)을 기준으로 시험실 입자시간을 출력함.
				$("#question-list").empty();
				console.log(list);
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
									//console.log("들어옴");
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
						
						//console.log(date);
						//console.log(diff);
						
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
						url		: '/smtp/mypage/selectMyOnlineExamAnswerAjax',
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
								 for(var i = 0; i < list.length; i++) {
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
								$("#question-list").append(str); 
 								eventReassign();
								startTime(examInfo.EXAM_TIME, diff);
								setLimits(examInfo.LIMITS);
								
								console.log(examInfo.TAKE_COUNT);
								console.log(takecount); 
								
								
									$('.modal').hide();
									location.reload(true);
									alert('이미 응시하셨습니다.');
									return;
								
								
 								setLimitkeys(examInfo.LIMIT_KEYS);
								
								setCheatPrevent(); 
							}
						}
					});
					break;
				}
			}
		});
	});*/
	
	//*********모달 창 닫는 x아이콘 나오게!
/*	$('.modal .close-modal').click(function() {
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
	});*/
	
}); //ready ftn끝

/*function updateReply(value) {
	var params = $("#quizForm").serialize();
	$.ajax({
		url:'/smtp/mypage/updateReply"',
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
			url:'/smtp/mypage/examTakeHistAjax',
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
			url:'/smtp/mypage/selectExamTime',
			type:'POST',
			data:params,
			async:false,
			dataType:'json',
			success : function(data) {
				time = data;
			}
	});
	console.log(time);
	return time;
}

function submitExam() {
	var params = $("#quizForm").serialize();
	console.log(params);
	$.ajax({
			url:'/smtp/mypage/examTakeAjax',
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
			   	location.reload(); 
			}
	});
}

var timer;
var seconds = 0;//초기0초
var pad = function(x) { return (x < 10) ? "0"+x : x; }
function startTime(timeLimit, diff) {
	var cname = "quiz_timer_" + $("#quizForm #quiz").val();
	var savedSeconds = getCookie(cname);
	console.log("saved cookie : "+savedSeconds);
	
	if (savedSeconds < 1) savedSeconds = null;	// 시간 만료시 다음 응시 때 부자연스러운 엑션으로 추가
	
	seconds = savedSeconds!=null ? savedSeconds : timeLimit*60;

	if(diff != 0) {
		seconds = seconds - diff;
	}
	console.log("seconds : "+seconds);
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
	 console.log(hour);
	console.log(minute);
	console.log(second); 
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
	화면에 엘리먼트가 추가되면서 이벤트 재할당이 필요.
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
		console.log("1,2,3,4,5");
		$("#modal_content").on("keydown", function(event){
			console.log("keyCode : " + event.keyCode);
			 
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
		console.log("1,2,3,4");
		$("#modal_content").on("keydown", function(event){
			console.log("keyCode : " + event.keyCode);
			
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
				//console.log("우클릭");
				alert("우클릭은 제한됩니다.");
		    }
		})
	} else if(limit_keys.includes('1') && limit_keys.includes('2') && limit_keys.includes('3')) {
		console.log("1,2,3");
		$("#modal_content").on("keydown", function(event){
			console.log("keyCode : " + event.keyCode);
			 
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
		console.log("1,2");
		$("#modal_content").on("keydown", function(event){
			console.log("keyCode : " + event.keyCode);
			 
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
			console.log("keyCode : " + event.keyCode);
			 
			if (event.ctrlKey && event.keyCode == 67) {
				event.preventDefault();
				alert("CTRL + C 는 제한된 키입니다.");
		    }
		})
	} 
}

function setLimits(limits) {
	if(!limits.includes('1')) {
		console.log("1을 포함x");
		clearInterval(timer);
		timer = null;
		$("#timeLimit").text("");
		var cname = "quiz_timer_" + $("#quizForm #quiz").val();
		deleteCookie(cname);
	}
	if(limits.includes('2')) {
		console.log("2를 포함");
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
	 alert("마우스 이탈로 자동 제출됩니다.");
	submitExam(); 
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
	console.log(name);
}*/

function userExam() {
	var course = $(':hidden[name=course_id]').val();
	var cardinal = $(':hidden[name=cardinal_id]').val();
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		type	: "get",
		url		: "/smtp/mypage/selectExamList",
		cache : false,
		async : false,
		data    : {
			"course" : course
			,"cardinal" : cardinal
			,"quiz_type" : "2"
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
						bContent += '<input type="hidden" name="id" value="'+asList.learnappid+'" />'
						bContent += '<input type="hidden" name="pagingYn" value="N" />';
						bContent += '<input type="hidden" name="useYn" value="Y" />'
							bContent += '<input type="hidden" name="quiz_type" value="2" />';
							bContent += '<input type="hidden" name="course" value="'+course+'" />';
							bContent += '<input type="hidden" name="cardinal" value="'+cardinal+'" />';
							bContent += '<input type="hidden" name="quiz" value="'+asList.ID+'">';
							bContent += '<input type="hidden" name="takeYn" value="'+asList.TAKE_YN+'">';
							bContent += '<input type="hidden" name="ready" value="'+asList.IS_READY+'">';
							bContent += '</form>';
							
						if(asList.TAKE_YN != '0' && asList.USE_YN == 'Y') {
							bContent += '<div class="class-list board-list open-answer d-flex">';
						} else {
							bContent += '<div class="class-list d-flex">';
						}
	                    bContent += '<div class="c-table-num">'+(index+1)+'</div>'
	                    bContent +=	'<div class="c-table-name-wide">' + asList.TITLE + '</div>';
	                    if(asList.IS_READY == 'Y') {
                            bContent += '<div class="c-table-02 c-table-date" data-value='+asList.END_DATE+'>'+ asList.START_DATE + ' ~ ' + asList.END_DATE + '</div>';	
                        } else {
                            bContent += '<div class="c-table-02 c-table-date" data-value='+asList.END_DATE+'>기간이 끝나 제출이 마감되었습니다.</div>';
                        }
	                    if(asList.TAKE_YN != '0' && asList.USE_YN == 'Y') {
                            bContent += '<div class="c-table-01 c-table-btn"><span class="btn_normal btn_default btn_xsmall h5 fc_true">제출완료</span></div>';
                        } else if(asList.TAKE_YN == '0' && asList.USE_YN == 'Y' && asList.IS_READY == 'Y') {
                        	bContent += '<div class="c-table-01 c-table-btn"><span class="btn_normal btn_pp_bg btn_xsmall h5">응시하기</span></div>';
                        } else {
                            bContent += '<div class="c-table-01 c-table-btn"><span class="btn_normal btn_default btn_xsmall h5 fc_false">미제출</span></div>';
                        }
	                    if(!asList.QUIZ_SCORE) {
                            bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></div>';
                        } else {
                            bContent += '<div class="c-table-01"><strong class="score">'+asList.QUIZ_SCORE+'</strong>/'+asList.SCORE+'</div></div>';	
                        }
	                    if(asList.IS_READY != 'Y' && asList.TAKE_YN != '0') {
	                    	bContent +='<div class="open-asw open-ctt"><ul class="class-list-wrap"><li class="aswr-box">';
		                    bContent += "<table class='table table_onlineTest'><thead class='thead'><tr><th colspan='27'>객관식</th><td colspan='3' class='fc_orD'>정답 표기 ○</td></tr></thead>";
		                    
		                     $.ajax({
		                    	url:"/smtp/mypage/selectMyOnlineExamAnswerAjax",
		                    	async: false,
		                    	data:{"id":asList.learnappid, "quiz_type":"2","course":course,"cardinal":cardinal,"quiz":asList.ID},
		                    	success: function(result) {
		                    		if(result["result"] == "FAIL") {
		                    			bContent += '<tbody class="tbody"><tr><td>결과값이 없습니다.</td></tr></tbody></table></li></ul></div>'
		                    		} else {
		                    		
		                    		bContent += '<tbody class="tbody">';
		                    		
		                    		for(var i = 0; i < result.quizList.length; i++) {
		                    			var reply = result.replyList[i];
		                    			
		                    			if(i % 5 == 0) {
		                    				bContent += '<tr>';
		                    			}
		                    			
		                    			bContent += '<th class="numberQ">'+(i+1)+'</th>';

		                    			if(result.quizList[i].EXAM_TYPE != 2) {
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
/*	$(document).on('click', '.board-list.open-answer',function(){
		$(this).next().slideToggle();
  	});*/
	
	$(document).on('click', '.examup', function(){
		var a = $(this).find('form[name$=examForm]');
		var idx = $('form[name$=examForm]').index(a);
		var takeYn = a.children(':hidden[name="takeYn"]').val()
		var end = $(this).children().eq(1).find('.c-table-date').data('value');
		
		var today = new Date();
		var eDate = new Date(end.split("-")[0], (end.split("-")[1])-1,end.split("-")[2], "23", "50");
		
		if(takeYn == 0) {
			if(today.getTime() - eDate.getTime() > 0) {
				alert("제출기한이 지났습니다.");
				return;
			} else if(Math.floor((today.getTime() - eDate.getTime())/1000/60) >= -10) {
				alert("제출기한 이후에는 제출이 불가합니다.");
			}
		}
		
		
		var examForm = $(".exam"+idx+"")[0];
		
		window.open("", 'openWindow', 'width=1020px, height=1000px, toolbars=no, scrollbars=yes')
		examForm.action = "/popup/smtpExam";
		examForm.target = "openWindow";
		examForm.submit();
	});
}