$(document).ready(function(){
	setApply();
});

//지원하기
function setApply() {
	//applyBtn(a태그) 선택시키면 클릭 인식범위가 너무 좁아짐
	$('.applyBtn').parent().on('click', function() {
		var cardinal_id = $(this).closest('div').find('input[name=cardinal_id]').val();
		
		//현재 시간이 지원기간 이내인지 체크
		var aedDate = $(this).closest('div').find('input[name=aedDate]').val();
		var today = new Date();
		
		if(aedDate < today) {
			alert('지원기간이 종료되었습니다.');
			return false;
		}
		document.location.href = "/smtp/apply/sub00-01?course_id="+ course_id +"&cardinal_id="+ cardinal_id;
	});
}