<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
<!-- 페이징관련 css 시작 -->
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script type="text/javascript" src="/resources/segroup/js/jquery.timepicker.min.js"></script>
<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">
$(function() {
    // 달력설정 & 시간설정 연결하기
    $("#apply_future_date").datepicker();
    $("#apply_future_time").timepicker({
        'minTime' : '00:00am', // 조회하고자 할 시작 시간 ( 00시 부터 선택 가능하다. )
        'maxTime' : '23:55pm', // 조회하고자 할 종료 시간 ( 23시59분 까지 선택 가능하다. )
        'timeFormat' : 'H:i',
        'step' : 5 //test로 5분단위
    // 30분 단위로 지정. ( 10을 넣으면 10분 단위 )
    });
	
	$("#curSelect").change(function(){
		var crc_seq = $(this).val();
		
	    if(crc_seq == 0){
	    	//초기화
	    	var option = "<option value='0'>선택</option>";
	    	$("#gisuSelect").html(option);
	    }else{
	    	//초기화 후 ajax
	    	$.ajax({
				type:"POST",						
				url:"/edu/admin/search_cur_gisu",	
				data:{
					'crc_seq' : crc_seq,
				},
				success:function(data){	
					var option = "<option value='0'>선택</option>";
					$.each(data,function(index,item){
						option +='<option value="'+item.gisu_seq+'">'+item.gisu_crc_nm+'</option>';
					})
					$("#gisuSelect").html(option);
				},
				error: function(e){
					console.log(e);
				}
			});
	    }
	    
	});
	
});
	var myApp = angular.module('myapp', []);

	myApp.directive('selectcode', ['$http',function($http){
		return {
			restrict: "A",
			replace: true,
			scope : {
				value : '@'
			},
			controller: function ($scope, $element, $attrs) {
				$http({
					method: 'POST',
					url: '/codeconverter',
			  		responseType: 'text',
					params : {
						code : $attrs.value
					}
				}).then(function successCallback(response) {
		    		$scope.filterParams = response.data;
				}, function errorCallback(response) {
					console.log(response);
				});
			}
			,template: "<option>{{filterParams}}</option>"
		}
	}]);
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){

		
        // 
        $http({
            method: 'POST',
            url: "/edu/admin/search_apply_list"
        }).then(function successCallback(response) {
            $scope.list_draw(response);
        }, function errorCallback(response) {
            console.log(response);
        });
		
		$scope.doc_change = function(doc, app_rt_seq){
			var app_rt_doc = angular.element(doc).prevAll(".docSelect_prev").next().val();
			var gisu_seq = $("#gisuSelect option:selected").val();
			var curPage = $("#curPage1").val();
			var orderType = $("#orderType1").val();
			var orderValue = $("#orderValue1").val();
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			var search_doc_rt = $(':radio[name="search_doc_rt"]:checked').val();	//2018/09/12 원병호 추가
			var search_itv_rt = $(':radio[name="search_itv_rt"]:checked').val();	//2018/09/12 원병호 추가
			console.log(app_rt_doc);
			$http({
				method: 'POST',
				url: "/edu/admin/apply_result_update",
				params : {
					app_rt_doc : app_rt_doc,
					app_rt_seq : app_rt_seq,
					gisu_seq	: gisu_seq,
					curPage		: curPage,
					pageCount	: pageCount,
					search_name	: search_name,
					orderType	: orderType,
					orderValue	: orderValue,
					search_doc_rt : search_doc_rt,	// 검색 정보(서류전형) 2018/09/12 원병호 추가
					search_itv_rt : search_itv_rt	// 검색 정보(면접전형) 2018/09/12 원병호 추가
				}
			}).then(function successCallback(response) {
				alert("서류 결과를 변경 하였습니다.");
				$scope.list_draw(response);
			}, function errorCallback(response) {
				console.log(response);
			});
			
		};
		
		$scope.itv_change = function(itv, app_rt_seq){
            var app_rt_itv = angular.element(itv).prevAll(".itvSelect_prev").next().val();
			var gisu_seq = $("#gisuSelect option:selected").val();
			var curPage = $("#curPage1").val();
			var orderType = $("#orderType1").val();
			var orderValue = $("#orderValue1").val();
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			var search_doc_rt = $(':radio[name="search_doc_rt"]:checked').val();	//2018/09/12 원병호 추가
			var search_itv_rt = $(':radio[name="search_itv_rt"]:checked').val();	//2018/09/12 원병호 추가
			console.log(app_rt_itv);
			$http({
				method: 'POST',
				url: "/edu/admin/apply_result_update",
				params : {
					app_rt_itv : app_rt_itv,
					app_rt_seq : app_rt_seq,
					gisu_seq	: gisu_seq,
					curPage		: curPage,
					pageCount	: pageCount,
					search_name	: search_name,
					orderType	: orderType,
					orderValue	: orderValue,
					search_doc_rt : search_doc_rt,	// 검색 정보(서류전형) 2018/09/12 원병호 추가
					search_itv_rt : search_itv_rt	// 검색 정보(면접전형) 2018/09/12 원병호 추가
				}
			}).then(function successCallback(response) {
				alert("면접 결과를 변경 하였습니다.");
				$scope.list_draw(response);
			}, function errorCallback(response) {
				console.log(response);
			});
		};
		
		$scope.gisu_change = function(curPage,orderType,orderValue){
			var gisu_seq = $("#gisuSelect option:selected").val();
			var curPage = curPage;
			var orderType = orderType;
			var orderValue = orderValue;
			// 페이징 버튼 클릭 시 히든으로 주었던 orderType1, orderValue1 값 입력. 2018/09/12 신동철 추가
			if(orderType == null && orderValue == null){
				var orderType = $("#orderType1").val();
				var orderValue = $("#orderValue1").val();
			}
			var search_name = $("#searchName").val();
			var pageCount = $("#pageSelect option:selected").val();
			var search_doc_rt = $(':radio[name="search_doc_rt"]:checked').val();	//2018/09/12 원병호 추가
			var search_itv_rt = $(':radio[name="search_itv_rt"]:checked').val();	//2018/09/12 원병호 추가
			$http({
				method: 'POST',
				url: "/edu/admin/search_apply_list",
				params : {
					gisu_seq : gisu_seq,
					search_name : search_name,
					curPage : curPage,
					pageCount : pageCount,
					orderType : orderType,
					orderValue : orderValue,
					search_doc_rt : search_doc_rt,	// 검색 정보(서류전형) 2018/09/12 원병호 추가
					search_itv_rt : search_itv_rt	// 검색 정보(면접전형) 2018/09/12 원병호 추가
				}
			}).then(function successCallback(response) {
				$("#orderType1").val(orderType);
				$("#orderValue1").val(orderValue);
				$("#curPage1").val(curPage);
				$scope.list_draw(response);
			}, function errorCallback(response) {
				console.log(response);
			});
		}
		
		$scope.list_draw = function(response){
			var context = '';
			var map = response.data;
			
			$.each(response.data.resultList,function(index,item){
				context += '<tr>';
				context += '<td><input type="checkbox" class="gisuCheckBox" name="checkBoxs" value="'+item.app_seq+'"/></td>';
				context += '<td>'+ (map.totalCount - ((map.adminPager.curPage - 1) * (map.adminPager.pageBegin-1) + index)) + '</td>';
				context += '<td>'+item.gisu_crc_nm+'</td>';
                context += '<td  style="display:none;">'+item.gisu_seq+'</td>';
				context += '<td>'+item.gisu_num+'</td>';
				context += '<td>'+item.app_ins_dt+'</td>';
				context += '<td>'+item.app_id+'</td>';
				context += '<td>'+item.user_nm+'</td>';
				context += '<td>'+item.user_phone+'</td>';
                context += '<td>'+item.user_email+'</td>';
				context += '<td><input type="button" onclick="showApply(&quot;'+item.app_id+'&quot;,&quot;'+item.gisu_seq+'&quot;);" class="showApply" value="보기" /></td>';
				context += '<td><input type="hidden" class="docSelect_prev" />';
				context += '<select id="docSelect" class="docSelect" onchange="angular.element(this).scope().doc_change(this,'+item.app_rt_seq+')">';
				if(item.app_rt_doc == 'B1400'){
	    			context += '<option selectcode value="B1400" selected></option>';
		    		context += '<option selectcode value="B1401"></option>';
		    		context += '<option selectcode value="B1402"></option>';
	    		}else if(item.app_rt_doc == 'B1401'){
	    			context += '<option selectcode value="B1400"></option>';
		    		context += '<option selectcode value="B1401" selected></option>';
		    		context += '<option selectcode value="B1402"></option>';
	    		}else if(item.app_rt_doc == 'B1402'){
	    			context += '<option selectcode value="B1400"></option>';
		    		context += '<option selectcode value="B1401"></option>';
		    		context += '<option selectcode value="B1402" selected></option>';
	    		}
	    		context += '</select>';
				context += '</td>';
				context += '<td>'+item.app_rt_doc_dt+'</td>';
				context += '<td>'+item.app_rt_doc_id+'</td>';
				context += '<td><input type="hidden" class="itvSelect_prev" />';
                context += '<select id="itvSelect" class="itvSelect" onchange="angular.element(this).scope().itv_change(this,'+item.app_rt_seq+')">';
				if(item.app_rt_itv == 'B1700'){
	    			context += '<option selectcode value="B1700" selected></option>';
		    		context += '<option selectcode value="B1701"></option>';
		    		context += '<option selectcode value="B1702"></option>';
	    		}else if(item.app_rt_itv == 'B1701'){
	    			context += '<option selectcode value="B1700"></option>';
		    		context += '<option selectcode value="B1701" selected></option>';
		    		context += '<option selectcode value="B1702"></option>';
	    		}else if(item.app_rt_itv == 'B1702'){
	    			context += '<option selectcode value="B1700"></option>';
		    		context += '<option selectcode value="B1701"></option>';
		    		context += '<option selectcode value="B1702" selected></option>';
	    		}
	    		context += '</select>';
	    		context += '</td>';
	    		context += '<td>'+item.app_rt_itv_dt+'</td>';
                context += '<td>'+item.app_rt_itv_id+'</td>';
	    		context += '</tr>';

			});
			$("#search_data").html($compile(context)($scope));
			
			
			context = '';
			context += '<div class="pagination_con">';
			context += '<span id="page"style="display: inline; margin:auto; display:table; ">';
			context += '<h4><ul><li><ol>';
			if(map.adminPager.curBlock > 1){
				context += '<li><input type="button" ng-click="gisu_change(&quot;1&quot;)" name="" value="<<"></li>';
			}
			if(map.adminPager.curBlock > 1){
				context += '<li><input type="button" ng-click="gisu_change(&quot;'+map.adminPager.prevPage+'&quot;)" name="" value="<"></li>';
			}
			for(var i=map.adminPager.blockBegin; i<=map.adminPager.blockEnd; i++){
				if(i == map.adminPager.curPage){
					context += '<li><input id="cur_page_btn" type="button" style="color:red"name="" value="'+i+'"></li>';
				}else{
					context += '<li><input type="button" ng-click="gisu_change(&quot;'+i+'&quot;)" name="" value="'+i+'"></li>';
				}
			}
			if(map.adminPager.curBlock <= map.adminPager.totBlock){
				context += '<li><input type="button" ng-click="gisu_change(&quot;'+map.adminPager.nextPage+'&quot;)" name="" value=">"></li>';
			}
			if(map.adminPager.curPage <= map.adminPager.totPage){
				context += '<li><input type="button" ng-click="gisu_change(&quot;'+map.adminPager.totPage+'&quot;)" name="" value=">>"></li>';
			}
			context += '</ol></h4></li></ul></span></div>';
			
			$(".pagination_wrap").empty();
			$(".pagination_wrap").html($compile(context)($scope));
			
			// pageCountList 삽입
			context = '';
			context += '<option value="10">10개씩</option>';
			for(var i=0; i<map.adminPager.pageCountList.length; i++){
				if(map.adminPager.pageCountList[i] == map.pageCount){
					context += '<option value="'+map.adminPager.pageCountList[i]+'" selected>'+map.adminPager.pageCountList[i]+'개씩</option>';
				}else{
					context += '<option value="'+map.adminPager.pageCountList[i]+'">'+map.adminPager.pageCountList[i]+'개씩</option>';
				}
			}
			$("#pageSelect").html($compile(context)($scope));
			
		}
	}]);

	$(function() {
		initialize();
	});

	function initialize(){
		var orderType = $("#orderType").val();
		var orderValue = $("#orderValue").val();
		
		$.each($(".arrow"),function(index, item){
			if($(this).hasClass(orderType) && orderValue == 'asc'){
				$(this).removeClass('desc').addClass(orderValue);
				$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_up.png');
			}else{
				$(this).removeClass('asc').addClass(orderValue);
				$(this).attr('src','/resources/segroup/society/edu/image/main/triangle_down.png');
			}
		});
	}

	function order_change(orderType, target){
		var orderValue = '';
		
		if($(target).hasClass('desc')){
			$(target).removeClass('desc').addClass('asc');
			orderValue = 'asc';
			//오름차순 정렬 버튼 화살표 추가. 2018/09/12 신동철
			$(target).attr("src", "/resources/segroup/society/edu/image/main/triangle_up.png")
		}else{
			$(target).removeClass('asc').addClass('desc');
			orderValue = 'desc';
			//내림차순 정렬 버튼 화살표 추가. 2018/09/12 신동철
			$(target).attr("src", "/resources/segroup/society/edu/image/main/triangle_down.png")
		}
		
		var scope = angular.element(document.getElementById('myBody')).scope();
		scope.gisu_change(1,orderType,orderValue);
		//alert(scope.gisu_seq);
	}
	
	function showApply(app_id, gisu_seq){
		var app_id = app_id;
// 		var gisu_seq = $("#gisuSelect option:selected").val();
		var popupX = (window.screen.width / 2) - ( 1200 / 2 );
		var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
		//Document.domain="${path}/edu/admin/apply_manager_form";
		window.open("${path}/edu/admin/apply_info_update_form?gisu_seq="+gisu_seq+"&app_id="+app_id+"&pageCount=${map.pageCount}&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}",'지원서 수정','width=1200,height=700,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes');
		//location.href="${path}/edu/admin/apply_info_update_form?gisu_seq="+gisu_seq+"&app_id="+app_id+"&pageCount=${map.pageCount}&curPage=${map.adminPager.curPage}&orderType=${map.orderType}&orderValue=${map.orderValue}";
	}
	
	$(function() {
        // textarea 키입력 시 + 포커스아웃 시
        $('#modal_textarea').on('keyup focusout mousedown mousehover', function (e){
            textLengthCheck($(this));
        });
        $('#modal_textarea').keyup();
        // 문자[장문] 키입력 시 + 포커스아웃 시
        $('#modal_title_lms').on('keyup focusout mousedown mousehover', function (e){
        	byteCheck_putText($(this), 45);
        });
        $('#modal_title_lms').keyup();
	});
    
	// textarea 글자수 카운터
	function textLengthCheck(a) {
	    if ($("input:radio[name=radio_select]:checked").val() == "mail") {
	        $('#counter').html(a.val().length + '/2000자');
	    } else if ($("input:radio[name=radio_select]:checked").val() == "sms") {
	    	byteCheck_putText(a, 90);
        } else {
            byteCheck_putText(a, 2000);
        }
	}
	// textarea 바이트수 카운터
	function byteCheck(a) {
		return (function(s,b,i,c){
            for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1);
            return b
        })(a.val());
	}
	function byteCheck_putText(a, maxByte) {
        // 문자열 BYTE 계산
        var stringByteLength = byteCheck(a);
        // 설정 최대 바이트 수를 넘길 경우
        if (stringByteLength > maxByte) {
            a.val(cutByLen(a.val(), maxByte));
            stringByteLength = maxByte;
        }
        // 바이트수 화면출력
        $('#counter').html(stringByteLength + '/' + maxByte + 'byte');
	}
    // 원하는 바이트수만큼 문자열 잘라내기
	function cutByLen(str, maxByte) {
		for(b=i=0;c=str.charCodeAt(i);) {
			b+=c>>7?2:1;
			if (b > maxByte)
				break;
			i++;
		}
		return str.substring(0,i);
	}

	$(document).ready(function() {
		
        // 라디오 버튼(메일or문자[단문]or문자[장문])을 클릭했을 때
        $("input:radio[name=radio_select]").click(function(){
        	// 메일 선택 시
            if($(this).val() == "mail"){
                btn_mail.style.display='';
                btn_sms.style.display='none';
                btn_lms.style.display='none';
                modal_title_div.style.display='';
                modal_title_div_lms.style.display='none';
            }
            // 문자[단문] 선택 시
            else if($(this).val() == "sms"){
                btn_mail.style.display='none';
                btn_sms.style.display='';
                btn_lms.style.display='none';
                modal_title_div.style.display='none';
                modal_title_div_lms.style.display='none';
            }
            // 문자[장문] 선택 시
            else if($(this).val() == "lms"){
                btn_mail.style.display='none';
                btn_sms.style.display='none';
                btn_lms.style.display='';
                modal_title_div.style.display='none';
                modal_title_div_lms.style.display='';
                byteCheck_putText($('#modal_title_lms'), 45);
            }
            textLengthCheck($('#modal_textarea'));
        });
        
        // 예약발송 체크박스를 클릭했을 때
        $("input:checkbox[name=is_check]").click(function(){
            if($("input:checkbox[name=is_check]").is(":checked")){
	            if ($("input:radio[name=radio_select]:checked").val() == "mail") {
	                alert("현재, 메일의 예약발송 기능은 지원하지 않습니다");
	                return false;
	            } else {
	                apply_future_date.style.display='';
	                apply_future_time.style.display='';
	            }
            } else {
                apply_future_date.style.display='none';
                apply_future_time.style.display='none';
            }
        });

        // 메일발송 버튼을 클릭했을 때
        $("#btn_mail").click(function(){
            var modal_sendDate = "";
            
            // 예약발송 체크가 되어 있다면
            if($("input:checkbox[name=is_check]").is(":checked")){
                if(!isDateCorrect()) {
                    return false;
                }
                modal_sendDate = $(apply_future_date).val() + ' ' + $(apply_future_time).val() + ':00.0';
            }
            // 제목 Validation Check
            if($(modal_title).val() == '' || $(modal_title).val() == null){
                alert('제목을 입력해 주시기 바랍니다');
                selectAndFocus(modal_title);
                return false;
            }
            // 내용 Validation Check
            if($(modal_textarea).val() == '' || $(modal_textarea).val() == null){
                alert('내용을 입력해 주시기 바랍니다');
                selectAndFocus(modal_textarea);
                return false;
            }
            
            // 움직이는 로딩표시 보이기
            $.LoadingOverlay("show");
        	
            // 이메일 주소들을 전송하기 위한 포맷으로 변경(구분자: , )
            var info_email="";
            $(":checkbox[name='checkBoxs']:checked").each(function(index){
                checked_tr = $(this).parent().parent().children();
                info_email += checked_tr.eq(9).text() + ",";
            });
            
            // AJAX-메일 발송하기
            $.ajax({
                type : "POST",
                url : "/edu/admin/send_mail",
                data : {
                    info_email : info_email,
                    modal_title : $(modal_title).val(),
                    modal_textarea : $(modal_textarea).val(),
                    modal_sendDate : modal_sendDate
                },
                success : function(isRequested) {
                    $.LoadingOverlay("hide");
                    alert("메일발송 완료되었습니다(" + isRequested + "건)");
                },
                error : function(e) {
                    $.LoadingOverlay("hide");
                    alert("에러가 발생하였습니다.\n홈페이지 관리자에게 문의해주십시요.");
                }
            });
        });
        
        // AJAX-문자[단문]문) 발송하기
        $("#btn_sms").click(function(){
            
            // 예약발송 체크가 되어 있다면
            var info_rdate="";
            var info_rtime="";
            if($("input:checkbox[name=is_check]").is(":checked")){
                if(!isDateCorrect()) {
                	return false;
                }
                info_rdate = $(apply_future_date).val().replace(/\-/g, '');
                info_rtime = $(apply_future_time).val().replace(/\:/g, '');
            }
            // 내용 Validation Check
            if($(modal_textarea).val() == '' || $(modal_textarea).val() == null){
                alert('내용을 입력해 주시기 바랍니다');
                selectAndFocus(modal_textarea);
                return false;
            }
            
            // 움직이는 로딩표시 보이기
            $.LoadingOverlay("show");
            
            var info_receiver="";
            var info_destination="";
            var tmp_phone = "";
            var tmp_name = "";
            $(":checkbox[name='checkBoxs']:checked").each(function(index){
            	tmp_name = $(this).parent().parent().children().eq(7).text();
            	tmp_phone = $(this).parent().parent().children().eq(8).text();
                info_receiver += tmp_phone + ",";
                info_destination += tmp_phone + "|" + tmp_name + ",";
            });
            // 문자열 마지막 콤마 제거
            info_receiver = info_receiver.substr(0, info_receiver.length - 1);
            info_destination = info_destination.substr(0, info_destination.length - 1);
            
            // AJAX-REST API SMS 발송하기
            $.ajax({
                type : "POST",
                url : "/edu/admin/send_sms",
                data : {
                    receiver : info_receiver,   // // 수신자 전화번호 - 컴마(,)분기 입력으로 최대 1천명
                    destination : info_destination, // %고객명% 치환용 입력
                    msg : $(modal_textarea).val(), // 메시지 내용
                    rdate : info_rdate,   // 예약일 (현재일이상)
                    rtime : info_rtime,   // 예약시간 - 현재시간기준 10분이후
                },
                success : function(data) {
                    $.LoadingOverlay("hide");
                    var json = JSON.parse(data);
//                     alert("json.result_code : " + json.result_code);
                    if (json.result_code == 1) {
                        alert("문자발송 완료되었습니다(성공:" + json.success_cnt + "건/실패:" + json.error_cnt + "건)");
                    } else {
                        alert(json.message);
                    }
                },
                error : function(e) {
                    $.LoadingOverlay("hide");
                    alert("에러가 발생하였습니다.\n홈페이지 관리자에게 문의해주십시요.");
                }
            });
        });
        
        // AJAX-문자[장문] 발송하기
        $("#btn_lms").click(function(){
            
            // 예약발송 체크가 되어 있다면
            var info_rdate="";
            var info_rtime="";
            if($("input:checkbox[name=is_check]").is(":checked")){
                if(!isDateCorrect()) {
                    return false;
                }
                info_rdate = $(apply_future_date).val().replace(/\-/g, '');
                info_rtime = $(apply_future_time).val().replace(/\:/g, '');
            }
            // 제목 Validation Check
            if($(modal_title_lms).val() == '' || $(modal_title_lms).val() == null){
                alert('제목을 입력해 주시기 바랍니다');
                selectAndFocus(modal_title_lms);
                return false;
            }
            // 내용 Validation Check
            if($(modal_textarea).val() == '' || $(modal_textarea).val() == null){
                alert('내용을 입력해 주시기 바랍니다');
                selectAndFocus(modal_textarea);
                return false;
            }
            // LMS일 때에만 하는 내용길이 체크
            if (byteCheck($(modal_textarea)) <= 90) {
                if (!confirm("문자내용의 길이가 90 byte 미만이기 때문에\nSMS(단문)으로 전환되어 제목없이 발송됩니다.\n그래도 진행하시겠습니까?")) {
                    return false;
                }
            }
            
            // 움직이는 로딩표시 보이기
            $.LoadingOverlay("show");
            
            // 수신자 전화번호 - 컴마(,)분기 입력으로 최대 1천명 ex) 01111111111,01111111112
            // %고객명% 치환용 입력 ex) 01111111111|홍길동,01111111112|아무개
            var info_receiver="";
            var info_destination="";
            var tmp_phone = "";
            var tmp_name = "";
            $(":checkbox[name='checkBoxs']:checked").each(function(index){
                tmp_name = $(this).parent().parent().children().eq(7).text();
                tmp_phone = $(this).parent().parent().children().eq(8).text();
                info_receiver += tmp_phone + ",";
                info_destination += tmp_phone + "|" + tmp_name + ",";
            });
            // 문자열 마지막 콤마 제거
            info_receiver = info_receiver.substr(0, info_receiver.length - 1);
            info_destination = info_destination.substr(0, info_destination.length - 1);
            
            // AJAX-REST API SMS 발송하기
            $.ajax({
                type : "POST",
                url : "/edu/admin/send_sms",
                data : {
                    receiver : info_receiver,   // // 수신자 전화번호 - 컴마(,)분기 입력으로 최대 1천명
                    destination : info_destination, // %고객명% 치환용 입력
                    msg : $(modal_textarea).val(), // 메시지 내용
                    title : $(modal_title_lms).val(),   // 문자제목(LMS,MMS만 허용)
                    rdate : info_rdate,   // 예약일 (현재일이상)
                    rtime : info_rtime,   // 예약시간 - 현재시간기준 10분이후
                },
                success : function(data) {
                    $.LoadingOverlay("hide");
                    var json = JSON.parse(data);
                    if (json.result_code == 1) {
                        alert("문자발송 완료되었습니다(성공:" + json.success_cnt + "건/실패:" + json.error_cnt + "건)");
                    } else {
                    	alert(json.message);
                    }
                },
                error : function(e) {
                    $.LoadingOverlay("hide");
                    alert("에러가 발생하였습니다.\n홈페이지 관리자에게 문의해주십시요.");
                }
            });
        });
	});

    function show(){
        if ($("input:checkbox[name=checkBoxs]:checked").length == 0) {
            alert("선택된 지원자가 없습니다.\n지원자를 선택(체크)해주세요.");
            return false;
        }
        
        // 선택(체크)된 지원자의 정보취득
        var info_name="";
        $(":checkbox[name='checkBoxs']:checked").each(function(index){
        	checked_tr = $(this).parent().parent().children();
            info_name += checked_tr.eq(7).text() + "(" + checked_tr.eq(8).text() + " / " + checked_tr.eq(9).text() + ")\n";
        });
        // 문자열 마지막 콤마 제거
        info_name = info_name.substr(0, info_name.length - 1);
        
        // 모달창의 해당영역에 이름정보 넣기
        $("#modal-info_name").html(info_name);
        $("#content").html("ajax를 통해 얻어온 id에 해당하는 값");
        
        // 모달 높이설정
        myModal.style.height='520px';
        modal_dialog.style.height='520px';
        modal_content.style.height='520px';
        modal_body.style.height='430px';
        wrap.style.height='250px';
        modal_textarea.style.height='230px';
        modal_title_div_lms.style.display='none';
        
        // 모달 속 예약발송(checkbox)를 체크해제해준다
        $("input:checkbox[name=is_check]").prop("checked",false);
        
        // modal을 띄워준다.  
        $("#myModal").modal('show');
    }
	
	var allChecked = false;
	function all_agree(){
		if(!allChecked) {
			//해당화면에 전체 checkbox들을 체크해준다
			$("input[type=checkbox]").prop("checked",true);
			allChecked = true;
		} else {
			//해당화면에 모든 checkbox들의 체크를해제시킨다.
			$("input[type=checkbox]").prop("checked",false);
            allChecked = false;
		}
	}
	
	function copy_to_smp(){
		if ($("input:checkbox[name=checkBoxs]:checked").length == 0) {
            alert("선택된 지원자가 없습니다.\n지원자를 선택(체크)해주세요.");
            return false;
        }
		
		var app_array = new Array;
		
		$(":checkbox[name='checkBoxs']:checked").each(function(index,item){
			
			var apply = {
					app_seq : item.value
					,app_id : $(this).closest("tr").find("td:eq(6)").text()
					,gisu_seq : $(this).closest("tr").find("td:eq(3)").text()
			};
			
			app_array.push(apply);			
			
        });
		
		$.ajax({
            type : "POST",
            url : "/edu/admin/copy_to_smp",
            data : JSON.stringify(app_array)
            ,dataType : "json"
            ,contentType : 'application/json'
            ,success : function(data) {
            	alert("지원정보가 학사정보로 복사 되었습니다.");
            },
            error : function(e) {
            	alert("복사가 실패 하였습니다.");
            }
        });
		
	}
	
	function open_printpage() {
        if ($("input:checkbox[name=checkBoxs]:checked").length == 0) {
            alert("선택된 지원자가 없습니다.\n지원자를 선택(체크)해주세요.");
            return false;
        }
        
        // 선택(체크)된 지원자의 정보취득
        var app_info="";
        $(":checkbox[name='checkBoxs']:checked").each(function(index){
            checked_tr = $(this).parent().parent().children();
            app_info += checked_tr.eq(3).text() + ",";
            app_info += checked_tr.eq(6).text() + ";";
        });
        // 문자열 마지막 콤마 제거
        app_info = app_info.substr(0, app_info.length - 1);
        
        // 프린트할 지원서 페이지 띄우기
        var popupX = (window.screen.width / 2) - ( 1200 / 2 );
        var popupY = (window.screen.height / 2) - ( 700 / 2 ) - 50;
        window.open("${path}/edu/admin/apply_info_print_form?app_info="+app_info, "지원서 인쇄", "width=1200,height=700,left='+popupX+',top='+popupY+',screenX='+popupX+',screenY='+popupY+',toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=yes,scrollbars=no,copyhistory=no,scrollbars=yes");
	}

	/**
	 * 예약날짜와 시간이 형식에 올바른지 확인
	 */
	function isDateCorrect() {
	    var input_date = $('#apply_future_date');
	    var apply_time = $('#apply_future_time');

	    if (input_date.val() == '') {
	        alert('발송예약 날짜를 입력해 주시기 바랍니다');
	        selectAndFocus(input_date);
	        return false;
	    }

	    if (apply_time.val() == '') {
	        alert('발송예약 시간을 입력해 주시기 바랍니다');
	        selectAndFocus(apply_time);
	        return false;
	    }

	    var today = new Date();
	    var dd = today.getDate();
	    var mm = today.getMonth() + 1; //January is 0!
	    var yyyy = today.getFullYear();
	    if (dd < 10) {
	        dd = '0' + dd
	    }
	    if (mm < 10) {
	        mm = '0' + mm
	    }
	    today = yyyy + mm + dd;
	    if (today > input_date.val().replace(/\-/g, '')) {
	        alert('과거는 선택하실 수 없습니다');
	        selectAndFocus(input_date);
	        return false;
	    }

	    var regNumber = /^[0-9]*$/;
	    if (!regNumber.test(apply_time.val().replace(/\:/g, ''))) {
	        alert('시간 형식에 맞추어 주시기 바랍니다');
	        selectAndFocus(apply_time);
	        return false;
	    }

	    var minTime = 0000; // 00:00을 의미
	    var maxTime = 2355; // 23:55을 의미
	    if (minTime > apply_time.val().replace(/\:/g, '')
	            || maxTime < apply_time.val().replace(/\:/g, '')) {
	        alert('정해진 시간 이내로 입력해 주시기 바랍니다');
	        selectAndFocus(apply_time);
	        return false;
	    }
	    return true;
	}

    /**
     * 엘리먼트를 선택한다
     */
    function selectAndFocus(element) {
        element.select();
        element.focus();
    }

