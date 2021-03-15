$(document).ready(function(){
	//기수검색
	var validCardinals = getCardinalInfo();
	//컨텐츠 세팅
	setContent(validCardinals, applyFormYn);
	
	//(관리자페이지에서의 요청을 받는 메소드)미리보기 -> 추후 수정필요
	function getMessage(event) {
		var newCode = event.data.newCodeTxt;
		$('#codeTxtDiv').html(newCode);
	}
	window.addEventListener('message', getMessage, false);
	if(window.opener != null) {
		window.opener.postMessage('opened', '*');
	}
});

//개설되어있는 기수 검색
function getCardinalInfo() {
	
	var result;
	$.ajax({
		contentType : "application/json",
		dataType : "json",
		type	: "get",
		async: false,
		url		: "/smtp/course/getCardinalInfo",
		data    : {
			"course_id" : course_id
		},
		success	: function(data) {
			result = data;
		}
	});
	return result;
}

//컨텐츠 세팅
function setContent(validCardinals, applyFormYn) {
	var content = '';
	if(validCardinals!=null&&validCardinals!="") {
		console.log(validCardinals);
		$.each(validCardinals, function(index, item) {
			
			aedDate_hyphen = item.app_end_date; //setApply 이벤트에서 사용. 하이픈으로 구분되어 있는 지원 마감일.
			
			//일수계산 필요없어서 주석했으나 필요해지면 주석해제해서 사용할 것
			//지원가능 일수계산 이름 길어서 줄임 (asd == app_start_date / aed = app_end_date)
			var asdArr = item.app_start_date.split('-');
			var aedArr = item.app_end_date.split('-');
//			
			var asdDate = new Date(asdArr[0], asdArr[1]-1, asdArr[2]);
			var aedDate = new Date(aedArr[0], aedArr[1]-1, aedArr[2]);
//			
//			var aDiff = (aedDate - asdDate)/1000/60/60/24;
//			
			//학습 일수 계산 이름 축약(lsd == learn_start_date / led = learn_end_date)
			var lsdArr = item.learn_start_date.split('-');
			var ledArr = item.learn_end_date.split('-');
//			
			var lsdDate = new Date(lsdArr[0], lsdArr[1]-1, lsdArr[2]);
			var ledDate = new Date(ledArr[0], ledArr[1]-1, ledArr[2]);
//			
//			var lDiff = (ledDate - lsdDate)/1000/60/60/24;
			
			//화폐단위 정규식
			var price = String(item.price);
			price = price.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			content += '<div class="periodBoxWrap">';
			content += 		'<div class="periodBox fc_fff">';
			content += 			'<div class="fz40 prd_div">' + item.name;
			if(item.recruit != 0 && item.recruit !== undefined) {
				content += '(' + item.recruit + '명)';
			}
			content += 			'</div>';
			content += 			'<div class="fz20 prd_day">';
			if(item.id == "n000000577") {
				content += 				'<span class="prd_day">결제기간</span>';
			} else {
				content += 				'<span class="prd_day">모집기간</span>';
			}
			content += 				'<br><span class="prd_time">' + item.app_start_date + ' ~ ' + item.app_end_date + '</span>';
			content += 			'</div>';
			content += 			'<div class="fz20 prd_day">';
			if(item.id == "n000000577") {
				content += 				'<span class="prd_day">시험일 : 2021-03-02(화) / 16시~</span>';
			} else {
				content += 				'<span class="prd_day">학습기간</span>';
				content += 				'<br><span class="prd_time">' + item.learn_start_date + ' ~ ';
			}
			if(course_id == 'c000000541' && item.id != "n000000577") {
				content += ' <br><br>주 1회 3시간 (약 3개월 총 12회 수업보장)';
				switch(item.id) {
				case 'n000000557' :
					content += '<br>금 09:00~11:50'
					break;
				case 'n000000558' : 
					content += '<br>금  13:00~15:50'
					break;
				}
			} else if(item.id == "n000000577") {
				
			} else {
				content +=  item.learn_end_date;
				
				if(item.class_day !== undefined
					&& item.class_start_time !== undefined 
					&& item.class_end_time !== undefined) {
					content += '<br><br>' + item.class_day;
					content += '<br>' + item.class_start_time + ' ~ ' + item.class_end_time;
				}
			}
			content += 			'</span>';
			content += 			'</div>';
			content += 			'<div class="fz20">';
			content +=				'<div class="fc_eg"><span class="prd_price">교육비 : ';
			if(price == 0) content += '무료';
			else content += price + '원';
			content += '</span></div>';
			content +=			'</div>';
			content +=		'</div>';
			if(applyFormYn == "Y") {
				content +=		'<div class="btn_normal btn_large btn_eg">';
				if(course_id == 'c000000526') {
					content +=			'<a class="applyBtn">지원하기</a>';
					
					var btn = '<div class="btn_normal btn_large btn_eg course_btn"><a class="applyBtn">지원하기</a>';
					btn += 		'<input type="hidden" value="' + item.id + '" name="cardinal_id">';
					btn +=		'<input type="hidden" value="' + aedDate + '" name="aedDate"></div>';
					
					$('.container_rainbow .sub02-01_content .opacity_bg').addClass('addCourse_btn');
					$('.container_rainbow .sub02-01_content .opacity_bg .course-title').append(btn);
				} else {
					//scit 면 리디렉션
					content +=			'<a onclick="redirectToKITA()">지원하기</a>';
				}
			} else {
				content +=		'<div class="btn_normal btn_large btn_eg modal-popup">';
				content +=			'<a class="modal-popup">지원하기</a>';
			}
			content +=			'<input type="hidden" value="' + item.id + '" name="cardinal_id">';
			content +=			'<input type="hidden" value="' + aedDate + '" name="aedDate">';
			content +=		'</div>';
			content +='</div>';
		});
	}
	else {
		content +='<div class="periodBoxWrap">';
		content += 		'<div class="periodBox fc_fff">';
		content += 			'<div class="fz40 prd_div">지원종료</div>';
		content += 			'<div class="fz20 prd_day">';
		content += 				'<span class="prd_day">지원가능한 과정이 없습니다.</span>';
//		if(course_id = 'c000000541') {
//			content +=			'<div class="btn_normal btn_large btn_eg applyInfoDiv">';
//			content +=				'<a>지원일정 안내</a>';
//			content += 			'</div>';
//		}
		content += 			'</div>';
		content += 		'</div>';
		content += '</div>';
	}
	$('div.coursePeriod div.justify_between').append(content);
//	$('.sub02_content .opacity_bg').appendTo('div.btn_normal.btn_large.btn_eg.course_btn').parents('.opacity_bg').addClass('.addCourse_btn');
}

function redirectToKITA() {
	if(confirm("해당 과정은 KITA-SES 공동운영과정으로, 지원신청은 무역아카데미 홈페이지에서 가능합니다. 이동하시겠습니까?")) {
		location.href="https://newtradecampus.kita.net/page/user_job_CloudIT_apply?course_category=JOBA&course_code=1498&class_seq=41&site_id=KITAACAD&viewMode=detail#appView_courseDetailView";
	}
}