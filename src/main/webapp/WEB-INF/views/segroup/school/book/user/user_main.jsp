<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html class="no-js">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>SES Library</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="User Landing Page" />
<meta name="keywords" content="SES Library, user, landing page, main" />

<link rel="shortcut icon" href="/favicon.ico">

<!-- jQuery -->
<script type="text/javascript"
	src="/resources/segroup/school/book/user/js/jquery-3.1.1.js"></script>
<!-- jQuery Easing -->
<script
	src="/resources/segroup/school/book/user/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="/resources/segroup/school/book/user/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script
	src="/resources/segroup/school/book/user/js/jquery.waypoints.min.js"></script>
<!-- Main JS -->
<script src="/resources/segroup/school/book/user/js/main.js"></script>
<!-- Jquery UI -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Datepicker -->
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<!-- Angular JS -->
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<!-- Jquery UI  -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<!-- Google Fonts -->
<!-- <link
	href='http://fonts.googleapis.com/css?family=Playfair+Display:400,700,400italic|Roboto:400,300,700'
	rel='stylesheet' type='text/css'> -->
<!-- Animate -->
<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/animate.css">
<!-- Icomoon -->
<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/icomoon.css">
<!-- Bootstrap  -->
<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/bootstrap.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/style.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/style2.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/normalize.css">

<link rel="stylesheet"
	href="/resources/segroup/school/book/user/css/responsive.css">

<!-- Modernizr JS -->
<script
	src="/resources/segroup/school/book/user/js/modernizr-2.6.2.min.js"></script>

</head>

<style>
a.advanced_search:hover {
	text-decoration: underline;
	cursor: pointer;
}
</style>

<script type="text/javascript">
	var myApp = angular.module('myapp', []);

	myApp.controller('BookController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		$http({
			method: 'GET',
			url: '/book/utility/get_category',
			responseType: 'json',

		}).then(function successCallback(response) {
			$scope.results = response.data;
			
			//????????? ?????? ??????
			var category_hidden = $("#bookinfo_category_hidden").val();
			
			var content = '';
			for(var i = 0; i < response.data.length; i++){
				if(category_hidden == response.data[i]){
					content += '<option selectcode value="' + response.data[i] +'" selected></option>';
				}else{
					content += '<option selectcode value="' + response.data[i] +'"></option>';
				}
			}
			
			$('#bookinfo_category').append($compile(content)($scope));
			
		}, function errorCallback(response) {
		});
		
		$http({
			method: 'GET',
			url: '/book/utility/get_division',
			responseType: 'json',

		}).then(function successCallback(response) {
			$scope.results = response.data;
			
			var division_hidden = $("#bookinfo_division_hidden").val();
			
			var content = '';
			for(var i = 0; i < response.data.length; i++){
				if(division_hidden == response.data[i]){
					content += '<option selectcode value="' + response.data[i] +'" selected></option>';
				}else{
					content += '<option selectcode value="' + response.data[i] +'"></option>';
				}
			}
			
			$('#bookinfo_division').append($compile(content)($scope));	
			
		}, function errorCallback(response) {
		});
		
	}]);
	
	myApp.directive('code', ['$http',function($http){
		return {
			restrict: "E",
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
			,template: "<span>{{filterParams}}</span>"
		}
	}]);
	
	myApp.directive('selectcode', ['$http',function($http){
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
					alert(response);
				});
			}
			,template: "<option>{{filterParams}}</option>"
		}
	}]);
	
	$(function() {
		//????????? ??????
		$("#login_submit").on("click", function() {

			var user_id = $("#id").val();
			var user_pw = $("#pw").val();

			if (user_id.length == 0) {
				alert('???????????? ??????????????????');
				return;
			}
			if (user_pw.length == 0) {
				alert('??????????????? ??????????????????');
				return;
			}
			
			$("#user_id").val(user_id);
			$("#user_pw").val(user_pw);
			
			$("#bookLoginForm").submit();

		});
		
		//???????????? ??????
		$('#logout').click(function() {
	        $('#logoutForm').submit();
	        return false;
	    });

		//????????????
		$("#advanced_search").on("click", function() {
			$("#advanced_box").css("display", "inline");
		});
		$("#advanced_submit").on("click", function() {
			$("#advanced_box").css("display", "none");
		});
		$("#advanced_cancel").on("click", function() {
			$("#advanced_box").css("display", "none");
		});

		//????????? ?????? datepicker
		minMax("advanced_start_date", "advanced_end_date");
		
		$("#searchBtn").on("click",function(){
			textClear();
			$("#bookinfo_book_nm").val($("#searchTextField").val());
			pagingFormSubmit(1);
		})

	});
	
	function pagingFormSubmit(currentPage) {
		var checkId = $("#checkId").val();
		
		if(checkId == null || checkId == '' ){
			alert("???????????? ????????????.");
			textClear();
		}else{
			var form = document.getElementById('pagingForm');
			var page = document.getElementById('page');
			page.value = currentPage;
			form.submit();
		}
	}
	
	function textClear(){
		$("#bookinfo_book_nm").val('');
		$("#searchTextField").val('');
		$("#bookinfo_author").val('');
		$("#bookinfo_publisher").val('');
		$("#advanced_start_date").val('');
		$("#advanced_end_date").val('');
		$("#bookinfo_isbn").val('');
		$('#bookinfo_category option:eq(0)').attr('selected', 'selected');
		$('#bookinfo_division option:eq(0)').attr('selected', 'selected');
	}
</script>


