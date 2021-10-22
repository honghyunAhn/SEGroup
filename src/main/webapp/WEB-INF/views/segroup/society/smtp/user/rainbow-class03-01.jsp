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
			setContent(0);
			// class nav active
		    navLinks[4].parentElement.classList.add('current')
		    subNav[4].classList.add('active');
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
        <%@include file="../include/rainbow_header.jsp"%>
        <div class="content myClass course-point05" id="main">
            <div class="sub-content class01-01">
                <div class="section_header">
                    <h3 class="h3">📃 서류발급</h3>
                    <p class="margin-top10 fc_999">
                        성적증명서, 연수확인증, 수료증 등 학위관련 필요서류를 발급하실 수 있습니다.
                    </p>
                </div>
                <div class="section_tab">
                    <ul class="tab_headerWrap d-flex justify_center fc_point">
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
                    <ul class="tab_bodyWrap">
                        <li id="tab1" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>학습기간</li>
                                    <li class="w100">성적증명서</li>
                                </ul>
                                <ul class="table-list tbody progressUl1">
                                    <li class="list d-flex">
                                        <div class="w50">
                                            No.
                                        </div>
                                        <div class="w500">
                                            <p>
                                                과정명/기수명
                                            </p>
                                            <p>
                                                YY-MM-DD ~ YY-MM-DD
                                            </p>
                                        </div>
                                        <div class="w100">
                                            <a href="#" class="w50 btn_normal btn_xsmall bgc_point"><span
                                                    class="h5">출력하기</span></a>
                                        </div>
                                    </li>
                                    <li class="list not fc_999">
                                        조회된 내용이 없습니다.
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li id="tab2" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>학습기간</li>
                                    <li class="w100">연수확인증</li>
                                </ul>
                                <ul class="table-list tbody progressUl2">
                                    <li class="list d-flex">
                                        <div class="w50">
                                            No.
                                        </div>
                                        <div class="w500">
                                            <p>
                                                과정명/기수명
                                            </p>
                                            <p>
                                                YY-MM-DD ~ YY-MM-DD
                                            </p>
                                        </div>
                                        <div class="w100">
                                            <a href="#" class="w50 btn_normal btn_xsmall bgc_point"><span
                                                    class="h5">출력하기</span></a>
                                        </div>
                                    </li>
                                    <li class="list not fc_999">
                                        조회된 내용이 없습니다.
                                    </li>
                                </ul>
                            </div>
                        </li>
                        <li id="tab3" class="tab_body">
                            <div class="section_table">
                                <ul class="table-title thead d-flex">
                                    <li class="w50">No.</li>
                                    <li class="w450">과정명/기수명<br>학습기간</li>
                                    <li class="w100">수료증</li>
                                </ul>
                                <ul class="table-list tbody progressUl3">
                                    <li class="list d-flex">
                                        <div class="w50">
                                            No.
                                        </div>
                                        <div class="w500">
                                            <p>
                                                과정명/기수명
                                            </p>
                                            <p>
                                                YY-MM-DD ~ YY-MM-DD
                                            </p>
                                        </div>
                                        <div class="w100">
                                            <a href="#" class="w50 btn_normal btn_xsmall bgc_point"><span
                                                    class="h5">출력하기</span></a>
                                        </div>
                                    </li>
                                    <li class="list not fc_999">
                                        조회된 내용이 없습니다.
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
                <!-- 기존 레인보우사이트 pagination 복사 >> 확인 필요 -->
                <div class="section_pagination">
                    <ul class="d-flex justify_center" id="pagination">
                        <!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button" onclick="javascript:ilist('1')" name=""
                                    value="&lt&lt">
                            </li>
                        </c:if>

                        <!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock > 1}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.prevPage}')" name="" value="&lt">
                            </li>
                        </c:if>
                        <!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
                        <c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
                            <!-- **현재페이지이면 하이퍼링크 제거 -->
                            <c:choose>
                                <c:when test="${num == map.boardPager.curPage}">
                                    <li class="page-item">
                                        <input class="btn_default fc_point" type="button" name="" value="${num}">
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <input class="btn_default" type="button" onclick="ilist('${num}')" name=""
                                            value="${num}">
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curBlock <= map.boardPager.totBlock}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.nextPage}')" name="" value="&gt">
                            </li>
                        </c:if>

                        <!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
                        <c:if test="${map.boardPager.curPage <= map.boardPager.totPage}">
                            <li class="page-item">
                                <input class="btn_default" type="button"
                                    onclick="javascript:ilist('${map.boardPager.totPage}')" name="" value="&gt&gt">
                            </li>
                        </c:if>
                        </ul>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
</body>
</html>