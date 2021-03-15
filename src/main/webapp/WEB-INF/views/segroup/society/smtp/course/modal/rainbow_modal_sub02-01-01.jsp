<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="header d-flex justify_between">
	<div class="titleBar h3" id="class-name-bar"></div>
	<!-- <h3 class="h3"></h3> -->
	<div class="img-icon times close-modal"></div>
</div>

<div class="sectionWrap courseRegistrationWrap">
    <!-- 1) 수강신청서작성 > 신청서 작성 -->
    <div class="header_textWrap d-flex justify_between">
        <h3 class="h3">수강신청서</h3>
        <div class="btn_normal btn_pp_bg btn_small" id="getMyInfo">내 정보 불러오기</div>
    </div>
    <div class="section">
        <form action="" class="formStyle courseRegistration" method="post">
            <div class="d-flex">
                <label class="label" for="user-name">과정명</label>
                <div class="label-input class_name">세상에서 가장 쉬운 영단어 Step 1</div>
            </div>
            <div class="d-flex">
                <label class="label" for="user-name">* 성명</label>
                <div class="label-input user_name"></div>
            </div>
            <div class="d-flex">
                <label class="label" for="user_sex">* 성별</label>
                <div class="label-input user_sex"></div>
            </div>
            <div class="d-flex">
                <label class="label" for="user_birth">* 생년월일</label>
                <div class="label-input user_birth">
                    <span>
                        1993-02-12
                    </span>
                    <span class="h5 c999">
                        생년월일 정보는 아카데미 수료증 발급 용도로만 사용됩니다.
                    </span>
                </div>
            </div>
            <div class="d-flex">
                <label class="label" for="email01">* 이메일</label>
                <div class="label-input email d-flex">
                    <input class="input email01 user_email_0" type="text" name="email01" autocomplete="off">
                    <span>&nbsp;@&nbsp;</span>
                    <input class="input email02 user_email_1" type="text" name="email02" autocomplete="off">
                    <!-- 이메일 option 클릭시 email02에 값 입력되는 것 알아보기 -->
                    <select class="select ml10 email01" name="email01">
                        <option value="직접입력" selected>직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="hanmail.net">hanmail.net</option>
                    </select>
                </div>
            </div>
            <div class="d-flex">
                <label class="label" for="work-school">직장/학교명</label>
                <input class="input label-input work-school user_belong_to" type="text" name="work-school" autocomplete="off">
            </div>
            <div class="d-flex">
                <label class="label" for="mbile-phone">* 휴대전화</label>
                <div class="label-input phone mobile-phone d-flex">
                    <select class="select mobile-phone1 user_phone phone_0" name="mobile-phone1">
                        <option value="선택" selected>선택</option>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="019">019</option>
                    </select>
                    <span>&nbsp;-&nbsp;</span>
                    <input class="input mobile-phone2 w100 phone_1" name="mobile-phone2" type="number" pattern="[0-9]*" value="" maxlength="4" autocomplete="off">
                    <span>&nbsp;-&nbsp;</span>
                    <input class="input mobile-phone3 w100 phone_2" name="mobile-phone3" type="number" pattern="[0-9]*" value="" maxlength="4" autocomplete="off">
                </div>
            </div>
            <div class="d-flex">
                <label class="label" for="adress">* 주소</label>
                <div class="label-input adressWrap">
                    <div class="adress adress1 d-flex">
                        <input class="input" id="post_code" type="text" name="adress" value="" autocomplete="off">
                        <button class="input-btn btn_normal btn_pp btn_small" type="button" onclick="searchPostcode()">우편번호 검색</button>
                    </div>
                    <div class="adress adress2">
                        <input class="input" type="text" id="addr1" name="adress" value="" autocomplete="off">
                    </div>
                    <div class="adress adress3">
                        <input class="input" type="text" id="addr2" name="adress" value="" placeholder="상세주소" autocomplete="off">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="section">
        <div class="header_textWrap">
            <h3 class="h3">결제금액 안내</h3>
        </div>
        <div class="sub-segment">
            <div class="titleBar-hdr">교육비정보</div>
            <table border="1" class="table sub-sec">
                <thead class="thead">
                    <tr>
                        <th>과정명</th>
                        <th>금액</th>
                    </tr>
                </thead>
                <tbody class="tbody">
                    <tr>
                    	<td class="class_name"></td>
                        <td class="class-price">
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="sub-segment">
            <div class="titleBar-hdr">최종결제금액</div>
            <!-- 1) 수강신청서작성 > 포인트 조회/사용 -->
            <form action="" class="formStyle sub-sec">
                <table border="1" class="table">
                    <thead class="thead">
                        <tr>
                            <th>교육비</th>
                            <th>마일리지
                                <span class="remaining c999 h5">잔여 : <span id="user_point" class="remaining-user user_point">0</span>원</span>
                            </th>
                            <th>최종결제금액</th>
                        </tr>
                    </thead>
                    <tbody class="tbody">
                        <tr>
                            <td class="class-pay-price">73,500원</td>
                            <td class="class-mile">
                                <span>-</span>
                                <input class="mileage" id="point_use" type="number" pattern="[0-9]*" placeholder="사용 금액" value="0">
                                <span>원 사용</span>
                            </td>
                            <td class="class-price price-total">73,500원</td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <div class="section">
        <div class="header_textWrap">
            <h3 class="h3">수강취소 및 환불 관련 규정</h3>
            <p class="fc_999">
                개강 이후 총 수업시간의 50% 초과 경과시에는 수강취소 및 환불이 불가
                <br>개강 이전 및 개강 후 수업시간의 50% 이하 경과시에는 아래 절차 및 규정에 따라 수강취소 및 환불 가능함.
            </p>
        </div>
        <div class="sub-segment">
            <dl class="cancel-rule d-flex">
                <dt class="rule-ttl fz16">수강취소 절차</dt>
                <dd class="rule-ctt">
                    <strong>
                        1) 홈페이지 ‘나의강의실’ 에서 해당 과정을 선택한 후, 환불신청서를 작성.
                    </strong>
                </dd>
            </dl>
            <dl class="cancel-rule d-flex">
                <dt class="rule-ttl fz16">환불규정</dt>
                <dd class="rule-ctt">
                    <p>
                        <strong>1) 무통장입금(가상계좌)의 경우</strong>
                    </p>
                    <p class="c999">
                        <strong class="c666">- 개강일전 취소 時 </strong>
                        : 가상계좌 이용수수료를 제외한 전액환불
                        <br>환불액 = 납입수강료 – 가상계좌 이용수수료(330원)
                    </p>
                    <p class="c999">
                        <strong class="c666">- 개강 이후 취소 時 </strong>: 수강취소 위약금과 수업경과일수에 해당하는 수강료 일할 공제 후 잔여금액 환불
                        <br>환불액 = 납입수강료 – 위약금(수강료의 10%) – 일할 공제금액
                        <br>(납입수강료 × 수업경과일수/총 수업일수)
                    </p>
                    <p class="margin-top20">
                        <strong class="margin-top20">2) 카드결제의 경우</strong>
                    </p>
                    <p class="c999">
                        <strong class="c666">- 개강일전 취소 時 </strong>: 전액환불<br>환불액 = 납입수강료 전액
                    </p>
                    <p class="c999">
                        <strong class="c666">- 개강 이후 취소 時 </strong>: 수강취소 위약금과 수업경과일수에 해당하는 수강료 일할 공제 후 잔여금액 환불
                        <br>환불액 = 납입수강료 – 위약금(수강료의 10%) – 일할 공제금액
                        <br>(납입수강료 × 수업경과일수/총 수업일수)
                    </p>
                </dd>
            </dl>
            <div class="sub-sec">
                <p>
                    가상계좌 이용수수료 및 신용카드 이용수수료는 카드회사 및 결제대행사와의 계약내용변화에 따라 사전 공지 없이 변경될 수 있습니다.
                </p>
                <p>
                    카드결제시 영수증은 이니시스 홈페이지에서 가능 <a class="d-inline h5" href="http://www.inicis.com" target="_blank">( http://www.inicis.com )</a>
                </p>
                <p>
                    가상계좌 입금시 계산서신청과 영수증출력은 나의강의실-계산서 및 환급서류 페이지에서 가능
                </p>
            </div>
            <!-- 2) 환불규정 >> 약관동의 -->
            <form action="" class="formStyle">
                <div class="checkWrap d-flex justify_center">
                    <input type="checkbox" class="input check" name="agree01" id="agree01">
                    <label for="agree01" class="label">
                        위 내용에 동의합니다.
                    </label>
                </div>
            </form>
        </div>
    </div>
    <div class="section">
        <div class="header_textWrap">
            <h3 class="h3">과정신청 동의서</h3>
        </div>
        <div class="sub-segment">
            <ul class="sub-sec">
                <li>수료증은 수강생의 성명, 생년월일이 기재되어 발급되니 반드시 수강생 본인 아이디로 신청해야합니다.</li>
                <li>본인은 상기 과정이 비환급 일반 과정임을 숙지하고 수강 신청합니다.</li>
                <li>따라서, 과정 수료 후 교육비 비환급에 대해서는 본인의 책임으로 인정하고 어떠한 이의도 당사에 제기하지 않을 것임을 약속합니다.</li>
                <li>본인은 개인수강지원과정에 대해 상기 내용을 정확히 숙지하고 수강신청 합니다.</li>
                <li>따라서 과정 수료 후 교육비 미환급에 대해서는 본인의 책임으로 인정하고 어떠한 이의도 당사에 제기하지 않을 것임을 약속합니다.</li>
            </ul>
            <form action="" class="formStyle">
                <ul class="signWrap d-flex justify_center">
                    <li class="date today" id="CRtoday"></li>
                    <li class="menu-divBar cccc">&nbsp;|&nbsp;</li>
                    <li class="retrieve user_name">
                    </li>
                </ul>
                <div class="checkWrap d-flex justify_center">
                    <input type="checkbox" class="input check" name="agree02" id="agree02">
                    <label for="agree02" class="label">
                        위 내용에 동의합니다.
                    </label>
                </div>
            </form>
        </div>
    </div>
    <!-- 3) 결제방법 >> 결제방법 선택(신용카드/가상계좌) -->
    <div class="section">
        <div class="header_textWrap">
            <h3 class="h3">결제방법 선택</h3>
        </div>
        <div class="sub-segment">
            <form action="" class="formStyle courseRegistration">
                <fieldset class="f01 checkBox-slide">
                    <label class="check-bro">
                        <input type="checkbox" class="check-only check-only01 payment01 slideYN" name="payment" value="Card">
                        신용카드
                    </label>
                    <div class="wrap check-bro">
                        <label>
                            <input type="checkbox" class="check-only check-only01 payment02 slideYN" name="payment" value="VBank">
                            가상계좌
                        </label>
                        <ul class="input-ctt payment-ctt">
                            <li>
                                - 개인 및 개인사업자는 계산서가 발행되지 않습니다.
                            </li>
                            <li>
                                - 환급과정을 신청하신 경우, 계산서 발행이 필수이므로 계산서 신청을 클릭하여 아래 내용을 작성하여 주시기 바랍니다.
                            </li>
                        </ul>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>

    <div class="button-wrap d-flex justify_end margin-top40">
        <button class="btn_normal btn_pp btn_large btnCancel" type="button">취소</button>
        <button class="btn_normal btn_pp_bg btn_large margin-left20 btnSubmit" type="button">수강신청</button>
    </div>
    <script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<!-- ActionするFormBox -->
			<form id="SendPayForm_id" name="" method="post">
				<input type="hidden" name="version" value="1.0"> 
				<input type="hidden" name="mid" value="${mid}"> 
				<input type="hidden" name="goodname" value="${goodname}">
				<!-- 상품명=과정명 선택후 결정 -->
				<input type="hidden" name="oid" value="${oid}"> 
				<input type="hidden" name="price" value="${price}">
				<!-- 사용자선택후 결정 -->
				<input type="hidden" name="currency" value="WON"> 
				<input type="hidden" name="buyername" value="${buyername}"> 
				<input type="hidden" name="buyertel" value="${buyertel}">
				<input type="hidden" name="buyeremail" value="${buyeremail}">
				<input type="hidden" name="timestamp" value="${timestamp}">
				<input type="hidden" name="signature" value="${signature}">
				<input type="hidden" name="returnUrl" value="https://www.softsociety.net/smtp/course/payInfo">
