<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
$(document).ready(function(){
	$(".btnClose").click(function(){
		popupClose("popOnlineExamMyAnswer");
	});
});
</script>

<div class="cl-popup-overlay" id="popOnlineExamMyAnswer">
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
						<h5 class="popup-title">온라인 시험 결과/답안 확인</h5>
						<h3 class="popup-title"><span id="cardinal_name"></span>기 <span id="course_name"></span> 과정 온라인 시험</h3>
					</div>
					<div class="popup-body">
						<form id="myAnswerForm">
							<input type="hidden" name="quiz">
							<input type="hidden" name="id" value="${classParam.id }">
							<input type="hidden" name="cardinal" value="${classParam.cardinal }">
							<input type="hidden" name="course" value="${classParam.course }">
							<ul class="myanswer-summary group">
								<li><em class="label"></em> <span id="exam_num"></span></li>
								<li><em class="label">점수</em> <span class="danger"><strong><span id="total_score"></span>점</strong>(<span id="right_count"></span>/<span id="total_count"></span>)</span></li>
							</ul>
							<div class="section">
								<ol class="question-list" id="question-list">
									<li class="answer-right">
										<div class="item-header">
											다지선택형 문제 출력 <strong class="right-answer">(기재: 4번 / 정답: 4번)</strong>
										</div>
										<ol class="item-body">
											<li><span>객관식이며 1개만 선택할 수 있을 때는 라디오 버튼으로 출력</span></li><!-- li안에 span 태그 꼭 유지 시켜 주세요!!-->
											<li><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</span></li>
											<li><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% 객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </span></li>
											<li class="check right"><span>보기 4번.</span></li><!-- 정답에는 li에 check 클래스명 부여 -->
											<li><span>보기 5번.</span></li>
										</ol>
									</li>
									<li class="answer-unright">
										<div class="item-header">
											다지 선다형 문제 출력 <strong class="right-answer">(기재: 1번, 4번 / 정답: 1번, 3번)</strong>
										</div>
										<ol class="item-body">
											<li class="check right"><span>객관식이며 답을 여러개 체크 할 수 있는 경우 체크박스로 출력</span></li>
											<li><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력.</span></li>
											<li class="right"><span>객관식이며 각 항의 내용 길이가 길 경우를 위하여 각 항은 블록요소로 출력하며 항 내 행간은 글자 크기의 160%, 각 항간의 간격은 글자크기의 50% </span></li>
											<li class="check"><span>보기 4번.</span></li>
											<li><span>보기 5번.</span></li>
										</ol>
									</li>
								</ol>
							</div><!--//.section-->
							<div class="list-bottom alignC">
								<a href="#" class="btn w5em btnClose">닫기</a>
							</div>
						</form>
					</div><!--//.popup-body-->
				</div><!--//.cl-popup-box-->
			</div><!--//.cl-popup-wrap-->
			<button class="cl-popup-closer">
				<span class="sr-only">닫기</span>
			</button>
		</div>