<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    <script type="text/javascript">
    
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
            <%@include file="../include/rainbow_header_basic.jsp"%>

        <div class="content sub-content content_schedule" id="main">
            <div class="background">
                <div class="opacity_bg">
                    <!-- 메인배너 -->
                    <div class="bannerTextWrap fc_fff">
                        <div class="fz20">
                            <span class="fc_pp">Off-line Program</span> Rainbow
                        </div>
                        <div class="fz40">
                            2021년 <span class="fc_eg">레인보우</span> 연간 교육 일정
                        </div>
                        <div class="horizonBar bgc_pp"></div>
                    </div>
                </div>
            </div>
            <div class="scheduleWrapper">
                <table class="table">
                    <thead class="thead">
                        <tr>
                            <th>과정</th>
                            <th>1월</th>
                            <th>2월</th>
                            <th>3월</th>
                            <th>4월</th>
                            <th>5월</th>
                            <th>6월</th>
                            <th>7월</th>
                            <th>8월</th>
                            <th>9월</th>
                            <th>10월</th>
                            <th>11월</th>
                            <th>12월</th>
                        </tr>
                    </thead>
                    <tbody class="tobdy">
                        <tr class="">
                            <th rowspan="3">
                                국내 AI/빅데이터 과정
                            </th>
                            <td colspan="2" class="bg01">
                                <a href="">
                                    SMART Cloud IT MASTER 사전학습반
                                    <br>교육기간 : 01.25~02.26<br>교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td colspan="2" class="bg02" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000535');">
                            	<a href="javascript:void(0);">
                                     입문 : 이제부터 파이썬 <br>딥러닝을 위한 파이썬 기초
                                    <br>교육기간 : 03.29~04.09<br>교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td class="bg04" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000537');">
                            	<a href="javascript:void(0);">
                                     Python으로 배우는 데이터 분석과 시각화
                                    <br>교육기간 : 05.17~05.21<br>교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td></td>
                            <td></td>
                            <td colspan="5" rowspan="3" class="bg04">추후예정</td>
                        </tr>
						<tr class="">
							<td colspan="2" class="bg03" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000543');">
                            	<a href="javascript:void(0);">
                                    SoftWare DevOps 7기 사전학습반
                                    <br>교육기간 : 01.18~02.19<br>교육장소 : 광주 무역회관
                                </a>
                            </td>
                            <td colspan="2" class="bg07" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000539');">
                            	<a href="javascript:void(0);">
                                     코딩 한 줄 없는 AI 활용하기
                                    <br>교육기간 : 03.29~04.09<br>교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td colspan="2" class="bg05" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000536');">
                            	<a href="javascript:void(0);"">
                                     Python기반 데이터 사이언스 기초
                                    <br>교육기간 : 05.31~06.08<br>교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td></td>
						</tr>
						<tr class="">
                            <td></td>
                            <td></td>
                            <td colspan="1" class="bg02" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000538');">
                            	<a href="javascript:void(0);">
                                     AI 개요와 딥러닝 개념
                                    <br>교육기간 : 03.22~03.26<br>교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td></td>
                            <td colspan="1" class="bg06" onclick="javascript:page_move('/smtp/course/short-term/short-term-info','c000000540');">
                            	<a href="javascript:void(0);">
                                     Python을 이용한 웹 스크래핑
                                    <br>교육기간 : 05.24~05.28<br>교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td></td>
                            <td></td>
						</tr>
                        <tr class="">
                            <th rowspan="2">
                                일본ICT직무 취업연계과정
                            </th>
                            <td></td>
                            <td></td>
                            <td colspan="10" class="bg01" onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000525');">
                                <a href="javascript:void(0);">
                                    SMART Cloud IT MASTER 41기
                                    <br>교육기간 : 03.29~12.03 / 교육장소 : 서울 코엑스
                                </a>
                            </td>
                        </tr>
                        <tr class="">
                            <td></td>
                            <td></td>
                            <td colspan="9" class="bg03" onclick="javascript:page_move('/smtp/course/scmaster/scmaster-info','c000000526');">
                                <a href="javascript:void(0);">
                                    SoftWare DevOps 7기
                                    <br>교육기간 : 03.00~11.00 / 교육장소 : 광주 무역회관
                                </a>
                            </td>
                            <td></td>
                        </tr>
                        <tr class="">
                            <th rowspan="2">
                                일본어 자격증 과정
                            </th>
                            <td></td>
                            <td colspan="3" class="bg04" onclick="location.href='/smtp/course/short-term/short-term-info?course_id=c000000541'">
                                <a href="/smtp/course/short-term/short-term-info?course_id=c000000541">
                                    일본취업을 위한 JPT
                                    <br>교육기간 : 02.19~ (약 3개월 총 12회)<br> 교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td colspan="5" rowspan="2" class="bg04">추후예정</td>
                        </tr>
                        <tr class="">
                            <td></td>
                            <td colspan="3" class="bg05" onclick="location.href='/smtp/course/short-term/short-term-info?course_id=c000000541'">
                                <a href="/smtp/course/short-term/short-term-info?course_id=c000000541">
                                    일본취업을 위한 SJPT
                                    <br>교육기간 : 02.19~ (약 3개월 총 12회)<br> 교육장소 : 서울 코엑스
                                </a>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>

                </table>
            </div>
        </div>


        <!-- footer-include -->
        <%@include file="../include/common_footer_rainbow.jsp"%>
    </div>
</body>

</html>
    