<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
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

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
	$(function() {
		initialize();
		$("#pageSelect")
				.change(
						function() {
							var pageCount = $(this).val();
							location.href = "${path}/edu/admin/offline_manager_form?pageCount="
									+ pageCount
									+ "&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}";
						});
	});

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

	function initialize(){
		var orderType = $("#orderType").val();
		var orderValue = $("#orderValue").val();
		
		$.each($(".arrow"),function(index, item){
			if($(this).hasClass(orderType) && orderValue == 'asc'){
				$(this).removeClass('desc').addClass(orderValue);
				$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_up.png');
			}else{
				$(this).removeClass('asc').addClass(orderValue);
				$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_down.png');
			}
		});
	}

	//**원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
	function ilist(page) {
		location.href = "${path}/edu/admin/offline_manager_form?pageCount=${map.pageCount}&curPage="
				+ page;
	}

	function order_change(orderType, target){
		var orderValue = '';
		
		if($(target).hasClass('desc')){
			$(target).removeClass('desc').addClass('asc');
			orderValue = 'asc';
		}else{
			$(target).removeClass('asc').addClass('desc');
			orderValue = 'desc';
		}
	    
	    location.href="${path}/edu/admin/offline_manager_form?pageCount=${map.pageCount}&curPage="+${map.adminPager.curPage}+"&orderType="+orderType+"&orderValue="+orderValue;
	}

	function toUpdateForm(seq) {
		$("#seq").val(seq);
		$("#update_form").submit();
	}
</script>
</head>
<body ng-app="myapp">
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>오프라인 상담 관리</h2>
		<h5>
			상담 관리 페이지&nbsp;&nbsp;&gt;&nbsp;&nbsp;<a href="offline_manager_form">오프라인
				방문상담 관리</a>
		</h5>
	</div>
	<div class="custom_div">
		<br />
		<br />
		<br /> <select id="pageSelect">
			<option value="10">10개씩</option>
			<c:forEach var="data" items="${map.adminPager.pageCountList}">
				<c:if test="${data == map.pageCount}">
					<option value="${data}" selected>${data}개씩</option>
				</c:if>
				<c:if test="${data != map.pageCount}">
					<option value="${data}">${data}개씩</option>
				</c:if>
			</c:forEach>
		</select>
		<table class="table">
			<thead>
				<tr>
					<th style="text-align: center;">번호</th>
					<th style="text-align: center;">이름</th>
					<th style="text-align: center;">성별&nbsp;<img class="arrow desc user_sex" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_sex', this)"></th>
					<th style="text-align: center;">나이&nbsp;<img class="arrow desc user_age" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_age', this)"></th>
					<th style="text-align: center;">전공</th>
					<th style="text-align: center;">전화번호</th>
					<th style="text-align: center;">이메일</th>
					<th style="text-align: center;">신청일자 및 시간&nbsp;<img class="arrow desc apply_datetime" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('apply_datetime', this)"></th>
					<th style="text-align: center;">신청제목</th>
					<th style="text-align: center;">등록날짜&nbsp;<img class="arrow desc user_ins_dt" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_ins_dt', this)"></th>
					<th style="text-align: center;">확인날짜&nbsp;<img class="arrow desc user_udt_dt" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_udt_dt', this)"></th>
					<th style="text-align: center;">담당자</th>
					<th style="text-align: center;">방문여부&nbsp;<img class="arrow desc user_visits" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('user_visits', this)"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="data" items="${resultList }" varStatus="status">
					<input type="hidden" class="hiddenClass" value="${data.seq }" />
					<tr>
						<td style="text-align: center;">${data.seq}</td>
						<td style="text-align: center;">${data.user_nm }</td>
						<td style="text-align: center;">${data.user_sex }</td>
						<td style="text-align: center;">${data.user_age }</td>
						<td style="text-align: center;">${data.user_major }</td>
						<td style="text-align: center;">${data.user_phone }</td>
						<td style="text-align: center;">${data.user_email }</td>
						<td style="text-align: center;">${data.apply_datetime }</td>
						<td><a href="javascript:toUpdateForm('${data.seq}')"
							class="updateClass">${data.apply_title }</a></td>
						<td style="text-align: center;">${data.user_ins_dt }</td>
                        <c:if test="${data.user_ins_dt != data.user_udt_dt}">
                            <td style="text-align: center;">${data.user_udt_dt }</td>
                        </c:if>
                        <c:if test="${data.user_ins_dt == data.user_udt_dt}">
                            <td style="text-align: center;"></td>
                        </c:if>
						<td style="text-align: center;">${data.user_udt_id }</td>
                        <c:if test="${data.user_visits == 0}">
                            <td></td>
                        </c:if>
                        <c:if test="${data.user_visits == 1}">
                            <td style="text-align: center;">상담완료</td>
                        </c:if>
                        <c:if test="${data.user_visits == 2}">
                            <td style="text-align: center;">불참</td>
                        </c:if>
					</tr> 
				</c:forEach>
			</tbody>
		</table>
		<input type="hidden" id="orderType" value="${map.orderType}">
		<input type="hidden" id="orderValue" value="${map.orderValue}">
	</div>

	<div class="pagination_wrap">
		<div class="pagination_con">
			<span id="page"
				style="display: inline; margin: auto; display: table;">
				<h4>
					<ul>
						<li>
							<ol>

								<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
								<c:if test="${map.adminPager.curBlock > 1}">
									<li><input type="button" onclick="javascript:ilist('1')"
										name="" value="<<"></li>
								</c:if>

								<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
								<c:if test="${map.adminPager.curBlock > 1}">
									<li><input type="button"
										onclick="javascript:ilist('${map.adminPager.prevPage}')"
										name="" value="<"></li>
								</c:if>

								<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
								<c:forEach var="num" begin="${map.adminPager.blockBegin}"
									end="${map.adminPager.blockEnd}">
									<!-- **현재페이지이면 하이퍼링크 제거 -->
									<c:choose>
										<c:when test="${num == map.adminPager.curPage}">
											<li><input type="button" style="color: red" name=""
												value="${num}"></li>
										</c:when>
										<c:otherwise>
											<li><input type="button"
												onclick="javascript:ilist('${num}')" name="" value="${num}"></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
								<c:if
									test="${map.adminPager.curBlock <= map.adminPager.totBlock}">
									<li><input type="button"
										onclick="javascript:ilist('${map.adminPager.nextPage}')"
										name="" value=">"></li>
								</c:if>

								<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
								<c:if test="${map.adminPager.curPage <= map.adminPager.totPage}">
									<li><input type="button"
										onclick="javascript:ilist('${map.adminPager.totPage}')"
										name="" value=">>"></li>
								</c:if>
							</ol>
						</li>
					</ul>
			</span>
			</h4>
		</div>
	</div>

	<form action="/edu/admin/offline_manager_detail_form" method="post"
		id="update_form">
		<input type="hidden" name="seq" id="seq" /> <input type="hidden"
			name="curPage" value="${curPage}"> <input type="hidden"
			name="pageCount" value="${pageCount}"> <input type="hidden"
			name="orderValue" value="${orderValue}"> <input type="hidden"
			name="orderType" value="${orderType}"> <input type="hidden"
			name="searchName" value="${searchName}"> <input type="hidden"
			name="searchTitle" value="${searchTitle}">
	</form>
</body>
</html>