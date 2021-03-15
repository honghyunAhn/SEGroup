<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="cl-popup-overlay" id="popupReview">
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
						<h3 class="popup-title">연수 후기 쓰기</h3>
					</div>
					<div class="popup-body">
							<!-- <div class="section">
								즐겁고 유익한 연수 시간이 되셨기를 바래봅니다.<br>
								저희 창비교육원격교육연수원에서는 늘 최선을 다하여 알찬 연수를 만들어 가겠습니다.<br>
								연수 후기를 작성하시면 소정의 감사 포인트를 드립니다. 적립된 포인트는 [내 정보]에서 확인할 수 있습니다.
							</div> -->
							<div class="section">
								즐겁고 유익한 연수 시간이 되셨나요?<br>
								창비교육 원격교육연수원은 최선을 다하여 알찬 연수를 만들어 가겠습니다.<br>
								선생님께서 작성해 주신 연수 후기는 향후 연수 과정 개발에 적극 반영하도록 하겠습니다.<br>
								감사합니다.
							</div>
							<form id="reviewForm">
								<input type="hidden" name="cardinal" value="${classParam.cardinal }">
								<input type="hidden" name="course" value="${classParam.course }">
								<input type="hidden" name="id" value="${classParam.id }">
								<dl>
									<dt>연수 과정</dt>
									<dd>
										<!-- <select class="nth-1st">
											<option>후기를 작성하실 연수과정이 없습니다. </option>
										</select> -->
										<span>${classInfo.NAME }</span>
									</dd>
									<dt>제목</dt>
									<dd>
										<input class="nth-1st width100" type="text" name="title">
									</dd>
								</dl>
								<div class="write-page">
									<textarea placeholder="내용을 입력하세요." name="comment"></textarea>
								</div>
								<div class="view-util">
									<div class="btnSet">
										<a href="#" onclick="popupClose('popupReview')" class="btn float_left primary">취소</a>
										<a href="#" class="btn float_right primary" onclick="saveReview()">등록</a>
									</div>
								</div>
							</form>
					</div><!--//.popup-body-->
				</div><!--//.cl-popup-box-->
			</div><!--//.cl-popup-wrap-->
			<button class="cl-popup-closer">
				<span class="sr-only">닫기</span>
			</button>
		</div>