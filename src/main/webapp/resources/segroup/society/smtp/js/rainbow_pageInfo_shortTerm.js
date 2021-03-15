$(document).ready(function(){
	//결제준비
	payStart();
	// 결제하기
	payProgress();
	$('select[name="email01"]').on('change', function(){
//		console.log($('select.email01 option:selected').val());
		if($('select.email01 option:selected').val() != "직접입력") {
			var emailAdd = $('select.email01 option:selected').val();
			$('input[name="email02"]').val(emailAdd);
		} else {
			$('input[name="email02"]').val("");	
		}
	});
		
	$('#point_use').on('focusout', function(){
//		console.log(Number($('#point_use').val()))
		if(Number($('#point_use').val()) > Number($('#user_point').attr('data-value'))){
			alert('보유 마일리지를 초과한 금액을 입력할 수 없습니다.');
			$(this).val(0);
			$(this).focus();			
			return;
		} 
//		console.log($('.class-price').html());
		if(Number($('#point_use').val()) > Number($('.class-pay-price').attr('data-value'))) {
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
		$('.price-total').html(total_price.toLocaleString('en') + '원');
	});
});

function getPointInfo(user_id){
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		type	: "get",
		url		: "/lms/course/getPointInfo",
		data    : {
			"user_id" : user_id
		},
		success	: function(userPoint) {
			$('.user_point').attr('data-value', userPoint.BALANCE);
			$('.user_point').html(userPoint.BALANCE.toLocaleString('en'));
			$('#class-name-bar').html(classNm);
		},
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
var classPrice;
var realPrice;

function payStart() {
	$('.modal-popup').on('click', function() {
		if(user_id == '' || user_id == null) {
			alert("로그인이 필요합니다.");
			document.location.href = '/smtp/user/sub01-01';
			return;
		} else {		
			var cardinal_id = $(this).closest('div').find('input[name=cardinal_id]').val();
			getPointInfo(user_id);
			callFunction(cardinal_id);
		}
	});
}

function modalInit() {
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		type	: "get",
		url		: "/smtp/course/getUserInfo",
		data    : {
			"user_id" : user_id
		},
		success	: function(userInfo) {

			//-----------------모달 기본 정보 세팅--------------------//
	        $('.user_name').html(userInfo.user_nm);
/*	        $('#signNm').html(userInfo.user_nm);*/
	        $('input[name$="buyername"]').val(userInfo.user_nm);
			$('.user_birth').html(userInfo.user_birth);
			
			var user_sex = userInfo.user_sex;
			
			if(user_sex == "A0000") { $('.user_sex').html("남자") }
			else if(user_sex == "A0001") { $('.user_sex').html("여자") }
			
			//------------------모달에 회원정보 불러오기-------------------//
			$('#getMyInfo').on('click', function(){
				
				/* 모달 내의 정보를 띄우는 세팅 */
				
				var email = userInfo.user_email;
				var e = email.split("@");
				
				var phone = userInfo.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
				var p = phone.split("-");
				
		        $('.user_email_0').val(e[0]);
		        $('.user_email_1').val(e[1]);
		        
		        $('.phone_0').val(p[0]);
		        $('.phone_1').val(p[1]);
		        $('.phone_2').val(p[2]);
				$('.user_belong_to').val(userInfo.user_belong_to);
		        
		        
	        	$('#post_code').val(userInfo.user_zipcode);
	        	$('#addr1').val(userInfo.user_addr1);
				$('#addr2').val(userInfo.user_addr2);

			});
			//------------------모달에 회원정보 불러오기-------------------//

			/* getPointInfo(user_id);
			getCardinalInfo(courseId, learnPeriod); */
		},
		error	: function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}						
	});
}

function callFunction(cardinal_id) {
	
	modalInit();
	$('#merCardinal').val(cardinal_id);
	$('#merId').val(user_id);
	$('.class-name').html(classNm);
	$('.class-id').val(course_id);
	$('.class-term').val(learnPeriod);	
	getUserInfo(user_id);
	getCardinalDetail(cardinal_id);
	
}

function getCardinalDetail(cardinalId) {
	$.ajax({
		url: "/smtp/course/getCardinalDetail"
		, type: "GET"
		, data: {
			cardinalId : cardinalId
		}
		, success : function(data) {
			
			
			if(data.PRICE != null) {
				classPrice = Number(data.PRICE).toLocaleString('en') + '원';
				realPrice = data.PAY_CRC_AMOUNT;
				
				
				$(".class_name").html(data.NAME);
				$(".cardinals_days").html(data.LEARN_START_DATE + " ~ " + data.LEARN_END_DATE);
				$(".class-price").html(classPrice);
				$('.class-pay-price').attr('data-value', realPrice);
				$('.class-pay-price').html(classPrice);
				$('.price-total').attr('data-value', realPrice);
				$('.price-total').html(realPrice.toLocaleString('en') + '원');
				
				$('.modal').show()
				$('html, body').addClass("not-scroll");
			} else {
				alert("결제기간이 아닙니다.");
				$('.modal').hide();
			}
			
			
//			makeSignature(realPrice);
		}
		, error : function() {
			alert("Cardianl Detail 실패");
		}
	});
}

