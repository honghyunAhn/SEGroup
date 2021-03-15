<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
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

<style>
#curSelect{width:20%;}
.gisu_crc_selectGroup{margin-top:20px;margin-left:330px;}
div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
.crc_submit{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
#tolist{color:white;background-color:#333;}
table.gisu_crc_table{text-align:left;}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
var myApp = angular.module('myapp', []);
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

$(function() {
	var user_sex = '${user.user_sex}';
	if(user_sex == 'A0000'){
		$("#user_sex_m").trigger("click");
	}else{
		$("#user_sex_f").trigger("click");
	}
	$("#tolist").click(function(){
		location.href="/edu/admin/user_manager_form?curPage=${curPage}&pageCount=${pageCount}&orderValue=${orderValue}&orderType=${orderType}&searchName=${searchName}&searchId=${searchId}";
	})
});

function check(){
	var birth_year = $("#birth_year").val();
	var birth_month = $("#birth_month").val();
	var birth_date = $("#birth_date").val();
	
	if(isNaN(birth_year) || birth_year.toString().length != 4) {
		alert('연도는 4자리 숫자로 입력하세요');
		return false;
	}
	if(isNaN(birth_month) || isNaN(birth_date)) {
		alert('숫자를 입력하세요');
		return false;
	}
	if(birth_month.toString().length < 2) {
		birth_month = '0' + birth_month;
	}
	if(birth_date.toString().length < 2) {
		birth_date= '0' + birth_date;
	}
	$("#user_birth").val(birth_year+birth_month+birth_date);
	return true;
}
</script>
</head>
<body ng-app="myapp" >
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>SMART Cloud IT 마스터 회원 관리</h2>
	<h5><a href="user_manager_form">회원 관리 페이지</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;회원 정보 수정</h5>
</div>
<div class="custom_div" style="margin-top:20px;">
	<form action="/edu/admin/user_info_update" method="post" onsubmit="return check();">
	<table class="gisu_crc_table">
		<colgroup>
			<col width="20%"/>
			<col width="80%"/>
		</colgroup>
		<thead>
			<tr>
				<th scope="col" class="name">회원정보</th>
				<th scope="col" style="text-align:center;">내 용</th>
			</tr>
		</thead>
		<tbody class="custom_tbody">
			<tr>
				<td class="name first">아이디</td>
				<td class="first"><input type="text" name="user_id" value="${user.user_id }" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="name">이름</td>
				<td><input type="text" name="user_nm" id="user_nm" value="${user.user_nm }" /></td>
			</tr>
			<tr>
				<td class="name">전화번호</td>
				<td><input type="tel" id="user_phone" name="user_phone" maxlength="11"  placeholder="전화번호" value="${user.user_phone }" /></td>
			</tr>
			<tr>
				<td class="name">이메일</td>
				<td><input type="email" id="user_email" name="user_email" placeholder="이메일" value="${user.user_email }" style="width:89% !important;height:40px !important;"/></td>
			</tr>
			<tr>
				<td class="name">생년월일</td>
				<td>
					<c:set var="birth" value="${user.user_birth }"/>
					<input class="ip_3" type="text" id="birth_year" name="birth_year" value="${fn:substring(birth,0,4) }" maxlength="4" placeholder="YYYY">년&nbsp;&nbsp;
					<input class="ip_3" type="text" id="birth_month" name="birth_month" value="${fn:substring(birth,5,7) }" maxlength="2" placeholder="MM">월&nbsp;&nbsp;
					<input class="ip_3" type="text" id="birth_date" name="birth_date" value="${fn:substring(birth,8,10) }" maxlength="2" placeholder="DD">일
					<input type="hidden" id="user_birth" name="user_birth" maxlength="8">
				</td>
			</tr>
			<tr>
				<td class="name" style="height:37px;">성별</td>
				<td style="height:37px;">
					<input type="radio" name="user_sex" id="user_sex_m" value="A0000" /><code value="A0000"></code>
					<input type="radio" name="user_sex" id="user_sex_f" value="A0001"  /><code value="A0001"></code>
				</td>
			</tr>
			<tr>
				<td class="name" style="height:37px;">회원 종류</td>
				<td style="height:37px;"><code value="${user.user_flag}"></code></td>
			</tr>
			<tr>
				<td class="name last" style="height:37px;">회원 상태</td>
				<td class="last" style="height:37px;"><code value="${user.user_state}"></code></td>
			</tr>
		</tbody>
	</table>
	<input class="crc_submit" type="submit" value="수정하기">
	<input id="tolist" class="crc_submit" type="button" value="목록보기">
	<input type="hidden" name="curPage" value="${curPage}">
	<input type="hidden" name="pageCount" value="${pageCount}">
	<input type="hidden" name="orderValue" value="${orderValue}">
	<input type="hidden" name="orderType" value="${orderType}">
	<input type="hidden" name="searchName" value="${searchName}">
	<input type="hidden" name="searchId" value="${searchId}">
	</form>
</div>
</body>
</html>