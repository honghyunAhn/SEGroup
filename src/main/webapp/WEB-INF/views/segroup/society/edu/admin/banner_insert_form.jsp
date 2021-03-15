<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">

<!-- 페이징관련 css 시작 -->
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
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
<!-- 페이징 관련 css 끝 -->

<style>

div.custom_div {
	text-align: center;
	margin-left: 330px;
	margin-right: 330px;
}

.banner_submit {
	color: white;
	font-weight: bold;
	font-size: 120%;
	background-color: #3af;
	border: none;
	padding: 5px;
	width: 180px;
	height: 50px;
	margin-top: 15px;
	margin-bottom: 30px;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
	
	$(function() {

		minMax("edu_ban_st", "edu_ban_et");
		$("#edu_ban_link").val($('#link').val());
		
		readOnlyCheckGisuNm();
		readOnlyCheckLink();

	});
	
	function readOnlyCheckGisuNm() {
		var selectedId_gisuNm = $('#curriculum option:selected').attr("id");
		
		if(selectedId_gisuNm == 'directInputGisuNm'){
			$("#edu_ban_nm").attr("readonly", false);
		}else{
			$("#edu_ban_nm").attr("readonly", true);
		}
	}
	
	function readOnlyCheckLink() {
		var selectedId_link = $('#link option:selected').attr("id");
		
		if(selectedId_link == 'directInputLink'){
			$("#edu_ban_link").attr("readonly", false);
		}else{
			$("#edu_ban_link").attr("readonly", true);
		}
	}

	function getThumbnailPrivew(input, targetId) {
		// 필드 채워지면
		if ($(input).val() != "") {
			// 확장자 체크
			var ext = $(input).val().split(".").pop().toLowerCase();
			if ($.inArray(ext, [ "bmp", "gif", "jpg", "jpeg", "png" ]) == -1) {
				alert("bmp, gif, jpg, jpeg, png 파일만 업로드 해주세요.");
				$(input).val("");
				return;
			}
			// 용량 체크
			var fileSize = input.files[0].size;
			var maxSize = 1024 * 1024 * 10;
			if (fileSize > maxSize) {
				alert("파일용량 1MB을 초과했습니다.");
				$(input).val("");
			}
			// 가로,세로 길이
			var file = input.files[0];
			var _URL = window.URL || window.webkitURL;
			var img = new Image();
			img.src = _URL.createObjectURL(file);
			img.onload = function() {
				$(input).closest("td").children("p").remove();
				//                 $(input).next().next().next().remove();
				var add_tag = "<p name='tmp_"+targetId+"'>" + img.width + " x "
						+ img.height + "</p>"
				$(input).closest("td").append(add_tag);
			}
		}
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				var element = window.document.getElementById(targetId);
				element.setAttribute("src", e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	function formCheck() {
		var edu_ban_nm = $("#edu_sub_ban_nm");
		var edu_ban_link = $("#edu_sub_ban_link");
		var edu_ban_file = $("#edu_sub_ban_file")[0].files;
		
		if (edu_ban_nm.val() == '') {
			alert('과정명를 입력해 주시기 바랍니다.');
			selectAndFocus(edu_ban_nm);
			return false;
		}
		if (edu_ban_link.val() == '') {
			alert('링크를 입력해 주시기 바랍니다.');
			selectAndFocus(edu_ban_link);
			return false;
		}
		if (edu_ban_file.length == 0) {
			alert("과정아이콘 이미지를 등록해 주세요.")
			return false;
		}

		// 과거날짜 선택불가와 날짜형식 확인체크
// 		var today = new Date();
// 		var dd = today.getDate();
// 		var mm = today.getMonth() + 1; //January is 0!
// 		var yyyy = today.getFullYear();
// 		if (dd < 10) {
// 			dd = '0' + dd
// 		}
// 		if (mm < 10) {
// 			mm = '0' + mm
// 		}
// 		today = yyyy + mm + dd;

// 		if (today > gisu_app_st.val().replace(/\-/g, '')) {
// 			alert('과거는 선택하실 수 없습니다');
// 			selectAndFocus(gisu_app_st);
// 			return false;
// 		}
// 		if (today > gisu_app_et.val().replace(/\-/g, '')) {
// 			alert('과거는 선택하실 수 없습니다');
// 			selectAndFocus(gisu_app_et);
// 			return false;
// 		}
// 		if (today > gisu_crc_st.val().replace(/\-/g, '')) {
// 			alert('과거는 선택하실 수 없습니다');
// 			selectAndFocus(gisu_crc_st);
// 			return false;
// 		}
// 		if (today > gisu_crc_et.val().replace(/\-/g, '')) {
// 			alert('과거는 선택하실 수 없습니다');
// 			selectAndFocus(gisu_crc_et);
// 			return false;
// 		}
	}

	/**
	 * 엘리먼트를 선택한다
	 */
	function selectAndFocus(element) {
		element.select();
		element.focus();
	}

	function reset_img(input, img_name, taget_img_id) {
		// 	alert($(input).parents("div")+"\n"+img_name+"\n"+taget_img_id);
		$(input).closest("td").append("<div>");
		$(input).closest("td").children("div").append($('<input/>', {
			type : 'file',
			name : img_name,
			id : img_name,
			accept : '.bmp, .gif, .jpg, .png',
			onchange : 'getThumbnailPrivew(this, "' + taget_img_id + '");'
		}));
		$(input).closest("td").children("div").append("<br />");
		$(input).closest("td").children("div").append($('<img/>', {
			id : taget_img_id,
			style : 'border: 1px solid black'
		}));
		$(input).closest("td").children("div").append("<br />");
		$(input).closest("td").append("</div>");
		$(input).closest("div").remove();
	}
	
</script>
</head>
<body ng-app="myapp" ng-controller="SocietyEduAdminViewController">
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>SMART Cloud IT 메인 화면 관리</h2>
		<h5>
			<a href="banner_manager_form">배너 관리 페이지</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;배너
			등록
		</h5>
	</div>
	
	<div class="custom_div">
		<form action="/edu/admin/banner_insert"
			onsubmit="return formCheck();" enctype="multipart/form-data"
			method="post">
            
			<table class="gisu_crc_table">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="name">입력 항목</th>
						<th scope="col">내 용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="name">과정명
							<select id="curriculum">
							<c:forEach var="data" items="${curriculum_nm_list}" varStatus="status">
								<option id="${data}" value="${data}">${data}</option>
							</c:forEach>
								<option id="directInputGisuNm" value="">직접 입력</option>
							</select></td>
						<td>
							<input type="text" value="${curriculum_nm_list.get(0)}" name="edu_ban_nm" id="edu_ban_nm"maxlength="100" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td class="name">링크
						<select id="link">
							<option id="seoul" value="https://www.softsociety.net/edu/apply/scitmaster_seoul">SC IT마스터(서울)</option>
							<option id="gwangju" value="https://www.softsociety.net/edu/apply/kmove">SW DevOps마스터 1기(광주)</option>
							<option id="beforehandEducation" value="http://newtradecampus.kita.net/page/user_job_CloudIT_home">사전학습반</option>
							<option id="directInputLink" value="">직접 입력</option>
						</select></td>
						<td><input type="text" value="" name="edu_ban_link" id="edu_ban_link" readonly="readonly"></td>
					</tr>
					<tr>
                    <td class="name">배너 등록 이미지</td>
                    <td>
                        <input type="file" name="edu_ban_file" id="edu_ban_file"
                        accept=".bmp, .gif, .jpg, .png" onchange="getThumbnailPrivew(this, 'avatar_info_image1');">
                        <img alt="배너 등록 이미지 미리보기" src="/image/user-empty.png" id="avatar_info_image1" style="border: 1px solid black"/><br/>
                    </td>
                	</tr>
			</table>
			
			<input class="banner_submit" type="submit" value="등록하기">
		</form>
	</div>
	
	<script type="text/javascript">
	
	$("#curriculum").change(changeCurriculum);
	function changeCurriculum(){
		$("#edu_ban_nm").val($('#curriculum').val());
		readOnlyCheckGisuNm();
	}
	
	$("#link").change(changeLink);
	function changeLink(){
		$("#edu_ban_link").val($('#link').val());
		readOnlyCheckLink();
	}
	</script>
	
</body>
</html>
