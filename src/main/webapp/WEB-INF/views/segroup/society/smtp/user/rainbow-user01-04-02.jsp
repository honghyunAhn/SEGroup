<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
        //정규표현식
        var passwdCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;

        function formCheck() {
            if (isPasswordCorrect() == false) {
                return false;
            }
            return true;
        }

        function isPasswordCorrect() {
            var pw = $('#pw').val();
            var pw_confirm = $('#pw_confirm').val();
            if (pw == "") {
                alert("비밀번호를 입력해 주시기 바랍니다.");
                return false;
            } else if (pw.length < 8) {
                alert("비밀번호는 최소 8자 이상입니다.");
                return false;
            } else if (pw_confirm == "") {
                alert("비밀번호 확인란에 입력해 주시기 바랍니다.");
                return false;
            } else if (pw != pw_confirm) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            } else if (passwdCheck.test(pw_confirm) == false) {
                alert("비밀번호의 형식이 잘못되었습니다.");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
    <div class="container_rainbow">
        <%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point04 sub01_content" id="main">
            <div class="sub-content">
                <div class="section_header">
                    <h3 class="h3">비밀번호 재설정</h3>
                    <p class="margin-top10 fc_999">
                        영문, 숫자, 특수문자를 모두 사용하여 최소 8자이상의 안전한 비밀번호로 변경해주세요.
                    </p>
                </div>

                <div class="section_formStyle">
                    <form class="formStyle find" action="/smtp/user/resetPw" onsubmit="return formCheck();"
                        method="post">
                        <input type="hidden" class="input" name="user_id" value="${user_id }">
                        <input class="input" type="password" id="pw" placeholder="새 비밀번호" name="pw" maxlength="20"
                            autocomplete="off">
                        <input class="input" type="password" id="pw_confirm" placeholder="새 비밀번호 확인" maxlength="20"
                            autocomplete="off">
                        <div class="section_btnWrap d-flex justify_center">
                    		<button id="certi_btn" type="submit" class="btn_normal btn_xlarge bgc_point">확인</button>
                		</div>
                    </form>
                </div>
                
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>

</body>

</html>