<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--// 2.팝업 -->
		<div class="cl-popup-overlay " id="notationpop">
			<div class="cl-popup-wrap">
				<c:choose>
					<c:when test="${currentDevice.mobile }">
				<div class="cl-popup-box full">
					</c:when>
					<c:otherwise>
				<div class="cl-popup-box mid" style="width:800px; margin-left:-400px;">
					</c:otherwise>
				</c:choose>
					<!--
						팝업타입 별 클래스 & 스타일 제어
							1.폭 800px 이하, 높이 500px 이하 팝업 정가운데 위치)
								- class="cl-popup-box"
								- style="width:폭; height:높이; margin-left:-폭/2; margin-right: -높이/2;"
							2.폭 800px 이하, 높이 500px 이상 가로 가운데 위치
								- class="cl-popup-box mid"
								- style="width:폭; margin-left:-폭/2;"
							3.풀화면 팝업
								- class="cl-popup-box full"
					-->
					<div class="popup-header">
						<h3 class="popup-title">수강하실 연수 기수를 선택해 주세요</h3>
					</div>
					<div class="popup-body">
						<ul class="check-list">
							<li>
							<strong class="label">신청 과정 </strong>
							<span></span>
							</li>
						</ul>
						<table id="list-notation" class="list">
							<thead>
								<tr>
									<th scope="col">연수 구분</th>
									<th scope="col">기수 명칭</th>
									<th scope="col">접수 기간</th>
									<th scope="col">연수 기간</th>
									<th scope="col"  class="item-function">신청</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
						<div class="list-bottom">
							<ul id="pagination"></ul>
						</div>
					</div><!--//.popup-body-->
				</div><!--//.cl-popup-box-->
			</div><!--//.cl-popup-wrap-->
			<button class="cl-popup-closer">
				<span class="sr-only">닫기</span>
			</button>
		</div><!--//.cl-popup-overlay-->
<!--// 2.팝업 END -->