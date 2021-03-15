<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
// 본인 인증 팝업
var idenWin;
function popIdentity(iden_gbn) {
	switch(iden_gbn) {
	case 'phone':	// 휴대 전화
	case 'cert':	// 공인 인증서
		idenWin = popIdenWindow('<c:url value="/iden/nice/checkplus"/>?iden_gbn='+iden_gbn, 440, 680);
		break;
	case 'ipin':	// 아이핀
		idenWin = popIdenWindow('<c:url value="/iden/nice/ipin"/>?iden_gbn='+iden_gbn, 465, 560);
		break;
	default:

	}
}

// 본인 인증 성공 처리
function onIdentitySuccess(iden_gbn, data) {
	idenWin.close();
	location.href = '<c:url value="/mypage/private/secessionedit"/>';
}

// 본인 인증 실패 처리
function onIdentityFail(iden_gbn, data) {
	data = $.extend({}, data);	// ie script18
	idenWin.close();
	var errorMessage = (typeof(data['errorMessage']) != 'undefined')?('\n['+data['errorMessage'] + ']'):'';
	alert('본인 인증에 실패하였습니다.' + errorMessage);
}
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a href="#">개인 정보</a>
			<a class="nth-last" href="#">회원 탈퇴</a>
		</p>
		<h2 class="sub-title">회원 탈퇴</h2>
	</div>
	<div class="sub-body">
		<div class="certification">
			<h3>본인 인증</h3>
			<p>회원 탈퇴를 하기 위해서는 본인 인증 후 탈퇴 신청을 할 수 있습니다.<br>본인 인증 수단을 선택하여 주시기 바랍니다.</p>
			<ul>
				<li>
					<div class="phone">
						<span>휴대 전화 인증</span>
						<p>본인 명의의 휴대 전화 인증</p>
						<a href="#" class="btn M primary" onclick="popIdentity('phone')">휴대 전화 인증</a>
					</div>
				</li>
				<li>
					<div class="pin">
						<span>아이핀 인증</span>
						<p>본인 명의의 아이핀 인증</p>
						<a href="#" class="btn M primary" onclick="popIdentity('ipin')">아이핀 인증</a>
					</div>
				</li>
				<c:if test="${not currentDevice.mobile }">
				<li>
					<div class="certi">
						<span>공인 인증서 인증</span>
						<p>본인 명의의 공인 인증서 인증</p>
						<a href="#" class="btn M primary" onclick="popIdentity('cert')">공인 인증서 인증</a>
					</div>
				</li>
				</c:if>
				<!--<li>
					<div class="card">
						<span>신용카드 인증</span>
						<p>본인 명의의 휴대 전화 인증</p>
						<a href="#" class="btn M primary">신용카드 인증</a>
					</div>
				</li>-->
			</ul>
		</div>

	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->
