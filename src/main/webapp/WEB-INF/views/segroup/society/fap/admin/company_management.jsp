<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>기업 관리</title>
<style type="text/css">

.searchSelect01{width: 10%; margin-bottom:0;}
.searchInput01{width: 40%;}
.btn01{color:white;font-weight:bold;background-color:#3af;border-radius:10px;border:none;padding:5px;width:15%;}
.btn02{color:white;font-weight:bold;background-color:#3af;border-radius:5px;border:none;padding:3px;width:80%;text-align: center;font-size:13px;}
 
</style>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/adminDefault.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<title>Bridge Job Fair</title>
<script type="text/javascript">
	
	var myApp = angular.module('myapp', []);

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
	} ]);

	myApp.controller('compManageController', ['$scope','$compile','$http',function($scope, $compile, $http){
		
		
	}]);

	
</script>

<script type="text/javascript">

	$(function(){
		initialize();
		
		//검색
		$("#searchButton").on('click',function(){
			
			var searchSelect = document.getElementById("searchSelect");
			var val = searchSelect.options[searchSelect.selectedIndex].value;				 
			
			if(val =="searchJaNm"){		 
					var searchJaNm = $("#searchInput").val();
					var searchEnNm = "";
			}else if(val=="searchEnNm"){
				    var searchJaNm = "";
				    var searchEnNm = $("#searchInput").val();
			}else{
					var searchJaNm = "";
					var searchEnNm = "";
			}
			
		  $("#searchJaNm").val(searchJaNm);
		  $("#searchEnNm").val(searchEnNm);
		  
			console.log("val:"+val+", searchJaNm:"+searchJaNm+",searchEnNm:"+searchEnNm);
				
			location.href="/fap/admin/company_management?searchJaNm="+searchJaNm+"&searchEnNm="+searchEnNm+"&currentPage="+${repNavi.currentPage}+"&orderType="+orderType+"&orderValue="+orderValue;		
		})
	})
	
	function initialize(){
		var orderType = $("#orderType").val();
		var orderValue = $("#orderValue").val();
			 
			$.each($(".arrow"),function(index,item){
				if($(this).hasClass(orderType) && orderValue=='asc'){
					$(this).removeClass('desc').addClass(orderValue);
					$(this).attr('src','/resources/segroup/society/fap/images/main/triangle_up.png');
				}else {
					$(this).removeClass('asc').addClass(orderValue);
					$(this).attr('src','/resources/segroup/society/fap/images/main/triangle_down.png');
				}
			})
		}
	
	function order_change(orderType, target){		 
			var orderValue = '';		
			if ($(target).hasClass('desc')) {			 
				$(target).removeClass('desc').addClass('asc');
				orderValue = 'asc';				 
			} else {		 
				$(target).removeClass('asc').addClass('desc');
				orderValue = 'desc';
			}
		 
			//검색관련
			var searchSelect = document.getElementById("searchSelect");
			var val = searchSelect.options[searchSelect.selectedIndex].value;				 
			
			if(val =="searchJaNm"){		 
					var searchJaNm = $("#searchJaNm"	).val();
					var searchEnNm = "";				 
			}else if(val=="searchEnNm"){
				    var searchJaNm = "";
				    var searchEnNm =$("#searchEnNm"	).val();
			}else{
					var searchJaNm = "";
					var searchEnNm = "";
			}
			 
			location.href="/fap/admin/company_management?searchJaNm="+searchJaNm+"&searchEnNm="+searchEnNm+"&currentPage="+${repNavi.currentPage}+"&orderType="+orderType+"&orderValue="+orderValue;
	}

	function changePageLoadList(clickedPage) {
		location.href='/fap/admin/company_management?clickedPage='+clickedPage;
	}

</script>

