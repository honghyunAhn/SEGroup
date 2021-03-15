<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<jsp:useBean id="now" class="java.util.Date" />
<style type="text/css">
.alert label {cursor: default;}
form p.alert {color: red;}
</style>
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

		// callback
		var callbackYn = $p.data('callback') || 'N';
		if (callbackYn === 'Y' && typeof(onSelectOption) == 'function') {
			onSelectOption({
				'value': value,
				'text': text
			});
		}
	});

	// 학교 기관 찾기 팝업
	$('#btnSearchSchool').click(function() {
		popSearchSchool();
	});

	// 우편 번호 조회 버튼 클릭 시
	$('a.search_addr').unbind('click').bind('click', function() {
		var idx = $('a.search_addr').index($(this));
		daumPostcode(idx);
	});

	// neis 변경시 중복체크여부 N
	$('.neis_piece').change(function() {
		$('#checkDuplNeisYn').val('N');
	});

	$("#neis_local").change(function() {
		if ($(this).val() == 'Z99') {
			$("input.neis_piece").each(function(i, obj){
				$(obj).val('9');
		 	});
		}
	});


	$('#btnCheckDuplNeis').click(function() {
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
			alert('등록 가능한 NEIS번호 입니다.');
		}

		$('#checkDuplNeisYn').valid();	// validate one field
	});

	// NEIS임시발급
	$('#btnGenNeis').click(function(){
		/*
		if(isEmpty($('#neis_local').val())) {
			alert('지역구분을 먼저 선택하여 주십시오.');
			$('#neis_local').focus();
			return;
		};

		$('#neis_num').val('');
		var landom = generateRandom(1,10000000);
		var lanarry = landom.split('');

		if(lanarry.length == 6){
			landom = landom+'0';
			lanarry.push('0');
		}
		$('input.neis_piece').each(function(idx,obj){
 			$(obj).val(lanarry[idx]);
		});
		$('#neis_num').val($('#neis_local').val()+landom);
		*/
		$('#neis_local').val('Z99').trigger('change');
	});

	// 취소버튼(이전가기)
	$('#btnCancel').click(function() {
		location.href = '<c:url value="/member/join2"/>';
	});

	// 회원가입버튼
	$('#btnRegist').click(function() {
		var f = document.getElementById("saveForm");
		var neis_num = '';
		$('.neis_piece').each(function(idx, obj) {
			neis_num += $(obj).val().toUpperCase();
		});

		$(f).find("input[name='neis_num']").val(neis_num);

		if (!validateForm()) {
			return;
		}

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
	});

	// validation rule
	$.validator.addMethod("checkNeis",function(value, element) {
		return this.optional(element) || isValidNeis(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkDuplNeis",function(value, element) {
		return this.optional(element) || $('#neis_num').val() == '' || $('#checkDuplNeisYn').val() === 'Y';
	}, "중복체크를 하여 주십시오.");
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
			school_name: {"required":true},
			neis_num: {"checkNeis":true},
			checkDuplNeisYn: {"checkDuplNeis":true},
			recomm_id: {"email":true, "checkExistId":true},
			agree: {"required":true}
		},
		messages: {
			recomm_id: {
				"checkExistId": "존재하지 않는 아이디 입니다."
			},
			agree: "내용에 동의하셔야 합니다. "
		}
	});

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

// 입력값 체크
function validateForm() {
	return $('#saveForm').valid();
}

