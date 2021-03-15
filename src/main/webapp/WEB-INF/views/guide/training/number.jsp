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
			<a href="#">연수 지명 번호 안내</a>
		</p>
		<h2 class="sub-title">연수 지명 번호 안내</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>연수 지명 번호 안내</h4>
			</div>
			<div class="section-body box">
				2007년 3월 1일부터 원격 연수 신청 시 학교장 추천서를 발급받아 신청하던 방법이 폐지되고, 각 학교마다 연수 지명 명부를 비치하여 연수 신청 시 지명 번호를 받아 연수원에 등록하는 제도로 변경되었습니다. 이에 따라, 연수 지명 번호가 없으면 연수 이수 학점 및 승진 규정상의 가산점이 인정되지 않습니다.
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>연수 지명 번호 등록/수정 방법</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 연수 신청 시, 연수 지명 번호 입력란에 입력<br />
						<img src="/resources/images/Guide_06_1.png"><br />
						(예시: 서울-창비초-18-004, 경기-창비중-18-005, 부산-창비고-18-010 등)
					</li>
					<li>② [나의 강의실] > [강의실] > [연수 과정] > [진행 연수] > [강의실 입장] > [홈] 메뉴에서 연수 지명 번호 수정 가능<br />
						<img src="/resources/images/Guide_06_2.png"><br />
					</li>
					<li>③ 참고: 자율 연수는 학점 인정이 되지 않으며, 연수 지명 번호를 등록할 수 없습니다.</li>
				</ul>
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>연수 지명 번호 취득 방법</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 교무부(교무부장), 연구부(연구부장) 선생님께 연수 관리 대장 혹은 연수 지명 명부를 요청합니다.</li>
					<li>② 연수자는 ‘연수 지명 명부’에 연수 내용과 기관, 연수 기간 등 관련 사항을 기재합니다. 이 과정에서 연수 지명 번호가 확정됩니다. </li>
					<li>③ 교육 전문직의 경우 ‘서울-(동부청, 수원청, 연수원, 정보원, 단위 부서명)-18-001’ 등의 형식으로 작성합니다.</li>
					<li>④ 학교 ‘연수 지명 명부’에서 확정된 연수 지명 번호는 연수 신청 시 입력합니다.</li>
					<li>⑤ 연수 신청 후부터 연수 종료 시까지 [나의 강의실] > [강의실] > [연수 과정] > [진행 연수] > [강의실 입장] > [홈] 메뉴에서 입력 및 수정 가능합니다.</li>
					<li>⑥ 연수 지명 번호 부여 없이 연수를 실시했을 경우 연수 이수 학점(성적) 및 승진 규정상의 가산점이 인정되지 않습니다.</li>
				</ul>
			</div>
		</div><!--//.section-->
		<div class="section">
			<div class="section-header box strong">
				<h4>연수 지명 명부 서식(예시)</h4>
			</div>
			<div class="section-body box">
				<table class="rule cell">
					<thead>
						<tr>
							<th class="nth-1st" scope="col">연번</th>
							<th scope="col">직명</th>
							<th scope="col">성명<br>(생년월일)</th>
							<th scope="col">지명 번호</th>
							<th scope="col">연수 과정명</th>
							<th scope="col">연수 기관</th>
							<th scope="col">수강 시간<br>(기간)</th>
							<th scope="col">지명 사유</th>
							<th scope="col">결재<br>(교감 확인)</th>
							<th scope="col">비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="nth-1st">1</td>
							<td>교감</td>
							<td>김창비<br>(1955.3.1)</td>
							<td>서울-창비초-18-001</td>
							<td>교사에게 필요한 글쓰기 기본기</td>
							<td>창비교육<br>원격교육연수원</td>
							<td>30시간<br>(9.1~9.30)</td>
							<td>전문성 신장</td>
							<td></td>
							<td>미이수</td>
						</tr>
						<tr>
							<td class="nth-1st">2</td>
							<td>교사</td>
							<td>이창비<br>(1990.3.1)</td>
							<td>경기-창비중-18-001</td>
							<td>국어 수업 개선</td>
							<td>㈜창비교육<br>(특수 분야 연수)</td>
							<td>60시간<br>(5.1~5.31)</td>
							<td>수업 개선</td>
							<td></td>
							<td>이수</td>
						</tr>
						<tr>
							<td class="nth-1st">3</td>
							<td>장학사</td>
							<td>박창비<br>(1989.3.1)</td>
							<td>부산-교육정책-18-001</td>
							<td>선생님의 서재: 시대를 뛰어넘는 교육 고전</td>
							<td>창비교육<br>원격교육연수원</td>
							<td>15시간<br>(8.1~8.15)</td>
							<td>전문성 신장</td>
							<td></td>
							<td>이수</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div><!--//.section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
