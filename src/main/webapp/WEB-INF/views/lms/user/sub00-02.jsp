<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<style type="text/css">
#redMessage {
	margin-left: auto;
	margin-right: auto;
	margin-botom: 70px;
}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- 홈페이지의 대략적인 설명 >> 검색 결과 제목 하단에 설명으로 노출 -->
<meta name="description" content=디지털·AI, 외국어, 직무, 자격증까지! Let's Do it! Doitcampus!">
<!-- 홈페이지 키워드 >> 키워드 검색했을 때 검색결과로 노출 -->
<meta name="keywords"
	content="디지털, AI, 빅데이터, 프로그래밍, 정보처리, 데이터베이스, 클라우드, 외국어, 영어, 일본어, 중국어, 직무, 경영, 사업전략, 리더십, 코칭, 마케팅, CS, 자기관리, 커뮤니케이션, 법정의무, 취업, 해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
<title>Let's Do it 두잇캠퍼스</title>
<link rel="stylesheet" href="/resources/lms/css/swiper.min.css">
<link rel="stylesheet" href="/resources/lms/css/reset.css">
<link rel="stylesheet" href="/resources/lms/css/common.css">
<link rel="stylesheet" href="/resources/lms/css/img-icon.css">
<link rel="stylesheet" href="/resources/lms/css/style.css">
<link rel="stylesheet" href="/resources/lms/css/style_responsive.css">
<link rel="stylesheet" href="/resources/lms/css/renewal_style.css">
<script src="/resources/lms/js/jquery-3.3.1.min.js"></script>
<script src="/resources/lms/js/swiper.js"></script>
<script src="/resources/lms/js/renewal_script.js"></script>
<script type="text/javascript">
<spring:eval expression="@domain['domain']" var="domain"/>
	document.domain = "${domain}";

	$(document).ready(function() {
		//다음 버튼 숨김(인증을 통해야 이동할 수 있도록)
		$("#goSubmit").hide();

		//전체 동의처리
		$('.check-all').click(function() {
			$('.check').prop('checked', this.checked);
		});

		$('#goSubmit').click(function() {
			$('#signUp-check').submit();
		})

	});

	//본인 인증 팝업
	<spring:eval expression="@domain['domain.mobile']" var="mobile"/>
	var url = "${mobile}"; //운영
	var DRMOK2_window;
	function popIdentity(iden_gbn) {

		if (!checkAgree()) {
			return;
		}

		switch (iden_gbn) {
		case 'phone': // 휴대 전화
			window.name = 'sendJsp2';
			DRMOK2_window = window
					.open(
							url
									+ '?cpid=${cpId}&rtn_url=${rtn_url}&req_info=${encReqInfo}',
							'DRMOK2_window',
							'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no');
			DRMOK2_window.focus();
			if (DRMOK2_window == null) {
				alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
			}
			break;
		/* case 'cert':	// 공인 인증서
			//window.open('<c:url value="/iden/nice/checkplus"/>?iden_gbn='+iden_gbn,'','top=100px,left=100px,width=422px,height=660px');
			idenWin = popIdenWindow('<c:url value="/iden/nice/checkplus"/>?iden_gbn='+iden_gbn, 440, 680);
			//idenWin = window.open(null,'','width=440px, height=680px, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			//idenWin.document.write('<iframe width="100%", height="100%" src="<c:url value="/iden/nice/checkplus"/>?iden_gbn='+iden_gbn+'" frameborder="0" style="margin:0;paddgin:0" scrolling="no" allowfullscreen></iframe>');
			break; */
		/* case 'ipin':	// 아이핀
			//window.open('<c:url value="/iden/nice/ipin"/>?iden_gbn='+iden_gbn,'','width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			idenWin = popIdenWindow('<c:url value="/iden/nice/ipin"/>?iden_gbn='+iden_gbn, 465, 560);
			//idenWin = window.open(null,'','width=465px, height=560px, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			//idenWin.document.write('<iframe width="100%", height="100%" src="<c:url value="/iden/nice/ipin"/>?iden_gbn='+iden_gbn+'" frameborder="0" style="margin:0;paddgin:0" allowfullscreen></iframe>');
			break; */
		default:

		}
	}

	window.CallVerified = function() {
		alert('본인인증을 완료하였습니다.');
		DRMOK2_window.close();
		$('#redMessage').html("본인인증을 완료하였습니다.");
		$("#goSubmit").trigger("click");
	}

	// 약관 및 회원 구분 선택 체크
	function checkAgree() {
		var valid = true;
		$("input[name='agree']").each(function() {
			if ($(this).data('must') != 'N') {
				if (!$(this).is(":checked")) {
					alert('약관에 동의하지 않으셨습니다.')
					$(this).focus();
					valid = false;
					return false;
				}
			}
		});

		return valid;
	}
