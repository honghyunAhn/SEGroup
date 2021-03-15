<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Bridge Job Fair</title>
<style type="text/css">
 

</style>
</head>
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />

<body ng-app="myapp" ng-controller="alimController">
<script type="text/javascript">
	$(function(){
		
			//체크박스 
			$(".alim-check").off("click").on("click",function(){			 
				$(this).toggleClass("ck");
				
				if($(this).hasClass("all")){
					if($(this).hasClass("ck")){
						$(".alim-check").each(function(index,item){
							if(!$(this).hasClass("ck")){
								$(this).toggleClass("ck");
							}
						})
					}else{
						$(".alim-check").each(function(index,item){
							if($(this).hasClass("ck")){
								$(this).toggleClass("ck");
							}
						})
					}
				}			
			})		
		
	})


 
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
					 console.log(response.status);
				});
			},
			template : "<span>{{filterParams}}</span>"
		}
	} ]);
	
	myApp.controller('alimController', ['$scope','$compile','$http', function($scope,$compile,$http){		
		 
		
		//체크박스 다중선택
		$scope.checkClick = function(e){			 
				$(e.currentTarget).toggleClass("ck");							
				if($(e.currentTarget).hasClass("all")){
						if($(e.currentTarget).hasClass("ck")){
							$(".alim-check").each(function(index,item){
								if(!$(e.currentTarget).hasClass("ck")){
									$(e.currentTarget).toggleClass("ck");
								}
							})
						}else{
							$(".alim-check").each(function(e,index,item){
								if($(e.currentTarget).hasClass("ck")){
									$(e.currentTarget).toggleClass("ck");
								}
							})
						}
				}			
			}
		
		//처리하기/취소하기(1개) 
		$scope.update_handle_fin_gb = function(fap_admin_notice_handle_fin_gb , fap_admin_notice_seq){		 			 			
				$http({
						url: 'admin_notice_update_handle_fin_gb'
						, method:'post'
						, params: { 
		  					   fap_admin_notice_handle_fin_gb:fap_admin_notice_handle_fin_gb
							 , fap_admin_notice_seq:fap_admin_notice_seq					
						}
					}).then(function successCallback(response){				 
						$scope.select_partial_list();
					}), function errorCallback(response){
						console.log(response);
					}		
		}	
		
		//선택항목 모두 처리/취소하기 
		$scope.handleAllSelected = function(handleOrCancel){
				 console.log("handleOrCancel:"+handleOrCancel);				 
				var  fap_admin_notice_seq_list = [];
			
				$(".alim-check").each(function(index, item){
					if(!$(this).hasClass("all")){
						if($(this).hasClass("ck")){
							fap_admin_notice_seq_list.push($(this).attr("seq"));					 
						}
					}
				})
							
				if(fap_admin_notice_seq_list.length == 0){
					alert("항목을 한개 이상 선택해 주세요.");
				}else{
					if(confirm("선택한 모든 항목이 완료처리됩니다. 계속하시겠습니까?")){
						var fap_admin_notice_handle_fin_gb = '';
						if(handleOrCancel =='handle'){
							fap_admin_notice_handle_fin_gb ='D2201'
						}
						if(handleOrCancel =='cancel'){
							fap_admin_notice_handle_fin_gb ='D2200'
						}		
						console.log("fap_admin_notice_handle_fin_gb:"+fap_admin_notice_handle_fin_gb);
						$http({
								url: 'admin_notice_update_handle_fin_gb_all_selected'
								, method:'post'
								, params: { 
				  					   fap_admin_notice_handle_fin_gb:fap_admin_notice_handle_fin_gb
									 , fap_admin_notice_seq_list:fap_admin_notice_seq_list					
								}
							}).then(function successCallback(response){							 
								$scope.select_partial_list();
								$(".alim-check").removeClass("ck");
							}), function errorCallback(response){
								console.log(response);
						}							 
					}			
				}				
		}
	
		//조건부 출력 
		 $scope.select_partial_list = function(){			  
				var pageCount = $("#search_count").val();
				$scope.drawList(pageCount, 1);	
		 }
		
		//리스트
		$scope.drawList = function(pageCount, currentPage){		
			  var selected_handle_gb = $("#select-box-layout #select_handle_gb option:selected").attr('value');
			  console.log("selected:"+selected_handle_gb);
			  $(".alimTableBody").empty();
			  $(".pagination").empty();
			  if(selected_handle_gb==null || selected_handle_gb==''){
				  selected_handle_gb ='D2300';
			  }			 			 	  
				  $http({
						  url:'admin_notice_alim_list'
						  , method: 'post'
						  , params : {  
							    selected_handle_gb : selected_handle_gb
							  , pageCount:pageCount
							  , currentPage: currentPage
							}
				         
				  }).then(function successCallback(response){				 
						  var data = response.data.result;
						  var navi = response.data.navi;
					  	  var context ='';
					  	  
					  	  if(data.length==0){
					  		context += '<tr><td rowspan="4" colspan="9">검색된 결과가 없습니다</td></tr>';
							context += '<tr></tr><tr></tr><tr></tr>';
							$(".pagination").empty();
					  	  }else{
					  	
					  	  //알림내역	  
					  	  $.each(data, function(index, alim){				  		       
							  		context += '<tr>'; 
							  		if(alim.fap_admin_notice_handle_need_gb =='D2101'){
							  			context += '   <td>';  
								  		context += ' 	<span class="alim-check" seq="'+alim.fap_admin_notice_seq+'" fin="'+alim.fap_admin_notice_handle_fin_gb+'" ng-click="checkClick($event)">';
								  		context += '		    <label class="alim-check-label"></label>';
								  		context += '	</span>';
								  		context += '    <input type="checkbox" >';
								  		context += ' </td>	 ';		
							  		}
							  		if(alim.fap_admin_notice_handle_need_gb =='D2100'){
							  			context += ' <td>&nbsp;</td>';  				  		 					  		 
							  		}	 						  		
							  		context += '<td><code value="'+alim.fap_admin_notice_handle_gb+'"></code></td>';
							  		context += '<td>'+alim.fap_admin_notice_ins_dt+'</td> ';
							  		context += '<td id="alim_ct">'+alim.fap_admin_notice_ct+'</td>	';
							  		context += '<td>';
							  		if(alim.fap_admin_notice_handle_need_gb =='D2101'){
							  		   if(alim.fap_admin_notice_handle_fin_gb =='D2200'){
							  				context += '   	<b style="color:crimson;"><code value="'+alim.fap_admin_notice_handle_fin_gb+'"></code></b>';
							  		   }	
							  		  if(alim.fap_admin_notice_handle_fin_gb =='D2201'){
									  		context += ' 	<b style="color:green"><code value="'+alim.fap_admin_notice_handle_fin_gb+'"></code></b>';
							  		   }	
							  		}	 		 
							  		context += '</td>';
							  		context += '<td>';
							  		if(alim.fap_admin_notice_handle_need_gb =='D2101'){
								  		   if(alim.fap_admin_notice_handle_fin_gb =='D2200'){
								  				context += '   		<input type="button" class="alim-btn-03" id="handle-btn" style="width:90px;  background-color: #66A5DD;" ng-click="update_handle_fin_gb(\'D2201\','+alim.fap_admin_notice_seq+')" value="처리하기"/>';
								  		   }
								  		   if(alim.fap_admin_notice_handle_fin_gb =='D2201'){
								  				context += '			<input type="button" class="alim-btn-03" id="handle-btn" style="width:90px; background-color:#E08095; " ng-click="update_handle_fin_gb(\'D2200\','+alim.fap_admin_notice_seq+')" value="취소하기"/>';
								  		   }	
								  	}	 		  		 					 		 
						  				context += '	</td>	'; 	 	
						  				context += '</tr>	';
							  	}) 	 
			  	  
					  	        //페이징
							  	var page = '<a class="pointer" onclick="angular.element(this).scope().select_page('+(navi.currentPage - 1)+')">&laquo;</a>';
								for(var i = navi.startPageGroup; i <= navi.endPageGroup; i++){
										if(i == navi.currentPage){
											page += '<a class="pointer active" onclick="angular.element(this).scope().select_page('+i+')">'+i+'</a>';
										}else{
											page += '<a class="pointer" onclick="angular.element(this).scope().select_page('+i+')">'+i+'</a>';
										}
								}
								page += '<a class="pointer" onclick="angular.element(this).scope().select_page('+(navi.currentPage + 1)+')">&raquo;</a>';
	
								$(".pagination").html(page);														  
					  	  }  					  
					       	$(".alimTableBody").append($compile(context)($scope));
					  }, function errorCallback(response){
							 console.log(response.status);
					  });			  
				  }	
		
					//페이징
					$scope.select_page = function(currentPage){
						var pageCount = $("#search_count").val();
						$scope.drawList(pageCount, currentPage);	
					}
					
					//한 페이지 출력글 갯수 선택
					$scope.select_count = function(){
						var pageCount = $("#search_count").val();
						$scope.drawList(pageCount, 1);	
					}
					
					 
			 
		}]);
		
	 
	
	
