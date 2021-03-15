<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="/resources/js/printThis.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#layerLearnPlan .cl-popup-closer, #layerLearnPlan .close').off('click');
	$('#layerLearnPlan .cl-popup-closer, #layerLearnPlan .close').click(function() {
		$(".cl-popup-overlay").removeClass("on");
	});

	$('#btnPrintLearnPlan').off('click');
	$('#btnPrintLearnPlan').click(function() {
		$('#layerLearnPlan').printThis();
	});
});
</script>

<link rel="stylesheet" href="<c:url value="/resources/css/print_popup.css"/>" />
<!--// 연수 계획서 팝업 -->
<div class="cl-popup-overlay" id="layerLearnPlan">
	<div class="cl-popup-wrap">
		<c:choose>
			<c:when test="${currentDevice.mobile }">
		<div class="cl-popup-box full">
			</c:when>
			<c:otherwise>
		<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
			</c:otherwise>
		</c:choose>
		<div class="popup-body">
			<div class="group learnSchedule print-wrap">

				<h3 class="print-title">연수 계획서</h3>
				<div class="section box">
					<ul class="info-list">
						<li class="learn-title"><em class="label">연수 과정명</em>
							<strong>${detail.NAME}</strong>
						</li>
						<li class="halfW"><em class="label">연수 영역</em>
							${detail.COURSE_CODE_NAME}
						</li>
						<li class="halfW"><em class="label">학점</em>
							${detail.CREDIT}학점(${detail.CREDIT_TIME}시간)
						</li>
						<li class="halfW clearL"><em class="label">강사</em>
							${detail.TEACHER_NAME}
						</li>
						<li class="halfW"><em class="label">기수</em> ${detail.CARDINAL_NAME}</li>
						<li class="clearL"><em class="label">연수 개요</em>
							${detail.SUMMARY}
						</li>
						<li><em class="label">연수 목표</em>
							${detail.PURPOSE}
						</li>
						<li><em class="label">연수 기간</em>
							${detail.LEARN_START_DATE}. ~ ${detail.LEARN_END_DATE}.
						</li>
						<li><em class="label">평가 기준</em>
								<c:choose>
									<c:when test="${detail.CREDIT eq '4' }">
							출석 고사(60점), 온라인 과제(20점), 온라인 시험(10점), 학습 참여도(10점)
									</c:when>
									<c:otherwise>
							온라인 과제(40점), 온라인 시험(40점), 학습 참여도(20점)
									</c:otherwise>
								</c:choose>
						</li>
						<li><em class="label">이수 기준</em>
							100점 만점 중 60점 이상, 학습 진도 90% 이상
						</li>
						<li><em class="label">교재</em>
							<c:if test="${not empty detail.MAIN_TB_NAME }">${detail.MAIN_TB_NAME }</c:if>
							<c:if test="${empty detail.MAIN_TB_NAME }">없음</c:if>

						</li>
						<li><em class="label">교구</em>
							<c:if test="${not empty detail.SUB_TB_NAME }">${detail.SUB_TB_NAME }</c:if>
							<c:if test="${empty detail.SUB_TB_NAME }">없음</c:if>
						</li>
						<li><em class="label">학습목차</em>
					<table class="table">
						<colgroup>
							<col width="60" />
							<col width="" />
							<col width="70" />
							<col width="80" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="item-no nth-1st">차시</th>
								<th scope="col" class="item-title">차시명</th>
								<th scope="col">강사명</th>
									<th scope="col">학습 시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${chapterList}" varStatus="status">
							<tr>
								<td class="item-no <c:if test="${status.index == 0 }">nth-1st</c:if>">${status.count}</td>
								<td class="item-title" style="text-align:left;padding:10px">${item.NAME}</td>
								<td>${item.TEACHER}</td>
								<td style="min-width:80px">${item.STUDY}분</td>
								<%-- <td style="min-width:80px">${item.STUDY2}</td> --%>
							</tr>
							</c:forEach>
						 	<c:if test="${empty chapterList}">
								<tr><td colspan="4">조회된 내용이 없습니다.</td></tr>
							</c:if>
						</tbody>
					</table></li>
				</ul>
				</div><!--//.section-->
			</div><!--//.group-->
		</div><!--//.popup-body-->
		<div class="popup-footer screen-only">
				<button class="btn primary w6em close">확인</button>
				<button class="btn w6em" id="btnPrintLearnPlan">인쇄하기</button>
		</div>
		</div><!--//.cl-popup-box-->
	</div><!--//.cl-popup-wrap-->
	<button class="cl-popup-closer">
		<span class="sr-only">닫기</span>
	</button>
</div><!--//.cl-popup-overlay-->
<!--// 연수 계획서 팝업 -->
