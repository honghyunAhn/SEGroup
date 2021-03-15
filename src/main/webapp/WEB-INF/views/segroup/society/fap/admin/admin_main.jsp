<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
	<%-- <script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script> --%>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js" />"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css" />" />
	<script type="text/javascript">
		//[start] 잡페어 선택 모달창
		function select_jobfair_list(){
			$('#myModal').modal('show');
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
		}
		function myJobFairDivide(){
			var fap_jobfair_seq = $('#chooseJobFair option:selected').val();
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
				html +='<button type="button" id="jobfarirButton" onclick="mySelectedJobfair('+fap_jobfair_divide_seq +')">선택</button>'
				$('#buttonDiv').append(html);
			}
		}
		function mySelectedJobfair(fap_jobfair_divide_seq){
				location.href="/fap/admin/admin_company_group_code_management_per_job_fair?fap_jobfair_divide_seq="+fap_jobfair_divide_seq;
		}
		//[end] 잡페어 선택 모달창
	</script>
</head>
<body>
	<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>관리자 메인 페이지</h2>
	</div>
	<br>
	<a href="#" onclick="select_jobfair_list()">잡페어별 기업 그룹코드</a>
	<!-- Modal -->
	<div class="modal fade" role="dialog" id="myModal">
		<div class="modal-dialog">
	 		<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">채용공고 리스트</h4>
				</div>
				<div class="modal-body">
			    	<div>잡페어 리스트 출력
						<!-- body 시작-->
						<div id="buttonDiv">
							<select id="chooseJobFair" onchange="myJobFairDivide()">
								<!-- 잡페어 리스트 출력 -->
							</select>
							<select id="selectDivideJobFair" onchange="selectedJobFairSeq()">
								<!-- 값 넘겨주는 버튼 들어가는곳 -->
							</select>
						</div>
						<!-- body 끝 -->
						<div class="modal-footer">
							<p>여기는 modal footer</p>
						</div>
					</div>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>