</script>
<%@include file="admin_menu.jsp"%>
 
<div class="join-wrap">
	<div id="subcontents" class="admin">
		<h1>관리자 알림 페이지</h1><br><br>
			<div id="nowBox">
			 	<div class="box-wrap">
			 	
			 	<div id="select-box-layout">
					<select class="m10p5" id="search_count" onchange="angular.element(this).scope().select_count()">
						<option value="10">10개씩 보기</option>
						<option value="50">50개씩 보기</option>
						<option value="100">100개씩 보기</option>
					</select>			 
				 	 			 &emsp;분류별 검색&nbsp;<select class="m10p5" id="select_handle_gb"  onchange="angular.element(this).scope().select_partial_list()">	 	 		
				 	 				    <option  value="" selected="selected" >--선택해 주세요--</option>
				 	 				    <option  value="D2300" >전체 리스트 보기</option>
										<option selectcode value="D2301"> </option>
										<option selectcode value="D2302"> </option>
										<option selectcode value="D2303"> </option>
										<option selectcode value="D2304"> </option>
										<option selectcode value="D2305"> </option>
										<option selectcode value="D2306"> </option>
										<option selectcode value="D2307"> </option>						 
								</select>								
				 	 	</div>
				 	 	<div id="btn-box-layout">							 
								<button class="alim-btn-01" style="width:185px; " ng-click="handleAllSelected('handle')" >선택항목 모두 처리하기</button>
								<button class="alim-btn-02" style="width:185px; " ng-click="handleAllSelected('cancel')" >선택항목 모두 취소하기</button>
						</div>
			 	</div>
			 	<div class="alim-list">
				 		<table class="alim-table" >
				 		<col width="4%">
				 		<col width="11%">
				 		<col width="8%">
				 		 <col width="68%">
				 		 <col width="9%">
				 		 <col>
							<thead>
							 <tr>
							 	<th>
								 	<span class="alim-check all">
										<label class="alim-check-label"></label>
									</span>
								<input type="checkbox"></th>
							 	<th>분류</th>
							 	<th>일시</th>
							 	<th>내용</th>
							 	<th >처리여부</th>	
							 	<th></th>						 	 
							 </tr>
							</thead>
							<tbody class="alimTableBody">
							<c:forEach items="${alimList.result}" var="alim">							 
							 	<tr>
							 	 <c:if test="${alim.fap_admin_notice_handle_need_gb =='D2101'}">
							 	    <td>
							 	    	<span class="alim-check" seq="${alim.fap_admin_notice_seq}" fin="${alim.fap_admin_notice_handle_fin_gb}" >
											    <label class="alim-check-label"></label>
										</span>
							 	        <input type="checkbox" >
							 	    </td>
							 	    </c:if>
							 	     <c:if test="${alim.fap_admin_notice_handle_need_gb =='D2100'}"><td></td>	</c:if> 		
							 	 	<td><code value="${alim.fap_admin_notice_handle_gb}"></code></td>
							 	  	<td>${alim.fap_admin_notice_ins_dt}</td> 
							 		<td id="alim_ct">${alim.fap_admin_notice_ct}</td>	
							 		<td>
							 		 <c:if test="${alim.fap_admin_notice_handle_need_gb =='D2101'}">
									 		<c:if test="${alim.fap_admin_notice_handle_fin_gb =='D2200'}">		
							 		   			<b style="color:crimson;"><code value="${alim.fap_admin_notice_handle_fin_gb}" ></code></b>
									 		</c:if>
									 		<c:if test="${alim.fap_admin_notice_handle_fin_gb =='D2201'}">		
												<b style="color:green"><code value="${alim.fap_admin_notice_handle_fin_gb}" ></code></b>
									 		</c:if> 
							 		</c:if>							 		 
							 		</td>	 	
							 		<td>
							 		 <c:if test="${alim.fap_admin_notice_handle_need_gb =='D2101'}">
									 		<c:if test="${alim.fap_admin_notice_handle_fin_gb =='D2200'}">		
							 		   			<input type="button" class="alim-btn-03" id="handle-btn" style="width:90px; background-color: #66A5DD; "  ng-click="update_handle_fin_gb('D2201',${alim.fap_admin_notice_seq})"  value="처리하기"/>
									 		</c:if>
									 		<c:if test="${alim.fap_admin_notice_handle_fin_gb =='D2201'}">		
												<input type="button" class="alim-btn-03" id="handle-btn" style="width:90px; background-color:#E08095; "  ng-click="update_handle_fin_gb('D2200',${alim.fap_admin_notice_seq})"  value="취소하기"/>
									 		</c:if> 
							 		</c:if>							 		 
							 		</td>	 	 	
							 	</tr>	
							</c:forEach>
							    
							</tbody>
						</table>
			 	</div>
			</div>
			<!-- 페이징 -->
			<div class="pagination">
					<c:if test="${alimList.navi.currentPage > 1}">
				    	<a class="pointer" onclick="angular.element(this).scope().select_page('${alimList.navi.currentPage - 1}')" >&laquo;</a>
				    </c:if>
					<c:forEach   var="i" begin="${alimList.navi.startPageGroup}" end="${alimList.navi.endPageGroup}"  >
					  	<c:choose>
						  		<c:when test ="${i == alimList.navi.currentPage}">												 
										<a class="pointer active" onclick="angular.element(this).scope().select_page('${i}')">${i}</a> 
								</c:when>
								<c:otherwise>
										<a class="pointer" onclick="angular.element(this).scope().select_page('${i}')">${i}</a>
								</c:otherwise>										
						</c:choose>
					</c:forEach>
					<c:if test="${alimList.navi.currentPage < alimList.navi.totalPageCount}">
						<a class="pointer" onclick="angular.element(this).scope().select_page('${alimList.navi.currentPage + 1}')">&raquo;</a>
					</c:if>
			</div>
	</div>
</div>


 

     

</body>
</html>