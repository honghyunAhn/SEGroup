<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
    	
    	//document.domain = 'softsociety.net'; //(운영서버 적용시)
		$(document).ready(function(){
        	//다음 버튼 숨김(인증을 통해야 이동할 수 있도록)
        	//$("#goSubmit").hide();
        	      	
        	$('#goSubmit').on('click', function(){
        		$('#signUp-check').submit();
        	});
        	
        	//인증하기 버튼
        	$('#validBtn').on('click', function() {
        		popIdentity('phone');
        	});
        });
    	
		//본인 인증 팝업
        //var url = "https://www.mobile-ok.com/popup/common/hscert.jsp"; //운영
        var url = "https://dev.mobile-ok.com/popup/common/hscert.jsp"; //운영
        var DRMOK2_window;
        
        function popIdentity(iden_gbn) {
        	switch(iden_gbn) {
        	case 'phone':	// 휴대 전화
        		window.name = 'sendJsp2';
        		DRMOK2_window = window.open(url+'?cpid=${cpId}&rtn_url=${rtn_url}&req_info=${encReqInfo}', 'DRMOK2_window', 'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no' );
        		DRMOK2_window.focus();
        		if(DRMOK2_window == null){
        		    alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
        		}
        		break;
        	default:
        	}
        }
        
        window.CallVerified = function() {
     		alert('본인인증을 완료하였습니다.');      
     		DRMOK2_window.close();
     		$('#redMessage').html("본인인증을 완료하였습니다.");
     		$("#goSubmit").trigger("click");
     	}
     	
   	</script>
</head>

<body>
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point02" id="main">
            <div class="sub-content user01-02">
                <ul class="processWrap bgc_eee d-flex">
                    <li class="process fc_point"><span class="margin-right10">01</span>본인인증</li>
                    <li class="process"><span class="margin-right10">02</span>약관확인</li>
                    <li class="process"><span class="margin-right10">03</span>정보입력</li>
                    <li class="process"><span class="margin-right10">04</span>가입완료</li>
                </ul>
                <div class="section_header">
                    <h3 class="h3">회원가입 본인인증</h3>
                    <p class="margin-top10 fc_999">
                        본인 명의의 휴대폰 번호로 인증합니다. 타인 명의의 휴대폰 번호는 인증이 불가합니다.<br>본인인증으로 가입여부를 확인 후 신청이 가능합니다.
                    </p>
                </div>
                <div class="section_formStyle">
                    <form class="formStyle join" action="/smtp/user/rainbow-user01-02-02" method="post" id="signUp-check">
                        <!-- 2) 회원가입(1) 본인인증 -->
                        <div class="certif textAlign_center">
                            <button class="btn_normal btn_xlarge bgc_point" id="validBtn" type="button">
                                휴대전화 본인인증 </button>
                            <h5 id="redMessage" class="h5 fc_point margin-top10"></h5>
                        </div>
                        <input type="hidden" name="req_info" value="${encReqInfo}">
                        <input type="hidden" name="rtn_url" value="#">
                        <input type="hidden" name="cpid" value="${cpId}">
                        <input type="hidden" name="newpop" value="Y">

                        <input type="hidden" id="user_phone" name="phone" value="">
                        <input type="hidden" id="user_nm" name="name" value="">
                        <input type="hidden" id="birth_year" name="birth_year" value="">
                        <input type="hidden" id="birth_month" name="birth_month" value="">
                        <input type="hidden" id="birth_date" name="birth_date" value="">
                        <input type="hidden" id="user_sex" name="gender" value="">

                        <input type="hidden" id="veriCi" name="veriCi" value="">
                        <input type="hidden" id="veriDi" name="veriDi" value="">
                        <input type="hidden" id="veriPhone" name="veriPhone" value="">
                        <input type="hidden" id="veriCom" name="veriCom" value="">
                        <input type="hidden" id="veriBirth" name="veriBirth" value="">
                        <input type="hidden" id="veriGender" name="veriGender" value="">
                        <input type="hidden" id="veriNation" name="veriNation" value="">
                        <input type="hidden" id="veriName" name="veriName" value="">
                        <input type="hidden" id="veriNum" name="veriNum" value="">
                        <input type="hidden" id="veriTime" name="veriTime" value="">
                    </form>
                </div>
                <div class="section_btnWrap d-flex justify_center">
                    <button class="btn_normal btn_xlarge bgc_ccc" id="goSubmit" type="submit">다음단계</button>
                </div>
            </div>
			<%@include file="../include/rainbow_footer.jsp"%>
        </div>
	</div>
</body>

</html>