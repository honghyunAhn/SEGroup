<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="description" content="다양한 전공과 ICT·AI를 융합하여 K-Digital 인재로 컬러링 해드립니다.">
    <meta name="keywords" content="해외취업, Soft Engineer Society, SES, 소프트엔지니어소사이어티, SCIT, SWDO, E러닝, e-learning">
    <title>Rainbow 레인보우</title>
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
	<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
	<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
	<style type="text/css">
		.check_box { width: 20px ;height: 20px;  border: 2px solid #ddd; box-sizing: border-box; display: inline-block; cursor: pointer;  }
		.check_box_a { border: 5px solid #212121;   }
	</style>
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
	<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
	<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
    <script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/ckeditor/ckeditor.js" />"></script>
	<script src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.5/dist/loadingoverlay.min.js"></script>
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
					obj_button.addClass('btn_pp_bg');
					obj_button.removeClass('btn_wh');
					input_consulting_open.val(obj_button.attr('value'));
				} else {
					obj_button.addClass('btn_wh');
					obj_button.removeClass('btn_pp_bg');
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
	        url: '<c:url value="/smtp/support/apply_online_udt" />',
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
		location.href="/smtp/support/sub04-04-01.do?consulting_seq="+${contentDetail.consulting_seq };
	}	
    </script>
</head>
<body ng-app="myapp">
	<div class="container_rainbow">
        <!-- Header-include -->
        <%@include file="../include/rainbow_header_basic.jsp" %>

        <div class="content sub-content sub04_content" id="main">
        	<div id="update">
	        	<div class="form_box">
					<form id="multiForm" action="/smtp/support/apply_online_udt" class="formStyle" name="multiForm" onsubmit="return checkOnSubmit();" method="post">
			            <div class="header_textWrap margin-bottom40">
			                <h3 class="h3">QnA</h3>
			                <p class="fc_999">궁금한 것이 있다면 무엇이든지 물어보세요!
			            </div>
						<input type="hidden" id="consulting_seq" name="consulting_seq"  value="${contentDetail.consulting_seq }" />
						<div class="line d-flex margin-bottom10">
							<label class="label" for="ip_2">신청인</label>
							<input class="ip_2" type="text" id="consulting_ins_id" name="consulting_ins_id" 
							maxlength="30" readonly="readonly" value="${contentDetail.consulting_ins_id }" 
							style="width: 70%;"/>
							<input type="hidden" id="consulting_udt_id" name="consulting_udt_id"  value="${contentDetail.consulting_ins_id }" />
						</div>
	
						<div class="line d-flex margin-bottom10">
							<label class="label">공개여부</label>
							<a class="btn btn_normal btn_medium btn_pp btn-agree btn-wh radio" id="consulting_open_o" value="0">공개</a> 
							<a class="btn btn_normal btn_medium btn_pp btn-agree btn-wh radio" id="consulting_open_c" value="1">비공개</a>
							<input type="hidden" id="consulting_open" name="consulting_open" value="${consulting_open }">
						</div>
						<div class="line d-flex margin-bottom10">
							<label class="label">제 목</label>
	                        <input class="ip_2" type="text" id="consulting_title" name="consulting_title" 
	                        maxlength="30" placeholder="상담 제목" value="${contentDetail.consulting_title }" 
	                        style="width: 70%;"/>
	                    </div>
	
						<div class="line_textarea d-flex">
							<textarea id="consulting_ct" name="consulting_ct" rows="40" cols="60">${contentDetail.consulting_ct } </textarea>
						</div>
						
						<div class="line"></div>
	
						<div class="line line_align_center">
							<input class="join_btn ip_4 btn_normal btn_medium btn_pp_bg" type="submit" id="consultingUpdateBtn" value="수정하기">
							<input class="join_btn ip_4 btn_normal btn_medium btn_pp btn-wh" type="button" onclick="goToBack()" value="수정취소">
						</div>
					</form>
				</div>
			</div>
    	</div>
    	<!-- footer-include -->
    	<%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>
</html>