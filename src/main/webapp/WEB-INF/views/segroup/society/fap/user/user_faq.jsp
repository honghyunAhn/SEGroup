<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bridge Job Fair</title>
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	
	<script type="text/javascript">
	$(function(){
		
		var fap_faq_gb_cd = $("#fap_faq_gb_cd").val();
		
		//구직자
		if(fap_faq_gb_cd == 'C5300'){
			$(".tab-apply").addClass("on");
		}
		//채용기업
		else if(fap_faq_gb_cd == 'C5301'){
			$(".tab-company").addClass("on");
		}
		
		$(".faq-item-btn").off("click").on("click",function(){
			$(this).toggleClass("on");
			$(this).nextAll(".faq-item-ct").toggleClass("on");
		})
		
		$(".tab-item").off("click").on("click",function(){
			tab_init();
			$(this).toggleClass("on");
		})
		
		function tab_init(){
			$(".tab-item").removeClass("on");
			$(".faq-item-btn").removeClass("on");
			$(".faq-item-ct").removeClass("on");
		}
		
		$(".faq-search-hd").on("click",function(){
			$(".faq-search-tx").focus();
		})
		
		$(".faq-search-tx").focusin(function(){
			$(".faq-search-hd").css("display","none");
			$(this).toggleClass("focus");
		});
		
		$(".faq-search-tx").focusout(function(){
			if($(this).val() == '' || $(this).val().length == 0){
				$(".faq-search-hd").css("display","block");
			}
			$(this).toggleClass("focus");
		});
		
	})
	
	function pageFnc(page){
		var gb_cd = $("#fap_faq_gb_cd").val();
		location.href = "/fap/user/user_faq?page="+page+"&fap_faq_gb_cd="+gb_cd;
	}
	
	function tabFnc(gb_cd){
		$("#fap_faq_gb_cd").val(gb_cd);
		pageFnc(1);
	}
	</script>
</head>
<body>
<%@include file="user_menu.jsp"%>	
	<div class="join-wrap">
		<div id="subcontents">
			<div class="joinBox">
				<div class="faq-header-wrap">
					<h2 class="faq-header">FAQ</h2>
					<form action="/fap/user/user_faq" method="get">
						<fieldset>
							<div class="faq-search-wrap">
								<span class="faq-search-hd"><spring:message code="fap.faq.search.text" /></span>
								<input type="text" name="searchText" class="faq-search-tx">
								<input type="hidden" name="fap_faq_gb_cd" id="fap_faq_gb_cd" value="${fap_faq_gb_cd }">
								<button type="submit" class="faq-search-btn">
								</button>
							</div>
						</fieldset>
					</form>
				</div>
				<div class="faq-body-wrap">
					<div class="faq-body-tab">
						<ul class="tab-items">
							<li class="tab-item tab-apply">
								<a href="javascript:tabFnc('C5300')"><spring:message code="fap.faq.job.seeker" /></a>
							</li>
							<li class="tab-item tab-company">
								<a href="javascript:tabFnc('C5301')"><spring:message code="fap.faq.company" /></a>
							</li>
						</ul>
					</div>
					<div class="faq-body-list">
						<ul>
							<c:forEach var="faq" items="${faqList }">
								<li>
									<button type="button" class="faq-item-btn">
										<span class="faq-item-hd">${faq.consulting_title}</span>
									</button>
									<div class="faq-item-ct">
										${faq.consulting_ct}
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
					<c:if test="${navi.endPageGroup != 1 }">
						<div class="faq-body-page">
							<div class="page-navi">
								<ul>
									<li>
										<c:choose>
											<c:when test="${navi.currentPage <= 1 }">
												<span class="left-arrow">&lt;</span>
											</c:when>
											<c:otherwise>
												<a href="javascript:pageFnc('${navi.currentPage - 1 }')">&lt;</a>
											</c:otherwise>										
										</c:choose>
									</li>
									<c:forEach begin="${navi.startPageGroup }" end="${navi.endPageGroup }" var="page">
										<li>
											<c:choose>
												<c:when test="${navi.currentPage == page }">
													<span class="now">${page }</span>
												</c:when>
												<c:otherwise>
													<a href="javascript:pageFnc('${page }')">${page }</a>
												</c:otherwise>
											</c:choose>
										</li>
									</c:forEach>
									<li>
										<c:choose>
											<c:when test="${navi.currentPage >= navi.totalPageCount }">
												<span class="left-arrow">&gt;</span>
											</c:when>
											<c:otherwise>
												<a href="javascript:pageFnc('${navi.currentPage + 1 }')">&gt;</a>
											</c:otherwise>										
										</c:choose>
									</li>
								</ul>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
<%@include file="../common_footer_fap.jsp"%>
</body>
</html>