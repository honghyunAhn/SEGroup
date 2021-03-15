document.addEventListener("DOMContentLoaded", function() {
	
	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	
	var date = new Date();
	var currentMonth = date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2);
	
	var calendarEl = document.getElementById("calendar");

    var lastClicked;
	var eventDatas=[];
	
	var flag = true;
	
	$.ajax({
		type: "GET"
		, url: "/smtp/mypage/attendance_smtp"
		, data: 
			{
				"course_id": course,
				"cardinal_id": cardinal
			}
		, success: function(data) {
			if(data == "" || data == NaN) {
				alert("출석 데이터가 없습니다.");
				flag = false;
			} else {
			
				$.each(data, function(index, item) {
					var status= item.ATT_FINAL_GUBUN;
					var inTime = item.IN_TIME;
					var outTime = item.OUT_ITME;
					var status_nm;
					var ecolor;
					
					if(status=='B4701'){
						ecolor='#54f542';
					}else if(status=='B4702'){
						ecolor='#eb3477';
					}else if(status=='B4703'){
						ecolor='#3440eb';
					}else if(status=='지각'){
						ecolor='#ebdc34';
					}
					
					switch(status) {
					case "B4701":
						status_nm = "출석"
						break;
					case "B4702":
						status_nm ="결석"
						break;
					case "B4703":
						status_nm ="지각/조퇴"
						break;	
					}
					
					if(status_nm != '결석') {
						var titles = status_nm + " : " + item.IN_TIME + " - " + item.OUT_TIME;
						eventDatas.push({
							"title": titles,
							"start": item.ATT_DATE,
							"color": ecolor
						});
					} else {
						eventDatas.push({
							"title":status_nm, 
							"start": item.ATT_DATE,
							"color":ecolor
						});
					}
				});
			}
				
				var calendar = new FullCalendar.Calendar(calendarEl, {
			    	
		    	locale: 'ko',
		        contentHeight: 450,
		        initialView: 'dayGridMonth',
		        editable: true,
		        selectable: true,
		        events: eventDatas
		    });
				calendar.render();
				$(".fc-next-button").addClass('nextMonth');
				$(".fc-prev-button").addClass('preMonth');
				
				if(flag) {getSisuCheck(course, cardinal, currentMonth);}
		}
		, error: function(e) {
			alert("출결정보가 없습니다.");
		}
	});
});
	
var allContentsNum=0;
var doneContents=0;

function getSisuCheck(course_id, cardinal_id, currentMonth) {
	
	$.ajax({
		type: "GET"
		, url: "/smtp/mypage/sisuCount"
		, data: 
			{
				"course_id": course_id,
				"cardinal_id": cardinal_id,
				"currentMonth": currentMonth
			} 
		, success: function(data){
			
			var sb = '';
			
			sb += "<thead><tr><th>구분</th><th>총 수업시수</th><th>정상출석</th><th>결석</th><th>공결처리</th><th>잔여시수</th><th>출석률(잔여시수 제외)</th></tr></thead>"
			sb += "<tbody>";
			$.each(data, function(index, item){
				if(item.status == "month") {
					var monthCount = item.monthCount;
					var attend = item.attend;
					var absence = item.absence;
					var accepted = item.accepted;
					var restSisu = monthCount - (attend + absence + accepted);
					
					sb += "<tr>";
					sb += "<td>월별</td>";
					sb += "<td class='total-sisu'>" + monthCount + "</td>";
					sb +="<td class='total-safe'>" + attend + "</td>";
					sb +="<td class='total-absence'>" + absence + "</td>";
					sb += "<td class='total-accepted'>" + accepted + "</td>";
					sb += "<td class='rest-sisu'>" + restSisu + "</td>";
					var t = monthCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
					sb += "<td class='attendance-avg'>" + m + "</td></tr>";
				} else if(item.status == "all") {
					var allCount = item.allCount;
					var attend = item.attend;
					var absence = item.absence;
					var accepted = item.accepted;
					var restSisu = allCount - (attend + absence + accepted);
					
					sb += "<tr>";
					sb += "<td>전체</td>";
					sb += "<td class='all-total-sisu'>" + allCount + "</td>";
					sb +="<td class='all-total-safe'>" + attend + "</td>";
					sb +="<td class='all-total-absence'>" + absence + "</td>";
					sb += "<td class='all-total-accepted'>" + accepted + "</td>";
					sb += "<td class='all-rest-sisu'>" + restSisu + "</td>";
					var t = allCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
					sb += "<td class='all-attendance-avg'>" + m + "</td></tr>";
				}
			});
			sb += "</tbody>";
			$(".sisuTable").html(sb);
			
		}
		, error: function(data) {
			alert("실패하였습니다.");
		}
	});
}

