<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script type="text/javascript">
	
	var myApp = angular.module('myapp', []);

	myApp.directive('code', [ '$http', function($http) {
		return {
			restrict : "E",
			replace : true,
			scope : {
				value : '@'
			},
			controller : function($scope, $element, $attrs) {
				$http({
					method : 'POST',
					url : '/codeconverter',
					responseType : 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
					$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			},
			template : "<span>{{filterParams}}</span>"
		}
	} ]);

	function list_ck(ck) {
		if(ck == 'standBy'){
			$('#standBy_list').show();
			$('#approval_list').hide();
			$('#refusal_list').hide();
		} else if(ck == 'approval'){
			$('#approval_list').show();
			$('#standBy_list').hide();
			$('#refusal_list').hide();
		} else if(ck == 'refusal'){
			$('#refusal_list').show();
			$('#standBy_list').hide();
			$('#approval_list').hide();
		}
	}
	
	function connect_update(fap_comp_user_connect_ck){
		var seq_list = [];
		$("input[name='standBy_seq_list']:checked").each(function () {
			seq = $(this).val();
			seq_list.push(seq);
		});
		
		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, url : '/fap/admin/company_user_connect_update'
			, type : 'post'
			, data : {
				seq_list : seq_list
				, fap_comp_user_connect_ck : fap_comp_user_connect_ck
			}
			, success : function() {
				alert('정상 처리 되었습니다.');
				location.reload();
			}	
			, error : function(e) {
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			}
		}); // ajax end
		
	} // function(connect_update) end
	
	function connect_all_update(origin_ck, update_ck) {
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, url : '/fap/admin/connect_all_update'
			, type : 'post'
			, data : {
				origin_ck : origin_ck
				, update_ck : update_ck
			}
			, success : function() {
				alert('정상 처리 되었습니다.');
				location.reload();
			}	
			, error : function(e) {
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			}
		}); // ajax end
	} // function(connect_all_update) end
	
	function connect_delete(connect_ck) {
		
		if(confirm('정말 삭제 하시겠습니까?')){
			var seq_list = [];
			
			if(connect_ck == 'approval'){
				$("input[name='approval_seq_list']:checked").each(function () {
					seq = $(this).val();
					seq_list.push(seq);
				});
			} else if(connect_ck == 'refusal'){
				$("input[name='refusal_seq_list']:checked").each(function () {
					seq = $(this).val();
					seq_list.push(seq);
				});
			}
			
			jQuery.ajaxSettings.traditional = true;
			
			$.ajax({
				beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				}
				, url : '/fap/admin/company_user_connect_delete'
				, type : 'post'
				, data : {
					seq_list  : seq_list
				}
				, success : function() {
					alert('정상 처리 되었습니다.');
					location.reload();
				}
				, error : function(e) {
					if(e.status == 403){
						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
						location.href = "/fap/admin/admin_login";
					}
				}
			}); // ajax end
			
		}
		
	} // function(connect_delete) end
	
	

</script>

<script type="text/javascript">

