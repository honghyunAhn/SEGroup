<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>사용자_과정신청-이력서-수정</title>
    
    <!-- 레인보우 기본세팅 -->
	<link rel="stylesheet" href="/resources/segroup/society/smtp/css/reset.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/common.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/img-icon.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/swiper.min.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style.css">
    <link rel="stylesheet" href="/resources/segroup/society/smtp/css/rainbow_style_responsive.css">
    <script src="/resources/segroup/society/smtp/js/jquery-3.3.1.min.js"></script>
    <script src="/resources/segroup/society/smtp/js/swiper.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script.js"></script>
    <script src="/resources/segroup/society/smtp/js/rainbow_script_responsive.js"></script>
    
    <!-- 추가 라이브러리 -->
    <link rel="stylesheet" href="<c:url value="/resources/segroup/society/smtp/css/resumeForm.css" />">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
    <script src="<c:url value="/resources/segroup/society/smtp/js/jquery-ui.js" />"></script>
    <script src="<c:url value="/resources/segroup/society/smtp/js/angular.js" />"></script>
    <script src="<c:url value="/resources/segroup/society/smtp/js/datepicker.js" />"></script>
    <script src="<c:url value="/resources/segroup/society/smtp/js/resumeUpdateForm.js" />"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <script type="text/javascript">
	    var apply = ${apply};
		var app_end_date = "${app_end_date}";
		var message = "${message}";
    </script>
</head>

