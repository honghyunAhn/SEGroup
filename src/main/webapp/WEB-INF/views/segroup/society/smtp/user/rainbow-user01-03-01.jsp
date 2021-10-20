<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">

    	function formCheck() {
    		var email = $('#email').val();
    		var name = $('#name').val();
     		
    		if(name == "") {
    			alert("이름을 입력해주세요.");
    			return false;
    		} else if (email == "") {
    			alert("가입하신 이메일을 입력해주세요.");
    			return false;
    		} 
    		if (isPhoneNumCorrect() == false) { return false; }
    		return true;
    	}
    	
    	function isPhoneNumCorrect() {
    		var phone_num = $('#phone').val();
    		if(phone_num == "") {
    			alert("휴대폰 번호를 입력해주세요.");
    			return false;
    		}   		
     	    $("#phone").val(phone_num);
     	    return true;
    	}
    	
    	$(function() {
    	   	 var message = '${msg}';
    	   	    if(message != "") {
    	   	    	alert(message);
    	   	 	}
    	   	    
    	   	     $("#phone").on("keyup", function() {
    	   	        $(this).val($(this).val().replace(/[^0-9]/g,""));
    	   	    }); 
    	   	});
    </script>
</head>

<body>
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point03 sub01_content" id="main">
            <div class="sub-content">
                <div class="section_header">
                    <h3 class="h3">아이디찾기</h3>
                    <p class="margin-top10 fc_999">아래 회원정보를 입력해주세요.</p>
                </div>

                <div class="section_formStyle">
                    <form class="formStyle login" action="/smtp/user/lostId" method="post" onsubmit="return formCheck();">
                        <input class="input" type="text" id="name" name="name" value="" autocomplete="off" placeholder="이름 입력">
                        <input class="input" type="text" id="email" name="email" value="" autocomplete="off" placeholder="이메일 입력">
                        <input class="input" type="text" id="phone" name="phone" value="" autocomplete="off" placeholder="휴대폰번호 입력(숫자만)">
                        <div class="section_btnWrap d-flex justify_center">
                        <input type="submit" class="btn_normal btn_xlarge bgc_point" value="아이디 찾기">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>

</body>

</html>