</script>
</head>

<body>
	<div class="skip-navigation">
		<!--웹접근성/content-->
		<p>
			<a class="goToMain" href="#main">콘텐츠 바로가기</a>
		</p>
	</div>

	<!-- header-include -->
	<%@include file="../sub_header.jsp"%>

	<div class="container subPage_container sub00 d-flex" id="main">
		<!-- <div class="container sub00 sub00-02" id="main"> -->

		<!-- sub00로그인/회원가입-include -->
		<%@include file="../user/menu/leftmenu00.jsp"%>
		<div class="subPage_content sub-content sub00-02 margin-left20">
			<!-- 현재 페이지 위치 표시 -->
			<!--  <div class="page-locationWrap">
                <ul class="page-location">
                    
                home 메인 / category menu 대분류 / division menu 중분류 / section menu 소분류
               
                    <li class="img-icon home"><a href="index.html"></a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="category-menu"><a href="/lms/user/sub00-01">로그인/회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="division-menu"><a href="/lms/user/sub00-02">회원가입</a></li>
                    <li class="img-icon chevron-right"></li>
                    <li class="section-menu"><a href="#">로그인</a></li>
                </ul>
                <div class="img-icon chevron-right"></div>
                <div class="sub-content sub00-01"></div>
            </div> -->

			<!-- <div class="header">
                	<div class="titleBar h3">회원가입</div>
                	<h3 class="h3"></h3>
            	 </div> -->

			<!-- processWrap : 다음단계로 넘어갈 때 .addClass('.active')됩니다. -->
			<ul class="processWrap d-flex">
				<li class="process active"><span
					class="margin-right10 h5 fc_orD">01</span>약관확인</li>
				<li class="process"><span class="margin-right10 h5 fc_orD">02</span>정보입력</li>
				<li class="process"><span class="margin-right10 h5 fc_orD">03</span>가입완료</li>
			</ul>
			<div class="section sub00-02">
				<form action="/lms/user/sub00-02-02" method="post" id="signUp-check">
					<acrticle class="signUp-agree"> <header
						class="article-title">
						<div class="titleBar-hdr h4">이용약관</div>
						<!-- <h4 class="h4"></h4> -->
					</header>
					<div class="text-box">
						<ul style="list-style-type: none;">
							<li>(주)소프트엔지니어소사이어티(Soft Engineer Society) 이용약관</li>
							<li>&nbsp;</li>
							<li>제1조(목적) 이 약관은 (주)소프트엔지니어소사이어티(Soft Engineer Society)이
								운영하는 인터넷 관련 서비스(이하 “소프트엔지니어소사이어티”라 한다)를 이용함에 있어 소프트엔지니어소사이어티와
								이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.</li>
							<li>&nbsp;</li>
							<li>제2조(정의)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”가란 (주)소프트엔지니어소사이어티(Soft
								Engineer Society)이 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등
								정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러
								(주)소프트엔지니어소사이어티(Soft Engineer School)이 운영하는 사업자의 의미로도 사용합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “이용자”란 “소프트엔지니어소사이어티”에 접속하여 이 약관에 따라
								“소프트엔지니어소사이어티”가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ ‘회원’이라 함은 “소프트엔지니어소사이어티”에 회원등록을 한 자로서,
								계속적으로 “소프트엔지니어소사이어티”가 제공하는 서비스를 이용할 수 있는 자를 말합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ ‘비회원’이라 함은 회원에 가입하지 않고 “소프트엔지니어소사이어티”가
								제공하는 서비스를 이용하는 자를 말합니다.</li>
							<li>&nbsp;</li>
							<li>제3조 (약관 등의 명시와 설명 및 개정)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 이 약관의 내용과 상호 및 대표자 성명, 영업소
								소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소,
								사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 소프트엔지니어소사이어티의
								초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수
								있습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티은 이용자가 약관에 동의하기에 앞서 약관에 정하여져
								있는 내용 중 청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는
								팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”는 「전자상거래 등에서의 소비자보호에 관한 법률」,
								「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망
								이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는
								범위에서 이 약관을 개정할 수 있습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ “소프트엔지니어소사이어티”가 약관을 개정할 경우에는 적용일자 및 개정사유를
								명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게
								불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우
								"소프트엔지니어소사이어티“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;⑤ “소프트엔지니어소사이어티”가 약관을 개정할 경우에는 그 개정약관은 그
								적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로
								적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의
								공지기간 내에 “소프트엔지니어소사이어티”에 송신하여 “소프트엔지니어소사이어티”의 동의를 받은 경우에는 개정약관
								조항이 적용됩니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래
								등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 「전자상거래 등에서의 소비자
								보호지침」 및 관계법령 또는 상관례에 따릅니다.</li>
							<li>&nbsp;</li>
							<li>제4조(서비스의 제공 및 변경)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 다음과 같은 업무를 수행합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;2. 구매계약이 체결된 재화 또는 용역의 제공</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;3. 기타 “소프트엔지니어소사이어티”가 정하는 업무</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 재화 또는 용역의 품절 또는 기술적 사양의 변경
								등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된
								재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”가 제공하기로 이용자와 계약을 체결한 서비스의
								내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한
								주소로 즉시 통지합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ 전항의 경우 “소프트엔지니어소사이어티”는 이로 인하여 이용자가 입은 손해를
								배상합니다. 다만, “소프트엔지니어소사이어티”가 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</li>
							<li>&nbsp;</li>
							<li>제5조(서비스의 중단)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 컴퓨터 등 정보통신설비의 보수점검․교체 및
								고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 제1항의 사유로 서비스의 제공이 일시적으로
								중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “소프트엔지니어소사이어티”가 고의 또는
								과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할
								수 없게 되는 경우에는 “소프트엔지니어소사이어티”는 제8조에 정한 방법으로 이용자에게 통지하고 당초
								“소프트엔지니어소사이어티”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “소프트엔지니어소사이어티”가
								보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “소프트엔지니어소사이어티”에서 통용되는
								통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.</li>
							<li>&nbsp;</li>
							<li>제6조(회원가입)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① 이용자는 “소프트엔지니어소사이어티”가 정한 가입 양식에 따라 회원정보를
								기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 제1항과 같이 회원으로 가입할 것을 신청한
								이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에
								회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서
								“소프트엔지니어소사이어티”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;2. 등록 내용에 허위, 기재누락, 오기가 있는 경우</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;3. 기타 회원으로 등록하는 것이
								“소프트엔지니어소사이어티”의 기술상 현저히 지장이 있다고 판단되는 경우</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ 회원가입계약의 성립 시기는 “소프트엔지니어소사이어티”의 승낙이 회원에게
								도달한 시점으로 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에
								“소프트엔지니어소사이어티”에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.</li>
							<li>&nbsp;</li>
							<li>제7조(회원 탈퇴 및 자격 상실 등)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① 회원은 “소프트엔지니어소사이어티”에 언제든지 탈퇴를 요청할 수 있으며
								“소프트엔지니어소사이어티”는 즉시 회원탈퇴를 처리합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② 회원이 다음 각 호의 사유에 해당하는 경우, “소프트엔지니어소사이어티”는
								회원자격을 제한 및 정지시킬 수 있습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;1. 가입 신청 시에 허위 내용을 등록한 경우</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;2. “소프트엔지니어소사이어티”를 이용하여 구입한 재화
								등의 대금, 기타 “소프트엔지니어소사이어티”가용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;3. 다른 사람의 “소프트엔지니어소사이어티” 이용을
								방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;4. “소프트엔지니어소사이어티”를 이용하여 법령 또는 이
								약관이 금지하거나 공서양속에 반하는 행위를 하는 경우</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”가 회원 자격을 제한․정지 시킨 후, 동일한 행위가
								2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “소프트엔지니어소사이어티”는 회원자격을
								상실시킬 수 있습니다.</li>
							<li>&nbsp;&nbsp;④ “소프트엔지니어소사이어티”가 회원자격을 상실시키는 경우에는 회원등록을
								말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를
								부여합니다.</li>
							<li>&nbsp;</li>
							<li>제8조(회원에 대한 통지)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”가 회원에 대한 통지를 하는 경우, 회원이
								“소프트엔지니어소사이어티”와 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 불특정다수 회원에 대한 통지의 경우 1주일이상
								“소프트엔지니어소사이어티” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와
								관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.</li>
							<li>&nbsp;</li>
							<li>제9조(구매신청)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”가용자는 “소프트엔지니어소사이어티”상에서 다음 또는
								이와 유사한 방법에 의하여 구매를 신청하며, “소프트엔지니어소사이어티”는 이용자가 구매신청을 함에 있어서 다음의 각
								내용을 알기 쉽게 제공하여야 합니다.</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. 재화 등의 검색 및 선택</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. 재화 등의 구매신청 및 이에
								관한 확인 또는 “소프트엔지니어소사이어티”의 확인에 대한 동의</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. 결제방법의 선택</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”가 제3자에게 구매자 개인정보를 제공·위탁할 필요가
								있는 경우 실제 구매신청 시 구매자의 동의를 받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이
								때 “소프트엔지니어소사이어티”는 제공되는 개인정보 항목, 제공받는 자, 제공받는 자의 개인정보 이용 목적 및
								보유‧이용 기간 등을 구매자에게 명시하여야 합니다. 다만 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제25조
								제1항에 의한 개인정보 취급위탁의 경우 등 관련 법령에 달리 정함이 있는 경우에는 그에 따릅니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;</li>
							<li>제10조 (계약의 성립)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 제9조와 같은 구매신청에 대하여 다음 각 호에
								해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면
								미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;1. 신청 내용에 허위, 기재누락, 오기가 있는 경우</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는
								재화 및 용역을 구매하는 경우</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;3. 기타 구매신청에 승낙하는 것이
								“소프트엔지니어소사이어티” 기술상 현저히 지장이 있다고 판단하는 경우</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”의 승낙이 제12조제1항의 수신확인통지형태로
								이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”의 승낙의 의사표시에는 이용자의 구매 신청에 대한
								확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.</li>
							<li>&nbsp;</li>
							<li>제11조(지급방법) “소프트엔지니어소사이어티”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음
								각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “소프트엔지니어소사이어티”는 이용자의 지급방법에 대하여 재화
								등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;3. 온라인무통장입금</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;4. 전자화폐에 의한 결제</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;5. 수령 시 대금지급</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;6. 마일리지 등 “소프트엔지니어소사이어티”가 지급한
								포인트에 의한 결제</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;7. “소프트엔지니어소사이어티”와 계약을 맺었거나
								“소프트엔지니어소사이어티”가 인정한 상품권에 의한 결제</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;8. 기타 전자적 지급 방법에 의한 대금 지급 등</li>
							<li>&nbsp;</li>
							<li>제12조(수신확인통지․구매신청 변경 및 취소)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 이용자의 구매신청이 있는 경우 이용자에게
								수신확인통지를 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는
								수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “소프트엔지니어소사이어티”는 서비스 제공 전에
								이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는
								제15조의 청약철회 등에 관한 규정에 따릅니다.</li>
							<li>&nbsp;</li>
							<li>제13조(재화 등의 공급)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 이용자와 재화 등의 공급시기에 관하여 별도의
								약정이 없는 이상, 이용자가 청약을 한 날에 재화 등을 제공할 수 있도록 필요한 조치를 취합니다. 이때
								“소프트엔지니어소사이어티”는 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 이용자가 구매한 재화에 대해 제공 수단, 제공
								기간 등을 명시합니다.</li>
							<li>&nbsp;</li>
							<li>제14조(환급) “소프트엔지니어소사이어티”는 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도
								또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는
								대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.</li>
							<li>&nbsp;</li>
							<li>제15조(청약철회 등)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”와 재화등의 구매에 관한 계약을 체결한 이용자는
								「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을
								받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을
								말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의
								소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② 이용자는 재화 등을 제공 받고 모의토플 시험을 응시한 경우에는 반품 및
								교환을 할 수 없습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ 제2항제2호 내지 제4호의 경우에 “소프트엔지니어소사이어티”가 사전에
								청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지
								않았다면 이용자의 청약철회 등이 제한되지 않습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시·광고
								내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는
								알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.</li>
							<li>&nbsp;</li>
							<li>제16조(청약철회 등의 효과)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 이용자로부터 재화 등을 반환받은 경우 5영업일
								이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “소프트엔지니어소사이어티”가 이용자에게 재화등의 환급을
								지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는
								지연이자율을 곱하여 산정한 지연이자를 지급합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 위 대금을 환급함에 있어서 이용자가 신용카드
								또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금
								재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가
								부담합니다. “소프트엔지니어소사이어티”는 이용자에게 청약철회 등을 이유로 손해배상을 청구하지 않습니다. 다만 재화
								등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한
								비용은 “소프트엔지니어소사이어티”가 부담합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에
								“소프트엔지니어소사이어티”는 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.</li>
							<li>&nbsp;</li>
							<li>제17조(개인정보보호)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 이용자의 개인정보 수집시 서비스제공을 위하여
								필요한 범위에서 최소한의 개인정보를 수집합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 회원가입시 구매계약이행에 필요한 정보를 미리
								수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정
								개인정보를 수집하는 경우에는 그러하지 아니합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”는 이용자의 개인정보를 수집·이용하는 때에는 당해
								이용자에게 그 목적을 고지하고 동의를 받습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ “소프트엔지니어소사이어티”는 수집된 개인정보를 목적외의 용도로 이용할 수
								없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용·제공단계에서 당해 이용자에게 그
								목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;⑤ “소프트엔지니어소사이어티”가 제3항과 제4항에 의해 이용자의 동의를 받아야
								하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적,
								제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호
								등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할
								수 있습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;⑥ 이용자는 언제든지 “소프트엔지니어소사이어티”가 가지고 있는 자신의 개인정보에
								대해 열람 및 오류정정을 요구할 수 있으며 “소프트엔지니어소사이어티”는 이에 대해 지체 없이 필요한 조치를 취할
								의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “소프트엔지니어소사이어티”는 그 오류를 정정할 때까지 당해
								개인정보를 이용하지 않습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;⑦ “소프트엔지니어소사이어티”는 개인정보 보호를 위하여 이용자의 개인정보를
								취급하는 자를 최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출,
								동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;⑧ “소프트엔지니어소사이어티” 또는 그로부터 개인정보를 제공받은 제3자는
								개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;⑨ “소프트엔지니어소사이어티”는 개인정보의 수집·이용·제공에 관한 동의란을 미리
								선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의거절시 제한되는 서비스를
								구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등
								서비스 제공을 제한하거나 거절하지 않습니다.</li>
							<li>&nbsp;</li>
							<li>제18조(“소프트엔지니어소사이어티“의 의무)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 법령과 이 약관이 금지하거나 공서양속에 반하는
								행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화․용역을 제공하는데 최선을 다하여야
								합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 이용자가 안전하게 인터넷 서비스를 이용할 수
								있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”가 상품이나 용역에 대하여 「표시․광고의 공정화에
								관한 법률」 제3조 소정의 부당한 표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;④ “소프트엔지니어소사이어티”는 이용자가 원하지 않는 영리목적의 광고성
								전자우편을 발송하지 않습니다.</li>
							<li>&nbsp;</li>
							<li>제19조(회원의 ID 및 비밀번호에 대한 의무)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게
								있습니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을
								인지한 경우에는 바로 “소프트엔지니어소사이어티”에 통보하고 “소프트엔지니어소사이어티”의 안내가 있는 경우에는 그에
								따라야 합니다.</li>
							<li>&nbsp;</li>
							<li>제20조(이용자의 의무) 이용자는 다음 행위를 하여서는 안 됩니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;1. 신청 또는 변경시 허위 내용의 등록</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;2. 타인의 정보 도용</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;3. “소프트엔지니어소사이어티”에 게시된 정보의 변경</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;4. “소프트엔지니어소사이어티”가 정한 정보 이외의
								정보(컴퓨터 프로그램 등) 등의 송신 또는 게시</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;5. “소프트엔지니어소사이어티” 기타 제3자의 저작권 등
								지적재산권에 대한 침해</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;6. “소프트엔지니어소사이어티” 기타 제3자의 명예를
								손상시키거나 업무를 방해하는 행위</li>
							<li>&nbsp;&nbsp;&nbsp;&nbsp;7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타
								공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위</li>
							<li>&nbsp;</li>
							<li>제21조(연결“소프트엔지니어소사이어티”와 피연결“소프트엔지니어소사이어티” 간의 관계)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① 상위 “소프트엔지니어소사이어티”와 하위 “소프트엔지니어소사이어티”가
								하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결
								“소프트엔지니어소사이어티”(웹 사이트)이라고 하고 후자를 피연결 “소프트엔지니어소사이어티”(웹사이트)이라고 합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② 연결“소프트엔지니어소사이어티”는 피연결“소프트엔지니어소사이어티”가 독자적으로
								제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을
								연결“소프트엔지니어소사이어티”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증
								책임을 지지 않습니다.</li>
							<li>&nbsp;</li>
							<li>제22조(저작권의 귀속 및 이용제한)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티“이 작성한 저작물에 대한 저작권 기타 지적재산권은
								”소프트엔지니어소사이어티“에 귀속합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② 이용자는 “소프트엔지니어소사이어티”를 이용함으로써 얻은 정보 중
								“소프트엔지니어소사이어티”에게 지적재산권이 귀속된 정보를 “소프트엔지니어소사이어티”의 사전 승낙 없이 복제, 송신,
								출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”는 약정에 따라 이용자에게 귀속된 저작권을 사용하는
								경우 당해 이용자에게 통보하여야 합니다.</li>
							<li>&nbsp;</li>
							<li>제23조(분쟁해결)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”는 이용자가 제기하는 정당한 의견이나 불만을
								반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치․운영합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”는 이용자로부터 제출되는 불만사항 및 의견은
								우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해
								드립니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;③ “소프트엔지니어소사이어티”와 이용자 간에 발생한 전자상거래 분쟁과 관련하여
								이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수
								있습니다.</li>
							<li>&nbsp;</li>
							<li>제24조(재판권 및 준거법)</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;① “소프트엔지니어소사이어티”와 이용자 간에 발생한 전자상거래 분쟁에 관한
								소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다.
								다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에
								제기합니다.</li>
							<li>&nbsp;</li>
							<li>&nbsp;&nbsp;② “소프트엔지니어소사이어티”와 이용자 간에 제기된 전자상거래 소송에는 한국법을
								적용합니다.</li>
							<li>&nbsp;</li>
						</ul>
						인도하겠다는 피가 위하여 이것이다. 관현악이며, 새 생의 철환하였는가? 열매를 무엇을 천자만홍이 사막이다.
					</div>
					<div class="checkWrap">
						<label> <input type="checkbox" class="input check"
							name="agree"> 위 개인정보 처리방침에 동의합니다.(필수)
						</label>
					</div>
					</acrticle>

					<acrticle class="signUp-agree"> <header
						class="article-title">
						<div class="titleBar-hdr h4">개인정보처리방침</div>
						<!-- <h4 class="h4"></h4> -->
					</header>
					<div class="text-box">
						<ul style="list-style-type: none;">
							<li>(주)소프트엔지니어소사이어티(이하 ‘SES’라 한다)는 개인정보 보호법 제30조에 따라 정보주체의
								개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보
								처리지침을 수립&nbsp;&middot;&nbsp;공개합니다.</li>
							<li>&nbsp;</li>
							<li>제1조(개인정보의 처리목적) SES는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는
								개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에
								따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</li>
							<li>&nbsp;</li>
							<li>1. 홈페이지 회원 가입 및 관리</li>
							<li>회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별&nbsp;&middot;&nbsp;인증,
								회원자격 유지&nbsp;&middot;&nbsp;관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정이용
								방지, 만 14세 미만 아동의 개인정보 처리시 법정대리인의 동의여부 확인, 각종
								고지&nbsp;&middot;&nbsp;통지, 고충처리 등을 목적으로 개인정보를 처리합니다.</li>
							<li>2. 재화 또는 서비스 제공</li>
							<li>물품배송, 서비스 제공, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증,
								요금결제&nbsp;&middot;&nbsp;정산, 채권추심 등을 목적으로 개인정보를 처리합니다.</li>
							<li>3. 고충처리</li>
							<li>민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락&nbsp;&middot;&nbsp;통지,
								처리결과 통보 등의 목적으로 개인정보를 처리합니다.</li>
							<li>&nbsp;</li>
							<li>제2조(개인정보의 처리 및 보유기간) ① SES는 법령에 따른 개인정보
								보유&nbsp;&middot;&nbsp;이용기간 또는 정보주체로부터 개인정보를 수집시에 동의받은 개인정보
								보유&nbsp;&middot;&nbsp;이용기간 내에서 개인정보를
								처리&nbsp;&middot;&nbsp;보유합니다.</li>
							<li>&nbsp;</li>
							<li>② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.</li>
							<li>&nbsp;</li>
							<li>1. 홈페이지 회원 가입 및 관리 : SES 홈페이지 탈퇴시까지</li>
							<li>다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료시까지</li>
							<li>1) 관계 법령 위반에 따른 수사&nbsp;&middot;&nbsp;조사 등이 진행중인 경우에는 해당
								수사&nbsp;&middot;&nbsp;조사 종료시까지</li>
							<li>2) 홈페이지 이용에 따른 채권&nbsp;&middot;&nbsp;채무관계 잔존시에는 해당
								채권&nbsp;&middot;&nbsp;채무관계 정산시까지</li>
							<li>&nbsp;</li>
							<li>2. 재화 또는 서비스 제공 : 재화&nbsp;&middot;&nbsp;서비스 공급완료 및
								요금결제&nbsp;&middot;&nbsp;정산 완료시까지</li>
							<li>다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료시까지</li>
							<li>1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른
								표시&nbsp;&middot;&nbsp;광고, 계약내용 및 이행 등 거래에 관한 기록</li>
							<li>- 표시&nbsp;&middot;&nbsp;광고에 관한 기록 : 6월</li>
							<li>- 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년</li>
							<li>- 소비자 불만 또는 분쟁처리에 관한 기록 : 3년</li>
							<li>2)「통신비밀보호법」제41조에 따른 통신사실확인자료 보관</li>
							<li>- 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월</li>
							<li>&nbsp;</li>
							<li>제3조(개인정보의 제3자 제공) ① SES는 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서
								명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조에 해당하는
								경우에만 개인정보를 제3자에게 제공합니다.</li>
							<li>② SES는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.</li>
							<li>- 개인정보를 제공받는 자 : (주) 디지틀조선</li>
							<li>- 제공받는 자의 개인정보 이용목적 : 모의토플 시험 응시</li>
							<li>- 제공하는 개인정보 항목 : 성명, 생년월일</li>
							<li>- 제공받는 자의 보유&nbsp;&middot;&nbsp;이용기간 : 결제일로부터 1년</li>
							<li>&nbsp;</li>
							<li>제4조(정보주체의 권리&nbsp;&middot;&nbsp;의무 및 행사방법) ① 정보주체는 SES에
								대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.</li>
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
							<li>&nbsp;&middot;&nbsp;필수항목 : 성명, 생년월일, 아이디, 비밀번호, 전화번호,
								성별, 이메일주소</li>
							<li>&nbsp;</li>
							<li>2. 재화 또는 서비스 제공</li>
							<li>&nbsp;&middot;&nbsp;필수항목 : 성명, 생년월일, 아이디, 비밀번호, 주소,
								전화번호, 이메일주소, 신용카드번호, 은행계좌정보 등 결제정보</li>
							<li>&nbsp;&middot;&nbsp;선택항목 : 과거 구매내역</li>
							<li>&nbsp;</li>
							<li>3. 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.</li>
							<li>&nbsp;&middot;&nbsp;IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량
								이용기록 등</li>
							<li>&nbsp;</li>
							<li>제6조(개인정보의 파기) ① SES는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가
								불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.</li>
							<li>② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른
								법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나
								보관장소를 달리하여 보존합니다.</li>
							<li>③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.</li>
							<li>1. 파기절차</li>
							<li>SES는 파기 사유가 발생한 개인정보를 선정하고, SES의 개인정보 보호책임자의 승인을 받아
								개인정보를 파기합니다.</li>
							<li>2. 파기방법</li>
							<li>SES는 전자적 파일 형태로 기록&nbsp;&middot;&nbsp;저장된 개인정보는 기록을 재생할
								수 없도록 로우레밸포멧(Low Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에
								기록&nbsp;&middot;&nbsp;저장된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.</li>
							<li>&nbsp;</li>
							<li>제7조(개인정보의 안전성 확보조치) SES는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고
								있습니다.</li>
							<li>1. 관리적 조치 : 내부관리계획 수립&nbsp;&middot;&nbsp;시행, 정기적 직원 교육 등</li>
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
							<li>▶ 개인정보 열람청구 접수&nbsp;&middot;&nbsp;처리 부서</li>
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
					</div>
					<div class="checkWrap">
						<label> <input type="checkbox" class="check input"
							name="agree"> 위 서비스 이용방침에 동의합니다.(필수)
						</label>
					</div>
					</acrticle>

					<div class="checkWrap all-check">
						<label> <input type="checkbox" class="check-all input"
							name="agreeAll"> 위의 모든 약관 내용을 확인하였으며 이에 동의합니다.
						</label>
					</div>

					<div class="certificationWrap">
						<header class="header">
							<strong class="h4"> 두잇캠퍼스에서는 깨끗하고 안전한 인터넷 서비스 이용을 위해
								본인확인을 받고 있습니다. </strong>
							<h5 class="fz14">
								입력하신 개인정보는 회원님의 동의 없이 제 3자에게 제공되지 않으며, 개인정보처리방치에 따라 보호되고 있습니다. <br>입력하신
								정보는 본인확인용으로 사용되며 회원가입이 완료되면 사용자 확인을 위해 회원정보 고유의 값으로 저장됩니다.<br>
								<br>아래 본인인증 모듈은 NICE평가정보의 본인확인 모듈을 사용합니다.<br>정상적인
								주민등록번호를 입력했거나 실명확인에 문제가 있는 경우, NICE신용평가정보에 문의하시기 바랍니다.
							</h5>
						</header>
						<div class="certif-boxWrap d-flex">
							<!-- <div class="certif certif01">
                                    	<h3 class="h3">아이핀인증</h3>
                                    	<p class="c666">아이핀으로 본인확인을 합니다.<br>&nbsp;</p>
                                    	<button class="button enter-btn btn-bk" type="button" onclick="location.href=''">인증하기</button>
                                	</div> -->
							<div class="certif">
								<h3 class="h3 fc_orD">휴대폰인증</h3>
								<p class="c666">
									본인 명의의 휴대폰 번호로 인증합니다. 타인 명의의 휴대폰은 인증이 불가합니다.<br>본인인증으로 가입여부를 확인 후 신청이 가능합니다.
								</p>
								<button class="btn_normal btn_orangeD btn_medium" type="button"
									onclick="javascript:popIdentity('phone');">인증하기</button>
								<div>
									<font id="redMessage" color="red"></font><br>
								</div>
								<!--  <form name="reqDRMOKForm" method="post"> -->
								<input type="hidden" name="req_info" value="${encReqInfo}">
								<input type="hidden" name="rtn_url" value="#"> <input
									type="hidden" name="cpid" value="${cpId}"> <input
									type="hidden" name="newpop" value="Y"> <input
									type="hidden" id="user_phone" name="phone" value=""> <input
									type="hidden" id="user_nm" name="name" value=""> <input
									type="hidden" id="birth_year" name="birth_year" value="">
								<input type="hidden" id="birth_month" name="birth_month"
									value=""> <input type="hidden" id="birth_date"
									name="birth_date" value=""> <input type="hidden"
									id="user_sex" name="gender" value=""> <input
									type="hidden" id="veriCi" name="veriCi" value=""> <input
									type="hidden" id="veriDi" name="veriDi" value=""> <input
									type="hidden" id="veriPhone" name="veriPhone" value="">
								<input type="hidden" id="veriCom" name="veriCom" value="">
								<input type="hidden" id="veriBirth" name="veriBirth" value="">
								<input type="hidden" id="veriGender" name="veriGender" value="">
								<input type="hidden" id="veriNation" name="veriNation" value="">
								<input type="hidden" id="veriName" name="veriName" value="">
								<input type="hidden" id="veriNum" name="veriNum" value="">
								<input type="hidden" id="veriTime" name="veriTime" value="">
								<!-- </form> -->
							</div>
						</div>
						<!-- <ul class="certification-notice">
							<li class="c999">- 본인인증으로 가입여부를 확인 후 신청이 가능합니다.</li>
							<li class="c999">- 입력하신 정보는 본인확인용으로 사용되며 회원가입이 완료되면 사용자 확인을
								위해 회원정보 고유의 값으로 저장됩니다.</li>
							<li class="c999">- 정상적인 주민등록번호를 입력했거나 실명확인에 문제가 있는 경우,
								NICE신용평가정보에 문의하시기 바랍니다.</li>
						</ul> -->
					</div>
					</acrticle>
				</form>
				<!-- 임시버튼 : 본인인증 완료후 자동으로 다음단계로 넘어갑니다. -->
				<button class="button btn-bk btn-next" type="submit" id="goSubmit">다음단계</button>
			</div>
		</div>

	</div>

	<!-- footer-include -->
	<%@include file="../common_footer_doitcam.jsp"%>
</body>

</html>
