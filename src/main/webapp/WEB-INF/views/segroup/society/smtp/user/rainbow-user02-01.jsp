<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
        var icon_displays;
	    var target_types;
	    var course_id;
	    var selp_period;
	    var classNm;
	    var classPrice;
	    var realPrice;
	    var learnPrice;
	
	    $( document ).ready(function() {
	    	// class nav active
	        navLinks[4].parentElement.classList.add('current')
	        subNav[4].classList.add('active');
	    	
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

    <!-- 나의강의실 - 결제현황/환불 -->
    <div class="container_rainbow">
        <!-- rainbow_header -->
        <%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-point05" id="main">
            <div class="sub-content user02-01">
                <div class="section_header">
                    <h3 class="h3">결제현황/환불</h3>
                    <p class="margin-top10 fc_999">
                        결제현황 및 환불 정보를 확인하실 수 있습니다.
                    </p>
                </div>
                <div class="section_search">
                    <form class="formStyle" id="searchForm" method="POST">
                        <div class="d-flex justify_between">
                            <input type="text" class="cusPHIn input margin-left10" name="searchKeyword"
                                value="${search.searchKeyword}" placeholder="검색어를 입력해주세요.">
                            <!-- 검색버튼 -->
                            <button type="button" class="btn_normal img-icon search" id="searchBtn"></button>
                            <c:if test="${startpage != '' && startpage != null}">
                                <input type="hidden" id="startPage" name="startPage" value="${search.startPage}">
                            </c:if>
                            <c:if test="${startpage == '' || startpage == null}">
                                <input type="hidden" id="course_search_seq" name="id" value="">
                            </c:if>
                        </div>
                    </form>
                </div>
                <div class="section_table overX-scroll">
                    <ul class="table-title d-flex thead fc_point">
                        <li class="w50">No.</li>
                        <li class="w350">과정명</li>
                        <li class="w100">결제상태</li>
                        <li class="w200">결제일</li>
                        <li class="w150">결제방식</li>
                        <li class="w200">결제금액</li>
                        <li class="w100">환불/결제</li>
                        <li class="w50">영수증</li>
                    </ul>
                    <ul class="table-list tbody">
                        <li class="list d-flex">
                            <div class="w50">No.</div>
                            <div class="w350">제목제목제목제목제목제목제목제목제목제목</div>
                            <div class="w100">결제대기</div>
                            <div class="w200">YYYY-MM-DD</div>
                            <div class="w150">가상계좌</div>
                            <div class="w200">1,000,000</div>
                            <div class="w100">
                                <a href="" class="table-btn btn_nomal bgc_point">결제하기</a>
                            </div>
                            <div class="w50">-</div>
                        </li>
                        <li class="list d-flex">
                            <div class="w50">No.</div>
                            <div class="w350">제목제목제목제목제목제목제목제목제목제목</div>
                            <div class="w100">결제완료</div>
                            <div class="w200">YYYY-MM-DD</div>
                            <div class="w150">가상계좌</div>
                            <div class="w200">1,000,000</div>
                            <div class="w100">
                                <a href="" class="table-btn btn_nomal bgc_point">환불신청</a>
                            </div>
                            <div class="w50">
                                <a href="javascript:void(0)" onclick="openModal()"
                                    class="table-btn btn_default">출력</a>
                            </div>
                        </li>
                        <li class="list d-flex">
                            <div class="w50">No.</div>
                            <div class="w350">제목제목제목제목제목제목제목제목제목제목</div>
                            <div class="w100">환불대기</div>
                            <div class="w200">YYYY-MM-DD</div>
                            <div class="w150">가상계좌</div>
                            <div class="w200">1,000,000</div>
                            <div class="w100">
                                <a href="" class="table-btn btn_nomal  bgc_point">환불현황</a>
                            </div>
                            <div class="w50">
                                <a href="javascript:void(0)" onclick="openModal()"
                                    class="table-btn btn_default">출력</a>
                            </div>
                        </li>
                        <c:if test="${empty payList}">
                            <li class="list not fc_999">결제정보가 없습니다.</li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
    <!-- 나의강의실 - 결제현황/환불 >> 영수증 출력 modal -->
    <%@include file="modal/rainbow-modal-printReceipt.jsp"%>
</body>
</html>