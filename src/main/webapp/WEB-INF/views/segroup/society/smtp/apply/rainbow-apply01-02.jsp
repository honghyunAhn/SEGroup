<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 지원서 보기 -->
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <%@include file="../include/rainbow_head.jsp"%>
    <!-- 기존 레인보우사이트 text/javascript 복사 -->
    <script type="text/javascript">
    $(function() {
			
			//지원신청서 resumeAside_scroll
		    /* $(window).scroll(function(){
				var scr = $(window).scrollTop();
// 				console.log(scr);
				var asideScr = $(this).scrollTop();
				
				if(asideScr > 1500){
					$('.container_rainbow .resumeAside').css({"position" : "absolute", "top" : "auto", "bottom" : "380px"});
				}
				else{
				$('.container_rainbow .resumeAside').css({"position" : "fixed", "top" : "120px", "bottom" : "auto"});
				}
			}); */
			
			//사진 다운로드
			$('.imgHere').click(function(){
 				location.href = "/file_download?origin=${apply.stu_app_photo_origin }&saved=${apply.stu_app_photo_saved }&path=stu/apply/photo/${apply.user_id}_${apply.gisu_id }";
			});
			
			//성별 세팅
    		if("${apply.stu_app_gender }" == 'A0001'){
    			$('#stu_app_gender').text('여성');
    		}else{
    			$('#stu_app_gender').text('남성');
    		}
    		
    		//병역 사항 세팅
    		var mt_ckeck = "${apply.stu_app_mt_ck}";
    		
    		switch(mt_ckeck){
    		case "B0600":
    			$('input[name="stu_app_mt_ck"]:radio[value="B0600"]').prop('checked', true);
    			break;
    		case "B0601":
    			$('input[name="stu_app_mt_ck"]:radio[value="B0601"]').prop('checked', true);
    			break;
    		case "B0603":
    			$('input[name="stu_app_mt_ck"]:radio[value="B0603"]').prop('checked', true);
    			break;
    		case "B0602":
    			$('input[name=stu_app_mt_ck]:radio[value="B0602"]').prop('checked', true);
    			$('input[name=stu_app_mt_etc]').val("${apply.stu_app_mt_etc }");
    			break;
    		}
    		
    		//수정하기 버튼 : 지원기간 이내이면서 지원결과가 나오지 않았을 때만 보여준다.
			var end_date = "${app_end_date}";
			var now = getToday();
			function getToday() {
				var date = new Date();
				return date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
			}
			
			$.ajax({
				contentType : "application/json",
				dataType : "json",
				type	: "post",
				url		: "/smtp/apply/checkApplyState",
				data    : "${apply.gisu_id}",
				success	: function(data) {
					
					// 지원기간 이내이면서 지원결과가 나오지 않은 경우에만 수정버튼을 보여준다.
					if(now <= end_date && data == "1") {
						var str = '<div class="resumeMsg">※ 지원기간 중에는 언제든 수정이 가능합니다.</div>';
						str += '<div class="btn_normal resumeBtn">수정하기</div>';
						
						var up = '<div class="resumeNav_button resumeBtn">수정하기</div>'
						$('#modifyBtn').html(str);
						$('#updateBtn').html(up)
					}else{
					}
					
					// 수정 버튼에 이벤트 연결
		    	    $('.resumeBtn').click(function() {
		    	    	var crc_id = "${apply.crc_id}";
		        		var gisu_id = "${apply.gisu_id}";
		    	    	location.href = '<c:url value="/smtp/apply/rainbow-apply01-03?gisu_id=' + gisu_id + '&app_end_date=' + end_date +'" />';
		    	    });
				}
			});
		
		}); // <----ready Fn 끝
    </script>
</head>

