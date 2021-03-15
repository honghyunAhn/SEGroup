$(document).ready(function(){   //페이지 로딩시 getEvent() 를가장먼저 호출
	  getEvent();
	});
function getEvent(){        //일정정보 가져오기
	
	var gisu_seq = document.getElementById("getGisu").value;
	$("#gisuList").val(gisu_seq);
	
	$.ajax({
	     type:"post",
	     url:"/smp/selectAll",
		 data :{'gisu_seq': gisu_seq},
		 dataType : 'json',
	     success:function(result){
	    	 eventList(result);
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
	}
function eventList(result)
{
	var eventData = [];
	var event;
	var gisu_seq = document.getElementById("getGisu").value;
	var today = new Date();
	  var mm = today.getMonth()+1; 
	  var yyyy = today.getFullYear();
	  if(mm<10) {
	      mm='0'+mm
	  } 

	  today = yyyy+'-'+mm;
	  
	var monthEvent = [];

	for(var i in result)
	{
		if(result[i].smp_sch_color==null)
		{
			result[i].smp_sch_color = "#a65ef9"; //색상 미지정 이벤트의 디폴트 색상값(보라색)
		}	

		var mf_end = moment(result[i].smp_sch_et).format('YYYY-MM-DD 23:59:59');
		
		event = {
			title : result[i].smp_sch_ct,    				//이벤트 제목
			start : result[i].smp_sch_st,					//이벤트 시작일
			end : mf_end, 									//이벤트 종료일 smp_sch_et
			color : result[i].smp_sch_color, 				//이벤트 색
			smp_sch_seq : result[i].smp_sch_seq, 			//이벤트 번호
			smp_sch_title : result[i].smp_sch_title,		//이벤트 과목
			smp_sch_cont : result[i].smp_sch_cont,			//이벤트 내용
			gisu_seq : result[i].gisu_seq, 					//기수
			smp_sch_ins_id : result[i].smp_sch_ins_id,		//이벤트 등록인
			smp_sch_ins_dt : result[i].smp_sch_ins_dt,		//이벤트 등록날짜
			smp_sch_udt_id : result[i].smp_sch_udt_id,		//이벤트 수정인
			smp_sch_udt_dt : result[i].smp_sch_udt_dt,		//이벤트 수정 날짜
			smp_sch_color_seq : result[i].smp_sch_color_seq //이벤트 색상 시퀀스
		};
		
		eventData.push(event);
		
	}	
	calendar(eventData);
	colorInput(gisu_seq);
	month(today);
}
  function calendar(eventData){
	  var gisu_seq = document.getElementById("getGisu").value;
	  var gisu_num = document.getElementById("getGisuNum").value;
	  
	  var today = new Date();
	  var dd = today.getDate();
	  var mm = today.getMonth()+1; 
	  var yyyy = today.getFullYear();
	  if(dd<10) {
	      dd='0'+dd
	  } 
	  if(mm<10) {
	      mm='0'+mm
	  } 

	  today = yyyy+'-'+mm+'-'+dd;
    $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: null
      },
      buttonText: {
          today : "오늘",
          month : "이번 달",
          basicWeek : "주별1",
          basicDay : "일별1",
          agendaWeek : "주별2",
          agendaDay : "일별2"
         },    
      defaultView: 'month',
      defaultDate: today,
      monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
      monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
      dayNames: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
      dayNamesShort: ["일","월","화 ","수 ","목 ","금 ","토 "],      ///한글로변환
      selectable: true,
      selectHelper: true,
      select: function(start, end) {
    	  $.ajax({
   		     type:"post",
   		     url:"/smp/user/gisuTitleCheck",
   			 data :{'gisu_seq': gisu_seq},
   			 dataType : 'json',
   		     success:function(result){
   		    	 if(result.subject==null)
   		    	{
   		    		 alert("과목별 색상을 지정해주세요.");
   		    	     $("#insertColorModal").modal('show');
   		    	}
   		    	else
   		    	{
   		    		  $("#insertSubject > option").remove();
		   		    var dt_start = moment(start).format('YYYY-MM-DD');	
		   		      $("#insertStrDate").val(dt_start);
		   	    	  $("#insertEndDate").val(dt_start);
		   	    	  $("#insertGisu").val(gisu_seq);
		   	    	  $("#insertGisuNum").val(gisu_num);
		   	    	 var tag = '';
		   	    	 for(var i in result.subject)
			   	     {
		   	    		tag += '<option value="'+result.subject[i].smp_sch_title+'">'+result.subject[i].smp_sch_title+'</option>';	 
			   	     }
		   			$("#insertSubject").append(tag);
		   			$("#insertmodal").modal('show');
   		    	}	
   		    		 
   		     },
   		     error:function(data)
   		     {
   		    	 alert("통신에러");
   		     }
   		    });
    	  
      },
      navLinks: true, // can click day/week names to navigate views
      editable: false,
      eventLimit: true, // allow "more" link when too many events
   	  eventClick:  function(event, jsEvent, view) {
    			
    			 $.ajax({
    	   		     type:"post",
    	   		     url:"/smp/user/gisuTitleCheck",
    	   			 data :{'gisu_seq': gisu_seq},
    	   			 dataType : 'json',
    	   		     success:function(result){
    	   		    	 
    	   				$("#updateSubject > option").remove();

    	   		    	var dt_start = moment(event.start).format('YYYY-MM-DD');
    	   		    	var dt_end = moment(event.end).format('YYYY-MM-DD');
    	   		    	
    	    			$("#updateTitle").val(event.title);
    	    			$("#updateStrDate").val(dt_start);
    	    			$("#updateEndDate").val(dt_end);
    	    			var tag = '';
			   	    	 for(var i in result.subject)
				   	     {
			   	    		tag += '<option value="'+result.subject[i].smp_sch_title+'">'+result.subject[i].smp_sch_title+'</option>';	 
				   	     }
			   			$("#updateSubject").append(tag);
			   			
			   			$("#updateSubject").val(event.smp_sch_title);
			   			
			   			$("#updateDiscription").val(event.smp_sch_cont);
			   			$("#updateGisu").val(event.gisu_seq);
		    			$("#updateColorSeq").val(event.smp_sch_color_seq);
		    			$("#eventNum").val(event.smp_sch_seq);
		    			$("#myModal").modal('show');
		    			
		    			
		    			$("#userSubject > option").remove();
		    			$("#userTitle").val(event.title);
    	    			$("#userStrDate").val(dt_start);
    	    			$("#userEndDate").val(dt_end);
		    			$("#userSubject").val(event.smp_sch_title);
			   			$("#userDiscription").val(event.smp_sch_cont);
		    			$("#userModal").modal('show');
		    			
		    			
    	   		     },	
    	   		     error:function(data)
    	   		     {
    	   		    	 alert("통신에러");
    	   		     }
    	   		    });
    
    	}, 	    
       events:eventData
    });
    
    jQuery("button.fc-prev-button").click(function() {
    	var date = jQuery("#calendar").fullCalendar("getDate");
    	month(date);
    });
    
    jQuery("button.fc-next-button").click(function() {
    	var date = jQuery("#calendar").fullCalendar("getDate");
    	month(date);
    });
    
    $(".fc-day-number").removeAttr("data-goto");
    
  }
		

