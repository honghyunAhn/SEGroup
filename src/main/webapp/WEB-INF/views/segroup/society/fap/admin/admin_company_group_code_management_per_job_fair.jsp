<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function(){
	
 
// selectbox 대분류: 잡페어 리스트 출력 	
	$('#selectDivideJobFair').children().remove();
	$('#jobfarirButton').remove();
	$('#selectDivideJobFair').append('<option value="defaultOption" selected="selected">선택해주세요.</option>');
	
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'admin_select_jobfair_list',
		type: 'post',
		contentType: 'application/json',
		dataType : 'json',
		success : function(data) {
			$("#chooseJobFair").children().remove();
			$("#chooseJobFair").append('<option value="defaultOption">선택해주세요.</option>');
			var nowJobfairList = data.jobfair_list_now;
			var afterJobfairList = data.jobfair_list_after;
			var html ='';
			html += '<optgroup label="진행중인 잡페어">';
			$.each(nowJobfairList, function(index, nowJobfair){
				html += '<option value="'+ nowJobfair.fap_jobfair_seq +'">';
				html += nowJobfair.fap_jobfair_title
				html += '</option>';
			});
			html += '</optgroup>';
			html += '<optgroup label="마감한 잡페어">';
			html +='</optgroup>';
			$('#chooseJobFair').append(html);
		},
		error : function(data) {
			console.log(data);
			if(data.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/admin/admin_login";
			}
		}
	});
	
})
	
 // 잡페어 선택하면 세부잡페어 조회 가능
function myJobFairDivide(){
			var fap_jobfair_seq = $('#chooseJobFair option:selected').val();
			console.log("fap_jobfair_seq"+fap_jobfair_seq);
			if(fap_jobfair_seq =="" || fap_jobfair_seq =="defaultOption"){
				$("#selectDivideJobFair").children().remove();
				$("#selectDivideJobFair").append('<option value="defaultOption" selected="selected">선택해주세요.</option>');
			}
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				},
				url: 'select_all_job_fair_divide',
				type: 'post',
				data: {'fap_jobfair_seq' : fap_jobfair_seq},
				dataType:'json',
				success : function(data) {
					console.log(data);
					var html ='';
					$("#selectDivideJobFair").children().remove();
					html += '<option selected="selected" value="defaultOption">선택해주세요</option>';
					$.each(data, function(index, divideJobfair){
						if(divideJobfair.fap_jobfair_divide_gb == 'C0100'){
							html += '<option value="'+ divideJobfair.fap_jobfair_divide_seq +'">K-fair</option>';
						}else if(divideJobfair.fap_jobfair_divide_gb == 'C0101'){
							html += '<option value="'+ divideJobfair.fap_jobfair_divide_seq +'">J-fair</option>';
						}else if(divideJobfair.fap_jobfair_divide_gb == 'C0102'){
							html += '<option value="'+ divideJobfair.fap_jobfair_divide_seq +'">포스트시즌</option>';
						} 
					});
					
					$("#selectDivideJobFair").append(html);
				},
				error : function(data) {
					console.log(data);
					if(data.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/admin/admin_login";
					}
				}
			});
		}
		
	//세부잡페어 선택하면 button 생김
	function selectedJobFairSeq(){
		var fap_jobfair_divide_seq = $('#selectDivideJobFair option:selected').val();
		$('#jobfarirButton').remove();
		if(fap_jobfair_divide_seq =='defaultOption'){
			return false;
		}else if(fap_jobfair_divide_seq==''){
			$('#jobfarirButton').remove();
			$('#selectDivideJobFair').append('<option selected="selected" value="defaultOption">선택해주세요.</option>');
		}else {
			var html='';
			html +='<button type="button" id="jobfarirButton" onclick="selectedJobfair('+fap_jobfair_divide_seq +')">선택</button>'
			$('#buttonDiv').append(html);
		}
	}	
	function selectedJobfair(fap_jobfair_divide_seq){
		$.ajax({
			url:'/fap/admin/admin_company_group_code_management_per_job_fair',
			type:'post',
			contentType:'application/json',
			dataType:'json',
			success:function(data){
				$("")
			}
		})
		location.href="/fap/admin/admin_company_group_code_management_per_job_fair?fap_jobfair_divide_seq="+fap_jobfair_divide_seq;
	}

