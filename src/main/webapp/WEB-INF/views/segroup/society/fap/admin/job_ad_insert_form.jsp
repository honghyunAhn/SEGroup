<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="<c:url value="/resources/segroup/js/jquery-3.1.1.js" />"></script>
<script src="<c:url value="/resources/segroup/js/jquery-ui.js" />"></script>
<script src="<c:url value="/resources/segroup/js/angular.min.js" />"></script>
<script src="<c:url value="/resources/segroup/js/datepicker.js" />"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<title>Bridge Job Fair</title>
<script type="text/javascript">
	
	function form_check() {
		$("input[type='number']").each(function(index, item){
			var value = $(item).val();
			if(value == null || value == ""){
				
				$(item).val("0");
			}
			
		})
		
		return true;
	}
	
	
	var myApp = angular.module('myapp', []);
	
	myApp.controller('JobAdController',['$scope','$compile', '$http', function($scope, $compile, $http) {
		
		//회사명
		$scope.addComp = function() {
			var compClass = $(".comp");
			var compIndex = compClass.length;
			
			var content = '<ul class ="comp">';
			content +='<li>언어구분<select name="jobCompList['+compIndex+'].fap_job_comp_gb">';
			content += '<option value="C0200">영문</option>';
			content += '<option value="C0201">일문</option>';
			content += '</select></li>';
			content += '<li>회사명<input type="text" name="jobCompList['+compIndex+'].fap_job_comp_nm"></li>';
			content += '</ul>';
			
			$(".comp:last").after(content);
			
		}
		
		$scope.removeComp = function() {
			var compIndex = $(".comp").length;
			if(compIndex > 1) {
				$(".comp:last").remove();
			}
		}
		
		//보험
		$scope.addIsr = function() {
			var isrClass = $(".isr");
			var isrIndex = isrClass.length;
			
			var content = '<ul class ="isr">';
			content +='<li>보험<select name="jobIsrList['+isrIndex+'].fap_job_isr_gb">';
			content += '<option value="C0600">건강보험</option>';
			content += '<option value="C0601">후생연금보험</option>';
			content += '<option value="C0602">고용보험</option>';
			content += '<option value="C0606">산재보험</option>';
			content += '<option value="C0604">퇴직금제도</option>';
			content += '</select></li>';
			content += '<li>비고<input type="text" name="jobIsrList['+isrIndex+'].fap_job_isr_note"></li>';
			content += '</ul>';
			
			$(".isr:last").after(content);
			
		}
		
		$scope.removeIsr = function() {
			var isrIndex = $(".isr").length;
			if(isrIndex > 1) {
				$(".isr:last").remove();
			}
		}
		
		//입사예정일
		$scope.addJoinDt = function() {
			var joinDtClass = $(".joindt");
			var joinDtIndex = joinDtClass.length;
			
			var content = '<ul class ="joindt">';
			content +='<li>입사예정일(공통코드)<select name="jobJoinDtList['+joinDtIndex+'].fap_job_join_dt_gb">';
			content += '<option value="C1500">올해 하반기</option>';
			content += '<option value="C1501">내년 상반기</option>';
			content += '</select></li>';
			content += '<li>상세내용<input type="text" name="jobJoinDtList['+joinDtIndex+'].fap_job_join_dt_dtl"></li>';
			content += '</ul>';
			
			$(".joindt:last").after(content);
			
		}
		
		$scope.removeJoinDt = function() {
			var joinDtIndex = $(".joindt").length;
			if(joinDtIndex > 1) {
				$(".joindt:last").remove();
			}
		}
		
		//주요업무정보
		$scope.addWork = function() {
			var workClass = $(".work");
			var workIndex = workClass.length;
			
			var content = '<ul class ="work">';
			content +='<li>입사예정일(공통코드)<select name="jobWorkList['+workIndex+'].fap_job_work_gb">';
			content += '<option value="C0300">자사 SI</option>';
			content += '<option value="C0301">타사 SI</option>';
			content += '<option value="C0302">자사 솔루션</option>';
			content += '<option value="C0303">그 외의 기타업무</option>';
			content += '</select></li>';
			content += '<li>상세내용<input type="text" name="jobWorkList['+workIndex+'].fap_job_work_dtl"></li>';
			content += '</ul>';
			
			$(".work:last").after(content);
			
		}
		
		$scope.removeWork = function() {
			var workIndex = $(".work").length;
			if(workIndex > 1) {
				$(".work:last").remove();
			}
		}
		
		//모집직종
		$scope.addCategory = function() {
			var categoryClass = $(".category");
			var categoryIndex = categoryClass.length;
			
			var content = '<ul class ="category">';
			content +='<li>모집직종(공통코드)<select name="jobCategoryList['+categoryIndex+'].fap_job_category_gb">';
			content += '<option value="C3700">시스템엔지니어</option>';
			content += '<option value="C3701">네트워크엔지니어</option>';
			content += '<option value="C3702">프로그래머</option>';
			content += '<option value="C3703">시스템운용/보수</option>';
			content += '<option value="C3704">기타모집직종</option>';
			content += '</select></li>';
			content += '<li>상세내용<input type="text" name="jobCategoryList['+categoryIndex+'].fap_job_category_dtl"></li>';
			content += '</ul>';
			
			$(".category:last").after(content);
			
		}
		
		$scope.removeCategory = function() {
			var categoryIndex = $(".category").length;
			if(categoryIndex > 1) {
				$(".category:last").remove();
			}
		}
		
		//우대사항
		$scope.addPref = function() {
			var prefClass = $(".pref");
			var prefIndex = prefClass.length;
			
			var content = '<ul class ="pref">';
			content +='<li>우대사항(공통코드)<select name="jobPrefList['+prefIndex+'].fap_job_pref_gb">';
			content += '<option value="C4100">특정 IT스킬 보유자 우대</option>';
			content += '<option value="C4101">IT, 컴퓨터 계열 전공자 우대</option>';
			content += '<option value="C4102">경력자 우대</option>';
			content += '<option value="C4103">정보처리기사(산업기사)보유자 우대</option>';
			content += '<option value="C4104">영어우수자 우대</option>';
			content += '<option value="C4105">기타 우대사항</option>';
			content += '</select></li>';
			content += '<li>상세내용<input type="text" name="jobPrefList['+prefIndex+'].fap_job_pref_dtl"></li>';
			content += '</ul>';
			
			$(".pref:last").after(content);
			
		}
		
		$scope.removePref = function() {
			var prefIndex = $(".pref").length;
			if(prefIndex > 1) {
				$(".pref:last").remove();
			}
		}
		
		//채용전형
		$scope.addRecruitPcs = function() {
			
			var recruitPcsClass = $(".recruitpcs");
			var recruitPcsIndex = recruitPcsClass.length;
		
			var content = '<ul class ="recruitpcs">';
			content += '<li>전형구분(공통코드)<select name="jobRecruitPcsList['+recruitPcsIndex+'].fap_job_recruit_pcs_gb">';
			content += '<option value="C2500" id="pcs_list_aa_'+recruitPcsIndex+'">서류전형</option>';
			content += '<option value="C2501" id="pcs_list_bb_'+recruitPcsIndex+'">시험전형</option>';
			content += '<option value="C2502" id="pcs_list_cc_'+recruitPcsIndex+'">면접전형</option>';
			content += '<option value="C2503" id="pcs_list_dd_'+recruitPcsIndex+'">기타전형</option>';
			content += '<option value="C2504" id="pcs_list_ee_'+recruitPcsIndex+'">현지면접전형</option>';
			content += '</select>';
			content += '<input type="button" value="상세내용작성" id="pcs_button'+recruitPcsIndex+'">';
			content += '<li>상세내용<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].fap_job_recruit_pcs_dtl"></li>';
			content += '<li>전형순서<input type="number" value="'+recruitPcsIndex+'" name="jobRecruitPcsList['+recruitPcsIndex+'].fap_job_recruit_pcs_od">';
			
			content += '<ul id ="pcs_body_a_'+recruitPcsIndex+'">';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.fap_job_exam_gb">';
			content += '<option value="C2600">필기시험</option>';
			content += '<option value="C2601">Web시험</option>';
			content += '</select></li>';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.fap_job_exam_obj">';
			content += '<option value="C2700">지원자 전원</option>';
			content += '<option value="C2701">서류전형 합격자</option>';
			content += '<option value="C2702">기타</option>';
			content += '</select></li>';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.fap_job_exam_mail">';
			content += '<option value="C2800">시험 대상자 메일주소 필요</option>';
			content += '<option value="C2801">시험 대상자 메일주소 불필요</option>';
			content += '</select></li>';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.fap_job_exam_sv">';
			content += '<option value="C2900">시험감독 필요</option>';
			content += '<option value="C2901">시험감독 불필요</option>';
			content += '<option value="C2902">집에서 수험가능</option>';
			content += '<option value="C2903">시험감독 관련 기타사항</option>';
			content += '</select></li>';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.fap_job_exam_need">';
			content += '<option value="C3000">시험준비물 제한 없음</option>';
			content += '<option value="C3001">시험 시, 준비물 반입불가</option>';
			content += '<option value="C3002">기타사항</option>';
			content += '</select></li>';
			content += '<li>시험종류<input type="checkbox" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamTypeList[0].fap_job_exam_type_gb" value="C3200">';
			content += '일본어 관련 시험';
			content += '<input type="checkbox" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamTypeList[1].fap_job_exam_type_gb" value="C3201">';
			content += '작문';
			content += '<input type="checkbox" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamTypeList[2].fap_job_exam_type_gb" value="C3202">';
			content += 'IT관련 시험';
			content += '<input type="checkbox" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamTypeList[3].fap_job_exam_type_gb" value="C3203">';
			content += '프로그래머 적성검사';
			content += '<input type="checkbox" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamTypeList[4].fap_job_exam_type_gb" value="C3204">';
			content += '성격 적성검사';
			content += '<input type="checkbox" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamTypeList[5].fap_job_exam_type_gb" value="C3205">';
			content += '기타시험';
			content += '</li>';
			content += '<li>소요시간<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.fap_job_exam_tm"></li>';
			content += '<li>시험대상자(기타)<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamObjEtc.fap_job_exam_obj_etc_dtl"></li>';
			content += '<li>시험감독관(기타)<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamSvEtc.fap_job_exam_sv_etc_dtl"></li>';
			content += '<li>시험준비물(기타)<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamNeedEtc.fap_job_exam_need_etc_dtl"></li>';
			content += '<li>파일<input type="file" name="jobRecruitPcsList['+recruitPcsIndex+'].jobExam.jobExamFile.fap_job_exam_file"></li></ul>';
			
			content += '<ul id ="pcs_body_b_'+recruitPcsIndex+'">';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobItv.fap_job_itv_gb">';
			content += '<option value="C3300">직접대면면접</option>';
			content += '<option value="C3301">화상면접(skype)</option>';
			content += '</select></li>';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobItv.fap_job_itv_obj">';
			content += '<option value="C3400">지원자 전원</option>';
			content += '<option value="C3401">서류전형 합격자</option>';
			content += '<option value="C3402">시험전형 합격자</option>';
			content += '<option value="C3403">기타</option>';
			content += '</select></li>';
			content += '<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobItv.fap_job_itv_tp">';
			content += '<option value="C3500">개별면접</option>';
			content += '<option value="C3501">그룹면접</option>';
			content += '<option value="C3502">미정</option>';
			content += '<option value="C3503">기타</option>';
			content += '</select></li>';
			content += '<li>소요시간<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobItv.fap_job_itv_tm"></li>';
			content += '<li>skype아이디<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobItv.fap_job_itv_skype"></li>';
			content += '<li>면접방식(기타)<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobItv.jobItvTpEtc.fap_job_itv_tp_etc_dtl"></li>';
			content += '<li>면접대상자(기타)<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobItv.jobItvObjEtc.fap_job_itv_obj_etc_dtl"></li></ul>';
			
			content += '<ul id ="pcs_body_c_'+recruitPcsIndex+'">';
			content +='<li><select name="jobRecruitPcsList['+recruitPcsIndex+'].jobTestEtc.fap_job_test_etc_obj">';
			content += '<option value="C3600">지원자 전원</option>';
			content += '<option value="C3601">서류전형 합격자</option>';
			content += '<option value="C3602">시험전형 합격자</option>';
			content += '<option value="C3603">기타</option>';
			content += '</select></li>';
			content += '<li>상세내용<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobTestEtc.fap_job_test_etc_dtl"></li>';
			content += '<li>기타대상자<input type="text" name="jobRecruitPcsList['+recruitPcsIndex+'].jobTestEtc.jobTestEtcObj.fap_job_test_etc_obj_dtl"></li></ul>';
			
			content += '</ul>';
			$(".recruitpcs:last").after(content);
			
			$("#pcs_body_a_"+recruitPcsIndex).hide();
			$("#pcs_body_b_"+recruitPcsIndex).hide();
			$("#pcs_body_c_"+recruitPcsIndex).hide();
			
			$("#pcs_button"+recruitPcsIndex).click(function(){
			    	if($("#pcs_list_bb_"+recruitPcsIndex).is(":selected")){
				        $("#pcs_body_a_"+recruitPcsIndex).show();
				    }else{
				        $("#pcs_body_a_"+recruitPcsIndex).hide();
				    }
				});
			    
			$("#pcs_button"+recruitPcsIndex).click(function(){
			    	if($("#pcs_list_cc_"+recruitPcsIndex).is(":selected")){
				        $("#pcs_body_b_"+recruitPcsIndex).show();
				    }else{
				        $("#pcs_body_b_"+recruitPcsIndex).hide();
				    }
				});
			    
			$("#pcs_button"+recruitPcsIndex).click(function(){
			    	if($("#pcs_list_dd_"+recruitPcsIndex).is(":selected")){
				        $("#pcs_body_c_"+recruitPcsIndex).show();
				    }else{
				        $("#pcs_body_c_"+recruitPcsIndex).hide();
				    }
				});
			
		}
		
		$scope.removeRecruitPcs = function() {
			var recruitPcsIndex = $(".recruitpcs").length;
			if(recruitPcsIndex > 1) {
				$(".recruitpcs:last").remove();
			}
		}
		
		//급여 (원병호)
		//급여 기타수당 추가
		$scope.add_job_pay = function(){
			var pay_index = $("#job_pay_ul > li").length;
			var content = "";
			content += "<li>";
			content += "기타수당<input type=\"number\" name=\"jobPayList[" + pay_index +"].fap_job_pay_info\">";
			content += "<br>";
			content += "설명 : <input type=\"text\" name=\"jobPayList[" + pay_index + "].fap_job_pay_dtl\">";
			content += "<input type=\"hidden\" name=\"jobPayList[" + pay_index + "].fap_job_pay_gb\" value=\"C2201\">";
			content += "</li>";
			
			$("#job_pay_ul").append(content);
		
		}//급여 기타수당 추가 끝
		
		//급여 기타수당 삭제
		$scope.remove_job_pay = function() {
			var index = $("#job_pay_ul > li").length;
			if(index > 4){
				$("#job_pay_ul > li:last").remove();
			}
		}//급여 기타수당 삭제 끝
		
		//급여 기본급 기타 추가
		$scope.add_job_pay_etc = function() {
			var index = $("#job_pay_etc_ul > li").length;
			alert(index);
			var content = "<li>";
			content += "금액";
			content += "<input type=\"number\" name=\"jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList[" + index + "].fap_job_pay_etc_info\">";
			content += "수당 이름";
			content += "<input type=\"text\" name=\"jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList[" + index + "].fap_job_pay_etc_nm\">";
			content += "</li>";
			$("#job_pay_etc_ul").append(content);
		}//급여 기본급 기타 추가 끝
		
		$scope.remove_job_pay_etc = function() {
			var index = $("#job_pay_etc_ul > li").length;
			if(index != 0){
				$("#job_pay_etc_ul > li:last").remove();
			}
		}//급여 기본급 기타 추가 끝
		
		//급여 끝
		
		
		/* $("#select_test").on("click", function() {
			$.ajax({
				method: "POST"
				, url: "/fap/admin/select_test"
				, data: {
					fap_jop_ad_seq	: "455"
				}
				, dataType: "json"
				, success: function(data){
					
					console.log(data);
					
				}
			});
		});*/
		$http({
			method : 'POST',
			url : '/fap/admin/select_test',
			responseType : 'text',
			params : {
				fap_jop_ad_seq	: "455"
			}
		}).then(function successCallback(response) {
			$scope.jobAd_pay = response.data;
			console.log(response.data);
		}, function errorCallback(response) {
			console.log(response);
		});
		
	}//myapp.controller
]);
	
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
			template : "<option>{{filterParams}}</option>"
		}
	} ]);

