<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(document).ready(function(){
	$(".btnCloseExamHall").click(function(event){
		popupClose("popOfflineExamHall");
	});

	$(".btnSaveExamSpot").click(function(event){
		saveExamSpot();
	});
});

function showExamSpot() {
	var params = $("#spotForm").serialize();
	$.ajax({
		url:'selectExamSpotAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data) {
			if (data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var examInfo = data.examInfo;
			$("#popOfflineExamHall input[name='quiz']").val(examInfo.ID);
			$("#popOfflineExamHall input[name='exam_period']").val(examInfo.EXAM_PERIOD);
			$("#popOfflineExamHall #examDate").text(examInfo.DESC_ATT_EVAL_DATE);
			$("#popOfflineExamHall #examDateWeek").text(examInfo.DESC_ATT_EVAL_DATE_WEEK);
			$("#popOfflineExamHall #examTime").text(examInfo.EXAM_PERIOD + "교시 (" +  examInfo.EXAM_TIME + "분)");

			var reportInfo = data.reportInfo;
			if(reportInfo != null) $("#popOfflineExamHall input[name='report']").val(reportInfo.ID);

			var spotList = data.spotList;
		 	var html = '';
		 	for (var i = 0; i < spotList.length; i++) {
				var spot = spotList[i];
				html += '<tr>';
				html += '<td class="item-title nth-1st">';
				html += '<label><input type="radio" name="hall_id" value="'+spot.ID+'"></label></td>';
				html += '<td class="item-title"><strong>'+spot.SPOT+'</strong></td>';
				html += '<td class="item-local">'+spot.NAME+'</td>';
				html += '<td class="item-address">'+spot.ADDR1  + ' ' + spot.ADDR2+'</td>';
				html += '<td class="item-tel">'+spot.TEL+'</td>';
				html += '<td class="item-function"><a class="btn primary" href="'+spot.MAP_URL_PATH+'" target="_blank">보기</a></td>';
				html += '</tr>';
			}
			$("#examlist-body").empty().append(html);

			popupOpen('popOfflineExamHall');
		},
		error:function(e) {
			alert("출석 고사장 정보 조회시 문제가 발생했습니다.");
		}
	});
}

function saveExamSpot() {
	if (!$("input[name='hall_id']:checked").val()) {
		alert("고사장을 선택하여 주십시오.");
		return;
	}
/*
	if (!$("input[name='userfile']").val()) {
		alert("사진을 등록하셔야 합니다.");
		return;
	} */

	var formData = $("#spotForm").serialize();
	//var formData = new FormData($('#spotForm')[0]);
	//formData.append("폼요소",  "폼값");

	$.ajax({
		url:'saveExamSpotAjax',
		type:'POST',
		data:formData,
		dataType:'json',
		/* processData: false,
    contentType: false, */
		success:function(data) {
			if(data.result == "SUCCESS") {
				alert("고사장 지정이 완료되었습니다.");
				location.reload();
			} else {
				alert("고사장 지정시 문제가 발생했습니다.");
				location.reload();
			}
		},
		error:function(e) {
			alert("고사장 지정시 문제가 발생했습니다.");
		}
	});
}
</script>
<div class="cl-popup-overlay" id="popOfflineExamHall">
	<div class="cl-popup-wrap">
			<c:choose>
				<c:when test="${currentDevice.mobile }">
			<div class="cl-popup-box full">
				</c:when>
				<c:otherwise>
			<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
				</c:otherwise>
			</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">출석 고사 안내 및 출석 고사장 지정</h3>
			</div>
			<div class="popup-body">
				<form  name="spotForm" id="spotForm" enctype="multipart/form-data">
					<input type="hidden" name="id" value="${classParam.id }">
					<input type="hidden" name="cardinal" value="${classParam.cardinal }">
					<input type="hidden" name="course" value="${classParam.course }">
					<input type="hidden" name="exam_period">
					<input type="hidden" name="quiz">
					<input type="hidden" name="report">

					<ul class="notice-list section">
						<li>
							<em class="label">시험 일시: </em>
							<span id="examDate"></span><span id="examDateWeek"></span>
						</li>
						<li>
							<em class="label">시험 시간: </em>
							<span id="examTime"></span>
						</li>
					</ul>
					<table id="examHall-list" class="list section">
						<colgroup>
							<col width="50">
							<col width="150">
							<col width="150">
							<col width="">
							<col width="110">
							<col width="70">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="item-check nth-1st">선택</th>
								<th scope="col" class="item-title">고사장명</th>
								<th scope="col" class="item-local">지역</th>
								<th scope="col" class="item-address">주소</th>
								<th scope="col" class="item-tel">전화번호</th>
								<th scope="col" class="item-function">약도</th>
							</tr>
						</thead>
						<tbody id="examlist-body">
							<!-- <tr>
								<td colspan="2" class="item-title nth-1st">
									<label><input type="radio" name="exam-hall"><strong>홍천여고</strong></label>
								</td>테이블인 경우 셀병합으로 인해 첫번째 칸이 첫칸이 아닐 수 있으므로 클래스로 첫칸 구분
								<td class="item-local">강원(정선,사북,춘천)</td>
								<td class="item-address">강원 정선군 사북읍</td>
								<td class="item-tel">033-112-1111</td>
								<td class="item-function"><a class="btn primary">보기</a></td>
							</tr> -->
						</tbody>
					</table>

					<!-- <dl>
						<dt>사진 첨부</dt>
						<dd><input type="file"  id="userfile" name="userfile" accept=".jpg, .png, .jpeg"><span>※ 200*240</span></dd>
					</dl> -->

					<div class="list-bottom alignC">
						<a href="#" class="btn primary w12em btnSaveExamSpot">선택완료(고사장지정)</a>
						<a href="#" class="btn w12em btnCloseExamHall">닫기</a>
					</div>
				</form>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>