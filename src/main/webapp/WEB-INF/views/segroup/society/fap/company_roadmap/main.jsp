<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
<style type="text/css">
	th {
		background-color: blue;
		color: white;
	}
	
	
	
	.gold {
		background-color: gold;
	}
	.silver {
		background-color: silver;
	}
	.pink {
		background-color: pink;
	}
	
	.link {
		background-color: white;
	}
</style>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>


<script type="text/javascript">

var myApp = angular.module('myapp', []);

myApp.directive('selectcode', ['$http',function ($http){
	return {
		restrict: "A",
		replace: true,
		scope : {
			value : '@'
		},
		controller: function ($scope, $element, $attrs) {
			$http({
				method: 'POST',
				url: '/codeconverter',
		  		responseType: 'text',
				params : {
					code : $attrs.value
				}
			}).then(function successCallback(response) {
	    		$scope.filterParams = response.data;
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		,template: "<option>{{filterParams}}</option>"
	}
}]);


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
				console.log(response);
			});
		},
		template : "<span>{{filterParams}}</span>"
	}
}]);//code


myApp.controller("RoadmapController", ["$scope", "$compile", "$http", function($scope, $compile, $http){
	
	
	$scope.select_change = function(flag){
		
		//table 설정하는 함수 실행
		$scope.table_set(flag);
		
		
		//진행도를 표시하는 함수 실행
		if(flag == 2){
			$scope.roadmap_process();
		}
		
		
	}//$scope.select_change
	
	$scope.table_set = function(flag){
		var table_output = $("#table_layout").html();
		
		//jobfair 선택시 jobfair_detail 초기화
		if(flag == 1){
			
			$("#jobfair_detail_hidden").prop("selected", true);
			$("#table_layout").html("");
			$("#select_jobfair_detail").html("<option value=\"\" id=\"jobfair_detail_hidden\" hidden>선택해주세요.</option>");
			//jobfair_detail(divide) 활성화
			$("#select_jobfair_detail").attr("disabled", false);
			
			
			$http({
				method : 'POST',
				url : '/fap/company_roadmap/select_jobfair_divide',
				responseType : 'text',
				params : {
					fap_jobfair_seq: $("#select_jobfair option:selected").val()
				}
			}).then(function successCallback(response) {
				//jobfair_detail에 option 추가
				for(var i in response.data){
					$("#select_jobfair_detail").append($compile("<option selectcode value=" 
							+ response.data[i].fap_jobfair_divide_gb + " seq=\"" + response.data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
				}
			
			}, function errorCallback(response) {
				console.log(response);
			});
			
			
			/*$.ajax({
			 	url: "/fap/company_roadmap/select_jobfair_divide"
				,type: "POST"
				,data: {fap_jobfair_seq: $("#select_jobfair option:selected").val()}
				,dataType: "json"
				,success: function(data){
					//jobfair_detail에 option 추가
					for(var i in data){
						//console.log(data[i]);
						$("#select_jobfair_detail").append($compile("<option selectcode value=" 
								+ data[i].fap_jobfair_divide_gb + " seq=\"" + data[i].fap_jobfair_divide_seq + "\"></option>")($scope));
					}
					
				}
				,error: function(){
				}
			}); */
			
		}else if(flag == 2){
			table_output = "";
			
			
		}
		
		//jobfair가 비어 있으면 종료
		var jobfair = $("#select_jobfair option:selected").val();
		if(jobfair == null || jobfair == ""){
			return;
		}
		
		//jobfair_detail가 비어 있으면 종료
		var jobfair_detail = $("#select_jobfair_detail option:selected").val();
		if(jobfair_detail == null || jobfair_detail == ""){
			return;
		}
		 
		
		var label = $("#select_jobfair_detail option:selected").text();
		
		table_output += "<table id=\"roadmap\" border=\"1\" style=\"border-collapse:collapse; text-align:center\">";
		table_output += "<caption>로드맵 " + label +  " </caption>";
		table_output += "<colgroup>";
		table_output += "<col style=\"width: 20%\">";
		table_output += "<col style=\"width: 20%\">";
		table_output += "<col style=\"width: 15%\">";
		table_output += "<col style=\"width: 15%\">";
		table_output += "<col style=\"width: 15%\">";
		//table_output += "<colgroup span=\"3\">";
		table_output += "<col style=\"width: 15%\">";
		table_output += "</colgroup>";
		table_output += "<thead>";
		table_output += "<tr>";
		table_output += "<th>구분</th>";
		table_output += "<th>상세구분</th>";
		table_output += "<th colspan=\"3\">상태";
		table_output += "<th>링크</th>";
		table_output += "</tr>";
		table_output += "</thead>";
		table_output += "<tbody>";
		table_output += "</tbody> ";
		table_output += "</table>";
		
		$("#table_layout").html(table_output);
		
		
		// selected된 option의 optionGroup label값 불러오기
		var label = $("#select_jobfair option:selected").closest("optgroup").attr("flag");
	    if(label == "2"){
	    	//예정된
	    	$scope.add_tr();
	    }else if(label == "1"){
	    	//진행중
	    	var detail = $("#select_jobfair_detail option:selected").text();
	    	//alert(detail);
	    	if(detail == "K-fair"){
	    		//K-fair
	    		$scope.add_tr();
	    		$scope.add_tr2(1);
		    	//add_tr5();
	    	}else if(detail == "J-fair"){
	    		//J-fair
	    		$scope.add_tr();
	    		$scope.add_tr2(2);
	    		//add_tr3();
		    	//add_tr4();
		    	//add_tr5();
	    	}else if(detail == "미스매칭"){
	    		//미스매칭
	    		$scope.add_tr();
	    		$scope.add_tr2(3);
		    	//add_tr3();
		    	//add_tr5();
	    	}
	    }else if(label == "3"){
	    	//종료된
	    	add_tr5();
	    }
	}//$scope.table_set
	
	
	$scope.roadmap_process = function() {
		
		//alert("roadmap_process 실행")
		
		
		$http({
			method : 'POST'
			, url : '/fap/company_roadmap/roadmap_process_map'
			, responseType : 'text'
			, params : {
				fap_jobfair_divide_seq	: $("#select_jobfair_detail option:selected").attr("seq")
			}
			
		}).then(function successCallback(response) {
			
			//구분 : 채용공고 등록 (add_tr)
			//상세구분 : 회사 연결 #company_connect
			if(response.data.fap_comp_user_connect.fap_comp_user_connect_ck == null) {
				//회사 연결 신청 안한 상태
				$("#company_connect td:nth-child(3)").addClass("pink");
				$("#company_connect td:nth-child(2)").addClass("pink");
			
			}else if(response.data.fap_comp_user_connect.fap_comp_user_connect_ck == "B3801") {
				//회사 연결 신청은 했지만 승인 대기 상태
				$("#company_connect td:nth-child(4)").addClass("pink");
				$("#company_connect td:nth-child(3)").addClass("silver");
				$("#company_connect td:nth-child(2)").addClass("pink");
				
			}else if(response.data.fap_comp_user_connect.fap_comp_user_connect_ck == "B3800") {
				//회사 연결 완료
				$("#company_connect td:nth-child(5)").addClass("silver");
				$("#company_connect td:nth-child(4)").addClass("silver");
				$("#company_connect td:nth-child(3)").addClass("silver");
				$("#company_connect td:nth-child(2)").addClass("silver");
				
			}
			
			//상세구분 : 잡페어 신청 #roadmap_jobfair
			//console.log(response.data.fap_jobfair_comp);
			
			if(response.data.fap_jobfair_comp != null){
				//잡페어를 이미 신청 한경우
				$("#roadmap_jobfair td:nth-child(4)").addClass("silver");
				$("#roadmap_jobfair td:nth-child(3)").addClass("silver");
				$("#roadmap_jobfair td:nth-child(2)").addClass("silver");
				$("#roadmap_jobfair td:nth-child(1)").addClass("silver");
				
			}else{
				//잡페어를 신청 안한경우
				//console.log(response.data.fap_jobfair_start);
				if(response.data.fap_jobfair_start.is_start == 1){
					//신청 기간 전
					$("#roadmap_jobfair td:nth-child(1)").addClass("pink");
				}else if(response.data.fap_jobfair_start.is_end == 1) {
					//신청 기간 중
					$("#roadmap_jobfair td:nth-child(1)").addClass("pink");
					$("#roadmap_jobfair td:nth-child(2)").addClass("pink");
				}else{
					//신청 기간 후
					$("#roadmap_jobfair td:nth-child(1)").addClass("pink");
					$("#roadmap_jobfair td:nth-child(2)").addClass("silver");
					$("#roadmap_jobfair td:nth-child(3)").addClass("pink");
				}
				return;
			}
			
			//상세구분 : 채용공고 등록 #roadmap_job_ad
			//console.log(response.data.fap_job_ad);
			//alert("1 : " + response.data.fap_job_ad.fap_job_ad_seq);
			
			if(response.data.fap_job_ad.fap_job_ad_seq == 0){
				//등록된 채용공고가 없는 경우
				//alert("2");
				$("#roadmap_job_ad td:nth-child(1)").addClass("pink");
				$("#roadmap_job_ad td:nth-child(2)").addClass("pink");
			
			}else if(response.data.fap_job_ad.fap_job_ad_per == "C0901"){
				//등록 했지만 아직 승인되지 않음
				//alert("3");
				$("#roadmap_job_ad td:nth-child(1)").addClass("pink");
				$("#roadmap_job_ad td:nth-child(2)").addClass("silver");
				$("#roadmap_job_ad td:nth-child(2)").addClass("pink");
				
			}else if(response.data.fap_job_ad.fap_job_ad_per == "C0900"){
				//승인됨
				//alert("4");
				$("#roadmap_job_ad td:nth-child(1)").addClass("silver");
				$("#roadmap_job_ad td:nth-child(2)").addClass("silver");
				$("#roadmap_job_ad td:nth-child(3)").addClass("silver");
				$("#roadmap_job_ad td:nth-child(4)").addClass("silver");
			}

			//전형진행(한국) .job_recruit_kr
			console.log(response.data.fap_job_recruit_pcs_sch);
			
			if(response.data.fap_job_recruit_pcs_sch == null ||
					response.data.fap_job_recruit_pcs_sch.length == 0){
				//등록된 전형이 없는 경우  
				return;
			}else{
				//등록된 전형이 있는 경우
				var trs = $(".job_recruit_kr").each(function(index, item){
					
					if(response.data.fap_job_recruit_pcs_sch[index].is_start == 1){
						//전형이 시작되지 않은 경우
					}else{
						//전형이 시작된 경우
						if(response.data.fap_job_recruit_pcs_sch[index].is_end == 1){
							//전형이 진행중인 경우 (시작되고 끝나지 않음)
							if(index == 0){
								$(item).children().eq(1).addClass("pink");
								$(item).children().eq(2).addClass("pink");
							}else{
								$(item).children().eq(0).addClass("pink");
								$(item).children().eq(1).addClass("pink");
							}
						
						}else{
							//전형이 끝난 경우
							if(index == 0){
								$(item).children().eq(1).addClass("pink");
								$(item).children().eq(2).addClass("silver");
								$(item).children().eq(3).addClass("silver");
								$(item).children().eq(4).addClass("pink");
							}else{
								$(item).children().eq(0).addClass("pink");
								$(item).children().eq(1).addClass("silver");
								$(item).children().eq(2).addClass("silver");
								$(item).children().eq(3).addClass("pink");
							}
							
							//합격자 발표 여부!!
							
							
						}
						
						
					
						
					}
					console.log(response.data.fap_job_recruit_pcs_sch[index].is_start)
					
				});
			}
			
			
			
			
			
			
		}, function errorCallback(response) {
			console.log(response);
		});
		
		
		
	/* 	$("#roadmap tbody tr").each(function (index, item) {
			//alert(index + " : " + $(item).attr("id"));
		}); */
		
		
		
		
		
		
	}//$scope.roadmap_process
	
	$scope.add_tr = function() {
		var str = "";
		
		str += "<tr id=\"company_connect\">";
		str += "<th rowspan=\"3\">채용공고등록</th>";
		str += "<td>회사 연결</td>";
		str += "<td>연결 신청</td>";
		str += "<td>대기</td>";
		str += "<td>승인</td>";
		str += "<td class=\"link\"><a href=\"#\">회사연결 오네가이 준영찡</a></td>";
		str += "</tr>";
		
		str += "<tr id=\"roadmap_jobfair\">";
		str += "<td>잡페어 신청</td>";
		str += "<td>신청 시작</td>";
		str += "<td>신청 마감</td>";
		str += "<td>신청 완료</td>";
		str += "<td class=\"link\"><a href=\"#\">잡페어 신청</a></td>";
		str += "</tr>";
		
		str += "<tr id=\"roadmap_job_ad\">>";
		str += "<td>채용공고 등록</td>";
		str += "<td>등록</td>";
		str += "<td>대기</td>";
		str += "<td>승인</td>";
		str += "<td class=\"link\"><a href=\"#\">채용공고관리 > 채용공고 등록</a></td>";
		str += "</tr>";
		
		$("#roadmap").append($compile(str)($scope));
	}
	
	
	$scope.add_tr2 = function(type){
		
		var str = "";
		
		/* $.ajax({
			method: "POST"
			, url: "/fap/company_roadmap/select_job_recruit_pcs"
			, data: {
				fap_jobfair_divide_seq	: $("#select_jobfair_detail option:selected").attr("seq")
			}
			, dataType: "json"
			, success: function(data){
				//alert("성공");
				console.log(data);
				if(data == null || data.length == 0){
					str += "<tr>";
					str += "<th>전형진행(한국)</th>";
					
					
					str += "<td colspan=\"4\">등록된 전형이 없습니다.</td>";
					
					
					str += "<td class=\"link\">링크링크링</td>";
					str += "</tr>";
					$("#roadmap").append($compile(str)($scope));
					return;
				}//if
				for(var i in data){
					//console.log(data[i].fap_job_recruit_pcs_dtl);
					//alert("i : " + i);
					if(i == 0){
						str += "<tr>";
						str += "<th rowspan=\"" + data.length + "\">전형진행(한국)</th>";
						
						//str += "<td><code value=\"" + data[i].fap_job_recruit_pcs_gb + "\"></td>";
						str += "<td>" + data[i].fap_job_recruit_pcs_dtl + "</td>";
						
						str += "<td>진행중</td>";
						str += "<td>종료</td>";
						str += "<td>합격자 발표</td>";
						str += "<td rowspan=\"" + data.length + "\" class=\"link\">링크링크링</td>";
						str += "</tr>";
					}else{
						str += "<tr>";
						
						//str += "<td><code value=\"" + data[i].fap_job_recruit_pcs_gb + "\"></td>";
						str += "<td>" + data[i].fap_job_recruit_pcs_dtl + "</td>";
						
						str += "<td>진행중</td>";
						str += "<td>종료</td>";
						str += "<td>합격자 발표</td>";
						str += "</tr>";
						
					}
				}//for	
				
				$("#roadmap").append($compile(str)($scope));
				
				if(type == 1){
					add_tr5();
				}else if(type == 2){
					add_tr3();
					add_tr4();
					add_tr5();
				}else if(type == 3){
					add_tr3();
					add_tr5();
				}
				
				
				
			}
		}); */
		
		$http({
			method: "POST"
			,url: "/fap/company_roadmap/select_job_recruit_pcs"
			,params: {
				fap_jobfair_divide_seq	: $("#select_jobfair_detail option:selected").attr("seq")
			}
			
		}).then(function successCallback(response) {
			
			//alert("성공");
			//console.log(response.data);
			if(response.data == null || response.data.length == 0){
				str += "<tr id=\"job_recruit_kr\">";
				str += "<th>전형진행(한국)</th>";
				
				
				
				str += "<td colspan=\"4\">등록된 전형이 없습니다.</td>";
				
				
				str += "<td class=\"link\">링크링크링</td>";
				str += "</tr>";
				$("#roadmap").append($compile(str)($scope));
				return;
			}//if
			for(var i in response.data){
				//console.log(response.data[i]);
				//alert("i : " + i);
				if(i == 0){
					str += "<tr class=\"job_recruit_kr\" seq=\"" + response.data.fap_job_ad_seq + " \">";
					str += "<th rowspan=\"" + response.data.length + "\">전형진행(한국)</th>";
					
					//str += "<td><code value=\"" + response.data[i].fap_job_recruit_pcs_gb + "\"></td>";
					str += "<td>" + response.data[i].fap_job_recruit_pcs_dtl + "</td>";
					
					str += "<td>진행중</td>";
					str += "<td>종료</td>";
					str += "<td>합격자 발표</td>";
					str += "<td rowspan=\"" + response.data.length + "\" class=\"link\">링크링크링</td>";
					str += "</tr>";
				}else{
					str += "<tr class=\"job_recruit_kr\">";
					
					//str += "<td><code value=\"" + response.data[i].fap_job_recruit_pcs_gb + "\"></td>";
					str += "<td>" + response.data[i].fap_job_recruit_pcs_dtl + "</td>";
					
					str += "<td>진행중</td>";
					str += "<td>종료</td>";
					str += "<td>합격자 발표</td>";
					str += "</tr>";
					
				}
			}//for	
			
			$("#roadmap").append($compile(str)($scope));
			
			if(type == 1){
				add_tr5();
			}else if(type == 2){
				add_tr3();
				add_tr4();
				add_tr5();
			}else if(type == 3){
				add_tr3();
				add_tr5();
			}
			
			
		}, function errorCallback(response) {
			return null; 
		});
		
		
			
		
		
		
		/* str += "<tr>";
		str += "<th rowspan=\"3\">전형진행(한국)</th>";
		str += "<td>서류 전형</td>";
		str += "<td>진행중</td>";
		str += "<td>종료</td>";
		str += "<td>합격자 발표</td>";
		str += "<td rowspan=\"3\" class=\"link\">링크링크링</td>";
		str += "</tr>";
		str += "<tr>";
		str += "<td>필기 시험</td>";
		str += "<td>진행중</td>";
		str += "<td>종료</td>";
		str += "<td>합격자 발표</td>";
		str += "</tr>";
		str += "<tr>";
		str += "<td>skype 면접</td>";
		str += "<td>진행중</td>";
		str += "<td>종료</td>";
		str += "<td>합격자 발표</td>";
		str += "</tr>"; */
		
		
		
		
		
	}//$scope.add_tr2
	
	
}]);//myApp.controller

	$(document).ready(function(){
		
	
		$("#add_tr").on("click", function(){				
			$scope.add_tr;
		});
		
		$("#add_tr2").on("click", function(){				
			add_tr2();
		});
		
		$("#add_tr3").on("click", function(){
			add_tr3();
		});	
		
		$("#add_tr4").on("click", function(){
			add_tr4();
		});	
		
		$("#add_tr5").on("click", function(){
			add_tr5();
		});	
		
		$("#add_class").on("click", function(){
			
			var tds = $("td");
			$.each(tds, function(index, item){
				$(item).addClass(index.toString());		
			});
			117
		});
		
		$("#add_onclick").on("click", function(){
			add_onclick();
		});
		
		
		
	});//ready
		
	function add_onclick(){
		$("td").on("click", function(){
			var to_index = $(this).attr("class");
			
			$.each($("td"), function(index, item){
				
				if(index <= to_index){
					$(item).addClass("gold");
				}
			});
		});
	}
	
	// (num1, num2) 부분을 진행완료 시킴
	function roadmap_process_go(num1, num2){
		
		var str_row_id = "#roadmap > tbody > tr:nth-child(" + num1 + ") > th:nth-child(1)";
		var has_rowspan = $(str_row_id).attr("rowspan");
		
		//"구분"칼럼이 있는 tr(rowspan)은 child가 1개씩 많으므로 판단해서 num2를 조정
		if(has_rowspan != null){
			//alert("있다");
			num2 ++;
		}else{
			//alert("없다")
		}
		
		
		var str_id = "#roadmap > tbody > tr:nth-child(" + num1 + ") > td:nth-child("+ num2 + ")";
		$(str_id).addClass("gold");
	}
	
	
	
	
 	
	
	//미스매칭	
	function add_tr3(){
		var str = "";
		
		str += "<tr>";
		str += "<th rowspan=\"3\">미스매칭</th>";
		str += "<td>현지 면접자 확정</td>";
		str += "<td>합격자입력</td>";
		str += "<td>...</td>";
		str += "<td>완료</td>";
		str += "<td class=\"link\">링크링</td>";
		str += "</tr>";
		
		str += "<tr>";
		str += "<td>진행여부</td>";
		str += "<td>시작</td>";
		str += "<td>진행중</td>";
		str += "<td>종료</td>";
		str += "<td class=\"link\">링크링</td>";
		str += "</tr>";
		
		str += "<tr>";
		str += "<td>미스매칭</td>";
		str += "<td>신청</td>";
		str += "<td>...</td>";
		str += "<td>완료</td>";
		str += "<td class=\"link\">잡페어 신청</td>";
		str += "</tr>";
		
		$("#roadmap").append(str);
	}
	
	//전형진행(일본)
	function add_tr4(){
		var str = "";
		
		str += "<tr>";
		str += "<th rowspan=\"2\">전형진행(일본)</th>";
		str += "<td>면접스케줄</td>";
		str += "<td>입력</td>";
		str += "<td>조정중</td>";
		str += "<td>완료</td>";
		str += "<td class=\"link\"><a href=\"#\">전형일정 관리>지원자 관리</a></td>";
		str += "</tr>";
		
		str += "<tr>";
		str += "<td>현지면접</td>";
		str += "<td>진행중</td>";
		str += "<td>종료</td>";
		str += "<td>합격자발표</td>";
		str += "<td class=\"link\">채용공고관리>지원자관리</td>"
		str += "</tr>";
		
		$("#roadmap").append(str);
	}
	
	//내정
	function add_tr5(){
		var str = "";
		
		str += "<tr>";
		str += "<th rowspan=\"3\">내정</th>";
		str += "<td>최종 결과 통지</td>";
		str += "<td>입력</td>";
		str += "<td>종료</td>";
		str += "<td>완료</td>";
		str += "<td class=\"link\"><a href=\"#\">채용공고 관리 > 지원자 관리</a></td>";
		str += "</tr>";
		
		str += "<tr>";
		str += "<td>서류 교환</td>";
		str += "<td>...</td>";
		str += "<td>...</td>";
		str += "<td>...</td>";
		str += "<td class=\"link\"><a href=\"#\">내정자 관리 > 서류 관리</a></td>"
		str += "</tr>";
		
		str += "<tr>";
		str += "<td>비용 결제</td>";
		str += "<td>결제</td>";
		str += "<td>...</td>";
		str += "<td>완료</td>";
		str += "<td class=\"link\"><a href=\"#\">내정자 관리 > 비용 결제</a></td>"
		str += "</tr>";
		
		$("#roadmap").append(str);
	}
	
	
	
	
	
	
	
</script>
<body ng-app="myapp" ng-controller="RoadmapController">
<h1>hello world</h1>

	<div id="select-box-layout">
		<h3>Job fair</h3>
		<select onchange="angular.element(this).scope().select_change(1)" id="select_jobfair">
			<option value="" hidden>선택해주세요.</option>
			<optgroup label="진행중인 잡페어" flag="1">
				<c:forEach var="jobfair" items="${jobfair_map.jobfair_list_now}">
					<option value="${jobfair.fap_jobfair_seq}">${jobfair.fap_jobfair_title}</option>
				</c:forEach>
			</optgroup>
			<optgroup label="예정된 잡페어" flag="2">
				<c:forEach var="jobfair" items="${jobfair_map.jobfair_list_before}">
					<option value="${jobfair.fap_jobfair_seq}">${jobfair.fap_jobfair_title}</option>
				</c:forEach>
			</optgroup>
			<optgroup label="종료된 잡페어" flag="3">
				<c:forEach var="jobfair" items="${jobfair_map.jobfair_list_after}">
					<option value="${jobfair.fap_jobfair_seq}">${jobfair.fap_jobfair_title}</option>
				</c:forEach>
			</optgroup>
		</select>
		<h3>Job fair</h3>
		<select onchange="angular.element(this).scope().select_change(2)" id="select_jobfair_detail" disabled="disabled">
			<option value="" id="jobfair_detail_hidden" hidden>선택해주세요.</option>
			<!-- <option value="1">K-fair</option>
			<option value="2">J-fair</option>
			<option value="3">미스매칭</option>
			<option selectcode value="C0100"></option> -->
		</select>
	</div>

	

	<div id="table_layout" style="overflow-x:auto;">
		여기입니다
		<%--<table border="1" style="border-collapse:collapse; text-align:center" cellpadding="0" cellspacing="0">
			<caption>로드맵</caption>
			<col>
			<col>
			<colgroup span="3">
			<col>				
			<thead>
				<tr>
					<th>구분</th>
					<th>상세구분</th>
					<th colspan="3">상태
					<th>링크</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th rowspan="3">전형진행(한국)</th>
					<td>서류 전형</td>
					<td>진행중</td>
					<td>종료</td>
					<td>합격자 발표</td>
					<td rowspan="3">링크링크링</td>
				</tr>
				<tr>
					<td>필기 시험</td>
					<td>진행중</td>
					<td>종료</td>
					<td>합격자 발표</td>
				</tr>
				<tr>
					<td>skype 면접</td>
					<td>진행중</td>
					<td>종료</td>
					<td>합격자 발표</td>
				</tr>
			</tbody> 
		</table>--%>
		
	</div>
	<input type="button" id="add_tr" value="채용공고등록">
	<input type="button" id="add_tr2" value="전형(한국)">
	<input type="button" id="add_tr3" value="미스매칭">
	<input type="button" id="add_tr4" value="전형(일본)">
	<input type="button" id="add_tr5" value="내정">
	<br>
	<input type="button" id="add_class" value="클래스 부여">
	<input type="button" id="add_onclick" value="온클릭 부여">
	<br>
	<input type="text" id="num1">
	<br>
	<input type="text" id="num2">
	<br>
	<input type="button" id="process" value="!!">
</body>
</html>