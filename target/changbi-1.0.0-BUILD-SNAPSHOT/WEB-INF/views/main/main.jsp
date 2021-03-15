<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>

<style>
#list-learn thead th {border-top: 1px solid #e0e0e0;}
#courseFilterCredit li.total:before {background:none}
</style>
<sec:authentication property="principal" var="principal" />

<script type="text/javascript" src="/resources/js/jsrender.js"></script>

<!-- 1.2. 메인 비주얼 배너 -->
		<div class="main visualBN">
			<div class="main_slide">
				<c:if test="${empty topBannerList }">
				<div><a href="/learn/course/detail?course_id=c000000007" tabindex="0"><img class='slider_image' src='/resources/images/imsi/main-slide_1805-1.jpg' alt="이강룡의 교사에게 필요한 글쓰기 기본기"/></a></div>
				</c:if>
				<c:forEach var="item" items="${topBannerList }">
				<div><a href="${item.URL }" target="${item.TARGET }"><img class='slider_image' src='<c:url value="${item.IMG_URL }"/>' alt="<util:strcut len="28" value="${item.TITLE }"/>"/></a></div>
				</c:forEach>
			</div>
		</div><!--//.area-visualBN-->
<!--// 1.2. 메인 비주얼 배너  -->

<!-- 1.3. 사이드 LEFT -->
		<div class="main sideL">
			<sec:authorize access="isAnonymous()" var="isAnonymous">
			<form class="login_wrap" id="lloginForm" method="post" action="<c:url value="/user/signin"/>">
				<input type="text" placeholder="아이디" name="username">
				<input type="password" placeholder="비밀번호" name="password">
				<input type="checkbox" name="sslLoginEnable"><label>보안 로그인 사용</label>
				<input type="checkbox" name="saveIdChecked" value="Y"><label>아이디 저장</label>
				<button type="button" onclick="gLogin('lloginForm')">로그인</button>
				<a href="<c:url value="/member/join1"/>" class="register">회원가입</a>
				<a href="<c:url value="/member/findId"/>" class="help">아이디/비밀번호 찾기</a>
			</form>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
			<form class="login_wrap">
				<p>즐거운 연수 시간 되세요.</p>
				<span><strong>${principal.name}</strong> 선생님<br> 로그인 중입니다.<em><c:if test="${not empty principal.school_name}">(${principal.school_name})</c:if></em></span>
				<a href="<c:url value="/mypage/lecture/lecture1"/>" class="register">나의 강의실</a>
				<div class="login-util">
					<a href="<c:url value="/user/signout"/>">로그아웃</a><i>I</i><a href="<c:url value="/mypage/private/privatecertification"/>">개인 정보 수정</a><i>I</i><a href="<c:url value="/mypage/note/received"/>">쪽지함</a>
				</div>
			</form>
			</sec:authorize>
			<div class="sideL_banner">
				<h3>교육청(기관) 연수</h3>
				<ul class="groupLearn_banner">
					<c:set var="groupLearnLen" value="${fn:length(groupLearnBannerList) }"/>
					<c:forEach var="item" items="${groupLearnBannerList }" varStatus="status">
					<li <c:if test="${status.index+1 == groupLearnLen }"></c:if>>
						<c:if test="${item.CLOSE_YN == 'Y' }"><p class="label">마감</p></c:if>
						<a href="<c:url value="/learn/course/groupDetail"/>?closed=${item.CLOSE_YN}&group_id=${item.ID }&course_id=${item.COURSE_ID }&cardinal_seq=${item.CARDINAL_SEQ}">
							<img class="item-logo" src="<c:url value="${item.BANNER_URL }"/>" alt="배너">
							<span class="item-title">
								<strong><c:out value="${item.REGION_NAME }"/></strong> <c:out value="${item.NAME }"/>
							</span>
						</a>
					</c:forEach>
				</ul>
			</div>
			<div class="sideL_schedule">
				<h3>다음 연수 일정</h3>
				<ul>
					<li class="today">
						<div><em>TODAY</em><span>${today }</span></div><a href="<c:url value="/guide/training/schedule"/>">전체 일정 보기</a>
					</li>
					<c:forEach var="item" items="${cardinalBannerList }">
					<li>
						<div><em><c:out value="${item.APP_POSSIBLES }"/></em><span>학점</span></div>
						<dl>
							<dt>신청 기간</dt>
							<dd><c:out value="${item.APP_END_DATE }"/> 까지</dd>
							<dt>연수 기간</dt>
							<dd><c:out value="${item.LEARN_START_DATE }"/> ~ <c:out value="${item.LEARN_END_DATE }"/> </dd>
						</dl>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<!--//.sideL-->
