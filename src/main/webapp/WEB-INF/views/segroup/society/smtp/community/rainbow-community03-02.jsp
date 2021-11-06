<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp" %>
	<script src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.5/dist/loadingoverlay.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
        	// community nav active
		    navLinks[3].parentElement.classList.add('current')
		    subNav[3].classList.add('active');
		    $("#btnUpdate").click(function(){
		    	$("#onlineUdtHiddenForm").submit();
		    });
		    
		    $("#btnDelete").click(function(){
		    	var check = confirm("정말로 삭제하시겠습니까?");
				if(check){
		    	ajaxSubmit();
				}
		    });
		});
	
		$(function () {
			var consulting_ins_id = '${boardDetail.consulting_ins_id}'
			var consulting_open = '${boardDetail.consulting_open}'
			if(consulting_ins_id != '${consulting_ins_id}' & consulting_open == 1){
				alert("비공개 글 입니다.");
				goToList();
			}
		});
	
		function close_deny(){
			
		}
	
		/**
		 * 서버에 온라인상담 취소(삭제) 서비스 요청
		 */
		function ajaxSubmit(){
	//			alert("Ajax 신청서비스 들어가기 전~!");
		    $.LoadingOverlay("show");
		        
			var formData = $("#onlineDelHiddenForm").serialize();
		    $.ajax({
		    	type: "POST",
		        url: '<c:url value="/smtp/support/apply_online_del" />',
		        data: formData,
		        success: function(isRequested) {
		            $.LoadingOverlay("hide");
		                
		            if (isRequested) {
		                alert('온라인상담 삭제가 완료되었습니다.');
		                location.href = "<c:url value='/smtp/community/rainbow-community03-01' />";
		            } else {
		                alert('서버에 에러가 발생했습니다. 재시도 후에도 에러발생시 홈페이지 담당자에게 문의해주십시요.');
		            }
		        },
		        error: function(e) {
		            alert('서버에 에러가 발생했습니다. 재시도 후에도 에러발생시 홈페이지 담당자에게 문의해주십시요.');
		        }
		    });
		}
	
		function goToList(){
			location.href="/smtp/community/rainbow-community03-01.do";
		}
    </script>
</head>

<body>
    <!-- community - 03. Q&A >> 게시글 보기 -->
    <div class="container_rainbow">
        <!-- rainbow_header -->
        <%@include file="../include/rainbow_header.jsp" %>
        <div class="content course-point04" id="main">
            <div class="sub-content community02-01">
                <div class="section_header">
                    <h3 class="h3">❔ QnA</h3>
                </div>
                <c:if test="${boardDetail.consulting_ins_id != consulting_ins_id and boardDetail.consulting_open == 1}">
                    <div class="margin-top40 textAlign_center">
                        잘못 된 접근입니다.
                    </div>
                </c:if>
                <c:if test="${boardDetail.consulting_ins_id == consulting_ins_id or boardDetail.consulting_open == 0}">
                    <form class="formStyle" onsubmit="return false;" id="userViewForm">
                        <div class="section_view">
                            <div class="view_question">
                                <ul class="view_info d-flex justify_end">
                                    <li>
                                        <strong>게시자&nbsp;</strong>
                                        ${boardDetail.consulting_udt_id }
                                    </li>
                                    <li>
                                        <strong>게시일&nbsp;</strong>
                                        ${boardDetail.consulting_udt_dt }
                                    </li>
                                </ul>
                                <div class="view_title bgc_eee">
                                    <strong class="margin-right10">Q.</strong>
                                    ${boardDetail.consulting_title}
                                </div>
                                <div class="view_content">
                                    ${boardDetail.consulting_ct }
                                </div>
                                <c:if test="${boardDetail.re_ins_id == null }">
                                    <div class="view_answer textAlign_center">
                                        아직 답변이 등록되지 않았습니다.
                                    </div>
                                </c:if>
                                <c:if test="${boardDetail.re_ins_id != null }">
                                    <div class="view_answer">
                                        <ul class="view_info d-flex justify_end">
                                            <li>
                                                <strong>답변자&nbsp;</strong>
                                                ${boardDetail.re_udt_id }
                                            </li>
                                            <li>
                                                <strong>답변일&nbsp;</strong>
                                                ${boardDetail.re_udt_dt }
                                            </li>
                                        </ul>
                                        <div class="view_content">
                                            <strong class="margin-right10">A.</strong>
                                            ${boardDetail.re_ct }
                                        </div>
                                    </div>
                                </c:if>
                            </div>

                        </div>
                        <div class="section_btnWrap d-flex justify_center">
                            <input type="button" onclick="goToList()" name=""
                                class="btn_default btn_medium margin-left20 bgc_eee" value="목록">
                            <c:if test="${boardDetail.consulting_ins_id == consulting_ins_id}">
                                <input type="button" class="btn_default btn_medium margin-left20" id="btnUpdate"
                                    name="btnUpdate" value="수정하기">
                                <input type="button" class="btn_default btn_medium margin-left20" id="btnDelete"
                                    name="btnDelete" value="삭제하기">
                            </c:if>
                        </div>
                    </form>
                    <form action="/smtp/community/rainbow-community03-04" id="onlineUdtHiddenForm" method="get">
                        <input type="hidden" name="consulting_udt_id" id="consulting_udt_id"
                            value="${onlineConsultingContents.consulting_udt_id}" />
                        <input type="hidden" name="consulting_seq" value="${boardDetail.consulting_seq }" />
                    </form>
                    <form action="/smtp/support/apply_online_del" id="onlineDelHiddenForm" method="post">
                        <input type="hidden" name="consulting_seq" value="${boardDetail.consulting_seq }" />
                        <input type="hidden" name="consulting_udt_id" value="${boardDetail.consulting_udt_id }" />
                        <input type="hidden" name="consulting_title" value="${boardDetail.consulting_title }" />
                        <input type="hidden" name="consulting_ct" value="${boardDetail.consulting_ct }" />
                    </form>
                </c:if>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp" %>
    </div>
</body>
</html>