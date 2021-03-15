<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script type="text/javascript">
    
    	var list;
    	
    	$(document).ready(function(){
    		setContent();
    		$.getScript('/resources/segroup/society/smtp/js/rainbow_script.js');
    		
        	var state = "${message}";
    		var session = "${session}";
        	if(state=="payComplete"){
        		alert("결제에 성공하셨습니다.");
        	}else if(state=="payError"){
        		alert("결제에 실패하셨습니다.");
        	}

    		if(session == "sessionExpire") {
    			alert("세션이 만료되었습니다. 계속하려면 다시 로그인 하세요.");
    		}
    	});
    	
    	function setContent() {
    		$.ajax({
   				type: 'POST'
   				, url: '/smtp/course/availableCourse'
   				, success: function(result) {
   					list = result;
   					setForm();
   				}
   			});
    	}
    	function getList() {
   			
    	}
    	//모집중인 과정
    	function setForm() {
    		var content = '';
    		if(list !== undefined && list.length != 0) {
    			$.each(list, function(index, item) {
    				content += '<div class="swiper-slide course course' + index + '">';
    				if(item.CATE_CODE == 'CATESEQ292' || item.CATE_CODE == 'CATESEQ293') {
	    				var link = "'/smtp/course/scmaster/scmaster-info','"+ item.COURSE_ID+"'"
    					content += 		'<a onclick="javascript:page_move('+link+')" href="javascript:void(0);">';
    					//content += 		'<a href="/smtp/course/scmaster/scmaster-info?course_id='+ item.COURSE_ID+'">';
    				} else if(item.CATE_CODE == 'CATESEQ294'){
    					if(item.COURSE_ID == 'c000000541') {
    						content += 		'<a href="/smtp/course/short-term/short-term-info?course_id='+ item.COURSE_ID+'">';	
    					} else {
    						var link = "'/smtp/course/short-term/short-term-info','"+ item.COURSE_ID+"'"
        					content += 		'<a onclick="javascript:page_move('+link+')" href="javascript:void(0);">';
    					}

    				}
    				content += 			'<div class="d-flex justify_between">';
    				content += 				'<div class="course-txt">';
    				content += 					'<div class="course-div">';
    				switch(item.CATE_CODE) {
    				case 'CATESEQ292':
    					content += '글로벌 S/W Master';
    					break;
    				case 'CATESEQ293':
    					content += 'Biz Expert(지역전문가)';
    					break;
    				case 'CATESEQ294':
    					content += '단기과정';
    					break;
    				}
    				content += 						'</div>';
    				content += 						'<div class="course-name fz20">';
    				content += 							 '과정명 : ' +  item.NAME;
    				content +=							'<br>';
    				content +=							'모집기간 : <br>' + item.APP_START_DATE + ' ~ ' + item.APP_END_DATE + '까지';
    				content += 						'</div>';
    				content += 					'</div>';
    				content += 				'<div class="course-img"><img src="' + item.URL_PATH + '" alt="' + item.NAME + '" style="max-width: 100%; max-height: 100%; width: 100%; height: 100%;"></div>';
    				content += 			'</div>';
    				content += 		'</a>';
    				content += '</div>';
    			});
    		}
			$('#availableDiv').html(content);
    	}
    	//post 페이지 이동
        function page_move(url, some_data) {
            var form = document.createElement("form");
            var input;

            form.action = url;
            form.method = "post";

            input = document.createElement("input");
            input.setAttribute("type", "hidden");
            input.setAttribute('name', "course_id");
            input.setAttribute("value", some_data);
            form.appendChild(input);
            
            document.body.appendChild(form);
            form.submit();
            form.remove();
        }
    </script>