//페이징관련 함수(대기중인 리스트)
function changePageLoadList(clickedPage) {
	
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'comp_user_connect_standby_paging',
		type : 'post',
		data : {'clickedPage' : clickedPage},
        dataType : 'json', 
		success : function(map) {
			var totalCount = map.userStandbyTotalCount;
			var currentPage = map.repNavi.currentPage;
			var pagePerGroup = map.repNavi.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1))
			
			$('.before-standby-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-page').children().remove();
			var pageContext = '';
			
			//[start] 대기중인 리스트 정보 innerHtml로 그려주기 시작
			$.each(map.user_standby_list, function(index, userStandbyLoadList){
				InfoContext += '<tr>';
				InfoContext += '<td><input type="checkbox" name="standBy_seq_list" value="' + userStandbyLoadList.fap_comp_user_connect_seq + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td>' + userStandbyLoadList.user_id + '</td>';
				InfoContext += '<td>' + userStandbyLoadList.user_nm + '</td>';
				InfoContext += '<td></td>';
				InfoContext += '<td>' + userStandbyLoadList.fap_comp_id + '</td>';
				InfoContext += '<td>' + userStandbyLoadList.fap_comp_ja_nm + '</td>';
				InfoContext += '<td>' + userStandbyLoadList.fap_comp_en_nm + '</td>';
				InfoContext += '</tr>';					
			});
			//[end] 대기중인 리스트 정보 inner로 그려주기 종료
			
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage - map.repNavi.pagePerGroup) + ')">◁◁</a>';
			pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage - 1) + ')">◀</a>';
			
			for(var i=map.repNavi.startPageGroup; i<=map.repNavi.endPageGroup; i++){
				
				if(i == map.repNavi.currentPage){
					pageContext += '<span class="now">' + i + '</span>';
				}else{
					pageContext += '<a href="javascript:changePageLoadList(' + i + ')">' + i + '</a>';
				}
				
			}
			
			pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage + 1) + ')">▶</a>';
			pageContext += '<a href="javascript:changePageLoadList(' + (map.repNavi.currentPage + map.repNavi.pagePerGroup) + ')">▷▷</a>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.before-standby-table-tbd').append(InfoContext);
			$('.before-page').append(pageContext);
		},
		error : function(response) {
			console.log(response);
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/admin/admin_login";
			}
		}
	});	
}

//페이징관련 함수(승인한 리스트)
function changePageLoadListTwo(clickedPage) {
	
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'comp_user_connect_approval_paging',
		type : 'post',
		data : {'clickedPage' : clickedPage},
        dataType : 'json', 
		success : function(map) {
			var totalCount = map.userApprovalTotalCount;
			var currentPage = map.repNaviTwo.currentPage;
			var pagePerGroup = map.repNaviTwo.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1))
			
			$('.before-approval-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-pagetwo').children().remove();
			var pageContext = '';
			
			//[start] 대기중인 리스트 정보 innerHtml로 그려주기 시작
			$.each(map.user_approval_list, function(index, userApprovalLoadList){
				InfoContext += '<tr>';
				InfoContext += '<td><input type="checkbox" name="approval_seq_list" value="' + userApprovalLoadList.fap_comp_user_connect_seq + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td>' + userApprovalLoadList.user_id + '</td>';
				InfoContext += '<td>' + userApprovalLoadList.user_nm + '</td>';
				InfoContext += '<td></td>';
				InfoContext += '<td>' + userApprovalLoadList.fap_comp_id + '</td>';
				InfoContext += '<td>' + userApprovalLoadList.fap_comp_ja_nm + '</td>';
				InfoContext += '<td>' + userApprovalLoadList.fap_comp_en_nm + '</td>';
				InfoContext += '</tr>';					
			});
			//[end] 대기중인 리스트 정보 inner로 그려주기 종료
			
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage - map.repNaviTwo.pagePerGroup) + ')">◁◁</a>';
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage - 1) + ')">◀</a>';
			
			for(var i=map.repNaviTwo.startPageGroup; i<=map.repNaviTwo.endPageGroup; i++){
				
				if(i == map.repNaviTwo.currentPage){
					pageContext += '<span class="now">' + i + '</span>';
				}else{
					pageContext += '<a href="javascript:changePageLoadListTwo(' + i + ')">' + i + '</a>';
				}
				
			}
			
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage + 1) + ')">▶</a>';
			pageContext += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage + map.repNaviTwo.pagePerGroup) + ')">▷▷</a>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.before-approval-table-tbd').append(InfoContext);
			$('.before-pagetwo').append(pageContext);
		},
		error : function(response) {
			console.log(response);
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/admin/admin_login";
			}
		}
	});	
}