<!--// 1.3. 사이드 LEFT  -->
<!-- 1.4. 본문 -->
		<div class="body">
			<!-- 창비 추천 연수 -->
			<div id="mainRecommand" class="tab-group">
				<ul class="tab-header x4" id="recommendFilterGubun">
					<li><a class="nth-1st on" href="#" data-gubun="1">창비 추천 과정</a></li>
					<li><a href="#" data-gubun="N">신규 과정</a></li>
					<li><a href="#" data-gubun="3">중등 추천 과정</a></li>
					<li><a href="#" data-gubun="2">초등 추천 과정</a></li>
				</ul>
				<div class="tab-body">
					<div class="gallery" id="recommCourseList">
							<c:forEach var="item" items="${recommCourseList }">
							<div class="item">
								<div class="item-img"><img src="<c:url value="${item.PHOTO_URL }"/>"></div>
								<div class="item-summary">
									<em class="item-type v<c:out value="${item.CREDIT }"/>"><c:out value="${item.CREDIT }"/>학점</em>
									<strong><a class="item-title" href="<c:url value="/learn/course/detail"/>?course_id=${item.ID }"><c:out value="${item.NAME }"/></a></strong>
									<ul class="item-info">
										<li class="learn-course"><em class="sr-only">연수 영역: </em><c:out value="${item.COURSE_CODE_NAME }"/></li>
										<li class="learn-time"><em class="sr-only">수강 기간: </em><c:out value="${item.CREDIT_TIME }"/>시간</li>
										<%-- <c:if test="${item.MOBILE_YN == 'Y' }">
										<li class="learn-mobile"><em class="sr-only">모바일 연수 가능</em></li>
										</c:if> --%>
									</ul>
									<p class="item-function">
										<c:if test="${not empty item.TASTING_URL }"><a class="btn line blit btnWatch" href="${item.TASTING_URL }" target="_blank">미리 보기</a></c:if>
										<c:if test="${empty item.TASTING_URL }"><a class="btn line blit btnWatch" href="javascript:alertNoPreview()" target="_blank">미리 보기</a></c:if>
										<a class="btn blit btnCheck primary" href="javascript:popCourseCardinalSelect('${item.ID }')">연수 신청</a>
									</p>
								</div>
							</div>
							</c:forEach>
					</div><!--//.gallery-->
					<div class="list-bottom">
						<button class="btn-more" id="moreRecommCourseBtn" <c:if test="${recommSearchVo.totalPages <= recommSearchVo.startPage }">style="display:none"</c:if> data-totalpages="${recommSearchVo.totalPages }" data-startpage="${recommSearchVo.startPage }"><span class="sr-only">더 보기</span></button>
					</div>
				</div><!--//.tab-body-->
			</div><!--//.tab-group-->
			<div id="mainTeacher" class="group">
				<h4><img src="/resources/images/main-banner.png" alt="우리 시대의 멘토 창비의 인문·교양 강좌에서 만날 수 있습니다."></h4>
				<div class=" teacher-list">
				<c:forEach var="item" items="${teacherList }">
				<a class="item" href="<c:url value="/teacher/detail"/>?id=${item.ID}">
					<div class="item-img"><img src="<c:url value="${item.PHOTO_URL }"/>"></div>
					<div class="item-summary">
						<em class="item-category"><c:out value="${item.MAIN_COURSE_NAME }"/></em>
						<strong class="item-title"><c:out value="${item.NAME }"/></strong>
					</div>
				</a>
				</c:forEach>
				</div>
			</div>
			<div id="mainCourse" class="group tab-group">
				<div class="group-header">
					<h4>영역별 연수 과정</h4>
				</div>
				<ul class="tab-header sub" id="courseFilterCourse">
					<li><a class='nth-1st on' href="#" data-course="">전체 보기</a></li>
					
					<script>
						console.log('${courseCodeList}');
					</script>
					
					<c:forEach var="item" items="${courseCodeList}" varStatus="status">
					<li><a href="#" data-course="${item.CODE }"><c:out value="${item.NAME}"/></a></li>
					</c:forEach>
				</ul>

				<div class="tab-body clearL">
					<div class="list-top">
						<ul class="min-filter" id="courseFilterCredit">
							<li class="on"><button data-credit="1">1학점</button></li>
							<li><button data-credit="2">2학점</button></li>
							<li><button data-credit="3">3학점</button></li>
							<li><button data-credit="4">4학점</button></li>
							<li class="total">총 <span id="courseByCourseListTotCnt">${fn:length(courseList) } </span>개의 과정이 검색되었습니다.</li>
						</ul>
						<p class="ctrl-btnSet" id="courseSort">
							<strong class="icon ci-align"><span class="sr-only">정렬 :</span></strong>
							<button class="on nth-1st" type="button" data-sort="H"><span>인기순</span></button>
							<button type="button" data-sort="S"><span>판매순</span></button>
							<button type="button" data-sort="D"><span>최신순</span></button>
						</p>
					</div>
					<table id="list-learn" class="list">
						<thead>
							<tr>
								<th scope="col" class="item-title">연수 과정명</th>
								<th scope="col" class="item-teacher">강사명</th>
								<th scope="col" class="item-score">학점</th>
								<th scope="col" class="item-price">연수비</th>
								<th scope="col" class="item-book">교재</th>
								<th scope="col" class="item-function">미리 보기</th>
								<th scope="col" class="item-function">연수 신청</th>
							</tr>
						</thead>
						<tbody id="courseByCourseList">
							<c:forEach var="item" items="${courseList }" varStatus="status">
							<tr <c:if test="${status.index == 0 }">class="nth-1st"</c:if>>
								<td class="item-title">
									<a href="<c:url value="/learn/course/detail"/>?course_id=${item.ID}"><strong><c:out value="${item.NAME }"/></strong></a>
								</td>
								<td class="item-teacher">${item.TEACHER_NAME}</td>
								<td class="item-score">${item.CREDIT}학점(${item.CREDIT_TIME}시간)</td>
								<td class="item-price"><fmt:formatNumber value="${item.PRICE }"/></td>
								<td class="item-book">
									<c:if test="${not empty item.MAIN_TB_NAME }">${item.MAIN_TB_NAME }</c:if>
									<c:if test="${empty item.MAIN_TB_NAME}">없음</c:if>
								</td>
								<td class="item-function">
								<c:if test="${not empty item.TASTING_URL }"><a class="btn line icon btnWatch" href="${item.TASTING_URL }" target="_blank"><span class="sr-only">미리 보기</span></a></c:if>
								<c:if test="${empty item.TASTING_URL }"><a class="btn line icon btnWatch" href="javascript:alertNoPreview()"><span class="sr-only">미리 보기</span></a></c:if>
								</td>
								<td class="item-function"><a class="btn blit btnCheck primary" href="javascript:popCourseCardinalSelect('${item.ID }')">연수 신청</a></td>
							</tr>
							</c:forEach>
							<c:if test="${empty courseList }">
							<tr><td colspan="7" class="alignC" style="padding:15px">해당 하는 과정이 존재하지 않습니다.</td></tr>
							</c:if>
						</tbody>
					</table>
				</div><!--//.tab-body-->
			</div>
			<div id="mainLatest" class="group">
				<div class="section">
					<div class="section-header">
						<h4>공지 사항</h4>
						<p class="ctrl-btnSet">
							<a href="<c:url value="/serviceCenter/bbs/notice?board_type=1"/>">더 보기 +</a>
						</p>
					</div>
					<div class="section-body borderT">
						<ul class="latest-list">
							<c:forEach var="item" items="${noticeList }">
							<li><a href="<c:url value="/serviceCenter/bbs/noticeDetail"/>?board_type=1&id=${item.ID}"><util:strcut len="50" value="${item.TITLE }"/></a></li>
							</c:forEach>
							<c:if test="${empty faqList }"><li class="alignC">등록된 내용이 없습니다.</li></c:if>
						</ul>
					</div>
				</div><!--//.section-->
				<div class="section">
					<div class="section-header">
						<h4>자주 묻는 질문</h4>
						<p class="ctrl-btnSet">
							<a href="<c:url value="/serviceCenter/bbs/faq?board_type=3&faq_code=0"/>">더 보기 +</a>
						</p>
					</div>
					<div class="section-body borderT">
						<ul class="latest-list">
							<c:forEach var="item" items="${faqList }">
							<li><a href="<c:url value="/serviceCenter/bbs/faq"/>?board_type=3&faq_code=${item.FAQ_CODE }&id=${item.ID}"><util:strcut len="50" value="${item.TITLE }"/></a></li>
							</c:forEach>
							<c:if test="${empty faqList }"><li class="alignC">등록된 내용이 없습니다.</li></c:if>
						</ul>
					</div>
				</div><!--//.section-->
				<div class="section">
					<div class="section-header">
						<h4>고객 센터</h4>
					</div>
					<div class="section-body box">
						<ul class="sr-only">
							<li>대표전화: 1833-7247</li>
							<li>Fax: 02-6949-0953</li>
							<li>운영시간<br>
							[평일] 09:00~18:00<br>
							[점심] 12:00~13:00
							</li>
						</ul>
					</div>
				</div><!--//.section-->
			</div><!--//.group-->
		</div>
		<!--//.body-wrap-->
