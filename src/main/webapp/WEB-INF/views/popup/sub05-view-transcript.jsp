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
    
	<!-- 추가 라이브러리 -->
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script type="text/javascript" src="/resources/js/printThis.js"></script>
	<script type="text/javascript">

	$(function(){
		
		var startDate = "";
		var endDate = "";
		
		var keyArr = new Array();
		var valueArr = new Array();
		var emp = "${result}";
		
		if(emp == "true") { 
			alert("해당하는 성적이 없습니다.");
			window.close();
		}
		$.each(${user}, function(index, item) {
			switch(index) {
				case "USER_BIRTH":
					$("li.ctf_birth").html(item);
				break;
				case "USER_NM" :
					$("li.ctf_name").html(item);
					break;
// 				case "COURSE_NAME" :
// 					$("li.ctf_course").html(item);
// 					break;
				case "START_DATE" :
					startDate += item;
					break;
				case "END_DATE" :
					endDate += item;
					break;
				case "CARDINAL_NAME" :
					$(".cdNum").html(item.substr(item.length-3));
					$("li.ctf_course").html(item);
					break;
				case "USER_ID" :
					break;
				default :
					keyArr.push(index);
					valueArr.push(item);
					break;
			}
		});
		
		keyArr.reverse();
		valueArr.reverse();
		
		$("li.ctf_terms").append(startDate + " ~ " + endDate);
		
		var myScoreHeadTxt = '';
		$.each(keyArr, function(index, item) {
			myScoreHeadTxt += '<td><strong>' + item + '</strong><br><span class="h5"></span></td>';
 		});
		$('#myScoreHead > tr').html(myScoreHeadTxt);
		
		var myScoreBodyTxt = '';
		$.each(valueArr, function(index, item) {
			myScoreBodyTxt += '<td>' + item + '</td>';
		});
		$('#myScoreBody > tr').html(myScoreBodyTxt);
		
		var totalScoreHeadTxt = '';
		var totalScoreBodyTxt = '';
		$.each(${grade}, function(key, item) {
			$.each(item, function(index, i) {
				totalScoreHeadTxt += '<td><strong>' + index + '</strong></td>';
				totalScoreBodyTxt += ' <td><span>' + i + '</span>%</td>';
			});
		});
		$('#totalScoreHead > tr').html(totalScoreHeadTxt);
		$('#totalScoreBody > tr').html(totalScoreBodyTxt);
		
		var date = new Date();
		var today = date.getFullYear() + "년 " + (date.getMonth()+1) + "월 " + date.getDate() + "일";
		
		$("div.ctf_endDate").html(today);
	});
	
	function printWindow() {
		var initBody;
		
		window.print();
		
		return false;
	}
</script>
	<style type="text/css">
		/* 	배경 img 프린트 */
		@media print
		{
			* {/*Chrome, Safari */
				-webkit-print-color-adjust: exact !important;
				/*Firefox*/
				color-adjust: exact !important;
			}
			.button-wrap{display: none;}
		}
	</style>
</head>
<body>
	<div class="container_rainbow" id="print-body">
        <div class="content sub-content sub05_content view-certificate view-transcript" id="main">
            <ul class="ctf_textWrap">
                <li class="ctf_name"></li>
                <li class="ctf_birth"></li>
                <li class="ctf_course"></li>
                <li class="ctf_cardinal"></li>
                <li class="ctf_terms"></li>
            </ul>
            <div class="tableWrap ctf_tableWrap">
            <table class="table ctf_table">
                <thead class="thead" id="myScoreHead">
                    <tr></tr>
                </thead>
                <tbody class="tbody" id="myScoreBody">
                    <tr></tr>
                </tbody>
            </table>
            </div>
            <div class="tableWrap ctf_tableWrap ctf_tableWrap02">
                <div class="ctf_table_ttl">[<span class="cdNum"></span> 종합성적 평가등급 분포율]</div>
                <table class="table ctf_table ctf_table_benchmark">
                    <thead class="thead" id="totalScoreHead">
                        <tr></tr>
                    </thead>
                    <tbody class="tbody" id="totalScoreBody">
                        <tr></tr>
                        <!-- <tr>
                        <td><strong>FAIL</strong><span class="h5">(등급보류)</span></td>
                        <td><strong>DROP</strong></td>
                        <td colspan="2"><strong>TOTAL</strong></td>
                    </tr>
                    <tr>
                        <td><span class="trs_fail"></span>%</td>
                        <td><span class="trs_drop"></span>%</td>
                        <td colspan="2"><span class="trs_total">100.0</span>%</td>
                    </tr> -->
                    </tbody>
                </table>
            </div>
            <div class="ctf_endDate"></div>
        </div>
    </div>
    <div class="button-wrap d-flex justify_center">
    	<input type="button" class="btn_normal btn_pp_bg btn_medium" value="출력하기" onclick="printWindow()">
    </div>
</body>
</html>