/**
 * 
 */
package global.segroup.society.fap.user.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.changbi.member.vo.MemberForm;
import com.aracomm.changbi.user.service.UserService;
import com.dreamsecurity.crypt.MsgCrypto;
import com.google.gson.Gson;

import global.segroup.domain.AdminPager;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.User;
import global.segroup.exception.DoesNotExistUserInfo;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFinalDecisionTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapMainpageContent;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapJobAd;
import global.segroup.society.fap.company.domain.SocietyFapJobFile;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.society.fap.user.domain.SocietyFapPersonalGraduate;
import global.segroup.society.fap.user.domain.SocietyFapPersonalHighschool;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUniversity;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUser;
import global.segroup.society.fap.user.domain.SocietyFapQnaQuestion;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeAddr;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeCareer;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeEduhistory;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeFile;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeForm;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeLicense;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeName;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeProfile;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeProject;
import global.segroup.society.fap.user.domain.SocietyFapUserResumeTalent;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.LocaleUtil;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 지원자 View 컨트롤러
 * 
 */

@Controller
public class SocietyFapUserViewController implements PathConstants {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapUserViewController.class);
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
		
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SocietyFapAdminCommonService sfaService;

	@Autowired
	private SocietyFapCompanyService sfcService;
	
	@Autowired
	private SocietyEduAdminService seaService;
	
	@Autowired
	private SocietyEduUserService seuService;
	
	@Autowired
	private UserService service;
	
	@Value("#{props['usr.local.cert']}")
	private String cert;
	
	//공지사항 게시판 코드
	private static final String BOARD_NOTICE_CODE = "A1700";
	
	//취업정보&전략 게시판 코드
	private static final String BOARD_JOBINFO_CODE = "A1701";
	
	//미국인턴십 게시판 코드
	private static final String BOARD_INTERNSHIP_CODE = "A1706";
	
	/**
	 * @Method Name : user_security_invalidate
	 * @Date : 2018. 12. 6
	 * @User : 이종호
	 * @Param : 세션정보
	 * @Return : 회원 로그인 페이지
	 * @Method 설명 : 현재 세션정보를 초기화 하고 회원 로그인 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_SECURITY_INVALIDATE , method = RequestMethod.GET)
	public String user_security_invalidate(HttpSession session) {
		logger.debug("FAP 회원 시큐리티 초기화 컨트롤러 시작");
		
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		
		logger.debug("FAP 회원 시큐리티 초기화 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : user_login_success
	 * @Date : 2018. 12. 6.
	 * @User : 이종호
	 * @Param : 인증 정보 객체
	 * @Return : JSP 리턴페이지(FAP 회원 로그인 성공)
	 * @Method 설명 : FAP 회원 로그인 성공시 권한별 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_LOGIN_SUCCESS, method = RequestMethod.GET)
	public String user_login_success(Authentication auth, RedirectAttributes rttr, HttpServletRequest request, HttpSession session){
		logger.debug("FAP 회원 로그인 성공 컨트롤러 시작");
		
		String user_ip = service.getClintIp(request);
		logger.info(user_ip);
		
		String user_id = auth.getName();
		
		User user = service.selectRestMemberInfo(user_id);
		logger.info("lms 회원 로그인 성공 컨트롤러 종료");
		//휴면회원인 경우 로그인시 휴면 상태 해제 2020-10-21 김나영
		if(user != null && user.getUser_state().equals("A0201")) {
			Date today = new Date();
			Timestamp timestamp = new Timestamp(today.getTime());
			String todayStr = timestamp.toString();
			todayStr = todayStr.substring(0, todayStr.length()-4);
			
			service.updateUserInfo(user);
			service.deleteRestUser(user_id);
			
			rttr.addFlashAttribute("dormancy_msg", "휴면 상태가 해제되었습니다. 일시: " + todayStr);
		}
		//접속이력 저장 2020-10-29 김나영
		MemberForm memberAcc = new MemberForm();
		memberAcc.setId(user_id);
		memberAcc.setUser_ip(user_ip);
		service.insertUserAccInfo(memberAcc);
		
		//user_flag 저장
		HashMap<String, Object> member = service.selectMemberInfo(user_id);
		session.setAttribute("user_flag", member.get("USER_FLAG"));
		logger.debug("FAP 회원 로그인 성공 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_MAIN;
		
	}
	
	/**
	 * @Method Name : user_login_form
	 * @Date : 2018. 12. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회원 로그인 폼 페이지)
	 * @Method 설명 : FAP 회원 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_LOGIN_FORM , method = RequestMethod.GET)
	public String user_login_form(HttpSession session, Model model,HttpServletRequest request, HttpServletResponse response){
		logger.debug("FAP 회원 로그인 폼 이동 컨트롤러 시작");
		
		Exception exception = (Exception)session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		
		if((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException || exception.getCause() instanceof BadCredentialsException) ){
			//세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			
			LocaleUtil.setLocale(request, response);
			
			//휴면 계정 처리
			if(exception.getCause() instanceof DisabledException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_USER_DORMANCY_FORM;
			}
			//탈퇴 계정 처리
			else if(exception.getCause() instanceof AccountExpiredException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_USER_EXPIRED_FORM;
			}
			//정지 계정 처리
			else if(exception.getCause() instanceof LockedException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_USER_LOCKED_FORM;
			}
			// 학교 정보 미등록 계정 처리
			else if(exception.getCause() instanceof DoesNotExistUserInfo){
				// 교육기관 불러오기
				ArrayList<HashMap<String, Object>> kmoveList = sfuService.select_komve();
				Gson gson = new Gson();
				model.addAttribute("kmoveList", gson.toJson(kmoveList));
				model.addAttribute("user_id", ((DoesNotExistUserInfo)exception.getCause()).getId());
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_USER_INSERT_SCHOOL;
			}
			
			
		}
		
		logger.debug("FAP 회원 로그인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_USER_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : user_access_denied
	 * @Date : 2018. 12. 6.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회원 접근 제한 페이지)
	 * @Method 설명 : FAP 회원 접근 제한 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_ACCESS_DENIED , method = RequestMethod.GET)
	public String user_access_denied() {
		logger.debug("FAP 회원 접근권한 제한 컨트롤러 시작");
		
		logger.debug("FAP 회원 접근권한 제한 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_USER_ACCESS_DENIED;
	}
	
	/**
	 * @Method Name : user_language_change
	 * @Date : 2021. 04. 26
	 * @User : 김나영
	 * @Param : 
	 * @Return : 사용자 메인 페이지
	 * @Method 설명 : 사용자 언어 변경 요청
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_LANGUAGE_CHANGE, method = RequestMethod.GET)
	public String user_language_change(String lo,HttpServletRequest request , HttpServletResponse response) {
		
		LocaleUtil.setLocale(request, response, lo);
		
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_MAIN;
	}
	
	/**
	 * @Method Name : resume_management
	 * @Date : 2018. 12. 11.
	 * @User : 남유송
	 * @Param : -
	 * @Return : 이력서 관리페이지 JSP
	 * @Method 설명 : 이력서 관리페이지로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_MANAGEMENT, method = RequestMethod.GET)
	public String resume_management(Authentication auth, Model model){
		logger.debug("이력서 관리페이지 이동 시작");
		String user_id = (String) auth.getPrincipal();
		ArrayList<HashMap<String, Object>> result = sfuService.select_my_resume_list(user_id);
		
		ArrayList<HashMap<String, Object>> resumeFormList = new ArrayList<>();
		ArrayList<HashMap<String, Object>> resumeApplyList = new ArrayList<>();
		
		for(HashMap<String, Object> map : result) {
			if(map.get("fap_resume_flag").toString().equals("0")) {
				resumeApplyList.add(map);
			}else {
				if(map.get("fap_open_resume_flag").toString().equals("0")) {
					resumeApplyList.add(map);
				}else {
					resumeFormList.add(map);
				}
			}
		}
		
		Gson gson = new Gson();
		
		String resume_form_jason = gson.toJson(resumeFormList);
		String replace_resume_form_jason =  resume_form_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("resumeFormListJson", replace_resume_form_jason);
		
		String resume_apply_jason = gson.toJson(resumeApplyList);
		String replace_resume_apply_jason =  resume_apply_jason.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("resumeApplyListJson", replace_resume_apply_jason);
		
		model.addAttribute("resumeFormList", resumeFormList);
		model.addAttribute("resumeApplyList", resumeApplyList);
		
		
		logger.debug("이력서 관리페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_RESUME_MANAGEMENT;
	}
	
   /**
	* @Method Name : resume_insert_form
	* @Date : 2018. 12. 6.
	* @User : 남유송
	* @Param : -
	* @Return : 이력서 등록 페이지 JSP
	* @Method 설명 : 로그인 한 회원정보를 이력서 form으로 이동
	*/
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_INSERT_FORM, method = RequestMethod.GET)
	public String resume_insert_form(Model model){
		logger.debug("이력서 등록페이지 이동 시작");
		logger.debug("이력서 등록페이지 이동 종료");  
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_RESUME_INSERT_FORM;
	}
	
	/**
	 * @Method Name : resume_insert
	 * @Date : 2018. 12. 6.
	 * @User : 남유송
	 * @Param : 이력서 정보(기본정보, 학력/관련 교육이수, 사회 경력, 프로젝트 개발 경력, 자격, 역량/재능, PR, 포트폴리오 파일)
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 사용자로부터 입력받은 정보로 이력서를 생성하고 이력서 관리 페이지로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_INSERT, method=RequestMethod.POST)
	public String resume_insert_form(SocietyFapUserResumeForm resumeForm, SocietyFapUserResumeEduhistory resumeEduHistory,
			SocietyFapUserResumeLicense resumeLicense, SocietyFapUserResumeCareer resumeCareer, SocietyFapUserResumeProject resumeProject
			, SocietyFapUserResumeTalent resumeTalent, SocietyFapUserResumeProfile resumeProfile, SocietyFapUserResumeAddr resumeAddr, 
			SocietyFapUserResumeName resumeName, SocietyFapUserResumeFile resumeFile, Authentication auth){
			logger.debug("FAP 취업지원자 이력서 등록 컨트롤러 시작");
			String user_id = (String) auth.getPrincipal();
			logger.info("회원 아이디 : " + user_id);
			
			resumeForm.setUser_id(user_id);			
			//부모테이블을 먼저 insert하고 generated key를 가져온다. 
			long resume_parent_insert_seq = sfuService.resume_parent_insert(resumeForm);
			resumeForm.setFap_resume_seq(resume_parent_insert_seq);
			//update 후 insert method를 따로 만들어주거나 조건으로 구분하기
			sfuService.resume_insert(resumeForm, resumeEduHistory, resumeLicense,resumeCareer, resumeProject, resumeTalent
					, resumeProfile, resumeAddr, resumeName, resumeFile);
			logger.debug("FAP 취업지원자 이력서 등록 컨트롤러 종료");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_RESUME_MANAGEMENT;
	}
	
	/**
	 * @Method Name : resume_delete
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : 이력서 정보(기본정보, 학력/관련 교육이수, 사회 경력, 프로젝트 개발 경력, 자격, 역량/재능, PR, 포트폴리오 파일)
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 사용자로부터 입력받은 정보로 이력서를 생성하고 이력서 관리 페이지로 이동하는 메소드
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_DELETE, method=RequestMethod.POST)
	public String delete_resume_form(Authentication auth, int fap_resume_seq){
		logger.debug("FAP 취업지원자 이력서 삭제 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", auth.getPrincipal());
		param.put("fap_resume_seq", fap_resume_seq);
		sfuService.delete_my_file(param);
		sfuService.delete_my_resume(param);
		logger.debug("FAP 취업지원자 이력서 삭제 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_RESUME_MANAGEMENT;
	}
	
	/**
	 * @Method Name : resume_update
	 * @Date : 2018. 12. 18.
	 * @User : 남유송
	 * @Param : 이력서 정보 업데이트 폼으로 이동
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 이력서를 수정하는 이력서 수정 페이지로 이동하는 method
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_UPDATE_FORM, method=RequestMethod.POST)
	public String resume_update_form(int fap_resume_seq, Model model, Authentication auth){
		logger.debug("FAP 취업지원자 이력서 업데이트 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", auth.getPrincipal());
		param.put("fap_resume_seq", fap_resume_seq);
		model.addAttribute("fap_resume_seq", fap_resume_seq);
		HashMap<String, Object> wholeResume = sfuService.selectResumeApply(param);
		Gson gson = new Gson();
		String wholeResume_json = gson.toJson(wholeResume);
		String replace_wholeResume_json = wholeResume_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("wholeResumeJson",replace_wholeResume_json);
		
		logger.debug("FAP 취업지원자 이력서 업데이트 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_RESUME_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : resume_read_form
	 * @Date : 2019. 03. 15.
	 * @User : 이종호
	 * @Param : 이력서 정보 읽기 폼으로 이동
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 이력서 읽기 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_READ_FORM, method=RequestMethod.POST)
	public String resume_read_form(int fap_resume_seq, Model model, Authentication auth){
		logger.debug("FAP 취업지원자 이력서 읽기 폼 컨트롤러 시작");
		HashMap<String, Object> param = new HashMap<>();
		param.put("user_id", auth.getPrincipal());
		param.put("fap_resume_seq", fap_resume_seq);
		model.addAttribute("fap_resume_seq", fap_resume_seq);
		HashMap<String, Object> wholeResume = sfuService.selectResumeApply(param);
		Gson gson = new Gson();
		String wholeResume_json = gson.toJson(wholeResume);
		String replace_wholeResume_json = wholeResume_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("wholeResumeJson",replace_wholeResume_json);
		
		logger.debug("FAP 취업지원자 이력서 읽기 폼 컨트롤러 종료");
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_RESUME_READ_FORM;
	}
	
	/**
	 * @Method Name : resume_update
	 * @Date : 2018. 12. 23.
	 * @User : 남유송
	 * @Param : 이력서 정보 업데이트
	 * @Return : JSP 리턴페이지
	 * @Method 설명 : 사용자로부터 입력받은 정보로 이력서를 수정하고 이력서 관리 페이지로 이동하는 method
	 */
	@Transactional
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_RESUME_UPDATE, method=RequestMethod.POST)
	public String resume_update(SocietyFapUserResumeForm resumeForm, SocietyFapUserResumeEduhistory resumeEduHistory,
			SocietyFapUserResumeLicense resumeLicense, SocietyFapUserResumeCareer resumeCareer, SocietyFapUserResumeProject resumeProject
			, SocietyFapUserResumeTalent resumeTalent, SocietyFapUserResumeProfile resumeProfile, SocietyFapUserResumeAddr resumeAddr, SocietyFapUserResumeName resumeName, SocietyFapUserResumeFile resumeFile
			, Authentication auth){
			logger.debug("FAP 취업지원자 이력서 업데이트 컨트롤러 시작");
			HashMap<String, Object> param = new HashMap<>();
			String user_id = (String) auth.getPrincipal();
			long fap_resume_seq = resumeForm.getFap_resume_seq();
			param.put("user_id", user_id);
			param.put("fap_resume_seq", fap_resume_seq);
			//공통 테이블인 resumeForm만 업데이트 해준다
			resumeForm.setUser_id(user_id);
			//1.현존하는 시퀀스로 이력서 시퀀스 박아주고 update
			long resume_parent_insert_seq = sfuService.resume_parent_update(resumeForm);
			resumeForm.setFap_resume_seq(resume_parent_insert_seq);
			//2.기본정보를 제외한 모든 자식 테이블 삭제해줌
			sfuService.resume_delete(resume_parent_insert_seq);
			//update해야할 부분
			sfuService.resume_insert(resumeForm, resumeEduHistory, resumeLicense, resumeCareer, resumeProject, resumeTalent, resumeProfile, resumeAddr, resumeName, resumeFile);
			logger.debug("FAP 취업지원자 이력서 업데이트 컨트롤러 시작");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_RESUME_MANAGEMENT;
	}
	
	/**
	 * @Method Name : user_insert_form
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(일반회원 회원가입)
	 * @Method 설명 : 일반 회원 회원가입하는 폼으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_INSERT_FORM, method=RequestMethod.GET)
	public String user_insert_form(Model model,HttpServletRequest request){
		logger.info("일반 회원 회원가입 이동 컨트롤러 시작");
		logger.debug("anh288");
		// 교육기관 불러오기
		ArrayList<HashMap<String, Object>> kmoveList = sfuService.select_komve();
		Gson gson = new Gson();
		model.addAttribute("kmoveList", gson.toJson(kmoveList));
		
		Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String day = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }
		//reqNum은 최대 40byte 까지 사용 가능
       
        MsgCrypto mscr = new MsgCrypto();
        
        String reqNum = day + randomStr;
        String reqInfo    = "";
		String encReqInfo = "";
		String rtn_url = "https://www.softsociety.net/edu/user/user_mobile_verification";
		String cpId       = "sesoc";        // 회원사ID
		String urlCode    = "01001";     // URL 코드
		String reqdate    = day;        // 요청일시

		reqInfo = urlCode + "/" + reqNum + "/" + reqdate;  //암호화 시킬 데이터 '/'로 구분해서 합친다.
		encReqInfo = mscr.msgEncrypt(reqInfo, cert+"/sesocCert.der");
		
		//deprecated 되서 수정함 - 2019.03.05 이종호
		//encReqInfo = URLEncoder.encode(encReqInfo);
		try {
			encReqInfo = URLEncoder.encode(encReqInfo,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//msgEncrypt(암호화 시킬 값, 인증서 경로);

        model.addAttribute("cpId",cpId);
        model.addAttribute("rtn_url",rtn_url);
        model.addAttribute("encReqInfo",encReqInfo);
		
		logger.info("일반 회원 회원가입 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_INSERT_FORM;
	}

	/**
	 * @Method Name : user_insert_form
	 * @Date : 2018. 12. 12.
	 * @User : 김준영
	 * @Param : 회원 공통, 개인 회원
	 * @Return : JSP 리턴(회원 로그인)
	 * @Method 설명 : 일반 회원가입하는 컨트롤러 함수 
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_INSERT_FORM, method=RequestMethod.POST)
	public String user_insert_form(User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity, 
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("일반 회원 회원가입 컨트롤러 시작");
		// 비밀번호 암호화
		String encodedPw = passwordEncoder.encode(user.getUser_pw());
		user.setUser_pw(encodedPw);
		sfuService.insert_user(user, sfpUser, sfpHighschool, sfpUniversity, sfpGraduate);
		logger.info("일반 회원 회원가입 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 
	 * @Return : JSP 리턴페이지(회원 수정폼) 
	 * @Method 설명 : 회원 수정폼으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_USER_UPDATE_FORM, method = RequestMethod.GET)
	public String user_update_form(Model model, Authentication auth){
		logger.info("유저 수정폼 이동 컨트롤러 시작");
		User com_user = sfuService.select_com_user((String)auth.getPrincipal());
		SocietyFapPersonalUser societyFapPersonalUser = sfuService.select_personal_user((String)auth.getPrincipal());
		HashMap<String, Object> hashMap = sfuService.select_personal_school(societyFapPersonalUser);
		Gson gson = new Gson();
		model.addAttribute("com_user", gson.toJson(com_user));
		model.addAttribute("user_info", gson.toJson(societyFapPersonalUser));
		model.addAttribute("user_school", gson.toJson(hashMap));
		
		// 교육기관 불러오기
		ArrayList<HashMap<String, Object>> kmoveList = sfuService.select_komve();
		model.addAttribute("kmoveList", gson.toJson(kmoveList));
		
		Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String day = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }
		//reqNum은 최대 40byte 까지 사용 가능
       
        MsgCrypto mscr = new MsgCrypto();
        
        String reqNum = day + randomStr;
        String reqInfo    = "";
		String encReqInfo = "";
		String rtn_url = "https://www.softsociety.net/edu/user/user_mobile_verification";
		String cpId       = "sesoc";        // 회원사ID
		String urlCode    = "01001";     // URL 코드
		String reqdate    = day;        // 요청일시

		reqInfo = urlCode + "/" + reqNum + "/" + reqdate;  //암호화 시킬 데이터 '/'로 구분해서 합친다.
		encReqInfo = mscr.msgEncrypt(reqInfo, cert+"/sesocCert.der");
		
		//deprecated 되서 수정함 - 2019.03.05 이종호
		//encReqInfo = URLEncoder.encode(encReqInfo);
		try {
			encReqInfo = URLEncoder.encode(encReqInfo,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//msgEncrypt(암호화 시킬 값, 인증서 경로);

        model.addAttribute("cpId",cpId);
        model.addAttribute("rtn_url",rtn_url);
        model.addAttribute("encReqInfo",encReqInfo);
		
		logger.info("유저 수정폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_USER_UPDATE_FORM;
	}

	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 12. 14.
	 * @User : 김준영
	 * @Param : 유저 정보
	 * @Return : 회원 메인 페이지로 이동
	 * @Method 설명 : 회원 정보를 수정한 후 메인 페이지로 이동  
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_USER_UPDATE_FORM, method = RequestMethod.POST)
	public String user_update_form(Authentication auth, User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity,
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("FAP 유저 수정 컨트롤러 시작");
		// 비밀번호 변경시 암호화; 입력 하지 않을 경우는 변경 되지 않음
		if(!user.getUser_pw().equals("")){
			String encodedPw = passwordEncoder.encode(user.getUser_pw());
			user.setUser_pw(encodedPw);
		}
		System.out.println("기본 유저 : " + user);
		System.out.println("개인 유저 : " + sfpUser);
		System.out.println("고등학교 : " + sfpHighschool);
		System.out.println("대학교 : " + sfpUniversity);
		System.out.println("대학원 : " + sfpGraduate);
		sfuService.user_update_form(user, sfpUser, sfpHighschool, sfpUniversity, sfpGraduate);
		
		logger.info("FAP 유저 수정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN;
	}
	
	/**
	 * @Method Name : user_delete
	 * @Date : 2020. 05. 06.
	 * @User : 김경아
	 * @Param : 탈퇴 할 회원 정보 객체
	 * @Return : JSP 리턴 페이지(메인페이지)
	 * @Method 설명 : 회원탈퇴하고 메인페이지로 이동하는 컨트롤러 함수

	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_DELETE, method = RequestMethod.POST)
	public String user_delete(User user, HttpSession session) {
		logger.debug("회원 탈퇴 컨트롤러 시작");

		// 회원탈퇴조치 서비스
		seuService.user_delete(user);

		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();

		logger.debug("회원 탈퇴 컨트롤러 종료");
		return "redirect:/fap/user/user_main/";
	}
	 */
	
	/**
	 * FAP 개인취업자 main 페이지로 이동  - 2018/12/06 정대영
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_MAIN, method = RequestMethod.GET)
	public String society_fap_user_main(Authentication auth
					, Model model,HttpServletRequest request
					, HttpServletResponse response
					, HttpSession session) {
		logger.debug("FAP 개인취업자 메인페이지 이동 종료");
		//메인페이지로 이동시 잡페어 정보 셀렉트해서 이동하는 코드
		LocaleUtil.setLocale(request, response);

		if(auth != null) {
			String user_id = (String) auth.getPrincipal();
			String user_flag = sfuService.select_user_flag(user_id);
			model.addAttribute("user_flag", user_flag);
			if(user_id != null) {
				int school_ck = sfuService.check_user_personal(user_id);
				if(school_ck == 0) {
					ArrayList<HashMap<String, Object>> kmoveList = sfuService.select_komve();
					Gson gson = new Gson();
					model.addAttribute("kmoveList", gson.toJson(kmoveList));
					model.addAttribute("user_id", user_id);
					return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_USER_INSERT_SCHOOL;
				}
			}
		}
			
		//기업 채용공고 리스트
		String locale = (String)LocaleUtil.getLocale(request).toString();
		String isIT = "";		
		HashMap<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("locale", locale);		
		
		SocietyFapMainpageContent result = sfaService.mainpage_ct_select();
		String fap_mainpage_ct_imp_code= result.getFap_mainpage_ct_imp_code();
		model.addAttribute("fap_mainpage_ct_imp_code", fap_mainpage_ct_imp_code);
		
		//가 == it직종 우선
		if(fap_mainpage_ct_imp_code.equals("가")) {
			paramMap.put("isIT", "yes");
			paramMap.put("fap_job_ad_groupcode", fap_mainpage_ct_imp_code);
			ArrayList<HashMap<String, Object>> mainpage_ct_IT = sfuService.select_mainpage_context(paramMap);
			model.addAttribute("mainpage_ct_IT", mainpage_ct_IT);
			
			paramMap.put("isIT", "no");
			ArrayList<HashMap<String, Object>> mainpage_ct_notIT = sfuService.select_mainpage_context(paramMap);
			model.addAttribute("mainpage_ct_notIT", mainpage_ct_notIT);
		} 
		//나 == 비it직종 우선
		else if(fap_mainpage_ct_imp_code.equals("나")) {
			paramMap.put("isIT", "no");
			paramMap.put("fap_job_ad_groupcode", fap_mainpage_ct_imp_code);
			ArrayList<HashMap<String, Object>> mainpage_ct_IT = sfuService.select_mainpage_context(paramMap);
			model.addAttribute("mainpage_ct_IT", mainpage_ct_IT);
			paramMap.put("isIT", "yes");
			ArrayList<HashMap<String, Object>> mainpage_ct_notIT = sfuService.select_mainpage_context(paramMap);
			model.addAttribute("mainpage_ct_notIT", mainpage_ct_notIT);
		}
		
//		paramMap.put("isIT", "yes"); //it직종
//		ArrayList<HashMap<String, Object>> mainpage_ct_IT = sfuService.select_mainpage_context(paramMap);
//		model.addAttribute("mainpage_ct_IT", mainpage_ct_IT);
//		
//		paramMap.put("isIT", "no"); //비it직종
//		ArrayList<HashMap<String, Object>> mainpage_ct_notIT = sfuService.select_mainpage_context(paramMap);
//		model.addAttribute("mainpage_ct_notIT", mainpage_ct_notIT);
		
		String divide_session = (String)session.getAttribute("divide_session");
		model.addAttribute("divide_session", divide_session);
		
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuService.select_fap_user_jobfair_info_list();
		model.addAttribute("jobfairInfoList", jobfairInfoList);
		logger.debug("FAP 개인취업자 메인페이지 이동 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_MAIN;
	}
	
	/**
	 * @Method Name : jobfair_entry_request
	 * @Date : 2018. 12. 10.
	 * @User : 정대영
	 * @Param : Int
	 * @Return : -
	 * @Method 설명 : FAP 취업지원자 잡페어 신청 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_ENTRY_REQUEST , method = RequestMethod.POST)
	public String entry_request(Authentication auth, @RequestParam(defaultValue="0") int fap_jobfair_seq, String fap_jobfair_title) {
		logger.debug("FAP 취업지원자 잡페어 신청 컨트롤러 시작");	
		String user_id = (String) auth.getPrincipal();
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("fap_jobfair_seq", fap_jobfair_seq);
		//잡페어 신청
		 int result = sfuService.user_jobfair_entry_request(map);		
		
		//알림게시판 내용추가		
		 if(result>0){			 
			 String fap_admin_notice_ct = "지원자 \'"+user_id+"\'가   \'"+fap_jobfair_title+"\' 잡페어에 참가 신청했습니다.";
			 HashMap<String, Object> paramMap = new HashMap<>();
			 paramMap.put("fap_admin_notice_ins_id", user_id);	 
			 paramMap.put("fap_jobfair_seq", fap_jobfair_seq);
			 paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			 paramMap.put("fap_admin_notice_handle_need_gb", "D2101");
			 paramMap.put("fap_admin_notice_handle_gb", "D2301");
			 int adminInfo = sfaService.insert_admin_notice_info(paramMap);		
		 }
		logger.debug("FAP 취업지원자 잡페어 신청 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_JOBFAIR_APPLY_TO_ATTEND_FORM;
	}
	
	/**
	 * @Method Name : user_job_advertisement_list_form
	 * @Date : 2018. 12. 13.
	 * @User : 정대영
	 * @Param : HttpSession
	 * @Return : JSP 취업지원자 채용공고 리스트폼으로 이동
	 * @Method 설명 : FAP 취업지원자 채용공고 리스트폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_LIST_FORM, method = RequestMethod.GET)
	public String user_job_advertisement_list_form(HttpSession session, Model model, 
			@RequestParam(defaultValue="1") int clickedPage, Authentication auth) {
		logger.debug("FAP 취업지원자 채용공고리스트 호출 컨트롤러 시작");
		
		//[start] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 시작
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");

		int fap_jobfair_divide_seq = 0;
		try{
			fap_jobfair_divide_seq = (int) jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		//[end] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 종료
		
		//paging start
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		paramMap.put("user_id",(String)auth.getPrincipal());
		
		int adTotalCount = sfuService.select_jobfair_job_advertisement_list_count(paramMap);
		PageNavigator repNavi = new PageNavigator(10, 5, clickedPage, adTotalCount);
		RowBounds rb = new RowBounds(repNavi.getStartRecord(), repNavi.getCountPerPage());
		int theNumberOfJobAd = adTotalCount - (repNavi.getPagePerGroup() * (repNavi.getCurrentPage() - 1));
		//paging end
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		params.put("user_id",(String)auth.getPrincipal());
		
		ArrayList<HashMap<String, Object>> jobAdvertisementList = sfuService.select_jobfair_job_advertisement_list(params, rb);
		if(repNavi.getCurrentPage() < 1){repNavi.setCurrentPage(1); repNavi.setStartPageGroup(1); repNavi.setEndPageGroup(1);}
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("theNumberOfJobAd", theNumberOfJobAd);
		model.addAttribute("jobAdvertisementList", jobAdvertisementList);
		logger.debug("FAP 취업지원자 채용공고리스트 호출 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_LIST_FORM;
	}
	
	/**
	 * @Method Name : user_forgot_id
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 아이디 찾기)
	 * @Method 설명 : 유저 아이디 찾기 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_FORGOT_ID, method = RequestMethod.GET)
	public String user_forgot_id(){
		logger.info("FAP 유저 아이디 찾기 이동 컨트톨러 시작");
		
		logger.info("FAP 유저 아이디 찾기 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_FORGOT_ID;
	}
	
	/**
	 * @Method Name : user_forgot_id_result
	 * @Date : 2018. 12. 24.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 아이디 찾기 결과 페이지)
	 * @Method 설명 : 유저 아이디 찾은 후 결과 페이지로 이동 후 아이디를 보여주는 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_FORGOT_ID_RESULT, method = RequestMethod.GET)
	public String user_forgot_id_result(HttpSession session, Model model) throws Exception{
		logger.info("FAP 유저 아이디 찾기 결과 이동 컨트톨러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");

		User user = new User();
		user.setUser_id(user_id);

		String found_id = sfuService.user_forgot_id(user);

		// 찾은 데이터를 모델에 담아서 보냄
		model.addAttribute("found", found_id);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");
		
		
		logger.info("FAP 유저 아이디 찾기 결과 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_FORGOT_ID_RESULT;
	}
	
	/**
	 * @Method Name : user_forgot_password
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 비밀번호 찾기)
	 * @Method 설명 : 유저 비밀번호 찾기 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_FORGOT_PASSWORD, method = RequestMethod.GET)
	public String user_forgot_password(){
		logger.info("FAP 유저 비밀번호 찾기 이동 컨트톨러 시작");
		
		logger.info("FAP 유저 비밀번호 찾기 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_FORGOT_PASSWORD;
	}
	
	/**
	 * @Method Name : user_forgot_password_form
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 
	 * @Return : JSP 리턴페이지(유저 비밀번호 찾기)
	 * @Method 설명 : 유저 비밀번호 찾기 폼 JSP로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_FORGOT_PASSWORD_FORM, method = RequestMethod.GET)
	public String user_forgot_password_form(HttpSession session) throws Exception{
		logger.info("FAP 유저 비밀번호 찾기 폼 이동 컨트톨러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			throw new Exception();
		}
		
		logger.info("FAP 유저 비밀번호 찾기 폼 이동 컨트톨러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_FORGOT_PASSWORD_FORM;
	}
	
	/**
	 * @Method Name : user_forgot_password_change
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 유저 비밀번호
	 * @Return : JSP 리턴페이지(유저 메인)
	 * @Method 설명 : 유저가 입력한 비밀번호로 비밀번호를 변경함
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_FORGOT_PASSWORD_CHANGE, method = RequestMethod.POST)
	public String user_forgot_password_change(HttpSession session, Model model, String user_pw) throws Exception{
		logger.debug("FAP 유저 비밀번호 변경 컨트롤러 시작");
		
		if(session.getAttribute("isCertificated") == null){
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_LOGIN_FORM;
		}
		
		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}
		String user_id = (String) session.getAttribute("user_id");

		boolean canChange = sfuService.user_forgot_password(user_id, user_pw);
		model.addAttribute("canChange", canChange);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");
		logger.debug("FAP 유저 비밀번호 변경 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_FORGOT_PASSWORD_RESULT;
	}
	
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2018. 12. 26.
	 * @User : 김준영
	 * @Param : 탈퇴할 회원 객체
	 * @Return : -
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_INFO_DELETE_FORM, method = RequestMethod.GET)
	public String delete_user_info_form(User user){
		logger.info("FAP  탈퇴 폼으로 이동 컨트롤러 시작");
		logger.info("FAP  탈퇴 폼으로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_INFO_DELETE_FORM;
	}
	
	/**
	 * @Method Name : apply_this_job_advertisement_form
	 * @Date : 2018. 12. 27.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : 취업지원자 지원하기 JSP로 이동
	 * @Method 설명 : FAP 취업지원자 잡페어 회사 지원하기 폼으로 이동  
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_APPLY_THIS_JOB_ADVERTISEMENT_FORM , method = RequestMethod.POST)
	public String apply_this_job_advertisement_form(@RequestParam HashMap<String, Object> advertisementInfoMap, Authentication auth, Model model, HttpSession session) {
		logger.debug("FAP 취업지원자 잡페어 회사 지원하기 폼으로 이동 요청 시작");
		String user_id = (String) auth.getPrincipal();
		advertisementInfoMap.put("user_id", user_id);
		//현재 지원가능한 지망 순위 및 회사이름과 같은 전반적인 지원 정보
		HashMap<String, Object> applyInfo = sfuService.select_company_name_and_apply_rank(advertisementInfoMap);
		model.addAttribute("applyInfo", applyInfo);
		
		//현재 유저의 이력서 리스트
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>)session.getAttribute("jobfairInfo");
		
		int fap_jobfair_seq = 0;
		int fap_jobfair_divide_seq = 0;
		try{
			fap_jobfair_seq = (Integer)jobfairInfo.get("fap_jobfair_seq");
			fap_jobfair_divide_seq = (Integer)jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		
		String fap_jobfair_divide_gb = sfuService.select_jobfair_divide_gb(fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_divide_gb", fap_jobfair_divide_gb);
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("user_id", user_id);
		paramMap.put("fap_jobfair_seq", fap_jobfair_seq);
		
		ArrayList<HashMap<String, Object>> resumeFormList = sfuService.select_my_resume_available_list(paramMap);
		model.addAttribute("resumeFormList", resumeFormList);
		logger.debug("FAP 취업지원자 잡페어 회사 지원하기 폼으로 이동 요청 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_APPLY_THIS_JOB_ADVERTISEMENT_FORM;
	}
	
	/**
	 * @Method Name : apply_this_job_advertisement
	 * @Date : 2018. 12. 28.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : 채용공고 목록 JSP로 이동
	 * @Method 설명 : FAP 취업지원자 해당 채용공고에 지원하기
	 */
	@Transactional
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_APPLY_THIS_JOB_ADVERTISEMENT , method = RequestMethod.POST)
	public String apply_this_job_advertisement(@RequestParam HashMap<String, Object> applyJobAdvertisementInfo, Authentication auth, Model model) {
		logger.debug("FAP 취업지원자 잡페어 회사 지원하기 요청 시작");
		String user_id = (String) auth.getPrincipal();
		applyJobAdvertisementInfo.put("user_id", user_id);
		int jobfaiAapplyResult = sfuService.apply_first_this_job_advertisement(applyJobAdvertisementInfo);
		if(jobfaiAapplyResult > 0){
			//잡페어 세부, 취업지원자별 지망 insert 및 update 끝나면 채용공고지원정보 테이블 insert
			sfuService.apply_second_this_job_advertisement(applyJobAdvertisementInfo);
		}
		logger.debug("FAP 취업지원자 잡페어 회사 지원하기 요청 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_LIST_FORM;
	}
	
	/**
	 * @Method Name : jobfair_job_advertisement_read_form
	 * @Date : 2019. 1. 3.
	 * @User : 정대영
	 * @Param : long
	 * @Return : JSP 취업지원자 채용공고 읽기 폼으로 이동
	 * @Method 설명 : FAP 취업지원자 채용공고 읽기 폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_READ_FORM , method = RequestMethod.GET)
	public String jobfair_job_advertisement_read_form(Model model, HttpSession session, long fap_job_ad_seq, Authentication auth, RedirectAttributes rttr) {
		logger.debug("FAP 취업지원자 채용공고읽기 컨트롤러 시작");
		
		//[start] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 시작
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		try{
			@SuppressWarnings("unused")
			int fap_jobfair_divide_seq = (int) jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		//[end] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 종료
		
		HashMap<String, Object> fapJobAdvertisement = new HashMap<>();
		fapJobAdvertisement.put("fap_jobfair_seq", (int) jobfairInfo.get("fap_jobfair_seq"));
		fapJobAdvertisement.put("fap_jobfair_divide_seq", (int) jobfairInfo.get("fap_jobfair_divide_seq"));
		fapJobAdvertisement.put("fap_job_ad_seq", fap_job_ad_seq);
		//읽기 폼으로 읽기 전에 해당 채용공고 지원가능한지 여부를 판단
		String user_id = (String)auth.getPrincipal();
		String whetherJobAdApply = sfuService.select_fap_jobfair_applicable_time(fapJobAdvertisement,user_id);
			
		model.addAttribute("whetherJobAdApply", whetherJobAdApply);
		
		//해당 채용공고관련 정보 Map
		/*HashMap<String, Object> jobAdvertisement = sfuService.select_jobfair_job_advertisement(fapJobAdvertisement);
		model.addAttribute("jobAdvertisement", jobAdvertisement);*/
		
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
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		
		// 회사 로고 정보
		SocietyFapCompanyUser company_info = sfcService.select_company_log(jobAd.getFap_comp_id());
		String info_json = gson.toJson(company_info);
		model.addAttribute("company_info", info_json);
		
		
		// 채용전형, 시험전형, 시험종류, 시험준비물, 시험감독관, 시험대상자, 시험문제파일
		ArrayList<HashMap<String, Object>> job_recruit_pcs = sfcService.select_job_recruit_pcs(fap_job_ad_seq);
		String job_recruit_pcs_json = gson.toJson(job_recruit_pcs);
		String replace_job_recruit_pcs_json =  job_recruit_pcs_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		model.addAttribute("job_recruit_pcs", replace_job_recruit_pcs_json);
		
		// 채용공고 파일정보(회사소개 동영상, 사진, pdf)
		ArrayList<SocietyFapJobFile> job_file = sfcService.select_job_file(fap_job_ad_seq);
		model.addAttribute("job_file",  gson.toJson(job_file));
		
		logger.debug("FAP 취업지원자 채용공고읽기 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_READ_FORM;
	}
	
	/**
	 * @Method Name : user_required_doc_management
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 취업지원자 내정서류관리 폼으로 이동
	 * @Method 설명 : FAP 취업지원자 내정서류관리 폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT , method = RequestMethod.GET)
	public String user_required_doc_management(Model model, Authentication auth) {
		logger.debug("FAP 취업지원자 내정서류관리 컨트롤러 시작");
		
		//내정기업 리스트 검색
		String user_id = (String)auth.getPrincipal();		
		ArrayList<HashMap<String, Object>> nominated_company_list = sfuService.search_nominated_company_list(user_id);
		model.addAttribute("nominated_company_list", nominated_company_list);
		
		logger.debug("FAP 취업지원자 내정서류관리 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : user_required_doc_insert
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 업로드할 개인 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 개인 내정서류 관리 페이지)
	 * @Method 설명 : 개인 내정서류 업로드 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String insert_user_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc user_required_doc, RedirectAttributes redirect){
		logger.info("내정자 내정서류 업로드 컨트롤러 시작");
				
		user_required_doc.setFap_personal_required_doc_ins_id((String)auth.getPrincipal());
		user_required_doc.setFap_personal_required_doc_udt_id((String)auth.getPrincipal());
		int result = sfuService.insert_user_required_doc(user_required_doc);
		
		//알림게시판에 관련정보 입력 
		if(result>0){			
			String user_id = (String)auth.getPrincipal();
			String fap_job_ad_title = sfaService.select_job_ad_title(user_required_doc.getFap_job_ad_seq());
			String fap_admin_notice_ct = "내정자 \'"+user_id+"\'가 채용공고  \'"+fap_job_ad_title+"\' 의 공통 내정서류를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", user_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2306");
			int adminInfo = sfaService.insert_admin_notice_info(paramMap);
		}
		
		redirect.addAttribute("param", user_required_doc.getFap_nominee_seq());
		
		logger.info("내정자 내정서류 업로드 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : user_required_doc_management_form
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 취업지원자 내정서류관리 폼으로 이동
	 * @Method 설명 : FAP 취업지원자 내정서류관리 폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT_FORM , method = RequestMethod.GET)
	public String user_required_doc_management_form(Model model, Authentication auth, @RequestParam("param") int fap_nominee_seq) {
		logger.debug("FAP 취업지원자 내정서류관리 컨트롤러 시작");
		
		//내정자 정보 검색
		SocietyFapNominee nominee_info = sfcService.select_nominee_info(fap_nominee_seq);
		model.addAttribute("nominee_info", nominee_info);
		//내정기업 리스트 검색
		String user_id = (String)auth.getPrincipal();		
		ArrayList<HashMap<String, Object>> nominated_company_list = sfuService.search_nominated_company_list(user_id);
		model.addAttribute("nominated_company_list", nominated_company_list);
				
		logger.debug("FAP 취업지원자 내정서류관리 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_update
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 내정자 내정서류정보
	 * @Return : JSP 리턴페이지(FAP 개인 내정서류 관리 페이지)
	 * @Method 설명 : 내정자 내정서류 수정 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_UPDATE, method = RequestMethod.POST)
	public String update_personal_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("FAP 취업지원자 내정서류 수정 컨트롤러 시작");
		
		personal_required_doc.setFap_personal_required_doc_udt_id((String)auth.getPrincipal());
		sfcService.update_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("FAP 취업지원자 내정서류 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_delete
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 삭제할 내정서류 정보
	 * @Return : JSP 리턴페이지(FAP 개인 내정서류 관리 페이지)
	 * @Method 설명 : 내정자 내정서류 삭제 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_PERSONAL_REQUIRED_DOC_DELETE, method = RequestMethod.GET)
	public String personal_required_doc_delete(Model model, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("FAP 취업지원자 내정서류 삭제 컨트롤러 시작");
		
		sfcService.delete_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("FAP 취업지원자 내정서류 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : user_process_schedule_calendar
	 * @Date : 2019. 1. 16.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(지원자 전형일정 캘린더 페이지)
	 * @Method 설명 : 지원자 전형일정 캘린더 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_PROCESS_SCHEDULE_CALENDAR, method = RequestMethod.GET)
	public String user_process_schedule_calendar(Model model){
		logger.info("FAP 취업지원자 전형일정 캘린더 페이지 이동 컨트롤러 시작");		
		logger.info("FAP 취업지원자 전형일정 캘린더 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : user_jobfair_apply_to_attend_form
	 * @Date : 2019. 2. 13.
	 * @User : 정대영
	 * @Param : -
	 * @Return : JSP 리턴페이지(취업지원자 잡페어 신청 페이지)
	 * @Method 설명 : FAP 취업지원자 잡페어 신청 페이지 이동 요청
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOBFAIR_APPLY_TO_ATTEND_FORM, method = RequestMethod.GET)
	public String user_jobfair_apply_to_attend_form(Model model, Authentication auth){
		logger.debug("FAP 취업지원자 잡페어 신청 페이지 이동 컨트롤러 시작");
		String user_id = (String) auth.getPrincipal();
		ArrayList<HashMap<String, Object>> jobfairInfoList = sfuService.select_fap_user_jobfair_per_user_info_list(user_id);
		model.addAttribute("jobfairInfoList", jobfairInfoList);
		logger.debug("FAP 취업지원자 잡페어 신청 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOBFAIR_APPLY_TO_ATTEND_FORM;
	}
	
	/**
	 * @Method Name : user_jobfair_participation_form
	 * @Date : 2019. 2. 14.
	 * @User : 정대영
	 * @Param : Int(fap_jobfair_seq)
	 * @Return : JSP 리턴페이지(해당잡페어 승인된 취업지원자 잡페어 세부선택 페이지)
	 * @Method 설명 : FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 페이지로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOBFAIR_PARTICIPATION_FORM, method = RequestMethod.GET)
	public String user_jobfair_participation_form(@RequestParam(defaultValue="0") int fap_jobfair_seq, Authentication auth, Model model){
		logger.debug("FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 페이지로 이동하는 컨트롤러 시작");
		String user_id = (String) auth.getPrincipal();
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_seq", fap_jobfair_seq);
		params.put("user_id", user_id);
		ArrayList<HashMap<String, Object>> jobfairDivideInfoList = sfuService.select_fap_user_jobfair_divide_info_list(params);
		model.addAttribute("jobfairDivideInfoList", jobfairDivideInfoList);
		logger.debug("FAP 취업지원자 해당잡페어 승인된 취업지원자 잡페어 세부선택 페이지로 이동하는 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOBFAIR_PARTICIPATION_FORM;
	}
	
	/**
	 * @Method Name : user_personal_apply_status_form
	 * @Date : 2019. 1. 15.
	 * @User : 정대영
	 * @Param : HashMap
	 * @Return : HashMap
	 * @Method 설명 : FAP 취업지원자 개인지원현황 리스트 출력
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_PERSONAL_APPLY_STATUS_FORM, method = RequestMethod.GET)
	public String user_personal_apply_status_form(Authentication auth, HttpSession session, Model model){
		logger.debug("FAP 취업지원자 개인지원현황 리스트 출력 컨트롤러 시작");
		HashMap<String, Object> userInfoMap = new HashMap<>();
		String user_id = (String) auth.getPrincipal();
		
		//[start] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 시작
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		try{
			@SuppressWarnings("unused")
			int fap_jobfair_divide_seq = (int) jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		//[end] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 종료
		
		userInfoMap.put("fap_jobfair_seq", (int) jobfairInfo.get("fap_jobfair_seq"));
		userInfoMap.put("fap_jobfair_divide_seq", (int) jobfairInfo.get("fap_jobfair_divide_seq"));
		userInfoMap.put("user_id", user_id);
		
		SocietyFapAdminFinalDecisionTime finalDecision = sfuService.final_decision_time_select_today((int) jobfairInfo.get("fap_jobfair_divide_seq"));
	    HashMap<String, Object> finalPersonalApplyStatusListMap = sfuService.select_personal_apply_status_list(userInfoMap);
	    model.addAttribute("finalPersonalApplyStatusListMap", finalPersonalApplyStatusListMap);
	    model.addAttribute("finalDecision", finalDecision);
	    model.addAttribute("fap_jobfair_divide_seq", (int) jobfairInfo.get("fap_jobfair_divide_seq"));
		logger.debug("FAP 취업지원자 개인지원현황 리스트 출력 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_PERSONAL_APPLY_STATUS_FORM;
	}
	
	/**
	 * @Method Name : user_job_advertisement_search_form
	 * @Date : 2019. 2. 15.
	 * @User : 정대영
	 * @Param : HttpSession
	 * @Return : JSP 취업지원자 채용공고 리스트폼으로 이동
	 * @Method 설명 : FAP 취업지원자 채용공고 리스트폼으로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_SEARCH_FORM, method = RequestMethod.GET)
	public String user_job_advertisement_search_form(HttpSession session, Model model) {
		logger.debug("FAP 취업지원자 잡페어 채용공고 상세검색 폼 요청 컨트롤러 시작");
		
		//[start] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 시작
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		int fap_jobfair_seq = 0;
		try{
			fap_jobfair_seq = (int) jobfairInfo.get("fap_jobfair_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		//[end] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 종료

		HashMap<String, Object> fapJobAdvertisement = new HashMap<>();
		fapJobAdvertisement.put("fap_jobfair_seq", fap_jobfair_seq);
		//채용공고 리스트폼에 가져갈 등록된 잡페어 그룹코드를 부르는 부분
		ArrayList<HashMap<String, Object>> companyGroupCodeList = sfuService.select_company_group_code_list(fapJobAdvertisement);
		model.addAttribute("companyGroupCodeList", companyGroupCodeList);
		logger.debug("FAP 취업지원자 잡페어 채용공고 상세검색 폼 요청 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_SEARCH_FORM;
	}

	/**
	 * @Method Name : user_total_apply_status_form
	 * @Date : 2019. 2. 22.
	 * @User : 정대영
	 * @Param : HttpSession
	 * @Return : JSP 취업지원자 전체지원현황 JSP로 이동
	 * @Method 설명 : FAP 취업지원자 전체지원현황 요청(JSP로 이동)
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_TOTAL_APPLY_STATUS_FORM , method = RequestMethod.GET)
	public String user_total_apply_status_form(HttpSession session, Model model, Authentication auth) {
		logger.debug("FAP 취업지원자 전체지원현황 요청(JSP로 이동) 컨트롤러 시작");
		
		//[start] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 시작
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		int fap_jobfair_divide_seq = 0;
		try{
			fap_jobfair_divide_seq = (int) jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		//[end] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 종료
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", (String) auth.getPrincipal());
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		
		ArrayList<HashMap<String, Object>> perJobfairTotalApplyList = sfuService.select_job_ad_total_application_status(params);
		model.addAttribute("perJobfairTotalApplyList", perJobfairTotalApplyList);
		logger.debug("FAP 취업지원자 전체지원현황 요청(JSP로 이동) 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_TOTAL_APPLY_STATUS_FORM;
	}
	
	/**
	 * @Method Name : select_my_favorite_company_list
	 * @Date : 2018. 12. 17.
	 * @User : 정대영
	 * @Param : Session
	 * @Return : FapMyFavoriteCompanyList
	 * @Method 설명 : FAP 채용정보메뉴에서 내가담은기업보기 탭을 누르면 Ajax로 내가담은기업보기 출력시킴
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_MY_FAVORITE_COMPANY_LIST_FORM, method = RequestMethod.GET)
	public String my_favorite_company_list(Authentication auth, HttpSession session, Model model){
		logger.debug("FAP 내가담은목록 출력 컨트롤러 시작");
		HashMap<String, Object> params = new HashMap<>();
		
		//[start] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 시작
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");
		int fap_jobfair_divide_seq = 0;
		try{
			fap_jobfair_divide_seq = (int) jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		//[end] 세션 만료로 인한 예외 발생시 메인페이지로 이동시키는 예외처리 종료
		
		params.put("user_id", (String) auth.getPrincipal());
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		ArrayList<HashMap<String, Object>> favoriteCompanyList = sfuService.select_my_favorite_company_list(params);
		model.addAttribute("favoriteCompanyList", favoriteCompanyList);
		logger.debug("FAP 내가담은목록 출력 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_MY_FAVORITE_COMPANY_LIST_FORM;
	}
	
	/**
	 * @Method Name : user_school_insert
	 * @Date : 2019. 2. 25.
	 * @User : 김준영
	 * @Param : 개인 유저 정보, 학교 정보
	 * @Return : JSP 리턴페이지(메인페이지로 이동)
	 * @Method 설명 : 회원의 학교 정보를 입력한 후 메인페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_INSERT_SCHOOL, method = RequestMethod.GET)
	public String user_school_insert_form(Model model){
		logger.info("FAP 회원 학교 정보 입력폼 이동 컨트롤러 시작");
		
		// 교육기관 불러오기
		ArrayList<HashMap<String, Object>> kmoveList = sfuService.select_komve();
		model.addAttribute("kmoveList", kmoveList);
		
		logger.info("FAP 회원 학교 정보 입력 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_INSERT_SCHOOL;
	}
	
	/**
	 * @Method Name : user_school_insert
	 * @Date : 2019. 2. 25.
	 * @User : 김준영
	 * @Param : 개인 유저 정보, 학교 정보
	 * @Return : JSP 리턴페이지(메인페이지로 이동)
	 * @Method 설명 : 회원의 학교 정보를 입력한 후 메인페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_INSERT_SCHOOL, method = RequestMethod.POST)
	public String user_school_insert(SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity, 
			SocietyFapPersonalGraduate sfpGraduate){
		logger.info("FAP 회원 학교 정보 입력 컨트롤러 시작");
		sfuService.user_school_insert(sfpUser, sfpHighschool, sfpUniversity, sfpGraduate);
		logger.info("FAP 회원 학교 정보 입력 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN;
	}
	
	
	/**
	 * @Method Name : user_board_content_list
	 * @Date : 2019. 7. 17.
	 * @User : 김경아
	 * @Param : -
	 * @Return : JSP 리턴페이지(공지사항 게시판 리스트)
	 * @Method 설명 : 잡페어 공지사항 리스트 페이지 이동
	 */	 
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_BOARD_CONTENT_LIST, method = RequestMethod.GET)
	public String user_board_content_list(Model model, BoardGroup boardGroup, String board_detail_gb, String board
			,@RequestParam(defaultValue="1") int curPage			
			,@RequestParam(defaultValue="10") int pageCount
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
		}else if(board.equals("internship")){ //미국인턴십게시판
			map.put("board_detail_gb", BOARD_INTERNSHIP_CODE);
		}
		
		int count = sfuService.board_contents_count(map);	 
	 
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		
		map.put("count", count);  
		map.put("adminPager", adminPager);		 
		
		//글 리스트
		ArrayList<BoardContent> resultList = sfuService.user_board_contents_list_search(map);
		
		//제목 
		 String board_nm = sfuService.select_user_board_nm(board_detail_gb);
		 map.put("board_nm",board_nm);

		 
		 model.addAttribute("resultList", resultList);
		 model.addAttribute("map", map);
		 model.addAttribute("boardGroup", boardGroup);
		
		logger.debug("잡페어 공지사항 리스트 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_BOARD_CONTENT_LIST;
	}
	 
	/**
	 * @Method Name : user_board_contents_detail
	 * @Date : 2019. 7. 17.
	 * @User : 김경아
	 * @Param : 게시판 세부내용 시퀀스, 게시판 구분, 게시판 타입
	 * @Return : JSP 리턴페이지(게시판 세부내용)
	 * @Method 설명 : 잡페어 공지사항 게시판 세부내용 검색
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_BOARD_CONTENTS_DETAIL, method = RequestMethod.GET)
	public String user_board_contents_detail(int board_content_seq, Model model, BoardGroup boardGroup
			, String board_detail_gb, Authentication auth){
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 시작");
       
		//조회수 증가
		seaService.board_contents_hit_update(board_content_seq);
		//조회
		HashMap<String, Object> resultMap = sfcService.board_contents_detail(board_content_seq);
		resultMap.put("board_detail_gb", board_detail_gb);
		// String path = seaService.findPath(boardGroup.getBoard_gb(), boardGroup.getBoard_tp());
		model.addAttribute("contentDetail", resultMap);	 
		// model.addAttribute("path", path);
		
		//미국인턴십 게시판인 경우 지원여부 조회
		if(board_detail_gb.equals("A1706")) {
			String user_id = (String) auth.getPrincipal();
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("board_content_seq", board_content_seq);
			params.put("user_id", user_id);
			
			model.addAttribute("internship_apply", sfuService.select_internship(params));
		}
		
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_BOARD_CONTENTS_DETAIL_FORM;
	}
	
	/**
	 * @Method Name : internship_apply
	 * @Date : 2021. 04. 16
	 * @User : 김나영
	 * @Param : 게시글 시퀀스, 사용자정보(ID, 이름, 연락처, 이메일)
	 * @Return : -
	 * @Method 설명 : 미국인턴십 지원
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_INTERNSHIP_APPLY, method = RequestMethod.POST)
	public Object internship_apply(@RequestParam HashMap<String, Object> params, Authentication auth){
		logger.debug("미국인턴십 지원 시작");
		String user_id = (String) auth.getPrincipal();
		params.put("user_id", user_id);
		logger.debug("미국인턴십 지원 종료");
		return sfuService.internship_apply(params);
	}
	/**
	 * @Method Name : internship_apply
	 * @Date : 2021. 04. 16
	 * @User : 김나영
	 * @Param : 게시글 시퀀스, 사용자정보(ID, 이름, 연락처, 이메일)
	 * @Return : -
	 * @Method 설명 : 미국인턴십 지원취소
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_INTERNSHIP_CANCEL, method = RequestMethod.POST)
	public Object internship_cancel(@RequestParam HashMap<String, Object> params){
		logger.debug("미국인턴십 지원취소 시작");
		logger.debug("미국인턴십 지원취소 종료");
		return sfuService.internship_cancel(params);
	}
	/**
	 * @Method Name : user_job_qna_management
	 * @Date : 2019. 3. 8.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 관리 페이지 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_QNA_MANAGEMENT, method = RequestMethod.GET)
	public String user_job_qna_management(Model model, Authentication auth, long fap_job_ad_seq){
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 시작");	
		
		ArrayList<HashMap<String, Object>> job_qna_list = sfuService.select_job_qna(fap_job_ad_seq);
		
		Gson gson = new Gson();
		
		model.addAttribute("job_qna_list", gson.toJson(job_qna_list));
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 끝");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOB_QNA_MANAGEMENT;
	}
	
	/**
	 * @Method Name : user_job_insert
	 * @Date : 2019. 3. 8.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 등록 페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_QNA_INSERT, method = RequestMethod.GET)
	public String user_job_qna_insert(Model model, Authentication auth, long fap_job_ad_seq){
		logger.info("FAP 채용공고 Q&A 질문 등록 페이지 이동 시작");	
		
		
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		
		
		logger.info("FAP 채용공고 Q&A 질문 등록 페이지 이동 끝");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOB_QNA_INSERT;
	}
	
	
	/**
	 * @Method Name : user_job_insert
	 * @Date : 2019. 3. 8.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_QNA_INSERT, method = RequestMethod.POST)
	public String user_job_qna_insert2(Model model, Authentication auth, SocietyFapQnaQuestion qna_q){
		logger.info("FAP 채용공고 Q&A 질문 등록 시작");	
		
		String user_id = (String) auth.getPrincipal();
		
		qna_q.setFap_job_qna_question_ins_id(user_id);
		qna_q.setFap_job_qna_question_udt_id(user_id);
		
		int result = sfuService.insert_job_qna_question(qna_q);	
		
		//알림게시판에 관련정보 추가 
		 if(result>0){
			 String fap_job_ad_title = sfaService.select_job_ad_title(qna_q.getFap_job_ad_seq());
				
				String fap_admin_notice_ct = "지원자 \'"+user_id+"\'이(가) 채용공고 \'"+fap_job_ad_title+"\' 에 질문글  \'"+qna_q.getFap_job_qna_question_title()+"\' 을 남겼습니다.";
				HashMap<String, Object> paramMap = new HashMap<>();
				paramMap.put("fap_admin_notice_ins_id", user_id);	 
				paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
     			paramMap.put("fap_admin_notice_handle_need_gb", "D2101");
				paramMap.put("fap_admin_notice_handle_gb","D2303");
				int adminInfo = sfaService.insert_admin_notice_info(paramMap);	
		 }
				
		logger.info("FAP 채용공고 Q&A 질문 등록 끝");		
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_JOB_QNA_MANAGEMENT + "?fap_job_ad_seq=" + qna_q.getFap_job_ad_seq();
	}
	
	/**
	 * @Method Name : user_job_qna
	 * @Date : 2019. 3. 11.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 일련번호
	 * @Return : 
	 * @Method 설명 : 해당 Q&A 상세
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_QNA, method = RequestMethod.GET)
	public String company_job_qna(Model model, Authentication auth, long fap_job_qna_question_seq){
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 시작");	
		
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
		
		logger.info("FAP 채용공고 Q&A 이동 컨트롤러 끝");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_JOB_QNA;
	}
	
	/**
	 * @Method Name : user_job_update
	 * @Date : 2019. 3. 11.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 수정
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_QNA_UPDATE, method = RequestMethod.POST)
	public String user_job_qna_update(Model model, Authentication auth, SocietyFapQnaQuestion qna_q){
		logger.info("FAP 채용공고 Q&A 질문 수정 시작");	
		
		String user_id = (String) auth.getPrincipal();
		
		qna_q.setFap_job_qna_question_udt_id(user_id);
		
		sfuService.update_job_qna_question(qna_q);
		
		logger.info("FAP 채용공고 Q&A 질문 수정 끝");		
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_JOB_QNA_MANAGEMENT + "?fap_job_ad_seq=" + qna_q.getFap_job_ad_seq();
	}
	
	/**
	 * @Method Name : user_job_delete
	 * @Date : 2019. 3. 11.
	 * @User : 원병호
	 * @Param : 채용공고 Q&A 객체
	 * @Return : 
	 * @Method 설명 : 채용공고 Q&A 삭제
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_JOB_QNA_DELETE, method = RequestMethod.GET)
	public String user_job_qna_delete(Model model, Authentication auth, long fap_job_qna_question_seq, long fap_job_ad_seq){
		logger.info("FAP 채용공고 Q&A 질문 수정 시작");	
		
		sfuService.delete_job_qna_question(fap_job_qna_question_seq);
		
		logger.info("FAP 채용공고 Q&A 질문 수정 끝");		
		return "redirect:" + PathConstants.SOCIETY_FAP_USER_JOB_QNA_MANAGEMENT + "?fap_job_ad_seq=" + fap_job_ad_seq;
	}
	
	/**
	 * @Method Name : user_roadmap_image
	 * @Date : 2019. 4. 2.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 회원 로드맵 이미지 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_ROADMAP_IMAGE, method = RequestMethod.GET)
	public String user_roadmap_image(){
		logger.info("FAP 회원 로드맵 이미지 페이지 이동 시작");
		
		logger.info("FAP 회원 로드맵 이미지 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_ROADMAP_IMAGE;
	}
	
	/**
	 * @Method Name : user_main_popup
	 * @Date : 2019. 4. 5.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 메인페이지 팝업창
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_MAIN_POPUP, method = RequestMethod.GET)
	public String user_main_popup(Model model, int fap_popup_seq) {	
		logger.info("FAP 메인페이지 팝업창 시작");
		SocietyFapPopup popup = sfaService.fap_popup_select_one(fap_popup_seq);
		
		model.addAttribute("popup", popup);
		logger.info("FAP 메인페이지 팝업창 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_MAIN_POPUP;
	}
	
	/**
	 * @Method Name : user_open_pt_popup
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 메인페이지 설명회 팝업창
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_OPEN_PT_POPUP, method = RequestMethod.GET)
	public String user_open_pt_popup(Model model, int fap_popup_seq) {	
		logger.info("FAP 메인페이지 설명회 팝업창 시작");
		SocietyFapPopup popup = sfaService.fap_popup_select_one(fap_popup_seq);
		
		model.addAttribute("popup", popup);
		logger.info("FAP 메인페이지 설명회 팝업창 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_OPEN_PT_POPUP;
	}
	
	/**
	 * @Method Name : user_open_edu_popup
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 메인페이지 구직자 교육 팝업창
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_OPEN_EDU_POPUP, method = RequestMethod.GET)
	public String user_open_edu_popup(Model model, int fap_popup_seq) {	
		logger.info("FAP 메인페이지 구직자 교육 팝업창 시작");
		SocietyFapPopup popup = sfaService.fap_popup_select_one(fap_popup_seq);
		
		model.addAttribute("popup", popup);
		logger.info("FAP 메인페이지 구직자 교육 팝업창 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_OPEN_EDU_POPUP;
	}
	
	/**
	 * @Method Name : user_faq
	 * @Date : 2019. 4. 10.
	 * @User : 이종호
	 * @Param : 페이지번호,검색어,FAQ구분
	 * @Return : FAP 회원 FAQ 정보
	 * @Method 설명 : FAP 회원 FAQ 페이지
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_FAQ, method = RequestMethod.GET)
	public String user_faq(Model model,@RequestParam(defaultValue="1") int page 
			, @RequestParam(defaultValue="") String searchText
			, @RequestParam(defaultValue="C5300") String fap_faq_gb_cd) {
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_faq_gb_cd", fap_faq_gb_cd);
		paramMap.put("searchText", searchText);
		
		int total = sfaService.fap_faq_select_list_gb_count(paramMap);
		PageNavigator navi = new PageNavigator(5, 5, page, total);
		ArrayList<HashMap<String, Object>> faqList = sfaService.fap_faq_select_list_gb(paramMap,navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("faqList", faqList);
		model.addAttribute("navi", navi);
		model.addAttribute("fap_faq_gb_cd", fap_faq_gb_cd);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_FAQ;
	}
	
	/**
	 * @Method Name : open_pt_info_select
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 정보
	 * @Method 설명 : 노출된 오픈잡페어 설명회 정보 조회
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_INFO, method = RequestMethod.GET)
	public String open_pt_info_select(Model model) {
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 조회 컨트롤러 시작");
		SocietyFapOpenPt result = sfuService.open_pt_info_select();
		
		model.addAttribute("result", result);
		
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_OPEN_PT_INFO;
	}
	
	/**
	 * @Method Name : open_pt_edu_info_select
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 구직자 교육 정보
	 * @Method 설명 : 노출된 오픈잡페어 구직자 교육 정보 조회
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_EDU_INFO, method = RequestMethod.GET)
	public String open_pt_edu_info_select(Model model, Authentication auth) {
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 정보 조회 컨트롤러 시작");
		SocietyFapOpenPt result = sfuService.open_pt_edu_info_select();
		
		ArrayList<SocietyFapUserResumeForm> resumeList = new ArrayList<>();

		if(auth != null) {
			String user_id = (String)auth.getPrincipal();
			resumeList = sfuService.user_open_edu_resume_list_select(user_id);
		}
		
		model.addAttribute("result", result);
		model.addAttribute("resumeFormList", resumeList);
		
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 정보 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_OPEN_PT_EDU_INFO;
	}
	
	/**
	 * @Method Name : open_pt_edu_apply
	 * @Date : 2019. 4. 15.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 노출된 오픈잡페어 구직자 교육 정보 페이지 이동.
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_EDU_INFO_LOGIN, method = RequestMethod.GET)
	public String open_pt_edu_apply() {
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 정보 페이지 이동 컨트롤러 시작");
		
		logger.info("FAP 노출된 오픈잡페어 구직자 교육 정보 페이지 이동 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_OPEN_PT_EDU_INFO;
	}
	
	/**
	 * @Method Name : open_pt_apply
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 노출된 오픈잡페어 설명회 정보 페이지 이동.
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_INFO_LOGIN, method = RequestMethod.GET)
	public String open_pt_apply() {
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 페이지 이동 컨트롤러 시작");
		logger.info("FAP 노출된 오픈잡페어 설명회 정보 페이지 이동 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_USER_OPEN_PT_INFO;
	}
	
	/**
	 * @Method Name : open_pt_applied_form
	 * @Date : 2019. 4. 12.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : 마이페이지 오픈잡페어 설명회 신청 내역 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_OPEN_PT_APPLIED_FORM, method = RequestMethod.GET)
	public String open_pt_applied_form() {
		logger.info("FAP 마이페이지 오픈잡페어 설명회 신청 내역 폼 이동 컨트롤러 시작");
		logger.info("FAP 마이페이지 오픈잡페어 설명회 신청 내역 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_OPEN_PT_APPLIED_FORM;
	}
	
	/**
	 * @Method Name :  user_open_comp_banner_list
	 * @Date : 2019. 7. 17. 
	 * @User : 김경아
	 * @Param :  회사아이디, 채용공고 시퀀스 
	 * @Return :  기업배너정보 
	 * @Method 설명 : FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value= PathConstants.SOCIETY_FAP_USER_OPEN_COMP_BANNER_LIST, method=RequestMethod.GET)
	public String  user_open_comp_banner_list  (Model model	 
			, @RequestParam int fap_jobfair_seq
			, @RequestParam int fap_jobfair_divide_seq
			){
		logger.info("FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회  컨트롤러 시작");
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("fap_jobfair_seq", fap_jobfair_seq);
		paramMap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		List<HashMap<String,Object>> result = sfuService.user_open_comp_banner_list(paramMap);	
		logger.info("FAP 오픈잡페어 지원자 메인페이지 기업배너 리스트 조회  컨트롤러 종료");
		System.out.println("bannerList"+result);
		model.addAttribute("bannerList", result);
		return "/angTest";
	}
	 
	/**
	 * @Method Name : user_ses_user_service
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 지원자 SES 회원서비스 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_SES_USER_SERVICE, method = RequestMethod.GET)
	public String user_ses_user_service(){
		logger.info("FAP 지원자 SES 회원서비스 페이지 이동 시작");
		
		logger.info("FAP 지원자 SES 회원서비스 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_SES_USER_SERVICE;
	}
	
	/**
	 * @Method Name : user_2020_fair_schedule
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 지원자 2020 Fair 일정 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_2020_FAIR_SCHEDULE, method = RequestMethod.GET)
	public String user_2020_fair_schedule(){
		logger.info("FAP 지원자 2020 Fair 일정 페이지 이동 시작");
		
		logger.info("FAP 지원자 2020 Fair 일정 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_2020_FAIR_SCHEDULE;
	}
	
	/**
	 * @Method Name : user_step
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 지원자 전형절차 페이지 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_STEP, method = RequestMethod.GET)
	public String user_step(){
		logger.info("FAP 지원자 전형절차 페이지 이동 시작");
		
		logger.info("FAP 지원자 전형절차 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_STEP;
	}
	
	/**
	 * @Method Name : user_comps_and_partners
	 * @Date : 2019. 7. 24.
	 * @User : 김경아
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 지원자 채용기업&파트너사 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_USER_COMPS_AND_PARTNERS, method = RequestMethod.GET)
	public String user_comps_and_partners(){
		logger.info("FAP 지원자 채용기업&파트너사 페이지 이동 시작");
		
		logger.info("FAP 지원자 채용기업&파트너사 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + SOCIETY_FAP_USER_COMPS_AND_PARTNERS;
	}

	/**
	 * @Method Name : user_mainpage_content_read
	 * @Date : 2019. 9. 4.
	 * @User : 이종호
	 * @Param : 잡페어 시퀀스 , 세부 잡페어 시퀀스 , 채용공고 시퀀스
	 * @Return : -
	 * @Method 설명 : 메인페이지 기업컨텐츠 클릭시 로그인 및 잡페어 참가 승인 확인 후 채용공고 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_MAINPAGE_CONTENT_READ, method = RequestMethod.GET)
	public String user_mainpage_content_read(HttpSession session,Authentication auth, int fap_jobfair_seq , int fap_jobfair_divide_seq, String fap_jobfair_title, long fap_job_ad_seq) {
		
		String path = "";
		//비 로그인일때 로그인폼으로 이동 - 시큐리티로 처리
		
		//잡페어 미 참가 혹은 미 승인 시 참가 페이지로 이동
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id", (String)auth.getPrincipal());
		params.put("fap_jobfair_seq",fap_jobfair_seq);
		int count = sfuService.check_jobfair_join(params);
		if(count == 0) {
			path = PathConstants.SOCIETY_FAP_USER_JOBFAIR_APPLY_TO_ATTEND_FORM;
		} else {
			HashMap<String, Object> jobfairInfo = new HashMap<>();
			jobfairInfo.put("fap_jobfair_seq", fap_jobfair_seq);
			jobfairInfo.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
			jobfairInfo.put("fap_jobfair_title", fap_jobfair_title);
			session.removeAttribute("jobfairInfo");
			session.setAttribute("jobfairInfo", jobfairInfo);
			path = PathConstants.SOCIETY_FAP_USER_JOB_ADVERTISEMENT_READ_FORM+"?fap_job_ad_seq="+fap_job_ad_seq;
		}
		//정상 처리시 채용공고 읽기 페이지로 리다이렉트
		
		return "redirect:"+path;
	}
	
	/**
	 * @Method Name : user_tokyofair_schedule_form
	 * @Date : 2019. 10. 15.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 도쿄페어 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 일정 정보 확인 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_TOKYOFAIR_SCHEDULE_FORM, method = RequestMethod.GET)
	public String user_tokyofair_schedule_form(Authentication auth,HttpSession session, Model model) {
		logger.info("FAP 도쿄페어 일정 정보 확인 폼 이동 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");

		int fap_jobfair_divide_seq = 0;
		try{
			fap_jobfair_divide_seq = (int) jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		
		HashMap<String, Object> tokyofairUserMap = sfuService.tokyofair_schedule_user_list(params);
		
		Gson gson = new Gson();
		
		String info_json = gson.toJson(tokyofairUserMap);
		String replace_json = info_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		model.addAttribute("tokyofairUserMap", replace_json);
		
		logger.info("FAP 도쿄페어 일정 정보 확인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_TOKYOFAIR_SCHEDULE_FORM;
	}
	
	/**
	 * @Method Name : user_tokyofair_schedule_print_form
	 * @Date : 2019. 10. 15.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 도쿄페어 일정 정보 리스트
	 * @Method 설명 : 도쿄페어 일정 정보 인쇄 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_USER_TOKYOFAIR_SCHEDULE_PRINT_FORM, method = RequestMethod.POST)
	public String user_tokyofair_schedule_print_form(Authentication auth,HttpSession session, Model model) {
		logger.info("FAP 도쿄페어 일정 정보 인쇄 폼 이동 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		
		@SuppressWarnings("unchecked")
		HashMap<String, Object> jobfairInfo = (HashMap<String, Object>) session.getAttribute("jobfairInfo");

		int fap_jobfair_divide_seq = 0;
		try{
			fap_jobfair_divide_seq = (int) jobfairInfo.get("fap_jobfair_divide_seq");
		}catch(NullPointerException e){
			session.setAttribute("divide_session", "divide_check");
			return "redirect:" + PathConstants.SOCIETY_FAP_USER_MAIN ;
		}
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("user_id", user_id);
		params.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		
		HashMap<String, Object> tokyofairUserMap = sfuService.tokyofair_schedule_user_list(params);
		
		Gson gson = new Gson();
		
		String info_json = gson.toJson(tokyofairUserMap);
		String replace_json = info_json.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");
		
		model.addAttribute("tokyofairUserMap", replace_json);
		
		logger.info("FAP 도쿄페어 일정 정보 인쇄 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_USER_TOKYOFAIR_SCHEDULE_PRINT_FORM;
	}
}