$(document).on("click", ".nextMonth", function(){
	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	
	var date = $(".fc-toolbar-title").html();
	var temp = date.replace("년 ", "-");
	var temp2 = temp.replace("월", " ");
	var cMonth = temp2.trim();
	
	$.ajax({
		type: "GET"
		, url: "/smtp/mypage/sisuCount"
		, data: {
			"course_id": course,
			"cardinal_id": cardinal,
			"currentMonth": cMonth
		}
		, success: function(data) {
			$.each(data, function(index, item) {
				if(item.status == "month") {
					var monthCount = item.monthCount;
					var attend = item.attend;
					var absence = item.absence;
					var late = item.late;
					var accepted = item.accepted;
					var restSisu = monthCount - (attend + absence + late + accepted);
					
					$(".total-sisu").html(monthCount);
					$(".total-safe").html(attend);
					$(".total-absence").html(absence);
					$(".total-late").html(late);
					$(".total-accepted").html(accepted);
					$(".rest-sisu").html(restSisu);
					var t = monthCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
	 				$(".attendance-avg").html(m);
				}
			});
			
		}
		, error: function(data) {
			alert("실패");
		}
	});
	
});

$(document).on('click', '.fc-event-title-container', function() {

	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	var date = $(this).parent().parent().parent().parent().parent().parent().parent().attr('data-date');
	
	var form = document.createElement("form");
	
    var input1 = document.createElement("input");
    input1.setAttribute("type", "hidden");
    input1.setAttribute('name', "courseId");
    input1.setAttribute("value", course);
    form.appendChild(input1);
    var input2 = document.createElement("input");
    input2.setAttribute("type", "hidden");
    input2.setAttribute('name', "cardinalId");
    input2.setAttribute("value", cardinal);
    form.appendChild(input2);
    var input3 = document.createElement("input");
    input3.setAttribute("type", "hidden");
    input3.setAttribute('name', "attDate");
    input3.setAttribute("value", date);
    form.appendChild(input3);
    document.body.appendChild(form);

	window.open("", 'openWindow', "width=800px, height=900px,scrollbars=yes");
    form.action = "/smtp/user/certiSubmit";
    form.target = "openWindow";
    form.method = "post";
    form.submit();
    form.remove();
});

$(document).on("click", ".preMonth", function(){

	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	
	var date = $(".fc-toolbar-title").html();
	var temp = date.replace("년 ", "-");
	var temp2 = temp.replace("월", " ");
	var cMonth = temp2.trim();
	
	$.ajax({
		type: "GET"
		, url: "/smtp/mypage/sisuCount"
		, data: {
			"course_id": course,
			"cardinal_id": cardinal,
			"currentMonth": cMonth
		}
		, success: function(data) {
			$.each(data, function(index, item) {
				if(item.status == "month") {
					var monthCount = item.monthCount;
					var attend = item.attend;
					var absence = item.absence;
					var late = item.late;
					var accepted = item.accepted;
					var restSisu = monthCount - (attend + absence + late + accepted);
					
					$(".total-sisu").html(monthCount);
					$(".total-safe").html(attend);
					$(".total-absence").html(absence);
					$(".total-late").html(late);
					$(".total-accepted").html(accepted);
					$(".rest-sisu").html(restSisu);
					var t = monthCount - restSisu;
					var e = attend + accepted;
					var m = (e / t) * 100;
					if(m == Infinity || isNaN(m)){
						m = "0";
					} else {
						m = m.toFixed(2);
					}
	 				$(".attendance-avg").html(m);
 				}
			}); 
			
		}
		, error: function(data) {
			alert("실패");
		}
	});
});