//기업 그룹코드 변경
function changeGroupcode(fap_job_ad_seq){
	
	var fap_job_ad_groupcode = $('#SelectGroupcode'+fap_job_ad_seq).val();
	var fap_jobfair_divide_seq = $('#fap_jobfair_divide_seq').val();
	if(fap_job_ad_groupcode == '선택해주세요'){
		alert('변경할 직군을 선택해주세요');
		return false;
	}
	$.ajax({	
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url: 'change_groupcode',
		type: 'post',
		data: {
			'fap_job_ad_seq' : fap_job_ad_seq,
			'fap_job_ad_groupcode' : fap_job_ad_groupcode,
			'fap_jobfair_divide_seq' : fap_jobfair_divide_seq
			},
		success: function(data){
			$('#count_per_group').empty();
			var html ='';
			
			for (var groupcode in data) {
				if(data[groupcode].fap_job_ad_groupcode != undefined) {
					if(data[groupcode].fap_job_ad_groupcode == 'D0500'){
						html += '-'+' : '+data[groupcode].count_per_group + ' ';
					}else {
						html += data[groupcode].fap_job_ad_groupcode + ' : ' + data[groupcode].count_per_group + ' ';
					}
				}
			} 
			$('#count_per_group').append(html);
			alert('성공적으로 변경되었습니다');
		},
		error: function(data) {
			console.log(data);
			if(data.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/admin/admin_login";
			}
		}
	});
	
}
 