</head>
<body>
    <div class="container_rainbow">
        <!-- header-include -->
        <%@include file="include/rainbow_header_basic.jsp"%>
		
        <div class="content" id="main">
        	<!-- 210209추가 Start -->
        	<div class="mainBannerWrapper swiper-container">
                <div class="d-flex justify_between swiper-buttonWrap">
                    <div class="swiper-button-prev img-icon chevron-left_pp btn_left"></div>
                    <div class="swiper-button-next img-icon chevron-right_pp btn_right"></div>
                </div>
                <div class="swiper-wrapper mainBannerWrap d-flex">
                    <div class="swiper-slide mainBanner mainBanner01">
                        <div class="background">
                            <div class="opacity_bg">
                                <div class="bannerTextWrap fc_fff">
                                    <div class="fz20">
                                        <span class="fc_pp">Blended-rainbow Program</span> Rainbow
                                    </div>
                                    <div class="fz40">다양한 전공과 ICT·AI를 융합,<br>
                                        <span class="fc_eg">21C 디지털 혁신</span>을 이끌어갈 글로벌 인재를 양성합니다.
                                    </div>
                                    <div class="horizonBar bgc_pp"></div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide mainBanner mainBanner02">
                        <a href="#">
                            <div class="background">
                                <div class="opacity_bg">
                                    <div class="bannerTextWrap">
                                        <div class="fz20 fc_pp">취업률 연간 90% 달성!</div>
                                        <div class="fz40 cNavy" onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526')">
                                            <span class="fc_pp">7기 SoftWare DevOps마스터</span>
                                            <br>일본AI 해외취업 연계과정
                                        </div>
                                        <div class="horizonBar bgc_pp"></div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <!-- 210209추가 End -->
            
        	<!-- 메인배너 -->
            <!-- <div class="background">
                <div class="opacity_bg">
                    
                    <div class="bannerTextWrap fc_fff">
                        <div class="fz20">
                            <span class="fc_pp">Off-line Program</span> Raninbow
                        </div>
                        <div class="fz40">다양한 전공과 ICT·AI를 융합,<br>
                            <span class="fc_eg">21C 디지털 혁신</span>을 이끌어갈 글로벌 인재를 양성합니다.
                        </div>
                        <div class="horizonBar bgc_pp"></div>
                    </div>
                </div>
            </div> -->
            
            <!-- 관심분야 -->
            <div class="fieldWrap fc_fff">
                <div class="title_barPoint fz40">어떤분야에 관심있으신가요?</div>
                <div class="field-tabMenu field-tabMenu-mobile">
                    <ul class="tabGroup-mobile">
                        <li>
                            <div class="mobile-tab">
                                <span class="fz18">SW·AI·클라우드</span>
                            </div>
                            <ul class="mobile-sub">
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000543" class="btn_normal">SWDO 마스터 사전학습반 </a></li>
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000538" class="btn_normal">AI개요와 딥러닝 개념</a></li>
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000539" class="btn_normal">코딩한 줄 없는 AI 활용</a></li>
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000535" class="btn_normal">입문 : 이제부터 파이썬<br>- 딥러닝을 위한 파이썬 기초</a></li>
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000537" class="btn_normal">Python으로 배우는 데이터 분석과 시각화</a></li>
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000536" class="btn_normal">Python 기반 데이터 사이언스 기초</a></li>
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000540" class="btn_normal">Python을 이용한 웹 스크래핑</a></li>
                            </ul>
                        </li>
                        <li>
                            <div class="mobile-tab">
                                <span class="fz18">외국어</span>
                            </div>
                            <ul class="mobile-sub">
                                <li><a href="/smtp/course/short-term/short-term-info?course_id=c000000541" class="btn_normal">일본취업을 위한 JPT & SJPT</a></li>
                            </ul>
                        </li>
                        <li>
                            <div class="mobile-tab">
                                <span class="fz18">96% ICT 취업캠퍼스</span>
                            </div>
                            <ul class="mobile-sub">
                                <li><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526')" class="btn_normal">SWDO 마스터</a></li>
<!--                                 <li><a href="https://newtradecampus.kita.net/page/user_job_CloudIT_apply?course_category=JOBA&course_code=1498&class_seq=41&site_id=KITAACAD&viewMode=detail#appView_courseDetailView">SCIT 마스터</a></li> -->
                                <li><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525')"class="btn_normal">SCIT 마스터</a></li>
                            </ul>
                        </li>
                        <li>
                            <div class="mobile-tab">
                                <span class="fz18">미국 인턴십</span>
                            </div>
                            <ul class="mobile-sub">
                                <li><a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000527')" class="btn_normal">미 융복합 SW인력 양성과정</a></li>
                            </ul>
                        </li>
                        <li>
                            <div class="mobile-tab">
                                <span class="fz18">Japan Biz Expert</span>
                            </div>
                            <ul class="mobile-sub">
                            	<li><a href="/smtp/course/short-term/short-term-info?course_id=c000000544" class="btn_normal">일본취업 스킬업</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="field-tabMenu">
                    <ul class="tabGroup d-flex justify_between">
                        <li>
                            <span class="fz18">SW·AI·클라우드</span>
                        </li>
                        <li>
                            <span class="fz18">외국어</span>
                        </li>
                        <li>
                            <span class="fz18">96% ICT 취업캠퍼스</span>
                        </li>
                        <li>
                            <span class="fz18">미국 인턴십</span>
                        </li>
                        <li>
                            <span class="fz18">Japan Biz Expert</span>
                        </li>
