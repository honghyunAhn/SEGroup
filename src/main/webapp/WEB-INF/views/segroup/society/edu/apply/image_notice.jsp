<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<head>
	<title></title>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">

<style>
.sub_top_img{ width: 984px; height: 300px; }

body .info1{
	word-wrap: break-word;
	width: 500px;
	height: 50px;
}
#page a {
    display:inline;
}
.center-cropped {
  object-fit: cover; /* Do not scale the image */
  object-position: center; /* Center the image within the element */
  height: 190px;
  width: 341px;
}
#boardContent{
  text-align: initial;
  padding-left: 50px;
}
</style>
<script>

$(document).ready(function(){
    $("#btnWrite").click(function(){
        // 페이지 주소 변경(이동)
        location.href = "/board/write.do";
    });
});
// **원하는 페이지로 이동시 검색조건, 키워드 값을 유지하기 위해 
function ilist(page){
    location.href="/edu/apply/image_notice.do?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
}

function goBoardDetail(seq){
	location.href="/edu/apply/image_notice_detail.do?seq="+seq;
}

function searchList(){
	
    location.href="/edu/apply/image_notice.do?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
}

function mySelection(){
	 $('input[id="searchOption"]').val(document.getElementById("mySelect").value);
}

function search(){
	  var searchword=document.getElementById("searchword").value;
	  var searchoption=document.getElementById("searchOption").value;
	  if(searchoption==""){
		  searchoption="contents";
	  }
	
	  location.href="/edu/apply/image_notice.do?searchOption="+searchoption+"&keyword="+searchword;
}

</script>
</head>
<body>
<%@include file="../menu.jsp"%>
 <div class="main_m_contents">
   <div class="main_notice_wrap1">
    <div class="main_notice_title1">
     <h1>보도자료</h1>
    </div>
    <hr>
    <c:if test="${fn:length(imageNoticeList) gt 0}">
    <c:forEach var="data" items="${imageNoticeList}" varStatus="status">
    <%-- ${status.count } --%>
    <table>
    	<tr>
    	   <td>
     	     <a href="javascript:goBoardDetail('${data.board_content_seq}')">
    		  <img class="center-cropped" src="${data.board_content_thumb}" />
    	     </a>
    	   </td>
    	   <td id="boardContent" style="word-wrap: break-word;">  
    	   <a href="javascript:goBoardDetail('${data.board_content_seq}')">
           <c:choose>
             <c:when test="${fn:length(data.board_content_title) > 14}">
              <h3> <c:out value="${fn:substring(data.board_content_title,0,13)}"/>....</h3>
             </c:when>
           <c:otherwise>
              <h3> <c:out value="${data.board_content_title}"/></h3>
           </c:otherwise> 
          </c:choose>
          </a>
        <br>
       
        
           <div class="info1" style="max-width: 1098px;">
            ${data.board_content_ct }
          </div>
          <td>
        </tr>
    </table>
    <hr>
    </c:forEach>
    </c:if>
   <c:if test="${fn:length(imageNoticeList) lt 1}">
    
    <h2>게시물이 없습니다.</h2>
    
    </c:if>
    <br><br>
    <div class="pagination_wrap">
		<div class="pagination_con">
       <span id="page"style="display: inline; margin:auto; display:table; "><h4>
              <ul>
					<li>
					 <ol>
                <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
                <c:if test="${map.boardPager.curBlock > 1}">
                    <li><input type="button" onclick="javascript:ilist('1')" name="" value="처음"></li>
                </c:if>
                
                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
                <c:if test="${map.boardPager.curBlock > 1}">
                    <li><input type="button" onclick="javascript:ilist('${map.boardPager.prevPage}')" name="" value="이전"></li>
                </c:if>
                
                <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
               
                <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
                    <!-- **현재페이지이면 하이퍼링크 제거 -->
                    
                    <c:choose>
                        <c:when test="${num == map.boardPager.curPage}">
                            <li><input type="button" style="color: red"name="" value="${num}"></li>
                        </c:when>
                        <c:otherwise>
                        <li><input type="button" onclick="ilist('${num}')" name="" value="${num}"></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                
                <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
                <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
                    <li><input type="button" onclick="javascript:ilist('${map.boardPager.nextPage}')" name="" value="다음"></li>
                </c:if>
                
                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
                <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
                    <li><input type="button" onclick="javascript:ilist('${map.boardPager.totPage}')" name="" value="끝"></li>
                </c:if>
                </ol>
                </h4>
                </li>
                </ul>
                
          </span>
          </div>
          </div>
          
          <div class="gal_last" style="width:791px;">
          <div class="gal_search">
          <span style=" display: inline-flex;">
             
               <select id="mySelect" onchange="mySelection()">
  						<option value="contents">내용
  						<option value="title">제목
			  </select>
              <input type="search" id="searchword"> 
              <input type="image"  onclick="search()" name="" src="<c:url value="/resources/segroup/society/edu/image/sub/btn_searchs.png" />">
              <input type="hidden" id="searchOption"/>
          </span>
          </div>
          </div>
   </div>
 </div>

 
 
<%@include file="../footer.jsp"%>
</body>
</html>