<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/smp/css/noticeBoard.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/smp/css/boardStyle.css" />">

<jsp:include page="../import.jsp" flush="true" />

<title>aps</title>

<script type="text/javascript">

function totalOverlap() {
	var gisu = $("#gisu_seq_select").val();
	var total_nm=$("#smp_aps_total_nm").val();
	var can;
	$.ajax({
		type : "POST",
		url : "/ajaxTotalOverlab",
		dataType : 'text',
		data : {
			'gisu_seq' : gisu,
			'smp_aps_total_nm': total_nm
		},
		success : function(data) {
			can=data;
			if(can != "canInsert"){		
				alert("평가종합 이름이 중복되었습니다.");
			}else{
				$("#totalInsert").submit();
			}
		},
		error : function() {
			alert("error");
		}
		});
	}	
	$(function() {
		
		//목록으로
		$("#goListBtn").on("click", function() {
			$("#goList").submit();
		});
		
		//등록하기
		$("#totalInsertBtn").on("click", function() {
			var smp_aps_total_nm = $("#smp_aps_total_nm").val();
			var smp_aps_total_ratio = $("#smp_aps_total_ratio").val();
			var gisu_seq_msg = $("#gisu_seq_select option:selected").val();
			if (gisu_seq_msg == "0"){
				alert("기수를 선택해주세요");
				return ;
			}
			if(smp_aps_total_nm == "") {
				alert("평가종합 이름을 입력해주세요");
				return;
			}

			if(smp_aps_total_ratio == "") {
				alert("평가종합 비율을 입력해주세요");
				return;
			}
			if(parseInt(smp_aps_total_ratio)<parseInt(0) || parseInt(smp_aps_total_ratio)>parseInt($('#smp_aps_total_ratio').attr('max'))){
				alert('올바른 비율값을 입력해주세요');
				return;
			}
			totalOverlap();

		});
		 //처음 페이지 들때 기수시퀀스 설정
		//var gi = ${gisuList[0].gisu_seq};
		//$("#gisu_seq").val(gi);

		$('select[id="gisu_seq_select"]').on('change', function() {
			$("#gisu_seq").val($('select[id="gisu_seq_select"]').val());
			//남은 비율 
			var gisu_seq = $("#gisu_seq_select").val();
			$.ajax({
				type : "POST",
				url : "/ajaxSumTotalRatio",
				dataType : 'text',
				data : {
					'gisu_seq' : gisu_seq
				},
				success : function(data) {
					var remainR=(100-data);
					var sumR = "남은 비율 : "+remainR+"%";
					$("#sumTR").html(sumR);
					$('#smp_aps_total_ratio').prop("max", remainR);
				},
				error : function() {
					alert("error");
				}
				}); 
			
		});

	})

</script>
<style type="text/css">
p {
	word-break: pre-wrap;
}
</style>
</head>
<body id="myBody">
	<div id="page">
		<div class="page-inner">
			<%@include file="adminmenu.jsp"%>
			<div class="gtco-section border-bottom">
				<div class="gtco-container">

					<div class="page_title">
						<h2 class="aps_h">평가종합 등록 페이지</h2>
					</div>
					<form id="totalInsert" action="/smp/admin/aps_total_insert"
						method="post" enctype="multipart/form-data">
						<input type="hidden" name="gisu_seq" id="gisu_seq">
						<table class="table_view">
							<colgroup>
								<col width="30%" />
								<col width="70%" />
							</colgroup>
							<tbody>
								<tr>
									<th>기수</th>
									<td><select name="gisu_seq_select" id="gisu_seq_select">
											<option value="0">선택</option>
											<c:forEach var="data" items="${seaCurList}">
												<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>평가종합 이름</th>
									<td><input type="text" name="smp_aps_total_nm"
										id="smp_aps_total_nm"></td>
								</tr>
								<tr>
									<th>평가종합 비율</th>
									<td><input type="number" name="smp_aps_total_ratio"
										id="smp_aps_total_ratio" min="0" max="0" onkeypress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">(%)
									<p id="sumTR" style="width:auto;" >기수를 먼저 선택하세요</p>
									</td>
								</tr>
								<tr>
									<th>평가종합 내용</th>
									<td><textarea name="smp_aps_total_ct"
											id="smp_aps_total_ct"></textarea></td>
								</tr>
							</tbody>
						</table>
						<div class="btnManagerDiv">
							<input type="button" id="totalInsertBtn" value="등록하기" /> <input
								type="button" id="goListBtn" value="목록으로" />
						</div>
					</form>
					<form action="/smp/admin/aps_total" id="goList" method="get">

					</form>


				</div>
			</div>
		</div>
	</div>
</body>
</html>