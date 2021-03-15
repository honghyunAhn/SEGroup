<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>
<c:set var="newline" value="<%= \"\n\" %>" /><%--cr to br --%>

<style type="text/css">
.ui-tooltip {width: auto; min-width: fit-content;}
</style>
<script type="text/javascript" src="/resources/js/clipboard.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
$(function () {
	/* #001 : 모바일 연수 상세보기 페이지 탭 스크롤 고정 */
	$(".page").scroll(function(){
		// 스크롤 고정 관련
		var height = $(".page").scrollTop(); // 현재 스크롤 위치
		var offset = $('#header').height() + $('.body .sub-header').height() + $('.learn-detailView .detailView-top').height() ; // 스크롤 고정이 시작되는 위치
		var position = height - $('#header').height() + 10; // 고정 값
		var target = ".affixed-element-sub-top";
		if (height > offset){
			$(target).addClass("affix").css("top", position);
		} else {
			$(target).removeClass("affix").css("top","auto");
		}
	});

});
$(document).ready(function(){
	var nowTabIndex, changeTabIndex = 0;
	var tabLen = $("#tab-detailView").children("li").length;
	var groupID = new Array("#learn-intro","#learn-contents","#learn-review");
	var groupTop = new Array(
		$("#learn-intro").position().top - 50,
		$("#learn-contents").position().top - 50,
		$("#learn-review").position().top - 50
		);

	$(".page").scroll(function(){
		// 스크롤 고정 관련
		var height = $(".page").scrollTop(); // 현재 스크롤 위치
		var offset = $('#header').height() + $('.body .sub-header').height() + $('.learn-detailView .detailView-top').height() ; // 스크롤 고정이 시작되는 위치
		var position = height - $('#header').height(); // 고정 값
		var target = ".affixed-element-sub-top";
		if (height > offset){
			$(target).addClass("affix").css("top", position);
		} else {
			$(target).removeClass("affix").css("top","auto");
		}
		// 스크롤 위치에 따른 탭 전환 관련
		if (height >= groupTop[0]){
			changeTabIndex = 0;
			for (var j = 1; j<tabLen; j++){
				if(height >= groupTop[j]){
					changeTabIndex ++;
				}
			}
			if( nowTabIndex != changeTabIndex ){
				nowTabIndex = changeTabIndex;
				$("#tab-detailView li>a").removeClass("on");
				$("#tab-detailView li>a[href='"+groupID[nowTabIndex]+"']").addClass("on");
			}
		}
	});


	//popup
	$(".notation").click(function(event){
		var course_id = $(this).data('course');

		if (isEmpty(course_id)) {
			alert('연수과정이 지정되지 않았습니다.');
			return;
		}
		popCourseCardinalSelect(course_id);
	});

	// sns kakaostory
	Kakao.init('<spring:eval expression="@config['sns.kakaostory.app_key']"/>');

	// clipboard
	$('.copy_to_clipboard').tooltip({ items: ".copy_to_clipboard", content: "복사되었습니다.", disabled: true});
	$('.copy_to_clipboard').mouseout(function() {
		$('.copy_to_clipboard').tooltip("disable");
	});
	if(window.clipboardData && window.clipboardData.setData) { // ie8
		$('.copy_to_clipboard').click(function() {
			window.clipboardData.setData("Text", $('.copy_to_clipboard').data('clipboard-text'));
			$('.copy_to_clipboard').tooltip("open");
		});
	} else {
		(new ClipboardJS('.copy_to_clipboard'))
		.on('success', function(e) {
			$('.copy_to_clipboard').tooltip("open");
	    }).on('error', function(e) {	// old safari
	    	prompt("Ctrl+C를 눌러 복사하세요.", e.text);
	    });
	}
});

// 교재보기(팝업)
function popupMainBookInfo(id) {
	var layerId  = 'layerBookInfo';
	if($('#'+layerId).length > 0) $('#'+layerId).remove();
	$.ajax({
		type: "POST",
		url: "<c:url value='/learn/course/layer/bookinfo' />",
		dataType: "text",
		data: {'course_id': id},
		success: function(txt) {
			$(document.body).append(txt);
			popupOpen(layerId);
		}
	});
}

