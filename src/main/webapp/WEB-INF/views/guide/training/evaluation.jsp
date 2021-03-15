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
			<a href="#">평가 이수 방법</a>
		</p>
		<h2 class="sub-title">평가 이수 방법</h2>
		<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
	</div><!--//.sub-header-->
	<div class="sub-body">
		<div class="section">
			<div class="section-header box strong">
				<h4>학점별 평가 및 이수 기준</h4>
			</div>
			<div class="section-body box">
				<ul class="unhead-list">
					<li>① 4학점(60시간)
						<table class="rule">
							<thead>
								<tr>
									<th class="nth-1st" scope="col">영역</th><th scope="col">배점</th><th scope="col">내용</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="nth-1st">출석 고사</td><td >60점</td><td >객관식, 주관식 출석 고사</td>
								</tr>
								<tr>
									<td class="nth-1st">온라인 과제</td><td >20점</td><td >과정당 온라인 과제 1~2회 부과</td>
								</tr>
								<tr>
									<td class="nth-1st">온라인 시험</td><td >10점</td><td >과정당 온라인 시험 1~2회 실시</td>
								</tr>
								<tr>
									<td class="nth-1st">학습 참여도</td><td >10점</td><td >질의 답변 및 연수 후기 게재 건수</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td class="nth-1st" colspan=2>이수 기준</td><td>학습 진도율 90% 이상, 연수 성적 60점 이상</td>
								</tr>
							</tfoot>
						</table>
						※ 4학점(60시간)의 최종 성적인 상대 평가 점수는 [연수 성적 분포 조견표]에 따라 80점~100점 사이로 산출됩니다.
						<table class="rule cell">
							<caption>[연수 성적 분포 조견표]</caption>
							<thead >
								<tr>
									<th class="nth-1st" scope="row">점수</th>
									<th scope="col">100</th><th scope="col">99</th><th scope="col">98</th><th scope="col">97</th><th scope="col">96</th93><th scope="col">95</th><th scope="col">94</th><th scope="col">93</th><th scope="col">92</th><th scope="col">91</th><th scope="col">90</th><th scope="col">89</th><th scope="col">88</th><th scope="col">87</th><th scope="col">86</th><th scope="col">85</th><th scope="col">84</th><th scope="col">83</th><th scope="col">82</th><th scope="col">81</th><th scope="col">80</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th class="nth-1st" scope="row">백분율<br />(%)</th>
									<td >2.0</td>
									<td >2.6</td>
									<td >3.2</td>
									<td >3.8</td>
									<td >4.5</td>
									<td >5.1</td>
									<td >5.7</td>
									<td >6.2</td>
									<td >6.6</td>
									<td >6.8</td>
									<td >7.0</td>
									<td >6.8</td>
									<td >6.6</td>
									<td >6.2</td>
									<td >5.7</td>
									<td >5.1</td>
									<td >4.5</td>
									<td >3.8</td>
									<td >3.2</td>
									<td >2.6</td>
									<td >2.0</td>
								</tr>
							</tbody>

						</table>
						[동점자 처리 기준]
						<ul>
							<li>1순위: 출석 고사 점수 우선자 </li>
							<li>2순위: 온라인 평가 항목 중 온라인 과제 점수 우선자 </li>
							<li>3순위: 온라인 평가 항목 중 온라인 시험 점수 우선자 </li>
							<li>4순위: 온라인 학습 진도율 우선자 </li>
							<li>5순위: 연수일 횟수 우선자</li>
							<li>6순위: 누적 학습 시간 우선자</li>
						</ul>
					</li>
					<li>
						② 3학점(45시간)
						<table class="rule">
							<thead>
								<tr>
									<th class="nth-1st" scope="col">영역</th><th scope="col">배점</th><th scope="col">내용</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="nth-1st">온라인 과제</td><td >40점</td><td >과정당 온라인 과제 1~2회 부과</td>
								</tr>
								<tr>
									<td class="nth-1st">온라인 시험</td><td >40점</td><td >과정당 온라인 시험 1~2회 실시</td>
								</tr>
								<tr>
									<td class="nth-1st">학습 참여도</td><td >20점</td><td >질의 답변 및 연수 후기 게재 건수</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td class="nth-1st" colspan=2>이수 기준</td><td>학습 진도율 90% 이상, 연수 성적 60점 이상</td>
								</tr>
							</tfoot>
						</table>
					</li>
					<li>③ 2학점(30시간)
						<table class="rule">
							<thead>
								<tr>
									<th class="nth-1st" scope="col">영역</th><th scope="col">배점</th><th scope="col">내용</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="nth-1st">온라인 과제</td><td >40점</td><td >과정당 온라인 과제 1~2회 부과</td>
								</tr>
								<tr>
									<td class="nth-1st">온라인 시험</td><td >40점</td><td >과정당 온라인 시험 1~2회 실시</td>
								</tr>
								<tr>
									<td class="nth-1st">학습 참여도</td><td >20점</td><td >질의 답변 및 연수 후기 게재 건수</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td class="nth-1st" colspan=2>이수 기준</td><td>학습 진도율 90% 이상, 연수 성적 60점 이상</td>
								</tr>
							</tfoot>
						</table>
					</li>
					<li>④ 1학점(15시간)
						<table class="rule">
							<thead>
								<tr>
									<th class="nth-1st" scope="col">영역</th><th scope="col">배점</th><th scope="col">내용</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="nth-1st">온라인 과제</td><td >40점</td><td >과정당 온라인 과제 1~2회 부과</td>
								</tr>
								<tr>
									<td class="nth-1st">온라인 시험</td><td >40점</td><td >과정당 온라인 시험 1~2회 실시</td>
								</tr>
								<tr>
									<td class="nth-1st">학습 참여도</td><td >20점</td><td >질의 답변 및 연수 후기 게재 건수</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td class="nth-1st" colspan=2>이수 기준</td><td>학습 진도율 90% 이상, 연수 성적 60점 이상</td>
								</tr>
							</tfoot>
						</table>
					</li>
				</ul>
			</div>
		</div><!--//.section-->
	</div><!--//.sub-body-->
</div><!--//.body-->
<!--// 1.3. 본문 -->
