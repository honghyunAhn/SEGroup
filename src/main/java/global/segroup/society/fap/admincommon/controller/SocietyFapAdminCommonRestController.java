/**
 * 
 */
package global.segroup.society.fap.admincommon.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import global.segroup.domain.AdminPager;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFinalDecisionTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfair;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivide;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairSet;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtResume;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobAdShow;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.companyroadmap.domain.SocietyFapCompanyRoadmapJobfairDivide;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUser;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.FileService;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * 
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자 Rest 컨트롤러
 * 
 */

@Controller
public class SocietyFapAdminCommonRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCommonRestController.class);

	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	@Autowired
	private SocietyFapCompanyService sfcService;
	
	@Autowired
	private SocietyFapUserService sfuService;
	
	/**
	 * file.propertices 의 채용전형 시험 파일 경로
	 */
	@Value("#{props['fap.company.job_recruit_exam_file']}")
	private String fapCompanyJobRecruitExamFile;
	
	/**
	
	/**
	 * file.propertices 의 채용전형 시험 파일 경로
	 */
	@Value("#{props['fap.admin.job_recruit_exam_file']}")
	private String fapAdminJobRecruitExamFile;
	
		
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2018. 12. 4.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 잡페어 정보 검색 리스트
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminJobfair> jobfair_search_list(Model model, @RequestParam(defaultValue = "") String fap_jobfair_opening_flag){
		logger.info("잡페어 리스트 검색 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening_flag", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		
		logger.info("잡페어 리스트 검색 종료");		
		return jobfairList;
	}
	
	/**
	 * @Method Name : search_jobfair_user_apply_info
	 * @Date : 2018. 12. 20.
	 * @User : 신동철
	 * @Param : (잡페어 시퀀스, 회원타입, 승인여부)
	 * @Return : 잡페어 지원자 신청 등록 정보
	 * @Method 설명 : 잡페어 지원자 신청 등록 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_SEARCH_USER_APPLY_INFO, method = RequestMethod.POST)
	public HashMap<String, Object> search_jobfair_user_apply_info(Model model, 
			@RequestParam(defaultValue = "0") int fap_jobfair_seq,	@RequestParam(defaultValue = "") String user_flag, 
			@RequestParam(defaultValue = "") String fap_jobfair_user_per, @RequestParam(defaultValue = "") String user_nm, 
			@RequestParam(defaultValue = "1") String curPage, @RequestParam(defaultValue = "10") String pageCount, 	
			@RequestParam(defaultValue = "") String orderType, @RequestParam(defaultValue = "") String orderValue){
		logger.info("잡페어 지원자 신청 등록 정보 검색 컨트롤러 시작");
		
		if(fap_jobfair_seq == 0 && user_flag.equals("") &&  fap_jobfair_user_per.equals("") && user_nm.equals("") ){
			return null;
		}		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("fap_jobfair_seq", fap_jobfair_seq);
		map.put("user_flag", user_flag);
		map.put("fap_jobfair_user_per", fap_jobfair_user_per);
		map.put("user_nm", user_nm);
		map.put("curPage", curPage);
		map.put("pageCount", pageCount);
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);		
		int count = sfaService.select_jobfair_apply_count(map);
		map.put("count", count); // 레코드의 갯수
		AdminPager.setPAGE_SCALE(Integer.parseInt(pageCount));
		AdminPager adminPager = new AdminPager(count, Integer.parseInt(curPage));
		map.put("adminPager", adminPager); // 페이징 객체
		ArrayList<HashMap<String, Object>> resultList = sfaService.search_jobfair_user_apply_info(map);
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("pageCount", pageCount);
		resultMap.put("resultList", resultList);
		resultMap.put("adminPager", adminPager);
		resultMap.put("totalCount", count); // 총 레코드 갯수 모델에 담기 위함
		
		logger.info("잡페어 지원자 신청 등록 정보 검색 컨트롤러 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : search_jobfair_user_edu_info
	 * @Date : 2019. 7. 17.
	 * @User : 이종호
	 * @Param : 잡페어 신청자 정보
	 * @Return : 잡페어 신청자 학력정보
	 * @Method 설명 : 잡페어 신청자 학력정보 팝업 호출
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_SEARCH_USER_EDU_INFO, method = RequestMethod.POST)
	public HashMap<String, Object> search_jobfair_user_edu_info(SocietyFapPersonalUser societyFapPersonalUser){
		User user = sfuService.select_com_user(societyFapPersonalUser.getUser_id());
		HashMap<String, Object> edu = sfuService.select_personal_school(societyFapPersonalUser);
		
		HashMap<String, Object> result = new HashMap<>();
		result.put("user", user);
		result.put("edu", edu);
		
		return result;
	}
	
	/**
	 * @Method Name : select_all_job_fair_divide
	 * @Date : 2018. 12. 31.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 잡페어별 잡페어 상세 구분코드, 일련번호 출력
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_FAIR_DIVIDE_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminJobfairDivide> select_all_job_fair_divide(int fap_jobfair_seq){
		logger.info("잡페어별 잡페어 세부정보 검색 컨트롤러 시작");
		ArrayList<SocietyFapAdminJobfairDivide> jobFairDividedMap = sfaService.select_fap_jobfair_divide(fap_jobfair_seq);
		for (int i = 0; i < jobFairDividedMap.size(); i++) {
			System.out.println(jobFairDividedMap.toString());
		}
		logger.info("잡페어별 잡페어 세부정보 검색컨트롤러 종료");
		return jobFairDividedMap;
	}
	
	/**
	 * @Method Name : read_all_job_fair_ad_list
	 * @Date : 2018. 01. 02.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 잡페어별 채용공고 리스트 출력
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_FAIR_AD_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_jobfair_job_ad(int fap_jobfair_divide_seq){
		logger.info("잡페어별 채용공고 리스트 출력 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		ArrayList<HashMap<String, Object>> jobFairAdList = sfaService.select_jobfair_job_ad(params);
		logger.info("잡페어별 채용공고 리스트 출력 컨트롤러 종료");
		return jobFairAdList;
	}
	
	/**
	 * @Method Name : comp_user_connect_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 변경 할 연결 객체 seq, 변경 할 승인 상태
	 * @Return : -
	 * @Method 설명 : 변경 할 연결 객체를 변경 할 승인 상태로 변경 하는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT_UPDATE, method = RequestMethod.POST)
	public void comp_user_connect_update(@RequestParam(defaultValue="") ArrayList<Integer> seq_list, String fap_comp_user_connect_ck){
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 변경 컨트롤러 시작");
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("seq_list", seq_list);
		hashMap.put("fap_comp_user_connect_ck", fap_comp_user_connect_ck);
		sfaService.connect_update(hashMap);
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 변경 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : connect_all_update
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : 기존 승인 상태, 변경 할 승인 상태
	 * @Return : -
	 * @Method 설명 : 기존 승인 상태와 일치하는 모든 연결 객체를 변경 할 승인 상태로 변경하는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_CONNECT_ALL_UPDATE, method = RequestMethod.POST)
	public void connect_all_update(String origin_ck, String update_ck){
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 전부 변경 컨트롤러 시작");
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("origin_ck", origin_ck);
		hashMap.put("update_ck", update_ck);
		sfaService.connect_all_update(hashMap);
		logger.info("FAP 관리자 담당자 - 기업 연결 승인 상태 전부 변경 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : connect_delete
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 기업 - 담당자 연결 seq list
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결을 끊는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT_DELETE, method = RequestMethod.POST)
	public void connect_delete(@RequestParam(defaultValue="") ArrayList<Integer> seq_list){
		logger.info("FAP 관리자 담당자 - 기업 연결 삭제 컨트롤러 시작");
		sfaService.connect_delete(seq_list);
		logger.info("FAP 관리자 담당자 - 기업 연결 삭제 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : select_my_applied_resume
	 * @Date : 2018. 01. 04.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 채용공고별 지원자 이력서 가져오기
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_APPLIED_RESUME_LIST, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String select_my_applied_resume(String user_id, int fap_resume_seq, Model model){
		logger.info("채용공고별 지원자 이력서 리스트 출력 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", user_id);
		param.put("fap_resume_seq", fap_resume_seq);
		HashMap<String, Object> wholeResume = sfuService.selectResumeApply(param);
		Gson gson = new Gson();
		logger.info("채용공고별 지원자 이력서 리스트 리스트 출력 컨트롤러 종료");
		return gson.toJson(wholeResume);
	}
	
	/**
	 * @Method Name : company_user_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : 연결 할 유저 아이디 리스트, 연결 할 기업 아이디
	 * @Return : -
	 * @Method 설명 : 기업과 담당자를 연결하는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT, method = RequestMethod.POST)
	public void company_user_connect(@RequestParam(defaultValue="") ArrayList<String> user_id_list, String fap_comp_id){
		logger.info("FAP 기업 - 담당자 연결 컨트롤러 시작");
		sfaService.insert_comp_user_connect(user_id_list, fap_comp_id);
		logger.info("FAP 기업 - 담당자 연결 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : agency_company_connect
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 기업 아이디 리스트, 에이전시 아이디
	 * @Return : - 
	 * @Method 설명 : 에이전시와 기업을 연결하는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT, method = RequestMethod.POST)
	public void agency_company_connect(@RequestParam(defaultValue="") String company_id, String agency_id){
		logger.info("FAP 에이전시 - 기업 연결 컨트롤러 시작");
		sfaService.connect_ag_comp(company_id, agency_id);
		logger.info("FAP 에이전시 - 기업 연결 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : agency_company_connect_delete
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체 seq 리스트
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결을 끊는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_DELETE, method = RequestMethod.POST)
	public void agency_company_connect_delete(@RequestParam(defaultValue="") ArrayList<Integer> seq_list){
		logger.info("FAP 에이전시 - 기업 연결 끊기 컨트롤러 시작");
		sfaService.ag_comp_connect_delete(seq_list);
		logger.info("FAP 에이전시 - 기업 연결 끊기 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : agency_company_connect_update
	 * @Date : 2019. 1. 8.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체 seq 리스트, 변경 할 승인 상태
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결 승인 상태를 변경 하는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_UPDATE, method = RequestMethod.POST)
	public void agency_company_connect_update(@RequestParam(defaultValue="") ArrayList<Integer> seq_list, String fap_ag_comp_connect_ck){
		logger.info("FAP 에이전시 - 기업 연결 업데이트 컨트롤러 시작");
		sfaService.ag_comp_connect_update(seq_list, fap_ag_comp_connect_ck);
		logger.info("FAP 에이전시 - 기업 연결 업데이트 컨트롤러 종료");
	}
		
	/**
	 * @Method Name : search_job_ad_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 잡페어세부 시퀀스, 채용전형 설정여부, 회사명
	 * @Return : 채용공고 정보
	 * @Method 설명 : 채용공고 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_INFO_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_job_ad_info(Model model, Authentication auth, @RequestParam(defaultValue = "0") int fap_jobfair_seq,
			@RequestParam(defaultValue = "0") int fap_jobfair_divide_seq, @RequestParam(defaultValue = "") String fap_job_recruit_pcs_sch_ck, @RequestParam(defaultValue = "") String comp_nm){
		logger.info("채용공고 정보 검색 컨트롤러 시작");
		
		if(fap_jobfair_seq == 0 && fap_jobfair_divide_seq == 0 &&  fap_job_recruit_pcs_sch_ck.equals("") && comp_nm.equals("") ){
			System.out.println("미선택");
			return null;
		}		
		ArrayList<HashMap<String, Object>> job_ad_info_list= sfaService.search_job_ad_info(fap_jobfair_seq, fap_jobfair_divide_seq, fap_job_recruit_pcs_sch_ck, comp_nm);

		logger.info("채용공고 정보 검색 컨트롤러 종료");
		return job_ad_info_list;
	}
	
	/**
	 * @Method Name : search_recruit_process_info
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : (잡페어 시퀀스, 잡페어 세부 시퀀스, 설정여부, 회사명)
	 * @Return : 채용전형 일정관리 페이지
	 * @Method 설명 :채용전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_RECRUIT_PROCESS_INFO_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_recruit_process_info(Model model, Authentication auth, @RequestParam(defaultValue = "0") int fap_jobfair_seq,
			@RequestParam(defaultValue = "0") int fap_jobfair_divide_seq, @RequestParam(defaultValue = "") String fap_job_recruit_pcs_sch_ck, @RequestParam(defaultValue = "") String comp_nm){
		logger.info("채용전형 정보 검색 컨트롤러 시작");
		
		if(fap_jobfair_seq == 0 && fap_jobfair_divide_seq == 0 &&  fap_job_recruit_pcs_sch_ck.equals("") && comp_nm.equals("") ){
			System.out.println("미선택");
			return null;
		}
		ArrayList<HashMap<String, Object>> recruit_process_info_list= sfaService.search_recruit_process_info(fap_jobfair_seq, fap_jobfair_divide_seq, fap_job_recruit_pcs_sch_ck, comp_nm);
		
		logger.info("채용전형 정보 검색 컨트롤러 종료");
		return recruit_process_info_list;
	}
	
	/**
	 * @Method Name : select_review_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 서류전형 시퀀스
	 * @Return : 서류전형 정보
	 * @Method 설명 : 서류전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_REVIEW_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_review_pcs(Model model, Authentication auth, @RequestParam(defaultValue ="") String fap_job_recruit_pcs_seq, @RequestParam(defaultValue = "0") int fap_jobfair_seq,
			@RequestParam(defaultValue = "0") int fap_jobfair_divide_seq, @RequestParam(defaultValue = "") String fap_job_recruit_pcs_sch_ck, @RequestParam(defaultValue = "") String comp_nm){
		logger.info("서류전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> review_pcs_info= sfaService.select_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("서류전형 정보 검색 컨트롤러 종료");
		return review_pcs_info;
	}
	
	/**
	 * @Method Name : select_exam_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 시험전형 시퀀스
	 * @Return : 시험전형 정보
	 * @Method 설명 : 시험전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_EXAM_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_exam_pcs(Model model, Authentication auth, @RequestParam(defaultValue ="") String fap_job_recruit_pcs_seq
			){
		logger.info("시험전형 정보 검색 컨트롤러 시작");
	 
		HashMap<String, Object> exam_pcs_info= sfaService.select_exam_pcs(fap_job_recruit_pcs_seq);
		String path = fapCompanyJobRecruitExamFile + "/";
		model.addAttribute("path", path);
		logger.info("시험전형 정보 검색 컨트롤러 종료");
		return exam_pcs_info;
	}
	
	/**
	 * @Method Name : delete_job_exam_file_uploaded
	 * @Date :2019. 09. 30
	 * @User : 김경아
	 * @Param : 파일정보
	 * @Return : 
	 * @Method 설명 :  채용전형 정보 첨부파일 삭제
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_DELETE_JOB_EXAM_FILE_UPLOADED, method = RequestMethod.POST)
	public int delete_job_exam_file_uploaded(@RequestParam(defaultValue ="") String fap_job_exam_file_saved){
		logger.info("채용전형 정보 첨부파일 삭제 컨트롤러 시작");
		//디렉토리에서 파일 삭제
		boolean result = FileService.deleteFile(fap_job_exam_file_saved, fapCompanyJobRecruitExamFile);	
		//db에서 파일 삭제
		int result2 = sfaService.delete_exam_file(fap_job_exam_file_saved);
		logger.info("채용전형 정보 첨부파일 삭제 컨트롤러 종료");
		return result2;
	}
	
	
	/**
	 * @Method Name : select_itv_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 면접전형 시퀀스
	 * @Return : 면접전형 정보
	 * @Method 설명 : 면접전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_INTERVIEW_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_itv_pcs(Model model, Authentication auth, @RequestParam(defaultValue ="") String fap_job_recruit_pcs_seq){
		logger.info("면접전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> itv_pcs_info= sfaService.select_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("면접전형 정보 검색 컨트롤러 종료");
		return itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_test_etc_pcs
	 * @Date : 2019. 1. 12.
	 * @User : 신동철
	 * @Param : 기타전형 시퀀스
	 * @Return : 기타전형 정보
	 * @Method 설명 : 기타전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TEST_ETC_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_test_etc_pcs(Model model, Authentication auth, @RequestParam(defaultValue ="") String fap_job_recruit_pcs_seq){
		logger.info("기타전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> test_etc_pcs_info= sfaService.select_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("기타전형 정보 검색 컨트롤러 종료");
		return test_etc_pcs_info;
	}
	
	
	/**
	 * @Method Name : select_recruit_pcs_sch
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 전형일정 스케줄 검색 정보
	 * @Return : 전형일정 스케줄
	 * @Method 설명 : 전형일정 스케줄 검색
	 */
	
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_RECRUIT_PROCESS_SCHEDULE_SELECT, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch){
		logger.info("전형일정 스케줄 검색 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> schedule_list = sfaService.select_recruit_pcs_sch(recruit_pcs_sch);
		
		logger.info("전형일정 스케줄 검색 컨트롤러 종료");
		return schedule_list;
	}
	
	/**
	 * @Method Name : search_job_ad_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : 회사가 참가하여 승인받은 채용공고 리스트
	 * @Method 설명 : 회사가 참가하여 승인받은 채용공고 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_LIST_SEARCH, method = RequestMethod.POST)
	public ArrayList<SocietyFapJobAd> search_job_ad_list(SocietyFapJobAd jobAd){
		logger.info("전형일정 스케줄 검색 컨트롤러 시작");
		
		ArrayList<SocietyFapJobAd> job_ad_list = sfaService.search_job_ad_list(jobAd);
		
		logger.info("전형일정 스케줄 검색 컨트롤러 종료");
		return job_ad_list;
	}
	
	/**
	 * @Method Name : common_required_doc_search_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사아이디
	 * @Return : 공통 내정서류 리스트
	 * @Method 설명 : 공통 내정서류 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapCommonRequiredDoc> company_required_doc_search_list(@RequestParam(defaultValue = "0") long fap_job_ad_seq, @RequestParam(defaultValue = "") String fap_comp_id){
		logger.info("공통 내정서류 검색 컨트롤러 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashmap.put("fap_comp_id", fap_comp_id);
		ArrayList<SocietyFapCommonRequiredDoc> common_required_doc_list = sfcService.search_common_required_doc_list(hashmap);
		
		logger.info("공통 내정서류 검색 컨트롤러 종료");		
		return common_required_doc_list;
	}
	
	/**
	 * @Method Name : select_job_ad_comp_list
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : 해당 잡페어의 채용공고에 승인받은 회사 목록
	 * @Method 설명 : 해당잡페어의 채용공고에 승인받은 회사 목록 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_AD_COMP_LIST_SELECT, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_job_ad_comp_list(int fap_jobfair_seq){
		logger.info("해당 잡페어의 채용공고에 승인받은 회사 목록 검색 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> job_ad_comp_list = sfaService.select_job_ad_comp_list(fap_jobfair_seq);
		
		logger.info("해당 잡페어의 채용공고에 승인받은 회사 목록 검색 컨트롤러 종료");
		return job_ad_comp_list;
	}
	
	/**
	 * @Method Name : select_common_required_doc
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 공통 내정서류 시퀀스
	 * @Return : 공통 내정서류
	 * @Method 설명 : 공통 내정서류 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_SELECT, method = RequestMethod.POST)
	public SocietyFapCommonRequiredDoc select_common_required_doc(int fap_common_required_doc_seq){
		logger.info("특정 공통 내정서류 검색 컨트롤러 시작");
		
		SocietyFapCommonRequiredDoc common_required_doc = sfcService.select_common_required_doc(fap_common_required_doc_seq);
		
		logger.info("특정 공통 내정서류 검색 컨트롤러 종료");	
		return common_required_doc;
	}
	
	/**
	 * @Method Name : personal_required_doc_search_list
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : 개인 내정서류 리스트
	 * @Method 설명 : 개인 내정서류 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> personal_required_doc_search_list(@RequestParam(defaultValue = "0") int fap_nominee_seq){
		logger.info("개인 내정서류 검색 컨트롤러 시작");
				
		ArrayList<HashMap<String, Object>> personal_required_doc_list = sfcService.search_personal_required_doc_list(fap_nominee_seq);
		
		logger.info("개인 내정서류 검색 컨트롤러 종료");		
		return personal_required_doc_list;
	}
	
	/**
	 * @Method Name : nominee_info_list_search
	 * @Date : 2019. 6.11
	 * @User : 김경아
	 * @Param : 채용공고 시퀀스, 회사아이디 
	 * @Return : 내정자 정보 리스트
	 * @Method 설명 : 내정자 정보 리스트 검색
	 */

	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_NOMINEE_INFO_SEARCH_LIST, method= RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> nominee_info_list_search(@RequestParam(defaultValue="0") int fap_job_ad_seq, 
			@RequestParam(defaultValue="")String fap_comp_id ){
		logger.info("내정자 정보 리스트 검색 컨트롤러 시작");
		
		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashMap.put("fap_comp_id", fap_comp_id);
		
		ArrayList<HashMap<String,Object>> nominee_info_list  = sfcService.search_nominee_info_list(hashMap);				 		 		
		
		logger.info("내정자 정보 리스트 검색 컨트롤러 종료");		
		return nominee_info_list;
	}

	
	
	/**
	 * @Method Name : nominee_info_search
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : 내정자 정보
	 * @Method 설명 : 내정자 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_NOMINEE_INFO_SEARCH, method = RequestMethod.POST)
	public HashMap<String, Object> nominee_info_search(SocietyFapNominee nominee){
		logger.info("내정자 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> nominee_info = sfcService.search_nominee_info(nominee);
		
		logger.info("내정자 정보 검색 컨트롤러 종료");		
		return nominee_info;
	}
	
	/**
	 * @Method Name : applied_result_list
	 * @Date : 2018. 01. 21.
	 * @User : 남유송
	 * @Param : HashMap
	 * @Return : ArrayList
	 * @Method 설명 : 지원자별 전형 결과 가져오기
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_APPLIED_RESULT_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> applied_result_list(long fap_job_ad_seq){
		logger.info("지원자별 전형 결과 출력 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_job_ad_seq", fap_job_ad_seq);
		ArrayList<HashMap<String, Object>> applied_result_list=sfaService.select_applied_result(params);
		System.out.println(applied_result_list.toString());
		logger.info("지원자별 전형 결과 출력 컨트롤러 종료");
		return applied_result_list;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_search
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 결제 그룹 검색
	 * @Method 설명 : 잡페어별 결제 정보 그룹 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> per_jobfair_temp_group_search(int fap_jobfair_seq){
		logger.info("잡페어별 임시 결제 그룹 검색 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> result = sfaService.per_jobfair_temp_group_search(fap_jobfair_seq);
		
		logger.info("잡페어별 임시 결제 그룹 검색 컨트롤러 종료");		
		return result;
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_search
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 전체 회사 결제정보 검색
	 * @Method 설명 : 잡페어별 전체 회사 결제정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> per_comp_temp_payment_search(int fap_jobfair_seq){
		logger.info("잡페어별 전체 회사 결제정보 검색 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> result = sfaService.select_comp_list_include_agency(fap_jobfair_seq);
		
		logger.info("잡페어별 전체 회사 결제정보 검색 컨트롤러 종료");		
		return result;
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_update
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 수정
	 * @Method 설명 : 잡페어별 회사 결제정보 수정
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_UPDATE, method = RequestMethod.POST)
	public void per_comp_temp_payment_update(int payment_seq, int group_seq, String payment_gb, Authentication auth, String payment_vip_gb){
		logger.info("잡페어별 회사 결제정보 수정 컨트롤러 시작");
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_per_jobfair_temp_group_seq", group_seq);
		params.put("fap_per_comp_temp_payment_gb", payment_gb);
		params.put("fap_per_comp_temp_payment_udt_id", auth.getPrincipal());
		params.put("fap_per_comp_temp_payment_seq", payment_seq);
		params.put("fap_per_comp_temp_payment_vip_gb", payment_vip_gb);

		sfaService.per_comp_temp_payment_update(params);
		
		logger.info("잡페어별 회사 결제정보 수정 컨트롤러 종료");		
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_insert
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 등록
	 * @Method 설명 : 잡페어별 회사 결제정보 등록
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_INSERT, method = RequestMethod.POST)
	public void per_comp_temp_payment_insert(String fap_comp_id, int group_seq, String payment_gb, Authentication auth, String payment_vip_gb){
		logger.info("잡페어별 회사 결제정보 등록 컨트롤러 시작");
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_per_jobfair_temp_group_seq", group_seq);
		params.put("fap_per_comp_temp_payment_gb", payment_gb);
		params.put("fap_per_comp_temp_payment_vip_gb", payment_vip_gb);
		params.put("fap_per_comp_temp_payment_ins_id", auth.getPrincipal());
		params.put("fap_comp_id", fap_comp_id);

		sfaService.per_comp_temp_payment_insert(params);
		
		logger.info("잡페어별 회사 결제정보 등록 컨트롤러 종료");		
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_delete
	 * @Date : 2019. 2. 7.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스
	 * @Return : 잡페어별 회사 결제정보 등록
	 * @Method 설명 : 잡페어별 회사 결제정보 등록
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_DELETE, method = RequestMethod.POST)
	public void per_comp_temp_payment_delete(int payment_seq){
		logger.info("잡페어별 회사 결제정보 삭제 컨트롤러 시작");
		
		sfaService.per_comp_temp_payment_delete(payment_seq);
		
		logger.info("잡페어별 회사 결제정보 삭제 컨트롤러 종료");		
	}
	
	/**
	 * @Method Name : delete_connect_request_seq
	 * @Date : 2019. 2. 8.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_CONNECT_REQUEST_DELETE, method = RequestMethod.POST)
	public int delete_connect_request(int fap_comp_user_request_seq){
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 컨트롤러 시작");
		int result = sfaService.delete_connect_request_seq(fap_comp_user_request_seq);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : agency_company_connect_company_paging
	 * @Date : 2019. 2. 19.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_COMPANY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> agency_company_connect_company_paging(int clickedPage){
		
		int unconnectTotalCount = sfaService.select_unconnect_comp_list_paging_count();
		if(unconnectTotalCount == 0){unconnectTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(10, 10, clickedPage, unconnectTotalCount);
		
		ArrayList<SocietyFapCompanyUser> unconnect_comp_list = sfaService.select_unconnect_comp_list(repNavi.getStartRecord(), repNavi.getCountPerPage());
		HashMap<String, Object> companyListInfo = new HashMap<>();
		companyListInfo.put("unconnect_comp_list", unconnect_comp_list);
		companyListInfo.put("repNavi", repNavi);
		companyListInfo.put("unconnectTotalCount", unconnectTotalCount);
		
		return companyListInfo;
	}

	/**
	 * @Method Name : agency_company_connect_agency_paging
	 * @Date : 2019. 2. 19.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_AGENCY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> agency_company_connect_agency_paging(int clickedPage){
		
		int agencyTotalCount = sfaService.select_agency_list_paging_count();
		if(agencyTotalCount == 0){agencyTotalCount=1;}
		PageNavigator repNaviTwo = new PageNavigator(10, 10, clickedPage, agencyTotalCount);
		
		ArrayList<SocietyFapCompanyUser> select_agency_list = sfaService.select_agency_list(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		HashMap<String, Object> agencyListInfo = new HashMap<>();
		agencyListInfo.put("select_agency_list", select_agency_list);
		agencyListInfo.put("repNaviTwo", repNaviTwo);
		agencyListInfo.put("agencyTotalCount", agencyTotalCount);
		
		return agencyListInfo;
	}

	/**
	 * @Method Name : delete_notice
	 * @Date : 2019. 2. 20.
	 * @User : 김준영
	 * @Param : 게시판 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 공지사항을 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_NOTICE_DELETE, method = RequestMethod.POST)
	public int delete_notice(int board_content_seq){
		logger.info("FAP 공지사항 삭제 컨트롤러 시작");
		int result = sfaService.delete_notice(board_content_seq);
		logger.info("FAP 공지사항 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : agency_company_connect_standby_paging
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 에이전시-기업연결관리, 대기중인 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_STANDBY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> agency_company_connect_standby_paging(int clickedPage){
		
		int standbyTotalCount = sfaService.select_standby_ag_comp_connect_list_paging_count();
		if(standbyTotalCount == 0){standbyTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(10, 10, clickedPage, standbyTotalCount);
		
		ArrayList<HashMap<String, Object>> standby_list = sfaService.select_standby_ag_comp_connect_list(repNavi.getStartRecord(), repNavi.getCountPerPage());
		HashMap<String, Object> standbyListInfo = new HashMap<>();
		standbyListInfo.put("standby_list", standby_list);
		standbyListInfo.put("repNavi", repNavi);
		standbyListInfo.put("standbyTotalCount", standbyTotalCount);
		
		return standbyListInfo;
	}
	
	/**
	 * @Method Name : agency_company_connect_approval_paging
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 에이전시-기업연결관리, 승인한 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_APPROVAL_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> agency_company_connect_approval_paging(int clickedPage){
		
		int approvalTotalCount = sfaService.select_approval_ag_comp_connect_list_paging_count();
		if(approvalTotalCount == 0){approvalTotalCount=1;}
		PageNavigator repNaviTwo = new PageNavigator(10, 10, clickedPage, approvalTotalCount);
		
		ArrayList<HashMap<String, Object>> approval_list = sfaService.select_approval_ag_comp_connect_list(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		HashMap<String, Object> approvalListInfo = new HashMap<>();
		approvalListInfo.put("approval_list", approval_list);
		approvalListInfo.put("repNaviTwo", repNaviTwo);
		approvalListInfo.put("approvalTotalCount", approvalTotalCount);
		
		return approvalListInfo;
	}
	
	/**
	 * @Method Name : search_jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(잡페어에 참가한 기업 리스트 페이지)
	 * @Method 설명 : 잡페어에 참가한 기업 리스트 페이지로 이동
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SEARCH_JOBFAIR_ATTENDED_COMP_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_jobfair_attended_comp_list(@RequestParam(defaultValue = "0") int fap_jobfair_seq,
			@RequestParam(defaultValue = "0") int fap_jobfair_divide_seq){
		logger.debug("잡페어에 참가한 기업 리스트 검색 컨트롤러 시작");
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_seq", fap_jobfair_seq);
		hashmap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		ArrayList<HashMap<String, Object>> resultList = sfaService.searched_jobfair_attended_comp_list(hashmap);
		logger.debug("잡페어에 참가한 기업 리스트 검색 컨트롤러 종료");
		return resultList;
	}
	/**
	 * @Method Name : agency_company_connect_refusal_paging
	 * @Date : 2019. 2. 20.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 에이전시-기업연결관리, 거절한 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_REFUSAL_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> agency_company_connect_refusal_paging(int clickedPage){
		
		int refusalTotalCount = sfaService.select_refusal_ag_comp_connect_list_paging_count();
		if(refusalTotalCount == 0){refusalTotalCount=1;}
		PageNavigator repNaviThree = new PageNavigator(10, 10, clickedPage, refusalTotalCount);
		
		ArrayList<HashMap<String, Object>> refusal_list = sfaService.select_refusal_ag_comp_connect_list(repNaviThree.getStartRecord(), repNaviThree.getCountPerPage());
		HashMap<String, Object> refusalListInfo = new HashMap<>();
		refusalListInfo.put("refusal_list", refusal_list);
		refusalListInfo.put("repNaviThree", repNaviThree);
		refusalListInfo.put("refusalTotalCount", refusalTotalCount);
		
		return refusalListInfo;
	}
	
	/**
	 * @Method Name : comp_user_connect_standby_paging
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 담당자-기업연결관리, 대기중인 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMP_USER_CONNECT_STANDBY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> comp_user_connect_standby_paging(int clickedPage){
		
		int userStandbyTotalCount = sfaService.select_standby_comp_user_connect_list_paging_count();
		if(userStandbyTotalCount == 0){userStandbyTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(10, 10, clickedPage, userStandbyTotalCount);
		
		ArrayList<HashMap<String, Object>> user_standby_list = sfaService.select_standby_comp_user_connect(repNavi.getStartRecord(), repNavi.getCountPerPage());
		HashMap<String, Object> userStandbyListInfo = new HashMap<>();
		userStandbyListInfo.put("user_standby_list", user_standby_list);
		userStandbyListInfo.put("repNavi", repNavi);
		userStandbyListInfo.put("userStandbyTotalCount", userStandbyTotalCount);
		
		return userStandbyListInfo;
	}
	
	/**
	 * @Method Name : comp_user_connect_approval_paging
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 담당자-기업연결관리, 승인한 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMP_USER_CONNECT_APPROVAL_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> comp_user_connect_approval_paging(int clickedPage){
		
		int userApprovalTotalCount = sfaService.select_approval_comp_user_connect_list_paging_count();
		if(userApprovalTotalCount == 0){userApprovalTotalCount=1;}
		PageNavigator repNaviTwo = new PageNavigator(10, 10, clickedPage, userApprovalTotalCount);
		
		ArrayList<HashMap<String, Object>> user_approval_list = sfaService.select_approval_comp_user_connect(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		HashMap<String, Object> userApprovalListInfo = new HashMap<>();
		userApprovalListInfo.put("user_approval_list", user_approval_list);
		userApprovalListInfo.put("repNaviTwo", repNaviTwo);
		userApprovalListInfo.put("userApprovalTotalCount", userApprovalTotalCount);
		
		return userApprovalListInfo;
	}
	
	/**
	 * @Method Name : comp_user_connect_refusal_paging
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 담당자-기업연결관리, 거절한 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_COMP_USER_CONNECT_REFUSAL_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> comp_user_connect_refusal_paging(int clickedPage){
		
		int userRefusalTotalCount = sfaService.select_refusal_comp_user_connect_list_paging_count();
		if(userRefusalTotalCount == 0){userRefusalTotalCount=1;}
		PageNavigator repNaviThree = new PageNavigator(10, 10, clickedPage, userRefusalTotalCount);
		
		ArrayList<HashMap<String, Object>> user_refusal_list = sfaService.select_refusal_comp_user_connect(repNaviThree.getStartRecord(), repNaviThree.getCountPerPage());
		HashMap<String, Object> userRefusalListInfo = new HashMap<>();
		userRefusalListInfo.put("user_refusal_list", user_refusal_list);
		userRefusalListInfo.put("repNaviThree", repNaviThree);
		userRefusalListInfo.put("userRefusalTotalCount", userRefusalTotalCount);
		
		return userRefusalListInfo;
	}
	
	/**
	 * @Method Name : connect_request_paging
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 담당자 연결 요청 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_CONNECT_REQUEST_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> connect_request_paging(int clickedPage){
		
		int requestTotalCount = sfaService.select_connect_request_paging_count();
		if(requestTotalCount == 0){requestTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(10, 10, clickedPage, requestTotalCount);
		
		ArrayList<HashMap<String, Object>> request_list = sfaService.select_connect_request(repNavi.getStartRecord(), repNavi.getCountPerPage());
		HashMap<String, Object> requestListInfo = new HashMap<>();
		requestListInfo.put("request_list", request_list);
		requestListInfo.put("repNavi", repNavi);
		requestListInfo.put("requestTotalCount", requestTotalCount);
		
		return requestListInfo;
	}
	
	/**
	 * @Method Name : uncertain_company_paging
	 * @Date : 2019. 2. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 연결 객체가 없어 불명확한 기업 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_UNCERTAIN_COMPANY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> uncertain_company_paging(int clickedPage){
		
		int uncertainTotalCount = sfaService.select_uncertain_company_paging_count();
		if(uncertainTotalCount == 0){uncertainTotalCount=1;}
		PageNavigator repNaviTwo = new PageNavigator(10, 10, clickedPage, uncertainTotalCount);
		
		ArrayList<SocietyFapCompanyUser> select_uncertain_company = sfaService.select_uncertain_company(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		HashMap<String, Object> uncertainListInfo = new HashMap<>();
		uncertainListInfo.put("select_uncertain_company", select_uncertain_company);
		uncertainListInfo.put("repNaviTwo", repNaviTwo);
		uncertainListInfo.put("uncertainTotalCount", uncertainTotalCount);
		
		return uncertainListInfo;
	}
	
	/**
	 * @Method Name : unconnect_company_paging
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 기업과 연결 되지 않은 유저(기업) 객체 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_UNCONNECT_COMPANY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> unconnect_company_paging(int clickedPage){
		
		int companyUserTotalCount = sfaService.select_unconnect_company_list_paging_count();
		if(companyUserTotalCount == 0){companyUserTotalCount=1;}
		PageNavigator repNaviThree = new PageNavigator(10, 10, clickedPage, companyUserTotalCount);
		
		ArrayList<User> company_user = sfaService.select_unconnect_company_list(repNaviThree.getStartRecord(), repNaviThree.getCountPerPage());
		HashMap<String, Object> companyUserListInfo = new HashMap<>();
		companyUserListInfo.put("company_user", company_user);
		companyUserListInfo.put("repNaviThree", repNaviThree);
		companyUserListInfo.put("companyUserTotalCount", companyUserTotalCount);
		
		return companyUserListInfo;
	}
	
	/**
	 * @Method Name : unconnect_agency_paging
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 기업과 연결 되지 않은 유저(에이전시) 객체 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_UNCONNECT_AGENCY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> unconnect_agency_paging(int clickedPage){
		
		int agencyUserTotalCount = sfaService.select_unconnect_agency_list_paging_count();
		if(agencyUserTotalCount == 0){agencyUserTotalCount=1;}
		PageNavigator repNaviFour = new PageNavigator(10, 10, clickedPage, agencyUserTotalCount);
		
		ArrayList<User> agency_user = sfaService.select_unconnect_agency_list(repNaviFour.getStartRecord(), repNaviFour.getCountPerPage());
		HashMap<String, Object> agencyUserListInfo = new HashMap<>();
		agencyUserListInfo.put("agency_user", agency_user);
		agencyUserListInfo.put("repNaviFour", repNaviFour);
		agencyUserListInfo.put("agencyUserTotalCount", agencyUserTotalCount);
		
		return agencyUserListInfo;
	}
	
	/**
	 * @Method Name : connect_company_paging
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 연결 할 기업 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_CONNECT_COMPANY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> connect_company_paging(int clickedPage){
		
		int connectCompanyTotalCount = sfaService.select_connect_company_list_paging_count();
		if(connectCompanyTotalCount == 0){connectCompanyTotalCount=1;}
		PageNavigator repNaviFive = new PageNavigator(10, 10, clickedPage, connectCompanyTotalCount);
		
		ArrayList<HashMap<String, Object>> company_list = sfaService.select_connect_company_list(repNaviFive.getStartRecord(), repNaviFive.getCountPerPage());
		HashMap<String, Object> connectCompanyListInfo = new HashMap<>();
		connectCompanyListInfo.put("company_list", company_list);
		connectCompanyListInfo.put("repNaviFive", repNaviFive);
		connectCompanyListInfo.put("connectCompanyTotalCount", connectCompanyTotalCount);
		
		return connectCompanyListInfo;
	}
	
	/**
	 * @Method Name : connect_agency_paging
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 연결 할 에이전시 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_CONNECT_AGENCY_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> connect_agency_paging(int clickedPage){
		
		int connectAgencyTotalCount = sfaService.select_connect_agency_list_paging_count();
		if(connectAgencyTotalCount == 0){connectAgencyTotalCount=1;}
		PageNavigator repNaviSix = new PageNavigator(10, 10, clickedPage, connectAgencyTotalCount);
		
		ArrayList<HashMap<String, Object>> agency_list = sfaService.select_connect_agency_list(repNaviSix.getStartRecord(), repNaviSix.getCountPerPage());
		HashMap<String, Object> connectAgencyListInfo = new HashMap<>();
		connectAgencyListInfo.put("agency_list", agency_list);
		connectAgencyListInfo.put("repNaviSix", repNaviSix);
		connectAgencyListInfo.put("connectAgencyTotalCount", connectAgencyTotalCount);
		
		return connectAgencyListInfo;
	}
	
	/**
	 * @Method Name : search_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 잡페어 세부 시퀀스
	 * @Return : 잡페어별 취업지원자 지망개수
	 * @Method 설명 : 잡페어별 취업지원자 지망개수 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_SEARCH_USER_APPLY_NUMBERS, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_user_apply_numbers(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어별 취업지원자 지망개수 검색 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaService.search_user_apply_numbers(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어별 취업지원자 지망개수 검색 컨트롤러 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : unconnect_company_paging_sub
	 * @Date : 2019. 2. 25.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 기업과 연결 되지 않은 유저(기업) 객체 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_UNCONNECT_COMPANY_PAGING_SUB, method = RequestMethod.POST)
	public HashMap<String, Object> unconnect_company_paging_sub(int clickedPage){
		
		int companyUserTotalCount = sfaService.select_unconnect_company_list_paging_count();
		if(companyUserTotalCount == 0){companyUserTotalCount=1;}
		PageNavigator repNaviSeven = new PageNavigator(10, 10, clickedPage, companyUserTotalCount);
		
		ArrayList<User> company_user = sfaService.select_unconnect_company_list(repNaviSeven.getStartRecord(), repNaviSeven.getCountPerPage());
		HashMap<String, Object> companyUserListInfoSub = new HashMap<>();
		companyUserListInfoSub.put("company_user", company_user);
		companyUserListInfoSub.put("repNaviSeven", repNaviSeven);
		companyUserListInfoSub.put("companyUserTotalCount", companyUserTotalCount);
		
		return companyUserListInfoSub;
	}
	
	/**
	 * @Method Name : unconnect_agency_paging_sub
	 * @Date : 2019. 2. 22.
	 * @User : 이재준
	 * @Param : -
	 * @Return : HashMap
	 * @Method 설명 : 기업과 연결 되지 않은 유저(에이전시) 객체 리스트 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_UNCONNECT_AGENCY_PAGING_SUB, method = RequestMethod.POST)
	public HashMap<String, Object> unconnect_agency_paging_sub(int clickedPage){
		
		int agencyUserTotalCount = sfaService.select_unconnect_agency_list_paging_count();
		if(agencyUserTotalCount == 0){agencyUserTotalCount=1;}
		PageNavigator repNaviEight = new PageNavigator(10, 10, clickedPage, agencyUserTotalCount);
		
		ArrayList<User> agency_user = sfaService.select_unconnect_agency_list(repNaviEight.getStartRecord(), repNaviEight.getCountPerPage());
		HashMap<String, Object> agencyUserListInfoSub = new HashMap<>();
		agencyUserListInfoSub.put("agency_user", agency_user);
		agencyUserListInfoSub.put("repNaviEight", repNaviEight);
		agencyUserListInfoSub.put("agencyUserTotalCount", agencyUserTotalCount);
		
		return agencyUserListInfoSub;
	}
	
	
	/**
	 * @Method Name : select_jobfair_applicable_time
	 * @Date : 2019. 2. 27.
	 * @User : 원병호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : 잡페어 추가지원 정보
	 * @Method 설명 :잡페어 세부 일련번호로 해당 추가지원정보 검색
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_APPLICABLE_TIME_MANAGEMENT, method = RequestMethod.POST)
	public HashMap<String, Object> select_jobfair_applicable_time(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 잡페어 추가지원 정보 검색 시작");
		HashMap<String, Object> result = sfaService.select_jobfair_applicable_time(fap_jobfair_divide_seq);
		
		logger.info("FAP 관리자 잡페어 추가지원 정보 검색 끝");
		return result;
	}
	
	/**
	 * @Method Name : delete_board_file
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항 파일 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 파일 삭제
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_DELETE_BOARD_FILE, method = RequestMethod.POST)
	public void delete_board_file(int board_file_seq, String board_file_saved){
		logger.info("FAP 잡페어 공지사항 파일 삭제 컨트롤러 시작");		
		sfaService.delete_board_file(board_file_seq, board_file_saved);		
		logger.info("FAP 잡페어 공지사항 파일 삭제 컨트롤러 끝");
	}
	
	/**
	 * @Method Name : delete_board_file_list
	 * @Date : 2019. 3. 5.
	 * @User : 신동철
	 * @Param : 잡페어 공지사항 파일 리스트 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어 공지사항 파일 리스트 삭제
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_DELETE_BOARD_FILE_LIST, method = RequestMethod.POST)
	public void delete_board_file(@RequestParam(defaultValue="") ArrayList<Integer> board_file_seq_list, 
			@RequestParam(defaultValue="") ArrayList<String> board_file_saved_list){
		logger.info("FAP 잡페어 공지사항 파일 리스트 삭제 컨트롤러 시작");
		sfaService.delete_board_file_list(board_file_seq_list, board_file_saved_list);		
		logger.info("FAP 잡페어 공지사항 파일 리스트 삭제 컨트롤러 끝");
	}
	
	/**
	 * @Method Name : search_qna_job_ad
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디
	 * @Return : 채용공고 Q&A 채용공고
	 * @Method 설명 : 채용공고 Q&A 채용공고 검색
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SEARCH_QNA_JOB_AD, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_qna_job_ad(String fap_comp_id){
		logger.info("FAP 잡페어 채용공고 Q&A 채용공고 검색 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> resultList = sfaService.search_qna_job_ad(fap_comp_id);		
		logger.info("FAP 잡페어 채용공고 Q&A 채용공고 검색 컨트롤러 끝");
		return resultList;
	}
	
	/**
	 * @Method Name : search_job_qna_question_info
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 채용기업 아이디, 채용공고 시퀀스, 질문승인여부, 작성자 이름
	 * @Return : 채용공고 Q&A 질문 정보
	 * @Method 설명 : 채용공고 Q&A 질문 정보 검색 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SEARCH_JOB_QNA_QUESTION_INFO, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_job_qna_question_info(@RequestParam(defaultValue="") String fap_comp_id,
			@RequestParam(defaultValue="0") long fap_job_ad_seq, @RequestParam(defaultValue="") String fap_job_qna_question_per,
			@RequestParam(defaultValue="") String user_nm){
		logger.info("FAP 잡페어 채용공고 Q&A 질문 정보 검색 컨트롤러 시작");
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_comp_id", fap_comp_id);
		hashmap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashmap.put("fap_job_qna_question_per", fap_job_qna_question_per);
		hashmap.put("user_nm", user_nm);
		ArrayList<HashMap<String, Object>> resultList = sfaService.search_job_qna_question_info(hashmap);		
		logger.info("FAP 잡페어 채용공고 Q&A 질문 정보 검색 컨트롤러 끝");
		return resultList;
	}
	
	/**
	 * @Method Name : select_jobfair_divide_info
	 * @Date : 2019. 3. 12.
	 * @User : 신동철
	 * @Param : fap_jobfair_seq 담은 hashmap
	 * @Return : SocietyFapCompanyRoadmapJobfairDivide 객체
	 * @Method 설명 : fap_jobfair_seq로 잡페어 세부정보 가져오기
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SELECT_JOBFAIR_DIVIDE_INFO, method = RequestMethod.POST)
	public ArrayList<SocietyFapCompanyRoadmapJobfairDivide> select_jobfair_divide_info(int fap_jobfair_seq){
		logger.info("FAP 잡페어 세부정보 가져오기 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("fap_jobfair_seq", fap_jobfair_seq);
		ArrayList<SocietyFapCompanyRoadmapJobfairDivide> jobfair_divide_list = sfaService.select_jobfair_divide_info(params);
		logger.info("FAP 잡페어 세부정보 가져오기 컨트롤러 종료");
		return jobfair_divide_list;
	}
	
	/**
	 * @Method Name : search_jobfair_divide_final_select_info
	 * @Date : 2019. 3. 14.
	 * @User : 신동철
	 * @Param : 잡페어 세부시퀀스
	 * @Return : 잡페어 세부별 최종합격자 결정 시한
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SEARCH_JOBFAIR_DIVIDE_FINAL_SELECT_INFO, method = RequestMethod.POST)
	public HashMap<String, Object> search_jobfair_divide_final_select_info(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 세부정보 가져오기 컨트롤러 시작");
		System.out.println(fap_jobfair_divide_seq);
		HashMap<String, Object> hashmap = sfaService.search_jobfair_divide_final_select_info(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 세부정보 가져오기 컨트롤러 종료");
		return hashmap;
	}
	
	/**
	 * @Method Name : final_decision_time_insert
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 최종확정 기간정보
	 * @Return : -
	 * @Method 설명 : 최종확정 기간 등록
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_INSERT, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminFinalDecisionTime> final_decision_time_insert(SocietyFapAdminFinalDecisionTime finalDecision , Authentication auth){
		logger.info("FAP 잡페어 최종확정 기간 등록 컨트롤러 시작");
		
		int count = sfaService.final_decision_time_duplicate_check(finalDecision);
		
		if(count > 0) {
			return null;
		}
		
		finalDecision.setFap_jobfair_final_decision_time_ins_id((String)auth.getPrincipal());
		finalDecision.setFap_jobfair_final_decision_time_udt_id((String)auth.getPrincipal());
		
		sfaService.final_decision_time_insert(finalDecision);
		ArrayList<SocietyFapAdminFinalDecisionTime> result = sfaService.final_decision_time_select(finalDecision.getFap_jobfair_divide_seq());
		logger.info("FAP 잡페어 최종확정 기간 등록 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_time_select
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_SELECT, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminFinalDecisionTime> final_decision_time_select(int fap_jobfair_divide_seq){
		logger.info("FAP 잡페어 최종확정 기간 조회 컨트롤러 시작");
		ArrayList<SocietyFapAdminFinalDecisionTime> result = sfaService.final_decision_time_select(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 기간 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_time_delete
	 * @Date : 2019. 3. 21.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : -
	 * @Method 설명 : 세부 잡페어 별 최종확정 기간 삭제
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_DELETE, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminFinalDecisionTime> final_decision_time_delete(@RequestBody HashMap<String, Object> fap_jobfair_set_seq_map){
		logger.info("FAP 잡페어 최종확정 기간 조회 컨트롤러 시작");
		sfaService.final_decision_time_delete(fap_jobfair_set_seq_map);
		
		ArrayList<SocietyFapAdminFinalDecisionTime> result = sfaService.final_decision_time_select(Integer.parseInt(fap_jobfair_set_seq_map.get("fap_jobfair_divide_seq").toString()));
		logger.info("FAP 잡페어 최종확정 기간 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : final_decision_commit_op
	 * @Date : 2019. 5. 10.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 최종확정 알고리즘 적용(확정유예가능)
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_COMMIT_OP, method = RequestMethod.POST)
	public void final_decision_commit_op(int fap_jobfair_divide_seq) {
		logger.info("FAP 최종확정 알고리즘 적용(확정유예가능) 컨트롤러 시작");
		sfaService.final_decision_commit_op(fap_jobfair_divide_seq);
		logger.info("FAP 최종확정 알고리즘 적용(확정유예가능) 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : final_decision_commit_ns
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 최종확정 알고리즘 적용(확정필수)
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_COMMIT_NS, method = RequestMethod.POST)
	public void final_decision_commit_ns(int fap_jobfair_divide_seq) {
		logger.info("FAP 최종확정 알고리즘 적용(확정필수) 컨트롤러 시작");
		sfaService.final_decision_commit_ns(fap_jobfair_divide_seq);
		logger.info("FAP 최종확정 알고리즘 적용(확정필수) 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : final_decision_commit_last
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 최종확정 알고리즘 적용(최종)
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_COMMIT_LAST, method = RequestMethod.POST)
	public void final_decision_commit_last(int fap_jobfair_divide_seq) {
		logger.info("FAP 최종확정 알고리즘 적용(최종) 컨트롤러 시작");
		sfaService.final_decision_commit_last(fap_jobfair_divide_seq);
		logger.info("FAP 최종확정 알고리즘 적용(최종) 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : final_decision_algorithm_pass_to_comp
	 * @Date : 2019. 5. 15.
	 * @User : 이종호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_PASS_TO_COMP, method = RequestMethod.POST)
	public void final_decision_algorithm_pass_to_comp(int fap_jobfair_divide_seq) {
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달 컨트롤러 시작");
		sfaService.final_decision_algorithm_pass_to_comp(fap_jobfair_divide_seq);
		logger.info("FAP 잡페어 최종확정 알고리즘 최종적용 이후 기업에 전달 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : fap_ad_show_code_select
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 대상자 공통코드 맵
	 * @Method 설명 : 채용공고 대상자 설정을 위한 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_AD_SHOW_CODE_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> fap_ad_show_code_select(@RequestBody long fap_job_ad_seq){
		logger.info("FAP 채용공고 대상자 공통코드 조회 컨트롤러 시작");
		
		HashMap<String, Object> resultMap = new HashMap<>();
		//대상자 공통코드
		ArrayList<HashMap<String, Object>> com_code_arr = sfaService.fap_ad_show_code_select();
		//채용공고 연결된 대상자 공통코드
		ArrayList<SocietyFapJobAdShow> ad_code_arr = sfaService.fap_ad_show_link_code_select(fap_job_ad_seq);
		resultMap.put("com_code_arr", com_code_arr);
		resultMap.put("ad_code_arr", ad_code_arr);
		logger.info("FAP 채용공고 대상자 공통코드 조회 컨트롤러 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : fap_ad_show_code_insert
	 * @Date : 2019. 3. 22.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 채용공고 대상자 공통코드 맵
	 * @Method 설명 : 채용공고 대상자 설정을 위한 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_AD_SHOW_CODE_INSERT, method = RequestMethod.POST)
	public void fap_ad_show_code_insert(@RequestBody HashMap<String, Object> paramMap, Authentication auth){
		logger.info("FAP 채용공고 대상자 공통코드 등록 컨트롤러 시작");
		
		long fap_job_ad_seq = Long.parseLong(paramMap.get("fap_job_ad_seq").toString());
		
		//우선 해당하는 이전 정보 삭제
		sfaService.fap_ad_show_link_code_delete(fap_job_ad_seq);
		
		ArrayList<SocietyFapJobAdShow> show_list = new ArrayList<>();
		
		ArrayList<String> code_arr = (ArrayList<String>)paramMap.get("code_arr");
		
		for(String s : code_arr) {
			SocietyFapJobAdShow show = new SocietyFapJobAdShow();
			show.setFap_job_ad_seq(fap_job_ad_seq);
			show.setFap_job_ad_show_gb(s);
			show.setFap_job_ad_show_ins_id((String)auth.getPrincipal());
			show.setFap_job_ad_show_udt_id((String)auth.getPrincipal());
			show_list.add(show);
		}
		
		sfaService.fap_ad_show_link_code_insert(show_list);
		
		logger.info("FAP 채용공고 대상자 공통코드 등록 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : fap_open_select_one
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : 오픈잡페어 설명회 정보
	 * @Method 설명 : 오픈잡페어 설명회 정보 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_SELECT_ONE, method = RequestMethod.POST)
	public SocietyFapOpenPt fap_open_select_one(int fap_open_pt_seq) {
		logger.info("FAP 오픈잡페어 설명회 조회 컨트롤러 시작");
		SocietyFapOpenPt result = sfaService.fap_open_pt_select_one(fap_open_pt_seq);
		logger.info("FAP 오픈잡페어 설명회 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_APPLIER_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> fap_open_pt_applier_list(
			SocietyFapOpenPt openPt
			, @RequestParam(defaultValue="10") int countPerPage 
			, @RequestParam(defaultValue="1") int page 
			, @RequestParam(defaultValue="") String searchNm){
		logger.info("FAP 해당 설명회 지원자 정보 리스트 조회 컨트롤러 시작");
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_open_pt_seq", openPt.getFap_open_pt_seq());
		paramMap.put("fap_open_pt_gb", openPt.getFap_open_pt_gb());
		paramMap.put("searchNm", searchNm);
		
		int count = sfaService.fap_open_pt_applier_list_count(paramMap);
		PageNavigator navi = new PageNavigator(countPerPage, 5, page, count);
		 ArrayList<HashMap<String, Object>> result =  sfaService.fap_open_pt_applier_list(paramMap,navi.getStartRecord(), navi.getCountPerPage());
		 
		 HashMap<String, Object> resultMap = new HashMap<>();
		 resultMap.put("count", count);
		 resultMap.put("navi", navi);
		 resultMap.put("result", result);
		 
		logger.info("FAP 해당 설명회 지원자 정보 리스트 조회 컨트롤러 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_EDU_APPLIER_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> fap_open_edu_applier_list(
			SocietyFapOpenPt openPt
			, @RequestParam(defaultValue="10") int countPerPage 
			, @RequestParam(defaultValue="1") int page 
			, @RequestParam(defaultValue="") String searchNm){
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 조회 컨트롤러 시작");
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_open_pt_seq", openPt.getFap_open_pt_seq());
		paramMap.put("fap_open_pt_gb", openPt.getFap_open_pt_gb());
		paramMap.put("searchNm", searchNm);
		
		int count = sfaService.fap_open_edu_applier_list_count(paramMap);
		PageNavigator navi = new PageNavigator(countPerPage, 5, page, count);
		 ArrayList<HashMap<String, Object>> result =  sfaService.fap_open_edu_applier_list(paramMap,navi.getStartRecord(), navi.getCountPerPage());
		 
		 HashMap<String, Object> resultMap = new HashMap<>();
		 resultMap.put("count", count);
		 resultMap.put("navi", navi);
		 resultMap.put("result", result);
		 
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 조회 컨트롤러 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 이력서 정보
	 * @Return : 해당 구직자 교육 지원자 이력서 정보
	 * @Method 설명 : 해당 구직자 교육 지원자 이력서 정보 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_EDU_APPLIER_RESUME_SELECT, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String select_my_applied_resume(int fap_resume_seq, String user_id, Model model){
		logger.info("FAP  해당 구직자 교육 지원자 이력서 정보 조회 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("fap_resume_seq", fap_resume_seq);
		param.put("user_id", user_id);
		HashMap<String, Object> wholeResume = sfuService.selectResumeApply(param);
		Gson gson = new Gson();
		logger.info("FAP  해당 구직자 교육 지원자 이력서 정보 조회 컨트롤러 종료");
		return gson.toJson(wholeResume);
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_resume_update
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 이력서 정보
	 * @Return : -
	 * @Method 설명 : 해당 구분 구직자 교육 지원자 합/불 처리
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_EDU_APPLIER_RESUME_UPDATE, method = RequestMethod.POST)
	public void fap_open_edu_applier_resume_update(SocietyFapOpenPtResume openResume) {
		logger.info("FAP  해당 구분 구직자 교육 지원자 합/불 처리 컨트롤러 시작");
		sfaService.fap_open_edu_applier_resume_update(openResume);
		logger.info("FAP  해당 구분 구직자 교육 지원자 합/불 처리 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : applicant_status_per_applier_search
	 * @Date : 2019. 5. 17.
	 * @User : 이종호
	 * @Param : 지원자별 지원현황 검색 조건
	 * @Return : 지원자별 지원 현황 리스트
	 * @Method 설명 : 지원자별 지원 현황 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_APPLIER_SEARCH, method = RequestMethod.POST)
	public HashMap<String, Object> applicant_status_per_applier_search(
			@RequestBody HashMap<String, Object> search_map){
			logger.info("FAP 관리자 지원자별 지원 현황 리스트 검색 컨트롤러 시작");
			
			HashMap<String, Object> resultMap = new HashMap<>();
			
			ArrayList<LinkedHashMap<String, Object>> result = sfaService.applicant_status_per_applier_search(search_map);
			
			HashMap<String, Object> params = new HashMap<>();
			params.put("fap_jobfair_seq", search_map.get("jobfairSelect"));
			params.put("fap_jobfair_divide_gb", "C0100");
			
			int k_num = sfaService.jobfair_apply_max_count(params);
			
			params.put("fap_jobfair_divide_gb", "C0101");
			int j_num = sfaService.jobfair_apply_max_count(params);
			
			resultMap.put("list", result);
			resultMap.put("k_num", k_num);
			resultMap.put("j_num", j_num);
			
			logger.info("FAP 관리자 지원자별 지원 현황 리스트 검색 컨트롤러 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : open_job_info_delete
	 * @Date : 2019. 7. 2.
	 * @User : 김경아
	 * @Param :  게시판 글 시퀀스
	 * @Return :  
	 * @Method 설명 :  
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_DELETE, method = RequestMethod.POST)
	public int open_job_info_delete(Model model, int board_content_seq, String board_detail_gb) {
		logger.info("FAP 오픈잡페어 취업정보 & 전략 게시판 글 삭제 컨트롤러 시작");	
		int result = sfaService.fap_open_delete_job_info_content(board_content_seq);
		model.addAttribute("board_detail_gb",board_detail_gb);
		logger.info("FAP 오픈잡페어 취업정보 & 전략 게시판 글 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : admin_search_job_advertisement_list
	 * @Date : 2019. 07. 25.
	 * @User : 김경아
	 * @Param : HashMap
	 * @Return : 
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SEARCH_JOB_ADVERTISEMENT_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> admin_search_job_advertisement_list(
								@RequestBody HashMap<String, Object> selectedCompanyInfoMap){	
		logger.info("FAP 채용공고 상세검색 컨트롤러 시작");  		
		System.out.println("selectedCompanyInfoMap:"+selectedCompanyInfoMap);
		ArrayList<HashMap<String, Object>> jobAdvertisementList = sfaService.admin_search_job_advertisement_list(selectedCompanyInfoMap);
		logger.info("FAP 채용공고 상세검색 컨트롤러 종료");
		System.out.println("jobAdvertisementList:"+jobAdvertisementList);
		return jobAdvertisementList;
	}
	
	
	/**
	 * @Method Name : admin_select_company_group_code_list
	 * @Date : 2019. 7. 29.
	 * @User : 김경아
	 * @Param : 
	 * @Return : -
	 * @Method 설명 :  FAP 관리자 잡페어 그룹코드 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_SELECT_COMPANY_GROUP_CODE_LIST, method=RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> admin_select_company_group_code_list(Model model
			, @RequestParam(defaultValue="0") int fap_jobfair_seq) {		 
		 logger.info("FAP 관리자 잡페어 그룹코드 조회 시작");
		 HashMap<String, Object> paramMap = new HashMap<>();
		 paramMap.put("fap_jobfair_seq",fap_jobfair_seq);
		 ArrayList<HashMap<String, Object>> companyGroupCodeList = sfaService.admin_select_company_group_code_list(paramMap);	
		 logger.info("FAP 관리자 잡페어 그룹코드 조회 종료");		 
		 return companyGroupCodeList;
	}
	
	
	/**
	 * @Method Name : admin_notice_alim_list
	 * @Date : 2019. 8. 30.
	 * @User : 김경아
	 * @Param :  
	 * @Return :   관리자 알림 list   
	 * @Method 설명 :   관리자 알림 list 출력 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_NOTICE_ALIM_LIST, method=RequestMethod.POST)
	public HashMap<String,Object> admin_notice_alim_list( String selected_handle_gb
			, @RequestParam(defaultValue="10") int pageCount, @RequestParam(defaultValue="1") int currentPage){
		logger.debug("FAP 관리자 알림 list 출력 컨트롤러 시작");	 	
		HashMap<String,Object> alimList =  sfaService.select_admin_notice_alim_list(selected_handle_gb, pageCount, currentPage);			
		logger.debug("FAP 관리자 알림 list 출력 이동 컨트롤러 종료");
		return alimList;
	}
	
	/**
	 * @Method Name : admin_notice_update_handle_fin_gb
	 * @Date : 2019. 9. 06.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 변경 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_NOTICE_UPDATE_HANDLE_FIN_GB, method=RequestMethod.POST)
	public int admin_notice_update_handle_fin_gb(String fap_admin_notice_handle_fin_gb, String fap_admin_notice_seq){
		logger.debug("FAP 관리자 알림내용 처리상태 변경 컨트롤러 시작");
	     HashMap<String, Object> paramMap = new HashMap<>();
	     paramMap.put("fap_admin_notice_handle_fin_gb", fap_admin_notice_handle_fin_gb);
	     paramMap.put("fap_admin_notice_seq", fap_admin_notice_seq);
		int result = sfaService.admin_notice_update_handle_fin_gb(paramMap);
		logger.debug("FAP 관리자 알림내용 처리상태 변경 컨트롤러 시작");
		return result;
	}
	

	/**
	 * @Method Name : admin_notice_update_handle_fin_gb_all_selected
	 * @Date : 2019. 9. 06.
	 * @User : 김경아
	 * @Param :  알림 seq, 알림처리여부 
	 * @Return :     
	 * @Method 설명 :   알림내용 처리상태 단체변경 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_NOTICE_UPDATE_HANDLE_FIN_GB_ALL_SELECTED, method=RequestMethod.POST)
	public int admin_notice_update_handle_fin_gb_all_selected(@RequestParam String fap_admin_notice_handle_fin_gb
			, @RequestParam  List<Integer> fap_admin_notice_seq_list){
		logger.info("FAP 관리자 알림내용 처리상태 단체변경 컨트롤러 시작");
	
		 HashMap<String, Object> paramMap= new HashMap<String, Object>();
		 paramMap.put("fap_admin_notice_handle_fin_gb", fap_admin_notice_handle_fin_gb);
	     paramMap.put("fap_admin_notice_seq_list", fap_admin_notice_seq_list);
	     	    	   
		int result = sfaService.admin_notice_update_handle_fin_gb_all_selected(paramMap);
		logger.info("FAP 관리자 알림내용 처리상태 단체변경 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_admin_notice_list_not_handled
	 * @Date : 2019. 9. 9.
	 * @User : 김경아
	 * @Param :   처리여부 
	 * @Return :     
	 * @Method 설명 :  처리되지 않은 항목 갯수 조회 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_SELECT_ADMIN_NOTICE_NOT_HANDLED, method=RequestMethod.POST)
	 public int select_admin_notice_list_not_handled(){		 
		 logger.info("FAP 관리자 처리되지 않은 항목 갯수 조회 컨트롤러 시작");
		 int result=sfaService.select_admin_notice_list_not_handled();
		 logger.info("FAP 관리자 처리되지 않은 항목 갯수 조회 컨트롤러 종료");		 
		 return result;
	 }
	
	/**
	 * @Method Name : tokyofair_schedule_insert
	 * @Date : 2019. 9. 16.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지 잡페어 설정 정보 등록 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_INSERT, method = RequestMethod.POST)
	public int  tokyofair_schedule_insert(@RequestBody SocietyFapAdminJobfairSet fap_jobfair_set, Authentication auth) {
		logger.info("FAP 관리자 현지 잡페어 설정 정보 등록 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		
		int result = sfaService.tokyofair_schedule_insert(fap_jobfair_set, user_id);
		
		logger.info("FAP 관리자 현지 잡페어 설정 정보 등록 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_update
	 * @Date : 2019. 9. 20.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 정보
	 * @Return : -
	 * @Method 설명 : 현지 잡페어 설정 정보 수정 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_UPDATE, method = RequestMethod.POST)
	public int tokyofair_schedule_update(@RequestBody SocietyFapAdminJobfairSet fap_jobfair_set, Authentication auth) {
		logger.info("FAP 관리자 현지 잡페어 설정 정보 수정 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		
		int result = sfaService.tokyofair_schedule_update(fap_jobfair_set, user_id);
		
		logger.info("FAP 관리자 현지 잡페어 설정 정보 수정 컨트롤러 종료");
		return result;
	}

	
	/**
	 * @Method Name : tokyofair_schedule_set_search_list
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 설정 정보 리스트 
	 * @Method 설명 : 도쿄페어 설정 정보 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_SET_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminJobfairSet> tokyofair_schedule_set_search_list(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 도쿄페어 설정 정보 리스트 조회 컨트롤러 시작");
		ArrayList<SocietyFapAdminJobfairSet> result = sfaService.tokyofair_schedule_set_search_list(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 도쿄페어 설정 정보 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_gb_update
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스, 도쿄페어 설정 사용여부 구분
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 사용여부 구분 변경 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_SET_GB_UPDATE, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminJobfairSet> tokyofair_schedule_set_gb_update(int fap_jobfair_divide_seq,int fap_jobfair_set_seq, String fap_jobfair_set_gb, Authentication auth) {
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 구분 변경 DAO 시작");
		
		String user_id = (String)auth.getPrincipal();
		sfaService.tokyofair_schedule_set_gb_update(fap_jobfair_divide_seq,fap_jobfair_set_seq,fap_jobfair_set_gb,user_id);
		ArrayList<SocietyFapAdminJobfairSet> result = sfaService.tokyofair_schedule_set_search_list(fap_jobfair_divide_seq);
		
		logger.info("FAP 관리자 도쿄페어 설정 사용여부 구분 변경 DAO 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_set_delete
	 * @Date : 2019. 9. 19.
	 * @User : 이종호
	 * @Param : 도쿄페어 설정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 설정 삭제 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_DELETE, method = RequestMethod.POST)
	public ArrayList<SocietyFapAdminJobfairSet> tokyofair_schedule_set_delete(int fap_jobfair_divide_seq,int fap_jobfair_set_seq) {
		logger.info("FAP 관리자 도쿄페어 설정 삭제 서비스 시작");
		sfaService.tokyofair_schedule_set_delete(fap_jobfair_set_seq);
		ArrayList<SocietyFapAdminJobfairSet> result = sfaService.tokyofair_schedule_set_search_list(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 도쿄페어 설정 삭제 서비스 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_bookable
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 채용공고 리스트
	 * @Method 설명 : 관리자 도쿄페어 설명회,시험 등록가능 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCREENING_SEARCH_BOOKABLE , method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> tokyofair_screening_search_bookable(int fap_jobfair_divide_seq){
		logger.info("FAP 관리자 도쿄페어 설명회,시험 등록가능 조회 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> result = sfaService.tokyofair_screening_search_bookable(fap_jobfair_divide_seq);
		logger.info("FAP 관리자 도쿄페어 설명회,시험 등록가능 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_admin_insert
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : 추가전형 정보
	 * @Return : 등록 여부
	 * @Method 설명 : 관리자 도쿄페어 추가전형 등록
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_ADMIN_INSERT, method = RequestMethod.POST)
	public HashMap<String, Object> tokyofair_schedule_admin_insert(@RequestBody HashMap<String, Object> scheduleMap) {
		logger.info("FAP 관리자 도쿄페어 추가전형 등록 컨트롤러 시작");
		HashMap<String, Object> result = sfaService.tokyofair_schedule_admin_insert(scheduleMap);
		logger.info("FAP 관리자 도쿄페어 추가전형 등록 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_reload
	 * @Date : 2019. 10. 10.
	 * @User : 이종호
	 * @Param : 현지 잡페어 설정 시퀀스 , 등록된 일정 날짜
	 * @Return : 등록된 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 등록된 일정 정보 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_RELOAD, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> tokyofair_schedule_reload(@RequestBody HashMap<String, Object> reloadMap){
		logger.info("FAP 관리자 도쿄페어 등록된 일정 정보 리스트 조회 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> result = sfaService.tokyofair_schedule_reload(reloadMap);
		logger.info("FAP 관리자 도쿄페어 등록된 일정 정보 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_delete
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 삭제 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCREENING_DELETE, method = RequestMethod.POST)
	public int tokyofair_screening_delete(int fap_tokyofair_screening_seq) {
		logger.info("FAP 관리자 도쿄페어 전형 삭제 컨트롤러 시작");
		int result = sfcService.tokyofair_screening_delete(fap_tokyofair_screening_seq);
		logger.info("FAP 관리자 도쿄페어 전형 삭제 컨트롤러 종료");
		return result;
	}
}