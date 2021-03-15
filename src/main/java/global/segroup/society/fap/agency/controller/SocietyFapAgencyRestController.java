/**
 * 
 */
package global.segroup.society.fap.agency.controller;

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
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.agency.service.SocietyFapAgencyService;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapCompUserConnectRequest;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUserConnect;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * @Author : 김준영
 * @Date : 2018. 12. 11.
 * @Class 설명 : Soft Engineer Society 통합잡페어 에이전시 Rest 컨트롤러
 */

@Controller
public class SocietyFapAgencyRestController implements PathConstants{

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAgencyRestController.class);
	
	@Autowired
	private SocietyFapAgencyService sfaService;
	
	@Autowired
	private SocietyFapAdminCommonService sfacService;
	
	@Autowired
	private SocietyFapCompanyService sfcService;
	
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SocietyEduAdminService seaService;
	
	@Autowired
	private SocietyEduUserService seuService;
	
	private static final String INTERVIEW_LIMIT_TYPE_ALL = "C5402";
	
	/**
	 * @Method Name : agency_user_id_check
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 유저가 입력한 아이디
	 * @Return : 중복 체크 후 boolean
	 * @Method 설명 : 유저가 입력한 아이디를 중복체크 해주는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_USER_ID_CHECK, method = RequestMethod.POST)
	public boolean agency_user_id_check(String user_id){
		logger.info("아이디 중복 체크 컨트롤러 시작");
		String user_id_check = sfaService.user_id_check(user_id);
		// 중복된 아이디가 없는 경우
		if(user_id_check == null){
			return true;
		}
		
		logger.info("아이디 중복 체크 컨트롤러 종료");
		return false;
	}
	
	/**
	 * @Method Name : society_fap_agency_menu_check
	 * @Date : 2019. 2. 11.
	 * @User : 김홍일
	 * @Param : 유저 아이디
	 * @Return : 메뉴 체크
	 * @Method 설명 : 유저에게 보여 줄 메뉴를 확인 하는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_MENU_CHECK, method = RequestMethod.POST)
	public String society_fap_agency_menu_check(String user_id){
		logger.info("FAP 기업 메뉴 체크 컨트롤러 시작");
		
		if(user_id.equals("") || user_id == null){
			return "default";
		}
		SocietyFapCompanyUserConnect connect_info = sfaService.select_agen_user_connect(user_id);
		
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
	 * @Method Name : user_request_certification_code
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : 요청 결과 
	 * @Method 설명 : 인증번호를 발행하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_REQUEST_CERTIFICATION_CODE, method = RequestMethod.GET)
	public int user_request_certification_code(User user, HttpSession session) {
		logger.info("FAP 에이전시 유저 회원 가입 인증 번호 발행 컨트롤러 시작");
		int requested = sfaService.user_request_certification_code(user);
		
		if (requested == 0) {
			session.removeAttribute("user_id");
			session.setAttribute("user_id", user.getUser_id());
			System.out.println("유저 회원 ( "+session.getAttribute("user_id")+" ) 가입 인증 번호 발행 !");
		}
		
		logger.info("FAP 에이전시 유저 회원 가입 인증 번호 발행 컨트롤러 종료");
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
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_CHECK_CERTIFICATION_CODE, method = RequestMethod.GET)
	public boolean user_check_certification_code(CertificationCode code, HttpSession session) {
		logger.info("FAP 에이전시 유저 회원 가입 인증 번호 검사 컨트롤러 시작");
		String id = (String) session.getAttribute("user_id");
		code.setUser_id(id);
		boolean isRequested = sfaService.user_check_certification_code(code);
		// 인증 성공하면 세션에 확인 추가
		if (isRequested) {
			session.setAttribute("isCertificated", isRequested);
		}
		
		logger.info("FAP 에이전시 유저 회원 가입 인증 번호 검사 컨트롤러 종료");
		return isRequested;
	}
	
	/**
	 * @Method Name : company_user_connect_list
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : -
	 * @Return : 에이전시 - 유저 연결 객체, 기업 정보 객체
	 * @Method 설명 : 유저가 에이전시 연결을 요청하기 위해 필요한 리스트를 호출하는 함수
	 */
	/*@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_USER_CONNECT_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> agency_user_connect_list(Authentication auth){
		ArrayList<SocietyFapCompanyUser> comp_list;
		SocietyFapCompanyUserConnect comp_user_connect = sfcService.select_comp_user_connect((String)auth.getPrincipal());
		HashMap<String, Object> hashMap = new HashMap<>();
		if(comp_user_connect == null){
			comp_list = sfaService.select_agency_company();
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
	}*/
	
	/**
	 * @Method Name : company_user_check
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 유저 객체
	 * @Return : 확인 메시지
	 * @Method 설명 : 에이전시 - 기업을 직접 연결해주는 ajax함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_COMPANY_DIRECT_CONNECT, method = RequestMethod.POST)
	public String direct_connect(Authentication auth, User user){
		logger.info("FAP 에이전시 - 기업 직접 연결 AJAX 시작");
		String company_user_check = sfaService.direct_connect(auth, user);
		logger.info("FAP 에이전시 - 기업 직접 연결 AJAX 종료");
		return company_user_check;
	}
	
	/**
	 * @Method Name : connect_request
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 회사 아이디 배열
	 * @Return : -
	 * @Method 설명 : 에이전시 - 기업 연결을 요청하는 ajax함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_CONNECT_REQUEST, method = RequestMethod.POST)
	public void connect_request(Authentication auth, @RequestParam(defaultValue="") ArrayList<String> comp_list){
		logger.info("FAP 에이전시 - 기업 연결 요청 AJAX 시작");
		sfaService.connect_request(auth, comp_list);
		logger.info("FAP 에이전시 - 기업 연결 요청 AJAX 종료");
	}
	
	/**
	 * @Method Name : delete_connect_request
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : 에이전시 - 기업 연결 객체
	 * @Return : -
	 * @Method 설명 : 에이전시가 기업 연결을 위해 보낸 요청을 삭제하는 ajax함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_DELETE_CONNECT_REQUEST, method = RequestMethod.POST)
	public void delete_connect_request(Authentication auth, String fap_comp_id, String request_ck){
		logger.info("FAP 에이전시 - 기업 연결 요청 삭제 AJAX 시작");
		sfaService.delete_connect_request(auth, fap_comp_id, request_ck);
		logger.info("FAP 에이전시 - 기업 연결 요청 삭제 AJAX 종료");
	}
	
	/**
	 * @Method Name : jobfair_search_list
	 * @Date : 2019. 1. 21.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 통합잡페어 정보 리스트
	 * @Method 설명 : 통합잡페어 정보 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOBFAIR_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> jobfair_search_list(Model model){
		logger.info("잡페어 리스트 검색 시작");
		
		ArrayList<HashMap<String, Object>> jobfairList = sfaService.jobfair_search_list();
		
		logger.info("잡페어 리스트 검색 종료");
		
		return jobfairList;
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
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_TERMS_UPDATE, method = RequestMethod.POST)
	public int terms_update(User user){
		logger.info("FAP 회원 약관 동의 변경 컨트롤러 시작");
		user.setUser_terms_ck("A1301");
		int check = sfcService.terms_update(user);
		logger.info("FAP 회원 약관 동의 변경 컨트롤러 종료");
		return check;
	}
	
	/**
	 * @Method Name : job_pcs_editable_check
	 * @Date : 2019. 1. 24.
	 * @User : 김준영
	 * @Param : 
	 * @Return :
	 * @Method 설명 : 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOB_PCS_EDITABLE_CHECK, method = RequestMethod.POST)
	public String job_pcs_editable_check(long fap_job_recruit_pcs_seq){
		
		int check = sfaService.editable_check(fap_job_recruit_pcs_seq);
		
		if(check != 0){
			return "impossible";
		}
		
		return "possible";
	}
	
	
	/**
	 * @Method Name : delete_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 에이전시 - 유저 연결 시퀀스
	 * @Return : 실행 결과
	 * @Method 설명 : 에이전시 - 유저 연결을 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_DELETE_COMPANY_USER_CONNECT, method = RequestMethod.POST)
	public int delete_request_ag_user_connect(int fap_comp_user_connect_seq){
		logger.info("FAP 에이전시 - 유저 연결 요청 삭제 컨트롤러 시작");
		int result = sfcService.delete_comp_user_connect(fap_comp_user_connect_seq);
		logger.info("FAP 에이전시 - 유저 연결 요청 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : request_comp_user_connect
	 * @Date : 2018. 12. 27.
	 * @User : 김준영
	 * @Param : 에이전시 아이디
	 * @Return : 실행 결과
	 * @Method 설명 : 유저의 기업 연결을 요청 한 후 메인페이지로 리턴하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_REQUEST_COMPANY_USER_CONNECT, method = RequestMethod.POST)
	public int request_ag_user_connect(Authentication auth, String fap_comp_id){
		logger.info("FAP 에이전시 - 유저 연결 요청 컨트롤러 시작");
		
		SocietyFapCompanyUserConnect comp_user_connect = new SocietyFapCompanyUserConnect();
		comp_user_connect.setFap_comp_id(fap_comp_id);
		comp_user_connect.setFap_comp_user_connect_ck("B3801");
		comp_user_connect.setUser_id((String)auth.getPrincipal());
		int result = sfcService.comp_user_connect(comp_user_connect);
		logger.info("FAP 에이전시 - 유저 연결 요청 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : agency_board_contents_search
	 * @Date : 2019. 1. 28.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 에이전시 메인 공지사항 정보
	 * @Method 설명 : 잡페어 에이전시 메인 공지사항 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_BOARD_CONTENTS_SEARCH, method = RequestMethod.POST)
	public ArrayList<BoardContent> agency_board_contents_search(Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type,
			@RequestParam(defaultValue="21") int board_seq,
			@RequestParam(defaultValue="") String borad_nm,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="10") int pageCount
			){
		logger.info("잡페어 에이전시 메인 공지사항 검색 컨트롤러 시작");

		int curPage = page;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		//map.put("board_detail_gb","A1413");
		int count = sfcService.board_contents_count(map);
		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<BoardContent> resultList = sfcService.company_board_contents_search(map);
		
		logger.info("잡페어 에이전시 메인 공지사항 검색 컨트롤러 종료");
		return resultList;
	}
	
	/**
	 * @Method Name : agency_board_contents_list_search
	 * @Date : 2019. 1. 28.
	 * @User : 신동철
	 * @Param : 게시판 시퀀스
	 * @Return : 잡페어 에이전시 공지사항 리스트
	 * @Method 설명 : 잡페어 에이전시 공지사항 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_BOARD_CONTENT_LIST_SEARCH, method = RequestMethod.POST)
	public HashMap<String, Object> agency_board_contents_list_search(Model model, BoardGroup boardGroup 	    
			,@RequestParam(defaultValue="10") int pageCount
			,@RequestParam(defaultValue="1") int curPage
			,@RequestParam(defaultValue="1") int pageBegin
			,@RequestParam(defaultValue="") String searchKey
			,@RequestParam(defaultValue="") String searchValue
			){
		logger.info("잡페어 에이전시 공지사항 리스트 검색 컨트롤러 시작");		 
	 		
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
		
		map.put("count:", count); 
		map.put("adminPager", adminPager);
		 
		//글 리스트
		ArrayList<BoardContent> resultList = sfcService.company_board_contents_list_search(map);

		//제목 
		String board_nm = sfcService.select_comp_name(boardGroup.getBoard_detail_gb());
		map.put("board_nm",board_nm);
		 
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("map", map);
		resultMap.put("resultList", resultList);
		
		logger.info("잡페어 에이전시 공지사항 리스트 검색 컨트롤러 종료");
		return resultMap;
	}
	
	/**
	 * @Method Name : select_agency_recruit_pcs_sch
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시 전형일정 스케줄 검색 정보
	 * @Return : 에이전시 전형일정 스케줄
	 * @Method 설명 : 에이전시 전형일정 스케줄 검색
	 */
	
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_RECRUIT_PROCESS_SCHEDULE_SELECT, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_agency_recruit_pcs_sch(SocietyFapJobRecruitPcsSch recruit_pcs_sch, HttpSession session){
		logger.info("에이전시 전형일정 스케줄 검색 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> schedule_list = sfcService.select_company_recruit_pcs_sch(recruit_pcs_sch, session);
		
		logger.info("에이전시 전형일정 스케줄 검색 컨트롤러 종료");
		return schedule_list;
	}
	
	/**
	 * @Method Name : search_agency_jobfair_divide_list
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 잡페어시퀀스, 회사아이디
	 * @Return : 에이전시 기업이 참가한 세부잡페어 정보 리스트
	 * @Method 설명 : 에이전시 기업이 참가한 세부잡페어 정보 검색
	 */
	
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOBFAIR_DIVIDE_LIST_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> search_agency_jobfair_divide_list(String fap_comp_id, @RequestParam(defaultValue = "0") long fap_jobfair_seq){
		logger.info("에이전시 기업이 참가한 세부잡페어 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("fap_comp_id", fap_comp_id);
		params.put("fap_jobfair_seq", fap_jobfair_seq);
		ArrayList<HashMap<String, Object>> jobfair_divide_list = sfaService.select_company_jobfair_divide_list(params);
		
		logger.info("에이전시 기업이 참가한 세부잡페어 정보 검색 컨트롤러 종료");
		return jobfair_divide_list;
	}
	
	/**
	 * @Method Name : select_agency_review_pcs
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시 서류전형 시퀀스
	 * @Return : 에이전시 서류전형 정보
	 * @Method 설명 : 에이전시 서류전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_REVIEW_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_agency_review_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("에이전시 서류전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_review_pcs_info= sfcService.select_company_review_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("에이전시 서류전형 정보 검색 컨트롤러 종료");
		return company_review_pcs_info;
	}
	
	/**
	 * @Method Name : select_agency_exam_pcs
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시 시험전형 시퀀스
	 * @Return : 에이전시 시험전형 정보
	 * @Method 설명 : 에이전시 시험전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_EXAM_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_agency_exam_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("에이전시 시험전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_exam_pcs_info = sfcService.select_company_exam_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("에이전시 시험전형 정보 검색 컨트롤러 종료");
		return company_exam_pcs_info;
	}
	
	/**
	 * @Method Name : select_agency_itv_pcs
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시 면접전형 시퀀스
	 * @Return : 에이전시 면접전형 정보
	 * @Method 설명 : 에이전시 면접전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_ITV_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_agency_itv_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("에이전시 면접전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_itv_pcs_info = sfcService.select_company_itv_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("에이전시 면접전형 정보 검색 컨트롤러 종료");
		return company_itv_pcs_info;
	}
	
	/**
	 * @Method Name : select_agency_test_etc_pcs
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시 기타전형 시퀀스
	 * @Return : 에이전시 기타전형 정보
	 * @Method 설명 : 에이전시 기타전형 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_TEST_ETC_PROCESS_SELECT, method = RequestMethod.POST)
	public HashMap<String, Object> select_agency_test_etc_pcs(Model model, long fap_job_recruit_pcs_seq){
		logger.info("에이전시 기타전형 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> company_test_etc_pcs_info = sfcService.select_company_test_etc_pcs(fap_job_recruit_pcs_seq);
		
		logger.info("에이전시 기타전형 정보 검색 컨트롤러 종료");
		return company_test_etc_pcs_info;
	}
	
	/**
	 * @Method Name : search_agency_company_jobfair_list
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 에이전시 회사 아이디
	 * @Return : 에이전시 회사 잡페어 정보 리스트
	 * @Method 설명 : 에이전시 회사 잡페어 정보 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_COMPANY_JOBFAIR_LIST_SEARCH, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>>search_agency_company_jobfair_list(HttpSession session, String fap_comp_id){
		logger.info("FAP 에이전시 회사 잡페어 정보 리스트 검색 컨트롤러 시작");
		
		//선택한 클라이언트 회사 정보 세션에 저장
		
		String chosen_fap_comp_ja_nm = sfaService.select_company_name(fap_comp_id);
		session.removeAttribute("chosen_fap_comp_id");
		session.removeAttribute("chosen_fap_comp_ja_nm");
		session.setAttribute("chosen_fap_comp_id", fap_comp_id);
		session.setAttribute("chosen_fap_comp_ja_nm", chosen_fap_comp_ja_nm);
		
		
		ArrayList<HashMap<String, Object>>agency_company_jobfair_list = sfaService.select_agency_jobfair_list(fap_comp_id);
		logger.info("!!!!!!!!!!!!!! {}", fap_comp_id);
		
		logger.info("FAP 에이전시 회사 잡페어 정보 리스트 검색 컨트롤러 종료");
		return agency_company_jobfair_list;
	}
	
	/**
	 * @Method Name : search_agency_job_ad_list
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : 에이전시 회사가 참가하여 승인받은 채용공고 리스트
	 * @Method 설명 : 에이전시 회사가 참가하여 승인받은 채용공고 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_LIST_SEARCH, method = RequestMethod.POST)
	public ArrayList<SocietyFapJobAd> search_agency_job_ad_list(SocietyFapJobAd jobAd){
		logger.info("에이전시 기업 채용공고 리스트 검색 컨트롤러 시작");
		
		ArrayList<SocietyFapJobAd> job_ad_list = sfcService.search_company_job_ad_list(jobAd);
		
		logger.info("에이전시 기업 채용공고 리스트 검색 컨트롤러 종료");
		return job_ad_list;
	}
	
	/**
	 * @Method Name : agency_common_required_doc_search_list
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 에이전시 회사아이디
	 * @Return : 공통 내정서류 리스트
	 * @Method 설명 : 공통 내정서류 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<SocietyFapCommonRequiredDoc> agency_company_required_doc_search_list(@RequestParam(defaultValue = "0") int fap_job_ad_seq, @RequestParam(defaultValue = "") String fap_comp_id){
		logger.info("에이전시 공통 내정서류 검색 컨트롤러 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashmap.put("fap_comp_id", fap_comp_id);
		ArrayList<SocietyFapCommonRequiredDoc> common_required_doc_list = sfcService.search_common_required_doc_list(hashmap);
		
		logger.info("에이전시 공통 내정서류 검색 컨트롤러 종료");		
		return common_required_doc_list;
	}
	
	/**
	 * @Method Name : nominee_info_list_search
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 에이전시 회사아이디
	 * @Return : 내정자 정보 리스트
	 * @Method 설명 : 내정자 정보 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_NOMINEE_INFO_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> nominee_info_list_search(@RequestParam(defaultValue = "0") int fap_job_ad_seq, @RequestParam(defaultValue = "") String fap_comp_id){
		logger.info("에이전시 회사 내정자 정보 리스트 검색 컨트롤러 시작");
		
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", fap_job_ad_seq);
		hashmap.put("fap_comp_id", fap_comp_id);
		ArrayList<HashMap<String, Object>> nominee_info_list = sfcService.search_nominee_info_list(hashmap);
		
		logger.info("에이전시 회사 내정자 정보 리스트 검색 컨트롤러 종료");		
		return nominee_info_list;
	}
	
	/**
	 * @Method Name : select_agency_common_required_doc
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 공통 내정서류 시퀀스
	 * @Return : 공통 내정서류
	 * @Method 설명 : 공통 내정서류 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_SEARCH, method = RequestMethod.POST)
	public SocietyFapCommonRequiredDoc select_agency_company_required_doc(int fap_common_required_doc_seq){
		logger.info("특정 공통 내정서류 검색 컨트롤러 시작");
		
		SocietyFapCommonRequiredDoc common_required_doc = sfcService.select_common_required_doc(fap_common_required_doc_seq);
		
		logger.info("특정 공통 내정서류 검색 컨트롤러 종료");	
		return common_required_doc;
	}
	
	/**
	 * @Method Name : personal_required_doc_search_list
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : 에이전시 회사 개인 내정서류 리스트
	 * @Method 설명 : 에이전시 회사 개인 내정서류 리스트 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_SEARCH_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> personal_required_doc_search_list(@RequestParam(defaultValue = "0") int fap_nominee_seq){
		logger.info("에이전시 회사 개인 내정서류 검색 컨트롤러 시작");
				
		ArrayList<HashMap<String, Object>> personal_required_doc_list = sfcService.search_personal_required_doc_list(fap_nominee_seq);
		
		logger.info("개인 내정서류 검색 컨트롤러 종료");		
		return personal_required_doc_list;
	}
	
	/**
	 * @Method Name : nominee_info_search
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 에이전시 회사 내정자 시퀀스
	 * @Return : 에이전시 회사 내정자 정보
	 * @Method 설명 : 에이전시 회사 내정자 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_NOMINEE_INFO_SEARCH, method = RequestMethod.POST)
	public HashMap<String, Object> nominee_info_search(SocietyFapNominee nominee){
		logger.info("에이전시 회사 내정자 정보 검색 컨트롤러 시작");
		
		HashMap<String, Object> nominee_info = sfcService.search_nominee_info(nominee);
		
		logger.info("에이전시 회사 내정자 정보 검색 컨트롤러 종료");		
		return nominee_info;
	}
	
	/**
	 * @Method Name : select_agency_personal_required_doc
	 * @Date : 2019. 1. 30.
	 * @User : 신동철
	 * @Param : 에이전시 회사 개인 내정서류 시퀀스
	 * @Return : 에이전시 회사 개인 내정서류
	 * @Method 설명 : 에이전시 회사 개인 내정서류 정보 검색
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_SEARCH, method = RequestMethod.POST)
	public SocietyFapPersonalRequiredDoc select_agency_personal_required_doc(int fap_personal_required_doc_seq){
		logger.info("에이전시 회사 특정 개인 내정서류 검색 컨트롤러 시작");
		
		SocietyFapPersonalRequiredDoc personal_required_doc = sfcService.select_personal_required_doc(fap_personal_required_doc_seq);
		
		logger.info("에이전시 회사 특정 개인 내정서류 검색 컨트롤러 종료");	
		return personal_required_doc;
	}
	
	/**
	 * @Method Name : agency_select_per_state_job_ad_list
	 * @Date : 2019. 2. 1.
	 * @User : 정대영
	 * @Param : 잡페어 시퀀스, 잡페어세부 시퀀스, 회사 아이디
	 * @Return : HashMapList(회사별 진행중인 잡페어 리스트)
	 * @Method 설명 : FAP 에이전시 진행중인 채용공고 목록 리스트 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_SELECT_PER_STATE_JOB_AD_LIST, method = RequestMethod.POST)
	public HashMap<String, Object> agency_select_per_state_job_ad_list(@RequestBody HashMap<String, Object> params, HttpSession session){
		logger.debug("FAP 에이전시 기업 별 상태 별 채용공고 리스트 검색 컨트롤러 시작");
		String chosen_fap_comp_id = (String) params.get("chosen_fap_comp_id");
		String chosen_fap_comp_ja_nm = sfaService.select_company_name(chosen_fap_comp_id);
		session.removeAttribute("chosen_fap_comp_id");
		session.removeAttribute("chosen_fap_comp_ja_nm");
		session.setAttribute("chosen_fap_comp_id", chosen_fap_comp_id);
		session.setAttribute("chosen_fap_comp_ja_nm", chosen_fap_comp_ja_nm);
		ArrayList<HashMap<String, Object>> perStateJobAdList = sfaService.select_job_ad_by_state(params);
		HashMap<String, Object> perStateJobAdListMap = new HashMap<>();
		perStateJobAdListMap.put("perStateJobAdList", perStateJobAdList);
		perStateJobAdListMap.put("chosen_fap_comp_ja_nm", chosen_fap_comp_ja_nm);
		logger.debug("FAP 에이전시 기업 별 상태 별 채용공고 리스트 검색 컨트롤러 종료");
		return perStateJobAdListMap;
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
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_UPDATE_JOB_AD_STATE, method = RequestMethod.POST)
	public void update_job_ad_state(@RequestBody SocietyFapJobAd jobAd, Authentication auth, Model model){
		logger.debug("FAP 담당자 - 채용공고 상태 수정 시작");
		int result = sfaService.update_job_ad_state(jobAd);
		System.out.println("Agency-job_ad_state:"+result);
		
		//알림게시판에 관련정보 추가 
				if(result>0){			
						String fap_agency_id = (String)auth.getPrincipal();
						String fap_job_ad_state = jobAd.getFap_job_ad_state();	 		 
						if(fap_job_ad_state.equals("C2104")){		 
								String fap_admin_notice_ct = "에이전시 \'"+fap_agency_id+"\'가  채용공고의  승인을 요청했습니다."; 				
								HashMap<String, Object> paramMap = new HashMap<>();
								paramMap.put("fap_admin_notice_ins_id", fap_agency_id);
								paramMap.put("fap_admin_notice_ct",fap_admin_notice_ct);
								 paramMap.put("fap_admin_notice_handle_need_gb", "D2101");
								paramMap.put("fap_admin_notice_handle_gb","D2302");
								int adminInfo = sfacService.insert_admin_notice_info(paramMap);						 	
						}		
				}
		logger.debug("FAP 담당자 - 채용공고 상태 수정 끝");
	}
	
	/**
	 * @Method Name : insert_company_jobfair_join_table
	 * @Date : 2019. 2. 7.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : String
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_INSERT_COMPANY_JOBFAIR_JOIN_TABLE, method = RequestMethod.POST)
	public String insert_company_jobfair_join_table(@RequestBody HashMap<String, Object> insertCompanyInfo){
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청 시작");
		String message = sfaService.insert_company_jobfair_join_table(insertCompanyInfo);
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청 끝");
		return message;
	}
	
	/**
	 * @Method Name : chosen_company_id_save_session
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : String, Session
	 * @Return : String
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_CHOSEN_COMPANY_ID_SAVE_SESSION, method = RequestMethod.POST)
	public String chosen_company_id_save_session(String chosen_fap_comp_id, HttpSession session){
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청 시작");
		String chosen_fap_comp_ja_nm = sfaService.select_company_name(chosen_fap_comp_id);
		session.removeAttribute("chosen_fap_comp_id");
		session.removeAttribute("chosen_fap_comp_ja_nm");
		session.setAttribute("chosen_fap_comp_id", chosen_fap_comp_id);
		session.setAttribute("chosen_fap_comp_ja_nm", chosen_fap_comp_ja_nm);
		logger.debug("FAP 에이전시 에이전시 관리 회사 잡페어 참가 요청 끝");
		return "insertSessionSuccess";
	}
	
	/**
	 * @Method Name : insert_connect_request
	 * @Date : 2019. 2. 7.
	 * @User : 김준영
	 * @Param : 기업 - 담당자 연결 요청 객체
	 * @Return : 요청 등록 성공 여부
	 * @Method 설명 : 에이전시 - 담당자 연결을 요청하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_CONNECT_REQUEST, method = RequestMethod.POST)
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
	 * @Method 설명 : 에이전시 - 담당자 연결 요청을 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_CONNECT_REQUEST_DELETE, method = RequestMethod.POST)
	public int delete_connect_request(int fap_comp_user_request_seq){
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 컨트롤러 시작");
		int result = sfcService.delete_connect_request(fap_comp_user_request_seq);
		logger.info("FAP 기업 - 담당자 연결 요청 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_in_job_management_company_list
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMapList(에이전시가 관리하는 회사 목록(잡페어에 참가한))
	 * @Method 설명 : FAP 에이전시 채용공고 관리화면에서 관리회사 목록 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_SELECT_IN_JOB_MANAGEMENT_COMPANY_LIST, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_in_job_management_company_list(@RequestBody HashMap<String, Object> params, Authentication auth){
		logger.debug("FAP 에이전시 채용공고 관리화면에서 관리회사 목록 요청 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		String fap_ag_id = sfcService.select_fap_comp_id(user_id);
		params.put("fap_ag_id", fap_ag_id);
		ArrayList<HashMap<String, Object>> attendCompanyInfoList = sfaService.select_jobfair_attended_company_list(params);
		logger.debug("FAP 에이전시 채용공고 관리화면에서 관리회사 목록 요청 컨트롤러 종료");
		return attendCompanyInfoList;
	}
	
	
	/**
	 * @Method Name : agency_select_allowable_company_list_form
	 * @Date : 2019. 2. 7.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : JSP 자식창 리턴페이지(에이전시 관리 회사들 목록 출력 폼)
	 * @Method 설명 : FAP 에이전시 에이전시 관리 회사들 목록 출력 폼 요청
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_SELECT_ALLOWABLE_COMPANY_LIST_FORM, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> select_agency_allowable_company_list_form(int fap_jobfair_seq, int fap_jobfair_divide_seq, Model model, Authentication auth){
		logger.debug("FAP 에이전시 에이전시 관리 회사들 목록 출력 폼 요청 시작");
		String user_id = (String)auth.getPrincipal();
		String fap_ag_id = sfaService.select_fap_comp_id(user_id);
		HashMap<String, Object> param = new HashMap<>();
		param.put("fap_jobfair_seq", fap_jobfair_seq);
		param.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		param.put("fap_ag_id", fap_ag_id);
		ArrayList<HashMap<String, Object>> agencyCompanyInfoList = sfaService.select_participate_possible_company_list(param);
		logger.debug("FAP 에이전시 에이전시 관리 회사들 목록 출력 폼 요청 종료");
		return agencyCompanyInfoList;
	}
	
	/**
	 * @Method Name : agency_select_attend_company_list_form
	 * @Date : 2019. 2. 8.
	 * @User : 정대영
	 * @Param : -
	 * @Return : JSP 자식창 리턴페이지(에이전시 참가 할 회사 목록 폼)
	 * @Method 설명 : FAP 에이전시 참가 할 회사 목록 폼 요청
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_SELECT_ATTEND_COMPANY_LIST_FORM, method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> agency_select_attend_company_list_form(int fap_jobfair_seq, int fap_jobfair_divide_seq, Model model, Authentication auth){
		logger.debug("FAP 에이전시 참가 할 회사 목록 폼 요청 시작");
		String user_id = (String)auth.getPrincipal();
		String fap_ag_id = sfaService.select_fap_comp_id(user_id);
		HashMap<String, Object> param = new HashMap<>();
		param.put("fap_jobfair_seq", fap_jobfair_seq);
		param.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		param.put("fap_ag_id", fap_ag_id);
		ArrayList<HashMap<String, Object>> attendCompanyInfoList = sfaService.select_jobfair_attended_company_list(param);
		logger.debug("FAP 에이전시 참가 할 회사 목록 폼 요청 종료");
		return attendCompanyInfoList;
	}
	
	/**
	 * @Method Name : select_job_ad_load_list_paging
	 * @Date : 2019. 2. 12.
	 * @User : 김준영
	 * @Param : -
	 * @Return : HashMap(이전에 등록한 채용공고 정보, 페이징 정보)
	 * @Method 설명 : FAP 기업 채용공고 등록화면에서 이전 채용공고 불러오기 페이징 된 정보 요청
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_SELECT_SELECT_JOB_AD_LOAD_LIST_PAGING, method = RequestMethod.POST)
	public HashMap<String, Object> select_job_ad_load_list_paging(Authentication auth, int clickedPage, int fap_jobfair_seq, HttpSession session){
		logger.debug("FAP 기업 채용공고 등록화면에서 이전 채용공고 불러오기 페이징 된 정보 요청 컨트롤러 시작");
		String chosen_fap_comp_id = (String) session.getAttribute("chosen_fap_comp_id");
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("chosen_fap_comp_id", chosen_fap_comp_id);
		paramMap.put("fap_jobfair_seq",fap_jobfair_seq);
		
		int adTotalCount = sfaService.select_job_ad_load_list_count(paramMap);
		if(adTotalCount == 0){adTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(5, 5, clickedPage, adTotalCount);
		// 해당 기업이 작성한 채용공고 리스트 가져오기
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfaService.select_job_ad_load_list_paging(paramMap, repNavi.getStartRecord(), repNavi.getCountPerPage());
		HashMap<String, Object> jobAdLoadListInfo = new HashMap<>();
		jobAdLoadListInfo.put("select_job_ad_load_list", select_job_ad_load_list);
		jobAdLoadListInfo.put("repNavi", repNavi);
		jobAdLoadListInfo.put("adTotalCount", adTotalCount);
		logger.debug("FAP 기업 채용공고 등록화면에서 이전 채용공고 불러오기 페이징 된 정보 요청 컨트롤러 종료");
		return jobAdLoadListInfo;
	}
	
	/**
	 * @Method Name : delete_job_ad_box
	 * @Date : 2019. 2. 14.
	 * @User : 김준영
	 * @Param : 채용공고 seq
	 * @Return : 삭제 여부
	 * @Method 설명 : 채용공고를 삭제하는 함수
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_DELETE, method=RequestMethod.POST)
	public int delete_job_ad_box(long fap_job_ad_seq){
		logger.info("FAP 채용공고 삭제 컨트롤러 시작");
		int result = sfaService.delete_job_ad_box(fap_job_ad_seq);
		logger.info("FAP 채용공고 삭제 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : select_my_applied_resume
	 * @Date : 2019. 03. 13.
	 * @User : 신동철
	 * @Param : 이력서 시퀀스, 지원자 아이디
	 * @Return : 해당 지원자 이력서 정보
	 * @Method 설명 : 채용공고별 지원자 이력서 가져오기
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_APPLIED_RESUME_LIST, method = RequestMethod.POST, produces = "application/text; charset=utf8")
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
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_ID_DUPLICATED, method = RequestMethod.GET)
	public boolean user_duplicated(User user) {
		logger.debug("유저 회원 가입 아이디 중복 검사 컨트롤러 시작");
		boolean isDuplicated = seuService.user_duplicated(user);
		logger.debug("유저 회원 가입 아이디 중복 검사 컨트롤러 종료");
		return isDuplicated;
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
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_USER_INFO_DELETE, method = RequestMethod.POST)
	public int delete_user_info(@RequestBody User user, HttpSession session){
		logger.info("FAP 에이전시 기업 담당자 탈퇴 컨트롤러 시작");
		int result = sfcService.delete_company_user_info(user);
		if(result > 0){
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
		}
		logger.info("FAP 에이전시 기업 담당자 탈퇴 컨트롤러 종료");
		return result;
	}
	
	/**
	 * @Method Name : interview_limit_check
	 * @Date : 2019. 8. 1.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스 , 현지면접 합격자 수
	 * @Return : 인원제한 가능 여부
	 * @Method 설명 : FAP 에이전시 전형 합/불 시 현지면접 합격자 수 인원제한 체크
	 */
	@ResponseBody
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_INTERVIEW_LIMIT_CHECK, method = RequestMethod.POST)
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
		
		logger.info("FAP 채용공고별 현지면접 대상자 인원제한 체크용 검색 컨트롤러 종료");
		
		return ck_flag;
	}
}
