<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bridge Job Fair</title>
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script>
	
	<script>
		$(function() {
			
			
			_logout = _.debounce(function(){
				$('#logoutForm').submit();
			},500,true);
			
			$('#logout').off("click").on("click", function() {
				_logout();
				return false;
			});
	
			$(".fap_nav li").mouseenter(function() {
				$.each($(".fap_nav li"), function(index, item) {
					var width = $(this).width();
					$(".nav-column").eq(index).width(width);
					$(".nav-column").eq(index).css("padding", "1px");
				});
				var contents = $("#menu-contents").clone().css("display", "block");
	
				$(this).find(".menu-area").html(contents);
			}).mouseleave(function() {
				$(this).find(".menu-area").html('');
			});
	
			var user_id = $('#user_id_ck').val();
			/* 
			if (typeof user_id != "undefined" && user_id != "") {
				$.ajax({
					url : '/fap/user/user_menu_check'
					, type : 'post'
					, async : false
					, data : {
						user_id : user_id
					}
					, success : function(menu_check) {
						
					}
					, error : function () {
						
					}
					
				});
				
			}
			 */
		});
			
		//[start] 선택한 잡페어 세션에 저장 시작
		function choiceJobfair() {
			var fap_jobfair_divide_seq = $('input[name=fap_jobfair_divide_seq]:checked', '#joinedJobfairInfoDiv').attr('divide_seq');
			var fap_jobfair_seq = $('input[name=fap_jobfair_divide_seq]:checked', '#joinedJobfairInfoDiv').attr('jobfair_seq');
			var fap_jobfair_title = $('input[name=fap_jobfair_divide_seq]:checked', '#joinedJobfairInfoDiv').attr('jobfair_title');
			if(fap_jobfair_divide_seq == undefined) {
				alert('선택된 잡페어가 없습니다.');
				return false;
			}
			var selectedJobfairInfo = {};
			selectedJobfairInfo['fap_jobfair_divide_seq'] = fap_jobfair_divide_seq;
			selectedJobfairInfo['fap_jobfair_seq'] = fap_jobfair_seq;
			selectedJobfairInfo['fap_jobfair_title'] = fap_jobfair_title;
			
			$.ajax({
				url : 'user_request_save_jobfair_info',
				type: 'post',
				contentType: 'application/json',
				data : JSON.stringify(selectedJobfairInfo),
				dataType : 'text',
				success : function(response) {
					if(response == 'saveSuccess'){
						alert('변경되었습니다.');
						window.location.href = '<c:url value="/fap/user/user_main" />';
					}else {
						alert('변경에 실패하였습니다. 관리자에게 문의하세요.');
					}
					$('#choiceJobfairModal').modal('hide');
				
				},
				error : function(response) {
					console.log(response);
				}
			});
		}
		//[end] 선택한 잡페어 세션에 저장 종료
		
		//[start] 개인별 참가가능한 잡페어 출력 시작
		function openChoiceJobfairModal() {
			$.ajax({
				url : 'user_current_participation_jobfair_list',
				type : 'post',
				dataType : 'json',
				success : function(response) {
					var jobfairInfoList = response;
					
					$('#joinedJobfairInfoDiv').children().remove();
					var context = '';
					if(jobfairInfoList == undefined || jobfairInfoList == null || jobfairInfoList.length == 0){
						context += '<h4>선택할 잡페어가 없습니다.</h4>';
						context += '<br>';
					} else{
						context += '<br>';
						$.each(jobfairInfoList, function(index, jobfairInfo){
							context +=	'<div id="perJobfairInfoDiv">';
							context += 		'<h3>' + jobfairInfo.fap_jobfair_title + '</h3>';
							if(jobfairInfo.jobfairDivideInfoList == undefined || jobfairInfo.jobfairDivideInfoList.length == 0){
								context += 	'<br>';
								context += '<h5>선택할 세부 잡페어가 없습니다.</h5>';
								context += 	'<br>';
							}else{
								$.each(jobfairInfo.jobfairDivideInfoList, function(index, jobfairDivideInfo){
									if(jobfairDivideInfo.fap_jobfair_divide_st <= jobfairDivideInfo.to_day && jobfairDivideInfo.to_day <= jobfairDivideInfo.fap_jobfair_divide_et){
										context += 	'<br>';
										context +=	'<div id="perDivideInfoDiv">';
										context +=		'<div style="display: block; width: 50%; float:left;">';
										switch(jobfairDivideInfo.fap_jobfair_divide_gb){
											case 'C0100' : 
												context +=	'<h4>Seoul-FAIR</h4>';
												break;
											case 'C0101' : 
												context +=	'<h4>Tokyo-FAIR</h4>';
												break;
											case 'C0102' : 
												context +=	'<h4>포스트시즌</h4>';
												break;	
										}
										context += 		'</div>';
										context += 		'<div style="display:inline-block; width: 50%; float:left;">';
										context += 			'<input type="radio" name="fap_jobfair_divide_seq" jobfair_title="' + jobfairInfo.fap_jobfair_title + '" jobfair_seq="' + jobfairInfo.fap_jobfair_seq + '" divide_seq="' + jobfairDivideInfo.fap_jobfair_divide_seq + '" style="display:inline-block; width: 25px; height: 20px;">';
										context += 		'</div>';
										context += 	'</div>';
										context += 	'<br><br>';
									}else{
										context += 	'<br>';
										context +=	'<div id="perDivideInfoDiv">';
										context +=		'<div style="display: block; width: 50%; float:left;">';
										switch(jobfairDivideInfo.fap_jobfair_divide_gb){
											case 'C0100' : 
												context +=	'<h4>Seoul-FAIR</h4>';
												break;
											case 'C0101' : 
												context +=	'<h4>Tokyo-FAIR</h4>';
												break;
											case 'C0102' : 
												context +=	'<h4>포스트시즌</h4>';
												break;	
										}
										context += 		'</div>';
										context += 		'<div style="display:inline-block; width: 50%; float:left;">';
										context += 			'잡페어 기간이 종료 되었습니다.';
										context += 		'</div>';
										context += 	'</div>';
										context += 	'<br><br>';
									}
								});
							}
							context += 	'</div>';
						});
					}
					$('#joinedJobfairInfoDiv').append(context);
					$('#choiceJobfairModal').modal('show');
				
				}, 
				error : function(response) {
					console.log(response);
				}
			});	
		}
		//[end] 개인별 참가가능한 잡페어 출력 종료
	</script>
