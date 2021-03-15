<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>온라인 과제</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms//css/reset.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/img-icon.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/renewal_style.css" />">

<script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>
<script src="<c:url value="/resources/lms/js/common.js" />"></script> 
<script src='/resources/js/ext/fullcalendar/js/moment.min.js'></script>
<script src='/resources/js/ext/fullcalendar/js/lang-all.js'></script>
<script>
$(function(){
	$("#btnSubmit").on("click",function(){
		submit();
		//모달 닫을때 모달 탭의 데이터가 기존 부모 탭에 append 되므로 새로고침 해주었음
	});

	//submitBtn event 끝

	$("#btnCancel").on("click",function(){
		window.close();
	});
	
	$(document).on("click", ".download", function(){
		var user = '${sessionScope.user_id}'; 
		var cardinal = $(':hidden[name="cardinal"]').val();
		var origin = $(this).children('.origin_nm').text();
		var saved = $(this).parents('.answerWrap').find('.saved').val();
		
		location.href = "/file_download?origin="+origin+"&saved="+saved+"&path=report/files/"+ user + "_" + cardinal;
	})
	
	var limit = "${result.examInfo.LIMIT_KEYS}";
	
	setLimitkeys(limit);
	
	$(window).bind("beforeunload", function (e){
		submit();
	});	
	
	// 첨부파일명 보여주기 시작
	for (var i = 1; i < 10; i++) {
        var str = "reportFile" + i;

        document.getElementById(str).onchange = function() {
            var text = this.id + "_name";
            document.getElementById(text).value = this.value.replace(/C:\\fakepath\\/i, '');
        };
    }
	// 첨부파일명 보여주기 끝
});

function submit() {
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
			//opener.parent.location.reload();
			opener.parent.myLectureInfo('${params.course}','${params.cardinal}','${sessionScope.user_id}',2);
			window.close();
		}
	});
}

