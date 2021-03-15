<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>일정관리</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<jsp:include page="../import.jsp" flush="true" />
<link href='/resources/segroup/society/smp/schedule/fullcalendar-3.9.0/css/fullcalendar.min.css' rel='stylesheet' />
<link href='/resources/segroup/society/smp/schedule/fullcalendar-3.9.0/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='/resources/segroup/society/smp/schedule/fullcalendar-3.9.0/lib/moment.min.js'></script>
<script src='/resources/segroup/society/smp/schedule/fullcalendar-3.9.0/lib/fullcalendar.min.js'></script>
<script src='/resources/segroup/society/smp/schedule/fullcalendar-3.9.0/js/bootstrap.js'></script>
<script src='/resources/segroup/society/smp/schedule/fullcalendar-3.9.0/js/bootstrap.min.js'></script>
<script src='/resources/segroup/society/smp/schedule/schedule.js'></script>
<link href='/resources/segroup/society/smp/schedule/schedule.css' rel='stylesheet'/>
<body>
	<div id="page">
		<div class="page-inner">
		<input type="hidden" id="getAuth" value="${Admin}">
			<c:if test="${Admin eq 'Admin'}">
				<%@include file="../admin/adminmenu.jsp"%>
			</c:if>
			<c:if test="${User eq 'User'}">
				<%@include file="usermenu.jsp"%>
			</c:if>
			<div class="gtco-section border-bottom">
				<div class="gtco-container">
					<div id='calendar'>
						<input type="hidden" id="getGisu" value="${gisu_seq}">
						<input type="hidden" id="getGisuNum" value="${gisu_num}">
					</div>
					
					<c:choose>
						<c:when test="${User eq 'User'}">
							<select id='gisuList' onchange="gisuChange()" name="gisuChange" class="gisuChange">
								 <option class="gisuChange" value="${gisu_seq}">${gisu_crc_nm}기</option>
							</select>
						</c:when>
						
						<c:when test="${Admin eq 'Admin'}">
							<select id='gisuList' onchange="gisuChange()" name="gisuChange" class="gisuChange">
								 <c:forEach varStatus="stat" var="item" items="${gisu_list}">
								      <option class="gisuChange" value="${item.gisu_seq}">${item.gisu_crc_nm}기</option>
								 </c:forEach>
							</select>
						</c:when>
					</c:choose>
					
					<div id="color">
					</div>
						
					<div id="result">					
					</div>
						<jsp:include page="../user/full_modal.jsp" flush="true"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>