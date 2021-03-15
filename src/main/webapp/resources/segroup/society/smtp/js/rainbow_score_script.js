var course;
var cardinal;
$(function(){
	course = $(':hidden[name=course_id]').val();
	cardinal = $(':hidden[name=cardinal_id]').val();
	var id = $(':hidden[name=user_id]').val();
	userScore(course, cardinal, id);
})
function tableCal() {
    $('tr.score_cal').each(function() {
        // 과목별 점수 및 배점비율 가져오기
        var score1 = $(this).find('.score1').text();
        var score2 = $(this).find('.score2').text();
        // 계산된 환산점수 적용하기
        calExc = parseFloat(score1) * score2 / 100;
        $(this).find('.score3').text(calExc.toFixed(2));
    });

    // 과목별 환산점수 합계 구하기
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
        //console.log(sumList);
        
        for(var i = 0; i < $(this).parents('tbody').find('tr.score_cal').length; i++) {
        	if(!sumList[i]) {
        		continue;
        	}
        	
        	sum += parseFloat(sumList[i]);
        	
        }
        
        //console.log(sum);
        $(this).html(sum.toFixed(2));
    });
    // 점수별 등급 적용하기
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
	var gisu_id = cardinal;
	var crc_id = course;
	allData = {
		"gisu_id": gisu_id,
		"crc_id": crc_id
	};
	$.ajax({
		url:'/smtp/user/searchGrade',
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
						//console.log(score+" "+result[i].GRADE);
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
		url:"/smtp/user/userScore",
		type:	"post",
		data    : {
			"crc_id" : course
			,"gisu_id" : cardinal
			, "user_id" : id
		},
		success : function(result) {
				
			  var barOptions_stacked = {
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
				var std = result[result.length-3];
				var avg = result[result.length-4];
				
				var newList = {};
				
				var sbB = new Array();
				var sbM = new Array();
				var sbS = new Array();
				
				for (var key in list) {
					if (key=='USER_ID' || key == 'TOTAL' || key =='USER_NM') continue;
					var str = key.split('▨');
					if (key.indexOf('대분류▨') != -1) {
						sbB.push(str[1]);
					} else if(key.indexOf('중분류▨') != -1){
						sbM.push(str[1]);
					} else if(key.indexOf('소분류▨') != -1) {
						sbS.push(str[1]);
					}
				}
				
				for (var key in list) {
					var str = key.split('▨');
					if (key=='USER_ID' || key =='USER_NM') continue;
					if(key=='TOTAL') {
						newList[key] = list[key];
					}
					else if (key.indexOf('대분류▨') != -1) {
						newList[str[1]] = list[key];
					} else if(key.indexOf('중분류▨') != -1){
						newList[str[1]] = list[key];
					} else if(key.indexOf('소분류▨') != -1) {
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
					content += '<div class="articleSubHdr">성적상세</div>';
					content+='<table class="tab_table table">';
		    		content+='<thead><tr><th class="tt_w10">중분류</th><th class="tt_w10">소분류</th><th class="tt_w20">시험명</th><th class="tt_w5">점수</th><th class="tt_w5">평균</th><th class="tt_w5">표준편차</th><th class="tt_w5">순위</th><th class="tt_w40">메모</th></tr></thead>';
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
									    content+='<td class="tt_w5">'+avg[test["TEST_NM"]]+'</td>';
									    content+='<td class="tt_w5">'+std[test["TEST_NM"]]+'</td>';
									    content+='<td class="tt_w5">'+rank[test["TEST_NM"]]+'/'+rank["All"]+'</td>';
									    content+='<td class="tt_w40">'+test["CONTENT"]+'</td>';
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
			    
				var add1 = '<table class="tab_table table"><thead><tr><th class="tt_w20">과목</th><th class="tt_w20">점수</th><th class="tt_w20">배점비율</th><th class="tt_w20">환산점수</th><th class="tt_w10">순위</th><th class="tt_w20">등급</th></tr></thead><tbody>';
			    var background = ["rgba(86,217,254,.7)", "rgba(95,227,161,.7)", "rgba(255,218,131,.7)", "rgba(163,160,251,.7)"];
			    
			    for(var i = 0; i < sbB.length; i++) {
			    	
			    	add1 += '<tr class="score_cal">';
	                add1 += '<td class="tt_w20" style="background-color:'+background[i]+';">'+sbB[i]+'</td>';
	                add1 += '<td class="tt_w20 score1">'+newList[sbB[i]]+'</td>';
	                    
	                for(var d = 0; d < result.length-2; d++) {
	                  	var list = result[d];
	                  	
	                    if(!list["big_cat_nm"] && list["CAT_NM"] == sbB[i]) {
	                    	// console.log(list["CAT_NM"]);
	                    	add1 += '<td class="tt_w20"><span class="score2">'+list["CAT_PERCENT"]+'</span>%</td>';	
	                    }
	                }
	                    
	                add1 += '<td class="tt_w20 score3"></td>';
	                add1 += '<td class="tt_w10">'+rank[sbB[i]]+'/'+rank["All"]+'</td>';
	                add1 += '<td class="tt_w20 score4">'+gradeSelect(newList[sbB[i]])+'</td></tr>';	
			    }
			    
			    add1 += '<tr class="score_cal">';
                add1 += '<td class="tt_w20" style="background-color:'+background[background.length-1]+';">종합</td>';
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
			    
			    sbB.push("종합");
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
				content += '<li class="class-list board-list d-flex"><div class="c-table-03 not"><p>성적 정보가 없습니다.</p></div></li>';
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
	
	window.open("/smtp/user/printScore?crc_id="+course+"&gisu_id="+cardinal, "성적표 출력", "width=800px, height=900px,scrollbars=yes");
	
}