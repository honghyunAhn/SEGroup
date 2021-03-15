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
			<a href="#">수강 방법</a>
		</p>
		<h2 class="sub-title">수강 방법</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>수강 절차</h4>
			</div>
			<div class="section-body box">
				<ol class="stepGuide-list">
							<li>
								<strong class="label">로그인</strong>
								<!--<div>[공인 인증서 로그인], [일반 로그인]<br />
							※ [일반 로그인]의 경우 [수강]을 위해서는 [본인 인증] 절차를 거치셔야 합니다.</div>//-->
							<div>
							창비교육 원격교육연수원은 아래와 같은 로그인 방법이 있습니다.<br>
							[범용 공인 인증서 로그인]<br>
							등록하신 [범용 공인 인증서]를 통해 로그인을 하실 경우 별도의 인증 절차를 거치지 않고 [수강]이 가능합니다.<br>
							[일반 로그인]<br>
							일반 로그인 하신 후 [본인 인증] 절차를 거쳐야만 [수강]이 가능합니다. <br>[본인 인증] 수단은 [범용 공인 인증서], [휴대 전화], [아이핀]이 있습니다.
							</div>
						</li>
						<li>
							<strong class="label">수강</strong>
							<div>[나의 강의실] > [강의실] > [연수 과정] > [진행 연수] > [강의실 입장] 클릭 후 수강을 할 수 있습니다.<br />
						※ [대기 연수]의 경우 연수 기간이 되어야만 수강이 가능합니다.</div>
					</li>
					<li>
						<strong class="label">평가</strong>
						<div>학점별 평가 기준에 따라 평가 진행<br />
						※ 4학점(60시간): 진도율, 온라인 시험, 온라인 과제, 출석 고사<br />
						※ 3학점(45시간), 2학점(30시간), 1학점(15시간): 진도율, 온라인 시험, 온라인 과제</div>
					</li>
					<li>
						<strong class="label">이수</strong>
							<div>연수 기간 종료 후 이수 기준 도달 시 이수증 발급 및 각 시·도 교육청에 연수 이수 결과 보고 진행</div>
						</li>
					</ol>
			</div>
		</div><!--section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>이용 안내</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 강의실
						<ul>
							<li>ⓐ 회원의 연수 현황(진행 연수, 대기 연수, 완료/복습 연수)을 확인할 수 있습니다.</li>
							<li>ⓑ 연수 과정의 연기/취소를 할 수 있습니다.</li>
						</ul>
					</li>
					<li>② [강의실 입장] 버튼 클릭
						<ul>
							<li>ⓐ 강의 보기: 연수 과정의 차시별 학습이 가능합니다. 수강 이력 확인과 수강 기록 조회를 할 수 있습니다. </li>
							<li>ⓑ 온라인 시험: 연수 기간 중 평가 일정에 맞추어 응시할 수 있습니다. 평가는 1회만 가능하고, 평가 기준의 점수에 미달할 경우 연수 이수 처리가 되지 않습니다. 충분히 학습 후 응시하시기 바랍니다.</li>
							<li>ⓒ 온라인 과제: 연수 기간 중 평가 일정에 맞추어 과제를 제출할 수 있습니다. 타 회원의 과제와 내용이 비슷할 경우 ‘모사 방지 시스템’에 의해 과제 점수가 낮게 나올 수 있습니다. 이 경우 연수 이수 처리가 되지 않습니다. 회원 본인 스스로 과제를 수행하고 제출해 주시기 바랍니다.</li>
							<li>ⓓ 성적 조회: 평가 기준에 따라 성적을 확인할 수 있습니다.</li>
							<li>ⓔ 자료실: 연수 과정의 학습에 필요한 자료를 확인할 수 있습니다.</li>
							<li>ⓕ 질의 답변: 연수 과정에 대한 질의 및 답변을 확인할 수 있습니다.</li>
						</ul>
					</li>
				</ul>
			</div>
		</div><!--section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