<!-- 				<input type="hidden" name="returnUrl" value="http://localhost:8080/smtp/course/payInfo"> -->
				<input type="hidden" name="mKey" value="${mKey}"> 
				<input type="hidden" name="gopaymethod" id="gopaymethod" value="">
				<input type="hidden" id="offerPeriod" name="offerPeriod" value="${offerPeriod}">
				<input type="hidden" name="acceptmethod" value="CARDPOINT:HPP(1):no_receipt:va_receipt:vbanknoreg(0):below1000">
				<input type="hidden" name="payViewType" value="overlay"> 
				<input type="hidden" name="languageView" value=""> 
				<input type="hidden" name="charset" value=""> 
				<input type="hidden" name="quotabase" value="${cardQuotaBase}"> 
				<input type="hidden" name="ini_onlycardcode" value=""> 
				<input type="hidden" name="ini_cardcode" value=""> 
				<input type="hidden" name="ansim_quota" value=""> 
				<input type="hidden" name="vbankRegNo" value=""> 
		        
		        <input type="hidden" name="merchantData" id="merCardinal">
		        <input type="hidden" name="merchantData" id="merCourse">
				<input type="hidden" name="merchantData" id="merPoint" value="0">	
				<input type="hidden" name="merchantData" id="merPayCrcSeq" value="0">
				<input type="hidden" name="merchantData" id="merPhone">
				<input type="hidden" name="merchantData" id="merEmail">
				<input type="hidden" name="merchantData" id="merId">
				<input type="hidden" name="merchantData" id="merType" value="short">
			</form>
			<button onclick="INIStdPay.pay('SendPayForm_id')" id="payreq" style="display: none;">결제하기</button>
