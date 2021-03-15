<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>     
<!DOCTYPE html>
<html lang="ko">

<script src="<c:url value="/resources/lms/js/jquery3.4.1.js" />"></script>
<!-- Pagination을 위한 js -->
<script type="text/javascript" src="/resources/js/jquery.twbsPagination.js"></script>

<script>

	$(function(){
		//페이징 처리를 위한 카테고리 설정 임시 변수
		var tmp_cate = "";
		var tmp_parent_cate = "";
		
		//과정리스트 가져오기 끝		
		function getCourseList(parent_cate_opt, cate_opt, search, display_list){

			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				url		: "/lms/course/toeflList",
				data    : {
					"startPage" : startPage
					,"display_list" : display_list
				},
				success	: function(data) {
					
					var content = "";
	
					$.each(data, function(index, courseList){
						
						content += '<li class="class-list d-flex text-center' + ' load-sub01-01-01">';
						content +=		'<div class="c-ttl">';
						content += 			'<a class="d-flex">';
						content += 				'<img src="' + courseList.photo_url + '" alt="' + courseList.TOEFL_TITLE + '" class="c-img">';
						content += 					'<div class="class-title-wrap margin-left10">';
						content += 						'<div class="fz16 text-over txt-ov-2" data-value="' + courseList.TOEFL_ID + '">' + courseList.TOEFL_TITLE + '</div>';
						content += 					'</div>';
						content += 			'</a>';
						content += 		'</div>';
						content += 		'<div class="c-ctt c-price">';
						if(courseList.price != 0){
							content += 				'<p class="classPrice" data-value="' + courseList.TOEFL_PRICE + '">' + courseList.TOEFL_PRICE.toLocaleString('en') + '원</p>';							
						} else {							
							content += 				'<p class="classPrice" data-value="' + courseList.TOEFL_PRICE + '">무료</p>';							
						}

						content += 			'</div>';
						content += 		'</div>';
						
						content += 		'<div class="c-ctt"><a class="btn_point btn_xsmall modal-popup">시험신청</a>';
						content += 		'</div>';
						content += '</li>';

					});

					//가져온 결과값이 없으면 검색결과가 없습니다를 출력한다.
					if(content==""){
						content += '<li class="listAndwrap"><div class="class-list not"><p>검색 결과가 없습니다.</p></div></li>';
					}
					
					$('.class-list-wrap.load-data').html(content);

					//뿌려주고 나서는 해당 페이지 내의 검색을 위한 세팅을 해주어야 한다.
					$('#category_opt').val(parent_cate_opt);
					$('#parent_category_opt').val(cate_opt);

					/* ---------------------------------------------------모달작업--------------------------------------------------- */
				    // modal-popup layer
				    $('.modal-popup').click(function() {
				    	var index = $('.modal-popup').index(this);
				    	/* 팝업정보 세팅 */
				    	var classNm = $(this).parent().parent().children('.c-ttl').find('div.txt-ov-2').html();
				    	var toefl = $(this).parent().parent().children('.c-ttl').find('div.txt-ov-2').attr("data-value");
				    	$("#merToefl").val(toefl);
						var classPrice = $('.c-price').children('.classPrice').eq(index).html();
				    	var realPrice = $('.c-price').children('.classPrice').eq(index).attr('data-value');
/* 				    	var discountPrice = $(this).parent().parent().children('.c-price').children('.tableWrap').children('.discountPrice').html(); */
				    	
				    	/*결재정보 세팅*/
				    	$.ajax({
							contentType : "application/json",
							dataType : "json",
							type	: "get",
							url		: "/lms/course/makesignature",
							data    : {
										price:realPrice
									  },
							success	: function(data) {
								$('input[name$="price"]').val(realPrice);	
								$('input[name$="goodname"]').val(classNm);
								$('input[name$="mid"]').val(data.mid);
								$('input[name$="oid"]').val(data.oid);
								
							}
						});
				    	
				    	var user_id = '${sessionScope.user_id}';

				    	if(user_id==''||user_id==null){
				    		alert('로그인이 필요합니다.');
							document.location.href = "/lms/user/sub00-01";
				    		return;
				    	}

						//유저 정보 가져오기
						$.ajax({
							contentType : "application/json",
							dataType : "json",
							type	: "get",
							url		: "/lms/course/getUserInfo",
							data    : {
								"user_id" : user_id
							},
							success	: function(userInfo) {

								//-----------------모달 기본 정보 세팅--------------------//
								$('.class-name').html(classNm);
								$('.class-price').html(classPrice);
								
								$('.class-pay-price').attr('data-value', realPrice);
								$('.class-pay-price').html(classPrice);
/* 								if(discountPrice.isNaN || discountPrice == '0'){
									$('.class-pay-price').html(classPrice);																		
								} else{
									$('.class-pay-price').html(discountPrice);									
								} */
								//-----------------모달 기본 정보 세팅--------------------//
						        $('.user_name').html(userInfo.user_nm);
						        $('#signNm').html(userInfo.user_nm);
								$('.user_birth').html(userInfo.user_birth);
								
								//------------------모달에 회원정보 불러오기-------------------//
								$('#getMyInfo').on('click', function(){
									/* 모달 내의 정보를 띄우는 세팅 */

/* 									모달에 성별표시 안하기로 결정
									if(userInfo.user_sex=='A0000'){
										$("input:radio[name='user_sex']:radio[value='A0000']").prop("checked",true);		
									} else{
										$("input:radio[name='user_sex']:radio[value='A0001']").prop("checked",true);		
							        } */
									
							        $('.user_email').val(userInfo.user_email);
							        $('.user_phone').val(userInfo.user_phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));											        
									$('.user_belong_to').val(userInfo.user_belong_to);
							        
							        
						        	$('#post_code').val(userInfo.user_zipcode);
						        	$('#addr1').val(userInfo.user_addr1);
									$('#addr2').val(userInfo.user_addr2);

								});
								//------------------모달에 회원정보 불러오기-------------------//

								getPointInfo(user_id);
							},
							error	: function(request, status, error) {
								alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
							}						
						});

				    	// 모달 열기
				        $('html, body').addClass("not-scroll");

				        /* 모달 내의 정보를 띄우는 세팅 끝*/
				       				        
				        $('.modal').show()

				        // 모달 >> 탭 기능
				        var $modaltab = $('.section div.class-tabMenu>.modal-tabGroup>li'),
				            $modalsub = $('.section div.class-tabMenu>.modal-subGroup>div'),
				            i = 0;

				        $modaltab.on('click', function() {
				            i = $(this).index();
				            console.log(i);
				            $modalsub.hide();
				            $modalsub.eq(i).show();
				            $('.section .modal-tabGroup>li*').removeClass('active');
				            $(this).addClass('active');
				        });
				        // 모달 >> 탭 기능 끝

				        //모달 열면 탭 활성화 초기화(index 0 = active)
				        $('.modal-tabGroup>li').removeClass('active');
				        $('.modal-tabGroup>li:first').addClass('active');
				        $('.modal-subGroup>div').hide();
				        $('.modal-subGroup>div:first').show();
				        //모달 열면 탭 활성화 초기화(index 0 = active) 끝
				    });

				    $('.modal .close-modal').click(function() {
				        // 모달 닫기
				        $('html, body').removeClass("not-scroll");
				        $('#agree01').prop('checked', false);
				        $('#agree02').prop('checked', false);				        
				        $('.modal').hide();

				        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active)
				        $('.section .tabGroup>li:first').addClass('active');
				        $('.section .subGroup>div:first').show();
				        //모달 닫으면 기존 탭 활성화 초기화(index 0 = active) 끝
				    });
				    //modal-popup layer 끝					
					/* ---------------------------------------------------모달작업--------------------------------------------------- */
					
					/*	페이징 처리를 위한 함수호출 */
					pagingFunc(parent_cate_opt, cate_opt, search, display_list);
				},
				error	: function(request, status, error) {
					//alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}
				
			});

		}
		//과정리스트 가져오기 끝

		$('.parent_category').on('click', function(){
	    	var parent_category_opt = $(this).attr('data-value');
	    	
	    	
	    	$('#division_menu').html(parent_category_opt);
 			$('#pagination').twbsPagination('destroy');		 
			getCourseList(parent_category_opt, "", "", "");
			tmp_parent_cate = parent_category_opt;
			tmp_cate = "";
		});		
		
		$('.category').on('click', function(){
	    	var category_opt = $(this).attr('data-value');
 			$('#pagination').twbsPagination('destroy');		 
	    	getCourseList("", category_opt, "","");
			tmp_cate = category_opt;
			tmp_parent_cate = "";	
		});		

		$('#filters').on('click', function(){
			$('#pagination').twbsPagination('destroy');		 

     		$('#startPage').val('1');                	
			var category_opt = $('#category_opt').val();
			var parent_category_opt = $('#parent_category_opt').val();
			
			var search = $('#keyWord').val();
			
			var icon_array = new Array();
			//검색버튼 위의 라디오 버튼 체크 여부 확인
			if($('input:checkbox[id="filter-RL"]').is(":checked")){
				 icon_array.push('1');	
			}
			if($('input:checkbox[id="filter-SW"]').is(":checked")){
				 icon_array.push('2');	
			}
			if($('input:checkbox[id="filter-complete"]').is(":checked")){
				 icon_array.push('3');	
			}
			
			var display_list = "";
			for(var i = 0; i < icon_array.length; i++){
				display_list += icon_array[i];
				if(i!=icon_array.length-1){
					display_list += ",";
				}
			}
			
			getCourseList(category_opt,parent_category_opt, search, display_list);
		});
		
		$('#searchBtn').on('click', function(){
 			$('#pagination').twbsPagination('destroy');		 

     		$('#startPage').val('1');                	
			var category_opt = $('#category_opt').val();
			var parent_category_opt = $('#parent_category_opt').val();
			
			var search = $('#keyWord').val();
			
			var icon_array = new Array();
			//검색버튼 위의 라디오 버튼 체크 여부 확인
			if($('input:checkbox[id="filter-RL"]').is(":checked")){
				 icon_array.push('1');	
			}
			if($('input:checkbox[id="filter-SW"]').is(":checked")){
				 icon_array.push('2');	
			}
			if($('input:checkbox[id="filter-complete"]').is(":checked")){
				 icon_array.push('3');	
			}
			
			var display_list = "";
			for(var i = 0; i < icon_array.length; i++){
				display_list += icon_array[i];
				if(i!=icon_array.length-1){
					display_list += ",";
				}				
			}
			
			getCourseList(category_opt,parent_category_opt, search, display_list);
			
		});

		function pagingFunc(parent_cate_opt, cate_opt, search, display_list){

			var startPage = $('#startPage').val();
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				url		: "/lms/course/toeflpageInfo",
				data    : {
					"startPage" : startPage
					,"display_list" : display_list
				},
				success	: function(data) {

					var totalPages = data.totalPages;
					var visiblePages = data.visiblePages;
					var startPage = Number(data.startPage) + 1;

					pagination(totalPages, visiblePages, startPage);		
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}						
			});
		}
		
		function pagination(totalPages, visiblePages, startPage){

			if(totalPages != 0 && totalPages != null){
		    	$('#pagination').twbsPagination({
			        totalPages: totalPages,
			        visiblePages: visiblePages,
			        startPage: startPage,
			        first : "",
 			        prev : '<a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a>',
					next : '<a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a>',
/* 
					prev : "«",
					next : "»",
 */
					last : "",
					
					
			        initiateStartPageClick : false,
			        onPageClick: function (event, page) {
			            $('#startPage').val(page);

			            var category_opt = tmp_cate;
						var parent_category_opt = tmp_parent_cate;
						var search = $('#keyWord').val();
				    	
 						var icon_array = new Array();
						//검색버튼 위의 라디오 버튼 체크 여부 확인
						if($('input:checkbox[id="filter-RL"]').is(":checked")){
							 icon_array.push('1');	
						}
						if($('input:checkbox[id="filter-SW"]').is(":checked")){
							 icon_array.push('2');	
						}
						if($('input:checkbox[id="filter-complete"]').is(":checked")){
							 icon_array.push('3');	
						}
						
						var display_list = "";
						for(var i = 0; i < icon_array.length; i++){
							display_list += icon_array[i];
							if(i!=icon_array.length-1){
								display_list += ",";
							}
						}
						
						getCourseList(parent_category_opt, category_opt, search, display_list);
			            
			        }
		    	});
		 	};
		 	
		 	//pagination css 포맷에 맞게 설정하는 작업		
		 	$('.page-item').children().addClass('num');
			$('.page-item.active').children().addClass('active'); 
/* 		 	if(startPage=="1"){
 		 	 	$(".num:contains('1')").trigger("click");
	 	 	}		 	 */

		}
		
    	function getPointInfo(user_id){

			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "get",
				url		: "/lms/course/getPointInfo",
				data    : {
					"user_id" : user_id
				},
				success	: function(userPoint) {
					$('.user_point').attr('data-value', userPoint.BALANCE);
					$('.user_point').html(userPoint.BALANCE.toLocaleString('en'));
				},
				error	: function(request, status, error) {
					alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
				}						
			});    		
    		
    	}
		
    	//이곳이 사용되는 이유는 다음과 같다.
    	//header에서 외국어 하위 탭에서 과목을 선택할 경우
    	//과정상세페이지에서 leftmenu의 과목을 선택할 경우
    	//ajax 페이징처리와 별개로 페이지가 이동하는 경우에 해당되므로, 이와 같은 코드로 해결

    	var parent_menu = "${parent_menu}";
		var son_menu = "${son_menu}";

		if(parent_menu!=''&&parent_menu!=null){
			$('[data-value="' + parent_menu + '"]').trigger('click');		
		} else if(son_menu!=''&&son_menu!=null){
			$('[data-value="' + son_menu + '"]').trigger('click');		
    	} else {
    		//화면 첫 로드시에 전체 과정 리스트를 출력
    		getCourseList();
    	}
	});

