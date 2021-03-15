<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript">
var questionList;
var sb = new StringBuilder();

$(function(){
	questionList = ${surveyDetail};
	var answer_state = "${info.survey_answer_state}";
	
	// 질문 내용 불러오기에 실패하는 경우에 대한 처리 (이런 경우는 거의 없지만, 만약 실패할 경우 관리자페이지에 가서 해당 설문에 질문내용이 없는 것을 확인한 후, DB에서 삭제하고 새로 작성할 것)
	if(questionList.length == 0){
		$(".questionBody").append("질문 내용이 없습니다. 관리자에게 문의해주세요.");
		$(".button-wrap").find('button').eq(0).css("display", "none");
		return;
	}
	
	for(var i=0; i<questionList.length; i++){
		sb.empty();
		var q = questionList[i];
		var answerSample_arr = q.SURVEY_ANSWER_SAMPLE.split('|');
		
		sb.Append('<li>'); 
		sb.Append('<div class="questionWrap">');
		sb.Append('<div class="question d-flex fc_pp">');
		sb.Append('<div class="h3">Q' + q.SURVEY_NUMBER + '</div>');
		sb.Append('<div class="item-header">' + q.SURVEY_QUESTION + '</div>');
		sb.Append('</div>');
		sb.Append('</div>');
		
		if(answer_state == "NOT_YET"){ //미응답 설문인 경우
			switch(q.SURVEY_TYPE_SEQ) {
			case 1:
				sb.Append('<div class="answerWrap">');
				sb.Append('<ul class="item-body">');
				
				for(var j=0; j<answerSample_arr.length; j++){
					sb.Append('<li><label>');
					sb.Append('<input type="checkbox" name="answer' + i + '" value="' + (j+1) + '">' + answerSample_arr[j]);
					sb.Append('</label></li>');
				}
				sb.Append('</ul>');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			case 2:
				sb.Append('<div class="answerWrap">');
				sb.Append('<ul class="item-body">');
				
				for(var j=0; j<answerSample_arr.length; j++){
					sb.Append('<li><label>');
					sb.Append('<input type="radio" name="answer' + i + '" value="' + (j+1) + '">' + answerSample_arr[j]);
					sb.Append('</label></li>');
				}
				sb.Append('</ul>');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			case 3:
				sb.Append('<div class="answerWrap">');
				sb.Append('<input type="text" id="answer' + i + '" style="width: 50%;" >');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			case 4:
				sb.Append('<div class="answerWrap">');
				sb.Append('<textarea class="answerBox" id="answer' + i + '" rows="10" style="resize: none; width: 99.5%;"></textarea>');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			}
			
		}else if(answer_state == "COMPLETED"){ //응답한 설문인 경우
			switch(q.SURVEY_TYPE_SEQ){
			case 1:
				var myAnswer_arr = q.SURVEY_ANSWER.split(',');
				sb.Append('<div class="answerWrap">');
				sb.Append('<ul class="item-body">');
				
				var arr = new Array();
				for(var j=0; j<answerSample_arr.length; j++){
					for(var k=0; k<myAnswer_arr.length; k++){
						if(myAnswer_arr[k] == j+1) {
							arr[j] = true;
						}
					}
				}
				
				for(var j=0; j<answerSample_arr.length; j++){
					if(arr[j]){
						sb.Append('<li><label>');
						sb.Append('<input type="checkbox" name="answer' + i + '" value="' + (j+1) + '" checked>' + answerSample_arr[j]);
						sb.Append('</label></li>');
					}else{
						sb.Append('<li><label>');
						sb.Append('<input type="checkbox" name="answer' + i + '" value="' + (j+1) + '">' + answerSample_arr[j]);
						sb.Append('</label></li>');
					}
				}
				sb.Append('</ul>');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			case 2:
				sb.Append('<div class="answerWrap">');
				sb.Append('<ul class="item-body">');
				
				for(var j=0; j<answerSample_arr.length; j++){
					if(q.SURVEY_ANSWER_CHOICE == j+1) {
						sb.Append('<li><label>');
						sb.Append('<input type="radio" name="answer' + i + '" value="' + (j+1) + '" checked>' + answerSample_arr[j]);
						sb.Append('</label></li>');
					}else {
						sb.Append('<li><label>');
						sb.Append('<input type="radio" name="answer' + i + '" value="' + (j+1) + '">' + answerSample_arr[j]);
						sb.Append('</label></li>');
					}
				}
				sb.Append('</ul>');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			case 3:
				sb.Append('<div class="answerWrap">');
				sb.Append('<input type="text" id="answer' + i + '" value="'+ q.SURVEY_ANSWER +'" style="width: 50%;">');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			case 4:
				sb.Append('<div class="answerWrap">');
				sb.Append('<textarea class="answerBox" id="answer' + i + '" rows="10" style="resize: none; width: 99.5%;">' + q.SURVEY_ANSWER +'</textarea>');
				sb.Append('</div>');
				sb.Append('</li>');
				break;
			}
		}
		$(".questionBody").append(sb.ToString());
	}
});

function submitSurvey(){
	if(!confirm("제출하시겠습니까?")) return;
	
	var answerVO_list = checkSurvey();
	if(answerVO_list == null) return;
	
	$.ajax({
	    type : "POST"
	    ,url : '<c:url value="/smtp/myLecture/insertSurveyAnswer" />'
	    ,data : JSON.stringify(answerVO_list)
	    ,dataType : "json"
	    ,contentType : 'application/json'
	    ,success : function(data) {
	    	if(data) {
	    		alert("제출이 완료되었습니다.");
	    		opener.parent.setSurveyDataListUl(); //부모창 새로고침. 제출하는 사이에 진행여부가 마감으로 바뀔 수도 있으므로.
	    		window.close();
	    	}else alert("제출에 실패하였습니다.");
	    }
	    ,error : function(e) {
	    	alert("제출 실패");
	    }
	});
}

