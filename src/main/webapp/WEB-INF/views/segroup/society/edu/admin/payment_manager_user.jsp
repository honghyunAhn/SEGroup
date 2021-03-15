<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style>

</style>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">

<!-- 페이징관련 css 시작 -->
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 -->


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
$(function() {
	$("th.sort").click(sort);
	$("#curSelect").change(function(){
		var crc_seq = $(this).val();
		
	    if(crc_seq == 0){
	    	//초기화
	    	var option = "<option value=''>선택</option>";
	    	$("#gisuSelect").html(option);
	    }else{
	    	//초기화 후 ajax
	    	$.ajax({
				type:"POST",						
				url:"/edu/admin/search_cur_gisu",	
				data:{
					'crc_seq' : crc_seq,
				},
				success:function(data){	
					var option = "<option value=''>선택</option>";
					$.each(data,function(index,item){
						option +='<option value="'+item.gisu_seq+'">'+item.gisu_crc_nm+'</option>';
					})
					$("#gisuSelect").html(option);
				},
				error: function(e){
					console.log(e);
				}
			});
	    }
	    
	});
	
	
	$("#gisuSelect").change(function(){
		var gisu_seq = $(this).val();
		
	    if(gisu_seq == 0){
	    	//초기화
	    	var option = "<option value=''>선택</option>";
	    	$("#orderSelect").html(option);
	    }else{
	    	//초기화 후 ajax
	    	$.ajax({
				type:"POST",						
				url:"/edu/admin/search_cur_order",	
				data:{
					'gisu_seq' : gisu_seq,
				},
				success:function(data){	
					var option = "<option value=''>선택</option><option value=''>전체</option>";
					$.each(data,function(index,item){
						option +='<option value="'+item.pay_crc_payorder+'">'+(item.pay_crc_payorder+1)+'회</option>';
					})
					$("#orderSelect").html(option);
				},
				error: function(e){
					console.log(e);
				}
			});
	    }
	    
	});
	
});
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
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		$scope.doc_change = function(doc){
			var app_rt_doc = $(".docSelect option:selected").val();
			var app_rt_seq = angular.element(doc).prevAll(".app_rt_seq").val();
			
			$http({
				method: 'POST',
				url: "/edu/admin/apply_result_update",
				params : {
					app_rt_doc : app_rt_doc,
					app_rt_seq : app_rt_seq
				}
			}).then(function successCallback(response) {
				alert("서류 결과를 변경 하였습니다.");
			}, function errorCallback(response) {
				console.log(response);
			});
			
		};
		
		$scope.itv_change = function(itv){
			var app_rt_itv = $(".itvSelect option:selected").val();
			var app_rt_seq = angular.element(itv).prevAll(".app_rt_seq").val();
			
			$http({
				method: 'POST',
				url: "/edu/admin/apply_result_update",
				params : {
					app_rt_itv : app_rt_itv,
					app_rt_seq : app_rt_seq
				}
			}).then(function successCallback(response) {
				alert("면접 결과를 변경 하였습니다.");
			}, function errorCallback(response) {
				console.log(response);
			});
		};
		
		/* $scope.search = function(){
			alert(curPage);
			var gisu_seq = $("#gisuSelect option:selected").val();
			var gisu_order= $("#orderSelect option:selected").val();
			var name = $("#name").val();
			$http({
				method: 'POST',
				url: "/edu/admin/search_paid_list",
				params : {
					"gisu_seq" : gisu_seq,
					"gisu_order" : gisu_order,
					"name" : name
				}
			}).then(function successCallback(response) {
				printList(response);					
			}, function errorCallback(response) {
				console.log(response);
			});
		} */
	}]);

function search(curPage){
	var gisu_seq = $("#gisuSelect option:selected").val();
	var gisu_order= $("#orderSelect option:selected").val();
	var name = $("#name").val();
    var pageCount = $("#pageSelect option:selected").val();
	
	$.ajax({
		url: "/edu/admin/search_paid_list",
		method: "POST",
		data:{
			"gisu_seq" : gisu_seq,
			"gisu_order" : gisu_order,
			"name" : name,
			"curPage" : curPage,
			"pageCount": pageCount
		}, success: function(data){
			printList(data);
		}
	})
}
function confirmPayDelete(pay_user_seq){
	if(confirm("결제요청을 삭제처리 하시겠습니까?") == false) return false;
	var gisu_seq = $("#gisuSelect option:selected").val();
	var gisu_order= $("#orderSelect option:selected").val();
	var name = $("#name").val();
    var pageCount = $("#pageSelect option:selected").val();
    var curPage = $("#cur_page_btn").val();
    var sort_param = $("#sorted_param").val();
    var sort_order = $("#sorted_order").val();
	$.ajax({
		url: "/edu/admin/delete_pay_info",
		type: "POST",
		data: {
			'pay_user_seq'	: pay_user_seq,
			'gisu_seq'		: gisu_seq,
			'gisu_order'	: gisu_order,
			'name'			: name,
			'pageCount'		: pageCount,
			'curPage'		: curPage,
			'sort_param'	: sort_param,
			'sort_order'	: sort_order
		},
		success:function(data){
			printList(data);
		},
		error:function(e){
			
		}
	});
}

