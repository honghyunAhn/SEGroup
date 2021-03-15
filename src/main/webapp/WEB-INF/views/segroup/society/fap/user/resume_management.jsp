<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script type="text/javascript">
$(function() {
	$('#nav li').hover(function() {
		$('ul', this).slideDown(200);
		$(this).children('a:first').addClass("hov");
	}, function() {
		$('ul', this).slideUp(100);
		$(this).children('a:first').removeClass("hov");		
	});
	
	$(".resume_editable_btn").off('click').on('click',function(){
		$(".resume_tab_btn").removeClass("on");
		$(this).addClass("on");
		
		var resumeFormListJson = '${resumeFormListJson}';
		resumeFormListJson = resumeFormListJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var resumeFormList = JSON.parse(resumeFormListJson);
		
		var formLength = 0;
		formLength = resumeFormList.length;
		
		var context = '';
		
		$.each(resumeFormList , function(index, item){
			context += '<div class="resume_list">';
			context += '<div class="resume_list_title">';
			context += '<p class="resume_list_context title"><a href="javascript:resume_update_form(\''+item.fap_resume_seq+'\')" title="'+item.fap_resume_title+'">'+item.fap_resume_title+'</a></p>';
			context += '</div>';
			context += '<div>';
			context += '<a href="javascript:delete_my_resume('+item.fap_resume_seq+')"><button class="btn-remove"></button> </a>';
			context += '</div>';
			context += '</div>';
		});
		
		for(var i = formLength; i < 9; i++){
			context += '<div class="resume_list">';
			context += '<div class="resume_list_title">';
			context += '<p class="resume_list_context">이력서 등록</p>';
			context += '</div>';
			context += '<div>';
			context += '<a href="javascript:choiceResumeGubun()"><button class="btn-add"></button></a>';
			context += '</div>';
			context += '</div>';
		}
		
		$(".resume_list_body").html(context);
	});
	
	$(".resume_applyed_btn").off('click').on('click',function(){
		$(".resume_tab_btn").removeClass("on");
		$(this).addClass("on");
		
		var resumeApplyListJson = '${resumeApplyListJson}';
		resumeApplyListJson = resumeApplyListJson.replace(/(?:\r\n|\r|\n)/g, '\\r\\n');
	    var resumeApplyList = JSON.parse(resumeApplyListJson);
		
		var context = '';
		
		$.each(resumeApplyList , function(index, item){
			context += '<div class="resume_list">';
			context += '<div class="resume_list_title">';
			if(item.fap_job_resume_update_gb == 'D1700'){
				context += '<p class="resume_list_context title"><a href="javascript:resume_read_form(\''+item.fap_resume_seq+'\')" title="'+item.fap_resume_title+'">'+item.fap_resume_title+'</a></p>';
			}else{
				context += '<p class="resume_list_context title"><a href="javascript:resume_update_form(\''+item.fap_resume_seq+'\')" title="'+item.fap_resume_title+'">'+item.fap_resume_title+'</a></p>';
			}
			context += '<p class="resume_list_context" title="'+item.fap_comp_ja_nm+'">'+item.fap_comp_ja_nm+'</p>';
			if(typeof item.fap_job_app_info_rank != "undefined"){
				context += '<p class="resume_list_context">'+item.fap_job_app_info_rank+'지망</p>';
			}else{
				context += '<p class="resume_list_context">구직자 교육</p>';
			}
			context += '<p class="resume_list_context">'+item.fap_job_app_info_ins_dt+'</p>';
			context += '</div>';
			context += '</div>';
		});
		
		$(".resume_list_body").html(context);
		
	});
	
});

function delete_my_resume(fap_resume_seq) {
	var realApply = confirm('정말 삭제하시겠습니까?');
	if(realApply == false){
		return false;
	}
	//ajax로 이력서 삭제 여부 결정
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'resume_deletable_check',
		type : 'post',
		data : {fap_resume_seq : fap_resume_seq},
        dataType : "text", 
		success : function(response) {
			if (response == 'approvalDeleteSuccess') {
				alert('성공적으로 삭제되었습니다');
				$("#fap_resume_delete_seq").val(fap_resume_seq);
				$('#delete_my_resume').submit();
			} else {
			  	alert('이미 지원된 이력서는 삭제할 수 없습니다');
			}
		},
		error : function(response) {
			console.log(response);
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/user/user_login";
			}
		}
	});
	
}
function resume_update_form(fap_resume_seq){
	$("#fap_resume_update_seq").val(fap_resume_seq);
	
	$('#resume_update_form').submit();
}

function resume_read_form(fap_resume_seq){
	$("#fap_resume_read_seq").val(fap_resume_seq);
	
	$('#resume_read_form').submit();
}

var myApp = angular.module('myapp', []);		

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
}]);

myApp.directive('code', [ '$http', function($http) {
	return {
		restrict : "E",
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
		template : "<span>{{filterParams}}</span>"
	}
}]);

 
function choiceResumeGubun(){  
	location.href = "/fap/user/resume_insert_form";
}

</script>
<body ng-app="myapp">
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check"/>
	<input type="hidden" id="user_flag" value="${check.user.user_flag }" />
</sec:authorize>
<%@include file="user_menu.jsp"%>
<div class="resume_wrap">
<div id="subcontents">
<h2>이력서 관리</h2>

<div class="resume_btn_div">
	<button class="resume_tab_btn resume_editable_btn on">작성중 이력서</button>
	<button class="resume_tab_btn resume_applyed_btn">지원한 이력서</button>
</div>
<div class="resume_list_wrap">
<div id="sub1_basic">
<ul>
<li class="jointxt1"></li>
</ul>
</div>

<div class="resume_list_body">

	<c:set var="formLength" value="0" />
	
	<c:if test="${!empty resumeFormList}">
		<c:set var="formLength" value="${fn:length(resumeFormList)}" />
	</c:if>
	
	<c:forEach items="${resumeFormList}" var="resumeFormList">
			<div class="resume_list">
				<div class="resume_list_title">
					<p class="resume_list_context title"><a href="javascript:resume_update_form('${resumeFormList.fap_resume_seq}')" title="${resumeFormList.fap_resume_title}">${resumeFormList.fap_resume_title}</a></p>
				</div>
				<div>
					<a href="javascript:delete_my_resume(${resumeFormList.fap_resume_seq})"><button class="btn-remove"></button> </a>
				</div>
			</div>
	</c:forEach>
	<c:forEach begin="${formLength }" end="8">
		<div class="resume_list">
			<div class="resume_list_title">
				<p class="resume_list_context">이력서 등록</p>
			</div>
			<div> 		 
				<a href="javascript:choiceResumeGubun()"><button class="btn-add"></button></a>
			</div>	 			  			 
		</div>
	</c:forEach>

</div>

</div>
</div>
</div>
<form id="resume_update_form" action="resume_update_form" method="post">
	<input type="hidden" name="fap_resume_seq" id="fap_resume_update_seq">
</form>

<form id="delete_my_resume" action="delete_resume_form" method="post">
	<input type="hidden" name="fap_resume_seq" id="fap_resume_delete_seq">
</form>

<form id="resume_read_form" action="resume_read_form" method="post">
	<input type="hidden" name="fap_resume_seq" id="fap_resume_read_seq">
</form>

<%@include file="../common_footer_fap.jsp"%>
</body>
</html>