<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<t:insertDefinition name="guideleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
			<a href="#">연수 안내</a>
			<a href="#">원격 연수</a>
			<a href="#">연수 연기/취소 방법</a>
		</p>
		<h2 class="sub-title">연수 연기/취소 방법</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>연수 연기</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 연수 연기는 신청한 연수 일정에 연수 수강이 어려울 경우, 신청한 연수 기간 이후의 일정으로 연기를 요청하는 것입니다.</li>
					<li>② 연수 연기는 연수 기간의 연장이 아니라 연수 기간의 연기이므로, 새로운 일정에 맞춰 학습이 시작되며, 진도/과제/시험 및 연수 지명 번호가 초기화됩니다.</li>
					<li>③ [나의 강의실] > [강의실] > [연수 연기/취소] 메뉴에서 진행할 수 있습니다.</li>
					<li>④ 연수 연기는 동일 과정에 한해 1회 까지만 가능합니다.</li>
				</ul>
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>연수 취소 및 환불 기준</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① [나의 강의실] > [강의실] > [연수 연기/취소] 메뉴에서 진행할 수 있습니다.</li>
					<li>② 연수 취소를 할 경우 연수 이수가 불가능하므로 신중히 결정하시기 바랍니다.</li>
					<li>③ 연수 취소에 따른 환불 기준은 아래와 같습니다.(『평생 교육법 제 23조, 대통령령 제28658호』)
						<table class="rule">
							<colgroup><col width="15%"><col width="25%"><col width=""></colgroup>
							<thead>
								<tr>
									<th class="nth-1st" scope="col">구분</th>
									<th scope="col">환불 사유 발생일</th>
									<th scope="col">환불 금액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="nth-1st" rowspan=3 >연수 기간이<br />30일 이내</td>
									<td >연수 시작일 전</td>
									<td >결제 금액 전액 환불</td>
								</tr>
								<tr>
									<td >총 연수 기간의 1/2 경과 전</td>
									<td >이용한 콘텐츠(강의 내용을 실제 연수한 차시를 말함)의 결제 금액 차감 후 환불</td>
								</tr>
								<tr>
									<td >총 연수 기간의 1/2 경과 후</td>
									<td >환불 불가</td>
								</tr>
								<tr>
									<td class="nth-1st" rowspan=2 >연수 기간이<br />30일 초과</td>
									<td >연수 시작일 전</td>
									<td >결제 금액 전액 환불</td>
								</tr>
								<tr>
									<td >연수 시작일 후</td>
									<td >반환 사유가 발생한 해당 월의 반환 대상 결제 금액<br />
(연수 기간이 1개월 이내인 경우의 기준에 따라 산출한 금액을 말함)과 나머지 월의 결제 금액의 전액을 합산</td>
								</tr>
								<tr>
									<td class="nth-1st" colspan=2>비고</td>
									<td >1. 원격 교습의 경우 환불 금액은 이용한 콘텐츠 즉, 강의 내용을 실제 연수한 차시(인터넷으로 연수하거나 학습 기기로 저장한 것을 말함)에 해당하는 금액을 뺀 금액으로 합니다.<br />
2. 연수 과정을 연수 연기(연수 시작일 후 연수 기간을 변경한 것을 말함)한 경우는 환불이 불가합니다.<br />
3. 원격 연수 4학점(60시간)의 경우는 출석 고사를 응시한 경우 환불이 불가합니다.</td>
								</tr>
							</tbody>
						</table>
					</li>
				</ul>
			</div>
		</div><!--//.section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
