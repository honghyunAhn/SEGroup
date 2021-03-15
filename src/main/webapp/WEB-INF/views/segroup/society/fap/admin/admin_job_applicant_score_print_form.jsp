<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/userDefault.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/modal_company_achievment_style.css" />" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<%-- <script src="<c:url value="/resources/segroup/society/fap/js/lodash.js" />"></script> --%>
<title>Bridge Job Fair</title>
<script type="text/javascript">
	$(function(){
		// 일반회원만 지원한 경우 화면 처리
		var stuList = ${studentList};
		if(stuList == "") {
			$('.modal-body').html('표시할 항목이 없습니다.');
			return;
		}
		
		var crcList = ${courseList};
		var gradeRate = ${gradeRate};
		var gradeGuide = ${gisuGrade};
		
		var sb = new StringBuilder();
		var start = 0;
		var end = 0;
		var stuNum = 0;
		
		for(var i=0; i<crcList.length; i++){
			// 과목 array 생성
			var subject_arr = new Array();
			for(key in crcList[i]){
				switch(key){
				case "CARDINAL_NAME":
				case "CARDINAL_ID":
				case "STUDENT_CNT":
				case "COURSE_NAME":
					break;
				default:
					subject_arr.push(crcList[i][key]);
				}
			}
			
			// 성적표 탭(과정명), 회사명, 성적 테이블 head 세팅
			if(crcList[i].STUDENT_CNT !=0){
				if(i==0) {
					$('.modal-tabGroup').append('<li class="active">' + crcList[i].COURSE_NAME + '</li>');
					sb.Append('<div class="modal-tabSub">');
				}else {
					$('.modal-tabGroup').append('<li>' + crcList[i].COURSE_NAME + '</li>');
					
					sb.empty();
					sb.Append('<div class="modal-tabSub hideTab">');
				}
			}else continue;
			
			sb.Append('<div class="ns_tableWrapper">');
			sb.Append('<div class="tal_right">' + "${comp_en_nm}" + ' 様</div>');
			sb.Append('<table class="newStyle_table">');
			sb.Append('<thead class="thead">');
			sb.Append('<tr class="bg_444">');
			sb.Append('<th colspan="7">' + "${jobfair_title}" + ' 参加者課程履修成績</th>'); 
			sb.Append('</tr>');
			sb.Append('<tr class="bg_999">');
			sb.Append('<th rowspan="2">NO</th>');
			sb.Append('<th rowspan="2">応募形態</th>');
			sb.Append('<th rowspan="2">氏名</th>');
			sb.Append('<th colspan="' + subject_arr.length + '">科目別成績等級</th>');
			sb.Append('<th rowspan="2">総合成績等級</th>');
			sb.Append('</tr>');
			sb.Append('<tr class="bg_999">');
			
			for(var j=0; j<subject_arr.length; j++){
				sb.Append('<th>' + subject_arr[j] + '</th>');
			}
			sb.Append('</tr>');
			sb.Append('</thead>');
			
			// 학생 성적 리스트 출력
			sb.Append('<tbody class="stuListBody">');
			end += crcList[i].STUDENT_CNT;
			
			for(var j=start; j<end; j++){
				if(start==0) stuNum = j;
				else stuNum = j - start;
				
				sb.Append('<tr>');
				sb.Append('<td class="ns_num">' + (stuNum+1) + '</td>');
				if(stuNum==0) sb.Append('<td rowspan="' + crcList[i].STUDENT_CNT + '">' + "${jobfair_gb}" + '</td>');
				sb.Append('<td class="ns_name">' + stuList[j].USER_NAME + '</td>');
				
				for(var k=0; k<subject_arr.length; k++){
					sb.Append('<td>' + stuList[j][subject_arr[k]] + '</td>');
				}
				sb.Append('<td>' + stuList[j].TOTAL + '</td>');
				sb.Append('</tr>');
 			}
			sb.Append('</tbody>');
			sb.Append('</table>');
			sb.Append('</div>');
			start += crcList[i].STUDENT_CNT;
			
			// 등급별 비율 출력
			sb.Append('<div class="ns_tableWrapper" style="width:300px;">');
			sb.Append('<h4 class="ns_tableHdr">[参考]</h4>');
			sb.Append('<table class="newStyle_table">');
			sb.Append('<thead class="thead">');
			sb.Append('<tr class`="bg_444">');
			sb.Append('<th colspan="2">総合成績等級別分布</th>');
			sb.Append('</tr>');
			sb.Append('</thead>');
			sb.Append('<tbody class="gradeRateBody">');
			
			for(var j=0; j<gradeRate[i].length; j++){
				sb.Append('<tr>');
				sb.Append('<td>' + gradeRate[i][j].GRADE + '</td>');
				sb.Append('<td><span class="acv_calc">' + gradeRate[i][j].PERCENT + '</span>%</td>');
				sb.Append('</tr>');
			}
			sb.Append('<tr>');
			sb.Append('<td class="acv_tt">TOTAL</td>');
			sb.Append('<td>100%</td>');
			sb.Append('</tr>');
			sb.Append('</tbody>');
			sb.Append('</table>');
			sb.Append('</div>');
			
			// 등급별 점수 구간
			sb.Append('<div class="ns_tableWrapper">');
			sb.Append('<div class="tal_right">(部門別評価点数 : 100点満点基準)</div>');
			sb.Append('<table class="newStyle_table">');
			sb.Append('<thead class="thead">');
			sb.Append('<tr class="bg_444">');
			sb.Append('<th colspan="2">等級</th>');
			
			for(var j=0; j<subject_arr.length; j++){
				sb.Append('<th>' + subject_arr[j] + '</th>');
			}
			sb.Append('<th>総合成績</th>');
			sb.Append('</tr>');
			sb.Append('</thead>');
			sb.Append('<tbody class="gradeGuideBody">');
			sb.Append('<tr>');
			sb.Append('<th colspan="2" class="bg_999">評価項目</th>');
			
			for(var j=0; j<subject_arr.length; j++){
				if(subject_arr[j] == 'BASICS')
					sb.Append('<td> - 出欠点数<br> - 学事規定順守度,　チームワーク参加度など</td>');
				else
					sb.Append('<td> - 力量評価 ①次～③次合否 </td>');
			}
			sb.Append('<td>-</td>');
			sb.Append('</tr>');
			
			for(var j=0; j<gradeGuide[i].length; j++){
				var end_score = gradeGuide[i][j].END_SCORE;
				
				sb.Append('<tr>');
				if(j==0) sb.Append('<th rowspan="' + gradeGuide[i].length + '" class="bg_999">評価<br>結果</th>');
				sb.Append('<th>' + gradeGuide[i][j].GRADE + '</th>');
				
				for(var m=0; m<subject_arr.length; m++){
					if(subject_arr[m] == 'BASICS')
						sb.Append('<td>' + end_score + '点以上 ~ ' + (gradeGuide[i][j].START_SCORE-1)+ '点以下</td>');
					else
						sb.Append('<td>総点(力量評価 Pass点数)<br>' + end_score + '点以上 ~ ' + (gradeGuide[i][j].START_SCORE-1)+ '点以下</td>');
				}
				sb.Append('<td>総点 ' + end_score + '点以上 ~ ' + (gradeGuide[i][j].START_SCORE-1)+ '点以下</td>');
				//(end_score>0 ? (end_score+1) : 0)
				sb.Append('</tr>');
			}
			sb.Append('</tbody>');
			sb.Append('</table>');
			sb.Append('</div>');
			sb.Append('</div>')
			$('.modal-subGroup').append(sb.ToString());
		}
		
		//modal_tab
		var $tab = $('.modal-tabMenu>.modal-tabGroup>li'),
	        $sub = $('.modal-tabMenu>.modal-subGroup>.modal-tabSub'),
	        i = 0;
	    $tab.click(function() {
	        i = $(this).index();
	        console.log(i);
	        $sub.hide();
	        $sub.eq(i).show();
	        $('.modal-tabMenu>.modal-tabGroup>li*').removeClass('active');
	        $(this).addClass('active');
	        return false;
	    });
	    
	}); // <------- ready function 끝
	
	// StringBuilder 기능구현
	function StringBuilder() {
		this.buffer = new Array();
	}
	StringBuilder.prototype.Append = function(strValue) {
		this.buffer[this.buffer.length] = strValue;
		//this.buffer.push(strValue);	//IE5.5, NS4
	};
	StringBuilder.prototype.ToString = function() {
		return this.buffer.join("");	//IE4, NS3
	};
	StringBuilder.prototype.empty = function() {
		this.buffer = new Array();
	};
	
	// 성적표 인쇄
	function printWindow() {
		window.print();
	}
</script>

<style type="text/css" media="print">
@page {
	size: auto; /* auto is the initial value */
	margin: 0; /* this affects the margin in the printer settings */
}

html {
	margin: 0px;
}

body {
	margin: 0mm; /* margin you want for the content */
}
.printBtn {
	display: none !important;
}
</style>
</head>
<body>
	<div style="display: block; position: fixed; top: 1px; left: 25px; z-index: 150;">
		<input class="printBtn" type="button" style="height: 45px; width: 65px;" onclick="printWindow()" value="PRINT">
	</div>
	<div id="subcontents">
		<div class="userjoinBox">
			<div class="modal-body">
                   <div class="modal-tabMenu">
                       <ul class="modal-tabGroup d-flex"></ul>
                       <div class="modal-subGroup">
                       </div>
                   </div>
               </div>
		</div>
	</div>
</body>
</html>