<!--                         <li> -->
<!--                             04&nbsp;<span class="fz18">미국 ICT융합직무</span> -->
<!--                         </li> -->
                    </ul>
                    <div class="subGroup">
                        <div class="tab-sub tab-sub01">
                            <div class="d-flex">
                                <ul class="courseList-tabWrap tabGroup">
                                    <li class="btn_normal">SWDO 마스터 사전학습반</li>
                                    <li class="btn_normal">AI개요와 딥러닝 개념</li>
                                    <li class="btn_normal">코딩한 줄 없는 AI 활용</li>
                                    <li class="btn_normal">입문 : 이제부터 파이썬<br>딥러닝을 위한 파이썬 기초</li>
                                    <li class="btn_normal">Python으로 배우는 데이터 시각화</li>
                                    <li class="btn_normal">Python 기반 데이터 사이언스 기초</li>
                                    <li class="btn_normal">Python을 이용한 웹 스크래핑</li>
                                </ul>
                                <div class="courseList-subWrap subGroup">
                                    <div class="courseList-sub tab-sub courseList-sub01">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
<!--                                                 	<img src="/upload/course/mainImg/2021010617412648.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;"> -->
                                                    <div class="courseTitle fz20 fc_fff">
                                                        SWDO 마스터<br>사전학습반
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-01-18 부터 ~ 2021-02-19 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육장소</div>
                                                <div class="seg-list fz16">
                                                	광주 무역회관
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	IT반: 60,000원 / 일본어반: 110,000원 / 종합반: 150,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000543')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    <div class="courseList-sub tab-sub courseList-sub02">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                	<img src="/upload/course/mainImg/2020122924831146.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;">
<!--                                                     <div class="courseTitle fz20 fc_fff"> -->
<!--                                                         AI개요와 딥러닝 개념 -->
<!--                                                     </div> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-03-22 부터 ~ 2021-03-26 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육방법</div>
                                                <div class="seg-list fz16">
                                                	원격 비대면 강의
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	30,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000538')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    <div class="courseList-sub tab-sub courseList-sub03">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                	<img src="/upload/course/mainImg/2020122974107101.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;">
<!--                                                     <div class="courseTitle fz20 fc_fff"> -->
<!--                                                         코딩한 줄 없는 AI 활용 -->
<!--                                                     </div> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-03-29 부터 ~ 2021-04-09 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육방법</div>
                                                <div class="seg-list fz16">
                                                	원격 비대면 강의
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	50,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000539')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    <div class="courseList-sub tab-sub courseList-sub04">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                	<img src="/upload/course/mainImg/2020122974661446.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;">
<!--                                                     <div class="courseTitle fz20 fc_fff"> -->
<!--                                                         입문 : 이제부터 파이썬<br>- 딥러닝을 위한 파이썬 기초 -->
<!--                                                     </div> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-03-29 부터 ~ 2021-04-09 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육방법</div>
                                                <div class="seg-list fz16">
                                                	원격 비대면 강의
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	50,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000535')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    <div class="courseList-sub tab-sub courseList-sub05">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                	<img src="/upload/course/mainImg/2020122997552581.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;">
<!--                                                     <div class="courseTitle fz20 fc_fff"> -->
<!--                                                         Python으로 배우는<br>데이터 분석과 시각화 -->
<!--                                                     </div> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-05-17 부터 ~ 2021-05-21 까지
                                                	<br>
                                                	(5월 19일 부처님 오신날 휴강)
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육방법</div>
                                                <div class="seg-list fz16">
                                                	원격 비대면 강의
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	50,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000537')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    <div class="courseList-sub tab-sub courseList-sub06">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                	<img src="/upload/course/mainImg/2020122963527171.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;">
<!--                                                     <div class="courseTitle fz20 fc_fff"> -->
<!--                                                         Python 기반<br>데이터 사이언스 기초 -->
<!--                                                     </div> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-05-31 부터 ~ 2021-06-08 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육방법</div>
                                                <div class="seg-list fz16">
                                                	원격 비대면 강의
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	50,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000536')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    <div class="courseList-sub tab-sub courseList-sub07">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                	<img src="/upload/course/mainImg/2020122988284586.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;">
<!--                                                     <div class="courseTitle fz20 fc_fff"> -->
<!--                                                         Python을 이용한<br>웹 스크래핑 -->
<!--                                                     </div> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-05-24 부터 ~ 2021-05-28 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육방법</div>
                                                <div class="seg-list fz16">
                                                	원격 비대면 강의
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	50,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000540')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    
                                    
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub tab-sub02">
                        	<div class="d-flex">
                                <ul class="courseList-tabWrap tabGroup">
                                    <li class="btn_normal">일본취업을 위한 JPT & SJPT</li>
                                </ul>
                                <div class="courseList-subWrap subGroup">
                                    <div class="courseList-sub tab-sub courseList-sub01">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                	<img src="/upload/course/mainImg/2020122993650209.jpg" style="max-height: 100%; max-width: 100%; width: 100%; height: 100%;">
