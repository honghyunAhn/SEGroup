<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html lang="ko">
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
//c-m-m
$(function(){
	
	
	//기수가 존재하는지 확인.
	$('#checkCardinalExist').on('click', function(){
		 //$("#payreq").click();
	});
	
	
	$('#point_use').on('focusout', function(){
		if(Number($('#point_use').val()) > Number($('#user_point').attr('data-value'))){
			alert('보유 마일리지를 초과한 금액을 입력할 수 없습니다.');
			$(this).val(0);
			$(this).focus();			
			return;
		}
		if(Number($('#point_use').val()) > Number($('.class-pay-price').attr('data-value'))){
			alert('교육비를 초과하는 마일리지를 적용할 수 없습니다.');
			$(this).val(Number($('.class-pay-price').attr('data-value')));
			$(this).focus();
			return;
		}				
		if(Number($('#point_use').val()) < 0){
			alert('0보다 작은 값은 입력할 수 없습니다.');
			$(this).val(0);
			$(this).focus();
			return;
		}				
		
		var total_price = Number($('.class-pay-price').attr('data-value')) - Number($('#point_use').val());
		$('.price-total').attr('data-value', total_price);		
		$('input[name$="price"]').val(total_price);
		
		/*결재정보 세팅*/
    	$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/lms/course/makesignature",
			data    : {
						price:total_price
					  },
			success	: function(data) {
				$('input[name$="price"]').val(total_price);	
				$('input[name$="goodname"]').val($('.class-name').html());
				$('input[name$="mid"]').val(data.mid);
				$('input[name$="oid"]').val(data.oid);
				$('input[name$="timestamp"]').val(data.timestamp);
				
				
			}
		});
		
		$('.price-total').html(total_price.toLocaleString('en') + '원');
	});
});

function checkPayExist(course_id, cardinal_id) {
	var price = $('.class-pay-price').data("value");
	var payDate = $('#cardinals_selectbox option:selected').text();
	
	var start = payDate.split("~")[0].trim();
	var end = payDate.split("~")[1].trim();
	
	var date1 = new Date(start);
	var date2 = new Date(end);
	date1.setMonth(date1.getMonth() + 1);
	
	// 1달이 넘으면 1달로 잡고 1달 넘지 않으면 그 기간으로 저장
	if((date2 - date1) > 0) {
		end = date1.getFullYear() + "-" + (date1.getMonth()+1) + "-" + date1.getDate();
	}
	
//	console.log(price);
//	console.log(start);
//	console.log(end);
	
	$.ajax({
		contentType : "application/json",
		type	: "get",
		url		: "/lms/course/checkPayExist",
		async	: false,
		data    : {
			"course_id" : course_id,
			"cardinal_id" : cardinal_id,
			"price" : price,
			"start" : start,
			"end" : end
		},
		success	: function(info) {
			
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}	
	});
}

