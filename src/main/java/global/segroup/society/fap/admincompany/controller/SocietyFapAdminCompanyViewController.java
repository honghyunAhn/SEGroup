/**
 * 
 */
package global.segroup.society.fap.admincompany.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aracomm.changbi.user.service.MyLectureInfoService;
import com.aracomm.changbi.user.vo.GisuCategoryVO;
import com.aracomm.changbi.user.vo.UserScoreVO;
import com.google.gson.Gson;

import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.admincompany.service.SocietyFapAdminCompanyService;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobCategory;
import global.segroup.society.fap.company.domain.SocietyFapJobComp;
import global.segroup.society.fap.company.domain.SocietyFapJobDorm;
import global.segroup.society.fap.company.domain.SocietyFapJobFile;
import global.segroup.society.fap.company.domain.SocietyFapJobIsr;
import global.segroup.society.fap.company.domain.SocietyFapJobJaLevel;
import global.segroup.society.fap.company.domain.SocietyFapJobJitEmployee;
import global.segroup.society.fap.company.domain.SocietyFapJobJoinDt;
import global.segroup.society.fap.company.domain.SocietyFapJobPay;
import global.segroup.society.fap.company.domain.SocietyFapJobPref;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobTrial;
import global.segroup.society.fap.company.domain.SocietyFapJobWork;
import global.segroup.society.fap.company.domain.SocietyFapJobWorkplace;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.companyroadmap.service.SocietyFapCompanyRoadmapService;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.PathConstants;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자(기업기능담당) View 컨트롤러
 * 
 */
