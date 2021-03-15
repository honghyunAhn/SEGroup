<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="list of books, which I have interest in" />
<meta name="keywords" content="SES Library, user, book list, interest" />
<meta name="author" content="이정식" />

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon" href="favicon.ico">
<!-- Google Fonts -->
<!-- <link href='http://fonts.googleapis.com/css?family=Playfair+Display:400,700,400italic|Roboto:400,300,700' rel='stylesheet' type='text/css'> -->
<!-- Animate -->
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/animate.css'/>">
<!-- Icomoon -->
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/icomoon.css'/>">
<!-- Bootstrap  -->
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/bootstrap.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/segroup/school/book/user/css/style.css'/>">
<!-- Modernizr JS -->
<script src="<c:url value='/resources/segroup/school/book/user/js/modernizr-2.6.2.min.js'/>"></script>
<!-- jQuery -->
<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.min.js'/>"></script>
<!-- jQuery Easing -->
<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.easing.1.3.js'/>"></script>
<!-- Bootstrap -->
<script src="<c:url value='/resources/segroup/school/book/user/js/bootstrap.min.js'/>"></script>
<!-- Waypoints -->
<script src="<c:url value='/resources/segroup/school/book/user/js/jquery.waypoints.min.js'/>"></script>
<!-- Main JS -->
<script src="<c:url value='/resources/segroup/school/book/user/js/main.js'/>"></script>
<script>
function isSelected(selectedIsbn) {
	// user_request.jsp로 되돌아갈 값
	/// searchIsbn.jsp에서 검색한 결과
	// purchase_req_isbn
	/// bookinfo_isbn	
	// purchase_req_book_nm
	/// bookinfo_book_nm
	// purchase_req_publisher
	/// bookinfo_publisher
	// purchase_req_author
	/// bookinfo_author
	
	$.ajax({
		type: "GET"
		, url:"/book/utility/byIsbn"
		, data: { keyword: selectedIsbn }
		, error : function(){
            alert('error!');
        }
		, success:function(result){
			$.each(result, function(key, data) {				
				var title = data.bookinfo_book_nm;
				//alert("title: "+title);
				var author = data.bookinfo_author;
				//alert("author: "+author);
				var publisher = data.bookinfo_publisher;
				//alert("publisher: "+publisher);
				var isbn = data.bookinfo_isbn;
				//alert("isbn: "+isbn);
				setOriginalPage(title, author, publisher, isbn);
			});
		}
	});	
}

function setOriginalPage(title, author, publisher, isbn) {
	opener.document.getElementById("purchase_req_book_nm").value = title;
	opener.document.getElementById("purchase_req_author").value = author;
	opener.document.getElementById("purchase_req_publisher").value = publisher;
	opener.document.getElementById("purchase_req_isbn").value = isbn;
	this.close();
}

$(function(){
	
	$("#search").on('click', function(){
		var searchTitle = $("#searchTitle").val();
		if (searchTitle.length<1) {
			alert('검색 조건 입력하세요!');
			return;
		}
		$.ajax({
			type: "GET"
			, url:"/book/utility/byTitle"
			, data: { keyword: searchTitle }
			, error : function(){
                alert('error!');
            }
			, success:function(data){
				$("#searchTitle").val('');
								
				var bookList = '<br><br><div class="container">';
				bookList += '<table class="table table-hover text-center"><tr>';
				bookList += '<th><div class="text-center">bookinfo_isbn</div></th>';				
				bookList += '<th><div class="text-center">bookinfo_book_nm</div></th>';
				bookList += '<th><div class="text-center">bookinfo_publisher</div></th>';
				bookList += '<th><div class="text-center">bookinfo_author</div></th>';
				
				if (data == null) {
					bookList += '<tr><td colspan="9">Nothing!</td></tr>';
				} else {

					$.each(data, function(key, value) {
						bookList += '<tr><td id="isbn'+(key+1)+'">' + value.bookinfo_isbn + '</td>';
						bookList += '<td id="title'+(key+1)+'">' + value.bookinfo_book_nm + '</td>';
						bookList += '<td id="publisher'+(key+1)+'">' + value.bookinfo_publisher + '</td>';
						bookList += '<td id="author'+(key+1)+'">' + value.bookinfo_author + '</td>';
						bookList += '<td><input type="button" class="btn btn-default" onClick="return isSelected('+ value.bookinfo_isbn +');" value="THIS!" /></td></tr>';
					});
				}
				bookList += '</table>';
				$("#result").html(bookList) ;
			}
		});
	});
	 
	$("#select").on('click', function(){ isSelected(); });
});

</script>
</head>
<body>

	<h1 id="fh5co-logo">ISBN 검색</h1>
		
		<div class="form-group">
			<div class="col-sm-8">
				<input type="text" class="form-control" id="searchTitle" name="searchTitle" />
			</div>
			<div class="col-sm-3">
				<input type="button" class="btn btn-default form-control" id="search" value="search" />
			</div>
		</div>
	
	<div id="result"></div>

	</body>
</html>