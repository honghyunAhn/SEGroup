<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
    
    	//securityMessage랑 따로 처리함
    	$(function() {
	   		var message = '${msg}';
	   	    if(message != "") {
	   	    	alert(message);
	   	 	}
	   	});
    	
	    $(document).ready(function(){
	    	var message = $("#message").val();
			if (message !== undefined  && message != "" && message.length != 0) {
				alert(message);
			}
	    	
	        // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	        var userInputId = getCookie("userInputId");
	        $("input[name='user_id']").val(userInputId); 
	         
	        if($("input[name='user_id']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	            $("#saveID").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	        }
	         
	        $("#saveID").change(function(){ // 체크박스에 변화가 있다면,
	            if($("#saveID").is(":checked")){ // ID 저장하기 체크했을 때,
	                var userInputId = $("input[name='user_id']").val();
	                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	            }else { // ID 저장하기 체크 해제 시,
	                deleteCookie("userInputId");
	            }
	        });
	         
	        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	        $("input[name='user_id']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	            if($("#saveID").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	                var userInputId = $("input[name='user_id']").val();
	                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	            }
	        });
	    });
    function setCookie(cookieName, value, exdays){
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
        document.cookie = cookieName + "=" + cookieValue;
    }
     
    function deleteCookie(cookieName){
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
    }
    
    function getCookie(cookieName) {
        cookieName = cookieName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cookieName);
        var cookieValue = '';
        if(start != -1){
            start += cookieName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cookieValue = cookieData.substring(start, end);
        }
        return unescape(cookieValue);
    }
    </script>
</head>

<body>
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point03" id="main">
            <div class="sub-content">
                <div class="section_header">
                    <h3 class="h3">레인보우에 오신 것을 환영합니다.</h3>
                    <p class="margin-top10 fc_999">로그인을 위하여 아래 아이디와 비밀번호를 입력해주세요.</p>
                </div>
                <div class="section_formStyle">
                    <form class="formStyle login" action="/smtp/user/login" method="post" id="loginForm">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                         <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION }">
                            <spring:message var="securityMessage" code="${SPRING_SECURITY_LAST_EXCEPTION.message}" />
                            <input type="hidden" id="message" value="${securityMessage}" />
                            <br>
                            <c:remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION" />
                        </c:if>
                        <input class="input" name="user_id" type="text" placeholder="아이디" maxlength="24">
                        <input class="input" name="user_pw" type="password" placeholder="비밀번호">
                        <div class="checkWrap d-flex justify_center">
                            <input class="input check" type="checkbox" name="saveID" id="saveID">
                            <label class="label" for="saveID">아이디 저장</label>
                            <input class="input check" type="checkbox" name="autoLogin" id="autoLogin">
                            <label class="label" for="autoLogin">자동로그인</label>
                        </div>
                        <input type="submit" class="btn_normal btn_xlarge bgc_point" value="로그인">
                    </form>
                    <ul class="division-menuWrap d-flex justify_center">
                        <li><a href="rainbow-user01-02.html">회원가입</a></li>
                        <li class="divBar">&nbsp;|&nbsp;</li>
                        <li><a href="rainbow-user01-03.html">아이디 찾기</a></li>
                        <li class="divBar">&nbsp;|&nbsp;</li>
                        <li><a href="rainbow-user01-04.html">비밀번호 찾기</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>

</body>

</html>