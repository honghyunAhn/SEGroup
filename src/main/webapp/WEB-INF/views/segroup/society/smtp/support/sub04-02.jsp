<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
	<script type="text/javascript">
	//list 값 들어가는 곳
	var data;
	
	$(document).ready(function() {
		setContent();
		
		//외부 소스코드가 로드되는 시점에는 화면상에 태그가 없기 때문에 이벤트가 연결되지 않는다.
		//그래서 동적으로 화면에 태그를 생성할때는 이벤트를 재바인딩 시켜줘야함
		$.getScript('/resources/segroup/society/smtp/js/rainbow_script.js');
		
		setEvent();
	});
	
	//컨텐츠 세팅
	function setContent() {
		getList();
		setDataListUl();
	}
	
	//FAQ 리스트 가져오기
	function getList() {
		
		var startPage = $('#startPage').val();
		var params = $('#searchForm').serializeObject();
		params.startPage = startPage;
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			url : "/smtp/support/faqList",
			data : params,
			async : false,
			success : function(result) {
				data = result;
			}
		});
	}
	//컨텐츠 세팅
	function setDataListUl(search) {
		var content = '';
		if(data != null && data.length != 0) {
			$.each(data, function(index, item) {
				content += '<li class="listAndwrap">';
				content += 		'<div class="class-list board-list open-answer d-flex">';
				content += 			'<div class="c-table-num">'+ (index+1) +'</div>';
				content += 			'<div class="c-table-08">';
				content += 				'<div class="d-flex icon-align title-margin">';
				content += 					'<div class="Qmark">Q.</div>';
				content += 					'<div class="text-over-lh20">'+ item.CONSULTING_TITLE +'</div>';
				content += 				'</div>';
				content += 			'</div>';
				content += 			'<div class="c-table-03">';
				switch(item.faq_code) {
				case '001':
					content += '과정문의';
					break;
				case '002':
					content += '학습문의';
					break;
				case '003':
					content += '시스템문의';
					break;
				case '004':
					content += '결제문의';
					break;
				}
				content += 			'</div>';
				content += 		'</div>';
				content += 		'<div class="open-asw open-ctt">';
				content += 			'<ul class="class-list-wrap">';
				content += 				'<li class="icon-align aswr-box d-flex">';
				content += 					'<div class="Amark margin-right10">A.</div>';
				content += 					'<div class="text-over-lh20">'+ item.CONSULTING_CT + '</div>';
				content += 				'</li>';
				content += 			'</ul>';
				content +=		'</div>';
				content += '</li>';
			});
		}
		if(content == '') {
			content += '<li class="class-list d-flex">';
			content += 		'<div class="c-table-03 not">';
			content += 			'<p class="text-over-lh20">조회된 내용이 없습니다.</p>';
			content += 		'</div>';
			content += '</li>';
		}
		$('#dataListUl').html(content);
	}
	function setEvent() {
		$('#searchBtn').on('click', function() {
			setContent();
		});
	}
	</script>
</head>

<body>
    <div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub04_content" id="main">
            <div class="header_textWrap">
                <h3 class="h3">FAQ 자주하는 질문</h3>
                <p class="fc_999">궁금하신 사항은 먼저 자주하는 질문을 참고하시면 회원님의 궁금증을 빠르게 해결하실 수 있습니다.
            </div>
            <div class="section section_sub04-01">
                <div class="searchWrapper">
                    <form class="formStyle" id="searchForm">
                        <div class="class-searchWrap d-flex justify_end">
                            <select name="searchCondition" class="select">
                                <option value="all" ${search.searchCondition eq 'all'? 'selected':''}>제목+내용</option>
								<option value="title" ${search.searchCondition eq 'title'? 'selected':''}>제목</option>
								<option value="content" ${search.searchCondition eq 'content'? 'selected':''}>내용</option>
                            </select>
                            <input type="text" class="cusPHIn input" name="searchKeyword" value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
                            <!-- 검색버튼 -->
                            <button type="button" class="button img-icon search" id="searchBtn"></button>
                            <c:if test="${startpage != '' && startpage != null}">
								<input type="hidden" id="startPage" name="startPage" value="${search.startPage}">
							</c:if>
							<c:if test="${startpage == '' || startpage == null}">
								<input type="hidden" id="startPage" name="startPage" value="1">
							</c:if>
                        </div>
                </form>
            </div>
            <div class="sub-segment table">
                <ul class="class-list-title thead d-flex">
                    <li class="c-table-num">No.</li>
                    <li class="c-table-08">제목</li>
                    <li class="c-table-03">구분</li>
                </ul>
                <ul class="class-list-wrap" id="dataListUl">
                </ul>
            </div>
        </div>
    </div>

    <!-- footer-include -->
    <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>

</html>