//페이징관련 함수(거절한 리스트)
function changePageLoadListThree(clickedPage) {
	
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'comp_user_connect_refusal_paging',
		type : 'post',
		data : {'clickedPage' : clickedPage},
        dataType : 'json', 
		success : function(map) {
			var totalCount = map.userRefusalTotalCount;
			var currentPage = map.repNaviThree.currentPage;
			var pagePerGroup = map.repNaviThree.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1))
			
			$('.before-refusal-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-pagethree').children().remove();
			var pageContext = '';
			
			//[start] 거절한 리스트 정보 innerHtml로 그려주기 시작
			$.each(map.user_refusal_list, function(index, userRefusalLoadList){
				InfoContext += '<tr>';
				InfoContext += '<td><input type="checkbox" name="refusal_seq_list" value="' + userRefusalLoadList.fap_comp_user_connect_seq + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td>' + userRefusalLoadList.user_id + '</td>';
				InfoContext += '<td>' + userRefusalLoadList.user_nm + '</td>';
				InfoContext += '<td></td>';
				InfoContext += '<td>' + userRefusalLoadList.fap_comp_id + '</td>';
				InfoContext += '<td>' + userRefusalLoadList.fap_comp_ja_nm + '</td>';
				InfoContext += '<td>' + userRefusalLoadList.fap_comp_en_nm + '</td>';
				InfoContext += '</tr>';					
			});
			//[end] 거절한 리스트 정보 inner로 그려주기 종료
			
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContext += '<a href="javascript:changePageLoadListThree(' + (map.repNaviThree.currentPage - map.repNaviThree.pagePerGroup) + ')">◁◁</a>';
			pageContext += '<a href="javascript:changePageLoadListThree(' + (map.repNaviThree.currentPage - 1) + ')">◀</a>';
			
			for(var i=map.repNaviThree.startPageGroup; i<=map.repNaviThree.endPageGroup; i++){
				
				if(i == map.repNaviThree.currentPage){
					pageContext += '<span class="now">' + i + '</span>';
				}else{
					pageContext += '<a href="javascript:changePageLoadListThree(' + i + ')">' + i + '</a>';
				}
				
			}
			
			pageContext += '<a href="javascript:changePageLoadListThree(' + (map.repNaviThree.currentPage + 1) + ')">▶</a>';
			pageContext += '<a href="javascript:changePageLoadListThree(' + (map.repNaviThree.currentPage + map.repNaviThree.pagePerGroup) + ')">▷▷</a>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.before-refusal-table-tbd').append(InfoContext);
			$('.before-pagethree').append(pageContext);
		},
		error : function(response) {
			console.log(response);
			if(response.status == 403){
				alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
				location.href = "/fap/admin/admin_login";
			}

		}
	});	
}

</script>

