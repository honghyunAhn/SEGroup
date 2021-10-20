<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
    	function goLogin(){
    		location.href="/smtp/user/rainbow-user01-01";
    	}
    	
    	function goPassword(){
    		$("#goSearch").submit();
    	}
    </script>
</head>

<body>
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point03 sub01_content" id="main">
            <div class="sub-content">
                <div class="section_header">
                    <h3 class="h3">아이디 조회 결과</h3>
                    <p class="margin-top10 fc_999">입력하신 정보와 일치하는 아이디는 아래와 같습니다.</p>
                </div>

                <div class="section_formStyle">
                    <form class="formStyle find" action="/smtp/user/rainbow-user01-04-01" method="post" id="goSearch">
                        <div class="result">${user_id}</div>
                        <input type="hidden" value="${user_id}" name="user_id" />
                    </form>
                </div>
                <div class="section_btnWrap d-flex justify_center">
                    <button class="btn_normal btn_xlarge bgc_ccc" type="button" onclick="goPassword()">비밀번호찾기</button>
                    <button type="button" onclick="goLogin();" class="btn_normal btn_xlarge bgc_point">로그인</button>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>

</body>

</html>