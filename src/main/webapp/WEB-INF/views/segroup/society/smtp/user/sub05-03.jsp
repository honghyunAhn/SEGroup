<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	<!-- 레인보우 기본 세팅 -->
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
    
    <!--full calendar -->
    <link rel='stylesheet' href='/resources/js/ext/fullcalendar/css/jquery-ui.min.css' /> 
	<link href='/resources/js/ext/fullcalendar/css/fullcalendar.css' rel='stylesheet' />
	<link href='/resources/js/ext/fullcalendar/css/fullcalendar.print.css' rel='stylesheet' media='print' /> 
	<script src='/resources/js/ext/fullcalendar/js/moment.min.js'></script>
	<script src='/resources/js/ext/fullcalendar/js/fullcalendar.min.js'></script>
	<script src='/resources/js/ext/fullcalendar/js/lang-all.js'></script>
	
    <!-- Pagination을 위한 js -->
	<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>
	<script type="text/javascript">

		/*---------------변수 영역----------------*/
		//과정 리스트
		var data;
		
		var listUrl = "<c:url value='/smtp/user/sub05-01-list'/>";
		/*---------------변수 영역 끝----------------*/
		
		/*---------------ready Func 시작----------------*/
		$(document).ready(function() {
			setContent(0);
			
			var classTabMenu = $('#mainDisplay >.myClass-tabGroup >li');
			var i = 0;
			classTabMenu.on('click', function () {
				$('#startPage').val(1);
				i = $(this).index();
				if(i == '0' || i == '1' || i == '2') {
					setContent(i);
				}
			});
			
		})
		/*---------------ready Func 끝--------------*/
		 
		/*---------------함수 영역----------------*/ 
		
		
		//선택탭에 따라 다른 데이터를 뿌려줌
		function setContent(i) {
			if(i == 0 || i == 1) {
				getList (0);
				setProgressList (i);
				setPrintBtn();
			} else if (i == 2) {
				getList (i);
				setCompleteList (i);
				setPrintBtn();
			}
		}
		
		//data 받아오는 메소드
		function getList(i) {
			
			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				url : listUrl,
				data : {
					"startPage" : startPage,
					"listNum" : i
				},
				async : false,
				success : function(list) {
					data = list;
				}
			})
		}
		
		function setProgressList(i) {
			
			var content = "";
			
			if(data.progressList != null && data.progressList.length != 0) {
				
				$.each(data.progressList, function (index, item) {
					
					content += '<li class="class-list d-flex">';
					content += 		'<div class="hiddenDiv">';
					content += 			'<input type="hidden" name="id" value="'+ item.ID +'"/>';
					content += 			'<input type="hidden" name="courseId" value="'+ item.COURSE_ID +'"/>';
					content += 			'<input type="hidden" name="cardinalId" value="'+ item.CARDINAL_ID +'"/>';
					content += 		'</div>';
					content += 		'<div class="c-table-num">'+(index+1)+ '</div>';
					content += 		'<div class="c-table-name-w">'+ item.NAME+ '</div>';
					content += 		'<div class="c-table-02">'+ item.CARDINAL_NAME + '</div>';
					content += 		'<div class="c-table-03">'+ item.LEARN_START_DATE + " - " + item.LEARN_END_DATE + '</div>';
					if(i == 0) {
						content += 		'<div class="c-table-01 c-table-btn printScoreDiv">';
						content += 			'<a class="btn_normal btn_pp btn_small btn_print">';
						content +=			'<span class="h5">출력</span></a>';
						content +=		'</div>';
						content +=	'</div>';
						content +=	'</li>';
						$('.progressUl1').html(content);
					} else if(i == 1) {
						content += 		'<div class="c-table-01 c-table-btn printTrainingCertificateDiv">';
						content += 			'<a class="btn_normal btn_pp btn_small btn_print">';
						content +=			'<span class="h5">출력</span></a>';
						content +=		'</div>';
						content +=	'</li>';
						$('.progressUl2').html(content);
					}
					
				})
			}
			if(content == "") {
				content += '<li class="listAndWrap">';
				content += 		'<div class="class-list justify_center"><p>조회된 내용이 없습니다.</p></div>';
				content +=	'</li>';
				$('.progressUl1').html(content);
				$('.progressUl2').html(content);
			}
		}
		
		function setCompleteList(i) {
			
			var content = "";
			
			if(data.completeList != null && data.completeList.length != 0) {
				$.each(data.completeList, function(index, item) {
					if(item.ISSUE_YN == 'Y') {
						content += '<li class="class-list d-flex">';
						content += 		'<div class="hiddenDiv">';
						content += 			'<input type="hidden" name="id" value="'+ item.ID +'"/>';
						content += 			'<input type="hidden" name="courseId" value="'+ item.COURSE_ID +'"/>';
						content += 			'<input type="hidden" name="cardinalId" value="'+ item.CARDINAL_ID +'"/>';
						content += 		'</div>';
						content += 		'<div class="c-table-num">'+(index+1)+ '</div>';
						content += 		'<div class="c-table-name-w">'+ item.NAME+ '</div>';
						content += 		'<div class="c-table-02">'+ item.CARDINAL_NAME + '</div>';
						content += 		'<div class="c-table-03">'+ item.REAL_START_DATE + " - " + item.REAL_END_DATE + '</div>';	
						content += 		'<div class="c-table-01 c-table-btn printCertificateDiv">';
						content += 			'<a href="#" class="btn_normal btn_pp btn_small btn_print modal-popup">';
						content += 			'<span class="h5">수료증</span>';
						content += 			'</a>';
						content += '</div>';
						content += '</li>';
					}
				})
			}
			if(content == "") {
				content += '<li class="listAndWrap">';
				content += 		'<div class="class-list justify_center"><p>조회된 내용이 없습니다.</p></div>';
				content +=	'</li>';
			}
			$('.completeUl').html(content);
		}
		
		function setPrintBtn() {
			$('.printScoreDiv').on('click', function() {
				var course = $(this).closest('li').find(':hidden[name=courseId]').val();
				var cardinal = $(this).closest('li').find(':hidden[name=cardinalId]').val();
				var form = document.createElement("form");
				var input1 = document.createElement("input");
			    input1.setAttribute("type", "hidden");
			    input1.setAttribute('name', "crc_id");
			    input1.setAttribute("value", course);
			    form.appendChild(input1);
			    var input2 = document.createElement("input");
			    input2.setAttribute("type", "hidden");
			    input2.setAttribute('name', "gisu_id");
			    input2.setAttribute("value", cardinal);
			    form.appendChild(input2);
			    document.body.appendChild(form);
			    
				window.open("", "성적표 출력", "width=800px, height=900px,scrollbars=yes");
			    form.action = "/smtp/user/printScore";
			    form.target = "성적표 출력";
			    form.method = "post";
			    form.submit();
			    form.remove();
			})
			$('.printCertificateDiv').on('click', function() {
				var cardinal = $(this).closest('li').find(':hidden[name=cardinalId]').val();
				
				var form = document.createElement("form");
				var input1 = document.createElement("input");
			    input1.setAttribute("type", "hidden");
			    input1.setAttribute('name', "cardinal_id");
			    input1.setAttribute("value", cardinal);
			    form.appendChild(input1);
			    document.body.appendChild(form);
			    
				window.open("", "수료증 출력", "width=800px, height=900px,scrollbars=yes");
			    form.action = "/smtp/user/printCertificate";
			    form.target = "수료증 출력";
			    form.method = "post";
			    form.submit();
			    form.remove();
			})
			$('.printTrainingCertificateDiv').on('click', function() {
				var cardinal = $(this).closest('li').find(':hidden[name=cardinalId]').val();
				
				var form = document.createElement("form");
				var input1 = document.createElement("input");
			    input1.setAttribute("type", "hidden");
			    input1.setAttribute('name', "cardinal_id");
			    input1.setAttribute("value", cardinal);
			    form.appendChild(input1);
			    document.body.appendChild(form);
			    
				window.open("", "openWindow", "width=800px, height=900px,scrollbars=yes");
			    form.action = "/smtp/user/printTrainingCertificate";
			    form.target = "openWindow";
			    form.method = "post";
			    form.submit();
			    form.remove();
			})
		}
		
		/*---------------함수 영역 끝-------------*/ 
	 
	 
	</script>
