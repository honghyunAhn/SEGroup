<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>지원 가능 과정(기수) 목록</title>
<script type="text/javascript">
	var myApp = angular.module('myapp', []);
	
	myApp.directive('code', ['$http',function($http){
		return {
			restrict: "E",
			replace: true,
			scope : {
				value : '@'
			},
			controller: function ($scope, $element, $attrs) {
				$http({
					method: 'POST',
					url: '/codeconverter',
			  		responseType: 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
		    		$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			,template: "<span>{{filterParams}}</span>"
		}
	}]);

	$(function() {
        $(window).scroll(function() {
        	if ($(this).scrollTop() > 10) {
                $('#MOVE_TOP_BTN').fadeIn();
            } else {
                $('#MOVE_TOP_BTN').fadeOut();
            }
        });
        
        $("#MOVE_TOP_BTN").click(function() {
            $('html, body').animate({
                scrollTop : 0
            }, 400);
            return false;
        });
    });
</script>
</head>
<body ng-app="myapp">
<a id="MOVE_TOP_BTN" href="#none"><img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기"></a>
 <c:forEach var="data" items="${longTermList }" varStatus="status">
 	<div>
	 	${status.count } | ${data.gisu_crc_nm } | ${data.gisu_num } | ${data.gisu_crc_st } ~ ${data.gisu_crc_et } | ${data.gisu_app_st } ~ ${data.gisu_app_et } | ${data.gisu_crc_days }일 |
	 

        <c:choose>
	 		<c:when test="${data.gisu_result == 'B1600'}">
			 	<a href="/edu/apply/apply_form?gisu_seq=${data.gisu_seq }" class="gisu_insert"><code value="${data.gisu_result }"></code></a> <br />
	 		</c:when>
	 		<c:when test="${data.gisu_result == 'B1601'}">
	 			<a href="/edu/apply/apply_update_form?gisu_seq=${data.gisu_seq }" class="gisu_update"><code value="${data.gisu_result }"></code></a> <br />
	 		</c:when>
	 		<c:otherwise>
	 			<code value="${data.gisu_result }"></code><br />
	 		</c:otherwise>
	 	</c:choose>
	 	
 	</div>
 </c:forEach>
 
</body>
</html>