</head>
<body>
	<sec:authorize access="hasAnyRole('ROLE_A0100,ROLE_A0101,ROLE_A0102,ROLE_A0106,ROLE_A0108')">
		<sec:authentication property="details" var="check" />
		<sec:authentication property="details.user" var="user" />
		<input type="hidden" id="user_id_ck" value="${user.user_id}">
	</sec:authorize>
	<form id="logoutForm" action="/fap/user/logout" method="post" style="display: none">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<div id="header">
		<div class="headerBackground">
			<ul id="infoMenu">
				<!-- 세션에 선택된 잡페어 title 출력하는 부분 -->
				<li id="chosenJobfairTitle">${sessionScope.jobfairInfo.fap_jobfair_title}</li>
				<c:choose>
					<c:when test="${empty check}">
						<li><a href="<c:url value="/fap/user/user_login" />">Login</a></li>
						<li><a href="<c:url value="/fap/user/user_insert_form" />">Join</a></li>
						
					</c:when>
					<c:otherwise>
						<li><a href="#none" id="logout">Logout</a></li>
					</c:otherwise>
				</c:choose>
				<!-- <li><a href="/fap/user/user_faq">FAQ</a></li> -->
			</ul>
		</div>
		<!-- 회원은 jobfair라는 디렉토리를 한번 더 들어가기 때문에 c태그로 링크 걸어야함 -->
		<div id="infoTop">
			<div id="logo">
				<a href="<c:url value="/fap/user/user_main" />">
					<img src="<c:url value="/resources/segroup/society/fap/images/userOpenMain/society_logo.svg" />">
				</a>
			</div>
			<div class="wrap">
				<c:if test="${not empty check}">
					<ul class="fap_nav">
						<li>
							<a href="<c:url value="/fap/user/resume_management" />">이력서 관리</a>
							<div class="menu-area"></div>
						</li>
						<li>
							<a href="<c:url value="/fap/user/user_jobfair_apply_to_attend_form" />">잡페어 신청</a>
							<div class="menu-area"></div>
						</li>
						<li>
							<a href="#" onclick="openChoiceJobfairModal()">잡페어 선택</a>
							<div class="menu-area"></div>
						</li>
						<!-- 잡페어 세션에 있는지 여부 확인 하는 부분 시작 -->
						<c:if test="${not empty sessionScope.jobfairInfo}">	
							<li>
								<a href="<c:url value="/fap/user/user_job_advertisement_list_form" />">채용정보</a>
								<div class="menu-area"></div>
							</li>
							<li>
								<a href="<c:url value="/fap/user/user_total_apply_status_form" />">지원현황관리</a>
								<div class="menu-area"></div>
							</li>
						</c:if>
						<!-- 잡페어 세션에 있는지 여부 확인 하는 부분 종료 -->
						<li>
							<a href="<c:url value="/fap/user/user_process_schedule_calendar" />">나의채용전형</a>
							<div class="menu-area"></div>
						</li>
						<li>
							<a href="<c:url value="/fap/user/user_update_form" />">마이페이지</a>
							<div class="menu-area"></div>
						</li>
					</ul>
				</c:if>
			</div>
		</div>
	</div>

	<c:if test="${not empty check}">
		<div id="menu-contents">
			<div class="nav-column">
				<ul>
					<li>
					</li>
				</ul>
			</div>
			<div class="nav-column">
				<ul>
					<li>
					</li>
				</ul>
			</div>
			<div class="nav-column">
				<ul>
					<li>
					</li>
				</ul>
			</div>
			<c:if test="${not empty sessionScope.jobfairInfo}">
				<div class="nav-column">
					<ul>
						<li>
							<a href="<c:url value="/fap/user/user_job_advertisement_list_form" />">채용공고목록</a>
							<a href="<c:url value="/fap/user/user_job_advertisement_search_form" />">상세검색</a>
							<a href="<c:url value="/fap/user/user_tokyofair_schedule_form" />">현장면접일정</a>
						</li>
					</ul>
				</div>
				<div class="nav-column">
					<ul>
						<li>
							<a href="<c:url value="/fap/user/user_total_apply_status_form" />">전체지원현황</a>
							<a href="<c:url value="/fap/user/user_personal_apply_status_form" />">개인지원현황</a>
							<a href="<c:url value="/fap/user/user_my_favorite_company_list_form" />">내가담은기업</a>
						</li>
					</ul>
				</div>
			</c:if>
			<div class="nav-column">
				<ul>
					<li>
						<a href="<c:url value="/fap/user/user_process_schedule_calendar" />">전형일정달력</a>
						<a href="<c:url value="/fap/user/user_required_doc_management" />">내정서류관리</a>
					</li>
				</ul>
			</div>
			<div class="nav-column">
				<ul>
					<li>
						<a id="user_update" href="<c:url value="/fap/user/user_update_form" />">회원정보 수정</a>
						<a href="<c:url value="/fap/user/user_open_pt_applied_form" />">설명회 확인</a>
					</li>
				</ul>
			</div>
		</div>
	</c:if>
	
	
	<!--------------- 지원기업편집 모달 시작 --------------->
	<div class="modal fade" id="choiceJobfairModal" role="dialog">
	
		<!-- Modal dialog------------------------->
		<div class="modal-dialog" id="modal-dialog">
		
			<!-- 1 Modal content------------------------->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="title">
						잡페어 정보
					</h4>
				</div>
				
				<!-- body 시작-->
				<div class="rank_change_modal-body" style="text-align: center;">
					<div id="joinedJobfairInfoDiv" style="text-align:center;">

						
					</div>

        		</div>
				<!-- body 끝 -->

				<div class="modal-footer">
					<button type="button" id="choiceJobfairModalBtnSave" class="btn btn-default" onclick="choiceJobfair()">변경</button>
					<button type="button" id="choiceJobfairModalBtnClose" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			
			</div>
			<!-- modal content div 종료 -->
			
		</div>
		<!-- modal-dialog div 종료 -->
		
	</div>  
	<!-- modal fade div 종료 -->
	<!--------------- 지원기업편집 모달 끝 --------------->
</body>
</html>