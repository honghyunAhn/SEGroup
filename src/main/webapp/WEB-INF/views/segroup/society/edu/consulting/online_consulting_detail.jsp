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
<script src="https://code.jquery.com/jquery-latest.js"></script>
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

<style>
.sub_top_img {
	width: 984px;
	height: 300px;
}

body .info1 {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width: 500px;
	height: 50px;
}

#page a {
	display: inline;
}

.center-cropped {
	object-fit: cover; /* Do not scale the image */
	object-position: center; /* Center the image within the element */
	height: 190px;
	width: 341px;
}

#boardContent {
	text-align: initial;
	padding-left: 50px;
}

.top_img {
    position: relative;
    background-image: url(/resources/segroup/society/edu/image/main/top_img/top_img_online.jpg);                                                               
    height: 250px;
    background-size: cover;
}
</style>
<script>

$(document).ready(function(){
    $("#btnUpdate").click(function(){
    	$("#onlineUdtHiddenForm").submit();
    });
    
    $("#btnDelete").click(function(){
    	var check = confirm("정말로 삭제하시겠습니까?");
		if(check){
    	ajaxSubmit();
		}
    });
});

$(function () {
	var consulting_ins_id = '${boardDetail.consulting_ins_id}'
	var consulting_open = '${boardDetail.consulting_open}'
	if(consulting_ins_id != '${consulting_ins_id}' & consulting_open == 1){
		alert("비공개 글 입니다.");
		goToList();
	}
});

function close_deny(){
	
}

/**
 * 서버에 온라인상담 취소(삭제) 서비스 요청
 */
function ajaxSubmit(){
//		alert("Ajax 신청서비스 들어가기 전~!");
    $.LoadingOverlay("show");
        
	var formData = $("#onlineDelHiddenForm").serialize();
    $.ajax({
    	type: "POST",
        url: '<c:url value="/edu/consulting/apply_online_del" />',
        data: formData,
        success: function(isRequested) {
            $.LoadingOverlay("hide");
                
            if (isRequested) {
                alert('온라인상담 삭제가 완료되었습니다.');
                location.href = "<c:url value='/edu/consulting/online_consulting' />";
            } else {
                alert('서버에 에러가 발생했습니다. 재시도 후에도 에러발생시 홈페이지 담당자에게 문의해주십시요.');
            }
        },
        error: function(e) {
            alert('서버에 에러가 발생했습니다. 재시도 후에도 에러발생시 홈페이지 담당자에게 문의해주십시요.');
        }
    });
}

function goToList(){
	location.href="/edu/consulting/online_consulting.do";
}

</script>
</head>
<body>
	<%@include file="../menu.jsp"%>
    <div class="top_img">
        <div class="top_img_text">
            <p class="top_img_text1">온라인상담 QnA</p>
            <p class="top_img_text2">궁금한 것이 있다면 뭐든지 물어보세요!</p>
        </div>
    </div>

    <div style="overflow: hidden; width: 100%; height: 50px;"></div>
	<c:if test="${boardDetail.consulting_ins_id != consulting_ins_id and boardDetail.consulting_open == 1}">
		<div class="main_m_contents">
			<div class="main_notice_wrap1">
				<div>
					<h1>잘못 된 접근입니다.</h1>
				</div>
				<br><br><br><br><br><br><br><br><br><br>
				<br><br><br><br><br><br><br><br><br><br>
				<br><br><br><br><br><br><br><br><br><br>
			</div>
		</div>
    </c:if>
    <c:if test="${boardDetail.consulting_ins_id == consulting_ins_id or boardDetail.consulting_open == 0}">
	<div class="main_m_contents">
		<div class="main_notice_wrap1">	
<!-- 			<div class="main_notice_title1"> -->
<!-- 				<h1>온라인상담</h1> -->
<!-- 			</div> -->
			<hr>

			<%-- ${status.count } --%>
			<header style="background: #f5f5f5;">
				<h2 style="padding: 20px;">${boardDetail.consulting_title}</h2>
			</header>
			<hr>
			<br> <span style="display: inline; text-align: right;">

					<h5>
						<span style="padding-right: 20px;"> 게시자 :
							${boardDetail.consulting_udt_id } </span><span
							style="padding-right: 20px;"> 날짜 :
							${boardDetail.consulting_udt_dt } </span><span
							style="padding-right: 20px;"> 조회수 :
							${boardDetail.consulting_hit } </span>
					</h5>

			</span> <br> <span class="imageContent">
				${boardDetail.consulting_ct }
			</span> <br>
			<br>
			<hr>
			<br> <br>
			<header style="background: #f5f5f5;">
				<h2 style="padding: 20px;">답변</h2>
			</header>
			<c:if test="${boardDetail.re_ins_id == null }">
				<hr>
				<br>
				<span class="imageContent">아직 답변이 등록되지 않았습니다.</span>
				<hr>
				<br>
			</c:if>
			<c:if test="${boardDetail.re_ins_id != null }">
				<hr>
				<br>
				<span style="display: inline; text-align: right;">

					<div>
						<h5>
							<span style="padding-right: 20px;"> 답변자 :
								${boardDetail.re_udt_id } </span><span style="padding-right: 20px;">
								답변날짜 : ${boardDetail.re_udt_dt } </span>
						</h5>
					</div>

				</span>
				<br>
				<br>
				<span class="imageContent"> ${boardDetail.re_ct } </span>
				<br>
				<br>
				<hr>
				<br>
			</c:if>

			<div class="gal_last">
				<div class="gal_write">
					<span style="width: 100%;"> <c:if
							test="${boardDetail.consulting_ins_id == consulting_ins_id}">
							<input type="button" id="btnUpdate" name="btnUpdate" value="수정하기">
							<input type="button" id="btnDelete" name="btnDelete" value="삭제하기">
						</c:if> <input type="button" onclick="goToList()" name="" value="목록">
					</span>
				</div>
			</div>
		</div>
	</div>

	<form action="/edu/consulting/online_consulting_update_form.do"
		id="onlineUdtHiddenForm" method="get">
		<input type="hidden" name="consulting_udt_id" id="consulting_udt_id"
			value="${onlineConsultingContents.consulting_udt_id}" /> <input
			type="hidden" name="consulting_seq"
			value="${boardDetail.consulting_seq }" />
	</form>
	<form action="/edu/consulting/apply_online_del"
		id="onlineDelHiddenForm" method="post">
            <input type="hidden" name="consulting_seq" value="${boardDetail.consulting_seq }" />
            <input type="hidden" name="consulting_udt_id" value="${boardDetail.consulting_udt_id }" />
            <input type="hidden" name="consulting_title" value="${boardDetail.consulting_title }" />
			<input type="hidden" name="consulting_ct" value="${boardDetail.consulting_ct }" />
		</form>
	</c:if>

	<%@include file="../footer.jsp"%>
</body>
</html>