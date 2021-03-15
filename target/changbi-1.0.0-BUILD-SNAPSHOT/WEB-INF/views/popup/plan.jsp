<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--// 2.팝업 -->
	<div class="cl-popup-overlay " id="planpop">
			<div class="cl-popup-wrap">
				<c:choose>
					<c:when test="${currentDevice.mobile }">
				<div class="cl-popup-box full">
					</c:when>
					<c:otherwise>
				<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
					</c:otherwise>
				</c:choose>
					<div class="popup-header">
						<h3 class="popup-title">건강한 교사, 행복한 교실을 위한 생활 명상 연수계획</h3>
					</div>
					<div class="popup-body">
						<div class="group learnSchedule">
							<div class="section box">
								<ul class="info-list">
									<li class="learn-title"><em class="label">연수과정</em>
										<strong>건강한 교사, 행복한 교실을 위한 생활 명상</strong>
									</li>
									<li class="learn-notation"><em class="label">연수 기수</em> <strong>2018년 3기</strong>
									</li>
									<li class="learn-date"><em class="label">연수 기간</em>
										2018. 03. 01 ~ 2018. 06. 30
									</li>
									<li class="learn-course"><em class="label">연수 종별</em>
										교원 직무 연수
									</li>
									<li class="learn-time"><em class="label">수강 기간</em>
										30시간
									</li>
									<li class="learn-score"><em class="label">학점</em>
										2학점
									</li>
									<li class="learn-max"><em class="label">모집 정원</em>
										제한없음
									</li>
									<li class="learn-price"><em class="label">연수비</em>
										<strong>60,000원</strong>
									</li>
									<li class="learn-book"><em class="label">교재/교구</em>
										교재 없음
									</li>
									<li class="learn-target"><em class="label">연수 대상</em>
										전국 유, 초, 중등교원 및 교육전문직
									</li>
									<li class="learn-exam"><em class="label">출석 고사</em>
										<strong>없음(해당무)</strong>
									</li>
									<li class="learn-evaluate"><em class="label">평가 방법</em>
										1차 온라인 과제(35점), 2차 온라인 과제(35점), 참여 점수(30점)
									</li>
									<li><em class="label">이수 기준</em>
										100점 만점 중 60점 이상, 학습 진도 80% 이상
									</li>
									<li><em class="label">연수 이수증</em>
										이수 완료 후 홈페이지에서 출력(※연수 이수증은 개별 발송 하지 않으며, 출력한 이수증은 원본과 동일합니다.)
									</li>
									<li><em class="label">강사진</em>
										김물길 외 9명
									</li>
									<li><em class="label">연수 개요</em>
										희망 교육과 꿈과 열정의 모토를 가지고 각 분야의 인사들이 대중의 멘토가 되어 메시지를 전해 줍니다. 각 분야에 뛰어난 멘토가 때로는 본인의 이야기를 때로는 사회에서 살아가기 위한 방법 등을 자신만의 노하우를 전달합니다. 또한, 학생들에게는 진로에 대한 비전을 제시하고, 교사들에게는 학생들의 진로 교육에 대한 나침반 역할을 할 수 있을 것으로 기대합니다.
									</li>
									<li class="learn-goal"><em class="label">연수 목표</em>
										- 학생들과 강연 내용을 공유하면서 교사 스스로 자신의 내면을 치유하는 시간을 가질 수 있습니다. <br>
										- 학생들과 진로에 대한 상담을 할 때, 동기부여를 할 수 있고, 학생과 상담하기 위한 다양한 팁을 알 수 있습니다.  <br>
										- 연사들의 이야기를 통해 꿈을 이루기 위한 열정의 방식들을 이해하고 학생들에게 다양한 진로지도를 할 수 있습니다.  <br>
										- 여러 분야의 전문가, 연사들의 이야기를 활용하여 청소년들의 글로벌 마인드와 인생을 설계하기 위한 동기를 키워줄 수 있습니다.
									</li>
								</ul>
							</div><!--//.section-->
							<div class="section" id="learn-contents">
								<div class="section-header box strong">
									<h5>세부 학습 내용</h5>
								</div><!--//.group-header-->
								<table class="table">
									<colgroup>
										<col width="50" />
										<col width="" />
										<col width="50" />
										<col width="150" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" class="item-no nth-1st">차시</th>
											<th scope="col" class="item-title">목차</th>
											<th scope="col" class="item-time">시간</th>
											<th scope="col" class="item-teater">강사</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="item-no nth-1st">1</td><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
									<!-- ITEM  반복 -->
										<tr>
											<td class="item-no nth-1st">2</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">3</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">4</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">5</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">6</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">7</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">8</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">9</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">10</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">11</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
										<tr>
											<td class="item-no nth-1st">12</td>
											<td class="item-title">차시 제목 출력되는 공간</td>
											<td class="item-time">1H</td>
											<td class="item-teacher">서민</td>
										</tr>
									<!--// ITEM 반복 END -->
									</tbody>
									<tfoot>
										<tr>
											<td class="item-label nth-1st" colspan="2"> 총 시간</td>
											<td class="item-time">30H</td>
											<td>&nbsp;</td>
										</tr>
									</tfoot>
								</table>
							</div><!--//.section#learn-contents-->
						</div><!--//.group-->
					</div><!--//.popup-body-->
					<div class="popup-footer">
						<button class="btn primary close">확인 및 닫기</button>
					</div>
				</div><!--//.cl-popup-box-->
			</div><!--//.cl-popup-wrap-->
			<button class="cl-popup-closer">
				<span class="sr-only">닫기</span>
			</button>
		</div><!--//.cl-popup-overlay-->
<!--// 2.팝업 END -->