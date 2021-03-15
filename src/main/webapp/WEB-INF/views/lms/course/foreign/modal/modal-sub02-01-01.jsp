<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html lang="ko">

<script>
//c-f-m-m
$(function(){
	
	$('#point_use').on('focusout', function(){
		if(Number($('#point_use').val() > Number($('#user_point').attr('data-value')))){
			alert('보유 마일리지를 초과한 금액을 입력할 수 없습니다.');
			$(this).val(0);
			$(this).focus();			
			return;
		}
		if(Number($('#point_use').val()) > Number($('.class-pay-price').attr('data-value'))){
			alert('교육비를 초과하는 마일리지를 적용할 수 없습니다.');
			$(this).val(0);
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
	
	//기수가 존재하는지 확인.
	$('#checkCardinalExist').on('click', function(){
	
		var course_id = $('.class-id').val();
		var class_term = $('.class-term').val();
		var course_name = $('.class-name').html();

		//디폴트 세팅 - 학습기간이 설정안되었을 경우 0으로 DB에 저장됨 -> 1달로 디폴트 값을 설정
		if(class_term==0){
			class_term = 30;
		}
		
		
	
  		$.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/lms/course/checkCardinalExist",
			data    : {
				"id" : course_id,
				"selp_period" : class_term,
				"course_name" : course_name
			},
			success	: function(info) {

				//상수쌤 결제관리 이후 수강정보가 들어가야할 것
				signUpClass(course_id, info.cardinal_id);
				
				
			},
			error	: function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}						
		});
		
  		function signUpClass(course_id, cardinal_id){
  			
  			var user_id = "${sessionScope.user_id}";
  			if(user_id==null || user_id==''){
  	  			alert("로그인이 선행되어야 합니다.");
  	  			return;
  			} else{
  				
  				$.ajax({
  					contentType : "application/json",
  					dataType : "json",
  					type	: "get",
  					url		: "/lms/course/signUpClass",
  					data    : {
  						"course_id" : course_id,
  						"cardinal_id" : cardinal_id
  					},
  					success	: function(info) {

  						alert('수강신청이 완료되었습니다.');
  		  				document.location.href = "/lms/course/foreign/sub02-01";
  						
  						
  					},
  					error	: function(request, status, error) {
  						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
  					}						
  				});
  				
  				
  				
  			}
  			
  			
  		}
		
	});
	
});


</script>

<body>
    <div class="sub-content sub-modal-01">
        <div class="header">
            <div class="titleBar h3">수강신청</div>
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
                        <label class="label" for="user-name">* 성명</label>
                        <input class="input user_name" type="text" >
                    </div>
                   <!--  <div class="d-flex">
                        <label class="label" for="user-sex">* 성별</label>
                        <input class="input user_sex" type="text" >
                    </div> -->
                    <div class="d-flex">
                        <label class="label" for="user-birth">* 생년월일</label>
                        <input class="input user_birth" type="text" >
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
                        <!-- <input class="input user_addr" type="text" > -->
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
                                    <th>수량</th>
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
                                            <span class="remaining c999 h5">잔여 : <span class="remaining-user user_point">0</span>원</span>
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
                                            <input class="input mileage w100" type="number" pattern="[0-9]*" placeholder="사용 금액">원 사용</td>
                                        <td class="class-price price-total">73,500원</td>
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
            <button class="button btn-pColor btn-next next-step" id="checkCardinalExist" type="button">다음</button>
        </div>
    </div>


    <script type="text/javascript">
        /* $(document).ready(function() {
            //모달 닫기 - 다음/이전 단계 넘어갈 시 load로 불러오니 닫기 버튼 안눌렸음 그래서 임시로 넣어둠
            $('.modal .close-modal').click(function() {
                $('html, body').removeClass("not-scroll");
                $('.modal').hide();
            });
            //다음단계 버튼 클릭
            $('.next-step').click(function() {
                $('.modal-content').load('modal/modal-sub02-01-02');
            });
        }); */
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

        		//none일 경우 자동기수 생성
        		if(existingBox == 'none'){
        			checkCardinalExist();

        		} else if(existingBox == 'app_date_title'){
        			alert('신청기간을 선택해주세요.');
					return;
        		} else {
        			
        			//이미 입과처리된 강좌일 경우, 중복해서 수강신청 할 수 없다.
        			checkAlreadyEnrolled(course_id, existingBox);
        			
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