$(function(){
	$("#udpateBtn").on('click', function(){
		var gisu_seq = $("#updateGisu").val();
		$.ajax({
  		     type:"post",
  		     url:"/smp/user/gisuTitleCheck",
  			 data :{'gisu_seq': gisu_seq},
  			 dataType : 'json',
  		     success:function(result){
  		    	for(var i in result.subject)
  		    	{
  		    		var sub = $("#updateSubject").val();
  		    		if(result.subject[i].smp_sch_title==sub)
  		    		{
  		    			update();
  		    			return;
  		    		}
  		    	}
  		    	alert("과목과 색상을 먼저 지정해주세요");
  		    	$("#myModal").modal('hide');
  		    	
  		     },
  		     error:function(data)
  		     {
  		    	 alert("통신에러");
  		     }
  		    });
		
	
	});
	
	$("#deleteBtn").on('click', function(){
		if (!confirm("일정을 삭제하시겠습니까?")) {
	   		  return;
	   	  	}
		var smp_sch_seq = document.getElementById("eventNum").value;
		$.ajax({
		     type:"post",
		     url:"/smp/admin/deleteSch",
			 data :{"smp_sch_seq" : smp_sch_seq},
		     success:function(result){
		    	 $("#myModal").modal('hide');
		    	 location.reload();
		     },
		     error:function(data)
		     {
		    	 alert("통신에러");
		     }
		  });
		
	});
	
	$("#insertBtn").on('click', function(){
		
		var gisu_seq = $("#insertGisu").val();
		$.ajax({
 		     type:"post",
 		     url:"/smp/user/gisuTitleCheck",
 			 data :{'gisu_seq': gisu_seq},
 			 dataType : 'json',
 		     success:function(result){
 		    	for(var i in result.subject)
 		    	{
 		    		var sub = $("#insertSubject").val();
 		    		if(result.subject[i].smp_sch_title==sub)
 		    		{
 		    			insert();
 		    			return;
 		    		}
 		    	}
 		    	alert("과목과 색상을 먼저 지정해주세요");
 		    	$("#insertmodal").modal('hide');
 		    	
 		     },
 		     error:function(data)
 		     {
 		    	 alert("통신에러");
 		     }
 		    });
		
	});
});