function confirmPayRefund(pay_user_seq){
	if(confirm("환불처리 하시겠습니까? 해당 결제내역은 임시로 유저환불관리 페이지로 이동되며 해당 수강생에게 환불정보 추가입력을 요청하셔야 합니다.") == false) return false;
	var gisu_seq = $("#gisuSelect option:selected").val();
	var gisu_order= $("#orderSelect option:selected").val();
	var name = $("#name").val();
    var pageCount = $("#pageSelect option:selected").val();
    var curPage = $("#cur_page_btn").val();
    var sort_param = $("#sorted_param").val();
    var sort_order = $("#sorted_order").val();
    
	$.ajax({
		url: "/edu/admin/insert_temp_refund",
		type: "POST",
		data: {
			'pay_user_seq'	: pay_user_seq,
			'gisu_seq'		: gisu_seq,
			'gisu_order'	: gisu_order,
			'name'			: name,
			'pageCount'		: pageCount,
			'curPage'		: curPage,
			'sort_param'	: sort_param,
			'sort_order'	: sort_order
		},
		success:function(data){
			printList(data);
		},
		error:function(e){
			
		}
	});
}

function printList(map){
	//ajax호출과 angular호출의 경우를 구분
	var context = '';
	$.each(map.resultList,function(index,item){
		context += '<tr>';
		<!--페이징 역순 수정 해야 할 부분--!>
		context += '<td>'+(index+1)+'</td>';
		context += '<td>'+item.user_nm+'</td>';
		context += '<td>'+item.user_id+'</td>';
		context += '<td>'+item.gisu_crc_nm+'</td>';
		context += '<td>'+item.gisu_num+'기</td>';
		context += '<td>'+(item.pay_crc_payorder+1)+'회</td>';
		context += '<td>'+item.pay_crc_amount+'원</td>';
		context += '<td>'+item.pay_user_method+'</td>';
		if(item.pay_user_status==0){
			context += '<td>결제대기</td><td><a href="javascript:confirmPayDelete('+item.pay_user_seq+')"><font color="red">관리자 결제취소</font></a></td>';
		}else if(item.pay_refund_status==0){
			context += '<td><font color="blue">결제완료</font></td><td><font color="purple">사용자 환불요청</font></td>';
		}else{
			context += '<td><font color="blue">결제완료</font></td><td><a href="javascript:confirmPayRefund('+item.pay_user_seq+')"><font color="red">관리자 환불처리</font></a></td>';
		}
		context += '</tr>';
	});
	$("#search_data").html(context);
	
	context = '';
	context += '<div class="pagination_con">';
	context += '<span id="page"style="display: inline; margin:auto; display:table; ">';
	context += '<h4><ul><li><ol>';
	if(map.adminPager.curBlock > 1){
		context += '<li><input type="button" onclick="search(&quot;1&quot;)" name="" value="<<"></li>';
	}
	if(map.adminPager.curBlock > 1){
		context += '<li><input type="button" onclick="search(&quot;'+map.adminPager.prevPage+'&quot;)" name="" value="<"></li>';
	}
	for(var i=map.adminPager.blockBegin; i<=map.adminPager.blockEnd; i++){
		if(i == map.adminPager.curPage){
			context += '<li><input id="cur_page_btn" type="button" style="color:red"name="" value="'+i+'"></li>';
		}else{
			context += '<li><input type="button" onclick="search(&quot;'+i+'&quot;)" name="" value="'+i+'"></li>';
		}
	}
	if(map.adminPager.curBlock <= map.adminPager.totBlock){
		context += '<li><input type="button" onclick="search(&quot;'+map.adminPager.nextPage+'&quot;)" name="" value=">"></li>';
	}
	if(map.adminPager.curPage <= map.adminPager.totPage){
		context += '<li><input type="button" onclick="search(&quot;'+map.adminPager.totPage+'&quot;)" name="" value=">>"></li>';
	}
	context += '</ol></h4></li></ul></span></div>';
	
	$(".pagination_wrap").empty();
	$(".pagination_wrap").html(context);
	//$(".pagination_wrap").html($compile(context)($scope));
	
	// pageCountList 삽입
	context = '';
	context += '<option value="10">10개씩</option>';
	for(var i=0; i<map.adminPager.pageCountList.length; i++){
		if(map.adminPager.pageCountList[i] == map.pageCount){
			context += '<option value="'+map.adminPager.pageCountList[i]+'" selected>'+map.adminPager.pageCountList[i]+'개씩</option>';
		}else{
			context += '<option value="'+map.adminPager.pageCountList[i]+'">'+map.adminPager.pageCountList[i]+'개씩</option>';
		}
	}
	$("#pageSelect").html(context);
	//$("#pageSelect").html($compile(context)($scope));
	
}