@Controller
public class SocietyFapAdminCompanyViewController implements PathConstants{
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCompanyViewController.class);

	@Autowired
	private SocietyFapAdminCompanyService sfacService;
	
	@Autowired
	private SocietyFapCompanyService sfcService;
	
	@Autowired
	private SocietyFapCompanyRoadmapService sfcrService;
	
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	@Autowired
	private MyLectureInfoService mliService;
	
	/**
	 * @Method Name : admin_job_ad_management
	 * @Date : 2019. 2. 12.
	 * @User : 이재준, 정대영(수정)
	 * @Param : -
	 * @Return : 채용공고 관리페이지 JSP
	 * @Method 설명 : 채용공고 관리페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_MANAGEMENT, method = RequestMethod.GET)
	public String admin_job_ad_management(Model model, @RequestParam(defaultValue="0") int fap_jobfair_seq, 
			@RequestParam(defaultValue="0") int fap_jobfair_divide_seq
			,@RequestParam(defaultValue="approvalRequest") String cur_seleted_btn){
		logger.debug("채용공고 관리페이지 이동 시작");
		//잡페어 리스트 담은 map (key : jobfair_list_now, jobfair_list_before,jobfair_list_after)
		HashMap<String, Object> jobfair_map = new HashMap<String, Object>();
		jobfair_map = sfcrService.select_jobfair();
		Gson gson = new Gson();
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("cur_seleted_btn", cur_seleted_btn);
		model.addAttribute("jobfair_map", gson.toJson(jobfair_map));
		logger.debug("채용공고 관리페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_ADMIN_JOB_AD_MANAGEMENT;
	}
	
	/**
	 * @Method Name : applicant_status_per_job_ad
	 * @Date : 2019. 4. 25.
	 * @User : 이종호
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : FAP 관리자 - 채용공고별 지원현황 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_JOB_AD, method = RequestMethod.POST)
	public String applicant_status_per_job_ad(Model model,int fap_jobfair_seq , int fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_en_nm, String fap_comp_id
												, String cur_seleted_btn, String fap_jobfair_title, String fap_jobfair_divide_gb) {
		logger.info("FAP 관리자 - 채용공고별 지원현황 페이지 이동 컨트롤러 시작");		
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_en_nm", fap_comp_en_nm);
		model.addAttribute("fap_comp_id", fap_comp_id);
		model.addAttribute("cur_seleted_btn", cur_seleted_btn);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_jobfair_title", fap_jobfair_title);
		model.addAttribute("fap_jobfair_divide_gb", fap_jobfair_divide_gb);
		
		Gson gson = new Gson();		
		HashMap <String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", Long.parseLong(fap_job_ad_seq));
		hashmap.put("fap_comp_id", fap_comp_id);
		
		//승인전 지원자 리스트 검색
		ArrayList<HashMap<String, Object>> approvalYetList = sfacService.admin_job_apply_approval_yet(hashmap);
		String approvalYetList_json = gson.toJson(approvalYetList);
		String replace_approvalYetList_json = approvalYetList_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("approvalYetList", replace_approvalYetList_json);
		//정규지원 진행중, 합격, 예비합격자 정보 검색
		ArrayList<HashMap<String, Object>> resultMap = sfcService.search_applicant_info(hashmap);
		String resultMap_jason = gson.toJson(resultMap);
		String replace_resultMap_jason =  resultMap_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("resultMap", replace_resultMap_jason);
		//미스매칭 진행중, 합격, 예비합격자 정보 검색
		ArrayList<HashMap<String, Object>> missResultMap = sfcService.search_missmatching_applicant_info(hashmap);
		String missResultMap_jason = gson.toJson(missResultMap);
		String replace_missResultMap_jason =  missResultMap_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("missResultMap", replace_missResultMap_jason);
		//불합격자 정보 검색
		ArrayList<HashMap<String, Object>> unaccepted_resultMap = sfcService.search_unaccepted_applicant_info(hashmap);
		String unaccepted_resultMap_jason = gson.toJson(unaccepted_resultMap);
		String replace_unaccepted_resultMap_jason =  unaccepted_resultMap_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("unacceptedResultMap", replace_unaccepted_resultMap_jason);
		//채용공고 채용전형 검색
		ArrayList<SocietyFapJobRecruitPcs> recruit_pcs = sfcService.select_job_ad_recruit_pcs(Long.parseLong(fap_job_ad_seq));
		String recruit_pcs_jason = gson.toJson(recruit_pcs);
		String replace_recruit_pcs_jason =  recruit_pcs_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("recruit_pcs", replace_recruit_pcs_jason);	
		//최종결과 입력 시한 검색
		HashMap<String, Object> final_select_info = sfcService.search_jobfair_divide_final_select_info(fap_jobfair_divide_seq);
		model.addAttribute("final_select_info", final_select_info);
		
		
		logger.info("FAP 관리자 - 채용공고별 지원현황 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_JOB_AD;
	}
	
	/**
	 * @Method Name : job_ad_insert_form
	 * @Date : 2018. 12. 24.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 채용공고 등록 JSP
	 * @Method 설명 : 채용공고 등록페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_INSERT_FORM, method = RequestMethod.GET)
	public String job_ad_insert_form(){
		logger.debug("채용공고 등록페이지 이동 시작");
		
		logger.debug("채용공고 등록페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_ADMIN_JOB_AD_INSERT_FORM;
	}
	
	/**
	 * @Method Name : job_ad_insert
	 * @Date : 2018. 12. 24.
	 * @User : 이재준
	 * @Param : 채용공고 정보(기본정보)
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 사용자로부터 입력받은 정보로 채용공고를 생성하고 채용공고 입력 페이지로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_INSERT, method=RequestMethod.POST)
	public String job_ad_insert(SocietyFapJobAd JobAd, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee
			, SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp,
			SocietyFapJobFile JobFile, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt,
			SocietyFapJobWork JobWork, SocietyFapJobCategory JobCategory
			, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace, SocietyFapJobRecruitPcs JobRecruitPcs,
			SocietyFapJobPay JobPay, Authentication auth){
			logger.debug("FAP  채용공고 등록 컨트롤러 시작");
			//logger.info("!!!{}", JobPay);
			
			/*sfcService.job_ad_insert(JobAd, JobDorm, JobJitEmployee, JobJaLevel, JobTrial, JobComp, JobFile, JobIsr, JobJoinDt
					, JobWork, JobCategory, JobPref, JobWorkplace, JobRecruitPcs, JobPay);*/
			
			logger.debug("FAP 채용공고 등록 컨트롤러 종료");
			return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_INSERT_FORM;
	}

	/**
	 * @Method Name : job_ad_update_form
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : 채용공고 정보 업데이트 폼으로 이동
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 채용공고를 수정하는 채용공고 수정 페이지로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_UPDATE_FORM, method=RequestMethod.POST)
	public String job_ad_update_form(long fap_job_ad_seq, Model model, Authentication auth){
		logger.debug("FAP 채용공고 업데이트 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("fap_comp_id", auth.getPrincipal());
		param.put("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		
		Gson gson = new Gson();
		
		// 김준영 추가
		HashMap<String, Object> job_ideal_person = sfcService.select_job_ideal_person(fap_job_ad_seq);
		model.addAttribute("job_ideal_person", gson.toJson(job_ideal_person));
		
		logger.debug("FAP 채용공고 업데이트 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : company_job_ad_read_form
	 * @Date : 2019. 2. 13.
	 * @User : 원병호
	 * @Param : 채용공고 시퀀스
	 * @Return : JSP 채용공고 읽기폼
	 * @Method 설명 : 해당 채용공고의 읽기폼으로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_READ_FORM, method=RequestMethod.GET)
	public String company_job_ad_read_form(Model model, Authentication auth, 
			long fap_job_ad_seq, String cur_seleted_btn,
			@RequestParam(defaultValue="job_ad") String return_value){
		logger.debug("FAP 관리자 채용공고 읽기 시작");
		String user_id = (String) auth.getPrincipal();
		model.addAttribute("fap_comp_id", sfcService.select_fap_comp_id(user_id));
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("cur_seleted_btn", cur_seleted_btn);
				
		Gson gson = new Gson();
		
		// 급여정보, 보험, 파일
		HashMap<String, Object> jobAd_pay = sfcService.select_job_pay(fap_job_ad_seq);		
		String jobAd_pay_jason = gson.toJson(jobAd_pay);
		String replace_jobAd_pay_jason =  jobAd_pay_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("jobAd_pay", replace_jobAd_pay_jason);
		
		// 기본 고용정보
		HashMap<String, Object> jobAd_category = sfcService.select_job_category(fap_job_ad_seq);
		String jobAd_category_jason = gson.toJson(jobAd_category);
		String replace_jobAd_category_jason =  jobAd_category_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("jobAd_category", replace_jobAd_category_jason);
		
		// 채용공고 정보, 주요 업무, 인재상, 기술상세
		HashMap<String, Object> job_ideal_person = sfcService.select_job_ideal_person(fap_job_ad_seq);
		String ideal_person_json = gson.toJson(job_ideal_person);
		String replace_ideal_person_json =  ideal_person_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("job_ideal_person", replace_ideal_person_json);
		
		// 채용공고 기본 정보
		SocietyFapJobAd jobAd = sfcService.select_job_ad(fap_job_ad_seq);
		String jobAd_json = gson.toJson(jobAd);
		String replace_jobAd_json =  jobAd_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("job_ad", replace_jobAd_json);
		
		model.addAttribute("fap_jobfair_divide_seq", jobAd.getFap_jobfair_divide_seq());
		model.addAttribute("fap_jobfair_seq", jobAd.getFap_jobfair_seq());
		
		// 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
		ArrayList<HashMap<String, Object>> job_recruit_pcs = sfcService.select_job_recruit_pcs(fap_job_ad_seq);
		String job_recruit_pcs_json = gson.toJson(job_recruit_pcs);
		String replace_job_recruit_pcs_json =  job_recruit_pcs_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("job_recruit_pcs", replace_job_recruit_pcs_json);
		
		// 채용공고 파일정보(회사소개 동영상, 사진, pdf)
		ArrayList<SocietyFapJobFile> job_file = sfcService.select_job_file(fap_job_ad_seq);
		model.addAttribute("job_file",  gson.toJson(job_file));
		
		model.addAttribute("return_value", return_value);
		
		logger.debug("FAP 관리자 채용공고 읽기 끝");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_READ_FORM;
	}
	
 
	/**
	 * @Method Name : admin_company_group_code_management_per_job_fair
	 * @Date : 2019.6.11
	 * @User : 김경아
	 * @Param : -
	 * @Return : 기업 그룹코드 설정 JSP
	 * @Method 설명 :  기업 그룹코드 설정 페이지 이동
	 */
 
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMPANY_GROUP_CODE_PER_JOB_FAIR, method = RequestMethod.GET)
	public String groupcode_per_job_fair(Model model, @RequestParam(defaultValue="0") int fap_jobfair_divide_seq,
			String fap_comp_groupcode, @RequestParam(defaultValue="desc") String order){
		logger.debug("채용공고별 기업 그룹코드 설정 페이지 이동 시작");
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("sort_info", order);
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		
		ArrayList<HashMap<String, Object>> jobFairAdList = sfaService.select_jobfair_job_ad(params);
		int fap_jobfair_seq;
		try {
			fap_jobfair_seq = (int) jobFairAdList.get(0).get("fap_jobfair_seq");
		} catch (IndexOutOfBoundsException e) {
			fap_jobfair_seq = 0;
		}
		ArrayList<HashMap<String, Object>> companyGroupcodeList = sfacService.select_current_jobfair_group_code(fap_jobfair_seq);
		HashMap<String, Object> companyGroupcode = new HashMap<>();
		companyGroupcode.put("fap_jobfair_seq", fap_jobfair_seq);
		companyGroupcode.put("fap_comp_groupcode", "D0500");
		companyGroupcode.put("fap_comp_3years_avg_sales", 0);
		companyGroupcode.put("fap_comp_stock", 0);
		companyGroupcode.put("fap_comp_employee_num", 0);
		companyGroupcodeList.add(companyGroupcode);
		ArrayList<HashMap<String, Object>> count_per_group = sfacService.select_count_per_group(fap_jobfair_divide_seq);
		model.addAttribute("sort_info", order);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("jobFairAdList", jobFairAdList);
		model.addAttribute("companyGroupcodeList", companyGroupcodeList);
		model.addAttribute("count_per_group", count_per_group);
		
		logger.debug("채용공고별 기업 그룹코드 설정 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_ADMIN_COMPANY_GROUP_CODE_PER_JOB_FAIR;
	}
 	
	
	
	/**
	 * @Method Name : admin_company_group_code_management_per_job_fair
	 * @Date : 2019.2.20 
	 * @User : 남유송
	 * @Param : -
	 * @Return : 기업 그룹코드 설정 JSP
	 * @Method 설명 : 기업 그룹코드 설정 페이지 이동
	 */
 /*
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMPANY_GROUP_CODE_PER_JOB_FAIR, method = RequestMethod.GET)
	public String groupcode_per_job_fair(Model model, @RequestParam(defaultValue="0") int fap_jobfair_divide_seq,
			String fap_comp_groupcode, @RequestParam(defaultValue="desc") String order){
		logger.debug("채용공고별 기업 그룹코드 설정 페이지 이동 시작");
		HashMap<String, Object> params = new HashMap<>();
		params.put("sort_info", order);
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		ArrayList<HashMap<String, Object>> jobFairAdList = sfaService.select_jobfair_job_ad(params);
		int fap_jobfair_seq;
		try {
			fap_jobfair_seq = (int) jobFairAdList.get(0).get("fap_jobfair_seq");
		} catch (IndexOutOfBoundsException e) {
			fap_jobfair_seq = 0;
		}
		ArrayList<HashMap<String, Object>> companyGroupcodeList = sfacService.select_current_jobfair_group_code(fap_jobfair_seq);
		HashMap<String, Object> companyGroupcode = new HashMap<>();
		companyGroupcode.put("fap_jobfair_seq", fap_jobfair_seq);
		companyGroupcode.put("fap_comp_groupcode", "D0500");
		companyGroupcode.put("fap_comp_3years_avg_sales", 0);
		companyGroupcode.put("fap_comp_stock", 0);
		companyGroupcode.put("fap_comp_employee_num", 0);
		companyGroupcodeList.add(companyGroupcode);
		ArrayList<HashMap<String, Object>> count_per_group = sfacService.select_count_per_group(fap_jobfair_divide_seq);
		model.addAttribute("sort_info", order);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("jobFairAdList", jobFairAdList);
		model.addAttribute("companyGroupcodeList", companyGroupcodeList);
		model.addAttribute("count_per_group", count_per_group);
		
		logger.debug("채용공고별 기업 그룹코드 설정 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_ADMIN_COMPANY_GROUP_CODE_PER_JOB_FAIR;
	}
 */
	
	/**
	 * @Method Name : admin_job_qna_management
	 * @Date : 2019. 4. 29.
	 * @User : 이종호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 관리자 채용공고별 Q&A 관리 페이지 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOB_QNA_MANAGEMENT, method = RequestMethod.GET)
	public String admin_job_qna_management(Model model, Authentication auth, long fap_job_ad_seq, int fap_jobfair_seq , int fap_jobfair_divide_seq , String cur_selected_btn){
		logger.info("FAP 관리자 채용공고별 Q&A 이동 컨트롤러 시작");	
		
		ArrayList<HashMap<String, Object>> job_qna_list = sfuService.select_job_qna(fap_job_ad_seq);
		
		Gson gson = new Gson();
		
		model.addAttribute("job_qna_list", gson.toJson(job_qna_list));
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("cur_selected_btn", cur_selected_btn);
		
		logger.info("FAP 관리자 채용공고별 Q&A 이동 컨트롤러 종료");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOB_QNA_MANAGEMENT;
	}
	
	/**
	 * @Method Name : admin_job_qna
	 * @Date : 2019. 4. 29.
	 * @User : 이종호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 관리자 채용공고별 해당 Q&A 상세
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOB_QNA, method = RequestMethod.GET)
	public String admin_job_qna(Model model, Authentication auth, long fap_job_qna_question_seq){
		logger.info("FAP 관리자 채용공고별 해당 Q&A 상세 컨트롤러 시작");	
		
		HashMap<String, Object> job_qna = sfcService.select_job_qna_one(fap_job_qna_question_seq);
		String fap_job_qna_question_ins_id = (String)job_qna.get("fap_job_qna_question_ins_id");
		String user_id = (String) auth.getPrincipal();
		
		boolean is_editable = false;
		String fap_job_qna_question_per = (String)job_qna.get("fap_job_qna_question_per");
		if(fap_job_qna_question_ins_id.equals(user_id)){
			if(fap_job_qna_question_per.equals("C5100")){
				is_editable = true;		//자신이 쓴글과 아직 승인되지 않은 글만 수정이 가능하다.
			}
		}
		
		long fap_job_ad_seq = (long)(job_qna.get("fap_job_ad_seq"));
		
		Gson gson = new Gson();
		
		model.addAttribute("job_qna", job_qna);
		model.addAttribute("job_qna_json", gson.toJson(job_qna));
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("is_editable", is_editable);
		
		logger.info("FAP 관리자 채용공고별 해당 Q&A 상세 컨트롤러 종료");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOB_QNA;
	}
	
	/**
	 * @Method Name : job_applicant_resume_print_form
	 * @Date : 2019. 4. 29.
	 * @User : 이종호
	 * @Param : 이력서 시퀀스 배열
	 * @Return : 
	 * @Method 설명 : 프린트 할 이력서 정보 조회
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOB_APPLICANT_RESUME_PRINT_FORM, method = RequestMethod.POST)
	public String job_applicant_resume_print_form(int[] fap_resume_seq, Model model) {
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<>();
		
		for(int num : fap_resume_seq) {
			HashMap<String, Object> param = new HashMap<>();
			param.put("fap_resume_seq", num);
			HashMap<String, Object> resume = new HashMap<>();
			resume =	sfuService.selectResumeApply(param);
			result.add(resume);
		}
		
		ArrayList<String> resume_json_list = new ArrayList<>();
		Gson gson = new Gson();
		
		for(HashMap<String, Object> map : result) {
			String wholeResume_json = gson.toJson(map);
			String replace_wholeResume_json = wholeResume_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
			resume_json_list.add(replace_wholeResume_json);
		}
		
		model.addAttribute("resume_json_list", resume_json_list);
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOB_APPLICANT_RESUME_PRINT_FORM;
	}
	
	/**
	 * @Method Name : job_applicant_score_print_form
	 * @Date : 2020. 10. 16.
	 * @User : 양승균
	 * @Param : 잡페어 seq, 회사 seq, 잡페어 이름, 회사 영문명, 잡페어 구분(서울/도쿄 등)
	 * @Return : 
	 * @Method 설명 : 프린트 할 성적표 정보 조회
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOB_APPLICANT_SCORE_PRINT_FORM, method = RequestMethod.POST)
	public String applicant_score_print_form(int fap_jobfair_seq, int fap_job_ad_seq, String jobfair_title, String comp_en_nm, String jobfair_divide_gb
											,Model model, Authentication auth) {
		HashMap<String, Object> param = new HashMap<>();
		List<HashMap<String, Object>> courseList = new ArrayList<>();
		List<HashMap<String, String>> studentList = new ArrayList<>();
		List<List<HashMap<String, Object>>> gradeRate = new ArrayList<>();
		List<List<HashMap<String, String>>> gisuGrade = new ArrayList<>();
		List<HashMap<String, String>> cList = new ArrayList<>();
		
		HashMap<String, String> list = new HashMap<>();
		list.put("crc_id", "c000000525");
		list.put("gisu_id", "n000000349");
		cList.add(list);
		HashMap<String, String> list1 = new HashMap<>();
		list1.put("crc_id", "c000000524");
		list1.put("gisu_id", "n000000343");
		cList.add(list1);
		HashMap<String, String> list2 = new HashMap<>();
		list2.put("crc_id", "c000000522");
		list2.put("gisu_id", "n000000341");
		cList.add(list2);
		
		param.put("fap_jobfair_seq", fap_jobfair_seq);
		param.put("fap_job_ad_seq", fap_job_ad_seq);
		
		Gson gson = new Gson();
		
		ArrayList<HashMap<String, Object>> wholeScore = sfuService.selectFapOpened(param);
		
		System.out.println(wholeScore.toString());
		
		for(int a = 0; a < wholeScore.size(); a++) {
		//for(int a = 0; a < cList.size(); a++) {
			HashMap<String, Object> info = wholeScore.get(a);
			
			if(!String.valueOf(info.get("ISOPENED")).equalsIgnoreCase("Y")) {
				continue;
			}
			
			String crc_id = String.valueOf(info.get("CB_COURSE_SEQ"));
			String gisu_id = String.valueOf(info.get("CB_CARDINAL_SEQ"));
			/*HashMap<String, String> c = cList.get(a);
			
			String crc_id = c.get("crc_id");
			String gisu_id = c.get("gisu_id");*/
			
			UserScoreVO vo = new UserScoreVO();
			GisuCategoryVO testVO = new GisuCategoryVO();
			
			vo.setCrc_id(crc_id);
			vo.setGisu_id(gisu_id);
			testVO.setCrc_id(crc_id);
			testVO.setGisu_id(gisu_id);
			param.put("crc_id", crc_id);
			param.put("gisu_id", gisu_id);
			
			List<HashMap<String, String>> testInfo = mliService.searchtUserTestInfo(vo);
			List<HashMap<String, String>> catInfo = mliService.searchtCategoryInfo(vo);
			List<HashMap<String, String>> needInfo = new ArrayList<HashMap<String,String>>();
			List<HashMap<String, String>> haveNotInfo = new ArrayList<HashMap<String,String>>();
			List<HashMap<String, String>> memberList = mliService.TestListAll(testVO);
			List<HashMap<String, String>> testInfoM = new ArrayList<HashMap<String,String>>();
			List<String> mL = new ArrayList<String>();
			HashMap<String, HashMap<Integer,Double>> testInfoMember = new HashMap<String, HashMap<Integer,Double>>();
			HashMap<String, Object> fail = new HashMap<>();
			int failCount = 0;
			
			for(int i = 0; i < memberList.size(); i++) {
				if(String.valueOf(memberList.get(i).get("state")).equalsIgnoreCase("A1801")) {
					failCount++;
					memberList.remove(i);
					i--;
				}
			}
			
			fail.put("Fail", String.valueOf(failCount));
			
			for (int i = 0; i < testInfo.size(); i++) {
				if (String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase("NULL") || String.valueOf(testInfo.get(i).get("TEST_SEQ")).equalsIgnoreCase(null)) {
					haveNotInfo.add(testInfo.get(i));
					testInfo.remove(i);
					i--;
				}
			}
			for (int i = 0; i < memberList.size(); i++) {
				mL.add(String.valueOf(memberList.get(i).get("USER_ID")));
				testInfoM.add(new HashMap<String,String>());
				testInfoM.get(i).put("USER_ID", String.valueOf(memberList.get(i).get("USER_ID")));
				testInfoM.get(i).put("GISU_ID", String.valueOf(memberList.get(i).get("CARDINAL_ID")));
			}
				
			HashMap<String, String> testCount = new HashMap<>();
			
			for(int i = 0; i < catInfo.size(); i++) {
				if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
					int count = mliService.testCount(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
					testCount.put(String.valueOf(catInfo.get(i).get("CAT_SEQ")), String.valueOf(count));				
				}
			}
			
			for (int i = 0; i < testInfo.size(); i++) {
				String user_id = String.valueOf(testInfo.get(i).get("USER_ID"));
				
			//	System.out.println("testInfo [ " +i+" ] : "+ testInfo.get(i).toString());
				if (testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID")))==null) {
					testInfoMember.put(String.valueOf(testInfo.get(i).get("USER_ID")),new HashMap<Integer, Double>());
				}
				
				double addScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("SCORE")))+Double.parseDouble(String.valueOf(testInfo.get(i).get("PLUS_SCORE")));
				double totalScore = Double.parseDouble(String.valueOf(testInfo.get(i).get("TOTAL_SCORE")));
				
				double userScore = 0.00;
				if (addScore >= totalScore) {
					userScore = totalScore;
				}else {
					userScore = addScore;
				}
				testInfoMember.get(String.valueOf(testInfo.get(i).get("USER_ID"))).put(Integer.parseInt(String.valueOf(testInfo.get(i).get("CAT_SEQ"))), userScore);
				for (int j = 0; j < testInfoM.size(); j++) {
					if (String.valueOf(testInfoM.get(j).get("USER_ID")).equalsIgnoreCase(user_id)) {
						
						if(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ"))) != null) {
							double score = userScore + Double.parseDouble(String.valueOf(testInfoM.get(j).get(String.valueOf(testInfo.get(i).get("CAT_SEQ")))));
							testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(score));
							
						} else {
							testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("CAT_SEQ")), String.valueOf(userScore));
						}
						
						testInfoM.get(j).put(String.valueOf(testInfo.get(i).get("TEST_NM")), String.valueOf(userScore));
						break;
					}
				}
			}
			
			for(int i = 0; i < catInfo.size(); i++) {
				if(!String.valueOf(catInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && !String.valueOf(catInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
					String cat = String.valueOf(catInfo.get(i).get("CAT_SEQ"));
				
					for(int j = 0; j < testInfoM.size(); j++) {
					//	System.out.println("testinfoM = " + String.valueOf(testInfoM.get(j).get(cat)));
						if(!(String.valueOf(testInfoM.get(j).get(cat)).equalsIgnoreCase("null"))) {
							double score = Double.parseDouble(String.valueOf(testInfoM.get(j).get(cat)));
							double total = Double.parseDouble(String.valueOf(testCount.get(cat)));
							double finalScore = score/total;
							/*	System.out.println("score = " + score + "total = " + total + " final = " + finalScore);*/
							testInfoM.get(j).put(cat, String.valueOf(Math.round(finalScore*100)/100.0));
						}
					}
				}
			}
			
			// 중분류 가져오기..
			for (int i = 0; i < catInfo.size(); i++) {
				Integer cat_seq = Integer.parseInt(String.valueOf(catInfo.get(i).get("CAT_SEQ")));
				int nm = cat_seq;	
				for (int j = 0; j < mL.size(); j++) {
					if (!(testInfoMember.containsKey(mL.get(j)))) {
						continue;	
					}
					if (testInfoMember.get(mL.get(j)).containsKey(nm)) {
							needInfo.add(catInfo.get(i));
							break;
					}
				}
			}
					
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < catInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j))))) {
						needInfo.add(catInfo.get(j));
					}
				}
			}
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < catInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("BIG_CAT_SEQ")).equalsIgnoreCase(String.valueOf(catInfo.get(j).get("CAT_SEQ"))) && (!(needInfo.contains(catInfo.get(j)))) && String.valueOf(needInfo.get(i).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						needInfo.add(catInfo.get(j));
					}
				}
			}
			for (int i = 0; i < needInfo.size(); i++) {
				for (int j = 0; j < testInfo.size(); j++) {
					if (String.valueOf(needInfo.get(i).get("CAT_SEQ")).equalsIgnoreCase(String.valueOf(testInfo.get(j).get("CAT_SEQ")))) {
						needInfo.get(i).put("TOTAL_SCORE", String.valueOf(testInfo.get(j).get("TOTAL_SCORE")));
						break;
					}
				}
			}
					