function updateSurvey(){
	if(!confirm("수정하시겠습니까?")) return;
	
	var answerVO_list = checkSurvey();
	if(answerVO_list == null) return;
	
	$.ajax({
	    type : "POST"
	    ,url : '<c:url value="/smtp/myLecture/updateSurveyAnswer" />'
	    ,data : JSON.stringify(answerVO_list)
	    ,dataType : "json"
	    ,contentType : 'application/json'
	    ,success : function(data) {
	    	if(data) {
	    		alert("수정되었습니다.");
	    		opener.parent.setSurveyDataListUl();
	    		window.close();
	    	}else alert("수정에 실패하였습니다.");
	    }
	    ,error : function(e) {
	    	alert("수정 실패");
	    }
	});
}

function checkSurvey(){
	var answerVO_list = [];
	var answer_flag = [];
	
	for(var i=0; i<questionList.length; i++) {
		var q = questionList[i];
		
		switch(q.SURVEY_TYPE_SEQ){
		case 1:
			var num_of_checked = $('input:checkbox[name="answer' + i + '"]:checked').length;
			
			if(num_of_checked == 0) {
				answer_flag[i] = false;
			}else{
				var answer_temp = "";
				
				$('input:checkbox[name="answer' + i + '"]').each(function() {
					if(this.checked == true){
						answer_temp += ',' + $(this).val();
					}
				});
				
				var survey_answer = answer_temp.substring(1);
				var answerVO = {
						survey_question_seq : q.SURVEY_QUESTION_SEQ
						,survey_answer : survey_answer
				}
				answerVO_list.push(answerVO);
				answer_flag[i] = true;
			}
			break;
		case 2:
			var survey_answer_choice = $('input:radio[name="answer' + i + '"]:checked').val();
			
			if(survey_answer_choice == undefined) {
				answer_flag[i] = false;
			}else {
				var answerVO = {
						survey_question_seq : q.SURVEY_QUESTION_SEQ
						,survey_answer_choice : survey_answer_choice
				}
				answerVO_list.push(answerVO);
				answer_flag[i] = true;
			}
			break;
		case 3:
			var survey_answer = $('#answer' + i).val().trim();
				
			if(survey_answer == "") {
				answer_flag[i] = false;
			}else {
				var answerVO = {
						survey_question_seq : q.SURVEY_QUESTION_SEQ
						,survey_answer : survey_answer
				}
				answerVO_list.push(answerVO);
				answer_flag[i] = true;
			}
			break;
		case 4:
			var survey_answer = $('#answer' + i).val().trim();
			
			if(survey_answer == "200자 이내" | survey_answer == "") {
				answer_flag[i] = false;
			}else {
				var answerVO = {
						survey_question_seq : q.SURVEY_QUESTION_SEQ
						,survey_answer : survey_answer
				}
				answerVO_list.push(answerVO);
				answer_flag[i] = true;
			}
			break;
		}
	}
	
	for(var i=0; i<answer_flag.length; i++){
		if(!answer_flag[i]) {
			alert("입력하지 않은 항목이 있습니다.");
			return null;
		}
	}
	return answerVO_list;
}

function cancelSurvey(){
	window.close();
}

//StringBuilder 기능구현
function StringBuilder() {
	this.buffer = new Array();
}
StringBuilder.prototype.Append = function(strValue) {
	this.buffer[this.buffer.length] = strValue;
	//this.buffer.push(strValue);	//IE5.5, NS4
};
StringBuilder.prototype.ToString = function() {
	return this.buffer.join("");	//IE4, NS3
};
StringBuilder.prototype.empty = function() {
	this.buffer = new Array();
};

</script>
</head>

<body>
    <div class="container_rainbow rainbow_myClass">
        <div class="content sub-content content_myClsss view-post" id="main">
            <div class="section section_sub05-01">
                <header class="article-title">
                    <div class="titleBar-hdr h4">설문조사</div>
                </header>
                <form class="formStyle">
                    <div class="d-flex post-titleWrap">
                        <label class="label w100" for="post-title">설문조사명</label>
                        <div class="post-title w880">${info.survey_title }</div>
                    </div>
                    <div class="d-flex post-titleWrap">
                        <label class="label w100" for="post-title">설문조사목적</label>
                        <div class="post-title w880">${info.survey_content }</div>
                    </div>
                    <div class="d-flex">
                        <label class="label w100" for="date">설문조사기간</label>
                        <div class="date w880">${info.survey_start_date } ~ ${info.survey_end_date }</div>
                    </div>
                    <div class="post-content">
                        <ul class="question-list questionBody"></ul>
                    </div>
                </form>
                <div class="button-wrap d-flex justify_end">
					<c:choose>
						<c:when test="${info.survey_state eq 'OPEN' }">
							<c:choose>
								<c:when test="${info.survey_answer_state eq 'NOT_YET' }"><button type="button" class="btn_normal btn_pp_bg btn_medium" onclick="submitSurvey()">제출</button></c:when>
								<c:when test="${info.survey_answer_state eq 'COMPLETED' }"><button type="button" class="btn_normal btn_pp_bg btn_medium" onclick="updateSurvey()">수정</button></c:when>
							</c:choose>
							<button type="button" class="btn_normal btn_pp btn_medium" onclick="cancelSurvey()">취소</button>
						</c:when>
						<c:when test="${info.survey_state eq 'CLOSED' }">
							<button type="button" class="btn_normal btn_pp btn_medium" onclick="cancelSurvey()">창 닫기</button>
						</c:when>
					</c:choose>
				</div>
            </div>
        </div>
    </div>
</body>

</html>
