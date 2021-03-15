<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/segroup/css/jquery-ui.min.css" />">
<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/jquery.bxslider.min.js" />"></script>
<script src="<c:url value="/resources/segroup/society/edu/js/slidebanner.js" />"></script>
<link href="<c:url value="/resources/segroup/society/edu/css/jquery.bxslider.css" />" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/common.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/sub.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/main.css" />">
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/segroup/society/edu/css/admin_menu.css" />">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글로벌 엔지니어 양성</title>
<style type="text/css" media="print">
@page {
	size: auto; /* auto is the initial value */
	margin: 30mm; /* this affects the margin in the printer settings */
}

html {
	margin: 0px;
	/* this affects the margin on the html before sending to printer */
}

body {
	margin: 0mm; /* margin you want for the content */
}

.apply_btn, .apply_btn * {
	display: none !important;
}
</style>
<script type="text/javascript">
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
			template : "<option>${filterParams}</option>"
		}
	} ]);

	function printWindow() {
		window.print();
	}
</script>
</head>
<body ng-app="myapp">
	<div style="display: block; position: fixed; top: 1px; left: 25px; z-index: 150;">
		<input class="apply_btn" type="button" style="height: 60px; width: 100px;" onclick="printWindow()" value="print">
	</div>
	<c:forEach var="data" items="${eduApplyList}" varStatus="status">
		<div class="sub_m_contents" style="page-break-after: always; margin-top: 10px; margin-bottom: 10px;">
			<div class="apply_form_wrap">
				<h1 style="width: 430px;">SW DevOps마스터 지원신청서</h1>
				<div class="form_wrap">
					<div class="form_line"></div>
					<div class="form_photo">
						<c:if test="${data.app_photo_origin != null && data.app_photo_origin != ''}">
							<div class="form_photo_area" id="imgDiv">
								<%-- <img class="edu_photo_img" alt="" src="/file_download?origin=${data.app_photo_origin}&saved=${data.app_photo_saved}&path=/edu/apply/photo/${data.app_id}_${data.gisu_seq}"> --%>
								<img class="edu_photo_img" alt="" src="/edu/apply/photo/${data.app_id}_${data.gisu_seq}/${data.app_photo_saved}">
							</div>
						</c:if>
					</div>
					<ul class="form_basic form_first">
						<li class="form_title">
							<span>
								성 명 <em>*</em>
							</span>
						</li>
						<li class="form_text border_bt" style="border-right: 1px solid #787878;">
							<input type="text" class="text-center" name="user_nm" value="${data.user_nm }" readonly="readonly" />
						</li>
					</ul>
					<ul class="form_basic">
						<c:set var="birth" value="${data.user_birth }" />
						<li class="form_title border_bt">
							<span>
								생년월일 <em>*</em>
							</span>
						</li>
						<li class="form_text border_bt">
							<input type="text" class="in_ex_sm text-right" value="${fn:substring(birth,0,4) }" readonly="readonly">
							년
							<input type="text" class="in_ex_sm text-right" value="${fn:substring(birth,5,7) }" readonly="readonly">
							월
							<input type="text" class="in_ex_sm text-right" value="${fn:substring(birth,8,10) }" readonly="readonly">
							일
						</li>
					</ul>
					<ul class="form_basic">
						<li class="form_title border_bt">
							<span>
								군병력 <em>*</em>
							</span>
						</li>
						<li class="form_text border_bt">
							<c:choose>
								<c:when test="${data.app_mt_ck eq 'B0602'}">
									<div class="text-center" style="font-size: 15px;">
										<code value='${data.app_mt_ck }'></code>
										(
										<code value='${data.app_mt_ck }'></code>
										사유: ${data.app_mt_etc})
									</div>
								</c:when>
								<c:otherwise>
									<div class="text-center" style="font-size: 15px;">
										<code value='${data.app_mt_ck }'></code>
									</div>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
					<ul class="form_basic form_large">
						<li class="form_title">
							<span>
								현 주소 <em>*</em>
							</span>
						</li>
						<li class="form_large_text">
							<ul>
								<li class="form_text border_bt">
									<b>(우편번호)</b>
									<input type="text" class="in_mid" id="zipcode" name="app_zipcode" readonly="readonly" value="${data.app_zipcode }" />
								<li class="form_text border_bt">
									<input type="text" id="address" name="app_address" readonly="readonly" value="${data.app_address }" />
								</li>
								<li class="form_text">
									<input type="text" id="addressDetail" name="app_address_detail" readonly="readonly" value="${data.app_address_detail }" />
								</li>
							</ul>
						</li>
					</ul>
					<ul class="form_basic">
						<c:set var="phone" value="${data.user_phone }" />
						<li class="form_title">
							<span>
								휴대전화 <em>*</em>
							</span>
						</li>
						<li class="form_text">
							<input type="text" class="in_small text-center" value="${fn:substring(phone,0,3) }" readonly="readonly">
							-
							<input type="text" class="in_small text-center" value="${fn:substring(phone,3,7) }" readonly="readonly">
							-
							<input type="text" class="in_small text-center" value="${fn:substring(phone,7,11) }" readonly="readonly">
						</li>
					</ul>
					<ul class="form_basic">
						<c:set var="em_phone" value="${data.app_em_phone }" />
						<li class="form_title">
							<span>비상연락처</span>
						</li>
						<li class="form_text">
							<input type="text" class="in_small text-center" id="app_em_phone1" value="${fn:substring(em_phone,0,3) }" maxlength="3" readonly="readonly">
							-
							<input type="text" class="in_small text-center" id="app_em_phone2" value="${fn:substring(em_phone,3,7) }" maxlength="4" readonly="readonly">
							-
							<input type="text" class="in_small text-center" id="app_em_phone3" value="${fn:substring(em_phone,7,11) }" maxlength="4" readonly="readonly">
						</li>
					</ul>
					<ul class="form_basic">
						<li class="form_title">
							<span>
								이메일 <em>*</em>
							</span>
						</li>
						<li class="form_text">
							<input type="email" class="text-center" value="${data.user_email }" readonly />
						</li>
					</ul>
					<div class="clear"></div>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							학력사항 <em>*</em>
						</span>
					</h2>
					<table class="form_full_table">
						<thead>
							<tr>
								<th>학교명</th>
								<th>전공</th>
								<th>졸업상태(선택)</th>
								<th>졸업년월</th>
								<th class="last_form">소재지</th>
							</tr>
						</thead>
						<tbody>
		                    <c:if test="${data.eduHistoryList.size() != 0}">
		                        <c:forEach items="${data.eduHistoryList}" var="eduHistory">
		                            <tr>
		                                <td>${eduHistory.app_edu_sc_nm}</td>
		                                <td>${eduHistory.app_edu_major}</td>
		                                <td><code value='${eduHistory.app_edu_gd_ck }'></code></td>
		                                <td>${eduHistory.app_edu_gd_dt}</td>
		                                <td class="last_form">${eduHistory.app_edu_sc_lo}</td>
		                            </tr>
                                    <c:if test="${eduHistory.app_edu_gd_ck eq 'B1001'}">
                                        <th colspan="2">졸업요건</th>
                                        <td colspan="3" class="last_form">${eduHistory.app_edu_gd_rq}</td>
                                    </c:if>
		                        </c:forEach>
		                    </c:if>
						</tbody>
					</table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>경력사항</span>
					</h2>
                    <table class="form_full_table">
                        <thead>
                            <tr>
                                <th>근무처</th>
                                <th>직위</th>
                                <th>근무기간 시작일</th>
                                <th>근무기간 종료일</th>
                                <th>근무부서</th>
                                <th class="last_form">회사전화번호</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${data.careerList.size() != 0}">
                                <c:forEach items="${data.careerList}" var="career">
                                    <tr>
                                        <td>${career.app_crr_place}</td>
                                        <td>${career.app_crr_position}</td>
                                        <td>${career.app_crr_st}</td>
                                        <td>${career.app_crr_et}</td>
                                        <td>${career.app_crr_dept}</td>
                                        <td class="last_form">${career.app_crr_phone}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>교육이수 경력</span>
					</h2>
                    <table class="form_full_table">
                        <thead>
                            <tr>
                                <th>교육과정명</th>
                                <th>교육기간시작일</th>
                                <th>교육기간종료일</th>
                                <th>기관명</th>
                                <th class="last_form" colspan="2">교육내용</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${data.studyList.size() != 0}">
                                <c:forEach items="${data.studyList}" var="study">
                                    <tr>
                                        <td>${study.app_study_nm}</td>
                                        <td>${study.app_study_st}</td>
                                        <td>${study.app_study_et}</td>
                                        <td>${study.app_study_ag}</td>
                                        <td class="last_form" colspan="2">${study.app_study_detail}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>언어능력</span>
					</h2>
                    <table class="form_full_table">
                        <thead>
                            <tr>
                                <th>언어</th>
                                <th>시험명</th>
                                <th>점수/등급</th>
                                <th>발급기관</th>
                                <th class="last_form">취득일자</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${data.languageList.size() != 0}">
                                <c:forEach items="${data.languageList}" var="language">
                                    <tr>
                                        <td>${language.app_lang_nm}</td>
                                        <td>${language.app_lang_test_nm}</td>
                                        <td>${language.app_lang_grade}</td>
                                        <td>${language.app_lang_ag}</td>
                                        <td class="last_form">${language.app_lang_obtain_dt}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>자격증</span>
					</h2>
                    <table class="form_full_table">
                        <thead>
                            <tr>
                                <th>자격증명</th>
                                <th>등급</th>
                                <th>발급기관</th>
                                <th class="last_form">취득일자</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${data.licenseList.size() != 0}">
                                <c:forEach items="${data.licenseList}" var="license">
                                    <tr>
                                        <td>${license.app_license_nm}</td>
                                        <td>${license.app_license_grade}</td>
                                        <td>${license.app_license_ag}</td>
                                        <td class="last_form">${license.app_license_obtain_dt}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							본 과정 응시 여부 <em>*</em>
						</span>
					</h2>
                    <table class="form_full_table">
                        <thead>
                            <tr>
                                <th colspan="2">본 과정을 응시한 적이</th>
                                <th>지원년월</th>
                                <th class="last_form" colspan="2">선발전형 결과</th>
                            </tr>
                        </thead>
                        <tbody>
                             <tr>
                                 <td colspan="2"><code value='${data.app_take_ck }'></code></td>
                                 <td>${data.app_take_dt}</td>
                                 <td class="last_form" colspan="2">${data.app_take_rt}</td>
                             </tr>
                        </tbody>
                    </table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							K-MOVE 스쿨 참여여부 <em>*</em>
						</span>
					</h2>
                    <table class="form_full_table">
                        <thead>
                            <tr>
                                <th colspan="3">한국산업인력공단의 해외취업 연수과정에 참여한 적이</th>
                                <th>과정명</th>
                                <th>운영기관</th>
                                <th>수강기간 시작일</th>
                                <th class="last_form">수강기간 종료일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="3"><code value='${data.app_kmove_ck }'></code></td>
                                <td>${data.app_kmove_nm}</td>
                                <td>${data.app_kmove_ag}</td>
                                <td>${data.app_kmove_st}</td>
                                <td class="last_form">${data.app_kmove_et}</td>
                            </tr>
                        </tbody>
                    </table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>해외체류 경험</span>
					</h2>
                    <table class="form_full_table">
                        <thead>
                            <tr>
                                <th colspan="2">본인은 과거 해외연수 경험이</th>
                                <td class="last_form" colspan="2"><code value='${data.app_abroad_ck }'></code></td>
                            </tr>
                        </thead>
                        <tbody>
		                    <c:if test="${data.overseasList.size() != 0}">
                                <tr>
                                    <th>국가명</th>
                                    <th>체류기간 시작일</th>
                                    <th>체류기간 종료일</th>
                                    <th class="last_form">목적</th>
                                </tr>
		                        <c:forEach items="${data.overseasList}" var="overseas">
		                             <tr>
		                                 <td>${overseas.app_overseas_nm}</td>
		                                 <td>${overseas.app_overseas_st}</td>
		                                 <td>${overseas.app_overseas_et}</td>
		                                 <td class="last_form">${overseas.app_overseas_purpose}</td>
		                             </tr>
		                        </c:forEach>
		                    </c:if>
                        </tbody>
                    </table>
					<h2>
						<img class="form_arrow" src="<c:url value="/resources/segroup/society/edu/image/main/ico_black.png" />" alt="" />
						<span>
							자기소개 <em>*</em>
						</span>
					</h2>
					<ul class="form_full">
						<li class="sub_title li_last" style="width: 100%;">지원동기, 성장과정, 성격, 가치관 및 특이사항 등을 자유롭게 기술</li>
					</ul>
					<ul class="form_full_text">
						<li class="li_last" style="width: 100%; height: 100%;">
							<textarea class="autosize" style="width: 100%; margin-left: 0px; margin-right: 0px;" readonly="readonly">${data.app_self_intro}</textarea>
						</li>
					</ul>
					<script>
						$("textarea.autosize").each(function() {
							$(this).height($(this).prop('scrollHeight') - 20);
						});
					</script>
					<p class="notice_choice">
						<em>*</em>는 필수항목
					</p>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>