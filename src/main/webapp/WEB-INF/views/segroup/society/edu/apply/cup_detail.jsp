<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<!-- 
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " /> -->
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
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
</head>
<style>
.w2 {
	font-size: 20px;
	font: bold;
	width: 20%;
	float: left;
}

.w8 {
	font-size: 20px;
	font: bold;
	width: 79%;
	float: left;
}

.w3 {
	width: 30%;
	float: left;
}

.w7 {
	width: 70%;
	float: right;
}

.linner {
	overflow: hidden;
	width: 100%;
	height: 10px;
}
</style>
<script type="text/javascript">
	$(function() {
		
		
		// 날짜의 특수기호 하이푼(-)을 콤마(.)로 치환 후, 해당 ID 위치에 설정
		var gisu_app_st = '${seaCurGisu.gisu_app_st }'.replace(/\-/gi, ".");
		var gisu_app_et = '${seaCurGisu.gisu_app_et }'.replace(/\-/gi, ".");
		var gisu_crc_st = '${seaCurGisu.gisu_crc_st }'.replace(/\-/gi, ".");
		var gisu_crc_et = '${seaCurGisu.gisu_crc_et }'.replace(/\-/gi, ".");
		$('#apply_days').html(gisu_app_st + " ~ " + gisu_app_et);
		$('#edu_days').html(gisu_crc_st + " ~ " + gisu_crc_et);
	});
	
	$(function() {
        $(window).scroll(function() {
        	if ($(this).scrollTop() > 10) {
                $('#MOVE_TOP_BTN').fadeIn();
            } else {
                $('#MOVE_TOP_BTN').fadeOut();
            }
        });
        
        $("#MOVE_TOP_BTN").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 400);
            return false;
        });
    });
	function short_pay(seq,amount,nm){
		$("#pay_seq").val(seq);
		$("#price").val(amount);
		$("#goodname").val(nm)
		$("#userPayInfoForm").submit();
	}
</script>
<body>
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none"><img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기"></a>
    <img
        src="<c:url value="/resources/segroup/society/edu/image/sub/images/sub_top_img.png" />"
        alt="sub_top_img" height="250px" width="100%" />

    <div style="overflow: hidden; width: 100%; height: 50px;"></div>

	<div class="sub_m_contents">
		<div class="main_top_slidewrap">

			<div class="w3">
				<%-- <img
					src="/file_download?origin=&saved=${seaCurGisu.gisu_crc_icon02 }&path=${path }"
					style="height: 260px; width: 260px;" /> --%>
			</div>

			<div class="w7">
				<div
					style="font-size: 30px; font: bold; padding-left: 0px; padding-bottom: 10px;">${seaCurGisu.gisu_crc_nm }</div>
				<div style="border: 2px solid black; padding: 10px 0px 0px 10px;">
					<div class="w2">신청기간</div>
					<div class="w8">
						<div id="apply_days"></div>
					</div>
					<div class="linner"></div>
					<div class="w2">교육기간</div>
					<div class="w8">
						<div id="edu_days"></div>
					</div>
					<div class="linner"></div>
					<div class="w2">교육시간</div>
					<div class="w8">${seaCurGisu.gisu_crc_month }개월
						${seaCurGisu.gisu_crc_days }일(${seaCurGisu.gisu_crc_times }시간)</div>
					<div class="linner"></div>
					<div class="w2">교육비</div>
					<div class="w8">
						<fmt:formatNumber value="${seaCurGisu.gisu_crc_pay }"
							pattern="#,###" />원
					</div>
					<div class="linner"></div>
					<div class="w2">정원</div>
					<div class="w8">${seaCurGisu.gisu_crc_personnel }명</div>
					<div class="linner"></div>
					<div class="w2">장소</div>
					<div class="w8">${seaCurGisu.gisu_crc_location }</div>
                    <div class="linner"></div>
				</div>
			</div>
                    <div class="linner"></div>
			<input type="button" class="confirms_btn" value="수강신청하기" onclick="short_pay(${SEAPayInfo.seq},${seaCurGisu.gisu_crc_pay},'${seaCurGisu.gisu_crc_nm}')" >
			<div class="linner"></div>

			<%-- <div class="master_bottom_menu_five">
				<ul>
					<li class="choice_menu mbm1"><a href="#fe_01">과정개요</a></li>
					<li class="mbm2"><a href="#fe_02">커리큘럼</a></li>
					<li class="mbm3"><a href="#fe_03">강사진</a></li>
					<li class="mbm4"><a href="#fe_04">교육장소</a></li>
					<li class="mbm5"><a href="#fe_05">수강문의</a></li>
				</ul>
			</div>

			<p id="fe_01">과정개요</p>
			<img
				src="/file_download?origin=&saved=${seaCurGisu.gisu_crc_infoimg01 }&path=${path }" />
			<p id="fe_02">커리큘럼</p>
			<img
				src="/file_download?origin=&saved=${seaCurGisu.gisu_crc_infoimg02 }&path=${path }" />
			<p id="fe_03">강사진</p>
			<img
				src="/file_download?origin=&saved=${seaCurGisu.gisu_crc_infoimg03 }&path=${path }" />
			<p id="fe_04">교육장소</p>
			<img
				src="/file_download?origin=&saved=${seaCurGisu.gisu_crc_infoimg04 }&path=${path }" />
			<p id="fe_05">수강문의</p>
			<img
				src="/file_download?origin=&saved=${seaCurGisu.gisu_crc_infoimg05 }&path=${path }" />
			<div class="linner"></div>
			<div style="float: right; margin: 30px;">
				<input type="button" class="confirms_btn" value="수강신청하기">
			</div> --%>
		</div>
	</div>
<form id="userPayInfoForm" method="post" action="/edu/user/user_pay_ini">
		<input type="hidden" value="" name="price" id="price">
		<input type="hidden" value="" name="goodname" id="goodname">
		<input type="hidden" value="" name="pay_seq" id="pay_seq">
		<input type="hidden" value="" name="pay_from" id="pay_from">
		<input type="hidden" value="" name="pay_to" id="pay_to">
	</form>
	<%@include file="../footer.jsp"%>
</body>
</html>