<!--                                                     <div class="courseTitle fz20 fc_fff"> -->
<!--                                                         일본취업을 위한<br>JPT & SJPT -->
<!--                                                     </div> -->
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-01-18 부터 ~ 2021-02-19 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육장소</div>
                                                <div class="seg-list fz16">
                                                	서울 코엑스
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	JPT반: 110,000원 / SJPT반: 120,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="location.href='/smtp/course/short-term/short-term-info?course_id=c000000541'"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub tab-sub03">
                            <div class="d-flex">
                                <ul class="courseList-tabWrap tabGroup">
                                    <li class="btn_normal">SWDO 마스터</li>
                                    <li class="btn_normal">SCIT 마스터</li>
                                </ul>
                                <div class="courseList-subWrap subGroup">
                                    <div class="courseList-sub tab-sub courseList-sub01">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
<!--                                                 	<img src="/upload/course/mainImg/2021010624175358.jpg" style="max-height: 100%; max-width: 100%;"> -->
                                                    <div class="courseTitle fz20 fc_fff">
                                                        SoftWare DevOps 마스터<br>광주/전남특화 - 글로벌 SW인재양성과정
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-04-12 부터 ~ 2021-12-06 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육장소</div>
                                                <div class="seg-list fz16">
                                                	광주 무역회관
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	1,350,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526')"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                    <div class="courseList-sub tab-sub courseList-sub02">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
<!--                                                 	<img src="/upload/course/mainImg/2020122924831146.jpg" style="max-height: 100%; max-width: 100%;"> -->
                                                    <div class="courseTitle fz20 fc_fff">
                                                        SMART Cloud IT 마스터<br>글로벌 SW인재양성과정
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-03-22 부터 ~ 2021-12-03 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육장소</div>
                                                <div class="seg-list fz16">
                                                	서울 코엑스
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	2,000,000원
                                                </div>
                                            </div>
                                            <div class="btnInfoWrap d-flex"> 
                                                <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525')">
                                            		<a href="javascript:void(0);">과정 상세보기</a>
                                            	</div>
                                                <div class="infoMsgWrap d-flex">
                                                	<div class="img-icon info-circle_pp margin-right10"></div>
                                                    <div class="message h5 fc_pp">해당 과정은 KITA-SES 공동운영과정으로, 지원신청은 무역아카데미 홈페이지에서 가능합니다.</div>
                                                </div>
                                            </div>
                                           <!--  <div class="btn_normal btn_large btn_eg courseDetail" onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525')">
                                            <a href="javascript:void(0);">과정 상세보기</a>
                                            	<a href="https://newtradecampus.kita.net/page/user_job_CloudIT_apply?course_category=JOBA&course_code=1498&class_seq=41&site_id=KITAACAD&viewMode=detail#appView_courseDetailView">과정 상세보기</a>
                                            </div> -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub tab-sub04">
                        	<div class="d-flex">
                                <ul class="courseList-tabWrap tabGroup">
                                    <li class="btn_normal">미 융복합 SW인력 양성과정</li>
                                </ul>
                                <div class="courseList-subWrap subGroup">
                                    <div class="courseList-sub tab-sub courseList-sub01">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                    <div class="courseTitle fz20 fc_fff">
                                                    	미 융복합 SW인력 양성과정
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-05-10 부터 ~ 2021-08-02 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육장소</div>
                                                <div class="seg-list fz16">
                                                	광주 무역회관
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	700,000원(비자수속비용 별도: $4,000~$4,500)
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" ㅇ><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-sub tab-sub05">
                        	<div class="d-flex">
                                <ul class="courseList-tabWrap tabGroup">
                                    <li class="btn_normal">일본취업 스킬업</li>
                                </ul>
                                <div class="courseList-subWrap subGroup">
                                    <div class="courseList-sub tab-sub courseList-sub01">
                                        <div class="tab-imgWrap">
                                            <div class="background">
                                                <div class="opacity_bg">
                                                    <div class="courseTitle fz20 fc_fff">
                                                    	일본취업 스킬업
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-segWrap">
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육기간</div>
                                                <div class="seg-list fz16">
                                                	2021-04-19 부터 ~ 2021-06-01 까지
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육장소</div>
                                                <div class="seg-list fz16">
                                                	서울 코엑스
                                                </div>
                                            </div>
                                            <div class="segmentWrap">
                                                <div class="seg-title fz20">교육비용</div>
                                                <div class="seg-list fz16">
                                                	500,000원
                                                </div>
                                            </div>
                                            <div class="btn_normal btn_large btn_eg courseDetail" onclick="location.href='/smtp/course/short-term/short-term-info?course_id=c000000544'"><a href="javascript:void(0);">과정 상세보기</a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 모집중인 과정 -->
            <!-- <div class="courseWrapper swiper-container">
                <div class="d-flex justify_between">
                    <div class="swiper-button-prev img-icon chevron-left_pp btn_left"></div>
                    <div class="title_barPoint_wh fz40">모집중인 과정</div>
                    <div class="swiper-button-next img-icon chevron-right_pp btn_right margin-left5"></div>
                </div>
                <div class="swiper-wrapper courseWrap d-flex" id="availableDiv"></div>
            </div> -->

			<!-- 배너영역 -->
            <div class="bannerWrapper">
                <!-- <div class="title_barPoint_wh fz40"></div> -->
                <div class="d-flex justify_between">
                    <a href="/smtp/course/schedule">
                        <div class="bannerWrap banner01"></div>
                        <!-- <div class="bannerTxt">2021년 연간 교육 일정을 확인하실 수 있습니다.</div> -->
                    </a>
                    <a href="http://doitcampus.com/">
                        <div class="bannerWrap banner02"></div>
                        <!-- <div class="bannerTxt">나에게 맞는 강의가 궁금하다면?<br>두잇캠퍼스에서 확인해보세요.</div> -->
                    </a>
                    <a href="https://www.softsociety.net/smtp/course/short-term/short-term-info?course_id=c000000541">
                        <div class="bannerWrap banner03"></div>
                        <!-- <div class="bannerTxt">아직 자격증이 없으신가요?<br>일본취업 필수과정을 확인해보세요.</div> -->
                    </a>
                </div>
            </div>
            
			<!-- 바로가기배너영역 210209 추가 Start -->
            <div class="linkBannerWrapper">
                <div class="linkBannerWrap">
                    <div class="d-flex flexWrap">
                        <!-- 모집중인 과정 -->
                        <div class="linkBanner link_banner01" style="cursor: pointer;">
                            <a onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526')"></a>
                        </div>
                        <!-- 공지사항 -->
                        <div class="linkBanner link_banner02">
                           <a href="/smtp/community/sub04-01"></a> 
                        </div>
                        <!-- Q&A -->
                        <div class="linkBanner link_banner03">
                            <a href="/smtp/support/sub04-02"></a>
                        </div>
                        <!-- 네이버블로그 바로가기 -->
                        <div class="linkBanner link_banner04">
                            <a href="https://blog.naver.com/scitmaster"></a>
                        </div>
                        <!-- 유튜브 채널 바로가기 -->
                        <div class="linkBanner link_banner05">
                            <a href="https://www.youtube.com/channel/UCCsiCEQ8g6PacQLuJEYEWpw?view_as=subscriber"></a>
                        </div>
                        <!-- 과정후기 보러가기 -->
                        <div class="linkBanner link_banner06">
                            <a href="/smtp/community/sub04-05"></a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 바로가기배너영역 210209 추가 End -->
            
            <!-- 주요취업처 -->
<!--             <div class="employmentWrap"> -->
<!--                 <div class="title_barPoint_wh fz40"> -->
<!--                     취업연계과정 주요 취업처 -->
<!--                 </div> -->
<!--                 <div class="empImgWrap d-flex flexWrap"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg01.png" alt="" class="empImg"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg02.png" alt="" class="empImg"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg03.png" alt="" class="empImg"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg04.png" alt="" class="empImg"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg05.png" alt="" class="empImg"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg06.png" alt="" class="empImg"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg07.png" alt="" class="empImg"> -->
<!--                     <img src="/resources/segroup/society/smtp/img/empImg08.png" alt="" class="empImg"> -->
<!--                 </div> -->
                <!-- <img src="/resources/segroup/society/smtp/img/employment-img.png" alt="" class="employmentImg"> -->
<!--             </div> -->
        </div>
        <%@include file="include/common_footer_rainbow.jsp"%>
</body>
</html>