function sort(){
	var sortColumn = $(this).text().trim();
	var sortOrder = $(this).find('img').attr('class');
    var pageCount = $("#pageSelect option:selected").val();
    var curPage = $("#cur_page_btn").val();
	var gisu_seq = $("#gisuSelect option:selected").val();
	var gisu_order= $("#orderSelect option:selected").val();
	var name = $("#name").val();
    
	if(sortOrder == 'desc'){
		$(this).find('img').attr('class', 'asc');
		$(this).find('img').attr('src', '/resources/segroup/society/edu/image/main/triangle_up.png;')
		sortOrder = 'asc';
	} else {
		$(this).find('img').attr('class', 'desc');
		$(this).find('img').attr('src', '/resources/segroup/society/edu/image/main/triangle_down.png;')
		sortOrder = 'desc';	
	}
	
	var sort_param = '';
	if(sortColumn == '결제기수') sort_param = 'gisu_num';
	else if(sortColumn == '결제방법') sort_param = 'pay_user_method';
	else if(sortColumn == '결제비용') sort_param = 'pay_crc_amount';
	else if(sortColumn == '분납번호') sort_param = 'pay_crc_payorder';
	else if(sortColumn == '결제상태') sort_param = 'pay_user_status';
	
	//정렬데이터 최신화
	$("#sorted_param").val(sort_param);
	$("#sorted_order").val(sortOrder);
	
    var gisu_seq = $("#gisuSelect option:selected").val();
    var gisu_order= $("#orderSelect option:selected").val();
    var search_name = $("#searchName").val();
	$.ajax({
		type:"POST",                  
		url:"/edu/admin/search_paid_list",   
		data:{
			'sort_param'	: sort_param,
			'sort_order'	: sortOrder,
			'gisu_seq'		: gisu_seq,
			'gisu_order'	: gisu_order,
			'name'			: name,
			'pageCount'		: pageCount,
			'curPage'		: curPage
        },
        success:function(data){   
			printList(data);
        },
        error: function(e){
           console.log(e);
        }
	});
}

</script>
</head>
<body ng-app="myapp" ng-controller="AdminController">
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>유저 결제 관리</h2>
	<h5>결제 관리 페이지&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="payment_manager_user">유저 결제 관리</a></h5>
</div>

<div class="custom_div">

	<table class="search_box">
		<tr>
			<th>과정명으로 검색</th>
			<td>
				<select id="curSelect">
					<option value="">선택</option>
					<c:forEach var="data" items="${seaCurList }">
						<option value="${data.crc_seq }">${data.crc_nm }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="gisuSelect">
					<option value="">과정기수를 선택하세요</option>
				</select>
			</td>
			<td>
				<!-- <select id="orderSelect" onchange="angular.element(this).scope().search(this)"> -->
				<select id="orderSelect" onchange="search();">
					<option value="">분납차수를 선택하세요</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>이름으로 검색</th>
			<td><input type="text" id="name"></td>
			<!-- <td class="td_search" colspan="2"><button class="btn_search" ng-click="search()">검색</button> -->
			<td class="td_search" colspan="2"><button class="btn_search" onclick="search()">검색</button>
		</tr>
	</table>
	<!-- <select id="pageSelect" onchange="angular.element(this).scope().search(this)"> -->
	<select id="pageSelect" onchange="search()">
		<option value="10">10개씩</option>
	</select>
	<table class="table">
		<thead>
			<tr>
				<th>No</th>
				<th>결제자명</th>
				<th>결제자ID</th>
				<th>결제과정명</th>
				<th class="sort">결제기수&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
				<th class="sort">분납번호&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
				<th class="sort">결제비용&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
				<th class="sort">결제방법&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
				<th class="sort">결제상태&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody id="search_data">

		</tbody>
	</table>
</div>
<div class="pagination_wrap">
</div>
<div id="sorter" style="display: none;">
	<input type="hidden" id="sorted_param" value="">
	<input type="hidden" id="sorted_order" value="">
</div>
</body>
</html>