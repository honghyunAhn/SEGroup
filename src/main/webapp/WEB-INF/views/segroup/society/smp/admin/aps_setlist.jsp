<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<!-- 페이징관련 css 시작 -->
<!-- bxSlider CSS file -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
   href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
   href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
   href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 -->

<jsp:include page="../import.jsp" flush="true" />
<!-- 상단메뉴와 하단메뉴 관련 css-->

<title>학생관리</title>
<style type="text/css">
.text_overflow {
   overflow: hidden;
   text-overflow: ellipsis;
   white-space: nowrap;
   width: 200px;
   height: 20px;
}
.setlistTable{
    resize: none;
    text-align: center;
    margin-top: 30px;
}

.setlistTable #setlistColumn th, .modal-title{
   margin: auto;
   text-align: center;
}

.smp_aps_setlist_nm a{cursor:pointer;}

table {
    width: 100%;
    border: 1px solid #444444;
}
th{
	width : 150px;
}
.addTotalTable td{
	margin: auto;
	text-align: center;
}
th, td {
    border: 1px solid #444444;
  }
  
#addNewSetbBtn{
	position: absolute;
    margin-left: 88%;
    margin-top: -50px;
}
#setlist_nm{
	width:300px;
	margin-left:300px;
	margin-top: -55px;
}

.setChangeTable{
	width: 290px;
    margin-left: 360px;
    margin-top: -80px;
}

#update_settotal_ratio{
	width: 100px;
}
a{cursor:pointer;}
</style>
<script>
function viewTotal(num){
	$(".setChangeTable").remove();
	$("#addSection").html('');
	$("#setlist_num").val(num);
   $.ajax({
        type:"post",
        url:"/smp/admin/aps/selectSetTotal",
        data : {'smp_aps_setlistseq' : num},
        success:function(result){
        	viewDrop(result);
        },
        error:function(data)
        {
           alert("통신에러1");
        }
       });
}

function viewDrop(data){
      
      var totalList = [];
      var groupList = [];
      
      var tag= '';
      $('#tableSection').html('');
      $("#setTotalTable").html('');
      $("#setGroupTable").html('');
      $("#setDetailTable").html('');
      tag+='<h4>종합평가</h4>';
      var setlist_seq = $("#setlist_num").val();
      tag+='<button onclick="addTotal('+setlist_seq+')">과목 추가</button>';
      tag+='<table id="setTotalTable" style="width: 350px;border:1px solid;">';
      tag+='<tr><th>과목</th><th>비율</th><th>수정</th><th>삭제</th></tr>';
      for(var i in data)
      {
            var total = {
               "smp_aps_settotal_seq" : data[i].smp_aps_settotal_seq,
               "smp_aps_settotal_nm" : data[i].smp_aps_settotal_nm,
               "smp_aps_settotal_ratio" : data[i].smp_aps_settotal_ratio
            };
            
            totalList.push(total);
         
      }
      for(var i in totalList){
    	  var totalName = totalList[i].smp_aps_settotal_nm;
    	  var totalSeq = totalList[i].smp_aps_settotal_seq;
    	  var totalRatio = totalList[i].smp_aps_settotal_ratio;
    	  tag +='<tr><td><a onclick=appendGroups("'+totalSeq+'")>'+totalName+'</a></td>';
          tag +='<td>'+totalList[i].smp_aps_settotal_ratio+'</td>';
          tag +='<td><button onclick="totalChange('+totalSeq+')">수정</button></td>';
          tag +='<td><button onclick="totalDelete('+totalSeq+')">삭제</button></td></tr>';
      }
      tag +='</table>';
      $("#tableSection").append(tag);      
 	  $("#apsSetListViewModal").modal('show');
}

