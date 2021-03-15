<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<style type="text/css">
#findResult {border:1px solid #e0e0e0; margin:10px 0px; padding:20px; text-align:center}
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

	// 아이디 찾기
	$('#btnFind').click(function() {
		var f = document.getElementById("findForm");
		var phone = concatArray([$('#phone1').val(),$('#phone2').val(),$('#phone3').val()],'-');
		$(f).find("input[name='phone']").val(phone=='--'?'':phone);

		if (!$('#findForm').valid()) {
			return;
		}

		$.ajax({
			type: "POST",
			url: "<c:url value='/member/ajaxFindPw' />",
			data: $('#findForm').serialize(),
			success: function(result) {
				if (isSuccessAjaxResponse(result)) {
					alert('입력하신 휴대 전화 번호로 임시 비밀번호를 발송하였습니다.\n로그인 후 반드시 비밀번호를 변경하시기 바랍니다.');
				} else {
					alertAjaxFailMessage(result);
				}
			},
			error: function(e) {
				alert('오류가 발생하였습니다.');
			}
		});
	});

	// 입력값 체크 설정
	$.validator.addMethod("checkTel",function(value, element) {
		return this.optional(element) || isValidTel(value);
	}, "유효하지 않은 입력입니다.");
	$("#findForm").validate({
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
			id: {"required":true},
			phone: {"required":true, "checkTel":true}
		}
	});
});
</script>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">회원 서비스</a>
			<a class="nth-last" href="#">아이디/비밀번호 찾기</a>
		</p>
		<h2 class="sub-title">아이디/비밀번호 찾기 </h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="tab-group">
			<ul class="tab-header sub x2">
				<li><a class="nth-1st" href="<c:url value="/member/findId"/>">아이디 찾기</a></li>
				<li><a class="on" href="#">비밀번호 찾기</a></li>
			</ul>
			<div class="tab-body">
				<form id="findForm">
					<dl class="section">
						<dt>아이디</dt>
						<dd><input class="nth-1st" type="text" id="id" name="id" placeholder="아이디(전자우편)" style="width:30%"></dd>
						<dt>휴대 전화</dt>
						<dd>
							<div class="body-select width15">
								<a class="btn-toggle" href="#select-phone"><span class="target_phone1">선택</span></a>
								<ul class="select-option off" id="select-phone" data-target="target_phone1">
									<li data-value="선택">선택</li>
									<c:forEach var="item" items="${phone1List}">
									<li data-value="${item.NAME}">${item.NAME}</li>
									</c:forEach>
								</ul>
							</div>
							-
							<input type="text" maxlength="4" id="phone2" name="phone2">
							-
							<input type="text" maxlength="4" id="phone3" name="phone3">

							<input type="hidden" id="phone1" name="phone1" class="target_phone1">
							<input type="hidden" id="phone" name="phone">
						</dd>
					</dl>
					<p class="section">휴대 전화가 변경되었거나 기타 사유로 아이디/비밀번호를 찾기가 어려우신 회원님께서는 고객 센터 <strong class="primary">1833-7247</strong>로 연락주세요.</p>
				</form>
				<div class="list-bottom alignR">
					<a href="#" class="btn primary" id="btnFind">비밀번호 찾기</a>
				</div>
			</div><!--//.tab-body-->
		</div><!--.tab-groyp-->
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
