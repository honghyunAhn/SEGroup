<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <? include 'include/rainbow_head.html' ?>
    <!-- 기존 레인보우사이트 text/javascript 복사 -->
    <!-- <script type="text/javascript">
        //정규표현식
        var userIdCheck = /^[A-Za-z0-9_\-]{6,20}$/;
        var passwdCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
        var birthCheck = /(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
        var numCheck = /^[0-9]*$/;
        function formCheck() {
            if (isNameCorrect() == false) {
                return false;
            }
            if (isSexSelected() == false) {
                return false;
            }
            if (isIdCorrect() == false) {
                return false;
            }
            if (isPasswordCorrect() == false) {
                return false;
            }
            if (isBirthCorrect() == false) {
                return false;
            }
            if (isEmailCorrect() == false) {
                return false;
            }
            if (isPhoneNumCorrect() == false) {
                return false;
            }
            if (isAddressCorrect() == false) {
                return false;
            }
    
            return true;
        }
        
        function isIdCorrect() {
            var f = document.getElementById("saveForm");
            var id = $('#id').val();
            $(f).find("#user_id").val(id);
            if (id == "") {
                alert("아이디를 입력해 주시기 바랍니다.");
                return false;
            } else if (userIdCheck.test(id) == false) {
                alert("아이디의 형식이 잘못되었습니다.");
                return false;
            } else if ($('#id').attr("check_result") == "fail") {
                alert("중복체크를 진행해주세요.");
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
        
        function isNameCorrect() {
            var name = $('#name').val();
            if (name == "") {
                alert("이름을 입력하여 주시기 바랍니다.");
                return false;
            }
            return true;
        }
        
        function isBirthCorrect() {
            var f = document.getElementById("saveForm");
            var birth_year = $("#birth_year").val();
            var birth_month = $("#birth_month").val();
            var birth_date = $("#birth_date").val();
            var birth_day = birth_year + "-" + birth_month + "-" + birth_date;
            var veriBirth = document.getElementById("hidden_birth_day").value;
            $(f).find("input[name='birth_day']").val(birth_day);
            $(f).find("input[name='veriBirth']").val(veriBirth);
            return true;
        }
        
        function isPhoneNumCorrect() {
            var f = document.getElementById("saveForm");
            var tel1 = $('#tel1').val();
            var tel2 = $('#tel2').val();
            var tel3 = $('#tel3').val();
            var phone1 = $('#phone1').val();
            var phone2 = $('#phone2').val();
            var phone3 = $('#phone3').val();
            if (phone1 == "" || phone2 == "" || phone3 == "") {
                alert("휴대폰 번호를 빈칸없이 입력해 주시기 바랍니다.");
                return false;
            }
            var phone = phone1 + phone2 + phone3;
            if (numCheck.test(phone) == false) {
                alert("휴대폰 번호는 숫자만 입력가능합니다.");
                return false;
            }
            var veriPhone = phone1 + phone2 + phone3;
            var tel = tel1 + '-' + tel2 + '-' + tel3;
            $(f).find("input[name=veriPhone]").val(veriPhone);
            $(f).find("input[name='phone']").val(phone);
            $(f).find("input[name='tel']").val(tel);
            return true;
        }
        
        function isEmailCorrect() {
            var f = document.getElementById("saveForm");
            var email1 = $('#email1').val();
            var email2 = $('#email2').val();
            var email3 = $('#email3').val();
            var belong_to = $('#belong_to').val();
            if (email1 == "") {
                alert("이메일을 입력하여 주시기 바랍니다.");
                return false;
            } else if (email2 == "" && email3 == "") {
                alert("이메일을 입력하여 주시기 바랍니다.");
                return false;
            }
            var email = email1 + "@" + (email2 == "" ? email3 : email2);
            $(f).find("input[name='email']").val(email);
            return true;
        }
        
        function isAddressCorrect() {
            var post_code = $('#post_code').val();
            var addr1 = $('#addr1').val();
            if (post_code == "") {
                alert("우편번호를 입력하여 주시기 바랍니다.");
                return false;
            } else if (addr1 == "") {
                alert("주소를 입력하여 주시기 바랍니다.");
                return false;
            } else if (addr2 == "") {
                alert("상세주소를 입력하여 주시기 바랍니다.");
                return false;
            }
            return true;
        }
        
        function isSexSelected() {
            var gender = $('input:radio[name="gender"]:checked').val();
            if (gender === undefined) {
                alert("성별을 선택해 주시기 바랍니다.");
                return false;
            }
            return true;
        }
        
        function searchPostcode() {
            new daum.Postcode({
                oncomplete : function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                    // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수
    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
    
                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if (data.userSelectedType === 'R') {
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            extraAddr += (extraAddr !== '' ? ', '
                                    + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if (extraAddr !== '') {
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        if (addr !== '') {
                            addr += extraAddr;
                        }
    
                    } else {
                        document.getElementById("addr1").value = '';
                    }
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById("post_code").value = data.zonecode;
                    document.getElementById("addr1").value = addr;
    
                    // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                    /*      if(roadAddr !== ''){
                             document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                         } else {
                             document.getElementById("sample4_extraAddress").value = '';
                         } */
    
                }
            }).open();
        }
        
        $(function() {
    
            //아이디 중복 체크
            $('#checkDuplId').on('click', function() {
                var id = $('#id').val();
                if (id == "") {
                    alert("아이디를 먼저 입력해 주세요.");
                    return false;
                } else if (userIdCheck.test(id) == false) {
                    alert("아이디의 형식이 잘못되었습니다.");
                    return false;
                }
                $.ajax({
                    type : "POST",
                    url : "<c:url value='/member/ajaxCheckDuplId' />",
                    data : {
                        "id" : id
                    },
                    async : false,
                    success : function(result) {
                        if (result.DUPL_YN == 'N') { //아이디가 없음.
                            alert("사용가능한 아이디 입니다.");
                            $('#id').attr("check_result", "success");
                        } else {
                            alert("이미 사용중인 아이디입니다. 다른 아이디를 입력해 주시기 바랍니다.");
                            $('#id').val("");
                        }
                    },
                    error : function(e) {
                        alert(e.responseText);
                    }
                });
            });
        
            //본인인증 완료시 성별 표시
            var hiddenGender = document.getElementById("hiddenGender").value;
            $(":radio[name='gender']").each(function() {
                if (this.value == hiddenGender) {
                    this.checked = true;
                }
            })
            $(":radio[name='gender']").prop("disabled", true);

            //본인인증 완료시 생일 표시
            var hiddenBirthday = document.getElementById("hidden_birth_day").value;
            $("#birth_year").val(hiddenBirthday.substring(0, 4));
            $("#birth_month").val(hiddenBirthday.substring(4, 6));
            $("#birth_date").val(hiddenBirthday.substring(6, 8));
            $("#birth_year").prop("disabled", true);
            $("#birth_month").prop("disabled", true);
            $("#birth_date").prop("disabled", true);
        });
    </script> -->
</head>

<body>
    <div class="container_rainbow">
        <? include 'include/rainbow_header.html' ?>
        <div class="content course-point02" id="main">
            <div class="sub-content user01-02">
                <ul class="processWrap bgc_eee d-flex">
                    <li class="process"><span class="margin-right10">01</span>본인인증</li>
                    <li class="process"><span class="margin-right10">02</span>약관확인</li>
                    <li class="process fc_point"><span class="margin-right10">03</span>정보입력</li>
                    <li class="process"><span class="margin-right10">04</span>가입완료</li>
                </ul>
                <div class="section_header">
                    <h3 class="h3">회원가입 정보입력</h3>
                    <p class="margin-top10 fc_999">
                        *표시가 된 곳은 필수 입력항목입니다.
                        입력하신 개인정보는 회원님의 동의 없이 제 3자에게 제공되지 않으며, 개인정보처리방치에 따라 보호되고 있습니다.
                        <br>입력하신 정보는 본인확인용으로 사용되며 회원가입이 완료되면 사용자 확인을 위해 회원정보 고유의 값으로 저장됩니다.
                    </p>
                </div>
                <div class="section_formStyle join">
                    <!-- 2) 회원가입(2) 약관 동의 -->
                    <form action="/smtp/user/joinMember" id="saveForm" class="formStyle" method="post"
                        onsubmit="return formCheck();">
                        <!-- .retrieve : 저장된 데이터 불러오기 -->
                        <input type="hidden" id="veriCi" name="veriCi" value="${userVeri.veriCi }">
                        <input type="hidden" id="veriDi" name="veriDi" value="${userVeri.veriDi }">
                        <input type="hidden" id="veriPhone" name="veriPhone">
                        <input type="hidden" id="veriCom" name="veriCom" value="${userVeri.veriCom }">
                        <input type="hidden" id="veriBirth" name="veriBirth" value="${userVeri.veriBirth }">
                        <input type="hidden" id="veriGender" name="veriGender" value="${userVeri.veriGender }">
                        <input type="hidden" id="veriNation" name="veriNation" value="${userVeri.veriNation }">
                        <input type="hidden" id="veriName" name="veriName" value="${userVeri.veriName }">
                        <input type="hidden" id="veriNum" name="veriNum" value="${userVeri.veriNum }">
                        <input type="hidden" id="veriTime" name="veriTime" value="${userVeri.veriTime }">
                        <input type="hidden" id="user_id" name="user_id">
                        <div class="formWrap">
                            <label class="label" for="user-name">* 성명</label>
                            <div class="retrieve user-name">
                                <input class="input w300" type="text" id="name" name="name" maxlength="10"
                                    value="${userVeri.veriName}" readonly="readonly" />
                            </div>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="user-sex">* 성별</label>
                            <div class="retrieve user-sex d-flex">
                                <label><input type="radio" name="gender" value="A0000" checked> 남자</label>
                                <label class="margin-left10"><input type="radio" name="gender" value="A0001"> 여자</label>
                                <input type="hidden" id="hiddenGender" name="gender" value="${userVeri.veriGender}">
                                <p class="alert" style="display: none"></p>
                            </div>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="user-birth">* 생년월일</label>
                            <div class="retrieve user-birth d-flex">
                                <input class="input user-birth w300" type="text" id="birth" maxlength="8" placeholder="YYYYMMDD">
                            </div>
                            <!-- <div class="retrieve user-birth d-flex">
                                <input class="input user-birth w100" type="text" id="birth_year" maxlength="4">
                                <span>&nbsp;년&nbsp;</span>
                                <input class="input user-birth w100" type="text" id="birth_month" maxlength="2">
                                <span>&nbsp;월&nbsp;</span>
                                <input class="input user-birth w100" type="text" id="birth_date" maxlength="2">
                                <span>&nbsp;일&nbsp;</span>
                                <input type="hidden" id="hidden_birth_day" value="${userVeri.veriBirth}">
                                <input type="hidden" name="birth_day">
                            </div> -->
                        </div>
                        <div class="formWrap">
                            <label class="label" for="userId">* 아이디</label>
                            <div class="userID d-flex">
                                <input class="input w300" type="text" id="id" name="id" maxlength="12" value="${user.id}"
                                    autocomplete="off">
                                <button class="btn_normal input-btn bgc_point" type="button" id="checkDuplId">중복확인</button>
                            </div>
                            <span class="explan fc_999">&nbsp;※ 영문자로 시작하는 6~20자 영문자 또는 숫자</span>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="userPw">* 비밀번호</label>
                            <div class="userPw d-flex">
                                <input class="input w300" type="password" id="pw" name="pw" maxlength="20"
                                    autocomplete="off">
                                </div>
                                <span class="explan fc_999">&nbsp;※ 영문, 숫자, 특수 기호(!, @, # 등)를 모두 사용하여 최소 8자이상</span>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="userPwCheck">* 비밀번호확인</label>
                            <div class="userPwCheck d-flex">
                                <input class="input w300" type="password" id="pw_confirm" name="pw_confirm" maxlength="20"
                                    autocomplete="off">
                            </div>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="email01">* 이메일</label>
                            <div class="email d-flex">
                                <input class="input w200 email01" type="text" id="email1" autocomplete="off">
                                <span>&nbsp;@&nbsp;</span>
                                <input class="input w200 email02" type="text" id="email2" autocomplete="off">
                                <!-- 이메일 option 클릭시 email02에 값 입력되는 것 알아보기 -->
                                <select class="select w200 email01" id="email3">
                                    <option value="0" selected>직접입력</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="hanmail.net">hanmail.net</option>
                                </select>
                                <input type="hidden" id="email" name="email" value="">
                            </div>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="work-school">직장/학교명</label>
                            <input class="input work-school" type="text" name="belong_to" id="belong_to"
                                autocomplete="off">
                        </div>
                        <div class="formWrap">
                            <label class="label" for="phone">자택(회사)번호</label>
                            <div class="phone d-flex">
                                <select class="select w200 phone1" id="tel1">
                                    <option value="선택" selected>선택</option>
                                    <option value="02">02</option>
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
                                <span>&nbsp;-&nbsp;</span>
                                <input class="input w200 phone2 w100" id="tel2" type="text" pattern="[0-9]*" value=""
                                    maxlength="4" autocomplete="off">
                                <span>&nbsp;-&nbsp;</span>
                                <input class="input w200 phone3 w100" id="tel3" type="text" pattern="[0-9]*" value=""
                                    maxlength="4" autocomplete="off">
                                <input type="hidden" id="tel" name="tel" value="">
                            </div>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="mbile-phone">* 휴대전화</label>
                            <div class="phone mobile-phone d-flex">
                                <select class="select w200 mobile-phone1" id="phone1" name="mobile-phone1">
                                    <option value="선택" selected>선택</option>
                                    <option value="010">010</option>
                                    <option value="011">011</option>
                                    <option value="016">016</option>
                                    <option value="017">017</option>
                                    <option value="019">019</option>
                                </select>
                                <span>&nbsp;-&nbsp;</span>
                                <input class="input w200 mobile-phone2 w100" id="phone2" type="text" pattern="[0-9]*"
                                    value="" maxlength="4" autocomplete="off">
                                <span>&nbsp;-&nbsp;</span>
                                <input class="input w200 mobile-phone3 w100" id="phone3" type="text" pattern="[0-9]*"
                                    value="" maxlength="4" autocomplete="off">
                                <input type="hidden" id="phone" name="phone" value="">
                            </div>
                        </div>
                        <div class="formWrap">
                            <label class="label" for="adress">* 주소</label>
                            <div class="adressWrap">
                                <div class="adress adress1 d-flex">
                                    <input class="input w300" type="text" id="post_code" name="post_code" value=""
                                        autocomplete="off">
                                    <button class="btn_normal input-btn bgc_point" type="button"
                                        onclick="searchPostcode();">우편번호 검색</button>
                                </div>
                                <div class="adress adress2">
                                    <input class="input" type="text" id="addr1" name="addr1" value=""
                                        autocomplete="off">
                                </div>
                                <div class="adress adress3">
                                    <input class="input" type="text" id="addr2" name="addr2" value=""
                                        placeholder="상세주소" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="section_btnWrap d-flex justify_center">
                    <button class="btn_normal btn_xlarge bgc_ccc" type="button" onclick="location.href=''">
                        <!-- a태그 임시적용 -->
                        <a href="rainbow-user01-02-02.html">이전단계</a>
                    </button>
                    <button class="btn_normal btn_xlarge bgc_point" type="submit">
                        <!-- a태그 임시적용 -->
                        <a href="rainbow-user01-02-04.html">가입신청</a>
                    </button>
                </div>
            </div>
            <? include 'include/rainbow_footer.html' ?>
        </div>
</body>

</html>