//			for (int i = 0; i < needInfo.size(); i++) {
//				System.out.println("needInfo ["+i+"] : "+needInfo.get(i).toString());
//			}
			// 중분류 점수 구하기
			HashMap<String,Double> percent = new HashMap<String,Double>();
			for (int i = 0; i < testInfoM.size(); i++) {	
				for (int j = 0; j < needInfo.size(); j++) {
					if (String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					String total_score = String.valueOf(needInfo.get(j).get("TOTAL_SCORE"));
					if (i==0) {
						if (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))) == null && needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0") {
							percent.put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), Double.parseDouble(cat_percent));
						}else if(needInfo.get(j).get("MID_CAT_SEQ") != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
							percent.replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))+Double.parseDouble(cat_percent)));
						}	
					}

					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						if (total_score != "null" && Double.parseDouble(total_score)!=100) {
							fixedScore = fixedScore * (100/(Double.parseDouble(total_score)));
						}
						if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))== null && needInfo.get(j).get("BIG_CAT_SEQ") != "0" && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0") {
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
						} else if(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")))!=null && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")) != "0" && needInfo.get(j).get("BIG_CAT_SEQ") != "0"){
							fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")), String.valueOf(fixedScore));				
						}
					}
				}
			}
			
//			for (int i = 0; i < testInfoM.size(); i++) {
//				System.out.println("testInfoM 확인2 : "+ testInfoM.get(i).toString());
//			}
			
			// 대분류 점수 구하기
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					
					if (i==0) {
						if (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))) == null) {
							percent.put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), Double.parseDouble(cat_percent));
						}else {
							percent.replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), (percent.get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))+Double.parseDouble(cat_percent)));
						}	
					}
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						
						if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")))== null) {
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(Math.round(fixedScore*100)/100.0));
						} else {
							fixedScore = Double.parseDouble(testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ"))))+Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")), String.valueOf(fixedScore));				
						}
					}
				}
			}
			
			// 소수점 맞추기
			Iterator<String> keys = percent.keySet().iterator();
        	while (keys.hasNext()){
                	String key = keys.next();					
                for (int i = 0; i < testInfoM.size(); i++) {
                	if (testInfoM.get(i).get(key)==null) {
						continue;
					}
                	double score = Double.parseDouble(testInfoM.get(i).get(key)) * Math.round((100.0/percent.get(key)*100)/100.0);
                	testInfoM.get(i).replace(key, String.valueOf(Math.round(score*100)/100.0));
                } 
			}
        	
			// 종합 성적 구하기
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if ((!(String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0"))) || (!(String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0")))) {
						continue;
					}
					String cat_seq = String.valueOf(needInfo.get(j).get("CAT_SEQ"));
					String cat_percent = String.valueOf(needInfo.get(j).get("CAT_PERCENT"));
					if (testInfoM.get(i).get(cat_seq) != null) {
						Double fixedScore = Double.parseDouble(testInfoM.get(i).get(cat_seq))*(Double.parseDouble(cat_percent)/100);
						if (testInfoM.get(i).get("TOTAL") == null) {
							testInfoM.get(i).put("TOTAL", String.valueOf(Math.round(fixedScore*100)/100.0));
						} else {
							fixedScore = Double.parseDouble(testInfoM.get(i).get("TOTAL"))+(Math.round(fixedScore*100)/100.0);
							fixedScore = Math.round(fixedScore*100)/100.0;
							testInfoM.get(i).replace("TOTAL", String.valueOf(fixedScore));
						}
					}
					
				}
			}

			for (int i = 0; i < testInfoM.size(); i++) {
				if (testInfoM.get(i).get("TOTAL") == null) {
					testInfoM.remove(i);
					i--;
				}
			}
			
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < memberList.size(); j++) {
					if (String.valueOf(testInfoM.get(i).get("USER_ID")).equalsIgnoreCase(String.valueOf(memberList.get(j).get("USER_ID")))) {
						testInfoM.get(i).put("USER_NM", String.valueOf(memberList.get(j).get("USER_NAME")));
						break;
					}
				}
			}
			
			List<String> cat_nm = new ArrayList<>(); 
			
			for (int i = 0; i < testInfoM.size(); i++) {
				for (int j = 0; j < needInfo.size(); j++) {
					if (testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ"))) != null) {
						String score = testInfoM.get(i).get(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
						if (String.valueOf(needInfo.get(j).get("BIG_CAT_SEQ")).equalsIgnoreCase("0") && String.valueOf(needInfo.get(j).get("MID_CAT_SEQ")).equalsIgnoreCase("0")) {
							testInfoM.get(i).put(String.valueOf(needInfo.get(j).get("CAT_NM")), score);
							if(i == 0) {
								cat_nm.add(String.valueOf(needInfo.get(j).get("CAT_NM")));
							}
						}
						testInfoM.get(i).remove(String.valueOf(needInfo.get(j).get("CAT_SEQ")));
					}
				}
			}
			
			for (int i = 0; i < testInfoM.size(); i++) {
				System.out.println("testInfoM 확인 : "+ testInfoM.get(i).toString());
			}
		
			List<HashMap<String, String>> grade = mliService.searchGrade(param);
			
			gisuGrade.add(grade);
			
			List<HashMap<String, String>> newInfo = new ArrayList<>();
			
			for(int i = 0; i < testInfoM.size(); i++) {
				HashMap<String, String> map = new HashMap<>();
				for(int j = 0; j < grade.size(); j++) {
					if(Double.parseDouble(String.valueOf(grade.get(j).get("START_SCORE"))) > Double.parseDouble(testInfoM.get(i).get("TOTAL")) && Double.parseDouble(String.valueOf(grade.get(j).get("END_SCORE"))) <= Double.parseDouble(testInfoM.get(i).get("TOTAL"))) {
						map.put("TOTAL", grade.get(j).get("GRADE"));
					}
				}
				map.put("USER_ID", testInfoM.get(i).get("USER_ID"));
				map.put("GISU_ID", testInfoM.get(i).get("GISU_ID"));
				newInfo.add(map);
			}
			
			for(int i = 0; i < testInfoM.size(); i++) {
				for(int z = 0; z < cat_nm.size(); z++) {
					for(int j = 0; j < grade.size(); j++) {
						if(Double.parseDouble(String.valueOf(grade.get(j).get("START_SCORE"))) > Double.parseDouble(testInfoM.get(i).get(cat_nm.get(z))) && Double.parseDouble(String.valueOf(grade.get(j).get("END_SCORE"))) <= Double.parseDouble(testInfoM.get(i).get(cat_nm.get(z)))) {
							newInfo.get(i).put(cat_nm.get(z), String.valueOf(grade.get(j).get("GRADE")));
						}
					}
				}
			}
			
			int allMember = testInfoM.size();
			
			if(!String.valueOf(fail.get("Fail")).equalsIgnoreCase("0")) {
				allMember += fail.size();
			} 
			
			List<HashMap<String, Object>> gradeMap = new ArrayList<>();
			   
			for(int j = 0; j < grade.size(); j++) {
				HashMap<String, Object> map = new HashMap<>();
				
				int count = 0;
				for(int i = 0; i < newInfo.size(); i++) {
					if(grade.get(j).get("GRADE").equalsIgnoreCase(newInfo.get(i).get("TOTAL"))) {
						count++;
					}
				}
//				System.out.println("count = " + count);

				double ratio = (double)count/allMember;
				double ratio2 = ratio*100.0;
				String gradeR = String.valueOf(Math.round(ratio2*100)/100.0);
				
				map.put("GRADE_SEQ", grade.get(j).get("GRADE_SEQ"));
				map.put("GRADE", grade.get(j).get("GRADE"));
				map.put("PERCENT", gradeR);
				map.put("CARDINAL_ID", gisu_id);
				
				gradeMap.add(map);
			}
			
			double ratio = (Double.parseDouble(String.valueOf(fail.get("Fail")))/allMember)*100.0;
			fail.put("GRADE", "Fail");
			fail.put("PERCENT", String.valueOf(Math.round(ratio*100)/100.0));
			fail.put("CARDINAL_ID", gisu_id);
			fail.remove("Fail");
			gradeMap.add(fail);			
			gradeRate.add(gradeMap);
			
			ArrayList<HashMap<String, Object>> name = sfuService.selectScoreList(param);
			
			List<HashMap<String, String>> user_name = new ArrayList<>();
			StringBuilder str = new StringBuilder();
			
			for(int i = 0; i < newInfo.size(); i++) {
				String n = newInfo.get(i).get("USER_ID");
				HashMap<String, String> map = new HashMap<>();
				
				for(int j = 0; j < name.size(); j++) {
					if(String.valueOf(name.get(j).get("FAP_RESUME_LANG_GB")).equalsIgnoreCase("B3103") && n.equalsIgnoreCase(String.valueOf(name.get(j).get("FAP_RESUME_NM_INS_ID")))) {
						str.append(name.get(j).get("FAP_RESUME_NM"));
					} else if(String.valueOf(name.get(j).get("FAP_RESUME_LANG_GB")).equalsIgnoreCase("B3101") && n.equalsIgnoreCase(String.valueOf(name.get(j).get("FAP_RESUME_NM_INS_ID")))) {
						str.append("("+name.get(j).get("FAP_RESUME_NM")+")");
					}
				}
				
				if(str.length() != 0) {
					map.put("USER_ID", n);
					map.put("USER_NAME", str.toString());
					user_name.add(map);
					str.delete(0, str.length());
				}
			}
			
			for(int i = 0; i < user_name.size(); i++) {
				System.out.println("name = " + user_name.get(i).toString());
			}
			
			//List<HashMap<String, String>> realUser = new ArrayList<>();
			int ck = 0;
			for(int i = 0; i < newInfo.size(); i++) {
				for(int j = 0; j < user_name.size(); j++) {
					if(newInfo.get(i).get("USER_ID").equalsIgnoreCase(user_name.get(j).get("USER_ID"))) {
						ck++;
						newInfo.get(i).put("USER_NAME", user_name.get(j).get("USER_NAME"));
						studentList.add(newInfo.get(i));
						//realUser.add(newInfo.get(i));
					}
				}
			}
			
//			System.out.println("student = " + studentList.toString());
			
			HashMap<String, Object> course = new HashMap<>();
			course.put("COURSE_NAME", info.get("CB_COURSE_JP_NM"));
			course.put("CARDINAL_NAME", memberList.get(0).get("CARDINAL_NAME"));
			course.put("CARDINAL_ID", gisu_id);
			
			for(int i = 0; i < cat_nm.size(); i++) {
				course.put("SUBJECT_"+i, cat_nm.get(i));
			}
			
			course.put("STUDENT_CNT", ck);
			courseList.add(course);
		}
		model.addAttribute("courseList", gson.toJson(courseList));
		model.addAttribute("studentList", gson.toJson(studentList));
		model.addAttribute("gradeRate", gson.toJson(gradeRate));
		model.addAttribute("gisuGrade", gson.toJson(gisuGrade));
		
		// 회사명, 잡페어 이름, 잡페어 구분(서울/도쿄)
		model.addAttribute("comp_en_nm", comp_en_nm);
		model.addAttribute("jobfair_title", jobfair_title);
		model.addAttribute("jobfair_gb", jobfair_divide_gb);
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOB_APPLICANT_SCORE_PRINT_FORM;
	}
}
