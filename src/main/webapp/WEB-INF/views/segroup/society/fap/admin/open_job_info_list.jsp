<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<!-- 페이징관련 css 시작 -->
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- modal을 위한 bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- 페이징 관련 css 끝 -->
<title>Bridge Job Fair</title>
<style type="text/css">
table th{text-align: center;}
table td{text-align: center;}
.boardInsertDiv {	margin-top: 20px;	width: 9%;	float: right;}

#boardInsertBtn{ 	width: 100%;	height: 40px;	font-size: 18.67px;	color: #fff;	border: 0; 	
							background: #212121;	border-radius: 7px;	outline: none;	cursor: pointer; }
							
#custom_div{ style="width: 80%; margin-left: 120px; margin-top: 20px; }
  

</style>
<script type="text/javascript">

$(function(){
		 
		// 상세글보기 
		$(".title").on('click',function(){
			   var board_content_seq = $(this).attr("id");
			   $("#board_content_seq").val(board_content_seq);
			
	           $("#jobInfoForm").attr("method","post");
	           $("#jobInfoForm").attr("action","/fap/admin/open_job_info_detail");
	           $("#jobInfoForm").submit();
		})
			 
		// 등록하기 
		$("#boardInsertBtn").on('click',function(){
			 var jobInfoForm =  $("#jobInfoForm");
			 jobInfoForm.attr("method", "post");
			 jobInfoForm.attr("action", "/fap/admin/open_job_info_insert_form");
			 $("#jobInfoForm").submit();
		 })
		
		 // 페이징 개수변경에 따른 리스트 출력   
		$("#pageSelect").change(function(){
			var pageCount = $(this).val();		 
			
			var jobInfoForm =  $("#jobInfoForm");
			 jobInfoForm.attr("method", "post");
			 jobInfoForm.attr("action", "/fap/admin/open_job_info_list");
			 
			 var curPageInput= $("#page");
			 curPageInput.attr("value","${pagingMap.adminPager.curPage}");
						 
			 var pageCountInput= $("#pageCount");
			 pageCountInput.attr("value", pageCount);			 
				 
			 $("#jobInfoForm").submit();			
		})
		
		//검색
		/*
		$("#searchBtn").on('click',function(){	 
			var searchKey = $("#searchKey option:selected").val();
			var searchValue = $("#searchValue").val();			 
			
			$("#jobInfoForm").attr("method","post");
			$("#jobInfoForm").attr("action","/fap/admin/open_job_info_list");
			$("#searchKeyHidden").val(searchKey);
			$("#searchValueHidden").val(searchValue);
			
			$("#jobInfoForm").submit();					 
		})
		*/
		
		
		
	
})
	
	//페이징 처리함수 
	function pagingList(page){
			var pagingForm = document.getElementById("jobInfoForm");
			pagingForm.setAttribute("method", "post");
			pagingForm.setAttribute("action", "/fap/admin/open_job_info_list");		 
			
			var PageMoveTo =document.getElementById("page");			 
			PageMoveTo.setAttribute("value", page);		 	 
			
			var pageCountInput = document.getElementById("pageCount");
			pageCountInput.setAttribute("value","${pagingMap.pageCount}");
			
			var searchKey = document.getElementById("searchKeyHidden");
			searchKey.setAttribute("value","${searchKey}");
			
			var searchValue = document.getElementById("searchValueHidden");
			searchValue.setAttribute("value","${searchValue}");
			 						 	
			pagingForm.submit();
	}

//전체출력
function list_draw(){
	 
  	  $("#jobInfoForm").attr("method","post");
	  $("#jobInfoForm").attr("action","/fap/admin/open_job_info_list");

		var page = $("#page");
        page.attr("value","${pagingMap.adminPager.curPage}");
		
		var pageCount = $("#pageSelect").val();
		$("#pageCount").attr("value",pageCount);

		var searchKey = $("#searchKey option:selected").val();
		var searchValue = $("#searchValue").val();
		$("#searchKeyHidden").val(searchKey);
		$("#searchValueHidden").val(searchValue);		 

		$("#jobInfoForm").submit();
	}
 
