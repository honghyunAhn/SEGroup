<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.inicis.std.util.SignatureUtil"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no"> -->
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script type="text/javascript">
	// 정규표현식
	var phone_regex = /^\d{3}\d{3,4}\d{4}$/;
	var pw_regex = new RegExp("[0-9a-zA-Z!@#$%^&*]+"); // 수정 필요
	var nm_regex = new RegExp("[가-힣]+");
	var birth_regex = new RegExp("[0-9]{8}");
	var email_regex = new RegExp(
			"([0-9a-zA-Z]+)(\@{1})([0-9a-zA-Z]+)([\.]{1})([0-9a-zA-Z]+)");
	var total_apply_num = 0;
	var total_apply_num2 = 0;

	// 상수
	const USER_ID_USABLE = '사용 가능한 아이디입니다';
	const USER_ID_NOT_USABLE = '사용 불가능한 아이디입니다. 다시 한 번 작성해 주시기 바랍니다.';
	const PW_MIN_LENGTH = 8;
	const PW_MAX_LENGTH = 12;

	/**
	 * 서브밋하기 전에 데이터를 체크한다
	 */
	function checkOnSubmit() {
		if (isPasswordCorrect() == false) {
			return false;
		}
		if (isNameCorrect() == false) {
			return false;
		}
		if (isPhoneNumCorrect() == false) {
			return false;
		}
		if (isEmailCorrect() == false) {
			return false;
		}
		if (isBirthCorrect() == false) {
			return false;
		}
		if (isSexSelected() == false) {
			return false;
		}
		if(confirm("수정 하시겠습니까 ?")){
			return true;
		}else{
			return false;
		}
		
	}
	
    function passwordCheckOnSubmit() {

        var input_pw = $('#user_pw_delete');
        var input_pw_val = input_pw.val();

        if (input_pw_val == '') {
            alert('비밀번호를 입력해 주시기 바랍니다');
            selectAndFocus(input_pw);
            return false;
        }

        if (input_pw_val.length < PW_MIN_LENGTH
                || PW_MAX_LENGTH < input_pw_val.length) {
            alert('비밀번호 글자 수를 맞춰주십시요 (8~12자)');
            selectAndFocus(input_pw);
            return false;
        }

        if (pw_regex.test(input_pw_val) == false) {
            alert('비밀번호의 형식이 잘못 되었습니다');
            selectAndFocus(input_pw);
            return false;
        }
        
        if (!ajaxPwCheck()) {
            alert('사용자 비밀번호가 틀립니다.');
            selectAndFocus(input_pw);
            return false;
        }
		return true;
	}
    
    function ajaxPwCheck(){
    	var result = false;
        var form_data = {
              user_id : $("#user_id").val(),
              user_pw : $("#user_pw_delete").val(),
          };
          $.ajax({
              type : "POST",
              url : "/edu/user/user_password_check",
              data : form_data,
              cache : false,
              async : false,
              dataType : "text",
              success : function(response) {
                  if (response == 'success') {
                	  result = true;
                  }
              }, error : function(request, status, error) {
                  if (request.status != '0') {
                      alert("code : " + request.status + "\r\nmessage : "
                              + request.reponseText + "\r\nerror : " + error);
                  }
              }
        });
        return result;
    }

	/**
	 * 패스워드 검사를 진행한다
	 * return: 같으면 true, 다르면 false
	 */
	function isPasswordCorrect() {
		var input_pw = $('#user_pw');
		var input_pw_check = $('#user_pw_check');

		var input_pw_val = input_pw.val();
		var input_pw_check_val = input_pw_check.val();

		if (input_pw_val == '') {
			alert('비밀번호를 입력해 주시기 바랍니다');
			selectAndFocus(input_pw);
			return false;
		}

		if (input_pw_val.length < PW_MIN_LENGTH
				|| PW_MAX_LENGTH < input_pw_val.length) {
			alert('비밀번호 글자 수를 맞춰주십시요 (8~12자)');
			selectAndFocus(input_pw);
			return false;
		}

		if (pw_regex.test(input_pw_val) == false) {
			alert('비밀번호의 형식이 잘못 되었습니다');
			selectAndFocus(input_pw);
			return false;
		}

		if (input_pw_check_val == '') {
			alert('비밀번호 확인란에 입력해 주시기 바랍니다');
			selectAndFocus(input_pw_check);
			return false;
		}

		if (input_pw_val != input_pw_check_val) {
			alert('비밀번호가 일치하지 않습니다');
			selectAndFocus(input_pw);
			return false;
		}

		return true;
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
	 * 전화번호 검사를 진행한다
	 * return: 제대로 되었으면 true, 다르면 false
	 */
	function isPhoneNumCorrect() {
		// 전화번호가 올바르면 데이터를 넣는다
		var phoneNum = $('#user_phone').val();

		if (phoneNum == '') {
			alert('휴대폰 번호를 입력해 주시기 바랍니다');
			return false;
		}
		
		if(phone_regex.test(phoneNum) == false){
	        alert("휴대폰 번호를 양식에 맞게 입력해 주세요.");
	        return false;
		}

		$("#user_phone").val(phoneNum);
		return true;
	}

	/**
	 * 생년월일이 맞는가
	 */
	function isBirthCorrect() {
		var year = $('#birth_year').val();
		if (year == '') {
			alert('생년을 올바르게 작성해 주기시 바랍니다');
			return false;
		}
		if (year < 1900 || ${year} < year) {
		    alert('생년을 올바르게 작성해 주기시 바랍니다');
		    return false;
		}

		var month = $('#birth_month').val();
		if (month.length < 2) {
			alert('생월을 올바르게 작성해 주시기 바랍니다');
			return false;
		}
		if (month <= 0 || 12 < month) {
			alert('생월을 올바르게 작성해 주시기 바랍니다');
			return false;
		}

		var date = $('#birth_date').val();
		if (date.length < 2) {
			alert('생일을 올바르게 작성해 주시기 바랍니다');
			return false;
		}
		if (date < 1 || 31 < date) {
			alert('생일을 올바르게 작성해 주시기 바랍니다');
			return false;
		}

		var birth = year + month + date;
		if (birth_regex.test(birth) == false) {
			alert('생년월일이 형식에 맞지 않습니다');
			return false;
		}

		$('#user_birth').val(birth);
		return true;
	}

	/**
	 * 이메일을 적었는지
	 */
	function isEmailCorrect() {
		var input_email = $('#user_email');
		if (email_regex.test(input_email.val()) == false) {
			alert('이메일이 형식에 맞지 않습니다');
			return false;
		}
		return true;
	}

	/**
	 * 성별을 선택했는지
	 */
	function isSexSelected() {
		if (!$('#user_sex').val()) {
			alert('성별을 선택해 주시기 바랍니다');
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
	 * 페이지가 로딩되면 실행
	 */
	$(function() {
		$.each($('div.line > a.radio'), function(index, button) {
			$(button).on('click', radioOnChange);
		});
		var user_sex = $("#user_sex").val();
		if (user_sex == 'A0000') {
			$("#user_sex_m").trigger("click");
		} else {
			$("#user_sex_f").trigger("click");
		}
		$("#update").css("display", "block");
		$("#apply").css("display", "none");
		$("#payment").css("display", "none");
		$("#consulting").css("display", "none");
		$("#deletepage").css("display", "none");
	});
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

	function updateMember() {
		$.ajax({
			url : "/edu/user/user_update_json",
			dataType : "json",
			success : function(data) {
				$("#user_nm").val(data.user_nm);
				$("#user_phone").val(data.user_phone);
				$("#user_email").val(data.user_email);
				$("#birth_year").val(
						(JSON.stringify(data.user_birth)).substr(1, 4));
				$("#birth_month").val(
						(JSON.stringify(data.user_birth)).substr(6, 2));
				$("#birth_date").val(
						(JSON.stringify(data.user_birth)).substr(9, 2));
				$("#user_sex").val(data.user_sex);
				$("#user_pw").val("");
				$("#user_pw_check").val("");

				$(function() {
					$.each($('div.line > a.radio'), function(index, button) {
						$(button).on('click', radioOnChange);
					});
					var user_sex = $("#user_sex").val();
					if (user_sex == 'A0000') {
						$("#user_sex_m").trigger("click");
					} else {
						$("#user_sex_f").trigger("click");
					}
				});

			},
			error : function(e) {
				console.log(e);
			}
		});

		$("#update").css("display", "block");
		$("#apply").css("display", "none");
		$("#payment").css("display", "none");
		$("#consulting").css("display", "none");
		$("#deletepage").css("display", "none");
	}

	function convertDate(data) {

		var d = new Date(data);
		var formattedDate = d.getFullYear() + "-" + (d.getMonth() + 1) + "-"
				+ d.getDate();
		var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
		var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d
				.getMinutes();
		var formattedTime = hours + ":" + minutes + ":" + "00.0";
		formattedDate = formattedDate
		return formattedDate;

	}

	function convertDateCheck(data) {

		var d = new Date(data);

		var dd = d.getDate()
		var mm = d.getMonth() + 1; //January is 0!
		var yyyy = d.getFullYear();

		if (dd < 10) {
			dd = '0' + dd
		}

		if (mm < 10) {
			mm = '0' + mm
		}

		var formattedDate = mm + "/" + dd + "/" + yyyy;
		return formattedDate;

	}

	Date.prototype.yyyymmdd = function() {
		var mm = this.getMonth() + 1; // getMonth() is zero-based
		var dd = this.getDate();

		return [ this.getFullYear(), (mm > 9 ? '' : '0') + mm,
				(dd > 9 ? '' : '0') + dd ].join('');
	};

	function payCheck(apply, payment) {

		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth(); //January is 0!
		var yyyy = today.getFullYear();

		if (dd < 10) {
			dd = '0' + dd
		}

		if (mm < 10) {
			mm = '0' + mm
		}

		today = mm + '/' + dd + '/' + yyyy;

		var dateFrom = convertDateCheck(apply.PAY_CRC_START);
		var dateTo = convertDateCheck(apply.PAY_CRC_END);
		var dateCheck = today;
		var d1 = dateFrom.split("/");
		var d2 = dateTo.split("/");
		var c = dateCheck.split("/");

		var from = new Date(apply.PAY_CRC_START);
		var to = new Date(apply.PAY_CRC_END);
		var check = new Date(c[2], c[0], c[1]);
		
		
	/* 	var from = new Date(Date.parse(d1[2]+"-"+parseInt(d1[1])+"-"+d1[0]));//년월일
		var to = new Date(Date.parse(d2[2]+"-"+parseInt(d2[1])+"-"+d2[0]));
		var check = new Date(Date.parse(c[2]+"-"+parseInt(c[1])+"-"+c[0])); */

		if (apply.pay_status != null && apply.pay_status == '0') {//미결제상태인 경우.(무통장입금에만 해당)
			return "무통장입금 대기"
		} else if (apply.pay_status == '1'
				&& typeof apply.refund_status == 'undefined') {//결제가 완료된 경우.
			return "결제완료"
		} else if (apply.pay_status == '1' && apply.refund_status == '0') {//결제완료 후 사용자에 의한 환불요청이 진행중인 경우.
			return "환불대기"
		} else if (typeof apply.pay_status == 'undefined'
				&& apply.refund_status == '0') { //관리자에 의한 환불요청이 진행중인 경우 결제요청을 하지 못하도록 막는다.
			return "환불처리중"
		} else if (typeof apply.pay_status == 'undefined'
				&& typeof apply.refund_status != '0' && check >= from && check <= to) {//결제기간 내이고 진행중인 환불이 없는 경우에만 결제가 가능하다
			return "<input type='button' class='confirms_btn_small' value='결제요청' onclick=\"javascript:amountInfo(\'"
					+ apply.PAY_CRC_AMOUNT + "\',\'" + payment.gisu_crc_nm
					+ " " + payment.gisu_num + "기" + "\',\'"
					+ apply.PAY_CRC_SEQ + "\',\'" + from.yyyymmdd() + "\',\'"
					+ to.yyyymmdd() + "\')\"/></a>";
			
		} else {
			return "결제대기"
		}

	}

	function amountInfo(amount, name, seq, from, to) {

		$("#price").val(amount);
		$("#goodname").val(name);
		$("#pay_seq").val(seq);
		$("#pay_from").val(from);
		$("#pay_to").val(to);

		$("#userPayInfoForm").submit();
	}

	function apply() {
		$
				.ajax({
					url : "/edu/user/user_apply_history",
					dataType : "json",
					success : function(data) {
						var tab = document.getElementById('tab');
						tab.style.width = '90%';
						if (data.length > 0) {
							tab.innerHTML = "<colgroup><col width='15%'><col width='45%'><col width='10%'><col width='10%'><col width='20%'></colgroup>";
							tab.innerHTML += "<tr><th>과정구분</th><th>과정명</th><th>기수</th><th>합격여부</th><th>결제</th></tr>";
							total_apply_num = data[0].length;
							for (var i = 0; i < data[0].length; i++) {
								if (data[0][i].crc_tp == "B1200") { //IT마스터과정
									if (data[0][i].gisu_per == "B1501") {
										if (data[0][i].app_rt_doc == "B1401"
												&& data[0][i].app_rt_itv == "B1701") {//서류, 면접 합격
											tab.innerHTML += "<tr style='background-color:#eee;'><td>장기과정</td><td>"
													+ "<a href='/edu/apply/apply_update_form?gisu_seq="+data[0][i].gisu_seq+"'>"
													+ data[0][i].gisu_crc_nm
													+ "</a>"
													+ "</td><td>"
													+ data[0][i].gisu_num
													+ "</td><td>최종합격</td><td><input type='button' class='confirms_btn_small' value='결제보기' onclick='payscroll("
													+ i
													+ ")'/></td></tr>";
											for (var j = 1; j < data.length; j++) {
												if (data[j].length > 0) {
													for (var k = 0; k < data[j].length; k++) {
														if (data[j][k].GISU_SEQ === data[0][i].gisu_seq) {
															tab.innerHTML += "<tr class='tr"+i+"' style='display:none;'><td>"
																	+ (k + 1)
																	+ "회 분납</td><td>결제기간 : "
																	+ convertDate(data[j][k].PAY_CRC_START)
																	+ " ~ "
																	+ convertDate(data[j][k].PAY_CRC_END)
																	+ "</td><td colspan='2'>비용 : "
																	+ data[j][k].PAY_CRC_AMOUNT
																	+ "원</td><td><b>"
																	+ payCheck(
																			data[j][k],
																			data[0][i])
																	+ "</b></td></tr>";
														}
													}
												} else {
													tab.innerHTML += "<tr class='tr"+i+"' style='display:none;'>"
													   + "<td colspan='5'>결제기간이 아닙니다</td></tr>";
												}
											}
										} else if (data[0][i].app_rt_doc == "B1401"
												&& data[0][i].app_rt_itv == "B1700") { //서류 합격, 면접 대기
											tab.innerHTML += "<tr style='background-color:#eee;'><td>장기과정</td><td>"
													+ "<a href='/edu/apply/apply_update_form?gisu_seq="+data[0][i].gisu_seq+"'>"
													+ data[0][i].gisu_crc_nm
													+ "</a>"
													+ "</td><td>"
													+ data[0][i].gisu_num
													+ "</td><td>서류합격</td><td>대기</td></tr>";
										} else if (data[0][i].app_rt_doc == "B1402"
												|| data[0][i].app_rt_itv == "B1702") { //서류, 면접 둘중 하나라도 불합격인 경우
											tab.innerHTML += "<tr style='background-color:#eee;'><td>장기과정</td><td>"
													+ "<a href='/edu/apply/apply_update_form?gisu_seq="+data[0][i].gisu_seq+"'>"
													+ data[0][i].gisu_crc_nm
													+ "</a>"
													+ "</td><td>"
													+ data[0][i].gisu_num
													+ "</td><td>불합격</td><td>대기</td></tr>";
										} else {
											tab.innerHTML += "<tr style='background-color:#eee;'><td>장기과정</td><td>"
													+ "<a href='/edu/apply/apply_update_form?gisu_seq="+data[0][i].gisu_seq+"'>"
													+ data[0][i].gisu_crc_nm
													+ "</a>"
													+ "</td><td>"
													+ data[0][i].gisu_num
													+ "</td><td>대기</td><td>대기</td></tr>";
										}
									}
								} else {//CUP과정
									if (data[0][i].gisu_per == "B1501") {

										tab.innerHTML += "<tr style='background-color:#eee;'><td>단기과정</td><td>"
												+ "<a href='/edu/apply/apply_update_form?gisu_seq="+data[0][i].gisu_seq+"'>"
												+ data[0][i].gisu_crc_nm
												+ "</a>"
												+ "</td><td>"
												+ data[0][i].gisu_num
												+ "</td><td></td><td><a onclick='payscroll("
												+ i + ")'>결제보기</a></td></tr>";
										for (var j = 1; j < data.length; j++) {
											if (data[j].length > 0) {
												for (var k = 0; k < data[j].length; k++) {
													if (data[j][k].GISU_SEQ === data[0][i].gisu_seq) {
														tab.innerHTML += "<tr class='tr"+i+"' style='display:none;'><td>"
																+ (k + 1)
																+ "회 분납</td><td>결제기간 : "
																+ convertDate(data[j][k].PAY_CRC_START)
																+ " ~ "
																+ convertDate(data[j][k].PAY_CRC_END)
																+ "</td><td colspan='2'>비용 : "
																+ data[j][k].PAY_CRC_AMOUNT
																+ "원</td><td><b>"
																+ payCheck(
																		data[j][k],
																		data[0][i])
																+ "</b></td></tr>";
													}
												}
											}
										}
									}
								}
							}
						}
					},
					error : function(e) {
						console.log(e);
					}
				});
		$("#update").css("display", "none");
		$("#apply").css("display", "block");
		$("#payment").css("display", "none");
		$("#consulting").css("display", "none");
		$("#deletepage").css("display", "none");
	}

	function payscroll(seq) {

		for (var i = 0; i < total_apply_num; i++) {
			if (i == seq) {
				var name = ".tr" + i;
				$(name).each(function(index, element) {
					if ($(element).css("display") == "none") {
						$(element).css("display", "table-row");
					} else {
						$(element).css("display", "none");
					}
				});

			} else {
				var name = ".tr" + i;
				$(name).each(function(index, element) {
					$(element).css("display", "none");
				});
			}
		}
	}

	function payment() {
		$.ajax({
			url : "/edu/user/user_pay_status",
			dataType : "json",
			success : function(data) {
				print_pay_status(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
		$("#update").css("display", "none");
		$("#apply").css("display", "none");
		$("#payment").css("display", "block");
		$("#consulting").css("display", "none");
		$("#deletepage").css("display", "none");
	}

	function payscroll2(seq) {

		for (var i = 0; i < total_apply_num2; i++) {
			if (i == seq) {
				var name = ".tr2" + i;
				$(name).each(function(index, element) {
					if ($(element).css("display") == "none") {
						$(element).css("display", "table-row");
					} else {
						$(element).css("display", "none");
					}
				});

			} else {
				var name = ".tr2" + i;
				$(name).each(function(index, element) {
					$(element).css("display", "none");
				});
			}
		}
	}

	function refundSubmit() {
		if (!confirm("환불요청하시겠습니까?")) {
			return;
		}
		document.getElementById('refundReq').submit();
	}

	function refundSubmit2() {
		if (!confirm("환불요청 내용을 수정하시겠습니까?")) {
			return;
		}
		document.getElementById('refundReq').submit();
	}

	function refundreq(seq) {

		var tab = document.getElementById('paydiv');
		tab.innerHTML = "";
		var string = "<div class='form_box'>";
		$
				.ajax({
					url : "/edu/user/user_refund_status",
					data : {
						"seq" : seq
					},
					dataType : "json",
					success : function(data) {
						if (data.status == '0') {
							string += "<h2><font color='red'>환불이 요청된 결제내역입니다.</font></h2><br>";
							string += "<form id='refundReq' method='post' action='/edu/user/user_refund_req.do'>";
							string += "<div class='line'>환불받을 계좌주 : <input class='ip_2' type='text' id='accName' name='accName' value='"+data.accName+"'/></div>";
							string += "<div class='line'>환불받을 계좌번호 : <input class='ip_2' type='text' id='accNum' name='accNum' value='"+data.accNum+"'/></div>";
							string += "<div class='line'>환불받을 은행 : <input class='ip_2' type='text' id='bank' name='bank' value='"+data.bank+"'/></div>";
							string += "<div class='line'>환불사유  : <br> <textarea rows='10' class='ip_2' type='text' id='reason' name='reason'/>"
									+ data.reason + "</textarea></div>";
							string += "<input type='hidden' id='seq' name='seq' value='"+seq+"'/>";
							string += "</form>";
	                        string += "<div class='line'></div><div class='line line_align_center' style='margin: 0px;'>";
	                        string += "<button class='join_btn ip_4' onclick='refundSubmit2()'>환불정보수정</button>&nbsp;&nbsp;";
	                        string += "<button class='join_btn ip_4' onclick='payment()'>돌아가기</button></div>";
							string += "</div>";
							tab.innerHTML += string;
						} else if (data.status == '1') {
							string += "<h2><font color='blue'>환불이 완료된 결제내역입니다.</font></h2><br>";
							string += "<div class='line'>환불요청일 : <br><input class='ip_2' type='text' id='reqDt' name='reqDt' value='"
									+ new String(data.reqDt).substring(0, 19)
									+ "'/></div>";
							string += "<div class='line'>환불완료일 : <br><input class='ip_2' type='text' id='comDt' name='comDt' value='"
									+ new String(data.comDt).substring(0, 19)
									+ "'/></div>";
							string += "<div class='line'>환불받은 계좌주 : <input class='ip_2' type='text' id='accName' name='accName' value='"+data.accName+"'/></div>";
							string += "<div class='line'>환불받은 계좌번호 : <input class='ip_2' type='text' id='accNum' name='accNum' value='"+data.accNum+"'/></div>";
							string += "<div class='line'>환불받은 은행 : <input class='ip_2' type='text' id='bank' name='bank' value='"+data.bank+"'/></div>";
							string += "<div class='line'>환불사유  : <br> <textarea rows='10' class='ip_2' type='text' id='reason' name='reason'/>"
									+ data.reason + "</textarea></div>";
							string += "<input type='hidden' id='seq' name='seq' value='"+seq+"'/>";
	                        string += "<div class='line'></div><div class='line line_align_center' style='margin: 0px;'>";
	                        string += "<button class='join_btn ip_4' onclick='payment()'>돌아가기</button></div>";
	                        string += "</div>";
							tab.innerHTML += string;
						}

					},
					error : function() {
						string += "<h2>신용카드일 경우, 하단의 환불요청만 누르셔도 됩니다.</h2><br>";
						string += "<form id='refundReq' method='post' action='/edu/user/user_refund_req.do'>";
						string += "<div class='line'>환불받을 계좌주 : <input class='ip_2' type='text' id='accName' name='accName'/></div>";
						string += "<div class='line'>환불받을 계좌번호 : <input class='ip_2' type='text' id='accNum' name='accNum'/></div>";
						string += "<div class='line'>환불받을 은행 : <input class='ip_2' type='text' id='bank' name='bank'/></div>";
						string += "<div class='line'>환불사유  : <br> <textarea rows='10' class='ip_2' type='text' id='reason' name='reason'/></textarea></div>";
						string += "<input type='hidden' id='seq' name='seq' value='"+seq+"'/>";
						string += "</form>";
						string += "<div class='line'></div><div class='line line_align_center' style='margin: 0px;'>";
						string += "<button class='join_btn ip_4' onclick='refundSubmit()'>환불요청</button>&nbsp;&nbsp;";
						string += "<button class='join_btn ip_4' onclick='payment()'>돌아가기</button></div>";
						string += "</div>";
						tab.innerHTML += string;
					}
				});
	}

	function refundcancel(pay_refund_seq) {
		if (confirm("환불요청을 취소하시겠습니까?") == false)
			return;
		$.ajax({
			url : "/edu/user/user_refund_cancel",
			method : "POST",
			data : {
				'pay_refund_seq' : pay_refund_seq
			},
			success : function(data) {
				print_pay_status(data)
			}
		})
	}

	function paycancel(pay_user_seq) {
		if (confirm("결제를 취소하시겠습니까?") == false)
			return;
		$.ajax({
			url : "/edu/user/user_pay_cancel",
			method : "POST",
			data : {
				'pay_user_seq' : pay_user_seq
			},
			success : function(data) {
				print_pay_status(data)
			}
		})
	}
	function print_pay_status(data) {
		if (data.length > 0) {
			var tdiv = document.getElementById('paydiv');
			tdiv.innerHTML = "<br><table id='paytab' style='width: 90%;'></table>";
			var tab = document.getElementById('paytab');
			total_apply_num2 = data.length;
			tab.innerHTML = "<colgroup><col width='8%'><col width='30%'><col width='10%'><col width='10%'><col width='10%'><col width='20%'></colgroup>";
			tab.innerHTML += "<tr><th>결제구분</th><th>과정명</th><th>분납차수</th><th>결제상태</th><th>환불상태</th><th>비고</th></tr>";
			for (var i = 0; i < data.length; i++) {
				var payType = data[i].PAY_USER_METHOD === "VBank" ? "무통장입금"
						: "신용카드";
				var payStatus = data[i].PAY_USER_STATUS;
				var refundStatus = data[i].PAY_REFUND_STATUS;
				if (payStatus === "1" && typeof refundStatus === 'undefined') { //결제완료
					tab.innerHTML += "<tr style='background-color:#eee;'><td>"
							+ payType
							+ "</td><td style='width:40%;'>"
							+ data[i].PAY_PRODUCT_NAME
							+ "</td><td>"
							+ (data[i].PAY_CRC_PAYORDER + 1)
							+ "회차</td><td><font color='blue'>결제완료</font></td><td></td><td>"
							+ "<input type='button' class='confirms_btn_small' value='환불요청' onclick='refundreq("
							+ data[i].PAY_USER_SEQ + ")'/></td></tr>";
				} else if (typeof payStatus === 'undefined'
						&& refundStatus === "0") { //관리자에 의한 환불요청
					tab.innerHTML += "<tr style='background-color:#eee;'><td>"
							+ payType
							+ "</td><td style='width:40%;'>"
							+ data[i].PAY_PRODUCT_NAME
							+ "</td><td>"
							+ (data[i].PAY_CRC_PAYORDER + 1)
							+ "회차</td><td><font color='blue'>결제완료</font></td><td><a onclick='refundreq("
							+ data[i].PAY_USER_SEQ
							+ ")'>환불대기</a></td></td><td></tr>";
				} else if (payStatus === '1' && refundStatus === "0") { //사용자에 의한 환불요청
					tab.innerHTML += "<tr style='background-color:#eee;'><td>"
							+ payType
							+ "</td><td style='width:40%;'>"
							+ data[i].PAY_PRODUCT_NAME
							+ "</td><td>"
							+ (data[i].PAY_CRC_PAYORDER + 1)
							+ "회차</td><td><font color='blue'>결제완료</font></td><td><a onclick='refundreq("
							+ data[i].PAY_USER_SEQ
							+ ")'>환불대기</a></td><td><a onclick='refundcancel("
							+ data[i].PAY_REFUND_SEQ
							+ ")'>환불요청취소</a></td></tr>";
				} else if (typeof payStatus === 'undefined'
						&& refundStatus === "1") { //환불완료
					tab.innerHTML += "<tr style='background-color:#eee;'><td>"
							+ payType
							+ "</td><td style='width:40%;'>"
							+ data[i].PAY_PRODUCT_NAME
							+ "</td><td>"
							+ (data[i].PAY_CRC_PAYORDER + 1)
							+ "회차</td><td><font color='blue'>결제완료</font></td><td><a onclick='refundreq("
							+ data[i].PAY_USER_SEQ
							+ ")'><font color='blue'>환불완료</font></a></td><td></td></tr>";
				} else if (payStatus === "0"
						&& typeof refundStatus === 'undefined') { //미결제(무통장입금)
					tab.innerHTML += "<tr style='background-color:#eee;'><td>"
							+ payType
							+ "</td><td style='width:40%;'>"
							+ data[i].PAY_PRODUCT_NAME
							+ "</td><td>"
							+ (data[i].PAY_CRC_PAYORDER + 1)
							+ "회차</td><td>미결제</td><td></td><td><a onclick='payscroll2("
							+ i + ")'>계좌보기</a></td></tr>";
					tab.innerHTML += "<tr class='tr2"+i+"' style='display:none;'><td></td><td colspan='4'>입금계좌 : <font style='font-weight:bolder;font-size:110%;'>"
							+ data[i].PAY_ACCNUM
							+ "</font>&nbsp;&nbsp;&nbsp;&nbsp;&#47;&nbsp;&nbsp;&nbsp;&nbsp;입금은행 : <font style='font-weight:bolder;font-size:110%;'>"
							+ data[i].PAY_BANKNAME
							+ "</font>&nbsp;&nbsp;&nbsp;&nbsp;&#47;&nbsp;&nbsp;&nbsp;&nbsp;비용 : <font style='font-weight:bolder;font-size:110%;'>"
							+ data[i].PAY_CRC_AMOUNT
							+ "</font>원</td><td><a onclick='paycancel("
							+ data[i].PAY_USER_SEQ + ")'>결제취소</a></td></tr>";
				} else {
					//그 외의 경우 
				}
			}
		}
	}

	function consulting() {
		$.ajax({            
			url:"/edu/user/user_consulting_list",
			dataType:"json",                
			success:function(data){
			print_consulting_list(data);
			}
		});
		
		$("#update").css("display", "none");
		$("#apply").css("display", "none");
		$("#payment").css("display", "none");
		$("#consulting").css("display", "block");
		$("#deletepage").css("display", "none");
	}

	function print_consulting_list(data) {
		if (data.length > 0) {
			var tdiv = document.getElementById('consultingdiv');
			tdiv.innerHTML = "<br><table id='consultingtab' style='width: 90%;'></table>";
			var tab = document.getElementById('consultingtab');
			total_apply_num2 = data.length;
			tab.innerHTML = "<tr><th width='5%''>번호</th><th width='10%''>답변상태</th><th width='40%''>문의제목</th><th width='10%'>비밀여부</th><th width='10%''>작성자</th><th width='25%'>작성일자</th></tr>";
			for (var i = 0; i < data.length; i++) {
				//if (data[i].consulting_check === 0) var consulting_check="삭제글";
				if (data[i].consulting_check === 1) var consulting_check="답변대기";
				if (data[i].consulting_check === 2) var consulting_check="답변완료";
				if (data[i].consulting_open === 0) var consulting_open="공개";
				if (data[i].consulting_open === 1) var consulting_open="비공개";
				if (data[i].consulting_seq === 0 && typeof data[i].consulting_seq === 'undefined') { //상담내역 없음
					tab.innerHTML += "<tr><td colspan='6'>온라인상담 신청내역이 없습니다.</td></tr>";
				} else {
					tab.innerHTML += "<tr><td>"
						+ data[i].consulting_seq
						+ "</td><td>"
						+ consulting_check
						+ "</td><td>"
						+ "<a href='javascript:goOnline_consulting_Detail("
						+ data[i].consulting_seq
						+ ")'>"
						+ data[i].consulting_title
						+ "</a></td><td>"
						+ consulting_open
						+ "</td><td>"
						+ data[i].consulting_ins_id
						+ "</td><td>"
						+ data[i].consulting_udt_dt
						+ "</td><td></tr>"; 
				}
			}
		}
	}
	
	function goOnline_consulting_Detail(consulting_seq){
		location.href="/edu/consulting/online_consulting_detail.do?consulting_seq="+consulting_seq;
	}

	function accountDelete() {
		$("#update").css("display", "none");
		$("#apply").css("display", "none");
		$("#payment").css("display", "none");
		$("#consulting").css("display", "none");
		$("#deletepage").css("display", "block");
	}
</script>
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
</style>
</head>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<form id="userPayInfoForm" method="post" action="/edu/user/user_pay_ini.do">
		<input type="hidden" valaue="" name="price" id="price">
		<input type="hidden" valaue="" name="goodname" id="goodname">
		<input type="hidden" valaue="" name="pay_seq" id="pay_seq">
		<input type="hidden" valaue="" name="pay_from" id="pay_from">
		<input type="hidden" valaue="" name="pay_to" id="pay_to">
	</form>
	<!--  join_section -->
	<section class="join_section">
		<article>
			<ul class="join_system">
				<h3 id="maintitle">${user.user_id }님의마이페이지</h3>
			</ul>
			<div class="master_bottom_menu" style="">
				<ul>
					<li class="choice_menu mbm1" style="width: 25%;"><a href="#fe_01" onclick="updateMember()">회원정보 수정</a></li>
					<li class="mbm2" style="width: 25%;"><a href="#fe_02" onclick="apply()">수강신청</a></li>
					<li class="mbm3" style="width: 25%;"><a href="#fe_03" onclick="payment()">결제내역</a></li>
					<li class="mbm4" style="width: 25%;"><a href="#fe_04" onclick="consulting()">상담내역</a></li>
				</ul>
			</div>
			<div id="update">
				<form action="/edu/user/user_update" method="POST" onsubmit="return checkOnSubmit();">
					<div class="form_box">
						<div class="line">
							<input class="ip_2" type="text" id="user_id" name="user_id" value="${user.user_id }" readonly="readonly" />
						</div>
						<div class="line line_s">
							<input class="ip_2" type="password" id="user_pw" name="user_pw" placeholder="비밀번호(8~12자리)" />
						</div>
						<div class="line">
							<input class="ip_2" type="password" id="user_pw_check" placeholder="비밀번호 확인(8~12자리)" />
						</div>
						<div class="line">
							<input class="ip_2" type="text" id="user_nm" name="user_nm" maxlength="4" placeholder="이름" value="${user.user_nm }" />
						</div>
						<div class="line">
							<input class="ip_2" type="tel" id="user_phone" name="user_phone" maxlength="14" placeholder="휴대폰번호 ( - 제외 )" value="${user.user_phone }" />
						</div>
						<div class="line">
							<input class="ip_2" type="email" id="user_email" name="user_email" placeholder="이메일" value="${user.user_email }" />
						</div>
						<div class="line">
							<c:set var="birth" value="${user.user_birth }" />
							<input class="ip_3" type="text" id="birth_year" name="birth_year" value="${fn:substring(birth,0,4) }" maxlength="4" placeholder="YYYY">
							<input class="ip_3" type="text" id="birth_month" name="birth_month" value="${fn:substring(birth,5,7) }" maxlength="2" placeholder="MM">
							<input class="ip_3" type="text" id="birth_date" name="birth_date" value="${fn:substring(birth,8,10) }" maxlength="2" placeholder="DD">
							<input type="hidden" id="user_birth" name="user_birth" maxlength="8">
						</div>
						<div class="line line_align_center">
							<a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="user_sex_m" value="A0000">
								<code value="A0000"></code>
							</a>
							<a class="btn btn_fifty_width btn_gray btn_fore_black radio" id="user_sex_f" value="A0001">
								<code value="A0001"></code>
							</a>
							<input type="hidden" id="user_sex" name="user_sex" value="${user.user_sex }">
						</div>
						<div class="line"></div>
						<div class="line line_align_center" style="margin: 0px;">
							<input class="join_btn ip_4" type="submit" value="수정하기">
						</div>
						<br>
						<!-- 						<div style="text-align: right;"> -->
						<!-- 							<input class="join_btn ip_4" type="button" onclick="accountDelete()" value="회원탈퇴"> -->
						<!-- 						</div> -->
					</div>
					<!-- form_box -->
				</form>
				<div style="float: right; margin-top: 5px;">
					<a onclick="accountDelete()">회원탈퇴</a>
				</div>
			</div>
			<div id="apply">
				<div class="notice_wrap">
					<br>
					<table id="tab" style='width: 90%;'>
						<colgroup>
							<col width='15%'>
							<col width='45%'>
							<col width='10%'>
							<col width='10%'>
							<col width='20%'>
						</colgroup>
						<tr>
							<th>과정구분</th>
							<th>과정명</th>
							<th>기수</th>
							<th>합격여부</th>
							<th>결제</th>
						</tr>
					</table>
					<br>
				</div>
			</div>
			<div id="payment">
				<div class="notice_wrap" id="paydiv">
					<br>
					<table id="paytab" style='width: 90%;'>
						<colgroup>
							<col width='10%'>
							<col width='40%'>
							<col width='10%'>
							<col width='10%'>
							<col width='10%'>
							<col width='20%'>
						</colgroup>
						<tr>
							<th>결제구분</th>
							<th>과정명</th>
							<th>분납차수</th>
							<th>결제상태</th>
							<th>환불상태</th>
							<th>비고</th>
						</tr>
					</table>
					<br>
				</div>
			</div>
			<div id="consulting">
				<div class="notice_wrap" id="consultingdiv">
					<br>
					<table id="consultingtab" style='width: 90%;'>
						<colgroup>
							<col width='10%'>
							<col width='50%'>
							<col width='20%'>
							<col width='20%'>
						</colgroup>
						<tr>
							<th>상담구분</th>
							<th>상담제목</th>
							<th>작성일자</th>
							<th>답변일자</th>
						</tr>
					</table>
					<br>
				</div>
			</div>
			<div id="deletepage">
				<form action="<c:url value='/edu/user/user_delete' />" method="POST" onsubmit="return passwordCheckOnSubmit();">
					<div class="form_box">
						<div class="line">
							<p>회원 탈퇴 시 개인정보를 포함한 모든 회원정보가 삭제되며 계정에 대한 복구가 불가능합니다.</p>
						</div>
						<div class="line">
							<input type="hidden" name="user_id" value="${user.user_id }" />
						</div>
						<div class="line line_s">
							<input class="ip_2" type="password" id="user_pw_delete" name="user_pw" placeholder="비밀번호 입력" />
						</div>
						<div class="line"></div>
						<div class="line line_align_center">
							<!-- TODO: 확인창 추가예정 -->
							<input class="join_btn ip_4" type="submit" value="회원탈퇴">
						</div>
					</div>
					<!-- form_box -->
				</form>
			</div>
		</article>
	</section>
	<!-- footer -->
	<%@include file="../footer.jsp"%>
</body>
</html>