</head>
<body>
<div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub05_content" id="main">
            <div class="header_textWrap">
                <h3 class="h3">서류발급</h3>
                <p class="fc_999">
                    성적증명서, 연수확인증, 수료증 등 학위관련 필요서류를 발급하실 수 있습니다.
                </p>
            </div>
            <div class="section section_sub05-03">
                <div class="myClass-tabMenu">
                    <div class="bgc_pb fc_fff"  id="mainDisplay">
                        <ul class="myClass-tabGroup d-flex justify_center">
                            <li class="active">성적증명서</li>
                            <li>연수확인증</li>
                            <li>수료증</li>
                        </ul>
                        <!-- pagination용  -->
			            <div class="d-flex floatR">
							<div class="class-search-down d-flex">
								<c:if test="${startpage != '' && startpage != null}">
									<input type="hidden" id="startPage" name="startPage" value="${startPage}">
								</c:if>
								<c:if test="${startpage == '' || startpage == null}">
									<input type="hidden" id="startPage" name="startPage" value="1">
								</c:if>
							</div>
						</div>
                    </div>
                    <div class="myClass-subGroup">
                        <div class="tab-sub tab-sub01">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-w">과정명</li>
                                    <li class="c-table-02">기수</li>
                                    <li class="c-table-03">학습기간</li>
                                    <li class="c-table-01">출력</li>
                                </ul>
                                <ul class="class-list-wrap progressUl1"></ul>
                            </div>
                        </div>
                        <div class="tab-sub tab-sub02">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-w">과정명</li>
                                    <li class="c-table-02">기수</li>
                                    <li class="c-table-03">학습기간</li>
                                    <li class="c-table-01">출력</li>
                                </ul>
                                <ul class="class-list-wrap progressUl2"></ul>
                            </div>
                        </div>
                        <div class="tab-sub tab-sub03">
                            <div class="sub-segment">
                                <ul class="class-list-title thead d-flex">
                                    <li class="c-table-num">No.</li>
                                    <li class="c-table-name-w">과정명</li>
                                    <li class="c-table-02">기수</li>
                                    <li class="c-table-03">학습기간</li>
                                    <li class="c-table-01">출력</li>
                                </ul>
                                <ul class="class-list-wrap completeUl"></ul>
                            </div>
                        </div>
                    </div>
                    <!-- pagenation  -->
					<div class="page">
						<ul class="pagination d-flex justify_between" id="pagination"></ul>
					</div>
                </div>
            </div>
        </div>
        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>
</html>