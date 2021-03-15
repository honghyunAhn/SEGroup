/**
 * 
 */
package global.segroup.society.fap.agency.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import global.segroup.domain.AdminPager;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.User;
import global.segroup.exception.DisagreeException;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.admincompany.service.SocietyFapAdminCompanyService;
import global.segroup.society.fap.agency.service.SocietyFapAgencyService;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapCompUserConnectRequest;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUserConnect;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobApplyFinalResult;
import global.segroup.society.fap.company.domain.SocietyFapJobApplyResult;
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
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapQnaAnswer;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.companyroadmap.service.SocietyFapCompanyRoadmapService;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.LocaleUtil;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * @Author : 김준영
 * @Date : 2018. 12. 11.
 * @Class 설명 : Soft Engineer Society 통합잡페어 에이전시 View 컨트롤러
 */

@Controller
public class SocietyFapAgencyViewController implements PathConstants{

	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAgencyViewController.class);
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private SocietyFapAgencyService sfaService;
	
	@Autowired
	private SocietyFapAdminCommonService sfacService;
	
	@Autowired
	private SocietyFapAdminCompanyService sfaccService;
	
	@Autowired
	private SocietyFapCompanyService sfcService;
	
	@Autowired
	private SocietyEduAdminService seaService;
	
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SocietyFapCompanyRoadmapService sfcrService;

	
	//공지사항 게시판 코드
	private static final String BOARD_NOTICE_CODE = "A1700";
		
	//취업정보&전략 게시판 코드
	private static final String BOARD_JOBINFO_CODE = "A1701";
	
	/**
	 * file.propertices 의 잡페어 로고 파일 경로
	 */
	@Value("#{props['fap.admin.jobfair_logo_image']}")
	private String fapAdminJobfairLogoImage;
	
	/**
	 * file.propertices 의 시험전형 파일 경로
	 */
	@Value("#{props['fap.company.job_recruit_exam_file']}")
	private String fapJobRecruitExamFile;
	
	/**
	 * @Method Name : agency_insert_form
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 회원가입 폼)
	 * @Method 설명 : 에이전시 회원가입으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_INSERT_FORM, method = RequestMethod.GET)
	public String agency_insert_form(){
		logger.info("FAP 에이전시 회원가입 이동 시작");		
		logger.info("FAP 에이전시 회원가입 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_INSERT_FORM;
	}
	
	/**
	 * @Method Name : agency_insert_form
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 공통 회원, 에이전시 회원
	 * @Return : 회원가입 후 기업 로그인 페이지로 이동 
	 * @Method 설명 : FAP 에이전시 회원가입 후 로그인 페이지로 이동하는 컨트롤러 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_INSERT_FORM, method = RequestMethod.POST)
	public String agency_insert_form(Model model, String company_ck, User user, 
			SocietyFapCompanyUser societyFapCompanyUser, 
			SocietyFapCompanyUserConnect societyFapCompanyUserConnect){
		logger.info("FAP 에이전시 회원 등록 컨트롤러 시작");
		// 비밀번호 암호화
		String encodedPw = passwordEncoder.encode(user.getUser_pw());
		user.setUser_pw(encodedPw);
		sfaService.insert_agency(company_ck, user, societyFapCompanyUser, societyFapCompanyUserConnect);
		logger.info("FAP 에이전시 회원 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : agency_security_invalidate
	 * @Date : 2018. 12. 14
	 * @User : 이종호
	 * @Param : 세션정보
	 * @Return : 에이전시 로그인 페이지
	 * @Method 설명 : 현재 세션정보를 초기화 하고 에이전시 로그인 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_SECURITY_INVALIDATE , method = RequestMethod.GET)
	public String agency_security_invalidate(HttpSession session) {
		logger.debug("FAP 에이전시 시큐리티 초기화 컨트롤러 시작");
		
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		
		logger.debug("FAP 에이전시 시큐리티 초기화 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : agency_login_success
	 * @Date : 2018. 12. 14
	 * @User : 이종호
	 * @Param : 인증 정보 객체
	 * @Return : JSP 리턴페이지(FAP 에이전시 로그인 성공)
	 * @Method 설명 : FAP 에이전시 로그인 성공시 권한별 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_LOGIN_SUCCESS, method = RequestMethod.GET)
	public String agency_login_success(Model model, Authentication auth){
		logger.debug("FAP 에이전시 로그인 성공 컨트롤러 시작");		
		
		logger.debug("FAP 에이전시 로그인 성공 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_MAIN;
	}
	
	/**
	 * @Method Name : agency_login_form
	 * @Date : 2018. 12. 14
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 에이전시 로그인 폼 페이지)
	 * @Method 설명 : FAP 에이전시 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM , method = RequestMethod.GET)
	public String agency_login_form(HttpSession session, Model model,Authentication auth){
		logger.debug("FAP 에이전시 로그인 폼 이동 컨트롤러 시작");
		
		Exception exception = (Exception)session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		
		if(auth != null) {
			//세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
		}
		
		if((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException || exception.getCause() instanceof BadCredentialsException) ){
			//휴면 계정 처리
			if(exception.getCause() instanceof DisabledException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_DORMANCY_FORM;
			}
			//탈퇴 계정 처리
			else if(exception.getCause() instanceof AccountExpiredException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_EXPIRED_FORM;
			}
			//정지 계정 처리
			else if(exception.getCause() instanceof LockedException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_LOCKED_FORM;
			}
			// 약관 미동의
			else if(exception.getCause() instanceof DisagreeException){
				model.addAttribute("user_id", ((DisagreeException)exception.getCause()).getId());
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_TERMS_AND_CONDITION;
			}
		}
		
		logger.debug("FAP 에이전시 로그인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM;
	}

	/**
	 * @Method Name : agency_access_denied
	 * @Date : 2018. 12. 14
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 에이전시 접근 제한 페이지)
	 * @Method 설명 : FAP 에이전시 접근 제한 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_ACCESS_DENIED , method = RequestMethod.GET)
	public String agency_access_denied() {
		logger.debug("FAP 에이전시 접근권한 제한 컨트롤러 시작");
		
		logger.debug("FAP 에이전시 접근권한 제한 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_ACCESS_DENIED;
	}
	
	/**
	 * @Method Name : agency_update_form
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 정보 수정 페이지)
	 * @Method 설명 : 에이전시 정보 수정 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_UPDATE_FORM , method = RequestMethod.GET)
	public String agency_update_form(Model model, Authentication auth){
		logger.info("FAP 에이전시 정보 수정 이동 컨트롤러 시작");
		SocietyFapCompanyUser company_info = sfaService.select_company((String)auth.getPrincipal());
		Gson gson = new Gson();
		model.addAttribute("company_info", gson.toJson(company_info));
		logger.info("FAP 에이전시 정보 수정 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : agency_update_form
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : 에이전시 정보 객체
	 * @Return : JSP 리턴페이지(에이전시 메인 페이지)
	 * @Method 설명 : 에이전시 정보를 업데이트 한 후 메인 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_UPDATE_FORM , method = RequestMethod.POST)
	public String agency_update_form(Model model, Authentication auth, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 에이전시 정보 수정 컨트롤러 시작");
		societyFapCompanyUser.setFap_comp_udt_id((String)auth.getPrincipal());
		sfaService.update_company(societyFapCompanyUser);
		logger.info("FAP 에이전시 정보 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_MAIN;
	}
	
	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회사 담당자 정보 수정 페이지)
	 * @Method 설명 : 에이전시 담당자 정보 수정 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_AGENCY_USER_UPDATE_FORM, method = RequestMethod.GET)
	public String user_update_form(Model model, Authentication auth){
		logger.info("FAP 에이전시 담당자 수정폼 이동 컨트롤러 시작");
		User user = sfaService.select_user((String)auth.getPrincipal());
		model.addAttribute("agency_user", user);
		logger.info("FAP 에이전시 담당자 수정폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_AGENCY_USER_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : JSP 리턴페이지(FAP 회사 담당자 정보 수정 페이지)
	 * @Method 설명 : 에이전시 담당자 정보를 수정한 후 메인 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_AGENCY_USER_UPDATE_FORM, method = RequestMethod.POST)
	public String user_update_form(User user, Authentication auth){
		logger.info("FAP 에이전시 담당자 수정 시작");
		
		// 비밀번호 변경시 암호화; 입력 하지 않을 경우는 변경 되지 않음
		if(!user.getUser_pw().equals("")){
			String encodedPw = passwordEncoder.encode(user.getUser_pw());
			user.setUser_pw(encodedPw);
		}
		user.setUser_udt_id((String)auth.getPrincipal());
		sfaService.update_user(user);
		logger.info("FAP 에이전시 담당자 수정 종료");
		
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_MAIN;
	}
	
	/**
	 * @Method Name : agency_company_insert
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 기업 회원가입)
	 * @Method 설명 : 에이전시가 기업 회원 가입을 대신 해주는 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_INSERT, method = RequestMethod.GET)
	public String agency_company_insert(){
		logger.info("FAP 에이전시 기업 회원 가입 이동 컨트톨러 시작");
		logger.info("FAP 에이전시 기업 회원 가입 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_COMPANY_INSERT;
	}
	
	/**
	 * @Method Name : agency_company_insert
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : JSP 리턴페이지(에이전시 기업 회원가입)
	 * @Method 설명 : 에이전시가 기업 회원 가입을 대신 해주는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_INSERT, method = RequestMethod.POST)
	public String agency_company_insert(Authentication auth, User user, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 에이전시 기업 회원 가입 컨트롤러 시작");
		sfaService.insert_company(auth, user, societyFapCompanyUser);
		logger.info("FAP 에이전시 기업 회원 가입 컨트톨러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_MAIN;
	}
	
	/**
	 * @Method Name : agency_company_registration
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 기업 등록)
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_REGISTRATION, method = RequestMethod.GET)
	public String agency_company_registration(Model model, Authentication auth){
		logger.info("FAP 에이전시 기업 등록 이동 컨트롤러 시작");
		HashMap<String, Object> hashMap = sfaService.select_comp_list((String)auth.getPrincipal());
		model.addAttribute("select_comp_list", hashMap.get("select_comp_list"));
		model.addAttribute("select_standBy_comp", hashMap.get("select_standBy_comp"));
		model.addAttribute("select_refusal_comp", hashMap.get("select_refusal_comp"));
		
		Gson gson = new Gson();
		ArrayList<HashMap<String, Object>> select_agency_management_company_list = sfaService.select_agency_management_company_list();
		model.addAttribute("select_agency_management_company_list", gson.toJson(select_agency_management_company_list));
		SocietyFapCompanyUser comp_user = sfaService.select_company((String)auth.getPrincipal());
		model.addAttribute("comp_user", gson.toJson(comp_user));
		
		logger.info("FAP 에이전시 기업 등록 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_COMPANY_REGISTRATION;
	}

	/**
	 * @Method Name : agency_company_management
	 * @Date : 2018. 12. 18.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 등록 기업 관리)
	 * @Method 설명 : 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_MANAGEMENT, method = RequestMethod.GET)
	public String agency_company_management(Model model, Authentication auth){
		logger.info("FAP 에이전시 기업 정보 가져오기 컨트롤러 시작");
		HashMap<String, Object> hashMap = sfaService.select_comp_list((String)auth.getPrincipal());
		model.addAttribute("select_approval_comp", hashMap.get("select_approval_comp"));
		model.addAttribute("select_standBy_comp", hashMap.get("select_standBy_comp"));
		model.addAttribute("select_refusal_comp", hashMap.get("select_refusal_comp"));
		logger.info("FAP 에이전시 기업 정보 가져오기 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_COMPANY_MANAGEMENT;
	}
	
	/**
	 * @Method Name : agency_company_update
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : JSP 리턴페이지(에이전시 기업 정보 수정)
	 * @Method 설명 : 에이전시가 선택한 기업의 정보를 수정하는 폼으로 이동하는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_UPDATE_FORM , method = RequestMethod.POST)
	public String agency_company_update(Model model, String fap_comp_id){
		logger.info("FAP 기업 정보 수정 이동 컨트롤러 시작");
		SocietyFapCompanyUser societyFapCompanyUser = sfaService.select_company_compare_id(fap_comp_id);
		Gson gson = new Gson();
		model.addAttribute("company_info", gson.toJson(societyFapCompanyUser));
		logger.info("FAP 기업 정보 수정 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_COMPANY_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : agency_company_update
	 * @Date : 2018. 12. 19.
	 * @User : 김준영
	 * @Param : 기업 객체
	 * @Return : JSP 리턴페이지(에이전시 등록 기업 관리)
	 * @Method 설명 : 에이전시가 선택한 기업의 정보를 수정한 후 기업 관리 페이지로 이동하는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_UPDATE , method = RequestMethod.POST)
	public String agency_company_update(Model model, Authentication auth, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 기업 정보 수정 컨트롤러 시작");
		
		societyFapCompanyUser.setFap_comp_udt_id((String)auth.getPrincipal());
		sfaService.update_company(societyFapCompanyUser);
		logger.info("FAP 기업 정보 수정 컨트톨러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_COMPANY_MANAGEMENT;
	}
	
	
	/**
	 * @Method Name : agency_company_disconnect
	 * @Date : 2018. 12. 21.
	 * @User : 김준영
	 * @Param : 에이전시 기업 연결 SEQ
	 * @Return : JSP 리턴페이지(에이전시 등록 기업 관리)
	 * @Method 설명 : 에이전시 기업 연결을 끊은 후 기업 관리 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPANY_DISCONNECT, method = RequestMethod.POST)
	public String agency_company_disconnect(Authentication auth, int fap_ag_comp_connect_seq){
		logger.info("FAP 에이전시 기업 연결 끊기 컨트롤러 시작");
		sfaService.ag_comp_disconnect(fap_ag_comp_connect_seq);
		logger.info("FAP 에이전시 기업 연결 끊기 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_COMPANY_MANAGEMENT;
	}
	
	/**
	 * @Method Name : agency_forgot_id
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 아이디 찾기)
	 * @Method 설명 : 에이전시 유저 아이디 찾기 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_FORGOT_ID, method = RequestMethod.GET)
	public String agency_forgot_id(){
		logger.info("FAP 에이전시 유저 아이디 찾기 이동 컨트톨러 시작");
		
		logger.info("FAP 에이전시 유저 아이디 찾기 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_FORGOT_ID;
	}
	
	/**
	 * @Method Name : agency_forgot_id_result
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 아이디 찾기 결과 페이지)
	 * @Method 설명 : 에이전시 유저 아이디 찾은 후 결과 페이지로 이동 후 아이디를 보여주는 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_FORGOT_ID_RESULT, method = RequestMethod.GET)
	public String agency_forgot_id_result(HttpSession session, Model model) throws Exception{
		logger.info("FAP 에이전시 유저 아이디 찾기 결과 이동 컨트톨러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");

		User user = new User();
		user.setUser_id(user_id);

		String found_id = sfaService.user_forgot_id(user);

		// 찾은 데이터를 모델에 담아서 보냄
		model.addAttribute("found", found_id);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");
		
		
		logger.info("FAP 에이전시 유저 아이디 찾기 결과 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_FORGOT_ID_RESULT;
	}
	
	/**
	 * @Method Name : agency_forgot_password
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 담당자 비밀번호 찾기)
	 * @Method 설명 : 에이전시 담당자 비밀번호 찾기 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_FORGOT_PASSWORD, method = RequestMethod.GET)
	public String agency_forgot_password(){
		logger.info("FAP 에이전시 담당자 비밀번호 찾기 이동 컨트톨러 시작");
		
		logger.info("FAP 에이전시 담당자 비밀번호 찾기 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_FORGOT_PASSWORD;
	}
	
	/**
	 * @Method Name : agency_forgot_password_form
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 
	 * @Return : JSP 리턴페이지(에이전시 담당자 비밀번호 찾기)
	 * @Method 설명 : 에이전시 담당자 비밀번호 찾기 폼 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_FORGOT_PASSWORD_FORM, method = RequestMethod.GET)
	public String agency_forgot_password_form(HttpSession session) throws Exception{
		logger.info("FAP 에이전시 담당자 비밀번호 찾기 폼 이동 컨트톨러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			throw new Exception();
		}
		
		logger.info("FAP 에이전시 담당자 비밀번호 찾기 폼 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_FORGOT_PASSWORD_FORM;
	}
	
	/**
	 * @Method Name : agency_forgot_password_change
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 에이전시 담당자 비밀번호
	 * @Return : JSP 리턴페이지(에이전시 메인)
	 * @Method 설명 : 에이전시 담당자가 입력한 비밀번호로 비밀번호를 변경함
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_FORGOT_PASSWORD_CHANGE, method = RequestMethod.POST)
	public String agency_forgot_password_change(HttpSession session, Model model, String user_pw) throws Exception{
		logger.debug("FAP 에이전시 담당자 비밀번호 변경 컨트롤러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}
		String user_id = (String) session.getAttribute("user_id");

		boolean canChange = sfaService.agency_forgot_password(user_id, user_pw);
		model.addAttribute("canChange", canChange);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");
		logger.debug("FAP 에이전시 담당자 비밀번호 변경 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_FORGOT_PASSWORD_RESULT;
	}
	
	/**
	 * @Method Name : delete_agency_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 에이전시 담당자 정보 객체
	 * @Return : -
	 * @Method 설명 : 에이전시 담당자 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_USER_INFO_DELETE, method = RequestMethod.POST)
	public String delete_agency_user_info(User user){
		logger.info("FAP 에이전시 담당자 탈퇴 컨트롤러 시작");
		sfaService.delete_agency_user_info(user);
		logger.info("FAP 에이전시 담당자 탈퇴 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : agency_info_insert_form
	 * @Date : 2019. 1. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(기업 정보 입력 페이지) 
	 * @Method 설명 : 기업 정보 입력 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_INFO_INSERT, method = RequestMethod.GET)
	public String agency_info_insert_form(){
		logger.info("FAP 에이전시 담당자 - 기업 정보 입력 폼 이동 컨트롤러 시작");
		
		logger.info("FAP 에이전시 담당자 - 기업 정보 입력 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_INFO_INSERT;
	}
	
	/**
	 * @Method Name : agency_info_insert
	 * @Date : 2019. 1. 10.
	 * @User : 김준영
	 * @Param : 
	 * @Return : JSP 리턴페이지(기업 메인 입력 페이지) 
	 * @Method 설명 : 기업 정보를 입력 한 후 메인 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_INFO_INSERT, method = RequestMethod.POST)
	public String agency_info_insert(Authentication auth, SocietyFapCompanyUser company_info){
		logger.info("FAP 에이전시 담당자 - 기업 정보 입력 시작");
		sfaService.user_agency_info_insert(auth, company_info);
		logger.info("FAP 에이전시 담당자 - 기업 정보 입력 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_MAIN;
	}
	
	/**
	 * @Method Name : jobfair_participation
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 잡페어 시퀀스
	 * @Return : JSP 리턴페이지(FAP 잡페어 참가 페이지)
	 * @Method 설명 : 선택한 잡페어 정보를 검색 후 잡페어 참가 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOBFAIR_PARTICIPATION, method = RequestMethod.GET)
	public String jobfair_participation(Model model, Authentication auth, int fap_jobfair_seq){
		logger.info("잡페어 참가폼 이동 컨트롤러 시작");
		
		//회사 아이디 발급 여부 확인(확인 후 삭제)
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id_ck = sfaService.select_fap_comp_id(user_id);
		if(fap_comp_id_ck == null){
			logger.info("관리자알림!!! 신청 대상이 아닌기업이 잡페어 신청했음!!");
		}
		
		//노출허용 된 선택 잡페어 세부정보 검색
		ArrayList<HashMap<String, Object>> jobfair_divide_search_list = sfaService.jobfair_divide_search_list(fap_jobfair_seq);
		model.addAttribute("jobfairDivideList", jobfair_divide_search_list);
		
		//잡페어 로고 경로 설정
		String path = fapAdminJobfairLogoImage+"/";
		model.addAttribute("path", path);
		
		logger.info("잡페어 참가폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_JOBFAIR_PARTICIPATION_FORM;
	}
	
	/**
	 * @Method Name : agency_job_ad_management
	 * @Date : 2019. 2. 1.
	 * @User : 정대영
	 * @Param : -
	 * @Return : 채용공고 관리페이지 JSP
	 * @Method 설명 : 채용공고 관리페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_MANAGEMENT, method = RequestMethod.GET)
	public String agency_job_ad_management(Model model, HttpSession session, Authentication auth,
			@RequestParam(defaultValue="0") int fap_jobfair_seq, @RequestParam(defaultValue="0") int fap_jobfair_divide_seq){
		logger.debug("채용공고 관리페이지 이동 시작");
		
		String chosen_fap_comp_id = (String) session.getAttribute("chosen_fap_comp_id");
		//컴퍼니에 딸리 회사 리스트도 가져오기
		
		Gson gson = new Gson();
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("chosen_fap_comp_id", chosen_fap_comp_id);
		
		//잡페어 리스트 담은 map (key : jobfair_list_now, jobfair_list_before,jobfair_list_after)
		HashMap<String, Object> jobfair_map = new HashMap<String, Object>();
		jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", gson.toJson(jobfair_map));
		
		
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		
		if(fap_comp_id == null){
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_MAIN;
		}		
		
		
		
		//FAP 에이전시 정보 가져오기
		SocietyFapCompanyUser agencyInfo = sfaService.select_company((String)auth.getPrincipal());		
		//FAP 에이전시가 관리중인 기업 정보 가져오기
		HashMap<String, Object> hashMap = sfaService.select_comp_list((String)auth.getPrincipal());
		
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("agency_info", agencyInfo);
		resultMap.put("select_approval_comp", hashMap.get("select_approval_comp"));
		model.addAttribute("resultMap", resultMap);
		
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcService.search_company_jobfair_list(fap_comp_id);
		model.addAttribute("jobfair_list", company_jobfair_list);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		
		
		logger.debug("채용공고 관리페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_JOB_AD_MANAGEMENT;
	}
	
	/**
	 * @Method Name : agency_job_ad_insert_form
	 * @Date : 2019. 1. 22.
	 * @User : 이재준, 정대영
	 * @Param : -
	 * @Return : 채용공고 등록 JSP
	 * @Method 설명 : 채용공고 등록페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_INSERT_FORM, method = RequestMethod.POST)
	public String agency_job_ad_insert_form(int fap_jobfair_seq, int fap_jobfair_divide_seq, Model model , HttpSession session){
		logger.debug("채용공고 등록페이지 이동 시작");
		String chosen_fap_comp_id = (String) session.getAttribute("chosen_fap_comp_id");

		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("chosen_fap_comp_id", chosen_fap_comp_id);
		paramMap.put("fap_jobfair_seq",fap_jobfair_seq);
		
		int adTotalCount = sfaService.select_job_ad_load_list_count(paramMap);
		if(adTotalCount == 0){adTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(5, 5, 1, adTotalCount);
		int jobAdLoadNum = adTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfaService.select_job_ad_load_list_paging(paramMap, repNavi.getStartRecord(), repNavi.getCountPerPage());
		model.addAttribute("select_job_ad_load_list", select_job_ad_load_list);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("jobAdLoadNum", jobAdLoadNum);
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("chosen_fap_comp_id", chosen_fap_comp_id);
		
		Gson gson = new Gson();
		SocietyFapCompanyUser comp_info = sfaService.select_company_of_parameter_comp_id(chosen_fap_comp_id);
		model.addAttribute("comp_info", gson.toJson(comp_info));
		
		logger.debug("채용공고 등록페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_JOB_AD_INSERT_FORM;
	}
	
	/**
	 * @Method Name : agency_job_ad_insert
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 객체
	 * @Return : JSP 등록폼
	 * @Method 설명 : -
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_INSERT, method=RequestMethod.POST)
	public String agency_job_ad_insert(SocietyFapJobAd JobAd, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee
			, SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp,
			SocietyFapJobFile JobFile, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt,
			SocietyFapJobWork JobWork, SocietyFapJobCategory JobCategory
			, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace, SocietyFapJobRecruitPcs JobRecruitPcs,
			SocietyFapJobPay JobPay, Authentication auth, int fap_jobfair_seq
			, int fap_jobfair_divide_seq, Model model, String fap_comp_id){
			logger.info("FAP 에이전시 채용공고 등록 시작");
			
			model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
			model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
			
			sfaService.job_ad_insert2(JobAd, JobDorm, JobJitEmployee, JobJaLevel, JobTrial, JobComp, JobFile, JobIsr, JobJoinDt
					, JobWork, JobCategory, JobPref, JobWorkplace, JobRecruitPcs, JobPay);
			
			logger.info("FAP 에이전시 채용공고 등록 끝");
			return "redirect:" + SOCIETY_FAP_AGENCY_JOB_AD_MANAGEMENT;
	}
	
	/**
	 * @Method Name : agency_job_ad_update_form
	 * @Date : 2019. 1. 22.
	 * @User : 이재준
	 * @Param : 채용공고 시퀀스
	 * @Return : JSP 채용공고 등록폼
	 * @Method 설명 : 해당 채용공고의 수정폼으로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_UPDATE_FORM, method=RequestMethod.GET)
	public String agency_job_ad_update_form(Model model, Authentication auth, HttpSession session, long fap_job_ad_seq){
		logger.debug("FAP ");
		String fap_comp_id = (String) session.getAttribute("chosen_fap_comp_id");
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
				
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
		
		//model.addAttribute("job_exam_file_path", fapJobRecruitExamFile);
		model.addAttribute("job_exam_file_path", "/fap/company/job_recruit_exam_file");
		
		logger.debug("FAP ");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : agency_job_ad_update
	 * @Date : 2019. 1. 23.
	 * @User : 이재준
	 * @Param : 
	 * @Return : 
	 * @Method 설명 : 채용공고를 수정하는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_UPDATE, method = RequestMethod.POST)
	public String agency_job_ad_update(Model model, Authentication auth, HttpSession session,
			@RequestParam(defaultValue="") ArrayList<Long> fap_job_recruit_pcs_seq_list, SocietyFapJobRecruitPcs JobRecruitPcs,
			SocietyFapJobAd JobAd, int fap_jobfair_divide_seq, int fap_jobfair_seq
			, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee
			, SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp,
			SocietyFapJobFile JobFile, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt,
			SocietyFapJobWork JobWork, SocietyFapJobCategory JobCategory
			, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace, SocietyFapJobPay JobPay){
		// 채용공고, 채용전형 수정
		long job_ad_parent_insert_seq = sfaService.job_ad_parent_update(fap_job_recruit_pcs_seq_list, JobAd, JobRecruitPcs);
		
		String fap_comp_id = (String) session.getAttribute("chosen_fap_comp_id");
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		ArrayList<SocietyFapJobAd> jobAdList = sfaService.select_job_ad_list(fap_comp_id);
		model.addAttribute("jobAdList", jobAdList);
		
		HashMap<String, Object> param = new HashMap<>();
		
		long fap_job_ad_seq = JobAd.getFap_job_ad_seq();
		param.put("fap_comp_id", fap_comp_id);
		param.put("fap_job_ad_seq", fap_job_ad_seq);
		
		JobAd.setFap_comp_id(fap_comp_id);
		JobAd.setFap_job_ad_seq(job_ad_parent_insert_seq);
		
		sfaService.delete_job_ad(job_ad_parent_insert_seq);
		sfaService.job_ad_children_insert(JobAd, JobDorm, JobJitEmployee, JobJaLevel, JobTrial, JobComp, JobFile, JobIsr, JobJoinDt, JobWork, JobCategory, JobPref, JobWorkplace, JobPay);
		return "redirect:" + SOCIETY_FAP_AGENCY_JOB_AD_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_mypage
	 * @Date : 2019. 1. 25.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 마이페이지)
	 * @Method 설명 : 에이전시 마이페이지로 이동하는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_MYPAGE, method = RequestMethod.GET)
	public String company_mypage(){
		logger.info("FAP 에이전시 마이페이지 이동 컨트롤러 시작");
		logger.info("FAP 에이전시 마이페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_MYPAGE;
	}
	
	/**
	 * @Method Name : company_connect_request_management
	 * @Date : 2019. 1. 25.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(담당자 - 에이전시 연결 관리 페이지)
	 * @Method 설명 : 담당자 - 에이전시 연결 관리 페이지로 이동하는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_CONNECT_REQUEST_MANAGEMENT, method = RequestMethod.GET)
	public String company_connect_request_management(Model model, Authentication auth){
		logger.info("FAP 담당자 - 에이전시 연결 페이지 이동 컨트롤러 시작");
		/*
		ArrayList<SocietyFapCompanyUser> comp_list = new ArrayList<>();
		SocietyFapCompanyUserConnect comp_user_connect = sfcService.select_comp_user_connect((String)auth.getPrincipal());
		HashMap<String, Object> connect_info = new HashMap<>();
		if(comp_user_connect == null){
			comp_list = sfaService.select_agency_company();
			connect_info.put("check_connect", "non_exist");
			connect_info.put("comp_list", comp_list);
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3800")){ 
			connect_info.put("check_connect", "exist");
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3801")){
			connect_info.put("check_connect", "standBy");
			// 해당 하는 기업 뿌려주기
			SocietyFapCompanyUser standBy_company = sfaService.select_company((String)auth.getPrincipal());
			connect_info.put("comp_user_connect", comp_user_connect);
			comp_list.add(standBy_company);
			connect_info.put("comp_list", comp_list);
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3802")){
			connect_info.put("check_connect", "refusal");
			// 해당 하는 기업 뿌려주기
			SocietyFapCompanyUser refusal_company = sfaService.select_company((String)auth.getPrincipal());
			connect_info.put("comp_user_connect", comp_user_connect);
			comp_list.add(refusal_company);
			connect_info.put("comp_list", comp_list);
		}
		
		Gson gson = new Gson();
		model.addAttribute("connect_info", gson.toJson(connect_info));
		*/
		
		ArrayList<SocietyFapCompUserConnectRequest> CompUserConnectRequest = sfcService.select_comp_user_connect_request((String)auth.getPrincipal());
		model.addAttribute("CompUserConnectRequest", CompUserConnectRequest);
		
		logger.info("FAP 담당자 - 에이전시 연결 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_CONNECT_REQUEST_MANAGEMENT;
	}
	
	/**
	 * @Method Name : agency_jobfair_apply_to_attend_form
	 * @Date : 2019. 1. 26.
	 * @User : 이재준
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 잡페어 신청 페이지)
	 * @Method 설명 : FAP 에이전시 잡페어 신청 페이지 이동 요청
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOBFAIR_APPLY_TO_ATTEND_FORM, method = RequestMethod.GET)
	public String agency_jobfair_apply_to_attend_form(){
		logger.info("FAP 에이전시 잡페어 신청 페이지 이동 컨트롤러 시작");
		logger.info("FAP 에이전시 잡페어 신청 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_JOBFAIR_APPLY_TO_ATTEND_FORM;
	}
	
	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2019. 1. 28.
	 * @User : 신동철
	 * @Param : 게시판 세부내용 시퀀스, 게시판 구분, 게시판 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용)
	 * @Method 설명 : 잡페어 공지사항 게시판 세부내용 검색
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_BOARD_CONTENTS_DETAIL, method = RequestMethod.GET)
	public String board_contents_detail(int board_content_seq, Model model, BoardGroup boardGroup			
			, String board_detail_gb){
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 시작");
	     
		//조회수 증가
		sfcService.board_contents_hit_update(board_content_seq);
		//조회
		HashMap<String, Object> resultMap = sfcService.board_contents_detail(board_content_seq);
		resultMap.put("board_detail_gb", board_detail_gb);
		//String path = seaService.findPath(boardGroup.getBoard_gb(), boardGroup.getBoard_tp());
		model.addAttribute("contentDetail", resultMap);
		//model.addAttribute("path", path);
 
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_BOARD_CONTENTS_DETAIL_FORM;
	}	
	
		
	
	/**
	 * @Method Name : agency_board_content_list
	 * @Date : 2019. 7. 16. 
	 * @User : 김경아
	 * @Param : -
	 * @Return : JSP 리턴페이지(공지사항 게시판 리스트)
	 * @Method 설명 : 잡페어 공지사항 리스트 페이지 이동
	 */

	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_BOARD_CONTENT_LIST, method = RequestMethod.GET)
	public String agency_board_content_list(Model model, BoardGroup boardGroup, String board_detail_gb, String board
			,@RequestParam(defaultValue="10") int pageCount
			,@RequestParam(defaultValue="1") int curPage	
			,@RequestParam(defaultValue="") String searchKey
			,@RequestParam(defaultValue="") String searchValue
			){
		logger.debug("잡페어 공지사항 리스트 페이지 이동 컨트롤러 시작");	
	
		//전체 글 갯수 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		if(board.equals("notice")){ //공지사항 게시판 		 
			map.put("board_detail_gb", BOARD_NOTICE_CODE);	 
		}else if(board.equals("jobinfo")){ //취업정보&전략 게시판 		 
			map.put("board_detail_gb", BOARD_JOBINFO_CODE);			 
		}else if(board.equals("same_board")) { //해당게시판
			map.put("board_detail_gb", board_detail_gb);			 
		}
		
		int count = sfcService.board_contents_count(map);		
		 
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
			
		map.put("count", count);  
		map.put("adminPager", adminPager);	 
		
		//글 리스트
		ArrayList<BoardContent> resultList = sfcService.company_board_contents_list_search(map);
		
		//제목 
		String board_nm = sfcService.select_comp_name(boardGroup.getBoard_detail_gb());
		map.put("board_nm",board_nm);
	
		 model.addAttribute("resultList", resultList);
		 model.addAttribute("map", map);
		 model.addAttribute("boardGroup", boardGroup);		 
		 
		logger.debug("잡페어 공지사항 리스트 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_BOARD_CONTENT_LIST;
	}
	
	
	/**
	 * @Method Name : agency_process_schedule_calendar
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 전형일정 캘린더 페이지)
	 * @Method 설명 : 에이전시 전형일정 캘린더 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_PROCESS_SCHEDULE_CALENDAR, method = RequestMethod.GET)
	public String agency_process_schedule_calendar(Model model, Authentication auth){
		logger.info("에이전시 전형일정 캘린더 이동 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		
		if(fap_comp_id == null){
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_MAIN;
		}		
		
		//FAP 에이전시 정보 가져오기
		SocietyFapCompanyUser agencyInfo = sfaService.select_company((String)auth.getPrincipal());		
		//FAP 에이전시가 관리중인 기업 정보 가져오기
		HashMap<String, Object> hashMap = sfaService.select_comp_list((String)auth.getPrincipal());
		
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("agency_info", agencyInfo);
		resultMap.put("select_approval_comp", hashMap.get("select_approval_comp"));
		model.addAttribute("resultMap", resultMap);
		
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcService.search_company_jobfair_list(fap_comp_id);
		model.addAttribute("jobfair_list", company_jobfair_list);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		logger.info("에이전시 전형일정 캘린더 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : agency_required_doc_management
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 에이전시 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 내정서류 관리 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT, method = RequestMethod.GET)
	public String agency_required_doc_management(Model model, Authentication auth, HttpSession session){
		logger.info("에이전시 내정서류 관리폼 이동 컨트롤러 시작");
		
		//FAP 에이전시 정보 가져오기
		SocietyFapCompanyUser agencyInfo = sfaService.select_company((String)auth.getPrincipal());		
		//FAP 에이전시가 관리중인 기업 정보 가져오기
		HashMap<String, Object> hashMap = sfaService.select_comp_list((String)auth.getPrincipal());		
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("agency_info", agencyInfo);
		resultMap.put("select_approval_comp", hashMap.get("select_approval_comp"));
		model.addAttribute("resultMap", resultMap);
		
		SocietyFapCompanyUser company_info = sfcService.select_company((String)auth.getPrincipal());
		SocietyFapJobAd job_ad = new SocietyFapJobAd();
		job_ad.setFap_comp_id(company_info.getFap_comp_id());
		ArrayList<SocietyFapJobAd> company_job_ad_list = sfcService.search_company_job_ad_list(job_ad);
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcService.search_company_jobfair_list(company_info.getFap_comp_id());
		model.addAttribute("company_info", company_info);
		model.addAttribute("company_job_ad_list", company_job_ad_list);
		model.addAttribute("company_jobfair_list", company_jobfair_list);
		
		session.removeAttribute("comp_id");
		session.removeAttribute("fap_ad_seq");
		session.removeAttribute("fap_divide_seq");
		
		if(session.getAttribute("fap_comp_id_2") != null){
			session.setAttribute("comp_id", session.getAttribute("fap_comp_id_2"));
			session.removeAttribute("fap_comp_id_2");
		}
		if(session.getAttribute("fap_ad_seq_2") != null){
			session.setAttribute("fap_ad_seq", session.getAttribute("fap_ad_seq_2"));
			session.removeAttribute("fap_ad_seq_2");
		}
		if(session.getAttribute("fap_divide_seq_2") != null){
			session.setAttribute("fap_divide_seq", session.getAttribute("fap_divide_seq_2"));
			session.removeAttribute("fap_divide_seq_2");
		}
	
		logger.info("에이전시 내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_common_required_doc_insert
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시가 등록한 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 에이전시 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 내정서류 등록 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String agency_insert_common_required_doc(Model model, Authentication auth, SocietyFapCommonRequiredDoc common_required_doc
			, @RequestParam("fap_job_ad_seq") long fap_job_ad_seq
			, @RequestParam("fap_jobfair_seq") int fap_jobfair_seq
			, @RequestParam("fap_jobfair_divide_seq") int fap_jobfair_divide_seq
			, @RequestParam("fap_comp_id") String fap_comp_id){
		logger.info("에이전시 내정서류 등록 컨트롤러 시작");
		
		common_required_doc.setFap_job_ad_seq(fap_job_ad_seq);
		common_required_doc.setFap_jobfair_seq(fap_jobfair_seq);
		common_required_doc.setFap_jobfair_divide_seq(fap_jobfair_divide_seq);
		common_required_doc.setFap_comp_id(fap_comp_id);
		
		common_required_doc.setFap_common_required_doc_ins_id((String)auth.getPrincipal());
		common_required_doc.setFap_common_required_doc_udt_id((String)auth.getPrincipal());
		int result = sfcService.insert_common_required_doc(common_required_doc);
		
		if(result>0){			
			//알림게시판에 관련정보 입력 		 
			HashMap<String,Object> compNms= sfaccService.select_comp_nm(fap_comp_id);		 
			String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
			String fap_job_ad_title = sfacService.select_job_ad_title(common_required_doc.getFap_job_ad_seq());
			String fap_admin_notice_ct = "기업 \'"+fap_comp_en_nm+"\'이(가) 채용공고  \'"+fap_job_ad_title+"\' 의 공통 내정서류를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_comp_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2306");
			int adminInfo = sfacService.insert_admin_notice_info(paramMap);
		}
		
		logger.info("에이전시 내정서류 등록 컨트롤러 종료");
		return "forward:"+PathConstants.SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_common_required_doc_delete
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시가 등록한 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 에이전시 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 내정서류 삭제 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_DELETE, method = RequestMethod.POST)
	public String agency_delete_common_required_doc(Model model, SocietyFapCommonRequiredDoc common_required_doc
			, @RequestParam("fap_job_ad_seq") long fap_job_ad_seq
			, @RequestParam("fap_jobfair_seq") int fap_jobfair_seq
			, @RequestParam("fap_jobfair_divide_seq") int fap_jobfair_divide_seq
			, @RequestParam("fap_comp_id") String fap_comp_id){
		logger.info("에이전시 내정서류 삭제 컨트롤러 시작");
		
		common_required_doc.setFap_job_ad_seq(fap_job_ad_seq);
		common_required_doc.setFap_jobfair_seq(fap_jobfair_seq);
		common_required_doc.setFap_jobfair_divide_seq(fap_jobfair_divide_seq);
		common_required_doc.setFap_comp_id(fap_comp_id);
		
		sfcService.delete_common_required_doc(common_required_doc);
		
		logger.info("에이전시 내정서류 삭제 컨트롤러 종료");
		return "forward:"+PathConstants.SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_common_required_doc_update
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시가 등록한 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 에이전시 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 내정서류 수정 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMMON_REQUIRED_DOC_UPDATE, method = RequestMethod.POST)
	public String agency_update_common_required_doc(Model model, Authentication auth, SocietyFapCommonRequiredDoc common_required_doc
			, @RequestParam("fap_job_ad_seq") long fap_job_ad_seq
			, @RequestParam("fap_jobfair_seq") int fap_jobfair_seq
			, @RequestParam("fap_jobfair_divide_seq") int fap_jobfair_divide_seq
			, @RequestParam("fap_comp_id") String fap_comp_id){
		logger.info("에이전시 내정서류 수정 컨트롤러 시작");
		
		common_required_doc.setFap_job_ad_seq(fap_job_ad_seq);
		common_required_doc.setFap_jobfair_seq(fap_jobfair_seq);
		common_required_doc.setFap_jobfair_divide_seq(fap_jobfair_divide_seq);
		common_required_doc.setFap_comp_id(fap_comp_id);
		common_required_doc.setFap_common_required_doc_udt_id((String)auth.getPrincipal());
		sfcService.update_common_required_doc(common_required_doc);
		
		logger.info("에이전시 내정서류 수정 컨트롤러 종료");
		return "forward:"+PathConstants.SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_required_doc_management_form
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 에이전시 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 내정서류 관리 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT_FORM, method = RequestMethod.POST)
	public String agency_required_doc_management_form(Model model, Authentication auth, HttpSession session
			, @RequestParam("fap_job_ad_seq") long fap_job_ad_seq, @RequestParam("fap_comp_id") String fap_comp_id
			,@RequestParam("fap_jobfair_seq") int fap_jobfair_seq, @RequestParam("fap_jobfair_divide_seq") int fap_jobfair_divide_seq){
		logger.info("에이전시 내정서류 관리폼 이동 컨트롤러 시작");
		
		//FAP 에이전시 정보 가져오기
		SocietyFapCompanyUser agencyInfo = sfaService.select_company((String)auth.getPrincipal());		
		//FAP 에이전시가 관리중인 기업 정보 가져오기
		HashMap<String, Object> hashMap = sfaService.select_comp_list((String)auth.getPrincipal());		
		HashMap<String, Object> resultMap = new HashMap<>();
		resultMap.put("agency_info", agencyInfo);
		resultMap.put("select_approval_comp", hashMap.get("select_approval_comp"));
		model.addAttribute("resultMap", resultMap);
		
		SocietyFapCompanyUser company_info = sfcService.select_company((String)auth.getPrincipal());
		SocietyFapJobAd job_ad = new SocietyFapJobAd();
		job_ad.setFap_comp_id(company_info.getFap_comp_id());
		ArrayList<SocietyFapJobAd> company_job_ad_list = sfcService.search_company_job_ad_list(job_ad);
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcService.search_company_jobfair_list(company_info.getFap_comp_id());
		model.addAttribute("company_info", company_info);
		model.addAttribute("company_job_ad_list", company_job_ad_list);
		model.addAttribute("company_jobfair_list", company_jobfair_list);		
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		logger.info("에이전시 내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_personal_required_doc_management
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 리턴페이지(FAP 에이전시 개인내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 개인내정서류 관리 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT, method = RequestMethod.GET)
	public String agency_personal_required_doc_management(Model model, HttpSession session, Authentication auth, long fap_nominee_seq){
		logger.info("에이전시 개인내정서류 관리폼 이동 컨트롤러 시작");
		
		SocietyFapNominee nominee_info = sfcService.select_nominee_info(fap_nominee_seq);
		model.addAttribute("nominee_info", nominee_info);
		session.setAttribute("fap_comp_id_2", nominee_info.getFap_comp_id());
		session.setAttribute("fap_ad_seq_2", nominee_info.getFap_job_ad_seq());
		session.setAttribute("fap_divide_seq_2", nominee_info.getFap_jobfair_divide_seq());
		
		logger.info("에이전시 개인내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_persoanl_required_doc_insert
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 등록할 에이전시 개인 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 개인 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 개인 내정서류 등록 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String agency_insert_personal_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("에이전시 개인 내정서류 등록 컨트롤러 시작");
		
		String fap_comp_id = sfcService.select_fap_comp_id((String)auth.getPrincipal());
		personal_required_doc.setFap_personal_required_doc_ins_id(fap_comp_id);
		personal_required_doc.setFap_personal_required_doc_udt_id(fap_comp_id);
		int result = sfcService.insert_personal_required_doc(personal_required_doc);
		
		//알림게시판에 관련정보 입력 
		if(result>0){		
			String fap_comp_id_2 = (String)auth.getPrincipal();
			HashMap<String,Object> compNms= sfaccService.select_comp_nm(fap_comp_id_2);		 
			String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
			String fap_job_ad_title = sfacService.select_job_ad_title(personal_required_doc.getFap_job_ad_seq());
			String fap_admin_notice_ct = "기업 \'"+fap_comp_en_nm+"\'가 채용공고  \'"+fap_job_ad_title+"\' 의 개인 내정서류를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_comp_id_2);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2306");
			int adminInfo = sfacService.insert_admin_notice_info(paramMap);
		}	
		
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("에이전시 개인 내정서류 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_personal_required_doc_management_form
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 리턴페이지(FAP 에이전시 개인내정서류 관리폼)
	 * @Method 설명 : 에이전시 개인내정서류 관리폼으로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM, method = RequestMethod.GET)
	public String agency_personal_required_doc_management_form(Model model, Authentication auth, @RequestParam("param") long fap_nominee_seq, RedirectAttributes redirect){
		logger.info("에이전시 개인내정서류 관리폼 이동 컨트롤러 시작");
		
		SocietyFapNominee nominee_info = sfcService.select_nominee_info(fap_nominee_seq);
		model.addAttribute("nominee_info", nominee_info);
		model.addAttribute("fap_jobfair_seq", nominee_info.getFap_jobfair_seq());
		model.addAttribute("fap_jobfair_divide_seq", nominee_info.getFap_jobfair_divide_seq());
		model.addAttribute("fap_job_ad_seq", nominee_info.getFap_job_ad_seq());
		model.addAttribute("fap_comp_id", nominee_info.getFap_comp_id());
		
		logger.info("에이전시 개인내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_personal_required_doc_update
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시 개인 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 에이전시 개인 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 개인 내정서류 수정 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_UPDATE, method = RequestMethod.POST)
	public String agency_update_personal_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("에이전시 개인 내정서류 수정 컨트롤러 시작");
		
		personal_required_doc.setFap_personal_required_doc_udt_id((String)auth.getPrincipal());
		sfcService.update_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("에이전시 개인 내정서류 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_personal_required_doc_delete
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 에이전시 개인 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 에이전시 개인 내정서류 관리 페이지)
	 * @Method 설명 : 에이전시 개인 내정서류 삭제 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_DELETE, method = RequestMethod.GET)
	public String agency_personal_required_doc_delete(Model model, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("에이전시 개인 내정서류 삭제 컨트롤러 시작");
		
		sfcService.delete_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("에이전시 개인 내정서류 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : agency_language_change
	 * @Date : 2019. 1. 29.
	 * @User : 신동철
	 * @Param : 
	 * @Return : 에이전시 메인 페이지
	 * @Method 설명 : 에이전시 언어 변경 요청
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_LANGUAGE_CHANGE, method = RequestMethod.GET)
	public String agency_language_change(String lo,HttpServletRequest request , HttpServletResponse response) {
		
		LocaleUtil.setLocale(request, response, lo);
		
		return "redirect:"+PathConstants.SOCIETY_FAP_AGENCY_MAIN+"?lang="+lo;
	}
	
	/**
	 * @Method Name : agency_terms_and_condition_policy
	 * @Date : 2019. 1. 31.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 개인정보처리방침 페이지
	 * @Method 설명 : 개인정보처리방침 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_TERMS_AND_CONDITION_POLICY, method = RequestMethod.GET)
	public String company_terms_and_condition_policy(){
		logger.info("FAP 개인정보처리방침 이동 시작");		
		logger.info("FAP 개인정보처리방침 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_TERMS_AND_CONDITION_POLICY;
	}
	
	/**
	 * @Method Name : delete_company_user_info_form
	 * @Date : 2019. 2. 12.
	 * @User : 김준영
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 회원 탈퇴페이지로 이동 요청 메소드
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_USER_INFO_DELETE_FORM, method = RequestMethod.GET)
	public String delete_user_info_form(){
		logger.info("FAP 기업 담당자 탈퇴 폼으로 이동 컨트롤러 시작");
		logger.info("FAP 기업 담당자 탈퇴 폼으로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_USER_INFO_DELETE_FORM;
	}
	
	/**
	 * @Method Name : company_job_ad_insert_form_load
	 * @Date : 2019. 1. 30.
	 * @User : 김준영
	 * @Param : 잡페어 seq, 잡페어 세부 seq, 불러올 채용공고 seq
	 * @Return : JSP 리턴페이지(채용공고 등록)
	 * @Method 설명 : 채용공고 등록페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_INSERT_FORM_LOAD, method = RequestMethod.GET)
	public String company_job_ad_insert_form_load(Model model, Authentication auth, int fap_jobfair_seq, int fap_jobfair_divide_seq, long fap_job_ad_seq, HttpSession session){
		logger.debug("FAP 채용공고 불러오기");
		
		String chosen_fap_comp_id = (String) session.getAttribute("chosen_fap_comp_id");
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_comp_id", chosen_fap_comp_id);
				
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
		
		// 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
		ArrayList<HashMap<String, Object>> job_recruit_pcs = sfcService.select_job_recruit_pcs(fap_job_ad_seq);
		String job_recruit_pcs_json = gson.toJson(job_recruit_pcs);
		String replace_job_recruit_pcs_json =  job_recruit_pcs_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("job_recruit_pcs", replace_job_recruit_pcs_json);

		// 채용공고 파일정보(회사소개 동영상, 사진, pdf)
		ArrayList<SocietyFapJobFile> job_file = sfcService.select_job_file(fap_job_ad_seq);
		model.addAttribute("job_file",  gson.toJson(job_file));
		
		// 불러오기
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("chosen_fap_comp_id", chosen_fap_comp_id);
		paramMap.put("fap_jobfair_seq",fap_jobfair_seq);
		
		int adTotalCount = sfaService.select_job_ad_load_list_count(paramMap);
		if(adTotalCount == 0){adTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(5, 5, 1, adTotalCount);
		int jobAdLoadNum = adTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfaService.select_job_ad_load_list_paging(paramMap, repNavi.getStartRecord(), repNavi.getCountPerPage());
		
		model.addAttribute("select_job_ad_load_list", select_job_ad_load_list);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("jobAdLoadNum", jobAdLoadNum);
		
		//시험전형 파일 path
		//model.addAttribute("job_exam_file_path", fapJobRecruitExamFile);
		model.addAttribute("job_exam_file_path", "/fap/company/job_recruit_exam_file");
		
		logger.debug("FAP 채용공고 불러오기");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_INSERT_FORM_LOAD;
	}
	
	/**
	 * @Method Name : agency_job_ad_read_form
	 * @Date : 2019. 2. 17.	
	 * @User : 원병호
	 * @Param : 채용공고 시퀀스
	 * @Return : JSP 채용공고 읽기폼
	 * @Method 설명 : 해당 채용공고의 읽기폼으로 이동하는 method, COMPANY와 동기화 날짜 : 2.17
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_READ_FORM, method=RequestMethod.GET)
	public String company_job_ad_read_form(Model model, Authentication auth, 
			long fap_job_ad_seq){
		logger.debug("FAP ");
		String user_id = (String) auth.getPrincipal();
		model.addAttribute("fap_comp_id", sfcService.select_fap_comp_id(user_id));
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
				
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
		
		logger.debug("FAP ");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_JOB_AD_READ_FORM;
	}
	
	/**
	 * @Method Name : agency_applicant_stat_per_job_ad
	 * @Date : 2019. 3. 13.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사 아이디
	 * @Return : 채용공고별 지원현황 페이지
	 * @Method 설명 : FAP 에이전시 - 채용공고별 지원현황 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD, method = RequestMethod.POST)
	public String agency_applicant_status_per_job_ad(Model model, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id,  String fap_job_ad_state) {
		logger.info("FAP 에이전시 - 채용공고별 지원현황 페이지 이동 컨트롤러 시작");		
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		model.addAttribute("fap_job_ad_state", fap_job_ad_state);
		
		Gson gson = new Gson();		
		HashMap <String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", Long.parseLong(fap_job_ad_seq));
		hashmap.put("fap_comp_id", fap_comp_id);
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
		//최종결과 입력 기한 검색
		HashMap<String, Object> final_select_info = sfcService.search_jobfair_divide_final_select_info(Integer.parseInt(fap_jobfair_divide_seq));
		model.addAttribute("final_select_info", final_select_info);
		
		SocietyFapJobAd ad = sfcService.select_job_ad(Long.parseLong(fap_job_ad_seq));
		
		//제한걸린 채용공고 모집계열 검색
		String limit_type = sfcService.select_interview_limit_type(ad.getFap_jobfair_seq());
		//제한 명수 검색
		HashMap<String, Object> limit_info = sfcService.select_interview_limit_check(Long.parseLong(fap_job_ad_seq));
		String ad_type = limit_info.get("fap_job_ad_category_type").toString();
		int limit_count = Integer.parseInt(limit_info.get("fap_job_itv_per_settled_num").toString());
		
		if(limit_type.equals(ad_type)) {
			model.addAttribute("limit_type", limit_type);
			model.addAttribute("limit_count", limit_count);
		}
		
		logger.info("FAP 에이전시 - 채용공고별 지원현황 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD;
	}
	
	/**
	 * @Method Name : update_fap_job_apply_result
	 * @Date : 2019. 3. 13.
	 * @User : 신동철
	 * @Param : 전형결과, 최종결과
	 * @Return : 채용공고별 지원현황 페이지
	 * @Method 설명 : FAP 에이전시 - 정규지원자의 전형결과, 최종결과 수정 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_UPDATE_FAP_JOB_APPLY_RESULT, method = RequestMethod.POST)
		public String update_fap_job_apply_result(Model model, Authentication auth, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id
				, SocietyFapJobApplyResult applyResult, SocietyFapJobApplyFinalResult finalResult){
		logger.info("FAP 에이전시 - 정규지원자의 전형결과, 최종결과 수정 컨트롤러 시작");	
		
		finalResult.setFap_job_ad_seq(Long.parseLong(fap_job_ad_seq));
		finalResult.setFap_comp_id(fap_comp_id);		
		int result = sfcService.update_fap_job_apply_result(auth, applyResult, finalResult);
		
		 //알림게시판 내용추가 
		if(result>0){		
			HashMap<String,Object> compNms= sfaccService.select_comp_nm(fap_comp_id);
			String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
			String fap_job_ad_title = sfacService.select_job_ad_title(Long.parseLong(fap_job_ad_seq));
			String fap_admin_notice_ct = "에이전시 \'"+fap_comp_en_nm+"\'이(가) 채용공고 \'"+fap_job_ad_title+"\' 의 결과를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_comp_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2305");
			int adminInfo = sfacService.insert_admin_notice_info(paramMap);		
		}
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		logger.info("FAP 에이전시 - 정규지원자의 전형결과, 최종결과 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD;
		}
	
	/**
	 * @Method Name : agency_applicant_stat_per_job_ad_form
	 * @Date : 2019. 3. 13.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사 아이디
	 * @Return : 채용공고별 지원현황 관리 폼
	 * @Method 설명 : FAP 에이전시 - 채용공고별 지원현황 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD_FORM, method = RequestMethod.GET)
	public String applicant_status_per_job_ad_form(Model model, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id) {
		logger.info("FAP 에이전시 - 채용공고별 지원현황 페이지 이동 컨트롤러 시작");		
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		Gson gson = new Gson();		
		HashMap <String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_ad_seq", Long.parseLong(fap_job_ad_seq));
		hashmap.put("fap_comp_id", fap_comp_id);
		//진행중, 합격, 예비합격자 정보 검색
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
		//최종결과 입력 기한 검색
		HashMap<String, Object> final_select_info = sfcService.search_jobfair_divide_final_select_info(Integer.parseInt(fap_jobfair_divide_seq));
		model.addAttribute("final_select_info", final_select_info);
		
		logger.info("FAP 에이전시 - 채용공고별 지원현황 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD;
	}
	
	/**
	 * @Method Name : insert_pass_comment
	 * @Date : 2019. 3. 13.
	 * @User : 신동철
	 * @Param : 최종결과 시퀀스, 합격사유
	 * @Return : 채용공고별 지원현황 페이지
	 * @Method 설명 : FAP 에이전시 - 지원자 합격사유 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_INSERT_PASS_COMMENT, method = RequestMethod.POST)
		public String insert_pass_comment(Model model, Authentication auth, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id, SocietyFapJobApplyFinalResult passComment){
		logger.info("FAP 에이전시 채용전형 지원자 최종결과 합격사유 등록 컨트롤러 시작");
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		passComment.setFap_job_app_final_rt_udt_id((String)auth.getPrincipal()); 
		sfcService.insert_pass_comment(passComment);		
		
		logger.info("FAP 에이전시 채용전형 지원자 최종결과 합격사유 등록 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD;
		}
	
	/**
	 * @Method Name : update_missmatching_fap_job_apply_result
	 * @Date : 2019. 3. 13.
	 * @User : 신동철
	 * @Param : 미스매칭 전형결과, 최종결과
	 * @Return : 채용공고별 지원현황 페이지
	 * @Method 설명 : 미스매칭 지원자의 전형결과, 최종결과 수정 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_UPDATE_MISSMATCHING_FAP_JOB_APPLY_RESULT, method = RequestMethod.POST)
		public String update_missmatching_fap_job_apply_result(Model model, Authentication auth, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id
				, SocietyFapJobApplyResult applyResult, SocietyFapJobApplyFinalResult finalResult){
		logger.info("FAP 에이전시 미스매칭 지원자의 전형결과, 최종결과 수정 컨트롤러 시작");	
		
		finalResult.setFap_job_ad_seq(Long.parseLong(fap_job_ad_seq));
		finalResult.setFap_comp_id(fap_comp_id);
		int result = sfcService.update_missmatching_fap_job_apply_result(auth, applyResult, finalResult);
		
		//알림게시판 내용추가
			if(result>0){
				HashMap<String,Object> compNms= sfaccService.select_comp_nm(fap_comp_id);
				String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
				String fap_job_ad_title = sfacService.select_job_ad_title(Long.parseLong(fap_job_ad_seq));
				String fap_admin_notice_ct = "에이전시 \'"+fap_comp_en_nm+"\'이(가) 채용공고 \'"+fap_job_ad_title+"\' 의 결과를 등록했습니다.";
				HashMap<String, Object> paramMap = new HashMap<>();
				paramMap.put("fap_admin_notice_ins_id", fap_comp_id);
				paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
				paramMap.put("fap_admin_notice_handle_gb","D2305");
				int adminInfo = sfacService.insert_admin_notice_info(paramMap);
			}
		
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		logger.info("FAP 에이전시 미스매칭 지원자의 전형결과, 최종결과 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_STAT_PER_JOB_AD;
		}
	
	
	/**
	 * @Method Name : agency_job_qna_management
	 * @Date : 2019. 3. 14.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 해당 Q&A 상세
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA_MANAGEMENT, method = RequestMethod.GET)
	public String agency_job_qna_management(Model model, Authentication auth, long fap_job_ad_seq){
		logger.info("FAP 에이전시 채용공고 Q&A 이동 컨트롤러 시작");	
		
		ArrayList<HashMap<String, Object>> job_qna_list = sfcService.select_job_qna(fap_job_ad_seq);
		
		Gson gson = new Gson();
		
		model.addAttribute("job_qna_list", gson.toJson(job_qna_list));
		
		logger.info("FAP 에이전시 채용공고 Q&A 이동 컨트롤러 끝");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA_MANAGEMENT;
	}
	
	/**
	 * @Method Name : agency_job_qna
	 * @Date : 2019. 3. 14.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 해당 Q&A 상세
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA, method = RequestMethod.GET)
	public String agency_job_qna(Model model, long fap_job_qna_question_seq){
		logger.info("FAP 에이전시 채용공고 Q&A 이동 컨트롤러 시작");	
		
		HashMap<String, Object> job_qna = sfcService.select_job_qna_one(fap_job_qna_question_seq);
		
		
		long fap_job_ad_seq = (long)(job_qna.get("fap_job_ad_seq"));
		
		Gson gson = new Gson();
		
		model.addAttribute("job_qna", job_qna);
		model.addAttribute("job_qna_json", gson.toJson(job_qna));
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		
		logger.info("FAP 에이전시 채용공고 Q&A 이동 컨트롤러 끝");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA;
	}
	
	/**
	 * @Method Name : insert_job_qna_question
	 * @Date : 2019. 3. 14.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체, 채용공고 일련번호
	 * @Return : 
	 * @Method 설명 : 채용기업 채용공고 Q&A 질문 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA_ANSWER_INSERT, method = RequestMethod.POST)
	public String insert_job_qna_question(SocietyFapQnaAnswer qnaAnswer, long fap_job_ad_seq, Authentication auth){
		logger.info("FAP 에이전시 채용공고 Q&A 답변 등록 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		qnaAnswer.setFap_job_qna_answer_ins_id(user_id);
		qnaAnswer.setFap_job_qna_answer_udt_id(user_id);
		int result = sfcService.insert_job_qna_question(qnaAnswer);
		
		//알림게시판에 관련정보 추가 
				if(result>0){			
					String fap_job_ad_title = sfacService.select_job_ad_title(fap_job_ad_seq);
					String fap_job_qna_question_title = sfacService.select_job_qna_question_title(qnaAnswer.getFap_job_qna_question_seq());
					String fap_admin_notice_ct = "에이전시 \'"+user_id+"\'이(가) 채용공고 \'"+fap_job_ad_title+"\' 의 질문글  \'"+ fap_job_qna_question_title+"\' 에 답변했습니다.";
					HashMap<String, Object> paramMap = new HashMap<>();
					paramMap.put("fap_admin_notice_ins_id", user_id);	 
					paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
					paramMap.put("fap_admin_notice_handle_gb","D2304");
					int adminInfo = sfacService.insert_admin_notice_info(paramMap);		
				}
		
		
		
		logger.info("FAP 에이전시 채용공고 Q&A 답변 등록 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA_MANAGEMENT + "?fap_job_ad_seq=" + fap_job_ad_seq;
	}
	
	/**
	 * @Method Name : update_job_qna_question
	 * @Date : 2019. 3. 14.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체, 채용공고 일련번호
	 * @Return : 
	 * @Method 설명 : 채용기업 채용공고 Q&A 질문 수정
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA_ANSWER_UPDATE, method = RequestMethod.POST)
	public String update_job_qna_question(SocietyFapQnaAnswer qnaAnswer, long fap_job_ad_seq, Authentication auth){
		logger.info("FAP 에이전시 채용공고 Q&A 답변 등록 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		qnaAnswer.setFap_job_qna_answer_udt_id(user_id);
		sfcService.update_job_qna_question(qnaAnswer);
		logger.info("FAP 에이전시 채용공고 Q&A 답변 등록 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_AGENCY_JOB_QNA_MANAGEMENT + "?fap_job_ad_seq=" + fap_job_ad_seq;
	}
	
	/**
	 * @Method Name : agency_roadmap_image
	 * @Date : 2019. 4. 2.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 회원 로드맵 이미지 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_ROADMAP_IMAGE, method = RequestMethod.GET)
	public String agency_roadmap_image(){
		logger.info("FAP 에이전시 로드맵 이미지 페이지 이동 시작");
		
		logger.info("FAP 에이전시 로드맵 이미지 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_ROADMAP_IMAGE;
	}
	
	/**
	 * @Method Name : agency_faq
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : 페이지번호,검색어,FAQ구분
	 * @Return : FAP 에이전시 FAQ 정보
	 * @Method 설명 : FAP 에이전시 FAQ 페이지
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_AGENCY_FAQ, method = RequestMethod.GET)
	public String agency_faq(Model model,@RequestParam(defaultValue="1") int page 
			, @RequestParam(defaultValue="") String searchText
			, @RequestParam(defaultValue="C5301") String fap_faq_gb_cd) {
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_faq_gb_cd", fap_faq_gb_cd);
		paramMap.put("searchText", searchText);
		
		int total = sfacService.fap_faq_select_list_gb_count(paramMap);
		PageNavigator navi = new PageNavigator(5, 5, page, total);
		ArrayList<HashMap<String, Object>> faqList = sfacService.fap_faq_select_list_gb(paramMap,navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("faqList", faqList);
		model.addAttribute("navi", navi);
		model.addAttribute("fap_faq_gb_cd", fap_faq_gb_cd);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_FAQ;
	}
	
	/**
	 * @Method Name : applicant_resume_print_form
	 * @Date : 2019. 4. 5.
	 * @User : 이종호
	 * @Param : 이력서 시퀀스 배열
	 * @Return : 
	 * @Method 설명 : 프린트 할 이력서 정보 조회
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_RESUME_PRINT_FORM, method = RequestMethod.POST)
	public String applicant_resume_print_form(int[] fap_resume_seq, Model model) {
		
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
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_AGENCY_APPLICANT_RESUME_PRINT_FORM;
	}
	
	
	/**
	 * @Method Name : agency_ses_user_service
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 에이전시 SES 회원서비스 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_SES_USER_SERVICE, method = RequestMethod.GET)
	public String agency_ses_user_service(){
		logger.info("FAP 에이전시 SES 회원서비스 페이지 이동 시작");
		
		logger.info("FAP 에이전시 SES 회원서비스 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_SES_USER_SERVICE;
	}
	
	/**
	 * @Method Name : agency_2020_fair_schedule
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 에이전시 2020 Fair 일정 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_2020_FAIR_SCHEDULE, method = RequestMethod.GET)
	public String agency_2020_fair_schedule(){
		logger.info("FAP 에이전시 2020 Fair 일정 페이지 이동 시작");
		
		logger.info("FAP 에이전시 2020 Fair 일정 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_2020_FAIR_SCHEDULE;
	}
	
	/**
	 * @Method Name : agency_step
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 에이전시 전형절차 페이지 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_STEP, method = RequestMethod.GET)
	public String agency_step(){
		logger.info("FAP 에이전시 전형절차 페이지 이동 시작");
		
		logger.info("FAP 에이전시 전형절차 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_STEP;
	}
	
	/**
	 * @Method Name : agency_comps_and_partners
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 에이전시 채용기업&파트너사 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_AGENCY_COMPS_AND_PARTNERS, method = RequestMethod.GET)
	public String agency_comps_and_partners(){
		logger.info("FAP 에이전시 채용기업&파트너사 페이지 이동 시작");
		
		logger.info("FAP 에이전시 채용기업&파트너사 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_AGENCY_COMPS_AND_PARTNERS;
	}

	
	
	
	
	
	
	
}
