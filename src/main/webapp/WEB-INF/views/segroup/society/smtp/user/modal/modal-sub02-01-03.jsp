<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
	<script language="javascript" type="text/javascript">
		<spring:eval expression="@domain['domain']" var="domain"/>
		<spring:eval expression="@domain['domain.http']" var="http"/>
	</script>
	document.domain="${domain}";
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
		<input type="hidden" name="returnUrl" value=`${http}/smtp/course/payInfo`>
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
		<input type="hidden" name="merchantData" id="merPayCrcSeq">
		<input type="hidden" name="merchantData" id="merPhone">
		<input type="hidden" name="merchantData" id="merEmail">
		<input type="hidden" name="merchantData" id="merId" value="${sessionScope.user_id}">
		<input type="hidden" name="merchantData" id="merType" value="long">
	</form>
	<button onclick="INIStdPay.pay('SendPayForm_id')" id="payreq" style="display: none;">결제하기</button>
	<div class="header d-flex justify_between">
		<div class="titleBar h3" id="class-name-bar"></div>
		<div class="img-icon times close-modal"></div>
	</div>
	<div class="sectionWrap courseRegistrationWrap">
		<!-- processWrap : 다음단계로 넘어갈 때 .addClass('.active')됩니다. -->
		<ul class="processWrap processWrapBar d-flex">
			<li class="process active"><span class="margin-right10 h5">01</span>결제방법</li>
			<li class="process"><span class="margin-right10 h5">02</span>결제</li>
		</ul>
			<div class="section">
                <div class="sub-segment">
                	<div class="titleBar-hdr">최종결제금액</div>
                	<form action="" class="formStyle sub-sec">
	                    <table border="1" class="table">
	                        <thead class="thead">
	                            <tr>
	                                <th>과정명</th>
	                                <th>금액</th>
	                            </tr>
	                        </thead>
	                        <tbody  class="tbody">
	                            <tr>
	                                <td class="class-pay-price"></td>
	                                <td class="class-price"></td>
	                            </tr>
	                        </tbody>
	                    </table>
                    </form>
                </div>
                <div class="sub-segment">
		            <div class="titleBar-hdr">최종결제금액</div>
		            <form action="" class="formStyle sub-sec">
		                <table border="1" class="table">
		                    <thead class="thead">
		                        <tr>
		                            <th>교육비</th>
		                            <th>최종결제금액</th>
		                        </tr>
		                    </thead>
		                    <tbody>
	                           <tr>
	                               <td class="class-pay-price"></td>
	                               <td class="class-price price-total"></td>
	                           </tr>
	                       </tbody>
		                </table>
		            </form>
        		</div>
            </div>
			<div class="section">
		        <div class="sub-segment">
		        	<div class="titleBar-hdr">결제방법 선택</div>
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
				<button class="btn_normal btn_pp btn_large close-modal" type="button">취소</button>
				<button class="btn_normal btn_pp_bg btn_large margin-left20 btnSubmit" type="button">결제하기</button>
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
/*             $('.modal .close-modal').click(function() {
            	$(".modal-content:eq(0)").css("display","block");
            	$(".modal-content:eq(1)").css("display","none");
            	$(".modal-content:eq(2)").css("display","none");
            	$(".modal-content:eq(3)").css("display","none");
                $('html, body').removeClass("not-scroll");
	            $('.modal').hide();
            }); */
            //모달 닫기 끝

            // 이전단계 버튼 클릭시 로드되는 부분
            $('.prev-step3').click(function() {
            	$(".modal-content:eq(2)").css("display","none");
            	$(".modal-content:eq(1)").css("display","block");
                //$('.modal-content').load('modal/modal-sub02-01-02');
            });
            // 이전단계 버튼 클릭 끝 

            // 다음단계 버튼 클릭
            $('.btnSubmit').click(function() {
            	
            	/* if(!$('#agree02').prop('checked')){
            		alert('동의란에 체크해주시기 바랍니다.');
            		return;
            	} */

            	
        		var course_id = $('.class-id').val();				            	
            	
        		//modal-sub02-01-01.jsp의 signUpClass 함수 참고
				//0원일 때 수강등록 바로 처리하기
 				if(Number($('.class-pay-price').attr('data-value')) - Number($('#point_use').val())=='0'){

        			if(confirm('총 결제금액이 0원이므로, 바로 수강신청됩니다. 수강신청하시겠습니까?')){
						signUpClass(course_id, $('#merCardinal').val());
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
