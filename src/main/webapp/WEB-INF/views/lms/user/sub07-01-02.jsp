<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/lms/css/style.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/lms/css/style_responsive.css" />">
<script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
<%-- <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
<script type="text/javascript">
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
	.attr('action','/lms/user/player')
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
			url		: "/lms/user/getLessonInfo",
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
						var prevProgYn = 'N'
						content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
						content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
						content += '<div class="c-table-num">'+lessonList.STUDY+'분</div>';
						content += '<div class="c-table-num"></div>'
	                    content += '<div class="c-table-num">'; //수강확인 Y/N
	                    
		                    if(lessonList.PROG_YN == 'Y') {
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
				
				$('.class-list-wrap.modal-ovflowY').html(content);

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
					url		: "/lms/user/selectExamList",
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
			url		: "/lms/user/courseBoardList",
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
			url		: "/lms/user/courseBoardList",
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
								bContent += '<div class="c-table-01"><a href="/lms/user/downloadFile?file_1='+cbList.ATTACH1_FILE+'&file_2='+cbList.ATTACH2_FILE+'"><div class="img-icon save"></div></a></div>';
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
	}
}//함수 종료


/* function goStudy(learnAppId, course, cardinal, chapter, chasi, study, chk, progYn, url) {
	// 처음 듣는 강의의 경우 수강 이력 등록
	if (progYn == 'N') {
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			cache: false,
			url		: "/lms/user/insertAttLec",
			data    : {
				"learn_app_id" : learnAppId
				, "course_id" : course
				, "cardinal_id" : cardinal
				, "chapter_id" : chapter
				, "chasi" : chasi
				, "study" : study
				, "chk" : chk
				, "progYn" : 'Y'
			},
			success : function() {
				// 학습여부 o로 변경
				$('.progYn').eq(chasi-1).attr('class', 'img-icon attendanceN progYn');
				window.open(url,'video','width=1000,height=700,location=no,status=no,scrollbars=yes');
			},
			error : function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
			
		});
	} else {
		window.open(url,'video','width=1000,height=700,location=no,status=no,scrollbars=yes');
	}
}; */

