<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(document).ready(function() {
	$(".btnOfflineAnswerClose").click(function(){
		popupClose("popOfflineExamAnswer");
	});
});

function showExamAnswer() {
	var params = $("#popOfflineExamAnswer #answerForm").serialize();
	$.ajax({
		url:'selectExamAnswerAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data) {
			if (data.result == "FAIL") {
				alert(data.message);
				return;
			}

			var classInfo = data.classInfo;
			var examInfo = data.examInfo;
			var reportInfo = data.reportInfo;
			var list = data.quizList;

			$("#popOfflineExamAnswer #question-list").empty();
			for (var i = 0; i < list.length; i++) {
				if (list[i].OS_TYPE == "O") { //O:객관식
					var quiz = "<li>";
					quiz += "<div class='item-header'>"+list[i].TITLE+"<strong class='right-answer'>(정답: "+list[i].O_ANSWER+"번)</strong></div>";
					quiz += "<ol class='item-body'>";
					quiz += "<li "+(list[i].O_ANSWER=="1"?"class='right'":"")+"><span>"+list[i].EXAM1+"</span></li>";
					quiz += "<li "+(list[i].O_ANSWER=="2"?"class='right'":"")+"><span>"+list[i].EXAM2+"</span></li>";
					quiz += "<li "+(list[i].O_ANSWER=="3"?"class='right'":"")+"><span>"+list[i].EXAM3+"</span></li>";
					quiz += "<li "+(list[i].O_ANSWER=="4"?"class='right'":"")+"><span>"+list[i].EXAM4+"</span></li>";

					if(list[i].EXAM_TYPE == 2)
						quiz += "<li"+(list[i].O_ANSWER=="5"?"class='right'":"")+"><span>"+list[i].EXAM5+"</span></li>";

					quiz += "</ol>";
					quiz += "</li>";
					$("#popOfflineExamAnswer #question-list").append(quiz);
				} else { //S:주관식
					var quiz = "<li>";
					quiz += "<div class='item-header'>"+list[i].TITLE+"<strong class='right-answer'>(주관식 정답)</strong></div>";
					quiz += "<div class='item-body'>";
					quiz += "<label>"+list[i].S_ANSWER+"</label>";
					quiz += "</div>";
					quiz += "</li>";
					$("#popOfflineExamAnswer #question-list").append(quiz);
				}
			}

			$("#popOfflineExamAnswer #cardinal_name").text(classInfo.CARDINAL_NAME);
			$("#popOfflineExamAnswer #course_name").text(classInfo.NAME);

			popupOpen('popOfflineExamAnswer');
		},
		error:function(e) {
			alert("출석 고사 답안 정보 조회시 문제가 발생했습니다.");
		}
	});
}
</script>
<div class="cl-popup-overlay" id="popOfflineExamAnswer">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
			</c:otherwise>
		</c:choose>
			<div class="popup-header">
				<h3 class="popup-title">출석 고사 정답 확인</h3>
				<h3 class="popup-title"><span id="cardinal_name"></span>기 <span id="course_name"></span> 과정 출석 고사 정답안</h3>
			</div>
			<div class="popup-body">
				<form id="answerForm">
						<input type="hidden" name="id" value="${classParam.id }">
						<input type="hidden" name="cardinal" value="${classParam.cardinal }">
						<input type="hidden" name="course" value="${classParam.course }">

						<div class="section">
							<ol class="question-list" id="question-list">
								<li>
									<div class="item-header">
										다지선택형 문제 출력 <strong class="right-answer">(정답: 4번)</strong>
									</div>
									<ol class="item-body">
										<li><span>객관식이며 1개만 선택할 수 있을 때는 라디오 버튼으로 출력</span></li><!-- li안에 span 태그 꼭 유지 시켜 주세요!!-->
										<li><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</span></li>
										<li><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% 객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </span></li>
										<li class='right'><span>보기 4번.</span></li><!-- 정답에는 li에 check 클래스명 부여 -->
										<li><span>보기 5번.</span></li>
									</ol>
								</li>
								<li>
									<div class="item-header">
										다지 선다형 문제 출력 <strong class="right-answer">(정답: 1번, 3번)</strong>
									</div>
									<ol class="item-body">
										<li class="right"><span>객관식이며 답을 여러개 체크 할 수 있는 경우 체크박스로 출력</span></li>
										<li><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</span></li>
										<li class="right"><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </span></li>
										<li><span>보기 4번.</span></li>
										<li><span>보기 5번.</span></li>
									</ol>
								</li>
							</ol>
						</div><!--//.section-->
						<div class="list-bottom alignC">
							<a href="#" class="btn w5em btnOfflineAnswerClose">닫기</a>
						</div>
					</form>
			</div><!--//.popup-body-->
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div>