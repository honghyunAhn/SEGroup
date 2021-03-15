<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${Admin eq 'Admin'}">
	<div class="container">
		<!-- 모달 팝업 -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
						</button>


						<h4 class="modal-title" id="myModalLabel">일정 수정/삭제하기</h4>
					</div>

					<div class="modal-body">
						<form action="" id="updateForm" method="post">
							제목&nbsp;&nbsp;<input type="text" name="smp_sch_ct" id="updateTitle">&nbsp;&nbsp;
							과목&nbsp;&nbsp; <select name="smp_sch_title" id="updateSubject" style="height: 30px; font-size: 11px;margin-left:10px;">
							</select><br><br>
							시작일&nbsp;&nbsp;<input type="date" name="smp_sch_st" id="updateStrDate">
							종료일&nbsp;&nbsp;<input type="date" name="smp_sch_et" id="updateEndDate"><br><br>
							상세<br>
                     		<textarea name="smp_sch_cont" id="updateDiscription" style="resize: none;
                     			 height: 250px; width: 400px; font-size: 11px;margin-left:10px;"></textarea>
							<input type="hidden" name="gisu_seq" id="updateGisu">
							<input type="hidden" name="smp_sch_seq" id="eventNum">
							<input type="hidden" name="smp_sch_color_seq" id="updateColorSeq">
							<input type="hidden" name="gisu_crc_nm" id="gisu_crc_nm"> 
							<input type="hidden" name="smp_sch_udt_id" id="updateUserId" value="${sessionScope.userId}">
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
						<button type="button" class="btn btn-primary" id="udpateBtn">수정</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">

		<!-- 모달 팝업 -->
		<div class="modal fade" id="insertmodal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
						</button>
							
						<h4 class="modal-title" id="myModalLabel">${gisu_num}기 일정 입력하기 </h4>
					</div>
					<div class="modal-body">
						<form action="/smp/admin/insertSch" id="insertForm" method="post">
							<input type="hidden" name="gisu_seq" id="insertGisu">  
							일정 &nbsp;&nbsp;<input type="text" name="smp_sch_ct" id="insertTitle">&nbsp;&nbsp;
							과목&nbsp;&nbsp; 
								<select name="smp_sch_title" id="insertSubject" style="height:30px;font-size:11px;margin-left:10px;">
								</select><br><br>
							시작일&nbsp;&nbsp;<input type="date" name="smp_sch_st" id="insertStrDate">
							종료일&nbsp;&nbsp;<input type="date" name="smp_sch_et" id="insertEndDate"><br><br>
							상세<br>
								<textarea name="smp_sch_cont" id="insertDiscription" 
									style="resize: none; height: 250px; width: 400px; font-size: 11px;margin-left:10px;"></textarea>
							<input type="hidden" name="smp_sch_ins_id" id="insertUserId" value="${sessionScope.userId}">
							<input type="hidden" name="smp_sch_udt_id" id="insertUserId" value="${sessionScope.userId}">
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="insertBtn">입력</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">

		<!-- 모달 팝업 -->
		<div class="modal fade" id="insertColorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
						</button>


						<h4 class="modal-title" id="myModalLabel">${gisu_num}기 과목 색상지정</h4>
					</div>

					<div class="modal-body">
							
							<label id="일본어">
							일본어&nbsp;&nbsp;<select name="smp_sch_color" id="japanColor" style="height: 30px; font-size: 11px;">
									<option value="#f26071" selected>빨간색</option>
									<option value="#667ff9">파란색</option>
									<option value="#f9e770">노란색</option>
									<option value="#f9b15e">주황색</option>
									<option value="#cb2ef7">보라색</option>
								</select>
							</label><br><br>
							<label class="it">
							IT&nbsp;&nbsp;<select name="smp_sch_color" id="itColor" style="height: 30px; font-size: 11px;">
									<option value="#f26071">빨간색</option>
									<option value="#667ff9" selected>파란색</option>
									<option value="#f9e770">노란색</option>
									<option value="#f9b15e">주황색</option>
									<option value="#cb2ef7">보라색</option>
								</select>
							</label><br><br>
							<label class="etc">
							기타공지사항&nbsp;&nbsp;<select name="smp_sch_color" id="etcColor" style="height: 30px; font-size: 11px;">
									<option value="#f26071" >빨간색</option>
									<option value="#667ff9">파란색</option>
									<option value="#f9e770" selected>노란색</option>
									<option value="#f9b15e">주황색</option>
									<option value="#cb2ef7">보라색</option>
								</select><br><br>
							</label>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="insertColor()">입력</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container">	
		<div class="modal fade" id="updateColorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
						</button>


						<h4 class="modal-title" id="myModalLabel">${gisu_num}기 과목 색상지정</h4>
					</div>

					<div class="modal-body">
						<table id="updateColorModalTable">
						
						</table>		
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="deleteColor()" id="deleteColorBtn">삭제</button>
						<button type="button" class="btn btn-primary" onclick="updateColor()" id="updateColorBtn">수정</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container">	
		<div class="modal fade" id="newSubjectInsertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
						</button>


						<h4 class="modal-title" id="myModalLabel">${gisu_num}기 과목 만들기</h4>
					</div>

					<div class="modal-body">
						<table id="insertSubjectModalTable">
						<tr>
							<td><input type="text" name="smp_sch_title" class="insertSubjectTitle" style="height: 30px; font-size: 11px;"></td>
							<td><select name="smp_sch_color" class="insertColor" style="height: 30px; font-size: 11px;">
									<option value="#f26071">빨간색</option>
									<option value="#667ff9">파란색</option>
									<option value="#f9e770">노란색</option>
									<option value="#f9b15e">주황색</option>
									<option value="#cb2ef7">보라색</option>
								</select>
							</td>	
						</tr>
					</table>
							<input type="hidden" id="colorCnt">		
							<button id="newSubjectInsertBtn" onclick="addTitleInsert()">+</button>
							<button id="newSubjectDeleteBtn" onclick="addTitleDelete()" hidden>-</button>	
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="newSubjectInsert()">입력</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	
	
	<c:if test="${User eq 'User'}">
	<div class="container">
		<div class="modal fade" id="userModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">

						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span> <span class="sr-only">Close</span>
						</button>


						<h4 class="modal-title" id="myModalLabel">${gisu_crc_nm} 일정 </h4>
					</div>

					<div class="modal-body">
							제목&nbsp;&nbsp;<input type="text" name="smp_sch_ct" id="userTitle" disabled>&nbsp;&nbsp;
							과목&nbsp;&nbsp; <input type="text" name="smp_sch_title" id="userSubject" 
								style="height: 30px; font-sizse: 11px;margin-left:10px;" disabled>
							<br><br>
							시작일&nbsp;&nbsp;<input type="date" name="smp_sch_st" id="userStrDate" disabled>
							종료일&nbsp;&nbsp;<input type="date" name="smp_sch_et" id="userEndDate" disabled><br><br>
							상세<br>
                     		<textarea name="smp_sch_cont" id="userDiscription" style="resize: none;
                     			 height: 250px; width: 400px; font-size: 11px;margin-left:10px;" disabled></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	