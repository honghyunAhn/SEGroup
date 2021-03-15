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
			<a href="#">출석 고사</a>
		</p>
		<h2 class="sub-title">출석 고사</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>출석 고사란?</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 4학점(60시간)의 평가 방법으로 오프라인 시험으로 진행됩니다.</li>
					<li>② 4학점(60시간)의 이수 배점 중 60점을 차지하며, 불참 시에는 연수 이수가 불가능합니다.</li>
				</ul>
			</div>
		</div><!--//section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>시험 유형</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 출제 범위: 해당 연수 과정 전 범위</li>
					<li>② 출제 유형: 객관식 총 30~40문항 (일부 연수 객관식, 주관식 혼용)</li>
					<li>③ 준비물: 신분증, 컴퓨터용 사인펜, 수정 테이프 </li>
				</ul>
			</div>
		</div><!--//section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>정답 확인</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 출석 고사 정답은 시험 당일 19시에 [나의 강의실] > [강의실] > [연수 과정] > [진행 연수] > [강의실 입장] > [홈] > [출석 고사 답안 공시]를 통해 공개됩니다.</li>
					<li>② 출석 고사 정답 공개 후 성적 이의 신청 기간에만 이의 신청을 할 수 있습니다.</li>
					<li>③ 시험 문제는 부정행위 방지를 위해 공개되지 않습니다. </li>
				</ul>
			</div>
		</div><!--//section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>출석 고사 점수 확인</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 출석 고사 종료 후 채점이 완료되면, 출석 시험 성적이 공개됩니다.(연수 종료 후 3일 이내)</li>
					<li>② 점수 확인은 [나의 강의실] > [강의실] > [연수 과정] > [진행 연수] > [강의실 입장] > [홈] > [출석 고사 성적 조회]에서 할 수 있습니다. </li>
				</ul>
			</div>
		</div><!--//section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>시험 일시</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 연수 기간 마지막 주 토요일에 1회 실시되며, 기수별 시험 일시는 [연간 연수 일정] 메뉴를 참고하시기 바랍니다.
						<table class="rule cell">
							<thead>
								<tr>
									<th class="nth-1st">교시</th><th>시험 시간</th><th>비고</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="nth-1st">1교시</td><td>13시 00분~13시 50분</td><td >50분</td>
								</tr>
								<tr>
									<td class="nth-1st">2교시</td><td>14시 10분~15시 00분</td><td >50분</td>
								</tr>
								<tr>
									<td class="nth-1st">3교시</td><td>15시 20분~16시 10분</td><td >50분</td>
								</tr>
								<tr>
									<td class="nth-1st">4교시</td><td>16시 30분~17시 20분</td><td>50분</td>
								</tr>
							</tbody>
						</table>
					</li>
					<li>② 시험 일정 및 장소는 창비교육 원격교육연수원 사정 및 천재지변으로 인하여 변경될 수 있습니다. </li>
				</ul>
			</div>
		</div><!--//section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