function update()
{
		var tit = $("#updateTitle").val();
		var str = $("#updateStrDate").val();
		var end = $("#updateEndDate").val();
		var sub = $("#updateSubject").val();
		var userId = $("#updateUserId").val();
		var sch_seq = $("#eventNum").val();
		var gisu = $("#updateGisu").val();
		var content = $("#updateDiscription").val();
		
 		var sDate = new Date(str);
        var eDate = new Date(end);
       
		if((tit=="")||(str=="")||(end=="")||(sub=="")||(gisu==""))
		{
			alert("정보를 모두 입력해주세요.");
			return;
		}
		else if(sDate.getTime() > eDate.getTime())
		{
			alert("종료일을 수정해주세요");
			return;
		}
	
		var sendData ={
				"gisu_seq" : gisu, "smp_sch_title" : sub, "smp_sch_ct" : tit, "smp_sch_cont" : content, 
				"smp_sch_st" : str, "smp_sch_et" : end,  "smp_sch_udt_id" : userId, "smp_sch_seq" : sch_seq
			};
		
			$.ajax({
			     type:"post",
			     url:"/smp/admin/updateSch",
				 data :JSON.stringify(sendData),
				 contentType : 'application/json',
			     success:function(){
			    	 $("#myModal").modal('hide');
			    	 location.reload();
			     },
			     error:function(data)
			     {
			    	 alert("통신에러");
			     }
			  });
}

function insert()
{
		var tit = $("#insertTitle").val();
		var str = $("#insertStrDate").val();
		var end = $("#insertEndDate").val();
		var sub = $("#insertSubject").val();
		var gisu = $("#insertGisu").val();
		var userId = $("#insertUserId").val();
		var content = $("#insertDiscription").val();
		
		var sDate = new Date(str);
	    var eDate = new Date(end);
	     
		if((tit=="")||(str=="")||(end=="")||(sub=="")||(gisu==""))
		{
			alert("정보를 모두 입력해주세요.");
			return;
		}
		else if(sDate.getTime() > eDate.getTime())
		{
			alert("종료일을 수정해주세요");
			return;
		}	
		
		var sendData ={
				"gisu_seq" : gisu, "smp_sch_title" : sub, "smp_sch_ct" : tit, "smp_sch_cont" : content, 
				"smp_sch_st" : str, "smp_sch_et" : end, "smp_sch_ins_id" : userId, "smp_sch_udt_id" : userId
		};
		
		$.ajax({
		     type:"post",
		     url:"/smp/admin/insertSch",
			 data :JSON.stringify(sendData),
			 contentType : 'application/json',
		     success:function(){
		    	 $("#myModal").modal('hide');
		    	 location.reload();
		     },
		     error:function(data)
		     {
		    	 alert("통신에러");
		     }
		  });
}


