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
<link rel="stylesheet" href="/resources/css/reset.css">
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<link rel="stylesheet" href="/resources/css/user_02_myPage_style.css">
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
<link rel="stylesheet" href="<c:url value="/resources/js/user_02_myPage_script.js" />">

<%-- <script src="<c:url value="/resources/js/jquery-3.3.1.js" />"></script> --%>
<style type="text/css">
.c-table-03.not {
	line-height : 45px;
	margin : 0 auto;
}

.c-table-03.not p{
	text-align : center;
}
</style>

<script>
$(function(){
	var course = '${course_id}';
	var cardinal = '${cardinal_id}';
	var id = '${id}';
	
	userScore(course, cardinal, id);
})
function tableCal() {
    $('tr.score_cal').each(function() {
        // ????????? ?????? ??? ???????????? ????????????
        var score1 = $(this).find('.score1').text();
        var score2 = $(this).find('.score2').text();
        // ????????? ???????????? ????????????
        calExc = parseFloat(score1) * score2 / 100;
        $(this).find('.score3').text(calExc);
    });

    // ????????? ???????????? ?????? ?????????
    $('.sum').each(function(){
        var v1=0,v2=0,v3=0;

        var sumList = {};
        var sum = 0;
        
        
        for(var i = 0; i < $(this).parents('tbody').find('tr.score_cal').length; i++) {
        	var v = $(this).parents('tbody').find('tr.score_cal').eq(i).find('.score3').html();
        	
        	if(!v) {
        		continue;
        	}
        	
        	sumList[i] = v;
        }
        
        for(var i = 0; i < $(this).parents('tbody').find('tr.score_cal').length; i++) {
        	if(!sumList[i]) {
        		continue;
        	}
        	
        	sum += parseFloat(sumList[i]);
        	
        }
        
        $(this).html(sum.toFixed(2));
    });
    // ????????? ?????? ????????????
    $('.score4').each(function() {
    	var sum = $(this).parent().find('.sum').html();
    	
    	if(!sum) {
    		return true;
    	}
    	
    	$(this).html(gradeSelect(sum));
    });
}

