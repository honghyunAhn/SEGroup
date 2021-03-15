<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){
	var totalPages = ${searchVO.totalPages};
	var visiblePages = ${searchVO.visiblePages};
	var startPage = ${searchVO.startPage};

	if (totalPages != 0) {
		$('#pagination').twbsPagination({
	        totalPages: totalPages,
	        visiblePages: visiblePages,
	        startPage: startPage,
	        first : "",
	        prev : "«",
	        next : "»",
	        last : "",
	        initiateStartPageClick : false,
	        onPageClick: function (event, page) {
	            $('#startPage').val(page);
	            $("#searchForm").submit();
	        }
    	});
	}
});

//수강변경신청
function lectureChange(id) {
	if(!id) {
		alert("연수과정을 선택하여 주십시오."); return;
	}

	var params = {};
	params.id = id;

	$.ajax({
		url:'searchChangeableLectureAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data) {

			var list = data.list;
			var lecture = data.lecture;

			if(list.length < 1) {
				alert("변경가능한 과정이 없습니다."); return;
			}

			$("#changeForm #learnAppId").val(lecture.ID);
			$("#changeForm #cardinalId").val(lecture.CARDINAL_ID);
			$("#changeForm #oldCourseId").val(lecture.COURSE_ID);

			$("#oldCourse").text(lecture.COURSE_NAME);

			var selectTag = "";
			selectTag += "<option value=''> 과정을 선택하세요</option>";
			for (var i = 0; i < list.length; i++) {
				selectTag += "<option value='"+list[i].COURSE_ID+"'>"+list[i].COURSE_NAME+"</option>";
			}
			$("#changeForm #newCourseId").empty().append(selectTag);

			popupOpen("lectureChangePopup");
		},
		error:function(e) {
			alert("데이터 조회시 문제가 발생했습니다.");
		}
	});
}

//수강연기신청
function lectureDelay(id) {
	if(!id) {
		alert("연수과정을 선택하여 주십시오."); return;
	}

	var params = {};
	params.id = id;

	$.ajax({
		url:'searchDelayableLectureAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data) {
			var lecture = data.lecture;
			var user = data.user;
			var list = data.list;

			if (!lecture || !user) {
				alert("데이터 조회시 문제가 발생했습니다.");
				return;
			}

			var selectTag = "";
			if(list.length > 0) {
				selectTag += "<option value=''> 기수을 선택하세요</option>";
				for (var i = 0; i < list.length; i++) {
					selectTag += "<option value='"+list[i].CARDINAL_ID+"'>"+list[i].CARDINAL_NAME+" [연수기간 : "+list[i].LEARN_START_DATE+" ~ "+list[i].LEARN_END_DATE+"]</option>";
				}
			} else {
				selectTag += "<option value=''> 연기 가능한 기수가 없습니다.</option>";
			}
			$("#delayForm #newCardinalId").empty().append(selectTag);

			$("#delayForm #userName").empty().text(user.name);
			$("#delayForm #userId").empty().text(user.username);

			$("#delayForm #courseName").empty().text(lecture.COURSE_NAME);
			$("#delayForm input[name='learnAppId']").val(lecture.ID);
			$("#delayForm input[name='oldCardinalId']").val(lecture.CARDINAL_ID);

			popupOpen("lectureDelayPopup");
		},
		error:function(e) {
			alert("데이터 조회시 문제가 발생했습니다.");
		}
	});
}

