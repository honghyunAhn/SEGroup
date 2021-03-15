<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta property="og:type" content="website">
    <meta property="og:title" content="Soft Engineer Society">
    <meta property="og:image" content="http://www.softsociety.net/edu/apply/ckeditor/ses_main_image.png">
	<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="https://kit.fontawesome.com/f4ead7948d.js"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>	
	<script src="<c:url value="/resources/segroup/society/fap/js/swiper.js" />" charset="utf-8"></script>
    <script src="<c:url value="/resources/segroup/society/fap/js/index.js" />"  charset="utf-8"></script>
	<script src="<c:url value="/resources/segroup/js/chartBundle-2.7.3.js" />"></script><!-- 차트를 위한 JS -->
	<script type="text/javascript" src="<c:url value="/resources/segroup/society/fap/js/jquery.banner.js" />" charset="utf-8"></script>	 
	<script type="text/javascript" src="<c:url value="/resources/segroup/society/fap/js/lightslider.js" />"></script>	
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/main.header.css" />">
	<!-- <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/reset.css" />"> -->
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/all.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/swiper.min.css" />">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/fa_style.css" />">
	<!-- <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/index.css" />"> -->
	<!-- <link rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/common.css" />"> -->
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/demo.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/lightslider.css" />" />
	
	<script type="text/javascript">	
		$(function(){			
					
			 //채용하러 가기 - 잡페어 신청 게시판으로 이동
			  var registerNow = $("#hireNow");
			  registerNow.on('click',function(){
			  location.href="/fap/company/company_jobfair_apply_to_attend_form";
			  })				 

			  //공지사항 게시판으로 이동
			  var userNotice = $("#companyNotice");
			  userNotice.on('click',function(){
				  location.href= "/fap/company/company_board_content_list?board=notice";
			  })
		
			  //FAQ로 이동
			  var faqLink = $("#faqLink");
			  faqLink.on('click',function(){
				  location.href= "/fap/company/company_faq";
			  })	
			  
			  //SES회원서비스(작업중)
			  var sesUserService = $("#sesUserService");
			  sesUserService.on('click',function(){
				 alert('<spring:message code="fap.main.under_construction"/>');
				 //  location.href= "/fap/company/company_ses_user_service";
			  })	
			  
			  //2020 Fair 일정(작업중)
			  var FairSchedule = $("#2020FairSchedule");
			    FairSchedule.on('click',function(){
				  alert('<spring:message code="fap.main.under_construction"/>');
				  // location.href= "/fap/company/company_2020_fair_schedule";
			  })	
			  
			  //전형절차(작업중)
			  var step = $("#step");
			  step.on('click',function(){
				   alert('<spring:message code="fap.main.under_construction"/>');
				   // location.href= "/fap/company/company_step";	
			  })	
			  
			  //취업정보&전략 게시판으로 이동
			  var openJobInfo =$("#openJobInfo");
			  openJobInfo.on('click',function(){
				  location.href = "/fap/company/company_board_content_list?board=jobinfo";
			  })

			  //채용기업&파트너사(작업중)
			  var companies = $("#companies");
			  companies.on('click',function(){				
				    location.href= "/fap/company/company_comps_and_partners";	
			  })	
			  
			  //취업연계과정(작업중)
			  var empConnection  = $("#empConnection");
			  empConnection.on('click',function(){				
				  alert('<spring:message code="fap.main.under_construction"/>');
			  })	
			  
  			var popupCount = 0;
			  
			//팝업
			$.ajax({
				url : '/fap/company/company_popup_check'
				, type : 'get'
				, success : function(response) {   
					$.each(response,function(index,item){
						var left = (popupCount%2)*615;
						var top = Math.floor(popupCount/2) * 505;
						if(item.fap_popup_gb == 'D1500'){
							if(getCookie(item.fap_popup_link)!="Y"){
								if(popupCount != 0 && popupCount%2 == 1){
									window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
									popupCount++;
								}else if(popupCount != 0 && popupCount%2 == 0){
									window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
									popupCount++;
								}else{
									window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no");
									popupCount++;
								}
							}
						}else{
							if(getCookie(item.fap_popup_link)!="Y"){
								if(popupCount != 0 && popupCount%2 == 1){
									window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
									popupCount++;
								}else if(popupCount != 0 && popupCount%2 == 0){
									window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no,left="+left+",top="+top);
									popupCount++;
								}else{
									window.open(item.fap_popup_link+"?fap_popup_seq="+item.fap_popup_seq,"popup"+index,"width=615,height=445,location=no,status=no,toolbar=no,scrollbars=no");
									popupCount++;
								}
							}
						}
					});
				}
				, error : function (e) {
					console.log(e);
				}				
			});
			  
		})	
		
		//쿠키 가져오기
		function getCookie(name){
			var cName = name + "=";
			var x = 0;
			var i = 0;
			while ( i <= document.cookie.length){
				var y = (x+cName.length);
				if(document.cookie.substring(x,y) == cName){
					if((endOfCookie=document.cookie.indexOf(";",y)) == -1){
						endOfCookie=document.cookie.length;
					}
					return unescape(document.cookie.substring(y,endOfCookie));
				}
				x = document.cookie.indexOf(" ",x) + 1;
				if( x == 0){
					break;
				}
			}
			return "";
		}
		
		var myApp = angular.module('myapp', []);		
		
		//공통코드
		myApp.directive('selectcode', [ '$http', function($http) {
			return {
				restrict : "A",
				replace : true,
				scope : {
					value : '@'
				},
				controller : function($scope, $element, $attrs) {
					$http({
						method : 'POST',
						url : '/codeconverter',
						responseType : 'text',
						params : {
							code : $attrs.value
						}
					}).then(function successCallback(response) {
						$scope.filterParams = response.data;
					}, function errorCallback(response) {
						//console.log(response);
					});
				},
				template : "<option>{{filterParams}}</option>"
			}
		}]);
		
		//공통코드 
		myApp.directive('code', [ '$http', function($http) {
			return {
				restrict : "E",
				replace : true,
				scope : {
					value : '@'
				},
				controller : function($scope, $element, $attrs) {
					$http({
						method : 'POST',
						url : '/codeconverter',
						responseType : 'text',
						params : {
							code : $attrs.value
						}
					}).then(function successCallback(response) {
						$scope.filterParams = response.data;
					}, function errorCallback(response) {
						//console.log(response);
					});
				},
				template : "<span>{{filterParams}}</span>"
			}
		}]);		
		
		 
		//잡페어 출력
		myApp.controller('MainController', ['$scope','$compile','$http', function($scope,$compile,$http){
			$http({
				method: 'POST',
				url: '/fap/company/jobfair_search_list'
			}).then(function successCallback(response) {
				$scope.jobfair_draw(response);	
				//잡페어 출력 후 그래프 출력해주는 앵귤러
				$scope.jobfair_graph_draw();
			}, function errorCallback(response) {
			});
			//[start] 잡페어 차트 시작
			$scope.jobfair_graph_draw = function(){
				//[start] 성별 차트 시작
				var ctx = document.getElementById('chart_gender_canvas_ses');
				var myChart = new Chart(ctx, {
				    type: 'doughnut',
				    data: {
				        labels: ["男性", "女性"],
				        datasets: [{
				            label: '# of Votes',
				            data: [109,32],
				            //data: [112, 33], // 2019 summer Bridge Job Fair
				            backgroundColor: [
				            	'rgba(54, 162, 235, 0.4)',
				            	'rgba(255, 99, 132, 0.5)',
				            ],
				            //[start] 선색(border)추가 시작
				            borderColor: [
				            	'rgba(54, 162, 235, 0.4)',
				            	'rgba(255, 99, 132, 0.5)',
				            ],
				            borderWidth: 1
				          //[end] 선색(border)추가 종료
				        }]
				    },
				    options: {
				    	 title: {
				             display: true,
				             text: '性別',
				             fontSize: 15
				         },
				         tooltips: {
				        	  callbacks: {
				        	    label: function(tooltipItem, data) {
				        	      //get the concerned dataset
				        	      var dataset = data.datasets[tooltipItem.datasetIndex];
				        	      //calculate the total of this data set
				        	      var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
				        	        return previousValue + currentValue;
				        	      });
				        	      //get the current items value
				        	      var currentValue = dataset.data[tooltipItem.index];
				        	      //calculate the precentage based on the total and current item, also this does a rough rounding to give a whole number
				        	      var percentage = ((currentValue/total) * 100).toFixed(1);

				        	      return percentage + "%";
				        	    }
				          }
				        },
				         //[start] 차트 비율 수동설정 시작
				         responsive: true,
				         maintainAspectRatio: false,
				         //[end] 차트 비율 수동설정 종료
				         //[start] 배경 선 설정 시작
				         /*scales: {
				             yAxes: [{
				                 ticks: {
				                     beginAtZero:true
				                 }
				             }]
				         }*/
				         //[end] 배경 선 설정 종료
				    }
				});
				//[end] 연령별 차트 종료
				
				//[start] 전공별 차트 시작
				var ctx = document.getElementById('chart_major_canvas_ses');
				var myChart = new Chart(ctx, {
				    type: 'doughnut',
				    data: {
				    	labels: ["コンピューター工学","日本語","工学系列","自然系列","人文系列","その他"],
				        datasets: [{
				            label: '# of Votes',
				            data: [25, 19, 21, 11, 52, 13],
				            //data: [27, 18, 21, 8, 62, 9], // 2019 summer Bridge Job Fair
				            backgroundColor: [
				            	'rgba(54, 162, 235, 0.4)',
				                'rgba(255, 0, 0, 0.5)',
				                'rgba(54, 162, 235, 0.1)',
				                'rgba(144, 238, 144, 1)',
				                'rgba(255, 255, 0, 0.5)',
				                'rgba(128, 128, 128, 0.7)'
				            ],
				            borderColor: [
				            	'rgba(54, 162, 235, 0.4)',
				                'rgba(255, 0, 0, 0.5)',
				                'rgba(54, 162, 235, 0.1)',
				                'rgba(144, 238, 144, 1)',
				                'rgba(255, 255, 0, 0.5)',
				                'rgba(128, 128, 128, 0.7)'
				            ],
				            borderWidth: 1
				        }]
				    },
				    options: {
				    	 title: {
				             display: true,
				             text: '専攻別',
				             fontSize: 15
				         },
				         tooltips: {
				        	  callbacks: {
				        	    label: function(tooltipItem, data) {
				        	      //get the concerned dataset
				        	      var dataset = data.datasets[tooltipItem.datasetIndex];
				        	      //calculate the total of this data set
				        	      var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
				        	        return previousValue + currentValue;
				        	      });
				        	      //get the current items value
				        	      var currentValue = dataset.data[tooltipItem.index];
				        	      //calculate the precentage based on the total and current item, also this does a rough rounding to give a whole number
				        	      var percentage = ((currentValue/total) * 100).toFixed(1);

				        	      return percentage + "%";
				        	    }
				          }
				        },
				         responsive: true,
				         maintainAspectRatio: false,
				    }
				});
				//[end] 연령별 차트 종료
								
				//[start] 연령별 차트 시작
				var ctx = document.getElementById('chart_age_canvas_ses');
				var myChart = new Chart(ctx, {
				    type: 'doughnut',
				    data: {
				        labels: ["30歳以上（～1989年生まれ）", "27歳(1992年生まれ) ~ 29歳(1990年生まれ)", "23歳(1996年生まれ) ~ 26歳(1993年生まれ)", "22歳以下(1997年生まれ~）"],
				        datasets: [{
				            label: '# of Votes',
				            data: [32, 40, 68, 1],
				            //data: [71, 41, 33], // 2019 summer Bridge Job Fair
				            backgroundColor: [
				            	'rgba(255, 255, 0, 0.7)',
				                'rgba(173, 216, 239, 1)',
				                'rgba(144, 238, 144, 1)'
				            ],
				            borderColor: [
				            	'rgba(255, 255, 0, 0.7)',
				                'rgba(173, 216, 239, 1)',
				                'rgba(144, 238, 144, 1)'
				            ],
				            borderWidth: 1
				        }]
				    },
				    options: {
				    	 title: {
				             display: true,
				             text: '年齢別',
				             fontSize: 15
				         },
				         tooltips: {
				        	  callbacks: {
				        	    label: function(tooltipItem, data) {
				        	      //get the concerned dataset
				        	      var dataset = data.datasets[tooltipItem.datasetIndex];
				        	      //calculate the total of this data set
				        	      var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
				        	        return previousValue + currentValue;
				        	      });
				        	      //get the current items value
				        	      var currentValue = dataset.data[tooltipItem.index];
				        	      //calculate the precentage based on the total and current item, also this does a rough rounding to give a whole number
				        	      var percentage = ((currentValue/total) * 100).toFixed(1);

				        	      return percentage + "%";
				        	    }
				          }
				        },
				         responsive: true,
				         maintainAspectRatio: false,
				    }
				});
				//[end] 연령별 차트 종료
				
				//[start] 성별 차트 시작
				var ctx = document.getElementById('chart_gender_canvas_etc');
				var myChart = new Chart(ctx, {
				    type: 'doughnut',
				    data: {
				        labels: ["男性", "女性"],
				        datasets: [{
				            label: '# of Votes',
				            data: [118, 56],
				            // data: [34, 23], // 2019 summer Bridge Job Fair
				            backgroundColor: [
				            	'rgba(54, 162, 235, 0.4)',
				            	'rgba(255, 99, 132, 0.5)',
				            ],
				            //[start] 선색(border)추가 시작
				            borderColor: [
				            	'rgba(54, 162, 235, 0.4)',
				            	'rgba(255, 99, 132, 0.5)',
				            ],
				            borderWidth: 1
				          //[end] 선색(border)추가 종료
				        }]
				    },
				    options: {
				    	 title: {
				             display: true,
				             text: '性別',
				             fontSize: 15
				         },
				         tooltips: {
				        	  callbacks: {
				        	    label: function(tooltipItem, data) {
				        	      //get the concerned dataset
				        	      var dataset = data.datasets[tooltipItem.datasetIndex];
				        	      //calculate the total of this data set
				        	      var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
				        	        return previousValue + currentValue;
				        	      });
				        	      //get the current items value
				        	      var currentValue = dataset.data[tooltipItem.index];
				        	      //calculate the precentage based on the total and current item, also this does a rough rounding to give a whole number
				        	      var percentage = ((currentValue/total) * 100).toFixed(1);

				        	      return percentage + "%";
				        	    }
				          }
				        },
				         //[start] 차트 비율 수동설정 시작
				         responsive: true,
				         maintainAspectRatio: false,
				         //[end] 차트 비율 수동설정 종료
				         //[start] 배경 선 설정 시작
				         /*scales: {
				             yAxes: [{
				                 ticks: {
				                     beginAtZero:true
				                 }
				             }]
				         }*/
				         //[end] 배경 선 설정 종료
				    }
				});
				//[end] 연령별 차트 종료
				
				//[start] 전공별 차트 시작
				var ctx = document.getElementById('chart_major_canvas_etc');
				var myChart = new Chart(ctx, {
				    type: 'doughnut',
				    data: {
				    	labels: ["コンピューター工学","日本語","工学系列","自然系列","人文系列","その他"],
				        datasets: [{
				            label: '# of Votes',
				            data: [31, 24, 41, 8, 60, 10],
				            //data: [8, 8, 13, 4, 20, 4], // 2019 summer Bridge Job Fair
				            backgroundColor: [
				            	'rgba(54, 162, 235, 0.4)',
				                'rgba(255, 0, 0, 0.5)',
				                'rgba(54, 162, 235, 0.1)',
				                'rgba(144, 238, 144, 1)',
				                'rgba(255, 255, 0, 0.5)',
				                'rgba(128, 128, 128, 0.7)'
				            ],
				            borderColor: [
				            	'rgba(54, 162, 235, 0.4)',
				                'rgba(255, 0, 0, 0.5)',
				                'rgba(54, 162, 235, 0.1)',
				                'rgba(144, 238, 144, 1)',
				                'rgba(255, 255, 0, 0.5)',
				                'rgba(128, 128, 128, 0.7)'
				            ],
				            borderWidth: 1
				        }]
				    },
				    options: {
				    	 title: {
				             display: true,
				             text: '専攻別',
				             fontSize: 15
				         },
				         tooltips: {
				        	  callbacks: {
				        	    label: function(tooltipItem, data) {
				        	      //get the concerned dataset
				        	      var dataset = data.datasets[tooltipItem.datasetIndex];
				        	      //calculate the total of this data set
				        	      var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
				        	        return previousValue + currentValue;
				        	      });
				        	      //get the current items value
				        	      var currentValue = dataset.data[tooltipItem.index];
				        	      //calculate the precentage based on the total and current item, also this does a rough rounding to give a whole number
				        	      var percentage = ((currentValue/total) * 100).toFixed(1);

				        	      return percentage + "%";
				        	    }
				          }
				        },
				         responsive: true,
				         maintainAspectRatio: false,
				    }
				});
				//[end] 연령별 차트 종료
								
				//[start] 연령별 차트 시작
				var ctx = document.getElementById('chart_age_canvas_etc');
				var myChart = new Chart(ctx, {
				    type: 'doughnut',
				    data: {
				        labels: ["30歳以上（～1989年生まれ）", "27歳(1992年生まれ) ~ 29歳(1990年生まれ)", "23歳(1996年生まれ) ~ 26歳(1993年生まれ)", "22歳以下(1997年生まれ~）"],
				        datasets: [{
				            label: '# of Votes',
				            data: [27, 48, 91, 8],
				            //data: [33, 15, 9], // 2019 summer Bridge Job Fair
				            backgroundColor: [
				            	'rgba(255, 255, 0, 0.7)',
				                'rgba(173, 216, 239, 1)',
				                'rgba(144, 238, 144, 1)'
				            ],
				            borderColor: [
				            	'rgba(255, 255, 0, 0.7)',
				                'rgba(173, 216, 239, 1)',
				                'rgba(144, 238, 144, 1)'
				            ],
				            borderWidth: 1
				        }]
				    },
				    options: {
				    	 title: {
				             display: true,
				             text: '年齢別',
				             fontSize: 15
				         },
				         tooltips: {
				        	  callbacks: {
				        	    label: function(tooltipItem, data) {
				        	      //get the concerned dataset
				        	      var dataset = data.datasets[tooltipItem.datasetIndex];
				        	      //calculate the total of this data set
				        	      var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
				        	        return previousValue + currentValue;
				        	      });
				        	      //get the current items value
				        	      var currentValue = dataset.data[tooltipItem.index];
				        	      //calculate the precentage based on the total and current item, also this does a rough rounding to give a whole number
				        	      var percentage = ((currentValue/total) * 100).toFixed(1);

				        	      return percentage + "%";
				        	    }
				          }
				        },
				         responsive: true,
				         maintainAspectRatio: false,
				    }
				});
				//[end] 연령별 차트 종료
			}
			//[end] 잡페어 차트 종료
			
			//잡페어
			$scope.jobfair_draw = function(response){
				$scope.results = response.data;
				var context = '';
				context += '<li ng-repeat="result in results" class="lslide">';
				context += 	'<ul id="image_list_1">';
				context +=		'<li ng-if="result.fapJobfairList[0].fap_jobfair_log_saved != null"><a href="#"><img alt="img{{$index}}" ng-src="/fap/admin/jobfair_logo_image/{{result.fapJobfairList[0].fap_jobfair_log_saved}}"></a></li>';
				context +=	    '<li class="text1">{{result.fapJobfairList[0].fap_jobfair_title}}</li>';
				context +=	    '<li class="text2"><spring:message code="fap.jobfair.date_hold" /> : {{result.fapJobfairList[0].fap_jobfair_st}}~{{result.fapJobfairList[0].fap_jobfair_et}}</li>';
				context +=	    '<li class="text3" ng-if="result.fapJobfairLoList[1].fap_jobfair_lo != null "><spring:message code="fap.jobfair.place_hold" /> : <code value="C0000" style="display: inline;"></code>, <code value="C0001" style="display: inline;"></code></li>';
				context +=	    '<li class="text3" ng-if="result.fapJobfairLoList[1].fap_jobfair_lo == null && result.fapJobfairLoList[0].fap_jobfair_lo == \'C0000\' "><spring:message code="fap.jobfair.place_hold" /> : <code value="C0000" style="display: inline;"></code></li>';
				context += 		'<spring:message var="attendButton" code="fap.jobfair.attend_jobfair" />';
				context +=	    '<li class="text3" ng-if="result.fapJobfairLoList[1].fap_jobfair_lo == null && result.fapJobfairLoList[0].fap_jobfair_lo == \'C0001\' "><spring:message code="fap.jobfair.place_hold" /> : <code value="C0001" style="display: inline;"></code></li>';
				context +=	    '<li class="text5"><button class="btn btn-primary" value="{{result.fapJobfairList[0].fap_jobfair_seq}}" ng-click="compJobfairParticipation(result.fapJobfairList[0].fap_jobfair_seq)" style="margin-top: 10px;">${attendButton}</button></li>';
				context +=	'</ul>';
				context += '</li>';

				$('#image-gallery').prepend($compile(context)($scope));
				$('#image-gallery').lightSlider({
					item : 1,
					slideMargin : 0,
					speed : 500,
					auto : true,
					loop : true,
					controls: false,
					onSliderLoad : function() { 
						$('#image-gallery').removeClass('cS-hidden');
					}
				});
			}
	
			//잡페어 선택 페이지로 이동
			$scope.compJobfairParticipation = function(){
				location.href = "/fap/company/company_jobfair_apply_to_attend_form";
			}	
			
			//잡페어 공지사항 
			$scope.titleClick = function(board_content_seq, board_seq, board_gb, board_tp){
				var board_content_seq = board_content_seq;
				var board_seq = board_seq;
				location.href="/fap/company/company_board_contents_datail?board_content_seq=" + board_content_seq + "&board_seq=" + board_seq + "&board_gb=" + board_gb + "&board_tp=" + board_tp;
			}
			
		}]);
		
	</script>
	