<!--// 1.4. 본문 -->
<!-- 1.5. 사이드 RIGHT -->
		<div class="main sideR">
			<div class="sideR_icon">
				<h3>빠른 서비스</h3>
				<ul>
					<li><a href="<c:url value="/guide/training/schedule"/>"><img src="/resources/images/sideR_icon_1.png" alt="연간 연수 일정"><span>2018년<br> 연수 일정</span></a></li>
					<li><a href="javascript:authAlertMove('<c:url value="/mypage/change/change"/>')"><img src="/resources/images/sideR_icon_2.png" alt="수강 연기"><span style="padding-top: 5px;">수강 연기</span></a></li>
					<li><a href="javascript:authAlertMove('<c:url value="/mypage/note/received"/>')"><img src="/resources/images/sideR_icon_3.png" alt="나의 쪽지함"><span>나의<br> 쪽지함</span></a></li>
				</ul>
				<ul>
					<li><a href="javascript:authAlertMove('<c:url value="/mypage/receipt/receipt"/>')"><img src="/resources/images/sideR_icon_4.png" alt="영수증 발급"><span>영수증<br> 발급</span></a></li>
					<li><a href="javascript:authAlertMove('<c:url value="/mypage/receipt/receipt"/>')"><img src="/resources/images/sideR_icon_5.png" alt="이수증 발급"><span>이수증<br> 발급</span></a></li>
					<li><a href="javascript:authAlertMove('<c:url value="/mypage/receipt/receipt"/>')"><img src="/resources/images/sideR_icon_6.png" alt="수강증 확인"><span>수강증<br> 확인</span></a></li>
				</ul>
				<ul>
					<li><a href="<c:url value="/guide/training/offidoc/list"/>"><img src="/resources/images/sideR_icon_7.png" alt="연수 안내 공문"><span>연수 안내<br> 공문</span></a></li>
					<li><a href="#"><img src="/resources/images/sideR_icon_8.png" alt="교육부 인가서"><span>교육부<br> 인가서</span></a></li>
					<li><a href="<c:url value="/serviceCenter/remote/remote"/>"><img src="/resources/images/sideR_icon_10.png" alt="원격 지원서비스"><span>원격 지원<br> 서비스</span></a></li>
				</ul>
			</div>
			<div class="sideR_banner">
				<ul>
					<%--
					<li><img src="/resources/images/sideR_banner_1.png" alt="배너1"></li>
					<li><img src="/resources/images/sideR_banner_2.png" alt="배너2"></li>
					<li><img src="/resources/images/sideR_banner_3.png" alt="배너3"></li>
					<li><img src="/resources/images/sideR_banner_4.png" alt="배너4"></li>
					 --%>
				</ul>
			</div>
			<a class="sideR_banner_close" href="#"><i class="remove"></i><span>배너 접기</span></a>
		</div><!--//.area-sideR-->