<body ng-app="myApp">
	<div class="container_rainbow">
		<!-- header-include -->
	    <%@include file="../include/rainbow_header_basic.jsp"%>
    
		<div class="container subPage_container sub01 d-flex">
	        <div class="resumeContent subPage_content">
	            <div class="resumeSection">
	            	<form action="/smtp/apply/update" name="resume" id="resumeForm" method="post" enctype="multipart/form-data">
	                <!-- <form action="/smtp/apply/update" name="resume" id="resumeForm" method="post" onsubmit="return formCheck();" enctype="multipart/form-data"> -->
	                	<input type="hidden" name="app_end_date" value="${app_end_date}" />
	                	<input type="hidden" name="stu_app_seq" value="${data.stu_app_seq }" />
			            <input type="hidden" name="gisu_id" value="${data.gisu_id }" />
			            <input type="hidden" name="crc_id" value="${data.crc_id }" />
						<input type="hidden" name="user_id" value="${data.user_id }" />
						<input type="hidden" name="stu_app_ins_id" value="${data.stu_app_ins_id }" />
	<%-- 					<input type="hidden" name="stu_app_ins_dt_forupdate" value="${data.stu_app_ins_dt }" /> --%>
						<input type="hidden" name="stu_app_udt_id" value="${data.stu_app_udt_id }" />
						<input type="hidden" name="stu_app_nm" value="${data.stu_app_nm }">
						<input type="hidden" name="stu_app_birth" value="${data.stu_app_birth }">
						<input type="hidden" name="stu_app_gender" value="${data.stu_app_gender }">
						
						<h2 class="h2">${data.gisu_nm} 지원서</h2>
	                    <div class="resumeMsg">
	                        <strong class="cRed">＊</strong>가 표기된 항목은
	                        <strong class="cRed">필수 입력항목</strong>입니다.
	                    </div>
	
	                    <!-- 기본정보 rsm_profile -->
	                    <div class="resumeWrap rsm_profile">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">기본정보</h3>
	                            <p class="cGray">담당자가 연락하는 이메일과 휴대폰 정보가 올바르게 입력되어 있는지 확인하세요.</p>
	                        </div>
	                        <div class="resumeSection d-flex">
	                            <div class="resumePhotoWrap">
	                                <div class="imgBox">
	                                    <div class="imgGuide"></div>
	                                    <div class="imgHere">
	                                    	<img class="stu_photo_img" alt="" src="" width="150px" height="200px">
	                                    </div>
	                                </div>
	                                <div class="imgBtnWrap d-flex">
	                                    <div class="imgBtn addImg">
	                                    	<input type="hidden" name="stu_app_photo_origin" value="${data.stu_app_photo_origin }">
	                                    	<input type="hidden" name="stu_app_photo_saved" value="${data.stu_app_photo_saved }">
	                                        <input type="file" name="stu_app_photo_file" id="resumePhoto" class="resumePhoto addImg">
	                                        <label for="resumePhoto"><span>등록</span></label>
	                                    </div>
	                                    <div class="imgBtn delImg">제거</div>
	                                </div>
	<!--                                 <a class="downImg" href="">사진 다운로드</a> -->
	                            </div>
	                            <div class="resumeFormWrap">
	                                <div class="resumeForm row d-flex">
	                                    <div class="resumeForm_text resumeForm_load form33">
	                                        <div class="rsm_label">성명<strong class="cRed">＊</strong></div>
	                                        <div class="rsm_input" id="stu_app_nm">${data.stu_app_nm }</div>
	                                    </div>
	                                    <div class="resumeForm_text resumeForm_load form33">
	                                        <div class="rsm_label">생년월일<strong class="cRed">＊</strong></div>
	                                        <div class="rsm_input" id="stu_app_birth">${data.stu_app_birth }</div>
	                                    </div>
	                                    <div class="resumeForm_text resumeForm_load form33">
	                                        <div class="rsm_label">성별<strong class="cRed">＊</strong></div>
	                                        <div class="rsm_input" id="stu_app_gender">
	                                        	<code value="${data.stu_app_gender}"></code>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="resumeForm row d-flex">
	                                    <div class="resumeForm_text form100">
	                                        <div class="rsm_label">병역<strong class="cRed">＊</strong></div>
	                                        <div class="rsm_input d-flex">
	                                        	<label for="militaryService_01" class="rsm_radio">
	                                            	<input type="radio" name="stu_app_mt_ck" value="B0600" ng-model="stuApply.stu_app_mt_ck" id="militaryService_01">
													<code value="B0600"></code>
												</label>
												<label for="militaryService_02" class="rsm_radio">
	                                            	<input type="radio" name="stu_app_mt_ck" value="B0601" ng-model="stuApply.stu_app_mt_ck" id="militaryService_02">
	                                            	<code value="B0601"></code>
	                                            </label>
	                                            <label for="militaryService_03" class="rsm_radio">
		                                            <input type="radio" name="stu_app_mt_ck" value="B0603" ng-model="stuApply.stu_app_mt_ck" id="militaryService_03">
	    	                                        <code value="B0603"></code>
	    	                                    </label>
	    	                                    <label for="militaryService_04" class="rsm_radio">
		                                            <input type="radio" name="stu_app_mt_ck" value="B0602" ng-model="stuApply.stu_app_mt_ck" id="militaryService_04">
													<code value="B0602"></code>
	             		                            <input type="text" class="rsm_input" name="stu_app_mt_etc" id="militaryService_05" ng-class="{'disabled' : stuApply.stu_app_mt_ck!='B0602'}" maxlength="30" placeholder="면제사유 30자 이내로 서술하세요.">
	                                        	</label>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="resumeForm row d-flex">
	                                    <div class="resumeForm_text form100 rsmForm_address d-flex justify_between">
	                                        <div class="rsm_txt">
	                                            <label for="loadAddress" class="rsm_label">
	                                                주소<strong class="cRed">＊</strong>
	                                            </label>
	                                            <div class="rsmForm_addressDiv d-flex justify_between">
	                                                <input type="text" class="rsm_input loadAddress" id="zipcode" name="stu_app_zipcode" value="${data.stu_app_zipcode }" style="cursor:default;" readonly>
	                                                <input type="text" class="rsm_input loadAddress" id="address" name="stu_app_addr" value="${data.stu_app_addr }" style="cursor:default;" readonly>
	                                                <input type="text" class="rsm_input " id="addressDetail" name="stu_app_addr_detail" value="${data.stu_app_addr_detail }">
	                                            </div>
	                                        </div>
	                                        <!-- 우편번호 검색 기능 넣기 -->
	                                        <div class="rsm_btn searchAddressBtn" onclick="findAddr()">검색</div>
	                                    </div>
	                                </div>
	                                <div class="resumeForm row d-flex">
	                                    <div class="resumeForm_text form33">
	                                        <label for="" class="rsm_label">휴대전화<strong class="cRed">＊</strong></label>
	                                        <input type="text" class="rsm_input" name="stu_app_phone" value="${data.stu_app_phone }" type="number" pattern="[0-9]*" maxlength="11" autocomplete="off">
	                                    </div>
	                                    <div class="resumeForm_text form33">
	                                        <label for="" class="rsm_label">비상연락처</label>
	                                        <input type="text" class="rsm_input" name="stu_app_em_phone" type="number" pattern="[0-9]*" value="${data.stu_app_em_phone }" maxlength="11" autocomplete="off">
	                                    </div>
	                                    <div class="resumeForm_text form33">
	                                    	<div class="rsm_label">이메일<strong class="cRed">＊</strong></div>
	                                        <input type="text" class="rsm_input" name="stu_app_email" value="${data.stu_app_email}">
	                                    </div>
	                                </div>
	
	                            </div>
	                        </div>
	                    </div>
	                    <!-- 학력사항 rsm_education// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_education" id="rsm_education" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">학력사항</h3>
	                            <p class="cGray">졸업순으로 입력하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                            	<c:if test="${not empty data.eduHistoryList }">
	                            		<c:forEach var="edu" items="${data.eduHistoryList }" varStatus="status">
			                            	<div class="resumeFormWrapper necessary">
			                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
			                                    <div class="resumeFormWrap">
			                                        <div class="resumeForm row d-flex">
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">학교명<strong class="cRed">＊</strong></div>
			                                                <input type="text" class="rsm_input edu_sc_nm edu_input" name="eduHistoryList[${status.count-1 }].stu_app_edu_sc_nm" value="${edu.stu_app_edu_sc_nm }" autocomplete="off">
			                                            </div>
			                                            
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">전공계열<strong class="cRed">＊</strong></div>
			                                                <select class="rsm_selectBox edu_field edu_input" name="eduHistoryList[${status.count-1 }].stu_app_edu_field">
			                                                    <option value="" selected="selected">선택</option>
			                                                    <option selectcode value="B2800"></option>
			                                                    <option selectcode value="B2801"></option>
			                                                    <option selectcode value="B2802"></option>
			                                                    <option selectcode value="B2803"></option>
			                                                    <option selectcode value="B2804"></option>
			                                                    <option selectcode value="B2805"></option>
			                                                    <option selectcode value="B2806"></option>
			                                                    <option selectcode value="B2807"></option>
			                                                </select>
			                                            </div>
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">전공<strong class="cRed">＊</strong></div>
			                                                <input type="text" class="rsm_input edu_major edu_input" name="eduHistoryList[${status.count-1 }].stu_app_edu_major" value="${edu.stu_app_edu_major }" autocomplete="off">
			                                            </div>
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">졸업상태<strong class="cRed">＊</strong></div>
			                                                <select class="rsm_selectBox edu_gd_ck edu_input" name="eduHistoryList[${status.count-1 }].stu_app_edu_gd_ck" id="eduHistoryList[${status.count-1 }].stu_app_edu_gd_ck">
			                                                    <option value="">선택</option>
			                                                    <!-- <option value="B1000">졸업</option>
																<option value="B1001">예정</option>
																<option value="B1002">유예</option> -->
			                                                    <option selectcode value="B1000"></option>
																<option selectcode value="B1001"></option>
																<option selectcode value="B1002"></option>
			                                                </select>
			                                            </div>
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">졸업일<strong class="cRed">＊</strong></div>
			                                                <input type="text" class="rsm_input edu_gd_dt edu_input" name="eduHistoryList[${status.count-1 }].stu_app_edu_gd_dt" id="stu_app_eduHistory_dt_${status.count-1 }" value="${edu.stu_app_edu_gd_dt }" autocomplete="off">
			                                            </div>
			                                        </div>
			                                        <div class="resumeForm row d-flex">
			                                        	<div class="resumeForm_text form20">
			                                                <div class="rsm_label">소재지<strong class="cRed">＊</strong></div>
			                                                <input type="text" class="rsm_input edu_sc_lo edu_input" name="eduHistoryList[${status.count-1 }].stu_app_edu_sc_lo" value="${edu.stu_app_edu_sc_lo}" autocomplete="off">
			                                            </div>
			                                            <div class="resumeForm_text form80">
			                                                <label for="loadAdress" class="rsm_label d-flex justify_between">
			                                                    <span>졸업요건</span>
			                                                    <span class="cRed h5">졸업예정자의 "졸업요건"은 현재 학적사항 및 연수기간 내 졸업가능 여부를 확인하기 위함입니다. 모든 졸업요건을 충족하고 졸업을 미룬 경우는 졸업상태 "유예"를 선택하세요.</span>
			                                                </label>
			                                                <input type="text" class="rsm_input edu_gd_rq" name="eduHistoryList[${status.count-1 }].stu_app_edu_gd_rq" value="${edu.stu_app_edu_gd_rq }" placeholder="1) 미 이수 학점 있을 경우 : 잔여학점 00학점(이수계획 기재) / 2) 그 외 졸업기준 미달성 시 : 졸업기준 학점 이수완료(졸업기준 기재)" autocomplete="off">
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
			                            </c:forEach>
	                            	</c:if>
	                            	<c:if test="${empty data.eduHistoryList }">
	                            		<div class="resumeFormWrapper">
		                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
		                                    <div class="resumeFormWrap">
		                                        <div class="resumeForm row d-flex">
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">학교명<strong class="cRed">＊</strong></div>
		                                                <input type="text" class="rsm_input edu_sc_nm edu_input" name="eduHistoryList[0].stu_app_edu_sc_nm" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">전공계열<strong class="cRed">＊</strong></div>
		                                                <select class="rsm_selectBox edu_field edu_input" name="eduHistoryList[0].stu_app_edu_field">
		                                                    <option value="" selected="selected">선택</option>
		                                                    <option selectcode value="B2800"></option>
		                                                    <option selectcode value="B2801"></option>
		                                                    <option selectcode value="B2802"></option>
		                                                    <option selectcode value="B2803"></option>
		                                                    <option selectcode value="B2804"></option>
		                                                    <option selectcode value="B2805"></option>
		                                                    <option selectcode value="B2806"></option>
		                                                    <option selectcode value="B2807"></option>
		                                                </select>
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">전공<strong class="cRed">＊</strong></div>
		                                                <input type="text" class="rsm_input edu_major edu_input" name="eduHistoryList[0].stu_app_edu_major" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">졸업상태<strong class="cRed">＊</strong></div>
		                                                <select class="rsm_selectBox edu_gd_ck edu_input" name="eduHistoryList[0].stu_app_edu_gd_ck" onchange="gd_ck_change(this)">
		                                                    <option value="" selected="selected">선택</option>
		                                                    <option selectcode value="B1000"></option>
															<option selectcode value="B1001"></option>
															<option selectcode value="B1002"></option>
		                                                </select>
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label gd_label">졸업일<strong class="cRed">＊</strong></div>
		                                                <input type="text" class="rsm_input edu_gd_dt edu_input" name="eduHistoryList[0].stu_app_edu_gd_dt" id="stu_app_eduHistory_dt_0" autocomplete="off">
		                                            </div>
		                                        </div>
		                                        <div class="resumeForm row d-flex">
		                                        	<div class="resumeForm_text form20">
		                                                <div class="rsm_label">소재지<strong class="cRed">＊</strong></div>
		                                                <input type="text" class="rsm_input edu_sc_lo edu_input" name="eduHistoryList[0].stu_app_edu_sc_lo" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form80">
		                                                <label for="loadAdress" class="rsm_label d-flex justify_between">
		                                                    <span>졸업요건</span>
		                                                    <span class="cRed h5">졸업예정자의 "졸업요건"은 현재 학적사항 및 연수기간 내 졸업가능 여부를 확인하기 위함입니다. 모든 졸업요건을 충족하고 졸업을 미룬 경우는 졸업상태 "유예"를 선택하세요.</span>
		                                                </label>
		                                                <input type="text" class="rsm_input edu_gd_rq" name="eduHistoryList[0].stu_app_edu_gd_rq" placeholder="1) 미 이수 학점 있을 경우 : 잔여학점 00학점(이수계획 기재) / 2) 그 외 졸업기준 미달성 시 : 졸업기준 학점 이수완료(졸업기준 기재)" autocomplete="off">
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
	                            	</c:if>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addEduHistory" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 경력사항 rsm_career// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_career" id="rsm_career" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">경력사항</h3>
	                            <p class="cGray">최근 경력순으로 입력하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                                <div class="resumeFormWrapper" id="test">
	                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
	                                    <div class="resumeFormWrap">
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">회사명</div>
	                                                <input type="text" class="rsm_input crr_place" name="careerList[0].stu_app_crr_place" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">부서명</div>
	                                                <input type="text" class="rsm_input crr_dept" name="careerList[0].stu_app_crr_dept" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">직급/직책</div>
	                                                <input type="text" class="rsm_input crr_position" name="careerList[0].stu_app_crr_position" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">회사전화번호</div>
	                                                <input type="text" class="rsm_input crr_phone" name="careerList[0].stu_app_crr_phone" placeholder="000-0000-0000" pattern="[0-9]*" value="" autocomplete="off">
	                                            </div>
	                                        </div>
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">입사년월</div>
	                                                <input type="text" class="rsm_input crr_st" id="stu_app_crr_frm_0" name="careerList[0].stu_app_crr_st" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">퇴사년월</div>
	                                                <input type="text" class="rsm_input crr_et" id="stu_app_crr_end_0" name="careerList[0].stu_app_crr_et" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form50">
	                                                <div class="rsm_label">담당업무</div>
	                                                <input type="text" class="rsm_input crr_description" name="careerList[0].stu_app_crr_description" autocomplete="off">
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addCareer" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 교육이수 경력 rsm_learn// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_learn" id="rsm_learn" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">교육이수 경력</h3>
	                            <p class="cGray">최근 경력순으로 입력하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                                <div class="resumeFormWrapper">
	                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
	                                    <div class="resumeFormWrap">
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">교육과정명</div>
	                                                <input type="text" class="rsm_input study_nm" name="studyList[0].stu_app_study_nm" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">시작년월</div>
	                                                <input type="text" class="rsm_input study_st" id="stu_app_study_frm_0" name="studyList[0].stu_app_study_st" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">종료년월</div>
	                                                <input type="text" class="rsm_input study_et" id="stu_app_study_end_0" name="studyList[0].stu_app_study_et" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">교육기관명</div>
	                                                <input type="text" class="rsm_input study_ag" name="studyList[0].stu_app_study_ag" autocomplete="off">
	                                            </div>
	                                        </div>
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form100">
	                                                <label for="loadAdress" class="rsm_label">
	                                                    <span>교육이수내용</span>
	                                                </label>
	                                                <input type="text" class="rsm_input study_detail" name="studyList[0].stu_app_study_detail" autocomplete="off">
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addStudy" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 언어능력 rsm_language// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_language" id="rsm_language" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">언어능력</h3>
	                            <p class="cGray">최근 취득일자순으로 입력하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                            	<c:if test="${not empty data.languageList }">
	                            		<c:forEach var="lang" items="${data.languageList }" varStatus="status">
	                            			<div class="resumeFormWrapper necessary">
			                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
			                                    <div class="resumeFormWrap">
			                                        <div class="resumeForm row d-flex">
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">시험명</div>
			                                                <select class="rsm_selectBox lang_test_nm" name="languageList[${status.count-1 }].stu_app_lang_test_nm">
			                                                    <option value="" selected="selected">선택</option>
			                                                    <option selectcode value="B2902"></option>
			                                                    <option selectcode value="B2903"></option>
			                                                    <option selectcode value="B2904"></option>
			                                                    <option selectcode value="B2905"></option>
			                                                    <option selectcode value="B2906"></option>
			                                                </select>
			                                            </div>
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">점수/등급</div>
			                                                <input type="text" class="rsm_input lang_grade" name="languageList[${status.count-1 }].stu_app_lang_grade" value="${lang.stu_app_lang_grade }" autocomplete="off">
			                                            </div>
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">발급기관</div>
			                                                <input type="text" class="rsm_input lang_ag" name="languageList[${status.count-1 }].stu_app_lang_ag" value="${lang.stu_app_lang_ag }" autocomplete="off">
			                                            </div>
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">취득일자</div>
			                                                <input type="text" class="rsm_input lang_obtain_dt" id="stu_app_lang_dt_${status.count-1 }" name="languageList[${status.count-1 }].stu_app_lang_obtain_dt" value="${lang.stu_app_lang_obtain_dt }" autocomplete="off">
			                                            </div>
			                                            <div class="resumeForm_text form20">
			                                                <div class="rsm_label">비고</div>
			                                                <input type="text" class="rsm_input lang_note" name="languageList[${status.count-1 }].stu_app_lang_note" value="${lang.stu_app_lang_note }" autocomplete="off">
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
	                            		</c:forEach>
	                            	</c:if>
	                            	<c:if test="${empty data.languageList }">
	                            		<div class="resumeFormWrapper">
		                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
		                                    <div class="resumeFormWrap">
		                                        <div class="resumeForm row d-flex">
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">시험명</div>
		                                                <select class="rsm_selectBox lang_test_nm" name="languageList[0].stu_app_lang_test_nm">
		                                                    <option value="" selected="selected">선택</option>
		                                                    <option selectcode value="B2902"></option>
		                                                    <option selectcode value="B2903"></option>
		                                                    <option selectcode value="B2904"></option>
		                                                    <option selectcode value="B2905"></option>
		                                                    <option selectcode value="B2906"></option>
		                                                </select>
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">점수/등급</div>
		                                                <input type="text" class="rsm_input lang_grade" name="languageList[0].stu_app_lang_grade" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">발급기관</div>
		                                                <input type="text" class="rsm_input lang_ag" name="languageList[0].stu_app_lang_ag" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">취득일자</div>
		                                                <input type="text" class="rsm_input lang_obtain_dt" id="stu_app_lang_dt_0" name="languageList[0].stu_app_lang_obtain_dt" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form20">
		                                                <div class="rsm_label">비고</div>
		                                                <input type="text" class="rsm_input lang_note" name="languageList[0].stu_app_lang_note"  autocomplete="off">
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
	                            	</c:if>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addLang" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 자격증 rsm_certificate// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_certificate" id="rsm_certificate" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">자격증</h3>
	                            <p class="cGray">최근 취득일자순으로 입력하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                            	<c:if test="${not empty data.licenseList }">
	                            		<c:forEach var="license" items="${data.licenseList }" varStatus="status">
		                            		<div class="resumeFormWrapper necessary">
			                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
			                                    <div class="resumeFormWrap">
			                                        <div class="resumeForm row d-flex">
			                                            <div class="resumeForm_text form25">
			                                                <div class="rsm_label">자격증명</div>
			                                                <select class="rsm_selectBox license_nm" name="licenseList[${status.count-1 }].stu_app_license_nm">
			                                                    <option value="" selected="selected">선택</option>
			                                                    <option selectcode value="B2900"></option>
			                                                    <option selectcode value="B2901"></option>
			                                                    <option selectcode value="B2906"></option>
			                                                </select>
			                                            </div>
			                                            <div class="resumeForm_text form25">
			                                                <div class="rsm_label">발급기관</div>
			                                                <input type="text" class="rsm_input license_ag" name="licenseList[${status.count-1 }].stu_app_license_ag" value="${license.stu_app_license_ag }" autocomplete="off">
			                                            </div>
			                                            <div class="resumeForm_text form25">
			                                                <div class="rsm_label">취득일자</div>
			                                                <input type="text" class="rsm_input license_obtain_dt" id="stu_app_license_dt_${status.count-1 }" name="licenseList[${status.count-1 }].stu_app_license_obtain_dt" value="${license.stu_app_license_obtain_dt }" autocomplete="off">
			                                            </div>
			                                            <div class="resumeForm_text form25">
			                                                <div class="rsm_label">비고</div>
			                                                <input type="text" class="rsm_input license_note" name="licenseList[${status.count-1 }].stu_app_license_note" value="${license.stu_app_license_note }" autocomplete="off">
			                                            </div>
			                                        </div>
			                                    </div>
			                                </div>
			                        	</c:forEach>
	                            	</c:if>
									<c:if test="${empty data.licenseList }">
										<div class="resumeFormWrapper">
		                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
		                                    <div class="resumeFormWrap">
		                                        <div class="resumeForm row d-flex">
		                                            <div class="resumeForm_text form25">
		                                                <div class="rsm_label">자격증명</div>
		                                                <select class="rsm_selectBox license_nm" name="licenseList[0].stu_app_license_nm">
		                                                    <option value="" selected="selected">선택</option>
		                                                    <option selectcode value="B2900"></option>
		                                                    <option selectcode value="B2901"></option>
		                                                    <option selectcode value="B2906"></option>
		                                                </select>
		                                            </div>
		                                            <div class="resumeForm_text form25">
		                                                <div class="rsm_label">발급기관</div>
		                                                <input type="text" class="rsm_input license_ag" name="licenseList[0].stu_app_license_ag" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form25">
		                                                <div class="rsm_label">취득일자</div>
		                                                <input type="text" class="rsm_input license_obtain_dt" id="stu_app_license_dt_0" name="licenseList[0].stu_app_license_obtain_dt" autocomplete="off">
		                                            </div>
		                                            <div class="resumeForm_text form25">
		                                                <div class="rsm_label">비고</div>
		                                                <input type="text" class="rsm_input license_note" name="licenseList[0].stu_app_license_note" autocomplete="off">
		                                            </div>
		                                        </div>
		                                    </div>
		                                </div>
	                            	</c:if>
	                                
	                                
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addLicense" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 본 과정 응시 여부 rsm_participation// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_participation" id="rsm_participation" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">본 과정 응시 여부</h3>
	                            <p class="cGray">본 과정 응시여부를 선택하세요. (SMART Cloud IT마스터 포함) </p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                                <div class="resumeFormWrapper">
	                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
	                                    <div class="resumeFormWrap">
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form33">
	                                                <div class="rsm_label">과정응시여부<strong class="cRed">＊</strong></div>
	                                                <div class="rsm_input d-flex">
	                                                    <label for="participation1" class="rsm_radio">
	                                                		<input type="radio" class="ses_ck" name="sesList[0].stu_app_ses_ck" value="B0700" onchange="ses_ck_change(this)" id="participation1">
	<%--                                                 		<code value="B0700"></code> --%>있다
	                                                	</label>
	                                                	<label for="participation2" class="rsm_radio">
		                                                	<input type="radio" class="ses_ck" name="sesList[0].stu_app_ses_ck" value="B0701" onchange="ses_ck_change(this)" id="participation2">
	<%--     	                                            	<code value="B0701"></code> --%>없다
	                                                    </label>
	                                                 </div>
	                                            </div>
	                                            <div class="resumeForm_text form33">
	                                                <div class="rsm_label">지원년월<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input ses_dt" id="stu_app_ses_dt_0" name="sesList[0].stu_app_ses_apply_dt"autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form33">
	                                                <div class="rsm_label">선발전형결과<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input ses_rt" name="sesList[0].stu_app_ses_apply_rt" placeholder="합격/불합격" autocomplete="off">
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addSes" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- K-MOVE스쿨 참여여부 rsm_kmove// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_kmove" id="rsm_kmove" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">K-MOVE스쿨 참여여부</h3>
	                            <p class="cGray">한국산업인력공단의 해외취업 연수과정 참여여부를 선택하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                                <div class="resumeFormWrapper">
	                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
	                                    <div class="resumeFormWrap">
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">과정참여여부<strong class="cRed">＊</strong></div>
	                                                <div class="rsm_input d-flex">
	                                                	<label for="kmove1" class="rsm_radio">
	                                                    	<input type="radio" class="kmove_ck" name="kmoveList[0].stu_app_kmove_ck" value="B0900" onchange="kmove_ck_change(this)" id="kmove1">
	<%--                                                     	<code value="B0900"></code> --%>있다
	                                                    </label>
	                                                    <label for="kmove2" class="rsm_radio">
		                                                    <input type="radio" class="kmove_ck" name="kmoveList[0].stu_app_kmove_ck" value="B0901" onchange="kmove_ck_change(this)" id="kmove2">
	<%--     	                                                <code value="B0901"></code> --%>없다
	                                                    </label>
	                                                </div>
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">과정명<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input kmove_nm" name="kmoveList[0].stu_app_kmove_nm" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">운영기관<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input kmove_ag" name="kmoveList[0].stu_app_kmove_ag" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">시작년월<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input kmove_st" id="stu_app_kmove_frm" name="kmoveList[0].stu_app_kmove_st" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">종료년월<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input kmove_et" id="stu_app_kmove_end" name="kmoveList[0].stu_app_kmove_et" autocomplete="off">
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addKmove" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 해외체류 경험 rsm_experience// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_experience" id="rsm_experience" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">해외체류 경험</h3>
	                            <p class="cGray">과거 해외연수 경험여부를 선택하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                                <div class="resumeFormWrapper">
	                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
	                                    <div class="resumeFormWrap">
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">해외연수 경험 여부<strong class="cRed">＊</strong></div>
	                                                <div class="rsm_input d-flex">
	                                                    <label for="experience1" class="rsm_radio">
	                                                    	<input type="radio" class="overseas_ck" name="overseasList[0].stu_app_overseas_ck" value="B0800" onchange="overseas_ck_change(this)" id="experience1">
	<%-- 														<code value="B0800"></code> --%>있다
														</label>
	                                                    <label for="experience2" class="rsm_radio">
		                                                    <input type="radio" class="overseas_ck" name="overseasList[0].stu_app_overseas_ck" value="B0801" onchange="overseas_ck_change(this)" id="experience2">
	<%--     	                                                <code value="B0801"></code> --%>없다
	                                                    </label> 
	                                                </div>
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">국가명<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input overseas_nm" name="overseasList[0].stu_app_overseas_nm" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">시작년월<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input overseas_st" id="stu_app_overseas_frm_0" name="overseasList[0].stu_app_overseas_st" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">종료년월<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input overseas_et" id="stu_app_overseas_end_0" name="overseasList[0].stu_app_overseas_et" autocomplete="off">
	                                            </div>
	                                            <div class="resumeForm_text form20">
	                                                <div class="rsm_label">목적<strong class="cRed">＊</strong></div>
	                                                <input type="text" class="rsm_input overseas_purpose" name="overseasList[0].stu_app_overseas_purpose" autocomplete="off">
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addOverseas" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 자기소개서 rsm_introduction// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_introduction" id="rsm_introduction" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">자기소개서</h3>
	                            <p class="cGray">지원동기, 성장과정, 성격, 가치관 및 특이사항 등을 자유롭게 기술하세요.</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                                <div class="resumeFormWrapper">
	                                    <div class="resumeForm_delBtn img-icon times-circle"></div>
	                                    <div class="resumeFormWrap">
	                                        <div class="resumeForm row">
	                                            <div class="resumeForm_text form100">
	                                                <input type="text" class="rsm_input introduce_title" name="introduceList[0].stu_app_introduce_title" placeholder="제목입력" autocomplete="off">
	                                            </div>
	                                        </div>
	                                        <div class="resumeForm row">
	                                            <textarea class="rsm_textarea introduce_detail" name="introduceList[0].stu_app_introduce_detail" placeholder="내용입력" rows="8" cols="80"></textarea>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="resumeForm_addBtn d-flex addIntroduce" id="formAddBtn">
	                                <div class="img-icon plus-circle-navy"></div><span class="h4">항목 추가</span>
	                            </div>
	                        </div>
	                    </div>
	
	                    <!-- 증빙자료 업로드 rsm_evidence// id는 우측 스크롤 고정 Nav에서 항목 클릭시 바로가기로 활용됩니다 -->
	                    <div class="resumeWrap rsm_evidence" id="rsm_evidence" name="matchLink">
	                        <div class="resumeTitle d-flex">
	                            <h3 class="h3">증빙자료 업로드</h3>
	                            <p class="cGray">파일명 : 항목_이름(ex : 최종학력증명서_홍길동, 고용보험상실내역확인_홍길동)</p>
	                        </div>
	                        <div class="resumeSection">
	                            <div class="resumeFormContainer">
	                                <div class="resumeFormWrapper necessary">
	                                    <div class="resumeForm_noticeWrap d-flex">
	                                        <div class="resumeForm_notice">
	                                            <ul class="rsm_noticeList">
	                                                <li>
	                                                    <strong>최종학력증명서(필수)</strong>
	                                                </li>
	                                                <li>
	                                                    - 졸업증명서, 학위증명서, 졸업장, 졸업예정증명서(졸업예정일 기재)
	                                                </li>
	                                                <li>
	                                                    - (졸예자, 유예자 중) 상기의 서류가 제출 불가능할 경우(수료증명서 포함)<br>&nbsp; : 학적상태를 증명할 수 있는 서류 제출(졸업요건, 달성상태기재, 학교 직인필수)
	                                                </li>
	                                            </ul>
	                                            <ul class="rsm_noticeList">
	                                                <li>
	                                                    <strong>고용보험 상실내역 확인서(필수)</strong>
	                                                </li>
	                                                <li>
	                                                    - 발급처: 고용보험(www.ei.go.kr) → 로그인 → 개인서비스
	                                                    → 고용보험 가입(상용이력) 이력조회
	                                                </li>
	                                                <li>
	                                                    - 고용보험가입이력이 아예 없는 경우에도 해당화면 캡쳐하여 제출
	                                                </li>
	                                                <li class="cRed">
	                                                    ※ 본인의 이름과 주민번호 앞 6자리, “고용보험조회 내역이 없습니다”라는 문구가 명확히 보이도록 캡쳐해주시기 바랍니다.
	                                                </li>
	                                                <li class="cRed">
	                                                    ※ 고용보험 상실신고가 지연되어 상실내역 확인서 제출이 어려운 경우 :
	                                                    퇴사일이 명기 된 “퇴사증명서”를 제출 하고, 반드시 연수과정 개시 전까지
	                                                    상실처리가 되어야 함(고용보험 상실일 역시 연수과정 개시이전으로 신고)
	                                                </li>
	                                            </ul>
	                                            <ul class="rsm_noticeList">
	                                                <li>
	                                                    <strong>출입국 사실증명서(필수)</strong>
	                                                </li>
	                                                <li>
	                                                    - 출입국 조회기간 : 개강일 기준 1년 전 일자 ~ 현재까지
	                                                </li>
	                                                <li>
	
	                                                    - 발급처 : 민원 24(www.minwon.go.kr) 로그인 → 출입국 기록 신청
	                                                    → 관련정보 입력 후 민원신청하기
	                                                </li>
	                                                <li class="cRed">
	                                                    ※ 출입국 내역이 없어 온라인 조회가 안 되는 경우
	                                                    : 동사무소에서 출입국 사실 증명원 발급
	                                                </li>
	                                                <li class="cRed">
	                                                    ※ 조회기간 내 해외체류기간이 8개월 이상 되는 경우
	                                                    : 방문국가를 확인할 수 있는 별도 증명서류 제출(여권 내 출입국 날인 사본 등)
	                                                </li>
	                                            </ul>
	                                            <ul class="rsm_noticeList">
	                                                <li>
	                                                    <strong>워크넷 직무평가 결과(필수)</strong>
	                                                </li>
	                                                <li>
	                                                    - 발급처: 워크넷(www.work.go.kr) → 로그인 →직업심리검사(성인)
	                                                    → IT직무 기본역량검사를 실시 → 결과조회 → 파일로 저장후 첨부
	                                                </li>
	                                                <li>
	                                                    - zip파일로 압축하여 첨부해주시기 바랍니다.
	                                                </li>
	                                            </ul>
	                                            <!-- <ul class="rsm_noticeList">
	                                                <li>
	                                                    <strong>기타(선택)</strong>
	                                                </li>
	                                                <li>
	                                                    - 일본어 공인자격(JLPT 또는 JPT 등)
	                                                </li>
	                                                <li>
	                                                    - 정보처리기사 또는 산업기사 자격증 사본
	                                                </li>
	                                                <li>
	                                                    - 개인의 경력/교육이수 내용을 확인할 수 있는 자료(포트폴리오 등)
	                                                </li>
	                                                <li>
	                                                    - 그 외(IT관련 자격증 등)
	                                                </li>
	                                            </ul> -->
	                                        </div>
	                                        <div class="resumeForm_ntcBtn img-icon question-circle"></div>
	
	                                    </div>
	                                    <div class="resumeFormWrap">
	                                        <div class="resumeForm row d-flex">
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">최종학력증명서</div>
	                                                <div class="rsm_fileUpload">
	                                                    <span>파일 선택</span>
	                                                    <input type="hidden" name="stu_app_edu_file_origin">
	                                                    <input type="hidden" name="stu_app_edu_file_saved">
	                                                    <input type="file" name="stu_app_edu_file" id="resumeEvidence1" class="resumeEvidence_file">
	                                                </div>
	                                                <input type="text" class="resumeEvidence_url" id="resumeEvidence1_url" readonly placeholder="최종학력증명서_홍길동">
	                                                <a class="fileUrl downEdu">파일 다운로드</a>
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">고용보험 상실내역 확인서</div>
	                                                <div class="rsm_fileUpload">
	                                                    <span>파일 선택</span>
	                                                    <input type="hidden" name="stu_app_isr_file_origin">
	                                                    <input type="hidden" name="stu_app_isr_file_saved">
	                                                    <input type="file" name="stu_app_isr_file" id="resumeEvidence2" class="resumeEvidence_file">
	                                                </div>
	                                                <input type="text" class="resumeEvidence_url" id="resumeEvidence2_url" readonly placeholder="고용보험 상실내역 확인서_홍길동">
	                                                <a class="fileUrl downIsr">파일 다운로드</a>
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">출입국 사실증명서</div>
	                                                <div class="rsm_fileUpload">
	                                                    <span>파일 선택</span>
	                                                    <input type="hidden" name="stu_app_imm_file_origin">
	                                                    <input type="hidden" name="stu_app_imm_file_saved">
	                                                    <input type="file" name="stu_app_imm_file" id="resumeEvidence3" class="resumeEvidence_file">
	                                                </div>
	                                                <input type="text" class="resumeEvidence_url" id="resumeEvidence3_url" readonly placeholder="출입국 사실증명서_홍길동">
	                                                <a class="fileUrl downImm">파일 다운로드</a>
	                                            </div>
	                                            <div class="resumeForm_text form25">
	                                                <div class="rsm_label">워크넷 직무평가 결과</div>
	                                                <div class="rsm_fileUpload">
	                                                    <span>파일 선택</span>
	                                                    <input type="hidden" name="stu_app_worknet_file_origin">
	                                                    <input type="hidden" name="stu_app_worknet_file_saved">
	                                                    <input type="file" name="stu_app_worknet_file" id="resumeEvidence4" class="resumeEvidence_file">
	                                                </div>
	                                                <input type="text" class="resumeEvidence_url" id="resumeEvidence4_url" readonly placeholder="워크넷 직무평가 결과_홍길동">
	                                                <a class="fileUrl downWorknet">파일 다운로드</a>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="resumeMsg cRed"><strong>※ 지원기간 중에는 언제든 수정이 가능합니다.</strong></div>
	<!--                         <input type="submit" class="button resumeBtn h2" value="수정하기"> -->
	                        <div class="button resumeBtn h2">수정하기</div>
	                    </div>
	                </form>
	            </div> <!-- resumeSection 끝 -->
	        </div> <!-- resumeContent 끝 -->
            <div class="resumeAside">
                <nav class="resumeNav">
                    <header class="resumeNav_header">
                        지원신청서 항목
                    </header>
                    <div class="resumeNav_content">
                        <ul class="resumeNav_listWrap">
                            <li class="d-flex">
                                <div class="img-icon graduation-cap"></div>
                                <a class="navTxt" href="#rsm_education">학력사항</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon briefcase"></div>
                                <a class="navTxt" href="#rsm_career">경력사항</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon book-open"></div>
                                <a class="navTxt" href="#rsm_learn">교육이수 경력</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon globe"></div>
                                <a class="navTxt" href="#rsm_language">언어능력</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon file-certificate"></div>
                                <a class="navTxt" href="#rsm_certificate">자격증</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon user-friends"></div>
                                <a class="navTxt" href="#rsm_participation">본 과정 응시여부</a>

                            </li>
                            <li class="d-flex">
                                <div class="img-icon atlas"></div>
                                <a class="navTxt" href="#rsm_kmove">K-MOVE스쿨 참여여부</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon plane"></div>
                                <a class="navTxt" href="#rsm_experience">해외체류경험</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon pen-nib"></div>
                                <a class="navTxt" href="#rsm_introduction">자기소개서</a>
                            </li>
                            <li class="d-flex">
                                <div class="img-icon upload"></div>
                                <a class="navTxt" href="#rsm_evidence">증빙자료 업로드</a>

                            </li>
                        </ul>
                    </div>
                    <div class="resumeNav_button resumeBtn">수정하기</div>
                </nav>
	        </div>
	    </div>
	    <%@include file="../include/common_footer_rainbow.jsp"%>
	</div>
</body>
</html>