// sns공유
function shareSns(sns) {

	var text = '${pageTitle}';
	var url = '${currentUrl}';

	switch(sns) {
	case 'naver':
		window.open('http://share.naver.com/web/shareView.nhn?url='+ encodeURIComponent(url) + '&title='+ encodeURIComponent(text), '_share', 'width=380, height=520, top=0, left=0, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		break;
	case 'facebook':
		window.open('https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(url), '_share', 'width=380, height=520, top=0, left=0, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		break;
	case 'kakao':
		Kakao.Story.share({
			url: url,
			text: text
		});
		break;
	}
}

// url 복사
function copyUrl() {
	var url = '${currentUrl}';
	if(window.clipboardData && window.clipboardData.setData) {
		window.clipboardData.setData("Text", url);
		alert("복사되었습니다.");
		return;
	} else {
		prompt("Ctrl+C를 눌러 복사하세요.", url);

	}
}

</script>

<t:insertDefinition name="leftmenu"/>

<!-- 1.3. 본문 -->
		<div class="body">
			<div class="sub-header">
				<p class="sub-nav">
					<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
					<a href="#">연수 신청</a>
					<a class="nth-last" href="${contextPath}">영역별 연수</a>
				</p>
				<h2 class="sub-title">영역별 연수 </h2>
				<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
			</div><!--//.sub-header-->
			<div class="sub-body">
				<div class="learn-detailView">
					<div class="detailView-top">
						<div class="group-header">
							<h3 class="strong">
								${detail.NAME}
								<span class="iconSet">
								<c:if test="${'' ne detail.ICON_DISPLAYS}">
									<c:forTokens items="${detail.icon_displays}" delims="," var="icon">
									    <c:if test="${1 eq icon }"><em class="icon-new">NEW</em></c:if>
									    <c:if test="${2 eq icon }"><em class="icon-best">BEST</em></c:if>
									    <c:if test="${3 eq icon }"><em class="icon-pop">인기</em></c:if>
									    <c:if test="${4 eq icon }"><em class="icon-upgrade">업그레이드</em></c:if>
									    <c:if test="${5 eq icon }"><em class="icon-great">우수</em></c:if>
									</c:forTokens>


								</c:if>
								</span>
							</h3>
						</div>
						<div class="group-body borderT">
							<div class="item-img"><img src="${detail.URL_PATH}"></div>
							<ul class="info-list">
								<li class="learn-course"><em class="label">연수 영역</em> ${detail.COURSE_CODE_NAME }</li>
								<li class="learn-time"><em class="label">수강 기간</em> ${detail.COMPLETE_TIME}일</li>
								<li class="learn-score"><em class="label">학점</em> ${detail.CREDIT}학점(${detail.CREDIT_TIME}시간)</li>
								<li class="learn-max"><em class="label">모집 정원</em> <c:if test="${detail.RECRUIT == 0}">제한 없음</c:if><c:if test="${detail.RECRUIT != 0}">${detail.RECRUIT}</c:if></li>
								<li class="learn-price"><em class="label">연수비</em> <fmt:formatNumber value="${detail.PRICE}" groupingUsed="true"/>원</li>
								<li class="learn-book">
									<em class="label">교재/교구</em>
										<c:if test="${detail.MAIN_TB_ID > 0 }"><a href="#" onclick="popupMainBookInfo('${detail.ID}')">교재: ${detail.MAIN_TB_NAME} - <fmt:formatNumber value="${detail.MAIN_PRICE}" groupingUsed="true"/>원</a></c:if>
										<c:if test="${detail.MAIN_TB_ID == 0}"><a href="#">교재: 없음</a></c:if>

									<a href="#">
										교구:
										<c:if test="${detail.SUB_TB_ID > 0}"> <fmt:formatNumber value="${detail.SUB_PRICE}" groupingUsed="true"/>원</c:if>
										<c:if test="${detail.SUB_TB_ID == 0}"> 없음</c:if>
									</a>
								</li>
								<li class="learn-target"><em class="label">연수 대상</em>
									<c:set var="abcdefg" value="${detail.TARGET_TYPES }"/>
									<c:set var="abcdefg" value="${fn:replace(abcdefg, '1','유아') }"/>
									<c:set var="abcdefg" value="${fn:replace(abcdefg, '2','초등') }"/>
									<c:set var="abcdefg" value="${fn:replace(abcdefg, '3','중등') }"/>
									<c:set var="abcdefg" value="${fn:replace(abcdefg, '4','전문직') }"/>
									<c:set var="abcdefg" value="${fn:replace(abcdefg, '5','기타') }"/>
									<c:set var="abcdefg" value="${fn:replace(abcdefg, ',','·') }"/>
									${abcdefg }
								</li>
								<li class="learn-exam">
									<em class="label">출석 고사</em>
									<c:if test="${'4' eq detail.CREDIT}">
									있음(출석 평가를 합니다.)
									</c:if>
									<c:if test="${'4' ne detail.CREDIT}">
									없음(출석 평가를 하지 않습니다.)
									</c:if>

								</li>
								<li class="learn-etc"><em class="label">비고</em>
									<c:if test="${detail.MOBILE_YN == 'Y' }">
									<strong class="learn-mobile">모바일 수강 지원 과정</strong><br>
									</c:if>
									<util:cr2br value="${detail.NOTE}"/>
								</li>
							</ul>
							<p class="item-function">
								<c:if test="${not empty detail.TASTING_URL }"><a class="btn line blit btnWatch" href="${detail.TASTING_URL }" target="_blank">미리 보기</a></c:if>
								<c:if test="${empty detail.TASTING_URL }"><a class="btn line blit btnWatch" href="javascript:alertNoPreview()">미리 보기</a></c:if>
								<a class="btn blit btnCheck primary notation" href="#" data-course="${detail.ID}">연수 신청</a>
							</p>
							<p class="SNSshare">
								<a class="share-item naver" href="javascript:shareSns('naver')" title="네이버블로그로 공유"><span class="sr-only">블로그</span></a>
								<a class="share-item facebook" href="javascript:shareSns('facebook')" title="페이스북으로 공유"><span class="sr-only">페이스북</span></a>
								<a class="share-item kakao" href="javascript:shareSns('kakao')" title="카카오스토리로 공유"><span class="sr-only">카카오</span></a>
								<a class="share-item url copy_to_clipboard" href="#" title="URL복사" data-clipboard-text="${currentUrl }"><span class="sr-only">URL복사</span></a>
							</p>
						</div><!--.//.group-body-->
					</div><!--//.detailView-top-->
					<div class="detailView-body tab-group">
						<ul id="tab-detailView" class="tab-header sub x3 affixed-element-sub-top">
							<li><a class="nth-1st on" href="#learn-intro">연수 정보</a></li>
							<li><a href="#learn-contents">학습 목차</a></li>
							<li><a href="#learn-review">연수 후기</a></li>
						</ul>
						<div class="group" id="learn-intro" style="margin-top:0px">
							<div class="group-header" style="padding-top:10px">
								<h4>연수 과정 소개</h4>
							</div><!--//.group-header-->
							<div class="section">
								<div class="section-header box strong">
									<h5>연수 기간</h5>
								</div>
								<table class="table">
									<colgroup>
										<col width="180" />
										<col width="250" />
										<col width="250" />
										<col width="" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col" class="nth-1st">연수 기수</th>
											<th scope="col">신청 기간</th>
											<th scope="col">연수 기간</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="item" items="${cardinalList}" varStatus="status">
										<tr>
											<td <c:if test="${status.index == 0 }">class="nth-1st"</c:if>>${item.NAME}</td>
											<td>${item.APP_START_DATE}. ~ ${item.APP_END_DATE}.</td>
											<td>${item.LEARN_START_DATE}. ~ ${item.LEARN_END_DATE}.</td>
											<td>
												<c:if test="${item.STATUS == 'P'}"><a class="btn blit btnCheck primary" href="javascript:authAlertApply('${item.COURSE_ID }','${item.CARDINAL_ID }')">연수 신청</a></c:if>
												<c:if test="${item.STATUS == 'B'}"><a class="btn standby" href="#">대기</a></c:if>
												<c:if test="${item.STATUS == 'C'}"><a class="btn" href="#">마감</a></c:if>
											</td>
										</tr>
									</c:forEach>
									<c:if test="${empty cardinalList}">
										<tr><td colspan="4">조회된 내용이 없습니다.</td></tr>
									</c:if>
									</tbody>
								</table>
							</div><!--//.section-->
								<div class="section">
									<div class="section-header box strong">
										<h5>연수 과정 </h5>
									</div>
									<div class="section-body box">
										<ul class="info-list">
											<li><em class="label">연수 개요</em>
												${fn:replace(detail.SUMMARY, newline, '<br />')}
											</li>
											<li><em class="label">연수 목표</em>
												${fn:replace(detail.PURPOSE, newline, '<br />')}
											</li>
											<li><em class="label">강사명</em>
												<c:if test="${not empty detail.TEACHER_NAME }"><a href="<c:url value="/teacher/detail"/>?id=${detail.TEACH_ID}">${detail.TEACHER_NAME}</a></c:if>
											</li>
										</ul>
									</div>
								</div><!--//.section-->
							<div class="section">
								<div class="section-header box strong">
									<h5>평가 방법 및 이수 기준</h5>
								</div>
								<c:choose>
									<c:when test="${detail.CREDIT eq '4' }">
									<table class="table">
										<colgroup>
											<col width="10%" />
											<col width="15%" />
											<col width="*" />
											<col width="10%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col" colspan="2" class="nth-1st">평가 방법</th>
												<th scope="col">내용</th>
												<th scope="col">배점</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>오프라인 평가</td>
												<td>출석 고사</td>
												<td>객관식, 주관식 출석 고사</td>
												<td>60 점</td>
											</tr>
											<tr>
												<td rowspan="3">온라인 평가</td>
												<td>온라인 과제</td>
												<td>과정당 온라인 과제 1~2회 부과</td>
												<td>20점</td>
											</tr>
											<tr>
												<td>온라인 시험</td>
												<td>과정당 온라인 시험 1~2회 실시</td>
												<td>10 점</td>
											</tr>
											<tr>
												<td>학습 참여도</td>
												<td>질의 답변 및 연수 후기 게재 건수</td>
												<td>10 점</td>
											</tr>
										</tbody>
										<tfoot>
											<tr>
												<td class="nth-1st" colspan="2"> 이수 기준</td>
												<td colspan="2">학습 진도율 90% 이상, 연수 성적 60점 이상</td>
											</tr>
										</tfoot>
									</table>
									</c:when>
									<c:otherwise>
									<table class="table">
										<colgroup>
											<col width="10%" />
											<col width="15%" />
											<col width="*" />
											<col width="10%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col" colspan="2" class="nth-1st">평가 방법</th>
												<th scope="col">내용</th>
												<th scope="col">배점</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td rowspan="3">온라인 평가</td>
												<td>온라인 과제</td>
												<td>과정당 온라인 과제 1~2회 부과</td>
												<td>40점</td>
											</tr>
											<tr>
												<td>온라인 시험</td>
												<td>과정당 온라인 시험 1~2회 실시</td>
												<td>40점</td>
											</tr>
											<tr>
												<td>학습 참여도</td>
												<td>질의 답변 및 연수 후기 게재 건수</td>
												<td>20점</td>
											</tr>
										</tbody>
										<tfoot>
											<tr>
												<td class="nth-1st" colspan="2"> 이수 기준</td>
												<td colspan="2">학습 진도율 90% 이상, 연수 성적 60점 이상</td>
											</tr>
										</tfoot>
									</table>
									</c:otherwise>
								</c:choose>
							</div><!--//.section-->
						</div><!--//.group#learn-intro-->
						<div class="group" id="learn-contents">
							<div class="group-header">
								<h4>학습 목차</h4>
							</div><!--//.group-header-->
							<table class="table">
								<colgroup>
									<col width="50" />
									<col width="*" />
									<col width="70" />
									<col width="80" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="item-no nth-1st">차시</th>
										<th scope="col" class="item-title">차시명</th>
										<th scope="col">강사명</th>
										<th scope="col">학습 시간</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${chapterList}" varStatus="status">
									<tr>
										<td class="item-no <c:if test="${status.index == 0 }">nth-1st</c:if>">${status.count}</td><!-- ie8에서는 nth-first 선택자를 이용할 수 없으므로 첫번째 아이템에만 class 명으로 부여 -->
										<td class="item-title" style="text-align:left;padding:10px">${item.NAME}</td>
										<td>${item.TEACHER}</td>
										<td style="min-width:80px">${item.STUDY}분</td>
										<%-- <td style="min-width:80px">${item.STUDY2}</td> --%>
									</tr>
									</c:forEach>
								 	<c:if test="${empty chapterList}">
										<tr><td colspan="4">조회된 내용이 없습니다.</td></tr>
									</c:if>
								</tbody>
							</table>
						</div><!--//.group#learn-contents-->
						<t:insertDefinition name="review"/>
					</div><!--//.detailView-body-->
				</div><!--//learn-detailView-->
			</div><!--//.sub-body-->
			<!--본문 내용 출력 공간-->
		</div><!--//.body-->
<!--// 1.3. 본문 -->