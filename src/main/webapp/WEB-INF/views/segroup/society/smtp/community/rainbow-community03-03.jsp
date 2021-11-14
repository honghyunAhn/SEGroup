<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp" %>
    <script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
	<script src="<c:url value="/resources/segroup/ckeditor/ckeditor.js" />"></script>
	<script src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.5/dist/loadingoverlay.min.js"></script>
	<script type="text/javascript">
        var myApp = angular.module('myapp', []);
        myApp.directive('code', ['$http', function ($http) {
            return {
                restrict: "E",
                replace: true,
                scope: {
                    value: '@'
                },
                controller: function ($scope, $element, $attrs) {
                    $http({
                        method: 'POST',
                        url: '/codeconverter',
                        responseType: 'text',
                        params: {
                            code: $attrs.value
                        }
                    }).then(function successCallback(response) {
                        $scope.filterParams = response.data;
                    }, function errorCallback(response) {
                        console.log(response);
                    });
                },
                template: "<span>{{filterParams}}</span>"
            }
        }]);

        // 페이지가 로딩되면 실행
        $(function () {
        	// community nav active
            navLinks[3].parentElement.classList.add('current')
            subNav[3].classList.add('active');
        	
            //CK에디터
            CKEDITOR.replace('consulting_ct', {
                filebrowserUploadUrl: '/board/imageUpload',
            });

            // 전문보기에서 확인버튼 클릭시
            $(".btn_pop").click(function () {
                $('.check_box').addClass("check_box_a");
            });
        });

        // 서브밋하기 전에 데이터를 체크한다
        function checkOnSubmit() {
            if (isIdCorrect() == false) {
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

        // 이름 검사를 진행한다
        function isIdCorrect() {
            var consulting_id = $('#consulting_ins_id');
            if (consulting_id.val() == '') {
                alert('아이디를 입력해 주시기 바랍니다');
                selectAndFocus(consulting_id);
                return false;
            }
            return true;
        }

        // 상담제목을 입력했는지
        function isTitleCorrect() {
            var consulting_title = $('#consulting_title');
            if (consulting_title.val() == '') {
                alert('제목을 입력해 주시기 바랍니다');
                selectAndFocus(consulting_title);
                return false;
            }
            return true;
        }

        // 상담내용을 입력했는지
        function isContentsCorrect() {
            var consulting_ct = $('#consulting_ct');
            if (consulting_ct.val() == '') {
                //alert('내용을 입력해 주시기 바랍니다');
                //selectAndFocus(consulting_ct);
                return false;
            }
            return true;
        }

        // 동의체크를 확인한다
        function isCheckboxCorrect() {
            var checkbox = $('#agree01');
            if (checkbox.prop("checked") == false) {
                alert('개인정보 처리방침에 동의해 주시기 바랍니다');
                return false;
            }
            return true;
        }

        // 엘리먼트를 선택한다
        function selectAndFocus(element) {
            element.select();
            element.focus();
        }

        function goToList() {
            location.href = "/smtp/community/rainbow-community03-01";
        }

        // 서버에 신청 서비스 요청
        function ajaxSubmit() {
            $.LoadingOverlay("show");
            var formData = $("#multiForm").serialize();
            $.ajax({
                type: "POST",
                url: '<c:url value="/smtp/support/apply_online" />',
                data: formData,
                success: function (isRequested) {
                    $.LoadingOverlay("hide");
                    if (isRequested) {
                        alert('온라인상담 신청이 완료되었습니다.');
                        location.href = "<c:url value='/smtp/community/rainbow-community03-01' />";
                    } else {
                        alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
                    }
                },
                error: function (e) {
                    alert('서버에 에러가 발생했습니다. 홈페이지 담당자에게 문의해주십시요.');
                }
            });
        }
    </script>
</head>

<body>
    <!-- community - 03. Q&A >> 게시글 쓰기 -->
    <div class="container_rainbow">
        <!-- rainbow_header -->
        <%@include file="../include/rainbow_header.jsp" %>
        <div class="content course-point04" id="main">
            <div class="sub-content community03-03">
                <div class="section_header">
                    <h3 class="h3">❔ QnA</h3>
                </div>
                <div class="section_formStyle join">
                    <form class="formStyle" id="multiForm" name="multiForm" onsubmit="return checkOnSubmit();">
                        <div class="formWrap">
                            <label class="label" for="ip_2">게시자</label>
                            <input class="input ip_2" type="text" id="consulting_ins_id" name="consulting_ins_id"
                                maxlength="30" readonly="readonly" value="${consulting_ins_id }">
                            <input type="hidden" id="consulting_udt_id" name="consulting_udt_id"
                                value="${consulting_ins_id }">
                        </div>
                        <div class="formWrap">
                            <label class="label" for="consulting_open">공개여부</label>
                            <div class="d-flex">
                                <label>
                                    <input type="radio" class="radio" id="consulting_open_o" name="consulting_open" value="0"
                                        checked>공개
                                </label>
                                <label class="margin-left10">
                                    <input type="radio" class="radio" id="consulting_open_c" name="consulting_open" value="1">비공개
                                </label>
                                <input type="hidden" id="consulting_open" name="consulting_open"
                                    value="${consulting_open }">
                            </div>
                        </div>
                        <div class="formWrap">
                            <label class="label">제목</label>
                            <input class="input ip_2" type="text" id="consulting_title" name="consulting_title"
                                maxlength="30" value="${consulting_title }">
                        </div>
                        <div class="formWrap">
                            <label class="label">내용</label>
                            <div class="line_textarea">
                                <textarea class="textarea" id="consulting_ct" name="consulting_ct" rows="40"
                                    cols="60"></textarea>
                            </div>
                        </div>
                        <div class="checkWrap d-flex justify_between">
                            <div class="d-flex">
                                <input type="checkbox" class="input check" name="agree01" id="agree01">
                                <label for="agree01" class="label">
                                    (필수) 개인정보 처리방침에 동의합니다.
                                </label>
                            </div>
                            <div class="see_more w100">
                                <a href="javascript:void(0)" onclick="openModal('privacyPolicy')"
									class="btn_default btn_xsmall">전문보기</a>
                            </div>
                        </div>
                        <div class="section_btnWrap d-flex justify_center">
                        <input class="join_btn ip_4 btn_default btn_medium" type="button" onclick="goToList()"
                            value="작성취소">
                        <input class="join_btn ip_4 btn_normal btn_medium margin-left20 bgc_point" type="submit" 
                            value="작성완료">
                   		</div>
                    </form>
                </div>
            </div>
            <!--  community - 03. Q&A >> 게시글 쓰기 >> 개인정보 처리방침 modal -->
            <%@include file="../course/modal/rainbow-modal-privacyPolicy.jsp" %>
        </div>
        <%@include file="../include/rainbow_footer.jsp" %>
    </div>
</body>
</html>