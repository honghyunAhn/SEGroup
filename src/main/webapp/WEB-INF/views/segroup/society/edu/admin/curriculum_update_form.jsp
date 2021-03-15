<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">

<!-- 페이징관련 css 시작 -->
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
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
#curSelect {
	width: 20%;
}

.gisu_crc_selectGroup {
	margin-top: 20px;
	margin-left: 330px;
}

div.custom_div {
	text-align: center;
	margin-left: 330px;
	margin-right: 330px;
}

.crc_submit {
	color: white;
	font-weight: bold;
	font-size: 120%;
	background-color: #3af;
	border: none;
	padding: 5px;
	width: 180px;
	height: 50px;
	margin-top: 15px;
	margin-bottom: 30px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
	$(function() {
		// 서버로부터 받은 객체 seaCurGisu의 crc_seq 값으로 셀렉트 박스의 선택 값을 지정
		$("#curSelect").val('${seaCurriculum.crc_tp }').prop("selected", true);
	});

	var myApp = angular.module('myapp', []);
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		var seaCurriculumJson = '${seaCurriculumJson}';
		
		$scope.seaCurriculum = JSON.parse(seaCurriculumJson);
		
	}]);

	myApp.directive('selectcode', [ '$http', function($http) {
		return {
			restrict : "A",
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
			template : "<option>{{filterParams}}</option>"
		}
	} ]);

	function request_add_crc_tp() {
		$("input[name=crc_tp]").attr('value',
				$("select[name=select_crc_tp]").val());
		if ($("#crc_tp").val() == '' || $("#crc_tp").val() == null) {
			//             alert($("select[name=select_crc_tp]").val());
			//             alert($("#crc_tp").val());
			return false;
		}
		formCheck();
	}

    function formCheck() {
        var crc_class = $("#crc_class");
        var crc_nm = $("#crc_nm");
        var crc_month = $("#crc_month");
        var crc_days = $("#crc_days");
        var crc_times = $("#crc_times");
        var crc_pay = $("#crc_pay");

        if (crc_class.val() == '') {
            alert('과정분류를 입력해 주시기 바랍니다.');
            selectAndFocus(crc_class);
            return false;
        }
        if (crc_nm.val() == '') {
            alert('과정명를 입력해 주시기 바랍니다.');
            selectAndFocus(crc_nm);
            return false;
        }
        if (crc_month.val() == '') {
            alert('교육의 개월수를 입력해 주시기 바랍니다.');
            selectAndFocus(crc_month);
            return false;
        }
        if (crc_days.val() == '') {
            alert('교육의 일수를 입력해 주시기 바랍니다.');
            selectAndFocus(crc_days);
            return false;
        }
        if (crc_times.val() == '') {
            alert('교육의 시간을 입력해 주시기 바랍니다.');
            selectAndFocus(crc_times);
            return false;
        }
        if (crc_pay.val() == '') {
            alert('교육비를 입력해 주시기 바랍니다.');
            selectAndFocus(crc_pay);
            return false;
        }
    }
</script>
</head>
<body ng-app="myapp" ng-controller="AdminController">
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>SMART Cloud IT 마스터 과정 관리</h2>
		<h5>
			과정 관리 페이지&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="curriculum_form">신규
				과정 등록</a>
		</h5>
	</div>
	<div class="gisu_crc_selectGroup">
		<select id="curSelect" name="select_crc_tp">
			<option selectcode value="B1200" selected></option>
			<option selectcode value="B1201"></option>
		</select>
	</div>
	<div class="custom_div">
		<form action="/edu/admin/curriculum_update" method="post"
			onsubmit="return request_add_crc_tp();">
			<input type="hidden" id="crc_tp" name="crc_tp" /> <input
				type="hidden" id="crc_seq" name="crc_seq"
				value="${seaCurriculum.crc_seq }" />
			<table class="gisu_crc_table">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="name">입력 항목</th>
						<th scope="col" class="name">내 용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<!-- 분류명, 중복 처리 확인 필요 -->
						<td class="name first">과정분류</td>
						<td class="first">
								<select id="crc_class" name="crc_class" ng-model="seaCurriculum.crc_class">
                					<option selectcode value="A1200"></option>
                					<option selectcode value="A1201"></option>
                					<option selectcode value="A1202"></option>
                					<option selectcode value="A1203"></option>
                					<option selectcode value="A1204"></option>
                				</select>
						</td>
					</tr>
					<tr>
						<td class="name first">과정명</td>
						<td><input type="text" name="crc_nm"
							value="${seaCurriculum.crc_nm }" /></td>
					</tr>
					<tr>
						<td class="name">교육일수 및 시간</td>
						<td style="float: left; padding-left: 36px;"><input
							class="ip_3" type="text" name="crc_month" maxlength="2"
							placeholder="MM" value="${seaCurriculum.crc_month }" />개월&nbsp;&nbsp;
							<input class="ip_3" type="text" name="crc_days" maxlength="4"
							placeholder="DD" value="${seaCurriculum.crc_days }" />일&nbsp;&nbsp;
							<input class="ip_3" type="text" name="crc_times" maxlength="8"
							placeholder="TIME" value="${seaCurriculum.crc_times }" />시간</td>
					</tr>
					<tr>
						<td class="name last">교육비</td>
						<td class="last"><input type="text" name="crc_pay"
							value="${seaCurriculum.crc_pay }" /></td>
					</tr>
					<tr>
						<td class="name">과정소개</td>
						<td><textarea id="crc_intro" name="crc_intro"
								style="height: 120px; width: 92%; resize: vertical; margin: 0; padding: 0;">${seaCurriculum.crc_intro }</textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<input class="crc_submit" type="submit" value="수정하기">
		</form>
	</div>
</body>
</html>