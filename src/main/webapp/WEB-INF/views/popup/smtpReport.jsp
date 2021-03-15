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
$(function(){
	$("#btnSubmit").on("click",function(){
		var end = "${result.examInfo.END_DATE}";
		var eDate = new Date(end.split("-")[0], end.split("-")[1]-1, end.split("-")[2])
		var today = new Date();
		//var eDate = new Date(2020, 11, 21);
		if(today.getTime() - eDate.getTime() > 0) {
			alert("제출기한이 지났습니다.");
			opener.parent.location.reload();
			window.close();
			return;
		}
		
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
			opener.parent.location.reload();
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
</head>
<body>
	<div class="container_rainbow rainbow_myClass">
        <div class="content sub-content content_myClsss view-post" id="main">
            <div class="section section_sub05-01">
                <header class="article-title">
                    <div class="titleBar-hdr h4">온라인과제</div>
                </header>
                <form name="replyForm" class="formStyle" id="replyForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${params.id}">
				<input type="hidden" name="course" value="${params.course}">
				<input type="hidden" name="cardinal" value="${params.cardinal}">
				<input type="hidden" name="quiz" value="${params.quiz}">
				<input type="hidden" name="quiz_type" id="quiz_type" value="3" />
				
                    <div class="d-flex post-titleWrap">
                        <label class="label w100" for="post-title">과목명</label>
                        <div class="post-title w880">
                           ${result.examInfo.TITLE}
                        </div>
                    </div>
                    <div class="d-flex post-titleWrap">
                        <label class="label w100" for="post-title">제출일</label>
                        <div class="date w880">
                            ${result.examInfo.END_DATE}
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label w100" for="date">배점</label>
                        <div class="score w880">문제당 ${result.examInfo.ITEM_SCORE}점</div>
                    </div>
                    <div class="post-content">
                        <ul class="question-list questionBody">
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
											<div class="question d-flex fc_pp">
												<div class="h3">Q${status.index+1}</div>
												<div class="item-header"><c:out value="${item.TITLE}" /></div>
											</div>
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
								 	  								<div class="fileWrap d-flex">
																		<div class="fileUpload btn_normal btn_pp btn_small">
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
							 		  						<div class="fileWrap d-flex">
																<div class="fileUpload btn_normal btn_pp btn_small">
																	<span>파일 선택</span><input type="file" class="reportFile" name="reportfile" id="reportFile${stat.index+1}" accept=".zip, .hwp, .doc, .docx, .jpg, .jpeg, .txt, .xlsx">
																</div>
																<input type="text" class="reportFileName" id="reportFile${stat.index+1}_name" readonly placeholder="파일명 : 과목명_과제명_성명">
															</div>
														</c:when>
														<c:otherwise>
															<textarea class="answerBox" name="answer${status.index+1}" disabled="disabled" rows="10" style="resize: none; width: 99.5%;"></textarea>
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
							<div class="questionWrap">
								<div class="question d-flex fc_pp">
									<div class="item-header">[첨삭]</div>
								</div>
							</div>
							<textarea class="answerBox" disabled="disabled" rows="10" style="resize: none; width: 99.5%;">${params.correct}</textarea>
						</c:if>
                        </ul>
                    </div>
                </form>
                <c:if test="${params.ready eq 'Y' && params.takeYn eq '0'}">
                <div class="button-wrap d-flex justify_end">
                    <button type="button" class="btn_normal btn_pp btn_medium" id="btnCancel">취소</button>
                    <button type="button" class="btn_normal btn_pp_bg btn_medium" id="btnSubmit">제출</button>
                </div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>