</script>

<script type="text/javascript">
	//근무예정지에 따른 상세 근무예정지
	$(document).ready(function(){
		$("#a_body").hide();
		$("#b_body").hide();
		$("#c_body").hide();
		$("#d_body").hide();
		$("#e_body").hide();
		$("#f_body").hide();
		$("#g_body").hide();
		$("#h_body").hide();
		$("#i_body").hide();
		$("#pcs_body_a_0").hide();
		$("#pcs_body_b_0").hide();
		$("#pcs_body_c_0").hide();
	
	    $("#a_checkbox").change(function(){
	        if($("#a_checkbox").is(":checked")){
	            $("#a_body").show();
	        }else{
	            $("#a_body").hide();
	        }
	    });	    
	    
	    $("#b_checkbox").change(function(){
	        if($("#b_checkbox").is(":checked")){
	            $("#b_body").show();
	        }else{
	            $("#b_body").hide();
	        }
	    });
	    
	    $("#c_checkbox").change(function(){
	        if($("#c_checkbox").is(":checked")){
	            $("#c_body").show();
	        }else{
	            $("#c_body").hide();
	        }
	    });
	    
	    $("#d_checkbox").change(function(){
	        if($("#d_checkbox").is(":checked")){
	            $("#d_body").show();
	        }else{
	            $("#d_body").hide();
	        }
	    });
	    
	    $("#e_checkbox").change(function(){
	        if($("#e_checkbox").is(":checked")){
	            $("#e_body").show();
	        }else{
	            $("#e_body").hide();
	        }
	    });
	    
	    $("#f_checkbox").change(function(){
	        if($("#f_checkbox").is(":checked")){
	            $("#f_body").show();
	        }else{
	            $("#f_body").hide();
	        }
	    });
	    
	    $("#g_checkbox").change(function(){
	        if($("#g_checkbox").is(":checked")){
	            $("#g_body").show();
	        }else{
	            $("#g_body").hide();
	        }
	    });
	    
	    $("#h_checkbox").change(function(){
	        if($("#h_checkbox").is(":checked")){
	            $("#h_body").show();
	        }else{
	            $("#h_body").hide();
	        }
	    });
	    
	    $("#i_checkbox").change(function(){
	        if($("#i_checkbox").is(":checked")){
	            $("#i_body").show();
	        }else{
	            $("#i_body").hide();
	        }
	    });
	    
	    $("#pcs_button0").click(function(){
	    	if($("#pcs_list_bb_0").is(":selected")){
		        $("#pcs_body_a_0").show();
		    }else{
		        $("#pcs_body_a_0").hide();
		    }
		});
	    
	    $("#pcs_button0").click(function(){
	    	if($("#pcs_list_cc_0").is(":selected")){
		        $("#pcs_body_b_0").show();
		    }else{
		        $("#pcs_body_b_0").hide();
		    }
		});
	    
	    $("#pcs_button0").click(function(){
	    	if($("#pcs_list_dd_0").is(":selected")){
		        $("#pcs_body_c_0").show();
		    }else{
		        $("#pcs_body_c_0").hide();
		    }
		});
		
	});		