/* function sort_groupcode(sort_info){
	var fap_jobfair_divide_seq = $('#fap_jobfair_divide_seq').val();
	$.ajax({
		 
		url: '/fap/admin/admin_company_group_code_management_per_job_fair',
		type: 'get',
		data:{
			    'fap_jobfair_divide_seq':fap_jobfair_divide_seq,
				'order':sort_info
		},
		success:function(data){
			alert("test");
		},
		error:function(data){
			console.log(data);
		}		
	})
} */
// 기업 순위 변경
function selectRank(fap_job_ad_seq){
	var fap_job_ad_rank = $('#selectRank'+fap_job_ad_seq).val();
	var fap_jobfair_divide_seq = $('#fap_jobfair_divide_seq').val();
	$.ajax({	
		url: 'admin_update_rank',
		type: 'post',
		data: {
			'fap_job_ad_seq' : fap_job_ad_seq,
			'fap_job_ad_rank' : fap_job_ad_rank,
			'fap_jobfair_divide_seq' : fap_jobfair_divide_seq
			},
		success: function(res){
			if(res != 0){
				location.href="/fap/admin/admin_company_group_code_management_per_job_fair?fap_jobfair_divide_seq="+fap_jobfair_divide_seq;
			}
		},
		error: function(data) {
			console.log(data);
			if(data.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/admin/admin_login";
			}
		}
	});
}
</script>
<body>
<%@include file="admin_menu.jsp"%>
	<input type="hidden" id="fap_jobfair_divide_seq" name="fap_jobfair_divide_seq" value="${fap_jobfair_divide_seq}">
	<div class="join-wrap">
		<div id="subcontents">
		<h1>잡페어별 기업 그룹코드 관리</h1><h6><spring:message code="fap.comp.login_invite_phrase" /></h6>
		   	   
			<div id="buttonDiv">잡페어 리스트 출력 
				<select id="chooseJobFair" onchange="myJobFairDivide()">					 
				<!-- 잡페어/세부잡페어 selectbox -->
				</select> 
				<select id="selectDivideJobFair" onchange="selectedJobFairSeq()">					 
				<!-- 버튼 -->
				</select>
			</div>
         	 
		<div id="count_per_group" style="margin-right: -70%;">
			<c:forEach items="${count_per_group}" var="group">
				<c:if test="${group.fap_job_ad_groupcode eq 'D0500'}">
					- : ${group.count_per_group}
				</c:if>
				<c:if test="${not empty group.fap_job_ad_groupcode and group.fap_job_ad_groupcode ne 'D0500'}">
				${group.fap_job_ad_groupcode} : ${group.count_per_group}
				</c:if>		
			</c:forEach> 
		</div>
		<table>
			<thead id="headTr">
				<tr>
					<th></th>
					<th>회사명</th>
					<th>채용공고제목</th>
					<th>자본금</th>
					<th>3년간 매출</th>
					<th>사원수</th>
					<th>직군
						<%-- <c:choose>
							<c:when test="${sort_info eq 'desc'}">
								<img src="<c:url value="/resources/segroup/society/fap/images/main/triangle_down.png" />" style="height: 10%; width: 10%;" onclick="sort_groupcode('asc')">
							</c:when>
							<c:when test="${sort_info eq 'asc'}">
								<img src="<c:url value="/resources/segroup/society/fap/images/main/triangle_up.png" />" style="height: 10%; width: 10%;" onclick="sort_groupcode('desc')">
							</c:when>
							<c:otherwise>
								<img src="<c:url value="/resources/segroup/society/fap/images/main/triangle_down.png" />" style="height: 10%; width: 10%;" onclick="sort_groupcode('asc')">				
							</c:otherwise>
						</c:choose> --%>
					</th>
					<th>변경하기</th>
					<th>순위</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jobFairAdList}" var="jobad">
					<tr>
							<td><input type="hidden" value="${jobad.fap_job_ad_seq}"></td>
							<td>${jobad.fap_comp_en_nm}</td>
							<td>${jobad.fap_job_ad_title}</td>
							<td>${jobad.fap_job_ad_stock}</td>
							<td>${jobad.fap_job_ad_3years_avg_sales}</td>
							<td>${jobad.fap_job_ad_employee_num}</td>
							<td>
								<select id="SelectGroupcode${jobad.fap_job_ad_seq}" style="width:60px">
									<option hidden value="선택해주세요">선택</option>
									<c:forEach items="${companyGroupcodeList}" var="companygroupcode">
										<c:choose>
											<c:when test="${companygroupcode.fap_comp_groupcode eq 'D0500' and jobad.fap_job_ad_groupcode eq 'D0500'}">
												<option selected="selected" value="D0500"> - </option>
											</c:when>
											<c:when test="${jobad.fap_job_ad_groupcode eq companygroupcode.fap_comp_groupcode}">
												<option selected="selected" value="${jobad.fap_job_ad_groupcode}">${jobad.fap_job_ad_groupcode}</option>
											</c:when>
											<c:when test="${companygroupcode.fap_comp_groupcode eq 'D0500'}">
												<option value="D0500"> - </option>
											</c:when>	
											<c:otherwise>
												<option value="${companygroupcode.fap_comp_groupcode}">
													${companygroupcode.fap_comp_groupcode}
												</option>
											</c:otherwise> 
										</c:choose>
									</c:forEach>
								</select>
							</td>
							<td style="width: 7%">
								<button type="button" onclick="changeGroupcode(${jobad.fap_job_ad_seq})">변경</button>	
							</td>
							<!-- anh288 -->
							<td>
								<select id="selectRank${jobad.fap_job_ad_seq}" onchange="selectRank('${jobad.fap_job_ad_seq}');" style="width:60px">
									<c:if test = "${jobad.fap_job_ad_rank == null}">
										<option hidden value="선택">선택</option>
									</c:if>
									<c:if test = "${jobad.fap_job_ad_rank != null}">
										<option hidden value="선택">${jobad.fap_job_ad_rank}</option>
									</c:if>
									<c:forEach var="i" begin="1" end="8">
										<option value="${i}">${i}</option>
									</c:forEach>
								</select>
							</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<%@include file="admin_footer.jsp"%>
</body>
</html>