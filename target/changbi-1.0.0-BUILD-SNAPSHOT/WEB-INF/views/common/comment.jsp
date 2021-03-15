<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<c:set var="userId" value="${sessionScope.user.USER_ID}" />
<c:set var="user_name" value="${sessionScope.user.USER_NAME}" />
<c:set var="userIp" value="${sessionScope.user.IP}" />
<c:set var="snsCd" value="${sessionScope.user.SNS_CD}" />

<script> 
var commentCnt = 0;
var option = {};
$.commentCnt = function(){
	$.ajax({
        url 	: '/common/commentCnt.do',
        method	: 'POST',
        data 	: $("#commentForm").serializeArray(), 
        dataType: 'json',
        async	: false,
        success:function(data){
        	if(data!=0){
        		commentCnt = data.commentCnt;
        		$(".btn_comt").text(commentCnt);
        		$.each(data.statisticCnt, function( index, list ) {
        			$(".btn_view").text(list.VIEW_CNT);
        			$(".btn_like").text(list.REFER_CNT);
        			$(".btn_shar").text(list.SHARE_CNT);
        		});
        	} 
        }
 	});
};
 
$(document).ready(function() {
 	$("#pcode").val(pcode);
 	$("#code").val(code);
 	var pm = '';
 	if($("#contents_id").val() != ''){
 		pm = "?id="+$("#contents_id").val();
 	}
 	if($("#detail_id").val() != '' && typeof $("#detail_id").val() != 'undefined'){
 		pm = "?id="+$("#detail_id").val();
 	}
 	$("#urlCopy").val(frontUrl+pcode+pm);
 	$(".cusPlaceHolder").append("<span class='placeholder'>" + $(".cusPHIn").attr("data-placeholder") + "</span>");
 	$.commentCnt();
 	
	option = {
		type 		: 'POST',
   		dataSource	: '/common/commentList.do',
	    prevText 	: '',
	    nextText 	: '',
	    locator		: 'data',
	    async		: false,
	    totalNumber : commentCnt,
	    pageSize	: pageSize, 
	    ajax		: {data : $("#commentForm").serializeArray()},
	    callback: function(data, pagination) {
    		$("#commentList li").remove();
	    	if(data.length != 0){
		        $.each(data, function( index, list ) {
		        	var mode = '';
	    			var icon = $.icon(list.SNS_CD);
	    			if('${userId}' == list.USER_ID){ 
	    				mode = '<div class="comment_ctrl">' 
		              		  +'   <button type="button" class="miniBtn commentDel" id="'+list.ID+'"><span><spring:message code="etc.delete"/></span></button>' 
		            		  +'   <button type="button" class="miniBtn commentModi"id="'+list.ID+'"><span><spring:message code="etc.modified"/></span></button>' 
		            		  +'   <button type="button" class="miniBtn commentAdd"id="'+list.ID+'" style="display:none"><span><spring:message code="etc.ok"/></span></button>' 
		            		  +'   <button type="button" class="miniBtn commentCancle"id="'+list.ID+'" style="display:none"><span><spring:message code="etc.cancle"/></span></button>' 
		            		  +'</div>' 
	    			}
                  	$("#commentList").append(
                		  '<li>'
                		  +'<div class="sns_icon"><img src="/images/icon/'+icon+'.png" alt='+icon+'></div>'
                		  +'<strong class="name">'+list.GUEST_NAME+'('+list.USER_ID+')</strong><span>'+list.UPD_DATE +'</span>'
                		  +'<p><span>'+list.COMMENT+'</span><textarea class="commentM" style="display:none;width: 99%;height: 50px;"></textarea></p>' 
                		  +mode
                		  +'</li>'
                	);
                });
	    	}else{
	    		$('#commentPaging').pagination('destroy');
	    	}
	    }
    };
	if(commentCnt != 0){
		$('#commentPaging').pagination(option); 
	}
	
	$('.cusPlaceHolder').bind({
		click:function(){
			var bool = loginConfirm('${userId}', '<spring:message code="gnb.lir"/>\n<spring:message code="idcheck.select.signin"/>');
			if(bool){
				$('#comment').focus();
				$('.placeholder').hide();
			}
		}		
	});
	$('.loginSelect').click(function(){
		location.href="/login/login.do";
	});
	//등록
	$("#addbtn").click(function(){
		if('${userId}' != ""){ 
			if($('#comment').val() == ""){
				alert("댓글을 입력하세요.");
				return false;
			}
			$("#code").val("C");
			$.ajax({
	            url 	: '/common/commentAdd.do',
	            method	: 'POST',
	            data 	: $("#commentForm").serializeArray(), 
	            dataType: 'json',
	            async	: false,
	            success:function(data){
	            	var commentTotalCnt = Number($("#btn_comt").text())+1;
	            	if(data!=0){
						alert("<spring:message code="success.common.insert"/>");
						option.totalNumber=commentTotalCnt
						if(commentTotalCnt != 1){
							$('#commentPaging').pagination('destroy').pagination(option);
						}else{
							$('#commentPaging').pagination(option);
						}
	            		$(".btn_comt").text(commentTotalCnt);
	            	/* 	if(data == 900){
	            			alert("<spring:message code="fail.check.comment"/>");
	            		}else{
	            		} */
	            	}else{
						alert("<spring:message code="fail.common.insert"/>");
	            	}
	           		$("#comment").val("");
	           		$(".placeholder").removeClass("off");
	            }
	        });
		}	
	});
	//삭제
	$('#commentPaging').on('click','ul li .comment_ctrl .commentDel',function(){
		var $this = $(this);
		$.ajax({
            url 	: '/common/commentDel.do',
            method	: 'POST',
            data 	: {id : $(this).attr('id')},
            dataType: 'json',
            async	: false,
            success:function(data){
            	if(data > 0){
            		$this.parent().parent().remove();
            		var commentTotalCnt = Number($("#btn_comt").text())-1;
            		$('.btn_comt').text(commentTotalCnt);
            		if(commentTotalCnt == 0){
            			$('#commentPaging').pagination('destroy');
            			$('#commentList').append('<li><spring:message code="no.common.select"/></li>');
            		}
            		alert("<spring:message code="success.common.delete"/>");
            		
            	}
            }
        });
	});
	//수정
	$('#commentPaging').on('click','ul li .comment_ctrl .commentModi',function(){
		var $this = $(this).parent().parent();
		$this.find('.commentDel, .commentModi').hide();
		$this.find('.commentAdd, .commentCancle').show();
		$this.find('p span').hide();
		$this.find('p textarea').val($this.find('p span').text()).show();
	});
	//수정취소
	$('#commentPaging').on('click','ul li .comment_ctrl .commentCancle',function(){
		var $this = $(this).parent().parent();
		$this.find('.commentDel, .commentModi').show();
		$this.find('.commentAdd, .commentCancle').hide();
		$this.find('p span').show();
		$this.find('p textarea').val('').hide();
	});
	
	//수정등록
	$('#commentPaging').on('click','ul li .comment_ctrl .commentAdd',function(){
		var $this = $(this).parent().parent();
		if($this.find('textarea').val() == ""){
			alert("댓글을 입력하세요.");
			return false;
		}
		$.ajax({
            url 	: '/common/commentModi.do',
            method	: 'POST',
            data 	: {id : $(this).attr('id'), comment : $this.find('textarea').val()},
            dataType: 'json',
            async	: false,
            success:function(data){
            	$this.find('.commentDel, .commentModi').show();
        		$this.find('.commentAdd, .commentCancle').hide();
            	$this.find('p span').text($this.find('textarea').val()).show();
        		$this.find('p textarea').val('').hide();
            }
        });
	});
	 
	
});
</script> 
<form id="commentForm">
<input type="hidden" name="user_id" id="user_id" value="${userId}">
<input type="hidden" name="user_name" id="user_name" value="${user_name}">
<input type="hidden" name="code" id="code" value="">

<div class="comment">
	<h3>댓글<strong>4</strong></h3>
	<textarea></textarea>
	<button type="submit">등록</button>
	<ul>
		<li>
			<span class="writer"><strong>홍길동</strong></span><span class="date">2018. 02. 14</span><span class="delete"><a href="#none">삭제</a></span><span class="edit"><a href="#none">수정</a></span>
			<div>댓글 내용</div>
		</li>
		<li>
			<span class="writer"><strong>홍길동</strong></span><span class="date">2018. 02. 14</span>
			<div>댓글 내용</div>
		</li>
		<li>
			<span class="writer"><strong>홍길동</strong></span><span class="date">2018. 02. 14</span><span class="delete"><a href="#none">삭제</a></span><span class="edit"><a href="#none">수정</a></span>
			<div>댓글 내용</div>
		</li>
		<li>
			<span class="writer"><strong>홍길동</strong></span><span class="date">2018. 02. 14</span>
			<div>댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용댓글 내용</div>
		</li>
	</ul>
</div>
</form>
