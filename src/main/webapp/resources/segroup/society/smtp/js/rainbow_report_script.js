$(document).ready(function(){
	userReport();
});

//컨텐츠 세팅
function userReport() {
	var course = $(':hidden[name=course_id]').val();
	var cardinal = $(':hidden[name=cardinal_id]').val();
	
	 $.ajax({
			contentType : "application/json",
			dataType : "json",
			type	: "get",
			url		: "/smtp/mypage/selectExamList",
			cache: false,
			async : false,
			data    : {
				"course" : course
				,"cardinal" : cardinal
				,"quiz_type" : "3"
			},
			success : function (data) {
				var bContent = "";
				
				if(data != '') {
						$.each(data, function(index, asList) {
							
							bContent += '<li class="listAndwrap reportup">';
							bContent += '<form name="reportForm" method="post" class="form-inline report'+index+'" onsubmit="return false;">';
							bContent += '<input type="hidden" name="id" value="'+asList.learnappid+'" />'
							bContent += '<input type="hidden" name="pagingYn" value="N" />';
							bContent += '<input type="hidden" name="useYn" value="Y" />'
							bContent += '<input type="hidden" name="quiz_type" value="3" />';
							bContent += '<input type="hidden" name="course" value="'+course+'" />';
							bContent += '<input type="hidden" name="cardinal" value="'+cardinal+'" />';
							bContent += '<input type="hidden" name="quiz" value="'+asList.ID+'">';
							bContent += '<input type="hidden" name="takeYn" value="'+asList.TAKE_YN+'">';
							bContent += '<input type="hidden" name="ready" value="'+asList.IS_READY+'">';
							bContent += '<input type="hidden" name="correct" value="'+asList.CORRECT+'">';
							bContent += '</form>';
							
							if(asList.TAKE_YN != '0' && asList.USE_YN == 'Y') {
								bContent += '<div class="class-list board-list open-answer d-flex">';
							} else {
								bContent += '<div class="class-list d-flex">';
							}
		                    bContent += '<div class="c-table-num">'+(index+1)+'</div>'
							bContent += '<div class="c-table-name-wide">' + asList.TITLE+ '</div>';
                         if(asList.IS_READY == 'Y') {
                             bContent += '<div class="c-table-02 c-table-date" data-value='+asList.END_DATE+'>'+ asList.START_DATE + ' - ' + asList.END_DATE + '</div>';	
                         } else {
                             bContent += '<div class="c-table-02 c-table-date" data-value='+asList.END_DATE+'>기간이 끝나 제출이 마감되었습니다.</div>';
                         }

                         if(asList.TAKE_YN != '0' && asList.QUIZ_SCORE == '-'){
                             bContent += '<div class="c-table-01 c-table-btn"><span class="btn_normal btn_default btn_xsmall h5">검토중</span></div>';
                         } else if(asList.TAKE_YN != '0' && asList.USE_YN == 'Y') {
                        	 bContent += '<div class="c-table-01 c-table-btn"><span class="btn_normal btn_default btn_xsmall h5 fc_true">제출완료</span></div>';
                         } else {
                        	 bContent += '<div class="c-table-01 c-table-btn"><span class="btn_normal btn_default btn_xsmall h5 fc_false">미제출</span></div>';
                         }
                         if(!asList.QUIZ_SCORE) {
                             bContent += '<div class="c-table-01"><strong class="score">-</strong>/'+asList.SCORE+'</div></li>';
                         } else {
                             bContent += '<div class="c-table-01"><strong class="score">'+asList.QUIZ_SCORE+'</strong>/'+asList.SCORE+'</div></li>';	
                         }
						});
				} else {
					bContent += '<li class="class-list d-flex"><div class="c-table-03 not"><p>과제정보가 존재하지 않습니다.</p></div></li>';
				}
				$('.class-list-wrap.report').empty().append(bContent);
			},
			error :  function(request, status, error) {
				alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
			}
			
		}); 
}

$(document).on('click', '.reportup', function(){
	var idx = $('.reportup').index($(this));
	var reportForm = $(".report"+idx+"")[0];
	
	var end = $(this).children().eq(1).find('.c-table-date').data('value');
	
	var today = new Date();
	var eDate = new Date(end.split("-")[0], (end.split("-")[1])-1,end.split("-")[2], "23", "50");
	
	if(today.getTime() - eDate.getTime() > 0) {
//		alert("제출기한이 지났습니다.");
//		return;
	} else if(Math.floor((today.getTime() - eDate.getTime())/1000/60) >= -10) {
		alert("제출기한 이후에는 제출이 불가합니다.");
	}
	
	window.open("", 'openWindow', 'width=1020px, height=1000px, toolbars=no, scrollbars=yes')
	
	reportForm.action = "/popup/smtpReport"; 
	reportForm.target = "openWindow"; 
	
	reportForm.submit();
});