<body>
    <div class="container_rainbow container-apply bgc_eee">
        <!-- rainbow_header -->
        <%@include file="../include/rainbow_header.jsp"%>
        <div class="content course-apply course-point06" id="main">
            <!-- ● 08/27  <div class="course-applyContainer d-flex"> 클래스 apply01-02 추가 -->
            <div class="course-applyContainer d-flex apply01-02">
                <div class="resumeSection">
                    <form action="/smtp/apply/update" name="resume" method="post" onsubmit="return formCheck();"
                        enctype="multipart/form-data">

                        <!-- ● 08/26 <div class="resumeHeader"> 추가  -->
                        <div class="resumeHeader">
                            <h2 class="h2">${apply.gisu_nm} 지원서</h2>
                            <div class="resumeMsg">
                                <strong class="cRed">＊</strong>가 표기된 항목은
                                <strong class="cRed">필수 입력항목</strong>입니다.
                            </div>
                        </div>

                        <!-- 기본정보 rsm_profile -->
                        <div class="resumeWrap rsm_profile">
                            <div class="resumeTitle d-flex">
                                <h3 class="h3">기본정보</h3>
                            </div>
                            <div class="resumeSection d-flex">
                                <div class="resumePhotoWrap">
                                    <div class="imgBox">
                                        <!-- <div class="imgGuide"></div> -->
                                        <div class="imgHere">
                                            <img class="stu_photo_img" alt=""
                                                src='<c:url value="/stu/apply/photo/${apply.user_id}_${apply.gisu_id }/${apply.stu_app_photo_saved }" />'>
                                        </div>
                                    </div>
                                    <!-- <%-- <a href="/file_download?origin=${apply.stu_app_photo_origin }&saved=${apply.stu_app_photo_saved }&path=stu/apply/photo/${apply.user_id}_${apply.gisu_id }">
                                        ${apply.stu_app_photo_origin }
                                    </a> --%> -->
                                </div>
                                <div class="resumeFormWrap">
                                    <div class="resumeForm row d-flex">
                                        <div class="resumeForm_text resumeForm_load form33">
                                            <div class="rsm_label">성명<strong class="cRed">＊</strong></div>
                                            <div class="rsm_input" id="stu_app_nm">${apply.stu_app_nm }</div>
                                        </div>
                                        <div class="resumeForm_text resumeForm_load form33">
                                            <div class="rsm_label">생년월일<strong class="cRed">＊</strong></div>
                                            <div class="rsm_input" id="stu_app_birth">${apply.stu_app_birth }</div>
                                        </div>
                                        <div class="resumeForm_text resumeForm_load form33">
                                            <div class="rsm_label">성별<strong class="cRed">＊</strong></div>
                                            <div class="rsm_input" id="stu_app_gender">
                                                <!-- <%-- <code value="${apply.stu_app_gender }"></code> --%> -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="resumeForm row d-flex">
                                        <div class="resumeForm_text form100">
                                            <div class="rsm_label">병역<strong class="cRed">＊</strong></div>
                                            <!-- ● 08/27 <div class="rsm_input d-flex"> 클래스 flexWrap 추가 -->
                                            <div class="rsm_input d-flex flexWrap">
                                                <label for="militaryService_01" class="rsm_radio">
                                                    <input type="radio" name="stu_app_mt_ck" value="B0600"
                                                        ng-model="stuApply.stu_app_mt_ck" id="militaryService_01"
                                                        onclick="return(false);"> 군필
                                                    <!-- <%-- <code value="B0600"></code> --%> -->
                                                </label>
                                                <label for="militaryService_02" class="rsm_radio">
                                                    <input type="radio" name="stu_app_mt_ck" value="B0601"
                                                        ng-model="stuApply.stu_app_mt_ck" id="militaryService_02"
                                                        onclick="return(false);"> 미필
                                                    <!-- <%-- <code value="B0601"></code> --%> -->
                                                </label>
                                                <label for="militaryService_03" class="rsm_radio">
                                                    <input type="radio" name="stu_app_mt_ck" value="B0603"
                                                        ng-model="stuApply.stu_app_mt_ck" id="militaryService_03"
                                                        onclick="return(false);"> 미대상(여성)
                                                    <!-- <%-- <code value="B0603"></code> --%> -->
                                                </label>
                                                <label for="militaryService_04" class="rsm_radio">
                                                    <input type="radio" name="stu_app_mt_ck" value="B0602"
                                                        ng-model="stuApply.stu_app_mt_ck" id="militaryService_04"
                                                        onclick="return(false);"> 면제
                                                    <!-- <%-- <code value="B0602"></code> --%> -->
                                                    <input type="text" class="rsm_input" name="stu_app_mt_etc"
                                                        id="militaryService_05"
                                                        ng-class="{'disabled' : stuApply.stu_app_mt_ck!='B0602'}"
                                                        maxlength="30" placeholder="면제사유 30자 이내로 서술하세요.">
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="resumeForm row d-flex">
                                        <div class="resumeForm_text form100 rsmForm_address d-flex justify_between">
                                            <div class="rsm_txt">
                                                <label for="loadAddress" class="rsm_label">주소<strong
                                                        class="cRed">＊</strong>
                                                </label>
                                                <div class="rsmForm_addressDiv d-flex justify_between">
                                                    <input type="text" class="rsm_input loadAddress" id="zipcode"
                                                        name="stu_app_zipcode" value="${apply.stu_app_zipcode }"
                                                        readonly>
                                                    <input type="text" class="rsm_input loadAddress" id="address"
                                                        name="stu_app_addr" value="${apply.stu_app_addr }" readonly>
                                                    <input type="text" class="rsm_input " id="addressDetail"
                                                        name="stu_app_addr_detail" value="${apply.stu_app_addr_detail }"
                                                        readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="resumeForm row d-flex">
                                        <div class="resumeForm_text form33">
                                            <label for="" class="rsm_label">휴대전화<strong class="cRed">＊</strong></label>
                                            <input type="text" class="rsm_input" name="stu_app_phone"
                                                value="${apply.stu_app_phone }" readonly>
                                        </div>
                                        <div class="resumeForm_text form33">
                                            <label for="" class="rsm_label">비상연락처</label>
                                            <input type="text" class="rsm_input" name="stu_app_em_phone"
                                                value="${apply.stu_app_em_phone }" readonly>
                                        </div>
                                        <div class="resumeForm_text form33">
                                            <div class="rsm_label">이메일<strong class="cRed">＊</strong></div>
                                            <input type="text" class="rsm_input" name="stu_app_email"
                                                value="${apply.stu_app_email }" readonly>
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
                                    <c:forEach var="edu" items="${apply.eduHistoryList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">학교명<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input edu_sc_nm"
                                                            value="${edu.stu_app_edu_sc_nm }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">전공계열<strong class="cRed">＊</strong></div>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2800'}">
                                                            <input type="text" class="rsm_input edu_field"
                                                                value="컴퓨터공학과" readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2801'}">
                                                            <input type="text" class="rsm_input edu_field"
                                                                value="컴퓨터관련학과" readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2802'}">
                                                            <input type="text" class="rsm_input edu_field"
                                                                value="일어관련학과" readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2803'}">
                                                            <input type="text" class="rsm_input edu_field" value="어문학"
                                                                readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2804'}">
                                                            <input type="text" class="rsm_input edu_field" value="인문학"
                                                                readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2805'}">
                                                            <input type="text" class="rsm_input edu_field" value="자연계열"
                                                                readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2806'}">
                                                            <input type="text" class="rsm_input edu_field" value="공학"
                                                                readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_field eq 'B2807'}">
                                                            <input type="text" class="rsm_input edu_field" value="기타"
                                                                readonly>
                                                        </c:if>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">전공<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input edu_major"
                                                            value="${edu.stu_app_edu_major }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">졸업상태<strong class="cRed">＊</strong></div>
                                                        <c:if test="${edu.stu_app_edu_gd_ck eq 'B1000'}">
                                                            <input type="text" class="rsm_input edu_gd_ck" value="졸업"
                                                                readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_gd_ck eq 'B1001'}">
                                                            <input type="text" class="rsm_input edu_gd_ck" value="예정"
                                                                readonly>
                                                        </c:if>
                                                        <c:if test="${edu.stu_app_edu_gd_ck eq 'B1002'}">
                                                            <input type="text" class="rsm_input edu_gd_ck" value="유예"
                                                                readonly>
                                                        </c:if>
                                                        <!-- <option selectcode value="B1000">졸업</option> -->
                                                        <!-- <option selectcode value="B1001">예정</option> -->
                                                        <!-- <option selectcode value="B1002">유예</option> -->
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">졸업년월<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input edu_gd_dt"
                                                            value="${edu.stu_app_edu_gd_dt }" readonly>
                                                    </div>
                                                </div>
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">소재지<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input edu_sc_lo"
                                                            value="${edu.stu_app_edu_sc_lo }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form80">
                                                        <label for="loadAdress"
                                                            class="rsm_label d-flex justify_between">
                                                            <span>졸업요건</span>
                                                        </label>
                                                        <input type="text" class="rsm_input edu_gd_rq"
                                                            value="${edu.stu_app_edu_gd_rq }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="career" items="${apply.careerList }">
                                        <div class="resumeFormWrapper necessary" id="test">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">회사명</div>
                                                        <input type="text" class="rsm_input crr_place"
                                                            value="${career.stu_app_crr_place }">
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">부서명</div>
                                                        <input type="text" class="rsm_input crr_dept"
                                                            value="${career.stu_app_crr_dept }">
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">직급/직책</div>
                                                        <input type="text" class="rsm_input crr_position"
                                                            value="${career.stu_app_crr_position }">
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">회사전화번호</div>
                                                        <input type="text" class="rsm_input crr_phone"
                                                            value="${career.stu_app_crr_phone }">
                                                    </div>
                                                </div>
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">입사년월</div>
                                                        <input type="text" class="rsm_input crr_st"
                                                            value="${career.stu_app_crr_st }">
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">퇴사년월</div>
                                                        <input type="text" class="rsm_input crr_et"
                                                            value="${career.stu_app_crr_et }">
                                                    </div>
                                                    <div class="resumeForm_text form50">
                                                        <div class="rsm_label">담당업무</div>
                                                        <input type="text" class="rsm_input crr_description"
                                                            value="${career.stu_app_crr_description }">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="study" items="${apply.studyList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">교육과정명</div>
                                                        <input type="text" class="rsm_input study_nm"
                                                            value="${study.stu_app_study_nm }">
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">시작년월</div>
                                                        <input type="text" class="rsm_input study_st"
                                                            value="${study.stu_app_study_st }">
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">종료년월</div>
                                                        <input type="text" class="rsm_input study_et"
                                                            value="${study.stu_app_study_et }">
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">교육기관명</div>
                                                        <input type="text" class="rsm_input study_ag"
                                                            value="${study.stu_app_study_ag }">
                                                    </div>
                                                </div>
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form100">
                                                        <label for="loadAdress" class="rsm_label">
                                                            <span>교육이수내용</span>
                                                        </label>
                                                        <input type="text" class="rsm_input study_detail"
                                                            value="${study.stu_app_study_detail }">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="lang" items="${apply.languageList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">시험명</div>
                                                        <c:if test="${lang.stu_app_lang_test_nm eq 'B2902'}">
                                                            <input type="text" class="rsm_input lagn_test_nm"
                                                                value="JLPT1급" readonly>
                                                        </c:if>
                                                        <c:if test="${lang.stu_app_lang_test_nm eq 'B2903'}">
                                                            <input type="text" class="rsm_input lagn_test_nm"
                                                                value="JLPT2급" readonly>
                                                        </c:if>
                                                        <c:if test="${lang.stu_app_lang_test_nm eq 'B2904'}">
                                                            <input type="text" class="rsm_input lagn_test_nm"
                                                                value="JPT" readonly>
                                                        </c:if>
                                                        <c:if test="${lang.stu_app_lang_test_nm eq 'B2905'}">
                                                            <input type="text" class="rsm_input lagn_test_nm"
                                                                value="TOEIC" readonly>
                                                        </c:if>
                                                        <c:if test="${lang.stu_app_lang_test_nm eq 'B2906'}">
                                                            <input type="text" class="rsm_input lagn_test_nm"
                                                                value="기타(비고란에 기재)" readonly>
                                                        </c:if>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">점수/등급</div>
                                                        <input type="text" class="rsm_input lang_grade"
                                                            value="${lang.stu_app_lang_grade }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">발급기관</div>
                                                        <input type="text" class="rsm_input lang_ag"
                                                            value="${lang.stu_app_lang_ag }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">취득일자</div>
                                                        <input type="text" class="rsm_input lang_obtain_dt"
                                                            value="${lang.stu_app_lang_obtain_dt }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">비고</div>
                                                        <input type="text" class="rsm_input lang_nm"
                                                            value="${lang.stu_app_lang_note }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="license" items="${apply.licenseList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">자격증명</div>
                                                        <c:if test="${license.stu_app_license_nm eq 'B2900' }">
                                                            <input type="text" class="rsm_input license_nm"
                                                                value="정보처리기사" readonly>
                                                        </c:if>
                                                        <c:if test="${license.stu_app_license_nm eq 'B2901' }">
                                                            <input type="text" class="rsm_input license_nm"
                                                                value="정보처리산업기사" readonly>
                                                        </c:if>
                                                        <c:if test="${license.stu_app_license_nm eq 'B2906'}">
                                                            <input type="text" class="rsm_input license_nm"
                                                                value="기타(비고란에 기재)" readonly>
                                                        </c:if>
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">발급기관</div>
                                                        <input type="text" class="rsm_input license_ag"
                                                            value="${license.stu_app_license_ag }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">취득일자</div>
                                                        <input type="text" class="rsm_input license_obtain_dt"
                                                            value="${license.stu_app_license_obtain_dt }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form25">
                                                        <div class="rsm_label">비고</div>
                                                        <input type="text" class="rsm_input license_note"
                                                            value="${license.stu_app_license_note }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="ses" items="${apply.sesList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form33">
                                                        <div class="rsm_label">과정응시여부<strong class="cRed">＊</strong>
                                                        </div>
                                                        <div class="rsm_input d-flex">
                                                            <c:if test="${ses.stu_app_ses_ck eq 'B0700' }">
                                                                <label for="participation1" class="rsm_radio">
                                                                    <input type="radio" class="ses_ck" value="B0700"
                                                                        checked onclick="return(false);">
                                                                    <!-- <%-- <code value="B0700"></code> --%> -->
                                                                    있다${apply.stu_app_ses_ck}
                                                                </label>
                                                                <label for="participation2" class="rsm_radio">
                                                                    <input type="radio" class="ses_ck" value="B0701"
                                                                        onclick="return(false);">
                                                                    <!-- <%-- <code value="B0701"></code> --%> -->
                                                                    없다
                                                                </label>
                                                            </c:if>
                                                            <c:if test="${ses.stu_app_ses_ck eq 'B0701' }">
                                                                <label for="participation1" class="rsm_radio">
                                                                    <input type="radio" class="ses_ck" value="B0700"
                                                                        onclick="return(false);">
                                                                    <code value="B0700"></code>있다
                                                                </label>
                                                                <label for="participation2" class="rsm_radio">
                                                                    <input type="radio" class="ses_ck" value="B0701"
                                                                        checked onclick="return(false);">
                                                                    <code value="B0701"></code>없다${apply.stu_app_ses_ck
                                                                    }
                                                                </label>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="resumeForm_text form33">
                                                        <div class="rsm_label">지원년월<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input ses_dt"
                                                            value="${ses.stu_app_ses_apply_dt }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form33">
                                                        <div class="rsm_label">선발전형결과<strong class="cRed">＊</strong>
                                                        </div>
                                                        <input type="text" class="rsm_input ses_rt"
                                                            value="${ses.stu_app_ses_apply_rt }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="kmove" items="${apply.kmoveList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">과정참여여부<strong class="cRed">＊</strong>
                                                        </div>
                                                        <div class="rsm_input d-flex">
                                                            <c:if test="${kmove.stu_app_kmove_ck eq 'B0900' }">
                                                                <label for="kmove1" class="rsm_radio">
                                                                    <input type="radio" class="kmove_ck" value="B0900"
                                                                        checked onclick="return(false);">
                                                                    <!-- <%-- <code value="B0900"></code> --%> -->
                                                                    있다
                                                                </label>
                                                                <label for="kmove2" class="rsm_radio">
                                                                    <input type="radio" class="kmove_ck" value="B0901"
                                                                        onclick="return(false);">
                                                                    <!-- <%-- <code value="B0901"></code> --%> -->
                                                                    없다
                                                                </label>
                                                            </c:if>
                                                            <c:if test="${kmove.stu_app_kmove_ck eq 'B0901' }">
                                                                <label for="kmove1" class="rsm_radio">
                                                                    <input type="radio" class="kmove_ck" value="B0900"
                                                                        onclick="return(false);">
                                                                    <!-- <%-- <code value="B0900"></code> --%> -->
                                                                    있다
                                                                </label>
                                                                <label for="kmove2" class="rsm_radio">
                                                                    <input type="radio" class="kmove_ck" value="B0901"
                                                                        checked onclick="return(false);">
                                                                    <!-- <%-- <code value="B0901"></code> --%> -->
                                                                    없다
                                                                </label>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">과정명<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input kmove_nm"
                                                            value="${kmove.stu_app_kmove_nm }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">운영기관<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input kmove_ag"
                                                            value="${kmove.stu_app_kmove_ag }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">시작년월<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input kmove_st"
                                                            value="${kmove.stu_app_kmove_st }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">종료년월<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input kmove_et"
                                                            value="${kmove.stu_app_kmove_et }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="overseas" items="${apply.overseasList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row d-flex">
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">해외연수 경험 여부<strong class="cRed">＊</strong>
                                                        </div>
                                                        <div class="rsm_input d-flex">
                                                            <c:if test="${overseas.stu_app_overseas_ck eq 'B0800'}">
                                                                <label for="experience1" class="rsm_radio">
                                                                    <input type="radio" class="overseas_ck"
                                                                        value="B0800" checked onclick="return(false);">
                                                                    <!-- <%-- <code value="B0800"></code> --%> -->
                                                                    있다
                                                                </label>
                                                                <label for="experience2" class="rsm_radio">
                                                                    <input type="radio" class="overseas_ck"
                                                                        value="B0801" onclick="return(false);">
                                                                    <!-- <%-- <code value="B0801"></code> --%> -->
                                                                    없다
                                                                </label>
                                                            </c:if>
                                                            <c:if test="${overseas.stu_app_overseas_ck eq 'B0801'}">
                                                                <label for="experience1" class="rsm_radio">
                                                                    <input type="radio" class="overseas_ck"
                                                                        value="B0800" onclick="return(false);">
                                                                    <!-- <%-- <code value="B0800"></code> --%> -->
                                                                    있다
                                                                </label>
                                                                <label for="experience2" class="rsm_radio">
                                                                    <input type="radio" class="overseas_ck"
                                                                        value="B0801" checked onclick="return(false);">
                                                                    <!-- <%-- <code value="B0801"></code> --%> -->
                                                                    없다
                                                                </label>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">국가명<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input overseas_nm"
                                                            value="${overseas.stu_app_overseas_nm }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">시작년월<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input overseas_st"
                                                            value="${overseas.stu_app_overseas_st }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">종료년월<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input overseas_et"
                                                            value="${overseas.stu_app_overseas_et }" readonly>
                                                    </div>
                                                    <div class="resumeForm_text form20">
                                                        <div class="rsm_label">목적<strong class="cRed">＊</strong></div>
                                                        <input type="text" class="rsm_input overseas_purpose"
                                                            value="${overseas.stu_app_overseas_purpose }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                    <c:forEach var="introduce" items="${apply.introduceList }">
                                        <div class="resumeFormWrapper necessary">
                                            <div class="resumeFormWrap">
                                                <div class="resumeForm row">
                                                    <div class="resumeForm_text form100">
                                                        <input type="text" class="rsm_input introduce_title"
                                                            value="${introduce.stu_app_introduce_title }" readonly>
                                                    </div>
                                                </div>
                                                <div class="resumeForm row">
                                                    <textarea class="rsm_textarea introduce_detail" rows="10"
                                                        readonly>${introduce.stu_app_introduce_detail }</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                        <div class="resumeFormWrap">
                                            <div class="resumeForm row d-flex">
                                                <div class="resumeForm_text form25">
                                                    <div class="rsm_label">최종학력증명서</div>
                                                    <input type="hidden" name="stu_app_edu_file_origin"
                                                        value="${apply.stu_app_edu_file_origin }">
                                                    <input type="hidden" name="stu_app_edu_file_saved"
                                                        value="${apply.stu_app_edu_file_saved }">
                                                    <a
                                                        href="/file_download?origin=${apply.stu_app_edu_file_origin }&saved=${apply.stu_app_edu_file_saved }&path=stu/apply/edu_history/${apply.user_id}_${apply.gisu_id }">
                                                        ${apply.stu_app_edu_file_origin }
                                                    </a>
                                                </div>
                                                <div class="resumeForm_text form25">
                                                    <div class="rsm_label">고용보험 상실내역 확인서</div>
                                                    <input type="hidden" name="stu_app_isr_file_origin"
                                                        value="${apply.stu_app_isr_file_origin }">
                                                    <input type="hidden" name="stu_app_isr_file_saved"
                                                        value="${apply.stu_app_isr_file_saved }">
                                                    <a
                                                        href="/file_download?origin=${apply.stu_app_isr_file_origin }&saved=${apply.stu_app_isr_file_saved }&path=stu/apply/insurance/${apply.user_id}_${apply.gisu_id }">
                                                        ${apply.stu_app_isr_file_origin }
                                                    </a>
                                                </div>
                                                <div class="resumeForm_text form25">
                                                    <div class="rsm_label">출입국 사실증명서</div>
                                                    <input type="hidden" name="stu_app_imm_file_origin"
                                                        value="${apply.stu_app_imm_file_origin }">
                                                    <input type="hidden" name="stu_app_imm_file_saved"
                                                        value="${apply.stu_app_imm_file_saved }">
                                                    <a
                                                        href="/file_download?origin=${apply.stu_app_imm_file_origin }&saved=${apply.stu_app_imm_file_saved }&path=stu/apply/immigration/${apply.user_id}_${apply.gisu_id }">
                                                        ${apply.stu_app_imm_file_origin }
                                                    </a>
                                                </div>
                                                <div class="resumeForm_text form25">
                                                    <div class="rsm_label">워크넷 직무평가 결과</div>
                                                    <input type="hidden" name="stu_app_worknet_file_origin"
                                                        value="${apply.stu_app_worknet_file_origin }">
                                                    <input type="hidden" name="stu_app_worknet_file_saved"
                                                        value="${apply.stu_app_worknet_file_saved }">
                                                    <a
                                                        href="/file_download?origin=${apply.stu_app_worknet_file_origin }&saved=${apply.stu_app_worknet_file_saved }&path=stu/apply/worknet/${apply.user_id}_${apply.gisu_id }">
                                                        ${apply.stu_app_worknet_file_origin }
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section_btnWrap">
                            	<div id="modifyBtn"></div>
                            </div>
                        </div>
                    </form>
                </div>
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
                        <div id="updateBtn"></div>
                    </nav>
                </div>
            </div>
        </div>
        <%@include file="../include/rainbow_footer.jsp"%>
    </div>
</body>
<script type="text/javascript">
    // 지원신청 Aside Scroll
    document.addEventListener('scroll', function () {
        const scroll = document.documentElement.scrollTop;
        const applyContainer = document.querySelector(".course-applyContainer").offsetHeight;
        const menuHeight = document.querySelector(".headerWrap").offsetHeight;
        const aside = document.querySelector(".resumeAside");
        const containerHeight = applyContainer - menuHeight - '500';
        // side 지원신청 bar -> fixed
        if (scroll >= containerHeight || scroll >= applyContainer) {
            aside.classList.add("scrollFixed")
        } else {
            aside.classList.remove("scrollFixed")
        }
    });

    // input readonly 처리
    $('input').attr("readonly", true);
    // document.getElementsByTagName('input').readOnly = true;
</script>

</html>