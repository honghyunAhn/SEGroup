<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp" %>
    <script type="text/javascript">
        $(function () {
        	navLinks[3].parentElement.classList.add('current')
            subNav[3].classList.add('active');
			$("#onlineConsultingWrite").on("click",function(){
				if ('${consulting_ins_id}' == ''){
					var check = confirm("로그인 후 이용가능합니다. 로그인 하시겠습니까?");
					if(!check){
						return false;
					}
					location.href="/smtp/user/rainbow-user01-01.do"
					return true;
				} else {
					write_form();
				}
			});
		});
	
		function ilist(page){
		    location.href="/smtp/community/rainbow-community03-01.do?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
		}
	
		function goOnline_consulting_Detail(consulting_seq){
			location.href="/smtp/community/rainbow-community03-02.do?consulting_seq="+consulting_seq;
		}
	
		function goOnline_consulting_closed(){
			alert("비공개 글 입니다.");
		}
	
		function searchList(){
		    location.href="/smtp/community/rainbow-community03-01.do?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
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
			
			  location.href="/smtp/community/rainbow-community03-01.do?searchOption="+searchoption+"&keyword="+searchword;
		}
	
		function write_form(){
			location.href="/smtp/community/rainbow-community03-03";
		}
    </script>
</head>

<body>
    <!-- community - 03. Q&A -->
    <div class="container_rainbow">
        <!-- rainbow_header -->
        <%@include file="../include/rainbow_header.jsp" %>
        <div class="content course-point04" id="main">
            <div class="sub-content community02-01">
                <div class="section_header">
                    <h3 class="h3">❔ QnA</h3>
                    <p class="margin-top10 fc_999">
                        궁금한 것이 있다면 무엇이든지 물어보세요!
                    </p>
                </div>
                <div class="section_search">
                    <form class="formStyle" id="searchForm" onsubmit="return false;">
                        <div class="d-flex justify_between">
                            <select name="searchCondition" class="select w200" id="searchOption">
                                <option value="all" ${search.searchCondition eq 'all' ? 'selected' :''}>제목+내용</option>
                                <option value="title" ${search.searchCondition eq 'title' ? 'selected' :''}>제목</option>
                                <option value="content" ${search.searchCondition eq 'content' ? 'selected' :''}>내용
                                </option>
                            </select>
                            <input type="text" class="cusPHIn input margin-left10" name="searchKeyword"
                                value="${search.searchKeyword}" placeholder="검색어를 입력해주세요." id="searchword">
                            <!-- 검색버튼 -->
                            <button type="button" class="btn_normal img-icon search" id="searchBtn" onclick="search()"></button>
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
                        <li class="w50">답변<br>상태</li>
                        <li class="w400">문의제목</li>
                        <li class="w100">작성자</li>
                        <li class="w50">공개<br>여부</li>
                    </ul>
                    <ul class="table-list tbody" id="dataListUl">
                    	<c:choose>
                        	<c:when test="${fn:length(boardList) gt 0}">
	                            <c:forEach var="data" items="${boardList}" varStatus="status">
	                                <li class="list d-flex question">
	                                    <div class="w50">
	                                        <c:if test="${data.consulting_check == 1}">
												<c:out value="대기"/>
											</c:if>
											<c:if test="${data.consulting_check == 2}">
												<c:out value="완료"/>
											</c:if>
	                                    </div>
	                                    <div class="w400">
	                                        <c:if test="${data.consulting_open == 0}">
												<a href="javascript:goOnline_consulting_Detail('${data.consulting_seq}')"> <c:out value="${data.consulting_title}"/></a>
											</c:if>
											<c:if test="${data.consulting_open == 1 and data.consulting_ins_id == consulting_ins_id}">
												<a href="javascript:goOnline_consulting_Detail('${data.consulting_seq}')"> <c:out value="${data.consulting_title}"/></a>
											</c:if>
											<c:if test="${data.consulting_open == 1 and data.consulting_ins_id != consulting_ins_id}">
												<a href="javascript:goOnline_consulting_closed()"> <c:out value="${data.consulting_title}"/></a>
											</c:if>
	                                    </div>
	                                    <div class="w100">
	                                        ${data.consulting_ins_id}
	                                    </div>
	                                    <div class="w50">
	                                    	<c:if test="${data.consulting_open == 0}">
												<c:out value="공개"/>
											</c:if>
											<c:if test="${data.consulting_open == 1}">
												<c:out value="비공개"/>
											</c:if>
	                                    </div>
	                                </li>
	                            </c:forEach>
                        	</c:when>
                        	<c:otherwise>
								<li class="list not fc_999">
		                            	조회된 내용이 없습니다.
		                        </li>
    						</c:otherwise>
                        </c:choose>
                    </ul>
                </div>
                <div class="section_pagination">
                    <ol class="d-flex justify_center">
                        <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button" onclick="javascript:ilist('1')" name=""
                                    value="&lt&lt">
                            </li>
                        </c:if>

                        <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.prevPage}')" name="" value="&lt">
                            </li>
                        </c:if>
                        <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
                        <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
                            <!-- **현재페이지이면 하이퍼링크 제거 -->
                            <c:choose>
                                <c:when test="${num == map.boardPager.curPage}">
                                    <li class="page-item">
                                        <input class="btn_default fc_point" type="button" name="" value="${num}">
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <input class="btn_default" type="button" onclick="ilist('${num}')" name=""
                                            value="${num}">
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.nextPage}')" name="" value="&gt">
                            </li>
                        </c:if>

                        <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.totPage}')" name="" value="&gt&gt">
                            </li>
                        </c:if>
                    </ol>
                </div>
                <!-- 글쓰기 버튼 추가 -->
                <div class="section_btnWrap d-flex justify_center">
                    <input type="button" name="onlineConsultingWrite" id="onlineConsultingWrite" class="btn_normal btn_xlarge bgc_point" value="글쓰기">
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp" %>
    </div>
</body>
<script type="text/javascript">
    // community nav active
    /* navLinks[3].parentElement.classList.add('current')
    subNav[3].classList.add('active'); */

    // FAQ 
    /* const slideTarget = document.querySelectorAll(".question");
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
    }) */
</script>

</html>