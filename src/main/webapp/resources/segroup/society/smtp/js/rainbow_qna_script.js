$(document).ready(function() {
	//헤더의 제목입력
	$('.courseHQna').html(course_name + ' QnA');
	$('.cardinalPQna').html(cardinal_name);
	setStaticEvent();
});

//qna 메뉴 눌렀을 때 초기화
function qnaMain() {
	$('#qnaSearchForm').find('select[name=searchCondition] option:eq(0)').prop('selected', true);
	$('#qnaSearchForm').find('input[name=searchKeyword]').val('');
	getQnaList();
	//리스트 div 보이기
	switchDivView(0);
}

//qna 리스트 가져오기(댓글도 가져옴)
function getQnaList(id) {
	//기본 param - 과정/기수에 해당하는 리스트를 모두 가져옴
	var params = $('#qnaSearchForm').serializeObject();
	var course_id = $(':hidden[name=course_id]').val();
	var cardinal_id = $(':hidden[name=cardinal_id]').val();
	params.course_id = course_id;
	params.cardinal_id = cardinal_id;
	params.board_type = 6;
	//상세보기용 param - id로 하나만 select함
	params.id = id;
	
	//페이징용 param
	//qna 리스트용
	params.visiblePages = 10;
	params.startPage = ($('#qnaStartPage').val() - 1) * 10;
	//reply 리스트용
	params.replyVisiblePages = 5;
	params.replyStartPage = ($('#replyStartPage').val() - 1) * 5;
	
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		url : "/smtp/community/courseQnaList",
		data: params,
		success : function(result) {
			
//			console.log(result);
			//1.상세보기용일때
			if(id !== undefined && id != null) {
				setQnaFormDiv(result.qnaList[0]);
				//페이징 초기화
				$('#replyPagination').twbsPagination('destroy');
				//댓글 여부에 따른 처리
				if(result.qnaReplyTotalCnt > 0) {
					//리스트 값 뿌리기
					setReplyListUl(result.qnaReplyList);
					//페이징
					replyPagination(result.qnaReplyList, result.qnaReplyTotalCnt);
				} else {
					//리스트 초기화
					$('#replyListUl').html('');
				}
				//화면전환
				switchDivView(2);
				
			// 2.qna리스트 보기일때
			} else {
				//페이징 초기화
				$('#qnaPagination').twbsPagination('destroy');
				//리스트 값 뿌려주기
				setQnaListUl(result.qnaList);
				//페이징
				if(result.qnaListTotalCnt > 0) qnaPagination(result.qnaList, result.qnaListTotalCnt);
				//화면전환
				switchDivView(0);
			}
			//동적 태그 이벤트 연결
			setDynamicEvent();
			
		}, error : function() {
			alert('리스트 불러오기에 실패했습니다.');
		}
	});
}
//qna 리스트 세팅
function setQnaListUl(list) {
	
	var content = '';
	
	$.each(list, function(index,item) {
		
		var reg_date = item.reg_date.substr(0,4) + '-' + item.reg_date.substr(4,2) + '-' + item.reg_date.substr(6,2);
		content += '<li class="class-list qnaList d-flex">';
		content += 		'<div class="c-table-num">' + (index + 1);
		content += 			'<input type="hidden" name="id" value="' + item.id + '">';
		content +=			'<input type="hidden" name="reg_user" value="' + item.reg_user + '">';
		content += 		'</div>';
		content += 		'<div class="c-table-name-wide">' + item.title;
		if(item.replyCnt != 0) content += ' (' + item.replyCnt + ')';
		content +=		'</div>';
		content += 		'<div class="c-table-01">';
		if(item.file.length != 0) content += 'O';
		else content += '-';
		content += 		'</div>';
		content += 		'<div class="c-table-num">' + item.hits + '</div>';
		content += 		'<div class="c-table-02">' + rpad(item.reg_user.substr(0,3),item.reg_user.length,'*') + '</div>';
		content += 		'<div class="c-table-02">' + reg_date + '</div>';
		content += 	'</li>';
	});
	if(content == '') {
		content += '<li class="listAndwrap">';
		content += 		'<div class="class-list justify_center">조회된 내용이 없습니다.</div>';
		content += '</li>';
	}
	$('#qnaListUl').html(content);
}
//상세보기 값 세팅
function setQnaFormDiv(detail) {
	var form = $('#qnaActionForm');
	var user_id = $(':hidden[name=user_id]').val();
	var reg_date = detail.reg_date.substr(0,4) + '-' + detail.reg_date.substr(4,2) + '-' + detail.reg_date.substr(6,2);
	
	//게시글 고유번호
	form.find(':hidden[name=id]').val(detail.id);
	
	//상세내용 확인 세팅
	form.find('.post-title > .view > .label').html(detail.title);
	form.find('.post-content > .view > .label').html(detail.comment);
	form.find('.post-author > .label').html(rpad(detail.reg_user.substr(0,3), detail.reg_user.length, '*'));
	form.find('.post-date > .label').html(reg_date);
	
	//첨부파일 있을때
	if(detail.file.length != 0) {
		var file = detail.file[0];
		var downloadTag = '<a href="/file_download?origin=' + file.origin_file_name + '&saved=' + file.file_name
		+ '&path=uploadImage">'
		+ '<b>' + file.origin_file_name + '</b>'
		+ '</a>';
		form.find('.post-file > .view').html(downloadTag);
		
		//작성자면 삭제버튼 + 값 세팅
		var delBtnTag = '<input type="button" class="btn_normal margin-left10 btn_small btn_pp btn-agree btn-wh" id="delFile" value="삭제">';
		if(detail.reg_user == user_id) form.find('.post-file > .view').append(delBtnTag);
		form.find(':hidden[name=file_id]').val(file.file_id);
	} else {
		form.find('.post-file > .view').html('');
	}
	
	//수정하기용 세팅
	form.find('input[name=title]').val(detail.title);
	form.find('textarea[name=comment]').val(detail.comment);
	
	//작성자가 같으면 수정/삭제 div 활성화
	if(detail.reg_user == user_id) $('.modDiv').removeAttr('hidden');
	else $('.modDiv').attr('hidden','hidden');
	
}
//댓글목록 세팅
function setReplyListUl(list) {
	var content = '';
	$.each(list, function(index,item) {
		var reg_date = item.reg_date.substr(0,4) + '-' + item.reg_date.substr(4,2) + '-' + item.reg_date.substr(6,2);
		content += '<li class="class-list replyList d-flex">';
		content += 		'<input type="hidden" name="id" value="' + item.id + '">';
		content += 		'<div class="c-table-02">' + rpad(item.user_id.substr(0,3), item.user_id.length, '*') + '</div>';
		content += 		'<div class="c-table-name-wide">' + item.comment + '</div>';
		content += 		'<div class="c-table-num">' + item.recommend + '</div>';
		content += 		'<div class="c-table-01"><input type="button" class="recommendBtn margin-left10 btn_normal btn_small btn_pp_bg" value="추천"></div>';
		content += 		'<div class="c-table-num">' + item.nonrecommend + '</div>';
		content += 		'<div class="c-table-01"><input type="button" class="nonRecommendBtn margin-left10 margin-left10 btn_normal btn_small btn_pp btn-agree btn-wh" value="비추천"></div>';
		content += 		'<div class="c-table-01">' + reg_date + '</div>';
		content +=		'<div class="c-table-01">'
		if(item.user_id == $(':hidden[name=user_id]').val()) {
			content += 	'<input type="button" class="delReply margin-left10 btn_normal btn_small btn_pp btn-agree btn-wh" value="삭제">';
		}
		content +=		'</div>';
		content +=	'</li>';
	});
	$('#replyListUl').html(content);
}
//qna 게시글 페이징
function qnaPagination(list, totalCnt) {
	var visiblePages = 10;
	var totalPages = (totalCnt / visiblePages) < 0 ? 1 : Math.ceil(totalCnt / visiblePages);
	var startPage = parseInt($('#qnaStartPage').val());
	$('#qnaPagination').twbsPagination({
        totalPages: totalPages,
        visiblePages: visiblePages,
        startPage: startPage,
        first : "",
        prev : '<a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a>',
        next : '<a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a>',
        last : "",
        initiateStartPageClick : false,
        onPageClick: function (event, page) {
        	$('#qnaStartPage').val(page);
        	getQnaList();
        }
	});
}
//qna 댓글 페이징
function replyPagination(list, totalCnt) {
	var visiblePages = 5;
	var totalPages = (totalCnt / visiblePages) < 0 ? 1 : Math.ceil(totalCnt / visiblePages);
	var startPage = parseInt($('#replyStartPage').val());
	
	var board_id = $('#qnaActionForm').find(':hidden[name=id]').val();
	$('#replyPagination').twbsPagination({
        totalPages: totalPages,
        visiblePages: visiblePages,
        startPage: startPage,
        first : "",
        prev : '<a href="#" class="prev"><div class="img-icon angle-left floatL"></div>PREV</a>',
        next : '<a href="#" class="next"><div class="img-icon angle-right floatR"></div>NEXT</a>',
        last : "",
        initiateStartPageClick : false,
        onPageClick: function (event, page) {
        	$('#replyStartPage').val(page);
        	getQnaList(board_id);
        }
	});
}
//고정 이벤트 연결(동적태그 생성X)
function setStaticEvent() {
	
	var form = $('#qnaActionForm');
	//중복요청 방지용 변수
	var isRun = false;
	
	//등록 버튼 눌렀을때
	$('#insQnaView').on('click', function(){
		
		form.find(':hidden[name=id]').val(0);
		form.find('input[name=title]').val('');
		form.find('textarea[name=comment]').val('');
		$('#qna_regFile').val('');
		switchDivView(1);
	});
	//리스트로 가기
	$('#listQna').on('click', function() {
		qnaMain();
	});
	//글수정
	$('#modQnaView').on('click', function() {
		switchDivView(3);
		if(form.find('.post-file > .view').html() != '') {
			form.find('.post-file > .view').removeAttr('hidden');
			form.find('.post-file > .view').append('')
		}
	});
	
	//글작성, 수정
	$('#insQna, #modQna').on('click', function() {
		
		//중복요청방지
		if(isRun == true) {
			alert('요청 처리중입니다. 잠시만 기다려주세요.');
			return;
		}
		isRun = true;
		var params = new FormData($('#qnaActionForm')[0]);
		params.append('file', $('#qna_regFile')[0].files[0]);
		params.append('course_id', $(':hidden[name=course_id]').val());
		params.append('cardinal_id', $(':hidden[name=cardinal_id]').val());
		
		$.ajax({
			type : "POST",
			processData : false,
			contentType : false,
			dataType : "json",
			url : "/smtp/community/insertQna",
            data: params,
			success : function(result) {
				isRun = false;
				if(!result) {
					alert('등록에 실패했습니다.');
				} else {
					alert('등록에 성공했습니다.');
					getQnaList();
				}
			}
		});
	});
	//파일 체크
	$('#qna_regFile').on('change', function(){
		var file = $(this).val();
		
		if(file == '') {
			$(this).val('');
			return;
		}
		
		//파일 사이즈 체크
		var size = $(this)[0].files[0].size;
		
		//100MB
		if(file_size_check(size, 100)){
			//alert("size ok");
		}else{
			alert('100MB 이하의 파일만 가능합니다.');
			$(this).val("");
		}
	});
	//글삭제
	$('#delQna').on('click', function() {
		
		var board_id = form.find(':hidden[name=id]').val();
		
		if(isRun == true) {
			alert('요청 처리중입니다. 잠시만 기다려주세요.');
			return;
		}
		isRun = true;
		
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				url : "/smtp/community/deleteQna",
				data: {'id' : board_id},
				success : function(result) {
					isRun = false;
					if(!result) {
						alert('삭제에 실패했습니다.');
					} else {
						alert('삭제되었습니다.');
						getQnaList();
					}
				}
			});
		}
	});
	//댓글 등록
	$('#insReply').on('click',function(){
		var board_id = form.find(':hidden[name=id]').val();
		var comment = $('.replyForm').find('textarea[name=comment]').val();
		
		var params = new Object();
		params.board_id = board_id;
		params.depth = 1;
		params.comment = comment;
		
		if(isRun == true) {
			alert('요청 처리중입니다. 잠시만 기다려주세요.');
			return;
		}
		isRun = true;
		
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			url : "/smtp/community/insertQnaReply",
			data: params,
			success : function(result) {
				isRun = false;
				if(!result) alert('등록에 실패했습니다.');
				else {
					alert('등록되었습니다.');
					getQnaList(board_id);
					$('.replyForm').find('textarea[name=comment]').val('');
					$('span.countSpan').html('0');
				}
			}
		});
	});
	
	//글자수 체크
	$('.replyForm').find('textarea[name=comment]').on('keyup focusout mousedown mousehover', function() {
		textLengthCheck($(this));
	});
	$('.replyForm').find('textarea[name=comment]').keyup();
	
	//글검색
	$('#qnaSearchBtn').on('click', function() {
		getQnaList();
	});
}
//이벤트 연결(동적으로 태그생성되는 경우 재연결용)
function setDynamicEvent() {
	//qna 게시글id 
	var qna_id = $('#qnaActionForm').find(':hidden[name=id]').val();
	var isRun = false;
	
	//상세보기
	$('li.qnaList').on('click', function(){
		var id = $(this).closest('li').find(':hidden[name=id]').val();
		$('.replyForm').find('textarea[name=comment]').val('');
		$('span.countSpan').html('0');
		getQnaList(id);
	});
	
	//댓글 삭제
	$('.replyList .delReply').on('click', function() {
		//댓글 id
		var reply_id = $(this).closest('li').find(':hidden[name=id]').val();
		
		if(isRun == true) {
			alert('요청 처리중입니다. 잠시만 기다려주세요.');
			return;
		}
		isRun = true;
		
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			url : "/smtp/community/deleteQnaReply",
			data: {'id' : reply_id},
			success : function(result) {
				
				isRun = false;
				
				if(!result) {
					alert('삭제에 실패했습니다.');
				}
				else {
					alert('삭제되었습니다.');
					getQnaList(qna_id);
				}
			}
		});
	});
	//댓글 추천/비추천
	$('.replyList .recommendBtn, .nonRecommendBtn').on('click', function() {
		//댓글 ID
		var reply_id = $(this).closest('li').find(':hidden[name=id]').val();
		
		var params = new Object();
		params.id = reply_id;
		
		if($(this).val() == '추천') params.recommend = 1;
		else if($(this).val() == '비추천' && confirm('정말 비추천하시겠습니까?')) {
			params.nonRecommend = 1;
		}
		
		if(isRun == true) {
			alert('요청 처리중입니다. 잠시만 기다려주세요.');
			return;
		}
		isRun = true;
		
		$.ajax({
			contentType : "application/json",
			dataType : "json",
			url : "/smtp/community/updateQnaReplyRecommend",
			data: params,
			success : function(result) {
				isRun = false;
				if(!result) {
					alert('처리에 실패했습니다.');
				}
				else {
					alert('처리되었습니다.');
					getQnaList(qna_id);
				}
			}
		});
	});
	//첨부파일 삭제
	$('#delFile').on('click', function() {
		
		var params = new FormData($('#qnaActionForm')[0]);
		params.append('file_id', $(':hidden[name=file_id]').val());
			
		if(isRun == true) {
			alert('요청 처리중입니다. 잠시만 기다려주세요.');
			return;
		}
		isRun = true;
		
		$.ajax({
			type : "POST",
			processData : false,
			contentType : false,
			dataType : "json",
			url : "/smtp/community/deleteQnaAttachFile",
			data: params,
			success : function(result) {
				
				isRun = false;
				
				if(!result) {
					alert('삭제에 실패했습니다.');
				}
				else {
					alert('삭제되었습니다.');
					getQnaList(qna_id);
				}
			}
		});
	});
}