function getUserInfo(user_id) {
	$.ajax({
		url: "/smtp/course/getUserInfo"
		, type: "GET"
		, data: {
			"user_id" : user_id
		}
		, success : function(data) {
			
/*			$('.user_name').html(data.user_nm);
			$('.user_birth').html(data.user_birth);		*/	
			
			$('input[name$="buyername"]').val(data.user_nm);
			$('input[name$="buyeremail"]').val(data.user_email);
			$('input[name$="buyertel"]').val(data.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
			$('.user_belong_to').val(data.user_belong_to);
			
			$('#merCourse').val(course_id);
			$('#merPhone').val(data.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
			$('#merEmail').val(data.user_email);
				
//			$('#post_code').val(data.user_zipcode);
//			$('#addr1').val(data.user_addr1);
//			$('#addr2').val(data.user_addr2);
		}
		, error : function() {
			alert("User Info 실패");
		}
	});
}

function makeSignature(realPrice) {
	$.ajax({
		url: "/smtp/course/makesignature"
		, type: "GET"
		, data : {
			price : realPrice
		}
		, dataType : "json"
		, success : function(data) {
			$('input[name$="price"]').val(realPrice);
			$('input[name$="goodname"]').val(classNm);
			$('input[name$="mid"]').val(data.mid);
			$('input[name$="oid"]').val(data.oid);
			$('input[name$="timestamp"]').val(data.timestamp);
			$('input[name$="mKey"]').val(data.mKey);
			$('input[name$="signature"]').val(data.signature);
		}
		, error : function(data) {
			alert("실패");
		}
	});
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
  				document.location.href = "/smtp/user/sub05-04";
  				return;
			}
		}
	});    			
	
}

function payProgress() {
	$('.btnSubmit').click(function() {
		
		/* -------------------유효성 검사---------------------- */

		if(!confirm('기재된 정보는 다시 수정할 수 없습니다. 결제하시겠습니까?')){            		
			return;
		}
		
		var finalPrice = $('.price-total').data('value');
		var regMail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		var a = $('input[name="email01"]').val();
		var b = $('input[name="email02"]').val();
		var email = a +"@" + b; 
		if(!regMail.test(email)){
			alert('이메일은 필수입력사항입니다. 이메일 형식을 확인바랍니다.');
			return;
		};
		var regPhone = /^\d{3}-\d{3,4}-\d{4}$/;
		
		var p1 = $('.phone_0').val();
		var p2 = $('input[name="mobile-phone2"]').val();
		var p3 = $('input[name="mobile-phone3"]').val();
		var phone = p1 +"-" +p2 + "-" +p3;
		if(!regPhone.test(phone)){
			alert('전화번호는 필수입력사항입니다. 000-000-0000 형식으로 입력해주세요.');
			return;
		}
		
		if($('#post_code').val() == '' || $('#addr1').val() == '' || $('#addr2').val() == ''){
			alert('주소는 필수입력사항입니다. 상세정보를 등록해주세요.');
			return;
		}

		/* -------------------유효성 검사---------------------- */		

		//이미 입과처리된 강좌일 경우, 중복해서 수강신청 할 수 없다.
		var cardinal_id = $('#merCardinal').val();
		checkAlreadyEnrolled(course_id, cardinal_id);
		
		$('#merCourse').val(course_id);
		$('#merPoint').val($('#point_use').val());
		$('input[name$="buyeremail"]').val(email);
		$('input[name$="buyertel"]').val(phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
		
		$('#merPhone').val(phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
		$('#merEmail').val(email);

		makeSignature(finalPrice);
		
		if(!$('#agree01').prop('checked')){
    		alert('첫번째 동의란에 체크해주시기 바랍니다.');
    		return;
    	}

		if(!$('#agree02').prop('checked')){
    		alert('두번째 동의란에 체크해주시기 바랍니다.');
    		return;
    	}
		
		var paymethod = $('input[name=payment]:checked').val();
		
		if (paymethod == 'Card') {
			$("#gopaymethod").val('Card');
		} else if (paymethod == 'VBank') {
			$("#gopaymethod").val('VBank');
    	} else {
    		alert("결제방법을 체크해주시기 바랍니다.");
    		return;
    	}

    	$("#payreq").click();
        $('html, body').removeClass("not-scroll");
        $('.modal').hide();
	});
	
	$('btnCancel').on('click', function(){
	    $('html, body').removeClass("not-scroll");
	    $('.modal').hide();
	});
}
