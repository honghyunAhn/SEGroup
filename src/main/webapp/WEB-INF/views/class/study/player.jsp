<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<title>강의실 :: ${classInfo.NAME } - ${classParam.idx}차시</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width">
		<link rel="stylesheet" href="/resources/css/changbilms_player.css" />
		<!--[if lte IE 9]><script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script><![endif]-->
		<!--[if (gt IE 9) | (!IE)]><!--><script type="text/javascript" src="/resources/js/jquery-3.2.1.min.js"></script><!--<![endif]-->
		<script type="text/javascript" >
			(function($) {
				$.ajaxSetup({
				  beforeSend: function(xhr) {
				     xhr.setRequestHeader("AJAX", true);
				  },
				  error: function(xhr, status, err) {
				     if (xhr.status == 401) {
				    	 	console.log("http code:401");
				      } else if (xhr.status == 403) {
				    	  console.log("http code:403")
				      }
				  }
				});
			})(jQuery);

			$(document).ready(function(){
				$("#btnExit").click(function(){
					/* TODO - 강의창 종료전 호출해야할 로직이 있는 경우 이 부분에서 처리함.(진도 및 출석 등) */
					window.close();
				});

				$("#btnHide").click(function(){
					/*타이틀영역을 숨겨버리면 타이틀을 다시 보기위해서는 어떻게?*/
					$("#playerHeader").slideUp(300);
				});

				loadContent();
				studyTimer();
			});

			function loadContent() {
				var frWidth = '${chapterInfo.WIDTH}';
				var frHeight = '${chapterInfo.HEIGHT}';
				if (${currentDevice.mobile }) {
					frWidth = frHeight = 0;
				}

				if (frWidth == 0 || frHeight == 0 ) {
					frWidth = $("#lecturePlayer").width();
					frHeight = $("#lecturePlayer").height();
				}

				$('#viewer').css("width", frWidth);
				$('#viewer').css("height", frHeight-4);

				var url = '${chapterInfo.MAIN_URL }';
				if (${currentDevice.mobile }) {
					url = '${chapterInfo.MOBILE_URL }';
				}
				$('#viewer').attr('src', url);
			}

			//수강기록을 갱신(등록 및 업데이트)하는 함수
			function enrollStudyhistory() {
				/* TODO - ajax를 이용하여 controller를 호출 */
				var params = {};
				params.id = '${classParam.id}';
				params.cardinal = '${classParam.cardinal}';
				params.course = '${classParam.course}';
				params.chapter = '${classParam.chapter}';
				params.idx = '${classParam.idx}';
				params.time = seconds;

				$.ajax({
					url:"<c:url value='/class/study/enrollHistory' />",
					data:params,
					datatype:"json",
					cache:false,
					type:"POST",
					success:function(data) {
					},
					error:function(e, t) {
						//window.close();
					}
				});
			}

			var seconds = 0;//초기0초
			var pad = function(x) { return (x < 10) ? "0"+x : x; }
			//수강시간을 체크 및 화면갱신하는 함수
			function calculateTime() {
				seconds++;

				$("#timeH").text(pad(parseInt(seconds / (60*60))));
				$("#timeM").text(pad(parseInt(seconds / 60 % 60)));
				$("#timeS").text(pad(seconds % 60));
			}

			//시간계산과 서버 업데이트 진행.
			function studyTimer() {
				setInterval(calculateTime, 1000);
				<c:if test="${classParam.op != 'preview'}" >
					setInterval(enrollStudyhistory, 5000);
				</c:if>
			}

			$(window).on("orientationchange",function(){
				setTimeout(loadContent, 300);
			});
		</script>
	</head>
	<body>
		<div class="lecturePlayer" id="lecturePlayer">
			<div class="body" style="overflow:hidden;">
				<iframe name="viewer" id="viewer" src=""  scrolling="no" webkitAllowFullScreen="true" mozallowfullscreen="true" allowFullScreen="true" style=";margin:0px auto;border:0px;overflow:hidden;width:100%;height:100%;" width="100%" height="100%" ></iframe>
				<!-- <iframe name="mainFrame" id="mainFrame" src="" scrolling="no" webkitAllowFullScreen="true" mozallowfullscreen="true" allowFullScreen="true" style="width:100%;min-width:1000px;min-height:680px;margin:0px auto;border:0px;"></iframe> -->
				<!-- //동영상 재생
				<div class="player-zone w1024">
					<video controls>
						<source src="/resources/video/sample.mp4" type="video/mp4">
						<embed src="/resources/video/sample.wmv"/>
					</video>
				</div>
				-->
			</div><!--//.body-->
			<div class="footer">
			</div>
		</div><!--//.windowPopup-->
	</body>
</html>