</script>
</head>
<body >
<%@include file="admin_menu.jsp"%><br>

	 <div class="page_title">
	 	<h2>게시판 관리 페이지</h2>	 
   			 <!-- 게시판 navigation -->		 
		 	<h5>
		 		<a href="/fap/admin/notice_management#${search_division},${search_type}">게시판 관리 페이지</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;
		 		<a href="#" onclick="history.go(0)">${boardGroup.board_nm}</a>
		 	</h5> 			 
	  </div>	 
	 	 
		
 
	 <!-- 표시될 페이지수 선택 -->
	  <div style="margin:10px;">
		 <select id="pageSelect" style="height:27.5px;">
		 	<option value="10">10개씩</option>
		 	<c:forEach var="paging" items="${pagingMap.adminPager.pageCountList}">
		 		<c:if test="${paging==pagingMap.pageCount}">
		 			<option value="${paging}" selected>${paging}개씩</option>
		 		</c:if>
		 		<c:if test="${paging!=pagingMap.pageCount }">
		     		<option value="${paging}">${paging}개씩</option>
		 		</c:if>
		 	</c:forEach>
		 </select>
	 </div>
	 
	 <!-- 검색 -->      
		  <div  style="margin:10px;"> 	 
			  <table>          
				  <tr>
					  <td>
					  		<select id="searchKey"  name="searchKey" style=" width: 150px; height:27.5px;" >
								<option value="searchTitle" >제목</option>
								<option value="searchNm" >작성자</option>
							</select>	
					  </td>
					  <td>&nbsp;</td>
					   <td>
					   		<input type="text" id="searchValue" name="searchValue"  class="input1" style="width: 700px;">	
					   	</td>
					   	 <td>&nbsp;</td>
					   	<td>
							<input  type="button" class="btn_search" id="searchBtn"  value="검색" onclick="list_draw();"  style="width: 100px; height:28px;">	
					   </td>
				  </tr>			
			  </table> 									
		  </div>
		 
	 
	 
	 <!-- 본문 -->	 
	 <div>
			 <table class="table" >
				    <colgroup>
				    	<col width="5%"/>
				    	<col width="35%"/>
				    	<col width="15%"/>
				    	<col width="5%"/>
				    	<col width="20%"/>
				    	<col width="20%"/>
				    </colgroup>
				    <thead>
				    	<tr>
				    		<th>번호</th>
				    		<th>제 목</th>
				    		<th>작성자</th>
				    		<th>조회수</th>
				    		<th>작성일</th>
				    		<th>수정일</th>
				    	</tr>
				    </thead>
				    <tbody class="custom-tbody">
				    	<c:forEach var="jobInfo" items="${jobInfoList}" varStatus="status">
				    		<tr>
				    			<td>${jobInfo.fap_open_job_info_seq}</td>
				    			<td>	<a class="title" id="${jobInfo.board_content_seq }" >${jobInfo.board_content_title}</a></td>
				    			<td>${jobInfo.board_content_nm }</td>
				    			<td>${jobInfo.board_content_hit }</td>
				    			<td id='board_content_in_dt_${jobInfo.board_content_seq}'>${jobInfo.board_content_ins_dt}</td>
				    			<td id='board_content_ud_dt_${jobInfo.board_content_seq}'>${jobInfo.board_content_udt_dt}</td>  			
				    		</tr>
				    	    <input type="hidden" value="${jobInfo.board_content_seq}">
				    	</c:forEach>
				    </tbody>
			 </table>
			 <div class="boardInsertDiv">
			 	<input type="button" id="boardInsertBtn" value="등록하기"> 
			 </div>
	 </div>
	 
	 <!-- 페이징 -->
	 <div class="pagination_wrap">
		 <div class="pagination_con">		  
	           <ul>				 
				 	<c:if test="${pagingMap.adminPager.curPage >1 }">
				 		<li><input type="button" onclick="pagingList('1')" name="" value="<<"> </li>
				 	</c:if> 
				 	<c:if test="${pagingMap.adminPager.curPage >1 }">
				 		<li><input type="button" onclick="pagingList('${pagingMap.adminPager.curPage-1}')" name="" value="<"> </li>
				 	</c:if> 
 	
				 	<c:forEach var="num" begin="${pagingMap.adminPager.blockBegin}" end="${pagingMap.adminPager.blockEnd}">
				 		<c:choose>				 		 
				 			<c:when test="${num==pagingMap.adminPager.curPage}">
				 				<li><input type="button" style="color: red" value="${num}"> </li>
				 			</c:when>
				 			<c:otherwise>
				 			<li><input type="button" value="${num}" onclick="pagingList('${num}')" > </li>
				 			</c:otherwise>
				 		</c:choose>					 	
				 	</c:forEach>			
				 		 					 		 	
				 	<c:if test="${pagingMap.adminPager.curPage < pagingMap.adminPager.totPage}">
				 		<li><input type="button" onclick="pagingList('${pagingMap.adminPager.curPage+1}')" name="" value=">"> </li>
				 	</c:if>	 	
				 	<c:if test="${pagingMap.adminPager.curPage < pagingMap.adminPager.totPage }">
				 		<li><input type="button" onclick="pagingList('${pagingMap.adminPager.totPage}')" name="" value=">>"> </li>
				 	</c:if>
			  </ul>	 
    	</div>
	 </div>
	 
	 
	 <form id="jobInfoForm">
		<input type="hidden" name="search_division" id="search_division" value="${search_division}" />
		<input type="hidden" name="search_type" id="search_type" value="${search_type}" />
		<input type="hidden"  id="page"  name="curPage" />  
		<input type="hidden" name="pageCount" id="pageCount" />
		<input type="hidden" name="board_content_seq" id="board_content_seq" />
		<input type="hidden" name="board_detail_gb" id="board_detail_gb" value="${boardGroup.board_detail_gb}" />
		<input type="hidden" name="board_nm" id="board_nm" value="${boardGroup.board_nm}" />
        <input type="hidden" name="board_seq" id="board_seq" value="${boardGroup.board_seq }" />  
        <input type="hidden" name="board_content_ud_dt" id="board_content_ud_dt"  />    	
        <input type="hidden" name="searchKey" id="searchKeyHidden"  />   
        <input type="hidden" name="searchValue" id="searchValueHidden"  />   			  
	</form>
	
</body>
</html>




















