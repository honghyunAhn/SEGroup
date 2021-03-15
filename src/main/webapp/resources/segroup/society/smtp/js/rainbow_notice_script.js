//list 값 들어가는 곳
var data;
//전체 data길이(중요글+그냥글)
var totalCnt = 0;

$(document).ready(function(){
	setContent();
	setEvent();
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
//중요글은 무조건 나오게 그냥 따로 받음
function getImpList() {
	
	var params = new Object();
	params.board_gb = 'A0307';
	params.board_detail_gb = 'A1704';
	params.board_content_imp = 'A1100';
	
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
function setDataListUl(imp) {
	var content = '';
	if(data != null && data.length != 0) {
		$.each(data, function(index, item) {
			content += '<li class="class-list d-flex">';
			content += 		'<div class="c-table-num">';
			if(imp == 1) content += '<div class="img-icon pin"></div>';
			else content += (index+1);
			content +=			'<input type="hidden" name="board_content_seq" value="' + item.board_content_seq + '">';
			content += 		'</div>';
			content += 		'<div class="c-table-name-wide">';
			content += 			'<a href="#">';
			content += 				'<div class="d-flex icon-align">';
			content += 					'<div class="color-box bgc_eg">NEW</div>';
			content += 					'<p class="text-over-lh20">'+ item.board_content_title +'</p>';
			content += 				'</div>';
			content += 			'</a>';
			content += 		'</div>';
			content += 		'<div class="c-table-02 c-table-date">'+ getDateFormat(item.board_content_ins_dt) +'</div>';
			content += 		'<div class="c-table-02 c-table-iconAlign">';
			content += 			'<div class="d-flex icon-align">';
			if(item.boardGt.board_detail_gb == 'A1704') {
				content += 			'<div class="img-icon bullhorn-s">공지사항</div>';
			}
			else if(item.boardGt.board_detail_gb == 'A1705') {
				content += 			'<div class="img-icon gift"></div>';
			}
			content += 				'<p class="text-over-lh20">';
			switch(item.boardGt.board_detail_gb) {
			case 'A1704':
				content += '공지사항';
				break;
			case 'A1705':
				content += '이벤트';
				break;
			}
			content += 			'공지사항';
			content += 				'</p>';
			content += 			'</div>';
			content += 		'</div>';
			content += 		'<div class="c-table-num">'+ item.board_content_hit +'</div>';
			content += '</li>';
		});
	}
	if(content == '' && imp == 0) {
		content += '<li class="listAndwrap">';
		content += 		'<div class="class-list justify_center">조회된 내용이 없습니다.</div>';
		content += '</li>';
	}
	$('#dataListUl').append(content);
}

//pagination에 필요한 값들 세팅하는 메소드
function pagingFunc() {
	var startPage = parseInt($('#startPage').val());
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
	//상세보기
	$('li.class-list').on('click', function(){
		var board_content_seq = $(this).find('input[name=board_content_seq]').val();
		$('#search_seq').val(board_content_seq);
		window.open('/smtp/community/sub04-view-notice?board_content_seq=' + board_content_seq,'_blank','width=1020px, height=1000px, toolbars=no, scrollbars=yes')
	});
	//검색
	$('#searchBtn').on('click', function(){
		setContent();
	});
}