//수강취소신청
function lectureCancel(id) {
	if(!id) {
		alert("연수 과정을 선택하여 주십시오."); return;
	}

	var params = {};
	params.id = id;

	$.ajax({
		url:'searchCancelableLectureAjax',
		type:'POST',
		data:params,
		dataType:'json',
		success:function(data) {
			var lecture = data.lecture;
			var user = data.user;

			if (!lecture || !user) {
				alert("데이터 조회시 문제가 발생했습니다.");
				return;
			}

			$("#cancelForm #userName").empty().text(user.name);
			$("#cancelForm #userId").empty().text(user.username);

			$("#cancelForm #courseName").empty().text(lecture.COURSE_NAME);
			$("#cancelForm input[name='learnAppId']").val(lecture.ID);

			popupOpen("lectureCancelPopup");
		},
		error:function(e) {
			alert("데이터 조회시 문제가 발생했습니다.");
		}
	});
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
						<a class="nth-last" href="${contextPath}">연수 연기/취소</a>
					</p>
					<h2 class="sub-title">연수 연기/취소</h2>
					<!--p class="sub-title-copy">제목을 보조해주는 문구 삽입</p-->
				</div><!--//.sub-header-->
				<div class="sub-body">
					<form id="searchForm">
						<input type="hidden" name="startPage" id="startPage" />
					</form>
					<div class="tab-group">
						<ul class="tab-header sub x2">
							<li><a class="nth-1st on" href="change">연수 연기/취소</a></li>
							<li><a href="result">신청 처리 결과 조회</a></li>
						</ul>
						<div class="tab-body">
							<table class="list">
								<colgroup>
									<col width="100">
									<col width="120">
									<col width="">
									<col width="120">
									<col width="120">
									<col width="100">
									<col width="160">
								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="item-type">연수 구분</th>
										<th scope="col" class="item-course">연수 영역</th>
										<th scope="col" class="item-title">연수 과정명</th>
										<th scope="col" class="item-notation">기수</th>
										<th scope="col" class="item-date">연수 기간</th>
										<th scope="col" class="item-state">결제 상태</th>
										<th scope="col" class="item-function">연기/취소</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${!empty list }">
										<c:forEach var="item" items="${list }" varStatus="status">
											<tr <c:if test="${status.index == 0 }"> class="nth-1st" </c:if>>
												<td class="item-type">${item.LEARN_TYPE_NAME }</td>
												<td class="item-course">${item.COURSE_CODE_NAME }</td>
												<td class="item-title"><a href="#">${item.NAME }</a></td>
												<td class="item-notation">${item.CARDINAL_NAME }</td>
												<td class="item-date">${item.LEARN_START_DATE }. ~ ${item.LEARN_END_DATE }.</td>
												<td class="item-state">
													<c:choose>
														<c:when test="${item.PAYMENT_STATE eq 1 }">미결제</c:when>
														<c:when test="${item.PAYMENT_STATE eq 2 }">결제완료</c:when>
														<c:when test="${item.PAYMENT_STATE eq 3 }">일부결제</c:when>
														<c:when test="${item.PAYMENT_STATE eq 4 }">환불</c:when>
													</c:choose>
												</td>
												<td class="item-function">
													<!-- 변경 기능 사용 안함. -->
													<%-- <c:if test="${item.CHANGEABLE }">
														<a class="btn short primary" href="javascript:lectureChange(${item.ID });">변경</a>
													</c:if> --%>
													<c:if test="${item.DELAYABLE }">
														<a class="btn short primary" href="javascript:lectureDelay(${item.ID });">연기</a>
													</c:if>
													<c:if test="${item.CANCELABLE }">
														<a class="btn short primary" href="javascript:lectureCancel(${item.ID });">취소</a>
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${empty list }">
										<tr class="nth-1st">
											<td colspan=7>조회된 연수 과정이 없습니다.</td>
										</tr>
									</c:if>

								</tbody>
							</table>
							<div class="list-bottom">
								<ul id="pagination"></ul>
							</div>
						</div><!--//.tab-body-->
					</div><!--.tab-group-->
				</div><!--//.sub-body-->
			</div><!--//.body-->
	<!--// 1.3. 본문 -->

 <t:insertDefinition name="lecturecancel"/>											<!-- lecturecancel popup : 수강취소 팝업 -->
 <t:insertDefinition name="lecturedelay"/>											<!-- lecturedelay popup : 수강연기 팝업 -->
 <t:insertDefinition name="lecturechange"/>										<!-- lecturechange popup : 수강변경 팝업 -->