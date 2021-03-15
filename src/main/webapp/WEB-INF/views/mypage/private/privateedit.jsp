<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="now" class="java.util.Date" />

<script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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

	// 회원 구분 변경
	/* $("#grade").change(function() {
		if($(this).val() == '1') $('#school_info_v').show();
		else $('#school_info_v').hide();
	}); */

	// 우편 번호 조회 버튼 클릭 시
	$("a.search_addr").unbind("click").bind("click", function() {
		var idx = $("a.search_addr").index($(this));
		daumPostcode(idx);
	});

	// 학교 기관 찾기 팝업
	/* $('#btnSearchSchool').click(function() {
		popSearchSchool();
	}); */
	/* $('#schoolSearchKeyword').keydown(function(event) {
	    if (event.keyCode === 13) {
	    	popSearchSchool();
	    }
	}); */


	// NEIS번호 처리
	/* var neis_num = $('#neis_num').val();
	if(!isEmpty(neis_num)) {
		if(neis_num.length != 10) {
			$('#neis_num').val('');
		} else {
			$('#neis_local').val(neis_num.substr(0,3));
			$("input.neis_piece").each(function(i, obj){
				$(obj).val(neis_num.charAt(i+3));
			 });
		}
	}
	$("input.neis_piece").on({
	 click:function(){
		 $(this).val("");
	 },keyup:function(){
		 $(this).next().focus();
		 setNeisNum();
	 }
	});
	$("select.neis_piece").change(function() {
		if ($(this).val() == 'Z99') {
			$("input.neis_piece").each(function(i, obj){
				$(obj).val('9');
		 	});
		}
		setNeisNum();
	});

	$("#neis_numChk").click(function(){
		 if($(this).is(":checked")){
			 $("#neis_num").val("");
			 $(".neis_piece").attr("readonly", true).css("background-color","#ccc").val("");
		 }else{
			 $(".neis_piece").attr("readonly", false).css("background-color","");
		 }
	}); */

	// neis 변경시 중복체크여부 N
	/* $('.neis_piece').change(function() {
		$('#checkDuplNeisYn').val('N');
	});

	$('#btnCheckDuplNeis').click(function() {	// NEIS번호 중복체크
		if($("#neis_numChk").is(":checked")) return;

		if(isEmpty($('#neis_local').val())) {
			alert('지역구분을 먼저 선택하여 주십시오.');
			$('#neis_local').focus();
			return;
		};

		var neis_num = $('#neis_local').val();
		$('input.neis_piece').each(function(idx, obj) {
			neis_num += $(obj).val().toUpperCase();
		});

		if (!isValidNeis(neis_num)) {
			alert('유효하지 않은 NEIS번호 입니다.');
			return;
		}

		$('#neis_num').val(neis_num);

		if(!checkDuplNeis(neis_num)) {
			$('#checkDuplNeisYn').val('N');
			alert('이미 등록된 NEIS번호 입니다.')
		} else {
			$('#checkDuplNeisYn').val('Y');
			alert('사용 가능한 NEIS번호 입니다.');
		}

		$('#checkDuplNeisYn').valid();	// validate one field
	}); */

	$('#saveBtn').click(function() {
		var f = document.getElementById("saveForm");
		var phone = concatArray([$('#phone1').val(),$('#phone2').val(),$('#phone3').val()],'-');
		//var tel = concatArray([$('#tel1').val(),$('#tel2').val(),$('#tel3').val()],'-');
		var email = $('#email1').val() + (isEmpty($('#email1').val()) || isEmpty($('#email2').val())?"":"@") + $('#email2').val();
		$(f).find("input[name='phone']").val(phone);
		//$(f).find("input[name='tel']").val(tel);
		$(f).find("input[name='email']").val(email);

		/* var neis_num = $('#neis_local').val();
		$('input.neis_piece').each(function(idx, obj) {
			neis_num += $(obj).val().toUpperCase();
		});
		$(f).find("input[name='neis_num']").val(neis_num); */

		if (!validateForm()) {
			alert('입력사항을 확인하여 주십시오.');
			return;
		}

		if (!confirm('저장하시겠습니까?')) return;

		f.action = '<c:url value="/mypage/private/doSave"/>';
		f.submit();
	});

	// validation rule
	/* $.validator.addMethod("checkNeis",function(value, element) {
		return this.optional(element) || isValidNeis(value);
	}, "유효하지 않은 입력입니다."); */
	/* $.validator.addMethod("checkDuplNeis",function(value, element) {
		return this.optional(element) || $('#neis_num').val() == '' || $('#checkDuplNeisYn').val() === 'Y';
	}, "중복체크를 하여 주십시오."); */
	$.validator.addMethod("checkPasswd",function(value, element) {
		return this.optional(element) || isValidPassword(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkTel",function(value, element) {
		return this.optional(element) || isValidTel(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkBirthday",function(value, element) {
		return this.optional(element) || isValidBirthday(value);
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
			id: {"required":true, "email":true, "checkDuplId":true},
			//neis_num: {"checkNeis":true},
			//checkDuplNeisYn: {"checkDuplNeis":true},
			name: {"required":true, "checkName":true},
			pw: {"checkPasswd":true},
			pw_confirm: {"equalTo":"#pw"},
			phone: {"required":true, "checkTel":true},
			//tel: {"checkTel":true},
			email: {"required":true, "email":true},
			post_code: {"required":true},
			birth_day: {"checkBirthday":true},
			gender: {"required":true},
			addr2: {"required":true},
			//recomm_id: {"email":true, "checkExistId":true},
		},
		messages: {
			pw_confirm: {
				"equalTo": "입력하신 비밀번호가 일치하지 않습니다. 다시 입력해 주세요"
			}
			,post_code: "우편 번호를 검색하여 선택하여 주십시오."
			,addr2: "상세주소는 필수 항목입니다."
			/* ,recomm_id: {
				"checkExistId": "존재하지 않는 아이디 입니다."
			} */
		}
	});

	// 입력값 초기화
	if($('#phone1').val() != '') {
		selectOption('select-phone', $('#phone1').val());
	}
	/* if($('#tel1').val() != '') {
		selectOption('select-tel', $('#tel1').val());
	} */
	/* if($('#region_code').val() != '') {
		selectOption('select-region', $('#region_code').val());
	} */
	/* if($('#s_type').val() != '') {
		selectOption('select-stype', $('#s_type').val());
	} */
	/* if($('#position').val() != '') {
		selectOption('select-position', $('#position').val());
	} */
	/* if($('#app_year').val() != '') {
		selectOption('select-appyear', $('#app_year').val());
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
/* function setEmailWithId() {
	$('.select-option[data-target="target_email2"]').first().trigger('click');
	$('#email1').val($('#id1').val());
	$('#email2').val($('#id2').val());
} */

/* function setNeisNum() {
	var neis_num = $('#neis_local').val();
	 $("#neis_num").val("");
	 $("input.neis_piece").each(function(idx,obj){
		 neis_num += $(obj).val();
	 });

	 $("#neis_num").val(neis_num);
}
 */
// 입력값 체크
function validateForm() {
	return $('#saveForm').valid();
}

// NEIS 중복체크
/* function checkDuplNeis(neis_num) {
	var valid = false;
	$.ajax({
		type: "post",
		url: "<c:url value='/member/ajaxUserCheckDuplNeis' />",
		data: {"neis_num": neis_num},
		async: false,
		success: function(result) {
			if (isSuccessAjaxResponse(result)) {
				valid = (result.DUPL_YN != 'Y');
			} else {
				alertAjaxFailMessage(result);
			}
		},
		error: function(e) {
			alert(e.responseText);
		}
	});
	return valid;
} */

// 학교(기관) 찾기 팝업
/* function popSearchSchool() {
	var layerId  = 'layerSearchSchool';
	if($('#'+layerId).length < 1) {
		$.ajax({
			type: "POST",
			url: "<c:url value='/common/layer/schoolSearch' />",
			dataType: "text",
			success: function(txt) {
				$(document.body).append(txt);
				popupOpen(layerId);
			}
		});
	} else {
		popupOpen(layerId);
	}
} */

// 학교(기관) 선택
/* function onSearchSchool(data) {
	$('#school_name').val(data.name);
	$('#school_post_code').val(data.post_code);
	$('#school_addr1').val(data.addr1);
	$('#school_addr2').val(data.addr2);
	//selectOption('select-region', data.region_code);
	//$('#jurisdiction').val(data.jurisdiction);
	//selectOption('select-stype', data.s_type);
} */
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a href="#">개인 정보</a>
			<a class="nth-last" href="#">개인 정보 수정</a>
		</p>
		<h2 class="sub-title">개인 정보 수정</h2>
	</div>
	<div class="sub-body">
		<form id="saveForm" name="saveForm" method="post">
			<div class="group">
				<h3 class="nth-1st">개인 정보 수정</h3>
				<dl>
					<dt>아이디</dt>
					<dd>${myinfo.ID }</dd>
					<%-- <dt class="border">회원 구분</dt>
					<dd class="halfW">
						<select id="grade" name="grade" style="background: none">
							<option value="1" <c:if test="${myinfo.GRADE == 1 }">selected="selected"</c:if>>교원 회원</option>
							<option value="2" <c:if test="${myinfo.GRADE == 2 }">selected="selected"</c:if>>일반 회원</option>
						</select>
					</dd> --%>
					<dt>비밀번호</dt>
					<dd>
						<input class="nth-1st" type="password" placeholder="비밀번호" id="pw" name="pw" maxlength="30"><span class="explan">※ 영문, 숫자, 특수 기호(!, @, # 등)을 모두 사용하여 최소 8자 이상</span>
					</dd>
					<dt>비밀번호 확인</dt>
					<dd>
						<input class="nth-1st" type="password" placeholder="비밀번호 확인" id="pw_confirm" name="pw_confirm" maxlength="30"><span class="explan">※ 영문, 숫자, 특수 기호(!, @, # 등)을 모두 사용하여 최소 8자 이상</span>
					</dd>
					<dt>보유 포인트</dt>
					<dd><span><strong><fmt:formatNumber value="${myinfo.POINT }"/> </strong>포인트</span></dd>
					<%-- <dt>NEIS 개인 번호</dt>
					<dd class="height h120 NEIS">
						<select id="neis_local" class="neis_piece" style="background: none">
						<option value="">지역 선택</option>
						<c:forEach var="item" items="${localEduofficeList}">
						<option value="${item.CODE}">${item.NAME}(${item.CODE })</option>
						</c:forEach>
						</select>
						<c:forEach begin="4" end="10" varStatus="varStatus">
						<input type="text" class="neis_piece" maxlength="1">
						</c:forEach>
						<input type="hidden" id="neis_num" name="neis_num" value="${myinfo.NEIS_NUM }">
						<input type="hidden" id="checkDuplNeisYn" name="checkDuplNeisYn" value="N"/>
						<a class="btn primary" href="#none" id="btnCheckDuplNeis">중복 확인</a>
						<p>
							<input type="checkbox" id="neis_numChk" name="neis_numChk"><label><strong>NEIS 개인 번호가 없습니다.</strong></label><span class="nth-1st">(사립 유치원 교사, 강사, 일반인 등 NEIS 개인 번호가 없는 경우 체크합니다.)</span><br>
							<strong>NEIS 개인 번호</strong><span class="nth-1st">는 <strong>지역(3자리) + 일련번호(7자리)</strong>로 구성된 개인별 고유 번호입니다.</span>
						</p>
						<a class="btn primary" href="javascript:popupOpen('layerNeisInfo')">NEIS 개인 번호 확인 방법 자세히 보기</a>
					</dd> --%>
					<dt>성명</dt>
					<dd class="halfW">${myinfo.NAME }</dd>
					<dt class="border">가입 일시</dt>
					<dd class="halfW">${myinfo.JOIN_DATE }</dd>
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
						<input type="text" class="w6em" maxlength="4" id="phone2" name="phone2" value="${myinfo.PHONE2 }">
						-
						<input type="text" class="w6em" maxlength="4" id="phone3" name="phone3" value="${myinfo.PHONE3 }">

						<input type="hidden" id="phone1" name="phone1" class="target_phone1" value="${myinfo.PHONE1 }"/>
						<input type="hidden" id="phone" name="phone" value="${myinfo.PHONE }"/>
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
						<input type="text" class="w6em" maxlength="4" id="tel2" name="tel2" value="${myinfo.TEL2 }">
						-
						<input type="text" class="w6em" maxlength="4" id="tel3" name="tel3" value="${myinfo.TEL3 }">

						<input type="hidden" id="tel1" name="tel1" class="target_tel1" value="${myinfo.TEL1 }"/>
						<input type="hidden" id="tel" name="tel" value="${myinfo.TEL }"/>
					</dd> --%>
					<dt>전자 우편<i>*</i></dt>
					<dd>
						<input class="nth-1st" type="text" id="email1" name="email1" maxlength="20" value="${myinfo.EMAIL1 }">@<input type="text" id="email2" name="email2" class="target_email2" maxlength="30" value="${myinfo.EMAIL2 }">
						<div class="body-select w8em">
							<a class="btn-toggle" href="#select-mail"><span class="target_email2">직접 입력</span></a>
							<ul class="select-option off" id="select-mail" data-target="target_email2">
								<li data-value="">직접 입력</li>
								<c:forEach var="item" items="${emailList}">
								<li data-value="${item.NAME}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						<input type="hidden" id="email" name="email" value="${myinfo.EMAIL }"/>
					</dd>
					<dt>생년월일</dt>
					<dd>
						<input class="nth-1st" type="text" id="birth_day" maxlength="10" name="birth_day" value="${myinfo.BIRTH_DAY }" <c:if test="${not empty myinfo.BIRTH_DAY }">readonly="readonly" style="background-color: #ccc"</c:if>>
						<span class="explan">※ 1990-01-01 형식으로 입력</span>
					</dd>
					<dt>성별</dt>
					<dd>
						<label><input type="radio" name="gender" value="M" <c:if test="${myinfo.GENDER == 'M'}">checked="checked"</c:if> <c:if test="${not empty myinfo.GENDER and myinfo.GENDER != 'M'}">disabled="disabled"</c:if>> 남자</label>
						<label><input type="radio" name="gender" value="F" <c:if test="${myinfo.GENDER == 'F'}">checked="checked"</c:if> <c:if test="${not empty myinfo.GENDER and myinfo.GENDER != 'F'}">disabled="disabled"</c:if>> 여자</label>
						<p class=".alert" style="display:none"></p>
					</dd>
					<dt>자택 주소<i>*</i></dt>
					<dd class="address">
						<input type="text" class="width20 nth-1st zipcode" id="post_code" name="post_code" value="${myinfo.POST_CODE }" readonly="readonly" style="background-color: #ccc"><a class="btn primary search_addr" href="#none">우편 번호 검색</a><br>
						<input type="text" class="width95 nth-1st addr" id="addr1" name="addr1" value="${myinfo.ADDR1 }" readonly="readonly" style="background-color: #ccc"><br>
						<input type="text" class="width95 nth-1st etc_addr" id="addr2" name="addr2" value="${myinfo.ADDR2 }">
					</dd>
					<dt>학교명/회사명<i>*</i></dt>
					<dd>
						<input type="text" class="width95 nth-1st etc_addr" id="school_name" name="school_name" value="${myinfo.SCHOOL_NAME }">
					</dd>
				</dl>
			</div><!--//.group - 회원 정보 입력 -->
			<%-- <div class="group" id="school_info_v" <c:if test="${myinfo.GRADE == 2 }">style="display:none"</c:if>>
				<h3>학교 및 기관 정보 입력</h3>
				<dl>
					<dt>학교(기관)명</dt>
					<dd>
						<input class="nth-1st width25" type="text" id="school_name" name="school_name" readonly="readonly" value="${myinfo.SCHOOL_NAME }" style="background-color: #ccc">
						<a class="btn primary" href="#" id="btnSearchSchool">학교 및 기관 찾기</a>
						<span class="explan">해당 학교명이나 기관명이 없을 경우 <strong>1833-7247</strong>로 연락하시기 바랍니다.</span>
					</dd>
					<dt>학교 주소</dt>
					<dd>
						<input class="nth-1st w8em" type="text" id="school_post_code" name="school_post_code" class="zipcode" value="${myinfo.SCHOOL_POST_CODE }" readonly="readonly" style="background-color: #ccc"><a class="btn primary" href="#none">우편 번호</a>
						<input type="text" id="school_addr1" name="school_addr1" class="width100 addr" value="${myinfo.SCHOOL_ADDR1 }" readonly="readonly" style="background-color: #ccc">
						<input type="text" id="school_addr2" name="school_addr2" class="width100 etc_addr" value="${myinfo.SCHOOL_ADDR2 }">
					</dd>
					<dt>시·도 교육청</dt>
					<dd class="halfW">
						<div class="body-select width100">
							<a class="btn-toggle" href="#select-region"><span class="target_region">선택</span></a>
							<ul class="select-option off" id="select-region" data-target="target_region">
								<li data-value="">-선택-</li>
								<c:forEach var="item" items="${regionList}">
								<li data-value="${item.CODE}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						<input type="hidden" id="region_code" name="region_code" class="target_region" value="${myinfo.REGION_CODE }"/>
					</dd>
					<dt class="border">교육 지원청</dt>
					<dd class="halfW"><input class="width100" type="text" id="jurisdiction" name="jurisdiction" value="${myinfo.JURISDICTION }"></dd>
					<dt>자격종별</dt>
					<dd class="halfW">
						<div class="body-select width100">
							<a class="btn-toggle" href="#select-stype"><span class="target_stype">자격 구분</span></a>
							<ul class="select-option off" id="select-stype" data-target="target_stype">
								<li data-value="">-선택-</li>
								<li data-value="1">교장</li>
								<li data-value="2">교감</li>
								<li data-value="3">수석 교사</li>
								<li data-value="4">정교사(1정)</li>
								<li data-value="5">정교사(2정)</li>
								<li data-value="6">특수 1정</li>
								<li data-value="7">특수 2정</li>
								<li data-value="8">준교사</li>
								<li data-value="9">실기 교사</li>
								<li data-value="10">전문 상담 교사</li>
								<li data-value="11">사서 교사</li>
								<li data-value="12">보건 교사</li>
								<li data-value="13">영양 교사</li>
							</ul>
						</div>
						<input type="hidden" id="s_type" name="s_type" value="${myinfo.S_TYPE }" class="target_stype"/>
						<input type="hidden" id="e_type" name="e_type" value="${myinfo.E_TYPE }"/>
					</dd>
					<dt class="border">담당 과목</dt>
					<dd class="halfW">
						<input class="width100" type="text" id="subject" name="subject" value="${myinfo.SUBJECT }" placeholder="예) 국어, 체육, 진로" maxlength="30">
					</dd>
					<dt>직위</dt>
					<dd class="halfW">
						<div class="body-select width45">
							<a class="btn-toggle" href="#select-position"><span class="target_position">-선택-</span></a>
							<ul class="select-option off" id="select-position" data-target="target_position">
								<li data-value="">-선택-</li>
								<c:forEach var="item" items="${positionList}">
								<li data-value="${item.NAME}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						<input class="width50" type="text" id="position_etc" name="position_etc" maxlength="30">
						<input type="hidden" id="position" name="position" value="${myinfo.POSITION }" class="target_position"/>
					</dd>
					<dt class="border">임용년도</dt>
					<dd class="halfW">
						<div class="body-select">
							<a class="btn-toggle" href="#select-appyear"><span class="target_appyear">-선택-</span></a>
							<ul class="select-option off" id="select-appyear" data-target="target_appyear">
								<li data-value="">-선택-</li>
								<fmt:formatDate value="${now}" pattern="yyyy" var="nowYear" />
								<c:forEach var="year" begin="${nowYear - 40}" end="${nowYear}" step="1">
								<li data-value="${nowYear - year + nowYear - 40}">${nowYear - year + nowYear - 40}년</li>
								</c:forEach>
							</ul>
						</div>

						<input type="hidden" id="app_year" name="app_year" value="${myinfo.APP_YEAR }" class="target_appyear"/>
					</dd>
				</dl>
			</div><!--//.group - 학교 및 기관정보 입력 --> --%>
			<%-- <div>
				<h3>선택 입력</h3>
				<ul class="notice-list">
					<li>연수 정보 및 이벤트에 대한 정보를 이메일 및 SMS로 수신하시겠습니까?<label><input type="checkbox" id="recv_agree" name="recv_agree" value="Y" <c:if test="${myinfo.ACCEPT_EMAIL == 'Y' or myinfo.ACCEPT_SMS == 'Y' }">checked="checked"</c:if>>수신 동의</label></li>
					<li>회원 가입 및 연수 신청 관련 메일은 수신 여부와 상관없이 발송됩니다.</li>
				</ul>
			</div> --%>
			
		</form>
		<div class="list-bottom alignC">
			<a href="#" class="btn primary" id="saveBtn">정보 수정</a>
			<%-- <a href="<c:url value="/mypage/private/privateedit"/>" class="btn danger">마이 페이지</a> --%>
			<a href="<c:url value="/"/>" class="btn standby">홈으로 이동</a>
		</div>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->

<!--// NEIS개인 번호안내 팝업 -->
<%-- <%@ include file="/WEB-INF/views/common/layer/inc_neisinfo_layers.jsp"%> --%>
<!--// NEIS개인 번호안내 팝업 -->