</script>

<body>
	<div class="header_filterWrap">
		<form action="">
			<div class="header_filter filterWrap d-flex justify_end">
				<h5 class="h5 margin-right5">조건 선택</h5>
				<ul class="filters d-flex" id="filters">
					<li class="d-flex">
						<input type="checkbox" value="RL" id="filter-RL"> 
						<label class="label new" for="filter-RL">Half(R/L)</label>
					</li>
					<li class="d-flex">
						<input type="checkbox" value="SW" id="filter-SW"> 
						<label class="label recommend" for="filter-SW">Half(S/W)</label>
					</li>
					<li class="d-flex">
						<input type="checkbox" value="complete" id="filter-complete"> 
						<label class="label popular" for="filter-complete">Complete</label>
					</li>
				</ul>
			</div>
		</form>
	</div>
	
    <div class="d-flex floatR">
		<div class="class-search-down d-flex">
<%-- 			<input type="text" class="cusPHIn input" id="keyWord" value="${param.search}" placeholder="검색어를 입력해주세요."> --%> 
			<input type="hidden" id="parent_category_opt" value="${parent_category_opt}"> <input type="hidden" id="category_opt" value="${category_opt}">
			<c:if test="${startpage != '' && startpage != null}">
				<input type="hidden" id="startPage" name="startPage" value="${startPage}">
			</c:if>
			<c:if test="${startpage == '' || startpage == null}">
				<input type="hidden" id="startPage" name="startPage" value="1">
			</c:if>

			<!-- 검색버튼 -->
<!-- 			<button type="button" class="button btn-wh img-icon search" id="searchBtn"></button> -->
		</div>
	</div>

   <!-- 과정목록 -->
	<div class="class-listWrap">
		<!-- 과정목록 : 제목 -->
		<ul class="class-list-title d-flex">
			<li class="c-ttl">시험명</li>
			<li class="c-ctt">시험비</li>
			<li class="c-ctt">시험신청</li>
		</ul>
		<!-- 과정목록 : 내용
                    - 목록 추가시 하위카테고리 분류하여
                    li에클래스로 지정 : load-sub0$-0$-0$)
                -->
		<ul class="class-list-wrap load-data"></ul>
	</div>
	
	<div class="modal">
        <div class="modal-layer"></div>
        <div class="modal-content">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../modal/modal-sub02-01-01.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../modal/modal-sub02-01-02.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../modal/modal-sub02-01-03.jsp"%>
        </div>
        <div class="modal-content" style="display:none">
            <!-- modal 수강신청 1단계 include -->
              <%@include file="../modal/modal-sub02-01-04.jsp"%>
        </div>
    </div>
</body>

</html>
