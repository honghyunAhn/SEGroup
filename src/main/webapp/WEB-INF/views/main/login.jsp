<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<sec:authentication property="principal" var="principal" />
<c:set var="contextPathsub" value='${fn:split(requestScope["javax.servlet.forward.request_uri"],"/")}'/>
<c:set var="islogin" value="false"/>
<sec:authorize access="isAuthenticated()"><c:set var="islogin" value="true"/></sec:authorize>
<c:set var="isMobile" value="false"/>
<c:if test="${currentDevice.mobile }"><c:set var="isMobile" value="true"/></c:if>




	<div class="skip-navigation">
        <!--웹접근성/content-->
        <p><a href="#main">콘텐츠 바로가기</a></p>
    </div>

    <div class="container-sub" id="main">
        <!-- sub00로그인/회원가입-include -->
        <t:insertDefinition name="loginmenu"/>
        <div class="sub-content">
            <!-- 현재 페이지 위치 표시 -->
            <div class="page-locationWrap">
                <ul class="page-location">
                    <!--
            home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
            -->
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="<c:url value="/loginPage"/>">로그인/회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="/loginPage">로그인</a></li>
                    <!-- <li class="img-icon chevron-right"></li>
                <li class="section-menu"><a href="">로그인</a></li> -->
                </ul>
                <div class="img-icon chevron-right"></div>
                <!-- <div class="sub-content sub00-01"></div> -->
            </div>

            <div class="header">
                <div class="titleBar"></div>
                <h3 class="h3">로그인</h3>
            </div>
            <div class="section sub00-01">
                <div class="header">
                    <strong class="h4">레인보우에 오신 것을 환영합니다.</strong>
                    <h5 class="fz14 c999">로그인을 위하여 아래 아이디와 비밀번호를 입력하여 주십시오.</h5>
                </div>
                <div class="loginWrap enterWrap">
                    <form id="tloginForm2" method="post">  <!-- action="/user/signin" -->
                        <input type="text" placeholder="아이디" id="username" name="username" value="${cookieValue}" maxlength="25">
                        <input type="password" placeholder="비밀번호" name="password" id="password">
                        <div class="checkWrap">
                            <label><input class="check" type="checkbox"  name="saveIdChecked" value="Y">아이디 저장</label>
                        </div>
                        <label><input type="checkbox" name="sslLoginEnable"> 보안 로그인 사용</label>
                        <input type="button" onclick="gLogin('tloginForm2')" class="blue-btn button" value="로그인">
                    </form>
                    <ul class="division-menuWrap d-flex">
                        <li><a href="<c:url value="/member/join1"/>" class="register">회원가입</a></li> 
                        <li class="divBar">|</li>
                        <li><a href="<c:url value="/member/findId"/>">아이디찾기</a></li>
                        <li class="divBar">|</li>
                        <li><a href="<c:url value="/member/findPw"/>">비밀번호찾기</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
    <!-- top button -->
    <img class="top-btn" src="img/top-btn.png" alt="최상단스크롤" width="40">
    
<script type="text/javascript">
// action 처리 메시지
var actionMessage = '<c:out value="${actionMessage }"/>';<%-- controller 메시지 --%>
if (!isEmpty(actionMessage)) alert(actionMessage);

var globals = {
	islogin: ${islogin},
	isMobile: ${isMobile},
	sslAvail: '<spring:eval expression="@config['https.avail']"/>' == 'Y',
	sslPort: '<spring:eval expression="@config['https.port']"/>'
};
function gLogin(formId) {
	var isSecureChecked = $('#'+formId).find('input[name="sslLoginEnable"]').is(':checked');
	var isCurrentSecure = (location.protocol == 'https:');

	var loginUrl = '<c:url value="/user/signin"/>';
	if (globals.sslAvail && isSecureChecked) {
		loginUrl = getSecureUrl(loginUrl,globals.sslPort);
	}

	// 보인로그인 여부에 따라 ajax login이  유효하지 않음
	if (globals.sslAvail && isSecureChecked && !isCurrentSecure) {
		$('#'+formId).attr('action', loginUrl);
		$('#'+formId).submit();
	} else {
		$.ajax({
			url : loginUrl,
			data: $('#'+formId).serialize(),  
			method: 'POST',
			type: 'POST',
			dataType : 'json'/*,
			crossDomain: true,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("Accept", "application/json");
				xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
			} */
		}).done(function(responseData) {
			var error = responseData.error;
			var code = responseData.code;
			
			var message = responseData.message;
			if (error) {
				if (code === 403 || code === 201){
					alert(message);
				} else {
					alert('알수 없는 오류가 발생하였습니다.');
				}

			} else {
				var redirectUrl = responseData.data.redirectUrl;
				location.replace(redirectUrl);
			}
		});
	}
};

var idenWinForLogin;
function gPopCertForLogin() {
	$('#tloginForm').find('input[name="certkey"]').val('');
	var url = '<c:url value="/iden/nice/checkplusForCertLogin"/>?iden_callback_success=onIdentitySuccessForLogin';
	if (globals.sslAvail) {
		url = getSecureUrl(url,globals.sslPort);
	}
	idenWinForLogin = popIdenWindow(url, 422, 660);
}

function onIdentitySuccessForLogin(iden_gbn, data) {
	var di = data.di;
	idenWinForLogin.close();

	var isCurrentSecure = (location.protocol == 'https:');

	var loginUrl = '<c:url value="/user/certsignin"/>';
	if (globals.sslAvail) {
		loginUrl = getSecureUrl(loginUrl,globals.sslPort);
	}

	// 보인로그인 여부에 따라 ajax login이  유효하지 않음
	if (globals.sslAvail && !isCurrentSecure) {
		var formId = 'tloginForm';
		$('#'+formId).find('input[name="certkey"]').val(di);
		$('#'+formId).attr('action', loginUrl);
		$('#'+formId).submit();
	} else {
		$.ajax({
			url : loginUrl,
			data: {'certkey':di},
			method: 'POST',
			type: 'POST',
			dataType : 'json'/* ,
			crossDomain: true,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("Accept", "application/json");
				xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
			} */
		}).done(function(responseData) {

			var error = responseData.error;
			var code = responseData.code;
			var message = responseData.message;

			if (error) {
				if (code === 403 || code === 201){
					alert(message);
				} else {
					alert('알수 없는 오류가 발생하였습니다.');
				}

			} else {
				var redirectUrl = responseData.data.redirectUrl;
				location.replace(redirectUrl);
			}
		});
	}
}

$(document).ready(function() {
	// 비밀번호 enter시 로그인 진행
	$('#tloginForm input[name="password"]').keypress(function (e) {
		if (e.which == 13) {
			gLogin('tloginForm');
		}
	});

	// 인기검색어
	if($('.hitkeywords').length > 0) {
		$.getJSON('<c:url value="/ajaxHitKeywords"/>', function(data) {
			var keywords = data.keywords;
			for(var i=0; i<keywords.length; i++) {
				k = keywords[i];
				$('.hitkeywords').append('<a href="<c:url value="/search"/>?keyword='+encodeURIComponent(k)+'" title="'+k+'">'+k+'</a> ');
			}
		});
	}
});
</script>
