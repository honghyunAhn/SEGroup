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
<script src="<c:url value="/resources/segroup/ckeditor/ckeditor.js" />"></script>

<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/join.css" />">

<!-- 페이징 관련 css 끝 -->

<style>
#curSelect{width:20%;}
.gisu_crc_selectGroup{margin-top:20px;margin-left:330px;}
div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
.crc_submit{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
.crc_select{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
.crc_selected{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}
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
   $("#tolist").click(function(){
        location.href="/edu/admin/online_manager_form?curPage=${curPage}&pageCount=${pageCount}&orderValue=${orderValue}&orderType=${orderType}&searchId=${searchId}&searchTitle=${searchTitle}";
    })
});

$(function(){
	// 공개설정 라디오버튼
	$.each($('td.open > a.radio'), function(index, button) {
		$(button).on('click', radioOnChange_open);
	});
	
	$.each($('td.check > a.radio'), function(index, button) {
		$(button).on('click', radioOnChange_check);
	});

	// 공개여부 설정 로드
	$.each($('td.open > a.radio'), function(index, button) {
		$(button).on('click', radioOnChange_open);
	});
	var consulting_open = ${result.consulting_open}
	if (consulting_open == '0') {
		$("#consulting_open_o").trigger("click");
	} else {
		$("#consulting_open_c").trigger("click");
	}
	
	$.each($('td.check > a.radio'), function(index, button) {
		$(button).on('check', radioOnChange_check);
	});
	var consulting_check = ${result.consulting_check}
	if (consulting_check == '0') {
		$("#consulting_check_a").trigger("click");
	}
	if (consulting_check == '1') {
		$("#consulting_check_b").trigger("click");
	}
	if (consulting_check == '2') {
		$("#consulting_check_c").trigger("click");
	}
	
	//CK에디터
	CKEDITOR.replace( 'consulting_ct',{
		filebrowserUploadUrl: '/board/imageUpload',
	});
	CKEDITOR.replace( 're_ct',{
		filebrowserUploadUrl: '/board/imageUpload',
	});
	
	//답변작성
	$("#replyInsertBtn").on("click",function(){
		formCheck();
	});
})

function radioOnChange_open(evt) {
	$.each($('td.open > a.btn'), function(index, button) {
		var obj_button = $(button);
		var input_consulting_open = $('#consulting_open');
		if (evt.currentTarget == button) {
			obj_button.addClass('btn_b');
			obj_button.removeClass('btn_gray btn_fore_black');
			input_consulting_open.val(obj_button.attr('value'));
		} else {
			obj_button.addClass('btn_gray btn_fore_black');
			obj_button.removeClass('btn_b');
		}
	});
}

function radioOnChange_check(evt) {
	$.each($('td.check > a.btn'), function(index, button) {
		var obj_button = $(button);
		var input_consulting_open = $('#consulting_check');
		if (evt.currentTarget == button) {
			obj_button.addClass('btn_b');
			obj_button.removeClass('btn_gray btn_fore_black');
			input_consulting_open.val(obj_button.attr('value'));
		} else {
			obj_button.addClass('btn_gray btn_fore_black');
			obj_button.removeClass('btn_b');
		}
	});
}

function formCheck(){
	if(consulting_title.length == 0){
		alert("제목을 입력해 주세요.");
		return false;
	}
	if(consulting_ct.length == 0){
		alert("내용을 입력해 주세요.");
		return false;
	}
	
	var check = confirm("온라인상담 내용을 수정 하시겠습니까?");
	if(!check){
		return false;
	}
	return true;
}

function formCheck_re(){
	if(re_ct.length == 0){
		alert("답변 내용을 입력해 주세요.");
		return false;
	}
	
	var check = confirm("답변을 등록 하시겠습니까?");
	if(!check){
		return false;
	}
	return true;
}
</script>
</head>
<body ng-app="myapp">
<%@include file="admin_menu.jsp"%>
<div class="page_title">
    <h2>온라인 상담 관리</h2>
    <h5><a href="/edu/admin/online_manager_form">온라인 상담 관리</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;온라인 상담 상세</h5>
