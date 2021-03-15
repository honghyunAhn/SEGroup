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
			<a href="#">교육청(기관) 연수</a>
		</p>
		<h2 class="sub-title">교육청(기관) 연수</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>교육청(기관) 연수란?</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 전국 시·도 교육청/교육 지원청 및 교육 관련 기관에서 해당 소속 교원을 대상으로 창비교육 원격교육연수원에 위탁하여 진행하는 연수입니다.</li>
					<li>② 원격 연수와 동일한 기준으로, 교육청(기관) 연수의 이수 시간은 15시간당 1학점으로 환산하여 NEIS(교육 행정 정보 시스템)에 등록되고, 교원의 승진 및 평가에 반영됩니다. </li>
				</ul>
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>교육청(기관) 원격 연수 대상</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 시·도 교육청/교육 지원청 및 교육 관련 기관 소속 교원</li>
					<li>② 시·도 교육청/교육 지원청 및 교육 관련 기관 지명 대상 교원</li>
				</ul>
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>교육청(기관) 원격 연수 신청 절차</h4>
			</div>
			<div class="section-body box">
				<ol class="stepGuide-list">
					<li>
						<strong class="label w10em">회원 가입</strong>
						<div>본인 인증을 받은 후 회원 가입 폼 양식에 기입하고, 이용 약관에 동의하여 회원 가입을 완료합니다.</div>
					</li>
					<li>
						<strong class="label w10em">교육청 배너</strong>
						<div>[메인 화면] 교육청(기관) 단체 연수에서 소속 교육청/교육 지원청 배너 클릭 후 [신청] 버튼을 클릭합니다.<br />
							[연수 신청] > [교육청(기관) 연수] > [모집 연수] > [신청] 버튼을 클릭합니다.</div>
					</li>
					<li>
						<strong class="label w10em">연수 기수 선택</strong>
						<div>[과정 소개 페이지]에서 수강하실 연수 기수를 선택 및 [신청] 버튼을 클릭합니다.</div>
					</li>
					<li>
						<strong class="label w10em">연수 지명 번호 기입</strong>
						<div>[신청 상세 페이지]에서 학교에서 부여받은 연수 지명 번호를 입력합니다.</div>
					</li>
					<li>
						<strong class="label w10em">연수비 결제</strong>
						<div>[결제] 버튼 클릭 후 결제를 진행합니다. 결제 수단에는 무통장 입금, 신용카드, 계좌 이체 등이 있습니다.</div>
					</li>
					<li>
						<strong class="label w10em">수강</strong>
						<div>[신청] 완료 후 [나의 강의실] > [강의실] > [연수 과정] > [진행 연수] > [강의실 입장] 클릭 후 수강을 할 수 있습니다.<br />
							※ [대기 연수]의 경우 연수 기간이 되어야만 수강이 가능합니다.</div>
					</li>
				</ol>
			</div>
		</div><!--//.section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
