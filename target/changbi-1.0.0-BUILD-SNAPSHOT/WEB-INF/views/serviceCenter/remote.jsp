<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
function checkAgreeMove(url) {
	if(!$('#agree').is(':checked')) {
		alert('정보 제공에 동의하셔야 원격지원 서비스가 가능 합니다.');
		$('#agree').focus();
		return;
	}
	window.open(url);
}
</script>

<t:insertDefinition name="centerleftmenu"/>

	<!-- 1.3. 본문 -->
			<div class="body">
				<div class="sub-header">
					<p class="sub-nav">
						<a class="nth-1st" href="<c:url value="/"/>"><span class="sr-only">HOME</span></a>
						<a href="#">고객 센터</a>
						<a class="nth-last" href="#">PC 원격 지원</a>
					</p>
					<h2 class="sub-title">PC 원격 지원</h2>
				</div>
				<div class="sub-body">
					<div class="section">
						<p>PC 또는 동영상 오류가 발생했을 때 온라인 문의와 전화 상담만으로 해결이 어려운 경우 원격 지원 서비스를 이용하세요.</p>
						<p>전문 상담원이 회원님의 PC 화면 제어를 통해 오류를 확인하고 장애를 즉시 해결해 드립니다. </p>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header">
							<h4>원격 지원 서비스 절차</h4>
							<p class="ctrl-btnSet">
								방화벽, 일부 보안 프로그램 사용 등 PC 사용 환경에 따라 원격 지원 서비스가 제한될 수 있습니다.
							</p>
						</div>
						<ol class="stepBox-list x4">
							<li><h5 class="label">문제 발생</h5>
								재생 오류, 동영상 끊김<br> 화면 안 보임 등</li>
							<li><h5 class="label">원격 지원 서비스 신청</h5>
								<em class="danger">Tel. 1833-7247 고객 센터</em><br> 원격 지원 요청 접수</li>
							<li><h5 class="label">원격 지원 서비스 시작</h5>
								원격 지원 상담원 안내에 따라 <br><em class="danger">[원격 지원 서비스 시작]</em> 버튼 클릭</li>
							<li><h5 class="label">원격 지원 서비스 종료</h5>
								지원 완료 및 테스트 후<br> <em class="danger">연결 종료</em></li>
						</ol>
					</div><!--//.section-->
					<div class="section">
						<div class="section-header">
							※ 원격 지원 서비스 진행을 위해 아래 정보가 제공됩니다. 동의하시겠습니까?
							<label class="ctrl-btnSet">
								<input type="checkbox" id="agree" name="agree"> 동의합니다.
							</label>
						</div>
						<table class="table">
							<thead>
								<tr>
									<th scope="col">제공받는 자</th>
									<th scope="col">제공 목적</th>
									<th scope="col">제공 항목</th>
									<th scope="col">보유 기간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>코이노</td>
									<td>원격 지원 서비스 시스템 운영</td>
									<td>아이디, 성명, 휴대 전화 번호</td>
									<td>회원 탈퇴 및 위탁 업무 종료 시</td>
								</tr>
							</tbody>
						</table>
					</div><!--//.section-->
					<div class="list-bottom alignR">
						<a href="javascript:checkAgreeMove('http://as82.kr/changbi')" class="btn primary">원격 지원 서비스 시작</a>
					</div>
				</div><!--//.sub-body-->
				<!--본문 내용 출력 공간-->
			</div><!--//.body-->
	<!--// 1.3. 본문 -->