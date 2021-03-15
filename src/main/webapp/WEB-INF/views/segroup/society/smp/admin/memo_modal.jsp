<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
var selectMemo = function(){
	var app_id = $("#memo_app_id").val();
	$.ajax({
		     type:"post",
		     url:"/smp/admin/selectMemo",
			 data :{'app_id': app_id},
			 dataType : 'text',
		     success:function(result){
		    	$("#memo").val(result);
		    	$("#memoModal").modal('show');
		     },
		     error:function(data, error)
		     {
		    	 alert("message:" + data.reponseText);
		     }
		    });
}
$(function(){
	$("#insertMemo").on('click', function(){
		
		var app_id = $("#memo_app_id").val();
		var smp_memo = $("#memo").val();
		
		$.ajax({
  		     type:"post",
  		     url:"/smp/admin/insertMemo",
  			 data :{'app_id': app_id,
  			 		'smp_memo': smp_memo},
  			 dataType : 'json',
  		     success:function(){
  		    	alert("메모 등록 성공");
  		    	$("#memoModal").modal('hide');
  		    	
  		     },
  		     error:function(data)
  		     {
  		    	 alert("통신에러");
  		     }
  		    });
	});
});
</script>
<div class="container">

		<!-- 모달 팝업 -->
		<div class="modal fade" id="memoModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
						</button>


						<h4 class="modal-title" id="myModalLabel">메모 작성</h4>
					</div>

					<div class="modal-body">
						<form action="" id="updateForm" method="post">
							메모&nbsp;&nbsp;<textarea  cols="20" rows="6" name="app_memo" id="memo"></textarea>
							<input type="hidden" name="app_id" id="memo_app_id">
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="insertMemo">등록</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
