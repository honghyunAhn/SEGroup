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
			<a href="#">원격 연수 안내</a>
		</p>
		<h2 class="sub-title">원격 연수 안내</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>원격 연수란?</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 원격 연수는 인터넷과 개인용 컴퓨터와 같은 정보 통신 기술(ICT)을 활용한 사이버 공간을 연수 장소로 하여 교원을 대상으로 진행하는 자기 주도 학습 형태의 연수 과정입니다.</li>
					<li>② 원격 연수를 진행할 수 있는 ‘원격교육연수원’은 『교원 등의 연수에 관한 규정, 대통령령 제28198호』에 따라 교육부 장관이 인가하거나 시·도 교육감이 설치한 것입니다.</li>
					<li>③ 원격 연수는 교원의 직무 수행에 필요한 능력을 배양하기 위한 연수로 직무 연수의 이수 시간은 15시간당 1학점으로 환산되어 NEIS(교육 행정 정보 시스템)에 등록되고, 교원의 승진 및 평가에 반영됩니다. </li>
				</ul>
			</div>
		</div><!--section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>원격 연수 대상</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 전국 17개 시·도 교육청 소속 유·초·중등 교원 및 교육전문직</li>
					<li>② 휴직 중인 교원 및 일반인은 학점 인정되지 않습니다.</li>
				</ul>
			</div>
		</div><!--section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>원격 연수 인정 기준</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 연수 기간 중복 허용
						<ul class="basic-list hipen">
							<li>- 원칙: 같은 기간 동안 2개 이상의 원격 연수를 이수하여도 전부 인정됩니다. (근거: 2014년 교원 연수 중점 추진 방향의 연수 기간 중복 허용 지침)</li>
							<li>- 예외: 집합 연수의 경우 같은 기간에 2개 이상 이수가 불가능하므로 인정되지 않습니다.</li>
						</ul>
					</li>
					<li>② 동일·유사 과정 중복 허용
						<ul class="basic-list hipen">
							<li>- 원칙: 2개 과정 중 1개 과정만 인정됩니다.</li>
							<li>- 예외: 2개 과정명이 동일·유사하여도 해당 연수 목차 등을 통해 과정의 70% 이상이 서로 다른 연수 과정임을 증명할 경우 2개 과정 모두 인정됩니다.(연수생 입증 책임)</li>
						</ul>
					</li>
					<li>③ 기간제 교원의 경우 시‧도 교육청이나 소속 학교마다 인정 여부가 다르므로, 소속 기관으로 확인 바랍니다. </li>
				</ul>
			</div>
		</div><!--section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>원격 연수 신청 절차</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>
						<ol class="stepGuide-list">
							<li>
								<strong class="label w12em">회원 가입</strong>
								<div>본인 인증을 받은 후 회원 가입 폼 양식 기입, 이용 약관 동의 후 회원 가입을 완료합니다.</div>
							</li>
							<li>
								<strong class="label w12em">연수 신청</strong>
								<div>강좌 선택 후 [신청] 버튼을 누르고, 새 창에서 연수 기수를 고른 후 [신청]을 클릭합니다.</div>
							</li>
							<li>
								<strong class="label w12em">연수 지명 번호 기입</strong>
								<div>[신청 상세 페이지]에서 학교에서 부여받은 연수 지명 번호를 입력합니다.</div>
							</li>
							<li>
								<strong class="label w12em">연수비 결제</strong>
								<div>[결제] 버튼 클릭 후 결제를 진행합니다. 결제 수단에는 무통장 입금, 신용 카드, 계좌 이체 등이 있습니다.</div>
							</li>
							<li>
								<strong class="label w12em">수강</strong>
								<div>[결제] 완료 후 [나의 강의실] > [강의실] > [연수 과정] > [진행 연수] > [강의실 입장] 클릭 후 수강을 할 수 있습니다.</div>
							</li>
						</ol>
					</li>
				</ul>
			</div>
		</div><!--section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