function checkCardinalExist(){
	var course_id = $('.class-id').val();				
	var class_term = $('.class-term').val();
	var course_name = $('.class-name').html();
	
	
	//디폴트 세팅 - 학습기간이 설정안되었을 경우 0으로 DB에 저장됨 -> 1달로 디폴트 값을 설정
	/* if(class_term==0){
		class_term = 30;
	}			
 */	
		$.ajax({
		contentType : "application/json",
		dataType : "json",
		type	: "get",
		url		: "/lms/course/checkCardinalExist",
		async	: false,
		data    : {
			"id" : course_id,
			"selp_period" : class_term,
			"course_name" : course_name
		},
		success	: function(info) {
			
			//여기서부터 다시
						
			$('#merCardinal').val(info.cardinal_id);
			$('#merCourse').val(course_id);
			$('#merPoint').val($('#point_use').val());		
			$('#merPhone').val($('.user_phone').val());
			$('#merEmail').val($('.user_email').val());
			
			$('#offerPeriod').val(info.cardinal_id);
			
			checkPayExist(course_id, info.cardinal_id);
/* 			if(Number($('.class-pay-price').attr('data-value')) - Number($('#point_use').val())=='0'){

    			if(confirm('총 결제금액이 0원이므로, 바로 수강신청됩니다. 수강신청하시겠습니까?')){
					signUpClass(course_id, $('#merCardinal').val());
					return;
				}

			}
 */
			
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}						
	});
}
		function signUpClass(course_id, cardinal_id){
		 
			var user_id = "${sessionScope.user_id}";
				
				$.ajax({
					contentType : "application/json",
					dataType : "json",
					type	: "get",
					url		: "/lms/course/signUpClass",
					data    : {			
						"user_id" : user_id,
						"course_id" : course_id,
						"cardinal_id" : cardinal_id,
						"pointUse" : $('#point_use').val(),
						"dis_point" : $('#merPoint').val(),
						//"phone" : $('#merPhone').val(),
						//"email" : $('#merEmail').val(),
						"phone" : 	$(".user_phone").val(),
						"email" : $(".user_email").val(),
						"post_code" : $("#post_code").val(),
						"belong_to" : $(".user_belong_to").val(),
						"addr1" : $("#addr1").val(),
						"addr2" : $("#addr2").val(),
						"payment" : "0"
					},
					success	: function(info) {
						insertEduUserPay(course_id, cardinal_id);
						alert('수강신청이 완료되었습니다.');
		  				document.location.href = "/lms/user/sub07-02";
						
						
					},
					error	: function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}						
				});
			
		}
		
		function insertEduUserPay(course_id, cardinal_id){
			 
			var user_id = "${sessionScope.user_id}";
			var goodsname = $(':hidden[name="goodname"]').val();
			
				$.ajax({
					contentType : "application/json",
					type	: "get",
					url		: "/lms/course/insertEduUserPay",
					data    : {			
						"id" : user_id,
						"course_id" : course_id,
						"cardinal_id" : cardinal_id,
						"point" : $('#merPoint').val(),
						"goodsName" : goodsname
					},
					success	: function(info) {},
					error	: function(request, status, error) {
						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
					}						
				});
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


</script>

<body>


    <div class="sub-content sub-modal-01">
        <div class="header d-flex justify_between">
            <div class="titleBar h3" style="text-align:left">수강신청</div>
            <!-- <h3 class="h3"></h3> -->
            <div class="img-icon times close-modal"></div>
        </div>

        <!-- processWrap : 다음단계로 넘어갈 때 .addClass('.active')됩니다. -->
        <ul class="processWrap d-flex">
            <li class="process active"><span class="margin-right10 h5 fc_orD">01</span>수강신청</li>
            <li class="process"><span class="margin-right10 h5 fc_orD">02</span>환불규정</li>
            <li class="process"><span class="margin-right10 h5 fc_orD">03</span>결제방법</li>
            <li class="process"><span class="margin-right10 h5 fc_orD">04</span>결제</li>
        </ul>
        <div class="modal-sectionWrap">
            <div class="section section-margin modal-sub02-01-01">
                <header class="article-title d-flex">
                    <div class="titleBar-hdr">수강신청서</div>
                    <div class="btn_default btn_xsmall btn_normal" id="getMyInfo">내 정보 불러오기</div>
                </header>
                <form action="" class="formStyle signUp-check" method="post">
                    <!-- <div class="fieldlabel"> -->
                    <div class="d-flex">
                        <label class="label" for="user-name">과정명</label>
                        <div class="input class-name" ></div>
                        <input type="hidden" class="class-id">
                        <input type="hidden" class="class-term">
                    </div>
                    <div class="d-flex">
                        <label class="label" for="cardinals_days">신청기간</label>
                        <div class="input cardinals_days" id="modal_app_days"></div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="cardinals_days">학습기간</label>
                        <div class="input cardinals_days" id="modal_learn_days">신청기간을 선택해주세요.</div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="user-name" >* 성명</label>
                        <div class="user_name"></div>
                    </div>
<!--                     <div class="d-flex">
                        <label class="label" for="user-sex">* 성별</label>
                        <input type="radio" class="input user_sex" name="user_sex" value="A0000" checked>남자
                        <input type="radio" class="input user_sex" name="user_sex" value="A0001">여자
                    </div> -->
                    <div class="d-flex">
                        <label class="label" for="user-birth" readonly>* 생년월일</label>
                        <div class="user_birth"></div>
                    </div>
                    <div class="d-flex">
                        <label class="label" for="email01">* 이메일</label>
                        <input class="input user_email" type="text" >
                    </div>
                    <div class="d-flex">
                        <label class="label" for="work-school">직장/학교명</label>
                        <input class="input user_belong_to" type="text" >
                    </div>
                    <!-- <div class="d-flex">
                        <label class="label" for="work-dept">부서</label>
                        <input class="input work-dept" type="text" name="work-dept" autocomplete="off">
                    </div> -->
                    <!-- <div class="d-flex">
                        <label class="label" for="work-rank">직위</label>
                        <input class="input work-rank" type="text" name="work-rank" autocomplete="off">
                    </div> -->
                    <!-- <div class="d-flex">
                        <label class="label" for="phone">자택(회사)번호</label>
                        <div class="phone">
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
                                <option value="070">070</option>
                                <option value="050">050</option>
                            </select>
                            <span>&nbsp;-&nbsp;</span>
                            <input class="input phone2" name="phone2" type="number" pattern="[0-9]*" value="" maxlength="4" autocomplete="off">
                            <span>&nbsp;-&nbsp;</span>
                            <input class="input phone3" name="phone3" type="number" pattern="[0-9]*" value="" maxlength="4" autocomplete="off">
                        </div>
                    </div> -->
                    <div class="d-flex">
                        <label class="label" for="mbile-phone">* 휴대전화</label>
                        <input class="input user_phone" type="text" placeholder="000-0000-0000">
                    </div>
                    <div class="d-flex">
                        <label class="label" for="adress">* 주소</label>
                        <div class="adressWrap">
                            <div class="adress adress1 d-flex">
                                <input class="input" type="text" id="post_code" name="post_code" value="" autocomplete="off" >
                                <button class="input-btn btn_orangeD btn_xsmall btn_normal" type="button" onclick="searchPostcode();">우편번호 검색</button>
                                <!-- <div class="d-none-msg">
                                    <p class="false-msg cDanger">우편번호를 입력해주세요.</p>
                                </div> -->
                            </div>
                            <div class="adress adress2">
                                <input class="input w355" type="text" id="addr1" name="addr1" value="" autocomplete="off" >
                                <!-- <div class="d-none-msg">
                                    <p class="false-msg cDanger">주소를 입력해주세요.</p>
                                </div> -->
                            </div>
                            <div class="adress adress3">
                                <input class="input w355" type="text" id="addr2" name="addr2" value="" placeholder="상세주소" autocomplete="off">
                                <!-- <div class="d-none-msg">
                                    <p class="false-msg cDanger">상세주소를 입력해주세요.</p>
                                </div> -->
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="section section-margin modal-sub02-01-01">
                <div class="d-flex margin-top5">
                    <div class="titleBar-hdr">교육비정보</div>
                    <div class="sub-segment">
                        <table border="1" class="table">
                            <thead>
                                <tr>
                                    <th>과정명</th>
                                    <!-- <th>수량</th> -->
                                    <th>금액</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <!--
                                class-name : 과정명
                                class-amount : 수량
                                class-price : 금액
                                -->
                                    <td class="class-name"></td>
                                    <!-- <td class="class-amount">1</td> -->
                                    <td class="class-price"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="section section-margin modal-sub02-01-01">
                <div class="d-flex margin-top10">
                    <div class="titleBar-hdr">최종결제금액</div>
                    <div class="sub-segment">
                        <form action="" class="formStyle">
                            <table border="1" class="table">
                                <thead>
                                    <tr>
                                        <th>교육비</th>
                                        <th>마일리지
                                            <!-- .remaining-user : 사용자 잔여 마일리지 조회 -->
                                            <span class="remaining c999 h5">잔여 : <span id="user_point" class="remaining-user user_point"></span>원</span>
                                        </th>
                                        <th>최종결제금액</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <!-- 계산 적용되어야 하는 부분
                                  .class-price(기존교육비)
                                - .mileage(사용마일리지)
                                = .price-total(최종결제금액)

                                -->
                                        <td class="class-pay-price"></td>
                                        <td class="class-mile">
                                            -
                                            <input class="input mileage w100 " id="point_use" type="number" pattern="[0-9]*" placeholder="사용 금액" value="0" min="0">
                                            원 사용</td>
                                        <td class="class-price price-total"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- onclick="location.href='include/modal-sub02-01-02.html'" -->
        <!-- <? include 'include/sub02.html' ?> -->
        <div class="button-wrap d-flex">
            <button class="btn_point btn_xsmall btn_normal btn-next next-step1"  type="button">다음</button><!-- id="checkCardinalExist" -->
        </div>
    </div>


    <script type="text/javascript">
        $(document).ready(function() {
            //모달 닫기 - 다음/이전 단계 넘어갈 시 load로 불러오니 닫기 버튼 안눌렸음 그래서 임시로 넣어둠
            $('.modal .close-modal').click(function() {
            	$(".modal-content:eq(0)").css("display","block");
            	$(".modal-content:eq(1)").css("display","none");
            	$(".modal-content:eq(2)").css("display","none");
            	$(".modal-content:eq(3)").css("display","none");
            	$(".user_email").val('');
            	$(".user_belong_to").val('');
            	$(".user_phone").val('');
            	$("#post_code").val('');
            	$("#addr1").val('');
            	$("#addr2").val('');
            	$("#addr3").val('');
				$("#point_use").val('0');
            	
            	$('html, body').removeClass("not-scroll");
                $('.modal').hide();
            });
            //다음단계 버튼 클릭
            $('.next-step1').click(function() {
            	
            	/* -------------------유효성 검사---------------------- */

            	if(!confirm('기재된 정보는 다시 수정할 수 없습니다. 결제페이지로 넘어가시겠습니까?')){            		
            		return;
            	}
            	
            	
            	
        		var regMail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        		if(!regMail.test($('.user_email').val())){
        			alert('이메일은 필수입력사항입니다. 이메일 형식을 확인바랍니다.');
        			return;
        		};
        		var regPhone = /^\d{3}-\d{3,4}-\d{4}$/;
        		if(!regPhone.test($('.user_phone').val())){
        			alert('전화번호는 필수입력사항입니다. 000-000-0000 형식으로 입력해주세요.');
        			return;
        		}
        		
        		if($('#post_code').val() == '' || $('#addr1').val() == '' || $('#addr2').val() == ''){
        			alert('주소는 필수입력사항입니다. 상세정보를 등록해주세요.');
        			return;
        		}

        		/* -------------------유효성 검사---------------------- */		
        	
        		var course_id = $('.class-id').val();				

        		//제일 먼저 선택된 기수가 이미 존재하는지 확인. cardinal_id를 리턴
        		var existingBox = $('#cardinals_selectbox option:selected').val();

//         		console.log("ExistingBox Check : " + existingBox);
        		//none일 경우 자동기수 생성
        		if(existingBox == 'none'){
        			checkCardinalExist();

        		} else if(existingBox == 'app_date_title'){
        			alert('신청기간을 선택해주세요.');
					return;
        		} else {
        			
        			//이미 입과처리된 강좌일 경우, 중복해서 수강신청 할 수 없다.
        			checkAlreadyEnrolled(course_id, existingBox);
        			checkPayExist(course_id, existingBox);
        			$('#merCardinal').val(existingBox);
        			$('#merCourse').val(course_id);
        			$('#merPoint').val($('#point_use').val());
        			$('#merPhone').val($('.user_phone').val());
    				$('#merEmail').val($('.user_email').val());
      		
        		}
        		
				makeSignature();        		
            	
               // $('.modal-content').load('modal/modal-sub02-01-02'); 
            });
            
    		function makeSignature(){
    			
        		/*결재정보 세팅*/
            	$.ajax({
        			contentType : "application/json",
        			dataType : "json",
        			type	: "get",
        			url		: "/lms/course/makesignature",
        			data    : {
        						price:Number($('.class-pay-price').attr('data-value')) - Number($('#point_use').val())
        					  },
        			success	: function(data) {

        				$('input[name$="price"]').val(Number($('.class-pay-price').attr('data-value')) - Number($('#point_use').val()));	
        				$('input[name$="goodname"]').val($('.class-name').html());
        				$('input[name$="mid"]').val(data.mid);
        				$('input[name$="oid"]').val(data.oid);
        				$('input[name$="timestamp"]').val(data.timestamp);
        				$('input[name$="mKey"]').val(data.mKey);
        				$('input[name$="signature"]').val(data.signature);
        				
        			}
        		});
        		
        		$('input[name$="buyertel"]').val($('.user_phone').val());
				$('input[name$="buyeremail"]').val($('.user_email').val());
        		$('input[name$="buyername"]').val($('.user_name').html());
            	$(".modal-content:eq(0)").css("display","none");
            	$(".modal-content:eq(1)").css("display","block");    			
    		}
    		
    		function checkAlreadyEnrolled(course_id, cardinal_id){

            	$.ajax({
        			contentType : "application/json",
        			dataType : "json",
        			type	: "get",
        			url		: "/lms/course/checkAlreadyEnrolled",
        			data    : {
        						'course_id' : course_id,
        						'cardinal_id' : cardinal_id
        					  },
        			success	: function(data) {
        				
        				if(data){
        					alert('이미 수강신청한 과목이기 때문에 중복하여 수강신청할 수 없습니다. 결제내역 페이지로 이동합니다.');
    		  				document.location.href = "/lms/user/sub07-02";
    		  				return;
        				}

/*         				//0원일 때 수강등록 바로 처리하기
         				if(Number($('.class-pay-price').attr('data-value')) - Number($('#point_use').val())=='0'){

                			if(confirm('총 결제금액이 0원이므로, 바로 수강신청됩니다. 수강신청하시겠습니까?')){
        						signUpClass(course_id, $('#merCardinal').val());
        						return;
        					}

        				}
 */
        			}
        		});    			
    			
    			
    			
    			
    			
    		}
        });
        
        
    </script>
</body>

</html>
