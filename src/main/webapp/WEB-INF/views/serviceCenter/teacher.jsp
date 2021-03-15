<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<style type="text/css">
.alert label {cursor: default; color:red}
</style>
<script type="text/javascript" src="/resources/js/jquery-validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-validation/localization/messages_ko.min.js"></script>
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

	// 제휴문의버튼
	$('#btnApply').click(function() {
		var f = document.getElementById("saveForm");
		var phone = concatArray([$('#phone1').val(),$('#phone2').val(),$('#phone3').val()],'-');
		var email = $('#email1').val() + (isEmpty($('#email1').val()) || isEmpty($('#email2').val())?"":"@") + $('#email2').val();
		$(f).find("input[name='phone']").val(phone);
		$(f).find("input[name='email']").val(email);

		if (!validateForm()) {
			return;
		}

		$(f).submit()
	});

	// validation rule
	$.validator.addMethod("checkName",function(value, element) {
		return this.optional(element) || isValidName(value);
	}, "유효하지 않은 입력입니다.");
	$.validator.addMethod("checkTel",function(value, element) {
		return this.optional(element) || isValidTel(value);
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
			name: {"required":true, "checkName":true},
			phone: {"required":true, "checkTel":true},
			email: {"email":true},
			agree: {"required":true}
		},
		messages: {
			agree: "지원 개인 정보 수집에 동의하셔야 합니다. "
		}
	});

	// 입력값 초기화
	if($('#phone1').val() != '') {
		selectOption('select-phone', $('#phone1').val());
	}
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
</script>

<t:insertDefinition name="centerleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">고객 센터</a>
			<a class="nth-last" href="${contextPath}">강사 지원</a>
		</p>
		<h2 class="sub-title">강사 지원 </h2>
	</div>
	<div class="sub-body">
		<form id="saveForm" name="saveForm" method="post" enctype="multipart/form-data" action="<c:url value="/serviceCenter/teacher/apply"/>">
			<div class="group">
				<dl>
					<dt>성명<i>*</i></dt>
					<dd>
						<input class="nth-1st" type="text" id="name" name="name" maxlength="30" value="<c:out value="${member.NAME }"/>">
					</dd>
					<dt>연락처<i>*</i></dt>
					<dd>
						<div class="body-select width10">
							<a class="btn-toggle" href="#select-phone"><span class="target_phone1">선택</span></a>
							<ul class="select-option off" id="select-phone" data-target="target_phone1">
								<li data-value="선택">선택</li>
								<c:forEach var="item" items="${phone1List}">
								<li data-value="${item.NAME}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						-
						<input type="text" maxlength="4" id="phone2" name="phone2" value="<c:out value="${member.PHONE2 }"/>">
						-
						<input type="text" maxlength="4" id="phone3" name="phone3" value="<c:out value="${member.PHONE3 }"/>">

						<input type="hidden" id="phone1" name="phone1" class="target_phone1" value="<c:out value="${member.PHONE1 }"/>"/>
						<input type="hidden" id="phone" name="phone" value="<c:out value="${member.PHONE1 }"/>"/>
					</dd>
					<dt>전자 우편<i>*</i></dt>
					<dd>
						<input class="nth-1st" type="text" id="email1" name="email1" maxlength="20" value="<c:out value="${member.EMAIL1 }"/>">@<input type="text" id="email2" name="email2" class="target_email2" maxlength="30" value="<c:out value="${member.EMAIL2 }"/>">
						<div class="body-select width15">
							<a class="btn-toggle" href="#select-mail"><span class="target_email2">직접 입력</span></a>
							<ul class="select-option off" id="select-mail" data-target="target_email2">
								<li data-value="">직접 입력</li>
								<c:forEach var="item" items="${emailList}">
								<li data-value="${item.NAME}">${item.NAME}</li>
								</c:forEach>
							</ul>
						</div>
						<input type="hidden" id="email" name="email" value="<c:out value="${member.EMAIL }"/>"/>
					</dd>
					<dt>지원 연수 영역</dt>
					<dd>
						<c:forEach var="item" items="${courseList}">
						<label><input type="checkbox" name="courses" value="${item.NAME}"> ${item.NAME}</label>
						</c:forEach>
					</dd>
					<dt class="height h120">자기소개</dt>
					<dd class="height h120"><textarea id="comment" name="comment"></textarea></dd>
					<dt>이력서 및 자기소개서</dt>
					<dd>
						<div><input type="file" name="filedatas"></div>
						<div><input type="file" name="filedatas"></div>
					</dd>
				</dl>
			</div>
			<div>
				<h3>개인 정보 수집 동의</h3>
				<p class="notice-title">창비교육 원격교육연수원은 아래와 같이 개인 정보를 수집하고 있습니다.</p>
				<ul class="notice-list">
					<li>수집 개인 정보 항목: 성명, 연락처, 전자 우편</li>
					<li>개인 정보 수집 및 이용 목적: 강사 지원에 따른 확인 및 회신</li>
					<li>개인 정보 이용 기간: 이용 목적 달성 또는 개인 정보 삭제 요청 시까지</li>
					<li>동의 거부 권리: 작성자는 개인 정보 수집 동의를 거부할 수 있습니다. 다만, 동의를 거부하는 경우 강사 지원이 불가능합니다.</li>
				</ul>
			</div>
			<div class="valdation_message_container">
				<label><input type="checkbox" id="agree" name="agree">개인 정보 수집에 동의합니다.</label>
				<p>신청하신 내용은 창비교육 원격교육연수원 담당자에게 전달되며, 신청일로부터 영업일 기준 7일 이내 회신을 드립니다. 감사합니다.</p>
			</div>
		</form>
		<div class="list-bottom alignR">
				<!-- <a href="#" class="btn danger">삭제</a> -->
				<a href="#" class="btn primary" id="btnApply">지원</a>
		</div>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->