</script>
<style type="text/css">
#myModal, #modal_dialog, #modal_content, #modal_body {
	height: 1px;
}

.wrap {
	width: 95%;
	position: relative;
	display: inline-block;
}

.wrap textarea {
	width: 100%;
	resize: none;
	line-height: 1.6em;
}

.wrap span {
	position: absolute;
	bottom: 10px;
	right: 1px;
}

#counter {
	background: rgba(255, 0, 0, 0.5);
	border-radius: 0.5em;
	padding: 0 .5em 0 .5em;
	font-size: 0.75em;
}
</style>
</head>
<body id="myBody" ng-app="myapp" ng-controller="AdminController">
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>지원자 관리 페이지</h2>
	</div>
	<div class="custom_div">
		<table class="search_box">
			<tr>
				<th>과정명으로 검색</th>
				<td>
					<select id="curSelect">
						<option value="0">선택</option>
						<c:forEach var="data" items="${seaCurList }">
							<option value="${data.crc_seq }">${data.crc_nm }</option>
						</c:forEach>
					</select>
				</td>
				<td>
					<select id="gisuSelect" onchange="angular.element(this).scope().gisu_change('')">
						<option value="">과정을 선택하세요</option>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>이름으로 검색</th>
				<td>
					<input type="text" id="searchName">
				</td>
				<td class="td_search" colspan="2">
					<button type="button" class="btn_search" ng-click="gisu_change()">검색</button>
				</td>
			</tr>
			
			<!-- 2018/09/12 추가 서류&면접 전형 합격,불합격,대기 인 인원 검색 기능 -->
			<tr>
				<th>서류전형 결과로 검색</th>
				<td>
					합격<input type="radio" value="B1401" name="search_doc_rt">
					불합격<input type="radio" value="B1402" name="search_doc_rt">
					대기<input type="radio" value="B1400" name="search_doc_rt">
					상관없음<input type="radio" value="" name="search_doc_rt" checked="checked">
				</td>
			
				<th>면접전형 결과로 검색</th>
				<td>
					합격<input type="radio" value="B1701" name="search_itv_rt">
					불합격<input type="radio" value="B1702" name="search_itv_rt">
					대기<input type="radio" value="B1700" name="search_itv_rt">
					상관없음<input type="radio" value="" name="search_itv_rt" checked="checked">
				</td>
			</tr>
		</table>
		<select id="pageSelect" onchange="angular.element(this).scope().gisu_change('')">
			<option value="10">10개씩</option>
		</select>
		<button type="button" class="btn_search" onclick="copy_to_smp()" style="float: right; margin-top: 20px; margin-right: 10px; width: 150px;">학사로 이동</button>
		<button type="button" class="btn_search" onclick="show()" style="float: right; margin-top: 20px; margin-right: 10px; width: 100px;">메일 / 문자</button>
		<button type="button" class="btn_search" onclick="open_printpage()" style="float: right; margin-top: 20px; margin-right: 10px; width: 100px;">선택인쇄</button>
		<button type="button" class="btn_search" onclick="all_agree()" style="float: right; margin-top: 20px; margin-right: 10px; width: 150px;">전체선택 / 해제</button>
		<table class="table">
			<thead>
				<tr>
					<th>선택</th>
					<th>No</th>
					<th>과정명</th>
					<th>과정기수</th>
					<th>지원일 &nbsp;<img class="arrow desc apply_date" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('apply_date', this)"></th>
					<!-- 아이디, 성명 정렬 버튼 추가. 2018/09/12 신동철 -->
					<th>아이디 &nbsp;<img class="arrow desc apply_id" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('apply_id', this)"></th>
					<th>성명 &nbsp;<img class="arrow desc apply_name" src="/resources/segroup/society/edu/image/main/triangle_down.png;" onclick="order_change('apply_name', this)"></th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>지원신청서</th>
					<th>서류전형</th>
					<th>처리일</th>
					<th>담당자</th>
					<th>면접전형</th>
					<th>처리일</th>
					<th colspan="2">담당자</th>
				</tr>
			</thead>
			<tbody id="search_data">
			</tbody>
		</table>
		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog" id="modal_dialog">
				<!-- Modal content-->
				<div class="modal-content" id="modal_content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title" id="title">e-Mail / SMS 발송기능</h4>
					</div>
					<div class="modal-body" id="modal_body" style="margin: 10 auto;">
						<div>
							<input type="radio" name="radio_select" value="mail" checked>
							메일
							<input type="radio" name="radio_select" value="sms">
							문자[단문]
							<input type="radio" name="radio_select" value="lms">
							문자[장문]
							<input type="checkbox" name="is_check" value="is_check" style="width: 30px;">
							예약발송
							<div id="apply_future_datetime" style="float: right;">
								<input type="text" id="apply_future_date" name="apply_future_date" placeholder="상담 날짜" value="" style="width: 80px; display: none;" readonly="readonly" />
								<input type="text" id="apply_future_time" name="apply_future_time" placeholder="상담 시간" value="" style="width: 60px; display: none;" />
							</div>
						</div>
						<div class="line_textarea">
							<textarea id="modal-info_name" readonly="readonly" style="resize: none; height: 70px;"></textarea>
						</div>
						<div id="modal_title_div">
							<input type="text" id="modal_title" name="modal_title" placeholder="제목 (50자이내)" style="margin-left: 4px; width: 500px;" maxlength="50">
						</div>
						<div id="modal_title_div_lms">
							<input type="text" id="modal_title_lms" name="modal_title_lms" placeholder="제목 (45Byte이내 : ex. 한글로는 22자, 영대소문자, 숫자, 기호로는 45자)" style="margin-left: 4px; width: 500px;" maxlength="45">
						</div>
						<div class="wrap" id="wrap">
							<textarea id="modal_textarea" name="modal_textarea" placeholder="내용(문자의 경우, %고객명% 사용시 개개인의 이름으로 치환되어 발송됩니다. ex. %고객명%님! 안녕하세요.)" maxlength="2000"></textarea>
							<span id="counter">####</span>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" id="btn_mail">메일발송</button>
						<button type="button" class="btn btn-default" id="btn_sms" style="display: none;">문자발송</button>
						<button type="button" class="btn btn-default" id="btn_lms" style="display: none;">문자발송</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="pagination_wrap"></div>
	<div style="display: none;">
		<input type="hidden" id="curPage1" value="">
		<input type="hidden" id="orderType1" value="">
		<input type="hidden" id="orderValue1" value="">
	</div>
	<div id="mask"></div>
</body>
</html>