</head>
<body  ng-app="myapp" ng-controller="MainController">
    <%@include file="company_menu.jsp"%>
	<!-- W3C 이 문서는 HTML5 규약을 준수 합니다! -->
    <!--웹접근성/content로 이동 -->
    <div class="skip-navigation">
        <p><a href="#main" class="goToMain">콘텐츠 바로가기</a></p>
    </div> 
    
    <!-- content -->
    <div class="content" id="main">
        <!-- 메인 배너_ 슬라이딩 갤러리 -->
        <div class="swiper-container gallery">
            <ul class="swiper-wrapper slidePic">
               <c:if test = "${pageContext.request.locale.language == 'ko'}">
                <li class="swiper-slide pic01"><a href="#"></a></li>
                </c:if>
                <c:if test = "${pageContext.request.locale.language == 'jp'}">
                <li class="swiper-slide pic01JA"><a href="#"></a></li>
                </c:if>
                <!-- <li class="swiper-slide pic02"><a href="#"></a></li> -->
            </ul>
            <div class="swiper-pagination pageWrap"></div>
        </div>

        <!-- 버튼 퀵 메뉴 -->
        <div class="quickMenuWrap btnWrap">
            <div class="btn-menu d-flex">
                <a href="#" class="menu-btn" id="companyNotice">
                    <div class="img-icon bullhorn"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.notice" /></div>
                </a>
                <a href="#" class="menu-btn"  id="faqLink">
                    <div class="img-icon comments"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.faq" /></div>
                </a>
                <a href="#" class="menu-btn" id="sesUserService">
                    <div class="img-icon user" ></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.ses_user_service" /></div>
                </a>
                <a href="#" class="menu-btn" id="2020FairSchedule">
                    <div class="img-icon calendar-alt"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.2020fair_schedule" /></div>
                </a>
                <a href="#" class="menu-btn" id="step">
                    <div class="img-icon chart-line" ></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.step" /></div>
                </a>
                <a href="#" class="menu-btn"  id="openJobInfo">
                    <div class="img-icon info-circle"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.jobinfo" /></div>
                </a>
                <a href="#" class="menu-btn" id="companies">
                    <div class="img-icon handshake" ></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.companies" /></div>
                </a>
                <a href="#" class="menu-btn"  id="empConnection">
                    <div class="img-icon globe"></div>
                    <div class="menu-txt fz16"><spring:message code="fap.main_menu.job.training.course" /></div>
                </a>
            </div>
        </div>

      
        <!-- 안내 문구(기업 회원) -->
        <div class="userGuideWrap">           
            <div class="userGuideBg">
                <header class="title h1 jua"><spring:message code="fap.comp_main_content.text01" /></header>
            </div>
            <div class="userGuide">
                <article class="guideWrap">
                    <h2 class="subTitle h2">
                       <spring:message code="fap.comp_main_content.text02" />
                    </h2>
                    <div class="guide d-flex">
                    
                         <c:if test = "${pageContext.request.locale.language == 'ko'}">
		                <div class="guide-banner"></div>
		                </c:if>
		                <c:if test = "${pageContext.request.locale.language == 'jp'}">
		                <div class="guide-bannerJA"></div>
		                </c:if>
                        
                        <div class="guide-text">
                            <p class="h4">
                                <spring:message code="fap.comp_main_content.text03" />
                                <spring:message code="fap.comp_main_content.text04" />
                            </p>
                            <h4 class="h4 baseColor">
                                <spring:message code="fap.comp_main_content.text05" />
                            </h4>
                            <ul class="guideList">
                                <li>
                                     <spring:message code="fap.comp_main_content.text06" />
                                </li>
                            </ul>
                            <button class="button bgcPoint" type="button" id="hireNow"><spring:message code="fap.comp_main_content.hire_now" />
                            </button>
                        </div>
                    </div>
                </article>
            </div>            
        </div>

	<!-- 기업용 지원자 통계 -->
        <div class="chartWrapper">
            <div class="chartWrap">
                <header class="title h2 baseColor">
                    <spring:message code="main.statistical_chart" />                   
                </header>
                <!-- 비IT직종 -->
                <div class="chartList">
                    <div class="subTitle bgcBase fz16"><spring:message code="main.statistical_chart_sub_ses" /></div>                   
                    <div id="jobfair_chart_div" style="width: 100%; display: inline-block;">
					<div id="chart_gender" style="float: left; width: 33%; height: 300px;"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
						<canvas id="chart_gender_canvas_ses" width="372" height="300" class="chartjs-render-monitor" style="display: block; width: 372px; height: 300px;"></canvas>
					</div>
					<div id="chart_major" style="float: left; width: 33%; height: 300px;"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
						<canvas id="chart_major_canvas_ses" width="372" height="300" class="chartjs-render-monitor" style="display: block; width: 372px; height: 300px;"></canvas>
					</div>
					<div id="chart_age_div" style="float: left; width: 33%; height: 300px;"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
						<canvas id="chart_age_canvas_ses" width="372" height="300" class="chartjs-render-monitor" style="display: block; width: 372px; height: 300px;"></canvas>
					</div>
				</div>
                </div>
                <!-- IT직종 -->
                <div class="chartList">
                    <div class="subTitle bgcLight fz16"><spring:message code="main.statistical_chart_sub_etc" /></div>                 
                     <div id="jobfair_chart_div" style="width: 100%; display: inline-block;">
					<div id="chart_gender" style="float: left; width: 33%; height: 300px;"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
						<canvas id="chart_gender_canvas_etc" width="372" height="300" class="chartjs-render-monitor" style="display: block; width: 372px; height: 300px;"></canvas>
					</div>
					<div id="chart_major" style="float: left; width: 33%; height: 300px;"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
						<canvas id="chart_major_canvas_etc" width="372" height="300" class="chartjs-render-monitor" style="display: block; width: 372px; height: 300px;"></canvas>
					</div>
					<div id="chart_age_div" style="float: left; width: 33%; height: 300px;"><div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
						<canvas id="chart_age_canvas_etc" width="372" height="300" class="chartjs-render-monitor" style="display: block; width: 372px; height: 300px;"></canvas>
					</div>
				</div>
                </div>
            </div>
        </div>
         
        
	 <%@include file="company_footer.jsp"%>

</body>
</html>