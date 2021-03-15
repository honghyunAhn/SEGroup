<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <!DOCTYPE >
<html>
<head>
<!--Import Google Icon Font-->
<link href="http://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!--Import materialize.css-->
<link type="text/css" rel="stylesheet"
	href="resources/segroup/society/smp/one/css/materialize.min.css" media="screen,projection" />
<link type="text/css" rel="stylesheet"
	href="resources/segroup/society/smp/one/css/aps_total.css" media="screen,projection" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="resources/segroup/society/smp/one/js/materialize.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>insert_form</title>
</head> --%>
<script type="text/javascript">
	function totalOverlap() {
		var gisu = $("#gisu_total_seq").val();
		var total_nm = $("#smp_aps_total_nm").val();

		//alert(gisu +" | " + total_nm);

		var can;
		$.ajax({
			type : "POST",
			url : "/ajaxTotalOverlab",
			dataType : 'text',
			data : {
				'gisu_seq' : gisu,
				'smp_aps_total_nm' : total_nm
			},
			success : function(data) {
				can = data;
				if (can != "canInsert") {
					alert("평가종합 이름이 중복되었습니다.");
				} else {
					$("#totalInsert").submit();
				}
			},
			error : function() {
				alert("error");
			}
		});
	}
	$(function() {
		//등록하기
		$("#totalInsertBtn").on(
				"click",
				function() {
					var smp_aps_total_nm = $("#smp_aps_total_nm").val();
					var smp_aps_total_ratio = $("#smp_aps_total_ratio").val();
					var gisu_seq_msg = $("#gisu_seq_select option:selected")
							.val();
					if (gisu_seq_msg == "0") {
						alert("기수를 선택해주세요");
						return;
					}
					if (smp_aps_total_nm == "") {
						alert("평가종합 이름을 입력해주세요");
						return;
					}

					if (smp_aps_total_ratio == "") {
						alert("평가종합 비율을 입력해주세요");
						return;
					}
					if (parseInt(smp_aps_total_ratio) < parseInt(0)
							|| parseInt(smp_aps_total_ratio) > parseInt($(
									'#smp_aps_total_ratio').attr('max'))) {
						alert(parseInt(smp_aps_total_ratio));
						return;
					}
					totalOverlap();
				});
	})
	function change_group_gisu() {
		var gisu = $("#gisu_group_seq").val();
		$.ajax({
			type : "POST",
			url : "/ajaxTotalNm",
			dataType : 'json',
			data : {
				'gisu_seq' : gisu
			},
			success : function(data) {
				var add = "";
				add += '<option value="0">과목명을 선택하세요.</option>';
				for (var i = 0; i < data.length; i++) {
					add += '<option value='+data[i].smp_aps_total_seq+'>';
					add += data[i].smp_aps_total_nm;
					add += "</option>";
				}
				$('#smp_aps_total_seq_group').html(add);
				$('#smp_aps_total_seq_group').formSelect();
			},
			error : function() {
				alert("error");
			}
		});
	}
	function change_detail_gisu() {
		var gisu = $("#gisu_detail_seq").val();
		$.ajax({
			type : "POST",
			url : "/ajaxTotalNm",
			dataType : 'json',
			data : {
				'gisu_seq' : gisu
			},
			success : function(data) {
				var add = "";
				add += '<option value="0">과목명을 선택하세요.</option>';
				for (var i = 0; i < data.length; i++) {
					add += '<option value='+data[i].smp_aps_total_seq+'>';
					add += data[i].smp_aps_total_nm;
					add += "</option>";
				}
				$('#smp_aps_total_seq_detail').html(add);
				$('#smp_aps_total_seq_detail').formSelect();
			},
			error : function() {
				alert("error");
			}
		});
	}
	function change_detail_total() {
		var gisu_seq = $("#gisu_detail_seq").val();
		var smp_aps_total_seq = $("#smp_aps_total_seq_detail").val();
		
		$.ajax({
			type : 'POST',
			url : "/smp/admin/selectApsGroupList",
			dataType : 'json',
			data : {
				smp_aps_total_seq : smp_aps_total_seq
				,gisu_seq : gisu_seq
			},
			success : function(data) {
			
				var context_exam = '';
				var context_subexam = '';
				context_exam += '<option value="" disabled selected>정규시험 명을 선택하세요.</option>';
				context_subexam += '<option value="" disabled selected>과목시험 명을 선택하세요.</option>';
				$.each(data, function(index, item){
					if(item.smp_aps_group_tp == 'A0900'){
						context_exam += '<option value="'+item.smp_aps_group_exam_seq+'">'+item.smp_aps_group_exam_nm+'</option>';
					}else if(item.smp_aps_group_tp == 'A0901'){
						context_subexam += '<option value="'+item.smp_aps_group_subexam_seq+'">'+item.smp_aps_group_subexam_nm+'</option>';
					}
				})

				$('#smp_aps_group_exam_seq').html(context_exam);
				$('#smp_aps_group_exam_seq').formSelect();
				
				$('#smp_aps_group_subexam_seq').html(context_subexam);
				$('#smp_aps_group_subexam_seq').formSelect();
		
			}, error : function() {
				alert("error");
			}
		});
	}
	
	function change_exam(myRadio){
		if(myRadio.value == 'A0900'){
			$('.group_detail').hide();
			$('#group_exam_detail').show();
		}else if(myRadio.value == 'A0901'){
			$('.group_detail').hide();
			$('#group_subexam_detail').show();			
		}
		
	}
	
	function change_ratio(myRadio){
		if(myRadio.value == 'ratio'){
			$('#detail_ratio_div').show();
		}else if(myRadio.value == 'point'){
			$('#detail_ratio_div').hide();
		}
		
	}
