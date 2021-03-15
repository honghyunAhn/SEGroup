//list 값 들어가는 곳
var data;
//전체 data길이(중요글+그냥글)
var totalCnt = 0;

$(document).ready(function(){
	setSurveyDataListUl();
	//setSurveyContent();
	//setEvent();
});

$(document).on('click', '.surveyItem', function(){
	var idx = $('.surveyItem').index($(this));
	var surveyForm = $(".survey"+idx)[0];
	
	window.open('', 'detail', 'width=1020px, height=1000px, toolbars=no, scrollbars=yes');
	
	surveyForm.action = "/smtp/myLecture/sub05-view-survey"; 
	surveyForm.target = "detail"; 
	surveyForm.submit();
});



//컨텐츠 세팅
function setSurveyContent() {
	//$('#dataListUl').html('');
	setSurveyDataListUl();
	/*getNomalList();
	setDataListUl(0);
	pagingFunc();*/
}

//공지사항 리스트 가져오기
//관리자에서 이벤트 글 작성도 가능하기는 한데 현재 사용예정없음
//그래서 일단 공지사항만 가져오게끔 param으로 설정해놓음
function getNomalList() {
	
	var params = $('#searchForm').serializeObject();
	params.startPage = $('#startPage').val();
	params.board_gb = 'A0307';
	params.board_detail_gb = 'A1704';
	
	delete params.board_content_seq;
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		url : "/smtp/community/noticeList",
		data: params,
		async : false,
		success : function(list) {
			data = list;
			totalCnt += data.length;
		}
	});
}

//컨텐츠 세팅
function setSurveyDataListUl() {
	var course = $('input[name=course_id]').val();
	var cardinal = $('input[name=cardinal_id]').val();
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		url		: "/smtp/myLecture/surveyList",
		data : {
					course : course
					,cardinal : cardinal
				},
		success : function(data) {
			
				var sContent = "";
				if(data != '') {
					$.each(data, function(index, survey) {
						if(survey.SURVEY_STATE == 'OPEN'){
							sContent += '<li class="surveyItem">';
							sContent += '<form method="post" class="form-inline survey'+index+'" onsubmit="return false;">';
							sContent += '<input type="hidden" name="survey_seq" value="'+survey.SURVEY_SEQ+'" />'
							sContent += '<input type="hidden" name="survey_title" value="'+survey.SURVEY_TITLE+'" />';
							sContent += '<input type="hidden" name="survey_content" value="'+survey.SURVEY_CONTENT+'" />';
							sContent += '<input type="hidden" name="survey_start_date" value="'+survey.SURVEY_START_DATE+'" />';
							sContent += '<input type="hidden" name="survey_end_date" value="'+survey.SURVEY_END_DATE+'" />';
							sContent += '<input type="hidden" name="survey_state" value="OPEN" />';
							sContent += '<input type="hidden" name="survey_answer_state" value="'+survey.SURVEY_ANSWER_STATE+'" />';
							sContent += '<input type="hidden" name="course_id" value="'+course+'" />';
							sContent += '<input type="hidden" name="cardinal_id" value="'+cardinal+'" />';
							sContent += '</form>';
							sContent += '<div class="class-list d-flex">';
							sContent += '<div class="c-table-num">' + (index + 1) + '</div>';
							sContent += '<div class="c-table-03">'+survey.COURSE_NM+'</div>';
							sContent += '<div class="c-table-name-w">'+survey.SURVEY_TITLE+'</div>';
							sContent += '<div class="c-table-02 c-table-date">'+ survey.SURVEY_START_DATE + ' - ' + survey.SURVEY_END_DATE +'</div>';
							sContent += '<div class="c-table-01 c-table-btn">';
							sContent += '<span class="btn_normal btn_default btn_xsmall h5">진행중</span>';
							sContent += '</div>';
							sContent += '</div>';
							sContent += '</a>';
							sContent += '</li>';
							
						}else if(survey.SURVEY_STATE == 'CLOSED'){
							sContent += '<li class="surveyItem">';
							sContent += '<form method="post" class="form-inline survey'+index+'" onsubmit="return false;">';
							sContent += '<input type="hidden" name="survey_seq" value="'+survey.SURVEY_SEQ+'" />'
							sContent += '<input type="hidden" name="survey_title" value="'+survey.SURVEY_TITLE+'" />';
							sContent += '<input type="hidden" name="survey_content" value="'+survey.SURVEY_CONTENT+'" />';
							sContent += '<input type="hidden" name="survey_start_date" value="'+survey.SURVEY_START_DATE+'" />';
							sContent += '<input type="hidden" name="survey_end_date" value="'+survey.SURVEY_END_DATE+'" />';
							sContent += '<input type="hidden" name="survey_state" value="CLOSED" />';
							sContent += '<input type="hidden" name="survey_answer_state" value="'+survey.SURVEY_ANSWER_STATE+'" />';
							sContent += '<input type="hidden" name="course_id" value="'+course+'" />';
							sContent += '<input type="hidden" name="cardinal_id" value="'+cardinal+'" />';
							sContent += '</form>';
							sContent += '<div class="class-list d-flex">';
							sContent += '<div class="c-table-num">' + (index + 1) + '</div>';
							sContent += '<div class="c-table-03">'+survey.COURSE_NM+'</div>';
							sContent += '<div class="c-table-name-w">'+survey.SURVEY_TITLE+'</div>';
							sContent += '<div class="c-table-02 c-table-date">'+ survey.SURVEY_START_DATE + ' - ' + survey.SURVEY_END_DATE +'</div>';
							sContent += '<div class="c-table-01 c-table-btn">';
							sContent += '<span class="btn_normal btn_default btn_xsmall h5">마감</span>';
							sContent += '</div>';
							sContent += '</div>';
							sContent += '</a>';
							sContent += '</li>'
						}
					});
				}else {
					sContent += '<li><p>설문조사 정보가 존재하지 않습니다.</p></div></li>';
				}
				$('.class-list-wrap.survey').empty().append(sContent);
		},
		error :  function(request, status, error) {
			alert("code : "+request.status+"\n\n"+"message : "+request.responseText+"\n\n"+"error : "+error);
		}
	
	});
}

//pagination에 필요한 값들 세팅하는 메소드
function pagingFunc() {
	var startPage = $('#startPage').val();
	var visiblePages = 10;
	var totalPages = Math.ceil(totalCnt/visiblePages);
	pagination(totalPages, visiblePages, startPage);
}
function pagination(totalPages, visiblePages, startPage) {
	if(totalPages != 0 && totalPages != null) {
		$('#pagination').twbsPagination({
	        totalPages: totalPages,
	        visiblePages: visiblePages,
	        startPage: startPage,
	        first : "",
		    prev : '<a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a>',
			next : '<a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a>',
			last : "",
	        initiateStartPageClick : false,
	        onPageClick: function (event, page) {
	        	$('#startPage').val(page);
				setContent();
	        }
		});
	}
	//pagination css 포맷에 맞게 설정하는 작업
 	$('.page-item').children().addClass('num');
	$('.page-item.active').children().addClass('active'); 
	
}
//이벤트 연결
function setEvent() {
	//검색
	$('#searchBtn').on('click', function(){
		setContent();
	});
}