// NEIS 중복체크
function checkDuplNeis(neis_num) {
	var valid = false;
	$.ajax({
		type: "post",
		url: "<c:url value='/member/ajaxCheckDuplNeis' />",
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

// 학교(기관) 찾기 팝업
function popSearchSchool() {
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
}

// 학교(기관) 선택
function onSearchSchool(data) {
	$('#school_name').val(data.name);
	$('#school_post_code').val(data.post_code);
	$('#school_addr1').val(data.addr1);
	/* $('#school_addr2').val(data.addr2); */
	selectOption('select-region', data.region_code);
	$('#jurisdiction').val(data.jurisdiction);
	selectOption('select-stype', data.s_type);
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
			<div class="group">
				<h3>학교 및 기관 정보 입력</h3>
				<dl>
					<dt>학교(기관)명<i>*</i></dt>
					<dd>
						<input class="nth-1st width25" type="text" id="school_name" name="school_name" readonly="readonly"><a class="btn primary" href="#none" id="btnSearchSchool">학교 및 기관 찾기</a>
						<span class="explan">해당 학교명이나 기관명이 없을 경우 <strong>1833-7247</strong>로 연락하시기 바랍니다.</span>
					</dd>
					<dt>학교 주소</dt>
					<dd>
						<input type="text" id="school_post_code" name="school_post_code" class="nth-1st w8em zipcode"><a class="btn primary" href="#none">주소 찾기</a>
						<input type="text" id="school_addr1" name="school_addr1" class="width100 addr">
						<!-- <input type="text" id="school_addr2" name="school_addr2" class="width100 etc_addr"> -->
					</dd>
					<dt>시·도 교육청</dt>
					<dd class="halfW">
						<div class="body-select width100">
							<a class="btn-toggle" href="#select-region"><span class="target_region">선택</span></a>
							<ul class="select-option off" id="select-region" data-target="target_region">
								<li data-value="">선택</li>
								<c:forEach var="item" items="${regionList}">
								<li data-value="${item.CODE}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						<input type="hidden" id="region_code" name="region_code" class="target_region"/>
					</dd>
					<dt class="border">교육 지원청</dt>
					<dd class="halfW"><input class="width100" type="text" id="jurisdiction" name="jurisdiction"></dd>
					<dt>NEIS 개인 번호</dt>
					<dd class="height h120 NEIS">
						<a class="btn primary" href="javascript:popupOpen('layerNeisInfo')">NEIS 개인 번호 도움말</a>
						<a class="btn line" href="#none" id="btnGenNeis">NEIS 개인 번호 임시 발급</a><br>
						<select id="neis_local" class="neis_piece" style="background: none">
						<option value="">지역 선택</option>
						<c:forEach var="item" items="${localEduofficeList}">
						<option value="${item.CODE}">${item.NAME}(${item.CODE })</option>
						</c:forEach>
						</select>
						<c:forEach begin="4" end="10" varStatus="varStatus">
						<input type="text" class="neis_piece" maxlength="1">
						</c:forEach>
						<a class="btn primary" href="#none" id="btnCheckDuplNeis">중복 확인</a>
						<input type="hidden" id="neis_num" name="neis_num"/>
						<input type="hidden" id="checkDuplNeisYn" name="checkDuplNeisYn" value="N"/>
					</dd>
					<dt>자격종별</dt>
					<dd class="halfW">
						<div class="body-select width100">
							<a class="btn-toggle" href="#select-stype"><span class="target_stype">자격종별</span></a>
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
						<input type="hidden" id="s_type" name="s_type" class="target_stype"/>
						<input type="hidden" id="e_type" name="e_type"/>
					</dd>
					<dt class="border">담당 과목</dt>
					<dd class="halfW"><input class="width100" type="text" id="subject" name="subject" placeholder="예) 국어, 체육, 진로" maxlength="30"></dd>
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
						<input type="hidden" id="position" name="position" class="target_position"/>
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

						<input type="hidden" id="app_year" name="app_year" class="target_appyear"/>
					</dd>
					<%--
					<dt>추천 아이디</dt>
					<dd><input class="nth-1st" type="text" id="recomm_id" name="recomm_id"><span>아이디를 입력하시면 200포인트가 지급됩니다.</span></dd>
					 --%>
				</dl>
			</div><!--//.group - 학교 및 기관정보 입력 -->
			<div>
				<h3>개인 정보 처리 방침 제4조 (개인 정보의 제3자 제공) 동의</h3>
				<p class="notice-title">제4조 (개인 정보의 제3자 제공)</p>
				<ul class="notice-list">
					<li class="indent">창비교육 원격교육연수원은 원칙적으로 회원의 개인 정보를 제1조 (개인 정보 수집 및 이용목적)에서 명시한 범위 내에서 처리하며, 회원의 사전 동의 없이는 본래의 범위를 초과하여 처리하거나 제3자에게 제공하지 않습니다. 단, 그러한 상황이 생길 경우, 회원의 사전 동의를 받습니다. 단, 관련 법령에 달리 정함이 있는 경우네는 예외로 하며, 이 경우 주의를 기울여 개인 정보를 이용 및 제공할 수 있습니다.</li>
					<li>개인 정보의 제3자 제공 동의
						<table>
							<thead>
								<tr>
									<th class="nth-1st">제공 받는자</th>
									<th>개인 정보 이용목적</th>
									<th>제공 항목</th>
									<th>보유 기간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="nth-1st">소속 교육청 및 시·도 교육연수원, 한국교육학술정보원(KERIS)</td>
									<td>이수 결과 통보 및 이수자 정보관리 시스템 등록</td>
									<td>
										<ol>
											<li>성명</li>
											<li>생년월일</li>
											<li>NEIS 개인 번호</li>
											<li>연수 지명번호</li>
											<li>학교명</li>
											<li>연수 영역</li>
											<li>연수 과정명</li>
											<li>연수 기관</li>
											<li>연수 시작일</li>
											<li>연수 종료일</li>
											<li>연수 이수 기간</li>
											<li>연수 성적</li>
											<li>직무 관련성</li>
											<li>평점 학점</li>
											<li>연수 이수 번호</li>
										</ol>
									</td>
									<td>『공공기록물 관리에 관한 볍류, 법률 제 12844호』에 의거 영구 보존</td>
								</tr>
							</tbody>
						</table>
					</li>
				</ul>
			</div>
			<div class="valdation_message_container">
				<label><input type="checkbox" id="agree" name="agree">위의 내용에 동의 합니다.</label>
			</div>
		</form>
		<div class="list-bottom alignR">
			<a href="#" class="btn danger" id="btnCancel">이전으로(취소)</a>
			<a href="#" class="btn primary" id="btnRegist">회원가입</a>
		</div>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->

<!--// NEIS개인 번호안내 팝업 -->
<%@ include file="/WEB-INF/views/common/layer/inc_neisinfo_layers.jsp"%>
<!--// NEIS개인 번호안내 팝업 -->