</div>
<div class="custom_div" style="margin-top:20px;">
	<form action="/edu/admin/online_manager_contents_update" method="post" enctype="multipart/form-data" onsubmit="return formCheck();">
    <table class="gisu_crc_table">
        <colgroup>
            <col width="20%"/>
            <col width="80%"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col" style="text-align:center;" colspan="2">상담 신청 내용</th>
            </tr>
        </thead>
        <tbody class="custom_tbody">
            <tr>
                <td class="name first">번호</td>
                <td class="first"><input type="text" name="consulting_seq" value="${result.consulting_seq }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">작성자</td>
                <td><input type="text" name="consulting_ins_id" value="${result.consulting_ins_id }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">공개여부</td>
                <td class="open">
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_open_o" value="0" style="width:42%; margin: 1px;">공개</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_open_c" value="1" style="width:42%; margin: 1px;">비공개</a>
				<input type="hidden" id="consulting_open" name="consulting_open" value="${consulting_open }">
                </td>
            </tr>
            <tr>
                <td class="name">처리현황</td>
				<td class="check">
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_a" value="0" style="width:26.6%; margin: 1px;">삭제처리</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_b" value="1" style="width:26.6%; margin: 1px;">답변대기</a>
                <a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="consulting_check_c" value="2" style="width:26.65%; margin: 1px;">답변완료</a>
				<input type="hidden" id="consulting_check" name="consulting_check" value="${consulting_check }">
            </tr>
            <tr>
                <td class="name">신청제목</td>
                <td><input type="text" id="consulting_title" name="consulting_title" value="${result.consulting_title }"/></td>
            </tr>
            <tr>
                <td colspan="2" class="name">신청내용</td>
            </tr>
            <tr>
                <td colspan="2"><textarea id="consulting_ct" name="consulting_ct" >${result.consulting_ct }</textarea></td>
            </tr>
        </tbody>
    </table>
    <input type="submit" class="crc_submit" id="onlineUpdateBtn" value="상담내용 수정하기" />
    <input type="button" class="crc_submit" id="tolist" value="목록보기" />
	<input type="hidden" name="consulting_udt_id" value="${loginedId}">
    <input type="hidden" name="curPage" value="${curPage}">
    <input type="hidden" name="pageCount" value="${pageCount}">
    <input type="hidden" name="orderValue" value="${orderValue}">
    <input type="hidden" name="orderType" value="${orderType}">
    <input type="hidden" name="searchId" value="${searchId}">
    </form>
    <br><br><br><br><br>
<c:if test="${result.re_ins_id == null}">
    <form action="/edu/admin/online_manager_reply_insert" method="post" enctype="multipart/form-data" onsubmit="return formCheck_re();">
    <table class="gisu_crc_table">
        <colgroup>
            <col width="20%"/>
            <col width="80%"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col" style="text-align:center;">온라인상담 답변작성란</th>
            </tr>
        </thead>
        <tbody>
	        <tr>
	        	<td>아직 답변이 등록되지 않은 상담글 입니다.</td>
	        </tr>
        </tbody>
        <tbody class="custom_tbody">
            <tr>
                <td><textarea id="re_ct" name="re_ct" maxlength="1000"  placeholder=" 답변내용(1000자이내)" style="height: 400px; width: 100%; resize: vertical; margin: 0; padding: 0;">${result.re_ct }</textarea></td>
            </tr>
        </tbody>
    </table>
	<input type="submit" class="crc_submit" id="onlineReInsertBtn" value="등록하기" />
	<input type="button" class="crc_submit" id="tolist" value="목록보기" />	
    <input type="hidden" name="curPage" value="${curPage}">
    <input type="hidden" name="pageCount" value="${pageCount}">
    <input type="hidden" name="orderValue" value="${orderValue}">
    <input type="hidden" name="orderType" value="${orderType}">
    <input type="hidden" name="searchId" value="${searchId}">
    <input type="hidden" name="consulting_seq" value="${result.consulting_seq }">
    <input type="hidden" name="re_ins_id" value="${loginedId}">
    <input type="hidden" name="re_udt_id" value="${loginedId}">
    </form>
</c:if>
<c:if test="${result.re_ins_id != null}">
    <form action="/edu/admin/online_manager_reply_update" method="post" enctype="multipart/form-data" onsubmit="return formCheck();">
    <table class="gisu_crc_table">
        <colgroup>
            <col width="20%"/>
            <col width="80%"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col" style="text-align:center;">온라인상담 답변작성란</th>
            </tr>
        </thead>
        <tbody>
	        <tr>
	        	<td>답변자: ${result.re_ins_id } / 최초 작성일시: [${result.re_ins_dt }]</td>
	        </tr>
	        <tr>
	        	<td>답변 수정자: ${result.re_udt_id } / 최종 수정일시: [${result.re_udt_dt }]</td>
	        </tr>
        </tbody>
        <tbody class="custom_tbody">
            <tr>
                <td><textarea id="re_ct" name="re_ct" maxlength="1000"  placeholder=" 답변내용(1000자이내)" style="height: 400px; width: 100%; resize: vertical; margin: 0; padding: 0;">${result.re_ct }</textarea></td>
            </tr>
        </tbody>
    </table>
	<input type="submit" class="crc_submit" id="onlineReUpdateBtn" value="수정하기" />
	<input type="button" class="crc_submit" id="tolist" value="목록보기" />
		
    <input type="hidden" name="curPage" value="${curPage}">
    <input type="hidden" name="pageCount" value="${pageCount}">
    <input type="hidden" name="orderValue" value="${orderValue}">
    <input type="hidden" name="orderType" value="${orderType}">
    <input type="hidden" name="searchId" value="${searchId}">
    <input type="hidden" name="consulting_seq" value="${result.consulting_seq }">
    <input type="hidden" name="re_ins_id" value="${loginedId}">
    <input type="hidden" name="re_udt_id" value="${loginedId}">
    </form>
</c:if>
    <form action="/edu/admin/online_manager_form" id="onlineHiddenManagerForm" method="get">
	</form>
</div>
</body>
</html>