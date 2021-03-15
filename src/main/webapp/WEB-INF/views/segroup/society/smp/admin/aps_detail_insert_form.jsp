<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<link rel="stylesheet" type="text/css"  href="<c:url value="/resources/segroup/society/smp/css/noticeBoard.css" />">
<link rel="stylesheet" type="text/css"  href="<c:url value="/resources/segroup/society/smp/css/boardStyle.css" />">

<%@include file="../import.jsp"%>

<title>aps</title>
<script type="text/javascript">
function totalOverlap() {
	var group_seq = $("#smp_aps_group_seq").val();
	var detail_nm=$("#smp_aps_detail_nm").val();
	var can;
	$.ajax({
		type : "POST",
		url : "/ajaxDetailOverlab",
		dataType : 'text',
		data : {
			'smp_aps_group_seq' : group_seq,
			'smp_aps_detail_nm': detail_nm
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
			var smp_aps_total_seq = $("#smp_aps_total_seq").val();
			var smp_aps_group_seq = $("#smp_aps_group_seq").val();
			var smp_aps_detail_nm = $("#smp_aps_detail_nm").val();
			var smp_aps_detail_ratio = $("#smp_aps_detail_ratio").val();
			var smp_aps_total_seq_msg = $("#smp_aps_total_seq option:selected").val();
			var smp_aps_group_seq_msg = $("#smp_aps_group_seq option:selected").val();
			var gisu_seq_msg = $("#gisu_seq option:selected").val();
			
			if (gisu_seq_msg == "0"){
				alert("기수를 선택해주세요");
				return ;
			}
								
			if (smp_aps_total_seq_msg == "0") {
				alert("평가종합 이름을 선택해주세요")
				return ;
			}
			
			if (smp_aps_group_seq_msg == "0"){
				alert("평가그룹 이름을 선택해주세요")
				return ;
			}

			
			if (smp_aps_detail_nm == "") {
				alert("평가상세 이름을 입력해주세요");
				return ;
			}

			if (smp_aps_detail_ratio == "") {
				alert("평가상세 비율을 입력해주세요");
				return ;
			}
			
			var ratio_max= $('#smp_aps_detail_ratio').attr('max');
			if(parseInt(smp_aps_detail_ratio)<parseInt(0)||parseInt(smp_aps_detail_ratio)>parseInt(ratio_max)){
				alert('올바른 비율값을 입력해주세요');
				return;
			}
			
			
			totalOverlap();
		});
		//처음total
		//changegisu();

		$('select[id="gisu_seq"]').on('change', function() {
			changegisu();
			changetotal();
		});

		$('select[id="smp_aps_total_seq"]').on('change', function() {
			changetotal();
		});
	})
	function changegisu() {
		var gisu = $("#gisu_seq").val();
		$.ajax({
			type : "POST",
			url : "/ajaxTotalNm",
			dataType : 'json',
			data : {
				'gisu_seq' : gisu
			},
			success : function(data) {
				var add = "";
				add += '<option value="0">선택</option>';
				for (var i = 0; i < data.length; i++) {
					add += '<option value='+data[i].smp_aps_total_seq;		
					add+='>'+ data[i].smp_aps_total_nm;
					add += "</option>";
				}
				$('#smp_aps_total_seq').html(add);
				$('#smp_aps_group_seq').html(" ");

				$('#smp_aps_total_seq option:eq(0)').attr("selected",
						"selected");
				changetotal();
			},
			error : function() {
				alert("error");
			}
		});
	}

	function changetotal() {
		var total_seq = $("#smp_aps_total_seq option:selected").val();
		$.ajax({
			type : "POST",
			url : "/ajaxGroupNm",
			dataType : 'json',
			data : {
				'smp_aps_total_seq' : total_seq
			},
			success : function(data) {
				var add = "";
				add += '<option value="0">선택</option>';
				for (var i = 0; i < data.length; i++) {
					add += '<option value='+data[i].smp_aps_group_seq+'>';
					add += data[i].smp_aps_group_nm;
					add += "</option>";
				}
				$('#smp_aps_group_seq').html(add);
			},
			error : function() {
				alert("error1");
			}
		});
	}
	
	
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
						<h2 class="aps_h">평가상세 등록 페이지</h2>
					</div>
					<form id="totalInsert" action="/smp/admin/aps_detail_insert" method="get" enctype="multipart/form-data">
						<table class="table_view">
							<colgroup>
								<col width="30%" />
								<col width="70%" />
							</colgroup>
							<tbody>
								<tr>
									<th>기수</th>
									<td><select name="gisu_seq" id="gisu_seq">
											<option value="0">선택</option>
											<c:forEach var="data" items="${seaCurList}">
												<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>평가종합 이름</th>
									<td><select name="smp_aps_total_seq" id="smp_aps_total_seq">

									</select></td>
								</tr>
								<tr>
									<th>평가그룹 이름</th>
									<td><select name="smp_aps_group_seq" id="smp_aps_group_seq">

									</select></td>
								</tr>
								<tr>
									<th>평가상세 이름</th>
									<td><input type="text" name="smp_aps_detail_nm" id="smp_aps_detail_nm"></td>
								</tr>
								<tr>
									<th>평가상세 비율</th>
									<td><input type="number" name="smp_aps_detail_ratio" id="smp_aps_detail_ratio" min='0' max='100' onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;">(%)</td>
								</tr>
								<tr>
									<th>평가상세 내용</th>
									<td><textarea name="smp_aps_detail_ct" id="smp_aps_detail_ct"></textarea></td>
								</tr>
							</tbody>
						</table>
						<div class="btnManagerDiv">
							<input type="button" id="totalInsertBtn" value="등록하기" /> <input type="button" id="goListBtn" value="목록으로" />
						</div>
					</form>
					<form action="/smp/admin/aps_detail" id="goList" method="get"></form>


				</div>
			</div>
		</div>
	</div>
</body>
</html>