function gisuChange()
{
	var gisu_seq = document.getElementById("gisuList").value;
	document.getElementById("updateForm").action="/smp/admin/gisuChange";
	$("#updateGisu").val(gisu_seq);
	document.getElementById("updateForm").submit();
}


function output(resp) {
	   
	   $("#result").html('');
	   
	   var result = '';
	   result += '<div class="grid-style">';
	   for (var i in resp) {
      
	  result += '<div class="notice"> ';
      
	  strday = moment(resp[i].smp_sch_st).format('MM/DD');
      
      result += '<p class="strday">' + strday + '</p> ';
      
      //"#f26071" 빨간색
	  //"#667ff9" 파란색
	  //"#f9e770" 노란색
	  //"#f9b15e" 주황색
      //"#cb2ef7" 보라색
      var sub;
        
	  if(resp[i].smp_sch_color=='#f26071')
	  {
		  sub = "　";
		  result += '<p class="subject" id="color_red">'+sub+'</p>';
	  }
	  else if(resp[i].smp_sch_color=='#667ff9')
	  {
		  sub = "　";
		  result += '<p class="subject" id="color_blue">' + sub + '</p>';
	  }
	  else if(resp[i].smp_sch_color=='#f9e770')
	  {
		  sub = "　";
		  result += '<p class="subject" id="color_yellow">' + sub + '</p>';
	  }
	  else if(resp[i].smp_sch_color=='#f9b15e')
	  {
		  sub = "　";
		  result += '<p class="subject" id="color_orange">' + sub + '</p>';
	  }
	  else if(resp[i].smp_sch_color=='#cb2ef7')
	  {
		  sub = "　";
		  result += '<p class="subject" id="color_purple">' + sub + '</p>';
	  }
	  
      result += '<p class="title">' + resp[i].smp_sch_ct + '</p> ';
      result += '</div>';
   }
   result += '</div>';

   
   $("#result").html(result);
}