</script>

</head>
<body ng-app="myapp" ng-controller="JobAdController">
	<sec:authorize access="hasAnyRole('A0600','A0601','A0602')">
		<sec:authentication property="details.admin" var="detail" />
	</sec:authorize>
	<form action="job_ad_insert" method="post" onsubmit="return form_check()" enctype="multipart/form-data">
			<input type="hidden" name="fap_job_ad_ins_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_ad_udt_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_dorm_ins_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_dorm_udt_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_jit_employee_ins_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_jit_employee_udt_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_ja_level_ins_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_ja_level_udt_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_trial_ins_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_trial_udt_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_jobfair_divide_seq" value="220">
			<input type="hidden" name="fap_jobfair_seq" value="202">
			<input type="hidden" name="fap_comp_id" value="${detail.admin_id }">
			<input type="hidden" name="fap_job_ad_is_mismatching" value="일반지원">
			<h1 style="width: 430px;">채용공고 등록 form</h1>
			
				<header>기본정보</header>
			<ul>
				<li>주요사업분야<input type="text" name="fap_job_ad_major_business"></li>
			
				<li>홈페이지<input type="text" name="fap_job_ad_homepage"></li>
			
				<li>설립일<input type="text" name="fap_job_ad_est_dt"></li>
			
				<li>자본금<input type="number" name="fap_job_ad_stock" name="fap_job_ad_stock"></li>
			
				<li>최근3년평균매출<input type="number" name="fap_job_ad_3years_avg_sales"></li>
			
				<li>종업원수<input type="number" name="fap_job_ad_employee_num"></li>
			
				<li>외국인사원수<input type="number" name="fap_job_ad_foreigner_num"></li>
				
				<li>한국인사원수<input type="number" name="fap_job_ad_korean_num"></li>
			
				<li>우편번호<input type="text" name="fap_job_ad_postcode"></li>
			
				<li>주소<input type="text" name="fap_job_ad_address"></li>
			
				<li>상세주소<input type="text" name="fap_job_ad_address_dtl"></li>
			</ul>
			<ul>
				<li>채용공고제목<input type="text" name="fap_job_ad_title"></li>
			
				<li>근무시간<input type="text" name="fap_job_ad_worktime"></li>
			
				<li>평균잔업시간<input type="text" name="fap_job_ad_overtime"></li>
			
				<li>고용형태(공통코드)
					<select name="fap_job_ad_hire_type">
						<option value="C0400">정규직</option>
						<option value="C0401">계약직</option>
					</select>
				</li>
			
				<li>시용기간유무(공통코드)
					<select name="fap_job_ad_intern">
						<option value="C0500">있음</option>
						<option value="C0501">없음</option>
					</select>
				</li>
			
				<li>채용예정인원<input type="number" name="fap_job_ad_recruit_num"></li>
			
				<li>인재상<input type="text" name="fap_job_ad_ideal_person"></li>
			
				<li>희망연령(공통코드)
					<select name="fap_job_ad_age">
						<option value="C1400">25세이하</option>
						<option value="C1401">30세이하</option>
						<option value="C1402">35세이하</option>
						<option value="C1403">연령무관</option>
					</select>
				</li>
			
				<li>희망성별(공통코드)
					<select name="fap_job_ad_gender">
						<option value="C4200">남자</option>
						<option value="C4201">여자</option>
						<option value="C4202">성별무관</option>
					</select>
				</li>
			
				<li>기숙사유무(공통코드)
					<select name="fap_job_ad_isdorm" ng-model="jobAd_pay.fap_job_ad_isdorm">
						<option value="C0800">있음</option>
						<option value="C0801">없음</option>
					</select>
				</li>
			
				<li>승진<input type="text" name="fap_job_ad_promotion" value="{{jobAd_pay.fap_job_ad_promotion}}"></li>
			
				<li>휴가<input type="text" name="fap_job_ad_vacation" value="{{jobAd_pay.fap_job_ad_vacation}}"></li>
			
				<li>기타복리후생<input type="text" name="fap_job_ad_welfare" value="{{jobAd_pay.fap_job_ad_welfare}}"></li>
			
				<li>성적공개희망여부(공통코드)
					<select name="fap_job_ad_open_grade">
						<option value="C1600">희망</option>
						<option value="C1601">희망하지않음</option>
					</select>
				</li>
			
				<li>재류자격 정보처리기사 필요여부(공통코드)
					<select name="fap_job_ad_qual_dpe">
						<option value="C1700">필요</option>
						<option value="C1701">불필요</option>
					</select>
				</li>
			
				<li>채용조건 정보처리기사 필요여부(공통코드)
					<select name="fap_job_ad_terms_dpe">
						<option value="C1800">필요</option>
						<option value="C1801">불필요</option>
					</select>
				</li>
			
				<li>과정수료 동의여부(공통코드)
					<select name="fap_job_ad_coc_agree">
						<option value="C1900">동의</option>
					</select>
				</li>
			
				<li>채용공고 승인여부(공통코드)
					<select name="fap_job_ad_per">
						<option value="C0900">승인</option>
						<option value="C0901">미승인</option>
					</select>				
				</li>
			
				<li>중복지원 가능여부(공통코드)
					<select name="fap_job_ad_overlap">
						<option value="C2000">가능</option>
						<option value="C2001">불가능</option>
					</select>
				</li>
			
				<li>기업그룹코드<input type="text" name="fap_job_ad_groupcode"></li>
			
				<li>채용공고 상태(공통코드)
					<select name="fap_job_ad_state">
						<option value="C2100">대기</option>
						<option value="C2101">진행</option>
						<option value="C2102">마감</option>
					</select>
				</li>	
					
			</ul>
				기숙사정보
			<ul>
				<li>기숙사 위치<input type="text" name="fap_job_dorm_lo" value="{{jobAd_pay.JobDormList[0].fap_job_dorm_lo}}"></li>
				<li>기숙사 자기부담금<input type="text" name="fap_job_dorm_cost" value="{{jobAd_pay.JobDormList[0].fap_job_dorm_cost}}"></li>
				<li>기숙사 비고<input type="text" name="fap_job_dorm_note" value="{{jobAd_pay.JobDormList[0].fap_job_dorm_note}}"></li>
			</ul>
				계약사원 정보
			<ul>
				<li>전환여부(공통코드)
					<select name="fap_job_jit_employee_isswitch">
						<option value="C3800">정사원 전환 가능</option>
						<option value="C3801">정사원 전환 불가</option>
						<option value="C3802">전환여부 미정</option>
					</select>
				</li>
				<li>계약기간<input type="text" name="fap_job_jit_employee_term"></li>
				<li>조건<input type="text" name="fap_job_jit_employee_dtl"></li>
			</ul>	
				업무에 필요한 일본어능력 정보
			<ul>
				<li>JLPT 급수(공통코드)
					<select name="fap_job_ja_level_gb">
						<option value="C4400">JLPT N1</option>
						<option value="C4401">JLPT N2 이상</option>
						<option value="C4402">JLPT N3 이상</option>
						<option value="C4403">일본어 자격증 유무 상관없음</option>
					</select>
				</li>
				<li>상세내용<input type="text" name="fap_job_ja_level_dtl"></li>
			</ul>	
				시용기간 정보
			<ul>
				<li>시용기간<input type="text" name="fap_job_trial_pd"></li>
				<li>시용기간 급여<input type="text" name="fap_job_trial_pay"></li>
				<li>시용기간 급여조건(공통코드)
					<select name="fap_job_trial_pay_equal">
						<option value="C2400">시용기간 중 급여 변동 없음</option>
						<option value="C2401">시용기간 중 급여 변동 있음</option>
					</select>
				</li>
			</ul>	
			
			회사명
			<ul class ="comp">
				<li>언어구분
					<select name="jobCompList[0].fap_job_comp_gb">
						<option value="C0200">영문</option>
						<option value="C0201">일문</option>
					</select>
				<li>회사명<input type="text" name="jobCompList[0].fap_job_comp_nm"></li>
			</ul>
				<i><b><img class="fore_add" ng-click="addComp()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeComp()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
			
			<br>
			회사소개 관련 파일
			<ul class ="file">
				<li>회사소개 동영상
				<input type="hidden" value="C0700" name="jobFileList[0].fap_job_file_gb">
				<input type="file" value="파일선택" name="jobFileList[0].job_ad_file">
			
				<li>회사소개 PDF 파일
				<input type="hidden" value="C0701" name="jobFileList[1].fap_job_file_gb">	
				<input type="file" value="파일선택" name="jobFileList[1].job_ad_file">
			
				<li>회사소개 이미지, 사진
				<input type="hidden" value="C0702" name="jobFileList[2].fap_job_file_gb">	
				<input type="file" value="파일선택" name="jobFileList[2].job_ad_file">
			</ul>
			<br>
			보험
			<ul class ="isr" ng-repeat="jobIsr in jobAd_pay.JobIsrList">
				<li>보험구분
					<select name="jobIsrList[{{$index}}].fap_job_isr_gb" ng-model="jobIsr.fap_job_isr_gb">
						<option value="C0600">건강보험</option>
						<option value="C0601">후생연금보험</option>
						<option value="C0602">고용보험</option>
						<option value="C0603">산재보험</option>
						<option value="C0604">퇴직금제도</option>
					</select>
				<li>비고<input type="text" name="jobIsrList[{{$index}}].fap_job_isr_note" value="{{jobIsr.fap_job_isr_note}}"></li>
			</ul>
				<i><b><img class="fore_add" ng-click="addIsr()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeIsr()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
			<br>
			입사예정일
			<ul class ="joindt">
				<li>입사예정일(공통코드)
					<select name="jobJoinDtList[0].fap_job_join_dt_gb">
						<option value="C1500">올해 하반기</option>
						<option value="C1501">내년 상반기</option>
					</select>
				<li>상세내용<input type="text" name="jobJoinDtList[0].fap_job_join_dt_dtl"></li>
			</ul>
				<i><b><img class="fore_add" ng-click="addJoinDt()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeJoinDt()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
			
			<br>
			주요업무
			<ul class ="work">
				<li>주요업무구분(공통코드)
					<select name="jobWorkList[0].fap_job_work_gb">
						<option value="C0300">자사 SI</option>
						<option value="C0301">타사 SI</option>
						<option value="C0302">자사 솔루션</option>
						<option value="C0303">그 외의 기타업무</option>
					</select>
				<li>업무상세내용<input type="text" name="jobWorkList[0].fap_job_work_dtl"></li>
			</ul>
				<i><b><img class="fore_add" ng-click="addWork()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeWork()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
			
			<br>
			모집직종
			<ul class ="category">
				<li>모집직종(공통코드)
					<select name="jobCategoryList[0].fap_job_category_gb">
						<option value="C3700">시스템 엔지니어</option>
						<option value="C3701">네트워크 엔지니어</option>
						<option value="C3702">프로그래머</option>
						<option value="C3703">시스템운용/보수</option>
						<option value="C3704">기타모집직종</option>
					</select>
				<li>상세내용<input type="text" name="jobCategoryList[0].fap_job_category_dtl"></li>
			</ul>
				<i><b><img class="fore_add" ng-click="addCategory()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeCategory()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
			
			<br>
			우대사항
			<ul class ="pref">
				<li>우대사항(공통코드)
					<select name="jobPrefList[0].fap_job_pref_gb">
						<option value="C4100">특정 IT 스킬 보유자 우대</option>
						<option value="C4101">IT, 컴퓨터 계열 전공자 우대</option>
						<option value="C4102">경력자 우대</option>
						<option value="C4103">정보처리기사(산업기사) 보유자 우대</option>
						<option value="C4104">영어우수자 우대</option>
						<option value="C4105">기타 우대사항</option>
					</select>
				<li>상세내용<input type="text" name="jobPrefList[0].fap_job_pref_dtl"></li>
			</ul>
				<i><b><img class="fore_add" ng-click="addPref()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removePref()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
				
			<br>
			
			근무예정지			
			<br>
								
			<input type="checkbox" name="jobWorkplaceList[0].fap_job_workplace_gb" id="a_checkbox" value="C3900">
			<code value="C3900"></code>
							
			<input type="checkbox" name="jobWorkplaceList[1].fap_job_workplace_gb" id="b_checkbox" value="C3901">
			<code value="C3901"></code>
							
			<input type="checkbox" name="jobWorkplaceList[2].fap_job_workplace_gb" id="c_checkbox" value="C3902">
			<code value="C3902"></code>
				
			<input type="checkbox" name="jobWorkplaceList[3].fap_job_workplace_gb" id="d_checkbox" value="C3903">
			<code value="C3903"></code>
				
			<input type="checkbox" name="jobWorkplaceList[4].fap_job_workplace_gb" id="e_checkbox" value="C3904">
			<code value="C3904"></code>
				
			<input type="checkbox" name="jobWorkplaceList[5].fap_job_workplace_gb" id="f_checkbox" value="C3905">
			<code value="C3905"></code>
				
			<input type="checkbox" name="jobWorkplaceList[6].fap_job_workplace_gb" id="g_checkbox" value="C3906">
			<code value="C3906"></code>
				
			<input type="checkbox" name="jobWorkplaceList[7].fap_job_workplace_gb" id="h_checkbox" value="C3907">
			<code value="C3907"></code>
				
			<input type="checkbox" name="jobWorkplaceList[8].fap_job_workplace_gb" id="i_checkbox" value="C3908">
			<code value="C3908"></code>
			
			<br>
			
			<div id="a_body">
			
			홋카이도, 토호쿠지방<br>	
			<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4000" class="cl">
			<code value="C4000"></code>
			
			<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4001" class="cl">
			<code value="C4001"></code>
					
			<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4002" class="cl">
			<code value="C4002"></code>
			
			<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4003" class="cl">
			<code value="C4003"></code>
			
			<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4004" class="cl">
			<code value="C4004"></code>
			
			<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4005" class="cl">
			<code value="C4005"></code>
			
			<input type="checkbox" name="jobWorkplaceList[0].jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4006" class="cl">
			<code value="C4006"></code>			
			
			</div>
			<div id="b_body">
			
			칸토 지방<br>	
			<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4007" class="cl">
			<code value="C4007"></code>
					
			<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4008" class="cl">
			<code value="C4008"></code>
							
			<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4009" class="cl">
			<code value="C4009"></code>
							
			<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4010" class="cl">
			<code value="C4010"></code>
			
			<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4011" class="cl">
			<code value="C4011"></code>				
			
			<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4012" class="cl">
			<code value="C4012"></code>
					
			<input type="checkbox" name="jobWorkplaceList[1].jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4013" class="cl">
			<code value="C4013"></code>
					
			</div>
			
			<br>
			
			<div id="c_body">
			
			호쿠리쿠, 코우신에츠 지방<br>	
			<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4014" class="cl">
			<code value="C4014"></code>
					
			<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4015" class="cl">
			<code value="C4015"></code>
							
			<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4016" class="cl">
			<code value="C4016"></code>
							
			<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4017" class="cl">
			<code value="C4017"></code>
			
			<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4018" class="cl">
			<code value="C4018"></code>				
			
			<input type="checkbox" name="jobWorkplaceList[2].jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4019" class="cl">
			<code value="C4019"></code>
					
			</div>
			
			<div id="d_body">
			
			토카이 지방<br>	
			<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4020" class="cl">
			<code value="C4020"></code>
					
			<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4021" class="cl">
			<code value="C4021"></code>
							
			<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4022" class="cl">
			<code value="C4022"></code>
							
			<input type="checkbox" name="jobWorkplaceList[3].jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4023" class="cl">
			<code value="C4023"></code>
			
			</div>
			
			<div id="e_body">
			
			킨키 지방<br>	
			<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4024" class="cl">
			<code value="C4024"></code>
					
			<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4025" class="cl">
			<code value="C4025"></code>
							
			<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4026" class="cl">
			<code value="C4026"></code>
							
			<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4027" class="cl">
			<code value="C4027"></code>
			
			<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4028" class="cl">
			<code value="C4028"></code>				
			
			<input type="checkbox" name="jobWorkplaceList[4].jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4029" class="cl">
			<code value="C4029"></code>
					
			</div>
			
			<div id="f_body">
			
			츄고쿠, 시코쿠 지방<br>	
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4030" class="cl">
			<code value="C4030"></code>
					
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4031" class="cl">
			<code value="C4031"></code>
							
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4032" class="cl">
			<code value="C4032"></code>
							
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4033" class="cl">
			<code value="C4033"></code>
			
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4034" class="cl">
			<code value="C4034"></code>				
			
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4035" class="cl">
			<code value="C4035"></code>
			
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4036" class="cl">
			<code value="C4036"></code>
			
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb" value="C4037" class="cl">
			<code value="C4037"></code>
			
			<input type="checkbox" name="jobWorkplaceList[5].jobWorkplaceDtlList[8].fap_job_workplace_dtl_gb" value="C4038" class="cl">
			<code value="C4038"></code>
					
			</div>
			
			<div id="g_body">
			
			큐슈, 오키나와 지방<br>	
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4039" class="cl">
			<code value="C4039"></code>
					
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[1].fap_job_workplace_dtl_gb" value="C4040" class="cl">
			<code value="C4040"></code>
							
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[2].fap_job_workplace_dtl_gb" value="C4041" class="cl">
			<code value="C4041"></code>
							
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[3].fap_job_workplace_dtl_gb" value="C4042" class="cl">
			<code value="C4042"></code>
			
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[4].fap_job_workplace_dtl_gb" value="C4043" class="cl">
			<code value="C4043"></code>				
			
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[5].fap_job_workplace_dtl_gb" value="C4044" class="cl">
			<code value="C4044"></code>
			
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[6].fap_job_workplace_dtl_gb" value="C4045" class="cl">
			<code value="C4045"></code>
			
			<input type="checkbox" name="jobWorkplaceList[6].jobWorkplaceDtlList[7].fap_job_workplace_dtl_gb" value="C4046" class="cl">
			<code value="C4046"></code>		
			</div>
			
			<br>
			
			<div id="h_body">
			<input type="checkbox" name="jobWorkplaceList[7].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4047" class="cl" checked="checked">
			<code value="C4047"></code>	
			</div>
			
			<div id="i_body">
			<input type="checkbox" name="jobWorkplaceList[8].jobWorkplaceDtlList[0].fap_job_workplace_dtl_gb" value="C4048" class="cl" checked="checked">
			<code value="C4048"></code>	
			<input type="text" name="jobWorkplaceList[8].jobWorkplaceDtlList[0].fap_job_workplace_dtl_address"> 	
			</div>
			
			채용전형
			<ul class ="recruitpcs">
				<li>전형구분(공통코드)
					<select name="jobRecruitPcsList[0].fap_job_recruit_pcs_gb" id="pcs_list">
						<option value="C2500" id="pcs_list_aa_0">서류전형</option>	
						<option value="C2501" id="pcs_list_bb_0">시험전형</option>
						<option value="C2502" id="pcs_list_cc_0">면접전형</option>
						<option value="C2503" id="pcs_list_dd_0">기타전형</option>
						<option value="C2504" id="pcs_list_ee_0">현지면접전형</option>
					</select>
					
					<input type="button" value="상세내용작성" id="pcs_button0">
				</li>
				<li>내용<input type="text" name="jobRecruitPcsList[0].fap_job_recruit_pcs_dtl"></li>
				<li>전형순서<input type="number" value="0" name="jobRecruitPcsList[0].fap_job_recruit_pcs_od"></li>
			<ul id="pcs_body_a_0" >
			<li>
					<select name="jobRecruitPcsList[0].jobExam.fap_job_exam_gb">
						<option value="C2600">필기시험</option>	
						<option value="C2601">Web시험</option>
					</select><br>
			</li>						
			<li>
					<select name="jobRecruitPcsList[0].jobExam.fap_job_exam_obj">
						<option value="C2700">지원자 전원</option>	
						<option value="C2701">서류전형 합격자</option>
						<option value="C2702">기타</option>
					</select><br>
			</li>		
			<li>	
					<select name="jobRecruitPcsList[0].jobExam.fap_job_exam_mail">
						<option value="C2800">시험 대상자 메일주소 필요</option>	
						<option value="C2801">시험 대상자 메일주소 불필요</option>
					</select><br>
			</li>
			<li>		
					<select name="jobRecruitPcsList[0].jobExam.fap_job_exam_sv">
						<option value="C2900">시험감독 필요</option>	
						<option value="C2901">시험감독 불필요</option>
						<option value="C2902">집에서 수험가능</option>
						<option value="C2903">시험감독 관련 기타사항</option>
					</select><br>
			</li>		
			<li>		
					<select name="jobRecruitPcsList[0].jobExam.fap_job_exam_need">
						<option value="C3000">시험준비물 제한 없음</option>	
						<option value="C3001">시험 시, 준비물 반입불가</option>
						<option value="C3002">기타사항</option>
					</select><br>
			</li>		
			<li>시험종류
						<input type="checkbox" name="jobRecruitPcsList[0].jobExam.jobExamTypeList[0].fap_job_exam_type_gb" value="C3200">
						<code value="C3200"></code>
										
						<input type="checkbox" name="jobRecruitPcsList[0].jobExam.jobExamTypeList[1].fap_job_exam_type_gb" value="C3201">
						<code value="C3201"></code>
						
						<input type="checkbox" name="jobRecruitPcsList[0].jobExam.jobExamTypeList[2].fap_job_exam_type_gb" value="C3202">
						<code value="C3202"></code>				
						
						<input type="checkbox" name="jobRecruitPcsList[0].jobExam.jobExamTypeList[3].fap_job_exam_type_gb" value="C3203">
						<code value="C3203"></code>
						
						<input type="checkbox" name="jobRecruitPcsList[0].jobExam.jobExamTypeList[4].fap_job_exam_type_gb" value="C3204">
						<code value="C3204"></code>
						
						<input type="checkbox" name="jobRecruitPcsList[0].jobExam.jobExamTypeList[5].fap_job_exam_type_gb" value="C3205">
						<code value="C3205"></code>		
			</li>
					<li>소요시간<input type="text" name="jobRecruitPcsList[0].jobExam.fap_job_exam_tm"><br></li>
					<li>시험대상자(기타)<input type="text" name="jobRecruitPcsList[0].jobExam.jobExamObjEtc.fap_job_exam_obj_etc_dtl"><br></li>
					<li>시험감독관(기타)<input type="text" name="jobRecruitPcsList[0].jobExam.jobExamSvEtc.fap_job_exam_sv_etc_dtl"><br></li>
					<li>시험준비물(기타)<input type="text" name="jobRecruitPcsList[0].jobExam.jobExamNeedEtc.fap_job_exam_need_etc_dtl"><br></li>
					<li>파일<input type="file" name="jobRecruitPcsList[0].jobExam.jobExamFile.fap_job_exam_file"></li>
			</ul>
					
			<ul id="pcs_body_b_0">
					
			<li>
					<select name="jobRecruitPcsList[0].jobItv.fap_job_itv_gb">
						<option value="C3300">직접대면면접</option>	
						<option value="C3301">화상면접(skype)</option>
					</select><br>https://www.erdcloud.com/u/tomtotoro31@gmail.com
			</li>		
			<li>	
					<select name="jobRecruitPcsList[0].jobItv.fap_job_itv_obj">
						<option value="C3400">지원자 전원</option>	
						<option value="C3401">서류전형 합격자</option>
						<option value="C3402">시험전형 합격자</option>
						<option value="C3403">기타</option>
					</select><br>
			</li>
			<li>		
					<select name="jobRecruitPcsList[0].jobItv.fap_job_itv_tp">
						<option value="C3500">개별면접</option>	
						<option value="C3501">그룹면접</option>
						<option value="C3502">미정</option>
						<option value="C3503">기타</option>
					</select><br>
			</li>		
					<li>소요시간<input type="text" name="jobRecruitPcsList[0].jobItv.fap_job_itv_tm"><br></li>
					<li>skype아이디<input type="text" name="jobRecruitPcsList[0].jobItv.fap_job_itv_skype"></li>
					<li>면접방식(기타)<input type="text" name="jobRecruitPcsList[0].jobItv.jobItvTpEtc.fap_job_itv_tp_etc_dtl"></li>
					<li>면접대상자(기타)<input type="text" name="jobRecruitPcsList[0].jobItv.jobItvObjEtc.fap_job_itv_obj_etc_dtl"></li>
					
			</ul>
			
			<ul id="pcs_body_c_0">
				
			<li>
					<select name="jobRecruitPcsList[0].jobTestEtc.fap_job_test_etc_obj" id="test_etc_obj_etc" onChange="goChange(this.value)">
						<option value="C3600">지원자 전원</option>	
						<option value="C3601">서류전형 합격자</option>
						<option value="C3602">시험전형 합격자</option>
						<option value="C3603" id="testtext">기타</option>
					</select>
					
				
					
			</li>		
	
			<li>상세내용<input type="text" name="jobRecruitPcsList[0].jobTestEtc.fap_job_test_etc_dtl"><br></li>
			<li>기타대상자<input type="text" name="jobRecruitPcsList[0].jobTestEtc.jobTestEtcObj.fap_job_test_etc_obj_dtl"></li>
			</ul>
					
			</ul>
				<i><b><img class="fore_add" ng-click="addRecruitPcs()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeRecruitPcs()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
			
			<br>
			
			
			
			<!-- 급여 -->
			급여
			<ul id="job_pay_ul">
				<li>
					기본급(자동완성)<input type="number" name="jobPayList[0].fap_job_pay_info" value="{{jobAd_pay.JobPayList[0].fap_job_pay_info}}">
					<br>
					설명 : <input type="text" name="jobPayList[0].fap_job_pay_dtl" value="{{jobAd_pay.JobPayList[0].fap_job_pay_dtl}}">
					<input type="hidden" name="jobPayList[0].fap_job_pay_gb" value="C2200">
					<br>
					기본급 상세
					<ul>
						<li>
							ㄹㅇ기본급
							<input type="number" name="jobPayList[0].jobPayBase.jobPayBaseList[0].fap_job_pay_base_info">
							<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[0].fap_job_pay_base_gb" value="C2300">
						</li>
						<li>
							주택수당
							<input type="number" name="jobPayList[0].jobPayBase.jobPayBaseList[1].fap_job_pay_base_info">
							<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[1].fap_job_pay_base_gb" value="C2301">
						</li>
						<li>
							서비스잔교
							<input type="number" name="jobPayList[0].jobPayBase.jobPayBaseList[2].fap_job_pay_base_info" readonly="readonly">
							<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[2].fap_job_pay_base_gb" value="C2302">
						<br>서비스잔교 상세
							<ul>
								<li>
									금액
									<input type="number" name="jobPayList[0].jobPayBase.jobPayBaseList[2].jobServiceWork.fap_job_service_work_info">
								</li>
								<li>
									시간
									<input type="number" name="jobPayList[0].jobPayBase.jobPayBaseList[2].jobServiceWork.fap_job_service_work_tm">
								</li>
							</ul>
						</li>
						<li>
							기타
							<input type="number" name="jobPayList[0].jobPayBase.jobPayBaseList[3].fap_job_pay_base_info" readonly="readonly">
							<input type="hidden" name="jobPayList[0].jobPayBase.jobPayBaseList[3].fap_job_pay_base_gb" value="C2303">
							<ul id="job_pay_etc_ul">
								<li>
									금액
									<input type="number" name="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList[0].fap_job_pay_etc_info">
									수당 이름
									<input type="text" name="jobPayList[0].jobPayBase.jobPayBaseList[3].jobPayEtc.jobPayEtcList[0].fap_job_pay_etc_nm">
								</li>
							</ul>
							기본급 상세 추가/제거
							<br>
							<i><b><img class="fore_add" ng-click="add_job_pay_etc()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b>
							<b><img class="fore_del" ng-click="remove_job_pay_etc()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
							
						</li>
					</ul>
								
				</li>
				<li>
					잔업수당<input type="number" name="jobPayList[1].fap_job_pay_info">엔/시간
					<br>
					설명 : <input type="text" name="jobPayList[1].fap_job_pay_dtl" placeholder="40시간 이후부터 10분 단위로">
					<input type="hidden" name="jobPayList[1].fap_job_pay_gb" value="C2202">
					<ul>
						<li>
							몇시간 이후부터 지급
							<input type="number" name="jobPayList[1].jobPayExtra.fap_job_pay_extra_tm">
						</li>
					</ul>
					
				</li>
				<li>
					교통비<input type="number" name="jobPayList[2].fap_job_pay_info" value="{{jobAd_pay.JobPayList[2].fap_job_pay_info}}">
					<br>
					설명 : <input type="text" name="jobPayList[2].fap_job_pay_dtl" value="{{jobAd_pay.JobPayList[2].fap_job_pay_dtl}}">
					<input type="hidden" name="jobPayList[2].fap_job_pay_gb" value="C2203">
				</li>
				<li>
					상여<input type="number" name="jobPayList[3].fap_job_pay_info">
					<br>
					설명 : <input type="text" name="jobPayList[3].fap_job_pay_dtl">
					<input type="hidden" name="jobPayList[3].fap_job_pay_gb" value="C2204">
				</li>
				
				
				
			</ul>
			기타수당 추가
			<br>
			<i><b><img class="fore_add" ng-click="add_job_pay()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b>
			<b><img class="fore_del" ng-click="remove_job_pay()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>	
				
				
			<!-- 급여  끝-->
			
			
			<input type="submit" value="등록하기">
			
	</form>
	
</body>
</html>