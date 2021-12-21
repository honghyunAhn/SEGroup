<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib url="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib url="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp" %>
    <script type="text/javascript">
	    $(document).ready(function() {
	    	// community nav active
	        navLinks[3].parentElement.classList.add('current')
	        subNav[3].classList.add('active');
		});
	
		function goToNear(seq, nearType) {
			location.href = "/smtp/community/rainbow-community01-02?seq=" + seq + "&searchOption=" + nearType;
		}
	
		function goToList() {
			location.href = "/smtp/community/rainbow-community01-01.do";
		}
    </script>
</head>

<body>
    <!-- community - 01. 공지사항 >> 게시글 보기 -->
    <div class="container_rainbow">
    	<%@include file="../include/rainbow_header.jsp" %>
        <div class="content course-point04" id="main">
            <div class="sub-content community01-02">
                <div class="section_header">
                    <h3 class="h3">📢 공지사항</h3>
                </div>
                <div class="section_view">
                    <div class="view_title bgc_eee">
                        ${boardDetail.board_content_title}
                    </div>
                    <ul class="view_info margin-top10 d-flex justify_end">
                        <li>
                            <strong>게시자&nbsp;</strong>
                            ${boardDetail.board_content_nm }
                        </li>
                        <li>
                            <strong>날짜&nbsp;</strong>
                            ${boardDetail.board_content_udt_dt }
                        </li>
                        <li>
                            <strong>조회수&nbsp;</strong>
                            ${boardDetail.board_content_hit }
                        </li>
                    </ul>
                    <div class="view_content">
                        ${boardDetail.board_content_ct }
                    </div>
                    <c:if test="${fn:length(files) gt 0}">
                        <div class="view_fileUpload">
                            <p class="fc_999">
                                첨부파일
                            </p>
                        <c:forEach var="data" items="${files}" varStatus="status">
                            <div class="margin-top10">
                                <a
                                    href="/file_download?origin=${data.board_file_origin}&saved=${data.board_file_saved}&path=${path}">${data.board_file_origin}</a>
                            </div>
                        
                        </c:forEach>
                        </div>
                    </c:if>
                </div>
                <div class="section_btnWrap d-flex justify_center">
                    <c:if test="${boardDetail.board_content_seq_min != boardDetail.board_content_seq}">
                        <input type="button" class="btn_default btn_medium btn_pp btn-agree btn-wh"
                            onclick="goToNear('${boardDetail.board_content_seq}' ,'previous')" name="" value="이전글">
                    </c:if>
                    <input type="button" class="btn_default btn_medium margin-left20 bgc_eee" onclick="goToList()"
                        name="" value="목록">
                    <c:if test="${boardDetail.board_content_seq_max != boardDetail.board_content_seq}">
                        <input type="button" class="btn_default btn_medium margin-left20"
                            onclick="goToNear('${boardDetail.board_content_seq}', 'next')" name="" value="다음글">
                    </c:if>
                </div>


            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp" %>
    </div>
</body>
</html>