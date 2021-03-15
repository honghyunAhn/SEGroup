<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 
<!-- bxSlider CSS file -->
<link
	href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 --> 
 
<style>
#curSelect{width:20%;}
.gisu_crc_selectGroup{margin-top:20px;margin-left:330px;}
div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
.crc_submit{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
</style>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">

//초기화 버튼을 눌렀을 경우 사용 되는 함수
function subbanner_initialization() {
	$.ajax({
		type : 'POST',
		url : 'subbanner_ini',
		success : function() {
			alert('전체 비공개로 변경 되었습니다.');
			location.reload();
		}
	});
}

function order(){
	
	var subbanner_seq_array = new Array();
	
	//drag and drop으로 순서가 바뀐 list에 순서대로 name을 부여하는 함수
	$('#sortable td').each(function(index, element){
		
		var image_name = "subbanner_list[" + index + "].edu_sub_ban_file";
		var naming = $(this).find("*:first-child").attr("name", image_name);
		
		// 순서 변경 후 위에서 부터 차례대로 seq를 받아옴
		subbanner_seq_array[index] = $('#shown_list tr td div:eq(' + index + ')' + ' input').val();
	});
	
	jQuery.ajaxSettings.traditional = true;

	$.ajax({
		type : 'POST'
		, url : 'subbanner_od_udt'
		, data : {
			subbanner_seq_array : subbanner_seq_array
		}
		, success : function() {
			alert('순서가 변경되었습니다.');
			location.reload();
		}
		, error : function (e) {
			console.log(e);
		}
	
	});
}

$( function() {
    $( "#sortable" ).sortable();
    $( "#sortable" ).disableSelection();
  } );

	var myApp = angular.module('myapp', []);
	
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
					console.log(response);
				});
			}
			,template: "<option>{{filterParams}}</option>"
		}
	}]);
	
	function getThumbnailPrivew(input, targetId) {
	    // 필드 채워지면
	    if($(input).val() != ""){
	        // 확장자 체크
	        var ext = $(input).val().split(".").pop().toLowerCase();
	        if($.inArray(ext, ["bmp","gif","jpg","jpeg","png"]) == -1){
	            alert("bmp, gif, jpg, jpeg, png 파일만 업로드 해주세요.");
	            $(input).val("");
	            return;
	        }
	        // 용량 체크
	        var fileSize = input.files[0].size;
	        var maxSize = 1024 * 1024 * 10;
	        if(fileSize > maxSize){
	            alert("파일용량 1MB을 초과했습니다.");
	            $(input).val("");
	        }
	        // 가로,세로 길이
	        var file = input.files[0];
	        var _URL = window.URL || window.webkitURL;
	        var img = new Image();
	        img.src = _URL.createObjectURL(file);
	        img.onload = function() {
	            $(input).next().next().remove();
	            var add_tag = "<p name='tmp_"+targetId+"'>"+img.width+" x "+img.height+"</p>";
	            $(input).closest("td").append(add_tag);
	        }
	    }
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            var element = window.document.getElementById(targetId);
	            element.setAttribute("src", e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	// 서브 배너의 등록, 삭제 버튼을 눌렀을 경우 사용 되는 함수
	function subbanner_shown(edu_sub_ban_seq, edu_sub_ban_eps) {
		$.ajax({
			type : 'POST',
			url : 'subbanner_od',
			data : {
				edu_sub_ban_seq : edu_sub_ban_seq
				, edu_sub_ban_eps : edu_sub_ban_eps
			},
			success : function() {
				location.reload();
			}
		});
		
	}
</script>
</head>
<body ng-app="myapp">
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>서브 배너 관리</h2>
</div>

<div class="custom_div">
	<h3 align="right"><a href= "/edu/admin/subbanner_insert_form">서브 배너 만들기</a></h3>
	<br><br>

	<table id="shown_list" class="table">
		<thead>
			<tr>
				<th><h4 align="center">공개 서브 배너</h4></th>
			</tr>
		</thead>
		
			<tbody id="sortable">
			<c:forEach var="data" items="${subbanner_shown_list}" varStatus="status">		
				<tr>
					<td>
						<div>
							<input type="hidden" value="${data.edu_sub_ban_seq}">
							<img src="${data.img_full_path}" width="100px" height="100px">&nbsp;&nbsp;
							<a href="/edu/admin/subbanner_update_form?edu_sub_ban_seq=${data.edu_sub_ban_seq}">${data.edu_sub_ban_nm}</a>
							<button onclick="subbanner_shown('${data.edu_sub_ban_seq}', '${data.edu_sub_ban_eps}')">비공개로 전환</button>
						</div>
					</td>
				</tr>	
			</c:forEach>
			</tbody>
		
	</table>
	<button onclick="order()">공개 서브배너 순서 확정버튼</button>
	<br><br>
	
	<table class="table">
		<thead>
			<tr>
				<th><h4 align="center">비공개 서브 배너</h4></th>
			</tr>
		</thead>
		<tbody>
			
			<c:forEach var="data" items="${subbanner_unshown_list}" varStatus="status">		
				<tr>
					<td>
						<img src="${data.img_full_path}" width="100px" height="100px">&nbsp;&nbsp;
						<a href="/edu/admin/subbanner_update_form?edu_sub_ban_seq=${data.edu_sub_ban_seq}">${data.edu_sub_ban_nm}</a>
						<button onclick="subbanner_shown('${data.edu_sub_ban_seq}', '${data.edu_sub_ban_eps}')">공개로 전환</button>
					</td>
				</tr>	
			</c:forEach>
			
		</tbody>
	</table>
	<button onclick="subbanner_initialization()">전체 비공개로 전환</button>
</div>
</body>
</html>