<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
	<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/fap/css/default.css" />" />
	<link type="text/css" rel="stylesheet" href="<c:url value="/resources/segroup/society/fap/css/popModal.css" />">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<title>Bridge Job Fair</title>
	
	<style type="text/css">
	.boardContentTitle{margin:0 auto;width:1127px;padding: 40px 0 40px 0;text-align:center; }
	.boardContentTitle h1 {font-weight:bold;color:#595959;font-size: 40px;}	
	</style>
	
	<script type="text/javascript">
 
		var myApp = angular.module('myapp', []);				
					
			myApp.controller('BoardListController', ['$scope','$compile','$http', function($scope,$compile,$http){
						 
	 
				//게시판 상세조회 
				$scope.titleClick = function(board_content_seq,board_gb, board_tp){
					var board_content_seq = board_content_seq;
					var board_detail_gb = '${map.board_detail_gb}';
					location.href="/fap/user/user_board_contents_detail?board_content_seq=" + board_content_seq +  "&board_gb=" + board_gb + "&board_tp=" + board_tp+"&board_detail_gb="+ board_detail_gb+"&board=same_board" ;
				}			
				
				//전체출력
				$scope.ilist = function(page){				
					var curPage = page;
					var pageBegin = '${map.adminPager.pageBegin}';
				    var board_detail_gb = '${map.board_detail_gb}';				   
				    var searchKey = $("#searchKey option:selected").val();
				    var searchValue = $("#searchValue").val();				   
				    			 
					$http({
						method: 'POST',
						url: '/fap/user/user_board_content_list_search',
						responseType : 'text',
						params : {
							 pageBegin : pageBegin
							, curPage : curPage
                            , searchKey: searchKey
                            , searchValue: searchValue
                            , board_detail_gb: board_detail_gb
						}
					}).then(function successCallback(response) {
						$scope.init_draw();
						$scope.board_content_list_draw_2(response);
						$scope.paging_draw(response);								
					}, function errorCallback(response) {
					  console.log(response.status);
					});
				}
				
				// 리스트 초기화
				$scope.init_draw = function(){
					$("#board_div").html("");
					$(".pagination_wrap").empty();
				}		
				
				// 게시판 테이블 출력
				$scope.board_content_list_draw_2 = function(response){
					$scope.content_list_2 = response.data.resultList;
					$scope.map = response.data.map;
					var count = response.data.map.count;
					var curPage = response.data.map.curPage;
					var pageCount = response.data.map.pageCount;
					var prevPagesTotCnt = (pageCount) * (curPage - 1);
					$scope.prevPagesTotCnt = prevPagesTotCnt;
					 
					var context = '';
					context += '<ul class="qnatitle2" ng-repeat="con_2 in content_list_2">';
					context += '<li class="wid1">{{prevPagesTotCnt + $index+1}}</li>';
					context += '<li class="wid2"><span class="title" id="{{con_2.board_content_seq}}" ng-click="titleClick(con_2.board_content_seq, con_2.board_gb, con_2.board_tp)">{{con_2.board_content_title}}</span></li>';
					context += '<li class="wid3">{{con_2.board_content_udt_dt}}</li>';
					context += '</ul>';
					
					$('#board_div').append($compile(context)($scope));				 
				}
	
				// 페이징 출력
				 $scope.paging_draw = function(response){					  
					var context ='';
					var resultMap = response.data;				
					
					context += '  <div class="pagination_con">';
					context += '	<span id="page"style="display: inline; margin:auto; display:table; ">';
					context += '		<h4>';
					context += '			<ul>';
					context += '				<li>';
					context += '					<ol>';				
					if(resultMap.map.adminPager.curBlock>1 ){
						context += '					<li><input type="button" ng-click="ilist(&quot;1&quot;)" name="" value="<<"></li>';
						context += '				    <li><input type="button" ng-click="ilist(&quot;'+resultMap.map.adminPager.prevPage+'&quot;)" name="" value="+<+"></li>';	
					}				 
					for(var i=resultMap.map.adminPager.blockBegin; i<=resultMap.map.adminPager.blockEnd; i++){
						if(i==resultMap.map.adminPager.curPage){
							context += '		<li><input type="button" style="color: red" name="" value="'+i+'"></li>';
						}else{
							context += '		<li><input type="button" ng-click="ilist(&quot;'+i+'&quot;)" name="" value="'+i+'"></li>';
						}
					}					 
					if(resultMap.map.adminPager.curBlock <= resultMap.map.adminPager.totBlock){
						context += '	<li><input type="button" ng-click="ilist(&quot;'+resultMap.map.adminPager.nextPage+'&quot;)" name="" value=">"></li>	';
					}					 
					if(resultMap.map.adminPager.curPage < resultMap.map.adminPager.totPage){
						context += ' <li><input type="button"  ng-click="ilist(&quot;'+resultMap.map.adminPager.totPage+'&quot;)" name="" value=">>"></li>';
					}					
					context += '</ol></h4></li></ul></span></div>';		
				 
					$(".pagination_wrap").html($compile(context)($scope));					 										
				 }
				
			
				
				
			}]);			
			
	</script>
</head>
<body ng-app="myapp" ng-controller="BoardListController">
  	<input type="hidden" id="pageBegin" name="pageBegin" value="${map.adminPager.pageBegin}">
	<input type="hidden" id="curPage" name="curPage" value="${map.adminPager.curPage}">
	<input type="hidden" id="board_detail_gb" name="board_detail_gb" value="${map.board_detail_gb}">

	<%@include file="user_menu.jsp"%><%@include file="user_quick_menu.jsp"%>	
	   
      <div class="boardContentTitle">		 
		 <h1>
			<c:if test = "${map.board_detail_gb =='A1700'}"><spring:message code="fap.main_menu.notice" /></c:if>
			<c:if test = "${map.board_detail_gb =='A1701'}"><spring:message code="fap.main_menu.jobinfo" /></c:if> 
			<c:if test = "${map.board_detail_gb =='A1706'}"><spring:message code="fap.main_menu.internship" /></c:if>
		</h1>
	  </div>
 
	   <!-- 검색 -->      
		  <div id="peopleBBS" style="padding:10px;"> 	 
			  <table>          
				  <tr>
					  <td>
					  		<select id="searchKey"  name="searchKey" style=" width: 150px; height:28px;" >
								<option value="searchTitle" >제목</option>
								<option value="searchContent" >내용</option>
							</select>	
					  </td>
					   <td>
					   		<input type="text" id="searchValue" name="searchValue"  class="input1">	
					   	</td>
					   	<td>
							<input  type="button" class="btn_search"   value="검색" ng-click="ilist(${map.adminPager.curPage})" style="width: 100px; height:28px;">	
					   </td>
				  </tr>			
			  </table> 									
		  </div>
		 
		<!-- 게시판 출력 -->
			<div id="qnaBBS">
				<div>
					<ul class="qnatitle">
						<li class="wid1"><spring:message code="fap.jobfair.main.board.no" /></li>
						<li class="wid2"><spring:message code="fap.jobfair.main.board.title" /></li>
						<li class="wid3"><spring:message code="fap.jobfair.main.board.indate" /></li>
					</ul>
				</div>
				<div id="board_div">
					<c:if test='${not empty resultList}'>
		 				<c:forEach var='content' items="${resultList}" varStatus="status">
						 	<ul class="qnatitle2" > 	  
						 		<li class="wid1">&nbsp;${(map.pageCount)*(map.adminPager.curPage-1)+status.index+1}</li>
						 		<li class="wid2" ng-click="titleClick(${content.board_content_seq }, ${ content.board_gb}, ${content.board_tp })">${content.board_content_title }</li>
						 		<li class="wid3">${content.board_content_udt_dt }</li>       	    		    			
			    			</ul>			 				 
					    </c:forEach> 					    
				    </c:if> 
				</div>
			</div>
		 
	<!-- 페이징 -->	
	<div class="pagination_wrap">
	  <div class="pagination_con">
		   <span id="page"style="display: inline; margin:auto; display:table; font-size:18px;">		 
				<ul>
					<li>
						<ol>				
						<!-- **처음페이지로 이동 : 현재 페이지가 1보다 크면  [처음]하이퍼링크를 화면에 출력-->
						<c:if test="${map.adminPager.curBlock > 1}">
							<li><input type="button" ng-click="ilist(&quot;1&quot;)" name="" value="<<"></li>
						</c:if>
						
						<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
						<c:if test="${map.adminPager.curBlock > 1}">
							<li><input type="button" ng-click="ilist('${map.adminPager.prevPage}')" name="" value="<"></li>
						</c:if>
						
						<!-- **하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
						<c:forEach var="num" begin="${map.adminPager.blockBegin}" end="${map.adminPager.blockEnd}">
							<!-- **현재페이지이면 하이퍼링크 제거 -->
							<c:choose>
								<c:when test="${num == map.adminPager.curPage}">							 
									<li><input type="button" style="color: red" name="" value="${num}"></li>
								</c:when>
								<c:otherwise> 
									<li><input type="button" ng-click="ilist('${num}')" name="" value="${num}"></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<!-- **다음페이지 블록으로 이동 : 현재 페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]하이퍼링크를 화면에 출력 -->
						<c:if test="${map.adminPager.curBlock <= map.adminPager.totBlock}">
							<li><input type="button" ng-click="ilist('${map.adminPager.nextPage}')" name="" value=">"></li>
						</c:if>
						
						<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작으면 [끝]하이퍼링크를 화면에 출력 -->
						<c:if test="${map.adminPager.curPage < map.adminPager.totPage}">
							<li><input type="button"  ng-click="ilist('${map.adminPager.totPage}')" name="" value=">>"></li>
						</c:if>
						</ol>						 
					</li>
				</ul>
			</span>
		</div>
   </div>
   <!-- 페이징 끝 -->
					
		<br><br><br><br>		
		<%@include file="../common_footer_fap.jsp"%>	

</body>
</html>