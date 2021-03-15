<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>     

<!DOCTYPE html>
<html lang="ko">

<head>
    <script type="text/javascript">
        $(function() {
        	
        	/* model값을 바탕으로 대,중,소 메뉴 구성을 변수화 시작 */
        	var parentList = new Array();
        	var sonList = new Array();

        	<c:forEach var="courseList" items="${courseList}">
        	if(${courseList.grand == "JOB-Market"}){
	        		sonList.push({
            			parent : "${courseList.parent}",
            			son : "${courseList.son}"
            		});
            		if(!parentList.includes("${courseList.parent}")){
    					parentList.push("${courseList.parent}")
    				}        	        	        			
        		}
        	</c:forEach>

			var menuHtml = "";
			
			
			$.each(parentList, function(index, parent){
				
				menuHtml += '<li class="lnb">';
				menuHtml += '<a class="parent_category" data-value="'+ parent +'">' + parent + '<div class="img-icon angle-right angle-down"></div></a>';
                menuHtml += '<ul class="menu-sub">';

                $.each(sonList, function(index, parSon){

                	if(parent == parSon.parent){						
                		menuHtml += '<li><a class="category" data-value="'+ parSon.son +'">';
                		menuHtml += '<div class="img-icon caret-right"></div>' + parSon.son ;
                		menuHtml += '</a></li>';
                	}                	                	
                });                
                menuHtml += '</ul>';
                menuHtml += '</li>';   	            
			});
        	
			$(menuHtml).insertAfter('.menuList');
        	/* model값을 바탕으로 대,중,소 메뉴 구성을 변수화 끝 */
        	


			var moveFlag = "${moveFlag}";
        	
        	
        	
            $('.sub-nav .lnb>a').each(function() {
                $(this).on('click', function(){

					setDefault();
                	
                	if(moveFlag!=''&&moveFlag!=null){

             			var clicked_parent = $(this).attr('data-value');
						document.location.href = "/lms/course/it/sub01-01?parent_menu=" + clicked_parent;
             			
             			
             		}   	
					//먼저 전체 active 상태를 해지
                	$('.sub-nav .lnb>a').removeClass('active');	
                	$('.sub-nav .lnb>a').next().css({"display":"none"});	
					$('.img-icon.active').removeClass('active');
                	$('.category.active').removeClass('active');
                	//이후 선택한 객체를 active화
                	$(this).addClass('active');
                    $(this).next().css({"display": "block"});
                    

                
                });
            });            
            
 				
            $('.sub-nav .menu-sub a').each(function() {
                $(this).on('click', function(){

					setDefault();
             		
             		if(moveFlag!=''&&moveFlag!=null){

             			var clicked_son = $(this).attr('data-value');
						document.location.href = "/lms/course/it/sub01-01?son_menu=" + clicked_son;

             		
             		}   	
					//먼저 전체 active 상태를 해지
                    $('.sub-nav .menu-sub a').removeClass('active').find('div').removeClass('active');
                    $('.sub-nav .menu-sub a').parent().parent().prev().removeClass('active');					
                    $('.sub-nav .menu-sub a').parent().parent().css({"display": "none"});                	
                    //이후 선택한 객체를 active화
                    $(this).addClass('active').find('div').addClass('active');
                    $(this).parent().parent().prev().addClass('active');
                    $(this).parent().parent().css({"display": "block"});                	
                });
            });
            

            function setDefault(){
            	//페이징 처리를 첫페이지로 설정
            	$('#startPage').val('1');   

            	//검색조건을 초기화 시작.
            	$('#filter-new').prop('checked', false);
            	$('#filter-recommend').prop('checked', false);
            	$('#filter-popular').prop('checked', false);
            	$('#filter-book').prop('checked', false);
            	$('#filter-sale').prop('checked', false);
            	$('#keyWord').val('');
            	
            	//검색조건을 초기화 끝.
            	
            }            
            
            
/*                  */
            
/* 안쓰는 기존 구문들             */
/*
        	var path = window.location.href;
            // because the 'href' property of the DOM element is the absolute path
             $('.sub-nav .lnb>a').each(function() {
                if (this.href === path) {
                    $(this).addClass('active');
                    $(this).next().css({
                        "display": "block"
                    });
                }
            }); 
*/            
/* 			 $('.sub-nav .lnb>a').on('click', function() {
			 	$(this).addClass('active');
			 	$(this).next().css({
                "display": "block"});
		 });
*/          

        });
    </script>
</head>

<body>
    <div class="sub-nav">
        <ul class="sub-navGroup">
            <li class="gnb sub05 bgc_point fz18 menuList"><a href="/lms/course/jobmarket/sub06-01" style="background: rgba(128,181,155,.5)">JOB-Market</a></li>
			
			<!-- 가공된 메뉴목록이 들어갈 자리 -->

<!-- 기존 코드 
            <li class="lnb">
                <a class="" href="/lms/course/foreign/sub02-03">중국어<div class="img-icon angle-right angle-down"></div></a>
                <ul class="menu-sub">
                    <li><a class="sub02-03-01"href="/lms/course/foreign/sub02-03-01">
                            <div class="img-icon caret-right"></div>문법/어휘
                        </a></li>
                    <li><a class="sub02-03-02"href="/lms/course/foreign/sub02-03-02">
                            <div class="img-icon caret-right"></div>비즈니스
                        </a></li>
                    <li><a class="sub02-03-03"href="/lms/course/foreign/sub02-03-03">
                            <div class="img-icon caret-right"></div>시험대비
                        </a></li>
                    <li><a class="sub02-03-04"href="/lms/course/foreign/sub02-03-04">
                            <div class="img-icon caret-right"></div>일반
                        </a></li>
                    <li><a class="sub02-03-05"href="/lms/course/foreign/sub02-03-05">
                            <div class="img-icon caret-right"></div>회화
                        </a></li>
                </ul> 
            </li>
 -->
        </ul>
    </div>
</body>

</html>
