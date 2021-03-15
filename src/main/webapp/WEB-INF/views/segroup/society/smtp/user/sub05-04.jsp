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
    
    <!-- Pagination -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
	<script>
	    var icon_displays;
	    var target_types;
	    var course_id;
	    var selp_period;
	    var classNm;
	    var classPrice;
	    var realPrice;
	    var learnPrice;
	
	    $( document ).ready(function() {
	    	
	    	var state =$("#serverMessage").val();
	
	    	if(state=="payComplete"){
	    		alert("결제에 성공하셨습니다. 나의 강의실에서 확인해주세요.");
	    	}else if(state=="payError"){
	    		alert("결제에 실패하셨습니다.");
	    	}
	    	getPaymentList();
	    });
		
	    function getPaymentList() {
	    	//페이징 처리용 변수
			var search = $('input[name=searchKeyword]').val();
			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				data : {
					"startPage" : startPage,
					"search" : search
				},
				url		: "/smtp/user/sub05-04-list",
				success : function(data) {
// 					console.log(data);
				}
			});
	    }
	    
	    
	    function dayCheck(idx) {
	        var date = new Date();
	        
	        var start_str = $(':hidden[class="start_'+idx+'"]').val();
	    	var end_str = $(':hidden[class="end_'+idx+'"]').val();
	    	
	    	if(!start_str || !end_str) {
	    		alert("납입 정보가 없습니다.");
	    		return false;
	    	}
	    	
	    	var start = new Date(start_str);
	    	var end = new Date(end_str);
	    	
	    	if(start >= date || end <= date || !start || !end) {
	    		alert("결제 기간이 아닙니다.");
	    		return false;
	    	}
	    	
	    	return true;
	    }
		//결제 모달관련
	    function callFunction(obj) {
	    	
	    	var thisBtnId = $(obj).attr("id");
	    	var idArr = thisBtnId.split("-");
	    	var length = idArr.length;
	    	var idIndex = idArr[length-1];
	    	
	    	if(!dayCheck(idIndex)) {
	    		return;
	    	}
	    	
	    	var gisuId = $("#gisu_id_" + idIndex).val();
	    	var payCrcSeq = $("#pay_crc_seq_" + idIndex).val();
	    	var user_id = '${sessionScope.user_id}';
	    	
	    	$.ajax({
	    		url: "/smtp/course/getCourse"
	    		, type: "GET"
	    		, data : {
	    			gisuId : gisuId
	    		}
	    		, contentType : String
	    		, success : function(data) {
	    			$.ajax({
	    				url: "/smtp/course/getCourseInfo"
	    				, type: "GET"
	    				, data : {
	    					courseId : data
	    				}
	    				, success : function(item) {
	    					
// 	    					console.log('getCourse item: ' + item);
	    					
	    					icon_displays = item.icon_displays;
	    					target_types = item.target_types;
	    					
	    					init(icon_displays, target_types);
	    					
	    					course_id = item.id;
	    					selp_period = item.selp_period;
	    					classNm = item.name;
	    					learnPeriod = item.selp_period;
	    					
	    					$('.class-name').html(classNm);
	    					$('.class-id').val(course_id);
	    					$('.class-term').val(learnPeriod);
	    					$('#merCardinal').val(gisuId);
	    					$('#merPayCrcSeq').val(payCrcSeq);
	    					getUserInfo(user_id);
	    					getCardinalDetail(gisuId);
	    				}
	    				, error : function() {
	    					alert("과정정보 불러오기 실패");
	    				}
	    			});
	    		}
	    		, error : function() {
	    			alert("과정코드 불러오기 실패");
	    		}
	    	});
	    	
	    	if(user_id == '' || user_id == null) {
	    		alert("로그인이 필요합니다.");
	    		document.location.href = '/segroup/society/smtp/user/login';
	    		return;
	    	}
	    	 $('html, body').addClass("not-scroll");
	    	$('.paymentmodal').show();
	    	
	    }
	
	    function makeSignature(realPrice) {
	    	
// 	    	console.log("Make SIgnature Param Check : " + realPrice);
	    	
	    	$.ajax({
	    		url: "/smtp/course/makesignature"
	    		, type: "GET"
	    		, data : {
	    			price : realPrice
	    		}
	    		, dataType : "json"
	    		, success : function(data) {
	    			
// 	    			console.log("MakeSignature Check : " + data.mid + " " + data.oid);
	    			
	    			$('input[name$="price"]').val(realPrice);
	    			$('input[name$="goodname"]').val(classNm);
	    			$('input[name$="mid"]').val(data.mid);
	    			$('input[name$="oid"]').val(data.oid);
	    			$('input[name$="timestamp"]').val(data.timestamp);
	    			$('input[name$="mKey"]').val(data.mKey);
	    			$('input[name$="signature"]').val(data.signature);
	    		}
	    		, error : function(data) {
	    			alert("실패");
	    		}
	    	});
	    }
	
	    function getUserInfo(user_id) {
	    	$.ajax({
	    		url: "/smtp/course/getUserInfo"
	    		, type: "GET"
	    		, data: {
	    			"user_id" : user_id
	    		}
	    		, success : function(data) {
	    			
	    			$('.user_name').html(data.user_nm);
	    			$('.user_birth').html(data.user_birth);			
	    			
	    			$('input[name$="buyername"]').val(data.user_nm);
	    			$('input[name$="buyeremail"]').val(data.user_email);
	    			$('input[name$="buyertel"]').val(data.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
	    			$('.user_belong_to').val(data.user_belong_to);
	    			
	    			$('#merCourse').val(course_id);
	    			$('#merPhone').val(data.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
	    			$('#merEmail').val(data.user_email);
	    				
	    			$('#post_code').val(data.user_zipcode);
	    			$('#addr1').val(data.user_addr1);
	    			$('#addr2').val(data.user_addr2);
	    		}
	    		, error : function() {
	    			alert("User Info 실패");
	    		}
	    	});
	    }
	
	    function getCardinalDetail(cardinalId) {
	    	$.ajax({
	    		url: "/smtp/course/getCardinalDetail"
	    		, type: "GET"
	    		, data: {
	    			cardinalId : cardinalId
	    		}
	    		, success : function(data) {
	    			
// 	    			console.log("Cardinal Data Check : " + data);
	    			
	    			classPrice = Number(data.PRICE).toLocaleString('en') + '원';
	    			realPrice = data.PAY_CRC_AMOUNT;
	    			
// 	    			console.log(classPrice + " " + realPrice);
	    			
	    			$(".cardinals_days").html(data.LEARN_START_DATE + " ~ " + data.LEARN_END_DATE);
	    			$(".class-price").html(classPrice);
	    			$('.class-pay-price').html(classPrice);
	    			$('.price-total').attr('data-value', realPrice);
	    			$('.price-total').html(Number(realPrice).toLocaleString('en') + '원');
	    			
	    			makeSignature(realPrice);
	    		}
	    		, error : function() {
	    			alert("Cardianl Detail 실패");
	    		}
	    	});
	    }
	
	    function init(icon_displays, target_types) {
	
	    	var point_percentage_policy = "${point_percentage_policy}";
	    	$('#point_percentage_policy').html('결제금액의 ' + point_percentage_policy + '% 적립');
	
	    	var course_price = "${courseInfo.price}";
	    	var price = Number(course_price).toLocaleString('en') + "원";
	    	$('#course_price').html(price);
	
	    	var content = "";
	
	    	$('.filterWrap').html(content);
	    		
	    }
		
	    //영수증 팝업
	    $(function() {
	    	$('.receipt').click(function() {
	    		var idx = $(this).closest('.idx-li').find('.c-table-num').text() - 1;
	    		var realPayment = $(':hidden[name="realPayment"]').eq(idx).val();
	    		var courseName = $(':hidden[name="courseName"]').eq(idx).val();
	    		var user_nm = $(':hidden[name="user_nm"]').eq(idx).val();
	    		var course_id = $(':hidden[name="course_id"]').eq(idx).val();
	    		var cardinal_id  = $(':hidden[name="cardinal_id"]').eq(idx).val(); 
	    			realPayment = numberWithCommas(realPayment);
	    			//무료과정 처리
	    			if(realPayment =="") {
	    				realPayment = "0";
	    			}
	    			
	    			//기존 영수증정보 조회, 없을시 생성
	    			$.ajax({
	    				type	: "post",
	    				url		: "/smtp/user/select_receipt_num",
	    				data    : {
	    							'course_id' : course_id
	    							,'cardinal_id' : cardinal_id
	    						  },
	    				success	: function(data) {
	    					$('.receiptNum').html(data.RECEIPT_NUM);//영수증 일련번호
	    					$('.receiptDate').html(data.RECEIPT_DATE);//발행일
	    					
	    					//모달창의 hidden값에 넣기
	    					$(':hidden[name="m_course_id"]').val(course_id);
	    					$(':hidden[name="m_cardinal_id"]').val(cardinal_id);
	    					$(':hidden[name="receiptNum"]').val(data.RECEIPT_NUM);
	    					$(':hidden[name="receiptDate"]').val(data.RECEIPT_DATE);
	    					
	    				},
	    				error : function (request, status, error) {
	    						alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
	    				}
	    			});
	    			
	    			
	    		
	    		//단가 표기
	    		var array = realPayment.toString().replace(",","").split('');
	    		array = array.reverse();
	    		var splitArray = new Array();
	    		for(i=0 ; i<array.length ; i++) {
// 	    			console.log(array[i]);
	    			splitArray.push(array[i]);
	    		}
	    		for(i=7 ; i>=0 ; i--) {
	    			$("tr.priceIdx").children("td").eq(i).empty();
	    			$("tr.priceIdx").children("td").eq(i).html(splitArray[7-i]);
	    		}
	    		
	    		function numberWithCommas(realPayment) {
	    			return realPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    		}
	    		
	    		$('.receiptItemList').html(courseName);//과정명
	    		$('.receiptItemPrice').html(numberWithCommas(realPayment)+"원");//단가
	    		$('.user_nm').html('<span>' + user_nm + '</span>&nbsp;귀하');
	    		$('html, body').addClass("not-scroll");
	    		$('.receiptModal').show();
	    	});
	    });
	
	    function numberWithCommas(realPayment) {
	        return realPayment.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }
	    
	    function checkAccount(id, course_name, cardinal_name, price, dis_point, real_payment, accnum, bank_name) {
	        var course = document.createElement("input");
	        course.setAttribute("type", "hidden");
	        course.setAttribute('name', "course_name");
	        course.setAttribute("value", course_name);
	        var cardinal = document.createElement("input");
	        cardinal.setAttribute("type", "hidden");
	        cardinal.setAttribute('name', "cardinal_name");
	        cardinal.setAttribute("value", cardinal_name);''
	        
	        var content = "<input type='hidden' name='learn_id' value="+id+">";
	        content += "<input type='hidden' name='price' value="+price+">";
	        content += "<input type='hidden' name='dis_point' value="+dis_point+">";
	        content += "<input type='hidden' name='real_payment' value="+real_payment+">";
	        content += "<input type='hidden' name='accnum' value="+accnum+">";
	        content += "<input type='hidden' name='bank_name' value="+bank_name+">";
	        
	        $("#listForm").append(course)
	        $("#listForm").append(cardinal)
			$("#listForm").append(content)
	        $("#listForm").removeAttr('target');
			$("#listForm").attr('action', '/smtp/user/paybackFinal');
	        $("#listForm").attr('method', 'post');
	    	$("#listForm").submit();
			$("#listForm").empty();
	    }
	    
	   	function checkRefund(url, id, course_name, cardinal_name, price, dis_point, real_payment, pay_crc_seq) {
	        var course = document.createElement("input");
	        course.setAttribute("type", "hidden");
	        course.setAttribute('name', "course_name");
	        course.setAttribute("value", course_name);
	        var cardinal = document.createElement("input");
	        cardinal.setAttribute("type", "hidden");
	        cardinal.setAttribute('name', "cardinal_name");
	        cardinal.setAttribute("value", cardinal_name);''
	        
	        var content = "<input type='hidden' name='learn_id' value="+id+">";
	        content += "<input type='hidden' name='price' value="+price+">";
	        content += "<input type='hidden' name='dis_point' value="+dis_point+">";
	        content += "<input type='hidden' name='real_payment' value="+real_payment+">";
	        content += "<input type='hidden' name='pay_crc_seq' value="+pay_crc_seq+">";
	        
	        $("#listForm").append(course)
	        $("#listForm").append(cardinal)
			$("#listForm").append(content)
			
			window.open("", '환불현황', 'width=960px, height=425px, toolbars=no, scrollbars=yes');
			$("#listForm").attr('action', url);
	        $("#listForm").attr('method', 'post');
	        $("#listForm").attr('target', '환불현황');
	    	$("#listForm").submit();
			$("#listForm").empty();
	    }
	   	function setContent() {
	   		var content = '';
	   		
	   	}
	</script>
</head>
<body>
	<input type="hidden" id="serverMessage" value="${message}">
	<div class="container_rainbow">
		<!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>
		<div class="content sub-content sub05_content" id="main">
	        <div class="header_textWrap">
	            <h3 class="h3">결제현황/환불</h3>
	            <p class="fc_999">
	                결제현황 및 환불 정보를 확인하실 수 있습니다.
	            </p>
	        </div>
	        <div>
		        <div class="searchWrapper">
					<form class="formStyle d-flex" id="searchForm" method="POST" style="margin: 0px;">
						<div class="class-searchWrap d-flex">
							<input type="text" class="cusPHIn input" name="searchKeyword" value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
							<!-- 검색버튼 -->
							<button type="button" class="button img-icon search" id="searchBtn"></button>
							<input type="hidden" id="startPage" name="startPage" value="${search.startPage}">
							<input type="hidden" id="course_search_seq" name="id" value="">
						</div>
					</form>
				</div>
	            <div class="sub-segment">
	                <ul class="class-list-title thead d-flex">
	                    <li class="c-table-num">No.</li>
	                    <li class="c-table-name">과정명</li>
	                    <li class="c-table-01">교육비</li>
	                    <li class="c-table-01">마일리지사용</li>
	                    <li class="c-table-01">결제금액</li>
	                    <li class="c-table-01">결제방식</li>
	                    <li class="c-table-02">결제기간</li>
	                    <li class="c-table-01">결제상태</li>
	                    <li class="c-table-01">환불/결제</li>
	                    <li class="c-table-01">영수증</li>
	                </ul>
	                <ul class="class-list-wrap">
		                <c:if test = "${!empty payList }">
		                <form name="listForm" id="listForm" method="post"></form>
	                        <c:forEach var="item" items="${payList }" varStatus="status">
	                        <form name="listForm2" method="post" onsubmit="return false;">
	                        	<input type="hidden" id="pay_crc_seq_${status.index}" name="pay_crc_seq" value="${item.PAY_CRC_SEQ}">
	                        	<input type="hidden" name="course_id" value="${item.COURSE_ID}"/>
	                        	<input type="hidden" id="gisu_id_${status.index}" name="cardinal_id" value="${item.CARDINAL_ID}"/>
	                        	<input type="hidden" name="realPayment" value="${item.REAL_PAY_AMOUNT }"/>
	                        	<input type="hidden" name="courseName" value="${item.COURSE_NAME }"/>
	                        	<input type="hidden" name="user_nm" value="${user_nm}"/>
	                        </form> 
	                       	<!-- 과정명 추가시 list and(+) Wrap 추가  -->
	                       	<!-- 결제 완료(payment-complete)시 환불(refund-Y)가능 -->
	                       	<!-- 결제 대기(payment-wait)시 환불(refund-N)불가 -->
	                       	<!-- 환불 완료시 (refund-complete) -->
	                       <li class="class-list d-flex idx-li">
	                           <div class="c-table-num">${status.count }</div>
	                           <div class="c-table-name">${item.CARDINAL_NAME } <c:if test="${not empty item.PAY_CRC_PAYORDER}">/ ${item.PAY_CRC_PAYORDER} 차</c:if></div>
	                           <div class="c-table-01">
		                           <c:choose>
			                           	<c:when test="${not empty item.PAY_CRC_AMOUNT}">
			                           		<fmt:formatNumber value="${item.PAY_CRC_AMOUNT }" pattern="#,###"/>원
			                           	</c:when>
			                           	<c:when test="${empty item.PAY_CRC_AMOUNT}">
			                           		<fmt:formatNumber value="0" pattern="#,###"/>원
			                           	</c:when>
		                           </c:choose>
	                           </div>
								<c:if test="${item.DIS_POINT == '' || item.DIS_POINT == null}">
	                           		<div class="c-table-01">0점</div>
	                           </c:if>
	                           <c:if test="${item.DIS_POINT != '' && item.DIS_POINT != null}">
	                           		<div class="c-table-01"><fmt:formatNumber value="${item.DIS_POINT }" pattern="#,###"/>점</div>
	                           </c:if>
								<c:choose>
									<c:when test="${item.REAL_PAY_AMOUNT == '' || item.REAL_PAY_AMOUNT == null}">
										<div class="c-table-01">0원</div>
									</c:when>
									<c:when test="${item.REAL_PAY_AMOUNT != '' && item.REAL_PAY_AMOUNT != null}">
										<div class="c-table-01"><fmt:formatNumber value="${item.REAL_PAY_AMOUNT }" pattern="#,###" />원</div>
									</c:when>
								</c:choose>
	                           <!-- 결제방식 처리 -->
	                           <c:choose>
		                           	<c:when test="${item.payment_type eq 'VBank'}">
										<div class="c-table-01">가상계좌</div>
									</c:when>
		                           	<c:when test="${item.payment_type eq 'Card' }">
		                           		<div class="c-table-01">신용카드</div>
		                           	</c:when>
		                          	<c:when test="${item.PRICE eq item.DIS_POINT }">
		                           		<div class="c-table-01">마일리지</div>
		                           	</c:when>
		                           	<c:otherwise>
		                           		<div class="c-table-01">-</div>
		                           	</c:otherwise>
	                           	</c:choose>
	                           	<div class="c-table-02">
	                           		<c:choose>
	                           			<c:when test="${not empty item.PAY_CRC_START && item.PAYMENT_STATUS != 'F0001'}">
	                           				${item.PAY_CRC_START} ~ ${item.PAY_CRC_END}
	                           			</c:when>
	                           			<c:when test="${not empty item.PAY_CRC_START && item.PAYMENT_STATUS == 'F0001'}">
	                           				<span>결제일 : ${item.PAY_INS_DT}</span>
	                           			</c:when>
	                           			<c:otherwise>
	                           				-
	                           			</c:otherwise>
	                           		</c:choose>
	                           	</div>
	                           	<!-- 결제상태 처리 -->
	                           	<!-- PAYMENT_STATUS 미결제: 0, 결제: 1, 환불신청: 2, 환불완료: 3 -->
	                           	<c:choose>
		                           	<c:when test="${item.payment_type eq 'VBank' && item.PAYMENT_STATUS eq 'F0000'}">
		                           		<div class="c-table-01 payment-wait"><span class="fc_999">결제대기</span></div>
		                           		<div class="c-table-01">
		                           			<a href="javascript:void(0);" onclick="javascript:checkAccount('${item.ID}','${item.COURSE_NAME}','${item.CARDINAL_NAME}','${item.PAY_CRC_AMOUNT}','${item.DIS_POINT}','${item.PAY_CRC_AMOUNT}','${item.ACCNUM}','${item.BANKNAME}');"
		                           				class="btn_normal btn_pp btn_small">계좌정보</a>
		                           		</div>
		                           		<div class="c-table-01"></div>
		                           	</c:when>
	                           		<c:when test="${item.payment_type eq 'VBank' && item.PAYMENT_STATUS eq 'F0001'}">
		                           		<div class="c-table-01 payment-complete"><span class="fc_true">결제완료</span></div>
		                           		<div class="c-table-01">
			                           		<c:choose>
			                           			<c:when test="${item.PAY_CRC_SEQ ne null}">
				                            		<a href="javascript:void(0);" onclick="javascript:checkRefund('/smtp/user/payback-main','${item.ID}','${item.COURSE_NAME}','${item.CARDINAL_NAME}','${item.PAY_CRC_AMOUNT}','${item.DIS_POINT}','${item.REAL_PAY_AMOUNT}','${item.PAY_CRC_SEQ}');"
				                            			class="btn_normal btn_pp btn_small" id="refund_button">환불신청</a>
			                           			</c:when>
			                           			<c:otherwise>
			                           				<a href="/smtp/user/payback-main?learn_id=${item.ID}&course_name=${item.COURSE_NAME}&cardinal_name=${item.CARDINAL_NAME}&price=${item.PAY_CRC_AMOUNT}&dis_point=${item.DIS_POINT}&real_payment=${item.REAL_PAY_AMOUNT}"
			                           					class="btn_normal btn_pp btn_small" onclick="window.open(this.href, '_blank', 'width=960px, height=425px, toolbars=no, scrollbars=yes'); return false;"
			                           					id="refund_button" style="text-align:center; align-self:center; width:70px;">환불신청</a>
			                           			</c:otherwise>
			                           		</c:choose>
	                           			</div>
	                           			<div class="c-table-01 c-table-btn receipt">
			                            	<a href="#" class="btn_normal btn_nv btn_small">출력</a>
										</div>
	                           		</c:when>
		                           	<c:when test="${item.PAYMENT_STATUS eq 'F0001'}">
		                           	    <div class="c-table-01 payment-complete"><span class="fc_true">결제완료</span></div>
		                           		<div class="c-table-01">
		                           		<c:choose>
		                           			<c:when test="${item.PAY_CRC_SEQ ne null }">
			                            		<a href="javascript:void(0);" onclick="javascript:checkRefund('/smtp/user/payback-main','${item.ID}','${item.COURSE_NAME}','${item.CARDINAL_NAME}','${item.PAY_CRC_AMOUNT}','${item.DIS_POINT}','${item.REAL_PAY_AMOUNT}','${item.PAY_CRC_SEQ}');"
				                            			class="btn_normal btn_pp btn_small" id="refund_button">환불신청</a>
		                           			</c:when>
		                           			<c:otherwise>
		                           				<a href="/smtp/user/payback-main?learn_id=${item.ID}&course_name=${item.COURSE_NAME}&cardinal_name=${item.CARDINAL_NAME}&price=${item.PAY_CRC_AMOUNT}&dis_point=${item.DIS_POINT}&real_payment=${item.REAL_PAY_AMOUNT}"
		                           				 class="btn_normal btn_pp btn_small" id="refund_button" onclick="window.open(this.href, '_blank', 'width=960px, height=425px, toolbars=no, scrollbars=yes'); return false;">환불신청</a>
		                           			</c:otherwise>
		                           		</c:choose>
		                           		</div>
			                            <div class="c-table-01 c-table-btn receipt">
			                            	<a href="#" class="btn_normal btn_nv btn_small">출력</a>
										</div>
		                           	</c:when>
	                           	
		                           	<c:when test="${item.PAYMENT_STATUS eq 'F0002' }">
		                           	    <div class="c-table-01"><span class="fc_999">환불대기</span></div>
		                           		<div class="c-table-01">
		                           			<a href="javascript:void(0);" onclick="javascript:checkRefund('/smtp/user/paybackUpdate','${item.ID}','${item.COURSE_NAME}','${item.CARDINAL_NAME}','${item.PAY_CRC_AMOUNT}','${item.DIS_POINT}','${item.REAL_PAY_AMOUNT}','${item.PAY_CRC_SEQ}');"
		                           		 	class="btn_normal btn_pp_bg btn_small" id="refund_button">환불현황</a>
		                           		 </div>
			                            <div class="c-table-01 c-table-btn receipt">
			                            	<a href="#" class="btn_normal btn_nv btn_small">출력</a>
										</div>
		                           	</c:when>
		                           	<c:when test="${item.PAYMENT_STATUS eq 'F0003' }">
		                           	    <div class="c-table-01 payment-complete"><span class="fc_false">환불완료</span></div>
		                           		<div class="c-table-01"><a class="btn_normal btn_pp_bg btn_small">환불완료</a></div>
		                           		<div class="c-table-01 c-table-btn receipt">
		                           			<a href="#" class="btn_normal btn_nv btn_small">출력</a>
		                           		</div>
		                           	</c:when>
		                           	<c:otherwise>
		                           		<input type="hidden" class="start_${status.index}" value="${item.PAY_CRC_START}">
	                            		<input type="hidden" class="end_${status.index}" value="${item.PAY_CRC_END}">
	                            		<div class="c-table-01 payment-wait"><span class="fc_999">결제대기</span></div>
	                            		<div class="c-table-01">
		                           			<a href="javascript:void(0);" onclick="callFunction(this);"
		                           				id="pay-btn-${status.index}" class="btn_normal btn_pp btn_small pay-btn-${status.index}">결제하기</a>
		                           			</div>
		                           		<div class="c-table-01">-</div>
		                           	</c:otherwise>
	                           	</c:choose>
	                        </li>
	                    </c:forEach>
	                  </c:if>
	                  <c:if test="${empty payList }">
	                  		<ul class="class-list-wrap">
		                        <li class="listAndwrap">
		                           <div class="class-list justify_center">결제정보가 없습니다.</div>
		                        </li>
	                  		</ul>
	                  </c:if>
	                </ul>
	            </div>
	        </div>
	    </div>
	    <div class="modal receiptModal" id="modal">
    		<div class="modal-layer"></div>
    		<div class="modal-content printReceipt">
    			<%@include file="modal/modal-sub07-02-01.jsp" %>
    		</div>
		</div> 
		<div class="modal paymentmodal">
			<div class="modal-layer"></div>
			<div class="modal-content">
				<!-- modal 수강신청 1단계 include -->
				<%@include file="modal/modal-sub02-01-03.jsp"%>
			</div>
			<div class="modal-content" style="display: none">
				<!-- modal 수강신청 1단계 include -->
				<%@include file="modal/modal-sub02-01-04.jsp"%>
			</div>
		</div>
	    <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp" %>
	</div>
</body>
</html>