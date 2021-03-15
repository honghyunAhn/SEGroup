<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<!-- 
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " /> -->
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-105593058-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-105593058-2');
</script>
<title>글로벌 엔지니어 양성</title>
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
<style>
.linner {
	overflow: hidden;
	width: 100%;
	height: 10px;
}
.top_img {
    position: relative;
    background-image: url(/resources/segroup/society/edu/image/main/top_img/top_img_scitmaster_intro.jpg);                                                               
    height: 250px;
    background-size: cover;
}
</style>

</head>
<body ng-app="myapp">
	<%@include file="../menu.jsp"%>
	<a id="MOVE_TOP_BTN" href="#none"><img src="/resources/segroup/society/edu/image/sub/top.png" style="width: 60px; height: 60px;" title="위로가기"></a>
	<div>
		<div class="top_img">
			<div class="top_img_text">
				<p class="top_img_text1">KITA 일본취업학교</p>
				<p class="top_img_text2"></p>
			</div>
		</div>
	</div>

	<div style="overflow: hidden; width: 100%; height: 50px;"></div>

	<div class="sub_m_contents">
		<div class="main_top_slidewrap">
			<!-- <img src="edu/apply/ckeditor/debops.png" /> -->
			<%-- 잠시 주석 처리 2018. 10. 10. 김준영
			<img src="${path }/${seaCurriculum.crc_infoimg01 }" />
			<c:if test="${seaCurriculum.crc_infoimg02 ne null}">
                <img src="${path }/${seaCurriculum.crc_infoimg02 }" />
			</c:if> --%>
			
				<img src="/edu/admin/curriculum_gisu_insert_image/20200630.jpg" width="1024px" >
			

			<div class="linner"></div>
            <div style="display: flex; align-items: center; justify-content: center; margin: 50px;">
                <c:choose>
                    <c:when test="${seaCurGisu.gisu_result == 'B1600'}">
                        <a href="/edu/apply/apply_form?gisu_seq=${seaCurGisu.gisu_seq }"
                            class="gisu_insert"><input type="button" class="confirms_btn"
                            value="지원하기"></a>
                    </c:when>
                    <c:when test="${seaCurGisu.gisu_result == 'B1601'}">
                        <a href="/edu/apply/apply_update_form?gisu_seq=${seaCurGisu.gisu_seq }"
                            class="gisu_update"><input type="button" class="confirms_btn"
                            value="지원하기"></a>
                    </c:when>
                    <c:otherwise>
                        <h2>지원기간에 해당하는 과정이 없습니다</h2>
                    </c:otherwise>
                </c:choose>
            </div>
		</div>
	</div>
	<%@include file="../footer.jsp"%>
</body>
</html>