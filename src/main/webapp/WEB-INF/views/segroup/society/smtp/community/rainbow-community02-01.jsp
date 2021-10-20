<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp" %>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script type="text/javascript">
  		//list 값 들어가는 곳
        var data;

        $(document).ready(function () {
        	// community nav active
            navLinks[3].parentElement.classList.add('current')
            subNav[3].classList.add('active');
        	
            setContent();
            
            //외부 소스코드가 로드되는 시점에는 화면상에 태그가 없기 때문에 이벤트가 연결되지 않는다.
            //그래서 동적으로 화면에 태그를 생성할때는 이벤트를 재바인딩 시켜줘야함
            $.getScript('/resources/segroup/society/smtp/js/rainbow_script.js');
            
            setEvent();
            
            const slideTarget = document.querySelectorAll(".question");
            const hideTarget = document.querySelectorAll(".answer");
            const toggleTarget = document.querySelectorAll('.angle-down');
            slideTarget.forEach(function (question) {
                function slideEvent() {
                    const answer = this.nextElementSibling;
                    if (!answer.classList.contains('show')) {
                        hideAnswer(hideTarget)
                        answer.classList.toggle('show');
                    } else {
                        answer.classList.remove('show');
                    }
                    //FAQ 질문 클릭 시, 전체 답변 숨기기
                    function hideAnswer(hideTarget) {
                        if (hideTarget) {
                            for (var i = 0; i < hideTarget.length; i++) {
                                hideTarget[i].classList.remove('show');
                            }
                        }
                    }
                }
                question.addEventListener("click", slideEvent);
            });
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
                contentType: "application/json",
                dataType: "json",
                url: "/smtp/support/faqList",
                data: params,
                async: false,
                success: function (result) {
                    data = result;
                }
            });
        }

        function setDataListUl(search) {
            var content = '';
            if (data != null && data.length != 0) {
                $.each(data, function (index, item) {
                    content += '<li class="listWrap">';
                    content += '<div class="list d-flex question">';
                    content += '<div class="w50">' + (index + 1) + '</div>';
                    content += '<div class="w550 textAlign_left">';
                    content += '<span class="fc_point">';
                    switch (item.faq_code) {
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
                    content += '&nbsp;</span>';
                    content += item.CONSULTING_TITLE + '</div>';
                    content += '</div>';
                    
                    
                    content += '<div class="list d-flex answer">';
                    content += '<div class="mark w50">💡</div>';
                    content += '<div class="w550 textAlign_left">' + item.CONSULTING_CT + '</div>';
                    content += '</div>';
                    content += '</li>';
                });
            }
            if (content == '') {
                content += '<li class="list not fc_999">조회된 내용이 없습니다.</li>';
            }
         // FAQ 
            $('#dataListUl').html(content);
        }

        function setEvent() {
            $('#searchBtn').on('click', function () {
                setContent();
            });
        }
    </script>
</head>

<body>
    <!-- community - 02. FAQ -->
    <div class="container_rainbow">
        <!-- rainbow_header -->
        <%@include file="../include/rainbow_header.jsp" %>
        <div class="content course-point04" id="main">
            <div class="sub-content community02-01">
                <div class="section_header">
                    <h3 class="h3">❔ FAQ 자주하는 질문</h3>
                    <p class="margin-top10 fc_999">
                        궁금하신 사항은 먼저 자주하는 질문을 참고하시면 회원님의 궁금증을 빠르게 해결하실 수 있습니다.
                    </p>
                </div>
                <div class="section_search">
                    <form class="formStyle" id="searchForm">
                        <div class="d-flex justify_between">
                            <select name="searchCondition" class="select w200">
                                <option value="all" ${search.searchCondition eq 'all' ? 'selected' :''}>제목+내용</option>
                                <option value="title" ${search.searchCondition eq 'title' ? 'selected' :''}>제목</option>
                                <option value="content" ${search.searchCondition eq 'content' ? 'selected' :''}>내용
                                </option>
                            </select>
                            <input type="text" class="cusPHIn input margin-left10" name="searchKeyword"
                                value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
                            <!-- 검색버튼 -->
                            <button type="button" class="btn_normal img-icon search" id="searchBtn"></button>
                            <c:if test="${startpage != '' && startpage != null}">
                                <input type="hidden" id="startPage" name="startPage" value="${search.startPage}">
                            </c:if>
                            <c:if test="${startpage == '' || startpage == null}">
                                <input type="hidden" id="startPage" name="startPage" value="1">
                            </c:if>
                        </div>
                    </form>
                </div>
                
                <div class="section_table">
                    <ul class="table-title thead d-flex fc_point">
	                    <li class="w50">No.</li>
	                    <li class="w550">제목</li>
	                </ul>
	                <ul class="table-list tbody" id="dataListUl">
	                </ul>
            	</div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp" %>
    </div>
</body>
</html>