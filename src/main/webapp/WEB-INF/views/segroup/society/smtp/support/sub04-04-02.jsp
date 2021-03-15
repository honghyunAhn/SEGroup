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
			//CK에디터
			CKEDITOR.replace( 'consulting_ct',{
				filebrowserUploadUrl: '/board/imageUpload',
			});
	
			// 공개설정 라디오버튼
			$.each($('div.line > a.radio'), function(index, button) {
				$(button).on('click', radioOnChange);
			});
	
			// 전문보기에서 확인버튼 클릭시
			$(".btn_pop").click(function() {
				$('.check_box').addClass("check_box_a");
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
			if (isCheckboxCorrect() == false) {
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
		 * 성별을 선택했는지
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
	//            alert('내용을 입력해 주시기 바랍니다');
	//            selectAndFocus(consulting_ct);
	            return false;
	        }
	        return true;
	    }
	
		/**
		 * 동의체크를 확인한다
		 */
		function isCheckboxCorrect() {
			var checkbox = $('.master_agree_wrap .agree_line b.check_box');
			if (checkbox.hasClass('check_box_a') == false) {
	            alert('개인정보 처리방침에 동의해 주시기 바랍니다');
				canPass = false;
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
	
		function goToList(){
			location.href="/smtp/support/sub04-04.do";
		}
	
	    /**
	     * 서버에 신청 서비스 요청
	     */
		function ajaxSubmit(){
	        $.LoadingOverlay("show");
			var formData = $("#multiForm").serialize();
		    $.ajax({
		    	type: "POST",
		        url: '<c:url value="/smtp/support/apply_online" />',
		        data: formData,
		        success: function(isRequested) {
		            $.LoadingOverlay("hide");
	                if (isRequested) {
		                alert('온라인상담 신청이 완료되었습니다.');
		                location.href = "<c:url value='/smtp/support/sub04-04' />";
		            } else {
		                alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
		            }
		        },
		        error: function(e) {
		            alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
		            }
	        });
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
				<form id="multiForm" class="formStyle" name="multiForm" onsubmit="return checkOnSubmit();">
		            <div class="header_textWrap margin-bottom40">
		                <h3 class="h3">QnA</h3>
		                <p class="fc_999">궁금한 것이 있다면 무엇이든지 물어보세요!
		            </div>
					<div class="line d-flex margin-bottom10">
						<label class="label" for="ip_2">신청인</label>
						<input class="ip_2" type="text" id="consulting_ins_id" name="consulting_ins_id" 
						maxlength="30" readonly="readonly" value="${consulting_ins_id }" 
						style="width: 70%;"/>
						<input type="hidden" id="consulting_udt_id" name="consulting_udt_id"  value="${consulting_ins_id }" />
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
                        maxlength="30" placeholder="상담 제목" value="${consulting_title }" 
                        style="width: 70%;"/>
                    </div>

					<div class="line_textarea d-flex">
						<textarea id="consulting_ct" name="consulting_ct" rows="40" cols="60"></textarea>
					</div>
					<div class="line margin-bottom20"></div>
				
					<div class="master_agree_wrap">
						<div class="master_agree">
							<p class="agree_title">(주)소프트엔지니어소사이어티 이용약관</p>
							<p class="agree_text">
								제1조(개인정보의 처리목적) SES는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는
								<br>
		                        개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라
		                        별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.
			                    <br>
							</p>
						</div>
						<!-- agree -->

						<div class="agree_line d-flex" >
							<b class="check_box"></b>
								개인정보 처리방침 동의
							<span class="see_more sm1 margin-left40">전문보기 +</span>
						</div>
						<!-- agree_line -->
					</div>

					<div class="line"></div>

					<div class="line line_align_center">
						<input class="join_btn ip_4 btn_normal btn_medium btn_pp_bg" type="submit" value="신청하기">
						<input class="join_btn ip_4 btn_normal btn_medium btn_pp btn-wh" type="button" onclick="goToList()" value="신청취소">
					</div>
				</form>
			</div>
		</div>
    	</div>
    	<div class="agree_pop_bk content" style="top: 100px;">
			<div class="agree_all agree_all_01">
				<div class="section agree_all_txt">
	                <ul>
						<li>(주)소프트엔지니어소사이어티(이하 ‘SES’라 한다)는 개인정보 보호법 제30조에 따라 정보주체의
	                        개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을
	                        수립&nbsp;·&nbsp;공개합니다.</li>
	                    <li>&nbsp;</li>
	                    <li>제1조(개인정보의 처리목적) SES는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는
	                        개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보 보호법 제18조에 따라
	                        별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</li>
	                    <li>&nbsp;</li>
	                    <li>1. 홈페이지 회원 가입 및 관리</li>
	                    <li>회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별&nbsp;·&nbsp;인증, 회원자격 유지&nbsp;·&nbsp;관리, 제한적 본인확인제
	                        시행에 따른 본인확인, 서비스 부정이용 방지, 만 14세 미만 아동의 개인정보 처리시 법정대리인의 동의여부 확인, 각종
	                        고지&nbsp;·&nbsp;통지, 고충처리 등을 목적으로 개인정보를 처리합니다.</li>
	                    <li>2. 재화 또는 서비스 제공</li>
	                    <li>물품배송, 서비스 제공, 콘텐츠 제공, 맞춤서비스 제공, 본인인증, 연령인증, 요금결제&nbsp;·&nbsp;정산, 채권추심
	                        등을 목적으로 개인정보를 처리합니다.</li>
	                    <li>3. 고충처리</li>
	                    <li>민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락&nbsp;·&nbsp;통지, 처리결과 통보 등의 목적으로 개인정보를
	                        처리합니다.</li>
	                    <li>&nbsp;</li>
	                    <li>제2조(개인정보의 처리 및 보유기간) ① SES는 법령에 따른 개인정보 보유&nbsp;·&nbsp;이용기간 또는 정보주체로부터
	                        개인정보를 수집시에 동의받은 개인정보 보유&nbsp;·&nbsp;이용기간 내에서 개인정보를 처리&nbsp;·&nbsp;보유합니다.</li>
	                    <li>&nbsp;</li>
	                    <li>② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.</li>
	                    <li>&nbsp;</li>
	                    <li>1. 홈페이지 회원 가입 및 관리 : SES 홈페이지 탈퇴시까지</li>
	                    <li>다만, 다음의 사유에 해당하는 경우에는 해당 사유 종료시까지</li>
	                    <li>1) 관계 법령 위반에 따른 수사&nbsp;·&nbsp;조사 등이 진행중인 경우에는 해당 수사&nbsp;·&nbsp;조사 종료시까지</li>
	                    <li>2) 홈페이지 이용에 따른 채권&nbsp;·&nbsp;채무관계 잔존시에는 해당 채권&nbsp;·&nbsp;채무관계 정산시까지</li>
	                    <li>&nbsp;</li>
	                    <li>2. 재화 또는 서비스 제공 : 재화&nbsp;·&nbsp;서비스 공급완료 및 요금결제&nbsp;·&nbsp;정산 완료시까지</li>
	                    <li>다만, 다음의 사유에 해당하는 경우에는 해당 기간 종료시까지</li>
	                    <li>1) 「전자상거래 등에서의 소비자 보호에 관한 법률」에 따른 표시&nbsp;·&nbsp;광고, 계약내용 및 이행 등 거래에
	                        관한 기록</li>
	                    <li>- 표시&nbsp;·&nbsp;광고에 관한 기록 : 6월</li>
	                    <li>- 계약 또는 청약철회, 대금결제, 재화 등의 공급기록 : 5년</li>
	                    <li>- 소비자 불만 또는 분쟁처리에 관한 기록 : 3년</li>
	                    <li>2)「통신비밀보호법」제41조에 따른 통신사실확인자료 보관</li>
	                    <li>- 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월</li>
	                    <li>&nbsp;</li>
	                    <li>제3조(개인정보의 제3자 제공) ① SES는 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서
	                        명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조에 해당하는 경우에만
	                        개인정보를 제3자에게 제공합니다.</li>
	                    <li>② SES는 다음과 같이 개인정보를 제3자에게 제공하고 있습니다.</li>
	                    <li>- 개인정보를 제공받는 자 : (주) 디지틀조선</li>
	                    <li>- 제공받는 자의 개인정보 이용목적 : 모의토플 시험 응시</li>
	                    <li>- 제공하는 개인정보 항목 : 성명, 생년월일</li>
	                    <li>- 제공받는 자의 보유&nbsp;·&nbsp;이용기간 : 결제일로부터 1년</li>
	                    <li>&nbsp;</li>
	                    <li>제4조(정보주체의 권리&nbsp;·&nbsp;의무 및 행사방법) ① 정보주체는 SES에 대해 언제든지 다음 각 호의 개인정보
	                        보호 관련 권리를 행사할 수 있습니다.</li>
	                    <li>1. 개인정보 열람요구</li>
	                    <li>2. 오류 등이 있을 경우 정정 요구</li>
	                    <li>3. 삭제요구</li>
	                    <li>4. 처리정지 요구</li>
	                    <li>② 제1항에 따른 권리 행사는 SES에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실
	                        수 있으며 SES는 이에 대해 지체없이 조치하겠습니다.</li>
	                    <li>③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 SES는 정정 또는 삭제를
	                        완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</li>
	                    <li>④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수
	                        있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</li>
	                    <li>⑤ 정보주체는 개인정보 보호법 등 관계법령을 위반하여 SES가 처리하고 있는 정보주체 본인이나 타인의
	                        개인정보 및 사생활을 침해하여서는 아니됩니다.</li>
	                    <li>&nbsp;</li>
	                    <li>제5조(처리하는 개인정보 항목) SES는 다음의 개인정보 항목을 처리하고 있습니다.</li>
	                    <li>1. 홈페이지 회원 가입 및 관리</li>
	                    <li>&nbsp;·&nbsp;필수항목 : 성명, 생년월일, 아이디, 비밀번호, 전화번호, 성별, 이메일주소</li>
	                    <li>&nbsp;</li>
	                    <li>2. 재화 또는 서비스 제공</li>
	                    <li>&nbsp;·&nbsp;필수항목 : 성명, 생년월일, 아이디, 비밀번호, 주소, 전화번호, 이메일주소, 신용카드번호,
	                        은행계좌정보 등 결제정보</li>
	                    <li>&nbsp;·&nbsp;선택항목 : 과거 구매내역</li>
	                    <li>&nbsp;</li>
	                    <li>3. 인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.</li>
	                    <li>&nbsp;·&nbsp;IP주소, 쿠키, MAC주소, 서비스 이용기록, 방문기록, 불량 이용기록 등</li>
	                    <li>&nbsp;</li>
	                    <li>제6조(개인정보의 파기) ① SES는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게
	                        되었을 때에는 지체없이 해당 개인정보를 파기합니다.</li>
	                    <li>② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에
	                        따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를
	                        달리하여 보존합니다.</li>
	                    <li>③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.</li>
	                    <li>1. 파기절차</li>
	                    <li>SES는 파기 사유가 발생한 개인정보를 선정하고, SES의 개인정보 보호책임자의 승인을 받아 개인정보를
	                        파기합니다.</li>
	                    <li>2. 파기방법</li>
	                    <li>SES는 전자적 파일 형태로 기록&nbsp;·&nbsp;저장된 개인정보는 기록을 재생할 수 없도록 로우레밸포멧(Low
	                        Level Format) 등의 방법을 이용하여 파기하며, 종이 문서에 기록&nbsp;·&nbsp;저장된 개인정보는 분쇄기로 분쇄하거나
	                        소각하여 파기합니다.</li>
	                    <li>&nbsp;</li>
	                    <li>제7조(개인정보의 안전성 확보조치) SES는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고
	                        있습니다.</li>
	                    <li>1. 관리적 조치 : 내부관리계획 수립&nbsp;·&nbsp;시행, 정기적 직원 교육 등</li>
	                    <li>2. 기술적 조치 : 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의
	                        암호화, 보안프로그램 설치</li>
	                    <li>3. 물리적 조치 : 전산실, 자료보관실 등의 접근통제</li>
	                    <li>&nbsp;</li>
	                    <li>제8조(개인정보 보호책임자) ① SES는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와
	                        관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</li>
	                    <li>&nbsp;</li>
	                    <li>▶ 개인정보 보호책임자</li>
	                    <li>성명 : 최승호</li>
	                    <li>직책 : 과장</li>
	                    <li>연락처 : 전화 02-6000-5189, 이메일 kaeback@sesoc.global, FAX
	                        02-6000-6261</li>
	                    <li>&nbsp;</li>
	                    <li>② 정보주체께서는 SES의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의,
	                        불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다. SES는 정보주체의 문의에 대해
	                        지체없이 답변 및 처리해드릴 것입니다.</li>
	                    <li>&nbsp;</li>
	                    <li>제9조(개인정보 열람청구) 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의
	                        부서에 할 수 있습니다. SES는 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.</li>
	                    <li>&nbsp;</li>
	                    <li>▶ 개인정보 열람청구 접수&nbsp;·&nbsp;처리 부서</li>
	                    <li>부서명 : O2O 클라우드팀</li>
	                    <li>담당자 : 최승호</li>
	                    <li>연락처 : 전화 02-6000-5189, 이메일 kaeback@sesoc.global, FAX
	                        02-6000-6261</li>
	                    <li>&nbsp;</li>
	                    <li>제10조(권익침해 구제방법) 정보주체는 아래의 기관에 대해 개인정보 침해에 대한 피해구제, 상담 등을
	                        문의하실 수 있습니다.</li>
	                    <li>&nbsp;</li>
	                    <li>&lt;아래의 기관은 SES와는 별개의 기관으로서, SES의 자체적인 개인정보 불만처리, 피해구제 결과에
	                        만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다&gt;</li>
	                    <li>&nbsp;</li>
	                    <li>▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영)</li>
	                    <li>- 소관업무 : 개인정보 침해사실 신고, 상담 신청</li>
	                    <li>- 홈페이지 : privacy.kisa.or.kr</li>
	                    <li>- 전화 : (국번없이) 118</li>
	                    <li>- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
	                    <li>&nbsp;</li>
	                    <li>▶ 개인정보 분쟁조정위원회 (한국인터넷진흥원 운영)</li>
	                    <li>- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결)</li>
	                    <li>- 홈페이지 : privacy.kisa.or.kr</li>
	                    <li>- 전화 : (국번없이) 118</li>
	                    <li>- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터</li>
	                    <li>&nbsp;</li>
	                    <li>▶ 대검찰청 사이버범죄수사단 : 02-3480-3573 (www.spo.go.kr)</li>
	                    <li>&nbsp;</li>
	                    <li>▶ 경찰청 사이버테러대응센터 : 1566-0112 (www.netan.go.kr)</li>
	                    <li>&nbsp;</li>
	                    <li>제11조(개인정보 처리방침 변경) ① 이 개인정보 처리방침은 2018. 8. 1부터 적용됩니다.</li>
					</ul>
	            </div>
				<div class="btn_pop">확인</div>
			</div>
		<!--agree_all-->
		</div>
		<!-- footer-include -->
    	<%@include file="../include/common_footer_rainbow.jsp" %>
    </div>
</body>
</html>