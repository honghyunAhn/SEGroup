<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<body>
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
		<input type="hidden" name="returnUrl" value="http://localhost:8089/lms/course/payToeflInfo">
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
		<input type="hidden" name="merchantData" id="merPoint">
		<input type="hidden" name="merchantData" id="merPhone">
		<input type="hidden" name="merchantData" id="merEmail">
		<input type="hidden" name="merchantData" id="merId" value="${sessionScope.user_id}">
		<input type="hidden" name="merchantData" id="merToefl" value="">
	</form>
	<button onclick="INIStdPay.pay('SendPayForm_id')" id="payreq" style="display: none;">결제하기</button>

	<div class="sub-content">
		<div class="header d-flex justify_between">
			<div class="titleBar h3" style="text-align: left">수강신청</div>
			<div class="img-icon times close-modal"></div>
		</div>
		<!-- processWrap : 다음단계로 넘어갈 때 .addClass('.active')됩니다. -->
		<ul class="processWrap d-flex">
			<li class="process"><span class="margin-right10 h5 fc_orD">01</span>수강신청</li>
			<li class="process"><span class="margin-right10 h5 fc_orD">02</span>환불규정</li>
			<li class="process active"><span class="margin-right10 h5 fc_orD">03</span>결제방법</li>
			<li class="process"><span class="margin-right10 h5 fc_orD">04</span>결제</li>
		</ul>
		<div class="modal-sectionWrap">
			<header class="article-title">
				<div class="titleBar-hdr">일반과정 수강신청 동의서</div>
			</header>
			<div class="section modal-sub02-01-03">
				<div class="text-box">
					수료증은 수강생의 성명, 생년월일이 기재되어 발급되니 반드시 수강생 본인 아이디로 신청해야합니다. <br>
					본인은 상기 과정이 비환급 일반 과정임을 숙지하고 수강 신청합니다. <br>
					따라서, 과정 수료 후 교육비 비환급에 대해서는 본인의 책임으로 인정하고 어떠한 이의도 당사에 제기하지 않을 것임을 약속합니다. <br>
					본인은 개인수강지원과정에 대해 상기 내용을 정확히 숙지하고 수강신청 합니다. <br>
					따라서 과정 수료 후 교육비 미환급에 대해서는 본인의 책임으로 인정하고 어떠한 이의도 당사에 제기하지 않을 것임을 약속합니다.
				</div>
				<div class="checkWrap">
					<ul class="signWrap d-flex">
						<li class="date today" id="today"></li>
						<!-- #today 오늘 날짜 구하기 - common.js include되는 modal레이어이므로 common.js의 오늘날짜구하는 기능 실행X 하단부에 text script 추가하였습니다. -->
						<li class="menu-divBar cccc">&nbsp;|&nbsp;</li>
						<li clss="retrieve user-name" id="signNm"></li>
					</ul>
					<label class="margin-top20">
						<input type="checkbox" class="check input" id="agree02" name="agree02"> 위 내용에 동의합니다.
					</label>
				</div>
			</div>
			<header class="article-title">
				<div class="titleBar-hdr">결제방법 선택</div>
			</header>
			<div class="section modal-sub02-01-03">
				<form action="" method="post">
					<fieldset class="f01 checkBox-slide">
						<label class="check-bro">
							<input type="checkbox" class="check-only check-only01 payment01 slideYN" name="payment" value="Card">신용카드
						</label>
						<div class="wrap check-bro">
							<label>
								<input type="checkbox" class="check-only check-only01 payment02 slideYN" name="payment" value="VBank">가상계좌
							</label>
							<ul class="input-ctt payment-ctt">
								<li>- 개인 및 개인사업자는 계산서가 발행되지 않습니다.</li>
								<li>- 환급과정을 신청하신 경우, 계산서 발행이 필수이므로 계산서 신청을 클릭하여 아래 내용을 작성하여 주시기 바랍니다.</li>
							</ul>
						</div>
					</fieldset>
					<fieldset class="f02 checkBox-slide">
						<div class="wrap check-bro">
							<div class="input-ctt bill-ctt">
								<div class="formStyle">
									<div class="d-flex">
										<label class="label" for="work-name">* 회사명</label>
											<input type="text" class="input work-name" name="work-name" autocomplete="off">
									</div>
									<div class="d-flex">
										<label class="label" for="work-num">* 사업자번호</label>
											<input type="number" pattern="[0-9]*" class=input "work-num" name="work-num" autocomplete="off">
									</div>
									<div class="d-flex">
										<label class="label" for="ceo-name">* 대표자명</label>
											<input type="text" class="input ceo-name" name="ceo-name" autocomplete="off">
									</div>
									<div class="d-flex">
										<label class="label mh80" for="bill-email">* 계산서 수령 E-mail</label>
										<div class="emailWrap">
											<div class="bill-email email">
												<input type="text" class="input bill-email01" name="bill-email01" autocomplete="off">
													<span>&nbsp;@&nbsp;</span>
												<input type="text" class="input bill-email02" name="bill-email02" autocomplete="off">
												<!-- 이메일 option 클릭시 email02에 값 입력되는 것 알아보기 -->
												<select class="select bill-email ml10" name="bill-email">
													<option value="직접입력" selected>직접입력</option>
													<option value="naver.com">naver.com</option>
													<option value="gmail.com">gmail.com</option>
													<option value="hanmail.net">hanmail.net</option>
												</select>
												<div class="d-none-msg">
													<p class="false-msg cDanger">이메일을 입력해주세요.</p>
												</div>
											</div>
											<div class="bill-email email">
												<input type="text" class="input bill-email01" name="bill-email01" autocomplete="off">
													<span>&nbsp;@&nbsp;</span>
												<input type="text" class="input bill-email02" name="bill-email02" autocomplete="off">
												<!-- 이메일 option 클릭시 email02에 값 입력되는 것 알아보기 -->
												<select class="select bill-email ml10" name="bill-email">
													<option value="직접입력" selected>직접입력</option>
													<option value="naver.com">naver.com</option>
													<option value="gmail.com">gmail.com</option>
													<option value="hanmail.net">hanmail.net</option>
												</select>
												<div class="d-none-msg">
													<p class="false-msg cDanger">이메일을 입력해주세요.</p>
												</div>
											</div>
										</div>
									</div>
									<div class="d-flex">
										<label class="label" for="work-phone">* 전화번호</label>
										<div class="work-phone phone">
											<select class="select phone1" name="phone1">
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
											</select> <span>&nbsp;-&nbsp;</span>
											<input class="input phone2 w100" name="phone2" type="number" pattern="[0-9]*" value="" maxlength="4" autocomplete="off"> <span>&nbsp;-&nbsp;</span>
											<input class="input phone3 w100" name="phone3" type="number" pattern="[0-9]*" value="" maxlength="4" autocomplete="off">
										</div>
									</div>
									<div class="d-flex">
										<label class="label mh120" for="work-adress">* 사업장주소</label>
										<div class="adressWrap">
											<div class="adress adress1 d-flex">
												<input class="input" type="text" name="adress" value="" autocomplete="off">
												<button class="button input-btn btn-bk" type="button" onclick="location.href=''">우편번호 검색</button>
												<div class="d-none-msg">
													<p class="false-msg cDanger">우편번호를 입력해주세요.</p>
												</div>
											</div>
											<div class="adress adress2 work-adress2">
												<input class="input w355" type="text" name="adress" value="" autocomplete="off">
												<div class="d-none-msg">
													<p class="false-msg cDanger">주소를 입력해주세요.</p>
												</div>
											</div>
											<div class="adress adress3 work-adress3">
												<input class="input w355" type="text" name="adress" value="" placeholder="상세주소" autocomplete="off">
												<div class="d-none-msg">
													<p class="false-msg cDanger">상세주소를 입력해주세요.</p>
												</div>
											</div>
										</div>
									</div>
									<div class="d-flex">
										<label class="label" for="work-stt">* 업태</label>
											<input type="text" class="input work-stt" name="work-stt" autocomplete="off">
									</div>
									<div class="d-flex">
										<label class="label" for="work-stk">* 종목</label>
											<input type="text" class="input work-stk" name="work-stk" autocomplete="off">
									</div>
									<div class="d-flex">
										<label class="label mh80" for="bill-form">* 계산서 형태</label>
										<fieldset class="f03">
											<label class="check-bro">
												<input type="checkbox" class="check-only check-only03 bill-form" name="bill-form">
												청구(교육비 입금 전으로 내부 품의를 위해 사전발행을 희망할 경우)시 발행요청일 기입
											</label>
											<label class="check-bro">
												<input type="checkbox" class="check-only check-only03 bill-form" name="bill-form">
												영수 (교육비 입금을 완료하고 계산서 발행을 희망할 경우)
											</label>
										</fieldset>
									</div>
									<div class="d-flex">
										<label class="label" for="bill-date">* 발행요청일</label>
										<div class="bill-date d-flex">
											<input type="number" pattern="[0-9]*" class="input bill-date" name="bill-date" value placeholder="YYYY-MM-DD" autocomplete="off">
											<div class="h5 c999 txt">
												신청일 기준 교육시작 전일까지의 날짜로 발급가능<br>교육 시작일 이후 날짜로는 발급 불가
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
		<div class="button-wrap d-flex">
			<button class="btn_default btn_xsmall btn_normal btn-prev prev-step3" type="button">이전</button>
			<button class="btn_point btn_xsmall btn_normal btn-next next-step3" type="button">다음</button>
		</div>
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

            $('#today').text(getRecentDate);
            //오늘 날짜 구하기 끝

            //모달 닫기 - 다음/이전 단계 넘어갈 시 load로 불러오니 닫기 버튼 안눌렸음 그래서 임시로 넣어둠
            $('.modal .close-modal').click(function() {
            	$(".modal-content:eq(0)").css("display","block");
            	$(".modal-content:eq(1)").css("display","none");
            	$(".modal-content:eq(2)").css("display","none");
            	$(".modal-content:eq(3)").css("display","none");
                $('html, body').removeClass("not-scroll");
                $('.modal').hide();
            });
            //모달 닫기 끝

            // 이전단계 버튼 클릭시 로드되는 부분
            $('.prev-step3').click(function() {
            	$(".modal-content:eq(2)").css("display","none");
            	$(".modal-content:eq(1)").css("display","block");
                //$('.modal-content').load('modal/modal-sub02-01-02');
            });
            // 이전단계 버튼 클릭 끝 

            // 다음단계 버튼 클릭
            $('.next-step3').click(function() {
            	
            	if(!$('#agree02').prop('checked')){
            		alert('동의란에 체크해주시기 바랍니다.');
            		return;
            	}

            	
        		var course_id = $('.class-id').val();				            	
            	
        		//modal-sub02-01-01.jsp의 signUpClass 함수 참고
				//0원일 때 수강등록 바로 처리하기
 				if(Number($('.class-pay-price').attr('data-value')) - Number($('#point_use').val())=='0'){

        			if(confirm('총 결제금액이 0원이므로, 바로 시험 신청됩니다. 시험 신청하시겠습니까?')){
        				insertToeflPay();
						return;
					} else {
						alert('수강신청을 취소합니다.');
		                $('.close-modal').click();												
						return;
						
					}

				}
            	
 				var paymethod = $('input[name=payment]:checked').val();
 				
 				if (paymethod == 'Card') {
 					$("#gopaymethod").val('Card');
 				} else if (paymethod == 'VBank') {
 					$("#gopaymethod").val('VBank');
            	}
            	
            	$("#payreq").click();
            	
            	$(".modal-content:eq(0)").css("display","block");
            	$(".modal-content:eq(1)").css("display","none");
            	$(".modal-content:eq(2)").css("display","none");
            	$(".modal-content:eq(3)").css("display","none");
                $('html, body').removeClass("not-scroll");
                $('.modal').hide();
                
            	//$(".modal-content:eq(2)").css("display","none");
            	//$(".modal-content:eq(3)").css("display","block");
                //$('.modal-content').load('modal/modal-sub02-01-04');
            });
            // 다음단계 버튼 클릭 끝


        });

        $(function() {
            // //modal 수강신청서 - 결제방법 선택시 슬라이드 다운되는 부분
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
            // //modal 수강신청서 - 결제방법 선택시 슬라이드 다운되는 부분 끝

            // 체크박스 중복체크 불가 - 모든 체크박스가 중복체크 불가가 되므로 실패
            // $('input.check-only[type="checkbox"]').bind('click', function() {
            //     $(".check-only").attr("checked", false);//uncheck all checkboxes
            //     $(this).attr("checked", true); //check the clicked one
            //
            //     //지금 클릭된 체크박스의 조상(fieldset)이름과
            //     //같은 조상(fieldset)의 (후손)체크박스의 이름이 같으면
            //     //체크 해제(false) 시킨다.
            //     var nowCheck = $(this).parents('fieldset').attr('class'),
            //         nonCheck = $(this).parents('.check-bro').siblings().parents('fieldset').attr('class'),
            //         nowChecked = $(this).attr("checked");
            //         // console.log('지금 선택된 부모의 class는 :' + nowCheck);
            //         // console.log('지금 선택된 형제의 부모의 class는 :' + nonCheck);
            //         // console.log('지금 선택된 checked 상태는 :' + nowCheckd);
            //     if(nowCheck == nonCheck){
            //         //체크박스 선택된것이 아닌 것은 체크해제됨.
            //         $('input.check-only[type="checkbox"]').not(this).prop("checked", false);
            //     }
            // });
            // 체크박스 중복체크 불가 - 모든 체크박스가 중복체크 불가가 되므로 실패 끝

            // 체크박스 하나만 체크되게 하기 01Group ~ 03Group
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
</body>

</html>