<body ng-app="myapp" ng-controller="BookController">
	<!-- ???????????? -->
	<%@include file="user_menu.jsp"%>

	<div class="search-form wow pulse" data-wow-delay="0.8s"
		style="text-align: center; margin: 10px">
		<span>????????????</span>
		<input type="text" class="" id="searchTextField" size="40"> 
		<input type="button" class="navbar-btn nav-button login" id="searchBtn" value="Search">
		<span><a id="advanced_search" class="advanced_search"
			style="color: black; font-size: 13px;">????????????</a></span>
		<div id="advanced_box" style="display: none;">
			
			<form action="/book/user/search_result" method="post" id="pagingForm">
				<input type="hidden" name="page" id="page" />
				<table style="width: 500px; margin: auto;">
					<tr>
						<td>??????</td>
						<td><input type="text" id="bookinfo_book_nm" name="bookinfo_book_nm" value="${paramMap.bookInfo.bookinfo_book_nm}" size="46"></td>
					</tr>
					<tr>
						<td>??????</td>
						<td><input type="text" id="bookinfo_author" name="bookinfo_author" value="${paramMap.bookInfo.bookinfo_author}" size="46"></td>
					</tr>
					<tr>
						<td>?????????</td>
						<td><input type="text" id="bookinfo_publisher" name="bookinfo_publisher" value="${paramMap.bookInfo.bookinfo_publisher}" size="46"></td>
					</tr>
					<tr>
						<td>?????????</td>
						<td><input type="text" id="advanced_start_date" name="advanced_start_date" size="20" value="${paramMap.advanced_start_date}"  readonly="readonly">
							~ <input type="text" id="advanced_end_date" name="advanced_end_date" size="20" value="${paramMap.advanced_end_date}"  readonly="readonly"></td>
					</tr>
					<tr>
						<td>ISBN</td>
						<td><input type="text" id="bookinfo_isbn" name="bookinfo_isbn" value="${paramMap.bookInfo.bookinfo_isbn}" size="46"></td>
					</tr>
					<tr>
						<td>?????????</td>
						<td colspan="2">
							<select name="bookinfo_category" id="bookinfo_category">
								<option value="0">??????</option>
							</select>
							<input type="hidden" id="bookinfo_category_hidden" value="${paramMap.bookInfo.bookinfo_category}">
						</td>
					</tr>
					
					<tr>
						<td>?????????</td>
						<td colspan="2">
							<select name="bookinfo_division" id="bookinfo_division">
								<option value="0">??????</option>
							</select>
							<input type="hidden" id="bookinfo_division_hidden" value="${paramMap.bookInfo.bookinfo_division}">
						</td>
					</tr>
					<tr>
						<td></td>
						<td style="text-align: end;">
						<input type="button" id="advanced_submit" onclick="pagingFormSubmit(1)" value="??????">
						<input type="button" id="advanced_cancel" value="??????">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	
	<div style="padding-left:100px;padding-right:100px;">
		<div id="recommended_list" class="row fh5co-post-entry">
			
		</div>
	</div>
	
	
	
	<div class="container-fluid">
		<div class="row fh5co-post-entry">
			<c:choose>
				<c:when test="${empty resultList}">
					<div class="text-center">
						<h1>?????? ????????? ????????????.</h1>
					</div>				
				</c:when>
				<c:otherwise>
					<c:forEach var="data" items="${resultList }" varStatus="status">
						<article
							class="col-lg-2-5 col-md-2-5 col-sm-2-5 col-xs-6 col-xxs-12 animate-box">
							<figure>
								<a href="#"><img	src="/file_download?origin=${data.BOARD_FILE_ORIGIN }&saved=${data.BOARD_FILE_SAVED }&path=/edu/book/bookinfo/" alt="Image" class="img-responsive"></a>
							</figure>
							<span class="fh5co-meta"><a href="#"><code value="${data.BOOKINFO_CATEGORY }"></code> | <code value="${data.BOOKINFO_DIVISION }"></code></a></span>
							<h3 class="fh5co-article-title">
								<a href="#">${data.BOOKINFO_BOOK_NM }</a>
							</h3>
							<span class="fh5co-meta fh5co-date">${data.BOOKINFO_AUTHOR } | ${data.BOOKINFO_PUBLISHER }</span>
						</article>
						<c:if test="${status.count%5 == 0}">
							<div	class="clearfix visible-lg-block visible-md-block visible-sm-block visible-xs-block"></div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	
	<c:if test="${not empty resultList}">
		<div class="text-center" id="navigator">
		<!-- ????????? ?????? ?????? -->                      
			<a href="javascript:pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})">?????? </a> &nbsp;&nbsp;
			<a href="javascript:pagingFormSubmit(${navi.currentPage - 1})">???</a> &nbsp;&nbsp;
		
			<c:forEach var="counter" begin="${navi.startPageGroup}" end="${navi.endPageGroup}"> 
				<c:if test="${counter == navi.currentPage}"><b></c:if>
					<a href="javascript:pagingFormSubmit(${counter})">${counter}</a>&nbsp;
				<c:if test="${counter == navi.currentPage}"></b></c:if>
			</c:forEach>
			&nbsp;&nbsp;
			<a href="javascript:pagingFormSubmit(${navi.currentPage + 1})">???</a> &nbsp;&nbsp;
			<a href="javascript:pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})">??????</a>
		</div>				
	</c:if>
		
	<form action="/book/user/login" id="bookLoginForm" method="post">

		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" id="message" value="${SPRING_SECURITY_LAST_EXCEPTION.message}" /><br />
		<input type="hidden" name="user_id" id="user_id"> <br />
		<input type="hidden" name="user_pw" id="user_pw"> <br />
		
	</form>
	
	<form id="logoutForm" action="/book/user/logout" method="post" style="display:none">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>

</body>
</html>

