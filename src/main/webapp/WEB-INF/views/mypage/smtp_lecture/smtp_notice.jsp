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
			url		: "/smtp/user/getLessonInfo",
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
						allContentsNum+=1;
						var prevProgYn = 'N'
						content += '<li class="class-list board-list d-flex"><div class="c-table-num">'+(index + 1)+'</div>';
						content += '<div class="c-table-name text-over-lh20">'+lessonList.CHAPTER_NAME+'</div>';
						content += '<div class="c-table-num">'+lessonList.STUDY+'???</div>';
						content += '<div class="c-table-num"></div>'
	                    content += '<div class="c-table-num">'; //???????????? Y/N
	                    
		                    if(lessonList.PROG_YN == 'Y') {
		                    	doneContents+=1;
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
				timeChk();
				$('.class-list-wrap.modal-ovflowY').html(content);
				doneContents=0;
				allContentsNum=0;
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
			url		: "/smtp/user/courseBoardList",
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
			url		: "/smtp/user/courseBoardList",
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
								bContent += '<div class="c-table-01"><a href="/smtp/user/downloadFile?file_1='+cbList.ATTACH1_FILE+'&file_2='+cbList.ATTACH2_FILE+'"><div class="img-icon save"></div></a></div>';
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
	}else if(i == '6') { //????????????

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
							if(status=='??????'){
								ecolor='#54f542';
							}else if(status=='??????'){
								ecolor='#eb3477';
							}else if(status=='??????'){
								ecolor='#3440eb';
							}else if(status=='??????'){
								ecolor='#ebdc34';
							}
							
							if(dateList.ISGONE=='Y'){
								status+="/??????";
							}
							 
					
							eventsData.push({
								
								start: dateList.PRESENT_DATE,
								end: dateList.PRESENT_DATE+" 22:00:00",
								title:status,
								color:ecolor
								
								
							});
							
						});
						
						
					}else {
							
							bContent += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>??????????????? ???????????? ????????????.</p></div></li>';
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
function timeChk(){
	
	var calStatus=0;
	
	if(allContentsNum==0){
		calStatus=0;
		$('.progress').html('<span class="checkScore">0</span>??? / <span class="condtnScore">0</span>???');
		$('.graphWrap>.graphGroup>.graph>.graph1').css('width', '0');
	}else{
		calStatus=doneContents/allContentsNum*100;
		$('.progress').html('<span class="checkScore">'+doneContents+'</span> / <span class="condtnScore">'+allContentsNum+'</span>');
		$('.graphWrap>.graphGroup>.graph>.graph1').css('width', 'calc((100% / '+allContentsNum+') *'+ doneContents+'');
	}
	
	
	var total=$("input[name=completeTotal]").val();
	calStatus=calStatus.toFixed(1);

	$('.fz34').html(calStatus);
	$('.cMain').html('<span class="calStatus">'+calStatus+'</span>');
	$(".calStatus").html(calStatus);
	$('.learnTotal').html('<strong class="classStatus cDanger">'+doneContents+'</strong>/'+allContentsNum);
	
	if(calStatus>=total){
		$(".cDanger").html("?????? ?????? ??????");
	}
	
	var j = $('.chart .calStatus').text();
    var degRight = 0;
    var degLeft = 180;
    j = parseInt(j);

$('.chart .calStatus').text(calStatus+'%');

$({percent:0}).delay(500).animate({percent : j}, {
    duration : 1500,
    progress : function(){
        var now = parseInt(this.percent),
            deg = now * 360 / 100; //?????????
        degRight = Math.min(180, deg);
        degLeft = Math.max(180, deg);

        $('.chart .calStatus').text(now +'%');

        $('.chart .right li').css({
            transform : 'rotate('+degRight+'deg)'
        });
        $('.chart .left li').css({
            transform : 'rotate('+degLeft+'deg)'
        });
    }
});
	/* $('.fz34').html('0');
	
	$('.exampro').html('<span class="checkScore">0</span>??? / <span class="conditionScore">'+completeQuizScore+'</span>???');
	$('.graphWrap>.graphGroup>.graph>.graph2').css('width', '0');
	
	$('.workpro').html('<span class="checkScore">0</span>??? / <span class="conditionScore">'+completeExamScore+'</span>???');
	$('.graphWrap>.graphGroup>.graph>.graph3').css('width', '0');
	
	$('.totalScore').html('/ '+completeTotal+'???');
	$('.cMain').html('<span class="calStatus">'+calStatus+'</span>');
	$('.learnTotal').html('<strong class="classStatus cDanger">'+doneContents+'</strong>/'+allContentsNum); */
	
	
}
$(function() {
	
	//*********?????? ??? ?????? x????????? ?????????!
	
	$('.modal-popup').click(function() {
		
		var idx = $('.modal-popup').index($(this));
		var title = $(':hidden[name="notice_title"]').eq(idx).val();
		var comment = $(':hidden[name="notice_comment"]').eq(idx).val();
		var regDt = $(':hidden[name="notice_regDt"]').eq(idx).val();

		var str = "";
 		str += title;
// 		str += '<div class="h3"><' + title + '></div><br>';
 		str += "<p>????????? : " + regDt.substring(0,4) + "??? " + regDt.substring(4,6) + "??? " + regDt.substring(6,8) + "???</p>";
 		$('#modal_title').append(str);
		
		str = ""
		str += comment;
		$("#modal_content").append(str);
		
		
		
		
		
		//???????????? ??????
		//var idx = $('.modal-popup').index($(this));
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
            if(i == '1' || i == '2' || i == '3' || i == '4' || i == '5' || i=='6') {
            	myLectureInfo(course,cardinal,id,i);
            }
        }); 
        
       myLectureInfo(course,cardinal,id,'1');
       
		const oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
		const firstDate = new Date();
		const secondDate = new Date(learnEndDate);
		const diffDays = Math.round(Math.abs((firstDate - secondDate) / oneDay));
		
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
	
		
		$('.countDay').html(diffDays+"???");
		var calStatus=0;
		if(allContentsNum==0){
			calStatus=0;
			$('.progress').html('<span class="checkScore">0</span>??? / <span class="condtnScore">0</span>???');
			$('.graphWrap>.graphGroup>.graph>.graph1').css('width', '0');
		}else{
			calStatus=doneContents/allContentsNum*100;
			$('.progress').html('<span class="checkScore">'+doneContents+'</span>??? / <span class="condtnScore">'+allContentsNum+'</span>???');
			$('.graphWrap>.graphGroup>.graph>.graph1').css('width', 'calc((100% / '+allContentsNum+') *'+ doneContents+'');
		}
		
		$('.exampro').html('<span class="checkScore">0</span>??? / <span class="conditionScore">'+completeQuizScore+'</span>???');
		$('.graphWrap>.graphGroup>.graph>.graph2').css('width', '0');
		
		$('.workpro').html('<span class="checkScore">0</span>??? / <span class="conditionScore">'+completeExamScore+'</span>???');
		$('.graphWrap>.graphGroup>.graph>.graph3').css('width', '0');
		
		$('.totalScore').html('/ '+completeTotal+'???');
	});
	
	

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
		<p>
			<a class="goToMain" href="#main">????????? ????????????</a>
		</p>
	</div>

	<!-- header-include -->
	<%@include file="header.jsp"%>


	<div class="container sub07" id="main">
		<!-- sub07 ???????????????-include -->
		<%@include file="../smtp_lecture/menu/leftmenu07.jsp"%>
		<div class="sub-content sub07 sub07-01">
			<!-- ?????? ????????? ?????? ?????? -->
			<!-- <div class="page-locationWrap">
				<ul class="page-location">
					
                    home ?????? / category menu ????????? / division menu ????????? / section menu ?????????
                   
					<li class="img-icon  home"><a href="/"></a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="category-menu"><a href="/smtp/user/sub07-01-01">???????????????</a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="division-menu"><a href="/smtp/user/sub07-01-01">????????????</a></li>
					<li class="img-icon  chevron-right"></li>
					<li class="section-menu"><a href="/smtp/user/sub07-01-01">?????????</a></li>
				</ul>
				<div class="img-icon  chevron-right"></div>
				<div class="sub-content sub00-01"></div>
			</div> -->
			<div class="header">
				<div class="titleBar h3">????????????</div>
				<!-- <h3 class="h3"></h3> -->
			</div>
			<div class="section">
                <div class="articleWrapper" id="assignment">
<!--                     <div class="articleHdr pointBg d-flex"> -->
<!--                         <a href="#" class="d-flex"> -->
<!--                             <div class="img-icon file-alt_wh"></div> -->
<!--                             <div class="HdrTitle">????????????</div> -->
<!--                         </a> -->
<!--                     </div> -->
                    <div class="articleWrap">
						<table class="tab_table table">
                            <thead>
                                <tr>
                                    <th class="tt_w5">#</th>
                                    <th class="tt_w75">??????</th>
                                    <th class="tt_w20">?????????</th>
                                </tr>
                            </thead>
                            <tbody class="noneBtn" id="noticeBody">
                                <c:forEach var="item" items="${list }" varStatus="status">
	                                	
   				                		
                                	<tr>
    				                	<td class="tt_w5">${status.count }</td>
    				                	<td class="tt_w75">
    				                		<input type="hidden" name="notice_title" value="${item.title }">
    				                		<input type="hidden" name="notice_regDt" value="${item.reg_date }">
			   				              	<input type="hidden" name="notice_comment" value="${item.comment }">
    				                		<a class="modal-popup">${item.title }</a>
    				                	</td>
    				                	<td class="tt_w20">
    				                		<c:set var="date" value="${item.reg_date }"/> 
    				                		${fn:substring(date,0,4) }??? ${fn:substring(date,4,6) }??? ${fn:substring(date,6,8) }???
    				                	</td>
                   					</tr>
                                </c:forEach>
                                
                                
                                <!-- <tr>
                                    <td class="tt_w5">1</td>
                                    <td class="tt_w25">20-07-30</td>
                                    <td class="tt_w55">??????????????? ????????? ???????????????.</td>
                                    <td class="tt_w25">????????????</td>
                                </tr>
                                ????????? ?????? tr??? class="cGray" ??????
                                <tr class="cGray">
                                    <td class="tt_w5">4</td>
                                    <td class="tt_w25">20-07-29</td>
                                    <td class="tt_w55">?????? ????????? ????????? ?????? ????????? ????????????, ??????????????? ????????? ???????????????.</td>
                                    <td class="tt_w25">??????</td>
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
			<!-- 19.11.21 myClass?????? ???????????? ?????????????????????. -->
			<!-- modal ???????????? 1?????? include -->
			<%@include file="../smtp_lecture/modal/modal_notice.jsp"%>
		</div>
	</div>
	<!-- footer-include -->
	<%@include file="../smtp_lecture/footer.jsp"%>
	
</body>

</html>