</script>
<body id="myBody" ng-app="myapp" ng-controller="AdminController">
	<!-- 김홍일 : 글 작성 버튼(자바스크립트 2개 포함 중) -->
	<div class="fixed-action-btn">
		<a class="btn-floating btn-large red"> <i
			class="large material-icons">mode_edit</i>
		</a>
		<ul>
			<li><a href="#modal-total"
				class="btn-floating red modal-trigger tooltipped"
				data-position="left" data-tooltip="종합평가 작성"><i
					class="material-icons">description</i></a></li>
			<li><a href="#modal-group"
				class="btn-floating yellow modal-trigger darken-1 tooltipped"
				data-position="left" data-tooltip="그룹평가 작성"><i
					class="material-icons">assignment</i></a></li>
			<li><a href="#modal-detail"
				class="btn-floating green modal-trigger tooltipped"
				data-position="left" data-tooltip="상세평가 작성"><i
					class="material-icons">chrome_reader_mode</i></a></li>
		</ul>
	</div>

	<!-- 김홍일 : 글 작성 버튼 / 상세 버튼(hover) 취향에 맞게 택 1-->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('.fixed-action-btn');
			var instances = M.FloatingActionButton.init(elems);
		});

		// Or with jQuery
		$(document).ready(function() {
			$('.fixed-action-btn').floatingActionButton();
		});
	</script>

	<!-- 김홍일 : 글 작성 버튼 / 상세 버튼(click) 취향에 맞게 택 1-->
	<!-- <script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('.fixed-action-btn');
			var instances = M.FloatingActionButton.init(elems, {
				direction : 'up',
				hoverEnabled : false
			});
		});
	</script> -->

	<!-- 김홍일 : 상세 버튼 / 좌측 툴팁 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('.tooltipped');
			var instances = M.Tooltip.init(elems);
		});

		// Or with jQuery

		$(document).ready(function() {
			$('.tooltipped').tooltip();
		});
	</script>

	<!-- 김홍일 : 새 종합평가 모달창 -->
	<div id="modal-total" class="modal bottom-sheet">
		<div class="modal-header">
			<span style="font-size: 1.5rem; color: #ffffff; margin-left: 1.5rem;">새
				종합평가</span>
		</div>
		<form id="totalInsert" action="/smp/admin/aps_total_insert"
			method="post" enctype="multipart/form-data">
			<div class="modal-content">
				<div class="row">
					<div class="input-field col s12">
						<select name="gisu_seq" id="gisu_total_seq">
							<option disabled selected>기수를 선택하세요.</option>
							<c:forEach var="data" items="${seaCurList}">
								<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
							</c:forEach>
						</select> <label>기수 검색</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<input id="smp_aps_total_nm" name="smp_aps_total_nm" type="text"
							data-length="10"> <label for="input_text">과목명</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<input id="smp_aps_total_ratio" name="smp_aps_total_ratio" min="0"
							max="100"
							onkeypress="if((event.keyCode<48)||(event.keyCode>57))event.returnValue=false;"
							type="number"> <label for="input_text">종합평가
							반영율(%)</label>
					</div>
				</div>
				<div class="row" style="margin: 2rem 0 1rem 0;">
					<div class="input-field col s12">
						<textarea id="smp_aps_total_ct" name="smp_aps_total_ct"
							class="materialize-textarea" data-length="120"></textarea>
						<label for="textarea2">평가 내용</label>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn red" type="button" name="action">
					취소 <i class="material-icons right">close</i>
				</button>
				<button id="totalInsertBtn" class="btn" type="submit"
					style="padding: 0 4rem 0 4rem; margin-left: 1rem;" name="action">
					등록 <i class="material-icons right">send</i>
				</button>
			</div>
		</form>
	</div>

	<!-- 김홍일 : 트리거를 이용해 모달창을 띄우는 자바스크립트 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('#modal-total');
			var instances = M.Modal.init(elems);
		});

		// Or with jQuery

		$(document).ready(function() {
			$('#modal-total').modal();
		});
	</script>

	<!-- 김홍일 : 텍스트 에어리어 글자수 표시 -->
	<script type="text/javascript">
		$(document).ready(
				function() {
					$('input#input_text, textarea#smp_aps_total_ct').characterCounter();
					
					
					setTimeout(function(){
						$("#smp_aps_group_tp").formSelect();
					},1000)
				});
	</script>

	<!-- 김홍일 : 새 그룹평가 모달창 -->
	<div id="modal-group" class="modal bottom-sheet">
		<div
			style="background-color: #333333; width: inherit; padding: 1rem 0.7rem 1rem 0.7rem;">
			<span style="font-size: 1.5rem; color: #ffffff; margin-left: 1.5rem;">새
				그룹평가</span>
		</div>
		<form id="totalInsert" action="/smp/admin/aps_group_insert"
			method="post" enctype="multipart/form-data">
			<div class="modal-content">
				<div class="row">
					<div class="input-field col s12">
						<select name="gisu_seq" id="gisu_group_seq" onchange="change_group_gisu();">
							<option disabled selected>기수를 선택하세요.</option>
							<c:forEach var="data" items="${seaCurList}">
								<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
							</c:forEach>
						</select> <label>기수 검색</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<select name="smp_aps_total_seq" id="smp_aps_total_seq_group">
							
						</select><label>과목명</label>
					</div>
				</div>
				<div class="row">
					<div class="input-field col s12">
						<select name="smp_aps_group_tp" class="smp_aps_group_tp" id="smp_aps_group_tp">
							<option value="" disabled selected>그룹평가 타입을 선택하세요.</option>
							<option selectcode value="A0900"></option>
							<option selectcode value="A0901"></option>
							<option selectcode value="A0902"></option>
						</select> <label>그룹평가 타입</label>
					</div>
				</div>
				<div id="group_exam" style="display: none;">
					<div class="row">
						<div class="input-field col s12">
							<input id="smp_aps_group_exam_nm" name="smp_aps_group_exam_nm"
								class="group_exam" type="text"> <label for="input_text">정규시험
								명</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<input id="smp_aps_group_exam_ratio" name="smp_aps_group_exam_ratio"
								class="group_exam" type="number"> <label
								for="input_text">그룹평가 반영율(%)</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<input id="smp_aps_group_exam_pp" name="smp_aps_group_exam_pp"
								class="group_exam" type="number"> <label
								for="input_text">합격점</label>
						</div>
					</div>
					<div class="row" style="margin: 2rem 0 1rem 0;">
						<div class="input-field col s12">
							<textarea id="smp_aps_group_exam_ct" name="smp_aps_group_exam_ct"
								class="materialize-textarea group_exam textarea-group"
								data-length="120"></textarea>
							<label for="textarea2">평가 내용</label>
						</div>
					</div>
				</div>
				<div id="group_subexam" style="display: none;">
					<div class="row">
						<div class="input-field col s12">
							<input id="smp_aps_group_subexam_nm" name="smp_aps_group_subexam_nm"
								class="group_subexam" type="text"> <label
								for="input_text">과목시험 명</label>
						</div>
					</div>
					<div class="row">
						<div class="input-field col s12">
							<input id="smp_aps_group_subexam_pp" name="smp_aps_group_subexam_pp"
								class="group_subexam" type="number"> <label
								for="input_text">합격점</label>
						</div>
					</div>
					<div class="row" style="margin: 2rem 0 1rem 0;">
						<div class="input-field col s12">
							<textarea id="smp_aps_group_subexam_ct" name="smp_aps_group_subexam_ct"
								class="materialize-textarea group_subexam textarea-group"
								data-length="120"></textarea>
							<label for="textarea2">평가 내용</label>
						</div>
					</div>
				</div>
				<div id="group_confirmation" style="display: none;">
					<div class="row">
						<div class="input-field col s12">
							<input id="smp_aps_group_confirm_nm" name="smp_aps_group_confirm_nm"
								class="group_confirmation" type="text"> <label
								for="input_text">개별점수 및 확인서 명</label>
						</div>
					</div>
					<div class="row" style="margin: 2rem 0 1rem 0;">
						<div class="input-field col s12">
							<textarea id="smp_aps_group_confirm_ct" name="smp_aps_group_confirm_ct"
								class="materialize-textarea group_confirmation textarea-group"
								data-length="120"></textarea>
							<label for="textarea2">평가 내용</label>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn waves-effect waves-light red" type="button"
					name="action">
					취소 <i class="material-icons right">close</i>
				</button>
				<button class="btn waves-effect waves-light" type="submit"
					style="padding: 0 4rem 0 4rem; margin-left: 1rem;" name="action">
					등록 <i class="material-icons right">send</i>
				</button>
			</div>
		</form>
	</div>

	<!-- 김홍일 : 트리거를 이용해 모달창을 띄우는 자바스크립트 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('#modal-group');
			var instances = M.Modal.init(elems);
		});

		// Or with jQuery

		$(document).ready(function() {
			$('#modal-group').modal();
		});
	</script>

	<!-- 김홍일 : 텍스트 에어리어 글자수 표시 -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('input#input_text, textarea.textarea-group').characterCounter();
		});
	</script>

	<!-- 김홍일 : 그룹평가, 상세평가//셀렉트의 결과에 따라 폼 입력요구 값이 변경되는 자바스크립트 -->
	<!-- 김홍일 : class로 초기화_수정 바람 -->
	<script type="text/javascript">
		$('.smp_aps_group_tp').on('change', function() {
			$(".group_exam").val('');
			$(".group_subexam").val('');
			$(".group_confirmation").val('');
			if (this.value == "A0900") {
				$('#group_exam').show();
				$('#group_subexam').hide();
				$('#group_confirmation').hide();
			} else if (this.value == "A0901") {
				$('#group_exam').hide();
				$('#group_subexam').show();
				$('#group_confirmation').hide();
			} else if (this.value == "A0902") {
				$('#group_exam').hide();
				$('#group_subexam').hide();
				$('#group_confirmation').show();
			}
		})
	</script>

	<!-- 김홍일 : 새 상세평가 모달창 -->
	<div id="modal-detail" class="modal bottom-sheet">
		<div
			style="background-color: #333333; width: inherit; padding: 1rem 0.7rem 1rem 0.7rem;">
			<span style="font-size: 1.5rem; color: #ffffff; margin-left: 1.5rem;">새
				상세평가</span>
		</div>
		<form id="totalInsert" action="/smp/admin/aps_detail_insert"
			method="post" enctype="multipart/form-data">
		<div class="modal-content">
			<div class="row">
				<div class="input-field col s12">
					<select name="gisu_seq" id="gisu_detail_seq" onchange="change_detail_gisu();">
							<option disabled selected>기수를 선택하세요.</option>
							<c:forEach var="data" items="${seaCurList}">
								<option value="${data.gisu_seq }">${data.gisu_crc_nm }</option>
							</c:forEach>
					</select> <label>기수 검색</label>
				</div>
			</div>
			<div class="row">
				<div class="input-field col s12">
					<select id="smp_aps_total_seq_detail" onchange="change_detail_total();">
					
					</select> <label>과목명</label>
				</div>
			</div>
			<div id="smp_aps_detail_type_radio" style="width: 100%; margin-left: 0.5rem;">
				<p>
					<span>그룹평가 타입 : </span> 
					<label>
					<input id="detail_exam" class="with-gap" value="A0900" name="smp_aps_detail_type_radio" type="radio" checked onchange="change_exam(this);"/> 
					<span>정규시험</span> 
					</label>
					<label style="margin-left: 1rem;">
					<input id="detail_subexam" class="with-gap" value="A0901" name="smp_aps_detail_type_radio" type="radio" onchange="change_exam(this);"/> 
					<span>과목시험</span>
					</label>

				</p>
			</div>
			<div class="row group_detail" id="group_exam_detail">
				<div class="input-field col s12">
					<select id="smp_aps_group_exam_seq" name="smp_aps_group_exam_seq" class="smp_aps_group_seq">

					</select> <label>정규시험 명</label>
				</div>
			</div>
			<div class="row group_detail" id="group_subexam_detail" style="display:none;">
				<div class="input-field col s12">
					<select id="smp_aps_group_subexam_seq" name="smp_aps_group_subexam_seq" class="smp_aps_group_seq">

					</select> <label>과목시험 명</label>
				</div>
			</div>
			<div class="row">
				<div class="input-field col s12">
					<input id="smp_aps_detail_nm" name="smp_aps_detail_nm" class="detail_exam" type="text"> 
					<label for="input_text">
					상세평가 명
					</label>
				</div>
			</div>
			<div id="smp_aps_detail_radio" style="width: 100%; margin-left: 0.5rem;">
				<p>
					<span>점수 산정 방식 : </span> 
					<label>
					<input id="detail_radio_ratio" class="with-gap" value="ratio" name="smp_aps_detail_radio" type="radio" checked onchange="change_ratio(this);"/> 
					<span>비율(취득한 점수 ÷ 입력한 비율)</span> 
					</label>
					<label style="margin-left: 1rem;"><input id="detail_radio_point" class="with-gap" value="point" name="smp_aps_detail_radio"	type="radio" onchange="change_ratio(this);"/> 
					<span>점수(취득한 점수 그대로 성적에 반영)</span>
					</label>

				</p>
			</div>
			<div class="row" id="detail_ratio_div">
				<div class="input-field col s12">
					<input id="smp_aps_detail_ratio" name="smp_aps_detail_ratio" min="0" max="100" 
					onkeypress="if((event.keyCode<48)||(event.keyCode>57))event.returnValue=false;" class="" type="number"> 
					<label for="input_text">
					비율 입력
					</label>
				</div>
			</div>
			<div class="row" id="detail_ratio_div">
				<div class="input-field col s12">
					<input id="smp_aps_detail_pp" name="smp_aps_detail_pp" min="0" max="100"
					onkeypress="if((event.keyCode<48)||(event.keyCode>57))event.returnValue=false;" class="" type="number"> 
					<label for="input_text">
					합격점 입력
					</label>
				</div>
			</div>
			<div class="row" style="margin: 2rem 0 1rem 0;">
				<div class="input-field col s12">
					<textarea id="smp_aps_detail_ct" name="smp_aps_detail_ct"
						class="materialize-textarea textarea-detail" data-length="120"></textarea>
					<label for="textarea2">평가 내용</label>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button class="btn waves-effect waves-light red" type="button" name="action">
				취소 <i class="material-icons right">close</i>
			</button>
			<button class="btn waves-effect waves-light" type="submit" style="padding: 0 4rem 0 4rem; margin-left: 1rem;" name="action">
				등록 <i class="material-icons right">send</i>
			</button>
		</div>
		</form>
	</div>

	<!-- 김홍일 : 트리거를 이용해 모달창을 띄우는 자바스크립트 -->
	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var elems = document.querySelectorAll('#modal-detail');
			var instances = M.Modal.init(elems);
		});

		// Or with jQuery

		$(document).ready(function() {
			$('#modal-detail').modal();
		});
	</script>

	<!-- 김홍일 : 텍스트 에어리어 글자수 표시 -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('input#input_text, textarea.textarea-detail').characterCounter();
		});
	</script>

	<script type="text/javascript">
		$("input[name='detail_radio']").click(
			function() {
				if ($("input[name='detail_radio']:checked").val() == 'detail_radio_ratio') {
					$('#detail_ratio_div').show();
				} else {
					$('#detail_ratio_div').hide();
					$('#detail_ratio').val('');
				}
		})
	</script>
</body>
</html>