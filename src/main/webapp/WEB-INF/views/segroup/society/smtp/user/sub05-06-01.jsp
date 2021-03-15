<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
	<!-- 레인보우 기본세팅 -->
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript">
	
	$(function(){
	});
	$(document).ready(function(){
		//원래 전화번호 표시 
		var tel1 =$("#tel1_hidden").val();
		if(tel1!=null && tel1!=''){
	        $("#tel1 option[value="+tel1+"]").attr("selected","selected");
		}
		$('.d-none-msg').attr('hidden','hidden');
	});
	//정규표현식
 	var userIdCheck = /^[A-Za-z0-9_\-]{6,20}$/;
	var passwdCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;	
  	var birthCheck = /(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;

		function formCheck() {
			if (isNameCorrect() == false) { return false; }
			if (isSexSelected() == false) { return false; }
			if (isIdCorrect() == false) { return false; }
			if (isPasswordCorrect() == false) { return false; }
			if (isBirthCorrect() == false) { return false; }
			if (isEmailCorrect() == false) { return false; }
			if (isPhoneNumCorrect() == false) { return false; }
			if (isAddressCorrect() == false) { return false; }
			
			return true;
		}
		
		function isIdCorrect() {
			var id = $('#id').val();
			if(id=="") {
				alert("아이디를 입력해 주시기 바랍니다.");
				return false;
			}else if(userIdCheck.test(id)==false) {
				alert("아이디의 형식이 잘못되었습니다.");
				return false;
			}else if($('#id').attr("check_result") == "fail") {
				alert("중복체크를 진행해주세요.");
				return false;
			}
			return true;
		}
		
		function isPasswordCorrect() {
			var pw = $('#pw').val();
			var pw_confirm = $('#pw_confirm').val();
			if(pw=="") {
				alert("비밀번호를 입력해 주시기 바랍니다.");
				return false;
			} else if(pw.length<8) {
				alert("비밀번호는 최소 8자 이상입니다.");
				return false;
			} else if(pw_confirm=="") {
				alert("비밀번호 확인란에 입력해 주시기 바랍니다.");
				return false;
			} else if(pw!=pw_confirm) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			} else if (passwdCheck.test(pw_confirm) == false) {
				alert("비밀번호의 형식이 잘못되었습니다.");
				return false;
			}
			return true;
			
		}
		
		function isNameCorrect() {
			var name = $('#name').val();
			if(name=="") {
				alert("이름을 입력하여 주시기 바랍니다.");
				return false;
			}
			return true;
		}
		
		function isBirthCorrect() {
			var birth_day = $('#birth_day').val();
			if(birth_day == "") {
				alert("생년월일을 입력하여 주시기 바랍니다.");
				return false;
			}else if (birthCheck.test(birth_day)==false) {
				alert("생년월일 형식에 맞지 않습니다.");
				return false;
			}
			return true;
		}
		
		function isPhoneNumCorrect() {
			 $('#phone1').removeAttr("disabled");
			 $('#phone2').removeAttr("disabled");
			 $('#phone3').removeAttr("disabled");
			var f = document.getElementById("saveForm");
			var tel1 = $('#tel1').val();
			var tel2 = $('#tel2').val();
			var tel3 = $('#tel3').val();
			var phone1 = $('#phone1').val();
			var phone2 = $('#phone2').val();
			var phone3 = $('#phone3').val();
			
			if(!(tel1=="" && tel2=="" && tel3=="")){				
				if(tel1=="" || tel2 == "" || tel3 == "") {
					alert("자택번호를 확인해 주시기 바랍니다.");				
					return false;
				}
			}
			
			if(phone1 == "" || phone2 == "" || phone3 == "") {
				alert("휴대폰 번호를 빈칸없이 입력해 주시기 바랍니다.");
				return false;
			}
			var phone = phone1 + phone2 + phone3;
			var tel = tel1 + tel2  + tel3;
			$(f).find("input[name='phone']").val(phone);
			$(f).find("input[name='tel']").val(tel);

			return true;
		}
		
		function isEmailCorrect() {
			if($('#email1').attr("disabled")!="disabled"){
				alert("중복확인을 해주시기 바랍니다."	);
				return false;
			}
			 $('#email1').removeAttr("disabled");
			 $('#email2').removeAttr("disabled");
			 $('#email3').removeAttr("disabled");
			var f = document.getElementById("saveForm");
			var email1 = $('#email1').val();
			var email2 = $('#email2').val();
			var email3 = $('#email3 option:selected').val();
			 
			var belong_to = $('#belong_to').val();
			if(email1=="") {
				alert("이메일을 입력하여 주시기 바랍니다.");
				return false;
			}else if(email2 == "" &&  email3 == "") {
				alert("이메일을 입력하여 주시기 바랍니다.");
				return false;
			}
			var email = email1 + "@" + (email2==""?email3:email2);
			$(f).find("input[name='email']").val(email);
			return true;
		}
		/*
		function isAddressCorrect() {
			var post_code = $('#post_code').val();
			var addr1 = $('#addr1').val();
			if (post_code=="") {
				alert("우편번호를 입력하여 주시기 바랍니다.");
				return false;
			} else if(addr1=="") {
				alert("주소를 입력하여 주시기 바랍니다.");
				return false;
			}
			return true;
		}
		*/
		function isSexSelected() {
			var gender = $('input:radio[name="gender"]:checked').val();
			if(gender===undefined) {
				alert("성별을 선택해 주시기 바랍니다.");
				return false;
			}
			return true;
		}
		
		function searchPostcode() {
			 new daum.Postcode({
	            oncomplete: function(data){
            	   // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;						                    
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
			                 
                  //alert("주소가 선택되었습니다. 상세주소를 입력해 주세요.");			
	                
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){	
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    if(addr !==''){
		                        addr  += extraAddr;
		                      }
		                 
		                
	                } else {
	                    	document.getElementById("addr1").value = '';
	                }
		                
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('post_code').value = data.zonecode;
	                document.getElementById("addr1").value = addr;
	             }
	        }).open( );
		}
		
		//이메일 중복확인
		function ajaxCheckEmailDuplicated(){  			
			var original_email = $("#original_email").val();
	        var new_email = $("#email1").val() + "@" + ( $("#email2").val()==""? $("#email3 option:selected").val() : $("#email2").val() );
	    
	        if(original_email==new_email){
		        	var duplCheck = confirm("사용 가능합니다. 사용하시겠습니까?");        	
			        	if(duplCheck){
			        		$("#email1").attr("disabled","disabled");
			        		$("#email2").attr("disabled","disabled");
			        		$("#email3").attr("disabled","disabled");
			        	}else{
			        		$("#email1").removeAttr("disabled");
			        		$("#email2").removeAttr("disabled");
			        		$("#email3").removeAttr("disabled");
			        	}		        	
	        }else{	     	   
	        	var data = {
						email: new_email
				};
		        	$.ajax({
		        		url: '<c:url value="/member/ajaxCheckEmailDuplicated" />'	
		        		, data: data		        	 
		        		, success: function(isDuplicated){
		        			if(isDuplicated){
		        				alert("중복입니다. 다시 시도해주세요.");
		        				$("#email1").removeAttr("disabled");
				        		$("#email2").removeAttr("disabled");
				        		$("#email3").removeAttr("disabled");
		        			}else{
		        				var duplCheck = confirm("사용 가능합니다. 사용하시겠습니까?");
		        				if(duplCheck){
		        					$("#email1").attr("disabled","disabled");
		    		        		$("#email2").attr("disabled","disabled");
		    		        		$("#email3").attr("disabled","disabled");
		        				}else{
		        					$("#email1").removeAttr("disabled");
		    		        		$("#email2").removeAttr("disabled");
		    		        		$("#email3").removeAttr("disabled");
		        				}
		        			}
		        		}
		        		, error:function(){
		        		   alert("중복 확인 과정 중 에러 발생");
		        		}
		        	})	         		         
	        }			
		}
		
		//전화번호 변경시 본인인증 
		var url = 'http://dev.mobile-ok.com/popup/common/hscert.jsp';  
		var DRMOK_window;
      
		function openDRMOKWindow(){			
				window.name = 'sendJsp';
				DRMOK_window = window.open(url+'?cpid=${cpId}&rtn_url=${rtn_url}&req_info=${encReqInfo}', 'DRMOKWindow', 'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no' );
				DRMOK_window.focus();	   
				if(DRMOK_window == null){
					alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
				}
		}	
		
		//본인인증 완료 후 변경된 전화번호 적용 
		 window.CallVerified = function() {
	     		alert('본인인증을 완료하였습니다.');      
	     		DRMOK_window.close();	     		 
		     	var veriPhone = $("#veriPhone").val();		     	 
		     	var veriPhone1 = veriPhone.substring(0,3);
		     	var veriPhone2 = veriPhone.substring(3,7);
		     	var veriPhone3 = veriPhone.substring(7,11);
		     	 $("#phone1 option").each(function(i){
		     		 var thisVal = $(this).attr("value");		     		
		        	 if(thisVal==veriPhone1){		        	 
		        		 $(this).attr("selected","selected");
		        	 }
		        })
		     	$("#phone2").val(veriPhone2);
		        $("#phone3").val(veriPhone3); 	 
	     	}
		
	 
	</script>