function checkInputReport() {
	var isAnswer = false;
	examCount = ${fn:length(result.list)};
	
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

</script>
<body>
    <div class="popup-content">
	    <div class="popup-header">
	    	<%-- <div class="statusWrap modal-sectionWrap" >
				<div class="h3 classTitle"><${result.examInfo.TITLE}></div>
				<p>문제당 배점 : ${result.examInfo.ITEM_SCORE}</p>
			</div> --%>
	    	<div class="titleWrap">
	        	<div class="h3 fc_orD">온라인 과제</div>
	        </div>    
	        <div class="infoWrap d-flex justify_between">
	        	<div class="testTitle">${result.examInfo.TITLE}</div>
	        	<div class="d-flex">	
		        	<div class="testInfo">
		            	<strong>제출일&nbsp;</strong>
		                <span>${result.examInfo.END_DATE} </span> <!-- 과제제출일 넣어주세요 --> 
		            </div>
		            <div class="testInfo margin-left10">
		            	<strong>배점&nbsp;</strong>
		                <span>문제당 ${result.examInfo.ITEM_SCORE}점</span>	                    
		            </div>
	            </div>
	        </div>
	    </div>
	    <!-- 20-10-28 시험 레이아웃 수정 -->
        <div class="popup-section" id="modal_content">
			<form name="replyForm" id="replyForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${params.id}">
				<input type="hidden" name="course" value="${params.course}">
				<input type="hidden" name="cardinal" value="${params.cardinal}">
				<input type="hidden" name="quiz" value="${params.quiz}">
				<input type="hidden" name="quiz_type" id="quiz_type" value="3" />
				
				<ul class="question-list">
					<c:forEach items="${result.list}" var="item" varStatus="status">
						<c:choose>
							<c:when test="${item.OS_TYPE eq O && item.EXAM_TYPE eq 2}">
								<li>
									<div class="questionWrap">
										<c:out value="${item.TITLE}" />
									</div>
									<ul class="item-body">
										<li><label><input type="radio"
												name="answer${status.index+1}" value="1"> <c:out
													value="${item.EXAM1}" /></label></li>
										<li><label><input type="radio"
												name="answer${status.index+1}" value="2"> <c:out
													value="${item.EXAM2}" /></label></li>
										<li><label><input type="radio"
												name="answer${status.index+1}" value="3"> <c:out
													value="${item.EXAM3}" /></label></li>
										<li><label><input type="radio"
												name="answer${status.index+1}" value="4"> <c:out
													value="${item.EXAM4}" /></label></li>
										<li><label><input type="radio"
												name="answer${status.index+1}" value="5"> <c:out
													value="${item.EXAM5}" /></label></li>
									</ul>
								</li>
							</c:when>
							<c:when test="${item.OS_TYPE eq 'O'}">
								<li>
									<div class="item-header">
										<c:out value="${item.TITLE}" />
									</div>
									<ol class="item-body">
										<li><label><input type="radio"
												name="answer${status.index+1}" value="1"> <c:out
													value="${item.EXAM1}" /></label></li>
										<li><label><input type="radio"
												name="answer${status.index+1}" value="2"> <c:out
													value="${item.EXAM2}" /></label></li>
										<li><label><input type="radio"
												name="answer${status.index+1}" value="3"> <c:out
													value="${item.EXAM3}" /></label></li>
										<li><label><input type="radio"
												name="answer${status.index+1}" value="4"> <c:out
													value="${item.EXAM4}" /></label></li>
									</ol>
								</li>
								<br>
							</c:when>
							<c:otherwise>
								<li>
									<div class="questionWrap">
										<div class="question d-flex fc_orD">
											<div class="h3">Q</div>
											<div class="item-header"><c:out value="${item.TITLE}" /></div>
										</div>
										<div class="explanation"><c:out value="${item.COMMENT}" /></div>
									</div>
									<div class="answerWrap">
										<c:choose>
											<c:when test="${params.takeYn ne '0'}">
												<c:choose>
													<c:when test="${params.ready eq 'Y'}">
														<c:forEach items="${result.reply}" var="reply" varStatus="stat">
															<c:if test="${status.index eq stat.index}">
																<input type="hidden" name="os_type${stat.index+1}" value="${reply.OS_TYPE}" />
																<input type="hidden" name="id${stat.index+1}" value="${reply.ID}" />
																<c:if test="${not empty reply.SAVED_FILE_NM}">
																	<input type="hidden" class="saved" name="saved${stat.index+1}" value="${reply.SAVED_FILE_NM}" />
																	<input type="hidden" class="origin" name="original${stat.index+1}" value="${reply.ORIGINAL_FILE_NM}" />
																</c:if>
																<textarea class="answerBox" name="answer${status.index+1}" rows="10" style="resize: none; width: 99.5%;"><c:out value="${reply.S_REPLY}" /></textarea>
																<div class="h5 fc_999">
																	답변은 직접 입력하거나 파일 첨부하는 2가지 방식으로 제출할 수 있으며
								 									파일 형식은 zip, hwp, doc, docx, xlsx, jpg, png, jpeg, txt 파일로 제한합니다.
							 									</div>
							 									<!-- fileWrap추가시 각 input의 id에 숫자 개별적으로 부여해주세요.
							 	  									1) 파일선택버튼 input#reportFile$
							 	  									2) 파일명표시 input#reportFile$_name  -->
							 	  								<div class="fileWrap">
																	<div class="fileUpload btn_normal btn_orangeD btn_small">
																		<span>파일 선택</span><input type="file" class="reportFile" name="reportfile" id="reportFile${stat.index+1}" accept=".zip, .hwp, .doc, .docx, .jpg, .jpeg, .txt, .xlsx">
																	</div>
																	<input type="text" class="reportFileName" id="reportFile${stat.index+1}_name" readonly placeholder="파일명 : 과목명_과제명_성명">
																</div>
																<c:if test="${not empty reply.ORIGINAL_FILE_NM}">
																	<div class="download explanation">
																		<span>업로드 파일:</span>&nbsp;&nbsp;
																		<span class="origin_nm" style="cursor: pointer">${reply.ORIGINAL_FILE_NM}</span>
																	</div>
																</c:if>
															</c:if>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<c:forEach items="${result.reply}" var="reply" varStatus="stat">
															<c:if test="${status.index eq stat.index}">
																<c:if test="${not empty reply.SAVED_FILE_NM}">
																	<input type="hidden" class="saved" name="saved${stat.index+1}" value="${reply.SAVED_FILE_NM}" />
																	<input type="hidden" class="origin" name="original${stat.index+1}" value="${reply.ORIGINAL_FILE_NM}" />
																</c:if>
																<textarea class="answerBox" disabled="disabled" rows="10" style="resize: none; width: 99.5%;"><c:out value="${reply.S_REPLY}" /></textarea>
																<c:if test="${not empty reply.ORIGINAL_FILE_NM}">
																	<div class="download">
																		<span>업로드 파일:</span>&nbsp;&nbsp;
																		<span class="origin_nm" style="cursor: pointer">${reply.ORIGINAL_FILE_NM}</span>
																	</div>
																</c:if>
															</c:if>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${params.ready eq 'Y'}">
														<textarea class="answerBox" name="answer${status.index+1}" rows="10" style="resize: none; width: 99.5%;"></textarea>
														<div class="h5 fc_999">
															답변은 직접 입력하거나 파일 첨부하는 2가지 방식으로 제출할 수 있으며
								 							파일 형식은 zip, hwp, doc, docx, xlsx, jpg, png, jpeg, txt 파일로 제한합니다.
							 							</div>
							 	  						<div class="fileWrap">
															<div class="fileUpload btn_normal btn_orangeD btn_small">
																<span>파일 선택</span><input type="file" class="reportFile" name="reportfile" id="reportFile${stat.index+1}" accept=".zip, .hwp, .doc, .docx, .jpg, .jpeg, .txt, .xlsx">
															</div>
															<input type="text" class="reportFileName" id="reportFile${stat.index+1}_name" readonly placeholder="파일명 : 과목명_과제명_성명">
														</div>
													</c:when>
													<c:otherwise>
														<textarea class="answerBox" disabled="disabled" rows="10" style="resize: none; width: 99.5%;"></textarea>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</div>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${not empty params.correct && params.correct ne 'undefined'}">
						<!-- <br> -->
						<div class="questionWrap">
							<div class="question d-flex fc_orD">
								<div class="item-header">[첨삭]</div>
							</div>
						</div>
						<div class="answerWrap">
							<textarea class="answerBox" disabled="disabled" rows="10" style="resize: none; width: 99.5%;">${params.correct}</textarea>
						</div>
					</c:if>
				</ul>
				<c:if test="${params.ready eq 'Y' && params.takeYn eq '0'}">
				<div class="btnWrap d-flex justify_end">
						<input type="button" class="btn_normal btn_orangeD btn_medium" id="btnSubmit" value="제출">
						<input type="button" class="btn_normal btn_default  btn_medium" id="btnCancel" value="취소">
				</div>
				</c:if>
			</form>
		</div>
    </div>
</body>
</html>