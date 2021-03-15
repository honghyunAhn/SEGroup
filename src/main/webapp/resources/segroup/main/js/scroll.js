$(function(){
	$('#lnb a').on('click',function(e){
		var index = $(this).attr('href');
		var secTop = $(index).offset().top;
		$("html, body").animate({
			'scrollTop' : secTop -80
		}, 400);
	});
});