function gradeSelect(score){
	var grade = "";
	var gisu_id = '${cardinal_id}';
	var crc_id = '${course_id}';
	allData = {
		"gisu_id": gisu_id,
		"crc_id": crc_id
	};
	$.ajax({
		url:"<c:url value='/smtp/user/searchGrade'/>",
		type:		"POST",
		data: allData,
		async: false,
		success:function(result){
			if(result == 'undefined' || result == 'null' || result === undefined || result == null || result =='') {
				if (score == 100) {
					grade = "(Diamond)";
				} else if (score>=90) {
					grade = "(Gold)";
				} else if (score>=80) {
					grade = "(Silver)";
				} else {
					grade = "(Bronze)";
				}
			} else {
				for(var i = 0; i < result.length; i++) {
					if(parseFloat(result[i].START_SCORE) > score && parseFloat(result[i].END_SCORE) <= score) {
						grade = result[i].GRADE;
						break;
					}
				}
			}
		}
	});
	
	return grade;
}
function userScore(course, cardinal, id) {
	$.ajax({
		url:"<c:url value='/smtp/user/userScore'/>",
		type:	"post",
		data    : {
			"crc_id" : course
			,"gisu_id" : cardinal
			, "user_id" : id
		},
		success : function(result) {
				
			  var barOptions_stacked = {
                      // responsive: false,
                      // title: {
                      //     display: false,
                      //     position: "top",
                      //     text: "????????????",
                      // },
                      tooltips: {
                          enabled: true
                      },
                      hover: {
                          animationDuration: 400
                      },
                      scales: {
                          xAxes: [{
                              ticks: {
                                  beginAtZero: true,
                              },
                              // scaleLabel: {
                              //     display: false,
                              //     labelString: "Hours Worked",
                              // },
                              gridLines: {},
                              stacked: true
                          }],
                          yAxes: [{

                              gridLines: {
                                  display: false,
                                  color: "#fff",
                                  zeroLineColor: "#fff",
                                  zeroLineWidth: 0
                              },
                              stacked: true
                          }]
                      },
                      legend: {
                          display: false,
                      }
                  };
            var ctx = $("#myChart");
               
            var content ='';
			
			if(result !='') {
				
				var list = result[result.length-1];
				var rank = result[result.length-2];
				
				
				var newList = {};
				
				var sbB = new Array();
				var sbM = new Array();
				var sbS = new Array();
				
				for (var key in list) {
					if (key=='USER_ID' || key == 'TOTAL' || key =='USER_NM') continue;
					var str = key.split('???');
					if (key.indexOf('????????????') != -1) {
						sbB.push(str[1]);
					} else if(key.indexOf('????????????') != -1){
						sbM.push(str[1]);
					} else if(key.indexOf('????????????') != -1) {
						sbS.push(str[1]);
					}
				}
				
				for (var key in list) {
					var str = key.split('???');
					if (key=='USER_ID' || key =='USER_NM') continue;
					if(key=='TOTAL') {
						newList[key] = list[key];
					}
					else if (key.indexOf('????????????') != -1) {
						newList[str[1]] = list[key];
					} else if(key.indexOf('????????????') != -1){
						newList[str[1]] = list[key];
					} else if(key.indexOf('????????????') != -1) {
						 newList[str[1]] = list[key].split('/')[0];
					} else {
						newList[key] = list[key];
					}
				}
				
				
				content += '<ul class="tabGroup d-flex">';
			    
				for(var i = 0; i < sbB.length; i++) {
			    	if(i == 0) {
			    		content+='<li class="active">'+sbB[i]+'</li>';
			    	} else {
			    		content+='<li>'+sbB[i]+'</li>';
			    	}
			    }
			    
			    content+='</ul>';
			    content+='<div class="subGroup">';
			    var idx = 0;
			    for(var a = 0; a < sbB.length; a++) {
			    	if(a == 0) {
						content+='<div class="tab-sub sub1-'+(a+1)+'">';
					} else {
						content+='<div class="tab-sub sub1-'+(a+1)+' hideTab">';
					}
					content += '<div class="articleSubHdr">????????????</div>';
					content+='<table class="tab_table table">';
		    		content+='<thead><tr><th class="tt_w10">?????????</th><th class="tt_w10">?????????</th><th class="tt_w20">?????????</th><th class="tt_w5">??????</th><th class="tt_w5">??????</th><th class="tt_w55">??????</th></tr></thead>';
		    		/**/
		    		content+='<tbody>';
						
			    	for(var b = 0; b < result.length-2; b++) {
					    var testList = result[b];
					    	
					    	
					    for(var j = 0; j < sbM.length; j++) {
					    	if(testList["big_cat_nm"] == sbB[a] && testList["mid_cat_nm"] == sbM[j]) {
							   	
							   	for(var v = 0; v < result.length-2; v++) {
									var test = result[v];
									if(test["SMALL_CAT_NM"] == null || test["SMALL_CAT_NM"] == 'null' || test["SMALL_CAT_NM"] == undefined || test["SMALL_CAT_NM"] == 'undefined') {
										continue;
									} else if(test["SMALL_CAT_NM"] == testList["CAT_NM"]){
										content+='<tr><td class="tt_w10">'+sbM[j]+'</td>';
									   	content+='<td class="tt_w10">'+testList["CAT_NM"]+'</td>';
										content+='<td class="tt_w20">'+test["TEST_NM"]+'</td>';
									    content+='<td class="tt_w5">'+newList[test["TEST_NM"]]+'</td>';
									    content+='<td class="tt_w5">'+rank[test["TEST_NM"]]+'/'+rank["All"]+'</td>';
									    content+='<td class="tt_w55">'+test["CONTENT"]+'</td>';
									    content+="</tr>";
									}
								}
						    }
					    }
					}

			    	content+='</tbody></table>';
				    content+='</div>';
			    }
			    $(".add2").html(content);
			    
				var add1 = '<table class="tab_table table"><thead><tr><th class="tt_w20">??????</th><th class="tt_w20">??????</th><th class="tt_w20">????????????</th><th class="tt_w20">????????????</th><th class="tt_w10">??????</th><th class="tt_w20">??????</th></tr></thead><tbody>';
			    
			    var background = ["rgba(86,217,254,.7)", "rgba(95,227,161,.7)", "rgba(255,218,131,.7)", "rgba(163,160,251,.7)"];
			    
			    for(var i = 0; i < sbB.length; i++) {
			    	
			    	add1 += '<tr class="score_cal">';
	                add1 += '<td class="tt_w20" style="background-color:'+background[i]+';">'+sbB[i]+'</td>';
	                add1 += '<td class="tt_w20 score1">'+newList[sbB[i]]+'</td>';
	                    
	                for(var d = 0; d < result.length-2; d++) {
	                  	var list = result[d];
	                  	
	                    if(!list["big_cat_nm"] && list["CAT_NM"] == sbB[i]) {
	                    	add1 += '<td class="tt_w20"><span class="score2">'+list["CAT_PERCENT"]+'</span>%</td>';	
	                    }
	                }
	                    
	                add1 += '<td class="tt_w20 score3"></td>';
	                add1 += '<td class="tt_w10">'+rank[sbB[i]]+'/'+rank["All"]+'</td>';
	                add1 += '<td class="tt_w20 score4">'+gradeSelect(newList[sbB[i]])+'</td></tr>';	
			    }
			    
			    add1 += '<tr class="score_cal">';
                add1 += '<td class="tt_w20" style="background-color:'+background[background.length-1]+';">??????</td>';
                add1 += '<td class="tt_w20 score1">-</td>';
                add1 += '<td class="tt_w20">-</td>';
                add1 += '<td class="tt_w20 sum"></td>';
                add1 += '<td class="tt_w10">'+rank["TOTAL"]+'/'+rank["All"]+'</td>';
                add1 += '<td class="tt_w20 score4"></td></tr>';
	    		
			    add1 += '</tbody></table></div>';
			    
			    var totals = [];
			    var needcolor = [];
			    
			    for(var i = 0; i < sbB.length; i++) {
			    	totals.push(newList[sbB[i]]);	
			    }
			    
			    sbB.push("??????");
			    totals.push(newList["TOTAL"]);
			    var colors = ["#56d9fe", "#5fe3a1", '#FFDA83', "#a3a0fb"];
			    
			    for(var i = 0; i < sbB.length; i++) {
			    	if(i == sbB.length-1) {
			    		needcolor.push(colors[colors.length-1]);
			    	}
			    	needcolor.push(colors[i]);
			    }
			    
			    
			    var myChart = new Chart(ctx, {
	                  responsive: true,
	                  type: "horizontalBar",
	                  data: {
	                      labels: sbB,
	                      datasets: [{
	                          barPercentage: .1,
	                          barThickness: 30,
	                          maxBarThickness: 30,
	                          minBarLength: sbB.length,
	                          data: totals,
	                          backgroundColor: needcolor
	                      }]
	                  },

	                  options: barOptions_stacked,
	              });
			    
			    
			    $(".add1").html(add1);
			   	
				tableCal();
				
			    var i = 0;
			    $('.tabTableWrap>.tabGroup>li').click(function() {
			        var $tab = $(this).parent().children();
			        var $sub = $(this).parent().next('.subGroup').children();
			        i = $(this).index();
			        $tab.removeClass('active');
			        $(this).addClass('active');
			        $sub.hide();
			        $sub.eq(i).show();
			    });
			} else {
				content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>?????? ????????? ????????????.</p></div></li>';
				$('.article').html(content);
				$('.add2').remove();
				$('.printScore').remove();
			}
			

		},error:function(error){
			alert(error.statusText);
		}
		
	});
}