$(function() {
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
		
		//모달>>탭 기능
		var $modaltab = $('.section div.class-tabMenu>.modal-tabGroup>li');
        var  i = 0;

       $modaltab.on('click', function(t) {
    	   i = $(this).index(); //자료실,공지사항,과목QnA
            if(i == '1' || i == '2' || i == '3' || i == '4' || i == '5') {
            	myLectureInfo(course,cardinal,id,i);
            }
        }); 
        // 모달 >> 탭 기능 끝
        
        /*
     //차시 정보를 default로 보여주고  탭을 선택하면 결과 다르게 나오도록 
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			cache: false,
			url		: "/lms/user/getLessonInfo",
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
						var prevProgYn = 'N'
						content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
						content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
						content += '<div class="c-table-num">'+lessonList.STUDY+'분</div>';
						content += '<div class="c-table-num"></div>'
	                    content += '<div class="c-table-num">'; //수강확인 Y/N
	                    
		                    if(lessonList.PROG_YN == 'Y') {
		                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
		                    }else if(lessonList.PROG_YN == 'N') {
		                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
		                    }
	                    
	                  	// content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="window.open(\''+lessonList.MAIN_URL+'\',\'video\',\'width=1000,height=700,location=no,status=no,scrollbars=yes\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';
	                    content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goStudy('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +','+lessonList.STUDY+','+lessonList.CHK+',\''+lessonList.PROG_YN+'\',\''+lessonList.MAIN_URL+'\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';


					});
                       
				} else {
					content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>차시정보가 존재하지 않습니다.</p></div></li>';
				}
				
				$('.class-list-wrap.modal-ovflowY').html(content);

			},
			error : function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
			
		});//ajax getLessonInfo 종료
		*/
		
		//학습현황 정보
		$('.classTitle').html(courseName);
		$('.learn').html(learnStartDate+' - '+learnEndDate);//학습기간
		$('.recap').html(realStartDate+' - '+realEndDate);//복습기간
		$('.completeQuizPercent').html(completeQuizPercent);
		$('.completeExamPercent').html(completeExamPercent);
		$('.completeProgPercent').html(completeProgPercent);
		$('.completeQuizScore').html(completeQuizScore);
		$('.completeExamScore').html(completeExamScore);
		$('.completeProgScore').html(completeProgScore);
		$('.completeTotal').html("<b class='c666'>총점 "+completeTotal+"점 이상</b>");
        
	});
	

	/* //탭클릭시 나오는 데이터
    function myLectureInfo(course,cardinal,id,i) {
		if(i == '1') {
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				cache: false,
				url		: "/lms/user/getLessonInfo",
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
							var prevProgYn = 'N'
							content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
							content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
							content += '<div class="c-table-num">'+lessonList.STUDY+'분</div>';
							content += '<div class="c-table-num"></div>'
		                    content += '<div class="c-table-num">'; //수강확인 Y/N
		                    
			                    if(lessonList.PROG_YN == 'Y') {
			                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
			                    }else if(lessonList.PROG_YN == 'N') {
			                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
			                    }
		                    
		                  	// content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="window.open(\''+lessonList.MAIN_URL+'\',\'video\',\'width=1000,height=700,location=no,status=no,scrollbars=yes\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';
		                    //content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goStudy('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +','+lessonList.STUDY+','+lessonList.CHK+',\''+lessonList.PROG_YN+'\',\''+lessonList.MAIN_URL+'\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';
		                    content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+',\''+lessonList.PROG_YN+'\');"><div class="img-icon study"></div><span class="h5">학습하기</span></a></div></li>';


						});
	                       
					} else {
						content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>차시정보가 존재하지 않습니다.</p></div></li>';
					}
					
					$('.class-list-wrap.modal-ovflowY').html(content);

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
						url		: "/lms/user/selectExamList",
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
				url		: "/lms/user/courseBoardList",
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
				url		: "/lms/user/courseBoardList",
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
									bContent += '<div class="c-table-01"><a href="/lms/user/downloadFile?file_1='+cbList.ATTACH1_FILE+'&file_2='+cbList.ATTACH2_FILE+'"><div class="img-icon save"></div></a></div>';
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
		}
	}//함수 종료 */
	
	// 학습하기
	

	$(document).on('click', '.board-list.open-answer',function(){
		$(this).next().slideToggle();
  	});
	
	$('.modal .close-modal').click(function() {
	 //모달 닫을때 모달 탭의 데이터가 기존 부모 탭에 append 되므로 새로고침 해주었음
		location.reload(true);
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
	<%@include file="../header.jsp"%>


	<div class="container sub07" id="main">
		<!-- sub07 나의강의실-include -->
		<%@include file="../user/menu/leftmenu07.jsp"%>

		<div class="sub-content sub07 sub07-01">
			<!-- 현재 페이지 위치 표시 -->
			<div class="page-locationWrap">
				<ul class="page-location">
					<!--
                    home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
                    -->
					<li class="img-icon  home"><a href="/"></a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="category-menu"><a href="/lms/user/sub07-01-01">나의강의실</a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="division-menu"><a href="/lms/user/sub07-01-01">학습현황</a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="section-menu"><a href="/lms/user/sub07-01-02">학습예정</a></li>
				</ul>
				<div class="img-icon  chevron-right"></div>
				<!-- <div class="sub-content sub00-01"></div> -->
			</div>
			<div class="header">
				<div class="titleBar h3">학습현황</div>
				<!-- <h3 class="h3"></h3> -->
			</div>
			<div class="section sub07-01 sub07-01-02">

				<!-- 학습현황 탭 -->
				<div class="class-tabMenu">
					<ul class="tabGroup d-flex">
						<li>학습 중</li>
						<li class="active">학습 예정</li>
						<li>학습 종료</li>
					</ul>
					<div class="subGroup">
						<div class="tab-sub sub01 hideTab">
							<div class="sub-section">
								<div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명</li>
										<li class="c-table-name">기수</li>
										<li class="c-table-03">학습기간</li>
										<li class="c-table-01">강의실</li>
									</ul>
									<c:if test="${!empty progressList }">
										<c:forEach var="item" items="${progressList }"
											varStatus="status">
											<ul class="class-list-wrap">
												<!-- 과정명 추가시 list and(+) Wrap 추가  -->
												<li class="listAndwrap">
													<div class="class-list d-flex">
														<div class="c-table-num">${status.count}</div>
														<div class="c-table-name">${item.NAME }</div>
														<div class="c-table-name">${item.CARDINAL_NAME }</div>
														<div class="c-table-03">${item.LEARN_START_DATE }-
															${item.LEARN_END_DATE }</div>
														<div class="c-table-01 c-table-btn">
															<!-- 강의실 버튼 클릭시 모달창으로 넘어가는 정보  -->
															<form name="listForm" method="post" onsubmit="return false;">
																<input type="hidden" name="courseName" value="${item.NAME }"/>
																<input type="hidden" name="realStartDate" value="${item.REAL_START_DATE }"/>
																<input type="hidden" name="realEndDate" value="${item.REAL_END_DATE }"/>
																<input type="hidden" name="learnStartDate" value="${item.LEARN_START_DATE }"/>
																<input type="hidden" name="learnEndDate" value="${item.LEARN_END_DATE }"/>
																<input type="hidden" name="cardinalId" value="${item.CARDINAL_ID }"/>
																<input type="hidden" name="id" value="${item.ID }"/>
																<input type="hidden" name="courseId" value="${item.COURSE_ID }"/>
																<input type="hidden" name="courseId" value="${item.COURSE_ID }"/>
																<input type="hidden" name="compQuizPercent" value="${item.QUPERCENT}"/>
																<input type="hidden" name="compExamPercent" value="${item.EXPERCENT}"/>
																<input type="hidden" name="compProgPercent" value="${item.PRPERCENT}"/>
																<input type="hidden" name="completeTotal" value="${item.TOTAL}"/>
																<input type="hidden" name="compQuizScore" value="${item.QUSCORE}"/>
																<input type="hidden" name="compExamScore" value="${item.EXSCORE}"/>
																<input type="hidden" name="compProgScore" value="${item.PRSCORE}"/>
																<input type="hidden" name="completeTotal" value="${item.TOTAL}"/>
															</form>
															<a class="button btn-myClass classRoom modal-popup"><span
																class="h5">강의실</span></a>
														</div>
														<!-- <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">상세</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div> -->
													</div> <!-- open-class 클릭하면 open-ctt가 .slideToggle되고 hide-show-txt.text(닫기);로 바뀐다. -->
													<!-- <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">과목명</li>
                                                    <li class="c-table-num">기수</li>
                                                    <li class="c-table-03">학습현황</li>
                                                    <li class="c-table-01">강의실</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    과목명 추가시 class-list추가
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 1 (상)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">강의실</span></a></div>
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 1 (하)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">강의실</span></a></div>
                                                    </li>
                                                </ul>
                                            </div> -->
												</li>
												<!-- <li class="listAndwrap">
                                            <div class="class-list d-flex">
                                                <div class="c-table-num">2</div>
                                                <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 2</div>
                                                <div class="c-table-num">1기</div>
                                                <div class="c-table-03">2019.08.05 - 2019.09.04</div>
                                                <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">상세</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div>
                                            </div>
                                            open-class 클릭하면 open-ctt가 .slideToggle되고 hide-show-txt.text(닫기);로 바뀐다.
                                            <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">과목명</li>
                                                    <li class="c-table-num">기수</li>
                                                    <li class="c-table-03">학습현황</li>
                                                    <li class="c-table-01">강의실</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    과목명 추가시 class-list추가
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 2 (상)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">강의실</span></a></div>
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 2 (하)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">강의실</span></a></div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li> -->
											</ul>
										</c:forEach>
									</c:if>
									<c:if test="${empty progressList }">
										<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>
									</c:if>
								</div>
							</div>
						</div>
						<div class="tab-sub sub02">
							<div class="sub-section">
								<div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명</li>
										<li class="c-table-name">기수</li>
										<li class="c-table-04">학습기간</li>
										<li class="c-table-01">결제상태</li>
									</ul>
									<c:if test="${!empty waitingList }">
										<c:forEach var="item" items="${waitingList }"
											varStatus="status">
											<ul class="class-list-wrap">
												<!-- 과정명 추가시 list and(+) Wrap 추가  -->
												<li class="class-list d-flex">
													<div class="c-table-num">${status.count }</div>
													<div class="c-table-name">${item.NAME }</div>
													<div class="c-table-name">${item.CARDINAL_NAME }</div>
													<div class="c-table-04">${item.LEARN_START_DATE }-
														${item.LEARN_END_DATE }</div>
													<c:choose>
													<c:when test="${item.PAYMENT_STATE eq 1 }">	
													<div class="c-table-01 payment-wait">대기</div>
													<!-- 결제상태 : 가상계좌 선택 시 입금전,입금완료 표시 할 것 -->
													</c:when>
													<c:when test="${item.PAYMENT_STATE eq 2 }">
													<div class="c-table-01 payment-complete">완료</div>
													</c:when>
													</c:choose>
												</li>
												<!-- <li class="class-list d-flex">
                                            <div class="c-table-num">1</div>
                                            <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 2</div>
                                            <div class="c-table-num">1기</div>
                                            <div class="c-table-04">2019.08.05 - 2019.09.04</div>
                                        </li> -->
											</ul>
										</c:forEach>
									</c:if>
									<c:if test="${empty waitingList }">
										<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>
									</c:if>
								</div>
							</div>
						</div>
						<div class="tab-sub sub03 hideTab">
							<div class="sub-section">
								<div class="sub-segment">
									<ul class="class-list-title thead d-flex">
										<li class="c-table-num">No.</li>
										<li class="c-table-name">과정명</li>
										<li class="c-table-01">기수</li>
										<li class="c-table-01"></li>
										<li class="c-table-02">복습기간</li>
										<li class="c-table-01">수료여부</li>
										<li class="c-table-01"></li>
									</ul>
									<c:if test="${!empty completeList }">
										<c:forEach var="item" items="${completeList}"
											varStatus="status">
											<ul class="class-list-wrap">
												<!-- 과정명 추가시 list and(+) Wrap 추가  -->
												<li class="listAndwrap">
												<!-- 강의실 버튼 클릭시 모달창으로 넘어가는 정보  -->
												<form name="listForm" method="post" onsubmit="return false;">
													<input type="hidden" name="courseName" value="${item.NAME }"/>
													<input type="hidden" name="realStartDate" value="${item.REAL_START_DATE }"/>
													<input type="hidden" name="realEndDate" value="${item.REAL_END_DATE }"/>
													<input type="hidden" name="learnStartDate" value="${item.LEARN_START_DATE }"/>
													<input type="hidden" name="learnEndDate" value="${item.LEARN_END_DATE }"/>
													<input type="hidden" name="cardinalId" value="${item.CARDINAL_ID }"/>
													<input type="hidden" name="id" value="${item.ID }"/>
													<input type="hidden" name="courseId" value="${item.COURSE_ID }"/>
													<input type="hidden" name="compQuizPercent" value="${item.QUPERCENT}"/>
													<input type="hidden" name="compExamPercent" value="${item.EXPERCENT}"/>
													<input type="hidden" name="compProgPercent" value="${item.PRPERCENT}"/>
													<input type="hidden" name="completeTotal" value="${item.TOTAL}"/>
													<input type="hidden" name="compQuizScore" value="${item.QUSCORE}"/>
													<input type="hidden" name="compExamScore" value="${item.EXSCORE}"/>
													<input type="hidden" name="compProgScore" value="${item.PRSCORE}"/>
													<input type="hidden" name="completeTotal" value="${item.TOTAL}"/>	
												</form>
													<div class="class-list d-flex">
														<div class="c-table-num">${status.count }</div>
														<div class="c-table-name">${item.NAME }</div>
														<div class="c-table-01">${item.CARDINAL_NAME }</div>
														<div class="c-table-01"></div>
														<div class="c-table-02">${item.REAL_START_DATE }-
															${item.REAL_END_DATE }</div>
															<c:choose>
																<c:when
																	test="${item.ISSUE_YN eq 'Y' }"><!-- and not empty item.ISSUE_NUM  -->
																	<div class="c-table-01 c-table-btn">
																		<a href="#" class="button btn-certificate">
																			<span class="h5">수료증</span>
																		</a>
																	</div>
																	<!-- 수료시 복습기간이 지나지 않았으면 복습하기 처리, 지났으면 만료 처리 -->
																	<c:set var="today" value="<%=new java.util.Date() %>"/>
																	<fmt:parseDate var="realEndDateSt" value="${item.REAL_END_DATE }" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="realEndDate" value="${realEndDateSt}" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="now" type="date" value="${today }" pattern="yyyy-MM-dd"/>
																	<c:choose>
																		<c:when test="${now > realEndDate }">
																			<div class="c-table-01 c-table-btn">
                                                								<a class="button btn-not2">
                                                    							<span class="h5">기간만료</span></a>
                                                    						</div>
																		</c:when>
																		<c:otherwise>
																			<div class="c-table-01 c-table-btn">
					                                                		<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">복습하기</span></a>
					                                            			</div>
																		</c:otherwise>
																	</c:choose>
																	<!-- 수료시 복습기간 처리 완료 -->
																</c:when>
																<c:otherwise>
																	<div class="c-table-01 c-table-btn">
																		<a class="button btn-not"><span class="h5">미수료</span></a>
																	</div>
																	<!-- 수료시 복습기간이 지나지 않았으면 복습하기 처리, 지났으면 만료 처리 -->
																	<c:set var="today" value="<%=new java.util.Date() %>"/>
																	<fmt:parseDate var="realEndDateSt" value="${item.REAL_END_DATE }" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="realEndDate" value="${realEndDateSt}" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="now" type="date" value="${today }" pattern="yyyy-MM-dd"/>
																	<c:choose>
																		<c:when test="${now > realEndDate }">
																			<div class="c-table-01 c-table-btn">
                                                								<a class="button btn-not2">
                                                    							<span class="h5">기간만료</span></a>
                                                    						</div>
																		</c:when>
																		<c:otherwise>
																			<div class="c-table-01 c-table-btn">
					                                                		<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">복습하기</span></a>
					                                            			</div>
																		</c:otherwise>
																	</c:choose>
																	<!-- 수료시 복습기간 처리 완료 -->
																</c:otherwise>
															</c:choose>
														
														<!-- <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">상세</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div> -->
													</div> <!-- open-class 클릭하면 open-ctt가 .slideToggle되고 hide-show-txt.text(닫기);로 바뀐다. -->
													<!-- <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">과목명</li>
                                                    <li class="c-table-num">기수</li>
                                                    <li class="c-table-03">학습현황</li>
                                                    <li class="c-table-01">강의실</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    과목명 추가시 class-list추가
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 1 (상)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a href="#" class="button btn-myClass classRoom"><span class="h5">복습하기</span></a></div>
                                                        19.11.21 기존의 btn-bl버튼이 btn-myClass로 클래스가 변경되었습니다.
                            sub07-01~03 동일합니다.
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 1 (하)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a href="#" class="button btn-myClass classRoom"><span class="h5">복습하기</span></a></div>
                                                    </li>
                                                </ul>
                                            </div> -->
												</li>
												<!-- <li class="listAndwrap">
                                            <div class="class-list d-flex">
                                                <div class="c-table-num">2</div>
                                                <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 2</div>
                                                <div class="c-table-num">1기</div>
                                                <div class="c-table-02">2019.08.05 - 2019.09.04</div>
                                                <div class="c-table-01 c-table-btn">
                                                    <a href="#" class="button btn-myClass btn-certificate">
                                                        <span class="h5">수료증</span>
                                                    </a>
                                                </div>
                                                <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">상세</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div>
                                            </div>
                                            open-class 클릭하면 open-ctt가 .slideToggle되고 hide-show-txt.text(닫기);로 바뀐다.
                                            <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">과목명</li>
                                                    <li class="c-table-num">기수</li>
                                                    <li class="c-table-03">학습현황</li>
                                                    <li class="c-table-01">강의실</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    과목명 추가시 class-list추가
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 2 (상)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="h5 c999 c-table-01">기간만료</div>
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">세상에서 가장 쉬운 영단어 Step 2 (하)</div>
                                                        <div class="c-table-num">1기</div>
                                                        <div class="c-table-01">진도<div class="percent prct1">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">시험<div class="percent prct2">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">과제<div class="percent prct3">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="h5 c999 c-table-01">기간만료</div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li> -->
											</ul>
										</c:forEach>
									</c:if>
									<c:if test="${empty completeList }">
										<div class="c-table-03 not"><p>조회된 내용이 없습니다.</p></div>
									</c:if>
								</div>
							</div>
						</div>
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
