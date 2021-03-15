<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<title>Soft Engineer Society</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width">
		<link rel="stylesheet" href="/resources/css/changbilms_player.css" />
		<!--[if lte IE 9]><script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script><![endif]-->
		<!--[if (gt IE 9) | (!IE)]><!--><script type="text/javascript" src="/resources/js/jquery-3.2.1.min.js"></script><!--<![endif]-->
		<script type="text/javascript" >
		var pageArr = new Array();
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
// 				studyTimer();
				/*
				 if (typeof (window.frames[0].CallContext) == "function"){
					 
				 }
		         else
		        	 window.close();
				*/ 
				var portYn = '${classParam.portYn}';
				if(portYn == 'Y') {
					//포팅인 경우 getMessage를 통해 이벤트 등록
					getMessage();
				} else if(portYn == 'N'){
					//링크인 경우 학습하기 클릭 시 수강인정
					setProg_YN_Link();
				}
			});
			
			//자식창에서 수강이 끝난 페이지 정보와 전체 페이지 수 정보를 가져온다
			function getMessage() {
				window.addEventListener('message', function(e){
					//포팅컨텐츠용(htm의 각 페이지 수강이 완료되면 페이지 번호가 날아옴)
					//추후 그냥 true 날아오는걸로 통일예정
					if(e.data.nowPageNum !== undefined) {
						setProg_YN(e.data.nowPageNum);
					}
					//자체컨텐츠용(수강완료되면 complete:true가 날아옴)
					if(e.data.complete == true) {
						setProg_YN_Link();
					}
				});
			}
			//수강처리(포팅방식)
			function setProg_YN(nowPageNum) {
				var params = {};
				params.id = '${classParam.id}';
				params.cardinal = '${classParam.cardinal}';
				params.course = '${classParam.course}';
				params.chasi = '${classParam.chasi}';
				params.portYn = '${classParam.portYn}';
				params.order = nowPageNum;
				
				$.ajax({
					url:"<c:url value='/lms/user/setProgYn' />",
					data:params,
					datatype:"json",
					cache:false,
					async: false,
					type:"POST",
					success:function(data) {
						opener.parent.setModal();
						opener.parent.$('#modalTab>.modal-tabGroup>li:eq(1)').trigger('click');
					},
					error:function(e, t) {
					}
				});
			}
			//수강처리(링크방식)
			function setProg_YN_Link() {
				var params = {};
				params.id = '${classParam.id}';
				params.cardinal = '${classParam.cardinal}';
				params.course = '${classParam.course}';
				params.chasi = '${classParam.chasi}';
				params.portYn = '${classParam.portYn}';
				params.att_id = '${classParam.att_id}';
				
				$.ajax({
					url:"<c:url value='/lms/user/setProgYnLink' />",
					data:params,
					datatype:"json",
					cache:false,
					async: false,
					type:"POST",
					success:function(data) {
						opener.parent.setModal();
						opener.parent.$('#modalTab>.modal-tabGroup>li:eq(1)').trigger('click');
					},
					error:function(e, t) {
					}
				});
			}
			function loadContent() {
				var darakwon = '${chapterInfo.DARAKWON}';

				var frWidth = '${chapterInfo.WIDTH}';
				var frHeight = '${chapterInfo.HEIGHT}';
				/* if (${currentDevice.mobile }) {
					frWidth = frHeight = 0;
				} */

				if (frWidth == 0 || frHeight == 0 ) {
					frWidth = $("#lecturePlayer").width();
					frHeight = $("#lecturePlayer").height();
				}

				$('#viewer').css("width", frWidth);
				if(frHeight>730)
					$('#viewer').css("height", frHeight-4);
				$('#viewer').css("height", "740px");
				
				var pc_url = '${chapterInfo.MAIN_URL }';
				var mo_url = '${chapterInfo.MOBILE_URL }';

				/* 다락원 과정이면 페이지를 리다이렉트 시킨다. */
				if (darakwon == 'Y') {
					if (chekMoba()) {
						window.location.href=mo_url;
					} else {
						window.location.href=pc_url;
					}
					//다락원 과정: 링크방식이기 때문에 진도체크 함수 적용불가
					setProg_YN_Link();
				}
				//개발시에는 모두 리다이렉트 시켜서 서버상의 컨텐츠 js코드 확인
// 				window.location.href=pc_url;
				/* if (${currentDevice.mobile }) {
					url = '${chapterInfo.MOBILE_URL }';
				} */
				
				if(chekMoba()){
					frWidth = frHeight = 0;
					
					 var contStr='';
					  contStr+='<video width="352" height="198" controls autoplay>';
					  contStr+='<source type="application/x-mpegURL" src="'+ mo_url +'" />';
					  contStr+='</video>';
					  
					  $('#playerDiv').html(contStr);
					
				}else{
					$('#viewer').attr('src', pc_url);
					
				}
			}
			
			function chekMoba() {
				  var check = false;
				  (function(a){if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) check = true;})(navigator.userAgent||navigator.vendor||window.opera);
				  return check;
				};
		</script>
		<style>
		video {
			position: fixed;
			right: 0;
			bottom: 0;
			min-width: 100%;
			min-height: 100%;
    	}
		</style>
	</head>
	<body>
		<div class="lecturePlayer" id="lecturePlayer">
			<div class="body" style="overflow:hidden;">
				<div id="playerDiv">
					<iframe name="viewer" id="viewer" src=""  scrolling="no" webkitAllowFullScreen="true" mozallowfullscreen="true" allowFullScreen="true" style=";margin:0px auto;border:0px;overflow:hidden;width:100%;height:730px;" width="100%" ></iframe>
				</div>
			</div><!--//.body-->
		</div>
	</body>
</html>