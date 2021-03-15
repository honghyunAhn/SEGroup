<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" Content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, target-densitydpi=medium-dpi " />
<meta name="format-detection" content="telephone=no">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script
	src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<head>
<title>글로벌 엔지니어 양성</title>
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
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/segroup/society/edu/css/join.css" />">
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<link rel="stylesheet"
	href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/ckeditor/ckeditor.js" />"></script>
<script type="text/javascript">
    /**
     * angular.js
     */
    var myApp = angular.module('myapp', []);
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
                    console.log(response);
                });
            },
            template : "<span>{{filterParams}}</span>"
        }
    } ]);
    
	/**
	 * 페이지가 로딩되면 실행
	 */
	$(function() {
		// 공개설정 라디오버튼
		$.each($('div.line > a.radio'), function(index, button) {
			$(button).on('click', radioOnChange);
		});

		// 전문보기에서 확인버튼 클릭시
		$(".btn_pop").click(function() {
			$('.check_box').addClass("check_box_a");
		});
		
		// 공개여부 설정 로드
		$.each($('div.line > a.radio'), function(index, button) {
			$(button).on('click', radioOnChange);
		});
		var consulting_open = ${contentDetail.consulting_open}
		if (consulting_open == '0') {
			$("#consulting_open_o").trigger("click");
		} else {
			$("#consulting_open_c").trigger("click");
		}
		
		//CK에디터
		CKEDITOR.replace( 'consulting_ct',{
			filebrowserUploadUrl: '/board/imageUpload',
		});
	});

	/**
	 * 서브밋하기 전에 데이터를 체크한다
	 */
	function checkOnSubmit() {
		if (isIdCorrect() == false) {
			return false;
		}
		if (isOpenSelected() == false) {
			return false;
		}
        if (isTitleCorrect() == false) {
            return false;
        }
        if (isContentsCorrect() == false) {
            return false;
        }
		ajaxSubmit();
	}

	/**
	 * 이름 검사를 진행한다
	 */
	function isIdCorrect() {
		var consulting_id = $('#consulting_id');
		if (consulting_id.val() == '') {
			alert('아이디를 입력해 주시기 바랍니다');
			selectAndFocus(consulting_id);
			return false;
		}
		return true;
	}

	/**
	 * 공개여부를 선택했는지
	 */
	function isOpenSelected() {
		var consulting_open = $('#consulting_open');
		if (!consulting_open.val()) {
			alert('공개여부를 선택해 주시기 바랍니다');
			selectAndFocus(consulting_open);
			return false;
		}
		return true;
	}

    /**
     * 상담내용을 입력했는지
     */
    function isTitleCorrect() {
        var consulting_title = $('#consulting_title');
        if (consulting_title.val() == '') {
            alert('제목을 입력해 주시기 바랍니다');
            selectAndFocus(consulting_title);
            return false;
        }
        return true;
    }

    /**
     * 상담내용을 입력했는지
     */
    function isContentsCorrect() {
        var consulting_ct = $('#consulting_ct');
        if (consulting_ct.val() == '') {
            alert('내용을 입력해 주시기 바랍니다');
            selectAndFocus(consulting_ct);
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

	/**
	 * 공개여부 선택 이벤트
	 */
	function radioOnChange(evt) {
		$.each($('div.line > a.btn'), function(index, button) {
			var obj_button = $(button);
			var input_consulting_open = $('#consulting_open');
			if (evt.currentTarget == button) {
				obj_button.addClass('btn_b');
				obj_button.removeClass('btn_gray btn_fore_black');
				input_consulting_open.val(obj_button.attr('value'));
			} else {
				obj_button.addClass('btn_gray btn_fore_black');
				obj_button.removeClass('btn_b');
			}
		});
	}
	
    /**
     * 서버에 신청 서비스 요청
     */
	function ajaxSubmit(){
// 		alert("Ajax 신청서비스 들어가기 전~!");
        $.LoadingOverlay("show");
		
	    $.ajax({
	    	type: "POST",
	        url: '<c:url value="/edu/consulting/apply_online_udt" />',
	        success: function(isRequested) {
	            $.LoadingOverlay("hide");
                
	            if (isRequested) {
	                alert('온라인상담 수정이 완료되었습니다.');
	                goToBack();
	            } else {
	                alert('서버에 에러가 발생했습니다. 재시도 후에도 에러발생시 홈페이지 담당자에게 문의해주십시요.');
	            }
	        },
	        error: function(e) {
	            alert('서버에 에러가 발생했습니다. 재시도 후에도 에러발생시 홈페이지 담당자에게 문의해주십시요.');
	        }
	    });
	}

	function goToBack(){
		location.href="/edu/consulting/online_consulting_detail.do?consulting_seq="+${contentDetail.consulting_seq };
	}	
</script>
<style>
.top_img {
    position: relative;
    background-image: url(/resources/segroup/society/edu/image/main/top_img/top_img_online.jpg);                                                               
    height: 250px;
    background-size: cover;
}
</style>
</head>
<body ng-app="myapp" ng-controller="BoardController">
	<%@include file="../menu.jsp"%>
    <div class="top_img">
        <div class="top_img_text">
            <p class="top_img_text1">온라인상담 QnA</p>
            <p class="top_img_text2">궁금한 것이 있다면 뭐든지 물어보세요!</p>
        </div>
    </div>

    <div style="overflow: hidden; width: 100%; height: 50px;"></div>

	<div class="notice_wrap">
<!-- 		<div class="main_notice_title1" -->
<!-- 			style="padding-top: 70px; padding-bottom: 30px;"> -->
<!-- 			<h1>온라인 상담 신청내역 수정</h1> -->
<!-- 		</div> -->
		<div id="update">
			<div class="form_box">
				<form action="/edu/consulting/apply_online_udt" method="post"  enctype="multipart/form-data" onsubmit="return checkOnSubmit();">
					<input type="hidden" id="consulting_seq" name="consulting_seq"  value="${contentDetail.consulting_seq }" />
					<div class="line">
						<input class="ip_2" type="text" id="consulting_ins_id" name="consulting_ins_id"
							maxlength="30" readonly="readonly" value="${contentDetail.consulting_ins_id }" />
						<input type="hidden" id="consulting_udt_id" name="consulting_udt_id"  value="${contentDetail.consulting_ins_id }" />
					</div>

					<div class="line line_align_center">
						<a class="btn btn_fifty_width btn_gray btn_fore_black radio"
							id="consulting_open_o" value="0">공개</a><a
							class="btn btn_fifty_width btn_gray btn_fore_black radio"
							id="consulting_open_c" value="1">비공개</a><input
							type="hidden" id="consulting_open" name="consulting_open"
							value="${consulting_open }">
					</div>
					
					<div class="line">
                        <input class="ip_2" type="text" id="consulting_title" name="consulting_title"
                            maxlength="30" placeholder="상담 제목" value="${contentDetail.consulting_title }" />
                    </div>

					<div class="line_textarea">
						<textarea id="consulting_ct" name="consulting_ct" rows="40" cols="60">${contentDetail.consulting_ct } </textarea>
					</div>
					<br><br><br><br>
					<div class="line"></div>

					<div class="line line_align_center">
						<input class="join_btn ip_4" type="submit" id="consultingUpdateBtn" value="수정하기">
						<input class="join_btn ip_4" type="button" onclick="goToBack()" value="수정취소">
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@include file="../footer.jsp"%>

</body>
</html>