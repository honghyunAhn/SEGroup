<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
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
<script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<script>
$(function() {
    search(0, 0, 1);
});

function mySelection(){
	 $('input[id="searchOption"]').val(document.getElementById("mySelect").value);
}

function togglequestion(i){
	var trObj = document.getElementById("answer"+i);
	if ( trObj.style.display == "none" ) {
		trObj.style.display = "";
	} else {
		trObj.style.display = "none";
	}
}

function search(searchOption, keyword, curPage){
    if (searchOption == 0) {
    	searchOption = $("#searchOption").val();
    }
    if (keyword == 0) {
    	keyword = $("#keyword").val();
    }
    if ((curPage+0) == 0) {
    	curPage = $("#curPage").val();
    }
  
    $.ajax({
        type : "POST",
        url : "/edu/consulting/faq_request",
        data : {
            'searchOption' : searchOption,
            'keyword' : keyword,
            'curPage' : curPage
        },
        dataType : 'json', //서버에서 보내는 데이터 타입 
        success:function(map){
//         	alert(map);


            // 리스트 리로딩 부분(.custom_tbody)
            var context = '';
            $.each(map.boardList, function(index, item){
            	context += "<tr class='notice_top' id='FAQ_question' onclick='togglequestion(" + item.consulting_seq + ")'>";
            	context += "<td>Q</td>";
            	context += "<td class='text_overflow' style='padding:13px; padding-left: 40px; text-align: left;'>" + item.consulting_title + "</td>";
            	//context += "<td>" + item.consulting_hit + "</td>";
            	context += "</tr>";
            	context += "<tr class='notice_bottom' id='answer" + item.consulting_seq + "' style='display: none; text-align: left'>";
            	context += "<td>A</td>";
            	context += "<td colspan='3' style='text-align: left; padding: 20px;'>" + item.consulting_ct + "</td>";
            	context += "</tr>";
            });
            $(".custom_tbody").empty();
            $(".custom_tbody").html(context);
            
            // 페이징 리로딩 부분(.paging_line)
            // alert("map.boardPager.curBlock : "+map.boardPager.curBlock + ", map.boardPager.totBlock : "+map.boardPager.totBlock);
            var pcontext = '';
            // << 처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력
            if (map.boardPager.curPage > 1) {
                pcontext += "<li><input type='button' onclick='search(0,0,1)'";
                pcontext += "name='' value='&lt&lt'></li>";
            }
            // < 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력
            if (map.boardPager.curBlock > 1) {
                pcontext += "<li><input type='button' onclick='search(0,0," + map.boardPager.prevPage + ")'";
                pcontext += "name='' value='&lt'></li>";
            }
            // ...number... 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지
            for (num = map.boardPager.blockBegin; num <= map.boardPager.blockEnd; num++) {
            	// 현재페이지이면 하이퍼링크 제거
            	if (num == map.boardPager.curPage) {
                    pcontext += "<li><input type='button' style='color: red' name=''";
                    pcontext += "value='" + num + "'></li>";
            	} else {
            		pcontext += "<li><input type='button' onclick='search(0,0," + num + ")'";
                    pcontext += " name='' value='" + num + "'></li>";
            	}
            }
            // > 다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력
            if (map.boardPager.curBlock <= map.boardPager.totBlock) {
                pcontext += "<li><input type='button' onclick='search(0,0," + map.boardPager.nextPage + ")'";
                pcontext += "name='' value='&gt'></li>";
            }
            // >> 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력
            if (map.boardPager.curPage < map.boardPager.totPage) {
                pcontext += "<li><input type='button' onclick='search(0,0," + map.boardPager.totPage + ")'";
                pcontext += "name='' value='&gt&gt'></li>";
            }

            $(".paging_line").empty();
            $(".paging_line").html(pcontext);
        },
        error: function(e){
            console.log(e);
        }
    });
}
</script>
<!-- bxSlider CSS file -->
<link
	href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<style>
.top_img {
	position: relative;
	background-image:
		url(/resources/segroup/society/edu/image/main/top_img/top_img_faq.jpg);
	height: 250px;
	background-size: cover;
}
.text_overflow {
    width: 635px;
    text-overflow: ellipsis;
    -o-text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    word-wrap: normal !important;
    display: block;
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
			<p class="top_img_text1">FAQ</p>
			<p class="top_img_text2">사람들이 자주 하는 질문들!</p>
		</div>
	</div>

	<div class="sub_m_contents">
		<div class="notice_wrap">
			<div class="master_bottom_menu_five" style="width: 983px;">
				<ul id="type_select">
				</ul>
			</div>
			<table class="table" style="table-layout:fixed; word-break: break-all;">
				<colgroup>
					<col width="10%" />
					<col width="90%" />
				<%-- 	<col width="10%" /> --%>
				</colgroup>
				<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col">제목</th>
						<!-- <th scope="col">조회수</th> -->
					</tr>
				</thead>
				<tbody class="custom_tbody">
				</tbody>
			</table>
			<div class="pagination_wrap">
				<div class="pagination_con">
					<span id="page"
						style="display: inline; margin: auto; display: table;"><h4>
							<ul>
								<li>
									<ol class="paging_line">
									</ol>
						          </li>
						      </ul>
                        </h4>
                    </span>
				</div>
			</div>
		</div>
		<div class="gal_last" style="text-align: center;">
			<div class="gal_search">
				<span style="display: inline-flex;"> <select id="mySelect"
					onchange="mySelection()">
						<option value="contents">내용
						<option value="title">제목
				</select> <input type="search" id="keyword" value=""> <input type="image"
					onclick="search(0,0,1)" name=""
					src="<c:url value="/resources/segroup/society/edu/image/sub/btn_searchs.png" />">
					<input type="hidden" id="searchOption" value="" />
	                <input type="hidden" id="curPage" value="1">
	                <input type="hidden" id="consulting_ct" value="9999">
				</span>
			</div>
			<!-- <div class="gal_write">
					<input type="button" name="" value="글쓰기">
				</div> -->
		</div>
	</div>

	<%@include file="../footer.jsp"%>
</body>
</html>