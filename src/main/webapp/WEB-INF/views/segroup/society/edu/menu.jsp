<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<script src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.5/dist/loadingoverlay.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#logout').off("click").on("click", function() {
			$('#logoutForm').submit();
			return false;
		});
	});

	function openWindow_img(url) {
		window.open(url, '_blank');
		window.focus();
	}
</script>
<script>
$(function(){
	$('.main_top_m > li a, .sub_top_hidden').off("mouseenter");
	$('.main_top_m, .sub_top_hidden').off("mouseleave");

	var sub_top_hidden_height = 50;
    var sub_top_hidden2_height = 0;
    var animation_duration = 150;

	$('.main_top_m > li a').mouseenter(function(e){
		var depth2 = $(this).next(".depth2").clone();
		if(depth2.length!=0){
			$('.sub_top_hidden').html(depth2.html());
			$(".sub_top_hidden").stop().fadeOut("fast");
			$(".sub_top_hidden").show();
			$(".sub_top_hidden").stop().animate({
				height:sub_top_hidden_height
			},{
				duration:animation_duration,
				queue:false,
				complete:function(){
					$(".sub_top_hidden").stop().fadeIn("fast");
				}
			});
			
			$('.sublinks > li a').off("mouseenter").mouseenter(function(e){
				var depth3 = $(this).next(".depth3").clone();
				if(depth3.length!=0){
					$('.sub_top_hidden2').html(depth3.html());
					$(".sub_top_hidden2").stop().fadeOut("fast");
					if($(this).next("div").find("ol").length==0){
						sub_top_hidden2_height = 50;
					}else{
						var li_length = 0;
						$.each($(this).next("div").find("ol"), function(index,item){
							li_length += $(this).find("li").length;
						});
						sub_top_hidden2_height = 50 + (li_length * 25);
					}
					
					var left_var = $(this).offset().left;
					$(".sub_top_hidden2").css("left", left_var);
					
					$(".sub_top_hidden2").show();
					$(".sub_top_hidden2").stop().animate({
						height:sub_top_hidden2_height
					},{
						duration:animation_duration,
						queue:false,
						complete:function(){
							$(".sub_top_hidden2").stop().fadeIn(animation_duration);
						}
					})
				} else {
					$(".sub_top_hidden2").stop().fadeOut(animation_duration);
					$(".sub_top_hidden2").stop().animate({
						height:0
					},{
						duration:animation_duration,
						queue:false,
						complete:function(){
							$(".sub_top_hidden2").hide();
						}
					});
				}
			});
		}
	});

	$('.sub_top_hidden').mouseenter(function(e){
		$(".sub_top_hidden").show();
		$(".sub_top_hidden").stop().animate({
			height:sub_top_hidden_height
		},{
			duration:animation_duration,
			queue:false,
			complete:function(){
				$(".sub_top_hidden").stop().fadeIn(animation_duration);
			}
		});

		if($(".sub_top_hidden2").height() > 0) {
			$(".sub_top_hidden2").show();
			$(".sub_top_hidden2").stop().animate({
				height:sub_top_hidden2_height
			},{
				duration:animation_duration,
				queue:false,
				complete:function(){
					$(".sub_top_hidden2").stop().fadeIn(animation_duration);
				}
			});
		}
	});

	$('.sub_top_hidden2').mouseenter(function(e){
		$(".sub_top_hidden").show();
		$(".sub_top_hidden").stop().animate({
			height:sub_top_hidden_height
		},{
			duration:animation_duration,
			queue:false,
			complete:function(){
				$(".sub_top_hidden").stop().fadeIn(animation_duration);
			}
		});
		
		$(".sub_top_hidden2").show();
		$(".sub_top_hidden2").stop().animate({
			height:sub_top_hidden2_height
		},{
			duration:animation_duration,
			queue:false,
			complete:function(){
				$(".sub_top_hidden2").stop().fadeIn(animation_duration);
			}
		});
	});

	$('.main_top_m, .sub_top_hidden, .sub_top_hidden2').mouseleave(function(){
		$(".sub_top_hidden, .sub_top_hidden2").stop().fadeOut(animation_duration);
		$(".sub_top_hidden, .sub_top_hidden2").stop().animate({
			height:0
		},{
			duration:animation_duration,
			queue:false,
			complete:function(){
				$(".sub_top_hidden, .sub_top_hidden2").hide();
			}
		});
	});
});
</script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Droid+Serif:400i|Open+Sans:400,600,700,800');
#main_menu {
	font-family: 'Open Sans', sans-serif;
	font-weight: 800;
	color: black;
	font-size: 30px;
	margin-left: 10px;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

