<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
<title>글로벌 엔지니어 양성</title>
<script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link
	href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script type="text/javascript"
	src="/resources/segroup/js/jquery.timepicker.min.js"></script>
<!-- 타이머js -->
<link type="text/css" rel="stylesheet"
	href="/resources/segroup/css/jquery.timepicker.css" media="" />
<!-- 타이머css -->
<style>
html, body {
	height: 100%;
	width: 100%;
	margin: 0;
	display: table;
}

.footer {
	display: table-row;
	height: 0;
}

.top_img {
	position: relative;
	background-image:
		url(/resources/segroup/society/edu/image/main/top_img/top_img_offline.jpg);
	height: 250px;
	background-size: cover;
}
</style>
</head>
<script type="text/javascript">
	// 정규표현식
	var nm_regex = new RegExp("[가-힣]+");
	var age_regex = new RegExp("[0-9]{2}");
	var phone_regex = new RegExp("[0-9]{11}");
	var email_regex = new RegExp(
			"([0-9a-zA-Z]+)(\@{1})([0-9a-zA-Z]+)([\.]{1})([0-9a-zA-Z]+)");

	/**
	 * angular.js
	 */
	var myApp = angular.module('myapp', []);
	myApp.directive('code', [ '$http', function($http) {
		return {
			restrict : "E",
			replace : true,
			scope : {
				value : '@'
			},
			controller : function($scope, $element, $attrs) {
				$http({
					method : 'POST',
					url : '/codeconverter',
					responseType : 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
					$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			},
			template : "<span>{{filterParams}}</span>"
		}
	} ]);

	/**
	 * 페이지가 로딩되면 실행
	 */
	$(function() {
		// 성별라디오버튼
		$.each($('div.line > a.radio'), function(index, button) {
			$(button).on('click', radioOnChange);
		});

		// 달력설정 & 시간설정 연결하기
		$("#apply_date").datepicker();
		$("#apply_time").timepicker({
			'minTime' : '09:00am', // 조회하고자 할 시작 시간 ( 09시 부터 선택 가능하다. )
			'maxTime' : '20:00pm', // 조회하고자 할 종료 시간 ( 20시 까지 선택 가능하다. )
			'timeFormat' : 'H:i',
			'step' : 30
		// 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
		});

		// 전문보기에서 확인버튼 클릭시
		$(".btn_pop").click(function() {
			$('.check_box').addClass("check_box_a");
		});
	});

	/**
	 * 서브밋하기 전에 데이터를 체크한다
	 */
	function checkOnSubmit() {
		if (isNameCorrect() == false) {
			return false;
		}
		if (isSexSelected() == false) {
			return false;
		}
		if (isAgeCorrect() == false) {
			return false;
		}
		if (isMajorCorrect() == false) {
			return false;
		}
		if (isPhoneNumCorrect() == false) {
			return false;
		}
		if (isEmailCorrect() == false) {
			return false;
		}
		if (isDateCorrect() == false) {
			return false;
		}
		if (isTitleCorrect() == false) {
			return false;
		}
		if (isContentsCorrect() == false) {
			return false;
		}
		if (isCheckboxCorrect() == false) {
			return false;
		}
		ajaxSubmit();
	}

	/**
	 * 이름 검사를 진행한다
	 */
	function isNameCorrect() {
		var input_nm = $('#user_nm');
		if (input_nm.val() == '') {
			alert('이름을 입력해 주시기 바랍니다');
			selectAndFocus(input_nm);
			return false;
		}
		if (nm_regex.test(input_nm.val()) == false) {
			alert('이름은 한국어로 작성해 주시기 바랍니다');
			selectAndFocus(input_nm);
			return false;
		}
		return true;
	}

	/**
	 * 성별을 선택했는지
	 */
	function isSexSelected() {
		var user_sex = $('#user_sex');
		if (!user_sex.val()) {
			alert('성별을 선택해 주시기 바랍니다');
			selectAndFocus(user_sex);
			return false;
		}
		return true;
	}

	/**
	 * 나이를 입력했는지
	 */
	function isAgeCorrect() {
		var input_age = $('#user_age');
		if (input_age.val() == '') {
			alert('나이를 입력해 주시기 바랍니다');
			selectAndFocus(input_age);
			return false;
		}
		if (age_regex.test(input_age.val()) == false) {
			alert('나이는 숫자로 작성해 주시기 바랍니다');
			selectAndFocus(input_age);
			return false;
		}
		return true;
	}

	/**
	 * 전공을 입력했는지
	 */
	function isMajorCorrect() {
		var user_major = $('#user_major');
		if (user_major.val() == '') {
			alert('전공을 입력해 주시기 바랍니다');
			selectAndFocus(user_major);
			return false;
		}
		return true;
	}

	/**
	 * 전화번호 검사를 진행한다
	 * return: 제대로 되었으면 true, 다르면 false
	 */
	function isPhoneNumCorrect() {
		// 전화번호가 올바르면 데이터를 넣는다
		var phoneNum = $('#user_phone');

		if (phoneNum.val() == '') {
			alert('전화번호를 입력해 주시기 바랍니다');
			selectAndFocus(phoneNum);
			return false;
		}

		return true;
	}

	/**
	 * 이메일을 적었는지
	 */
	function isEmailCorrect() {
		var input_email = $('#user_email');

		if (input_email.val() == '') {
			alert('이메일을 입력해 주시기 바랍니다');
			selectAndFocus(input_email);
			return false;
		}

		if (email_regex.test(input_email.val()) == false) {
			alert('이메일이 형식에 맞지 않습니다');
			selectAndFocus(input_email);
			return false;
		}
		return true;
	}

	/**
	 * 상담일 신청날짜가 맞는가
	 */
	function isDateCorrect() {
		var input_date = $('#apply_date');
		var apply_time = $('#apply_time');

		if (input_date.val() == '') {
			alert('상담날짜를 입력해 주시기 바랍니다');
			selectAndFocus(input_date);
			return false;
		}

		if (apply_time.val() == '') {
			alert('상담시간을 입력해 주시기 바랍니다');
			selectAndFocus(apply_time);
			return false;
		}

		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1; //January is 0!
		var yyyy = today.getFullYear();
		if (dd < 10) {
			dd = '0' + dd
		}
		if (mm < 10) {
			mm = '0' + mm
		}
		today = "" + yyyy + mm + dd;
		if (today >= input_date.val().replace(/\-/g, '')) {
			alert('과거는 선택하실 수 없습니다');
			selectAndFocus(input_date);
			return false;
		}

		var regNumber = /^[0-9]*$/;
		if (!regNumber.test(apply_time.val().replace(/\:/g, ''))) {
			alert('시간 형식에 맞추어 주시기 바랍니다');
			selectAndFocus(apply_time);
			return false;
		}

		var minTime = 900; // 09:00am을 의미
		var maxTime = 2000; // 20:00pm을 의미
		if (minTime > apply_time.val().replace(/\:/g, '')
				|| maxTime < apply_time.val().replace(/\:/g, '')) {
			alert('정해진 시간 이내로 입력해 주시기 바랍니다');
			selectAndFocus(apply_time);
			return false;
		}
		return true;
	}

	/**
	 * 상담내용을 입력했는지
	 */
	function isTitleCorrect() {
		var apply_title = $('#apply_title');
		if (apply_title.val() == '') {
			alert('상담제목을 입력해 주시기 바랍니다');
			selectAndFocus(apply_title);
			return false;
		}
		return true;
	}

	/**
	 * 상담내용을 입력했는지
	 */
	function isContentsCorrect() {
		var apply_contents = $('#apply_contents');
		if (apply_contents.val() == '') {
			alert('상담내용을 입력해 주시기 바랍니다');
			selectAndFocus(apply_contents);
			return false;
		}
		return true;
	}

	/**
	 * 동의체크를 확인한다
	 */
	function isCheckboxCorrect() {
		var checkbox = $('.master_agree_wrap .agree_line b.check_box');
		if (checkbox.hasClass('check_box_a') == false) {
			alert('개인정보 처리방침에 동의해 주시기 바랍니다');
			canPass = false;
			return false;
		}
		return true;
	}

	/**
	 * 엘리먼트를 선택한다
	 */
	function selectAndFocus(element) {
		element.select();
		element.focus();
	}

	/**
	 * 유저 성별 선택 이벤트
	 */
	function radioOnChange(evt) {
		$.each($('div.line > a.btn'), function(index, button) {
			var obj_button = $(button);
			var input_user_sex = $('#user_sex');
			if (evt.currentTarget == button) {
				obj_button.addClass('btn_b');
				obj_button.removeClass('btn_gray btn_fore_black');
				input_user_sex.val(obj_button.attr('value'));
			} else {
				obj_button.addClass('btn_gray btn_fore_black');
				obj_button.removeClass('btn_b');
			}
		});
	}

	/**
	 * 서버에 신청 서비스 요청
	 */
	function ajaxSubmit() {
		// 		alert("Ajax 신청서비스 들어가기 전~!");
		var formData = $("#multiForm").serialize();

		$.ajax({
			type : "POST",
			url : '<c:url value="/edu/consulting/apply_offline" />',
			data : formData,
			success : function(isRequested) {
				if (isRequested) {
					alert('신청에 성공하였습니다. 작성하신 이메일을 통해 접수내용을 확인하실 수 있습니다.');
					location.href = "<c:url value='/ictcenter' />";
				} else {
					alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
				}
			},
			error : function(e) {
				alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
			}
		});
	}
</script>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<div class="top_img">
		<div class="top_img_text">
			<p class="top_img_text1">오프라인 상담신청</p>
			<p class="top_img_text2">직접 찾아와서 상담받고 싶다! 여기서 신청해 주세요~!</p>
		</div>
	</div>

	<div style="overflow: hidden; width: 100%; height: 50px;"></div>

	<div class="notice_wrap">
		<!-- 		<div class="main_notice_title1" -->
		<!-- 			style="padding-top: 70px; padding-bottom: 30px;"> -->
		<!-- 			<h1>오프라인 상담 신청</h1> -->
		<!-- 		</div> -->
		<div class="form_box">
			<form id="multiForm" name="multiForm"
				onsubmit="return checkOnSubmit();">

				<div class="line">
					<input class="ip_2" type="text" id="user_nm" name="user_nm"
						maxlength="4" placeholder="이름" value="${user.user_nm }" />
				</div>

				<div class="line line_align_center">
					<a class="btn btn_fifty_width btn_gray btn_fore_black radio"
						id="user_sex_m" value="남자"><code value="A0000"></code></a> <a
						class="btn btn_fifty_width btn_gray btn_fore_black radio"
						id="user_sex_f" value="여자"><code value="A0001"></code></a> <input
						type="hidden" id="user_sex" name="user_sex"
						value="${user.user_sex }">
				</div>

				<div class="line">
					<input class="ip_2" type="text" id="user_age" name="user_age"
						maxlength="2" placeholder="나이" value="" />
				</div>

				<div class="line">
					<input class="ip_2" type="text" id="user_major" name="user_major"
						maxlength="30" placeholder="학과" value="" />
				</div>

				<div class="line">
					<input class="ip_2" type="tel" id="user_phone" name="user_phone"
						maxlength="14" placeholder="전화번호" value="${user.user_phone }" />
				</div>

				<div class="line">
					<input class="ip_2" type="email" id="user_email" name="user_email"
						maxlength="50" placeholder="이메일" value="${user.user_email }" />
				</div>

				<div class="line">
					<input class="ip_3" type="text" id="apply_date" name="apply_date"
						placeholder="상담 날짜" value="" readonly="readonly" /> <input
						class="ip_3" type="text" id="apply_time" name="apply_time"
						placeholder="상담 시간" value="" />
				</div>

				<div class="line">
					<input class="ip_2" type="text" id="apply_title" name="apply_title"
						maxlength="30" placeholder="상담 제목" value="${user.apply_title }" />
				</div>

				<!--                     join.css에서 높이조절이 가능하다 -->
				<div class="line_textarea">
					<textarea class="ip_2" id="apply_contents" name="apply_contents"
						maxlength="1000" placeholder="상담 내용"></textarea>
				</div>

				<div class="agree agree_1" style="width: 840px;">
					<p class="agree_title">(주)소프트엔지니어소사이어티 개인정보 처리방침</p>
					<p class="agree_text">
					<ul style="list-style-type: none;">
						<li>(주)소프트엔지니어소사이어티(이하 ‘SES’라 한다)는 개인정보 보호법 제30조에 따라 정보주체의
							개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보
							처리지침을 수립․공개합니다.</li>
						<li>&nbsp;</li>
						<li>제1조(개인정보의 처리목적) SES는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는
							개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에
							따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</li>
						<li>&nbsp;</li>
						<li>1. 홈페이지 회원 가입 및 관리</li>
						<li>회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별․인증, 회원자격 유지․관리, 제한적
							본인확인제 시행에 따른 본인확인, 서비스 부정이용 방지, 만 14세 미만 아동의 개인정보 처리시 법정대리인의 동의여부
							확인, 각종 고지․통지, 고충처리 등을 목적으로 개인정보를 처리합니다.</li>
						<li>2. 재화 또는 서비스 제공</li>
						<li>물품배송, 서비스 제공, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증, 요금결제․정산, 채권추심
							등을 목적으로 개인정보를 처리합니다.</li>
						<li>3. 고충처리</li>
						<li>민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리결과 통보 등의 목적으로
							개인정보를 처리합니다.</li>
						<li>&nbsp;</li>
						<li>제2조(개인정보의 처리 및 보유기간) ① SES는 법령에 따른 개인정보 보유․이용기간 또는
							정보주체로부터 개인정보를 수집시에 동의받은 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다.</li>
						<li>&nbsp;</li>
						<li>② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.</li>
						<li>&nbsp;</li>
						<li>1. 홈페이지 회원 가입 및 관리 : SES 홈페이지 탈퇴시까지</li>
						<li>다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료시까지</li>
						<li>1) 관계 법령 위반에 따른 수사․조사 등이 진행중인 경우에는 해당 수사․조사 종료시까지</li>
						<li>2) 홈페이지 이용에 따른 채권․채무관계 잔존시에는 해당 채권․채무관계 정산시까지</li>
						<li>&nbsp;</li>
						<li>2. 재화 또는 서비스 제공 : 재화․서비스 공급완료 및 요금결제․정산 완료시까지</li>
						<li>다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료시까지</li>
						<li>1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른 표시․광고, 계약내용 및 이행 등 거래에
							관한 기록</li>
						<li>- 표시․광고에 관한 기록 : 6월</li>
						<li>- 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년</li>
						<li>- 소비자 불만 또는 분쟁처리에 관한 기록 : 3년</li>
						<li>2)「통신비밀보호법」제41조에 따른 통신사실확인자료 보관</li>
						<li>- 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월</li>
						<li>&nbsp;</li>
						<li>제3조(개인정보의 제3자 제공) ① SES는 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서
							명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조에 해당하는 경우에만
							개인정보를 제3자에게 제공합니다.</li>
						<li>② SES는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.</li>
						<li>- 개인정보를 제공받는 자 : (주) 디지틀조선</li>
						<li>- 제공받는 자의 개인정보 이용목적 : 모의토플 시험 응시</li>
						<li>- 제공하는 개인정보 항목 : 성명, 생년월일</li>
						<li>- 제공받는 자의 보유․이용기간 : 결제일로부터 1년</li>
						<li>&nbsp;</li>
						<li>제4조(정보주체의 권리․의무 및 행사방법) ① 정보주체는 SES에 대해 언제든지 다음 각 호의 개인정보
							보호 관련 권리를 행사할 수 있습니다.</li>
						<li>1. 개인정보 열람요구</li>
						<li>2. 오류 등이 있을 경우 정정 요구</li>
						<li>3. 삭제요구</li>
						<li>4. 처리정지 요구</li>
						<li>② 제1항에 따른 권리 행사는 SES에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여
							하실 수 있으며 SES는 이에 대해 지체없이 조치하겠습니다.</li>
						<li>③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 SES는 정정 또는 삭제를
							완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
						<li>④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수
							있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
						<li>⑤ 정보주체는 개인정보 보호법 등 관계법령을 위반하여 SES가 처리하고 있는 정보주체 본인이나 타인의
							개인정보 및 사생활을 침해하여서는 아니됩니다.</li>
						<li>&nbsp;</li>
						<li>제5조(처리하는 개인정보 항목) SES는 다음의 개인정보 항목을 처리하고 있습니다.</li>
						<li>1. 홈페이지 회원 가입 및 관리</li>
						<li>․필수항목 : 성명, 생년월일, 아이디, 비밀번호, 전화번호, 성별, 이메일주소</li>
						<li>&nbsp;</li>
						<li>2. 재화 또는 서비스 제공</li>
						<li>․필수항목 : 성명, 생년월일, 아이디, 비밀번호, 주소, 전화번호, 이메일주소, 신용카드번호,
							은행계좌정보 등 결제정보</li>
						<li>․선택항목 : 과거 구매내역</li>
						<li>&nbsp;</li>
						<li>3. 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.</li>
						<li>․IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등</li>
						<li>&nbsp;</li>
						<li>제6조(개인정보의 파기) ① SES는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게
							되었을 때에는 지체없이 해당 개인정보를 파기합니다.</li>
						<li>② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에
							따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를
							달리하여 보존합니다.</li>
						<li>③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.</li>
						<li>1. 파기절차</li>
						<li>SES는 파기 사유가 발생한 개인정보를 선정하고, SES의 개인정보 보호책임자의 승인을 받아 개인정보를
							파기합니다.</li>
						<li>2. 파기방법</li>
						<li>SES는 전자적 파일 형태로 기록․저장된 개인정보는 기록을 재생할 수 없도록 로우레밸포멧(Low
							Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에 기록․저장된 개인정보는 분쇄기로 분쇄하거나
							소각하여 파기합니다.</li>
						<li>&nbsp;</li>
						<li>제7조(개인정보의 안전성 확보조치) SES는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고
							있습니다.</li>
						<li>1. 관리적 조치 : 내부관리계획 수립․시행, 정기적 직원 교육 등</li>
						<li>2. 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의
							암호화, 보안프로그램 설치</li>
						<li>3. 물리적 조치 : 전산실, 자료보관실 등의 접근통제</li>
						<li>&nbsp;</li>
						<li>제8조(개인정보 보호책임자) ① SES는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보
							처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</li>
						<li>&nbsp;</li>
						<li>▶ 개인정보 보호책임자</li>
						<li>성명 : 최승호</li>
						<li>직책 : 과장</li>
						<li>연락처 : 전화 02-6000-5189, 이메일 kaeback@sesoc.global, FAX
							02-6000-6261</li>
						<li>&nbsp;</li>
						<li>② 정보주체께서는 SES의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의,
							불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다. SES는 정보주체의 문의에 대해
							지체없이 답변 및 처리해드릴 것입니다.</li>
						<li>&nbsp;</li>
						<li>제9조(개인정보 열람청구) 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의
							부서에 할 수 있습니다. SES는 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.</li>
						<li>&nbsp;</li>
						<li>▶ 개인정보 열람청구 접수․처리 부서</li>
						<li>부서명 : O2O 클라우드팀</li>
						<li>담당자 : 최승호</li>
						<li>연락처 : 전화 02-6000-5189, 이메일 kaeback@sesoc.global, FAX
							02-6000-6261</li>
						<li>&nbsp;</li>
						<li>제10조(권익침해 구제방법) 정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을
							문의하실 수 있습니다.</li>
						<li>&nbsp;</li>
						<li>&lt;아래의 기관은 SES와는 별개의 기관으로서, SES의 자체적인 개인정보 불만처리, 피해구제
							결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다&gt;</li>
						<li>&nbsp;</li>
						<li>▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)</li>
						<li>- 소관업무 : 개인정보 침해사실 신고, 상담 신청</li>
						<li>- 홈페이지 : privacy.kisa.or.kr</li>
						<li>- 전화 : (국번없이) 118</li>
						<li>- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
						<li>&nbsp;</li>
						<li>▶ 개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)</li>
						<li>- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)</li>
						<li>- 홈페이지 : privacy.kisa.or.kr</li>
						<li>- 전화 : (국번없이) 118</li>
						<li>- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
						<li>&nbsp;</li>
						<li>▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)</li>
						<li>&nbsp;</li>
						<li>▶ 경찰청 사이버테러대응센터 : 1566-0112 (www.netan.go.kr)</li>
						<li>&nbsp;</li>
						<li>제11조(개인정보 처리방침 변경) ① 이 개인정보 처리방침은 2018. 8. 1부터 적용됩니다.</li>
					</ul>
					</p>
				</div>
				<!-- agree -->
				<div class="agree_line">
					<p class="terms">
						<b class="check_box"></b>개인정보 처리방침 동의<span class="see_more sm1">전문보기
							+</span>
					</p>
				</div>
				<!-- agree_line -->
				<div class="line line_align_center"
					style="margin: 30px 0px 0px 0px;">
					<input class="join_btn ip_4" type="submit" value="신청하기">
				</div>
			</form>
		</div>
		<br /> <br />
	</div>

	<%@include file="../footer.jsp"%>

	<div class="agree_pop_bk">
		<div class="agree_all agree_all_01">
			<div class="agree_all_txt">
				<p class="agree_title">(주)소프트엔지니어소사이어티 개인정보 처리방침</p>
				<p class="agree_text">
				<ul style="list-style-type: none;">
					<li>(주)소프트엔지니어소사이어티(Soft Engineer Society)의 개인정보취급방침은 다음과 같은
						내용을 담고 있습니다.</li>
					<li>&nbsp;</li>
					<li>(주)소프트엔지니어소사이어티(이하 ‘SES’라 한다)는 개인정보 보호법 제30조에 따라 정보주체의
						개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을
						수립․공개합니다.</li>
					<li>&nbsp;</li>
					<li>제1조(개인정보의 처리목적) SES는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는
						개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라
						별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</li>
					<li>&nbsp;</li>
					<li>1. 홈페이지 회원 가입 및 관리</li>
					<li>회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별․인증, 회원자격 유지․관리, 제한적 본인확인제
						시행에 따른 본인확인, 서비스 부정이용 방지, 만 14세 미만 아동의 개인정보 처리시 법정대리인의 동의여부 확인, 각종
						고지․통지, 고충처리 등을 목적으로 개인정보를 처리합니다.</li>
					<li>2. 재화 또는 서비스 제공</li>
					<li>물품배송, 서비스 제공, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증, 요금결제․정산, 채권추심
						등을 목적으로 개인정보를 처리합니다.</li>
					<li>3. 고충처리</li>
					<li>민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리결과 통보 등의 목적으로 개인정보를
						처리합니다.</li>
					<li>&nbsp;</li>
					<li>제2조(개인정보의 처리 및 보유기간) ① SES는 법령에 따른 개인정보 보유․이용기간 또는 정보주체로부터
						개인정보를 수집시에 동의받은 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다.</li>
					<li>&nbsp;</li>
					<li>② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.</li>
					<li>&nbsp;</li>
					<li>1. 홈페이지 회원 가입 및 관리 : SES 홈페이지 탈퇴시까지</li>
					<li>다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료시까지</li>
					<li>1) 관계 법령 위반에 따른 수사․조사 등이 진행중인 경우에는 해당 수사․조사 종료시까지</li>
					<li>2) 홈페이지 이용에 따른 채권․채무관계 잔존시에는 해당 채권․채무관계 정산시까지</li>
					<li>&nbsp;</li>
					<li>2. 재화 또는 서비스 제공 : 재화․서비스 공급완료 및 요금결제․정산 완료시까지</li>
					<li>다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료시까지</li>
					<li>1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른 표시․광고, 계약내용 및 이행 등 거래에
						관한 기록</li>
					<li>- 표시․광고에 관한 기록 : 6월</li>
					<li>- 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년</li>
					<li>- 소비자 불만 또는 분쟁처리에 관한 기록 : 3년</li>
					<li>2)「통신비밀보호법」제41조에 따른 통신사실확인자료 보관</li>
					<li>- 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월</li>
					<li>&nbsp;</li>
					<li>제3조(개인정보의 제3자 제공) ① SES는 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서
						명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조에 해당하는 경우에만
						개인정보를 제3자에게 제공합니다.</li>
					<li>② SES는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.</li>
					<li>- 개인정보를 제공받는 자 : (주) 디지틀조선</li>
					<li>- 제공받는 자의 개인정보 이용목적 : 모의토플 시험 응시</li>
					<li>- 제공하는 개인정보 항목 : 성명, 생년월일</li>
					<li>- 제공받는 자의 보유․이용기간 : 결제일로부터 1년</li>
					<li>&nbsp;</li>
					<li>제4조(정보주체의 권리․의무 및 행사방법) ① 정보주체는 SES에 대해 언제든지 다음 각 호의 개인정보
						보호 관련 권리를 행사할 수 있습니다.</li>
					<li>1. 개인정보 열람요구</li>
					<li>2. 오류 등이 있을 경우 정정 요구</li>
					<li>3. 삭제요구</li>
					<li>4. 처리정지 요구</li>
					<li>② 제1항에 따른 권리 행사는 SES에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실
						수 있으며 SES는 이에 대해 지체없이 조치하겠습니다.</li>
					<li>③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 SES는 정정 또는 삭제를
						완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
					<li>④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수
						있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
					<li>⑤ 정보주체는 개인정보 보호법 등 관계법령을 위반하여 SES가 처리하고 있는 정보주체 본인이나 타인의
						개인정보 및 사생활을 침해하여서는 아니됩니다.</li>
					<li>&nbsp;</li>
					<li>제5조(처리하는 개인정보 항목) SES는 다음의 개인정보 항목을 처리하고 있습니다.</li>
					<li>1. 홈페이지 회원 가입 및 관리</li>
					<li>․필수항목 : 성명, 생년월일, 아이디, 비밀번호, 전화번호, 성별, 이메일주소</li>
					<li>&nbsp;</li>
					<li>2. 재화 또는 서비스 제공</li>
					<li>․필수항목 : 성명, 생년월일, 아이디, 비밀번호, 주소, 전화번호, 이메일주소, 신용카드번호,
						은행계좌정보 등 결제정보</li>
					<li>․선택항목 : 과거 구매내역</li>
					<li>&nbsp;</li>
					<li>3. 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.</li>
					<li>․IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등</li>
					<li>&nbsp;</li>
					<li>제6조(개인정보의 파기) ① SES는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게
						되었을 때에는 지체없이 해당 개인정보를 파기합니다.</li>
					<li>② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에
						따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를
						달리하여 보존합니다.</li>
					<li>③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.</li>
					<li>1. 파기절차</li>
					<li>SES는 파기 사유가 발생한 개인정보를 선정하고, SES의 개인정보 보호책임자의 승인을 받아 개인정보를
						파기합니다.</li>
					<li>2. 파기방법</li>
					<li>SES는 전자적 파일 형태로 기록․저장된 개인정보는 기록을 재생할 수 없도록 로우레밸포멧(Low
						Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에 기록․저장된 개인정보는 분쇄기로 분쇄하거나
						소각하여 파기합니다.</li>
					<li>&nbsp;</li>
					<li>제7조(개인정보의 안전성 확보조치) SES는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고
						있습니다.</li>
					<li>1. 관리적 조치 : 내부관리계획 수립․시행, 정기적 직원 교육 등</li>
					<li>2. 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의
						암호화, 보안프로그램 설치</li>
					<li>3. 물리적 조치 : 전산실, 자료보관실 등의 접근통제</li>
					<li>&nbsp;</li>
					<li>제8조(개인정보 보호책임자) ① SES는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와
						관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</li>
					<li>&nbsp;</li>
					<li>▶ 개인정보 보호책임자</li>
					<li>성명 : 최승호</li>
					<li>직책 : 과장</li>
					<li>연락처 : 전화 02-6000-5189, 이메일 kaeback@sesoc.global, FAX
						02-6000-6261</li>
					<li>&nbsp;</li>
					<li>② 정보주체께서는 SES의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의,
						불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다. SES는 정보주체의 문의에 대해
						지체없이 답변 및 처리해드릴 것입니다.</li>
					<li>&nbsp;</li>
					<li>제9조(개인정보 열람청구) 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의
						부서에 할 수 있습니다. SES는 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.</li>
					<li>&nbsp;</li>
					<li>▶ 개인정보 열람청구 접수․처리 부서</li>
					<li>부서명 : O2O 클라우드팀</li>
					<li>담당자 : 최승호</li>
					<li>연락처 : 전화 02-6000-5189, 이메일 kaeback@sesoc.global, FAX
						02-6000-6261</li>
					<li>&nbsp;</li>
					<li>제10조(권익침해 구제방법) 정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을
						문의하실 수 있습니다.</li>
					<li>&nbsp;</li>
					<li>&lt;아래의 기관은 SES와는 별개의 기관으로서, SES의 자체적인 개인정보 불만처리, 피해구제 결과에
						만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다&gt;</li>
					<li>&nbsp;</li>
					<li>▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)</li>
					<li>- 소관업무 : 개인정보 침해사실 신고, 상담 신청</li>
					<li>- 홈페이지 : privacy.kisa.or.kr</li>
					<li>- 전화 : (국번없이) 118</li>
					<li>- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
					<li>&nbsp;</li>
					<li>▶ 개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)</li>
					<li>- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)</li>
					<li>- 홈페이지 : privacy.kisa.or.kr</li>
					<li>- 전화 : (국번없이) 118</li>
					<li>- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
					<li>&nbsp;</li>
					<li>▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)</li>
					<li>&nbsp;</li>
					<li>▶ 경찰청 사이버테러대응센터 : 1566-0112 (www.netan.go.kr)</li>
					<li>&nbsp;</li>
					<li>제11조(개인정보 처리방침 변경) ① 이 개인정보 처리방침은 2018. 8. 1부터 적용됩니다.</li>
				</ul>
				</p>

			</div>
			<div class="btn_pop">확인</div>
		</div>
		<!--agree_all-->
	</div>
	<!--agree_pop_bk-->
</body>
</html>