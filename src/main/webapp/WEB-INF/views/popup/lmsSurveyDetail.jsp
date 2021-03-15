<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>온라인 설문조사</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms//css/reset.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/renewal_style.css" />">

<script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>
<script src="<c:url value="/resources/lms/js/common.js" />"></script>

<script type="text/javascript">
var questionList;
var sb = new StringBuilder();

$(function(){
	questionList = ${surveyDetail};
	var answer_state = "${info.survey_answer_state}";
	
	// 질문 내용 불러오기에 실패하는 경우에 대한 처리 (이런 경우는 거의 없지만, 만약 실패할 경우 관리자페이지에 가서 해당 설문에 질문내용이 없는 것을 확인한 후, DB에서 삭제하고 새로 작성할 것)
	if(questionList.length > 0){
		$(".questionBody").append("질문 내용이 없습니다. 관리자에게 문의해주세요.");
		$(".btnWrap").find('input[type="button"]').eq(0).css("display", "none");
		return;
	}
	
	for(var i=0; i<questionList.length; i++){
		sb.empty();
		var q = questionList[i];
		var answerSample_arr = q.SURVEY_ANSWER_SAMPLE.split('|');
		
		sb.Append('<li>');
		sb.Append('<div class="questionWrap">');
		sb.Append('<div class="question d-flex fc_orD">');
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
	    ,url : '<c:url value="/popup/lmsInsertSurveyAnswer" />'
	    ,data : JSON.stringify(answerVO_list)
	    ,dataType : "json"
	    ,contentType : 'application/json'
	    ,success : function(data) {
	    	if(data) {
	    		alert("제출이 완료되었습니다.");
	    		opener.parent.myLectureInfo("${info.course_id}", "${info.cardinal_id}", "", 5);
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
	    ,url : '<c:url value="/popup/lmsUpdateSurveyAnswer" />'
	    ,data : JSON.stringify(answerVO_list)
	    ,dataType : "json"
	    ,contentType : 'application/json'
	    ,success : function(data) {
	    	if(data) {
	    		alert("수정되었습니다.");
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
	<div class="popup-content">
	    <div class="popup-header">
		    <div class="titleWrap">
				<div class="h3 fc_orD testTitle">
					온라인 설문조사
				</div>
				<div class="infoWrap">
					<table>
						<tr>
							<td><strong>설문조사명&nbsp;&nbsp;</strong></td>
							<td>${info.survey_title }</td>
						</tr>
						<tr>
							<td><strong>설문조사 목적&nbsp;&nbsp;</strong></td>
							<td>${info.survey_content }</td>
						</tr>
						<tr>
							<td><strong>설문조사 기간&nbsp;&nbsp;</strong></td>
							<td>${info.survey_st } ~ ${info.survey_et }</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	    
        <div class="popup-section" id="modal_content">
        	<form name="surveyForm" id="surveyForm" class="surveyForm">
				<ul class="question-list questionBody"></ul>
				<div class="btnWrap d-flex justify_end">
					<c:choose>
						<c:when test="${info.survey_state eq 'OPEN' }">
							<c:choose>
								<c:when test="${info.survey_answer_state eq 'NOT_YET' }"><input type="button" class="btn_normal btn_orangeD btn_medium" onclick="submitSurvey()" value="제출"></c:when>
								<c:when test="${info.survey_answer_state eq 'COMPLETED' }"><input type="button" class="btn_normal btn_orangeD btn_medium" onclick="updateSurvey()" value="수정"></c:when>
							</c:choose>
							<input type="button" class="btn_normal btn_default  btn_medium" onclick="cancelSurvey()" value="취소">
						</c:when>
						<c:when test="${info.survey_state eq 'CLOSED' }">
							<input type="button" class="btn_normal btn_default  btn_medium" onclick="cancelSurvey()" value="창 닫기">
						</c:when>
					</c:choose>
				</div>
			</form>
		</div>
    </div>
</body>
</html>