</div>
<script type="text/javascript">
    $(document).ready(function() {

        //오늘 날짜 구하기 https://zero-gravity.tistory.com/308
        function getRecentDate() {
            var dt = new Date();
            var recentYear = dt.getFullYear();
            var recentMonth = dt.getMonth() + 1;
            var recentDay = dt.getDate();

            if (recentMonth < 10) recentMonth = "0" + recentMonth;
            if (recentDay < 10) recentDay = "0" + recentDay;

            return recentYear + " 년 " + recentMonth + " 월 " + recentDay + " 일 ";
        }

        $('#CRtoday').text(getRecentDate);
        //오늘 날짜 구하기 끝
        $('.slideYN').change(function() {
            var showWrap = $('.checkBox-slide>.wrap>label .slideYN'),
                hclasseWrap = $('.checkBox-slide>label .slideYN');
            //체크된 input의 슬라이드가 wrap의 후손이면 slide down
            //체크된 input의 슬라이드가 wrap의 후손이 아니면 hclasse
            if ($(this).is(':checked') == true) {
                // console.log('체크박스 체크!');
                if ((showWrap).is(':checked') == true) {
                    // console.log((this)+'열기 1');
                    $(this).parent('label').siblings('.input-ctt').slideDown();
                    // ↓ 아래에 있는 체크박스를 활성화하게되면 위에 있는 체크박스는 비활성화가 안되므로 추가
                    $(this).parent('label').siblings('.wrap').find('.input-ctt').hide();
                } else if ((hclasseWrap).is(':checked') == true) {
                    // console.log((this) + '닫기 1');
                    $(this).parent('label').siblings('.wrap').find('.input-ctt').hide();
                };
            } else if ($(this).is(':checked') == false) {
                // console.log('체크박스 해제!');
                // ↓ 아래에 있는 체크박스를 활성화하게되면 위에 있는 체크박스는 비활성화가 안되므로 추가
                $(this).parent('label').siblings('.input-ctt').hide();
                if ((showWrap).is(':checked') == false) {
                    // console.log((this) + '닫기 2');
                    $(this).parent('label').siblings('.input-ctt').hide();
                }
            }
        });

        // 체크박스 하나만 체크되게 하기 01Group ~ 03Group 끝
        $(".check-only").click(function() {
            $(".check-only").attr("checked", false); //uncheck all checkboxes
            $(this).attr("checked", true); //check the clicked one
        });

        $('input.check-only01[type="checkbox"],[name="payment]').bind('click', function() {
            $('input.check-only01[type="checkbox"],[name="payment]').not(this).prop("checked", false);
        });

        $('input.check-only02[type="checkbox"],[name="bill]').bind('click', function() {
            $('input.check-only02[type="checkbox"],[name="bill]').not(this).prop("checked", false);
        });

        $('input.check-only03[type="checkbox"],[name="bill-form]').bind('click', function() {
            $('input.check-only03[type="checkbox"],[name="bill-form]').not(this).prop("checked", false);
        });
        // 체크박스 하나만 체크되게 하기 01Group ~ 03Group 끝
    });
</script>
