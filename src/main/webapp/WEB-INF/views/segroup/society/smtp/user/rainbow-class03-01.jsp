<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 나의강의실 >> 서류발급 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <script type="text/javascript">
        /*---------------변수 영역----------------*/
		//과정 리스트
		var data;
		
		var listUrl = "<c:url value='/smtp/user/sub05-01-list'/>";
		/*---------------변수 영역 끝----------------*/
		
		/*---------------ready Func 시작----------------*/
		$(document).ready(function() {
			// class nav active
		    navLinks[4].parentElement.classList.add('current')
		    subNav[4].classList.add('active');
			
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
					
					content += '<li class="list d-flex">';
					content += 		'<div class="hiddenDiv">';
					content += 			'<input type="hidden" name="id" value="'+ item.ID +'"/>';
					content += 			'<input type="hidden" name="courseId" value="'+ item.COURSE_ID +'"/>';
					content += 			'<input type="hidden" name="cardinalId" value="'+ item.CARDINAL_ID +'"/>';
					content += 		'</div>';
					content += 		'<div class="w50">'+(index+1)+ '</div>';
					content += 		'<div class="w500"><p>'+ item.NAME +' / '+ item.CARDINAL_NAME + '</p>';
					content += 		'<p>' + item.LEARN_START_DATE + " ~ " + item.LEARN_END_DATE +  '</p></div>';
					if(i == 0) {
						content += 		'<div class="w100 printScoreDiv">';
						content += 			'<a class="w50 btn_normal btn_xsmall bgc_point">';
						content +=			'<span class="h5">출력하기</span></a>';
						content +=		'</div>';
						content +=	'</div>';
						content +=	'</li>';
						$('.progressUl1').html(content);
					} else if(i == 1) {
						content += 		'<div class="w100 printTrainingCertificateDiv">';
						content += 			'<a class="w50 btn_normal btn_xsmall bgc_point">';
						content +=			'<span class="h5">출력하기</span></a>';
						content +=		'</div>';
						content +=	'</li>';
						$('.progressUl2').html(content);
					}
					
				})
			}
			if(content == "") {
				content += '<li class="list not fc_999">';
				content += 		'조회된 내용이 없습니다.';
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
						content += '<li class="list d-flex">';
						content += 		'<div class="hiddenDiv">';
						content += 			'<input type="hidden" name="id" value="'+ item.ID +'"/>';
						content += 			'<input type="hidden" name="courseId" value="'+ item.COURSE_ID +'"/>';
						content += 			'<input type="hidden" name="cardinalId" value="'+ item.CARDINAL_ID +'"/>';
						content += 		'</div>';
						content += 		'<div class="w50">'+(index+1)+ '</div>';
						content += 		'<div class="w500"><p>'+ item.NAME+ " / " + item.CARDINAL_NAME + '</p>';
						content += 		'<p>'+ item.REAL_START_DATE + " ~ " + item.REAL_END_DATE + '</p></div>';
						content += 		'<div class="w100 printCertificateDiv">';
						content += 			'<a href="#" class="w50 btn_normal btn_xsmall bgc_point">';
						content += 			'<span class="h5">출력하기</span>';
						content += 			'</a>';
						content += '</div>';
						content += '</li>';
					}
				})
			}
			if(content == "") {
				content += '<li class="list not fc_999">';
				content += 		'조회된 내용이 없습니다.';
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
        <%@include file="../include/rainbow_header.jsp"%>
        <div class="content myClass course-point05" id="main">
            <div class="sub-content class01-01">
                <div class="section_header">
                    <h3 class="h3">📃 서류발급</h3>
                    <p class="margin-top10 fc_999">
                        성적증명서, 연수확인증, 수료증 등 학위관련 필요서류를 발급하실 수 있습니다.
                    </p>
                </div>
                <div class="section_tab" id="mainDisplay">
                    <ul class="tab_headerWrap d-flex justify_center fc_point myClass-tabGroup">
                        <li class="tab_header fz16 active">
                            <a tab="#tab1">성적증명서</a>
                        </li>
                        <li class="tab_header fz16">
                            <a tab="#tab2">연수확인증</a>
                        </li>
                        <li class="tab_header fz16">
                            <a tab="#tab3">수료증</a>
                        </li>
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
                    <ul class="tab_bodyWrap">
                        <li id="tab1" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>학습기간</li>
                                    <li class="w100">성적증명서</li>
                                </ul>
                                <ul class="table-list tbody progressUl1"></ul>
                            </div>
                        </li>
                        <li id="tab2" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>학습기간</li>
                                    <li class="w100">연수확인증</li>
                                </ul>
                                <ul class="table-list tbody progressUl2"></ul>
                            </div>
                        </li>
                        <li id="tab3" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>학습기간</li>
                                    <li class="w100">수료증</li>
                                </ul>
                                <ul class="table-list tbody completeUl"></ul>
                            </div>
                        </li>
                    </ul>
                    <!-- pagenation  -->
					<div class="page">
						<ul class="pagination d-flex justify_between" id="pagination"></ul>
					</div>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
</body>
</html>