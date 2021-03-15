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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
#curSelect{width:20%;}
.gisu_crc_selectGroup{margin-top:20px;margin-left:330px;}
div.custom_div{text-align:center;margin-left:330px;margin-right:330px;}
.crc_submit{color:white;font-weight:bold;font-size:120%;background-color:#3af;border:none;padding:5px;width:180px;height:50px;margin-top:15px;margin-bottom:30px;}

#gisu_image{
    border: 1px solid #eee;
    width: 142px;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    float: left;
    margin-right: 10px;
  }

  #gisu_image li{
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 120px;
  }

</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<script type="text/javascript">

	var myApp = angular.module('myapp', []);
	
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

var gisu_crc_nm_val = '';

$(function() {
		
	var count = 2;		//이미지 추가용 카운트 변수
	var isFirstImage = true;

	
	//date 형식 변경
	$('.date_format').datepicker(
		{
			dateFormat : 'yy/mm/dd'
		}	
	);
	
	minMax("gisu_app_st","gisu_app_et");
	minMax("gisu_crc_st","gisu_crc_et");	
	
	
	$("#curSelect").change(function(){
		var crc_seq = $(this).val();
		
	    if(crc_seq == 0){
	    	//초기화
	    	$("#gisu_crc_nm").val("");
            $("#gisu_crc_month").val("");
            $("#gisu_crc_days").val("");
            $("#gisu_crc_times").val("");
			$("#gisu_crc_pay").val("");
			$("#crc_seq").val("");
	    }else{
	    	//초기화 후 ajax
	    	$.ajax({
				type:"POST",						
				url:"/edu/admin/search_curriculum",		
				data:{
					'crc_seq' : crc_seq,
				},
				success:function(data){
                    $("#gisu_crc_class").val(data.crc_class);
                    $("#gisu_crc_nm").val(data.crc_nm);
                    $("#gisu_crc_month").val(data.crc_month);
                    $("#gisu_crc_days").val(data.crc_days);
                    $("#gisu_crc_times").val(data.crc_times);
                    $("#gisu_crc_pay").val(data.crc_pay);
                    $("textarea[name=gisu_crc_intro]").html(data.crc_intro);
					$("#crc_seq").val(data.crc_seq);
					gisu_crc_nm_val = data.crc_nm;
				},
				error: function(e){
					console.log(e);
				}
			});
	    }
	    
	});
	
	//이미지 추가버튼
	$("#add_img").click(function(){
		
		if(!confirm('이미지를 추가하시겠습니까?')){
			return;
		}
		
		
			//이미지 추가 (리스트)
			
			
			var add_li = document.createElement("li");
			$(add_li).addClass("ui-state-default");
			
			var str = "'avatar_img" + count + "'";
			
			var inner_str = "";
			
			inner_str += "<input type='file' id='gisu_crc_img_file" + count +  "' accept='.bmp, .gif, .jpg, .png'";
			inner_str += ' onchange = "javascript:getThumbnailPrivew(this, ' + str + ');">';
			inner_str += "<img alt='과정아이콘 이미지 미리보기'  id='avatar_img" + count + "' style='border: 1px solid black'/>"
			
			add_li.innerHTML = inner_str;
			var ul = document.getElementById("gisu_image");
			
			ul.appendChild(add_li);
			
			count ++;
			
			$( function() {
			    $( "#gisu_image").sortable({
			      connectWith: ".connectedSortable"
			    }).disableSelection();
			  } );
			
		
		
		
	});
	
	/* $("#remove_img").click(function(){
		if(confirm('이미지를 제거 하시겠습니까?')){
			
			count--;
			
			if(count <= 1){
				$("#crc_img_output").html("");
			}else{
				$("#img_tr" + count).remove();
			}
			
			if(count == 1){
				var remove = document.getElementById("crc_img_output");
				remove.removeChild(remove.childNodes[0]);
			}
		}
	}); */
	
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
	$('#gisu_image li').each(function(index, element){		
		var image_name = "gisu_crc_img_list[" + index + "].gisu_crc_img_file";
		var d = $(this).find("*:first-child").attr("name", image_name);			
	});
}

function formCheck(){
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

function test() {
	
	$('#gisu_crc_nm').val(gisu_crc_nm_val);
	var gisu_crc_nm = $('#gisu_crc_nm').val();
	var gisu_num = $('#gisu_num').val();
	$('#gisu_crc_nm').val(gisu_crc_nm + ' ' + gisu_num +'기');
	
}

</script>
</head>
<body ng-app="myapp">
<%@include file="admin_menu.jsp"%>
<div class="page_title">
	<h2>SMART Cloud IT 마스터 기수 관리</h2>
    <h5><a href="curriculum_gisu_manager_form">기수 관리 페이지</a>&nbsp;&nbsp;&gt;&nbsp;&nbsp;신규 기수 등록</h5>
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
	<form action="/edu/admin/curriculum_gisu_insert" onsubmit="order();return formCheck();" enctype="multipart/form-data" method="post">
	<input type="hidden" name="crc_seq" id="crc_seq">
		<table class="gisu_crc_table">
			<colgroup>
				<col width="20%"/>
				<col width="80%"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="name">입력 항목</th>
					<th scope="col">내  용</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<tr>
					<td class="name first">기수</td>
					<td class="first"><input type="text" name="gisu_num" id="gisu_num" maxlength="10" onkeyup="test()"></td>
				</tr>
                <tr>
                    <td class="name">과정분류</td>
                    <!-- <td><input type="text" name="gisu_crc_class" id="gisu_crc_class" maxlength="100"></td> -->
                    <!-- 앵귤러 처리? -->
                    <td>
                    	<select id="gisu_crc_class" name="gisu_crc_class">
                   			<option selectcode value="A1200"></option>
							<option selectcode value="A1201"></option>
							<option selectcode value="A1202"></option>
							<option selectcode value="A1203"></option>
							<option selectcode value="A1204"></option>
                    	</select>
                    </td>
                    <!--------------->
                </tr>
                <tr>
                    <td class="name">과정명</td>
                    <td><input type="text" name="gisu_crc_nm" id="gisu_crc_nm" maxlength="100"></td>
                </tr>
				<tr>
					<td class="name">교육일수 및 시간</td>
                    <td style="float: left; padding-left: 36px;">
                       <input class="ip_3" type="text" name="gisu_crc_month" id="gisu_crc_month" maxlength="2" placeholder="MM" />개월&nbsp;&nbsp;
                       <input class="ip_3" type="text" name="gisu_crc_days" id="gisu_crc_days" maxlength="4" placeholder="DD" />일&nbsp;&nbsp;
                       <input class="ip_3" type="text" name="gisu_crc_times" id="gisu_crc_times" maxlength="8" placeholder="TIME" />시간
                    </td>
                <tr>
                    <td class="name">교육비</td>
                    <td><input type="text" name="gisu_crc_pay" id="gisu_crc_pay"></td>
                </tr>
                <tr>
                    <td class="name">교육인원</td>
                    <td><input type="text" name="gisu_crc_personnel" id="gisu_crc_personnel" maxlength="5"></td>
                </tr>
                <tr>
                    <td class="name">교육장소</td>
                    <td><input type="text" name="gisu_crc_location" id="gisu_crc_location" maxlength="30"></td>
                </tr>
				<tr>
					<td class="name">신청 시작일</td>
					<td><input type="text" name="gisu_app_st" id="gisu_app_st" readonly="readonly" class="date_format"></td>
				</tr>
				<tr>
					<td class="name">신청 종료일</td>
					<td><input type="text" name="gisu_app_et" id="gisu_app_et" readonly="readonly" class="date_format"></td>
				</tr>
				<tr>
					<td class="name">과정 시작일</td>
					<td><input type="text" name="gisu_crc_st" id="gisu_crc_st" readonly="readonly" class="date_format"></td>
				</tr>
                <tr>
                    <td class="name">과정 종료일</td>
                    <td><input type="text" name="gisu_crc_et" id="gisu_crc_et" readonly="readonly" class="date_format"></td>
                </tr>
                <tr>
                    <td class="name">과정간략소개</td>
                    <td>
                        <textarea id="gisu_crc_intro" name="gisu_crc_intro" 
                        style="height: 80px; width: 92%; resize: vertical; margin: 0; padding: 0;" maxlength="100"></textarea>
                    </td>
                </tr>                
			</tbody>			
		</table>
		
		<input type="button" value="이미지 추가" id="add_img">
		<input class="crc_submit" type="submit" value="등록하기">
	
	
		<ul id="gisu_image" class="connectedSortable">
			<li class="ui-state-default">
				<input type="file" id="gisu_crc_img_file1" accept=".bmp, .gif, .jpg, .png"
					onchange="getThumbnailPrivew(this, 'avatar_img1');">
				
				<img alt="과정아이콘 이미지  미리보기"  id="avatar_img1" style="border: 1px solid black"/>
			</li>
		</ul>
	</form>
</div>
</body>
</html>