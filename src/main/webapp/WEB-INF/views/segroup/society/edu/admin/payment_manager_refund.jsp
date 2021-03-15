<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<style>

/* td.td_memo_text{width:13%;} */
td.td_memo_btns{width:5%;}
img.img_memo_edit{display:block; margin:auto; width:50%;}
img.img_memo_submit, img.img_memo_cancel{width:45%;}
button.btn_refund{background-color: #9cf; color: white; border: none; font-size: 90%;}
input.text_memo_old{width:90%; height:40%;}
font.font_refund_done{color: purple; font-weight: bolder;}
/* div.selectGroup{display: inline-table;} */
img.desc, img.asc{width:12px;}
table.dialog{width:90%;}
table.dialog th{width:25%;text-align:left;vertical-align: top;}

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
	search(1);
	
	$("th.sort").click(sort);
   $("#curSelect").change(function(){
      var crc_seq = $(this).val();
      
       if(crc_seq == 0){
          //초기화
          var option = "<option value='0'>선택</option>";
          $("#gisuSelect").html(option);
       }else{
          //초기화 후 ajax
          $.ajax({
            type:"POST",                  
            url:"/edu/admin/search_cur_gisu",   
            data:{
               'crc_seq' : crc_seq
            },
            success:function(data){   
               var option = "<option value='0'>선택</option>";
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
          var option = "<option value='0'>선택</option>";
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
               var option = "<option value='0'>분납차수선택</option>";
                  option +='<option value="">전체</option>';
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
   /* var myApp = angular.module('myapp', []);

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
   }]); */
   
   /* myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){

	   $scope.search = function(){
         var gisu_seq = $("#gisuSelect option:selected").val();
         var gisu_order= $("#orderSelect option:selected").val();
         var search_name = $("#searchName").val();
         $http({
            method: 'POST',
            url: "/edu/admin/search_refund_list",
            params : {
               "gisu_seq" : gisu_seq,
               "gisu_order" : gisu_order,
               "search_name" : search_name
            }
         }).then(function successCallback(response) {
        	 printList(response.data);
         }, function errorCallback(response) {
            console.log(response);
         });
      }
   }]);
    */

function search(curPage){
    var gisu_seq = $("#gisuSelect option:selected").val();
    var gisu_order= $("#orderSelect option:selected").val();
    var search_name = $("#searchName").val();
    var pageCount = $("#pageSelect option:selected").val();
    $.ajax({
		url: "/edu/admin/search_refund_list",
		type: "POST",
		data: {	
			'gisu_seq': gisu_seq,
			'gisu_order': gisu_order,
			'search_name': search_name,
			'curPage' : curPage,
			'pageCount' : pageCount
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
	//var data = response.length > 0 ? response : response.data;
	var context = '';
	$.each(map.resultList,function(index,item){
		//if(index == 0 && item.refund_result == 0) alert('환불처리에 실패했습니다');
		//if(index == 0 && item.refund_result == 1) alert('환불처리가 완료되었습니다');
		
		context += '<tr>';
		context += '<td>'+(index+1)+'</td>';
		context += '<td id="user_nm_'+item.pay_refund_seq+'">'+item.user_nm+'</td>';
		context += '<td id="user_id_'+item.pay_refund_seq+'">'+item.user_id+'</td>';
		context += '<td id="crc_nm_'+item.pay_refund_seq+'">'+item.pay_product_name+'</td>';
		context += '<td>'+(item.pay_crc_payorder+1)+'회차</td>';
		context += '<td>'+item.pay_crc_amount.toLocaleString('en')+'원</td>';
		context += '<td>'+item.pay_user_method+'</td>';
		if(item.pay_refund_status==0){
		    context += '<td><font color="red">환불대기</font></td>';
		 }else{
		    context += '<td><font color="blue">환불완료</font></td>';
		 }
		context += '<td>'+item.pay_refund_accnum+'</td>';
		context += '<td>'+item.pay_refund_accname+'</td>'; 
		var reqdt = new Date(item.pay_refund_reqdt);
		
		context += '<td>'+reqdt.toISOString().split('T')[0]+'</td>'; 
		if(item.pay_refund_reason != null && item.pay_refund_reason != ''){
			context += '<td><input id="reason_'+item.pay_refund_seq+'" type="hidden" value="'+item.pay_refund_reason+'">';
			context += '<a href="#" onclick="open_reason_dialog('+item.pay_refund_seq+');return false;"><font color="blue">보기</font></a></td>';
		} else {
			context += '<td></td>';
		}
		context += '<td><input id="memo_'+item.pay_refund_seq+'" type="hidden" value="'+item.pay_refund_memo+'">';
		context += '<a href="#" onclick="open_memo_dialog('+item.pay_refund_seq+');return false;">';
		context += (item.pay_refund_memo != null && item.pay_refund_memo != '' ? '<font color="blue">보기</font>' : '<font color="black">등록</font>');
		context += '</a></td>';
		if(item.pay_refund_status==0){
		    /* context += '<td><a href="javascript:confirmRefund('+item.pay_refund_seq+','+item.pay_user_seq+')"><font color="blue">환불완료처리</font></a></td>'; */
		    context += '<td><a onclick="open_refund_dialog('+item.pay_refund_seq+','+item.pay_user_seq+');return false;"><font color="blue">환불완료처리</font></a></td>';
		 }else{
		    context += '<td></td>';
		 }
		context += '</tr>';
		

	});
	$("#search_data").empty();
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
		alert(map.adminPager.nextPage);
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
   
function open_memo_dialog(seq){
	var memo_txt = $("input#memo_"+seq).val().replace("\r\n", "<br>");
	//if(typeof memo_txt === 'undefined') memo_txt = '';
	if(memo_txt === 'undefined') memo_txt = '';
	$("#memo_user_nm").text($("#user_nm_"+seq).text());
	$("#memo_crc_nm").text($("#crc_nm_"+seq).text());
	
	var btn_name1 = '등록';
	var btn_name2 = '취소';
	if(memo_txt != null && memo_txt != ''){
		btn_name1 = '수정';
		btn_name2 = '삭제';
	}
	$("#frm_memo > textarea").val(memo_txt);
	$("#frm_memo > input").val(seq);
	$("#dialog_memo").dialog({
		title: "메모"+btn_name1,
		width:"30%",
		buttons:[{
			text: btn_name1,
			click: function(){
				process_memo(btn_name1, seq, $("#frm_memo > textarea").val())
			}
		}
		,{
			text: btn_name2,
			click: function(){
				process_memo(btn_name2, seq, '')
			}
		}]
	
	});
}


function open_refund_dialog(pay_refund_seq, pay_user_seq){
	
	var btn_name1 = '환불하기';
	
	$("#dialog_refund").dialog({
		title: "환불",
		width:"30%",
		buttons:[{
			text: btn_name1,
			click: function(){
				confirmRefund(pay_refund_seq, pay_user_seq,$("#frm_refund > #refundreason").val(),$( "#cancelreason option:selected" ).text())
			}
		}]
	
	});
}

function process_memo(process_name, seq, memo){
	$("#dialog_memo").dialog("close");  
	if(process_name=='취소') return;
	var gisu_seq = $("#gisuSelect option:selected").val();
 	var gisu_order= $("#orderSelect option:selected").val();
	var search_name = $("#searchName").val();
    var pageCount = $("#pageSelect option:selected").val();
    var curPage = $("#cur_page_btn").val();
    var sort_param = $("#sorted_param").val();
    var sort_order = $("#sorted_order").val();
    
	$.ajax({
		type:"POST",                  
		url:"/edu/admin/refund_memo_update",   
		data:{
			'memo'			: memo,
			'seq'			: seq,
			'gisu_seq'		: gisu_seq,
			'gisu_order'	: gisu_order,
			'search_name'	: search_name,
			'pageCount'		: pageCount,
			'curPage'		: curPage,
			'sort_param'	: sort_param,
			'sort_order'	: sort_order
        },
        success:function(data){   
			printList(data);
			if(process_name == '수정') alert('메모가 수정되었습니다');
			if(process_name == '등록') alert('메모가 등록되었습니다');
			if(process_name == '삭제') alert('메모가 삭제되었습니다');
        },
        error: function(e){
           console.log(e);
        }
	});
}

function open_reason_dialog(seq){
	var reason_txt = $("#reason_"+seq).val().replace("\r\n", "<br>");
	$("#reason_user_nm").text($("#user_nm_"+seq).text());
	$("#reason_crc_nm").text($("#crc_nm_"+seq).text());
	$("#reason_txt").text(reason_txt);
	$("#dialog_reason").dialog({
		title:"환불사유 확인",
		width:"30%"
	});
}

function sort(){
	var sortColumn = $(this).text().trim();
	var sortOrder = $(this).find('img').attr('class');
    var pageCount = $("#pageSelect option:selected").val();
    var curPage = $("#cur_page_btn").val();
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
	if(sortColumn == '환불상태') sort_param = 'pay_refund_status';
	else if(sortColumn == '환불요청일') sort_param = 'pay_refund_reqdt';
	else if(sortColumn == '결제비용') sort_param = 'pay_crc_amount';
	else if(sortColumn == '분납차수') sort_param = 'pay_crc_payorder';
	else if(sortColumn == '결제과정명') sort_param = 'gisu_seq';
	
	$("#sorted_param").val(sort_param);
	$("#sorted_order").val(sortOrder);
	
    var gisu_seq = $("#gisuSelect option:selected").val();
    var gisu_order= $("#orderSelect option:selected").val();
    var search_name = $("#searchName").val();
	$.ajax({
		type:"POST",                  
		url:"/edu/admin/search_refund_list",   
		data:{
			'sort_param'	: sort_param,
			'sort_order'	: sortOrder,
			'gisu_seq'		: gisu_seq,
			'gisu_order'	: gisu_order,
			'search_name'	: search_name,
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

function confirmRefund(pay_refund_seq, pay_user_seq,pay_user_refund_reason,pay_user_cancelreason){
	if(confirm('정말 환불처리 하시겠습니까? 처리하시면 취소하실 수 없습니다') == false) return;
	var gisu_seq = $("#gisuSelect option:selected").val();
 	var gisu_order= $("#orderSelect option:selected").val();
	var search_name = $("#searchName").val();
    var pageCount = $("#pageSelect option:selected").val();
    var curPage = $("#cur_page_btn").val();
    var sort_param = $("#sorted_param").val();
    var sort_order = $("#sorted_order").val();
	$.ajax({
		type:"POST",                  
		url:"/edu/admin/proceed_refund",   
		data:{
			'pay_refund_seq': pay_refund_seq,
			'pay_user_seq'	: pay_user_seq,
			'gisu_seq'		: gisu_seq,
			'gisu_order'	: gisu_order,
			'search_name'	: search_name,
			'pageCount'		: pageCount,
			'curPage'		: curPage,
			'sort_param'	: sort_param,
			'sort_order'	: sort_order,
			'pay_user_refund_reason' : pay_user_refund_reason,
			'pay_user_cancelreason' : pay_user_cancelreason
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
<!-- <body ng-app="myapp" ng-controller="AdminController"> -->
<body>
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>유저 환불 관리</h2>
	<h5>결제 관리 페이지&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="payment_manager_refund">유저 환불 관리</a></h5>
</div>
<div class="custom_div">
	<table class="search_box">
		<tr>
			<th>과정명으로 검색</th>
			<td>
				<select id="curSelect">
					<option value="">분류</option>
					<c:forEach var="data" items="${seaCurList }">
						<option value="${data.crc_seq }">${data.crc_nm }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="gisuSelect">
					<option value="">과정명</option>
				</select>
			</td>
			<td>
				<select id="orderSelect" onchange="search()">
					<option value="">분납차수</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>이름으로 검색</th>
			<td><input type="text" id="searchName"></td>
			<td class="td_search" colspan="2"><button class="btn_search" onclick="search()">검색</button>
		</tr>
	</table>
	<select id="pageSelect" onchange="search()">
		<option value="10">10개씩</option>
		<c:forEach var="data" items="${map.adminPager.pageCountList}">
			<c:if test="${data == map.pageCount}">
				<option value="${data}" selected>${data}개씩</option>
			</c:if>
			<c:if test="${data != map.pageCount}">
				<option value="${data}">${data}개씩</option>
			</c:if>
		</c:forEach>
	</select>
	<table class="table">
		<thead>
			<tr>
				<th>No</th>
	            <th>결제자명</th>
	            <th>결제자ID</th>
	            <th class="sort">결제과정명&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
	            <th class="sort">분납차수&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
	            <th class="sort">결제비용&nbsp;<img class="desc" src="/resources/segroup/society/edu/image/main/triangle_down.png;"></th>
	            <th>결제방법</th>
	            <!-- <th class="sort">결제상태&nbsp;<img class="desc" src="/resources/segroup/society/edu/image/main/triangle_down.png;"></th> -->
	            <th class="sort">환불상태&nbsp;<img class="asc" src="/resources/segroup/society/edu/image/main/triangle_up.png;"></th>
	            <th>환불요청계좌</th>
	            <th>환불요청계좌주</th>
	            <th class="sort">환불요청일&nbsp;<img class="desc" src="/resources/segroup/society/edu/image/main/triangle_down.png;"></th>
	            <th>환불사유</th>
	            <th>메모</th>
	            <th>환불처리</th>
			</tr>
		</thead>
		<tbody id="search_data">
			<%--페이징 역순 처리 할 부분 --%>
			<%-- <c:forEach var="data" items="${seaRefundList }" varStatus="status">
				<tr>
					<td>${status.count }</td>
					<td id="user_nm_${data.pay_refund_seq}">${data.user_nm }</td>
					<td id="user_id_${data.pay_refund_seq}">${data.user_id }</td>
					<td id="crc_nm_${data.pay_refund_seq}">${data.pay_product_name}</td>
					<td>${data.pay_crc_payorder+1}회차</td>
					<td><fmt:formatNumber value="${data.pay_crc_amount }" pattern="#,###" />원</td>
					<td>${data.pay_user_method }</td>
					<td>
	             		<c:if test="${data.pay_refund_status == 1}"><font color="blue">환불완료</font></c:if>
	             		<c:if test="${data.pay_refund_status == 0}"><font color="red">환불대기</font></c:if>
					</td>
					<td>${data.pay_refund_accnum }</td>
					<td>${data.pay_refund_accname }</td>
					<td><c:out value="${fn:substring(data.pay_refund_reqdt,0,10)}"/></td>
					<td><input id="reason_${data.pay_refund_seq}" type="hidden" value="${data.pay_refund_reason}"><c:if test="${data.pay_refund_reason ne null and data.pay_refund_reason != ''}"><a href="#" onclick="open_reason_dialog(${data.pay_refund_seq});return false;"><font color="blue">보기</font></a></c:if></td>
					<td><input id="memo_${data.pay_refund_seq}" type="hidden" value="${data.pay_refund_memo}"><a href="#" onclick="open_memo_dialog(${data.pay_refund_seq});return false;">${data.pay_refund_memo ne null and data.pay_refund_memo != '' ? '<font color="blue">보기</font>' : '<font color="black">등록</font>'}</a></td>
					<td>
	             		<c:if test="${data.pay_refund_status == 0}"><a href="javascript:confirmRefund(${data.pay_refund_seq}, ${data.pay_user_seq});"><font color="blue">환불완료처리</font></a></c:if>
					</td>
				</tr>
			</c:forEach> --%>
		</tbody>
	</table>
</div>

<div class="pagination_wrap">
<%-- 	<div class="pagination_con">
	<span id="page"style="display: inline; margin:auto; display:table; ">
	<h4>
	<ul>
	<li>
	<ol>
	
	<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
	<c:if test="${map.adminPager.curBlock > 1}">
		<li><input type="button" onclick="javascript:ilist('1','')" name="" value="<<"></li>
	</c:if>
	
	<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curBlock > 1}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.prevPage}','')" name="" value="<"></li>
	</c:if>
	
	<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
	<c:forEach var="num" begin="${map.adminPager.blockBegin}" end="${map.adminPager.blockEnd}">
		<!-- **현재페이지이면 하이퍼링크 제거 -->
		<c:choose>
			<c:when test="${num == map.adminPager.curPage}">
				<li><input type="button" style="color: red"name="" value="${num}"></li>
			</c:when>
			<c:otherwise>
				<li><input type="button" onclick="javascript:ilist('${num}','')" name="" value="${num}"></li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curBlock <= map.adminPager.totBlock}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.nextPage}','')" name="" value=">"></li>
	</c:if>
	
	<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
	<c:if test="${map.adminPager.curPage <= map.adminPager.totPage}">
		<li><input type="button" onclick="javascript:ilist('${map.adminPager.totPage}','')" name="" value=">>"></li>
	</c:if>
	</ol>
	</h4>
	</li>
	</ul>
	</span>
	</div> --%>
</div>

<div id="dialog_memo" style="display: none;">
	<form id="frm_memo" method="post" action="refund_memo_update">
		<table class="dialog">
			<tr>
				<th>결제자명</th>
				<td id="memo_user_nm"></td>
			</tr>
			<tr>
				<th>결제과정명</th>
				<td id="memo_crc_nm"></td>
			</tr>
		</table>
		<textarea name="memo" rows="8" style="width:95%;margin-top:2%;"></textarea>
		<!-- <input type="hidden" name="seq">
		<input type="hidden" name="gisu_seq" value="">
		<input type="hidden" name="gisu_order" value="">
		<input type="hidden" name="search_name" value=""> -->
	</form>
</div>

<div id="dialog_reason" style="display: none;">
	<form id="frm_reason">
		<table class="dialog">
			<tr>
				<th>결제자명</th>
				<td id="reason_user_nm"></td>
			</tr>
			<tr>
				<th>결제과정명</th>
				<td id="reason_crc_nm"></td>
			</tr>
			<tr>
				<th>환불사유</th>
				<td><pre id="reason_txt"></pre></td>
			</tr>
		</table>
	</form>
</div>

<div id="dialog_refund" style="display: none;">
	<form id="frm_refund">
		<table class="dialog">
			<tr>
				<th>취소사유</th>
				<td id="reason_refund"><input type="text" name="refundreason" id="refundreason"></td>
			</tr>
			<tr>
				<th>취소코드(현금영수증)</th>
				<td id="reason_refund_code">
						<select name="cancelreason"	id="cancelreason">
                      		<option value="">--선택--</option>
                      		<option value="1">거래취소</option>
                      		<option value="2">오류</option>
                      		<option value="3">기타사항</option>
                      	</select>
                </td>
			</tr>
		</table>
	</form>
</div>

<form id="frm_refund_param" method="post" action="proceed_refund">
	<input type="hidden" name="pay_user_seq">
	<input type="hidden" name="pay_refund_seq">
	<input type="hidden" name="gisu_seq">
	<input type="hidden" name="gisu_order">
	<input type="hidden" name="search_name">
</form>
<div id="sorter" style="display: none;">
	<input type="hidden" id="sorted_param" value="">
	<input type="hidden" id="sorted_order" value="">
</div>
</html>