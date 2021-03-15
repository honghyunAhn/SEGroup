/**
 * 
 */
package global.segroup.society.fap.user.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.changbi.user.service.UserService;
import com.google.gson.Gson;

import global.segroup.domain.AdminPager;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtApply;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPtResume;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.PathConstants;

/**
 * 
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 지원자 Rest 컨트롤러
 * 
 */

@Controller
public class SocietyFapUserRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapUserRestController.class);

	@Autowired
	private SocietyFapCompanyService sfcService;
		
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	//공지사항 게시판 코드
	public static final String BOARD_NOTICE_CODE = "A1700";
	
	//취업정보&전략 게시판 코드
	public static final String BOARD_JOBINFO_CODE = "A1701";
	
	/**
	 * @Method Name : user_id_check
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 유저가 입력한 아이디
	 * @Return : 일치하는 아이디 or null
	 * @Method 설명 : 유저가 입력한 아이디가 중복되는지 확인하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_USER_ID_CHECK, method = RequestMethod.POST)
	public boolean user_id_check(String user_id){
		logger.info("아이디 중복 체크 컨트롤러 시작");
		String user_id_check = sfuService.user_id_check(user_id);
		// 중복된 아이디가 없는 경우
		if(user_id_check == null){
			logger.info("아이디 중복 체크 컨트롤러 종료");
			return true;
		}
		logger.info("아이디 중복 체크 컨트롤러 종료");
		return false;
	}
	
	/**
	 * @Method Name : insert_my_favorite_company
	 * @Date : 2018. 12. 14.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 내가담은기업 목록에 담기 중복 저장 체크 Ajax
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_INSERT_MY_FAVORITE_COMPANY, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String insert_my_favorite_company(@RequestBody HashMap<String, Object> fapMyFavoriteCompany, Authentication auth){
		logger.debug("FAP 내가담은목록 담기 컨트롤러 시작");
		fapMyFavoriteCompany.put("user_id",(String) auth.getPrincipal());
		String message = sfuService.insert_my_favorite_company(fapMyFavoriteCompany);
		logger.debug("FAP 내가담은목록 담기 컨트롤러 종료");
		return message;
	}
	
	/**
	 * @Method Name : delete_my_favorite_company_list
	 * @Date : 2018. 12. 17.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 채용정보메뉴에서 내가담은기업보기 탭을 누르면 Ajax로 내가담은기업보기 출력
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_DELETE_MY_FAVORITE_COMPANY_LIST, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String delete_my_favorite_company_list(Authentication auth, @RequestBody HashMap<String, Object> deleteMyFavoriteCompany){
		logger.debug("FAP 내가담은목록 삭제 컨트롤러 시작");
		String user_id = (String) auth.getPrincipal();
		deleteMyFavoriteCompany.put("user_id", user_id);
		String message = sfuService.delete_my_favorite_company_list(deleteMyFavoriteCompany);
		logger.debug("FAP 내가담은목록 삭제 컨트롤러 종료");
		return message;
	}
	
	/**
	 * @Method Name : search_job_advertisement_list
	 * @Date : 2018. 12. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : SocietyFapUserJobAdvertisementList
	 * @Method 설명 : FAP 채용공고 상세검색
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_SEARCH_JOB_ADVERTISEMENT_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_job_advertisement_list(HttpSession session, @RequestBody HashMap<String, Object> selectedCompanyInfoMap ,Authentication auth){
		logger.debug("FAP 채용공고 상세검색 컨트롤러 시작");  
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		
		if(jobfairInfo == null) {
			session.setAttribute("divide_session", "divide_check");
			return null;
		}

	    selectedCompanyInfoMap.put("fap_jobfair_divide_seq", (int) jobfairInfo.get("fap_jobfair_divide_seq"));
	    selectedCompanyInfoMap.put("fap_jobfair_seq", (int) jobfairInfo.get("fap_jobfair_seq"));
	    selectedCompanyInfoMap.put("user_id", (String)auth.getPrincipal()); 
	    System.out.println("selectedCompanyInfoMap"+selectedCompanyInfoMap);
	    ArrayList<HashMap<String, Object>> jobAdvertisementList = sfuService.search_job_advertisement_list(selectedCompanyInfoMap);
		logger.debug("FAP 채용공고 상세검색 컨트롤러 종료");
		return jobAdvertisementList;
	}
	
	/**
	 * @Method Name : user_request_certification_code
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : 요청 결과 
	 * @Method 설명 : 인증번호를 발행하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_REQUEST_CERTIFICATION_CODE, method = RequestMethod.GET)
	public int user_request_certification_code(User user, HttpSession session) {
		logger.info("FAP 유저 회원 가입 인증 번호 발행 컨트롤러 시작");
		int requested = sfuService.user_request_certification_code(user);
		
		if (requested == 0) {
			session.removeAttribute("user_id");
			session.setAttribute("user_id", user.getUser_id());
			System.out.println("유저 회원 ( "+session.getAttribute("user_id")+" ) 가입 인증 번호 발행 !");
		}
		
		logger.info("FAP 유저 회원 가입 인증 번호 발행 컨트롤러 종료");
		return requested;
	}
	
	/**
	 * @Method Name : user_check_certification_code
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : 인증번호
	 * @Return : 인증결과
	 * @Method 설명 : 인증 결과를 확인 하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_CHECK_CERTIFICATION_CODE, method = RequestMethod.GET)
	public boolean user_check_certification_code(CertificationCode code, HttpSession session) {
		logger.info("FAP 유저 회원 가입 인증 번호 검사 컨트롤러 시작");
		String id = (String) session.getAttribute("user_id");
		code.setUser_id(id);
		boolean isRequested = sfuService.user_check_certification_code(code);
		// 인증 성공하면 세션에 확인 추가
		if (isRequested) {
			session.setAttribute("isCertificated", isRequested);
		}
		
		logger.info("FAP 유저 회원 가입 인증 번호 검사 컨트롤러 종료");
		return isRequested;
	}
	/**
	 * @Method Name : company_scale_statistics
	 * @Date : 2018. 12. 24.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 채용공고 기업규모별 상세통계
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_COMPANY_SCALE_STATISTICS, method = RequestMethod.POST)
	public HashMap<String, Object> company_scale_statistics(@RequestBody HashMap<String, Object> jobAdvertisementInfoMap){
		logger.debug("FAP 채용공고 기업규모별 상세통계 시작");    
	    HashMap<String, Object> companyScaleStatistics = sfuService.company_scale_statistics(jobAdvertisementInfoMap);
	    logger.debug("FAP 채용공고 기업규모별 상세통계 종료");
		return companyScaleStatistics;
	}

	/**
	 * @Method Name : apply_this_job_advertisement_applicable_check
	 * @Date : 2018. 12. 31.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 채용공고 중복지원 여부 체크
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_APPLY_THIS_JOB_ADVERTISEMENT_APPLICABLE_CHECK, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String apply_this_job_advertisement_applicable_check(@RequestBody HashMap<String, Object> applyApplicableCheckInfo, Authentication auth){
		logger.debug("FAP 채용공고 중복지원 여부 체크 시작");
		String user_id = (String) auth.getPrincipal();
		applyApplicableCheckInfo.put("user_id", user_id);
	    String message = sfuService.apply_job_advertisement_applicable_check(applyApplicableCheckInfo);
	    logger.debug("FAP 채용공고 중복지원 여부 체크 종료");
		return message;
	}
	
	/**
	 * @Method Name : common_required_doc_search_list
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사아이디
	 * @Return : 공통 내정서류 리스트
	 * @Method 설명 : 공통 내정서류 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_COMMON_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapCommonRequiredDoc> user_common_required_doc_search_list(@RequestParam(defaultValue = "0") int fap_job_ad_seq, @RequestParam(defaultValue = "") String fap_comp_id){
		logger.info("공통 내정서류 검색 컨트롤러 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashmap.put("fap_comp_id", fap_comp_id);
		ArrayList<SocietyFapCommonRequiredDoc> common_required_doc_list = sfcService.search_common_required_doc_list(hashmap);
		
		logger.info("공통 내정서류 검색 컨트롤러 종료");		
		return common_required_doc_list;
	}
	
	/**
	 * @Method Name : personal_required_doc_search_list
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : 개인 내정서류 리스트
	 * @Method 설명 : 개인 내정서류 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> user_personal_required_doc_search_list(@RequestParam(defaultValue = "0") int fap_nominee_seq){
		logger.info("개인 내정서류 검색 컨트롤러 시작");
				
		ArrayList<HashMap<String, Object>> personal_required_doc_list = sfcService.search_personal_required_doc_list(fap_nominee_seq);
		
		logger.info("개인 내정서류 검색 컨트롤러 종료");		
		return personal_required_doc_list;
	}
	
	/**
	 * @Method Name : select_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 내정자 내정서류 시퀀스
	 * @Return : 내정자 내정서류
	 * @Method 설명 : 내정자 내정서류 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_SEARCH, method = RequestMethod.POST)
	public SocietyFapPersonalRequiredDoc select_personal_required_doc(int fap_personal_required_doc_seq){
		logger.info("내정자 내정서류 검색 컨트롤러 시작");
		
		SocietyFapPersonalRequiredDoc personal_required_doc = sfcService.select_personal_required_doc(fap_personal_required_doc_seq);
		
		logger.info("내정자 내정서류 검색 컨트롤러 종료");	
		return personal_required_doc;
	}
	
	/**
	 * @Method Name : resume_deletable_check
	 * @Date : 2019. 1. 9.
	 * @User : 남유송
	 * @Param : int(이력서 일련번호)
	 * @Return : int
	 * @Method 설명 : 지원된 이력서를 삭제 못하도록 이력서가 이미 지원되어있는지 여부 검사
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_DELETABLE_CHECK, method = RequestMethod.POST)
	public String resume_deletable_check(int fap_resume_seq){
		logger.info("지원된 이력서 검색 컨트롤러 시작");
		String message = sfuService.select_undeletable_resume(fap_resume_seq);
		logger.info("지원된 이력서 검색 컨트롤러 시작");
		return message;
	}
	
	/**
	 * @Method Name : select_user_recruit_pcs_sch
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 취업지원자 전형 스케줄 정보
	 * @Method 설명 : 취업지원자 전형 스케줄 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RECRUIT_PROCESS_SCHEDULE_SELECT, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_user_recruit_pcs_sch(Authentication auth){
		logger.info("취업지원자 채용전형 정보 검색 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		ArrayList<HashMap<String, Object>> user_recruit_process_schedule = sfuService.select_user_recruit_pcs_sch(user_id);
		
		logger.info("취업지원자 채용전형 정보 검색 컨트롤러 종료");	
		return user_recruit_process_schedule;
	}
	
	/**
	 * @Method Name : select_user_review_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 서류전형 시퀀스
	 * @Return : 취업지원자 서류전형 정보
	 * @Method 설명 : 취업지원자 서류전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_REVIEW_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_user_review_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 서류전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> user_review_pcs_info= sfuService.select_user_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 서류전형 정보 검색 컨트롤러 종료");
		return user_review_pcs_info;
	}
	
	/**
	 * @Method Name : select_user_exam_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 시험전형 시퀀스
	 * @Return : 취업지원자 시험전형 정보
	 * @Method 설명 : 취업지원자 시험전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_EXAM_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_user_exam_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 시험전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> user_exam_pcs_info = sfuService.select_user_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 시험전형 정보 검색 컨트롤러 종료");
		return user_exam_pcs_info;
	}
	
	/**
	 * @Method Name : select_user_itv_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 면접전형 시퀀스
	 * @Return : 취업지원자 면접전형 정보
	 * @Method 설명 : 취업지원자 면접전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_ITV_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_user_itv_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 면접전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> user_itv_pcs_info = sfuService.select_user_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 면접전형 정보 검색 컨트롤러 종료");
		return user_itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_user_test_etc_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 취업지원자 기타전형 시퀀스
	 * @Return : 취업지원자 기타전형 정보
	 * @Method 설명 : 취업지원자 기타전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_TEST_ETC_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_user_test_etc_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("취업지원자 기타전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> user_test_etc_pcs_info = sfuService.select_user_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("취업지원자 기타전형 정보 검색 컨트롤러 종료");
		return user_test_etc_pcs_info;
	}
	
	/**
	 * @Method Name : delete_current_apply_info
	 * @Date : 2019. 1. 18.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 승인 전 지원정보 삭제
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_DELETE_CURRENT_APPLY_INFO, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String delete_current_apply_info(Authentication auth, HttpSession session, Long fap_job_app_info_seq){
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 컨트롤러 시작");
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		
		if(jobfairInfo == null) {
			session.setAttribute("divide_session", "divide_check");
			return null;
		}
		
		//데이터베이스에 들어갈 파라미터
		HashMap<String, Object> userInfoMap = new HashMap<>();
		String user_id = (String) auth.getPrincipal();
		userInfoMap.put("user_id", user_id);
		userInfoMap.put("fap_job_app_info_seq", fap_job_app_info_seq);
	    userInfoMap.put("fap_jobfair_divide_seq", (int) jobfairInfo.get("fap_jobfair_divide_seq"));
	    String message = sfuService.delete_current_apply_info(userInfoMap);
		logger.debug("FAP 취업지원자 승인 전 지원정보 삭제 컨트롤러 종료");
		return message;
	}
	
	
	/**
	 * @Method Name : select_applied_company_rank_edit_info_modal
	 * @Date : 2019. 1. 21.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 기업지망순위편집 모달창 출력
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_SELECT_APPLIED_COMPANY_RANK_EDIT_INFO_MODAL, method = RequestMethod.POST)
	public HashMap<String, Object> select_applied_company_rank_edit_info_modal(Authentication auth, HttpSession session){
		logger.debug("FAP 취업지원자 기업지망순위편집 모달창 출력 컨트롤러 시작");
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		
		if(jobfairInfo == null) {
			session.setAttribute("divide_session", "divide_check");
			return null;
		}
		
		//데이터베이스에 들어갈 파라미터
		HashMap<String, Object> userInfoMap = new HashMap<>();
		String user_id = (String) auth.getPrincipal();
		userInfoMap.put("user_id", user_id);
		userInfoMap.put("fap_jobfair_seq", (int) jobfairInfo.get("fap_jobfair_seq"));
		userInfoMap.put("fap_jobfair_divide_seq", (int) jobfairInfo.get("fap_jobfair_divide_seq"));
	    int perUserFixedCount = sfuService.select_applied_company_rank_edit_info_modal(userInfoMap);
	    HashMap<String, Object> finalPersonalApplyStatusListMap = sfuService.select_personal_apply_status_list(userInfoMap);
	    finalPersonalApplyStatusListMap.put("perUserFixedCount", perUserFixedCount);
		logger.debug("FAP 취업지원자 기업지망순위편집 모달창 출력 컨트롤러 종료");
		return finalPersonalApplyStatusListMap;
	}
	
	/**
	 * @Method Name : user_current_participation_jobfair_list
	 * @Date : 2019. 2. 15.
	 * @User : 정대영
	 * @Param : -
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_CURRENT_PARTICIPATION_JOBFAIR_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> user_current_participation_jobfair_list(Authentication auth){
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청 컨트롤러 시작");
		String user_id = null;
		try{
			user_id = (String) auth.getPrincipal();
		}catch (Exception e) {
			user_id = "";
		}
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuService.select_user_current_participation_jobfair_list(user_id);
		logger.debug("FAP 취업지원자 잡페어 선택 모달 눌렀을 때 해당아이디 잡페어 목록 요청 컨트롤러 종료");
		return jobfairInfoList;
	}
	
	/**
	 * @Method Name : user_request_save_jobfair_info
	 * @Date : 2019. 2. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 잡페어 선택 시 세션저장 요청 및 세션 변경
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_USER_REQUEST_SAVE_JOBFAIR_INFO, method = RequestMethod.POST)
	public String user_request_save_jobfair_info(HttpSession session, @RequestBody HashMap<String, Object> selectedJobfairInfo){
		logger.debug("FAP 취업지원자 잡페어 선택 시 세션저장 요청 컨트롤러 시작");
		int fap_jobfair_seq = Integer.parseInt((String) selectedJobfairInfo.get("fap_jobfair_seq"));
		int fap_jobfair_divide_seq = Integer.parseInt((String) selectedJobfairInfo.get("fap_jobfair_divide_seq"));
		HashMap<String, Object> jobfairInfo = new HashMap<>();
		jobfairInfo.put("fap_jobfair_seq", fap_jobfair_seq);
		jobfairInfo.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		jobfairInfo.put("fap_jobfair_title", (String) selectedJobfairInfo.get("fap_jobfair_title"));
		session.removeAttribute("jobfairInfo");
		session.setAttribute("jobfairInfo", jobfairInfo);
		String message = "saveFail";
		if(fap_jobfair_seq > 0 && fap_jobfair_divide_seq > 0){
			message = "saveSuccess";
		}
		session.removeAttribute("divide_session");
		logger.debug("FAP 취업지원자 잡페어 선택 시 세션저장 요청 컨트롤러 종료");
		return message;
	}
	
	/**
	 * @Method Name : request_apply_info_rank_change
	 * @Date : 2019. 2. 20.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 취업지원자 개인지원현황 지망순위 변경 요청
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_REQUEST_APPLY_INFO_RANK_CHANGE, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String request_apply_info_rank_change(@RequestBody ArrayList<HashMap<String, Object>> appInfoMapAry, Authentication auth){
		logger.debug("FAP 취업지원자 개인지원현황 지망순위 변경 요청 컨트롤러 시작");
	    String message = sfuService.request_apply_info_rank_change(appInfoMapAry);
	    logger.debug("FAP 취업지원자 개인지원현황 지망순위 변경 요청 컨트롤러 종료");
		return message;
	}
	
	/**
	 * @Method Name : select_apply_status_detail_info_modal
	 * @Date : 2019. 2. 21.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 개인별 상세정보 요청(개인지원현황 상세정보보기 모달창)
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_SELECT_APPLY_STATUS_DETAIL_INFO_MODAL, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_apply_status_detail_info_modal(long fap_job_app_info_seq, String status){
		logger.debug("FAP 취업지원자 개인별 상세정보 요청 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> userInfoMapList = sfuService.select_per_user_apply_detail_info(fap_job_app_info_seq, status);
		logger.debug("FAP 취업지원자 개인별 상세정보 요청 컨트롤러 종료");
		return userInfoMapList;
	}
	
	/**
	 * @Method Name : user_menu_check
	 * @Date : 2019. 2. 22.
	 * @User : 김준영
	 * @Param : 
	 * @Return : 
	 * @Method 설명 :
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_USER_MENU_CHECK, method = RequestMethod.POST)
	public String user_menu_check(String user_id){
		String menu_check = "default";
		logger.info("FAP 회원 메뉴 체크 컨트롤러 시작");
		int result = sfuService.check_user_personal(user_id);
		if(result == 0){
			menu_check = "disconnected";
		} else if(result == 1){
			menu_check = "connected";
		}
		logger.info("FAP 회원 메뉴 체크 컨트롤러 종료");
		return menu_check;
	}
	
	
	/**
	 * @Method Name : select_total_apply_status_detail_info_modal
	 * @Date : 2019. 2. 22.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMapList
	 * @Method 설명 : FAP 취업지원자 기업별 상세정보 요청(전체지원현황 상세정보보기 모달창)
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_SELECT_TOTAL_APPLY_STATUS_DETAIL_INFO_MODAL, method = RequestMethod.POST)
	public HashMap<String, Object> select_total_apply_status_detail_info_modal(long fap_job_ad_seq, Authentication auth){
		logger.debug("FAP 취업지원자 기업별 상세정보 요청(전체지원현황 상세정보보기 모달창) 컨트롤러 시작");
		String user_id = (String) auth.getPrincipal();
		HashMap<String, Object> totalApplyInfoMap = sfuService.select_total_apply_status_detail_info(fap_job_ad_seq, user_id);
		logger.debug("FAP 취업지원자 기업별 상세정보 요청(전체지원현황 상세정보보기 모달창) 컨트롤러 종료");
		return totalApplyInfoMap;
	}
	
	/**
	 * @Method Name : select_user_resume_info_read
	 * @Date : 2019. 2. 27.
	 * @User : 정대영
	 * @Param : Long
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 기업별 상세정보 요청(전체지원현황 상세정보보기 모달창)
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_SELECT_USER_RESUME_INFO_READ, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String select_user_resume_info_read(long fap_resume_seq, String user_id){
		logger.debug("FAP 취업지원자 이력서 읽기 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("fap_resume_seq", fap_resume_seq);
		param.put("user_id", user_id);
		HashMap<String, Object> resume_info = sfuService.selectResumeApply(param);
		Gson gson = new Gson();
		logger.debug("FAP 취업지원자 이력서 읽기 컨트롤러 종료");
		return gson.toJson(resume_info);
	}
	
	/**
	 * @Method Name : user_board_contents_search
	 * @Date : 2019. 3. 6.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 채용기업 메인 공지사항 정보
	 * @Method 설명 : 잡페어 채용기업 메인 공지사항 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_BOARD_CONTENTS_SEARCH, method = RequestMethod.POST)
	public ArrayList<BoardContent> user_board_contents_search(Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="10") int pageCount
			){
		logger.info("잡페어 채용기업 메인 공지사항 검색 컨트롤러 시작");
		
		int curPage = page;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("board_seq", boardGroup.getBoard_seq());
		// map.put("board_detail_gb","A1413");
		int count = sfuService.board_contents_count(map);
		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<BoardContent> resultList = sfuService.user_board_contents_search(map);
		logger.info("잡페어 채용기업 메인 공지사항 검색 컨트롤러 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : user_board_content_list_search
	 * @Date : 2019. 7. 17.
	 * @User : 김경아
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 지원자 공지사항 리스트
	 * @Method 설명 : 잡페어 지원자 공지사항 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_BOARD_CONTENT_LIST_SEARCH, method = RequestMethod.POST)
	public HashMap<String, Object> user_board_content_list_search(Model model, BoardGroup boardGroup 	 
			,@RequestParam(defaultValue="10") int pageCount
			,@RequestParam(defaultValue="1") int curPage
			,@RequestParam(defaultValue="1") int pageBegin
			,@RequestParam(defaultValue="") String searchKey
			,@RequestParam(defaultValue="") String searchValue
			){
		logger.info("잡페어 채용기업 공지사항 리스트 검색 컨트롤러 시작");
		 
		//전체 글 개수
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("board_detail_gb", boardGroup.getBoard_detail_gb());	 
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		int count = sfuService.board_contents_count(map);		 
	   
		map.put("curPage", curPage);
		map.put("pageBegin", pageBegin);		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
		map.put("count", count);  
		map.put("adminPager", adminPager);
		 
		
		//한 페이지 출력 리스트 
		ArrayList<BoardContent> resultList = sfuService.user_board_contents_list_search(map);
		 
		//제목 
		 String board_nm = sfuService.select_user_board_nm(boardGroup.getBoard_detail_gb());
		 map.put("board_nm",board_nm);
	 
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("map", map);
		resultMap.put("resultList", resultList);
		
		logger.info("잡페어 채용기업 공지사항 리스트 검색 컨트롤러 종료");
		return resultMap;
	}
	
	
	
	
	/**
	 * @Method Name : open_pt_apply
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 노출된 오픈잡페어 설명회 신청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_APPLY, method = RequestMethod.POST)
	public int open_pt_apply(SocietyFapOpenPtApply apply,Authentication auth) {
		logger.info("FAP 노출된 오픈잡페어 설명회 신청 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		
		apply.setUser_id(user_id);
		apply.setFap_open_pt_apply_ins_id(user_id);
		
		int result = sfuService.open_pt_apply_check(apply);
		
		if(result == 0) {
			sfuService.open_pt_apply(apply);
		}
		logger.info("FAP 노출된 오픈잡페어 설명회 신청 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_edu_apply
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 노출된 오픈잡페어 구직자 교육 신청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_EDU_APPLY, method = RequestMethod.POST)
	public int open_pt_edu_apply(SocietyFapOpenPtApply apply,Authentication auth,SocietyFapOpenPtResume resume) {
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 신청 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		
		apply.setUser_id(user_id);
		apply.setFap_open_pt_apply_ins_id(user_id);
		
		int result = sfuService.open_pt_apply_check(apply);
		
		if(result == 0) {
			sfuService.open_pt_edu_apply(apply,resume);
		}
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 신청 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : open_pt_apply_cancel
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스
	 * @Return : 취소 후 지원리스트
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 취소
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_APPLY_CANCEL, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> open_pt_apply_cancel(int fap_open_pt_apply_seq,Authentication auth) {
		logger.info("FAP 노출된 오픈잡페어 설명회 신청 취소 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		ArrayList<HashMap<String, Object>> result = sfuService.open_pt_apply_cancel(fap_open_pt_apply_seq,user_id);
		
		logger.info("FAP 노출된 오픈잡페어 설명회 신청 취소 컨트롤러 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : open_pt_apply_cancel
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스
	 * @Return : 취소 후 지원리스트
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 신청 취소
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_EDU_APPLY_CANCEL, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> open_pt_edu_apply_cancel(int fap_open_pt_apply_seq,Authentication auth) {
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 신청 취소 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		ArrayList<HashMap<String, Object>> result = sfuService.open_pt_edu_apply_cancel(fap_open_pt_apply_seq,user_id);
		
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 신청 취소 컨트롤러 종료");
		
		return result;
	}
	
	/**
	 * @Method Name : open_pt_apply_mypage_list
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 오픈잡페어 설명회 지원자 참가 내역
	 * @Method 설명 : 오픈잡페어 설명회 지원자 신청 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_APPLIED_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> user_open_pt_applied_list(Authentication auth){
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 리스트 조회 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		ArrayList<HashMap<String, Object>> result = sfuService.user_open_pt_applied_list(user_id);
		logger.info("FAP 오픈잡페어 설명회 지원자 신청 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_open_edu_applied_list
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : 회원 아이디
	 * @Return : 오픈잡페어 설명회 지원자 참가 내역
	 * @Method 설명 : 오픈잡페어 구직자교육 지원자 신청 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_EDU_APPLIED_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> user_open_edu_applied_list(Authentication auth){
		logger.info("FAP 오픈잡페어 구직자교육 지원자 신청 리스트 조회 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		ArrayList<HashMap<String, Object>> result = sfuService.user_open_edu_applied_list(user_id);
		logger.info("FAP 오픈잡페어 구직자교육 지원자 신청 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_popup_check
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 노출 팝업 리스트
	 * @Method 설명 : FAP 노출 팝업 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_POPUP_CHECK, method = RequestMethod.GET)
	public ArrayList<SocietyFapPopup> user_popup_check(){
		logger.info("FAP 노출 팝업 리스트 조회 컨트롤러 시작");
		ArrayList<SocietyFapPopup> result = sfuService.user_popup_check();
		logger.info("FAP 노출 팝업 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : user_personal_apply_final_decision
	 * @Date : 2019. 3. 25.
	 * @User : 이종호
	 * @Param : 최종확정 정보
	 * @Return : 개인지원현황 페이지
	 * @Method 설명 : FAP 취업지원자 개인지원현황 최종확정
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_PERSONAL_APPLY_FINAL_DECISION, method = RequestMethod.POST)
	public int user_personal_apply_final_decision(Authentication auth,@RequestBody HashMap<String, Object> paramMap) {
		logger.info("FAP 지원자 최종확정 결정 등록  컨트롤러 시작");
		paramMap.put("user_id", (String)auth.getPrincipal());
		int result = sfuService.user_personal_apply_final_decision(paramMap);
		
		//알림게시판 내용추가
		if(result>0){
			String user_id = (String)auth.getPrincipal();
			String fap_comp_en_nm = (String)paramMap.get("fap_comp_en_nm");
			String fap_admin_notice_ct = "지원자 \'"+user_id+"\'이(가) 기업 \'"+fap_comp_en_nm+"\' 에의 입사여부를 최종확정 했습니다.";
			HashMap<String, Object> alimParam = new HashMap<>();
			alimParam.put("fap_admin_notice_ins_id", user_id);
			alimParam.put("fap_admin_notice_ct", fap_admin_notice_ct);
			alimParam.put("fap_admin_notice_handle_gb","D2307");
			int adminInfo = sfaService.insert_admin_notice_info(alimParam);
		}
		logger.info("FAP 지원자 최종확정 결정 등록  컨트롤러 시작");
		return result;
	}
	
	/**
	 * @Method Name : insert_user_apply_confirm
	 * @Date : 2019. 9. 6.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스, 회원 아이디
	 * @Return : -
	 * @Method 설명 : 잡페어별 회원 지원동의(보증보험) 동의 등록 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_APPLY_CONFIRM, method = RequestMethod.POST)
	public boolean insert_user_apply_confirm(Authentication auth, int fap_jobfair_seq) {
		logger.info("잡페어별 회원 지원동의(보증보험) 동의 등록 서비스 시작");
		
		boolean flag = false;
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id", (String)auth.getPrincipal());
		params.put("fap_jobfair_seq", fap_jobfair_seq);
		
		int result = sfuService.insert_user_apply_confirm(params);
		
		if(result > 0) {
			flag = true;
		}
		
		logger.info("잡페어별 회원 지원동의(보증보험) 동의 등록 서비스 종료");
		
		return flag;
	}
	
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2020. 05. 11.
	 * @User : 전상수
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 * 
	 * 
	 * 2021.01.13 수정 김성미
	 * 회원탈퇴를 SMTP, LMS와 동일한 Service 매서드를 통해 통합 처리할 수 있도록 바꾸었습니다.
	 * SMTP, LMS처럼 비밀번호 일치 여부 확인 후, UserService의 deleteMemberInfo 매서드로 이동해 탈퇴 처리를 하도록 하였습니다.
	 * return 값 : int (국가에 따라 메세지 언어가 달라져야 하므로 SMTP, LMS처럼 한글 메세지를 redirect로 보내지 않음)
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_INFO_DELETE, method = RequestMethod.POST)
	public int delete_user_info(@RequestBody User user, HttpSession session){
		logger.info("FAP 회원 탈퇴 컨트롤러 시작");
		
		HashMap<String, Object> userInfo = userService.selectMemberInfo(user.getUser_id());
		if(userInfo != null) {
			String user_pw = (String) userInfo.get("USER_PW");
			if(!passwordEncoder.matches(user.getUser_pw(), user_pw)) {
				return 0; //비밀번호가 맞지 않는 경우
			}
			
			int result = userService.deleteMemberInfo(userInfo);
			if(result < 1) {
				logger.info("탈퇴오류");
				return 0;
			}
		}else {
			return 0; //사용자 아이디가 없는 경우
		}
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		logger.info("FAP 회원 탈퇴 컨트롤러 종료");
		return 1;
	}
}
