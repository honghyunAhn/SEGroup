<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<style type="text/css">
.alert label {cursor: default;}
</style>
<script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// 선택UI 클릭 이벤트
	$('.select-option li').click(function() {
		var value = $(this).data('value');
		var text = $.trim($(this).text());

		var $p = $(this).closest('.select-option');
		var target_class = $p.data('target') || '';
		if (target_class !== '') {
			$('.'+target_class).each(function(idx, obj){
				if($(obj).prop('tagName') == 'INPUT') {
					$(obj).val(value);
				} else {
					$(obj).text(text);
				}
			});
		}

		$p.addClass('off');
	});

	// 동일 이메일 사용
	/* $('#chkSameEmail').click(function() {
		setEmailWithId();
	}); */

	// 아이디 변경시 동일 이메일 사용 체크에 따라 이메일 동기화
	/* $('#id1, #id2').on('blur', function() {
		if ($('#chkSameEmail').prop('checked')) {
			setEmailWithId();
		}
	}); */

	// 우편 번호 조회 버튼 클릭 시
	$("a.search_addr").unbind("click").bind("click", function() {
		var idx = $("a.search_addr").index($(this));
		daumPostcode(idx);
	});

	$('#btnCancel').click(function() {
		location.href = '<c:url value="/member/join1"/>';
	});

	// 다음버튼
	$('#btnNext').click(function() {
		var f = document.getElementById("saveForm");
		//var id = $('#id1').val() + (isEmpty($('#id1').val()) || isEmpty($('#id2').val())?"":"@") + $('#id2').val();
		var phone = concatArray([$('#phone1').val(),$('#phone2').val(),$('#phone3').val()],'-');
		var tel = concatArray([$('#tel1').val(),$('#tel2').val(),$('#tel3').val()],'-');
		var email = $('#email1').val() + (isEmpty($('#email1').val()) || isEmpty($('#email2').val())?"":"@") + $('#email2').val();
		//$(f).find("input[name='id']").val(id);
		$(f).find("input[name='phone']").val(phone);
		$(f).find("input[name='tel']").val(tel);
		$(f).find("input[name='email']").val(email);
		if (!validateForm()) {
			return;
		}

		// 교(직)원의 경우 추가 입력 화면 이동
		/* if ($('#grade').val() == '1') {
			f.action = '<c:url value="/member/join3"/>';
			f.submit();
		} else { */
			$.ajax({
	  			url : '<c:url value="/member/ajaxDoJoin"/>',
	  			method : 'POST',
	  			data : $(f).serialize(),
	  			success : function(result) {
	  				if (isSuccessAjaxResponse(result)) {
		  				alert(result.ID + '아이디로 가입이 완료되었습니다.\n로그인 후 이용하여 주십시오. 감사합니다.');
		  				location.href = '<c:url value="/"/>';
					} else {
						alertAjaxFailMessage(result);
					}
	  			},
	  			error: function(e) {
	  				alert('회원가입에 실패하였습니다.');
	  			}
	  		});
		//}
	});

	// validation rule
	$.validator.addMethod("checkId",function(value, element) {
		return this.optional(element) || isValidId(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkName",function(value, element) {
		return this.optional(element) || isValidName(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkDuplId",function(value, element) {
		return this.optional(element) || checkDuplId(value);
	}, "이미 사용중인 아이디입니다. 다른 아이디를 입력해 주시기 바랍니다.");
	$.validator.addMethod("checkPasswd",function(value, element) {
		return this.optional(element) || isValidPassword(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkTel",function(value, element) {
		return this.optional(element) || isValidTel(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkBirthday",function(value, element) {
		return this.optional(element) || isValidBirthday(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkExistId",function(value, element) {
		return this.optional(element) || checkExistId(value);
	}, "유효하지 않은 입력입니다.");
	$("#saveForm").validate({
		ignore: ".ignore",
		errorPlacement: function(error, element) {  // 입력 에러메시지 출력 위치 설정
			var holder = $(element).parent().find(".alert" );
			if (holder.length < 1) {
				holder = $("<p>").addClass('alert');
				var $p = $(element).closest('dd');
				if ($p.length > 0) {
					$p.append(holder);
				} else {
					$p = $(element).closest('.valdation_message_container');
					$p.append(holder);
				}
			}
			if(holder.length > 0) {
				$(holder).append(error);
			}
		},
		rules: {	// 입력체크 룰
			id: {"required":true, "checkId":true, "checkDuplId":true},
			name: {"required":true, "checkName":true},
			pw: {"required":true, "checkPasswd":true},
			pw_confirm: {"required":true, "equalTo":"#pw"},
			phone: {"required":true, "checkTel":true},
			tel: {"checkTel":true},
			email: {"required":true, "email":true},
			post_code: {"required":true},
			birth_day: {"checkBirthday":true},
			gender: {"required":true},
			addr2: {"required":true},
			recomm_id: {"email":true, "checkExistId":true},
		},
		messages: {
			pw_confirm: {
				"equalTo": "입력하신 비밀번호가 일치하지 않습니다. 다시 입력해 주세요"
			},
			post_code: "우편 번호를 검색하여 선택하여 주십시오.",
			addr2: "상세주소는 필수 항목입니다.",
			recomm_id: {
				"checkExistId": "존재하지 않는 아이디 입니다."
			}
		}
	});

	// 입력값 초기화
	if($('#phone1').val() != '') {
		selectOption('select-phone', $('#phone1').val());
	}

	/* if($('#tel1').val() != '') {
		selectOption('select-tel', $('#tel1').val());
	} */
});

// 선택 설정
function selectOption(selectOptionId,val) {
	var found = false;
	$('#'+selectOptionId).find('li').each(function(idx, obj) {
		found = $(obj).data('value') == val;
		if(found) {
			$(obj).trigger('click');
			return false;
		}
	});

	if(!found) {
		alert('선택값을 찾을 수 없습니다.');
	}
}

// 아이디와 동일하게 이메일 설정
function setEmailWithId() {
	$('.select-option[data-target="target_email2"]').first().trigger('click');
	$('#email1').val($('#id1').val());
	$('#email2').val($('#id2').val());
}


// 입력값 체크
function validateForm() {
	return $('#saveForm').valid();
}

// 아이디 중복체크
function checkDuplId(id) {
	var valid = false;
	$.ajax({
		type: "POST",
		url: "<c:url value='/member/ajaxCheckDuplId' />",
		data: {"id": id},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = result.DUPL_YN == 'N';
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
}

// 아이디 존재 여부 체크
function checkExistId(id) {
	var valid = false;
	$.ajax({
		type: "POST",
		url: "<c:url value='/member/ajaxCheckExistId' />",
		data: {"id": id},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = (result.EXIST_YN == 'Y');
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
}
</script>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">회원 서비스</a>
			<a class="nth-last" href="#">회원 가입</a>
		</p>
		<h2 class="sub-title">회원 가입 </h2>
	</div>
	<div class="sub-body">
		<form id="saveForm" name="saveForm" method="post">
		<input type="hidden" name="iden_di" value="${identForm.iden_di }"/>
			<div class="group">
				<h3 class="nth-1st">개인 정보 입력</h3>
				<dl>
					<dt>아이디<i>*</i></dt>
					<dd>
						<input class="nth-1st" type="text" id="id" name="id" maxlength="30" value="${memberForm.id }"/>
						<span class="explan">※ 영문자로 시작하는 6~20자 영문자 또는 숫자</span>
					</dd>
					<dt>성명<i>*</i></dt>
					<dd><input class="nth-1st" type="text" placeholder="성명" id="name" name="name" maxlength="30" value="${memberForm.name }" readonly="readonly" style="background-color: #ccc"><span class="explan">※ 한글 2~15자, 영문 4~30자</span></dd>
					<dt>비밀번호<i>*</i></dt>
					<dd><input class="nth-1st" type="password" placeholder="비밀번호" id="pw" name="pw" maxlength="30"><span class="explan">※ 영문, 숫자, 특수 기호(!, @, # 등)을 모두 사용하여 최소 8자 이상</span></dd>
					<dt>비밀번호 확인<i>*</i></dt>
					<dd>
						<input class="nth-1st" type="password" placeholder="비밀번호 확인" id="pw_confirm" name="pw_confirm" maxlength="30"><span class="explan">※ 영문, 숫자, 특수 기호(!, @, # 등)을 모두 사용하여 최소 8자 이상</span>
					</dd>
					<dt>휴대 전화<i>*</i></dt>
					<dd>
						<div class="body-select w5em">
							<a class="btn-toggle" href="#select-phone"><span class="target_phone1">선택</span></a>
							<ul class="select-option off" id="select-phone" data-target="target_phone1">
								<li data-value="선택">선택</li>
								<c:forEach var="item" items="${phone1List}">
								<li data-value="${item.NAME}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						-
						<input type="text" class="w6em" maxlength="4" id="phone2" name="phone2" value="${memberForm.phone2 }">
						-
						<input type="text" class="w6em" maxlength="4" id="phone3" name="phone3" value="${memberForm.phone3 }">

						<input type="hidden" id="phone1" name="phone1" class="target_phone1" value="${memberForm.phone1 }"/>
						<input type="hidden" id="phone" name="phone" value="${memberForm.phone }"/>
					</dd>
					<%-- <dt>자택 전화</dt>
					<dd>
						<div class="body-select w5em">
							<a class="btn-toggle" href="#select-tel"><span class="target_tel1">선택</span></a>
							<ul class="select-option off" id="select-tel" data-target="target_tel1">
								<li data-value="선택">선택</li>
								<c:forEach var="item" items="${tel1List}">
								<li data-value="${item.NAME}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						-
						<input type="text" class="w6em" maxlength="4" id="tel2" name="tel2" value="${memberForm.tel2 }">
						-
						<input type="text" class="w6em" maxlength="4" id="tel3" name="tel3" value="${memberForm.tel3 }">

						<input type="hidden" id="tel1" name="tel1" class="target_tel1" value="${memberForm.tel1 }"/>
						<input type="hidden" id="tel" name="tel" value="${memberForm.tel }"/>
					</dd> --%>
					<dt>전자 우편<i>*</i></dt>
					<dd>
						<input class="nth-1st" type="text" id="email1" name="email1" maxlength="20" value="${memberForm.email1 }">@<input type="text" id="email2" name="email2" class="target_email2" maxlength="30" value="${memberForm.email2 }">
						<div class="body-select w8em">
							<a class="btn-toggle" href="#select-mail"><span class="target_email2">직접 입력</span></a>
							<ul class="select-option off" id="select-mail" data-target="target_email2">
								<li data-value="">직접 입력</li>
								<c:forEach var="item" items="${emailList}">
								<li data-value="${item.NAME}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						<!-- <label><input type="checkbox" id="chkSameEmail"> 아이디와 동일한 전자 우편 사용</label> -->
						<input type="hidden" id="email" name="email" value="${memberForm.email }"/>
					</dd>
					<dt>생년월일</dt>
					<dd>
						<input class="nth-1st" type="text" id="birth_day" maxlength="10" name="birth_day" value="${memberForm.birth_day }" <c:if test="${not empty memberForm.birth_day }">readonly="readonly" style="background-color: #ccc"</c:if>>
						<span class="explan">※ 1990-01-01 형식으로 입력</span>
					</dd>
					<dt>성별</dt>
					<dd>
						<label><input type="radio" name="gender" value="M" <c:if test="${memberForm.gender == 'M'}">checked="checked"</c:if> <c:if test="${not empty memberForm.gender and memberForm.gender != 'M'}">disabled="disabled"</c:if>> 남자</label>
						<label><input type="radio" name="gender" value="F" <c:if test="${memberForm.gender == 'F'}">checked="checked"</c:if> <c:if test="${not empty memberForm.gender and memberForm.gender != 'F'}">disabled="disabled"</c:if>> 여자</label>
						<p class=".alert" style="display:none"></p>
					</dd>
					<dt>자택 주소<i>*</i></dt>
					<dd class="address">
						<input type="text" class="width20 nth-1st zipcode" id="post_code" name="post_code" readonly="readonly"  value="${memberForm.post_code }"><a class="btn primary search_addr" href="#none">우편 번호 검색</a><br>
						<input type="text" class="width95 nth-1st addr" id="addr1" name="addr1" value="${memberForm.addr1 }"><br>
						<input type="text" class="width95 nth-1st etc_addr" id="addr2" name="addr2" value="${memberForm.addr2 }">
					</dd>
					<dt>회사명/학교명<i>*</i></dt>
					<dd><input class="width95 nth-1st" type="text" id="school_name" name="school_name" value="${memberForm.schoolForm.school_name }" maxlength="30"></dd>
				</dl>
			</div>
			<!--//.group - 회원 정보 입력 -->
			<%-- <c:if test="${identForm.grade == '2' }"> --%>
			<%--
			<div class="section">
				<dl>
					<dt>추천 아이디</dt>
					<dd><input class="nth-1st" type="text" id="recomm_id" name="recomm_id" value="${memberForm.recomm_id }"><span>아이디를 입력하시면 200포인트가 지급됩니다.</span></dd>
				</dl>
			</div><!--//.group - 학교 및 기관정보 입력 -->
			 --%>
			<%-- </c:if> --%>

		</form>
		<div class="list-bottom alignR">
			<a href="#" class="btn danger" id="btnCancel">이전으로(취소)</a>
			<a href="#" class="btn primary" id="btnNext">회원가입</a>
		</div>

	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->