function appendGroups(totalSeq){
	$("#addSection").html('');
	$(".setChangeTable").remove();
	$('#totalSeq').val(totalSeq);
	$.ajax({
        type:"post",
        url:"/smp/admin/aps/appendGroup",
        data :{'smp_aps_settotal_seq': totalSeq},
        success:function(result){
        	$("#tableSection").html('');
        	var groupList = [];
            var tag= '';
            tag+='<h4>그룹평가</h4>';
            var setlist_num = $('#setlist_num').val();
            var totalSeq = $("#totalSeq").val();
            tag+='<button onclick="addGroupSet('+totalSeq+')">그룹 추가</button>'
            tag+='<button onclick="viewTotal('+setlist_num+')">종합평가</button>';
            tag+='<table id="setGroupTable" style="width: 300px;border:1px solid;">';
            tag+='<tr><th>그룹명</th><th>비율</th><th>타입</th><th>수정</th><th>삭제</th></tr>';
           	for(var i in result){
            	var group ={
            			"smp_aps_setgroup_seq" : result[i].smp_aps_setgroup_seq,
            			"smp_aps_setgroup_nm" : result[i].smp_aps_setgroup_nm,
            			"smp_aps_setgroup_ratio" : result[i].smp_aps_setgroup_ratio,
            			"smp_aps_setgroup_tp" : result[i].smp_aps_setgroup_tp
            	};
               	groupList.push(group);
           	}
           	for(var i in groupList)
            {
              	var groupName = groupList[i].smp_aps_setgroup_nm;
              	var groupSeq = groupList[i].smp_aps_setgroup_seq;
              	var groupRatio = groupList[i].smp_aps_setgroup_ratio;
				var groupTp = groupList[i].smp_aps_setgroup_tp;
				var str;
				if(groupTp=='A0900'){
					str = '시험';
				}
				else if(groupTp=='A0901'){
					str = '확인서';
				}
				else if(groupTp=='A0902'){
					str = '개별점수';
				}
              	tag +='<tr><td><a onclick=appendDetails("'+groupSeq+'")>'+groupName+'</a></td><td>';
                tag +=groupList[i].smp_aps_setgroup_ratio+'</td>';
                tag +='<td>'+str;
                tag +='</td><td><button onclick="groupChange('+groupSeq+')">수정</button></td>';
                tag +='<td><button onclick="groupDelete('+groupSeq+')">삭제</button></td></tr>';
            }  
           	tag +='</table>';
            $("#tableSection").append(tag);
        },
        error:function(data)
        {
           alert("통신에러2");
        }
     });
}