function printScore() {
	var course = '${course_id}';
	var cardinal = '${cardinal_id}';
	
	window.open("/smtp/user/printScore?crc_id="+course+"&gisu_id="+cardinal, "????????? ??????", "width=800px, height=900px,scrollbars=yes");
	
}

</script>
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
				<div class="titleBar h3">??????</div>
				<!-- <h3 class="h3"></h3> -->
			</div>
			<div class="section sub07-01 sub07-01-01">
				<div class="articleWrapper" id="score">
<!--                     <div class="articleHdr pointBg d-flex"> -->
<!--                         <a href="#" class="d-flex"> -->
<!--                             <div class="img-icon signal-alt-3_wh"></div> -->
<!--                             <div class="HdrTitle">????????????</div> -->
<!--                         </a> -->
<!--                     </div> -->
                    <div class="articleWrap">
                        <div class="article">
                            <div class="articleSubHdr">????????????</div>
                            <div class="layout_half d-flex justify_between">
                                <div class="graphWrap article">
                                    <canvas class="graph" id="myChart" style="-moz-user-select: none; -webkit-user-select: none; -ms-user-select: none;"></canvas>
                                </div>
                                <div class="tabTableWrap article add1">
                                  <!--   <table class="tab_table table">
                                        <thead>
                                            <tr>
                                                <th class="tt_w20">??????</th>
                                                <th class="tt_w20">??????</th>
                                                <th class="tt_w20">????????????</th>
                                                <th class="tt_w20">????????????</th>
                                                <th class="tt_w20">??????</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="score_cal">
                                                <td class="tt_w20" style="background-color:rgba(86,217,254,.7);">ICT</td>
                                                <td class="tt_w20 score1">82.5</td>
                                                <td class="tt_w20">
                                                    <span class="score2">30</span>%
                                                </td>
                                                <td class="tt_w20 score3"></td>
                                                <td class="tt_w20 score4"></td>
                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w20" style="background-color:rgba(95,227,161,.7);">?????????</td>
                                                <td class="tt_w20 score1">90</td>
                                                <td class="tt_w20">
                                                    <span class="score2">30</span>%
                                                </td>
                                                <td class="tt_w20 score3"></td>
                                                <td class="tt_w20 score4"></td>
                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w20" style="background-color:rgba(255,218,131,.7);">Basics</td>
                                                <td class="tt_w20 score1">100</td>
                                                <td class="tt_w20">
                                                    <span class="score2">40</span>%
                                                </td>
                                                <td class="tt_w20 score3"></td>
                                                <td class="tt_w20 score4"></td>
                                            </tr>
                                            <tr class="score_total">
                                                <td class="tt_w20" style="background-color:rgba(163,160,251,.7);">??????</td>
                                                <td class="tt_w20">-</td>
                                                <td class="tt_w20">-</td>
                                                <td class="tt_w20 sum"></td>
                                                <td class="tt_w20 score4"></td>
                                            </tr>
                                        </tbody>
                                    </table> -->
                                </div>
                            </div>
                        </div>                        
                        <div class="tabTableWrap article add2">
