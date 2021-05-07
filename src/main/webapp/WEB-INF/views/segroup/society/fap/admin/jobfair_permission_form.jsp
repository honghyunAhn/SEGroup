<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
	<script src="<c:url value="/resources/segroup/society/fap/js/layer.js" />"></script>
	<script type="text/javascript" src="/resources/segroup/js/jquery.timepicker.min.js"></script>
	<link type="text/css" rel="stylesheet" href="/resources/segroup/css/jquery.timepicker.css" media="" />
	<!-- modal을 위한 bootstrap 시작-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/layer.css" />" media="" />
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/newAdminDefault.css" />" media="" />
	
	<!--  modal을 위한 bootstrap 끝 -->
	
	<title>Bridge Job Fair</title>
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
		});
		</script>
		
		<script type="text/javascript">	
		
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
		
		myApp.directive('code', [ '$http', function($http) {
			return {
				restrict : "E",
				replace : true,
				scope : {
					value : '@'
				},
				controller : function($scope, $element, $attrs) {
					$http({
						method : 'POST',
						url : '/codeconverter',
						responseType : 'text',
						params : {
							code : $attrs.value
						}
					}).then(function successCallback(response) {
						$scope.filterParams = response.data;
					}, function errorCallback(response) {
						//console.log(response);
					});
				},
				template : "<span>{{filterParams}}</span>"
			}
		} ]);
		
		myApp.controller('PermissionController', ['$scope','$compile','$http', function($scope,$compile,$http){			
	        // 승인 페이지 로딩 시 실행
	        $http({
	            method: 'POST',
	            url: "/fap/admin/jobfair_search_list"
	        }).then(function successCallback(response) {
	            $scope.type_draw();
	            $scope.per_draw();
	        }, function errorCallback(response) {
	       
	        });		
			
	        //검색할 지원자 변경시 다시 검색
			$scope.search_change = function(curPage, orderType, orderValue){
				var fap_jobfair_seq = $('#jobfairSelect').val();
				var user_flag = $('#typeSelect').val();
				var fap_jobfair_user_per = $('#perSelect').val();
				var user_nm = $('#searchName').val();
				var curPage = curPage;
				var orderType = orderType;
				var orderValue = orderValue;
				if(orderType == null && orderValue == null){
					var orderType = $("#orderType1").val();
					var orderValue = $("#orderValue1").val();
				}
				var pageCount = $("#pageSelect option:selected").val();
				
				console.log('fap_jobfair_seq : ' + fap_jobfair_seq);
				console.log('user_flag : ' + user_flag);
				console.log('fap_jobfair_user_per : ' + fap_jobfair_user_per);
				console.log('user_nm : ' + user_nm);
				console.log('curPage : ' + curPage);
				console.log('orderType : ' + orderType);
				console.log('orderValue : ' + orderValue);
				console.log('pageCount : ' + pageCount);
				console.log('-------------------------------');
				
				$http({
					method: 'POST',
					url: "/fap/admin/search_jobfair_user_apply_info",
					params : {
						fap_jobfair_seq : fap_jobfair_seq
						, user_flag : user_flag
						, fap_jobfair_user_per : fap_jobfair_user_per
						, user_nm : user_nm
						, curPage : curPage
						, pageCount : pageCount
						, orderType : orderType
						, orderValue : orderValue
					}
				}).then(function successCallback(response) {
					 $scope.list_draw(response);
					 $scope.paging_draw(response);			
				}, function errorCallback(response) {
				
				});
			}
			
			//회원타입 선택
			$scope.type_draw = function(){
				var context = '';
				context += '<option value="">선택</option>';
				context += '<option selectcode value="A0101"></option>';
				context += '<option selectcode value="A0106"></option>';
				context += '<option selectcode value="A0108"></option>';
				context += '<option selectcode value="A0100"></option>';
				context += '<option selectcode value="A0102"></option>';
				$("#typeSelect").html($compile(context)($scope));
			}
			
			//승인여부 선택
			$scope.per_draw = function(){
				var context = '';
				context += '<option value="">선택</option>';
				context += '<option selectcode value="C1000"></option>';
				context += '<option selectcode value="C1001"></option>';
				$("#perSelect").html($compile(context)($scope));
			}
			
			//지원자 검색결과 리스트
			$scope.list_draw = function(response){
				var map = response.data;
				$scope.results = response.data.resultList;
				var pageCount = response.data.pageCount;
				var curPage = response.data.adminPager.curPage;
				var prevPagesTotCnt = (pageCount) * (curPage - 1);				
				$scope.prevPagesTotCnt = prevPagesTotCnt;				
				var context = '';				
				context += '<tr>';
				context += '<tr ng-repeat="result in results | filter:query">';
				context += '<td><input type="checkbox" name="checkBoxs" value="{{result.fap_jobfair_user_seq}}" class="form-control"></td>';
				context += '<td>{{prevPagesTotCnt + $index+1}}</td>';				
				/* context += '<td>{{result.fap_jobfair_title}}</td>'; */				
				context += '<td ng-if="result.user_flag == \'A0101\' ">';				
				context += '<span  selectcode value="A0101"></span>';
				context += '</td>';
				context += '<td ng-if="result.user_flag == \'A0106\' ">';				
				context += '<span selectcode value="A0106"></span>';
				context += '</td>';
				context += '<td ng-if="result.user_flag == \'A0100\' ">';				
				context += '<span selectcode value="A0100"></span>';
				context += '</td>';
				context += '<td ng-if="result.user_flag == \'A0108\' ">';				
				context += '<span selectcode value="A0108"></span>';
				context += '</td>';
				context += '<td ng-if="result.user_flag == \'A0102\' ">';				
				context += '<span selectcode value="A0102"></span>';
				context += '</td>';
				context += '<td><a href="javascript:void(0)" ng-click="layerEdu(result.user_id,result.fap_personal_user_seq,result.fap_personal_user_edu_level)">{{result.user_nm}}</a></td>';	
				context += '<td>{{result.user_age}}</td>';
				context += '<td>{{result.fap_personal_user_job_objective}}</td>';
				context += '<td>{{result.user_phone}}</td>';
				context += '<td>{{result.user_email}}</td>';
				context += '<td>{{result.fap_jobfair_user_app_dt}}</td>';
				context += '<td>{{result.fap_jobfair_user_per_dt}}</td>';
				context += '<td>{{result.fap_jobfair_user_per_id}}</td>';
				context += '<td ng-if="result.fap_jobfair_user_per == \'C1000\' ">';				
				context += '<span selectcode value="C1000"></span>';
				context += '</td>';
				context += '<td ng-if="result.fap_jobfair_user_per == \'C1001\' ">';				
				context += '<span selectcode value="C1001"></span>';
				context += '</td>';
				context += '</tr>';

				$("#search_data").html($compile(context)($scope)); 				
								
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
			
			$scope.layerEdu = function(user_id,fap_personal_user_seq,fap_personal_user_edu_level){
				$http({
					method: 'POST',
					url: "/fap/admin/search_jobfair_user_edu_info",
					params : {
						user_id : user_id
						, fap_personal_user_seq : fap_personal_user_seq
						, fap_personal_user_edu_level : fap_personal_user_edu_level
					}
				}).then(function successCallback(response) {
					 layer_popup("#edu_layer");
					 $scope.layerInit(response.data, fap_personal_user_edu_level);
					 
				}, function errorCallback(response) {
				
				});
			}
			
			$scope.layerClear = function(){
				$(".pop-common").empty();
				$(".pop-hs").empty();
				$(".pop-uni").empty();
				$(".pop-gradu").empty();
			}
			
			$scope.layerInit = function(data,level){
				console.log(data);
				$scope.layerClear();
				
				/* 공통 부분 */
				var com_text = '<div>';
				com_text += '생년월일 : ' + data.user.user_birth;
				com_text += '</div>';
				com_text += '<div>';
				com_text += '성별 : <code value="'+data.user.user_sex+'"></code>';
				com_text += '</div>';
				com_text += '<div>';
				com_text += '최종학력 : <code value="'+level+'"></code>';
				com_text += '</div>';
				
				/* 학력 부분 */
				if(level == 'B3300'){
					//고등학교
					var hs_text = '<div>';
					hs_text += '고등학교명 : '+data.edu.fap_personal_hs_nm;
					hs_text += '</div>';
					hs_text += '<div>';
					hs_text += '계열 : <code value="'+data.edu.fap_personal_hs_field+'"></code>';
					hs_text += '</div>';

					$(".pop-hs").html($compile(hs_text)($scope));
					
				}else{
					//대학교
					var uni_text = '<div>';
					uni_text += '대학교명 : '+data.edu.fap_personal_univ_nm;
					uni_text += '</div>';
					uni_text += '<div>';
					uni_text += '국내/외 구분 : <code value="'+data.edu.fap_personal_univ_abroad_ck+'"></code>';
					uni_text += '</div>';
					uni_text += '<div>';
					uni_text += '학부 : <code value="'+data.edu.fap_personal_univ_coll+'"></code>';
					uni_text += '</div>';
					uni_text += '<div>';
					uni_text += '세부전공 : '+data.edu.fap_personal_univ_major;
					uni_text += '</div>';
					
					$(".pop-uni").html($compile(uni_text)($scope));
					
					if(level == 'B3303' || level == 'B3306'){
					//대학원
					var gradu_text = '<div>';
						gradu_text += '대학원명 : '+data.edu.fap_personal_grad_nm;
						gradu_text += '</div>';
						gradu_text += '<div>';
						gradu_text += '석/박사 구분 : <code value="'+data.edu.fap_personal_grad_ck+'"></code>';
						gradu_text += '</div>';
						gradu_text += '<div>';
						gradu_text += '전공분야 : '+data.edu.fap_personal_grad_major;
						gradu_text += '</div>';
					
						$(".pop-gradu").html($compile(gradu_text)($scope));
					}
				
				}
					
				$(".pop-common").html($compile(com_text)($scope));
			}
			

			// 페이징 출력
			 $scope.paging_draw = function(response){					
				var context ='';
				var map = response.data;							  
				context = '';
				context += '<div class="pagination_con">';
				context += '<span id="page"style="display: inline; margin:auto; display:table; ">';
				context += '<ul><li>';
				if(map.adminPager.curBlock > 1){
					context += '<li><input type="button" ng-click="search_change(&quot;1&quot;)" name="" value="<<"></li>';
				}
				if(map.adminPager.curBlock > 1){
					context += '<li><input type="button" ng-click="search_change(&quot;'+map.adminPager.prevPage+'&quot;)" name="" value="<"></li>';
				}
				for(var i=map.adminPager.blockBegin; i<=map.adminPager.blockEnd; i++){
					if(i == map.adminPager.curPage){
						context += '<li><input id="cur_page_btn" type="button" style="color:red"name="" value="'+i+'"></li>';
					}else{
						context += '<li><input type="button" ng-click="search_change(&quot;'+i+'&quot;)" name="" value="'+i+'"></li>';
					}
				}
				if(map.adminPager.curBlock <= map.adminPager.totBlock){
					context += '<li><input type="button" ng-click="search_change(&quot;'+map.adminPager.nextPage+'&quot;)" name="" value=">"></li>';
				}
				if(map.adminPager.curPage < map.adminPager.totPage){
					context += '<li><input type="button" ng-click="search_change(&quot;'+map.adminPager.totPage+'&quot;)" name="" value=">>"></li>';
				}
				context += '</li></ul></span></div>';
				
				 
				$(".pagination_wrap").html($compile(context)($scope));		 										
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
					$(this).attr('src','/resources/segroup/society/fap/images/main/triangle_up.png;');
				}else{
					$(this).removeClass('asc').addClass(orderValue);
					$(this).attr('src','/resources/segroup/society/fap/images/main/triangle_down.png;');
				}
			});
		}

		function order_change(orderType, target){
			var orderValue = '';
			
			if($(target).hasClass('desc')){
				$(target).removeClass('desc').addClass('asc');
				orderValue = 'asc';
				$(target).attr("src", "/resources/segroup/society/fap/images/main/triangle_up.png;")
			}else{
				$(target).removeClass('asc').addClass('desc');
				orderValue = 'desc';
				$(target).attr("src", "/resources/segroup/society/fap/images/main/triangle_down.png;")
			}
			
			var scope = angular.element(document.getElementById('myBody')).scope();
			scope.search_change(1, orderType, orderValue);
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
	            	beforeSend: function(xhr) {
	   			     xhr.setRequestHeader("AJAX", true);
	   			   },
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
	                    if(e.status == 403){
	    					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
	    					location.href = "/fap/admin/admin_login";
	    				}else{
		                    $.LoadingOverlay("hide");
		                    alert("에러가 발생하였습니다.\n홈페이지 관리자에게 문의해주십시요.");
	    				}
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
	            	beforeSend: function(xhr) {
	   			      xhr.setRequestHeader("AJAX", true);
	   			   },
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
						//alert("json.result_code : " + json.result_code);
	                    if (json.result_code == 1) {
	                        alert("문자발송 완료되었습니다(성공:" + json.success_cnt + "건/실패:" + json.error_cnt + "건)");
	                    } else {
	                        alert(json.message);
	                    }
	                },
	                error : function(e) {
	                	if(e.status == 403){
      						alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
      						location.href = "/fap/admin/admin_login";
      					}else{
		                    $.LoadingOverlay("hide");
		                    alert("에러가 발생하였습니다.\n홈페이지 관리자에게 문의해주십시요.");
      					}
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
	            	beforeSend: function(xhr) {
		   			     xhr.setRequestHeader("AJAX", true);
		   			},
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
	                	if(e.status == 403){
	    					alert('<spring:message code="com.login.ajaxSesstion" javaScriptEscape="true" />');
	    					location.href = "/fap/admin/admin_login";
	    				}else{
		                    $.LoadingOverlay("hide");
		                    alert("에러가 발생하였습니다.\n홈페이지 관리자에게 문의해주십시요.");
	    				}
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
	
		function apply_permission() {
			//참가 승인
			var fap_jobfair_user_seq_list = new Array();
			$("input:checkbox[name=checkBoxs]:checked").each(function(){
				fap_jobfair_user_seq_list.push($(this).val());
			});
			if(fap_jobfair_user_seq_list.length == 0){
          	 	alert('승인할 지원자를 선택하세요.');
          		return;
            }
			
			location.href="/fap/admin/jobfair_user_apply_permission?fap_jobfair_user_seq_list=" + fap_jobfair_user_seq_list;

	     }
			
	</script>
	
	<style type="text/css">
	
	</style>
		
</head>
<body id="myBody" ng-app="myapp" ng-controller="PermissionController">
<%@include file="admin_menu.jsp"%><br>
 
 	<div class="container">
 		<div>
			<h2>JobFair 지원자 승인 페이지</h2>
		</div>
		<br>
		<div class="search_div">
			<div class="search_box">
				<table class="search_box">
					<colgroup>
						<col width="30%">
						<col width="80%">
					</colgroup>
					<tr>
						<th>잡페어명으로 검색</th>
						<td>
							<select id="jobfairSelect" class="selectMid" onchange="angular.element(this).scope().search_change()">
								<option value="0">잡페어를 선택하세요</option>
								<c:forEach var="data" items="${jobfairList }">
									<option value="${data.fap_jobfair_seq }">${data.fap_jobfair_title }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>회원 타입으로 검색</th>
						<td>
							<select id="typeSelect" class="selectMid" onchange="angular.element(this).scope().search_change()"></select>
						</td>
					</tr>
					<tr>
						<th>승인 여부로 검색</th>
						<td>
							<select id="perSelect" class="selectMid" onchange="angular.element(this).scope().search_change()"></select>
						</td>
					</tr>
					<tr>
						<th>이름으로 검색</th>
						<td>
							<input type="text" id="searchName">
							<button type="button" class="btn_search" ng-click="search_change()">검색</button>
						</td>
					</tr>
				</table>
				<div class="sub_search_box">
					<select id="pageSelect" onchange="angular.element(this).scope().search_change('')"></select>
					<button type="button" class="btn_search" onclick="apply_permission()">참가승인</button>
					<button type="button" class="btn_search" onclick="show()">메일 / 문자</button>		
					<button type="button" class="btn_search" onclick="all_agree()">전체선택 / 해제</button>
					<br><br>
				</div>
			</div>
		</div>
		
		<table class="table">
				<thead>
					<tr>
						<th>선택 &emsp;</th>
						<th>No &emsp;</th>
						<!-- <th>잡페어명 &emsp;</th> -->
						<th>회원타입 &emsp;</th>
						<th>성명 &nbsp;<img class="arrow desc apply_name" src="/resources/segroup/society/fap/images/main/triangle_down.png;" onclick="order_change('apply_name', this)" style="width: 20px;"></th>
						<th>만 나이</th>
						<th>희망직무</th>
						<!-- <th>아이디 &nbsp;<img class="arrow desc apply_id" src="/resources/segroup/society/fap/images/main/triangle_down.png;" onclick="order_change('apply_id', this)" style="width: 20px;"></th> -->
						<th>전화번호 &emsp;</th>
						<th>이메일 &emsp;</th>
						<th>참가신청일 &nbsp;<img class="arrow desc apply_date" src="/resources/segroup/society/fap/images/main/triangle_down.png;" onclick="order_change('apply_date', this)" style="width: 20px;"></th>
						<th>참가승인일 &nbsp;<img class="arrow desc per_date" src="/resources/segroup/society/fap/images/main/triangle_down.png;" onclick="order_change('per_date', this)" style="width: 20px;"></th>
						<th>담당자 &emsp;</th>
						<th>승인여부 &emsp;</th>
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
									<input type="text" id="apply_future_date" name="apply_future_date" placeholder="전송 날짜" value="" style="width: 80px; display: none;" readonly="readonly" />
									<input type="text" id="apply_future_time" name="apply_future_time" placeholder="전송 시간" value="" style="width: 60px; display: none;" />
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
		
		 <div class="pagination_wrap"></div>
		<div style="display: none;">
			<input type="hidden" id="curPage1" value="">
			<input type="hidden" id="orderType1" value="">
			<input type="hidden" id="orderValue1" value="">
		</div> 
		
		<div class="dim-layer">
		    <div class="dimBg"></div>
		    <div id="edu_layer" class="pop-layer">
		        <div class="pop-container">
		            <div class="pop-conts">
		                <!--content //-->
		                <div class="pop-contents pop-common">
		                </div>
		                
		                <div class="pop-contents pop-hs">
		                	
		                </div>
		
						<div class="pop-contents pop-uni">
							
						</div>
						
						<div class="pop-contents pop-gradu">
							
						</div>
					
		                <div class="btn-r">
		                    <a href="#" class="btn-layerClose">Close</a>
		                </div>
		                <!--// content-->
		            </div>
		        </div>
		    </div>
		</div>
 	</div>
</body>
</html>