</head>
<body>
	<div class="container_rainbow">
		<!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp"%>
        <div class="content sub-content sub01_content" id="main">
        	<div class="section section_sub01-02-01">
                <acrticle class="signUp-inputInfo">
                    <header class="article-title d-flex">
                        <div class="titleBar-hdr h4">회원정보수정</div>
                        <p class="fc_666 margin-left10">
                            *표시가 된 곳은 필수 입력항목입니다.
                        </p>
                    </header>
                </acrticle>
                <!--
                    span.retrieve : 저장된 데이터 불러오기
                -->
                <form action="/smtp/user/updateUser" id="saveForm" class="formStyle join" method="post" onsubmit="return formCheck();">
                	<ul></ul>
                    <div class="d-flex">
                        <label class="label" for="user-name">* 성명</label>
                        <div class="retrieve user-name">
	                        <input class="input" type="text" id="name" name="name" maxlength="10" value="${myInfo.USER_NM}" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="user-sex">* 성별</label>
                        <div class="retrieve user-sex d-flex">
							<label><input type="radio" name="gender" value="A0000" <c:if test="${myInfo.USER_SEX == 'A0000'}">checked="checked"</c:if> <c:if test="${not empty memberForm.gender and memberForm.gender != 'M'}">disabled="disabled"</c:if> onclick="return(false);"> 남자</label>
							<label><input type="radio" name="gender" value="A0001" <c:if test="${myInfo.USER_SEX == 'A0001'}">checked="checked"</c:if> <c:if test="${not empty memberForm.gender and memberForm.gender != 'F'}">disabled="disabled"</c:if> onclick="return(false);"> 여자</label>
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="userId">* 아이디</label>
                        <div class="userID d-flex">
                            <input class="input" type="text" name="id" maxlength="12" value="${myInfo.USER_ID}" readonly>
                        </div> 
                    </div>
                    <div class="d-flex">
                        <label class="label mh80" for="userPw">* 비밀번호</label>
                        <div class="userPw d-flex">
	                       <input class="input" type="password" id="pw" name="pw" minlength="8" maxlength="30" autocomplete="off" value="">
	                        &nbsp;<span class="explan">※ 영문, 숫자, 특수 기호(!, @, # 등)을 모두 사용하여 최소 8자 이상</span>
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label mh80" for="userPwCheck">* 비밀번호확인</label>
                        <div class="userPwCheck d-flex">
                             <input class="input" type="password" id="pw_confirm" name="pw_confirm" minlength="8" maxlength="30" autocomplete="off">
                            <div class="d-none-msg">
                                <p class="true-msg">일치합니다.</p>
                            </div>
                            <div class="d-none-msg">
                                <p class="false-msg cDanger">입력하신 비밀번호와 일치하지 않습니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex">
                         <label class="label" for="user-birth">* 생년월일</label>
                         <div class="retrieve user-birth d-flex">
	                        <input class="input user-birth" type="text" value="${myInfo.USER_BIRTH}" id="birth_day" name="birth_day" placeholder="YYYY-MM-DD" autocomplete="off" readonly="readonly">
	                 		<!-- &nbsp;<span class="explan">※ 1990-01-01 형식으로 입력</span> -->
                         </div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="email01">* 이메일</label> 
                       <div class="email d-flex">
                            <input class="input email01" type="text" id="email1" value="${myInfo.EMAIL1 }" autocomplete="off">
                            <span>&nbsp;@&nbsp;</span>
                            <input class="input email02" type="text" id="email2" value="${myInfo.EMAIL2 }"  autocomplete="off">
                            <!-- 이메일 option 클릭시 email02에 값 입력되는 것 알아보기 -->
                            <select class="select ml10" id="email3">
                                <option value="" selected>직접입력</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                            </select> <button class="btn_normal input-btn btn_pp" type="button" onclick="ajaxCheckEmailDuplicated();">중복확인</button>
                            <div class="d-none-msg">
                                <p class="false-msg cDanger">이메일을 입력해주세요.</p>
                            </div>   
                            <input type="hidden" id="original_email" value="${myInfo.EMAIL1}@${myInfo.EMAIL2 }">                      
                            <input type="hidden" id="email" name="email" value="">
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="work-school">직장/학교명</label>
                         <input class="input work-school" type="text" name="belong_to" id="belong_to" value="${myInfo.USER_BELONG_TO }"autocomplete="off">
                    </div>
                    <div class="d-flex">
                        <label class="label" for="phone">자택(회사)번호</label>
                        <div class="phone d-flex">
                            <select class="select phone1" id="tel1" >
                                <option value="" >선택</option>
                                <option value="02" >02</option>
                                <option value="031">031</option>
                                <option value="032">032</option>
                                <option value="033">033</option>
                                <option value="041">041</option>
                                <option value="042">042</option>
                                <option value="043">043</option>
                                <option value="044">044</option>
                                <option value="051">051</option>
                                <option value="052">052</option>
                                <option value="053">053</option>
                                <option value="054">054</option>
                                <option value="055">055</option>
                                <option value="061">061</option>
                                <option value="062">062</option>
                                <option value="063">063</option>
                                <option value="064">064</option>
                                <!-- 인터넷전화(070) / 평생전화(050) -->
                                <option value="070">070</option>
                                <option value="050">050</option>
                            </select>
                            <input type="hidden" id="tel1_hidden" value="${myInfo.TEL1 }">
                            <span>&nbsp;-&nbsp;</span>
                            <input class="input phone2 w100" id="tel2" type="number" pattern="[0-9]*" value="${myInfo.TEL2 }" maxlength="4" autocomplete="off">
                            <span>&nbsp;-&nbsp;</span>
                            <input class="input phone3 w100" id="tel3" type="number" pattern="[0-9]*" value="${myInfo.TEL3 }" maxlength="4" autocomplete="off">
                            <input type="hidden" id="tel" name="tel" value="">                        
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="mbile-phone">* 휴대전화</label>
                        <div class="phone mobile-phone d-flex">
                            <select class="select mobile-phone1" id="phone1" disabled="disabled">
                                <option value="선택">선택</option>
                                <option value="010" selected>010</option>
                                <option value="011">011</option>
                                <option value="016">016</option>
                                <option value="017">017</option>
                                <option value="019">019</option>
                            </select>
                            <span>&nbsp;-&nbsp;</span>
                            <input class="input mobile-phone2 w100" id="phone2" type="number" pattern="[0-9]*" value="${myInfo.PHONE2 }" maxlength="4" autocomplete="off" disabled="disabled">
                            <span>&nbsp;-&nbsp;</span>
                            <input class="input mobile-phone3 w100" id="phone3" type="number" pattern="[0-9]*" value="${myInfo.PHONE3 }" maxlength="4" autocomplete="off" disabled="disabled">
                            <button class="btn_normal input-btn btn_pp" type="button" onclick="openDRMOKWindow();">전화번호 변경</button>
                            <div class="d-none-msg">
                                <p class="false-msg cDanger">전화번호를 입력해주세요.</p>
                            </div>
                            <input type="hidden" id="phone" name="phone" value="">
                            <input type="hidden" id="veriPhone" > 
                        </div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="adress"> 주소</label>
                         <div class="adressWrap">
                            <div class="adress adress1 d-flex">
                                <input class="input" type="text" id="post_code" name="post_code" value="${myInfo.USER_ZIPCODE}" autocomplete="off">
                                <button class="btn_normal input-btn btn_pp" type="button" onclick="searchPostcode();">우편번호 검색</button>
                                <div class="d-none-msg">
                                    <p class="false-msg cDanger">우편번호를 입력해주세요.</p>
                                </div>
                            </div>
                            <div class="adress adress2">
                                <input class="input w355" type="text" id="addr1" name="addr1" value="${myInfo.USER_ADDR1}" placeholder="기본주소" autocomplete="off">
                                <div class="d-none-msg">
                                    <p class="false-msg cDanger">주소를 입력해주세요.</p>
                                </div>
                            </div>
                            <div class="adress adress3">
                                <input class="input w355" type="text" name="addr2" value="${myInfo.USER_ADDR2}" placeholder="상세주소" autocomplete="off">
                                <div class="d-none-msg">
                                    <p class="false-msg cDanger">상세주소를 입력해주세요.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                <div class="button-wrap d-flex">
                    <input type="submit" class="margin-left10 btn_normal btn_large btn_pp_bg" value="수정완료">
                    <a href="/smtp/user/sub05-07">
	                    <input type="button" class="margin-left10 btn_normal btn_large btn_pp btn-agree btn-wh" value="회원탈퇴">
                    </a>
                </div>
                </form>
            </div>
        </div>
        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
	</div>
</body>
</html>