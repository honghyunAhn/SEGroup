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
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style.css" />">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/lms/css/style_responsive.css" />">
    <script src="<c:url value="/resources/lms/js/jquery-3.3.1.min.js" />"></script>
<%--     <script src="<c:url value="/resources/lms/js/common.js" />"></script> --%>
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
    	
    	// ?????? ?????? ????????? ??????
    	$('.progYn').eq(chasi-1).attr('class', 'img-icon attendanceY progYn');
    }

    //???????????? ????????? ?????????
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
    				//1. ???????????? ???????????? 2.????????????????????? ????????? ??????????????? ?????? url??? ????????????. 
    				var content ="";
    				if(data !='') {
    					$.each(data, function(index, lessonList) {
    						var prevProgYn = 'N'
    						content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
    						content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
    						content += '<div class="c-table-num">'+lessonList.STUDY+'???</div>';
    						content += '<div class="c-table-num"></div>'
    	                    content += '<div class="c-table-num">'; //???????????? Y/N
    	                    
    		                    if(lessonList.PROG_YN == 'Y') {
    		                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
    		                    }else if(lessonList.PROG_YN == 'N') {
    		                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
    		                    }
    	                    
    	                  	// content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="window.open(\''+lessonList.MAIN_URL+'\',\'video\',\'width=1000,height=700,location=no,status=no,scrollbars=yes\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';
    	                    //content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goStudy('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +','+lessonList.STUDY+','+lessonList.CHK+',\''+lessonList.PROG_YN+'\',\''+lessonList.MAIN_URL+'\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';
    	                    content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +',\''+lessonList.PROG_YN+'\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';


    					});
                           
    				} else {
    					content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.</p></div></li>';
    				}
    				
    				$('.class-list-wrap.modal-ovflowY').html(content);

    			},
    			error : function(request, status, error) {
    				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    			}
    			
    		});
    		
    	} else if(i == '2') { //?????? ???
    		
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
    	                                    bContent += '<div class="c-table-01 cDanger">?????????</div>';
    	                                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></li>';
    	                                   
    								});
    								
    						} else {
    							bContent += '<li class="class-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.</p></div></li>';
    						}
    							$('.class-list-wrap.assignment').empty().append(bContent);
    					},
    					error :  function(request, status, error) {
    						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    					}
    					
    				}); 
    	
    		} else if(i == '3') { //?????? ???
    	
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
    				                    bContent += '<div class="c-table-01 cDanger">?????????</div>';
    				                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></div>';
    				                    bContent +='<div class="open-asw open-ctt"> <ul class="class-list-wrap"> <li class="icon-align aswr-box d-flex">';
    				                    bContent +='<div class="c999">??????<br>??????<br>??????</div>';
    				                    bContent +=' <div class="text-over-lh20"> </div></li>';
    								});
    						} else {
    							bContent += '<li class="class-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.<p></div></li>';
    						}
    							$('.class-list-wrap.exam').empty().append(bContent);
    					},
    					error :  function(request, status, error) {
    						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    					}
    	   	 });
    	   
    	} else if(i == '4') { //???????????? ???
    		
    		$.ajax({
    			contentType : "application/json",
    			dataType : "json",
    			type	: "get",
    			url		: "/lms/user/courseBoardList",
    			cache : false,
    			data    : {
    				"course" : course
    				,"index" : "1" //board_type (????????????) : 1
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
    							bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>?????????????????? ???????????? ????????????.</p></div></li>';
    					}
    							$('.class-list-wrap.boardType01').empty().append(bContent);
    			},
    			error : function(request, status, error) {
    				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    			}
    		});
    	  
    	} else if(i == '5') { //????????? ???

    		$.ajax({
    			contentType : "application/json",
    			dataType : "json",
    			type	: "get",
    			url		: "/lms/user/courseBoardList",
    			cache: false,
    			data    : {
    				"course" : course
    				,"index" : "2" //board_type (?????????) : 2
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
    							//???????????? ??????
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
    							
    							bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>?????????????????? ???????????? ????????????.</p></div></li>';
    					}
    							
    							$('.class-list-wrap.boardType02').empty().append(bContent);
    					
    			},
    			error :  function(request, status, error) {
    				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    			}
    		
    		});
    	}
    }//?????? ??????


    /* function goStudy(learnAppId, course, cardinal, chapter, chasi, study, chk, progYn, url) {
    	// ?????? ?????? ????????? ?????? ?????? ?????? ??????
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
    				// ???????????? o??? ??????
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
    	
    		//???????????? ??????
    		var idx = $('.modal-popup').index($(this));
    		var course = $(':hidden[name="courseId"]').eq(idx).val();
    		var cardinal = $(':hidden[name="cardinalId"]').eq(idx).val();
    		var learnStartDate = $(':hidden[name="learnStartDate"]').eq(idx).val();
    		var learnEndDate = $(':hidden[name="learnEndDate"]').eq(idx).val();
    		var realStartDate = $(':hidden[name="realStartDate"]').eq(idx).val();
    		var realEndDate = $(':hidden[name="realEndDate"]').eq(idx).val();
    		var id = $(':hidden[name="id"]').eq(idx).val();
    		var courseName = $(':hidden[name="courseName"]').eq(idx).val();//?????????
    		var completeQuizPercent = $(':hidden[name="compQuizPercent"]').eq(idx).val();//?????? ???????????? ??????
    		var completeExamPercent = $(':hidden[name="compExamPercent"]').eq(idx).val();//?????? ???????????? ??????
    		var completeProgPercent = $(':hidden[name="compProgPercent"]').eq(idx).val();//?????? ???????????? ?????????
    		var completeQuizScore = $(':hidden[name="compQuizScore"]').eq(idx).val();//?????? ?????? ??????
    		var completeExamScore = $(':hidden[name="compExamScore"]').eq(idx).val();//?????? ?????? ??????
    		var completeProgScore = $(':hidden[name="compProgScore"]').eq(idx).val();//?????? ????????? ??????
    		var completeTotal = $(':hidden[name="completeTotal"]').eq(idx).val();//???????????? ??????
    		
    		//??????>>??? ??????
    		var $modaltab = $('.section div.class-tabMenu>.modal-tabGroup>li');
            var  i = 0;

           $modaltab.on('click', function(t) {
        	   i = $(this).index(); //?????????,????????????,??????QnA
                if(i == '1' || i == '2' || i == '3' || i == '4' || i == '5') {
                	myLectureInfo(course,cardinal,id,i);
                }
            }); 
            // ?????? >> ??? ?????? ???
            
            /*
         //?????? ????????? default??? ????????????  ?????? ???????????? ?????? ????????? ???????????? 
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
    				//1. ???????????? ???????????? 2.????????????????????? ????????? ??????????????? ?????? url??? ????????????. 
    				var content ="";
    				if(data !='') {
    					$.each(data, function(index, lessonList) {
    						var prevProgYn = 'N'
    						content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
    						content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
    						content += '<div class="c-table-num">'+lessonList.STUDY+'???</div>';
    						content += '<div class="c-table-num"></div>'
    	                    content += '<div class="c-table-num">'; //???????????? Y/N
    	                    
    		                    if(lessonList.PROG_YN == 'Y') {
    		                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
    		                    }else if(lessonList.PROG_YN == 'N') {
    		                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
    		                    }
    	                    
    	                  	// content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="window.open(\''+lessonList.MAIN_URL+'\',\'video\',\'width=1000,height=700,location=no,status=no,scrollbars=yes\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';
    	                    content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goStudy('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +','+lessonList.STUDY+','+lessonList.CHK+',\''+lessonList.PROG_YN+'\',\''+lessonList.MAIN_URL+'\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';


    					});
                           
    				} else {
    					content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.</p></div></li>';
    				}
    				
    				$('.class-list-wrap.modal-ovflowY').html(content);

    			},
    			error : function(request, status, error) {
    				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    			}
    			
    		});//ajax getLessonInfo ??????
    		*/
    		
    		//???????????? ??????
    		$('.classTitle').html(courseName);
    		$('.learn').html(learnStartDate+' - '+learnEndDate);//????????????
    		$('.recap').html(realStartDate+' - '+realEndDate);//????????????
    		$('.completeQuizPercent').html(completeQuizPercent);
    		$('.completeExamPercent').html(completeExamPercent);
    		$('.completeProgPercent').html(completeProgPercent);
    		$('.completeQuizScore').html(completeQuizScore);
    		$('.completeExamScore').html(completeExamScore);
    		$('.completeProgScore').html(completeProgScore);
    		$('.completeTotal').html("<b class='c666'>?????? "+completeTotal+"??? ??????</b>");
            
    	});
    	

    	/* //???????????? ????????? ?????????
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
    					//1. ???????????? ???????????? 2.????????????????????? ????????? ??????????????? ?????? url??? ????????????. 
    					var content ="";
    					if(data !='') {
    						$.each(data, function(index, lessonList) {
    							var prevProgYn = 'N'
    							content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
    							content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
    							content += '<div class="c-table-num">'+lessonList.STUDY+'???</div>';
    							content += '<div class="c-table-num"></div>'
    		                    content += '<div class="c-table-num">'; //???????????? Y/N
    		                    
    			                    if(lessonList.PROG_YN == 'Y') {
    			                    	content += '<div class="img-icon attendanceN progYn"></div></div>';
    			                    }else if(lessonList.PROG_YN == 'N') {
    			                    	content += '<div class="img-icon attendanceY progYn"></div></div>';
    			                    }
    		                    
    		                  	// content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="window.open(\''+lessonList.MAIN_URL+'\',\'video\',\'width=1000,height=700,location=no,status=no,scrollbars=yes\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';
    		                    //content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goStudy('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+','+(index + 1) +','+lessonList.STUDY+','+lessonList.CHK+',\''+lessonList.PROG_YN+'\',\''+lessonList.MAIN_URL+'\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';
    		                    content += '<div class="c-table-02 c-table-btn"><a class="button btn-bl btn-study d-flex" type="button" onclick="goPlayer('+id+',\''+course+'\',\''+cardinal+'\','+lessonList.CHAPTER_ID+',\''+lessonList.PROG_YN+'\');"><div class="img-icon study"></div><span class="h5">????????????</span></a></div></li>';


    						});
    	                       
    					} else {
    						content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.</p></div></li>';
    					}
    					
    					$('.class-list-wrap.modal-ovflowY').html(content);

    				},
    				error : function(request, status, error) {
    					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    				}
    				
    			});
    			
    		} else if(i == '2') { //?????? ???
        		
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
    		                                    bContent += '<div class="c-table-01 cDanger">?????????</div>';
    		                                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></li>';
    		                                   
    									});
    									
    							} else {
    								bContent += '<li class="class-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.</p></div></li>';
    							}
    								$('.class-list-wrap.assignment').empty().append(bContent);
    						},
    						error :  function(request, status, error) {
    							alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    						}
    						
    					}); 
    		
       		} else if(i == '3') { //?????? ???
    		
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
    					                    bContent += '<div class="c-table-01 cDanger">?????????</div>';
    					                    bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></div>';
    					                    bContent +='<div class="open-asw open-ctt"> <ul class="class-list-wrap"> <li class="icon-align aswr-box d-flex">';
    					                    bContent +='<div class="c999">??????<br>??????<br>??????</div>';
    					                    bContent +=' <div class="text-over-lh20"> </div></li>';
    									});
    							} else {
    								bContent += '<li class="class-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.<p></div></li>';
    							}
    								$('.class-list-wrap.exam').empty().append(bContent);
    						},
    						error :  function(request, status, error) {
    							alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    						}
    		   	 });
    		   
    		} else if(i == '4') { //???????????? ???
    			
    			$.ajax({
    				contentType : "application/json",
    				dataType : "json",
    				type	: "get",
    				url		: "/lms/user/courseBoardList",
    				cache : false,
    				data    : {
    					"course" : course
    					,"index" : "1" //board_type (????????????) : 1
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
    								bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>?????????????????? ???????????? ????????????.</p></div></li>';
    						}
    								$('.class-list-wrap.boardType01').empty().append(bContent);
    				},
    				error : function(request, status, error) {
    					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    				}
    			});
    		  
    		} else if(i == '5') { //????????? ???

    			$.ajax({
    				contentType : "application/json",
    				dataType : "json",
    				type	: "get",
    				url		: "/lms/user/courseBoardList",
    				cache: false,
    				data    : {
    					"course" : course
    					,"index" : "2" //board_type (?????????) : 2
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
    								//???????????? ??????
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
    								
    								bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>?????????????????? ???????????? ????????????.</p></div></li>';
    						}
    								
    								$('.class-list-wrap.boardType02').empty().append(bContent);
    						
    				},
    				error :  function(request, status, error) {
    					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
    				}
    			
    			});
    		}
    	}//?????? ?????? */
    	
    	// ????????????
    	

    	$(document).on('click', '.board-list.open-answer',function(){
    		$(this).next().slideToggle();
      	});
    	
    	$('.modal .close-modal').click(function() {
    	 //?????? ????????? ?????? ?????? ???????????? ?????? ?????? ?????? append ????????? ???????????? ????????????
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
        <!--????????????/content-->
        <p><a class="goToMain" href="#main">????????? ????????????</a></p>
    </div>

    <!-- header-include -->
    <%@include file="../header.jsp"%>


    <div class="container sub07" id="main">
        <!-- sub07 ???????????????-include -->
        <%@include file="../user/menu/leftmenu07.jsp"%>

        <div class="sub-content sub07 sub07-01">
            <!-- ?????? ????????? ?????? ?????? -->
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
                    home ?????? / category menu ????????? / division menu ????????? / section menu ?????????
                    -->
                    <li class="img-icon  home"><a href="/"></a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub07-01-01">???????????????</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub07-01-01">????????????</a></li>
                    <li class="img-icon  chevron-right"></li>
                    <li class="section-menu"><a href="/lms/user/sub07-01-03">????????????</a></li>
                </ul>
                <div class="img-icon  chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>
            <div class="header">
                <div class="titleBar h3">????????????</div>
                <!-- <h3 class="h3"></h3> -->
            </div>
            <div class="section sub07-01 sub07-01-03">

                <!-- ???????????? ??? -->
                <div class="class-tabMenu">
                    <ul class="tabGroup d-flex">
                        <li>?????? ???</li>
                        <li>?????? ??????</li>
                        <li class="active">?????? ??????</li>
                    </ul>
                    <div class="subGroup">
                        <div class="tab-sub sub01 hideTab">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name">?????????</li>
                                        <li class="c-table-name">??????</li>
                                        <li class="c-table-03">????????????</li>
                                        <li class="c-table-01">?????????</li>
                                    </ul>
                                    <c:if test="${!empty progressList }">
										<c:forEach var="item" items="${progressList }"
											varStatus="status">
                                    <ul class="class-list-wrap">
                                        <!-- ????????? ????????? list and(+) Wrap ??????  -->
                                        <li class="listAndwrap">
                                            <div class="class-list d-flex">
                                                <div class="c-table-num">${status.count}</div>
														<div class="c-table-name">${item.NAME }</div>
														<div class="c-table-name">${item.CARDINAL_NAME }</div>
														<div class="c-table-03">${item.LEARN_START_DATE }-
															${item.LEARN_END_DATE }</div>
														<div class="c-table-01 c-table-btn">
															<!-- ????????? ?????? ????????? ??????????????? ???????????? ??????  -->
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
															<a class="button btn-myClass classRoom modal-popup" ><span
																class="h5">?????????</span></a>
														</div>
                                                <!-- <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">??????</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div> -->
                                            </div>
                                            <!-- open-class ???????????? open-ctt??? .slideToggle?????? hide-show-txt.text(??????);??? ?????????. -->
                                            <!-- <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">?????????</li>
                                                    <li class="c-table-num">??????</li>
                                                    <li class="c-table-03">????????????</li>
                                                    <li class="c-table-01">?????????</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    ????????? ????????? class-list??????
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 1 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">?????????</span></a></div>
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 1 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">?????????</span></a></div>
                                                    </li>
                                                </ul>
                                            </div> -->
                                        </li>
                                        <!-- <li class="listAndwrap">
                                            <div class="class-list d-flex">
                                                <div class="c-table-num">2</div>
                                                <div class="c-table-name">???????????? ?????? ?????? ????????? Step 2</div>
                                                <div class="c-table-num">1???</div>
                                                <div class="c-table-03">2019.08.05 - 2019.09.04</div>
                                                <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">??????</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div>
                                            </div>
                                            open-class ???????????? open-ctt??? .slideToggle?????? hide-show-txt.text(??????);??? ?????????.
                                            <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">?????????</li>
                                                    <li class="c-table-num">??????</li>
                                                    <li class="c-table-03">????????????</li>
                                                    <li class="c-table-01">?????????</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    ????????? ????????? class-list??????
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 2 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">?????????</span></a></div>
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 2 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a class="button btn-myClass classRoom modal-popup"><span class="h5">?????????</span></a></div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li> -->
                                    </ul>
                                    </c:forEach>
									</c:if>
									<c:if test="${empty progressList }">
										<div class="c-table-03 not"><p>????????? ????????? ????????????.</p></div>
									</c:if>
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub sub02 hideTab">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name">?????????</li>
                                        <li class="c-table-name">??????</li>
                                        <li class="c-table-04">????????????</li>
                                        <li class="c-table-01">????????????</li>
                                    </ul>
                                    <c:if test="${!empty waitingList }">
										<c:forEach var="item" items="${waitingList }"
											varStatus="status">
                                    <ul class="class-list-wrap">
                                        <!-- ????????? ????????? list and(+) Wrap ??????  -->
                                        <li class="class-list d-flex">
                                           <div class="c-table-num">${status.count }</div>
													<div class="c-table-name">${item.NAME }</div>
													<div class="c-table-name">${item.CARDINAL_NAME }</div>
													<div class="c-table-04">${item.LEARN_START_DATE }-
														${item.LEARN_END_DATE }</div>
													<c:choose>
													<c:when test="${item.PAYMENT_STATE eq 1 }">	
													<div class="c-table-01 payment-wait">??????</div>
													<!-- ???????????? : ???????????? ?????? ??? ?????????,???????????? ?????? ??? ??? -->
													</c:when>
													<c:when test="${item.PAYMENT_STATE eq 2 }">
													<div class="c-table-01 payment-complete">??????</div>
													</c:when>
													</c:choose>
                                        </li>
                                        <!-- <li class="class-list d-flex">
                                            <div class="c-table-num">1</div>
                                            <div class="c-table-name">???????????? ?????? ?????? ????????? Step 2</div>
                                            <div class="c-table-num">1???</div>
                                            <div class="c-table-04">2019.08.05 - 2019.09.04</div>
                                        </li> -->
                                    </ul>
                                    </c:forEach>
									</c:if>
									<c:if test="${empty waitingList }">
										<div class="c-table-03 not"><p>????????? ????????? ????????????.</p></div>
									</c:if>
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub sub03">
                            <div class="sub-section">
                                <div class="sub-segment">
                                    <ul class="class-list-title thead d-flex">
                                        <li class="c-table-num">No.</li>
                                        <li class="c-table-name">?????????</li>
                                        <li class="c-table-01">??????</li>
                                        <li class="c-table-01"></li>
                                        <li class="c-table-02">????????????</li>
                                        <li class="c-table-01">????????????</li>
                                        <li class="c-table-01"></li>
                                    </ul>
                                    <c:if test="${!empty completeList }">
										<c:forEach var="item" items="${completeList}"
											varStatus="status">
                                    <ul class="class-list-wrap">
                                        <!-- ????????? ????????? list and(+) Wrap ??????  -->
                                        <li class="listAndwrap">
                                        <!-- ????????? ?????? ????????? ??????????????? ???????????? ??????  -->
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
																<c:when test="${item.ISSUE_YN eq 'Y' }"> <!-- and not empty item.ISSUE_NUM -->
																	<div class="c-table-01 c-table-btn">
																		<a href="#" class="button btn-certificate">
																			<span class="h5">?????????</span>
																		</a>
																	</div>
																	<!-- ????????? ??????????????? ????????? ???????????? ???????????? ??????, ???????????? ?????? ?????? -->
																	<c:set var="today" value="<%=new java.util.Date() %>"/>
																	<fmt:parseDate var="realEndDateSt" value="${item.REAL_END_DATE }" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="realEndDate" value="${realEndDateSt}" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="now" type="date" value="${today }" pattern="yyyy-MM-dd"/>
																	<c:choose>
																		<c:when test="${now > realEndDate }">
																			<div class="c-table-01 c-table-btn">
                                                								<a class="button btn-not2">
                                                    							<span class="h5">????????????</span></a>
                                                    						</div>
																		</c:when>
																		<c:otherwise>
																			<div class="c-table-01 c-table-btn">
					                                                		<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">????????????</span></a>
					                                            			</div>
																		</c:otherwise>
																	</c:choose>
																	<!-- ????????? ???????????? ?????? ?????? -->
																</c:when>
																<c:otherwise>
																	<div class="c-table-01 c-table-btn">
																		<a class="button btn-not"><span class="h5">?????????</span></a>
																	</div>
																	<!-- ????????? ??????????????? ????????? ???????????? ???????????? ??????, ???????????? ?????? ?????? -->
																	<c:set var="today" value="<%=new java.util.Date() %>"/>
																	<fmt:parseDate var="realEndDateSt" value="${item.REAL_END_DATE }" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="realEndDate" value="${realEndDateSt}" pattern="yyyy-MM-dd"/>
																	<fmt:formatDate var="now" type="date" value="${today }" pattern="yyyy-MM-dd"/>
																	<c:choose>
																		<c:when test="${now > realEndDate }">
																			<div class="c-table-01 c-table-btn">
                                                								<a class="button btn-not2">
                                                    							<span class="h5">????????????</span></a>
                                                    						</div>
																		</c:when>
																		<c:otherwise>
																			<div class="c-table-01 c-table-btn">
					                                                		<a href="#" class="button btn-myClass classRoom modal-popup"><span class="h5">????????????</span></a>
					                                            			</div>
																		</c:otherwise>
																	</c:choose>
																	<!-- ????????? ???????????? ?????? ?????? -->
																</c:otherwise>
															</c:choose>
													
                                                <!-- <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">??????</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div> -->
                                            </div>
                                            <!-- open-class ???????????? open-ctt??? .slideToggle?????? hide-show-txt.text(??????);??? ?????????. -->
                                            <!-- <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">?????????</li>
                                                    <li class="c-table-num">??????</li>
                                                    <li class="c-table-03">????????????</li>
                                                    <li class="c-table-01">?????????</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    ????????? ????????? class-list??????
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 1 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a href="#" class="button btn-myClass classRoom"><span class="h5">????????????</span></a></div>
                                                        19.11.21 ????????? btn-bl????????? btn-myClass??? ???????????? ?????????????????????.
                                                        sub07-01~03 ???????????????.
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 1 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>0</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01 c-table-btn"><a href="#" class="button btn-myClass classRoom"><span class="h5">????????????</span></a></div>
                                                    </li>
                                                </ul>
                                            </div> -->
                                        </li>
                                        <!-- <li class="listAndwrap">
                                            <div class="class-list d-flex">
                                                <div class="c-table-num">2</div>
                                                <div class="c-table-name">???????????? ?????? ?????? ????????? Step 2</div>
                                                <div class="c-table-num">1???</div>
                                                <div class="c-table-02">2019.08.05 - 2019.09.04</div>
                                                <div class="c-table-01 c-table-btn">
                                                    <a href="#" class="button btn-myClass btn-certificate">
                                                        <span class="h5">?????????</span>
                                                    </a>
                                                </div>
                                                <div class="open-class d-flex c-table-01">
                                                    <span class="hide-show-txt">??????</span>
                                                    <div class="img-icon sort-up"></div>
                                                </div>
                                            </div>
                                            open-class ???????????? open-ctt??? .slideToggle?????? hide-show-txt.text(??????);??? ?????????.
                                            <div class="open-ctt">
                                                <ul class="class-list-title thead d-flex">
                                                    <li class="c-table-num">No.</li>
                                                    <li class="c-table-name">?????????</li>
                                                    <li class="c-table-num">??????</li>
                                                    <li class="c-table-03">????????????</li>
                                                    <li class="c-table-01">?????????</li>
                                                </ul>
                                                <ul class="class-list-wrap">
                                                    ????????? ????????? class-list??????
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">1</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 2 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="h5 c999 c-table-01">????????????</div>
                                                    </li>
                                                    <li class="class-list d-flex">
                                                        <div class="c-table-num">2</div>
                                                        <div class="c-table-name">???????????? ?????? ?????? ????????? Step 2 (???)</div>
                                                        <div class="c-table-num">1???</div>
                                                        <div class="c-table-01">??????<div class="percent prct1">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct2">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="c-table-01">??????<div class="percent prct3">
                                                                <span>100</span>%
                                                            </div>
                                                        </div>
                                                        <div class="h5 c999 c-table-01">????????????</div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </li> -->
                                    </ul>
                                    </c:forEach>
									</c:if>
									<c:if test="${empty completeList }">
										<div class="c-table-03 not"><p>????????? ????????? ????????????.</p></div>
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
            <!-- 19.11.21 myClass?????? ???????????? ?????????????????????. -->
            <!-- modal ???????????? 1?????? include -->
            <%@include file="../user/modal/modal-sub07-01-01.jsp"%>
        </div>
    </div>
    <!-- footer-include -->
    <%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
