<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){
	//popup
	$(".notation").click(function(event){
		//var course_id = $("input:radio[name='chkClass']:checked").val();
		var course_id = $(this).attr("data");
		if (isEmpty(course_id)) {
			alert('연수과정이 지정되지 않았습니다.');
			return;
		}
		popCourseCardinalSelect(course_id);
	});
});

/*팝업창*/
function reApply() {
	var course_id = $("input:radio[name='chkClass']:checked").val();
	if(!course_id) {
		alert("연수 과정을 선택해 주십시오.");
		return;
	}

	popCourseCardinalSelect(course_id);
}
</script>

<t:insertDefinition name="mypageleftmenu"/>
<!-- 1.3. 본문 -->
			<div class="body">
				<div class="sub-header">
					<p class="sub-nav">
						<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
						<a href="#">나의 강의실</a>
						<a href="#">강의실</a>
						<a class="nth-last" href="${contextPath}">연수 과정</a>
					</p>
					<h2 class="sub-title">연수 과정</h2>
					<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
				</div><!--//.sub-header-->
				<div class="sub-body">
					<div id="mypage-summary" class="group">
						<div id="mypage-summary-class" class="section box">
							<div class="section-header"><h4>연수 현황</h4></div>
							<div class="section-body">
								<ul class="summary-list">
									<li class="nth-1st"><span class="label">진행<br>연수 현황</span><strong class="num">${progressList.size() }</strong></li>
									<li><span class="label">대기<br>연수 현황</span><strong class="num">${waitingList.size() }</strong></li>
									<li><span class="label">완료/복습<br>연수 현황</span><strong class="num">${completeList.size() }</strong></li>
								</ul>
							</div>
						</div>
						<div id="mypage-summary-point" class="section box">
							<div class="section-header"><h4>포인트/쿠폰</h4></div>
							<div class="section-body borderT">
								<ul class="summary-list">
									<li><span class="label">보유 포인트</span><strong class="num"><fmt:formatNumber value="${pointInfo.BALANCE>0?pointInfo.BALANCE:0 }" groupingUsed="true"/></strong>점</li>
									<li><span class="label">익월 소멸 예정 포인트</span><strong class="num"><fmt:formatNumber value="0" groupingUsed="true"/></strong>점</li>
									<li><span class="label">보유 쿠폰</span><strong class="num"><fmt:formatNumber value="${couponInfo.CNT }" groupingUsed="true"/></strong>개</li>
								</ul>
							</div>
						</div>
						<div id="mypage-summary-delivery" class="section box">
							<div class="section-header"><h4>배송 정보</h4></div>
							<div class="section-body borderT">
								<ul class="summary-list">
									<li><span class="label">입금 대기</span><strong class="num">${bookInfo.PAY_CHECK }</strong>건</li>
									<li><span class="label">배송 요청</span><strong class="num">${bookInfo.DELIVERY_CHECK }</strong>건</li>
									<li><span class="label">배송 완료</span><strong class="num">${bookInfo.PAYMENT }</strong>건</li>
								</ul>
							</div>
						</div>
					</div><!--//#mypage-summary.group-->
					<div class="tab-group">
						<ul class="tab-header sub x3">
							<li><a href="lecture1">진행 연수<strong class="num">${progressList.size() }</strong></a></li>
							<li><a href="lecture2">대기 연수<strong class="num">${waitingList.size() }</strong></a></li>
							<li><a class="nth-1st on" href="lecture3">완료/복습 연수<strong class="num">${completeList.size() }</strong></a></li>
						</ul>
						<div class="tab-body">
							<table id="myclass-list" class="list">
								<colgroup>
									<%-- <col width="50"> --%>
									<col width="70">
									<col width="100">
									<col width="90">
									<col width="">
									<col width="60">
									<col width="100">
									<col width="70">
									<col width="100">
									<col width="200">
								</colgroup>
								<thead>
									<tr>
										<%-- <th scope="col" class="item-check">선택</th> --%>
										<th scope="col" class="item-type">연수 구분</th>
										<th scope="col" class="item-course">연수 영역</th>
										<th scope="col" class="item-notation">기수</th>
										<th scope="col" class="item-title">연수 과정명</th>
										<th scope="col" class="item-score">학점</th>
										<th scope="col" class="item-date">복습 기간</th>
										<th scope="col" class="item-state">이수 여부</th>
										<th scope="col" class="item-local">연수 지명 번호</th>
										<th scope="col" class="item-function">수강</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${!empty completeList }">
										<c:forEach  var="item" items="${completeList}" varStatus="status">
											<tr class="<c:if test="${status.index == 0 }">nth-1st</c:if>"><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
												<%-- <td class="item-check"><input type="radio" name="chkClass" value="${item.COURSE_ID }"></td> --%>
												<td class="item-type">${item.LEARN_TYPE_NAME }</td>
												<td class="item-course">${item.COURSE_CODE_NAME } </td>
												<td class="item-notation">${item.CARDINAL_NAME }</td>
												<td class="item-title">${item.NAME }</td>
												<td class="item-score">${item.CREDIT }학점</td>
												<td class="item-date">${item.REAL_START_DATE } ~ ${item.REAL_END_DATE }</td>
												<td class="item-state">
													<c:choose>
													<c:when test="${item.ISSUE_YN eq 'Y' and not empty item.ISSUE_NUM  }">미이수</c:when>
													<c:otherwise>미이수</c:otherwise>
													</c:choose>
												</td>
												<td class="item-local">${item.DES_NUM }</td>
												<td class="item-function">
													<!-- 복습기간내 -->
													<c:if test="${item.REVIEW_DAYS >= 0 and item.ISSUE_YN eq 'Y' }">
														<a class="btn primary"  href="classroom?id=${item.ID }&cardinal=${item.CARDINAL_ID }&course=${item.COURSE_ID }&op=review" target="_self">복습</a>
													</c:if>
													<a href="#" class="btn danger notation" data="${item.COURSE_ID }">재수강</a>
												</td>
												<!-- 복습기간 이후 -->
													<%-- <c:if test="${item.REVIEW_DAYS < 0 }">
														<td class="item-function"><a href="#" class="btn danger notation" data="${item.COURSE_ID }">재수강</a></td>
													</c:if> --%>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty completeList }">
										<tr class="nth-1st">
											<td colspan="10">조회된 내용이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div><!--//.tab-body-->
					</div><!--.tab-group-->
					<c:if test="${currentDevice.mobile }"><div>※ 이수증, 수강 확인증, 영수증은 PC 버전에서만 출력이 가능합니다.</div></c:if>
					<div class="section box">
						<div class="section-header">
							<h5 class="blit circleL-notice"> 연수 진행을 위해 <strong>개인 정보를 확인하여 변동 시 수정</strong>하여 주시기 바랍니다.</h5>
							<p class="ctrl-btnSet">
									<a class="btn-modify" href="/mypage/private/privateedit">개인 정보 수정</a>
								</p>
						</div>
						<div class="section-body borderT">
							<ul class="info-list">
								<li class="halfW"><em class="label">성명</em> ${userInfo.NAME }</li>
								<li class="halfW"><em class="label">회원 구분</em> ${userInfo.GRADE }</li>
								<li class="halfW clearL"><em class="label">휴대 전화</em> ${userInfo.PHONE }</li>
								<li class="halfW"><em class="label">전자 우편</em> ${userInfo.EMAIL }</li>
								<li class="clearL"><em class="label">학교명</em> ${userInfo.SCHOOL_NAME }</li>
								<li><em class="label">주소</em>
									[${userInfo.POST_CODE }] ${userInfo.ADDR1 } ${userInfo.ADDR2 }
								</li>
								<li><em class="label">학교 주소</em>
									[${userInfo.SCHOOL_POST }] ${userInfo.SCHOOL_ADDR1 } ${userInfo.SCHOOL_ADDR2 }
								</li>
							</ul>
						</div>
					</div><!--//.section-->
				</div><!--//.sub-body-->
			</div><!--//.body-->
	<!--// 1.3. 본문 -->