.header_mainlogo .sub_top_hidden .sublinks:first-child {
	margin-left: 20px;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 30%; /* Could be more or less, depending on screen size */
}
.sub_top_hidden {height: 0px;}
.sub_top_hidden2 {width: 220px; height: 0px; margin: 0; overflow: hidden; position: absolute; z-index: 9999}
.sub_top_hidden2 {display: none; overflow: hidden; padding: 0 0 10px 0; background: #fbfbfb;}
.sub_top_hidden2 .sublinks {float: center; width: 220px; box-sizing: border-box;}
.sub_top_hidden2 .sublinks > li {float: center; padding-top:5%; padding-left: 5%; padding-right: 5%;}
.sub_top_hidden2 .sublinks > li a {margin-bottom: 10px; font-size: 14px; color: #444; font-weight: bold; padding: 5px 0px 0px 0px;}
.sub_top_hidden2 .sublinks > li a:hover {color: #105ba3;}
</style>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="details" var="check" />
</sec:authorize>
<form id="logoutForm" action="/edu/logout" method="post" style="display: none">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<div class="main_top_header"></div>
<div class="header">
	<div class="header_mainlogo" style="width: 600px;">
		<a href="/ictcenter">
			<img style="height: 34px; vertical-align: bottom;" src="/resources/segroup/images/classic/logo.png" alt="logo" />
		</a>
	</div>
	<div class="header_navimenu">
		<ul>
			<c:choose>
<%-- 				<c:when test="${empty check }"> --%>
				<c:when test="${sessionScope.user_id eq null}">
					<li class="ico_login"><a href="/edu/user/user_login_form">?????????</a></li>
					<li class="ico_join"><a href="/edu/user/user_join_terms">????????????</a></li>
				</c:when>
				<c:otherwise>
					<li class="ico_mypage"><a href="/edu/user/user_update_form">???????????????</a></li>
					<li class="ico_loginout"><a href="#none" id="logout">????????????</a></li>
				</c:otherwise>
			</c:choose>
			<!-- 			<li class="ico_come"><a -->
			<!-- 				href="http://ict.sesoc.global/" target="_blank" -->
			<!-- 				onclick="popup(this)">????????????</a></li> -->
		</ul>
	</div>
</div>
<div class="main_top_menu">
	<ul class="main_top_m">
		<li><a href="/ictcenter">Home</a></li>
		<li>
			<!-- <a href="/ictcenter">K-Move ??????</a> --> <a href="javascript:void(0);">??????????????????</a>
			<div class="depth2">
				<ul class="sublinks">
					<li><a href="/edu/apply/kmove">SW DO ?????????(??????-?????????)</a></li>
<!-- 					<li><a href="/edu/apply/scitmaster_seoul">SC IT ?????????(??????-?????????)</a></li> -->
					<li><a href="/edu/apply/cup">????????? ????????????(??????/??????-CUP)</a></li>
<!-- 					<li><a href="/edu/apply/japanjob">KITA ??????????????????</a></li> -->
<!-- 					<li><a href="/edu/apply/usintern">?????? ??????????? S/W ???????????? ??????</a></li> -->
					<!-- <li><a href="http://ict.sesoc.global:8888/member/courseJoinForm">???????????????(??????/??????)</a></li> -->
				</ul>
			</div>
		</li>
		<!-- <li><a href="/edu/apply/cup">???????????????</a></li> -->
		<!-- <li><a href="/edu/apply/it101_menu">IT 101</a></li> -->
		<!-- 		????????? ????????? ?????? -->
		<!-- 		<li><a href="/edu/apply/oracle_menu">Oracle</a></li> -->
		<li>
			<!-- <a href="/ictcenter">?????? ??????</a> --> 
			<a href="javascript:void(0);">????????????</a>
			<div class="depth2">
				<ul class="sublinks">
<!-- 					<li> -->
<!-- 						<a href="/edu/apply/short_term_c1">C??????</a> -->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_c1">??????: C ?????????-1???</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_c2">??????: C ?????????-2???</a></li> -->
<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<a href="/edu/apply/short_term_java1">JAVA</a> -->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_java1">??????: ????????? JAVA-1???</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_java2">??????: ????????? JAVA-2???</a></li> -->
<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<a href="/edu/apply/short_term_springboot2">??? ??????</a> -->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_springboot2">??????: ?????? ????????? Spring Boot 2</a></li> -->
<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<li>
						<a href="/edu/apply/short_term_python">?????????</a>
						<div class="depth3" style="display: none;">
							<ol class="sublinks">
								<li><a href="/edu/apply/short_term_python">????????? ?????????</a></li>
							</ol>
						</div>
					</li>
<!-- 					<li> -->
<!-- 						<a href="#">?????????</a> -->
						<!--<a href="#">?????????(?????????)</a>-->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_japan_business">???????????? ?????? ?????????</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_japan_freetalk">???????????? 1:1????????????(skype)</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_japan_jpt">JPT?????? ?????????</a></li> -->

								<%--<li><a href="/edu/apply/short_term_work_in_japan">IT????????? ?????? ???????????? ????????????</a></li>  
								<li><a href="/edu/apply/short_term_japan_oa">???????????? ????????? OA??????</a></li>
								<li><a href="/edu/apply/short_term_japan_on_demand">???????????? ?????????(On-Demand)</a></li>
								<li><a href="/edu/apply/short_term_japan_employment">???????????? ????????????</a></li>
								<li><a href="/edu/apply/short_term_japan_sjpt">??? ???????????? ????????? ?????????!</a></li> --%>

<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<%--
					<li>
						<a href="#">?????????(??????)</a>
						<div class="depth3" style="display: none;">
							<ol class="sublinks">
								<li><a href="/edu/apply/short_term_japan_business_all">???????????? ?????? ?????????</a></li>
								<li><a href="/edu/apply/short_term_japan_freetalk_all">???????????? 1:1????????????(skype)</a></li>
								<li><a href="/edu/apply/short_term_japan_jpt_all">JPT?????? ?????????</a></li>

								<%--<li><a href="/edu/apply/short_term_work_in_japan">IT????????? ?????? ???????????? ????????????</a></li>  
								<li><a href="/edu/apply/short_term_japan_oa">???????????? ????????? OA??????</a></li>
								<li><a href="/edu/apply/short_term_japan_on_demand">???????????? ?????????(On-Demand)</a></li>
								<li><a href="/edu/apply/short_term_japan_employment">???????????? ????????????</a></li>
								<li><a href="/edu/apply/short_term_japan_sjpt">??? ???????????? ????????? ?????????!</a></li> 

							</ol>
						</div>
					</li>--%>
				</ul>
			</div>
		</li>
		<li>
			<!-- <a href="/edu/community/notice">????????????</a> --> <a href="javascript:void(0);">????????????</a>
			<div class="depth2">
				<ul class="sublinks">
					<li><a href="/edu/community/notice">????????????</a></li>
					<li><a href="/edu/community/media_in_it">?????????</a></li>
					<li><a href="/edu/community/graduate_community">????????? ??????</a></li>
					<sec:authorize access="hasAnyRole('ROLE_A0101','ROLE_A0105','ROLE_A0106')">
						<li><a href="/edu/community/notice2">????????? ????????????</a></li>
					</sec:authorize>
					<!--                     <li><a href="/edu/community/pds">?????????</a></li> -->
				</ul>
			</div>
		</li>
		<li>
			<!-- <a href="/edu/consulting/faq">????????????</a> --> <a href="javascript:void(0);">????????????</a>
			<div class="depth2">
				<ul class="sublinks">
					<li><a href="/edu/consulting/faq">FAQ</a></li>
					<li><a href="/edu/consulting/online_consulting">????????? ??????</a></li>
					<!-- 					<li style="padding-left: 0px;"><a href="/edu/consulting/offline_consulting">???????????? ?????? ??????</a></li> -->
				</ul>
			</div>
		</li>
		<li style="float: right;">
            <a href="#none" onclick="openWindow_img('https://blog.naver.com/scitmaster')">
                <img src="/resources/segroup/society/edu/image/main/sns_img_naverblog.png">
			</a>
			<a href="#none" onclick="openWindow_img('https://www.facebook.com/smart.cloud.master/')">
                <img src="/resources/segroup/society/edu/image/main/sns_img_facebook.png">
			</a>
            <a href="#none" onclick="openWindow_img('https://www.youtube.com/channel/UCCsiCEQ8g6PacQLuJEYEWpw?view_as=subscriber')">
                <img src="/resources/segroup/society/edu/image/main/sns_img_youtube.png">
			</a>
			<a href="#none" onclick="openWindow_img('https://www.instagram.com/scitmaster/')">
                <img src="/resources/segroup/society/edu/image/main/sns_img_instargram.png">
			</a>
		</li>
	</ul>
</div>
<div class="sub_top_hidden"></div>
<div class="sub_top_hidden2"></div>