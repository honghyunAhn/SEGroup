<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
        $(function(){
        	// class nav active
    		navLinks[4].parentElement.classList.add('current')
    		subNav[4].classList.add('active');
    		// 지원현황 페이지 이동 메세지 alert
	    	var message = "${message}";
    		if(message.trim().length != 0) alert("지원 결과를 확인해주세요.");
    	})
    	
	    var icon_displays;
	    var target_types;
	    var course_id;
	    var selp_period;
	    var classNm;
	    var classPrice;
	    var realPrice;
	    var learnPrice;
	    
	    function callFunction(obj) {
	    	
	    	var thisBtnId = $(obj).attr("id");
	    	var idArr = thisBtnId.split("-");
	    	var length = idArr.length;
	    	var idIndex = idArr[length-1];
	    	
	    	var gisuId = $("#gisu_id_" + idIndex).val();
	    	var user_id = '${sessionScope.user_id}';
	    	
	    	/* alert("Gisu : " + gisuId); */
	    	
	    	$.ajax({
	    		url : "/smtp/course/getCourse"
	    		, type : "GET"
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
	    					/* init */
	    					icon_displays = item.icon_displays;
	    					target_types = item.target_types;
	    					
	    					init(icon_displays, target_types);
	    					
	    					/* getCardinalDetail */
	    					course_id = item.id;
	    					selp_period = item.selp_period;
	    					classNm = item.name;
	    					/* classPrice = Number(item.price).toLocaleString('en') + '원';
	    					realPrice = item.price; */
	    					learnPeriod = item.selp_period;
	    					
	    					/* alert(icon_displays + " " + target_types + " " + course_id + " " + 
	    							selp_period + " " + classNm + " " + classPrice + " " +
	    							realPrice + " " + learnPeriod); */
	    					
// 	    					console.log(icon_displays + " " + target_types + " " + course_id + " " + 
// 	    							selp_period + " " + classNm + " " + classPrice + " " +
// 	    							realPrice + " " + learnPeriod);
	    					
	    					$('.class-name').html(classNm);
	    					$('.class-id').val(course_id);
	    					$('.class-term').val(learnPeriod);
	    					$('#merCardinal').val(gisuId);
	    					
	    					getUserInfo(user_id);
	    					getCardinalDetail(gisuId);
	    				}
	    				, error : function(data) {
	    					alert("과정정보 불러오기 실패");
	    				}
	    			});
	    			
	    		}
	    		, error : function() {
	    			alert("과정코드 불러오기 실패");
	    		}
	    	}) 
	    	
	    	if(user_id == '' || user_id == null) {
	    		alert("로그인이 필요합니다.");
	    		document.location.href = '/segroup/society/smtp/user/login';
	    		return;
	    	}
	    	
	    	$('.modal').show();
	    	
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
	    			/* alert(data.user_nm + " " + data.user_email + " " + 
	    					data.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3') + " " 
	    					+ data.user_belong_to + " " + data.user_zipcode + " " 
	    					+ data.user_addr1 + " " + data.user_addr2); */
	    			
// 	    			console.log(data.user_nm + " " + data.user_email + " "
// 	    					+ data.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3') + " " 
// 	    					+ data.user_belong_to + " " + data.user_zipcode + " " 
// 	    					+ data.user_addr1 + " " + data.user_addr2);
	    			
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
	    			$('.price-total').html(realPrice);
	    			
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

	    	if (icon_displays != null) {

	    		var display_icon = icon_displays.split(',');

	    		$.each(display_icon, function(index, display) {
	    			if (display == '1') {
	    				content += '<div class="filter new">신규</div>';
	    			} else if (display == '2') {
	    				content += '<div class="filter recommend">추천</div>';
	    			} else if (display == '3') {
	    				content += '<div class="filter popular">인기</div>';
	    			} else if (display == '4') {
	    				content += '<div class="filter book">교재</div>';
	    			} else if (display == '5') {
	    				content += '<div class="filter sale">할인</div>';
	    			}
	    		});
	    	}

	    	$('.filterWrap').html(content);
	    		
	    }
	    
	    function submit(i) {
	    	$("#listForm_"+i).submit();
	    }
    </script>
</head>

<body>
    <div class="container_rainbow">
        <!-- rainbow_header -->
        <%@include file="../include/rainbow_header.jsp"%>
        <div class="content myClass course-point05" id="main">
            <div class="sub-content class02-01">
                <div class="section_header">
                    <h3 class="h3">📋 지원현황</h3>
                    <p class="margin-top10 fc_999">
                        지원신청한 과정들의 전형현황을 확인할 수 있습니다.
                    </p>
                </div>

                <div class="section_table overX-scroll">
                    <ul class="table-title thead d-flex fc_point">
                        <li class="w50">No.</li>
                        <li class="w550">과정/기수명</li>
                        <li class="w200">지원(수정)일</li>
                        <li class="w150">서류결과</li>
                        <li class="w150">면접결과</li>
                        <li class="w100">지원서</li>
                    </ul>
                    <c:choose>
                        <c:when test="${!empty applyResult }">
                            <c:forEach var="item" items="${applyResult }" varStatus="status">
                                <form name="listForm" id="listForm_${status.index}" action="/smtp/user/sub05-02-01"
                                    method="post">
                                    <input type="hidden" id="gisu_id_${status.index}" name="gisu_id"
                                        value="${item.gisu_id}" />
                                    <input type="hidden" id="app_end_date_${status.index}" name="app_end_date"
                                        value="${item.app_end_date}" />
                                </form>
                                <c:if test="${item.PAY_CRC_AMOUNT ne null}">
                                    <input type="hidden" name="pay-amount-${status.index}"
                                        value="${item.PAY_CRC_AMOUNT}">
                                </c:if>
                                <ul class="table-list tbody" id="dataListUl">
                                    <li class="list d-flex">
                                        <div class="w50"></div>
                                        <div class="w550">${item.gisu_nm }</div>
                                        <div class="w200">${item.stu_app_udt_dt }</div>
                                        <div class="w150 resume-result-${status.index}">
                                            <c:choose>
                                                <c:when test="${item.stu_app_rt_doc eq 'B1400' }">대기</c:when>
                                                <c:when test="${item.stu_app_rt_doc eq 'B1401' }">합격</c:when>
                                                <c:when test="${item.stu_app_rt_doc eq 'B1402' }">불합격</c:when>
                                                <c:when test="${item.stu_app_rt_doc eq 'B1403' }">예비</c:when>
                                            </c:choose>
                                        </div>
                                        <div class="w150 interview-result-${status.index}">
                                            <c:choose>
                                                <c:when test="${item.stu_app_rt_itv eq 'B1700' }">대기</c:when>
                                                <c:when test="${item.stu_app_rt_itv eq 'B1701' }">합격</c:when>
                                                <c:when test="${item.stu_app_rt_itv eq 'B1702' }">불합격</c:when>
                                                <c:when test="${item.stu_app_rt_itv eq 'B1703' }">예비</c:when>
                                            </c:choose>
                                        </div>
                                        <div class="w100">
                                            <a class="w50 btn_normal btn_xsmall bgc_point myCourse" href="javascript:void(0);" onclick="javascript:submit(${status.index})"><span class="h5">보기</span></a>
                                        </div>
                                    </li>
                                </ul>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <ul class="table-list tbody">
                                <li class="list not fc_999">
                                    조회 결과가 없습니다.
                                </li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
</body>
</html>