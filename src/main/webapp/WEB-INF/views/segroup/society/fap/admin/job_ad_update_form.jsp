<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	
	myApp.controller('JobAdController',['$scope','$compile', function($scope, $compile) {
		
		var job_ideal_person = '${job_ideal_person}';
		$scope.jobIdealPerson = JSON.parse(job_ideal_person);
		
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
			content += '<option selectcode value="C0300"></option>';
			content += '<option selectcode value="C0301"></option>';
			content += '<option selectcode value="C0302"></option>';
			content += '<option selectcode value="C0303"></option>';
			content += '</select></li>';
			content += '<li>상세내용<input type="text" name="jobWorkList['+workIndex+'].fap_job_work_dtl"></li>';
			content += '</ul>';
			
			$(".work:last").after($compile(content)($scope));
			
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
			content += '<option selectcode value="C4100"></option>';
			content += '<option selectcode value="C4101"></option>';
			content += '<option selectcode value="C4102"></option>';
			content += '<option selectcode value="C4103"></option>';
			content += '<option selectcode value="C4104"></option>';
			content += '<option selectcode value="C4105"></option>';
			content += '</select></li>';
			content += '<li>상세내용<input type="text" name="jobPrefList['+prefIndex+'].fap_job_pref_dtl"></li>';
			content += '</ul>';
			
			$(".pref:last").after($compile(content)($scope));
			
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
	
</script>

</head>
<body ng-app="myapp" ng-controller="JobAdController">
	
	<ul>
		<li>인재상<input type="text" name="fap_job_ad_ideal_person" value="{{jobIdealPerson.fap_job_ad_ideal_person}}"></li>
			
		<li>희망연령(공통코드)
			<select name="fap_job_ad_age" ng-model="jobIdealPerson.fap_job_ad_age">
				<option selectcode value="C1400"></option>
				<option selectcode value="C1401"></option>
				<option selectcode value="C1402"></option>
				<option selectcode value="C1403"></option>
			</select>
		</li>
	</ul>
	<ul>
		<li>희망성별(공통코드)
			<select name="fap_job_ad_gender" ng-model="jobIdealPerson.fap_job_ad_gender">
				<option selectcode value="C4200"></option>
				<option selectcode value="C4201"></option>
				<option selectcode value="C4202"></option>
			</select>
		</li>
	</ul>
	<!-- ------------------------------------------------------------ -->
	<ul>
		<li>JLPT 급수(공통코드)
			<select name="fap_job_ja_level_gb" ng-model="jobIdealPerson.fap_job_ja_level.fap_job_ja_level_gb">
				<option selectcode value="C4400"></option>
				<option selectcode value="C4401"></option>
				<option selectcode value="C4402"></option>
				<option selectcode value="C4403"></option>
			</select>
		</li>
		<li>상세내용<input type="text" name="fap_job_ja_level_dtl" value="{{jobIdealPerson.fap_job_ja_level_dtl}}"></li>
	</ul>
	<!-- ------------------------------------------------------------ -->	
		
	<ul class="pref" ng-repeat="pref in jobIdealPerson.fap_job_pref">
		<li>우대사항(공통코드)
			<select name="jobPrefList[{{index}}].fap_job_pref_gb" ng-model="pref.fap_job_pref_gb">
				<option selectcode value="C4100"></option>
				<option selectcode value="C4101"></option>
				<option selectcode value="C4102"></option>
				<option selectcode value="C4103"></option>
				<option selectcode value="C4104"></option>
				<option selectcode value="C4105"></option>
			</select>
		</li>
		<li>상세내용<input type="text" name="jobPrefList[{{index}}].fap_job_pref_dtl" value="{{pref.fap_job_pref_dtl}}"></li>
	</ul>	
	<i><b><img class="fore_add" ng-click="addPref()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removePref()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
	
	<ul class="work" ng-repeat="work in jobIdealPerson.fap_job_work">	
		<li>주요업무구분(공통코드)
			<select name="jobWorkList[{{index}}].fap_job_work_gb" ng-model="work.fap_job_work_gb">
				<option selectcode value="C0300"></option>
				<option selectcode value="C0301"></option>
				<option selectcode value="C0302"></option>
				<option selectcode value="C0303"></option>
			</select>
		</li>
		<li>업무상세내용<input type="text" name="jobWorkList[{{index}}].fap_job_work_dtl" value="{{work.fap_job_work_dtl}}"></li>
	</ul>
	<i><b><img class="fore_add" ng-click="addWork()" src="<c:url value="/resources/segroup/society/edu/image/sub/plus_icon.png" />" alt="" /></b><b><img class="fore_del" ng-click="removeWork()" src="<c:url value="/resources/segroup/society/edu/image/sub/minus_icon.png" />" alt="" /></b></i>
	
	
	
	
	
	
</body>
</html>