<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<script>
$(function() {

	$('#refund_submit').on('click', function(){

		if($('#bank').val()==''||$('#bank').val()==null){
			alert('은행이름을 기입해주세요');
			return;
		}
		if($('#account').val()==''||$('#account').val()==null){
			alert('계좌번호를 기입해주세요');
			return;
		}
		if($('#owner').val()==''||$('#owner').val()==null){
			alert('예금주를 기입해주세요');
			return;
		}
		
		if(confirm('환불신청 하시겠습니까?')){

			$.ajax({
				type : "POST",
				url: "/smtp/user/sub05-04-01-submit",
				data: $('#refund_form').serialize(),
				complete: function(){
					opener.parent.location.reload();
					window.close();
				}
			})
		}
	});
	

	
});
</script>
<body>
    <div class="container_rainbow">
        <div class="content sub-content view-refund" id="main">
            <div class="header">
                <div class="titleBar h3">환불정보입력</div>
            </div>
            <div class="section">
                <div class="sub-segment">
                    <ul class="class-list-title thead d-flex">
                        <li class="c-table-name-w">과정명</li>
						<li class="c-table-name-w">기수</li>
                        <li class="c-table-01">교육비</li>
                        <li class="c-table-01">마일리지사용</li>
                        <li class="c-table-01">결제금액</li>
                    </ul>
                    <ul class="class-list-wrap">
                        <li class="class-list d-flex">                            
                            <div class="c-table-name-w" style="text-align:center; align-self:center;">${refundInfo.course_name}</div>
                            <div class="c-table-name-w" style="text-align:center; align-self:center;">${refundInfo.cardinal_name }</div>
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.price}" pattern="#,###" />원</div>

                            <c:if test="${refundInfo.dis_point == '' || refundInfo.dis_point == null}">
                            <div class="c-table-01" style="text-align:center; align-self:center;">0점</div>
                            </c:if>
                            <c:if test="${refundInfo.dis_point != '' && refundInfo.dis_point != null}">
                            <div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.dis_point }" pattern="#,###" />점</div>
                            </c:if>

                            <c:if test="${refundInfo.real_payment == '' || refundInfo.real_payment == null}">
							<div class="c-table-01" style="text-align:center; align-self:center;">0원</div>
                            </c:if>
                            <c:if test="${refundInfo.real_payment != '' && refundInfo.real_payment != null}">
							<div class="c-table-01" style="text-align:center; align-self:center;"><fmt:formatNumber value="${refundInfo.real_payment }" pattern="#,###" />원</div>
                            </c:if>
                            
                        </li>
                    </ul>
                </div>
                <div class="sub-segment">
                    <form action="/smtp/user/sub05-04-01-submit" method="post" id="refund_form" class="formStyle">
                    	<input type="hidden" name="id" value="${refundInfo.learn_id}">
						<input type="hidden" name="pay_user_seq" value="${refundInfo.pay_user_seq}">
						<input type="hidden" name="pay_crc_seq" value="${refundInfo.pay_crc_seq}">
						<input type="hidden" name="pay_user_method" value="${refundInfo.pay_user_method}">
                        <div class="d-flex">
                            <label class="label" for="bank">은행명</label>
                            <input type="text" class="input" id="bank" name="bank" placeholder="은행명을 입력하세요.">
                        </div>
                        <div class="d-flex">
                            <label class="label" for="account">계좌번호</label>
                            <input type="text" class="input" id="account" name="account" placeholder="계좌번호를을 입력하세요.">
                        </div>
                        <div class="d-flex">
                            <label class="label" for="owner">예금주</label>
                            <input type="text" class="input" id="owner" name="owner" placeholder="예금주를 입력하세요.">
                        </div>
                        <div class="margin-top40">
                            <input type="button" id="refund_submit" class="btn_normal btn_pp_bg btn_large" value="환불신청">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>