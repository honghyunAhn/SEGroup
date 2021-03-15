<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/admin_menu.js" />"></script>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/bootstrap.min.css" />">
<link rel="stylesheet"	href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<!-- 페이징관련 css 시작 -->
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<!-- bxSlider CSS file -->
<link
	href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<!-- 페이징 관련 css 끝 -->

<style>
#curSelect {
	width: 20%;
}

.gisu_crc_selectGroup {
	margin-top: 20px;
	margin-left: 330px;
}

div.custom_div {
	text-align: center;
	margin-left: 330px;
	margin-right: 330px;
}

.crc_submit {
	color: white;
	font-weight: bold;
	font-size: 120%;
	background-color: #3af;
	border: none;
	padding: 5px;
	width: 180px;
	height: 50px;
	margin-top: 15px;
	margin-bottom: 30px;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">

	var myApp = angular.module('myapp', []);
	
	myApp.controller('AdminController', ['$scope','$compile','$http', function($scope,$compile,$http){
		
		var seaCurGisuJson = '${seaCurGisuJson}';
		
		$scope.seaCurGisu = JSON.parse(seaCurGisuJson);
		
	}]);
	
	myApp.directive('selectcode', [ '$http', function($http) {
		return {
			restrict : "A",
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
					console.log(response);
				});
			},
			template : "<option>{{filterParams}}</option>"
		}
	} ]);

	$(function() {
		initialize();
		//date 형식 변경
		$('.date_format').datepicker(
			{
				dateFormat : 'yy/mm/dd'
			}	
		);
		
		minMax("gisu_app_st", "gisu_app_et");
		minMax("gisu_crc_st", "gisu_crc_et");

		$("#curSelect").change(
				function() {
					var crc_seq = $(this).val();

					if (crc_seq == 0) {
						//초기화
						$("#gisu_crc_nm").val("");
                        $("#gisu_crc_month").val("");
                        $("#gisu_crc_days").val("");
                        $("#gisu_crc_times").val("");
						$("#gisu_crc_pay").val("");
						$("#crc_seq").val("");
					} else {
						//초기화 후 ajax
						$.ajax({
							type : "POST",
							url : "/edu/admin/search_curriculum",
							data : {
								'crc_seq' : crc_seq,
							},
							success : function(data) {
								$("#gisu_crc_class").val(data.crc_class);
								$("#gisu_crc_nm").val(data.crc_nm);
                                $("#gisu_crc_month").val(data.crc_month);
                                $("#gisu_crc_days").val(data.crc_days);
                                $("#gisu_crc_times").val(data.crc_times);
								$("#gisu_crc_pay").val(data.crc_pay);
								$("textarea[name=gisu_crc_intro]").html(
										data.crc_intro);
								$("#crc_seq").val(data.crc_seq);
							},
							error : function(e) {
								console.log(e);
							}
						});
					}
				});
	});

	var count = 2;		//이미지 추가용 카운트 변수
	var isFirstImage = true;
	
	//이미지 추가버튼
	function add_img(){
		if(!confirm('이미지를 추가하시겠습니까?')){
			return;
		}		
			//이미지 추가 (리스트)			
			var add_li = document.createElement("li");
			$(add_li).addClass("ui-state-default");
			
			var str = "'avatar_img" + count + "'";
			
			var inner_str = "";
			inner_str += "<input type='hidden'>";
			inner_str += "<input type='hidden' value='0'>";
			inner_str += "<input type='file' accept='.bmp, .gif, .jpg, .png'";
			inner_str += ' onchange = "javascript:getThumbnailPrivew(this, ' + str + ');">';
			inner_str += "<img alt='과정아이콘 이미지 미리보기'  id='avatar_img" + count + "' style='border: 1px solid black'/>"
			
			add_li.innerHTML = inner_str;
			var ul = document.getElementById("sortable");
			
			ul.appendChild(add_li);
			
			count ++;
			
			$( function() {
			    $("#sortable").sortable({
			      connectWith: ".connectedSortable"
			    }).disableSelection();
			  } );
	};
	
	function initialize() {
		
		// 서버로부터 받은 객체 seaCurGisu의 crc_seq 값으로 셀렉트 박스의 선택 값을 지정
		$("#curSelect").val('${seaCurGisu.crc_seq }').prop("selected", true);
		// 초기에 선택한 값을 숨겨진 crc_seq 파라미터에 셋팅, 하지않을 시에는 org.springframework.validation.BindException 발생!
        $("#crc_seq").val($("#curSelect").val());
	}

	function getThumbnailPrivew(input, targetId) {
		// 필드 채워지면
		if ($(input).val() != "") {
			// 확장자 체크
			var ext = $(input).val().split(".").pop().toLowerCase();
			if ($.inArray(ext, [ "bmp", "gif", "jpg", "jpeg", "png" ]) == -1) {
				alert("bmp, gif, jpg, jpeg, png 파일만 업로드 해주세요.");
				$(input).val("");
				return;
			}
			// 용량 체크
			var fileSize = input.files[0].size;
			var maxSize = 1024 * 1024 * 10;
			if (fileSize > maxSize) {
				alert("파일용량 1MB을 초과했습니다.");
				$(input).val("");
			}
			// 가로,세로 길이
			var file = input.files[0];
			var _URL = window.URL || window.webkitURL;
			var img = new Image();
			img.src = _URL.createObjectURL(file);
			img.onload = function() {
				$(input).closest("td").children("p").remove();
				//                 $(input).next().next().next().remove();
				var add_tag = "<p name='tmp_"+targetId+"'>" + img.width + " x "
						+ img.height + "</p>"
				$(input).closest("td").append(add_tag);
			}
		}
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				var element = window.document.getElementById(targetId);
				element.setAttribute("src", e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	function formCheck() {
		var curSelect = $("#curSelect");
		var gisu_num = $("#gisu_num");
		var gisu_crc_class = $("#gisu_crc_class");
		var gisu_crc_nm = $("#gisu_crc_nm");
        var gisu_crc_month = $("#gisu_crc_month");
        var gisu_crc_days = $("#gisu_crc_days");
        var gisu_crc_times = $("#gisu_crc_times");
		var gisu_crc_pay = $("#gisu_crc_pay");
		var gisu_crc_personnel = $("#gisu_crc_personnel");
		var gisu_crc_location = $("#gisu_crc_location");
		var gisu_app_st = $("#gisu_app_st");
		var gisu_app_et = $("#gisu_app_et");
		var gisu_crc_st = $("#gisu_crc_st");
		var gisu_crc_et = $("#gisu_crc_et");
		var gisu_crc_intro = $("#gisu_crc_intro");
		var gisu_crc_icon_image01 = $("#gisu_crc_icon_image01")[0].files;
		var gisu_crc_icon_image02 = $("#gisu_crc_icon_image02")[0].files;

		// TODO: 과정관리에서 등록한 과정명에 한해서만 기수등록이 가능하다는 전제 하에 넣은 체크처리
		if (curSelect.val() == "0") {
			alert("선택 창에서 한 가지의 과정명을 선택해 주시기 바랍니다.")
			selectAndFocus(curSelect);
			return false;
		}
		if (gisu_num.val() == '') {
			alert('기수를 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_num);
			return false;
		}
		if (gisu_crc_class.val() == '') {
			alert('과정분류를 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_class);
			return false;
		}
		if (gisu_crc_nm.val() == '') {
			alert('과정명를 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_nm);
			return false;
		}
        if (gisu_crc_month.val() == '') {
            alert('교육의 개월수를 입력해 주시기 바랍니다.');
            selectAndFocus(gisu_crc_month);
            return false;
        }
        if (gisu_crc_days.val() == '') {
            alert('교육의 일수를 입력해 주시기 바랍니다.');
            selectAndFocus(gisu_crc_days);
            return false;
        }
        if (gisu_crc_times.val() == '') {
            alert('교육의 시간을 입력해 주시기 바랍니다.');
            selectAndFocus(gisu_crc_times);
            return false;
        }
		if (gisu_crc_pay.val() == '') {
			alert('교육비를 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_pay);
			return false;
		}
		if (gisu_crc_personnel.val() == '') {
			alert('교육인원을 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_personnel);
			return false;
		}
		if (gisu_crc_location.val() == '') {
			alert('교육장소를 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_location);
			return false;
		}
		if (gisu_app_st.val() == '') {
			alert('신청시작일을 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_app_st);
			return false;
		}
		if (gisu_app_et.val() == '') {
			alert('신청종료일을 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_app_et);
			return false;
		}
		if (gisu_crc_st.val() == '') {
			alert('과정시작일을 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_st);
			return false;
		}
		if (gisu_crc_et.val() == '') {
			alert('과정종료일을 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_et);
			return false;
		}

		if (gisu_crc_intro.val() == '') {
			alert('과정소개를 입력해 주시기 바랍니다.');
			selectAndFocus(gisu_crc_intro);
			return false;
		}

		// 입력한 기수가 숫자인지 체크
		var regexp = /^[0-9]*$/
		if (!regexp.test(gisu_num.val())) {
			alert('기수는 숫자로만 작성해 주시기 바랍니다');
			selectAndFocus(gisu_num);
			return false;
		}

		// 입력한 교육비가 숫자인지 체크
		if (!regexp.test(gisu_crc_pay.val())) {
			alert('교육비는 숫자로만 작성해 주시기 바랍니다');
			selectAndFocus(gisu_crc_pay);
			return false;
		}

		// 입력한 교육인원이 숫자인지 체크
		if (!regexp.test(gisu_crc_personnel.val())) {
			alert('교육인원은 숫자로만 작성해 주시기 바랍니다');
			selectAndFocus(gisu_crc_personnel);
			return false;
		}

	}

	/**
	 * 엘리먼트를 선택한다
	 */
	function selectAndFocus(element) {
		element.select();
		element.focus();
	}

	function reset_img(input, img_name, taget_img_id) {
		// 	alert($(input).parents("div")+"\n"+img_name+"\n"+taget_img_id);
		$(input).closest("td").append("<div>");
		$(input).closest("td").children("div").append($('<input/>', {
			type : 'file',
			name : img_name,
			id : img_name,
			accept : '.bmp, .gif, .jpg, .png',
			onchange : 'getThumbnailPrivew(this, "' + taget_img_id + '");'
		}));
		$(input).closest("td").children("div").append("<br />");
		$(input).closest("td").children("div").append($('<img/>', {
			id : taget_img_id,
			name : gisu_crc_img_seq,
			style : 'border: 1px solid black'
		}));
		$(input).closest("td").children("div").append("<br />");
		$(input).closest("td").children("div").append($('<input/>', {
			type : 'hidden',
			name : gisu_crc_img_seq,
			value : taget_img_id
		}));
		$(input).closest("td").children("div").append("<br />");
		$(input).closest("td").append("</div>");
		$(input).closest("div").remove();
	}
</script>
<script>
	$(function() {
		$("#sortable").sortable();
		$("#sortable").disableSelection();
	});
	
	function getThumbnailPrivew(input, targetId) {
	    // 필드 채워지면
	    if($(input).val() != ""){
	        // 확장자 체크
	        var ext = $(input).val().split(".").pop().toLowerCase();
	        if($.inArray(ext, ["bmp","gif","jpg","jpeg","png"]) == -1){
	            alert("bmp, gif, jpg, jpeg, png 파일만 업로드 해주세요.");
	            $(input).val("");
	            return;
	        }
	        // 용량 체크
	        var fileSize = input.files[0].size;
	        var maxSize = 1024 * 1024 * 10;
	        if(fileSize > maxSize){
	            alert("파일용량 1MB을 초과했습니다.");
	            $(input).val("");
	        }
	        // 가로,세로 길이
	        var file = input.files[0];
	        var _URL = window.URL || window.webkitURL;
	        var img = new Image();
	        img.src = _URL.createObjectURL(file);
	        img.onload = function() {
	            $(input).next().next().remove();
	            var add_tag = "<p name='tmp_"+targetId+"'>"+img.width+" x "+img.height+"</p>"
	            $(input).closest("td").append(add_tag);
	        }
	    }
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            var element = window.document.getElementById(targetId);
	            element.setAttribute("src", e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	//이미지 순서 정하는 함수
	function order(){
		//drag and drop으로 순서가 바뀐 list에 순서대로 name을 부여하는 함수
		$('#sortable li').each(function(index, element){
			var image_id = "gisu_crc_img_file"+index;
			var image_name = "gisu_crc_img_list[" + index + "].gisu_crc_img_file";
			var image_seq = "gisu_crc_img_list[" + index + "].gisu_crc_img_seq";
			$(this).find("*:nth-child(3)").attr("id", image_id);
			$(this).find("*:nth-child(3)").attr("name", image_name);
			$(this).find("*:nth-child(2)").attr("name", image_seq);
		});
	}
	
	
</script>
</head>
<body ng-app="myapp" ng-controller="AdminController">
	<%@include file="admin_menu.jsp"%>
	<div class="page_title">
		<h2>SMART Cloud IT 마스터 기수 관리</h2>
		<h5>
			<a href="curriculum_gisu_manager_form">기수 관리 페이지</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;기수
			정보 수정
		</h5>
	</div>
	<div class="gisu_crc_selectGroup">
		<select id="curSelect">
			<option value="0">선택</option>
			<c:forEach var="data" items="${seaCurList }">
				<option value="${data.crc_seq }">${data.crc_nm }</option>
			</c:forEach>
		</select>
	</div>
	<div class="custom_div">
		<form action="/edu/admin/curriculum_gisu_update"
			onsubmit="order(); return formCheck();" enctype="multipart/form-data"
			method="post">
            <input type="hidden" name="crc_seq" id="crc_seq">
            <input type="hidden" name="gisu_seq" id="gisu_seq" value="${seaCurGisu.gisu_seq }">
			<table class="gisu_crc_table">
				<colgroup>
					<col width="20%" />
					<col width="80%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="name">입력 항목</th>
						<th scope="col">내 용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="name first">기수</td>
						<td class="first"><input type="text" name="gisu_num"
							id="gisu_num" maxlength="10" value="${seaCurGisu.gisu_num }"></td>
					</tr>
					<tr>
						<td class="name">과정분류</td>
						<%-- <td><input type="text" name="gisu_crc_class"
							id="gisu_crc_class" maxlength="100"
							value="${seaCurGisu.gisu_crc_class }"></td> --%>
							
						<!-- 앵귤러로 처리 -->
						<td>
							<select id="crc_class" name="gisu_crc_class" ng-model="seaCurGisu.gisu_crc_class">
								<option selectcode value="A1200"></option>
								<option selectcode value="A1201"></option>
								<option selectcode value="A1202"></option>
								<option selectcode value="A1203"></option>
								<option selectcode value="A1204"></option>
							</select>
						</td>
						<!---------------------------->	
					</tr>
					<tr>
						<td class="name">과정명</td>
						<td><input type="text" name="gisu_crc_nm" id="gisu_crc_nm"
							maxlength="100" value="${seaCurGisu.gisu_crc_nm }"></td>
					</tr>
					<tr>
						<td class="name">교육일수</td>
					   <td style="float: left; padding-left: 36px;">
                       <input class="ip_3" type="text" name="gisu_crc_month" id="gisu_crc_month" maxlength="10" placeholder="MM" value="${seaCurGisu.gisu_crc_month }" />개월&nbsp;&nbsp;
                       <input class="ip_3" type="text" name="gisu_crc_days" id="gisu_crc_days" maxlength="10" placeholder="DD" value="${seaCurGisu.gisu_crc_days }" />일&nbsp;&nbsp;
                       <input class="ip_3" type="text" name="gisu_crc_times" id="gisu_crc_times" maxlength="10" placeholder="TIME" value="${seaCurGisu.gisu_crc_times }" />시간
                    </td>
					</tr>
					<tr>
						<td class="name">교육비</td>
						<td><input type="text" name="gisu_crc_pay" id="gisu_crc_pay"
							maxlength="10" value="${seaCurGisu.gisu_crc_pay }"></td>
					</tr>
					<tr>
						<td class="name">교육인원</td>
						<td><input type="text" name="gisu_crc_personnel"
							id="gisu_crc_personnel" maxlength="5"
							value="${seaCurGisu.gisu_crc_personnel }"></td>
					</tr>
					<tr>
						<td class="name">교육장소</td>
						<td><input type="text" name="gisu_crc_location"
							id="gisu_crc_location" maxlength="30"
							value="${seaCurGisu.gisu_crc_location }"></td>
					</tr>
					<tr>
						<td class="name">신청 시작일</td>
						<td><input type="text" name="gisu_app_st" id="gisu_app_st" class="date_format"
							readonly="readonly" value="${seaCurGisu.gisu_app_st }"></td>
					</tr>
					<tr>
						<td class="name">신청 종료일</td>
						<td><input type="text" name="gisu_app_et" id="gisu_app_et" class="date_format"
							readonly="readonly" value="${seaCurGisu.gisu_app_et }"></td>
					</tr>
					<tr>
						<td class="name">과정 시작일</td>
						<td><input type="text" name="gisu_crc_st" id="gisu_crc_st" class="date_format"
							readonly="readonly" value="${seaCurGisu.gisu_crc_st }"></td>
					</tr>
					<tr>
						<td class="name">과정 종료일</td>
						<td><input type="text" name="gisu_crc_et" id="gisu_crc_et" class="date_format"
							readonly="readonly" value="${seaCurGisu.gisu_crc_et }"></td>
					</tr>
					<tr>
						<td class="name">과정간략소개</td>
						<td><textarea id="gisu_crc_intro" name="gisu_crc_intro"
								style="height: 80px; width: 92%; resize: vertical; margin: 0; padding: 0;"
								maxlength="100">${seaCurGisu.gisu_crc_intro }</textarea></td>
					</tr>				
			</table>
			<br><br><br>		
			
				<ul id="sortable">
					<c:forEach var="list" items="${seaCurGisuImgList}" >									
							<li class="ui-state-default">
								<a href="/edu/admin/curriculum_gisu_img_delete?gisu_seq=${list.gisu_seq}&gisu_crc_img_seq=${list.gisu_crc_img_seq }&gisu_crc_img_saved=${list.gisu_crc_img_saved}"><input type="button" value="삭제하기"></a>			
								<input type="hidden" name="gisu_crc_img_seq" value="${list.gisu_crc_img_seq }">
								
								<input type="file" accept=".bmp, .gif, .jpg, .png"
									onchange="getThumbnailPrivew(this, '${list.gisu_crc_img_seq }');">
								
								<img src="${path }${list.gisu_crc_img_saved }" alt="과정아이콘 이미지  미리보기"  id="${list.gisu_crc_img_seq }" style="border: 1px solid black"/>		
							
					</c:forEach>										
				</ul>
				
			<input class="crc_submit" type="submit" value="수정하기">
			<a href="/edu/admin/curriculum_gisu_delete?gisu_seq=${seaCurGisu.gisu_seq }"><input class="crc_submit" type="button" value="삭제하기"></a>
			<input type="button" value="이미지 추가" onclick="add_img()">
			<br><br><br>
			
		</form>
	</div>
</body>
</html>