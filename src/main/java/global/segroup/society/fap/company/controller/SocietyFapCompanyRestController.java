/**
 * 
 */
package global.segroup.society.fap.company.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import global.segroup.domain.AdminPager;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapCompUserConnectRequest;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUserConnect;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairDate;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScreening;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * 
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 Rest 컨트롤러
 * 
 */

@Controller
public class SocietyFapCompanyRestController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyRestController.class);

	@Autowired
	private SocietyFapCompanyService sfcService;
		
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	private static final String INTERVIEW_LIMIT_TYPE_ALL = "C5402";
	
	/**
	 * 공통 유저 관련 DAO
	 */
	@Autowired
	private SocietyEduUserService seuService;
	
	/**
	 * @Method Name : company_user_id_check
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저가 입력한 아이디
	 * @Return : 중복 체크 후 boolean
	 * @Method 설명 : 유저가 입력한 아이디를 중복체크 해주는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_USER_ID_CHECK, method = RequestMethod.POST)
	public boolean company_user_id_check(String user_id){
		logger.info("아이디 중복 체크 컨트롤러 시작");
		String user_id_check = sfcService.user_id_check(user_id);
		// 중복된 아이디가 없는 경우
		if(user_id_check == null){
			return true;
		}
		logger.info("아이디 중복 체크 컨트롤러 종료");
		return false;
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
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_REQUEST_CERTIFICATION_CODE, method = RequestMethod.GET)
	public int user_request_certification_code(User user, HttpSession session) {
		logger.info("FAP 기업 유저 회원 가입 인증 번호 발행 컨트롤러 시작");
		int requested = sfcService.user_request_certification_code(user);
		
		if (requested == 0) {
			session.removeAttribute("user_id");
			session.setAttribute("user_id", user.getUser_id());
			System.out.println("유저 회원 ( "+session.getAttribute("user_id")+" ) 가입 인증 번호 발행 !");
		}
		
		logger.info("FAP 기업 유저 회원 가입 인증 번호 발행 컨트롤러 종료");
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
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_CHECK_CERTIFICATION_CODE, method = RequestMethod.GET)
	public boolean user_check_certification_code(CertificationCode code, HttpSession session) {
		logger.info("FAP 기업 유저 회원 가입 인증 번호 검사 컨트롤러 시작");
		String id = (String) session.getAttribute("user_id");
		code.setUser_id(id);
		boolean isRequested = sfcService.user_check_certification_code(code);
		// 인증 성공하면 세션에 확인 추가
		if (isRequested) {
			session.setAttribute("isCertificated", isRequested);
		}
		
		logger.info("FAP 기업 유저 회원 가입 인증 번호 검사 컨트롤러 종료");
		return isRequested;
	}
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 통합잡페어 정보 리스트
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOBFAIR_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> jobfair_search_list(Model model){
		logger.info("잡페어 리스트 검색 시작");
		
		ArrayList<HashMap<String, Object>> jobfairList = sfcService.jobfair_search_list();
		
		logger.info("잡페어 리스트 검색 종료");
		
		return jobfairList;
	}
	
	/**
	 * @Method Name : jobfair_divide_participation
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : (잡페어 시퀀스, 잡페어 세부 시퀀스, 회사ID, 에이전시 구분여부)
	 * @Return : -
	 * @Method 설명 : 회사 세부잡페어 참가
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOBFAIR_DIVIDE_PARTICIPATION, method = RequestMethod.POST)
	public String jobfair_divide_participation(Model model, Authentication auth, @RequestParam(defaultValue = "0") int fap_jobfair_seq, @RequestParam(defaultValue = "0") int fap_jobfair_divide_seq){
		logger.info("회사 세부잡페어 참가 컨트롤러 시작");
		
		//회사 아이디 발급 여부 확인
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		if(fap_comp_id == null){
			return null;
		}
		
		//세부 잡페어 참가
		String participation = "";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_seq", fap_jobfair_seq);
		hashmap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		hashmap.put("fap_comp_id", fap_comp_id);
		sfcService.company_jobfair_divide_participation(hashmap);		
		
		logger.info("회사 세부잡페어 참가 컨트롤러 종료");
		
		return participation;
	}

	/**
	 * @Method Name : company_user_connect_list
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 기업 - 유저 연결 객체, 기업 정보 객체
	 * @Method 설명 : 유저가 기업 연결을 요청하기 위해 필요한 리스트를 호출하는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_USER_CONNECT_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> company_user_connect_list(Authentication auth){
		ArrayList<SocietyFapCompanyUser> comp_list;
		SocietyFapCompanyUserConnect comp_user_connect = sfcService.select_comp_user_connect((String)auth.getPrincipal());
		HashMap<String, Object> hashMap = new HashMap<>();
		if(comp_user_connect == null){
			comp_list = sfcService.select_common_company();
			hashMap.put("check_connect", "non_exist");
			hashMap.put("comp_list", comp_list);
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3800")){ 
			hashMap.put("check_connect", "exist");
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3801")){
			hashMap.put("check_connect", "standBy");
			// 해당 하는 기업 뿌려주기
			SocietyFapCompanyUser standBy_company = sfcService.select_company((String)auth.getPrincipal());
			hashMap.put("comp_user_connect", comp_user_connect);
			hashMap.put("company_info", standBy_company);
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3802")){
			hashMap.put("check_connect", "refusal");
			// 해당 하는 기업 뿌려주기
			SocietyFapCompanyUser refusal_company = sfcService.select_company((String)auth.getPrincipal());
			hashMap.put("comp_user_connect", comp_user_connect);
			hashMap.put("company_info", refusal_company);
		}
		return hashMap;
	}
	
	/**
	 * @Method Name : common_required_doc_search_list
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사아이디
	 * @Return : 공통 내정서류 리스트
	 * @Method 설명 : 공통 내정서류 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapCommonRequiredDoc> company_required_doc_search_list(@RequestParam(defaultValue = "0") int fap_job_ad_seq, @RequestParam(defaultValue = "") String fap_comp_id){
		logger.info("공통 내정서류 검색 컨트롤러 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashmap.put("fap_comp_id", fap_comp_id);
		ArrayList<SocietyFapCommonRequiredDoc> common_required_doc_list = sfcService.search_common_required_doc_list(hashmap);
		
		logger.info("공통 내정서류 검색 컨트롤러 종료");		
		return common_required_doc_list;
	}
	
	/**
	 * @Method Name : request_handling
	 * @Date : 2019. 1. 2.
	 * @User : 김준영
	 * @Param : 요청 처리를 위한 유저 아이디, 기업 아이디, 처리 상태
	 * @Return : -
	 * @Method 설명 : 에이전시의 기업 연결 요청을 처리하는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_REQUEST_HANDLING, method = RequestMethod.POST)
	public void request_handling(Authentication auth, String fap_comp_id, String handling_ck){
		logger.info("FAP 에이전시 요청 처리 AJAX 시작");
		sfcService.request_handling(auth, fap_comp_id, handling_ck);
		logger.info("FAP 에이전시 요청 처리 AJAX 종료");
	}
	
	/**
	 * @Method Name : select_common_required_doc
	 * @Date : 2019. 1. 2.
	 * @User : 신동철
	 * @Param : 공통 내정서류 시퀀스
	 * @Return : 공통 내정서류
	 * @Method 설명 : 공통 내정서류 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_SEARCH, method = RequestMethod.POST)
	public SocietyFapCommonRequiredDoc select_company_required_doc(int fap_common_required_doc_seq){
		logger.info("특정 공통 내정서류 검색 컨트롤러 시작");
		
		SocietyFapCommonRequiredDoc common_required_doc = sfcService.select_common_required_doc(fap_common_required_doc_seq);
		
		logger.info("특정 공통 내정서류 검색 컨트롤러 종료");	
		return common_required_doc;
	}
	
	/**
	 * @Method Name : nominee_info_list_search
	 * @Date : 2019. 1. 5.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사아이디
	 * @Return : 내정자 정보 리스트
	 * @Method 설명 : 내정자 정보 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_NOMINEE_INFO_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> nominee_info_list_search(@RequestParam(defaultValue = "0") int fap_job_ad_seq, @RequestParam(defaultValue = "") String fap_comp_id){
		logger.info("내정자 정보 리스트 검색 컨트롤러 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashmap.put("fap_comp_id", fap_comp_id);
		ArrayList<HashMap<String, Object>> nominee_info_list = sfcService.search_nominee_info_list(hashmap);
		
		logger.info("내정자 정보 리스트 검색 컨트롤러 종료");		
		return nominee_info_list;
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
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> personal_required_doc_search_list(@RequestParam(defaultValue = "0") int fap_nominee_seq){
		logger.info("개인 내정서류 검색 컨트롤러 시작");
				
		ArrayList<HashMap<String, Object>> personal_required_doc_list = sfcService.search_personal_required_doc_list(fap_nominee_seq);
		
		logger.info("개인 내정서류 검색 컨트롤러 종료");		
		return personal_required_doc_list;
	}
	
	/**
	 * @Method Name : select_personal_required_doc
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류 시퀀스
	 * @Return : 개인 내정서류
	 * @Method 설명 : 개인 내정서류 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_SEARCH, method = RequestMethod.POST)
	public SocietyFapPersonalRequiredDoc select_personal_required_doc(int fap_personal_required_doc_seq){
		logger.info("특정 개인 내정서류 검색 컨트롤러 시작");
		
		SocietyFapPersonalRequiredDoc personal_required_doc = sfcService.select_personal_required_doc(fap_personal_required_doc_seq);
		
		logger.info("특정 개인 내정서류 검색 컨트롤러 종료");	
		return personal_required_doc;
	}
	
	/**
	 * @Method Name : nominee_info_search
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : 내정자 정보
	 * @Method 설명 : 내정자 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_NOMINEE_INFO_SEARCH, method = RequestMethod.POST)
	public HashMap<String, Object> nominee_info_search(SocietyFapNominee nominee){
		logger.info("내정자 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> nominee_info = sfcService.search_nominee_info(nominee);
		
		logger.info("내정자 정보 검색 컨트롤러 종료");		
		return nominee_info;
	}
	
	/**
	 * @Method Name : select_company_recruit_pcs_sch
	 * @Date : 2019. 1. 14.
	 * @User : 신동철
	 * @Param : 채용기업 전형일정 스케줄 검색 정보
	 * @Return : 채용기업 전형일정 스케줄
	 * @Method 설명 : 채용기업 전형일정 스케줄 검색
	 */
	
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_RECRUIT_PROCESS_SCHEDULE_SELECT, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_company_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch, HttpSession session){
		logger.info("채용기업 전형일정 스케줄 검색 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> schedule_list = sfcService.select_company_recruit_pcs_sch(recruit_pcs_sch, session);
		
		logger.info("채용기업 전형일정 스케줄 검색 컨트롤러 종료");
		return schedule_list;
	}
	
	/**
	 * @Method Name : search_company_jobfair_divide_list
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 회사아이디
	 * @Return : 채용기업 참가한 세부잡페어 정보 리스트
	 * @Method 설명 : 채용기업 참가한 세부잡페어 정보 검색
	 */
	
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOBFAIR_DIVIDE_LIST_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_company_jobfair_divide_list(SocietyFapJobRecruitPcsSch recruit_pcs_sch){
		logger.info("채용기업 참가한 세부잡페어 정보 검색 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> jobfair_divide_list = sfcService.search_company_jobfair_divide_list(recruit_pcs_sch);
		
		logger.info("채용기업 참가한 세부잡페어 정보 검색 컨트롤러 종료");
		return jobfair_divide_list;
	}
	
	/**
	 * @Method Name : select_company_review_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 서류전형 시퀀스
	 * @Return : 채용기업 서류전형 정보
	 * @Method 설명 : 채용기업 서류전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_REVIEW_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_company_review_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("채용기업 서류전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_review_pcs_info= sfcService.select_company_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 서류전형 정보 검색 컨트롤러 종료");
		return company_review_pcs_info;
	}
	
	/**
	 * @Method Name : select_company_exam_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 시험전형 시퀀스
	 * @Return : 채용기업 시험전형 정보
	 * @Method 설명 : 채용기업 시험전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_EXAM_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_company_exam_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("채용기업 시험전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_exam_pcs_info = sfcService.select_company_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 시험전형 정보 검색 컨트롤러 종료");
		return company_exam_pcs_info;
	}
	
	/**
	 * @Method Name : select_company_itv_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 면접전형 시퀀스
	 * @Return : 채용기업 면접전형 정보
	 * @Method 설명 : 채용기업 면접전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_ITV_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_company_itv_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("채용기업 면접전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_itv_pcs_info = sfcService.select_company_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 면접전형 정보 검색 컨트롤러 종료");
		return company_itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_company_test_etc_pcs
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : 채용기업 기타전형 시퀀스
	 * @Return : 채용기업 기타전형 정보
	 * @Method 설명 : 채용기업 기타전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TEST_ETC_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_company_test_etc_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("채용기업 기타전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_test_etc_pcs_info = sfcService.select_company_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("채용기업 기타전형 정보 검색 컨트롤러 종료");
		return company_test_etc_pcs_info;
	}
	
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOB_PCS_EDITABLE_CHECK, method = RequestMethod.POST)
	public String job_pcs_editable_check(long fap_job_recruit_pcs_seq){
		
		int check = sfcService.editable_check(fap_job_recruit_pcs_seq);
		
		if(check != 0){
			return "impossible";
		}
		
		return "possible";
	}
	
	/**
	 * @Method Name : company_board_contents_search
	 * @Date : 2019. 1. 23.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 채용기업 메인 공지사항 정보
	 * @Method 설명 : 잡페어 채용기업 메인 공지사항 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_BOARD_CONTENTS_SEARCH, method = RequestMethod.POST)
	public ArrayList<BoardContent> company_board_contents_search(Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="10") int pageCount
			){
		logger.info("잡페어 채용기업 메인 공지사항 검색 컨트롤러 시작");
		
		int curPage = page;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		// map.put("board_seq", board_seq);
		//map.put("board_detail_gb","A1413");
		int count = sfcService.board_contents_count(map);
		System.out.println(count);
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<BoardContent> resultList = sfcService.company_board_contents_search(map);
		
		logger.info("잡페어 채용기업 메인 공지사항 검색 컨트롤러 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : terms_update
	 * @Date : 2019. 1. 23.
	 * @User : 김준영
	 * @Param : 회원 객체
	 * @Return : 함수 작동 여부
	 * @Method 설명 : 회원의 약관 동의를 업데이트 하는 ajax 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TERMS_UPDATE, method = RequestMethod.POST)
	public int terms_update(User user){
		logger.info("FAP 회원 약관 동의 변경 컨트롤러 시작");
		user.setUser_terms_ck("A1301");
		int check = sfcService.terms_update(user);
		logger.info("FAP 회원 약관 동의 변경 컨트롤러 종료");
		return check;
	}
	
	
	/**
	 * @Method Name : company_board_contents_list_search
	 * @Date : 2019. 7. 16. 
	 * @User : 김경아
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 채용기업 공지사항 리스트
	 * @Method 설명 : 잡페어 채용기업 공지사항 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_BOARD_CONTENT_LIST_SEARCH, method = RequestMethod.POST)
	public HashMap<String, Object> company_board_contents_list_search(Model model, BoardGroup boardGroup 
			,@RequestParam(defaultValue="10") int pageCount
			,@RequestParam(defaultValue="1") int curPage
			,@RequestParam(defaultValue="1") int pageBegin
			,@RequestParam(defaultValue="") String searchKey
			,@RequestParam(defaultValue="") String searchValue
			){
		logger.info("잡페어 채용기업 공지사항 리스트 검색 컨트롤러 시작");
      
		//전체 글 갯수 
		HashMap<String, Object> map = new HashMap<String, Object>();		 
		map.put("pageCount", pageCount);
		map.put("board_detail_gb", boardGroup.getBoard_detail_gb());
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		int count = sfcService.board_contents_count(map);
		
		map.put("curPage", curPage);
		map.put("pageBegin", pageBegin);		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
			
		map.put("count", count);  
		map.put("adminPager", adminPager);
		 
		
		//글 리스트
		ArrayList<BoardContent> resultList = sfcService.company_board_contents_list_search(map);
		
		 //제목 
		 String board_nm = sfcService.select_comp_name(boardGroup.getBoard_detail_gb());
		 map.put("board_nm",board_nm);
		 
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("map", map);
		resultMap.put("resultList", resultList);
		
		logger.info("잡페어 채용기업 공지사항 리스트 검색 컨트롤러 종료");
		return resultMap;
	}
		
	
	/**
	 * @Method Name : delete_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 기업 - 유저 연결 시퀀스
	 * @Return : 실행결과
	 * @Method 설명 : 기업 - 유저 연결을 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_DELETE_COMPANY_USER_CONNECT, method = RequestMethod.POST)
	public int delete_request_comp_user_connect(int fap_comp_user_connect_seq){
		logger.info("FAP 기업 - 유저 연결 요청 삭제 컨트롤러 시작");
		int result = sfcService.delete_comp_user_connect(fap_comp_user_connect_seq);
		logger.info("FAP 기업 - 유저 연결 요청 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : request_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : 실행결과
	 * @Method 설명 : 유저의 기업 연결을 요청 한 후 메인페이지로 리턴하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_REQUEST_COMPANY_USER_CONNECT, method = RequestMethod.POST)
	public int request_comp_user_connect(Authentication auth, String fap_comp_id){
		logger.info("FAP 기업 - 유저 연결 요청 컨트롤러 시작");
		
		SocietyFapCompanyUserConnect comp_user_connect = new SocietyFapCompanyUserConnect();
		comp_user_connect.setFap_comp_id(fap_comp_id);
		comp_user_connect.setFap_comp_user_connect_ck("B3801");
		comp_user_connect.setUser_id((String)auth.getPrincipal());
		int result = sfcService.comp_user_connect(comp_user_connect);
		logger.info("FAP 기업 - 유저 연결 요청 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : search_company_job_ad_list
	 * @Date : 2019. 1. 25.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : 회사가 참가하여 승인받은 채용공고 리스트
	 * @Method 설명 : 회사가 참가하여 승인받은 채용공고 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_LIST_SEARCH, method = RequestMethod.POST)
	public ArrayList<SocietyFapJobAd> search_company_job_ad_list(SocietyFapJobAd jobAd){
		logger.info("채용공고 리스트 검색 컨트롤러 시작");
		System.out.println(jobAd);
		ArrayList<SocietyFapJobAd> job_ad_list = sfcService.search_company_job_ad_list(jobAd);
		
		logger.info("채용공고 리스트 검색 컨트롤러 종료");
		return job_ad_list;
	}
	
	/**
	 * @Method Name : fap_company_select_per_state_job_ad_list
	 * @Date : 2019. 1. 28.
	 * @User : 정대영
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : HashMapList(회사별 진행중인 잡페어 리스트)
	 * @Method 설명 : FAP 회사 진행중인 채용공고 목록 리스트 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_SELECT_PER_STATE_JOB_AD_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> company_select_per_state_job_ad_list(@RequestBody HashMap<String, Object> params, Authentication auth){
		logger.debug("채용공고 리스트 검색 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		params.put("fap_comp_id", fap_comp_id);
		
		//에러 감지용 로그 시작
		logger.info("---------> 에러감지용 로그 시작(CompanyRestController)");
		logger.info("회사아이디 : " + fap_comp_id);
		logger.info("잡페어 세부 및 진행상태 정보 : " + params.toString());
		logger.info("---------> 에러감지용 로그 종료(CompanyRestController)");
		//에러 감지용 로그 종료
		
		ArrayList<HashMap<String, Object>> perStateJobAdList = sfcService.select_job_ad_by_state(params);
		
		logger.debug("채용공고 리스트 검색 컨트롤러 종료");
		return perStateJobAdList;
	}
	
	/**
	 * @Method Name : society_fap_company_menu_check
	 * @Date : 2019. 1. 29.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : 메뉴 체크
	 * @Method 설명 : 유저에게 보여 줄 메뉴를 확인 하는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_MENU_CHECK, method = RequestMethod.POST)
	public String society_fap_company_menu_check(String user_id){
		logger.info("FAP 기업 메뉴 체크 컨트롤러 시작");
		
		if(user_id.equals("") || user_id == null){
			return "default";
		}
		SocietyFapCompanyUserConnect connect_info = sfcService.select_comp_user_connect(user_id);
		
		String connect_ck = "";
		if(connect_info != null){
			connect_ck = connect_info.getFap_comp_user_connect_ck();			
		}
		String menu_check = "";
		
		if(connect_ck.equals("B3801") || connect_ck.equals("B3802")){
			menu_check = "disconnected";
		} else if(connect_ck.equals("B3800")){
			menu_check = "connected";
		} else if(connect_ck.equals("")){
			menu_check = "disconnected";
		}
		
		logger.info("FAP 기업 메뉴 체크 컨트롤러 종료");
		return menu_check;
	}
	
	/**
	 * @Method Name : update_job_ad_state
	 * @Date : 2019. 1. 26.
	 * @User : 정대영
	 * @Param : SocietyFapJobAd(fap_job_ad_seq, fap_job_ad_state)
	 * @Return : 
	 * @Method 설명 : 채용공고 상태 수정
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_UPDATE_JOB_AD_STATE, method = RequestMethod.POST)
	public void update_job_ad_state(@RequestBody SocietyFapJobAd jobAd, Authentication auth, Model model){
		logger.debug("FAP 담당자 - 채용공고 상태 수정 시작");
		int result = sfcService.update_job_ad_state(jobAd);
		
		//알림게시판에 관련정보 추가 
		if(result>0){			
				String fap_comp_id = (String)auth.getPrincipal();
				String fap_job_ad_state = jobAd.getFap_job_ad_state();	 		 
				if(fap_job_ad_state.equals("C2104")){		 
						String fap_admin_notice_ct = "기업 \'"+fap_comp_id+"\'가  채용공고의  승인을 요청했습니다."; 				
						HashMap<String, Object> paramMap = new HashMap<>();
						paramMap.put("fap_admin_notice_ins_id", fap_comp_id);
						paramMap.put("fap_admin_notice_ct",fap_admin_notice_ct);
						paramMap.put("fap_admin_notice_handle_need_gb", "D2101");
						paramMap.put("fap_admin_notice_handle_gb","D2302");
						int adminInfo = sfaService.insert_admin_notice_info(paramMap);						 	
				}		
		}
		logger.debug("FAP 담당자 - 채용공고 상태 수정 끝");
	}
	
	/**
	 * @Method Name : delete_company_user_info
	 * @Date : 2019. 1. 31.
	 * @User : 김준영, 정대영
	 * @Param : 탈퇴할 기업 담당자 객체
	 * @Return : -
	 * @Method 설명 : 기업 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(45글자) 변경후 참조 테이블에 적용
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_USER_INFO_DELETE, method = RequestMethod.POST)
	public int delete_user_info(@RequestBody User user, HttpSession session){
		logger.info("FAP 기업 담당자 탈퇴 컨트롤러 시작");
		int result = sfcService.delete_company_user_info(user);
		if(result > 0){
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
		}
		logger.info("FAP 기업 담당자 탈퇴 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : insert_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 기업 - 담당자 연결 요청 객체
	 * @Return : 요청 등록 성공 여부
	 * @Method 설명 : 기업 - 담당자 연결을 요청하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_CONNECT_REQUEST, method = RequestMethod.POST)
	public int insert_connect_request(Authentication auth, SocietyFapCompUserConnectRequest CompUserConnectRequest){
		logger.info("FAP 기업 - 담당자 연결 요청 컨트롤러 시작");
		int result = sfcService.insert_connect_request(auth, CompUserConnectRequest);
		logger.info("FAP 기업 - 담당자 연결 요청 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : delete_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : 기업 - 담당자 연결 요청을 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_CONNECT_REQUEST_DELETE, method = RequestMethod.POST)
	public int delete_connect_request(int fap_comp_user_request_seq){
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 컨트롤러 시작");
		int result = sfcService.delete_connect_request(fap_comp_user_request_seq);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_job_ad_load_list_paging
	 * @Date : 2019. 2. 11.
	 * @User : 정대영
	 * @Param : -
	 * @Return : HashMap(이전에 등록한 채용공고 정보, 페이징 정보)
	 * @Method 설명 : FAP 기업 채용공고 등록화면에서 이전 채용공고 불러오기 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_SELECT_SELECT_JOB_AD_LOAD_LIST_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> select_job_ad_load_list_paging(Authentication auth, int clickedPage, int fap_jobfair_seq){
		logger.debug("FAP 기업 채용공고 등록화면에서 이전 채용공고 불러오기 페이징 된 정보 요청 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_comp_id", fap_comp_id);
		paramMap.put("fap_jobfair_seq", fap_jobfair_seq);
		
		int adTotalCount = sfcService.select_job_ad_load_list_count(paramMap);
		if(adTotalCount == 0){adTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(5, 5, clickedPage, adTotalCount);
		// 해당 기업이 작성한 채용공고 리스트 가져오기
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfcService.select_job_ad_load_list_paging(paramMap, repNavi.getStartRecord(), repNavi.getCountPerPage());
		HashMap<String, Object> jobAdLoadListInfo = new HashMap<>();
		jobAdLoadListInfo.put("select_job_ad_load_list", select_job_ad_load_list);
		jobAdLoadListInfo.put("repNavi", repNavi);
		jobAdLoadListInfo.put("adTotalCount", adTotalCount);
		logger.debug("FAP 기업 채용공고 등록화면에서 이전 채용공고 불러오기 페이징 된 정보 요청 컨트롤러 종료");
		return jobAdLoadListInfo;
	}
	
	/**
	 * @Method Name : delete_job_ad_box
	 * @Date : 2019. 2. 11.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 채용공고를 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_DELETE, method=RequestMethod.POST)
	public int delete_job_ad_box(long fap_job_ad_seq){
		logger.info("FAP 채용공고 삭제 컨트롤러 시작");
		int result = sfcService.delete_job_ad_box(fap_job_ad_seq);
		logger.info("FAP 채용공고 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : pay_for_cost_search
	 * @Date : 2019. 2. 15.
	 * @User : 이종호
	 * @Param : 잡페어 seq
	 * @Return : 해당 잡페어 해당 기업의 비용결제 금액
	 * @Method 설명 : 채용공고를 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_PAY_FOR_COST_SEARCH, method=RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> pay_for_cost_search(int fap_jobfair_seq, Authentication auth){
		
		logger.info("FAP 기업 - 비용결제 검색 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id",(String)auth.getPrincipal());
		params.put("fap_jobfair_seq",fap_jobfair_seq);
		
		ArrayList<HashMap<String, Object>> result = sfcService.company_pay_for_cost(params);

		logger.info("FAP 기업 - 비용결제 검색 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : search_applicant_info
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 seq, 회사 아이디
	 * @Return : 채용전형 지원자 정보
	 * @Method 설명 : 채용전형 지원자 정보 불러오는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_SEARCH_APPLICANT_INFO, method=RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_applicant_info(String fap_job_ad_seq, String fap_comp_id){
		logger.info("FAP 채용전형 지원자 정보 불러오기 컨트롤러 시작");
		HashMap <String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", Long.parseLong(fap_job_ad_seq));
		hashmap.put("fap_comp_id", fap_comp_id);
		ArrayList<HashMap<String, Object>> resultMap = sfcService.search_applicant_info(hashmap);
		logger.info("FAP 채용전형 지원자 정보 불러오기 컨트롤러 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : select_job_ad_recruit_pcs
	 * @Date : 2019. 2. 15.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스
	 * @Return : 채용공고 채용전형 정보
	 * @Method 설명 : 채용공고 지원자관리 채용전형 정보 검색 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_SELECT_JOB_AD_RECRUIT_PCS, method=RequestMethod.POST)
	public ArrayList<SocietyFapJobRecruitPcs> select_job_ad_recruit_pcs(String fap_job_ad_seq){
		logger.info("FAP 채용공고 지원자관리 채용전형 정보 검색 컨트롤러 시작");
		ArrayList<SocietyFapJobRecruitPcs> recruit_pcs = sfcService.select_job_ad_recruit_pcs(Long.parseLong(fap_job_ad_seq));
		logger.info("FAP 채용공고 지원자관리 채용전형 정보 검색 컨트롤러 종료");
		return recruit_pcs;
	}
	
	/**
	 * @Method Name : select_my_applied_resume
	 * @Date : 2019. 02. 19.
	 * @User : 남유송
	 * @Param : int
	 * @Return : HashMap
	 * @Method 설명 : 채용공고별 지원자 이력서 가져오기
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_APPLIED_RESUME_LIST, method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String select_my_applied_resume(int fap_resume_seq, String user_id, Model model){
		logger.info("채용공고별 지원자 이력서 리스트 출력 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("fap_resume_seq", fap_resume_seq);
		param.put("user_id", user_id);
		HashMap<String, Object> wholeResume = sfuService.selectResumeApply(param);
		Gson gson = new Gson();
		logger.info("채용공고별 지원자 이력서 리스트 리스트 출력 컨트롤러 종료");
		return gson.toJson(wholeResume);
	}

	/**
	 * @Method Name : user_duplicated
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param : 
	 * @Return :  중복되면 true / 중복되지 않으면 false
	 * @Method 설명 : 유저 정보가 중복하는지 검사하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_USER_DUPLICATED, method = RequestMethod.GET)
	public boolean user_duplicated(User user) {
		logger.debug("유저 회원 가입 아이디 중복 검사 컨트롤러 시작");
		boolean isDuplicated = seuService.user_duplicated(user);
		logger.debug("유저 회원 가입 아이디 중복 검사 컨트롤러 종료");
		return isDuplicated;
	}
	
	/**
	 * @Method Name : company_popup_check
	 * @Date : 2019. 6. 5.
	 * @User : 이종호
	 * @Param : -
	 * @Return : FAP 기업 노출 팝업 리스트
	 * @Method 설명 : FAP 기업 노출 팝업 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_POPUP_CHECK, method = RequestMethod.GET)
	public ArrayList<SocietyFapPopup> company_popup_check(){
		logger.info("FAP 기업 노출 팝업 리스트 조회 컨트롤러 시작");
		ArrayList<SocietyFapPopup> result = sfuService.user_popup_check();
		logger.info("FAP 기업 노출 팝업 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : interview_limit_check
	 * @Date : 2019. 8. 1.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스 , 현지면접 합격자 수
	 * @Return : 인원제한 가능 여부
	 * @Method 설명 : FAP 기업 전형 합/불 시 현지면접 합격자 수 인원제한 체크
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_INTERVIEW_LIMIT_CHECK, method = RequestMethod.POST)
	public boolean interview_limit_check(long fap_job_ad_seq , int ck_count) {
		
		logger.info("FAP 채용공고별 현지면접 대상자 인원제한 체크용 검색 컨트롤러 시작");
		
		HashMap<String, Object> limit_result = sfcService.select_interview_limit_check(fap_job_ad_seq);
		int fap_jobfair_seq = Integer.parseInt(limit_result.get("fap_jobfair_seq").toString());
		int settled_num = Integer.parseInt(limit_result.get("fap_job_itv_per_settled_num").toString());
		String limit_type = sfcService.select_interview_limit_type(fap_jobfair_seq);
		String ad_limit_type = limit_result.get("fap_job_ad_category_type").toString();
		//true : 제한 , false : 허용
		boolean ck_flag = false;
		
		//제한 대상일 경우
		if(limit_type.equals(ad_limit_type) || limit_type.equals(INTERVIEW_LIMIT_TYPE_ALL)) {
			//인원 체크
			if(ck_count > settled_num) {
				ck_flag = true;
			}
		}
		
		logger.info("FAP 채용공고별 현지면접 대상자 인원제한 체크용 검색 컨트롤러 시작");
		
		return ck_flag;
	}
	
	/**
	 * @Method Name : tokyofair_screening_date_check
	 * @Date : 2019. 9. 24.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 )
	 * @Method 설명 : 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_DATE_CHECK, method = RequestMethod.POST)
	public int company_tokyofair_screening_date_check(int fap_jobfair_divide_seq) {
		logger.info("FAP 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회 컨트롤러 시작");
		int result = sfcService.tokyofair_screening_date_check(fap_jobfair_divide_seq);
		logger.info("FAP 도쿄페어 기업 전형 등록 가능 여부 ( 1: 가능 , 0: 불가능 ) 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_subject_search
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 대상자
	 * @Method 설명 : 도쿄페어 전형 대상자 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SUBJECT_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> tokyofair_screening_subject_search(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 대상자 조회 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> subject = sfcService.tokyofair_screening_subject_search(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 대상자 조회 컨트롤러 종료");
		return subject;
	}
	
	/**
	 * @Method Name : tokyofair_screening_subject_search_two
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 대상자 일부
	 * @Method 설명 : 도쿄페어 전형 대상자 일부 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SUBJECT_SEARCH_TWO, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> tokyofair_screening_subject_search_two(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 대상자 일부 조회 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> subject = sfcService.tokyofair_screening_subject_search_two(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 대상자 일부 조회 컨트롤러 종료");
		return subject;
	}
	
	/**
	 * @Method Name : tokyofair_screening_subject_search_three
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스, 도쿄페어 전형 시퀀스
	 * @Return : 도쿄페어 전형별 대상자 일부
	 * @Method 설명 : 도쿄페어 전형별 대상자 일부 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SUBJECT_SEARCH_THREE, method = RequestMethod.POST)
	public HashMap<String, Object> tokyofair_screening_subject_search_three(long fap_job_ad_seq,int fap_tokyofair_screening_seq){
		logger.info("FAP 도쿄페어 전형별 대상자 일부 조회 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> subject = sfcService.tokyofair_screening_subject_search_two(fap_job_ad_seq);
		HashMap<String, Object> result = sfcService.tokyofair_screening_subject_search_three(subject, fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형별 대상자 일부 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search
	 * @Date : 2019. 9. 27.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 리스트
	 * @Method 설명 : 도쿄페어 전형 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH, method = RequestMethod.POST)
	public ArrayList<SocietyFapTokyofairScreening> tokyofair_screening_search(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 리스트 조회 컨트롤러 시작");
		ArrayList<SocietyFapTokyofairScreening> result = sfcService.tokyofair_screening_search(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 리스트 조회 컨트롤러 종료");
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
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_DELETE, method = RequestMethod.GET)
	public int company_tokyofair_screening_delete(int fap_tokyofair_screening_seq) {
		logger.info("FAP 도쿄페어 전형 삭제 컨트롤러 시작");
		int result = sfcService.tokyofair_screening_delete(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_bookable
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : 도쿄페어 전형 중 예약 가능한 리스트
	 * @Method 설명 : 도쿄페어 전형 중 예약 가능한 리스트 조회 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_BOOKABLE, method = RequestMethod.POST)
	public ArrayList<SocietyFapTokyofairScreening> tokyofair_screening_search_bookable(long fap_job_ad_seq){
		logger.info("FAP 도쿄페어 전형 중 예약 가능한 리스트 조회 컨트롤러 시작");
		ArrayList<SocietyFapTokyofairScreening> result = sfcService.tokyofair_screening_search_bookable(fap_job_ad_seq);
		logger.info("FAP 도쿄페어 전형 중 예약 가능한 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_screening_search_one
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : 도쿄페어 전형 정보
	 * @Method 설명 : 도쿄페어 전형 정보 조회
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_ONE, method = RequestMethod.POST)
	public HashMap<String, Object> tokyofair_screening_search_one(int fap_tokyofair_screening_seq){
		logger.info("FAP 도쿄페어 전형 정보 조회 컨트롤러 시작");
		HashMap<String, Object> tokyofairScrMap = sfcService.tokyofair_screening_search_one(fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 전형 정보 조회 컨트롤러 종료");
		return tokyofairScrMap;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_insert
	 * @Date : 2019. 10. 4.
	 * @User : 이종호
	 * @Param : 등록할 도쿄페어 일정 정보
	 * @Return : 등록 가능여부, 등록시 일정 시퀀스
	 * @Method 설명 : 등록가능여부를 판단하여 도쿄페어 일정을 등록
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_INSERT, method = RequestMethod.POST)
	public HashMap<String, Object> tokyofair_schedule_insert(@RequestBody HashMap<String, Object> params, Authentication auth){
		logger.info("FAP 등록가능여부를 판단하여 도쿄페어 일정을 등록 컨트롤러 시작");
		HashMap<String, Object> result = new HashMap<>();
		boolean insertFlag = false;
		String user_id = (String)auth.getPrincipal();
		//도쿄페어 일정 가능여부 확인
		int check = sfcService.tokyofair_schedule_info_check(params);

		//가능
		if(check == 0) {
			//도쿄페어 일정 등록
			long fap_tokyofair_schedule_seq = sfcService.tokyofair_schedule_insert(params, user_id);
			insertFlag = true;
			result.put("fap_tokyofair_schedule_seq", fap_tokyofair_schedule_seq);
		}
		//불가능
		else {
			
		}
		result.put("insertFlag", insertFlag);
		
		logger.info("FAP 등록가능여부를 판단하여 도쿄페어 일정을 등록 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_delete
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 삭제 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_DELETE, method = RequestMethod.POST)
	public int tokyofair_schedule_delete(long fap_tokyofair_schedule_seq) {
		logger.info("FAP 도쿄페어 일정 삭제 컨트롤러 시작");
		int result = sfcService.tokyofair_schedule_delete(fap_tokyofair_schedule_seq);
		logger.info("FAP 도쿄페어 일정 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_first_check
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 도쿄페어 날짜 정보
	 * @Return : 최초일정 여부
	 * @Method 설명 : 도쿄페어 최초등록 일정 여부 판단
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_FIRST_CHECK, method = RequestMethod.POST)
	public boolean tokyofair_schedule_first_check(SocietyFapTokyofairDate tokyofairDate) {
		logger.info("FAP 도쿄페어 최초등록 일정 여부 판단 컨트롤러 시작");
		boolean result = false;
		int count = sfcService.tokyofair_schedule_first_check(tokyofairDate);
		
		if(count > 0) {
			result = true;
		}
		
		logger.info("FAP 도쿄페어 최초등록 일정 여부 판단 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_itv_comp_check
	 * @Date : 2019. 10. 7.
	 * @User : 이종호
	 * @Param : 
	 * @Return :  
	 * @Method 설명 : 도쿄페어 앞면접 과의 면접준비시간 체크
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_ITV_COMP_BEFORE_CHECK, method = RequestMethod.POST)
	public boolean tokyofair_schedule_itv_comp_before_check(@RequestBody HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 앞면접 과의 면접준비시간 체크 컨트롤러 시작");
		boolean result = false;
		int count = sfcService.tokyofair_schedule_itv_comp_before_check(params);
		
		if(count > 0) {
			result = true;
		}
		
		logger.info("FAP 도쿄페어 앞면접 과의 면접준비시간 체크 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_term_check
	 * @Date : 2019. 10. 8.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 도쿄페어 앞면접 과의 여유도 체크
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_TERM_CHECK, method = RequestMethod.POST)
	public boolean tokyofair_schedule_term_check(@RequestBody HashMap<String, Object> params) {
		logger.info("FAP 도쿄페어 앞면접 과의 여유도 체크 컨트롤러 시작");
		boolean result = false;
		int count = sfcService.tokyofair_schedule_term_check(params);
		
		if(count > 0) {
			result = true;
		}
		
		logger.info("FAP 도쿄페어 앞면접 과의 여유도 체크 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_insert
	 * @Date : 2019. 10. 8.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : 
	 * @Method 설명 : 도쿄페어 일정 인원 등록
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MEMBER_INSERT, method = RequestMethod.POST)
	public 	ArrayList<HashMap<String, Object>> tokyofair_schedule_member_insert(@RequestBody HashMap<String, Object> scheduleMemberMap) {
		logger.info("FAP 도쿄페어 일정 인원 등록 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> result = sfcService.tokyofair_schedule_member_duplicate_check(scheduleMemberMap);
		
		if(result.size() == 0) {
			sfcService.tokyofair_schedule_member_insert(scheduleMemberMap);
		}
		
		logger.info("FAP 도쿄페어 일정 인원 등록 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_update
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 인원 정보
	 * @Return : 
	 * @Method 설명 : 도쿄페어 일정 인원 수정
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MEMBER_UPDATE, method = RequestMethod.POST)
	public 	ArrayList<HashMap<String, Object>> tokyofair_schedule_member_update(@RequestBody HashMap<String, Object> scheduleMemberMap) {
		logger.info("FAP 도쿄페어 일정 인원 수정 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> result = sfcService.tokyofair_schedule_member_duplicate_check(scheduleMemberMap);
		
		if(result.size() == 0) {
			sfcService.tokyofair_schedule_member_update(scheduleMemberMap);
		}
		
		logger.info("FAP 도쿄페어 일정 인원 수정 컨트롤러 종료");
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
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_RELOAD, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> tokyofair_schedule_reload(@RequestBody HashMap<String, Object> reloadMap){
		logger.info("FAP 도쿄페어 등록된 일정 정보 리스트 조회 컨트롤러 시작");
		ArrayList<HashMap<String, Object>> result = sfcService.tokyofair_schedule_reload(reloadMap);
		logger.info("FAP 도쿄페어 등록된 일정 정보 리스트 조회 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_search_detail
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스
	 * @Return : 도쿄페어 일정 및 인원 정보
	 * @Method 설명 : 도쿄페어 일정 정보 및 인원 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_SEARCH_DETAIL, method = RequestMethod.POST)
	public HashMap<String, Object> tokyofair_schedule_search_detail(long fap_tokyofair_schedule_seq){
		logger.info("FAP 도쿄페어 일정 정보 및 인원 정보 검색 컨트롤러 시작");
		HashMap<String, Object> result = sfcService.tokyofair_schedule_search_detail(fap_tokyofair_schedule_seq);
		logger.info("FAP 도쿄페어 일정 정보 및 인원 정보 검색 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_member_delete
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 도쿄페어 일정 시퀀스, 도쿄페어 전형 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 인원 삭제 
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MEMBER_DELETE, method= RequestMethod.POST)
	public int tokyofair_schedule_member_delete(long fap_tokyofair_schedule_seq, int fap_tokyofair_screening_seq) {
		logger.info("FAP 도쿄페어 일정 인원 삭제 컨트롤러 시작");
		int result = sfcService.tokyofair_schedule_member_delete(fap_tokyofair_schedule_seq,fap_tokyofair_screening_seq);
		logger.info("FAP 도쿄페어 일정 인원 삭제 컨트롤러 종료");
		return result;
	}
}
