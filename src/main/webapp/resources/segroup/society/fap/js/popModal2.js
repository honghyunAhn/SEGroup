// JavaScript Document

$(function(){
	$('#popModal_ex1').click(function(){
		$('#popModal_ex1').popModal({
			html : $('#content'),
			placement : 'bottomLeft',
			showCloseBut : true,
			onDocumentClickClose : true,
			onDocumentClickClosePrevent : '',
			overflowContent : false,
			inline : true,
			asMenu : false,
			beforeLoadingContent : 'Please, wait...',
			onOkBut : function() {},
			onCancelBut : function() {},
			onLoad : function() {},
			onClose : function() {}
		});
	});
		
	$('#popModal_ex2').click(function(){
		$('#popModal_ex2').popModal({
			html : function(callback) {
				$.ajax({url:'ajax.html'}).done(function(content){
					callback(content);
				});
			}
		});
	});
	
	$('#popModal_ex3').click(function(){
		$('#popModal_ex3').popModal({
			html : $('#content3'),
			placement : 'bottomLeft',
			asMenu : true
		});
	});
	
	$('#notifyModal_ex1').click(function(){
		$('#content2').notifyModal({
			duration : 2500,
			placement : 'center',
			overlay : true,
			type : 'notify',
			onClose : function() {}
		});
	});
	
	$('#dialogModal_ex1').click(function(){
		$('.dialog_content').dialogModal({
			topOffset: 0,
			top: '10%',
			type: '',
			onOkBut: function() {},
			onCancelBut: function() {},
			onLoad: function(el, current) {},
			onClose: function() {},
			onChange: function(el, current) {
				if(current == 3){
					el.find('.dialogModal_header span').text('Page 3');
					$.ajax({url:'ajax.html'}).done(function(content){
						el.find('.dialogModal_content').html(content);
					});
				}
			}
		});
	});
	
	$('#confirmModal_ex1').click(function(){
		$('#confirm_content').confirmModal({
			topOffset: 0,
			onOkBut: function() {},
			onCancelBut: function() {},
			onLoad: function() {},
			onClose: function() {}
		});
	});
	
	
	/* tab */
(function($) {
	$.fn.tab = function(method){
	
		var methods = {
			init : function(params) {

				$('.tab').click(function() {
					var curPage = $(this).attr('data-tab');
					$(this).parent().find('> .tab').each(function(){
						$(this).removeClass('active');
					});
					$(this).parent().find('+ .page_container > .page').each(function(){
						$(this).removeClass('active');
					});
					$(this).addClass('active');
					$('.page[data-page="' + curPage + '"]').addClass('active');
				});
			
			}
		};

		if (methods[method]) {
			return methods[method].apply( this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || ! method) {
			return methods.init.apply(this, arguments);
		}
		
	};
	$('html').tab();
	
})(jQuery);
	
});