<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 정보 등록</title>

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

<script type="text/javascript">

	$( document ).ready(function() {
		
		
		$("#bookInfoimg").change(function(){
			var val = $(this).val();

			if(val == ""){
			    $(this).val('');
	        	$("#imgDiv").empty();
	       		return;
			}else if(isImage(val)){
				photoAjax();
			}else{
				$(this).val('');
	    		$("#imgDiv").empty();
	            alert("이미지 파일이 아닙니다. gif, jpg, png 형식만 가능 합니다.");
			}
		});
		
		 
		 $('#isbnSearch').click(function(){
			var isbn = $('#bookinfo_isbn').val();
			if(isbn == null || isbn == '')
				return;
			
			$.ajax({
		        type : 'GET',
		        url : '/book/utility/byIsbn',
		        data : {'keyword' : isbn},
		        
		        success : function(resultArr) {
		        	var result = resultArr[0];
		        	var bookInfoNm = result.bookinfo_book_nm;
		        	var bookInfoAuth = result.bookinfo_author;
		        	var bookInfoPublisher = result.bookinfo_publisher;
		        	var bookInfoPublishedDt = result.bookinfo_published_dt;
		        	
		        	$('#bookinfo_book_nm').val(bookInfoNm);
		        	$('#bookinfo_author').val(bookInfoAuth);
		        	$('#bookinfo_publisher').val(bookInfoPublisher);
		        	
		        	var tmpYear = bookInfoPublishedDt.substr(0, 4);
		        	var tmpMonth = bookInfoPublishedDt.substr(4, 2);
		        	var tmpDate = bookInfoPublishedDt.substr(6, 2);
		        	
		        	$('#bookinfo_published_dt').val(tmpYear + '-' + tmpMonth + '-' + tmpDate);
		        },
		        
		        error: function(request, status, error) {
		        	alert(error);
		        }
		    }); 
			
		 });
		
		
	});
	
	var myApp = angular.module('myapp', []);
	 
	myApp.controller('MainController', ['$scope','$http','$compile', function($scope, $http, $compile) {
		$http({
			method: 'GET',
			url: '/book/utility/get_category',
			responseType: 'json',

		}).then(function successCallback(response) {
			$scope.results = response.data;// 뭐하는 애지
			
			var content = '';
			for(var i = 0; i < response.data.length; i++){
				content += '<option selectcode value="' + response.data[i] +'"></option>';
			}
			
			$('#bookinfo_category').append($compile(content)($scope));	
			
		}, function errorCallback(response) {
		});
		
		$http({
			method: 'GET',
			url: '/book/utility/get_division',
			responseType: 'json',

		}).then(function successCallback(response) {
			$scope.results = response.data;// 뭐하는 애지
			
			var content = '';
			for(var i = 0; i < response.data.length; i++){
				content += '<option selectcode value="' + response.data[i] +'"></option>';
			}
			
			$('#bookinfo_division').append($compile(content)($scope));	
			
		}, function errorCallback(response) {
		});
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
	
	function getExtension(filename) {
	    var parts = filename.split('.');
	    return parts[parts.length - 1];
	}

	function isImage(filename) {
	    var ext = getExtension(filename);
	    switch (ext.toLowerCase()) {
	    case 'jpg':
	    case 'bmp':
	    case 'png':
	    case 'gif':
	        //etc
	        return true;
	    }
	    return false;
	}
	
	function submitCheck(){
		
		if( document.getElementById("bookInfoimg").files.length == 0 ){
		    alert("이미지를 선택 해주세요");
		    return false;
		}
		
		if( document.getElementById("bookInfoimg").files.length > 2 ){
		    alert("이미지를 하나 만 선택 해주세요");
		    return false;
		}
		
		var img = $('#bookInfoimg');
		if (!isImage(img.val())) {
			alert("이미지 파일만 업로드 할 수 있습니다.");
			return false;
        }
		
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
			alert("모든 양식을 채워 주세요.")
			return false;
		}
		
		var bookInfoCategory = $('#bookinfo_category').val();
		var bookInfoDivision = $('#bookinfo_division').val();

		if(bookInfoCategory == '선택') {
			alert("대분류를 선택 해주세요.")
			return false;
		}
		if( bookInfoDivision=='선택') {
			alert("소분류를 선택 해주세요.")
			return false;
		}
		
		return true;
	}

	function photoAjax(){
		
		var size = $("#bookInfoimg")[0].files[0].size;
		if(fileSizeCheck(size)){
			var formData = new FormData();
			formData.append("file",$("#bookInfoimg")[0].files[0]);
			
			$.ajax({
				type:"POST",						
				url:"/temporarily_upload",				
				data:formData,
				processData: false,
			    contentType: false,
				dataType:"json",				
				success:function(data){	
					$("#imgDiv").empty();
					$("#imgDiv").html('<img onload="resizeImg(this, 170, 130);" alt="" src="/temporarily_download?origin='+data.originalfile+'&saved='+data.savedfile+'">');
				},
				error: function(e){			
					console.log(e);
				}
			});
		}else{
			$("#bookInfoimg").val('');
        	$("#imgDiv").empty();
			alert("파일 사이즈는 5MB 까지 입니다.");
		}
	}
	
	function resizeImg(img, height, width) {
	    img.height = height;
	    img.width = width;
	}
	
	function fileSizeCheck(size){
		//5MB
		var maxSize = 5242880;
		var fileSize = Math.round(size);
		if(fileSize > maxSize){
			return false;
		}
		return true;
	}
	

</script>

</head>
<body ng-app="myapp" ng-controller="MainController">
<h1>도서 정보 등록</h1>

<form action="/book/admin/regist_bookinfo" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>이미지</td>
			<td><div id="imgDiv"></div></td>
			<td><input type="file" name="bookInfoimg" id="bookInfoimg" accept="image/*"></td>
		</tr>
	  
	  	<tr>
			<td>ISBN</td>
			<td><input type="text" name="bookinfo_isbn" id="bookinfo_isbn"></td>
			<td><input type="button" id="isbnSearch" value = "검색"></td>
		</tr>

	  	<tr>
			<td>대분류</td>
			<td colspan="2"><select name="bookinfo_category" id="bookinfo_category">
					<option value="선택">선택</option>
				</select></td>
		</tr>
		
		<tr>
			<td>소분류</td>
			<td colspan="2"><select name="bookinfo_division" id="bookinfo_division">
					<option value="선택">선택</option>
				</select></td>
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
		
		<tr>
			<td colspan="3"><input value="등록" type="submit" onclick="return submitCheck();"></td>
		</tr>
	
	</table>
</form>

</body>
</html>