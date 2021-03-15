<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
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

<style>
#curSelect{width:20%;}
.gisu_crc_selectGroup{margin-top:20px;margin-left:330px;}
div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
.crc_submit{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
#form_button_delete{background-color:#f44256;}
#paydata th{background-color:#333;}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script>


$(document).ready(function(){ 

	minMax("payst0","payed0");
	/* var div = document.getElementById('pay_content');
	div.innerHTML +="1회 분납 비용 : <input type='text' name='paymentList[0].amount' id='payNum0' onkeypress='if ( isNaN( String.fromCharCode(event.keyCode) )) return false;'/>원 <br>" ;
	div.innerHTML +="<input type='hidden' name='paymentList[0].pay_order' value='0'>";
	div.innerHTML +=" 결제시작기간 : <input type='text' name='paymentList[0].pay_st' id='payst0' readonly='readonly'><br>";
	div.innerHTML +=" 결제종료기간 : <input type='text' name='paymentList[0].pay_end' id='payed0' readonly='readonly'><br><br>"; */
	var tbody = $("#pay_content tbody");
	var content = '';
	content +="<tr><td>1</td><td><input type='text' name='paymentList[0].amount' id='payNum0' onkeypress='if ( isNaN( String.fromCharCode(event.keyCode) )) return false;'/></td>" ;
	content +="<input type='hidden' name='paymentList[0].pay_order' value='0'>";
	content +="<td><input type='text' name='paymentList[0].pay_st' id='payst0' readonly='readonly'></td>";
	content +="<td><input type='text' name='paymentList[0].pay_end' id='payed0' readonly='readonly'></td></tr>"; 
	tbody.html(content);
	minMax("payst0","payed0");
 
}) 

function pay_num(sel){
	var num=sel.value;
	 //var div = document.getElementById('pay_content');
	 var tbody = $("#pay_content tbody");
	 tbody.html('');
	 var content = '';
	 $(function() {
		 for(var i=0;i<num;i++){
			 minMax("payst"+i,"payed"+i);
		 }
			
	 });
	 /* for(var i=0;i<num;i++){
		 div.innerHTML +=(i+1)+"회 분납 비용 : <input type='text' name='paymentList["+i+"].amount' id='payNum"+i+"' onkeypress='if ( isNaN( String.fromCharCode(event.keyCode) )) return false;'/>원 <br>" ;
		 div.innerHTML +="<input type='hidden' name='paymentList["+i+"].pay_order' value='"+i+"'>";
		 div.innerHTML +=" 결제시작기간 : <input type='text' name='paymentList["+i+"].pay_st' id='payst"+i+"' readonly='readonly'><br>";
		 div.innerHTML +=" 결제종료기간 : <input type='text' name='paymentList["+i+"].pay_end' id='payed"+i+"' readonly='readonly'><br><br>";
	 } */
	 for(var i=0;i<num;i++){
		 //div.innerHTML +="<tr><th>지불순서</th><th>분납 비용</th><th>결제시작일</th><th>결제종료일</th></tr>";
		 content +="<tr><td>"+(i+1)+"</td><td><input type='text' name='paymentList["+i+"].amount' id='payNum"+i+"' onkeypress='if ( isNaN( String.fromCharCode(event.keyCode) )) return false;'/></td>" ;
		 content +="<input type='hidden' name='paymentList["+i+"].pay_order' value='"+i+"'>";
		 content +="<td><input type='text' name='paymentList["+i+"].pay_st' id='payst"+i+"' readonly='readonly'></td>";
		 content +="<td><input type='text' name='paymentList["+i+"].pay_end' id='payed"+i+"' readonly='readonly'></td></tr>";
	 }
	 tbody.html(content);
		
}

function convertDate(data){
	
	var d = new Date(data);
	var formattedDate = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
	var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
	var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d.getMinutes();
	var formattedTime = hours + ":" + minutes+":"+"00.0";
	formattedDate = formattedDate + " " + formattedTime;
	return formattedDate;
	
}


$(function(){
$("#form_button").click(function() {
	
	if(!check()){
		return false;
	}
	
	if(!confirm("수정/등록 하시겠습니까?")){
		return false; 
	}

	if (isUpdatePossible() !== "0"){ //관련 결제데이터 개수. 0일때만 결제정보 변경 가능
		alert('해당 기수에 진행중인 결제가 있습니다. 결제관리페이지 > 유저결제관리에서 진행중인 결제를 취소 또는 환불처리 해주세요.');
		return false;
	}
	
	var url = "/edu/admin/payment_insert";
	
	$.ajax({
        type: "POST",
        url: url,
        data: $("#pay_form").serialize(), // serializes the form's elements.
        success: function(data)
        {
            var tbody = $("#paydata tbody");
            tbody.html("");
            var content = '';
            for (i = 0; i < data.length; i++) { 
            	console.log(data[i]);
            	content+="<tr>";
            	content +="<td>"+(data[i].PAY_CRC_PAYORDER+1)+"</td><td>"+data[i].PAY_CRC_AMOUNT+"원</td><td>"+new Date(data[i].PAY_CRC_START).toISOString().split('T')[0]+"</td><td>"+new Date(data[i].PAY_CRC_END).toISOString().split('T')[0]+"</td>";
            	content +="</tr>";
            }
            tbody.html(content);
        }
      });
});


$("#form_button_delete").click(function() {
	
	if(!confirm("삭제 하시겠습니까?")){
		return false; 
	}
	
	if (isUpdatePossible() !== "0"){//관련 결제데이터 개수. 0일때만 결제정보 삭제 가능
		alert('해당 기수에 진행중인 결제가 있습니다. 결제관리페이지 > 유저결제관리에서 진행중인 결제를 취소 또는 환불처리 해주세요.');
		return false;
	}
	
	var url = "/edu/admin/payment_delete";
	
	$.ajax({
        type: "POST",
        url: url,
        data: $("#pay_form").serialize(), // serializes the form's elements.
        success: function(data)
        {
            var tbody = $("#paydata tbody");
            tbody.html("");
            var content = '';
            for (i = 0; i < data.length; i++) { 
            	console.log(data[i]);
            	content+="<tr>";
            	content +="<td>"+(data[i].PAY_CRC_PAYORDER+1)+"</td><td>"+data[i].PAY_CRC_AMOUNT+"원</td><td>"+new Date(data[i].PAY_CRC_START).toISOString().split('T')[0]+"</td><td>"+new Date(data[i].PAY_CRC_END).toISOString().split('T')[0]+"</td>";
            	content +="</tr>";
            }
            tbody.html(content);
        }
      });
});


function isUpdatePossible(){
	var gisu_seq = $("input[name*='gisu_seq']").val();
	var result = "";
	$.ajax({
		url: "/edu/admin/payment_update_validity",
		method: "POST",
		async: false,
		data: {
			"gisu_seq" : gisu_seq
		},
		success: function(data){
			result = data;
		}
	});
	return result;
}

});

function check(){
	
	var num=$("#pay_num").val()+1;
	
	
	for(var i=0;i<num;i++){
		var st=$("#payst"+i).val();
		var ed=$("#payed"+i).val();
		var amount=$("#payNum"+i).val();
		if(st===""||ed===""){
			alert("결제기간을 모두 입력해주세요.")
					return false;
		}
		
		if(amount===""){
			alert("분납비용을 모두 입력해주세요.")
			return false;
		}
		
	}
	
	
	
	return true;
}




</script>
</head>
<body>
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>기수 결제 관리</h2>
	<h5>결제 관리 페이지&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="payment_manager_form">기수 결제 관리</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;${gisu_name} 결제 정보 등록</h5>
</div>
<br>
<div class="custom_div">
	<h3>기존 등록 정보</h3>
	<table class="gisu_crc_table" id="paydata">
		<colgroup>
			<col width="15%"/>
			<col width="25%"/>
			<col width="30%"/>
			<col width="30%"/>
		</colgroup>
		<thead>
			<tr>
				<th>지불순서</th>
				<th>비용</th>
				<th>결제시작일</th>
				<th>결제종료일</th>
			</tr>
		</thead>
		<tbody>
	        <c:forEach var="data" items="${pay_info}" varStatus="status">
				<tr>
					<td>${ status.count }</td>
					<td>${ data.PAY_CRC_AMOUNT}원</td>
					<td>${fn:substring(data.PAY_CRC_START,0,10)}</td>
					<td>${fn:substring(data.PAY_CRC_END,0,10)}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div class="page_sub_title"></div>
<div class="custom_div">
	<h3 style="margin-bottom:-35px;margin-top:20px;">새로 등록</h3>
	<div>
		<h4 style="float:left;">
			총
			<select id="pay_num" onchange="pay_num(this);" onsubmit="return check();">
			  <option value="1">1</option>
			  <option value="2">2</option>
			  <option value="3">3</option>
			  <option value="4">4</option>
			  <option value="5">5</option>
			  <option value="6">6</option>
			</select>
			회 분납
		</h4>
		
		<h5 style="float:right;position:relative;top:15px;"><font color="red">완납일시, 1회 분납으로 설정해주세요.</font></h5>
	</div>
	<form method="post" id="pay_form" onsubmit="return check()">
	<input type="hidden" name="gisu_seq" value="${gisu_seq}">
	<div id="pay_content">
		<table class="gisu_crc_table">
			<colgroup>
				<col width="15%"/>
				<col width="25%"/>
				<col width="30%"/>
				<col width="30%"/>
			</colgroup>
			<thead>
			<tr>
				<th>분납순서</th>
				<th>분납비용(원	)</th>
				<th>결제시작일</th>
				<th>결제종료일</th>
			</tr>
			</thead>
			<tbody>
			
			</tbody>
		</table>
		<input type="button" id="form_button" class="crc_submit" value="수정/등록">
		<input type="button" id="form_button_delete" class="crc_submit" value="결제정보삭제">
	</div>
	</form>
</div>
</body>
</html>