function appendDetails(groupSeq){
	$("#addSection").html('');
	$(".setChangeTable").remove();
	$("#groupSeq").val(groupSeq);
	$.ajax({
        type:"post",
        url:"/smp/admin/aps/appendDetail",
        data :{'smp_aps_setgroup_seq': groupSeq},
        success:function(result){
        	$("#tableSection").html('');
        	var tag=''
        	var groupSeq = $('#groupSeq').val();
            tag+='<h4>상세평가</h4>';
            tag+=' <button onclick="addDetailSet('+groupSeq+')">디테일 추가</button>';
            var setlist_num = $('#setlist_num').val();
            var totalSeq = $('#totalSeq').val();
            tag+='<button onclick="viewTotal('+setlist_num+')">종합평가</button>';
            tag+='<button onclick="appendGroups('+totalSeq+')">그룹평가</button>';
        	tag +='<table id="setDetailTable" style="width: 300px;border:1px solid;">';
        	tag+='<tr><th>디테일명</th><th>비율</th><th>수정</th><th>삭제</th></tr>';
        	
        	var detailList = [];
           	for(var i in result){
	        	var detail ={
	        			"smp_aps_setdetail_seq" : result[i].smp_aps_setdetail_seq,
	        			"smp_aps_setdetail_nm" : result[i].smp_aps_setdetail_nm,
	        			"smp_aps_setdetail_ratio" : result[i].smp_aps_setdetail_ratio
	        	};
           		detailList.push(detail);
           	}
           	for(var i in detailList){ 
          	  	var detailName = detailList[i].smp_aps_setdetail_nm;
          	  	var detailRatio = detailList[i].smp_aps_setdetail_ratio;
          	  	var detailSeq = detailList[i].smp_aps_setdetail_seq;
          	    tag +='<tr><td>'+detailName+'</td>';
            	tag +='<td>'+detailRatio+'</td>';
            	tag +='<td><button onclick="detailChange('+detailSeq+')">수정</button></td>';
                tag +='<td><button onclick="detailDelete('+detailSeq+')">삭제</button></td></tr>';
           	}
           	tag+='</table>';
           	$("#tableSection").append(tag);
        },
        error:function(data){
           alert("통신에러3");
        }
     });
}
function deleteSetList(){
	var setlist_seq = $("#setlist_num").val();
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/deleteSetList",
		 data :{"setlist_seq" : setlist_seq},
		 dataType : 'json',
	     success:function(result){
			if(result==true){
				alert("리스트가 삭제되었습니다.");
				location.reload();
			}
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}

function totalChange(total_seq){
	$("#addDetailTable").remove();
	$("#addGroupTable").remove();
	$(".setChangeTable").remove();
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/selectSet",
		 data :{"set_seq" : total_seq, "section" : 1},
		 dataType : 'json',
	     success:function(result){
	    	 
	    	    var tag ='';
	    		tag+='<table class="setChangeTable"><colgroup><col width="30%"/><col width="70%" /></colgroup>';
	    		tag+='<tbody><tr><th>설정</th>';
	    		tag+='<td>설정명</td></tr>';
	    		tag+='<tr><th>평가종합 이름</th>';
	    		tag+='<td><input type="text" name="smp_aps_total_nm" id="update_settotal_nm" value="'+result.smp_aps_settotal_nm+'"></td></tr>';
	    		tag+='<tr><th>평가종합 비율</th>';
	    		tag+='<td><input type="number" name="smp_aps_settotal_ratio" id="update_settotal_ratio" value="'+result.smp_aps_settotal_ratio+'"  min="0" max="100" onkeydown="filterNumber(event)">(%)</td></tr>';
	    		tag+='<input type="hidden" name="smp_aps_settotal_seq" id="update_settotal_seq" value="'+result.smp_aps_settotal_seq+'">';
	    		tag+='<input type="hidden" name="section" value="1">';
	    		tag+='</tbody></table>';
	    		
	    		$("#updateSection").val("total");
	    		$("#changeSet").show();
	    		$('#modal-body').append(tag);
	    		
	     
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}

function groupChange(group_seq){
	$(".setChangeTable").remove();
	$("#addDetailTable").remove();
	$("#addGroupTable").remove();
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/selectSet",
		 data :{"set_seq" : group_seq, "section" : 2},
		 dataType : 'json',
	     success:function(result){
	    	 
	    	    var tag ='';
	    		tag+='<table class="setChangeTable"><colgroup><col width="30%"/><col width="70%" /></colgroup>';
	    		tag+='<tbody><tr><th>설정</th>';
	    		tag+='<td>설정명</td></tr>';
	    		tag+='<tr><th>평가그룹 이름</th>';
	    		tag+='<td><input type="text" name="smp_aps_setgroup_nm" id="update_setgroup_nm" value="'+result.smp_aps_setgroup_nm+'"></td></tr>';
	    		tag+='<tr><th>평가그룹 비율</th>';
	    		tag+='<td><input type="number" name="smp_aps_setgroup_ratio" id="update_setgroup_ratio" value="'+result.smp_aps_setgroup_ratio+'"  min="0" max="100" onkeydown="filterNumber(event)">(%)</td></tr>';
	    		tag+='<tr><th>평가그룹  구분</th>';
	    		tag+='<td><select name="smp_aps_setgroup_tp" id="update_setgroup_tp">';
	    		tag+='<option value="A0900">시험</option>';
	    		tag+='<option value="A0901">확인서</option>';
				tag+='<option value="A0902">개별점수</option>';
				tag+='</select></td>';
				tag+='<input type="hidden" value="'+result.smp_aps_setgroup_seq+'" name="smp_aps_aps_setgroup_seq" id="update_setgroup_seq">';
				tag+='<input type="hidden" name="section" value="2">';
				tag+='</tbody></table>';
				
				$("#updateSection").val("group");
	    		$("#changeSet").show();
	    		$('#modal-body').append(tag);
	    		
	    		var tp = result.smp_aps_setgroup_tp;
	    		if(tp=='A0900'){
		    		$("#update_setgroup_tp").val("A0900");
	    		}
	    		else if(tp=='A0901'){
	    			$("#update_setgroup_tp").val("A0901");
	    		}
	    		else if(tp=='A0902'){
	    			$("#update_setgroup_tp").val("A0902");
	    		}
	     
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}

function detailChange(detail_seq){
	$(".setChangeTable").remove();
	$("#addDetailTable").remove();
	$("#addGroupTable").remove();
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/selectSet",
		 data :{"set_seq" : detail_seq, "section" : 3},
		 dataType : 'json',
	     success:function(result){
	    	 
	    	    var tag ='';
	    	    tag+=''
	    		tag+='<table class="setChangeTable"><colgroup><col width="30%"/><col width="70%" /></colgroup>';
	    		tag+='<tbody><tr><th>설정</th>';
	    		tag+='<td>설정명</td></tr>';
	    		tag+='<tr><th>평가세부 이름</th>';
	    		tag+='<td><input type="text" name="smp_aps_setdetail_nm" id="update_setdetail_nm" value="'+result.smp_aps_setdetail_nm+'"></td></tr>';
	    		tag+='<tr><th>평가세부 비율</th>';
	    		tag+='<td><input type="number" name="smp_aps_setdetail_ratio" id="update_setdetail_ratio" value="'+result.smp_aps_setdetail_ratio+'"  min="0" max="100" onkeydown="filterNumber(event)">(%)</td></tr>';
				tag+='<input type="hidden" value="'+result.smp_aps_setdetail_seq+'" name="smp_aps_aps_setdetail_seq" id="update_setdetail_seq">';
				tag+='<input type="hidden" name="section" value="3">';
	    		tag+='</tbody></table>';
				
	    		$("#updateSection").val("detail");
	    		$("#changeSet").show();
	    		$('#modal-body').append(tag);
	     
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}

function totalDelete(settotal_seq){
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/deleteSet",
		 data :{"set_seq" : settotal_seq, "section" : 1},
		 dataType : 'json',
	     success:function(result){
			if(result==true){
				alert("종합평가과목이 삭제되었습니다.");
				var num = $('#setlist_num').val();
				viewTotal(num);
			}
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    }); 
}

function groupDelete(setgroup_seq){
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/deleteSet",
		 data :{"set_seq" : setgroup_seq, "section" : 2},
		 dataType : 'json',
	     success:function(result){
			if(result==true){
				alert("그룹평가과목이 삭제되었습니다.");
				var totalSeq = $("#totalSeq").val();
				appendGroups(totalSeq);
			}
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    }); 
	
}

function detailDelete(setdetail_seq){
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/deleteSet",
		 data :{"set_seq" : setdetail_seq, "section" : 3},
		 dataType : 'json',
	     success:function(result){
			if(result==true){
				alert("세부평가과목이 삭제되었습니다.");
				var groupSeq = $("#groupSeq").val();
				appendDetails(groupSeq);
			}
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    }); 
}
function applySetList(tdNum){
	var num = tdNum;
	var setlist_seq = $('#setlistTable > tbody > tr').eq(num).find('td').eq(0).find('input').val();
	var gisu_seq = $('#setlistTable > tbody > tr').eq(num).find('td').eq(2).find('option:selected').val();
	
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/applySetList",
		 data :{'gisu_seq': gisu_seq, "setlist_seq" : setlist_seq},
		 dataType : 'json',
	     success:function(result){
			alert("성적 설정이 완료되었습니다.");
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}
function addNewSet(){
	$("#gisuSelected").val("0");
	$("#totalListTable").html('');
	$('#groupListTable').html('');
	$("#detailListTable").html('');
	$("#setlist_nm").val('');
	$("#addSetListViewModal").modal('show');
}
function gisuSelected(){
	var gisu_seq = $("#gisuSelected option:selected").val();
	if(gisu_seq==0){
		$("#totalListTable").html('');
	    $("#groupListTable").html('');
	    $("#detailListTable").html('');
	}
	else{
	$.ajax({
		type : "POST",
		url : "/apsTotalList",
		dataType : 'json',
		data : {
			'gisu_seq' : gisu_seq
		},
		success : function(data) {
			if(data[0]==null)
			{
				alert("성적이 지정되어있지 않습니다");
				$("#totalListTable").html('');
				return;
			}	
			totalView(data);
		},
		error : function() {
			alert("error");
		}
	});
	}
}
function totalView(data){
    
    var totalList = [];
    var groupList = [];
    
    var tag= '';
    $("#totalListTable").html('');
    $("#groupListTable").html('');
    $("#detailListTable").html('');
    tag+='<tr><th>과목</th><th>비율</th></tr>'
    for(var i in data)
    {
          var total = {
             "smp_aps_total_seq" : data[i].smp_aps_total_seq,
             "smp_aps_total_nm" : data[i].smp_aps_total_nm,
             "smp_aps_total_ratio" : data[i].smp_aps_total_ratio
          };
          
          totalList.push(total);
       
    }
    for(var i in totalList)
    {
       var name = totalList[i].smp_aps_total_nm;
       var total_seq = totalList[i].smp_aps_total_seq;
        tag +='<tr><td><a value="'+total_seq+'" onclick=groupView("'+total_seq+'")>'+name+'</a></td>';
        tag +='<td><input type="text" value="'+totalList[i].smp_aps_total_ratio+'" disabled></td></tr>';
    }
    $("#totalListTable").append(tag); 
}
function groupView(total_seq){
	
	 $.ajax({
			type : "POST",
			url : "/apsGroupList",
			dataType : 'json',
			data : {
				'smp_aps_total_seq' : total_seq
			},
			success : function(result) {
				if(result[0]==null)
				{
					alert("성적이 지정되어있지 않습니다");
					$("#groupListTable").html('');
					return;
				}	
				$("#groupListTable").html('');
	            $("#detailListTable").html('');
	            
	            var groupList = [];
	            var tag= '';
	            tag+='<tr><th>그룹명</th><th>비율</th></tr>'
	              for(var i in result){
	              var group ={
	                    "smp_aps_group_seq" : result[i].smp_aps_group_seq,
	                    "smp_aps_group_nm" : result[i].smp_aps_group_nm,
	                    "smp_aps_group_ratio" : result[i].smp_aps_group_ratio
	              };
	                 groupList.push(group);
	              }
	              for(var i in groupList)
	            {
	                var groupName = groupList[i].smp_aps_group_nm;
	                var groupSeq = groupList[i].smp_aps_group_seq;
	               tag +='<tr><td><a value="'+groupSeq+'" onclick=detailView("'+groupSeq+'")>'+groupName+'</a></td>';
	               tag +='<td><input type="text" value="'+groupList[i].smp_aps_group_ratio+'" disabled></td></tr>';
	            }
	              $("#groupListTable").append(tag);
			},
			error : function() {
				alert("error");
			}
		}); 
    
}
function detailView(group_seq){
	 $.ajax({
		 	type : "POST",
			url : "/apsDetailList",
			dataType : 'json',
			data : {
				'smp_aps_group_seq' : group_seq
			},
	        success:function(result){
	           $("#detailListTable").html('');
	           var tag=''
	           var detailList = [];
	           tag+='<tr><th>디테일명</th><th>비율</th></tr>'
	              for(var i in result){
	              var detail ={
	                    "smp_aps_detail_seq" : result[i].smp_aps_detail_seq,
	                    "smp_aps_detail_nm" : result[i].smp_aps_detail_nm,
	                    "smp_aps_detail_ratio" : result[i].smp_aps_detail_ratio
	              };
	                 detailList.push(detail);
	              }
	              for(var i in detailList){ 
	                  var detailName = detailList[i].smp_aps_detail_nm;
	                tag +='<tr><td>'+detailName+'</td>';
	                tag +='<td><input type="text" value="'+detailList[i].smp_aps_detail_ratio+'"disabled></td></tr>';
	            }
	              $("#detailListTable").append(tag);
	        },
	        error:function(data){
	        
	           alert("통신에러3");
	        }
	     }); 
}
function addListSet(){
	var gisu_seq = $("#gisuSelected option:selected").val();
	var setlist_nm = $("#setlist_nm").val();
	if(gisu_seq==0){
		alert("기수를 선택하여 주세요");
		return;
	}
	if(setlist_nm==''){
		alert("설정명을 지정해주세요");
		return;
	}	
	$.ajax({
		type : "POST",
		url : "/apsTotalList",
		dataType : 'json',
		data : {
			'gisu_seq' : gisu_seq
		},
		success : function(data) {
			if(data[0]==null){
				alert("성적이 지정되어있지 않습니다");
				return;
			}
			else{
				addSetList(gisu_seq);
			}
			
		},
		error : function() {
			alert("error");
		}
	});
}
function addSetList(gisu_seq){
	$("#gisu_seq_add_set_list").val(gisu_seq);
	$("#addSetList").submit();
	
}
function changeSetValue(){
	var section = $("#updateSection").val();
	var set_seq;
	var set_ratio;
	var set_nm;
	var set_tp;
	var parent_seq;
	if(section=='total'){
		var total_seq = $("#update_settotal_seq").val();
		var total_ratio = $("#update_settotal_ratio").val();
		var total_nm = $("#update_settotal_nm").val();
		parent_seq = $("#setlist_num").val();
		set_seq=total_seq;
		set_ratio=total_ratio;
		set_nm=total_nm;
		section=1;
	}
	else if(section=='group'){
		var group_seq = $("#update_setgroup_seq").val();
		var group_ratio = $("#update_setgroup_ratio").val();
		var group_nm = $("#update_setgroup_nm").val();
		var group_tp = $("#update_setgroup_tp").val();
   		parent_seq=$("#totalSeq").val();
		set_seq=group_seq;
		set_ratio=group_ratio;
		set_nm=group_nm;
		set_tp=group_tp;
		section=2;
	}
	else if(section=='detail'){
		var detail_seq = $("#update_setdetail_seq").val();
		var detail_ratio = $("#update_setdetail_ratio").val();
		var detail_nm = $("#update_setdetail_nm").val();
		if(detail_ratio>100){
			alert("비율은 100%를 넘을 수 없습니다");
			return;
		}
		if(detail_ratio<0||detail_ratio>100){
			alert("비율의 범위는 0~100%를 넘을 수 없습니다");
			return;
		}
		set_seq=detail_seq;
		set_ratio=detail_ratio;
		set_nm=detail_nm;
		section=3;
	}
	
	if(set_seq==''||set_ratio==''||set_nm==''){
		alert("항목을 모두 입력해주세요");
		return;
	}
	if(set_ratio<0||set_ratio>100){
		alert("비율은 0부터 100까지 입니다");
		return;
	}
	$.ajax({
		type : "POST",
		url : "/smp/admin/aps/setUpdate",
		dataType : 'json',
		data : {
			'set_seq' :set_seq,
			'set_ratio' :set_ratio,
			'set_nm' :set_nm,
			'set_tp' :set_tp,
			'parent_seq' : parent_seq,
			'section' : section
		},
		success : function(data) {
			if(data==-1){
				alert("합계는 100%를 넘을 수 없습니다");
				return;
			}
			else if(data==1){
				var setlist_num = $("#setlist_num").val();
				viewTotal(setlist_num);
				$("#changeSet").hide();
			}
			else if(data==2){
				var totalSeq = $("#totalSeq").val();
				appendGroups(totalSeq);
				$("#changeSet").hide();
			}
			else if(data==3){
				var groupSeq = $("#groupSeq").val();
				appendDetails(groupSeq);
				$("#changeSet").hide();
			}
			
		},
		error : function() {
			alert("error");
		}
	});
	
		
}

function addTotal(setlist_num){
	$("#addSection").html('');
	$(".setChangeTable").remove();
	$("#changeSet").hide();
 	var tag = '';
 		tag +='<table id="addDetailTable" style="width: 300px;border:1px solid;">';
		tag +='<tr class="setTableTr"><th style="width:120px;">과목</th><th>비율</th></tr>';
		tag +='<tr><td><input type="text" id="addTotalName"></td>';
        tag +='<td><input type="number" id="addTotalRatio"  min="0" max="100" style="ime-mode:disabled" onkeydown="filterNumber(event)"></td>';
        tag +='<td style="width:46px"><button onclick="newTotal('+setlist_num+')">추가</button></td>';
        tag +='<td style="width:46px"><button onclick="removeRow(this)">삭제</button></td></tr>';
        tag +='</table>';
    
   		$("#addSection").append(tag);
}



function filterNumber(event) {
	
   var code = event.keyCode; 
   if (code >= 96 && code <= 106) {
      code -= 48;
    }
   if (code > 47 && code < 58) {
      return;
   } 
   if (event.ctrlKey || event.altKey) {
      return;
   }
   if (code === 9 || code === 36 || code === 35 || code === 37 ||
      code === 39 || code === 8 || code === 46) {
      return;
   }
   event.preventDefault(); 
	
}

function newTotal(setlist_num){
	var addTotalName = $("#addTotalName").val();
	var addTotalRatio = $("#addTotalRatio").val();
	if(setlist_num==''||addTotalName==''||addTotalRatio==''){
		alert("정보를 입력해주세요");
		return;
	}
	else if(addTotalRatio<0||addTotalRatio>100){
		alert("범위가 올바르지 않습니다");
		return;
	}
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/newTotal",
		 data :{"smp_aps_setlist_seq" : setlist_num, "smp_aps_settotal_nm" : addTotalName, "smp_aps_settotal_ratio" : addTotalRatio},
		 dataType : 'json',
	     success:function(result){
			if(result>100){
				alert("과목 비율 총합이 100을 넘습니다 다른 과목 비율을 조정 후 추가해 주세요");
			}else{
				alert("과목이 추가되었습니다");
				var num = $("#setlist_num").val();
				viewTotal(num);
			}
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}

function addGroupSet(totalSeq){
	$("#addSection").html('');
	$(".setChangeTable").remove();
	$("#changeSet").hide();
 	var tag = '';
 		tag +='<table id="addGroupTable" style="width: 350px;border:1px solid;">';
		tag +='<tr class="setTableTr"><th style="width:120px;">그룹</th><th>비율</th><th style="width:90px">TP</th></tr>';
		tag +='<tr><td><input type="text" id="addGroupName"></td>';
        tag +='<td><input type="number" id="addGroupRatio" min="0" max="100" onkeydown="filterNumber(event)"></td>';
        tag +='<td><select id="addgroupTP">';
        tag +='<option value="A0900">시험</option>';
        tag +='<option value="A0900">확인서</option>';
        tag +='<option value="A0900">개인 점수</option></select></td>';
        tag +='<td style="width:50px"><button onclick="newGroup('+totalSeq+')">추가</button></td>';
        tag +='<td style="width:50px"><button onclick="removeRow(this)">삭제</button></td></tr>';
        tag +='</table>';
        $("#addSection").append(tag);
}

function newGroup(totalSeq){
	var addGroupName = $("#addGroupName").val();
	var addGroupRatio = $("#addGroupRatio").val();
	var addGroupTp = $("#addgroupTP").val();
	if(totalSeq==''||addGroupName==''||addGroupRatio==''||addGroupTp==''){
		alert("정보를 입력해주세요");
		return;
	}
	else if(addGroupRatio<0||addGroupRatio>100){
		alert("범위가 올바르지 않습니다");
		return;
	}
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/newGroup",
		 data :{"smp_aps_settotal_seq" : totalSeq, "smp_aps_setgroup_nm" : addGroupName, "smp_aps_setgroup_ratio" : addGroupRatio, "smp_aps_setgroup_tp" : addGroupTp},
		 dataType : 'json',
	     success:function(result){
			if(result>100){
				alert("그룹 비율 총합이 100을 넘습니다 다른 과목 비율을 조정 후 추가해 주세요");
			}else{
				alert("그룹이 추가되었습니다");
				var totalSeq=$('#totalSeq').val();
				appendGroups(totalSeq);
			}
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}

function addDetailSet(groupSeq){
	$("#addSection").html('');
	$(".setChangeTable").remove();
	$("#changeSet").hide();
 	var tag = '';
 		tag +='<table id="addDetailTable" style="width: 300px;border:1px solid;">';
		tag +='<tr class="setTableTr"><th style="width:120px;">디테일</th><th>비율</th></tr>';
		tag +='<tr><td><input type="text" id="addDetailName"></td>';
        tag +='<td><input type="number" id="addDetailRatio"  min="0" max="100" onkeydown="filterNumber(event)"></td>';
        tag +='<td style="width:46px"><button onclick="newDetail('+groupSeq+')">추가</button></td>';
        tag +='<td style="width:46px"><button onclick="removeRow(this)">삭제</button></td></tr>';
        tag +='</table>';
    
   		$("#addSection").append(tag);
}

function newDetail(groupSeq){
	var addDetailName = $("#addDetailName").val();
	var addDetailRatio = $("#addDetailRatio").val();
	if(groupSeq==''||addDetailName==''||addDetailRatio==''){
		alert("정보를 입력해주세요");
		return;
	}
	else if(addDetailRatio>100){
		alert("100%를 넘을 수 없습니다");
		return;
	}
	else if(addDetailRatio<0){
		alert("0%보다 작을 수 없습니다");
		return;
	}	
	$.ajax({
	     type:"post",
	     url:"/smp/admin/aps/newDetail",
		 data :{"smp_aps_setgroup_seq" : groupSeq, "smp_aps_setdetail_nm" : addDetailName, "setSmp_aps_setdetail_ratio" : addDetailRatio},
		 dataType : 'json',
	     success:function(result){
			if(result>100){
				alert("디테일 비율 총합이 100을 넘습니다 다른 과목 비율을 조정 후 추가해 주세요");
			}else{
				alert("과목이 추가되었습니다");
				var groupSeq=$("#groupSeq").val();
				appendDetails(groupSeq);
			}
	     },
	     error:function(data)
	     {
	    	 alert("통신에러");
	     }
	    });
}

function removeTotal(){
	var setTotalTable = document.getElementById('setTotalTable');
}

function addGroup(data){
	var row = $(data).parent().parent();
	row.after('<tr><td><input class="setGroupName" type="text"></td><td><input type="text" class="setGroupRatio"></td><td><button onclick="removeRow(this)">-</button></td></tr>');

}

function addDetail(data){
	var row = $(data).parent().parent();
	row.after('<tr><td><input class="setGroupName" type="text"></td><td><input type="text" class="setDetailRatio"></td><td><button onclick="removeRow(this)">-</button></td></tr>');
}

function removeRow(obj){
	var row = $(obj).parent().parent().parent();
	row.remove();
}
</script>
</head>
<body>
   <div id="page">
      <div class="page-inner">
         <%@include file="adminmenu.jsp"%>
         <div class="gtco-section border-bottom">
            <div class="gtco-container">
            <div class="page_title">
				<h2>성적설정 페이지</h2>
			</div>
            <button type="button" class="btn btn-default" id="addNewSetbBtn" onclick="addNewSet()">추가</button>
               <div class="setlist">
                  <table class="setlistTable" id="setlistTable">
                        <tr class = "setlistColumn" id = "setlistColumn" >
                           <th>번호</th>
                           <th>설정명</th>
                           <th>적용 대상</th>
                           <th>적용</th>
                        </tr>
                     <c:forEach varStatus="stat" var="item" items="${apsSetList}">
                    	<tr class="setlistData" id="setlistData">
                           <td>${stat.count}<input type="hidden" value="${item.smp_aps_setlist_seq}"></td>
                           <td class="text_overflow"><a href="#" onclick="viewTotal(${item.smp_aps_setlist_seq})">${item.smp_aps_setlist_nm}</a></td>
                           <td>
                           <select name="gisu_seq" id="gisu_seq">
                            <c:forEach var="item" items="${gisu_list}">
                                 <option class="gisuChange" value="${item.gisu_seq}">${item.gisu_crc_nm}기</option>
                            </c:forEach>
                           </select>
                           </td>
                       		<td><button type="button" onclick="applySetList(${stat.count})">적용</button></td>
                        </tr>
             	  	</c:forEach>
                  </table>   
               </div>
            </div>
         </div>
      </div>
   </div>
   
   <div class="container">
      <!-- 모달 팝업 -->
      <div class="modal fade" id="apsSetListViewModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content" style="width: 770px; resize: none;">
               
               <input type="hidden" id="aps_setlist_seq">
               <div class="modal-header">
				
				     <button type="button" class="close" data-dismiss="modal">
                     <span aria-hidden="true">×</span> <span class="sr-only">Close</span>
                  </button>

                  <h4 class="modal-title" id="apsSetListModalLabel">설정상세보기</h4>
               </div>
   
               <div class="modal-body" id="modal-body">
               		<div id="tableSection">
               		</div>
               		<div id="addSection">
					</div>
               </div>
               	<div class="modal-footer" id="modal-footer">
               	<input type="hidden" id="updateSection">
               	  <button type="button" class="btn btn-default" id="changeSet" onclick="changeSetValue()" style="display:none">수정</button>
               	  <button type="button" class="btn btn-default" onclick="deleteSetList()">삭제</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
               		<input type="hidden" id="setlist_num">
               		<input type="hidden" id="totalSeq">
               		<input type="hidden" id="groupSeq">
            </div>
         </div>
      </div>
   </div>
   <div class="container">
      <!-- 모달 팝업 -->
      <div class="modal fade" id="addSetListViewModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content" style="width: 700px; resize: none;">
               
               <input type="hidden" id="aps_setlist_seq">
               <div class="modal-header">

                  <button type="button" class="close" data-dismiss="modal">
                     <span aria-hidden="true">×</span> <span class="sr-only">Close</span>
                  </button>

                  <h4 class="modal-title" id="addSetListViewModal">추가하기</h4>
               </div>
   
               <div class="modal-body">
               	 기수선택&nbsp;&nbsp;<select name="gisu_seq" id="gisuSelected" onchange="gisuSelected()">
               	 <option value="0">==기수선택==</option>
                      <c:forEach var="item" items="${gisu_list}">
                           <option value="${item.gisu_seq}">${item.gisu_crc_nm}기</option>
                      </c:forEach>
                  </select>
                  <form action="/smp/admin/addSetList" method="post" id="addSetList">
	                  <input type="text" name="setlist_nm" id="setlist_nm" placeholder="설정이름을 적어주세요">
	                  <input type="hidden" name="gisu_seq" id="gisu_seq_add_set_list">
               	  </form>
             			
		               <table id="totalListTable" style="width: 300px;border:1px solid;">
		               </table>
		               
		               <table id="groupListTable" style="width: 300px;border:1px solid;">
		               </table>
		               
		               <table id="detailListTable" style="width: 300px;border:1px solid;">
		               </table>
                </div>
               <div>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-default" onclick="addListSet()">기본설정리스트추가</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
               </div>
            </div>
         </div>
      </div>
   </div>	
   
   
</body>
</html>