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

	function agency_company_connect() {
		// 채용 기업 아이디
		var company_id = $("input:radio[name='company_id']:checked").val();
		
		// 에이전시 아이디
		var agency_id = $("input:radio[name='agency_id']:checked").val();

		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			beforeSend: function(xhr) {
			     xhr.setRequestHeader("AJAX", true);
			}
			, url : '/fap/admin/agency_company_connect'
			, type : 'post'
			, data : {
				company_id : company_id
				, agency_id : agency_id
			}
			, success : function() {
				alert("정상 처리 되었습니다.");
				location.reload();
			}
			, error : function(e) {
				if(e.status == 403){
					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
					location.href = "/fap/admin/admin_login";
				}
			}
		});
		
	}
	
</script>

<script type="text/javascript">

//페이징관련 함수(회사)
function changePageLoadList(clickedPage) {
	
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'agency_company_connect_company_paging',
		type : 'post',
		data : {'clickedPage' : clickedPage},
        dataType : 'json', 
		success : function(map) {
			var totalCount = map.unconnectTotalCount;
			var currentPage = map.repNavi.currentPage;
			var pagePerGroup = map.repNavi.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1))
			
			$('.before-company-table-tbd').children().remove();
			var InfoContext = '';
			$('.before-page-ul').children().remove();
			var pageContext = '';
			
			//[start] 회사리스트 정보 innerHtml로 그려주기 시작
			$.each(map.unconnect_comp_list, function(index, companyLoadList){
				InfoContext += '<tr>';
				InfoContext += '<td><input type="radio" name="company_id" value="' + companyLoadList.fap_comp_id + '"></td>';
				InfoContext += '<td>' + (num - index) + '</td>';
				InfoContext += '<td>' + companyLoadList.fap_comp_ja_nm + '</td>';
				InfoContext += '<td>' + companyLoadList.fap_comp_en_nm + '</td>';
				InfoContext += '</tr>';					
			});
			//[end] 회사리스트 정보 inner로 그려주기 종료
			
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
			
			$('.before-company-table-tbd').append(InfoContext);
			$('.before-page-ul').append(pageContext);
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

//페이징관련 함수(에이전시)
function changePageLoadListTwo(clickedPage) {
	
	$.ajax({
		beforeSend: function(xhr) {
		     xhr.setRequestHeader("AJAX", true);
		},
		url : 'agency_company_connect_agency_paging',
		type : 'post',
		data : {'clickedPage' : clickedPage},
        dataType : 'json', 
		success : function(map) {
			var totalCount = map.agencyTotalCount;
			var currentPage = map.repNaviTwo.currentPage;
			var pagePerGroup = map.repNaviTwo.pagePerGroup;
			var num = totalCount - ((pagePerGroup) * (currentPage - 1))
			
			$('.before-agency-table-tbd').children().remove();
			var agencyInfoContext = '';
			$('.before-agency-page-ul').children().remove();
			var pageContextTwo = '';
			
			//[start] 에이전시 리스트 정보 innerHtml로 그려주기 시작
			$.each(map.select_agency_list, function(index, agencyLoadList){
				agencyInfoContext += '<tr>';
				agencyInfoContext += '<td><input type="radio" name="agency_id" value="' + agencyLoadList.fap_comp_id + '"></td>';
				agencyInfoContext += '<td>' + (num - index) + '</td>';
				agencyInfoContext += '<td>' + agencyLoadList.fap_comp_ja_nm + '</td>';
				agencyInfoContext += '<td>' + agencyLoadList.fap_comp_en_nm + '</td>';
				agencyInfoContext += '</tr>';					
			});
			//[end] 에이전시 리스트 정보 inner로 그려주기 종료
			
			//[start] 페이지정보 innerHtml로 그려주기 시작
			
			pageContextTwo += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage - map.repNaviTwo.pagePerGroup) + ')">◁◁</a>';
			pageContextTwo += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage - 1) + ')">◀</a>';
			
			for(var i=map.repNaviTwo.startPageGroup; i<=map.repNaviTwo.endPageGroup; i++){
				
				if(i == map.repNaviTwo.currentPage){
					pageContextTwo += '<span class="now">' + i + '</span>';
				}else{
					pageContextTwo += '<a href="javascript:changePageLoadListTwo(' + i + ')">' + i + '</a>';
				}
				
			}
			
			pageContextTwo += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage + 1) + ')">▶</a>';
			pageContextTwo += '<a href="javascript:changePageLoadListTwo(' + (map.repNaviTwo.currentPage + map.repNaviTwo.pagePerGroup) + ')">▷▷</a>';
			
			//[end] 페이지정보 inner로 그려주기 종료
			
			$('.before-agency-table-tbd').append(agencyInfoContext);
			$('.before-agency-page-ul').append(pageContextTwo);
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
		<h2>에이전시-기업 연결</h2>
	</div>
	<br>
		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>에이전시 일어명</td>
				<td>에이전시 영문명</td>
			</tr>
			<tbody class="before-agency-table-tbd">
			<c:forEach var="data" items="${select_agency_list}" varStatus="status">
				<tr>
					<td><input type="radio" name="agency_id" value="${data.fap_comp_id}"></td>
					<td>${agencyLoadNum - (status.count-1)}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		
		</table>
		<div class="before-agency-page-ul">
										
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
	
	
-------------------------------------------------------------------------------------------------------

		<table>
			<tr>
				<td></td>
				<td>No.</td>
				<td>회사 일어명</td>
				<td>회사 영문명</td>
			</tr>
			<tbody class="before-company-table-tbd">
			<c:forEach var="data" items="${unconnect_comp_list}" varStatus="status">
				<tr>
					<td><input type="radio" name="company_id" value="${data.fap_comp_id}"></td>
					<td>${companyLoadNum - (status.count-1)}</td>
					<td>${data.fap_comp_ja_nm}</td>
					<td>${data.fap_comp_en_nm}</td>
				</tr>
			</c:forEach>
			</tbody>
		
		</table>
		<div class="before-page-ul">
										
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

	<button onclick="agency_company_connect()">연결</button>

</body>
</html>