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
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-105593058-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-105593058-2');
</script>
<title>글로벌 엔지니어 양성</title>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<script>
$(function () {
	$("#onlineConsultingWrite").on("click",function(){
		if ('${consulting_ins_id}' == ''){
			var check = confirm("로그인 후 이용가능합니다. 로그인 하시겠습니까?");
			if(!check){
				return false;
			}
			location.href="/edu/user/user_login_form.do"
			return true;
		} else {
			write_form();
		}
	});
});

function ilist(page){
    location.href="/edu/consulting/online_consulting.do?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
}

function goOnline_consulting_Detail(consulting_seq){
	location.href="/edu/consulting/online_consulting_detail.do?consulting_seq="+consulting_seq;
}

function goOnline_consulting_closed(){
	alert("비공개 글 입니다.");
}

function searchList(){
	
    location.href="/edu/consulting/online_consulting.do?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
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
	
	  location.href="/edu/consulting/online_consulting.do?searchOption="+searchoption+"&keyword="+searchword;
}

function write_form(){
	location.href="/edu/consulting/online_consulting_write_form.do";
}

</script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<style>
.top_img {
    position: relative;
    background-image: url(/resources/segroup/society/edu/image/main/top_img/top_img_online.jpg);                                                               
    height: 250px;
    background-size: cover;
}
.sub_m_contents{
	width: 1100px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<%@include file="../menu.jsp"%>
    <div class="top_img">
        <div class="top_img_text">
            <p class="top_img_text1">온라인상담 QnA</p>
            <p class="top_img_text2">궁금한 것이 있다면 뭐든지 물어보세요!</p>
        </div>
    </div>

    <div style="overflow: hidden; width: 100%; height: 50px;"></div>
	<div class="sub_m_contents">
		<div class="notice_wrap">
			<table>
				<thead>
				<tr>
					<th width="5%">번호</th>
					<th width="10%">답변상태</th>
					<th width="40%">문의제목</th>
					<th width="10%">비밀여부</th>
					<th width="10%">작성자</th>
					<th width="25%">작성일자</th>
				</tr>
				</thead>
    			<tbody>
				<c:if test="${fn:length(boardList) gt 0}">
    			<c:forEach var="data" items="${boardList}" varStatus="status">
               <tr class="notice_top">
					<td>${data.consulting_count}</td>
					<td>
						<c:if test="${data.consulting_check == 1}">
							<c:out value="답변대기"/>
						</c:if>
						<c:if test="${data.consulting_check == 2}">
							<c:out value="답변완료"/>
						</c:if>
					</td>
					<c:if test="${data.consulting_open == 0}">
						<td style="text-align: left;"><a href="javascript:goOnline_consulting_Detail('${data.consulting_seq}')"> <c:out value="${data.consulting_title}"/></a></td>
					</c:if>
					<c:if test="${data.consulting_open == 1 and data.consulting_ins_id == consulting_ins_id}">
						<td style="text-align: left;"><a href="javascript:goOnline_consulting_Detail('${data.consulting_seq}')"> <c:out value="${data.consulting_title}"/></a></td>
					</c:if>
					<c:if test="${data.consulting_open == 1 and data.consulting_ins_id != consulting_ins_id}">
						<td style="text-align: left;"><a href="javascript:goOnline_consulting_closed()"> <c:out value="${data.consulting_title}"/></a></td>
					</c:if>
					<td>
						<c:if test="${data.consulting_open == 0}">
							<c:out value="공개"/>
						</c:if>
						<c:if test="${data.consulting_open == 1}">
							<c:out value="비공개"/>
						</c:if>
					</td>
					<td><c:out value="${data.consulting_ins_id}"/></td>
					<td><c:out value="${data.consulting_ins_dt}"/></td>
				</tr>
  				</c:forEach>
                </c:if>
                </tbody>
			</table>
		</div>
		<div class="pagination_wrap">
		<div class="pagination_con">
       <span id="page"style="display: inline; margin:auto; display:table; "><h4>
              <ul>
					<li>
					 <ol>
                <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
                <c:if test="${map.boardPager.curBlock > 1}">
                    <li><input type="button" onclick="javascript:ilist('1')" name="" value="&lt&lt"></li>
                </c:if>
                
                <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
                <c:if test="${map.boardPager.curBlock > 1}">
                    <li><input type="button" onclick="javascript:ilist('${map.boardPager.prevPage}')" name="" value="&lt"></li>
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
                    <li><input type="button" onclick="javascript:ilist('${map.boardPager.nextPage}')" name="" value="&gt"></li>
                </c:if>
                
                <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
                <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
                    <li><input type="button" onclick="javascript:ilist('${map.boardPager.totPage}')" name="" value="&gt&gt"></li>
                </c:if>
                </ol>
                </h4>
                </li>
                </ul>
                
          </span>
          </div>
		</div>
		<div class="gal_last" style="text-align:center;">
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
				<div class="gal_write">
					<input type="button" name="onlineConsultingWrite" id="onlineConsultingWrite" value="글쓰기">
				</div>
		</div>
	</div>
	
	<%@include file="../footer.jsp"%>
</body>
</html>