//div 변환
function switchDivView(status) {
	/* status 값 설명
	 * 0: qna리스트 보기
	 * 1: qna 등록하기(formDiv에서 .edit 활성화, .view 숨김)
	 * 2: qna 상세보기(등록하기와 반대)
	 * 3: qna 수정*/
	switch(status) {
	case 0:
		$('.qnaFormDiv').attr('hidden','hidden');
		$('.qnaViewDiv').removeAttr('hidden');
		break;
	case 1:
		$('.qnaFormDiv').removeAttr('hidden');
		$('.qnaViewDiv').attr('hidden','hidden');
		
		$('.edit').removeAttr('hidden');
		$('.view').attr('hidden','hidden');
		
		$('.qnaReplyFormDiv').attr('hidden','hidden');
		$('.modDiv').attr('hidden','hidden');
		break;
	case 2:
		$('.qnaFormDiv').removeAttr('hidden');
		$('.qnaViewDiv').attr('hidden','hidden');
		
		$('.edit').attr('hidden', 'hidden');
		$('.view').removeAttr('hidden');
		
		$('.qnaReplyFormDiv').removeAttr('hidden');
		$('span.countSpan').html('0');
		
		$('#modQna').attr('hidden', 'hidden');
		$('#modQnaView').removeAttr('hidden', 'hidden');
		break;
	case 3:
		$('.edit').removeAttr('hidden');
		$('.view').attr('hidden','hidden');
		
		$('.modDiv').removeAttr('hidden');
		$('.button-wrap > .edit').attr('hidden','hidden');
		$('.qnaReplyFormDiv').attr('hidden','hidden');
		
		$('#modQna').removeAttr('hidden');
		$('#modQnaView').attr('hidden', 'hidden');
		break;
	}
}
//사이즈 체크 함수
function file_size_check (size, max_size) {
	
	max_size = max_size * 1024 * 1024;	//MB를 byte로 변경
	
	if (size > max_size){
		return false;
	}
	
	return true;
}
//아이디 모자이크(문자열, 채울길이, 채울문자)
function rpad(str, padLen, padStr) {
    str += ""; // 문자로
    padStr += ""; // 문자로
    while (str.length < padLen)
        str += padStr;
    str = str.length >= padLen ? str.substring(0, padLen) : str;
    return str;
}
//글자수 체크
function textLengthCheck(obj) {
	$('span.countSpan').html(obj.val().length);
	//2000자 넘을 때
	if(obj.val().length > 2000) {
		obj.val(obj.val().substr(0,2000));
		textLengthCheck(obj);
	}
}