<body ng-app="myapp" ng-controller="compManageController">
    <%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>기업 관리</h2>
	</div>
	<div style="text-align:center;">
		<button onclick="location.href='/fap/admin/agency_company_connect'" class="btn01">에이전시 - 기업 연결</button>
		<button onclick="location.href='/fap/admin/agency_company_connect_management'" class="btn01">에이전시 - 기업 연결 관리</button>
	</div>
	<br>
	<div class="custom_div" >
	<!-- 검색 -->
		<table class="search_box" >
			<tr>
				<th style="width: 10%;">
					<select id="searchSelect" class="searchSelect01">
						<option value="searchJaNm" <c:if test= " ${ searchJaNm != '' } ">selected="selected"</c:if>>일본어</option>
						<option value="searchEnNm" <c:if test= " ${ searchEnNm != '' } ">selected="selected"</c:if>>영어</option>
					</select>
				</th>	
				<td>
					<input type="text" id="searchInput" class="searchInput01" placeholder="검색할 회사명을 입력하세요"
						<c:choose>
							<c:when test=" ${searchJaNm != ''} ">value=" ${searchJaNm} "</c:when>
							<c:when test=" ${searchEnNm != ''} ">value=" ${searchEnNm} "</c:when>
				    	</c:choose>
					>
				</td>
				<td >
					<input type="button" value="검색" class="btn01" id="searchButton" >
				</td> 
			</tr>
		</table>

	<br>
	<table class="table" >
	    <colgroup>
	    	<col width="4%;">
	    	<col width="20%;">
	    	<col width="9%;">
	    	<col width="9%;">
	    	<col width="9%;">
	    	<col width="11%;">
	    	<col width="10%;">
	    	<col width="7%;">
	    	<col width="7%;">
	    	<col width="7%;">
	    	<col width="7%;">	    	
	    </colgroup>
	    
		<thead>
			<tr>
				<td>No.</td>
				<td>회사 아이디</td>
				<td>회사&nbsp;
					<img class="arrow desc fap_comp_ja_nm" src="/resources/segroup/society/fap/images/main/triangle_down.png;" 
					         onclick="order_change('fap_comp_ja_nm', this)"><br>(일본어)
				</td>
				<td>
					회사&nbsp;
					<img class="arrow desc fap_comp_en_nm" src="/resources/segroup/society/fap/images/main/triangle_down.png;" 
					         onclick="order_change('fap_comp_en_nm', this)"><br>(영어)
				</td>
				<td>대표자명</td>
				<td>회사<br>홈페이지</td>
				<td>설립일</td>
				<td>자본금</td>
				<td>종업원수</td>
				<td>IT Master 사원수</td>
				<td>회사정보<br>수정</td>
			</tr>
		</thead>	
		<tbody class="tbody">
			<c:forEach var="data" items="${company_list}" varStatus="status">
				<tr>
					<td>${companyLoadNum - (status.count-1)}</td>
					<td>${data.fap_comp_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
					<td>${data.fap_comp_rep}</td>
					<td>${data.fap_comp_homepage}</td>
					<td>${data.fap_comp_est_dt}</td>
					<td>${data.fap_comp_stock}</td>
					<td>${data.fap_comp_employee_num}</td>
					<td>${data.fap_comp_scit_num}</td>
					<td>
						<form action="/fap/admin/company_update_form" method="post">
							<input type="hidden" name="fap_comp_id" value="${data.fap_comp_id}">
							<input type="submit" value="수정" class="btn02">
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		<input type="hidden" id="orderType" value="${orderType}">
		<input type="hidden" id="orderValue" value="${orderValue}">
		<input type="hidden" id="searchJaNm" name="searchJaNm" value="${searchJaNm}">
		<input type="hidden" id="searchEnNm"  name="searchEnNm"  value="${searchEnNm}">
</div>
<div class="before-page">
					
	<a href="javascript:changePageLoadList(${repNavi.currentPage - repNavi.pagePerGroup})">◁◁</a>
	<a href="javascript:changePageLoadList(${repNavi.currentPage - 1})">◀</a>
			<c:forEach var="i" begin="${repNavi.startPageGroup}" end="${repNavi.endPageGroup}" step="1">					
						<c:choose>					
							<c:when test="${i eq repNavi.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="javascript:changePageLoadList(${i})">${i}</a>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
	<a href="javascript:changePageLoadList(${repNavi.currentPage + 1})">▶</a>
	<a href="javascript:changePageLoadList(${repNavi.currentPage + repNavi.pagePerGroup})">▷▷</a>
</div>





</body>
</html>