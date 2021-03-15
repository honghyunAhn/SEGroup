/**
 * 
 */
package global.segroup.society.fap.company.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

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

import com.aracomm.changbi.user.service.MyLectureInfoService;
import com.aracomm.changbi.user.vo.GisuCategoryVO;
import com.aracomm.changbi.user.vo.UserScoreVO;
import com.google.gson.Gson;

import global.segroup.domain.AdminPager;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.User;
import global.segroup.exception.DisagreeException;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfair;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.admincompany.service.SocietyFapAdminCompanyService;
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
import global.segroup.society.fap.company.domain.SocietyFapLaJobPlan;
import global.segroup.society.fap.company.domain.SocietyFapLaJobSet;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapQnaAnswer;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScreening;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.companyroadmap.service.SocietyFapCompanyRoadmapService;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.LocaleUtil;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 채용기업 View 컨트롤러
 * 
 */

@Controller
public class SocietyFapCompanyViewController implements PathConstants {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapCompanyViewController.class);
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private SocietyFapCompanyService sfcService;
	
	@Autowired
	private SocietyFapAdminCompanyService sfacService;
	
	@Autowired
	private SocietyFapUserService sfuService;
		
	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	@Autowired
	private SocietyFapCompanyRoadmapService sfcrService;
	
	@Autowired
	private SocietyEduAdminService seaService;
	
	@Autowired
	private MyLectureInfoService mliService;
	
	private static final String FAP_JOBFAIR_SET_USE_GB = "E0000";
	
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
	
	/*
	 * @Method Name : company_security_invalidate
	 * @Date : 2018. 1. 25
	 * @User : 김홍일
	 * @Return : 에러 페이지
	 * @Method 설명 : 에러 페이지 디자인 확인 및 수정용
	 * 
	 * @RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY + "/company_dormancy_form", method = RequestMethod.GET)
	public String company_dormancy_form(Authentication auth){
		logger.debug("FAP 에러 페이지 시작");
		
		logger.debug("FAP 에러 페이지 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY + "/company_dormancy_form";
		
	}*/
	
	/**
	 * @Method Name : company_security_invalidate
	 * @Date : 2018. 12. 6
	 * @User : 이종호
	 * @Param : 세션정보
	 * @Return : 기업 로그인 페이지
	 * @Method 설명 : 현재 세션정보를 초기화 하고 기업 로그인 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_SECURITY_INVALIDATE , method = RequestMethod.GET)
	public String company_security_invalidate(HttpSession session) {
		logger.debug("FAP 기업 시큐리티 초기화 컨트롤러 시작");
		
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		
		logger.debug("FAP 기업 시큐리티 초기화 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : company_login_success
	 * @Date : 2018. 12. 6.
	 * @User : 이종호
	 * @Param : 인증 정보 객체
	 * @Return : JSP 리턴페이지(FAP 기업 로그인 성공)
	 * @Method 설명 : FAP 기업 로그인 성공시 권한별 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_LOGIN_SUCCESS, method = RequestMethod.GET)
	public String company_login_success(HttpSession session, Authentication auth){
		logger.debug("FAP 기업 로그인 성공 컨트롤러 시작");
		session.setAttribute("user_id", (String)auth.getPrincipal());
		logger.debug("FAP 기업 로그인 성공 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
		
	}
	
	/**
	 * @Method Name : company_login_form
	 * @Date : 2018. 12. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 기업 로그인 폼 페이지)
	 * @Method 설명 : FAP 기업 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_LOGIN_FORM , method = RequestMethod.GET)
	public String company_login_form(HttpSession session,Model model,Authentication auth){
		logger.debug("FAP 기업 로그인 폼 이동 컨트롤러 시작");
		
		Exception exception = (Exception)session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		
		if(auth != null) {
			//세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
		}
		
		if((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException || exception.getCause() instanceof BadCredentialsException) ){
			//휴면 계정 처리
			if(exception.getCause() instanceof DisabledException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_DORMANCY_FORM;
			}
			//탈퇴 계정 처리
			else if(exception.getCause() instanceof AccountExpiredException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_EXPIRED_FORM;
			}
			//정지 계정 처리
			else if(exception.getCause() instanceof LockedException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_LOCKED_FORM;
			}
			//약관 미동의
			else if(exception.getCause() instanceof DisagreeException){
				model.addAttribute("user_id", ((DisagreeException)exception.getCause()).getId());
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_TERMS_AND_CONDITION;
			}
			
		}
		
		logger.debug("FAP 기업 로그인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_LOGIN_FORM;
	}

	/**
	 * @Method Name : company_access_denied
	 * @Date : 2018. 12. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 기업 접근 제한 페이지)
	 * @Method 설명 : FAP 기업 접근 제한 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ACCESS_DENIED , method = RequestMethod.GET)
	public String company_access_denied() {
		logger.debug("FAP 기업 접근권한 제한 컨트롤러 시작");
		
		logger.debug("FAP 기업 접근권한 제한 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_ACCESS_DENIED;
	}
	
	/**
	 * @Method Name : company_insert_from
	 * @Date : 2018. 12. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 기업 회원가입)
	 * @Method 설명 : FAP 기업 회원가입 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_INSERT_FORM, method = RequestMethod.GET)
	public String company_insert_from(){
		logger.debug("FAP 기업 회원가입 이동 컨트롤러 시작");
		logger.debug("FAP 기업 회원가입 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_INSERT_FORM;
	}
	
	/**
	 * @Method Name : company_insert_form
	 * @Date : 2018. 12. 11.
	 * @User : 김준영
	 * @Param : 공통 유저, 회사 유저
	 * @Return : 회원가입 후 기업 로그인 페이지로 이동 
	 * @Method 설명 : FAP 기업 회원가입 후 로그인 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_INSERT_FORM, method = RequestMethod.POST)
	public String company_insert_form(Model model, String company_ck, User user, 
			SocietyFapCompanyUser societyFapCompanyUser, 
			SocietyFapCompanyUserConnect societyFapCompanyUserConnect){
		logger.info("FAP 기업 회원 등록 컨트롤러 시작");
		// 비밀번호 암호화
		String encodedPw = passwordEncoder.encode(user.getUser_pw());
		user.setUser_pw(encodedPw);
		sfcService.insert_company(company_ck, user, societyFapCompanyUser, societyFapCompanyUserConnect);
		logger.info("FAP 기업 회원 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_INSERT_COMPLETE;
	}
	
	/**
	 * @Method Name : company_insert_complete
	 * @Date : 2019. 02. 13.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 회원 가입 완료 폼으로 이동 
	 * @Method 설명 : FAP 기업 회원가입 완료 폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_INSERT_COMPLETE, method = RequestMethod.GET)
	public String company_insert_complete(){
		logger.info("FAP 기업 회원 등록 완료 폼 컨트롤러 시작");
		logger.info("FAP 기업 회원 등록 완료 폼 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_INSERT_COMPLETE;
	}
	
	
	/**
	 * @Method Name : company_update_form
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회사 정보 수정폼)
	 * @Method 설명 : 유저 아이디가 가지고 있는 회사 정보를 가지고 수정폼으로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMPANY_UDDATE_FORM, method = RequestMethod.GET)
	public String company_update_form(Model model, Authentication auth){
		logger.info("회사 정보 수정폼 이동 컨트롤러 시작");
		// 아이디가 가지고 있는 회사 정보 가져오기(업데이트 전 정보)
		Gson gson = new Gson();
		SocietyFapCompanyUser company_info = sfcService.select_company((String)auth.getPrincipal());
		
		String info_json = gson.toJson(company_info);
		String replace_json = info_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		model.addAttribute("company_info", replace_json);
		logger.info("회사 정보 수정폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_COMPANY_UDDATE_FORM;
	}
	
	/**
	 * @Method Name : company_update_form
	 * @Date : 2018. 12. 13.
	 * @User : 김준영
	 * @Param : 회사 정보 객체
	 * @Return : JSP 리턴페이지(FAP 회사 메인 페이지)
	 * @Method 설명 : 회사 정보를 수정한 후 메인 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMPANY_UDDATE_FORM, method = RequestMethod.POST)
	public String company_update_form(Model model, Authentication auth, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("회사 정보 수정 컨트롤러 시작");
		societyFapCompanyUser.setFap_comp_udt_id((String)auth.getPrincipal());
		sfcService.update_company(societyFapCompanyUser);
		System.out.println("dd -----> " + societyFapCompanyUser.getFap_comp_log_saved());
		logger.info("회사 정보 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
	}
	
	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회사 담당자 정보 수정 페이지)
	 * @Method 설명 : 회사 담당자 정보 수정 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMPANY_USER_UPDATE_FORM, method = RequestMethod.GET)
	public String user_update_form(Model model, Authentication auth){
		logger.info("회사 담당자 수정폼 이동 컨트롤러 시작");
		User user = sfcService.select_user((String)auth.getPrincipal());
		model.addAttribute("company_user", user);
		logger.info("회사 담당자 수정폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_COMPANY_USER_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 12. 17.
	 * @User : 김준영
	 * @Param : 공통 유저 객체
	 * @Return : JSP 리턴페이지(FAP 회사 담당자 정보 수정 페이지)
	 * @Method 설명 : 회사 담당자 정보를 수정한 후 메인 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMPANY_USER_UPDATE_FORM, method = RequestMethod.POST)
	public String user_update_form(User user, Authentication auth){
		logger.info("회사 담당자 수정 시작");
		// 비밀번호 변경시 암호화; 입력 하지 않을 경우는 변경 되지 않음
		if(!user.getUser_pw().equals("")){
			String encodedPw = passwordEncoder.encode(user.getUser_pw());
			user.setUser_pw(encodedPw);
		}
		user.setUser_udt_id((String)auth.getPrincipal());
		sfcService.update_user(user);
		logger.info("회사 담당자 수정 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
	}
	
	/**
	 * @Method Name : company_forgot_id
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 아이디 찾기)
	 * @Method 설명 : 기업 유저 아이디 찾기 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_FORGOT_ID, method = RequestMethod.GET)
	public String company_forgot_id(){
		logger.info("FAP 기업 유저 아이디 찾기 이동 컨트톨러 시작");
		
		logger.info("FAP 기업 유저 아이디 찾기 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_FORGOT_ID;
	}
	
	/**
	 * @Method Name : company_forgot_id_result
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 아이디 찾기 결과 페이지)
	 * @Method 설명 : 기업 유저 아이디 찾은 후 결과 페이지로 이동 후 아이디를 보여주는 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_FORGOT_ID_RESULT, method = RequestMethod.GET)
	public String company_forgot_id_result(HttpSession session, Model model) throws Exception{
		logger.info("FAP 기업 유저 아이디 찾기 결과 이동 컨트톨러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");

		User user = new User();
		user.setUser_id(user_id);

		String found_id = sfcService.user_forgot_id(user);

		// 찾은 데이터를 모델에 담아서 보냄
		model.addAttribute("found", found_id);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");
		
		
		logger.info("FAP 기업 유저 아이디 찾기 결과 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_FORGOT_ID_RESULT;
	}
	
	/**
	 * @Method Name : jobfair_participation
	 * @Date : 2018. 12. 24.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : JSP 리턴페이지(FAP 회사 잡페어 참가 페이지)
	 * @Method 설명 : 선택한 잡페어 정보를 검색 후 잡페어 참가 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOBFAIR_PARTICIPATION, method = RequestMethod.GET)
	public String jobfair_participation(Model model, Authentication auth, int fap_jobfair_seq){
		logger.info("회사 잡페어 참가폼 이동 컨트롤러 시작");
		
		//회사 아이디 발급 여부 확인
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id_ck = sfcService.select_fap_comp_id(user_id);
		if(fap_comp_id_ck == null){
			model.addAttribute("fap_comp_id_ck", "신청 대상이 아닙니다.");
		}
		
		//노출허용 된 선택 잡페어 세부정보 검색
		ArrayList<HashMap<String, Object>> jobfair_divide_search_list = sfcService.jobfair_divide_search_list(fap_jobfair_seq);
		model.addAttribute("jobfairDivideList", jobfair_divide_search_list);
		
		//잡페어 로고 경로 설정
		String path = fapAdminJobfairLogoImage+"/";
		model.addAttribute("path", path);
		
		//회사잡페어 등록정보 검색
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_seq", fap_jobfair_seq);
		hashmap.put("fap_comp_id", fap_comp_id_ck);
		ArrayList<HashMap<String, Object>> select_company_jobfair_participation_list = sfcService.select_company_jobfair_participation(hashmap);
		model.addAttribute("participationInfo", select_company_jobfair_participation_list);
		
		logger.info("회사 잡페어 참가폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_JOBFAIR_PARTICIPATION_FORM;
	}
	
	/**
	 * @Method Name : company_forgot_password
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(기업 담당자 비밀번호 찾기)
	 * @Method 설명 : 기업 담당자 비밀번호 찾기 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_FORGOT_PASSWORD, method = RequestMethod.GET)
	public String company_forgot_password(){
		logger.info("FAP 기업 담당자 비밀번호 찾기 이동 컨트톨러 시작");
		
		logger.info("FAP 기업 담당자 비밀번호 찾기 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_FORGOT_PASSWORD;
	}
	
	/**
	 * @Method Name : company_forgot_password_form
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 
	 * @Return : JSP 리턴페이지(기업 담당자 비밀번호 찾기)
	 * @Method 설명 : 기업 담당자 비밀번호 찾기 폼 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_FORGOT_PASSWORD_FORM, method = RequestMethod.GET)
	public String company_forgot_password_form(HttpSession session) throws Exception{
		logger.info("FAP 기업 담당자 비밀번호 찾기 폼 이동 컨트톨러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			throw new Exception();
		}
		
		logger.info("FAP 기업 담당자 비밀번호 찾기 폼 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_FORGOT_PASSWORD_FORM;
	}
	
	/**
	 * @Method Name : company_forgot_password_change
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 기업 담당자 비밀번호
	 * @Return : JSP 리턴페이지(기업 메인)
	 * @Method 설명 : 기업 담당자가 입력한 비밀번호로 비밀번호를 변경함
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_FORGOT_PASSWORD_CHANGE, method = RequestMethod.POST)
	public String company_forgot_password_change(HttpSession session, Model model, String user_pw) throws Exception{
		logger.debug("FAP 기업 담당자 비밀번호 변경 컨트롤러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}
		String user_id = (String) session.getAttribute("user_id");

		boolean canChange = sfcService.company_forgot_password(user_id, user_pw);
		model.addAttribute("canChange", canChange);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");
		logger.debug("FAP 기업 담당자 비밀번호 변경 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_FORGOT_PASSWORD_RESULT;
	}
	
	/**
	 * @Method Name : delete_company_user_info_form
	 * @Date : 2019. 1. 31.
	 * @User : 정대영
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 회원 탈퇴페이지로 이동 요청 메소드
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_USER_INFO_DELETE_FORM, method = RequestMethod.GET)
	public String delete_user_info_form(){
		logger.info("FAP 기업 담당자 탈퇴 폼으로 이동 컨트롤러 시작");
		logger.info("FAP 기업 담당자 탈퇴 폼으로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_USER_INFO_DELETE_FORM;
	}
	

	/**
	 * @Method Name : company_required_doc_management
	 * @Date : 2018. 12. 31.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회사 내정서류 관리 페이지)
	 * @Method 설명 : 회사 내정서류 관리 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT, method = RequestMethod.GET)
	public String company_required_doc_management(Model model, Authentication auth, HttpSession session){
		logger.info("회사 내정서류 관리폼 이동 컨트롤러 시작");
		
		SocietyFapCompanyUser company_info = sfcService.select_company((String)auth.getPrincipal());
		SocietyFapJobAd job_ad = new SocietyFapJobAd();
		job_ad.setFap_comp_id(company_info.getFap_comp_id());
		ArrayList<SocietyFapJobAd> company_job_ad_list = sfcService.search_company_job_ad_list(job_ad);
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcService.search_company_jobfair_list(company_info.getFap_comp_id());
		model.addAttribute("company_info", company_info);
		model.addAttribute("company_job_ad_list", company_job_ad_list);
		model.addAttribute("company_jobfair_list", company_jobfair_list);
		
		session.removeAttribute("fap_ad_seq");
		session.removeAttribute("fap_divide_seq");	
		if(session.getAttribute("fap_ad_seq2") != null){
			session.setAttribute("fap_ad_seq", session.getAttribute("fap_ad_seq2"));
			session.removeAttribute("fap_ad_seq2");
		}
		if(session.getAttribute("fap_divide_seq2") != null){
			session.setAttribute("fap_divide_seq", session.getAttribute("fap_divide_seq2"));
			session.removeAttribute("fap_divide_seq2");
		}
		
		logger.info("회사 내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : management_connect_request
	 * @Date : 2018. 12. 31.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 연결 요청 관리 페이지)
	 * @Method 설명 : 에이전시가 보낸 연결 요청을 관리하는 페이지
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_MANAGEMENT_CONNECT_REQUEST, method = RequestMethod.GET)
	public String management_connect_request(Model model, Authentication auth){
		logger.info("FAP 에이전시 연결 요청 관리 페이지 이동 컨트롤러 시작");
		
		ArrayList<SocietyFapCompanyUser> agency_list = sfcService.select_connect_request((String)auth.getPrincipal());
		model.addAttribute("agency_list", agency_list);
		
		logger.info("FAP 에이전시 연결 요청 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_MANAGEMENT_CONNECT_REQUEST;
	}

	/**
	 * @Method Name : common_required_doc_insert
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 회사가 등록한 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 회사 내정서류 관리 페이지)
	 * @Method 설명 : 회사 내정서류 등록 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String insert_common_required_doc(Model model, Authentication auth, SocietyFapCommonRequiredDoc common_required_doc, RedirectAttributes redirect){
		logger.info("회사 내정서류 등록 컨트롤러 시작");
		
		common_required_doc.setFap_common_required_doc_ins_id((String)auth.getPrincipal());
		common_required_doc.setFap_common_required_doc_udt_id((String)auth.getPrincipal());
		int result = sfcService.insert_common_required_doc(common_required_doc);
		
		//알림게시판에 관련정보 입력 
		if(result>0){
			String fap_comp_id = common_required_doc.getFap_comp_id(); 
			HashMap<String,Object> compNms= sfacService.select_comp_nm(fap_comp_id);		 
			String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
			String fap_job_ad_title = sfaService.select_job_ad_title(common_required_doc.getFap_job_ad_seq());
			String fap_admin_notice_ct = "기업 \'"+fap_comp_en_nm+"\'가 채용공고  \'"+fap_job_ad_title+"\' 의 공통 내정서류를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_comp_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2306");
			int adminInfo = sfaService.insert_admin_notice_info(paramMap);
		}
			 
		redirect.addAttribute("fap_job_ad_seq", common_required_doc.getFap_job_ad_seq());
		redirect.addAttribute("fap_jobfair_seq", common_required_doc.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", common_required_doc.getFap_jobfair_divide_seq());
		logger.info("회사 내정서류 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : common_required_doc_delete
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 회사가 등록한 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 회사 내정서류 관리 페이지)
	 * @Method 설명 : 회사 내정서류 삭제 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_DELETE, method = RequestMethod.GET)
	public String delete_common_required_doc(Model model, SocietyFapCommonRequiredDoc common_required_doc, RedirectAttributes redirect){
		logger.info("회사 내정서류 삭제 컨트롤러 시작");
		
		sfcService.delete_common_required_doc(common_required_doc);
		redirect.addAttribute("fap_job_ad_seq", common_required_doc.getFap_job_ad_seq());
		redirect.addAttribute("fap_jobfair_seq", common_required_doc.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", common_required_doc.getFap_jobfair_divide_seq());
		
		logger.info("회사 내정서류 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : common_required_doc_update
	 * @Date : 2019. 1. 2.
	 * @User : 신동철
	 * @Param : 회사가 등록한 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 회사 내정서류 관리 페이지)
	 * @Method 설명 : 회사 내정서류 수정 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMMON_REQUIRED_DOC_UPDATE, method = RequestMethod.POST)
	public String update_common_required_doc(Model model, Authentication auth, SocietyFapCommonRequiredDoc common_required_doc, RedirectAttributes redirect){
		logger.info("회사 내정서류 수정 컨트롤러 시작");
		
		common_required_doc.setFap_common_required_doc_udt_id((String)auth.getPrincipal());
		sfcService.update_common_required_doc(common_required_doc);
		redirect.addAttribute("fap_job_ad_seq", common_required_doc.getFap_job_ad_seq());
		redirect.addAttribute("fap_jobfair_seq", common_required_doc.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", common_required_doc.getFap_jobfair_divide_seq());
		
		logger.info("회사 내정서류 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : company_required_doc_management_form
	 * @Date : 2018. 12. 31.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회사 내정서류 관리 페이지)
	 * @Method 설명 : 회사 내정서류 관리 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT_FORM, method = RequestMethod.GET)
	public String company_required_doc_management_form(Model model, Authentication auth, HttpSession session, @RequestParam("fap_job_ad_seq") long fap_job_ad_seq
			,@RequestParam("fap_jobfair_seq") int fap_jobfair_seq, @RequestParam("fap_jobfair_divide_seq") int fap_jobfair_divide_seq){
		logger.info("회사 내정서류 관리폼 이동 컨트롤러 시작");
		
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
		
		logger.info("회사 내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : algorithm_calender_setting_form
	 * @Date : 2019. 1. 7.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 회사 현지잡페어 달력 폼 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_FORM, method = RequestMethod.GET)
	public String algorithm_calendar_setting_form(Model model, int fap_jobfair_divide_seq , long fap_job_ad_seq){
		logger.info("회사 현지잡페어 달력 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		params.put("fap_jobfair_set_gb", FAP_JOBFAIR_SET_USE_GB);
		
		Gson gson = new Gson();
		
		HashMap<String, Object> result = sfcService.algorithm_jobfair_setting_use_search(params);
		
		//승인된 시간설정 값이 없을 경우
		if(result == null) {
			//페이지 연결했을때 처리 추가 해야함.
			return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
		}
		
		HashMap<String, Object> companyResult = sfcService.algorithm_company_setting_search(fap_job_ad_seq);

		//기존에 시간설정한 정보가 있을 경우
		if(companyResult != null) {
			model.addAttribute("companyResult", gson.toJson(companyResult));
			return "forward:"+PathConstants.SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_UPDATE_FORM;
		}
		
		model.addAttribute("result", gson.toJson(result));
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		
		logger.info("회사 현지잡페어 달력 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_FORM;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_UPDATE_FORM, method = RequestMethod.GET)
	public String algorithm_calendar_setting_update_form(Model model) {
		
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : algorithm_calendar_setting_insert
	 * @Date : 2019. 1. 10.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 회사 현지잡페어 달력 등록
	 */	
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_INSERT, method = RequestMethod.POST)
	public String algorithm_calendar_setting_insert(Model model, SocietyFapLaJobSet jobSet , SocietyFapLaJobPlan jobPlan, Authentication auth) {
		
		jobSet.setFap_la_job_set_ins_id((String)auth.getPrincipal());
		jobSet.setFap_la_job_set_udt_id((String)auth.getPrincipal());
		
		for(SocietyFapLaJobPlan plan : jobPlan.getSetTimeList()) {
			plan.setFap_la_job_plan_ins_id((String)auth.getPrincipal());
			plan.setFap_la_job_plan_udt_id((String)auth.getPrincipal());
		}
		
		sfcService.algorithm_calendar_setting_insert(jobSet, jobPlan);
		
		
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
	}
	
	/**
	 * @Method Name : algorithm_calendar_setting_update
	 * @Date : 2019. 1. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 회사 현지잡페어 달력 수정
	 */	
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ALGORITHM_CALENDAR_SETTING_UPDATE, method = RequestMethod.POST)
	public String algorithm_calendar_setting_update(Model model, SocietyFapLaJobSet jobSet , SocietyFapLaJobPlan jobPlan, Authentication auth) {
		
		jobSet.setFap_la_job_set_ins_id((String)auth.getPrincipal());
		jobSet.setFap_la_job_set_udt_id((String)auth.getPrincipal());
		
		for(SocietyFapLaJobPlan plan : jobPlan.getSetTimeList()) {
			plan.setFap_la_job_plan_ins_id((String)auth.getPrincipal());
			plan.setFap_la_job_plan_udt_id((String)auth.getPrincipal());
		}
		
		sfcService.algorithm_calendar_setting_update(jobSet, jobPlan);
		
		
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
	}
	
	/**
	 * @Method Name : company_personal_required_doc_management
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 리턴페이지(FAP 회사 개인내정서류 관리 페이지)
	 * @Method 설명 : 회사 개인내정서류 관리 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT, method = RequestMethod.GET)
	public String company_personal_required_doc_management(Model model, HttpSession session, Authentication auth, long fap_nominee_seq){
		logger.info("회사 개인내정서류 관리폼 이동 컨트롤러 시작");
		
		SocietyFapNominee nominee_info = sfcService.select_nominee_info(fap_nominee_seq);
		model.addAttribute("nominee_info", nominee_info);
		session.setAttribute("fap_ad_seq2", nominee_info.getFap_job_ad_seq());
		session.setAttribute("fap_divide_seq2", nominee_info.getFap_jobfair_divide_seq());
		
		logger.info("회사 개인내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : persoanl_required_doc_insert
	 * @Date : 2019. 1. 1.
	 * @User : 신동철
	 * @Param : 등록할 개인 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 개인 내정서류 관리 페이지)
	 * @Method 설명 : 개인 내정서류 등록 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String insert_personal_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("개인 내정서류 등록 컨트롤러 시작");
		
		String fap_comp_id = sfcService.select_fap_comp_id((String)auth.getPrincipal());
		personal_required_doc.setFap_personal_required_doc_ins_id(fap_comp_id);
		personal_required_doc.setFap_personal_required_doc_udt_id(fap_comp_id);
		int result = sfcService.insert_personal_required_doc(personal_required_doc);
		
		   //알림게시판에 관련정보 입력 
			if(result>0){				
				HashMap<String,Object> compNms= sfacService.select_comp_nm(fap_comp_id);		 
				String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
				String fap_job_ad_title = sfaService.select_job_ad_title(personal_required_doc.getFap_job_ad_seq());
				String fap_admin_notice_ct = "기업 \'"+fap_comp_en_nm+"\'가 채용공고  \'"+fap_job_ad_title+"\' 의 개인 내정서류를 등록했습니다.";
				HashMap<String, Object> paramMap = new HashMap<>();
				paramMap.put("fap_admin_notice_ins_id", fap_comp_id);	 
				paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
				paramMap.put("fap_admin_notice_handle_gb","D2306");
				int adminInfo = sfaService.insert_admin_notice_info(paramMap);
			}
				
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("개인 내정서류 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : company_personal_required_doc_management_form
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 리턴페이지(FAP 회사 개인내정서류 관리폼)
	 * @Method 설명 : 회사 개인내정서류 관리폼으로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM, method = RequestMethod.GET)
	public String company_personal_required_doc_management_form(Model model, Authentication auth, @RequestParam("param") long fap_nominee_seq, RedirectAttributes redirect){
		logger.info("회사 개인내정서류 관리폼 이동 컨트롤러 시작");
		
		SocietyFapNominee nominee_info = sfcService.select_nominee_info(fap_nominee_seq);
		model.addAttribute("nominee_info", nominee_info);
		model.addAttribute("fap_jobfair_seq", nominee_info.getFap_jobfair_seq());
		model.addAttribute("fap_jobfair_divide_seq", nominee_info.getFap_jobfair_divide_seq());
		model.addAttribute("fap_job_ad_seq", nominee_info.getFap_job_ad_seq());
		model.addAttribute("fap_comp_id", nominee_info.getFap_comp_id());
		
		logger.info("회사 개인내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_update
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 개인 내정서류 관리 페이지)
	 * @Method 설명 : 개인 내정서류 수정 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_UPDATE, method = RequestMethod.POST)
	public String update_personal_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("개인 내정서류 수정 컨트롤러 시작");
		
		personal_required_doc.setFap_personal_required_doc_udt_id((String)auth.getPrincipal());
		sfcService.update_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("개인 내정서류 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_delete
	 * @Date : 2019. 1. 7.
	 * @User : 신동철
	 * @Param : 개인 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 개인 내정서류 관리 페이지)
	 * @Method 설명 : 개인 내정서류 삭제 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_DELETE, method = RequestMethod.GET)
	public String personal_required_doc_delete(Model model, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("개인 내정서류 삭제 컨트롤러 시작");
		
		sfcService.delete_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("개인 내정서류 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : company_info_insert_form
	 * @Date : 2019. 1. 10.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(기업 정보 입력 페이지) 
	 * @Method 설명 : 기업 정보 입력 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_INFO_INSERT, method = RequestMethod.GET)
	public String company_info_insert_form(){
		logger.info("FAP 기업 담당자 - 기업 정보 입력 폼 이동 컨트롤러 시작");
		
		logger.info("FAP 기업 담당자 - 기업 정보 입력 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_INFO_INSERT;
	}
	
	/**
	 * @Method Name : company_info_insert
	 * @Date : 2019. 1. 10.
	 * @User : 김준영
	 * @Param : 
	 * @Return : JSP 리턴페이지(기업 메인 입력 페이지) 
	 * @Method 설명 : 기업 정보를 입력 한 후 메인 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_INFO_INSERT, method = RequestMethod.POST)
	public String company_info_insert(Authentication auth, SocietyFapCompanyUser company_info){
		logger.info("FAP 기업 담당자 - 기업 정보 입력 시작");
		String company_id = ((company_info.getFap_comp_en_nm()).replaceAll(" ","")) + "@_@" + (String) auth.getPrincipal();
		company_info.setFap_comp_id(company_id);
		sfcService.user_company_info_insert(auth, company_info);
		logger.info("FAP 기업 담당자 - 기업 정보 입력 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_LOGIN_SUCCESS;
	}
	
	/**
	 * @Method Name : company_job_ad_management
	 * @Date : 2019. 1. 10.
	 * @User : 이재준
	 * @Param : -
	 * @Return : 채용공고 관리페이지 JSP
	 * @Method 설명 : 채용공고 관리페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_MANAGEMENT, method = RequestMethod.GET)
	public String company_job_ad_management(Model model, Authentication auth, SocietyFapJobAd JobAd
			, @RequestParam(defaultValue="0") int fap_jobfair_seq, @RequestParam(defaultValue="0") int fap_jobfair_divide_seq){
		logger.debug("채용공고 관리페이지 이동 시작");
		
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		Gson gson = new Gson();
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		//잡페어 리스트 담은 map (key : jobfair_list_now, jobfair_list_before,jobfair_list_after)
		HashMap<String, Object> jobfair_map = new HashMap<String, Object>();
		jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", gson.toJson(jobfair_map));
		
		logger.debug("채용공고 관리페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_JOB_AD_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_job_ad_insert_form
	 * @Date : 2019. 1. 10.
	 * @User : 이재준, 정대영
	 * @Param : -
	 * @Return : 채용공고 등록 JSP
	 * @Method 설명 : 채용공고 등록페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_INSERT_FORM, method = RequestMethod.POST)
	public String company_job_ad_insert_form(int fap_jobfair_seq, int fap_jobfair_divide_seq, Model model, Authentication auth){
		logger.debug("채용공고 등록페이지 이동 시작");
		
		String user_id = (String) auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_comp_id", fap_comp_id);
		paramMap.put("fap_jobfair_seq", fap_jobfair_seq);
		
		int adTotalCount = sfcService.select_job_ad_load_list_count(paramMap);
		if(adTotalCount == 0){adTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(5, 5, 1, adTotalCount);
		int jobAdLoadNum = adTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfcService.select_job_ad_load_list_paging(paramMap, repNavi.getStartRecord(), repNavi.getCountPerPage());
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		Gson gson = new Gson();
		SocietyFapCompanyUser comp_info = sfcService.select_company(user_id);
		model.addAttribute("comp_info", gson.toJson(comp_info));
		model.addAttribute("select_job_ad_load_list", select_job_ad_load_list);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("jobAdLoadNum", jobAdLoadNum);
		
		logger.debug("채용공고 등록페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_JOB_AD_INSERT_FORM;
	}
	
	/**
	 * @Method Name : company_job_ad_insert
	 * @Date : 2019. 1. 11.
	 * @User : 이재준
	 * @Param : 채용공고 객체
	 * @Return : JSP 등록폼
	 * @Method 설명 : -
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_INSERT, method=RequestMethod.POST)
	public String company_job_ad_insert(SocietyFapJobAd JobAd, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee
			, SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp,
			SocietyFapJobFile JobFile, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt,
			SocietyFapJobWork JobWork, SocietyFapJobCategory JobCategory
			, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace, SocietyFapJobRecruitPcs JobRecruitPcs,
			SocietyFapJobPay JobPay, Authentication auth, int fap_jobfair_seq, int fap_jobfair_divide_seq, Model model){
			logger.debug("FAP 기업 채용공고 등록 시작");
			
			logger.info("fap_jobfair_state!!! : {}", JobAd.getFap_job_ad_state());
			
			model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
			model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
								
			sfcService.job_ad_insert2(JobAd, JobDorm, JobJitEmployee, JobJaLevel, JobTrial, JobComp, JobFile, JobIsr, JobJoinDt
					, JobWork, JobCategory, JobPref, JobWorkplace, JobRecruitPcs, JobPay);
			
			logger.debug("FAP 기업 채용공고 등록 끝");
			return "redirect:" + SOCIETY_FAP_COMPANY_JOB_AD_MANAGEMENT;
			
		}

	/**
	 * @Method Name : company_job_ad_update_form
	 * @Date : 2019. 1. 11.
	 * @User : 이재준
	 * @Param : 채용공고 시퀀스
	 * @Return : JSP 채용공고 등록폼
	 * @Method 설명 : 해당 채용공고의 수정폼으로 이동하는 method
	 */
	// 수정!해야됨!
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_UPDATE_FORM, method=RequestMethod.GET)
	public String company_job_ad_update_form(Model model, Authentication auth, 
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
		
		//model.addAttribute("job_exam_file_path", fapJobRecruitExamFile);
		model.addAttribute("job_exam_file_path", "/fap/company/job_recruit_exam_file");
		
		logger.debug("FAP ");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : company_process_schedule_calendar
	 * @Date : 2019. 1. 15.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(채용기업 전형일정 캘린더 페이지)
	 * @Method 설명 : 채용기업 전형일정 캘린더 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_PROCESS_SCHEDULE_CALENDAR, method = RequestMethod.GET)
	public String company_process_schedule_calendar(Model model, Authentication auth){
		logger.info("채용기업 전형일정 캘린더 이동 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		
		if(fap_comp_id == null){
			return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
		}		
		ArrayList<HashMap<String, Object>>company_jobfair_list = sfcService.search_company_jobfair_list(fap_comp_id);
		model.addAttribute("jobfair_list", company_jobfair_list);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		logger.info("채용기업 전형일정 캘린더 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : company_job_ad_update
	 * @Date : 2019. 1. 15.
	 * @User : 김준영
	 * @Param : 
	 * @Return : JSP 리턴페이지()
	 * @Method 설명 : 채용공고를 수정하는 함수
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_UPDATE, method = RequestMethod.POST)
	public String company_job_ad_update(Model model, Authentication auth, 
			@RequestParam(defaultValue="") ArrayList<Long> fap_job_recruit_pcs_seq_list, SocietyFapJobRecruitPcs JobRecruitPcs,
			SocietyFapJobAd JobAd, int fap_jobfair_divide_seq, int fap_jobfair_seq
			, SocietyFapJobDorm JobDorm, SocietyFapJobJitEmployee JobJitEmployee
			, SocietyFapJobJaLevel JobJaLevel, SocietyFapJobTrial JobTrial, SocietyFapJobComp JobComp,
			SocietyFapJobFile JobFile, SocietyFapJobIsr JobIsr, SocietyFapJobJoinDt JobJoinDt,
			SocietyFapJobWork JobWork, SocietyFapJobCategory JobCategory
			, SocietyFapJobPref JobPref, SocietyFapJobWorkplace JobWorkplace, SocietyFapJobPay JobPay){
		logger.info("채용공고를 수정 컨트롤러 시작");
				
		// 채용공고, 채용전형 수정		
		long job_ad_parent_insert_seq = sfcService.job_ad_parent_update(fap_job_recruit_pcs_seq_list, JobAd, JobRecruitPcs);		
		String fap_comp_id = sfcService.select_fap_comp_id((String)auth.getPrincipal());
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		
		JobAd.setFap_comp_id(fap_comp_id);
		JobAd.setFap_job_ad_seq(job_ad_parent_insert_seq);
		
		sfcService.delete_job_ad(job_ad_parent_insert_seq);
		sfcService.job_ad_children_insert(JobAd, JobDorm, JobJitEmployee, JobJaLevel, JobTrial, JobComp, JobFile, JobIsr, JobJoinDt, JobWork, JobCategory, JobPref, JobWorkplace, JobPay);

		logger.info("채용공고를 수정 컨트롤러 종료");
		return "redirect:" + SOCIETY_FAP_COMPANY_JOB_AD_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_language_change
	 * @Date : 2019. 1. 17.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 기업 메인 페이지
	 * @Method 설명 : 기업 언어 변경 요청
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_LANGUAGE_CHANGE, method = RequestMethod.GET)
	public String company_language_change(String lo,HttpServletRequest request , HttpServletResponse response) {
		
		LocaleUtil.setLocale(request, response, lo);
		
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_MAIN;
	}
		
	/**
	 * @Method Name : board_contents_detail
	 * @Date : 2019. 1. 23.
	 * @User : 신동철
	 * @Param : 게시판 세부내용 시퀀스, 게시판 구분, 게시판 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용)
	 * @Method 설명 : 잡페어 공지사항 게시판 세부내용 검색
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_BOARD_CONTENTS_DETAIL, method = RequestMethod.GET)
	public String board_contents_detail(int board_content_seq, Model model, BoardGroup boardGroup
			, String board_detail_gb){
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 시작");
	
		//조회수 증가
		sfcService.board_contents_hit_update(board_content_seq);
		//조회
		HashMap<String, Object> resultMap = sfcService.board_contents_detail(board_content_seq);
		resultMap.put("board_detail_gb", board_detail_gb);
		// String path = seaService.findPath(boardGroup.getBoard_gb(), boardGroup.getBoard_tp());
		model.addAttribute("contentDetail", resultMap);
		// model.addAttribute("path", path);
		
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_BOARD_CONTENTS_DETAIL_FORM;
	}
	

	/**
	 * @Method Name : company_board_content_list
	 * @Date : 2019. 1. 24.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(공지사항 게시판 리스트)
	 * @Method 설명 : 잡페어 공지사항 리스트 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_BOARD_CONTENT_LIST, method = RequestMethod.GET)
	public String company_board_content_list(Model model, BoardGroup boardGroup, String board_detail_gb, String board
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
		 String board_nm = sfcService.select_comp_name(board_detail_gb);
		 map.put("board_nm",board_nm);
		 
		 model.addAttribute("resultList", resultList);
		 model.addAttribute("map", map);
		 model.addAttribute("boardGroup", boardGroup);
		
		 
		logger.debug("잡페어 공지사항 리스트 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_BOARD_CONTENT_LIST;
	}
	
	/**
	 * @Method Name : company_jobfair_apply_to_attend_form
	 * @Date : 2019. 1. 24.
	 * @User : 정대영
	 * @Param : -
	 * @Return : JSP 리턴페이지(회사 잡페어 신청 페이지)
	 * @Method 설명 : FAP 회사 잡페어 신청 페이지 이동 요청
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOBFAIR_APPLY_TO_ATTEND_FORM, method = RequestMethod.GET)
	public String company_jobfair_apply_to_attend_form(){
		logger.info("FAP 회사 잡페어 신청 페이지 이동 컨트롤러 시작");
		logger.info("FAP 회사 잡페어 신청 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_JOBFAIR_APPLY_TO_ATTEND_FORM;
	}
	
	/**
	 * @Method Name : company_mypage
	 * @Date : 2019. 1. 25.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(기업 마이페이지)
	 * @Method 설명 : 기업 마이페이지로 이동하는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_MYPAGE, method = RequestMethod.GET)
	public String company_mypage(){
		logger.info("FAP 기업 마이페이지 이동 컨트롤러 시작");
		logger.info("FAP 기업 마이페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_MYPAGE;
	}
	
	/**
	 * @Method Name : company_connect_request_management
	 * @Date : 2019. 1. 25.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(담당자 - 기업연결 관리 페이지)
	 * @Method 설명 : 담당자 - 기업연결 관리 페이지로 이동하는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_CONNECT_REQUEST_MANAGEMENT, method = RequestMethod.GET)
	public String company_connect_request_management(Model model, Authentication auth){
		logger.info("FAP 담당자 - 기업 연결 페이지 이동 컨트롤러 시작");
		/*
		ArrayList<SocietyFapCompanyUser> comp_list = new ArrayList<>();
		SocietyFapCompanyUserConnect comp_user_connect = sfcService.select_comp_user_connect((String)auth.getPrincipal());
		HashMap<String, Object> connect_info = new HashMap<>();
		if(comp_user_connect == null){
			comp_list = sfcService.select_common_company();
			connect_info.put("check_connect", "non_exist");
			connect_info.put("comp_list", comp_list);
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3800")){ 
			connect_info.put("check_connect", "exist");
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3801")){
			connect_info.put("check_connect", "standBy");
			// 해당 하는 기업 뿌려주기
			SocietyFapCompanyUser standBy_company = sfcService.select_company((String)auth.getPrincipal());
			connect_info.put("comp_user_connect", comp_user_connect);
			comp_list.add(standBy_company);
			connect_info.put("comp_list", comp_list);
		} else if(comp_user_connect.getFap_comp_user_connect_ck().equals("B3802")){
			connect_info.put("check_connect", "refusal");
			// 해당 하는 기업 뿌려주기
			SocietyFapCompanyUser refusal_company = sfcService.select_company((String)auth.getPrincipal());
			connect_info.put("comp_user_connect", comp_user_connect);
			comp_list.add(refusal_company);
			connect_info.put("comp_list", comp_list);
		}
		
		Gson gson = new Gson();
		model.addAttribute("connect_info", gson.toJson(connect_info));
		*/
		
		ArrayList<SocietyFapCompUserConnectRequest> CompUserConnectRequest = sfcService.select_comp_user_connect_request((String)auth.getPrincipal());
		model.addAttribute("CompUserConnectRequest", CompUserConnectRequest);
		
		logger.info("FAP 담당자 - 기업 연결 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_CONNECT_REQUEST_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_roadmap_image
	 * @Date : 2019. 1. 30.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 기업 로드맵 이미지 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_ROADMAP_IMAGE, method = RequestMethod.GET)
	public String company_roadmap_image(){
		logger.info("FAP 기업 로드맵 이미지 페이지 이동 시작");
		
		logger.info("FAP 기업 로드맵 이미지 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_ROADMAP_IMAGE;
	}
	
	/**
	 * @Method Name : company_job_ad_insert_form_load
	 * @Date : 2019. 1. 30.
	 * @User : 김준영
	 * @Param : 잡페어 seq, 잡페어 세부 seq, 불러올 채용공고 seq
	 * @Return : JSP 리턴페이지(채용공고 등록)
	 * @Method 설명 : 채용공고 등록페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_INSERT_FORM_LOAD, method = RequestMethod.GET)
	public String company_job_ad_insert_form_load(Model model, Authentication auth, int fap_jobfair_seq, int fap_jobfair_divide_seq, long fap_job_ad_seq){
		logger.debug("FAP 채용공고 불러오기");
		
		String user_id = (String) auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
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
		paramMap.put("fap_comp_id", fap_comp_id);
		paramMap.put("fap_jobfair_seq", fap_jobfair_seq);
		
		int adTotalCount = sfcService.select_job_ad_load_list_count(paramMap);
		if(adTotalCount == 0){adTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(5, 5, 1, adTotalCount);
		int jobAdLoadNum = adTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		ArrayList<HashMap<String, Object>> select_job_ad_load_list = sfcService.select_job_ad_load_list_paging(paramMap, repNavi.getStartRecord(), repNavi.getCountPerPage());
		

		model.addAttribute("select_job_ad_load_list", select_job_ad_load_list);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("jobAdLoadNum", jobAdLoadNum);
		
		//시험전형 파일 path
		//model.addAttribute("job_exam_file_path", fapJobRecruitExamFile);
		model.addAttribute("job_exam_file_path", "/fap/company/job_recruit_exam_file");
		
		logger.debug("FAP 채용공고 불러오기");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_INSERT_FORM_LOAD;
	}
	
	/**
	 * @Method Name : company_terms_and_condition_policy
	 * @Date : 2019. 1. 31.
	 * @User : 신동철
	 * @Param : -
	 * @Return : 개인정보처리방침 페이지
	 * @Method 설명 : 개인정보처리방침 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_TERMS_AND_CONDITION_POLICY, method = RequestMethod.GET)
	public String company_terms_and_condition_policy(){
		logger.info("FAP 개인정보처리방침 이동 시작");		
		logger.info("FAP 개인정보처리방침 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_TERMS_AND_CONDITION_POLICY;
	}
	
	/**
	 * @Method Name : company_pay_for_cost
	 * @Date : 2019. 2. 8.
	 * @User : 이종호
	 * @Param : 유저 아이디
	 * @Return : -
	 * @Method 설명 : FAP 기업 - 비용결제 검색
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_PAY_FOR_COST, method = RequestMethod.GET)
	public String company_pay_for_cost(Authentication auth, Model model) {
		
		logger.info("FAP 기업 - 비용결제 검색 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);

		logger.info("FAP 기업 - 비용결제 검색 컨트롤러 종료");
		
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_PAY_FOR_COST;
	}
	
	/**
	 * @Method Name : company_job_ad_read_form
	 * @Date : 2019. 2. 13.
	 * @User : 원병호
	 * @Param : 채용공고 시퀀스
	 * @Return : JSP 채용공고 읽기폼
	 * @Method 설명 : 해당 채용공고의 읽기폼으로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_READ_FORM, method=RequestMethod.GET)
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
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_JOB_AD_READ_FORM;
	}
	
	/**
	 * @Method Name : company_applicant_stat_per_job_ad
	 * @Date : 2019. 2. 15.
	 * @User : 남유송
	 * @Param : 
	 * @Return : -
	 * @Method 설명 : FAP 기업 - 채용공고별 지원현황 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD, method = RequestMethod.POST)
	public String applicant_status_per_job_ad(Model model, String fap_jobfair_seq, String fap_jobfair_divide_seq, String fap_job_ad_seq, 
												String fap_jobfair_title, String fap_jobfair_devide_gb,
												String fap_comp_id, String fap_job_ad_state) {
		logger.info("FAP 기업 - 채용공고별 지원현황 페이지 이동 컨트롤러 시작");		
	 
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_jobfair_title", fap_jobfair_title);
		model.addAttribute("fap_jobfair_devide_gb", fap_jobfair_devide_gb);
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
		//최종결과 입력 시한 검색
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
		
		logger.info("FAP 기업 - 채용공고별 지원현황 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD;
	}
	
	/**
	 * @Method Name : update_fap_job_apply_result
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : 전형결과, 최종결과
	 * @Return : 채용공고별 지원현황 페이지
	 * @Method 설명 : FAP 기업 - 정규지원자의 전형결과, 최종결과 수정 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_UPDATE_FAP_JOB_APPLY_RESULT, method = RequestMethod.POST)
		public String update_fap_job_apply_result(Model model, Authentication auth, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id
				, String fap_jobfair_seq, String fap_jobfair_title, String fap_jobfair_devide_gb
				, SocietyFapJobApplyResult applyResult, SocietyFapJobApplyFinalResult finalResult){
		logger.info("FAP 기업 - 정규지원자의 전형결과, 최종결과 수정 컨트롤러 시작");	
		
		finalResult.setFap_job_ad_seq(Long.parseLong(fap_job_ad_seq));
		finalResult.setFap_comp_id(fap_comp_id);		
		int result = sfcService.update_fap_job_apply_result(auth, applyResult, finalResult);
		
        //알림게시판 내용추가 
		if(result>0){
			HashMap<String,Object> compNms= sfacService.select_comp_nm(fap_comp_id);
			String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
			String fap_job_ad_title = sfaService.select_job_ad_title(Long.parseLong(fap_job_ad_seq));
			String fap_admin_notice_ct = "기업 \'"+fap_comp_en_nm+"\'이(가) 채용공고 \'"+fap_job_ad_title+"\' 의 결과를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_comp_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2305");
			int adminInfo = sfaService.insert_admin_notice_info(paramMap);
		}
				
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
	      model.addAttribute("fap_jobfair_title", fap_jobfair_title);
	      model.addAttribute("fap_jobfair_devide_gb", fap_jobfair_devide_gb);

		
		logger.info("FAP 기업 - 정규지원자의 전형결과, 최종결과 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD;
		}
	
	/**
	 * @Method Name : company_applicant_stat_per_job_ad_form
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : 채용공고 시퀀스, 회사 아이디
	 * @Return : 채용공고별 지원현황 관리 폼
	 * @Method 설명 : FAP 기업 - 채용공고별 지원현황 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD_FORM, method = RequestMethod.GET)
	public String applicant_status_per_job_ad_form(Model model, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id, String fap_jobfair_seq, String fap_jobfair_title, String fap_jobfair_devide_gb) {
		logger.info("FAP 기업 - 채용공고별 지원현황 페이지 이동 컨트롤러 시작");		
	 
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
	      model.addAttribute("fap_jobfair_title", fap_jobfair_title);
	      model.addAttribute("fap_jobfair_devide_gb", fap_jobfair_devide_gb); 
		
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
		//최종결과 입력 시한 검색
		HashMap<String, Object> final_select_info = sfcService.search_jobfair_divide_final_select_info(Integer.parseInt(fap_jobfair_divide_seq));
		model.addAttribute("final_select_info", final_select_info);
		
		logger.info("FAP 기업 - 채용공고별 지원현황 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD;
	}
	
	/**
	 * @Method Name : insert_pass_comment
	 * @Date : 2019. 2. 12.
	 * @User : 신동철
	 * @Param : 최종결과 시퀀스, 합격사유
	 * @Return : 채용공고별 지원현황 페이지
	 * @Method 설명 : FAP 기업 - 지원자 합격사유 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_INSERT_PASS_COMMENT, method = RequestMethod.POST)
		public String insert_pass_comment(Model model, Authentication auth, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id, SocietyFapJobApplyFinalResult passComment){
		logger.info("FAP 채용전형 지원자 최종결과 합격사유 등록 컨트롤러 시작");
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		passComment.setFap_job_app_final_rt_udt_id((String)auth.getPrincipal()); 
		sfcService.insert_pass_comment(passComment);		
		
		logger.info("FAP 채용전형 지원자 최종결과 합격사유 등록 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD;
		}
	
	/**
	 * @Method Name : update_missmatching_fap_job_apply_result
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : 미스매칭 전형결과, 최종결과
	 * @Return : 채용공고별 지원현황 페이지
	 * @Method 설명 : 미스매칭 지원자의 전형결과, 최종결과 수정 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_UPDATE_MISSMATCHING_FAP_JOB_APPLY_RESULT, method = RequestMethod.POST)
		public String update_missmatching_fap_job_apply_result(Model model, Authentication auth, String fap_jobfair_divide_seq, String fap_job_ad_seq, String fap_comp_id
				, SocietyFapJobApplyResult applyResult, SocietyFapJobApplyFinalResult finalResult){
		logger.info("FAP 미스매칭 지원자의 전형결과, 최종결과 수정 컨트롤러 시작");	
		
		finalResult.setFap_job_ad_seq(Long.parseLong(fap_job_ad_seq));
		finalResult.setFap_comp_id(fap_comp_id);
		int result = sfcService.update_missmatching_fap_job_apply_result(auth, applyResult, finalResult);
		
		  //알림게시판 내용추가 
				if(result>0){
					HashMap<String,Object> compNms= sfacService.select_comp_nm(fap_comp_id);
					String fap_comp_en_nm = (String)compNms.get("fap_comp_en_nm");
					String fap_job_ad_title = sfaService.select_job_ad_title(Long.parseLong(fap_job_ad_seq));
					String fap_admin_notice_ct = "기업 \'"+fap_comp_en_nm+"\'이(가) 채용공고 \'"+fap_job_ad_title+"\' 의 결과를 등록했습니다.";
					HashMap<String, Object> paramMap = new HashMap<>();
					paramMap.put("fap_admin_notice_ins_id", fap_comp_id);	 
					paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
					paramMap.put("fap_admin_notice_handle_gb","D2305");
					int adminInfo = sfaService.insert_admin_notice_info(paramMap);
				}
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		logger.info("FAP 미스매칭 지원자의 전형결과, 최종결과 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_STAT_PER_JOB_AD;
		}
	
	/**
	 * @Method Name : company_job_qna_management
	 * @Date : 2019. 3. 5.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 해당 Q&A 상세
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA_MANAGEMENT, method = RequestMethod.GET)
	public String company_job_qna_management(Model model, Authentication auth, long fap_job_ad_seq){
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 시작");	
		
		ArrayList<HashMap<String, Object>> job_qna_list = sfcService.select_job_qna(fap_job_ad_seq);
		
		Gson gson = new Gson();
		
		String job_qna_list_string = gson.toJson(job_qna_list);
		String replace_job_qna_list = job_qna_list_string.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		model.addAttribute("job_qna_list",replace_job_qna_list);
		
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 끝");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_job_qna
	 * @Date : 2019. 3. 5.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 해당 Q&A 상세
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA, method = RequestMethod.GET)
	public String company_job_qna(Model model, long fap_job_qna_question_seq){
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 시작");	
		
		HashMap<String, Object> job_qna = sfcService.select_job_qna_one(fap_job_qna_question_seq);
		
		
		long fap_job_ad_seq = (long)(job_qna.get("fap_job_ad_seq"));
		
		model.addAttribute("job_qna", job_qna);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 끝");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA;
	}
	
	/**
	 * @Method Name : insert_job_qna_question
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체, 채용공고 일련번호
	 * @Return : 
	 * @Method 설명 : 채용기업 채용공고 Q&A 질문 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA_ANSWER_INSERT, method = RequestMethod.POST)
	public String insert_job_qna_question(SocietyFapQnaAnswer qnaAnswer, long fap_job_ad_seq, Authentication auth){
		logger.info("FAP 채용공고 Q&A 답변 등록 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		qnaAnswer.setFap_job_qna_answer_ins_id(user_id);
		qnaAnswer.setFap_job_qna_answer_udt_id(user_id);
		int result = sfcService.insert_job_qna_question(qnaAnswer);
		
		//알림게시판에 관련정보 추가 
		if(result>0){			
			String fap_job_ad_title = sfaService.select_job_ad_title(fap_job_ad_seq);
			String fap_job_qna_question_title = sfaService.select_job_qna_question_title(qnaAnswer.getFap_job_qna_question_seq());
			String fap_admin_notice_ct = "기업 \'"+user_id+"\'이(가) 채용공고 \'"+fap_job_ad_title+"\' 의 질문글  \'"+ fap_job_qna_question_title+"\' 에 답변했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", user_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2304");
			int adminInfo = sfaService.insert_admin_notice_info(paramMap);		
		}
		
		logger.info("FAP 채용공고 Q&A 답변 등록 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA_MANAGEMENT + "?fap_job_ad_seq=" + fap_job_ad_seq;
	}
	
	/**
	 * @Method Name : update_job_qna_question
	 * @Date : 2019. 3. 6.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체, 채용공고 일련번호
	 * @Return : 
	 * @Method 설명 : 채용기업 채용공고 Q&A 질문 수정
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA_ANSWER_UPDATE, method = RequestMethod.POST)
	public String update_job_qna_question(SocietyFapQnaAnswer qnaAnswer, long fap_job_ad_seq, Authentication auth){
		logger.info("FAP 채용공고 Q&A 답변 등록 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		qnaAnswer.setFap_job_qna_answer_udt_id(user_id);
		sfcService.update_job_qna_question(qnaAnswer);
		logger.info("FAP 채용공고 Q&A 답변 등록 컨트롤러 시작");	
		return "redirect:" + PathConstants.SOCIETY_FAP_COMPANY_JOB_QNA_MANAGEMENT + "?fap_job_ad_seq=" + fap_job_ad_seq;
	}
	
	/**
	 * @Method Name : applicant_resume_print_form
	 * @Date : 2019. 4. 5.
	 * @User : 이종호
	 * @Param : 이력서 시퀀스 배열
	 * @Return : 
	 * @Method 설명 : 프린트 할 이력서 정보 조회
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_RESUME_PRINT_FORM, method = RequestMethod.POST)
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
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_RESUME_PRINT_FORM;
	}
	
	/**
	 * @Method Name : applicant_score_print_form
	 * @Date : 2020. 10. 05.
	 * @User : 양승균
	 * @Param : 잡페어 seq, 회사 seq, 잡페어 이름, 잡페어 구분(서울/도쿄 등)
	 * @Return : 
	 * @Method 설명 : 프린트 할 성적표 정보 조회
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_SCORE_PRINT_FORM, method = RequestMethod.POST)
	public String applicant_score_print_form(int fap_jobfair_seq, int fap_job_ad_seq, String fap_jobfair_title, String fap_jobfair_devide_gb
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
			
			fail.put("Fail", failCount);
			
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
			
//			for (int i = 0; i < testInfoM.size(); i++) {
//				System.out.println("testInfoM 확인 : "+ testInfoM.get(i).toString());
//			}
		
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
			
//			for(int i = 0; i < user_name.size(); i++) {
//				System.out.println("name = " + user_name.get(i).toString());
//			}
			
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
		SocietyFapCompanyUser company_info = sfcService.select_company((String)auth.getPrincipal());
		model.addAttribute("comp_en_nm", company_info.getFap_comp_en_nm());
		model.addAttribute("jobfair_title", fap_jobfair_title);
		model.addAttribute("jobfair_gb", fap_jobfair_devide_gb);
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_APPLICANT_SCORE_PRINT_FORM;
	}
	
	/**
	 * @Method Name : company_faq
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : 페이지번호,검색어,FAQ구분
	 * @Return : FAP 기업 FAQ 정보
	 * @Method 설명 : FAP 기업 FAQ 페이지
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_FAQ, method = RequestMethod.GET)
	public String company_faq(Model model,@RequestParam(defaultValue="1") int page 
			, @RequestParam(defaultValue="") String searchText
			, @RequestParam(defaultValue="C5301") String fap_faq_gb_cd) {
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_faq_gb_cd", fap_faq_gb_cd);
		paramMap.put("searchText", searchText);
		
		int total = sfaService.fap_faq_select_list_gb_count(paramMap);
		PageNavigator navi = new PageNavigator(5, 5, page, total);
		ArrayList<HashMap<String, Object>> faqList = sfaService.fap_faq_select_list_gb(paramMap,navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("faqList", faqList);
		model.addAttribute("navi", navi);
		model.addAttribute("fap_faq_gb_cd", fap_faq_gb_cd);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_FAQ;
	}

	/**
	 * @Method Name : company_ses_user_service
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 기업 SES 회원서비스 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_SES_USER_SERVICE, method = RequestMethod.GET)
	public String company_ses_user_service(){
		logger.info("FAP 기업 SES 회원서비스 페이지 이동 시작");
		
		logger.info("FAP 기업 SES 회원서비스 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_SES_USER_SERVICE;
	}
	
	/**
	 * @Method Name : company_2020_fair_schedule
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 기업 2020 Fair 일정 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_2020_FAIR_SCHEDULE, method = RequestMethod.GET)
	public String company_2020_fair_schedule(){
		logger.info("FAP 기업 2020 Fair 일정 페이지 이동 시작");
		
		logger.info("FAP 기업 2020 Fair 일정 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_2020_FAIR_SCHEDULE;
	}
	
	/**
	 * @Method Name : company_step
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 기업 전형절차 페이지 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_STEP, method = RequestMethod.GET)
	public String company_step(){
		logger.info("FAP 기업 전형절차 페이지 이동 시작");
		
		logger.info("FAP 기업 전형절차 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_STEP;
	}
	
	/**
	 * @Method Name : company_comps_and_partners
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 기업 채용기업&파트너사 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_COMPS_AND_PARTNERS, method = RequestMethod.GET)
	public String company_comps_and_partners(){
		logger.info("FAP 기업 채용기업&파트너사 페이지 이동 시작");
		
		logger.info("FAP 기업 채용기업&파트너사 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_COMPANY_COMPS_AND_PARTNERS;
	}
	
	/**
	 * @Method Name : company_tokyofair_screening_management
	 * @Date : 2019. 9. 23.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 기업 도쿄페어 전형 관리 페이지 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_MANAGEMENT, method = RequestMethod.GET)
	public String company_tokyofair_screening_management(Model model, @RequestParam(defaultValue="0") int fap_jobfair_seq, @RequestParam(defaultValue="0") int fap_jobfair_divide_seq) {
		logger.info("FAP 기업 도쿄페어 전형 관리 페이지 이동 컨트롤러 시작");
		
		Gson gson = new Gson();
		
		HashMap<String, Object> jobfair_map = new HashMap<String, Object>();
		jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", gson.toJson(jobfair_map));
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		
		logger.info("FAP 기업 도쿄페어 전형 관리 페이지 이동 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_tokyofair_screening_search_form
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 세부잡페어 시퀀스
	 * @Return : 
	 * @Method 설명 : 도쿄페어 전체 전형 일정 조회 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_FORM, method = RequestMethod.GET)
	public String company_tokyofair_screening_search_form(int fap_jobfair_divide_seq, Authentication auth, Model model) {
		logger.info("FAP 도쿄페어 전체 전형 일정 조회 폼 이동 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		params.put("fap_comp_id", fap_comp_id);
		
		HashMap<String, Object> result = sfcService.tokyofair_screening_search_total(params);
		Gson gson = new Gson();
		
		String info_json = gson.toJson(result);
		String replace_json = info_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		model.addAttribute("total", replace_json);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		
		logger.info("FAP 도쿄페어 전체 전형 일정 조회 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_FORM;
	}
	
	/**
	 * @Method Name : company_tokyofair_screening_search_print_form
	 * @Date : 2019. 10. 11.
	 * @User : 이종호
	 * @Param : 세부잡페어 시퀀스
	 * @Return : 
	 * @Method 설명 : 도쿄페어 전체 전형 일정 인쇄 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_PRINT_FORM, method = RequestMethod.POST)
	public String company_tokyofair_screening_search_print_form(int fap_jobfair_divide_seq, Authentication auth, Model model) {
		logger.info("FAP 도쿄페어 전체 전형 일정 인쇄 폼 이동 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		String fap_comp_id = sfcService.select_fap_comp_id(user_id);
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		params.put("fap_comp_id", fap_comp_id);
		
		HashMap<String, Object> result = sfcService.tokyofair_screening_search_total(params);
		Gson gson = new Gson();
		
		String info_json = gson.toJson(result);
		String replace_json = info_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		model.addAttribute("total", replace_json);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		
		logger.info("FAP 도쿄페어 전체 전형 일정 인쇄 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_SEARCH_PRINT_FORM;
	}
	
	/**
	 * @Method Name : company_tokyofair_screening_insert_form
	 * @Date : 2019. 9. 24.
	 * @User : 이종호
	 * @Param : 채용공고 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형 등록 페이지 이동 
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_INSERT_FORM, method=RequestMethod.GET)
	public String company_tokyofair_screening_insert_form(Model model, long fap_job_ad_seq) {
		logger.info("FAP 기업 도쿄페어 전형 등록 페이지 이동 컨트롤러 시작");
		int count = sfcService.tokyofair_screening_search_count(fap_job_ad_seq);
		String fap_comp_id = sfcService.job_ad_comp_id_search(fap_job_ad_seq);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		model.addAttribute("count", count);
		
		logger.info("FAP 기업 도쿄페어 전형 등록 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_INSERT_FORM;
	}
	
	/**
	 * @Method Name : company_tokyofair_screening_insert_form
	 * @Date : 2019. 9. 26.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형정보 등록 
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_INSERT, method = RequestMethod.POST)
	public String company_tokyofair_screening_insert_form(SocietyFapTokyofairScreening screening,Authentication auth) {
		logger.info("FAP 기업 도쿄페어 전형정보 등록 컨트롤러 시작");
		screening.setFap_tokyofair_screening_ins_id((String)auth.getPrincipal());
		screening.setFap_tokyofair_screening_udt_id((String)auth.getPrincipal());
		
		sfcService.tokyofair_screening_insert(screening);
		
		logger.info("FAP 기업 도쿄페어 전형정보 등록 컨트롤러 종료");
		
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_tokyofair_screening_update_form
	 * @Date : 2019. 9. 30.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 정보
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전형정보 수정 
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_UPDATE, method = RequestMethod.POST)
	public String company_tokyofair_screening_update_form(SocietyFapTokyofairScreening screening,Authentication auth) {
		logger.info("FAP 기업 도쿄페어 전형정보 수정 컨트롤러 시작");
		screening.setFap_tokyofair_screening_ins_id((String)auth.getPrincipal());
		screening.setFap_tokyofair_screening_udt_id((String)auth.getPrincipal());
		
		sfcService.tokyofair_screening_update(screening);
		
		logger.info("FAP 기업 도쿄페어 전형정보 수정 컨트롤러 종료");
		
		return "redirect:"+PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_tokyofair_screening_update_form
	 * @Date : 2019. 9. 27.
	 * @User : 이종호
	 * @Param : 도쿄페어 전형 시퀀스
	 * @Return : 도쿄페어 전형 정보
	 * @Method 설명 : 도쿄페어 전형 정보 조회
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_UPDATE_FORM, method=RequestMethod.GET)
	public String company_tokyofair_screening_update_form(Model model, int fap_tokyofair_screening_seq) {
		logger.info("FAP 도쿄페어 전형 정보 조회 컨트롤러 시작");
		HashMap<String, Object> tokyofairScrMap = sfcService.tokyofair_screening_search_one(fap_tokyofair_screening_seq);
		ArrayList<HashMap<String, Object>> userList = sfcService.tokyofair_screening_subject_search_some(Long.parseLong(tokyofairScrMap.get("fap_job_ad_seq").toString()));
		
		Gson gson = new Gson();
		
		String info_json = gson.toJson(tokyofairScrMap);
		String replace_json = info_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		String user_json = gson.toJson(userList);
		String user_replace_json = user_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		model.addAttribute("tokyofairScrMap", tokyofairScrMap);
		model.addAttribute("tokyofairScrMapJson", replace_json);
		model.addAttribute("userList", user_replace_json);
		
		logger.info("FAP 도쿄페어 전형 정보 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCREENING_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : company_tokyofair_schedule_management
	 * @Date : 2019. 10. 1.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스 , 채용공고 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 일정 관리 페이지 이동 
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MANAGEMENT, method=RequestMethod.GET)
	public String company_tokyofair_schedule_management(Model model, long fap_job_ad_seq, int fap_jobfair_divide_seq) {
		logger.info("FAP 도쿄페어 일정 관리 페이지 이동 컨트롤러 시작");
		HashMap<String, Object> tokyofairSetMap = sfcService.tokyofair_schedule_set_search(fap_jobfair_divide_seq);
		ArrayList<SocietyFapTokyofairScreening> screeningList = sfcService.tokyofair_screening_search(fap_job_ad_seq);
		String fap_comp_id = sfcService.job_ad_comp_id_search(fap_job_ad_seq);
		model.addAttribute("tokyofairSetMap", tokyofairSetMap);
		model.addAttribute("screeningList", screeningList);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		
		logger.info("FAP 도쿄페어 일정 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_COMPANY_TOKYOFAIR_SCHEDULE_MANAGEMENT;
	}
}