<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <style type="text/css">
    #userViewForm, #adminViewForm {
    margin-bottom: 100px;
    }
    #userViewForm div.post-content, #adminViewForm div.post-content {
    padding-top: 50px;
    }
    #userViewForm div, #adminViewForm div {
    align-items: center;
    }
    div.button-wrap {
    text-align: right;
    }
    #headerForm {
    margin-bottom: 50px;
    }
    </style>
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.5/dist/loadingoverlay.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
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
		                location.href = "<c:url value='/smtp/support/sub04-04' />";
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
			location.href="/smtp/support/sub04-04.do";
		}
	</script>
</head>

<body>
    <div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub04_content" id="main">
        	<form class="formStyle" id="headerForm">
	            <div class="header_textWrap">
	                <h3 class="h3">QnA</h3>
	                <p class="fc_999">궁금한 것이 있다면 무엇이든지 물어보세요!
	            </div>
        	</form>
            <c:if test="${boardDetail.consulting_ins_id != consulting_ins_id and boardDetail.consulting_open == 1}">
				<div class="main_m_contents">
					<div class="main_notice_wrap1">
						<div>
							<h1>잘못 된 접근입니다.</h1>
						</div>
					</div>
				</div>
		    </c:if>
		    <c:if test="${boardDetail.consulting_ins_id == consulting_ins_id or boardDetail.consulting_open == 0}">
		    	<form class="formStyle" onsubmit="return false;" id="userViewForm">
		    		<hr>
		    		<div class="d-flex post-titleWrap">
                        <label class="label" for="post-title">제 목</label>
                        <div class="post-title">
                        	${boardDetail.consulting_title}
                        </div>
                    </div>
                    <hr>
                    <div class="d-flex">
                        <label class="label" for="author">게시자</label>
                        <div class="author">
                        	${boardDetail.consulting_udt_id } 
                        </div>
                    </div>
                    <hr>
                    <div class="d-flex">
                        <label class="label" for="date">등록일</label>
                        <div class="date">
                        	${boardDetail.consulting_udt_dt } 
                        </div>
                    </div>
                    <hr>
                    <div class="post-content">
                    	${boardDetail.consulting_ct }
                    </div>
                </form>
                <form class="formStyle" onsubmit="return false;" id="adminViewForm">
                	<hr>
                	<div class="d-flex post-titleWrap">
                        <label class="label" for="post-title">답 변</label>
                    </div>
                    <hr>
                   	<c:if test="${boardDetail.re_ins_id == null }">
                   		<div class="post-content">
							아직 답변이 등록되지 않았습니다.
						</div>
					</c:if>
					<c:if test="${boardDetail.re_ins_id != null }">
						<div class="d-flex">
	                        <label class="label" for="author">답변자</label>
	                        <div class="author">
	                        	${boardDetail.re_udt_id }
	                        </div>
	                    </div>
	                    <hr>
	                    <div class="d-flex">
	                        <label class="label" for="date">답변일</label>
	                        <div class="date">
	                        	${boardDetail.re_udt_dt } 
	                        </div>
	                    </div>
	                    <hr>
	                    <div class="post-content">
							${boardDetail.re_ct }
						</div>
					</c:if>
                </form>
                <form class="formStyle" onsubmit="return false;">
	                <div class="button-wrap">
						<input type="button" onclick="goToList()" name="" class="btn_normal btn_medium btn_pp btn-agree btn-wh" value="목록">
						<c:if test="${boardDetail.consulting_ins_id == consulting_ins_id}">
							<input type="button" class="btn_normal btn_medium btn_pp_bg" id="btnUpdate" name="btnUpdate" value="수정하기">
							<input type="button" class="btn_normal btn_medium btn_pp btn-agree btn-wh" id="btnDelete" name="btnDelete" value="삭제하기">
						</c:if> 
	                </div>
                </form>
				<form action="/smtp/support/sub04-04-03.do" id="onlineUdtHiddenForm" method="get">
					<input type="hidden" name="consulting_udt_id" id="consulting_udt_id" value="${onlineConsultingContents.consulting_udt_id}" /> 
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
    <!-- footer-include -->
    <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>

</html>