<body ng-app="myapp">
<%@include file="admin_menu.jsp"%>
	<br>
	<div class="page_title">
		<h2>기업-담당자 연결 관리</h2>
	</div>
	<br>
	<label><input type="radio" name="list_ck" onclick="list_ck('standBy')" checked="checked">대기중인 리스트</label>
	<label><input type="radio" name="list_ck" onclick="list_ck('approval')">승인 한 리스트</label>
	<label><input type="radio" name="list_ck" onclick="list_ck('refusal')">거절 한 리스트</label>

	<div id="standBy_list">
		<h3>대기중인 리스트</h3>
		<button onclick="connect_all_update('B3801', 'B3800')">전체 승인</button><button onclick="connect_all_update('B3801', 'B3802')">전체 거절</button>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회원 아이디</td>
				<td>회원 이름</td>
				<td><pre>		</pre></td>
				<td>기업 아이디</td>
				<td>기업 일어명</td>
				<td>기업 영문명</td>
			</tr>
			<tbody class="before-standby-table-tbd">
			<c:forEach var="data" items="${user_standby_list}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="standBy_seq_list" value="${data.fap_comp_user_connect_seq}"></td>
					<td>${userStandbyLoadNum - (status.count-1)}</td>
					<td>${data.user_id}</td>
					<td>${data.user_nm}</td>
					<td></td>
					<td>${data.fap_comp_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="before-page">
		<a href="javascript:changePageLoadList(${repNavi.currentPage - repNavi.pagePerGroup})">◁◁</a>
		<a href="javascript:changePageLoadList(${repNavi.currentPage - 1})">◀</a>
			<c:forEach var="i" begin="${repNavi.startPageGroup}" end="${repNavi.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNavi.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="javascript:changePageLoadList(${i})">${i}</a>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<a href="javascript:changePageLoadList(${repNavi.currentPage + 1})">▶</a>
		<a href="javascript:changePageLoadList(${repNavi.currentPage + repNavi.pagePerGroup})">▷▷</a>
		</div>
		
		<button onclick="connect_update('B3800')">승인</button>
		<button onclick="connect_update('B3802')">거절</button>
	</div>

	<div id="approval_list" style="display: none;">
		<h3>승인 한 리스트</h3>
		
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회원 아이디</td>
				<td>회원 이름</td>
				<td><pre>		</pre></td>
				<td>기업 아이디</td>
				<td>기업 일어명</td>
				<td>기업 영문명</td>
			</tr>
			<tbody class="before-approval-table-tbd">
			<c:forEach var="data" items="${user_approval_list}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="approval_seq_list" value="${data.fap_comp_user_connect_seq}"></td>
					<td>${userApprovalLoadNum - (status.count-1)}</td>
					<td>${data.user_id}</td>
					<td>${data.user_nm}</td>
					<td></td>
					<td>${data.fap_comp_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="before-pagetwo">
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage - repNaviTwo.pagePerGroup})">◁◁</a>
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage - 1})">◀</a>
			<c:forEach var="i" begin="${repNaviTwo.startPageGroup}" end="${repNaviTwo.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviTwo.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="javascript:changePageLoadListTwo(${i})">${i}</a>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage + 1})">▶</a>
		<a href="javascript:changePageLoadListTwo(${repNaviTwo.currentPage + repNaviTwo.pagePerGroup})">▷▷</a>
		</div>
		
		<button onclick="connect_delete('approval')">삭제</button>
	</div>

	<div id="refusal_list" style="display: none;">
		<h3>거절 한 리스트</h3>
		
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회원 아이디</td>
				<td>회원 이름</td>
				<td><pre>		</pre></td>
				<td>기업 아이디</td>
				<td>기업 일어명</td>
				<td>기업 영문명</td>
			</tr>
			<tbody class="before-refusal-table-tbd">
			<c:forEach var="data" items="${user_refusal_list}" varStatus="status">
				<tr>
					<td><input type="checkbox" name="refusal_seq_list" value="${data.fap_comp_user_connect_seq}"></td>
					<td>${userRefusalLoadNum - (status.count-1)}</td>
					<td>${data.user_id}</td>
					<td>${data.user_nm}</td>
					<td></td>
					<td>${data.fap_comp_id}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="before-pagethree">
		<a href="javascript:changePageLoadListThree(${repNaviThree.currentPage - repNaviThree.pagePerGroup})">◁◁</a>
		<a href="javascript:changePageLoadListThree(${repNaviThree.currentPage - 1})">◀</a>
			<c:forEach var="i" begin="${repNaviThree.startPageGroup}" end="${repNaviThree.endPageGroup}" step="1">
						
						<c:choose>					
							<c:when test="${i eq repNaviThree.currentPage}">
								<span class="now">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="javascript:changePageLoadListThree(${i})">${i}</a>
							</c:otherwise>
						</c:choose>							
			</c:forEach>
		<a href="javascript:changePageLoadListThree(${repNaviThree.currentPage + 1})">▶</a>
		<a href="javascript:changePageLoadListThree(${repNaviThree.currentPage + repNaviThree.pagePerGroup})">▷▷</a>
		</div>
		
		<button onclick="connect_delete('refusal')">삭제</button>
	</div>

</body>
</html>