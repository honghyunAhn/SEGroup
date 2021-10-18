<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$('#mainBtn').on('click', function(){
    			location.href='/rainbow';
    		});
    	});
    </script>
</head>

<body>
    <div class="container_rainbow">
        <%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point02" id="main">
            <div class="sub-content user01-02">
                <ul class="processWrap bgc_eee d-flex">
                    <li class="process"><span class="margin-right10">01</span>본인인증</li>
                    <li class="process"><span class="margin-right10">02</span>약관확인</li>
                    <li class="process"><span class="margin-right10">03</span>정보입력</li>
                    <li class="process fc_point"><span class="margin-right10">04</span>가입완료</li>
                </ul>
                <div class="section_header">
                    <h3 class="h3">레인보우 가입을 환영합니다.</h3>
                    <p class="margin-top10 fc_999">
                        회원에게 주어지는 각종 서비스 혜택을 받으실 수 있습니다.
                        <br>레인보우만의 프리미엄 교육 서비스 특권을 누려보세요.
                    </p>
                </div>
                <div class="section_btnWrap d-flex justify_center">
                    
                    <button class="btn_normal btn_xlarge bgc_point" id="mainBtn">메인으로</button>
                </div>
            </div>
            <%@include file="../include/rainbow_footer.jsp"%>
        </div>
	</div>
</body>

</html>