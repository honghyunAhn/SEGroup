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
    $("#tolist").click(function(){
        location.href="/edu/admin/offline_manager_form?curPage=${curPage}&pageCount=${pageCount}&orderValue=${orderValue}&orderType=${orderType}&searchName=${searchName}&searchTitle=${searchTitle}";
    })
});

function check(){
    var send_mail_title = $("#send_mail_title");
    var send_mail_contents = $("#send_mail_contents");

    if (send_mail_title.val() == '') {
        alert('메일 제목을 입력해 주시기 바랍니다');
        selectAndFocus(send_mail_title);
        return false;
    }
    if (send_mail_contents.val() == '') {
        alert('메일 내용을 입력해 주시기 바랍니다');
        selectAndFocus(send_mail_contents);
        return false;
    }
    
    ajaxSubmit();
}

/**
 * 서버에 신청 서비스 요청
 */
function ajaxSubmit(){
//  alert("Ajax 신청서비스 들어가기 전~!");
    var formData = $("#multiForm").serialize();

    $.ajax({
        type: "POST",
        url: '<c:url value="/edu/admin/offline_manager_mail_send" />',
        data: formData,
        success: function(isRequested) {
            if (isRequested) {
                alert('신청에 성공하였습니다. 작성하신 이메일을 통해 접수내용을 확인하실 수 있습니다.');
                location.href = "<c:url value='/edu/admin/offline_manager_form?curPage=${curPage}&pageCount=${pageCount}&orderValue=${orderValue}&orderType=${orderType}&searchName=${searchName}&searchTitle=${searchTitle}' />";
            } else {
                alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
            }
        },
        error: function(e) {
            alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
        }
    });
}
</script>
</head>
<body ng-app="myapp" >
<%@include file="admin_menu.jsp"%>
<div class="page_title">
    <h2>오프라인 상담 관리</h2>
    <h5><a href="/edu/admin/offline_manager_form">오프라인 상담 관리</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;오프라인 상담 상세</h5>
</div>
<div class="custom_div" style="margin-top:20px;">
    <form id="multiForm" name="multiForm" method="post" onsubmit="return check();">
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
                <td class="first"><input type="text" name="seq" value="${result.seq }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">이름</td>
                <td><input type="text" name="user_nm" value="${result.user_nm }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">성별</td>
                <td><input type="text" name="user_sex" value="${result.user_sex }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">나이</td>
                <td><input type="text" name="user_age" value="${result.user_age }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">전공</td>
                <td><input type="text" name="user_major" value="${result.user_major }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">전화번호</td>
                <td><input type="text" name="user_phone" value="${result.user_phone }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">이메일</td>
                <td><input type="text" name="user_email" value="${result.user_email }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">신청날짜</td>
                <td><input type="text" name="apply_datetime" value="${result.apply_datetime }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">신청제목</td>
                <td><input type="text" name="apply_title" value="${result.apply_title }" readonly="readonly"/></td>
            </tr>
            <tr>
                <td class="name">신청내용</td>
                <td><textarea  name="apply_contents" readonly="readonly" style="height: 120px; width: 92%; resize: vertical; margin: 0; padding: 0;">${result.apply_contents }</textarea></td>
            </tr>
        </tbody>
    </table>
    <table class="gisu_crc_table">
        <colgroup>
            <col width="20%"/>
            <col width="80%"/>
        </colgroup>
        <thead>
            <tr>
                <th scope="col" style="text-align:center;">신청자 확인 메일 작성란</th>
            </tr>
        </thead>
        <tbody class="custom_tbody">
            <tr>
                <td><input type="email" name="send_mail_address" id="send_mail_address" maxlength="50" placeholder="메일주소" value="school.engineer.soft@gmail.com" readonly="readonly"/></td>
            </tr>
            <tr>
                <td><input type="text" name="send_mail_title" id="send_mail_title"  maxlength="30" placeholder="메일제목(30자이내)" style="width: 99%;" value="${result.send_mail_title }"/></td>
            </tr>
            <tr>
                <td><textarea id="send_mail_contents" name="send_mail_contents" maxlength="1000"  placeholder=" 메일내용(1000자이내)" style="height: 400px; width: 100%; resize: vertical; margin: 0; padding: 0;">${result.send_mail_contents }</textarea></td>
            </tr>
        </tbody>
    </table>
    <input class="crc_submit" type="submit" value="메일 발송">
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