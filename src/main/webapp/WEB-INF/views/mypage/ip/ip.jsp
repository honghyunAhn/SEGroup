<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t"%>

<script type="text/javascript">
$(document).ready(function(){
	$('#ipForm input[name="ip"]').keypress(function (e) {
		if (e.which == 13) {
			$('.ipsave').trigger('click');
		}
	});

	$('#ipchek').click(function(){
		$.ajax({
  			url : 'saveIpUseYn',
  			method : 'POST',
  			dataType : 'json',
  			data : $("#ipForm").serializeArray(),
  			success : function(data) {
  				if(!isSuccessAjaxResponse(data)) {
  					alertAjaxFailMessage(data);
  				}
  			}
  		});
	});

	$('.ipsave').click(function(){
		var ip = $('#ipForm input[name="ip"]').val();
		if (isEmpty(ip)) {
			alert('아이피를 입력하여 주십시오.');
			$('#ipForm input[name="ip"]').focus();
			return;
		}
		$.ajax({
  			url : 'insertIp',
  			method : 'POST',
  			dataType : 'json',
  			data : $("#ipForm").serializeArray(),
  			success : function(data) {
  				if(!isSuccessAjaxResponse(data)) {
  					alertAjaxFailMessage(data);
  				} else {
  					alert('등록되었습니다.');
  					location.href = '<c:url value="/mypage/ip/ip"/>';
  				}
  			}

  		});
	});

	$('.ipdelete').click(function(){
		$.ajax({
  			url : 'deleteIp',
  			method : 'POST',
  			dataType : 'json',
  			data : {seq : $(this).data("seq")},
  			success : function(data) {
  				if(!isSuccessAjaxResponse(data)) {
  					alertAjaxFailMessage(data);
  				} else {
  					alert('삭제되었습니다.');
  					location.href = '<c:url value="/mypage/ip/ip"/>';
  				}
  			}
  		});
	});
});
</script>

<t:insertDefinition name="mypageleftmenu"/>

<!-- 1.3. 본문 -->
<div class="body">
	<div class="sub-header">
		<p class="sub-nav">
			<a class="nth-1st" href="/"><span class="sr-only">HOME</span></a>
			<a href="#">나의 강의실</a>
			<a class="nth-last" href="${contextPath}">접속 IP 등록/변경/삭제</a>
		</p>
		<h2 class="sub-title">접속 IP 등록/변경/삭제</h2>
	</div>
	<div class="sub-body">
		<div class="ip_table">
		<form id="ipForm" method="post">
			<span class="floatR">현재 아이피 : ${remoteIp }</span>
			<%-- <label><input type="checkbox" name="ipchek" id="ipchek" value="Y" ${user.ip_use_yn eq 'Y'?'checked':''}> 접속 IP설정 사용하기</label> --%>
			<table>
				<thead>
					<tr>
						<th class="nth-1st">순번</th>
						<th>아이피</th>
						<th class="nth-last">삭제</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="list" items="${list}" varStatus="status">
					<tr>
						<td class="nth-1st">${status.index+1}</td>
						<td>${list.IP}</td>
						<td class="nth-last"><button type="button" class="btn ipdelete" data-seq="${list.SEQ}">삭제</button></td>
					</tr>
				</c:forEach>
				<c:if test="${empty list}">
					<tr><td colspan="3" class="nth-1st">등록된 아이피가 없습니다.</td></tr>
				</c:if>
				</tbody>
			</table>
			<div><label>아이피 : <input type="text" name="ip" value="${remoteIp }"></label><button type="button" class="btn primary ipsave">추가</button></div>
		</form>
		</div>
	</div><!--//.sub-body-->
	<!--본문 내용 출력 공간-->
</div>
<!--// 1.3. 본문 -->
