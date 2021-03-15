//list 값 들어가는 곳
var data;
//전체 data길이(중요글+그냥글)
var totalCnt = 0;

$(document).ready(function(){
//	setContent();
//	setEvent();
});

//컨텐츠 세팅
function setContent() {
	$('#dataListUl').html('');
	getImpList();
	setDataListUl(1);
	getNomalList();
	setDataListUl(0);
	pagingFunc();
}

function setEventContent() {
	$('#eventDataListUl').html('');
	getEventImpList();
	setDataListUl(1);
	getEventNomalList();
	setDataListUl(0);
	pagingFunc();
}

//공지사항 리스트 가져오기
function getNomalList() {
	
	var params = new FormData($('#searchForm')[0]);
	params.append('startPage', parseInt($('#startPage').val()));
	params.append('board_gb', 'A0306');
	params.append('board_detail_gb', 'A1702');
	
	$.ajax({
		type : "POST",
		processData : false,
		contentType : false,
		dataType : "json",
		url : "/lms/community/noticeList",
		data: params,
		async : false,
		success : function(list) {
			data = list;
			totalCnt += data.length;
		}
	});
}
//중요글은 무조건 나오게 그냥 따로 받음
function getImpList() {
	var params = new Object();
	params.board_gb = 'A0306';
	params.board_detail_gb = 'A1702';
	params.board_content_imp = 'A1100';
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		url : "/lms/community/noticeList",
		data: params,
		async : false,
		success : function(list) {
			data = list;
			totalCnt += data.length;
		}
	});
}
//컨텐츠 세팅
function setDataListUl(imp) {
	var content = '';
	var check = '';
	if(data != null && data.length != 0) {
		$.each(data, function(index, item) {
			content += '<li class="class-list d-flex">';
			content += 		'<div class="c-table-num">';
			if(imp == 1) content += '<div class="img-icon pin"></div>';
			else content += (index+1);
			content +=			'<input type="hidden" name="board_content_seq" value="' + item.board_content_seq + '">';
			content += 		'</div>';
			content += 		'<div class="c-table-name-w">';
			content += 			'<p class="text-over-lh20">'+ item.board_content_title +'</p>';
			content += 		'</div>';
			content += 		'<div class="c-table-02 c-table-date">'+ getDateFormat(item.board_content_ins_dt) +'</div>';
			content += 		'<div class="c-table-02 c-table-iconAlign">';
			content += 			'<div class="d-flex icon-align">';
			if(item.boardGt.board_detail_gb == 'A1702') {
				content += 			'<div class="img-icon bullhorn-s"></div>';
			}
			else if(item.boardGt.board_detail_gb == 'A1703') {
				content += 			'<div class="img-icon gift"></div>';
			}
			content += 				'<p class="text-over-lh20">';
			switch(item.boardGt.board_detail_gb) {
			case 'A1702':
				content += '공지사항';
				break;
			case 'A1703':
				content += '이벤트';
				check = 'A1703'
				break;
			}
			content += 				'</p>';
			content += 			'</div>';
			content += 		'</div>';
			content += 		'<div class="c-table-01">'+ item.board_content_hit +'</div>';
			content += '</li>';
		});
	}
	if(content == '' && imp == 0) {
		content += '<li class="listAndwrap">';
		content += 		'<div class="class-list justify_center">조회된 내용이 없습니다.</div>';
		content += '</li>';
	}
	
	if(check == 'A1703') {
		$('#eventDataListUl').append(content);
	} else {
		$('#dataListUl').append(content);
	}
	
	
}
//pagination에 필요한 값들 세팅하는 메소드
function pagingFunc() {
	var startPage = parseInt($('#startPage').val());
	var visiblePages = 10;
	var totalPages = (totalCnt / visiblePages) < 0 ? 1 : Math.ceil(totalCnt / visiblePages);
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
// 이벤트 부분 시작 
function getEventNomalList() {
	
	var params = new FormData($('#searchForm')[0]);
	params.append('startPage', parseInt($('#startPage').val()));
	params.append('board_gb', 'A0306');
	params.append('board_detail_gb', 'A1703');
	
	$.ajax({
		type : "POST",
		processData : false,
		contentType : false,
		dataType : "json",
		url : "/lms/community/noticeList",
		data: params,
		async : false,
		success : function(list) {
			data = list;
			totalCnt += data.length;
		}
	});
}
//중요글은 무조건 나오게 그냥 따로 받음
function getEventImpList() {
	var params = new Object();
	params.board_gb = 'A0306';
	params.board_detail_gb = 'A1703';
	params.board_content_imp = 'A1100';
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		url : "/lms/community/noticeList",
		data: params,
		async : false,
		success : function(list) {
			data = list;
			totalCnt += data.length;
		}
	});
}

//이벤트 연결
function setEvent() {
	//상세보기
	$('li.class-list').on('click', function(){
		var board_content_seq = $(this).find('input[name=board_content_seq]').val();
		$('#search_seq').val(board_content_seq);
		window.open('/lms/community/sub05-view-notice?board_content_seq=' + board_content_seq,'_blank','width=1020px, height=1000px, toolbars=no, scrollbars=yes')
	});
	//검색
	$('#searchBtn').on('click', function(){
		setContent();
	});
	$('#searchEventBtn').on('click', function(){
		setEventContent();
	});
}
//timestamp -> date 형식변환
function getDateFormat(timestamp) {
	
	var dateVal = new Date(timestamp);
	var year = dateVal.getFullYear();
	var month = dateVal.getMonth() + 1;
	var day = dateVal.getDate();
	var time = dateVal.getHours();
	var min = dateVal.getMinutes();
	var sec = dateVal.getSeconds();
	var formattedVal = year + '-' + month + '-' + day + ' ' + time + ':' + min + ':' + sec;
	
	return formattedVal;
}