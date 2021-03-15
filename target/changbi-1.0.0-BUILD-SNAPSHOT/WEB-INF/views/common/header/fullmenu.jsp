<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="util" uri="http://www.aracomm.com/customtag/util" %>

						<c:if test="${currentDevice.mobile }">
							<c:if test="${not empty principal }">
							<sec:authorize access="isAnonymous()">
								<p class="loginMenu">
									<a href="javascript:popupOpen('layerLogin')">로그인</a>이 필요합니다.
									<a href="<c:url value="/member/join1"/>" class="btn primary">회원 가입</a>
								</p>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<p class="loginMenu">
									<a><util:strcut len="18" value="${principal.name}"/></a>님
									<a href="<c:url value="/user/signout"/>" class="btn primary">로그아웃</a>
									<a href="<c:url value="/mypage/private/privatecertification"/>" class="btn">개인 정보 수정</a>
								</p>
							</sec:authorize>
							</c:if>
							<c:if test="${empty principal }">
								<p class="loginMenu">
									<a href="javascript:popupOpen('layerLogin')">로그인</a>이 필요합니다.
									<a href="<c:url value="/member/join1"/>" class="btn primary">회원 가입</a>
								</p>
							</c:if>
						</c:if>

						<c:if test="${currentDevice.mobile }">
						<ul class="menu-d1">
							<li>
								<h5><a href="#">나의 강의실</a></h5>
								<ul class="menu-d2">
									<li>
										<a href="#">강의실</a>
										<ul class="menu-d3">
											<li><a href="javascript:authAlertMove('<c:url value="/mypage/lecture/lecture1"/>')">연수 과정</a></li>
										</ul>
									</li>
									<li>
										<a href="#">개인 정보</a>
										<ul class="menu-d3">
											<li><a href="javascript:authAlertMove('<c:url value="/mypage/private/privatecertification"/>')">개인 정보 수정</a></li>
											<li><a href="javascript:authAlertMove('<c:url value="/mypage/private/secessioncertification"/>')">회원 탈퇴</a></li>
										</ul>
									</li>
								</ul>
							</li>
							<li>
								<h5><a href="#">연수 신청</a></h5>
								<ul class="menu-d2">
									<li>
										<a href="<c:url value="/learn/course/course?course_code=0"/>">영역별 연수</a>
									</li>
								</ul>
							</li>
							<li>
								<h5><a href="#">연수 안내</a></h5>
								<ul class="menu-d2">
									<li>
										<a href="#">원격 연수</a>
										<ul class="menu-d3">
											<li><a href="<c:url value="/guide/training/guide"/>">원격 연수 안내</a></li>
											<li><a href="<c:url value="/guide/training/evaluation"/>">평가 이수 방법</a></li>
										</ul>
									</li>
								</ul>
							</li>
							<li>
								<h5><a href="#">고객 센터</a></h5>
								<ul class="menu-d2">
									<li><a href="<c:url value="/serviceCenter/bbs/faq?board_type=3&faq_code=0"/>">자주 묻는 질문</a></li>
									<li><a href="<c:url value="/serviceCenter/bbs/notice?board_type=1"/>">공지 사항</a></li>
									<li><a href="javascript:authAlertMove('<c:url value="/serviceCenter/bbs/qna?board_type=4&faq_code=0"/>')">1:1 상담</a></li>
								</ul>
							</li>
							<li>
								<h5><a href="#">연수원 소개</a></h5>
								<ul class="menu-d2">
									<li><a href="<c:url value="/footer/intro"/>">소개</a></li>
									<li><a href="<c:url value="/footer/organization"/>">조직도</a></li>
									<li><a href="<c:url value="/footer/location"/>">찾아오시는 길</a></li>
									<li><a href="<c:url value="/footer/provision"/>">연수원 규정</a></li>
								</ul>
							</li>
						</ul>
						</c:if>

						<c:if test="${not currentDevice.mobile }">
						<ul class="menu-d1">
							<li>
								<h5><a href="#">나의 강의실</a></h5>
								<ul class="menu-d2">
									<li>
										<a href="#">강의실</a>
										<ul class="menu-d3">
											<li><a href="javascript:authAlertMove('<c:url value="/mypage/lecture/lecture1"/>')">연수 과정</a></li>
											<li><a href="javascript:authAlertMove('<c:url value="/mypage/change/change"/>')">연수 연기/취소</a></li>
										</ul>
									</li>
									<li><a href="javascript:authAlertMove('<c:url value="/mypage/receipt/receipt"/>')">영수증/이수증 정보</a></li>
									<li><a href="javascript:authAlertMove('<c:url value="/mypage/delivery/delivery"/>')">배송 정보</a></li>
									<li><a href="javascript:authAlertMove('<c:url value="/mypage/point/point"/>')">포인트/쿠폰 정보</a></li>
									<li><a href="javascript:authAlertMove('<c:url value="/mypage/note/received"/>')">쪽지함</a></li>
									<li>
										<a href="#">개인 정보</a>
										<ul class="menu-d3">
											<li><a href="javascript:authAlertMove('<c:url value="/mypage/private/privatecertification"/>')">개인 정보 수정</a></li>
											<li><a href="javascript:authAlertMove('<c:url value="/mypage/private/secessioncertification"/>')">회원 탈퇴</a></li>
										</ul>
									</li>
									<li><a href="javascript:authAlertMove('<c:url value="/mypage/ip/ip"/>')">접속 IP 등록/변경/삭제</a></li>
								</ul>
							</li>
							<li>
								<h5><a href="#">연수 신청</a></h5>
								<ul class="menu-d2">
									<li>
										<a href="<c:url value="/learn/course/course?course_code=0"/>">영역별 연수</a>
									</li>
									<li>
										<a href="<c:url value="/learn/course/grades?credit=0"/>">학점별 연수</a>
									</li>
									<li>
										<a href="<c:url value="/learn/course/object?target_types=0"/>">대상별 연수</a>
									</li>
									<%--
									<li>
										<a href="<c:url value="/learn/course/group"/>">교육청(기관) 연수</a>
									</li>
									<li>
										<a href="<c:url value="/learn/course/autonomy?course_code=0"/>">자율 연수</a>
									</li>
									<li>
										<a href="<c:url value="/learn/course/set?course_code=0"/>">집합 연수</a>
									</li>
									 --%>
								</ul>
							</li>
							<li>
								<h5><a href="#">연수 안내</a></h5>
								<ul class="menu-d2">
									<li>
										<a href="#">원격 연수</a>
										<ul class="menu-d3">
											<li><a href="<c:url value="/guide/training/guide"/>">원격 연수 안내</a></li>
											<li><a href="<c:url value="/guide/training/class"/>">수강 방법</a></li>
											<li><a href="<c:url value="/guide/training/evaluation"/>">평가 이수 방법</a></li>
											<li><a href="<c:url value="/guide/training/attendance"/>">출석 고사</a></li>
											<li><a href="<c:url value="/guide/training/change"/>">연수 연기/취소</a></li>
											<li><a href="<c:url value="/guide/training/number"/>">연수 지명 번호 안내</a></li>
											<li><a href="<c:url value="/guide/training/schedule"/>">연간 연수 일정</a></li>
											<li><a href="<c:url value="/guide/training/offidoc/list"/>">연수 공문</a></li>
										</ul>
									</li>
									<li><a href="<c:url value="/guide/training/group"/>">교육청(기관) 연수</a></li>
									<li><a href="<c:url value="/guide/training/autonomy"/>">자율 연수</a></li>
									<li><a href="<c:url value="/guide/training/set"/>">집합 연수</a></li>
								</ul>
							</li>
							<li>
								<h5><a href="<c:url value="/teacher/list"/>">강사 소개</a></h5>
								<ul class="menu-d2">
									<li><a href="<c:url value="/teacher/list"/>">이달의 창비 강사</a></li>
									<li><a href="<c:url value="/teacher/list"/>">영역별 강사</a></li>
								</ul>
							</li>
							<li>
								<h5><a href="#">고객 센터</a></h5>
								<ul class="menu-d2">
									<li><a href="<c:url value="/serviceCenter/bbs/notice?board_type=1"/>">공지 사항</a></li>
									<li><a href="<c:url value="/serviceCenter/bbs/faq?board_type=3&faq_code=0"/>">자주 묻는 질문</a></li>
									<li><a href="javascript:authAlertMove('<c:url value="/serviceCenter/bbs/qna?board_type=4&faq_code=0"/>')">1:1 상담</a></li>
									<li><a href="<c:url value="/serviceCenter/remote/remote"/>">PC 원격 지원</a></li>
									<li><a href="<c:url value="/serviceCenter/bbs/program?board_type=2"/>">학습 프로그램</a></li>
									<li><a href="<c:url value="/serviceCenter/event/eventList"/>">이벤트</a></li>
									<li><a href="<c:url value="/serviceCenter/teacher/teacher"/>">강사 지원</a></li>
									<li><a href="<c:url value="/serviceCenter/alliance/alliance"/>">제휴 문의</a></li>
								</ul>
							</li>
						</ul>
						</c:if>