<!--// 1.5. 사이드 RIGHT  -->

<!-- 추천과정 템플릿 -->
<script id="recommCourseTmpl" type="text/x-jsrender">
<div class="item">
	<div class="item-img"><img src="{{:PHOTO_URL}}"/></div>
	<div class="item-summary">
		<em class="item-type v{{:CREDIT}}">{{:CREDIT}}학점</em>
		<strong><a class="item-title" href="<c:url value="/learn/course/detail"/>?course_id={{:ID}}">{{:NAME}}</a></strong>
		<ul class="item-info">
			<li class="learn-course"><em class="sr-only">연수 영역: </em>{{:COURSE_CODE_NAME}}</li>
			<li class="learn-time"><em class="sr-only">수강 기간: </em>{{:CREDIT_TIME}}시간</li>
			{{if MOBILE_YN == 'Y'}}
			<li class="learn-mobile"><em class="sr-only">모바일 연수 가능</em></li>
			{{/if}}
		</ul>
		<p class="item-function">
			{{if TASTING_URL != '' }}
			<a class="btn line blit btnWatch" href="{{:TASTING_URL}}" target="_blank">미리 보기</a>
			{{else}}
			<a class="btn line blit btnWatch" href="javascript:alertNoPreview()" target="_blank">미리 보기</a>
			{{/if}}
			<a class="btn primary" href="javascript:popCourseCardinalSelect('{{:ID}}')">신청</a>
		</p>
	</div>
