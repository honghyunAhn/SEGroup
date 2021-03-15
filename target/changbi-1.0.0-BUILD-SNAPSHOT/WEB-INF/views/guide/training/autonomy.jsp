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
			<a href="#">자율 연수</a>
		</p>
		<h2 class="sub-title">자율 연수</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>자율 연수란?</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<!--<li>선생님의 직무 능력 향상 및 자기 개발을 위해 자유롭게 수강이 가능한 연수입니다.<br>(연수 종료 익일 부터 수료증 발급이 가능하며, 온라인 출력만 가능합니다.)<br>※ 자율 연수는 학점 인정 및 NEIS(교육 행정 정보 시스템)에 등록이 되지 않습니다.</li>//-->
					<li>선생님의 직무 능력 향상 및 자기 개발을 위해 자유롭게 수강이 가능한 연수입니다.</li>
					<li>(연수 종료 익일 부터 수료증 발급이 가능하며, 온라인 출력만 가능합니다.)</li>
					<li>※ 자율 연수는 학점 인정 및 NEIS(교육 행정 정보 시스템)에 등록이 되지 않습니다.</li>
				</ul>
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>자율 연수 대상</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 자율연수는 대상에 대한 제한이 없습니다.</li>
				</ul>
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>집합 연수 신청 절차</h4>
			</div>
			<div class="section-body box">
				<ol class="stepGuide-list">
					<li>
						<strong class="label w15em">회원 가입</strong>
						<div>본인 인증을 받은 후 회원 가입 폼 양식 기입, 이용 약관 동의 후 회원 가입 완료합니다.</div>
					</li>
					<li>
						<strong class="label w15em">연수 신청</strong>
						<div>[연수 신청] 메뉴에서 [자율 연수] 연수 과정 선택 후 [신청] 버튼을 클릭합니다.</div>
					</li>
					<li>
						<strong class="label w15em">연수비 결제</strong>
						<div>[결제] 버튼 클릭 후 결제 진행합니다. 결제 수단: 무통장 입금, 신용 카드, 계좌 이체 등이 있습니다.</div>
					</li>
					<li>
						<strong class="label w15em">수강</strong>
						<div>[결제] 완료 후 결제일로부터 30일간 진행됩니다.</div>
					</li>
				</ol>
			</div>
		</div><!--//.section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