<!--                             <ul class="tabGroup d-flex">
                                <li class="active">ICT</li>
                                <li>?????????</li>
                                <li>Basic</li>
                            </ul>
                            <div class="subGroup">
                                <div class="tab-sub sub1-1">
                                    <div class="articleSubHdr">????????????</div>
                                    <table class="tab_table table">
                                        <thead>
                                            <tr>
                                                <th class="tt_w10">?????????</th>
                                                <th class="tt_w20">?????????</th>
                                                <th class="tt_w5">??????</th>
                                                <th class="tt_w55">??????</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">90</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????.</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">100</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????. ????????? ?????? ???????????? ?????? ?????? ????????? ????????? ?????? ????????? ?????????. ?????? ?????? ????????? ????????? ???????????? ?????????, ????????? ???????????????????</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">70</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????. ????????? ?????? ???????????? ?????? ?????? ????????? ????????? ?????? ????????? ?????????.</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">1??? ????????????</td>
                                                <td class="tt_w5">80</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="articleSubHdr">ICT ?????? ??????</div>
                                    <table class="tab_table table">
                                        <thead>
                                            <tr>
                                                <th class="tt_w15">?????????</th>
                                                <th class="tt_w15">??????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">??????</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">88.3</td>
                                                <td class="tt_w15"><span class="score2">30</span>%</td>
                                                <td class="tt_w15 score3"></td>
                                                <td rowspan="3" class="tt_w15 sum"></td>
                                                <td rowspan="3" class="tt_w15 score4"></td>
                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">80</td>
                                                <td class="tt_w15"><span class="score2">40</span>%</td>
                                                <td class="tt_w15 score3"></td>

                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">80</td>
                                                <td class="tt_w15"><span class="score2">30</span>%</td>
                                                <td class="tt_w15 score3"></td>

                                            </tr>
                                    </table>
                                </div>
                                <div class="tab-sub sub1-2 hideTab">
                                    <div class="articleSubHdr">????????????</div>
                                    <table class="tab_table table">
                                        <thead>
                                            <tr>
                                                <th class="tt_w10">?????????</th>
                                                <th class="tt_w20">?????????</th>
                                                <th class="tt_w5">??????</th>
                                                <th class="tt_w55">??????</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">100</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????.</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">90</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????. ????????? ?????? ???????????? ?????? ?????? ????????? ????????? ?????? ????????? ?????????. ?????? ?????? ????????? ????????? ???????????? ?????????, ????????? ???????????????????</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">2??? ????????????</td>
                                                <td class="tt_w5">80</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????. ????????? ?????? ???????????? ?????? ?????? ????????? ????????? ?????? ????????? ?????????.</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">???????????? ??????</td>
                                                <td class="tt_w5">80</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="articleSubHdr">????????? ?????? ??????</div>
                                    <table class="tab_table table">
                                        <thead>
                                            <tr>
                                                <th class="tt_w15">?????????</th>
                                                <th class="tt_w15">??????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">??????</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">88.3</td>
                                                <td class="tt_w15"><span class="score2">30</span>%</td>
                                                <td class="tt_w15 score3"></td>
                                                <td rowspan="3" class="tt_w15 sum"></td>
                                                <td rowspan="3" class="tt_w15 score4"></td>
                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">80</td>
                                                <td class="tt_w15"><span class="score2">40</span>%</td>
                                                <td class="tt_w15 score3"></td>

                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">80</td>
                                                <td class="tt_w15"><span class="score2">30</span>%</td>
                                                <td class="tt_w15 score3"></td>

                                            </tr>
                                    </table>
                                </div>
                                <div class="tab-sub sub1-3 hideTab">
                                    <div class="articleSubHdr">????????????</div>
                                    <table class="tab_table table">
                                        <thead>
                                            <tr>
                                                <th class="tt_w10">?????????</th>
                                                <th class="tt_w20">?????????</th>
                                                <th class="tt_w5">??????</th>
                                                <th class="tt_w55">??????</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">70</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????.</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">80</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????. ????????? ?????? ???????????? ?????? ?????? ????????? ????????? ?????? ????????? ?????????. ?????? ?????? ????????? ????????? ???????????? ?????????, ????????? ???????????????????</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">1??? ????????????</td>
                                                <td class="tt_w5">100</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????.</td>
                                            </tr>
                                            <tr>
                                                <td class="tt_w10">????????????</td>
                                                <td class="tt_w20">????????????</td>
                                                <td class="tt_w5">80</td>
                                                <td class="tt_w55">????????? ?????????, ????????? ????????????. ??????, ????????? ????????? ?????????. ????????? ?????? ???????????? ?????? ?????? ????????? ????????? ?????? ????????? ?????????.</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="articleSubHdr">Basics ?????? ??????</div>
                                    <table class="tab_table table">
                                        <thead>
                                            <tr>
                                                <th class="tt_w15">?????????</th>
                                                <th class="tt_w15">??????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">????????????</th>
                                                <th class="tt_w15">??????</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">88.3</td>
                                                <td class="tt_w15"><span class="score2">30</span>%</td>
                                                <td class="tt_w15 score3"></td>
                                                <td rowspan="3" class="tt_w15 sum"></td>
                                                <td rowspan="3" class="tt_w15 score4"></td>
                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">80</td>
                                                <td class="tt_w15"><span class="score2">40</span>%</td>
                                                <td class="tt_w15 score3"></td>

                                            </tr>
                                            <tr class="score_cal">
                                                <td class="tt_w15">????????????</td>
                                                <td class="tt_w15 score1">80</td>
                                                <td class="tt_w15"><span class="score2">30</span>%</td>
                                                <td class="tt_w15 score3"></td>

                                            </tr>
                                    </table>
                                </div>
                            </div> -->
                        </div>
                        <input type="button" class="printScore" value="????????? ??????" onclick="printScore()">
                    </div>
                </div>
			</div>
		</div>
	</div>

	<!-- footer-include -->
	<%@include file="footer.jsp"%>
</body>

</html>