</div>
</script>
<!-- 분아별과정 템플릿 -->
<script id="courseByCourseTmpl" type="text/x-jsrender">
<tr>
	<td class="item-title"><a href="<c:url value="/learn/course/detail"/>?course_id={{:ID}}"><strong>{{:NAME}}</strong></a></td>
	<td class="item-teacher">{{:TEACHER_NAME}}</td>
	<td class="item-score">{{:CREDIT}}학점({{:CREDIT_TIME}}시간)</td>
	<td class="item-price">{{:~formatNumber(PRICE)}}</td>
	<td class="item-book">
		{{if MAIN_TB_NAME}}{{:MAIN_TB_NAME}}{{/if}}
		{{if !MAIN_TB_NAME}}없음{{/if}}
	</td>
	<td class="item-function">
		{{if TASTING_URL != '' }}<a class="btn line icon btnWatch" href="{{:TASTING_URL}}" target="_blank"><span class="sr-only">미리 보기</span></a>
		{{else}} <a class="btn line icon btnWatch" href="javascript:alertNoPreview()" target="_blank"><span class="sr-only">미리 보기</span></a>{{/if}}
	</td>
	<td class="item-function"><a class="btn blit btnCheck primary" href="javascript:popCourseCardinalSelect('{{:ID}}')">연수 신청</a></td>
</tr>
</script>

<script type="text/javascript">
$(document).ready(function(){
	$('.main_slide').slick({
		dots: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 2000,
		prevArrow : '<button type="button" class="prev"><span class="sr-only">이전</span></button>',
		nextArrow : '<button type="button" class="next"><span class="sr-only">다음</span></button>',
		customPaging: function(slider, i) {
			var txt = $('.main_slide img.slider_image').eq(i).attr('alt');
			if(isEmpty(txt)) txt = ''+(i+1);
			return $('<button type="button" />').text(txt);
		},
	});

	// cookie id
	var __u__ = ($.cookie("__cbuser__") || '');
	$('input[name="saveIdChecked"]').prop('checked', __u__ !== '');
	$('input[name="username"]').val(__u__);

	// 비번변경
	var __p__ = ($.cookie("__initpass__") || '');
	$.removeCookie("__initpass__");	// 로그인 후 최초 1회에 한하여 변경 화면 pop
	if (__p__ == 'Y') {
		$.ajax({
			type: "POST",
			url: "<c:url value='/common/layer/pwChange' />",
			dataType: "text",
			success: function(txt) {
				$(document.body).append(txt);
				popupOpen('layerPasswordChange');
			}
		});
	}

	// 비밀번호 enter시 로그인 진행
	$('#lloginForm input[name="password"]').keypress(function (e) {
		if (e.which == 13) {
			gLogin('lloginForm');
		}
	});

	// 우측 배너
	if($('.sideR_banner').length > 0) {
		$.getJSON('<c:url value="/ajaxSideBanners"/>', function(data) {
			var banners = data.banners;
			for(var i=0; i<banners.length; i++) {
				var b = banners[i];
				$('.sideR_banner ul').append('<a href="'+b['URL']+'" target="'+b['TARGET']+'"><img src="'+b['IMG_URL']+'" alt="'+b['TITLE']+'"></a> ');
			}
		});
	}
	// banner 접기
	$('a.sideR_banner_close').click(function() {
		if($('.sideR_banner').is(':hidden')) {
			$(this).find('i').addClass('remove');
			$(this).find('span').text('배너 접기');
			$('.sideR_banner').show();
		} else {
			$(this).find('i').removeClass('remove');
			$(this).find('span').text('배너 보기');
			$('.sideR_banner').hide();
		}
	});

	// 탭 갯수 자동 판별
	if($.fn.tabLength != null ) $('.tab-group > .tab-header.sub').tabLength();
});
</script>
<script type="text/javascript">
/** 추천 과정 조회 **/
$(document).ready(function () {
	// 추천과정 탭 처리
	$('#recommendFilterGubun a').click(function() {
		var gubun = $(this).data('gubun');
		if($('#recommendFilterGubun a.on').data('gubun') == gubun) return;

		$('#recommendFilterGubun a.on').removeClass('on');
		$(this).addClass('on');

		getAjaxMainRecommendCourseList(1);
	});
	// 추천과정 더보기
	$('#moreRecommCourseBtn').click(function() {
		var totalPages = parseInt($(this).data('totalpages'),10);
		var startPage = parseInt($(this).data('startpage'),10);

		if (startPage >= totalPages) return;
		getAjaxMainRecommendCourseList(startPage+1);
	});
});

