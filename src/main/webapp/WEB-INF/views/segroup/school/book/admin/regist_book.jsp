<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 등록</title>

<!-- BootStrap  -->
<link rel="stylesheet" type="text/css" href="/resources/segroup/school/book/admin/css/bootstrap.min.css">

<!-- Animation library for notifications   -->
<link href="/resources/segroup/school/book/admin/css/animate.min.css" rel="stylesheet" />

<!--  Paper Dashboard core CSS    -->
<link href="/resources/segroup/school/book/admin/css/paper-dashboard.css" rel="stylesheet" />

<!--  CSS for Demo Purpose, don't include it in your project     -->
<link href="/resources/segroup/school/book/admin/css/demo.css" rel="stylesheet" />

<!--  Fonts and icons     -->
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
<link href="/resources/segroup/school/book/admin/css/themify-icons.css" rel="stylesheet">
	
<!-- Jquery  -->
<script src="/resources/segroup/js/jquery-3.1.1.js"></script>

<!-- Angular  -->
<script src="/resources/segroup/js/angular.min.js"></script>

<script>
	
	var myApp = angular.module('myapp', []);
	myApp.directive('code', ['$http',function($http){
		return {
			restrict: "E",
			replace: true,
			scope : {
				value : '@'
			},
			controller: function ($scope, $element, $attrs) {
				console.log($attrs.value);
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
			,template: "<span>{{filterParams}}</span>"
		}
	}]);
	
	myApp.controller('MainController', ['$scope','$http','$compile', function($scope, $http, $compile) {
		
		$scope.plusBookCnt = function(){
			var labelClass = $(".labelDv");
			var labelIndex = labelClass.length;
			var nextIndex = labelIndex+1
 			var content = '<div class="labelDv">';
				content += 'label : <input type="text" id="bookLabel'+ nextIndex +'" name="bookLabels" /> <br />';
				content += '</div>';

			$(".labelDv:last").append(content);
			$("#bookCnt").val(nextIndex);	
		}
		
		$scope.minusBookCnt = function(){
			var labelClass = $(".labelDv");
			var labelIndex = labelClass.length;
			if(labelIndex == 1) return;
			
			$(".labelDv:last").remove();
			$("#bookCnt").val(labelIndex-1);
		}
		
		$scope.isbnSearch = function(){
			var isbn = $('#bookinfo_isbn').val();
			if(isbn == null || isbn == '')
				return;
			
			$http({
				method: 'GET',
				url: '/book/admin/search_by_isbn_on_sesbook',
				responseType: 'json',
				params : {
					isbn : isbn
				}
			}).then(function successCallback(response) {
				$scope.results = response.data;// 뭐하는 애지
				
				if(response.data == null) {
					alert("등록 되지 않은 도서 입니다.");
			        $('#bookinfo_book_nm').val("");
			        $('#bookinfo_author').val("");
			        $('#bookinfo_publisher').val("");
			        $('#bookinfo_published_dt').val("");
			        $('#bookinfo_category').val("");
			        $('#bookinfo_division').val("");
					return;
				}
		        
		        $('#bookinfo_book_nm').val(response.data.bookinfo_book_nm);
		        $('#bookinfo_author').val(response.data.bookinfo_author);
		        $('#bookinfo_publisher').val(response.data.bookinfo_publisher);
		        $('#bookinfo_published_dt').val(response.data.bookinfo_published_dt);
		       
		   		var categoryHtml = "<code value=" + "'" + response.data.bookinfo_category +"'" + "></code>";
				$('#categoryTd').html($compile(categoryHtml)($scope));	
				
		   		var divisionHtml = "<code value=" + "'" + response.data.bookinfo_division +"'" + "></code>";
				$('#divisionTd').html($compile(divisionHtml)($scope));	
				
				$("#imgDiv").html(' <img onload="resizeImg(this, 170, 130);" alt="" ' 
								+ ' src="/book/utility/download_bookinfo_image?origin='+response.data.board_file_origin+'&saved='+response.data.board_file_saved+'">');
				
			}, function errorCallback(response) {
				
			});	
		}
	}]);
	
	function resizeImg(img, height, width) {
	    img.height = height;
	    img.width = width;
	}
	
	function submitCheck(){

		var bookInfoISBN = $('#bookinfo_isbn').val();
		var bookInfoNm = $('#bookinfo_book_nm').val();
		var bookInfoAuth = $('#bookinfo_author').val();
		var bookInfoPublisher = $('#bookinfo_publisher').val();
		var bookInfoPublishedDt = $('#bookinfo_published_dt').val();
		
		if(		bookInfoISBN == null || bookInfoISBN == '' ||
				bookInfoNm == null || bookInfoNm == '' ||
				bookInfoAuth == null || bookInfoAuth == '' ||
				bookInfoPublisher == null || bookInfoPublisher == '' ||
				bookInfoPublishedDt == null || bookInfoPublishedDt == '' ){
			alert("추가 하기 전 검색을 먼저 해주세용~")
			return false;
		}
		
		if($(".labelDv").length < 1) {
			alert("1권 이상 등록 하셔야 합니다.");
			return false;
		}
		
		for(var index = 0; index < $(".labelDv").length; index++){
			var value = $("#bookLabel"+(index*1+1)).val();
			if(value == null || value == ''){
				alert("추가 할 책의 라벨을 모두 입력 해주세요.");
				return false;
			}
		}
		
		$('#isbn').val( $('#bookinfo_isbn').val() );
		return true;	
	}
	
</script>

</head>
<body ng-app="myapp" ng-controller="MainController">
<h1>도서 추가</h1>


<table>
	 <tr>
		<td>ISBN</td>
		<td><input type="text" name="bookinfo_isbn" id="bookinfo_isbn"></td>
		<td><input type="button" ng-click="isbnSearch()" id="isbnSearch" value = "검색"></td>
	</tr>
		
	<tr>
		<td>이미지</td>
		<td colspan="2"><div id="imgDiv"></div></td>
	</tr>

  	<tr>
		<td>대분류</td>
		<td colspan="2" id="categoryTd"></td>
	</tr>
	
	<tr>
		<td>소분류</td>
		<td colspan="2" id="divisionTd"></td>
	</tr>

  	<tr>
		<td>책 제목</td>
		<td colspan="2"><input type="text" name="bookinfo_book_nm" id="bookinfo_book_nm" readonly="readonly"></td>
	</tr>
		
	<tr>
		<td>저자</td>
		<td colspan="2"><input type="text" name="bookinfo_author" id="bookinfo_author" readonly="readonly"></td>
	</tr>
		
	<tr>
		<td>출판사</td>
		<td colspan="2"><input type="text" name="bookinfo_publisher" id="bookinfo_publisher" readonly="readonly"></td>
	</tr>
		
	<tr>
		<td>출판일</td>
		<td colspan="2"><input type="text" name="bookinfo_published_dt" id="bookinfo_published_dt" readonly="readonly"></td>
	</tr>
		

	
</table>
	
<form action="/book/admin/regist_book" method="post">
	<input type="hidden" id="isbn" name="isbn">
	추가 할 수량 : <span>
				<input type="text" readonly="readonly" id="bookCnt" name="bookCnt" value="1">
			   </span>
	<span id="BookCntBtns">
		<input type="button" ng-click="plusBookCnt()" value="+" />
		<input type="button" ng-click="minusBookCnt()" value="-" /><br />
	</span>
	<div class="labelDv">
		label : <input type="text" id="bookLabel1" name="bookLabels" /> <br />
	</div>
	
	<input type="submit" value="추가" onclick="return submitCheck();">
</form>


</body>
</html>