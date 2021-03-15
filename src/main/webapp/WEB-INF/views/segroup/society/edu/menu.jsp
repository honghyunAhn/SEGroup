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
					<li class="ico_login"><a href="/edu/user/user_login_form">로그인</a></li>
					<li class="ico_join"><a href="/edu/user/user_join_terms">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<li class="ico_mypage"><a href="/edu/user/user_update_form">마이페이지</a></li>
					<li class="ico_loginout"><a href="#none" id="logout">로그아웃</a></li>
				</c:otherwise>
			</c:choose>
			<!-- 			<li class="ico_come"><a -->
			<!-- 				href="http://ict.sesoc.global/" target="_blank" -->
			<!-- 				onclick="popup(this)">오시는길</a></li> -->
		</ul>
	</div>
</div>
<div class="main_top_menu">
	<ul class="main_top_m">
		<li><a href="/ictcenter">Home</a></li>
		<li>
			<!-- <a href="/ictcenter">K-Move 스쿨</a> --> <a href="javascript:void(0);">해외취업과정</a>
			<div class="depth2">
				<ul class="sublinks">
					<li><a href="/edu/apply/kmove">SW DO 마스터(광주-본과정)</a></li>
<!-- 					<li><a href="/edu/apply/scitmaster_seoul">SC IT 마스터(서울-본과정)</a></li> -->
					<li><a href="/edu/apply/cup">마스터 사전학습(서울/광주-CUP)</a></li>
<!-- 					<li><a href="/edu/apply/japanjob">KITA 일본취업학교</a></li> -->
<!-- 					<li><a href="/edu/apply/usintern">미국 융·복합 S/W 인력양성 과정</a></li> -->
					<!-- <li><a href="http://ict.sesoc.global:8888/member/courseJoinForm">과정설명회(서울/광주)</a></li> -->
				</ul>
			</div>
		</li>
		<!-- <li><a href="/edu/apply/cup">사전학습반</a></li> -->
		<!-- <li><a href="/edu/apply/it101_menu">IT 101</a></li> -->
		<!-- 		당분간 서비스 안함 -->
		<!-- 		<li><a href="/edu/apply/oracle_menu">Oracle</a></li> -->
		<li>
			<!-- <a href="/ictcenter">단기 과정</a> --> 
			<a href="javascript:void(0);">단기과정</a>
			<div class="depth2">
				<ul class="sublinks">
<!-- 					<li> -->
<!-- 						<a href="/edu/apply/short_term_c1">C언어</a> -->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_c1">입문: C 뿌리기-1부</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_c2">초급: C 뿌리기-2부</a></li> -->
<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<a href="/edu/apply/short_term_java1">JAVA</a> -->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_java1">입문: 누구나 JAVA-1부</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_java2">초급: 누구나 JAVA-2부</a></li> -->
<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
<!-- 					<li> -->
<!-- 						<a href="/edu/apply/short_term_springboot2">웹 개발</a> -->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_springboot2">최신: 쉽게 배우는 Spring Boot 2</a></li> -->
<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<li>
						<a href="/edu/apply/short_term_python">파이썬</a>
						<div class="depth3" style="display: none;">
							<ol class="sublinks">
								<li><a href="/edu/apply/short_term_python">파이썬 첫걸음</a></li>
							</ol>
						</div>
					</li>
<!-- 					<li> -->
<!-- 						<a href="#">일본어</a> -->
						<!--<a href="#">일본어(마스터)</a>-->
<!-- 						<div class="depth3" style="display: none;"> -->
<!-- 							<ol class="sublinks"> -->
<!-- 								<li><a href="/edu/apply/short_term_japan_business">비즈니스 회화 첫걸음</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_japan_freetalk">프리토킹 1:1개인지도(skype)</a></li> -->
<!-- 								<li><a href="/edu/apply/short_term_japan_jpt">JPT시험 대비반</a></li> -->

								<%--<li><a href="/edu/apply/short_term_work_in_japan">IT인재를 위한 일본취업 프로그램</a></li>  
								<li><a href="/edu/apply/short_term_japan_oa">일본어로 배우는 OA기초</a></li>
								<li><a href="/edu/apply/short_term_japan_on_demand">찾아가는 일본어(On-Demand)</a></li>
								<li><a href="/edu/apply/short_term_japan_employment">일본기업 취업전략</a></li>
								<li><a href="/edu/apply/short_term_japan_sjpt">내 마음대로 말하는 일본어!</a></li> --%>

<!-- 							</ol> -->
<!-- 						</div> -->
<!-- 					</li> -->
					<%--
					<li>
						<a href="#">일본어(일반)</a>
						<div class="depth3" style="display: none;">
							<ol class="sublinks">
								<li><a href="/edu/apply/short_term_japan_business_all">비즈니스 회화 첫걸음</a></li>
								<li><a href="/edu/apply/short_term_japan_freetalk_all">프리토킹 1:1개인지도(skype)</a></li>
								<li><a href="/edu/apply/short_term_japan_jpt_all">JPT시험 대비반</a></li>

								<%--<li><a href="/edu/apply/short_term_work_in_japan">IT인재를 위한 일본취업 프로그램</a></li>  
								<li><a href="/edu/apply/short_term_japan_oa">일본어로 배우는 OA기초</a></li>
								<li><a href="/edu/apply/short_term_japan_on_demand">찾아가는 일본어(On-Demand)</a></li>
								<li><a href="/edu/apply/short_term_japan_employment">일본기업 취업전략</a></li>
								<li><a href="/edu/apply/short_term_japan_sjpt">내 마음대로 말하는 일본어!</a></li> 

							</ol>
						</div>
					</li>--%>
				</ul>
			</div>
		</li>
		<li>
			<!-- <a href="/edu/community/notice">커뮤니티</a> --> <a href="javascript:void(0);">커뮤니티</a>
			<div class="depth2">
				<ul class="sublinks">
					<li><a href="/edu/community/notice">공지사항</a></li>
					<li><a href="/edu/community/media_in_it">미디어</a></li>
					<li><a href="/edu/community/graduate_community">졸업생 마당</a></li>
					<sec:authorize access="hasAnyRole('ROLE_A0101','ROLE_A0105','ROLE_A0106')">
						<li><a href="/edu/community/notice2">재학생 공지사항</a></li>
					</sec:authorize>
					<!--                     <li><a href="/edu/community/pds">자료실</a></li> -->
				</ul>
			</div>
		</li>
		<li>
			<!-- <a href="/edu/consulting/faq">상담센터</a> --> <a href="javascript:void(0);">상담센터</a>
			<div class="depth2">
				<ul class="sublinks">
					<li><a href="/edu/consulting/faq">FAQ</a></li>
					<li><a href="/edu/consulting/online_consulting">온라인 상담</a></li>
					<!-- 					<li style="padding-left: 0px;"><a href="/edu/consulting/offline_consulting">오프라인 상담 신청</a></li> -->
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