function month(date)
{
	var gisu = document.getElementById("getGisu").value;
	var date = new Date(date);
	var strday = moment(date).format('YYYY-MM-01 00:00:00');
	var end = new Date(date.getFullYear(), date.getMonth()+1, 0);
	var endday = moment(end).format('YYYY-MM-DD 23:59:59');
	
	var sendData ={"gisu_seq":gisu, "smp_sch_st":strday, "smp_sch_et":endday};
	
	$.ajax({
	     type:"post",
	     url:"/smp/monthEventSelect",
		 data :(sendData),
	     success:function(result){
	    	 output(result);
	    	 $(".fc-day-number").removeAttr("data-goto");
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	  });
}

/*function subjectInsertFun()
{
	$('#insertSubject').replaceWith('<input type="text" name="smp_sch_title" id="insertSubject" style="height: 30px; font-size: 11px;">');
	$('#subjectInsertBtn').replaceWith('<button id="subjectOriginalBtn" onclick="subjectOriginal()">기존</button>');
}

function subjectOriginal()
{
	var tag = '<select name="smp_sch_title" id="insertSubject" style="height: 30px; font-size: 11px;">';
	tag += '<option value="일본어">일본어</option>'
	tag += '<option value="IT">IT</option>'
	tag += '<option value="기타공지사항">기타공지사항</option>'
	tag += '</select>'
	$('#insertSubject').replaceWith(tag);
	$('#subjectOriginalBtn').replaceWith('<button id="subjectInsertBtn" onclick="subjectInsertFun()">추가</button>');
}
*/

function addSubjectInsert()
{
	$('#updateSubject').replaceWith('<input type="text" name="smp_sch_title" id="updateSubject" style="height: 30px; font-size: 11px;">');
	$('#addSubjectInsertBtn').replaceWith('<button id="addSubjectOriginalBtn" onclick="addSubjectOriginal()">기존</button>');
}

function addSubjectOriginal()
{
	var tag = '<select name="smp_sch_title" id="updateSubject" style="height: 30px; font-size: 11px;">';
	tag += '<option value="일본어">일본어</option>'
	tag += '<option value="IT">IT</option>'
	tag += '<option value="기타공지사항">기타공지사항</option>'
	tag += '</select>'
	$('#updateSubject').replaceWith(tag);
	$('#addSubjectOriginalBtn').replaceWith('<button id="addSubjectInsertBtn" onclick="addSubjectInsert()">추가</button>');
}

function addTitleInsert()
{
	var cnt = $("#colorCnt").val();
	var maxlength = 5-cnt;
	
	var trLength = $("#insertSubjectModalTable tr").length;
	if(trLength<maxlength)
	{
		
		$("#newSubjectDeleteBtn").show();
		
		var tag = '<tr><td>';
		tag += '<input type="text" name="smp_sch_title" class="insertSubjectTitle" style="height: 30px; font-size: 11px;"></td>';
		tag += '<td><select name="smp_sch_color" class="insertColor" style="height: 30px; font-size: 11px;" onselect="selectCheck()">';
		tag += '<option value="#f26071">빨간색</option>';
		tag += '<option value="#667ff9">파란색</option>';
		tag += '<option value="#f9e770">노란색</option>';
		tag += '<option value="#f9b15e">주황색</option>';
		tag += '<option value="#cb2ef7" selected>보라색</option>';	
		tag += '</td></tr>';
		$("#insertSubjectModalTable").append(tag);
	}	
	else if(trLength==maxlength)
	{
		$("#newSubjectInsertBtn").hide();
		alert("과목 수가 초과되었습니다.");
	}	
}

function addTitleDelete()
{	
	var trLength = $("#insertSubjectModalTable tr").length;
	if(trLength==1)
	{
		$("#newSubjectDeleteBtn").hide();
		alert("더 이상 삭제가 불가능 합니다.");
	}	
	else
	{
		$("#insertSubjectModalTable > tbody > tr:last").remove();
		$("#newSubjectInsertBtn").show();
	}	
}

function newSubjectInsert()
{
	var gisu_seq = document.getElementById("getGisu").value;
	$.ajax({
	     type:"post",
	     url:"/smp/user/gisuTitleCheck",
		 data :{'gisu_seq': gisu_seq},
		 dataType : 'json',
	     success:function(result){
	    	 subjectInsertFun(result);
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}
function subjectInsertFun(result)
{
	var trLength = $("#insertSubjectModalTable tr").length;
	
	var subject = [];
	var colorList = [];
	var insertSubject = [];
	var insertColorList = [];
	for(var i in result.subject)
	{	
		var title = result.subject[i].smp_sch_title;
		var col = result.subject[i].smp_sch_color;
		var sub = {
			"smp_sch_title" : title
		};
		var color={
			"smp_sch_color" : col
		};
		subject.push(sub);
		colorList.push(color);
	}
	
	$('.insertSubjectTitle').each(function(){ 
		var test = $(this).val();
		if(test=='')
		{
			alert("과목명을 입력해주세요");
		}	
		else
		{
			var sub = {
					"smp_sch_title" : test };
			subject.push(sub);
			insertSubject.push(sub);
		}	
	}); 
	 
	for(var i=1;i<subject.length; i++)
	{
	      for(var j = 0; j < i ; j++){
	         
	    	  tmpA = subject[j].smp_sch_title;
	    	  tmpB = subject[i].smp_sch_title;
	         if(tmpA == tmpB){
	            alert("과목명이 중복되었습니다.");
	            return;
	         }
	      }
	}
	
	$('.insertColor').each(function(){ 
		 var test = $(this).val();
		 var col = {
				 "smp_sch_color" : test };
		 colorList.push(col);
		 insertColorList.push(col);
	}); 
	for(var i=1;i<colorList.length; i++)
	{
	      for(var j = 0; j < i ; j++){
	         
	    	 tmpA = colorList[j].smp_sch_color;
	         tmpB = colorList[i].smp_sch_color;
	         if(tmpA == tmpB){
	            alert("색상이 중복되었습니다.");
	            return;
	         }
	      }
	}
	
	var sssList = [];
	var gisu_seq = document.getElementById("getGisu").value;
	
	for(var i=0;i<insertColorList.length;i++)
	{
		 var sssc = {
					"gisu_seq" : gisu_seq,
					"smp_sch_title" : insertSubject[i].smp_sch_title,
					"smp_sch_color" : insertColorList[i].smp_sch_color
			};
			sssList.push(sssc);
	}	
	
	$.ajax({
	     type:"post",
	     url:"/smp/admin/schColorInsert",
		 data :JSON.stringify(sssList),
		 contentType : 'application/json',
	     success:function(result){
	    	if(result==true)
	    	{
	    		 $("#newSubjectInsertModal").modal('hide');
	    		 location.reload();
	    	}
	    	else
	    	{
	    		alert("색상을 다시 입력해주세요");
	    		$("#newSubjectInsertModal").modal('show');
	    		
	    	}	
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	  });
	
	
		
}
	

/*function newSubjectColorSetting()
{
	var subject = [{"smp_sch_title" : "일본어"}, {"smp_sch_title" : "IT"}, {"smp_sch_title" : "기타공지사항"}];
	var color = [{"smp_sch_color" : japanColor}, {"smp_sch_color" : itColor}, {"smp_sch_color" : etcColor}];
	
	var sssList = [];
	
	
	for(var i=0;i<3;i++)
	{
		 var sssc = {
					"gisu_seq" : gisu_seq,
					"smp_sch_title" : subject[i].smp_sch_title,
					"smp_sch_color" : color[i].smp_sch_color
			};
			sssList.push(sssc);
	}	
	
	$.ajax({
	     type:"post",
	     url:"/smp/admin/schColorInsert",
		 data :JSON.stringify(sssList),
		 contentType : 'application/json',
	     success:function(result){
	    	if(result==true)
	    	{
	    		 $("#insertColorModal").modal('hide');
	    	}
	    	else
	    	{
	    		alert("색상을 다시 입력해주세요");
	    		$("#insertColorModal").modal('show');
	    		
	    	}	
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	  });
}*/


function insertColor()
{
	var gisu_seq = document.getElementById("getGisu").value;
	
	var japanColor = $("#japanColor").val();
	var itColor = $("#itColor").val();
	var etcColor = $("#etcColor").val();
	
	if(japanColor==itColor)
	{
		alert("색깔을 다르게 지정해주세요");
		return;
	}
	else if(etcColor==itColor)
	{
		alert("색깔을 다르게 지정해주세요");
		return;
	}	
	else if(japanColor==etcColor)
	{
		alert("색깔을 다르게 지정해주세요");
		return;
	}
	
	var subject = [{"smp_sch_title" : "일본어"}, {"smp_sch_title" : "IT"}, {"smp_sch_title" : "기타공지사항"}];
	var color = [{"smp_sch_color" : japanColor}, {"smp_sch_color" : itColor}, {"smp_sch_color" : etcColor}];
	
	var sssList = [];
	
	
	for(var i=0;i<3;i++)
	{
		 var sssc = {
					"gisu_seq" : gisu_seq,
					"smp_sch_title" : subject[i].smp_sch_title,
					"smp_sch_color" : color[i].smp_sch_color
			};
			sssList.push(sssc);
	}	
	
	$.ajax({
	     type:"post",
	     url:"/smp/admin/schColorInsert",
		 data :JSON.stringify(sssList),
		 contentType : 'application/json',
	     success:function(result){
	    	if(result==true)
	    	{
	    		 $("#insertColorModal").modal('hide');
	    		 location.reload();
	    	}
	    	else
	    	{
	    		alert("색상을 다시 입력해주세요");
	    		$("#insertColorModal").modal('show');
	    		
	    	}	
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	  });
	
}

function colorInput(gisu_seq)
{
	$.ajax({
		     type:"post",
		     url:"/smp/user/gisuTitleCheck",
			 data :{'gisu_seq': gisu_seq},
			 dataType : 'json',
		     success:function(result){
		    	if(result.subject!=null)
		    	{
		    		var eventColorList = [];
		    		for(var i in result.subject)
			    	{
			    		var eventColor = { "smp_sch_color" : result.subject[i].smp_sch_color, 
			    							"smp_sch_title" :result.subject[i].smp_sch_title,
			    							"smp_sch_color_seq" : result.subject[i].smp_sch_color_seq	
			    		}
			    		eventColorList.push(eventColor);
			    	}
		    		eventColorFun(eventColorList);
		    		var cnt = result.subject.length;
		   			$("#colorCnt").val(cnt);
		    		updateColor(eventColorList);
		    	}
		     },
		     error:function(data)
		     {
		    	 alert("통신에러");
		     }
		    });
	
}

function eventColorFun(resp)
{
   $("#color").html('');
         
     var result = '';
     var colorList = {};
     result += '<div id="colorDiv" style="display: inline;">';
     
     for (var i in resp) {
        var sub;
         colorList[i] = resp[i].smp_sch_color;
        if(resp[i].smp_sch_color=='#f26071')
        {
           result += '<p name="smp_sch_color" id="smp_sch_color_red" class="sch_color"></p>';
        }
        else if(resp[i].smp_sch_color=='#667ff9')
        {
           result += '<p name="smp_sch_color" id="smp_sch_color_blue" class="sch_color"></p>';
        }
        else if(resp[i].smp_sch_color=='#f9e770')
        {
           result += '<p name="smp_sch_color" id="smp_sch_color_yellow" class="sch_color"></p>';
        }
        else if(resp[i].smp_sch_color=='#f9b15e')
        {
           result += '<p name="smp_sch_color" id="smp_sch_color_orange" class="sch_color"></p>';
        }
        else if(resp[i].smp_sch_color=='#cb2ef7')
        {
           result += '<p name="smp_sch_color" id="smp_sch_color_purple" class="sch_color"></p>';
        }
        
      result += '<p name="smp_sch_title">'+resp[i].smp_sch_title+'</p>';
      result += '<input type="hidden" class="smp_sch_color_seq" value="resp[i].smp_sch_color_seq"></div>'
   }
   var test = $("#getAuth").val();
   if(test == "Admin"){
   result += '<div id="sch_btn"><button class="blue_btn" onclick="colorChange()">색상변경</button>';
      if(i!=4)
      {
         result += '<button onclick="subjectInsert()">과목추가</button></div>';
      }   
   }
   result += '</div>';
   $("#color").html(result);
   
   for(var i in resp){
      var tag = '';
      tag += '<tr><td width="50">';
      tag += '<input type="checkbox" class="deleteCheckbox" value="'+resp[i].smp_sch_color_seq+'" hidden></td>';
      tag += '<td><input type="text" value="'+resp[i].smp_sch_title+'" class="update_smp_sch_title">';
      tag += '</td>';
      tag += '<td><select name="smp_sch_color" id="updateColorSelection" class="updateColorSelection" style="height: 30px; font-size: 11px;">';
      if(colorList[i]=="#f26071"){
         tag += '<option selected="selected" value="#f26071">빨간색</option>';
      }else{
         tag += '<option value="#f26071">빨간색</option>';
      }
      if(colorList[i]=="#667ff9"){
         tag += '<option selected="selected" value="#667ff9">파란색</option>';
      }else{
         tag += '<option value="#667ff9">파란색</option>';
      }
      if(colorList[i]=="#f9e770"){
         tag += '<option selected="selected" value="#f9e770">노란색</option>';
      }else{
         tag += '<option value="#f9e770">노란색</option>';
      }
      if(colorList[i]=="#f9b15e"){
         tag += '<option selected="selected" value="#f9b15e">주황색</option>';
      }else{
         tag += '<option value="#f9b15e">주황색</option>';
      }
      if(colorList[i]=="#cb2ef7"){
         tag += '<option selected="selected" value="#cb2ef7">보라색</option>';
      }else{
         tag += '<option value="#cb2ef7">보라색</option>';
      }
      
      tag += '</select></td>';
      tag += '<input type="hidden" value="'+resp[i].smp_sch_color_seq+'" class="update_smp_sch_color_seq">';
      tag += '</tr>';
      $("#updateColorModalTable").append(tag);
   }
   
}

function colorChange()
{
	$("#updateColorModal").modal('show');
}

function subjectInsert()
{
	$("#newSubjectInsertModal").modal('show');
}

function updateColor()
{
	
	/*$(".updateColorSelection").off().on("change", function(){
		
		var targetColor = $(this).val();
		var count = 0;
		
		$.each($(".updateColorSelection"), function(index , item){
			if($(this).val() == targetColor){
				count++;
			}
		});
		
		if(count > 1){
			alert("같은색상이 있습니다.");
			return;
		}
	});*/
	
	$("#updateColorBtn").on("click", function(){
		var subject = [];
		$('.update_smp_sch_title').each(function(){ 
			 var test = $(this).val();
			 if(test=="")
			 {
				 alert("과목명을 입력해주세요");
				 return;
			 }	 
			 else
			 { 
				 var sub = {
						 "smp_sch_title" : test };
				 subject.push(sub);
			 } 
		}); 
		
		for(var i=1;i<subject.length; i++)
		{
		      for(var j = 0; j < i ; j++){
		         
		    	  tmpA = subject[j].smp_sch_title;
		    	  tmpB = subject[i].smp_sch_title;

		         if(tmpA == tmpB){
		            alert("과목명이 중복되었습니다.");
		            return;
		         }
		      }
		}
			
		
		
		var color = [];
		$('.updateColorSelection').each(function(){ 
			 var test = $(this).val();
			 var col = {
					 "smp_sch_color" : test
			 };
			 
			 color.push(col);
		}); 
		for(var i=1;i<color.length; i++)
		{
		      for(var j = 0; j < i ; j++){
		         
		    	 tmpA = color[j].smp_sch_color;
		         tmpB = color[i].smp_sch_color;
		         if(tmpA == tmpB){
		            alert("색상이 중복되었습니다.");
		            return;
		         }
		      }
		}
		
		var color_seq = [];
		$('.update_smp_sch_color_seq').each(function(){ 
			 var test = $(this).val();
			 var seq = {
					 "smp_sch_color_seq" : test
			 };
			 
			 color_seq.push(seq);
		}); 
		
		var gisu_seq = document.getElementById("getGisu").value;
		var sendData = [];
		for(var i=0;i<color.length;i++)
		{
			send = {
					"gisu_seq" : gisu_seq,
					"smp_sch_title" : subject[i].smp_sch_title,
					"smp_sch_color" : color[i].smp_sch_color,
					"smp_sch_color_seq" : color_seq[i].smp_sch_color_seq
			};
			sendData.push(send);
		}	
		
		$.ajax({
		     type:"post",
		     url:"/smp/admin/schColorUpdate",
			 data :JSON.stringify(sendData),
			 contentType : 'application/json',
		     success:function(result){
		    	if(result==true)
		    	{
		    		$("#updateColorModal").modal('hide');
		    		location.reload();
		    	}
		    	else
		    	{
		    		alert("색상을 다시 입력해주세요");
		    		$("#updateColorModal").modal('show');
		    	}	
		     },
		     error:function(data)
		     {
		    	 alert("통신에러");
		     }
		  });
	});
	
	
}

function deleteColor()
{
	$(".deleteCheckbox").show();
	var seqList = [];
	$('.deleteCheckbox:checked').each(function() { 
		var smp_sch_color_seq = $(this).val();
		var color_seq = {
				"smp_sch_color_seq" : smp_sch_color_seq
		};
		
		seqList.push(color_seq);
		$.ajax({
   	     type:"post",
   	     url:"/smp/admin/schColorDelete",
   		 data :JSON.stringify(seqList),
   		 contentType : 'application/json',
   	     success:function(result){
   	    	if(result==true)
   	    	{
   	    		 location.reload();
   	    	}
   	     },
   	     error:function(data)
   	     {
   	    	 alert("통신에러");
   	     }
   	  	});
   });

	
}



	