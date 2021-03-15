<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
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
				case "USER_NM" :
					$("#name-span").append(item);
					break;
				case "COURSE_NAME" :
					$("#course-span").append(item);
					break;
				case "START_DATE" :
					startDate += item;
					break;
				case "END_DATE" :
					endDate += item;
					break;
				case "CARDINAL_NAME" :
					$("#cardinal-title").html("[ " + item + " 종합 성적 평가등급 분포율 ]");
					$("#cardinal-span").append(item);
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
		
		$("#date-span").append(startDate + " ~ " + endDate);
		
 		var text = "<tr>";
 		$.each(keyArr, function(index, item) {
 			text += "<td>" + item + "</td>";
 		});
		text += "</tr><tr>";
		
		$.each(valueArr, function(index, item) {
			text += "<td>" + item + "</td>";
		});
		text += "</tr>";
		
		$("#bigTbody").append(text);
		
		var gradeTb = "";
		$.each(${grade}, function(key, item) {
			$.each(item, function(index, i) {
				gradeTb += "<tr><td>" + index + "</td><td>" + i + " %</td></tr>";
			});
		});
		gradeTb += "<tr><td>TOTAL</td><td>100.0 %</td></tr>";
		$("#gradeTbody").html(gradeTb);
		
		var date = new Date();
		
		var today = date.getFullYear() + "년 " + (date.getMonth()+1) + "월 " + date.getDate() + "일";
		
		$("#today").html(today);
	});
	
	function printWindow() {
		var initBody;
		
		window.onbeforeprint = function(){
			initBody = document.body.innerHTML;
			document.body.innerHTML = document.getElementById("print-body").innerHTML;
		};
		window.onafterprint = function(){
			document.body.innerHTML = initBody;
		};
		
		$(".modal-content").css("margin", "20% auto");
		
		window.print();
		
		$(".modal-content").css("margin", "0px 0px");
		
		return false;
	}
</script>
<style>
	@page {
		margin: 0;
	}
	
	* {
		margin: 0;
		padding: 0;
	}
	
	.modal-content {
		position: relative;
		width: 100%;
		/* margin: 30%  0;
		margin-bottom: 0px; */
		pointer-events: auto;
		background-color: #fff;
		background-clip: padding-box;
		border: 1px solid rgba(0, 0, 0, .2);
		border-radius: 0.3rem;
		outline: 0;
	}
	
	.modal-header {
		display: -ms-flexbox;
		display: flex;
		-ms-flex-align: start;
		align-items: flex-start;
		-ms-flex-pack: justify;
		justify-content: space-between;
		padding: 1rem;
		border-bottom: 1px solid #e9ecef;
		border-radius: 0.3rem 0.3rem 0.3rem;
	}
	
	.modal-title {
		margin-bottom: 0;
		line-height: 1.5;		
	}
	
	.modal-header .close {
		padding: 1rem;
		margin: -1rem -1rem -1rem auto;
	}
	
	.close {
		float: right;
		font-size: 1.5rem;
		font-weight: 700;
		line-height: 1;
		color: #000;
		text-shadow: 0 1px 0 #fff;
		opacity: .5;
	}
	
	.modal-body {
		position: relative;
		-ms-flex: 1 1 auto;
		flex: 1 1 auto;
		padding: 1 rem;
	} 
	
	.modal-footer {
		display: -ms-flexbox;
		display: flex;
		-ms-flex-align: center;
		align-items: center;
		-ms-flex-pack: end;
		justify-content: flex-end;
        padding: 1rem;
		/* border-top: 1px solid #e9ecef; */
	}
	.modal-footer.text-alignR{
		display : block;
	}
	.modal-footer.text-alignR>h5{
		text-align:right;
	}
	.bg_444 {
		background-color: #444;
		color: #fff;
	}
	
	.bg_999 {
		background-color: #999;
		color: #fff;
	}
	
	.bg_wm {
		background-color: rgba(42, 174, 186, 0.7);
	}
	
	.modal-header,
	.modal-body,
	.modal-footer {
		padding: 10px;
		color: #333;
		line-height: 20px;
	}
	
	.modal-header {
		border-radius: 0;
	}
	
	.modal-header .close {
		padding: 0;
		margin: 0;
	}
	
	.modal-subGroup {
		/* border: 1px solid #ddd; */
		padding: 10px;
	}
	
	.modal-subGroup>.hideTab {
		display: none;
	}
	
	.ns_tableWrapper:nth-child(1)~* {
		margin-top: 40px;
	}
	
	.ns_tableWrapper .ns_tableHdr {
		line-height: 30px;
	}
	
	.ns_tableWrapper .tal_right {
		text-align: right;
		padding: 0 5px;
	}
	
	.newStyle_table {
		width: 100%;
		text-align: center;
		vertical-align: center;
		cursor: default;
		margin: 20px;
	}
	
	.newStyle_table th,
	.newStyle_table td {
		padding: 5px;
	}
	
	.newStyle_table th {
		line-height: 30px;
		font-weight: normal;
	}
	
	.newStyle_table td {
		border: 1px solid #ddd;
	}
	
	.modal-titleGroup {
		display: flex;
		justify-content: center;
	}
	
	.printBtn {
		margin: 0 auto;
		width: 200px;
	}
	
</style>
<div class="cl-popup-overlay" id="certificatepop">
	<div id="print-body">
		<div class="main-body" id="main-body">
			<div class="moda fade show" id="myModal" role="dialog" style="display: block; padding-right: 17px;">
				<div class="modal-dialog" style="max-width: 1200px;">
					<div class="modal-content">
						<div class="modal-body">
							<div class="modal-tabMenu">
								<div class="modal-subGroup">
									<div class="modal-titleGroup">
										<h2>종합성적표</h2>
									</div>
									<div class="modal-infoGroup">
										<h4 id="name-span" >성   명 : </h4>
										<h4 id="course-span">과정명 : </h4>
										<h4 id="cardinal-span">기수명 : </h4>
										<h4 id="date-span">교육기간 : </h4>
									</div>
									<div class="modal-tabSub">
										<div class="ns_tableWrapper">
											<div class="ns_tableWrapper">
												<table class="newStyle_table">
													<tbody class="tbody" id="bigTbody">
													</tbody>
												</table>
											</div>
											<div class="ns_tableWrapper" style="width:400px;">
												<h4 class="ns_tableHdr" id="cardinal-title"></h4>
												<table class="newStyle_table">
													<tbody class="tbody" id="gradeTbody">
													</tbody>
												</table>
											</div>
											<br><br><br><br>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer text-alignR">
								<h5 id="today"></h5>
								<h5>한국무역협회-Soft Engineer Society</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> 
	<input class="printBtn" type="button" onclick="printWindow()" value="출력">
</div>