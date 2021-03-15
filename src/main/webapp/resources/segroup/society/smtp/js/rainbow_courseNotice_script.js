//과정공지사항 리스트
var courseList;

$(document).ready(function(){
	$('.courseH').html(course_name + ' 공지사항');
	$('.cardinalP').html(cardinal_name);
	setCourseNotice();
	setCourseNoticeEvent();
});

//컨텐츠 세팅
function setCourseNotice() {
	$('#courseNoticeListUl').html('');
	getCourseNoticeList();
	setCourseNoticeData();
}

function getCourseNoticeList() {
	
	var course_id = $(':hidden[name=course_id]').val();
	var cardinal_id = $(':hidden[name=cardinal_id]').val();
	var params = $('#courseSearchForm').serializeObject();
	params.course_id = course_id;
	params.cardinal_id = cardinal_id;
	params.board_type = 1;
	params.startPage = $('#startPage').val();
	params.visiblePages = 10;
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		async : false,
		url : "/smtp/community/courseNoticeList",
		data: params,
		success : function(result) {
			courseList = result;
		}
	});
}
function setCourseNoticeData() {
	var content = '';
	$.each(courseList, function(index,item) {
		var reg_date = item.reg_date.substr(0,4) + '-' + item.reg_date.substr(4,2) + '-' + item.reg_date.substr(6,2);
		content += '<li class="class-list d-flex" onclick="courseNoticePopup(' + item.id + ')">';
		content += 		'<div class="c-table-num">' + (index + 1) + '</div>';
		content += 		'<div class="c-table-name-wide">' + item.title + '</div>';
		content += 		'<div class="c-table-02">' + reg_date + '</div>';
		content += 		'<div class="c-table-num">' + item.hits + '</div>';
		content +=	'</li>';
	});
	if(content == '') {
		content += '<li class="listAndwrap">';
		content += 		'<div class="class-list justify_center">조회된 내용이 없습니다.</div>';
		content += '</li>';
	}
	$('#courseNoticeListUl').html(content);
}
function courseNoticePopup(id) {
	window.open('/smtp/community/sub04-view-notice?id=' + id,'_blank','width=1020px, height=1000px, toolbars=no, scrollbars=yes');
}
function setCourseNoticeEvent() {
	$('#courseSearchBtn').on('click', function() {
		setCourseNotice();
	});
}