// 추천과정조회
function getAjaxMainRecommendCourseList(page) {
	var param = {
		  'gubun': $('#recommendFilterGubun a.on').data('gubun'),
		  'startPage': page?page:1
	};
	$.getJSON('<c:url value="/ajaxMainRecommendCourseList"/>', param, function(data) {
		var courseList = data.recommCourseList;
		var searchVo = data.recommSearchVo;

		if (typeof(courseList) == 'undefined' || typeof(searchVo) == 'undefined') return;
		$('#moreRecommCourseBtn').data('startpage', searchVo.startPage)
								.data('totalages', searchVo.totalPages);

		if(searchVo.totalPages <= searchVo.startPage) $('#moreRecommCourseBtn').hide();
		else $('#moreRecommCourseBtn').show();

		var html = $("#recommCourseTmpl").render(courseList);
		if (searchVo.startPage == 1) {
			$("#recommCourseList").html(html);
		} else {
			$("#recommCourseList").append(html);
		}
	});
}
</script>
<script type="text/javascript">
/** 분야별 과정 조회 **/
$(document).ready(function () {
	$('#courseFilterCourse a').click(function() {
		var course = $(this).data('course');
		if($('#courseFilterCourse a.on').data('course') == course) return;

		$('#courseFilterCourse a.on').removeClass('on');
		$(this).addClass('on');

		getAjaxMainCourseListByCourse();
	});
	$('#courseFilterCredit button').click(function() {
		var credit = $(this).data('credit');
		if($('#courseFilterCredit li.on button').data('credit') == credit) return;

		$('#courseFilterCredit li.on').removeClass('on');
		$(this).parent().addClass('on');

		getAjaxMainCourseListByCourse();
	});
	$('#courseSort button').click(function() {
		var sort = $(this).data('sort');
		if($('#courseSort button.on').data('sort') == sort) return;

		$('#courseSort button.on').removeClass('on');
		$(this).addClass('on');

		getAjaxMainCourseListByCourse();
	});
});
// 분야별 과정 조회
function getAjaxMainCourseListByCourse() {
	var param = {
		  'course': $('#courseFilterCourse a.on').data('course')
		, 'credit': $('#courseFilterCredit li.on button').data('credit')
		, 'sort': $('#courseSort button.on').data('sort')
	};

	$.getJSON('<c:url value="/ajaxMainCourseListByCourse"/>', param, function(data) {
		var courseList = data.courseList;

		if (typeof(courseList) == 'undefined') return;

		$('#courseByCourseListTotCnt').text(courseList.length);
		if (courseList.length < 1) {
			$("#courseByCourseList").html('<tr><td colspan="7" class="alignC" style="padding:15px">해당 하는 과정이 존재하지 않습니다.</td></tr>');
		} else {
			$("#courseByCourseList").html($("#courseByCourseTmpl").render(courseList, {'formatNumber': addComma}));	// formatNumber helper 등록
		}
	});
}
</script>
