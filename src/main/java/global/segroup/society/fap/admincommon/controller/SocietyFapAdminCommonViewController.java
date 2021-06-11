/**
 * 
 */
package global.segroup.society.fap.admincommon.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Workbook;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import global.segroup.domain.AdminPager;
import global.segroup.domain.AdminSecurity;
import global.segroup.domain.BoardContent;
import global.segroup.domain.BoardFile;
import global.segroup.domain.BoardGroup;
import global.segroup.domain.FaqConsultingContents;
import global.segroup.domain.User;
import global.segroup.domain.UserSecurity;
import global.segroup.exception.ExpiredDateException;
import global.segroup.society.edu.admin.service.SocietyEduAdminService;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminFaqGb;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfair;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairCompGroup;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivide;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairDivideRc;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminJobfairLo;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminLimitInterview;
import global.segroup.society.fap.admincommon.domain.SocietyFapAdminNoticeContent;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobRecruitPcsSch;
import global.segroup.society.fap.admincommon.domain.SocietyFapJobfairApplicableTime;
import global.segroup.society.fap.admincommon.domain.SocietyFapMainpageContent;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenJobInfo;
import global.segroup.society.fap.admincommon.domain.SocietyFapOpenPt;
import global.segroup.society.fap.admincommon.domain.SocietyFapPerJobfairDivideTemp;
import global.segroup.society.fap.admincommon.domain.SocietyFapPerJobfairTempGroup;
import global.segroup.society.fap.admincommon.domain.SocietyFapPopup;
import global.segroup.society.fap.admincommon.service.SocietyFapAdminCommonService;
import global.segroup.society.fap.company.domain.SocietyFapCommonRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapCompanyUser;
import global.segroup.society.fap.company.domain.SocietyFapJobExam;
import global.segroup.society.fap.company.domain.SocietyFapJobExamFile;
import global.segroup.society.fap.company.domain.SocietyFapJobExamNeedEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamSvEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobExamType;
import global.segroup.society.fap.company.domain.SocietyFapJobItv;
import global.segroup.society.fap.company.domain.SocietyFapJobItvObjEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobItvTpEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobRecruitPcs;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtc;
import global.segroup.society.fap.company.domain.SocietyFapJobTestEtcObj;
import global.segroup.society.fap.company.domain.SocietyFapPersonalRequiredDoc;
import global.segroup.society.fap.company.domain.SocietyFapTokyofairScreening;
import global.segroup.society.fap.company.service.SocietyFapCompanyService;
import global.segroup.society.fap.companyroadmap.service.SocietyFapCompanyRoadmapService;
import global.segroup.society.fap.user.domain.SocietyFapNominee;
import global.segroup.society.fap.user.domain.SocietyFapPersonalGraduate;
import global.segroup.society.fap.user.domain.SocietyFapPersonalHighschool;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUniversity;
import global.segroup.society.fap.user.domain.SocietyFapPersonalUser;
import global.segroup.society.fap.user.domain.SocietyFapUserApplyNumbers;
import global.segroup.society.fap.user.service.SocietyFapUserService;
import global.segroup.util.ExcelUtil;
import global.segroup.util.FileService;
import global.segroup.util.MailService;
import global.segroup.util.PageNavigator;
import global.segroup.util.PathConstants;

/**
 * @Author : 신동철
 * @Date : 2018. 11. 29.
 * @Class 설명 : Soft Engineer Society 통합잡페어 관리자 View 컨트롤러
 * 
 */

@Controller
public class SocietyFapAdminCommonViewController implements PathConstants {
	
	private static final Logger logger = LoggerFactory.getLogger(SocietyFapAdminCommonViewController.class);
	
	@Autowired
	private SocietyFapAdminCommonService sfaService;
	
	@Autowired
	private SocietyFapCompanyService sfcService;
		
	@Autowired
	private SocietyFapUserService sfuService;
	
	@Autowired
	private SocietyFapCompanyRoadmapService sfcrService;
	
	@Autowired
	private SocietyEduAdminService seaService;
	
	/**
	 * file.propertices 의 채용전형 시험 파일 경로
	 */
	@Value("#{props['fap.company.job_recruit_exam_file']}")
	private String fapCompanyJobRecruitExamFile;
	
	/**
	 * file.propertices 의 잡페어 로고 파일 경로
	 */
	@Value("#{props['fap.admin.jobfair_logo_image']}")
	private String fapAdminJobfairLogoImage;
		
	/**
	 * @Method Name : jobfair_management
	 * @Date : 2018. 12. 3.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 잡페어 관리 폼)
	 * @Method 설명 : 관리자 페이지에서 잡페어 관리 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_MANAGEMENT, method = RequestMethod.GET)
	public String jobfair_management(Model model){
		logger.info("잡페어 관리페이지 이동 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.info("잡페어 관리페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : jobfair_insert
	 * @Date : 2018. 12. 3.
	 * @User : 신동철
	 * @Param : 잡페어 등록 정보
	 * @Return : JSP 리턴페이지(FAP 잡페어 관리 폼)
	 * @Method 설명 : 잡페어 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_INSERT, method = RequestMethod.POST)
	public String jobfair_insert(Model model, Authentication auth, SocietyFapAdminJobfair sfaJobfair, SocietyFapAdminJobfairDivide sfaJobfairDivide,
				SocietyFapAdminJobfairLo sfaJobfairLo, SocietyFapAdminJobfairDivideRc sfaJobfairDivideRc, SocietyFapAdminJobfairCompGroup sfaJobfairCompGroup,
				SocietyFapJobfairApplicableTime jobfairApplicableTime, SocietyFapAdminLimitInterview limitInterview){
		logger.info("잡페어 등록 컨트롤러 시작");		
		
		sfaJobfair.setFap_jobfair_ins_id((String)auth.getPrincipal());
		sfaJobfair.setFap_jobfair_udt_id((String)auth.getPrincipal());
		sfaService.insert_Jobfair(sfaJobfair, sfaJobfairDivide, sfaJobfairLo, sfaJobfairDivideRc, sfaJobfairCompGroup, jobfairApplicableTime, limitInterview);
		
		logger.info("잡페어 등록 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_MANAGEMENT;
	}
	
	/**
	 * @Method Name : admin_security_invalidate
	 * @Date : 2018. 12. 4
	 * @User : 이종호
	 * @Param : 세션정보
	 * @Return : 관리자 로그인 페이지
	 * @Method 설명 : 현재 세션정보를 초기화 하고 관리자 로그인 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_SECURITY_INVALIDATE , method = RequestMethod.GET)
	public String admin_security_invalidate(HttpSession session) {
		logger.debug("관리자 시큐리티 초기화 컨트롤러 시작");
		
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		
		logger.debug("관리자 시큐리티 초기화 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_LOGIN_FORM;
	}
	
	/**
	 * @Method Name : admin_login_success
	 * @Date : 2018. 12. 4.
	 * @User : 이종호
	 * @Param : 인증 정보 객체
	 * @Return : JSP 리턴페이지(FAP 관리자 로그인 성공)
	 * @Method 설명 : FAP 관리자 로그인 성공시 권한별 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_LOGIN_SUCCESS, method = RequestMethod.GET)
	public String admin_login_success(Authentication auth, HttpSession session){
		logger.debug("FAP 관리자 로그인 성공 컨트롤러 시작");
		Object authObj = auth.getDetails();
		String user_id = (String)auth.getPrincipal();
		session.setAttribute("user_id", user_id);
		if(authObj instanceof UserSecurity){
			logger.debug("FAP 관리자 로그인 성공 컨트롤러 종료");
			return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_ACCESS_DENIED;
		}else if(authObj instanceof AdminSecurity){
			logger.debug("FAP 관리자 로그인 성공 컨트롤러 종료");
			return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_MAIN;
		}else {
			logger.debug("FAP 관리자 로그인 성공 컨트롤러 종료");
			return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_MAIN;
		}
	}
	
	/**
	 * @Method Name : admin_access_denied
	 * @Date : 2019. 4. 2.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 관리자 접근 제한 페이지)
	 * @Method 설명 : FAP 관리자 접근 제한 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_ACCESS_DENIED , method = RequestMethod.GET)
	public String admin_access_denied() {
		logger.debug("FAP 관리자 접근권한 제한 컨트롤러 시작");
		
		logger.debug("FAP 관리자 접근권한 제한 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_ACCESS_DENIED;
	}
	
	/**
	 * @Method Name : admin_login_form
	 * @Date : 2018. 12. 4.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 관리자 로그인 폼 페이지)
	 * @Method 설명 : FAP 관리자 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_LOGIN_FORM , method = RequestMethod.GET)
	public String admin_login_form(HttpSession session){
		logger.debug("FAP 관리자 로그인 폼 이동 컨트롤러 시작");
		
		Exception exception = (Exception)session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		
		
		if((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException || exception.getCause() instanceof BadCredentialsException) ){
			//세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			//휴면 계정 처리
			if(exception.getCause() instanceof DisabledException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_DORMANCY_FORM;
			}
			//탈퇴 계정 처리
			else if(exception.getCause() instanceof AccountExpiredException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_EXPIRED_FORM;
			}
			//정지 계정 처리
			else if(exception.getCause() instanceof LockedException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_LOCKED_FORM;
			}
			//관리자 권한 기간 만료
			else if(exception.getCause() instanceof ExpiredDateException){
				return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_TERMINATION_FORM;
			}
			// 승인 대기 계정 처리
			else {
				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PENDING_APPROVAL_FORM;
			}
		}
		
		logger.debug("FAP 관리자 로그인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_LOGIN_FORM;
	}
		
	/**
	 * @Method Name : jobfair_divide_search
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스
	 * @Return : JSP 리턴페이지(FAP 잡페어 수정 폼)
	 * @Method 설명 : 잡페어 세부사항 검색
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_DIVIDE_SEARCH, method = RequestMethod.GET)
	public String jobfair_divide_search(Model model, int fap_jobfair_seq){		
		logger.info("잡페어 세부사항 검색 컨트롤러 시작");				
		
		ArrayList<SocietyFapAdminJobfairDivide> jobfair_divide_search_list = sfaService.select_fap_jobfair_divide(fap_jobfair_seq);
		model.addAttribute("jobfair_divide_search_list", jobfair_divide_search_list);
		
		logger.info("잡페어 세부사항 검색 컨트롤러 종료");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : jobfair_update_form
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 잡페어 수정 폼)
	 * @Method 설명 : 잡페어 수정 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_UPDATE_FORM, method = RequestMethod.GET)
	public String jobfair_update_form(Model model, int fap_jobfair_seq){
		logger.info("잡페어 수정페이지 이동 컨트롤러 시작");
		
		HashMap<String, Object> resultMap = sfaService.select_fap_jobfair_info(fap_jobfair_seq);
		model.addAttribute("fapJobfair", resultMap);
		Gson gson = new Gson();
		gson.toJson(resultMap);
		model.addAttribute("fapJobfair", resultMap);
		model.addAttribute("fapJobfairJson", gson.toJson(resultMap));
		String path = fapAdminJobfairLogoImage+"/";
		model.addAttribute("path", path);
		
		logger.info("잡페어 수정페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : delete_fap_jobfair
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : 삭제할 잡페어 시퀀스 리스트
	 * @Return : JSP 리턴페이지(FAP 잡페어 관리 폼)
	 * @Method 설명 : 잡페어 삭제
	 */	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_DELETE, method = RequestMethod.GET)
	public String delete_fap_jobfair(Model model, @RequestParam List<Integer> fap_jobfair_seq_list ){
		logger.info("잡페어 삭제 컨트롤러 시작");
		
		sfaService.delete_fap_jobfair(fap_jobfair_seq_list);
		
		logger.info("잡페어 삭제 컨트롤러 종료");		
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_MANAGEMENT;
	}
	
	/**
	 * @Method Name : update_Jobfair
	 * @Date : 2018. 12. 17.
	 * @User : 신동철
	 * @Param : FAP 잡페어 수정 정보(잡페어, 잡페어 세부, 잡페어 개최지, 잡페어 채용대상)
	 * @Return : JSP 리턴페이지 (잡페어 관리)
	 * @Method 설명 : 잡페어 정보를 수정하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_UPDATE, method = RequestMethod.POST)
	public String update_Jobfair(Model model, Authentication auth, SocietyFapAdminJobfair sfaJobfair, SocietyFapAdminJobfairLo sfaJobfairLo, SocietyFapAdminJobfairDivide sfaJobfairDivide, 
			SocietyFapAdminJobfairDivideRc sfaJobfairDivideRc, SocietyFapAdminJobfairCompGroup sfaJobfairCompGroup, SocietyFapJobfairApplicableTime jobfairApplicableTime, SocietyFapAdminLimitInterview limitInterview){
		logger.info("잡페어 수정 컨트롤러 시작");
		
		sfaJobfair.setFap_jobfair_ins_id((String)auth.getPrincipal());
		sfaJobfair.setFap_jobfair_udt_id((String)auth.getPrincipal());
		sfaService.update_Jobfair(sfaJobfair, sfaJobfairDivide, sfaJobfairLo, sfaJobfairDivideRc, sfaJobfairCompGroup, jobfairApplicableTime,limitInterview);
		
		logger.info("잡페어 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_MANAGEMENT;
	}
	
	/**
	 * @Method Name : jobfair_permission
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 잡페어 승인 폼)
	 * @Method 설명 : 잡페어 승인 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_PERMISSION, method = RequestMethod.GET)
	public String jobfair_permission(Model model){
		logger.info("잡페어 승인페이지 이동 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.info("잡페어 승인페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_PERMISSION_FORM;
	}
	
	/**
	 * @Method Name : jobfair_user_apply_permission
	 * @Date : 2018. 12. 14.
	 * @User : 신동철
	 * @Param : 지원자 잡페어 신청 등록 시퀀스 리스트
	 * @Return : JSP 리턴페이지(FAP 잡페어 승인 폼)
	 * @Method 설명 : 잡페어 지원자 신청 승인
	 */	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_USER_APPLY_PERMISSION, method = RequestMethod.GET)
	public String jobfair_user_apply_permission(Model model, Authentication auth, @RequestParam List<Integer> fap_jobfair_user_seq_list ){
		logger.info("잡페어 지원자 신청 승인 컨트롤러 시작");
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		hashmap.put("fap_jobfair_user_seq_list", fap_jobfair_user_seq_list);
		hashmap.put("fap_jobfair_user_per_id", (String)auth.getPrincipal());
		sfaService.jobfair_user_apply_permission(hashmap);
		
		logger.info("잡페어 지원자 신청 승인 컨트롤러 종료");		
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_PERMISSION;
	}
	
	
	/**
	 * @Method Name : algorithm_jobfair_list
	 * @Date : 2019. 1. 4.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 잡페어 설정 리스트 폼)
	 * @Method 설명 : 현지 잡페어 설정
	 */	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_MANAGEMENT, method = RequestMethod.GET)
	public String algorithm_jobfair_list(Model model){
		logger.info("알고리즘 현지 잡페어 설정 리스트 폼 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.info("알고리즘 현지 잡페어 설정 리스트 폼 컨트롤러 종료");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_MANAGEMENT;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_insert_form
	 * @Date : 2018. 12. 26.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 잡페어 설정 등록 폼)
	 * @Method 설명 : 현지 잡페어 설정 프로토타입
	 */	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_INSERT_FORM, method = RequestMethod.POST)
	public String tokyofair_schedule_insert_form(Model model ,int fap_jobfair_divide_seq){
		logger.info("알고리즘 현지 잡페어 설정(프로토타입) 등록 폼 이동 컨트롤러 시작");
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		
		logger.info("알고리즘 현지 잡페어 설정(프로토타입) 등록 폼 이동 컨트롤러 종료");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_INSERT_FORM;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_search_form
	 * @Date : 2019. 10. 13.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 도쿄페어 일정 확인 폼)
	 * @Method 설명 : 도쿄페어 일정 확인 폼 이동
	 */	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_SEARCH_FORM, method = RequestMethod.GET)
	public String tokyofair_schedule_search_form(Model model ,int fap_jobfair_divide_seq){
		logger.info("도쿄페어 일정 확인 폼 이동 컨트롤러 시작");
		
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		HashMap<String, Object> tokyofairSetMap = sfaService.tokyfair_schedule_booked_search(fap_jobfair_divide_seq);
		model.addAttribute("tokyofairSetMap", tokyofairSetMap);
		
		
		logger.info("도쿄페어 일정 확인 폼 이동 컨트롤러 종료");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_SEARCH_FORM;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_update_form
	 * @Date : 2019. 09. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 잡페어 설정 수정 폼)
	 * @Method 설명 : 현지 잡페어 설정 프로토타입  수정 폼 이동
	 */	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_UPDATE_FORM, method = RequestMethod.POST)
	public String tokyofair_schedule_update_form(Model model ,int fap_jobfair_set_seq){
		logger.info("알고리즘 현지 잡페어 설정(프로토타입) 수정 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> result = sfaService.tokyofair_schedule_set_search(fap_jobfair_set_seq);
		model.addAttribute("result", result);
		model.addAttribute("fap_jobfair_set_seq", fap_jobfair_set_seq);
		
		logger.info("알고리즘 현지 잡페어 설정(프로토타입) 수정 폼 이동 컨트롤러 종료");		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_TOKYOFAIR_SCHEDULE_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : process_schedule_calendar
	 * @Date : 2018. 12. 27.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 채용전형 캘린더 폼)
	 * @Method 설명 : 채용전형 캘린더 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR, method = RequestMethod.GET)
	public String process_schedule_calendar(Model model){
		logger.info("잡페어 채용전형 캘린더 페이지 이동 컨트롤러 시작");
		
		HashMap<String, Object> jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", jobfair_map);
		
		logger.info("잡페어 채용전형 캘린더 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : applicant_status_per_comp
	 * @Date : 2018. 12. 31.
	 * @User : 남유송
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 기업별 지원자 현황 JSP폼)
	 * @Method 설명 : 관리자 페이지에서 기업별 지원자 현황 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_COMP, method = RequestMethod.GET)
	public String applicant_status_per_comp(Model model, @RequestParam(defaultValue="0") int fap_jobfair_seq, 
			@RequestParam(defaultValue="0") int fap_jobfair_divide_seq
			,@RequestParam(defaultValue="progressing") String cur_seleted_btn){
		logger.info("기업별 지원자 현황 페이지 이동 컨트롤러 시작");
		HashMap<String, Object> jobfair_map = new HashMap<String, Object>();
		jobfair_map = sfcrService.select_jobfair();
		Gson gson = new Gson();
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("cur_seleted_btn", cur_seleted_btn);
		model.addAttribute("jobfair_map", gson.toJson(jobfair_map));
		logger.info("기업별 지원자 현황 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_COMP_FORM;
	}
	
	/**
	 * @Method Name : applicant_status_per_applier
	 * @Date : 2019. 5. 16.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 지원자별 지원 현황 JSP폼)
	 * @Method 설명 : 관리자 페이지에서 지원자별 지원 현황 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_APPLIER, method = RequestMethod.GET)
	public String applicant_status_per_applier(Model model) {
		logger.info("지원자별 지원 현황 페이지 이동 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.info("지원자별 지원 현황 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_APPLIER;
	}
	
	/**
	 * @Method Name : user_management
	 * @Date : 2019. 3. 4.
	 * @User : 정병준
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 회원 관리 페이지)
	 * @Method 설명 : 회원 관리 페이지로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_USER_MANAGEMENT, method = RequestMethod.GET)
	/*public String user_management(Model model,@RequestParam(defaultValue="1") int clickedPage){*/
	public String user_management(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String orderType,
			@RequestParam(defaultValue="") String orderValue,
			@RequestParam(defaultValue="") String searchKey,
			@RequestParam(defaultValue="") String searchValue
			){
		logger.info("FAP 관리자 회원 관리 페이지 이동 컨트롤러 시작");
	 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderType", orderType);
		map.put("orderValue", orderValue);
		map.put("pageCount", pageCount);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		int count = sfaService.select_user_list_count(map);
		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<User> user_list = sfaService.select_user_list(map);
		
		model.addAttribute("map", map);
		model.addAttribute("user_list", user_list);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		/*int userTotalCount = sfaService.select_user_list_paging_count();
		if(userTotalCount == 0){userTotalCount=1;}
		PageNavigator repNavi = new PageNavigator(10, 10, clickedPage, userTotalCount);
		ArrayList<User> user_list = sfaService.select_user_list(repNavi.getStartRecord(), repNavi.getCountPerPage());
		int userLoadNum = userTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		
		model.addAttribute("user_list", user_list);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("userLoadNum", userLoadNum);*/
		logger.info("FAP 관리자 회원 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_USER_MANAGEMENT;

	}

	/**
	 * @Method Name : user_update_form
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 회원 아이디
	 * @Return : JSP 리턴페이지(FAP 회원 정보 수정 폼)
	 * @Method 설명 : 회원 정보 수정 폼으로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_USER_UPDATE_FORM, method = RequestMethod.POST)
	public String user_update_form(Model model, Authentication auth, String user_flag, String user_id){
		logger.info("FAP 관리자 회원 정보 수정 페이지 이동 컨트롤러 시작");
	
		// 일반, 마스터 재학생, 마스터 졸업생, K-Move 학생 -> 공통, 개인, 학교 정보를 가져옴
		// 2020.08.11(최승호) 일본취업학교 A0108 추가
		if(user_flag.equals("A0100") || user_flag.equals("A0101") || user_flag.equals("A0102") || user_flag.equals("A0106") || user_flag.equals("A0107")  || user_flag.equals("A0108")){
			
			// 개인 회원 정보를 가져옴
			HashMap<String, Object> user_info = sfaService.select_personal_user(user_id);
			// 개인 회원이 가지고 있는 회사 정보를 가져옴
			HashMap<String, Object> hashMap = new HashMap<>();
			hashMap.put("fap_personal_user_edu_level", user_info.get("fap_personal_user_edu_level"));
			hashMap.put("fap_personal_user_seq", user_info.get("fap_personal_user_seq"));
			
			model.addAttribute("user_info", user_info);
			if(user_info.get("fap_personal_user_seq") != null){
				HashMap<String, Object> user_school = sfaService.select_personal_school(hashMap); 				
				model.addAttribute("user_school", user_school);
			}
			
			return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_USER_UPDATE_FORM;
		// 채용 기업, 에이전시 -> 공통 회원 정보만 가져옴
		} else if(user_flag.equals("A0103") || user_flag.equals("A0104")){
			// 기업, 에이전시 담당자 정보를 가져옴
			User user = sfaService.select_user(user_id);
			
			model.addAttribute("company_user", user);
			
			return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_UPDATE_FORM;
		}
		
		logger.info("FAP 관리자 회원 정보 수정 페이지 이동 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_USER_MANAGEMENT;
	}
	
	/**
	 * @Method Name : personal_user_update
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통, 개인 회원 객체, 학교 객체
	 * @Return : JSP 리턴페이지(회원 관리 페이지)
	 * @Method 설명 : 개인 회원 정보를 수정 한 후 회원 관리 페이지로 이동 한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_USER_UPDATE, method = RequestMethod.POST)
	public String personal_user_update(Authentication auth, User user, SocietyFapPersonalUser sfpUser, 
			SocietyFapPersonalHighschool sfpHighschool, 
			SocietyFapPersonalUniversity sfpUniversity,
			SocietyFapPersonalGraduate sfpGraduate, String origin_level){
		logger.info("FAP 관리자 개인 회원 정보 수정 컨트롤러 시작");
		sfaService.personal_user_update(auth, user, sfpUser, sfpHighschool, sfpUniversity, sfpGraduate, origin_level);
		logger.info("FAP 관리자 개인 회원 정보 수정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_USER_MANAGEMENT;
	}
	
	/**
	 * @Method Name : delete_user_info
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 탈퇴할 회원 객체
	 * @Return : JSP 리턴페이지(회원 관리 페이지)
	 * @Method 설명 : 회원 정보를 이름만 남겨놓고 공백처리, 회원 상태(A0202) 탈퇴로변경 , 아이디+난수(30글자) 변경후 참조 테이블에 적용
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_USER_INFO_DELETE, method = RequestMethod.POST)
	public String delete_user_info(User user){
		logger.info("FAP 관리자 회원 탈퇴 컨트롤러 시작");
		sfaService.delete_user_info(user);
		logger.info("FAP 관리자 회원 탈퇴 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_USER_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_user_update
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 공통 회원 객체
	 * @Return : JSP 리턴페이지(회원 관리 페이지)
	 * @Method 설명 : 기업, 에이전시 담당자 정보를 수정 한 후 회원 관리 페이지로 이동 한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_UPDATE, method = RequestMethod.POST)
	public String company_user_update(Authentication auth, User user){
		logger.info("FAP 관리자 기업, 에이전시 관리자 정보 수정 컨트롤러 시작");
		sfaService.update_user(auth, user);
		logger.info("FAP 관리자 기업, 에이전시 관리자 정보 수정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_USER_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_management
	 * @Date :2019. 08. 02.
	 * @User : 김준영 > 김경아
	 * @Param : 검색 관련 정보
	 * @Return : JSP 리턴페이지(FAP 기업 관리 페이지)
	 * @Method 설명 : 기업 관리 페이지로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_MANAGEMENT, method = RequestMethod.GET)
	public String company_management(Model model, @RequestParam(defaultValue="1") int clickedPage		
			, @RequestParam(defaultValue="1") int currentPage 	
			, String orderType , String orderValue  
			, String searchJaNm, String searchEnNm){
		logger.info("FAP 관리자 기업 관리 페이지 이동 컨트롤러 시작");
        System.out.println("currentPage:"+currentPage+", clickedPage:"+clickedPage);
		//페이징 
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("searchJaNm", searchJaNm);
		paramMap.put("searchEnNm", searchEnNm); 
		int companyTotalCount = sfaService.select_company_list_paging_count(paramMap);
	
		paramMap.put("orderType", orderType);
		paramMap.put("orderValue", orderValue);
		System.out.println("orderType:"+paramMap.get("orderType")+", orderValue:"+paramMap.get("orderValue"));
		if(companyTotalCount == 0){companyTotalCount = 1;}
		PageNavigator repNavi = new PageNavigator(10, 10, clickedPage, companyTotalCount);		 
			   
		//출력리스트
		ArrayList<SocietyFapCompanyUser> company_list = sfaService.select_company_list(repNavi.getStartRecord(), repNavi.getCountPerPage(), paramMap);
		int companyLoadNum = companyTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
 
		model.addAttribute("company_list", company_list);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("companyLoadNum", companyLoadNum);
		model.addAttribute("orderType", orderType);
		model.addAttribute("orderValue", orderValue);
		model.addAttribute("searchJaNm", searchJaNm);
		model.addAttribute("searchEnNm", searchEnNm);
		logger.info("FAP 관리자 기업 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_COMPANY_MANAGEMENT;
	}
	
	

	/**
	 * @Method Name : company_update_form
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 아이디
	 * @Return : JSP 리턴페이지(기업 정보 수정 폼)
	 * @Method 설명 : 기업 정보 수정 페이지로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_UPDATE_FORM, method = RequestMethod.POST)
	public String company_update_form(Model model, String fap_comp_id){
		logger.info("FAP 관리자 기업 정보 수정 페이지 이동 컨트롤러 시작");
		SocietyFapCompanyUser company_info = sfaService.select_company(fap_comp_id);
		model.addAttribute("company_info", company_info);
		logger.info("FAP 관리자 기업 정보 수정 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_COMPANY_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : company_info_update
	 * @Date : 2019. 1. 3.
	 * @User : 김준영
	 * @Param : 기업 정보 객체
	 * @Return : JSP 리턴페이지(기업 관리 페이지)
	 * @Method 설명 : 기업 정보를 수정 한 후 기업 관리 페이지로 이동 한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_INFO_UPDATE, method = RequestMethod.POST)
	public String company_info_update(Model model, Authentication auth, SocietyFapCompanyUser societyFapCompanyUser){
		logger.info("FAP 기업 정보 수정 컨트롤러 시작");
		sfaService.update_company(auth, societyFapCompanyUser);
		logger.info("FAP 기업 정보 수정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_COMPANY_MANAGEMENT;
	}
	

	/**
	 * @Method Name : email_management
	 * @Date : 2019. 1. 3.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 이메일 관리 페이지)
	 * @Method 설명 : 기업 이메일 관리 페이지로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_EMAIL_MANAGEMENT, method = RequestMethod.GET)
	public String email_management(Model model){
		logger.info("FAP 관리자 이메일 관리 페이지 이동 컨트롤러 시작");
		
		HashMap<String,Object> max_mail=sfaService.select_email_max_uid();
		
		MailService ms=new MailService();
		sfaService.insert_email(ms.recieveAllMail(max_mail));
		
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_EMAIL_ALL;
	}
	
	/**
	 * @Method Name : email_send
	 * @Date : 2019. 1. 3.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 이메일 관리 페이지)
	 * @Method 설명 : 기업 이메일을 발송한다.
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_EMAIL_SEND, method = RequestMethod.POST)
	public String email_send(Model model,String fromMail, String toMail, String subject, String content,
			String fileName, String filePath, Date sentDate,MultipartHttpServletRequest files){
		logger.info("FAP 기업 이메일을 발송한다 시작");
		MailService ms=new MailService();
		fromMail="searpier@gmail.com";
		
		
		ArrayList<HashMap<String, String>> allMap=null;
		
		if(files.getFiles("files").size()>0)
		//allMap= FileService.temporarilySaveAll(files, "D:/upload/");
		allMap= FileService.temporarilySaveAll(files, "/usr/local/upload/");
		
		
		try {
			//ms.sendMail(fromMail, toMail, subject, content);.split("/")[files.getOriginalFilename().split("/").length-1]
			ms.bizMailSending(fromMail, toMail, subject, content, 
					allMap, null);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_EMAIL_ALL;
		}
		/*mailSending(String fromMail, String toMail, String subject, String content,
				String fileName, String filePath, Date sentDate)*/
		
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_EMAIL_ALL;
	}
	
	
	/**
	 * @Method Name : email_management
	 * @Date : 2019. 1. 24.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 이메일 관리 페이지)
	 * @Method 설명 : 기업 이메일 관리 페이지로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_EMAIL_ALL, method = {RequestMethod.GET,RequestMethod.POST})
	public String email_all(Model model, @RequestParam(value="page",defaultValue="0")int page,
			@RequestParam(value="searchWord",defaultValue="") String searchWord,
			@RequestParam(value="searchType",defaultValue="") String searchType,
			@RequestParam(value="searchDomain",defaultValue="") String searchDomain
			){
		
		logger.info("FAP 관리자 이메일 관리 페이지 이동 컨트롤러 시작");
		
		HashMap<String,String> hm=new HashMap<String, String>();
		
		
		hm.put("searchWord", searchWord);
		hm.put("searchType", searchType);
		hm.put("searchDomain", searchDomain);
		
		int totalRecord=sfaService.select_count_email(hm);
		PageNavigator pn=new PageNavigator(15,5,page,totalRecord);

		model.addAttribute("searchWord",searchWord);
		model.addAttribute("searchDomain",searchDomain);
		model.addAttribute("searchType",searchType);
		model.addAttribute("mailList",sfaService.select_email(hm,pn));
		model.addAttribute("navi",pn);
		logger.info("FAP 관리자 이메일 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_EMAIL_MANAGEMENT;
	}
	
	
	/**
	 * @Method Name : email_content
	 * @Date : 2019. 1. 3.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 이메일 관리 페이지)
	 * @Method 설명 : 기업 이메일 관리 페이지로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_EMAIL_SPECIFIC, method = RequestMethod.GET)
	public @ResponseBody String email_content(@RequestParam("uid") String uid){
		
		
		String content=sfaService.select_email_content(uid);
		
		
		return content;
	}
	
	/**
	 * @Method Name : applicant_list_per_job_ad
	 * @Date : 2018. 01. 03.
	 * @User : 남유송
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 지원자 리스트 출력 페이지 )
	 * @Method 설명 : 기업별 지원자 현황 페이지에서 채용공고별 지원자 리스트 출력 페이지
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_LIST_PER_JOB_AD, method = RequestMethod.GET)
	public String applicant_list_per_job_ad(int fap_job_ad_seq, String fap_comp_ja_nm, Model model){
		logger.info("채용공고별 지원자 리스트 출력 페이지 이동 컨트롤러 시작");
		model.addAttribute("fap_comp_ja_nm", fap_comp_ja_nm);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		ArrayList<HashMap<String, Object>> allApplicantList = sfaService.select_applicant_list(fap_job_ad_seq);
		model.addAttribute("allApplicantList", allApplicantList);
		logger.info("채용공고별 지원자 리스트 출력 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_LIST_PER_JOB_AD_FORM;
	}

	/**
	 * @Method Name : company_user_connect_management
	 * @Date : 2019. 1. 4.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(기업 - 유저 연결 요청 관리)
	 * @Method 설명 : 담당자 - 기업 연결 요청 관리 페이지로 이동한다
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT_MANAGEMENT, method = RequestMethod.GET)
	public String company_user_connect_management(Model model){
		logger.info("FAP 담당자 - 기업 연결 요청 관리 페이지 이동 컨트롤러 시작");
		
		int userStandbyTotalCount = sfaService.select_standby_comp_user_connect_list_paging_count();
		if(userStandbyTotalCount == 0){userStandbyTotalCount=1;}
		
		int userApprovalTotalCount = sfaService.select_approval_comp_user_connect_list_paging_count();
		if(userApprovalTotalCount == 0){userApprovalTotalCount=1;}
		
		int userRefusalTotalCount = sfaService.select_refusal_comp_user_connect_list_paging_count();
		if(userRefusalTotalCount == 0){userRefusalTotalCount=1;}
		
		PageNavigator repNavi = new PageNavigator(10, 10, 1, userStandbyTotalCount);
		int userStandbyLoadNum = userStandbyTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		
		PageNavigator repNaviTwo = new PageNavigator(10, 10, 1, userApprovalTotalCount);
		int userApprovalLoadNum = userApprovalTotalCount - ((repNaviTwo.getPagePerGroup()) * (repNaviTwo.getCurrentPage() - 1));
		
		PageNavigator repNaviThree = new PageNavigator(10, 10, 1, userRefusalTotalCount);
		int userRefusalLoadNum = userRefusalTotalCount - ((repNaviThree.getPagePerGroup()) * (repNaviThree.getCurrentPage() - 1));
		
		ArrayList<HashMap<String, Object>> user_standby_list = sfaService.select_standby_comp_user_connect(repNavi.getStartRecord(), repNavi.getCountPerPage());
		model.addAttribute("user_standby_list", user_standby_list);
		model.addAttribute("userStandbyLoadNum", userStandbyLoadNum);
		model.addAttribute("repNavi", repNavi);
		
		ArrayList<HashMap<String, Object>> user_approval_list = sfaService.select_approval_comp_user_connect(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		model.addAttribute("user_approval_list", user_approval_list);
		model.addAttribute("userApprovalLoadNum", userApprovalLoadNum);
		model.addAttribute("repNaviTwo", repNaviTwo);
		
		ArrayList<HashMap<String, Object>> user_refusal_list = sfaService.select_refusal_comp_user_connect(repNaviThree.getStartRecord(), repNaviThree.getCountPerPage());
		model.addAttribute("user_refusal_list", user_refusal_list);
		model.addAttribute("userRefusalLoadNum", userRefusalLoadNum);
		model.addAttribute("repNaviThree", repNaviThree);
		
		//HashMap<String, Object> hashMap = sfaService.select_comp_user_connect();
		//model.addAttribute("standBy_list", hashMap.get("standBy_list"));
		//model.addAttribute("approval_list", hashMap.get("approval_list"));
		//model.addAttribute("refusal_list", hashMap.get("refusal_list"));

		logger.info("FAP 담당자 - 기업 연결 요청 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : company_user_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(기업 - 유저 연결 페이지)
	 * @Method 설명 : 기업과 유저를 연결하는 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT, method = RequestMethod.GET)
	public String company_user_connect(Model model){
		logger.info("FAP 기업 - 담당자 연결 페이지 이동 컨트롤러 시작");
		
		int requestTotalCount = sfaService.select_connect_request_paging_count();
		if(requestTotalCount == 0){requestTotalCount=1;}
		
		int uncertainTotalCount = sfaService.select_uncertain_company_paging_count();
		if(uncertainTotalCount == 0){uncertainTotalCount=1;}
		
		int companyUserTotalCount = sfaService.select_unconnect_company_list_paging_count();
		if(companyUserTotalCount == 0){companyUserTotalCount=1;}
		
		int agencyUserTotalCount = sfaService.select_unconnect_agency_list_paging_count();
		if(agencyUserTotalCount == 0){agencyUserTotalCount=1;}
		
		int connectCompanyTotalCount = sfaService.select_connect_company_list_paging_count();
		if(connectCompanyTotalCount == 0){connectCompanyTotalCount=1;}
		
		int connectAgencyTotalCount = sfaService.select_connect_agency_list_paging_count();
		if(connectAgencyTotalCount == 0){connectAgencyTotalCount=1;}
		
		PageNavigator repNavi = new PageNavigator(10, 10, 1, requestTotalCount);
		int requestLoadNum = requestTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		
		PageNavigator repNaviTwo = new PageNavigator(10, 10, 1, uncertainTotalCount);
		int uncertainLoadNum = uncertainTotalCount - ((repNaviTwo.getPagePerGroup()) * (repNaviTwo.getCurrentPage() - 1));
		
		PageNavigator repNaviThree = new PageNavigator(10, 10, 1, companyUserTotalCount);
		int companyUserLoadNum = companyUserTotalCount - ((repNaviThree.getPagePerGroup()) * (repNaviThree.getCurrentPage() - 1));
		
		PageNavigator repNaviFour = new PageNavigator(10, 10, 1, agencyUserTotalCount);
		int agencyUserLoadNum = agencyUserTotalCount - ((repNaviFour.getPagePerGroup()) * (repNaviFour.getCurrentPage() - 1));
		
		PageNavigator repNaviFive = new PageNavigator(10, 10, 1, connectCompanyTotalCount);
		int connectCompanyLoadNum = connectCompanyTotalCount - ((repNaviFive.getPagePerGroup()) * (repNaviFive.getCurrentPage() - 1));
		
		PageNavigator repNaviSix = new PageNavigator(10, 10, 1, connectAgencyTotalCount);
		int connectAgencyLoadNum = connectAgencyTotalCount - ((repNaviSix.getPagePerGroup()) * (repNaviSix.getCurrentPage() - 1));
		
		ArrayList<User> company_user = sfaService.select_unconnect_company_list(repNaviThree.getStartRecord(), repNaviThree.getCountPerPage());
		ArrayList<User> agency_user = sfaService.select_unconnect_agency_list(repNaviFour.getStartRecord(), repNaviFour.getCountPerPage());
		
		ArrayList<HashMap<String, Object>> company_list = sfaService.select_connect_company_list(repNaviFive.getStartRecord(), repNaviFive.getCountPerPage());
		ArrayList<HashMap<String, Object>> agency_list = sfaService.select_connect_agency_list(repNaviSix.getStartRecord(), repNaviSix.getCountPerPage());
		
		ArrayList<HashMap<String, Object>> request_list = sfaService.select_connect_request(repNavi.getStartRecord(), repNavi.getCountPerPage());
		ArrayList<SocietyFapCompanyUser> select_uncertain_company = sfaService.select_uncertain_company(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		
		//HashMap<String, Object> comp_list = sfaService.select_connect_company();
		//HashMap<String, Object> user_list = sfaService.select_unconnect_user_list();
		//model.addAttribute("company_user", user_list.get("company_user"));
		//model.addAttribute("agency_user", user_list.get("agency_user"));
		//model.addAttribute("company_list", comp_list.get("company_list"));
		//model.addAttribute("agency_list", comp_list.get("agency_list"));
		
		model.addAttribute("request_list", request_list);
		model.addAttribute("requestLoadNum", requestLoadNum);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("select_uncertain_company", select_uncertain_company);
		model.addAttribute("uncertainLoadNum", uncertainLoadNum);
		model.addAttribute("repNaviTwo", repNaviTwo);
		
		model.addAttribute("company_user", company_user);
		model.addAttribute("companyUserLoadNum", companyUserLoadNum);
		model.addAttribute("repNaviThree", repNaviThree);
		
		model.addAttribute("agency_user", agency_user);
		model.addAttribute("agencyUserLoadNum", agencyUserLoadNum);
		model.addAttribute("repNaviFour", repNaviFour);
		
		model.addAttribute("company_list", company_list);
		model.addAttribute("connectCompanyLoadNum", connectCompanyLoadNum);
		model.addAttribute("repNaviFive", repNaviFive);
		
		model.addAttribute("agency_list", agency_list);
		model.addAttribute("connectAgencyLoadNum", connectAgencyLoadNum);
		model.addAttribute("repNaviSix", repNaviSix);
		
		logger.info("FAP 기업 - 담당자 연결 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_COMPANY_USER_CONNECT;
	}
	
	/**
	 * @Method Name : agency_company_connect_management
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 - 기업 연결 관리 페이지)
	 * @Method 설명 : 에이전시와 기업의 연결을 관리하는 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_MANAGEMENT, method = RequestMethod.GET)
	public String agency_company_connect_management(Model model){
		logger.info("FAP 에이전시 - 기업 연결 관리 페이지 이동 컨트롤러 시작");
		
		int standbyTotalCount = sfaService.select_standby_ag_comp_connect_list_paging_count();
		if(standbyTotalCount == 0){standbyTotalCount=1;}
		
		int approvalTotalCount = sfaService.select_approval_ag_comp_connect_list_paging_count();
		if(approvalTotalCount == 0){approvalTotalCount=1;}
		
		int refusalTotalCount = sfaService.select_refusal_ag_comp_connect_list_paging_count();
		if(refusalTotalCount == 0){refusalTotalCount=1;}
		
		PageNavigator repNavi = new PageNavigator(10, 10, 1, standbyTotalCount);
		int standbyLoadNum = standbyTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		
		PageNavigator repNaviTwo = new PageNavigator(10, 10, 1, approvalTotalCount);
		int approvalLoadNum = approvalTotalCount - ((repNaviTwo.getPagePerGroup()) * (repNaviTwo.getCurrentPage() - 1));
		
		PageNavigator repNaviThree = new PageNavigator(10, 10, 1, refusalTotalCount);
		int refusalLoadNum = refusalTotalCount - ((repNaviThree.getPagePerGroup()) * (repNaviThree.getCurrentPage() - 1));
		
		ArrayList<HashMap<String, Object>> standby_list = sfaService.select_standby_ag_comp_connect_list(repNavi.getStartRecord(), repNavi.getCountPerPage());
		model.addAttribute("standby_list", standby_list);
		model.addAttribute("standbyLoadNum", standbyLoadNum);
		model.addAttribute("repNavi", repNavi);
		
		ArrayList<HashMap<String, Object>> approval_list = sfaService.select_approval_ag_comp_connect_list(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		model.addAttribute("approval_list", approval_list);
		model.addAttribute("approvalLoadNum", approvalLoadNum);
		model.addAttribute("repNaviTwo", repNaviTwo);
		
		ArrayList<HashMap<String, Object>> refusal_list = sfaService.select_refusal_ag_comp_connect_list(repNaviThree.getStartRecord(), repNaviThree.getCountPerPage());
		model.addAttribute("refusal_list", refusal_list);
		model.addAttribute("refusalLoadNum", refusalLoadNum);
		model.addAttribute("repNaviThree", repNaviThree);
		
		//HashMap<String, Object> hashMap = sfaService.select_ag_comp_connect();
		//model.addAttribute("approval_list", hashMap.get("approval_list"));
		//model.addAttribute("refusal_list", hashMap.get("refusal_list"));
		//model.addAttribute("standBy_list", hashMap.get("standBy_list"));

		logger.info("FAP 에이전시 - 기업 연결 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : agency_company_connect
	 * @Date : 2019. 1. 7.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(에이전시 - 기업 연결 페이지)
	 * @Method 설명 : 에이전시와 기업을 연결 해주는 페이지
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT, method = RequestMethod.GET)
	public String agency_company_connect(Model model){
		logger.info("FAP 에이전시 - 기업 연결 페이지 이동 컨트롤러 시작");
		
		int unconnectTotalCount = sfaService.select_unconnect_comp_list_paging_count();
		if(unconnectTotalCount == 0){unconnectTotalCount=1;}
		
		int agencyTotalCount = sfaService.select_agency_list_paging_count();
		if(agencyTotalCount == 0){agencyTotalCount=1;}
		
		PageNavigator repNavi = new PageNavigator(10, 10, 1, unconnectTotalCount);
		int companyLoadNum = unconnectTotalCount - ((repNavi.getPagePerGroup()) * (repNavi.getCurrentPage() - 1));
		
		PageNavigator repNaviTwo = new PageNavigator(10, 10, 1, agencyTotalCount);
		int agencyLoadNum = agencyTotalCount - ((repNaviTwo.getPagePerGroup()) * (repNaviTwo.getCurrentPage() - 1));
		
		ArrayList<SocietyFapCompanyUser> unconnect_comp_list = sfaService.select_unconnect_comp_list(repNavi.getStartRecord(), repNavi.getCountPerPage());
		ArrayList<SocietyFapCompanyUser> select_agency_list = sfaService.select_agency_list(repNaviTwo.getStartRecord(), repNaviTwo.getCountPerPage());
		
		model.addAttribute("unconnect_comp_list", unconnect_comp_list);
		model.addAttribute("select_agency_list", select_agency_list);
		model.addAttribute("companyLoadNum", companyLoadNum);
		model.addAttribute("agencyLoadNum", agencyLoadNum);
		model.addAttribute("repNavi", repNavi);
		model.addAttribute("repNaviTwo", repNaviTwo);
		
		logger.info("FAP 에이전시 - 기업 연결 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_AGENCY_COMPANY_CONNECT;
	}
		
	/**
	 * @Method Name : process_schedule_management
	 * @Date : 2019. 1. 10.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 채용전형 일정관리 폼)
	 * @Method 설명 : 채용전형 일정관리 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT, method = RequestMethod.GET)
	public String process_schedule_management(Model model){
		logger.info("잡페어 채용전형 일정관리 페이지 이동 컨트롤러 시작");
		
		HashMap<String, Object> jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", jobfair_map);
		
		logger.info("잡페어 채용전형 일정관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : update_review_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 서류전형 정보
	 * @Return : FAP 채용전형 일정관리 컨트롤러
	 * @Method 설명 : 서류전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_REVIEW_PROCESS_SCHEDULE_UPDATE, method = RequestMethod.POST)
	public String update_review_process_schedule(Model model, Authentication auth, SocietyFapJobRecruitPcsSch review_process_schedule, SocietyFapJobRecruitPcs review_process,  RedirectAttributes redirect){
		logger.info("서류전형 스케줄 설정 컨트롤러 시작");
		
		review_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		review_process.setFap_job_recruit_pcs_udt_id((String)auth.getPrincipal());
		sfaService.update_review_process_schedule(review_process_schedule, review_process);
		
		redirect.addAttribute("fap_jobfair_seq", review_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", review_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_sch_ck", review_process_schedule.getFap_job_recruit_pcs_sch_ck());
		redirect.addAttribute("comp_nm", review_process_schedule.getComp_nm());
		
		logger.info("서류전형 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : update_exam_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 시험전형 정보
	 * @Return : FAP 채용전형 일정관리 컨트롤러
	 * @Method 설명 : 시험전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_EXAM_PROCESS_SCHEDULE_UPDATE, method = RequestMethod.POST)
	public String update_exam_process_schedule(Model model, Authentication auth, SocietyFapJobRecruitPcsSch exam_process_schedule, SocietyFapJobExam exam_process, SocietyFapJobExamFile exam_file,
			SocietyFapJobExamObjEtc exam_obj_etc, SocietyFapJobExamSvEtc exam_sv_etc, SocietyFapJobExamNeedEtc exam_need_etc, SocietyFapJobExamType exam_type, RedirectAttributes redirect
			){
		logger.info("시험전형 스케줄 설정 컨트롤러 시작");
	 
		exam_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		exam_process.setFap_job_exam_udt_id((String)auth.getPrincipal());
		exam_file.setFap_job_exam_file_udt_id((String)auth.getPrincipal());
		exam_obj_etc.setFap_job_exam_obj_etc_udt_id((String)auth.getPrincipal());
		exam_sv_etc.setFap_job_exam_sv_etc_udt_id((String)auth.getPrincipal());
		exam_need_etc.setFap_job_exam_need_etc_udt_id((String)auth.getPrincipal());
		exam_type.setFap_job_exam_type_udt_id((String)auth.getPrincipal());		
	  
		sfaService.update_exam_process_schedule(exam_process_schedule, exam_process, exam_file, exam_obj_etc, exam_sv_etc, exam_need_etc, exam_type, auth);		 
		redirect.addAttribute("fap_jobfair_seq", exam_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", exam_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_sch_ck", exam_process_schedule.getFap_job_recruit_pcs_sch_ck());		
		redirect.addAttribute("fap_job_exam_file_seq", exam_file.getFap_job_exam_file_seq()); // 확인
		redirect.addAttribute("comp_nm", exam_process_schedule.getComp_nm());
	
		
		logger.info("시험전형 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : update_itv_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 면접전형 정보
	 * @Return : FAP 채용전형 일정관리 컨트롤러
	 * @Method 설명 : 면접전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_INTERVEIW_PROCESS_SCHEDULE_UPDATE, method = RequestMethod.POST)
	public String update_itv_process_schedule(Model model, Authentication auth, SocietyFapJobRecruitPcsSch itv_process_schedule, SocietyFapJobRecruitPcs itv_process,
			SocietyFapJobItv itv_process_info, SocietyFapJobItvTpEtc itv_tp_etc, SocietyFapJobItvObjEtc itv_obj_etc, RedirectAttributes redirect){
		logger.info("면접전형 스케줄 설정 컨트롤러 시작");
		
		itv_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		itv_process.setFap_job_recruit_pcs_udt_id((String)auth.getPrincipal());
		itv_process_info.setFap_job_itv_udt_id((String)auth.getPrincipal());
		itv_tp_etc.setFap_job_itv_tp_etc_udt_id((String)auth.getPrincipal());
		itv_obj_etc.setFap_job_itv_obj_etc_udt_id((String)auth.getPrincipal());
		sfaService.update_itv_process_schedule(itv_process_schedule, itv_process, itv_process_info, itv_tp_etc, itv_obj_etc);
		
		redirect.addAttribute("fap_jobfair_seq", itv_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", itv_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_sch_ck", itv_process_schedule.getFap_job_recruit_pcs_sch_ck());
		redirect.addAttribute("comp_nm", itv_process_schedule.getComp_nm());
		
		logger.info("면접전형 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM;
	}

	/**
	 * @Method Name : update_test_etc_process_schedule
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : 기타전형 정보
	 * @Return : FAP 채용전형 일정관리 컨트롤러
	 * @Method 설명 : 기타전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TEST_ETC_PROCESS_SCHEDULE_UPDATE, method = RequestMethod.POST)
	public String update_test_etc_process_schedule(Model model, Authentication auth, SocietyFapJobRecruitPcsSch test_etc_process_schedule, 
			SocietyFapJobTestEtc test_etc_info,	SocietyFapJobTestEtcObj test_etc_obj, RedirectAttributes redirect){
		logger.info("기타전형 스케줄 설정 컨트롤러 시작");
		
		test_etc_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		test_etc_info.setFap_job_test_etc_udt_id((String)auth.getPrincipal());
		test_etc_obj.setFap_job_test_etc_obj_udt_id((String)auth.getPrincipal());
		sfaService.update_test_etc_process_schedule(test_etc_process_schedule, test_etc_info, test_etc_obj);
		
		redirect.addAttribute("fap_jobfair_seq", test_etc_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", test_etc_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_sch_ck", test_etc_process_schedule.getFap_job_recruit_pcs_sch_ck());
		redirect.addAttribute("comp_nm", test_etc_process_schedule.getComp_nm());
		
		logger.info("기타전형 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM;
	}	
	
	/**
	 * @Method Name : process_schedule_management_form
	 * @Date : 2019. 1. 13.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 채용전형 일정관리 폼)
	 * @Method 설명 : 채용전형 일정관리 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM, method = RequestMethod.GET)
	public String process_schedule_management_form(Model model, @RequestParam("fap_jobfair_seq") String fap_jobfair_seq,  @RequestParam("fap_jobfair_divide_seq") String fap_jobfair_divide_seq,
			@RequestParam("fap_job_recruit_pcs_sch_ck") String fap_job_recruit_pcs_sch_ck, @RequestParam("comp_nm") String comp_nm){
		logger.info("잡페어 채용전형 일정관리 페이지 이동 컨트롤러 시작");
		
		HashMap<String, Object> jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", jobfair_map);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_recruit_pcs_sch_ck", fap_job_recruit_pcs_sch_ck);
		model.addAttribute("comp_nm", comp_nm);
		
		logger.info("잡페어 채용전형 일정관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : update_review_process_schedule_calendar
	 * @Date : 2019. 1. 15.
	 * @User : 신동철
	 * @Param : 서류전형 정보
	 * @Return : FAP 채용전형 일정 Calendar 컨트롤러
	 * @Method 설명 : 서류전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_REVIEW_PROCESS_SCHEDULE_CALENDAR_UPDATE, method = RequestMethod.POST)
	public String update_review_process_schedule_calendar(Model model, Authentication auth, SocietyFapJobRecruitPcsSch review_process_schedule, SocietyFapJobRecruitPcs review_process,  RedirectAttributes redirect){
		logger.info("서류전형 Calendar 스케줄 설정 컨트롤러 시작");
		
		review_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		review_process.setFap_job_recruit_pcs_udt_id((String)auth.getPrincipal());
		sfaService.update_review_process_schedule(review_process_schedule, review_process);
		
		redirect.addAttribute("fap_jobfair_seq", review_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", review_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_gb", review_process_schedule.getFap_job_recruit_pcs_gb());
		redirect.addAttribute("comp_nm", review_process_schedule.getComp_nm());
		
		logger.info("서류전형 Calendar 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : update_exam_process_schedule_calendar
	 * @Date : 2019. 1. 15.
	 * @User : 신동철
	 * @Param : 시험전형 정보
	 * @Return : FAP 채용전형 일정 Calendar 컨트롤러
	 * @Method 설명 : 시험전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_EXAM_PROCESS_SCHEDULE_CALENDAR_UPDATE, method = RequestMethod.POST)
	public String update_exam_process_schedule_calendar(Model model, Authentication auth, SocietyFapJobRecruitPcsSch exam_process_schedule, SocietyFapJobExam exam_process, SocietyFapJobExamFile exam_file,
			SocietyFapJobExamObjEtc exam_obj_etc, SocietyFapJobExamSvEtc exam_sv_etc, SocietyFapJobExamNeedEtc exam_need_etc, SocietyFapJobExamType exam_type, RedirectAttributes redirect){
		logger.info("시험전형 Calendar 스케줄 설정 컨트롤러 시작");
		
		exam_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		exam_process.setFap_job_exam_udt_id((String)auth.getPrincipal());
		exam_file.setFap_job_exam_file_udt_id((String)auth.getPrincipal());
		exam_obj_etc.setFap_job_exam_obj_etc_udt_id((String)auth.getPrincipal());
		exam_sv_etc.setFap_job_exam_sv_etc_udt_id((String)auth.getPrincipal());
		exam_need_etc.setFap_job_exam_need_etc_udt_id((String)auth.getPrincipal());
		exam_type.setFap_job_exam_type_udt_id((String)auth.getPrincipal());
		sfaService.update_exam_process_schedule(exam_process_schedule, exam_process, exam_file, exam_obj_etc, exam_sv_etc, exam_need_etc, exam_type, auth);
		
		redirect.addAttribute("fap_jobfair_seq", exam_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", exam_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_gb", exam_process_schedule.getFap_job_recruit_pcs_gb());
		redirect.addAttribute("comp_nm", exam_process_schedule.getComp_nm());
		
		logger.info("시험전형 Calendar 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : update_itv_process_schedule_calendar
	 * @Date : 2019. 1. 15.
	 * @User : 신동철
	 * @Param : 면접전형 정보
	 * @Return : FAP 채용전형 일정 Calendar 컨트롤러
	 * @Method 설명 : 면접전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_INTERVEIW_PROCESS_SCHEDULE_CALENDAR_UPDATE, method = RequestMethod.POST)
	public String update_itv_process_schedule_calendar(Model model, Authentication auth, SocietyFapJobRecruitPcsSch itv_process_schedule, SocietyFapJobRecruitPcs itv_process,
			SocietyFapJobItv itv_process_info, SocietyFapJobItvTpEtc itv_tp_etc, SocietyFapJobItvObjEtc itv_obj_etc, RedirectAttributes redirect){
		logger.info("면접전형 Calendar 스케줄 설정 컨트롤러 시작");
		
		itv_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		itv_process.setFap_job_recruit_pcs_udt_id((String)auth.getPrincipal());
		itv_process_info.setFap_job_itv_udt_id((String)auth.getPrincipal());
		itv_tp_etc.setFap_job_itv_tp_etc_udt_id((String)auth.getPrincipal());
		itv_obj_etc.setFap_job_itv_obj_etc_udt_id((String)auth.getPrincipal());
		sfaService.update_itv_process_schedule(itv_process_schedule, itv_process, itv_process_info, itv_tp_etc, itv_obj_etc);
		
		redirect.addAttribute("fap_jobfair_seq", itv_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", itv_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_gb", itv_process_schedule.getFap_job_recruit_pcs_gb());
		redirect.addAttribute("comp_nm", itv_process_schedule.getComp_nm());
		
		logger.info("면접전형 Calendar 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM;
	}

	/**
	 * @Method Name : update_test_etc_process_schedule_calendar
	 * @Date : 2019. 1. 15.
	 * @User : 신동철
	 * @Param : 기타전형 정보
	 * @Return : FAP 채용전형 일정 Calendar 컨트롤러
	 * @Method 설명 : 기타전형 스케줄 설정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TEST_ETC_PROCESS_SCHEDULE_CALENDAR_UPDATE, method = RequestMethod.POST)
	public String update_test_etc_process_schedule_calendar(Model model, Authentication auth, SocietyFapJobRecruitPcsSch test_etc_process_schedule, 
			SocietyFapJobTestEtc test_etc_info,	SocietyFapJobTestEtcObj test_etc_obj, RedirectAttributes redirect){
		logger.info("기타전형 Calendar 스케줄 설정 컨트롤러 시작");
		
		test_etc_process_schedule.setFap_job_recruit_pcs_sch_udt_id((String)auth.getPrincipal());
		test_etc_info.setFap_job_test_etc_udt_id((String)auth.getPrincipal());
		test_etc_obj.setFap_job_test_etc_obj_udt_id((String)auth.getPrincipal());
		sfaService.update_test_etc_process_schedule(test_etc_process_schedule, test_etc_info, test_etc_obj);
		
		redirect.addAttribute("fap_jobfair_seq", test_etc_process_schedule.getFap_jobfair_seq());
		redirect.addAttribute("fap_jobfair_divide_seq", test_etc_process_schedule.getFap_jobfair_divide_seq());
		redirect.addAttribute("fap_job_recruit_pcs_gb", test_etc_process_schedule.getFap_job_recruit_pcs_gb());
		redirect.addAttribute("comp_nm", test_etc_process_schedule.getComp_nm());
		
		logger.info("기타전형 Calendar 스케줄 설정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : process_schedule_calendar_form
	 * @Date : 2018. 12. 27.
	 * @User : 신동철
	 * @Param : 잡페어 시퀀스, 잡페어 세부 시퀀스, 채용전형구분, 회사명
	 * @Return : JSP 리턴페이지(FAP 채용전형 캘린더 폼)
	 * @Method 설명 : 채용전형 캘린더 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM, method = RequestMethod.GET)
	public String process_schedule_calendar_form(Model model,  @RequestParam("fap_jobfair_seq") String fap_jobfair_seq,  @RequestParam("fap_jobfair_divide_seq") String fap_jobfair_divide_seq,
			@RequestParam("fap_job_recruit_pcs_gb") String fap_job_recruit_pcs_gb, @RequestParam("comp_nm") String comp_nm){
		logger.info("잡페어 채용전형 캘린더 페이지 이동 컨트롤러 시작");
		
		HashMap<String, Object> jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", jobfair_map);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		model.addAttribute("fap_job_recruit_pcs_gb", fap_job_recruit_pcs_gb);
		model.addAttribute("comp_nm", comp_nm);
		
		logger.info("잡페어 채용전형 캘린더 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PROCESS_SCHEDULE_CALENDAR_FORM;
	}
	
	/**
	 * @Method Name : required_doc_management
	 * @Date : 2019. 1. 17.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(FAP 내정서류 관리 폼)
	 * @Method 설명 : 관리자 내정서류 관리 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT, method = RequestMethod.GET)
	public String required_doc_management(Model model){
		logger.info("관리자 내정서류 관리 페이지 이동 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> job_ad_jobfair_list = sfaService.search_job_ad_jobfair_list();
		ArrayList<HashMap<String, Object>> job_ad_comp_list = sfaService.search_job_ad_comp_list();
		model.addAttribute("jobfair_list", job_ad_jobfair_list);
		model.addAttribute("comp_list", job_ad_comp_list);		
		
		
		logger.info("관리자 내정서류 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT_FORM;
	}

	/**
	 * @Method Name : required_doc_management_form
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 리턴페이지(FAP 관리자 개인내정서류 관리폼)
	 * @Method 설명 : 관리자 개인내정서류 관리폼으로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT_FORM, method = RequestMethod.GET)
	public String required_doc_management_form(Model model, HttpSession session, @RequestParam("fap_job_ad_seq") long fap_job_ad_seq, 
			@RequestParam("fap_jobfair_seq") int fap_jobfair_seq, @RequestParam("fap_comp_id") String fap_comp_id){
		logger.info("관리자 내정서류 관리폼 이동 컨트롤러 시작");
		
		ArrayList<HashMap<String, Object>> job_ad_jobfair_list = sfaService.search_job_ad_jobfair_list();
		ArrayList<HashMap<String, Object>> job_ad_comp_list = sfaService.search_job_ad_comp_list();
		model.addAttribute("jobfair_list", job_ad_jobfair_list);
		model.addAttribute("comp_list", job_ad_comp_list);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_comp_id", fap_comp_id);
		session.removeAttribute("job_ad_seq");
		
		logger.info("관리자 내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT_FORM;
	}	
	
	/**
	 * @Method Name : common_required_doc_insert
	 * @Date : 2019. 1. 18.
	 * @User : 신동철
	 * @Param : 내정자 공통서류
	 * @Return : -
	 * @Method 설명 : 내정자 공통서류 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String insert_common_required_doc(Authentication auth, Model model, SocietyFapCommonRequiredDoc common_required_doc, RedirectAttributes redirect){
		logger.info("관리자 내정서류 등록 컨트롤러 시작");
		
		common_required_doc.setFap_common_required_doc_ins_id(common_required_doc.getFap_comp_id());
		common_required_doc.setFap_common_required_doc_udt_id(common_required_doc.getFap_comp_id());
	    int result = sfcService.insert_common_required_doc(common_required_doc);
		
		if(result>0){		
			String fap_admin_id = (String)auth.getPrincipal();		 
			String fap_job_ad_title = sfaService.select_job_ad_title(common_required_doc.getFap_job_ad_seq());
			String fap_admin_notice_ct = "관리자 \'"+fap_admin_id+"\'가 채용공고  \'"+fap_job_ad_title+"\' 의 공통 내정서류를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_admin_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2306");
			int adminInfo = sfaService.insert_admin_notice_info(paramMap);
		}
		
		redirect.addAttribute("fap_job_ad_seq", common_required_doc.getFap_job_ad_seq());
		redirect.addAttribute("fap_jobfair_seq", common_required_doc.getFap_jobfair_seq());
		redirect.addAttribute("fap_comp_id", common_required_doc.getFap_comp_id());
		
		logger.info("관리자 내정서류 등록 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_management
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 리턴페이지(FAP 관리자 개인내정서류 관리 페이지)
	 * @Method 설명 : 관리자 개인내정서류 관리 페이지로 처음 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT, method = RequestMethod.GET)
	public String personal_required_doc_management(Model model, HttpSession session, long fap_nominee_seq, @RequestParam(defaultValue = "0") String fap_job_ad_seq){
		logger.info("관리자 개인내정서류 관리폼 이동 컨트롤러 시작");
		
		SocietyFapNominee nominee_info = sfcService.select_nominee_info(fap_nominee_seq);
		model.addAttribute("nominee_info", nominee_info);
		session.setAttribute("job_ad_seq", fap_job_ad_seq);
				
		logger.info("관리자 개인내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_management_form
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 내정자 시퀀스
	 * @Return : JSP 리턴페이지(FAP 관리자 개인내정서류 관리폼)
	 * @Method 설명 : 관리자 개인내정서류 관리폼으로 이동하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM, method = RequestMethod.GET)
	public String personal_required_doc_management_form(Model model, Authentication auth, @RequestParam("param") long fap_nominee_seq){
		logger.info("관리자 개인내정서류 관리폼 이동 컨트롤러 시작");
		
		SocietyFapNominee nominee_info = sfcService.select_nominee_info(fap_nominee_seq);
		model.addAttribute("nominee_info", nominee_info);
		
		logger.info("관리자 개인내정서류 관리폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : common_required_doc_update
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 수정할 내정서류정보
	 * @Return : 관리자 내정서류 관리폼
	 * @Method 설명 :  내정서류 수정 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_UPDATE, method = RequestMethod.POST)
	public String update_common_required_doc(Model model, Authentication auth, SocietyFapCommonRequiredDoc common_required_doc, RedirectAttributes redirect){
		logger.info("관리자 내정서류 수정 컨트롤러 시작");
		
		common_required_doc.setFap_common_required_doc_udt_id((String)auth.getPrincipal());
		sfcService.update_common_required_doc(common_required_doc);
		redirect.addAttribute("fap_job_ad_seq", common_required_doc.getFap_job_ad_seq());
		redirect.addAttribute("fap_jobfair_seq", common_required_doc.getFap_jobfair_seq());
		redirect.addAttribute("fap_comp_id", common_required_doc.getFap_comp_id());
		
		logger.info("관리자 내정서류 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : common_required_doc_delete
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 삭제할 내정서류정보
	 * @Return : 관리자 내정서류 관리폼
	 * @Method 설명 : 관리자 내정서류 삭제 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_COMMON_REQUIRED_DOC_DELETE, method = RequestMethod.GET)
	public String delete_common_required_doc(Model model, SocietyFapCommonRequiredDoc common_required_doc, RedirectAttributes redirect){
		logger.info("회사 내정서류 삭제 컨트롤러 시작");
		
		sfcService.delete_common_required_doc(common_required_doc);
		redirect.addAttribute("fap_job_ad_seq", common_required_doc.getFap_job_ad_seq());
		redirect.addAttribute("fap_jobfair_seq", common_required_doc.getFap_jobfair_seq());
		redirect.addAttribute("fap_comp_id", common_required_doc.getFap_comp_id());
		
		logger.info("회사 내정서류 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : persoanl_required_doc_insert
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 등록할 개인 내정서류정보
	 * @Return : 관리자 개인 내정서류 관리폼
	 * @Method 설명 : 관리자 개인 내정서류 등록 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String insert_personal_required_doc(Authentication auth, Model model, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("관리자 개인 내정서류 등록 컨트롤러 시작");
		
		personal_required_doc.setFap_personal_required_doc_ins_id(personal_required_doc.getFap_comp_id());
		personal_required_doc.setFap_personal_required_doc_udt_id(personal_required_doc.getFap_comp_id());
		int result = sfcService.insert_personal_required_doc(personal_required_doc);
		
		if(result>0){			
			String fap_admin_id = (String)auth.getPrincipal(); 
			String fap_job_ad_title = sfaService.select_job_ad_title(personal_required_doc.getFap_job_ad_seq());
			System.out.println("id:"+fap_admin_id+", title:"+fap_job_ad_title);
			String fap_admin_notice_ct = "관리자 \'"+fap_admin_id+"\'이(가) 채용공고  \'"+fap_job_ad_title+"\' 의 개인 내정서류를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_admin_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2306");
			int adminInfo = sfaService.insert_admin_notice_info(paramMap);
		}
		
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		logger.info("관리자 개인 내정서류 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_update
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 개인 내정서류정보
	 * @Return : 관리자 개인 내정서류 관리폼
	 * @Method 설명 : 개인 내정서류 수정 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_UPDATE, method = RequestMethod.POST)
	public String update_personal_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("관리자 개인 내정서류 수정 컨트롤러 시작");
		
		personal_required_doc.setFap_personal_required_doc_udt_id((String)auth.getPrincipal());
		sfcService.update_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("관리자 개인 내정서류 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : personal_required_doc_delete
	 * @Date : 2019. 1. 19.
	 * @User : 신동철
	 * @Param : 개인 내정서류정보
	 * @Return : 관리자 개인 내정서류 관리폼
	 * @Method 설명 : 관리자 개인 내정서류 삭제 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_DELETE, method = RequestMethod.GET)
	public String personal_required_doc_delete(Model model, SocietyFapPersonalRequiredDoc personal_required_doc, RedirectAttributes redirect){
		logger.info("관리자 개인 내정서류 삭제 컨트롤러 시작");
		
		sfcService.delete_personal_required_doc(personal_required_doc);
		redirect.addAttribute("param", personal_required_doc.getFap_nominee_seq());
		
		logger.info("관리자 개인 내정서류 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : nominee_required_doc_insert
	 * @Date : 2019. 1. 8.
	 * @User : 신동철
	 * @Param : 업로드할 개인 내정서류정보
	 * @Return : 관리자 개인 내정서류 관리 페이지)
	 * @Method 설명 : 관리자 내정자 내정서류 업로드 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_NOMINEE_REQUIRED_DOC_INSERT, method = RequestMethod.POST)
	public String insert_nominee_required_doc(Model model, Authentication auth, SocietyFapPersonalRequiredDoc user_required_doc, RedirectAttributes redirect){
		logger.info("관리자 내정자 내정서류 업로드 컨트롤러 시작");
				
		user_required_doc.setFap_personal_required_doc_ins_id(user_required_doc.getUser_id());
		user_required_doc.setFap_personal_required_doc_udt_id(user_required_doc.getUser_id());
		int result = sfuService.insert_user_required_doc(user_required_doc);
		
		if(result>0){				
			String fap_admin_id = (String)auth.getPrincipal();		 
			String fap_user_id = user_required_doc.getUser_id();
			String fap_job_ad_title = sfaService.select_job_ad_title(user_required_doc.getFap_job_ad_seq());
			String fap_admin_notice_ct = "관리자 \'"+fap_admin_id+"\'이(가) 채용공고  \'"+fap_job_ad_title+"\' 에서 내정자 \'"+fap_user_id+"\'대신 서류를 등록했습니다.";
			HashMap<String, Object> paramMap = new HashMap<>();
			paramMap.put("fap_admin_notice_ins_id", fap_admin_id);	 
			paramMap.put("fap_admin_notice_ct", fap_admin_notice_ct);
			paramMap.put("fap_admin_notice_handle_gb","D2306");
			int adminInfo = sfaService.insert_admin_notice_info(paramMap);
		}
		
		
		redirect.addAttribute("param", user_required_doc.getFap_nominee_seq());
		
		logger.info("관리자 내정자 내정서류 업로드 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_PERSONAL_REQUIRED_DOC_MANAGEMENT_FORM;
	}

	/**
	 * @Method Name : per_jobfair_temp_group_management
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 잡페어 리스트
	 * @Method 설명 : 잡페어별 임시 결제 그룹 관리 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_MANAGEMENT, method = RequestMethod.GET)
	public String per_jobfair_temp_group_management(Model model) {
		logger.info("잡페어별 임시 결제 그룹 관리 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.info("잡페어별 임시 결제 그룹 관리 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_insert_form
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 선택된 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 등록 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_INSERT_FORM, method = RequestMethod.POST)
	public String per_jobfair_temp_group_insert_form(Model model, SocietyFapAdminJobfair jobfair) {
		logger.info("잡페어별 임시 결제 그룹 등록 폼 이동 컨트롤러 시작");
		
		model.addAttribute("jobfair", jobfair);
		
		logger.info("잡페어별 임시 결제 그룹 등록 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_INSERT_FORM;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_insert
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹정보, 세부 잡페어별 임시 결제 정보
	 * @Return : 잡페어별 임시 결제 그룹 관리 페이지
	 * @Method 설명 : 잡페어별 임시 결제 그룹정보 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_INSERT, method = RequestMethod.POST)
	public String per_jobfair_temp_group_insert(SocietyFapPerJobfairTempGroup perGroup, SocietyFapPerJobfairDivideTemp divideTemp, Authentication auth) {
		logger.info("잡페어별 임시 결제 그룹 등록 컨트롤러 시작");
		
		perGroup.setFap_per_jobfair_temp_group_ins_id((String)auth.getPrincipal());
		perGroup.setFap_per_jobfair_temp_group_udt_id((String)auth.getPrincipal());
		
		for(SocietyFapPerJobfairDivideTemp list :  divideTemp.getPerJobfairDivideList()) {
			list.setFap_per_jobfair_divide_temp_ins_id((String)auth.getPrincipal());
			list.setFap_per_jobfair_divide_temp_udt_id((String)auth.getPrincipal());
		}
		
		sfaService.per_jobfair_temp_group_insert(perGroup, divideTemp);
		
		logger.info("잡페어별 임시 결제 그룹 등록 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_delete
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹 정보 시퀀스
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 정보 삭제
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_DELETE, method = RequestMethod.POST)
	public String per_jobfair_temp_group_delete(int fap_per_jobfair_temp_group_seq) {
		logger.debug("잡페어별 임시 결제 그룹 정보 삭제 컨트롤러 시작");
		
		sfaService.per_jobfair_temp_group_delete(fap_per_jobfair_temp_group_seq);
		
		logger.debug("잡페어별 임시 결제 그룹 정보 삭제 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_update_form
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 선택된 잡페어 객체
	 * @Return : -
	 * @Method 설명 : 잡페어별 임시 결제 그룹 수정 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_UPDATE_FORM, method = RequestMethod.POST)
	public String per_jobfair_temp_group_update_form(Model model, SocietyFapAdminJobfair jobfair,SocietyFapPerJobfairTempGroup perGroup) {
		logger.info("잡페어별 임시 결제 그룹 등록 폼 이동 컨트롤러 시작");
		
		model.addAttribute("jobfair", jobfair);
		HashMap<String, Object> result = sfaService.per_jobfair_temp_group_search_detail(perGroup);
		
		model.addAttribute("result", result);

		Gson gson = new Gson();
		model.addAttribute("resultGson", gson.toJson(result));
		
		logger.info("잡페어별 임시 결제 그룹 등록 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : per_jobfair_temp_group_update
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : 잡페어별 임시 결제 그룹정보, 세부 잡페어별 임시 결제 정보
	 * @Return : 잡페어별 임시 결제 그룹 관리 페이지
	 * @Method 설명 : 잡페어별 임시 결제 그룹정보 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_UPDATE, method = RequestMethod.POST)
	public String per_jobfair_temp_group_update(SocietyFapPerJobfairTempGroup perGroup, SocietyFapPerJobfairDivideTemp divideTemp, Authentication auth) {
		logger.info("잡페어별 임시 결제 그룹 등록 컨트롤러 시작");
		
		perGroup.setFap_per_jobfair_temp_group_ins_id((String)auth.getPrincipal());
		perGroup.setFap_per_jobfair_temp_group_udt_id((String)auth.getPrincipal());
		
		for(SocietyFapPerJobfairDivideTemp list :  divideTemp.getPerJobfairDivideList()) {
			list.setFap_per_jobfair_divide_temp_ins_id((String)auth.getPrincipal());
			list.setFap_per_jobfair_divide_temp_udt_id((String)auth.getPrincipal());
		}
		
		sfaService.per_jobfair_temp_group_update(perGroup, divideTemp);
		
		logger.info("잡페어별 임시 결제 그룹 등록 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_PER_JOBFAIR_TEMP_GROUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : per_comp_temp_payment_management
	 * @Date : 2019. 1. 26.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 잡페어 리스트
	 * @Method 설명 : 잡페어별 임시 결제 그룹 관리 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_MANAGEMENT, method = RequestMethod.GET)
	public String per_comp_temp_payment_management(Model model) {
		logger.info("잡페어별 임시 결제 그룹 관리 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.info("잡페어별 임시 결제 그룹 관리 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_PER_COMP_TEMP_PAYMENT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : admin_faq_management
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 관리자 faq관리 페이지
	 * @Method 설명 : 파인애플의 faq리스트를 조회하여 관리페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_FAQ_MANAGEMENT, method = RequestMethod.GET)
	public String admin_faq_management(Model model){
		logger.info("관리자 faq관리 페이지 이동 시작");
		ArrayList<HashMap<String, Object>> faqList = sfaService.fap_faq_select_list();
		model.addAttribute("faqList", faqList);
		logger.info("관리자 faq관리 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_FAQ_MANAGEMENT;
	}
	
	/**
	 * @Method Name : admin_faq_insert_form
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 관리자 faq등록 페이지
	 * @Method 설명 : 파인애플의 faq등록페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_FAQ_INSERT_FORM, method = RequestMethod.GET)
	public String admin_faq_insert_form() {
		logger.info("관리자 faq등록 페이지 이동 시작");
		logger.info("관리자 faq등록 페이지 이동 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_FAQ_INSERT_FORM;
	}
	
	/**
	 * @Method Name : admin_faq_insert
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 파인애플 FAQ 정보
	 * @Return : 관리자 faq관리 페이지
	 * @Method 설명 : 파인애플의 faq내용 등록 후 관리페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_FAQ_INSERT, method = RequestMethod.POST)
	public String admin_faq_insert(FaqConsultingContents content , SocietyFapAdminFaqGb faqGb, Authentication auth) {
		logger.info("관리자 faq등록 컨트롤러 시작");
		
		String admin_id = (String)auth.getPrincipal();
		
		content.setConsulting_ins_id(admin_id);
		content.setConsulting_udt_id(admin_id);
		
		faqGb.setFap_faq_gb_ins_id(admin_id);
		faqGb.setFap_faq_gb_udt_id(admin_id);
		
		sfaService.fap_faq_insert_content(content, faqGb);
		
		logger.info("관리자 faq등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_FAQ_MANAGEMENT;
	}
	
	/**
	 * @Method Name : admin_faq_update_form
	 * @Date : 2019. 4. 9.
	 * @User : 이종호
	 * @Param : 
	 * @Return : 관리자 faq수정 페이지
	 * @Method 설명 : 파인애플의 faq수정페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FAQ_UPDATE_FORM, method = RequestMethod.GET)
	public String admin_faq_update_form(int consulting_seq, Model model) {
		logger.info("관리자 faq수정페이지 이동 컨트롤러 시작");
		HashMap<String, Object> result = sfaService.fap_faq_select_one(consulting_seq);
		
		model.addAttribute("result", result);
		logger.info("관리자 faq수정페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_FAQ_UPDATE_FORM;
	}
	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FAQ_UPDATE, method = RequestMethod.POST)
	public String admin_faq_update(FaqConsultingContents content , SocietyFapAdminFaqGb faqGb, Authentication auth) {
		
		logger.info("관리자 faq수정 컨트롤러 시작");
		
		String admin_id = (String)auth.getPrincipal();
		
		content.setConsulting_udt_id(admin_id);
		
		faqGb.setFap_faq_gb_udt_id(admin_id);
		
		sfaService.fap_faq_update_content(content, faqGb);
		
		logger.info("관리자 faq수정 컨트롤러 종료");
		
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_FAQ_MANAGEMENT;
	}
	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FAQ_DELETE, method = RequestMethod.GET)
	public String admin_faq_delete(int consulting_seq) {
		logger.info("관리자 faq삭제 컨트롤러 시작");
		
		sfaService.fap_faq_delete(consulting_seq);
		
		logger.info("관리자 faq삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_FAQ_MANAGEMENT;
	}
	
	/**
	 * @Method Name : notice_management
	 * @Date : 2019. 2. 14.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(공지사항 관리)
	 * @Method 설명 : 공지사항 관리 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_NOTICE_MANAGEMENT, method = RequestMethod.GET)
	public String notice_management(Model model,
			@RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int pageCount,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type){
		logger.info("FAP 관리자 공지사항 관리 이동 컨트롤러 시작");
		logger.debug("모집홍보 관리자 게시판 관리 폼 이동 컨트롤러 시작");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("search_division", search_division);
		map.put("search_type", search_type);
		
		int count = sfaService.board_search_all_count(map);
		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count, curPage);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<BoardGroup> resultList = sfaService.board_search_all(map);	
		model.addAttribute("map", map);
		model.addAttribute("resultList", resultList);
		model.addAttribute("curPage", curPage);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("search_division", search_division);
		model.addAttribute("search_type", search_type);
		logger.info("FAP 관리자 공지사항 관리 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_NOTICE_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_notice_management
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 시퀀스
	 * @Return : JSP 리턴 페이지(관리자 게시글 리스트 페이지)
	 * @Method 설명 : 특정 게시판 시퀀스에 해당하는 게시글 리스트 를 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT, method = RequestMethod.POST)
	public String fap_notice_management(Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type,
			@RequestParam(defaultValue="0") int board_seq,
			@RequestParam(defaultValue="") String borad_nm,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="10") int pageCount			
			){
			
		logger.debug("모집홍보 관리자 게시글 리스트 조회 컨트롤러 시작");
		
		int curPage = page;
		HashMap<String, Object> map = new HashMap<String, Object>();
		// map.put("board_seq", board_seq);
		map.put("board_detail_gb", boardGroup.getBoard_detail_gb());
		int count = sfaService.board_contents_count(map);
	 
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		logger.debug("adminPager {}", adminPager);
		
		map.put("pageCount", pageCount);
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		
		ArrayList<HashMap<String,Object>> resultList = sfaService.board_contents_search(map);
		
		model.addAttribute("contentList", resultList);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		//model.addAttribute("board_seq",board_seq);
		//model.addAttribute("borad_nm",borad_nm);
		model.addAttribute("map", map);
		logger.debug("모집홍보 관리자 게시글 리스트 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT;
	}
	
	/**
	 * @Method Name : notice_insert_form
	 * @Date : 2019. 2. 14.
	 * @User : 김준영
	 * @Param : -
	 * @Return : JSP 리턴페이지(공지사항 작성폼)
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_NOTICE_INSERT_FORM, method = RequestMethod.GET)
	public String notice_insert_form(Model model, int board_seq,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type
			){
		logger.info("FAP 관리자 공지사항 작성폼 이동 컨트롤러 시작");
		model.addAttribute("board_seq", board_seq);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		logger.info("FAP 관리자 공지사항 작성폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_NOTICE_INSERT_FORM;
	}
	
	/**
	 * @Method Name : notice_insert
	 * @Date : 2019. 2. 14.
	 * @User : 김준영
	 * @Param : 공지사항 내용, 부가내용
	 * @Return : JSP 리턴페이지(공지사항 작성폼)
	 * @Method 설명 : FAP 공지사항 내용, 부가내용 등록 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_NOTICE_INSERT, method = RequestMethod.POST)
	public String notice_insert(Model model, Authentication auth, BoardContent boardContent, 
			SocietyFapAdminNoticeContent noticeContent, RedirectAttributes redirect, BoardFile boardFile, 
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type){
		logger.info("FAP 관리자 공지사항 등록 컨트롤러 시작");
		System.out.println("boardContent:"+boardContent);
        System.out.println("noticeContent:"+noticeContent);
		
		boardContent.setBoard_content_ins_id((String)auth.getPrincipal());
		boardContent.setBoard_content_udt_id((String)auth.getPrincipal());
		boardContent.setBoard_content_nm((String)auth.getPrincipal());
		sfaService.notice_insert(auth, boardContent, noticeContent, boardFile);
		
		redirect.addAttribute("board_seq", boardContent.getBoard_seq());
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		
		logger.info("FAP 관리자 공지사항 등록 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT_FORM;
	}
	
	/**
	 * @Method Name : fap_notice_management_form
	 * @Date : 2019. 2. 15.
	 * @User : 김준영
	 * @Param : 게시판 시퀀스
	 * @Return : JSP 리턴 페이지(관리자 게시글 리스트 페이지)
	 * @Method 설명 : 특정 게시판 시퀀스에 해당하는 게시글 리스트 를 조회하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT_FORM, method = RequestMethod.GET)
	public String fap_notice_management_form(Model model, BoardGroup boardGroup,
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type,
			@RequestParam(defaultValue="0") int board_seq,
			@RequestParam(defaultValue="") String borad_nm,
			@RequestParam(defaultValue="1") int page,
			@RequestParam(defaultValue="10") int pageCount
			){
		logger.debug("모집홍보 관리자 게시글 리스트 조회 컨트롤러 시작");
		int curPage = page;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageCount", pageCount);
		map.put("board_seq", board_seq);

		int count = sfaService.board_contents_count(map);
		
		AdminPager.setPAGE_SCALE(pageCount);
		AdminPager adminPager = new AdminPager(count,curPage);
		logger.debug("adminPager {}", adminPager);
		
		map.put("count", count); // 레코드의 갯수
		map.put("adminPager", adminPager);
		map.put("board_detail_gb", boardGroup.getBoard_detail_gb());
		ArrayList<HashMap<String,Object>> resultList = sfaService.board_contents_search(map);
		
		model.addAttribute("contentList", resultList);
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("search_division",search_division);
		model.addAttribute("search_type",search_type);
		model.addAttribute("board_seq",board_seq);
		model.addAttribute("borad_nm",borad_nm);
		model.addAttribute("map", map);
		logger.debug("모집홍보 관리자 게시글 리스트 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY+PathConstants.SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT;
	}
	
	/**
	 * @Method Name : notice_contents_detail
	 * @Date : 2019. 7.31.
	 * @User : 김경아
	 * @Param : 게시판 글 seq
	 * @Return : JSP 리턴페이지(공지사항을 읽은 페이지)
	 * @Method 설명 : 공지사항을 읽는 페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_NOTICE_CONTENTS_DETAIL, method = RequestMethod.GET)
	public String notice_contents_detail(Model model, BoardGroup boardGroup, int board_seq, int board_content_seq){
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 시작");

		//조회수 증가
		sfaService.board_contents_hit_update(board_content_seq);
		//조회
		HashMap<String, Object> resultMap = sfaService.board_contents_detail(board_content_seq);
		model.addAttribute("contentDetail", resultMap);
		model.addAttribute("board_content_seq", board_content_seq);
		model.addAttribute("board_seq", board_seq);
		model.addAttribute("board_detail_gb",boardGroup.getBoard_detail_gb());
		Gson gson = new Gson();
		String content_Detail = gson.toJson(resultMap);
		String replace_content_Detail = content_Detail.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");		
		model.addAttribute("content_Detail", replace_content_Detail);
		
		logger.debug("잡페어 공지사항 게시판 세부내용 검색 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_NOTICE_CONTENTS_DETAIL;
	}
	
	/**
	 * @Method Name : notice_update_form
	 * @Date : 2019. 2. 20.
	 * @User : 김준영
	 * @Param : 게시판 seq
	 * @Return : JSP 리턴페이지(공지사항 수정폼)
	 * @Method 설명 : 공지사항을 수정하는 폼으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_NOTICE_UPDATE_FORM, method = RequestMethod.POST)
	public String notice_update_form(Model model, int board_seq, int board_content_seq, String board_detail_gb){
		
		//조회
		HashMap<String, Object> resultMap = sfaService.board_contents_detail(board_content_seq);
		model.addAttribute("contentDetail", resultMap);
		//model.addAttribute("board_content_seq", board_content_seq);
		model.addAttribute("board_seq", board_seq);
		model.addAttribute("board_detail_gb", board_detail_gb);
		Gson gson = new Gson();
		String content_Detail = gson.toJson(resultMap);
		String replace_content_Detail = content_Detail.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");		
		model.addAttribute("content_Detail", replace_content_Detail);
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_NOTICE_UPDATE_FORM;
	}
	

	/**
	 * @Method Name : jobfair_applicable_time_management
	 * @Date : 2019. 2. 21.
	 * @User : 원병호
	 * @Param : 잡페어 세부 일련번호
	 * @Return : 
	 * @Method 설명 : 지원가능시간 관리 관리 페이지
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_APPLICABLE_TIME_MANAGEMENT, method = RequestMethod.GET)
	public String jobfair_applicable_time_management(Model model, int fap_jobfair_seq){
		
		//HashMap<String, Object> app_time_map = sfaService.select_jobfair_applicable_time(fap_jobfair_seq);
		Gson gson = new Gson();
		//model.addAttribute("app_time_map_json", gson.toJson(app_time_map));
		//model.addAttribute("app_time_map", app_time_map);
		
		HashMap<String, Object> jobfair_info =  sfaService.select_fap_jobfair_info(fap_jobfair_seq);
		
		model.addAttribute("jobfair_info_json", gson.toJson(jobfair_info));
		model.addAttribute("jobfair_info", jobfair_info);
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_APPLICABLE_TIME_MANAGEMENT;
	}

	/**
	 * @Method Name : jobfair_attended_comp_list
	 * @Date : 2019. 2. 21.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(잡페어에 참가한 기업 리스트 페이지)
	 * @Method 설명 : 잡페어에 참가한 기업 리스트 페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_ATTENDED_COMP_LIST, method = RequestMethod.GET)
	public String jobfair_attended_comp_list(Model model){
		logger.debug("잡페어에 참가한 기업 리스트 페이지로 이동 컨트롤러 시작");
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		ArrayList<HashMap<String, Object>> resultList = sfaService.search_jobfair_attended_comp_list();
		model.addAttribute("jobfairList", jobfairList);
		model.addAttribute("resultList", resultList);
		logger.debug("잡페어에 참가한 기업 리스트 페이지로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_ATTENDED_COMP_LIST_FORM;
	}
	
	/**
	 * @Method Name : user_apply_numbers_management
	 * @Date : 2019. 2. 24.
	 * @User : 신동철
	 * @Param : -
	 * @Return : JSP 리턴페이지(잡페어 지원자 지원가능 갯수 설정 페이지)
	 * @Method 설명 : 잡페어 지원자 지원가능 갯수 설정 페이지로 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_USER_APPLY_NUMBERS_MANAGEMENT, method = RequestMethod.GET)
	public String user_apply_numbers_management(Model model){
		logger.debug("잡페어 지원자 지원가능 갯수 설정 페이지로 이동 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.debug("잡페어 지원자 지원가능 갯수 설정 페이지로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_USER_APPLY_NUMBERS_MANAGEMENT;
	}
	
	/**
	 * @Method Name : update_user_apply_numbers
	 * @Date : 2019. 2. 25.
	 * @User : 신동철
	 * @Param : 지원자 지망가능 갯수
	 * @Return : JSP 리턴페이지(잡페어 지원자 지원가능 갯수 설정 페이지)
	 * @Method 설명 : 잡페어 지원자 지원가능 갯수 수정
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_UPDATE_USER_APPLY_NUMBERS, method = RequestMethod.POST)
	public String update_user_apply_numbers(Model model, Authentication auth, SocietyFapUserApplyNumbers userApplyNumbers){
		logger.debug("잡페어 지원자 지원가능 갯수 수정 컨트롤러 시작");
		
		sfaService.update_user_apply_numbers(auth, userApplyNumbers);
		
		logger.debug("잡페어 지원자 지원가능 갯수 수정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_USER_APPLY_NUMBERS_MANAGEMENT;
	}
	
	/**
	 * @Method Name : insert_jobfair_applicable_time
	 * @Date : 2019. 2. 27.
	 * @User : 원병호 
	 * @Param : 잡페어 추가지원 정보 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 추가지원 정보 등록 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_INSERT_JOB_APPLICABLETIME, method = RequestMethod.POST)
	public String insert_jobfair_applicable_time(SocietyFapJobfairApplicableTime jobfairApplicableTime, int fap_jobfair_seq, Authentication auth){
		logger.info("FAP 관리자 잡페어 추가지원 정보 등록 시작");
		jobfairApplicableTime.setFap_jobfair_applicable_time_ins_id((String)auth.getPrincipal());
		jobfairApplicableTime.setFap_jobfair_applicable_time_udt_id((String)auth.getPrincipal());
		sfaService.insert_jobfair_applicable_time_one(jobfairApplicableTime);
		logger.info("FAP 관리자 잡페어 추가지원 정보 등록 끝");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_APPLICABLE_TIME_MANAGEMENT + "?fap_jobfair_seq=" + fap_jobfair_seq;
	}
	
	/**
	 * @Method Name : notice_update
	 * @Date : 2019. 3. 4.
	 * @User : 신동철
	 * @Param : 공지사항 내용, 부가내용
	 * @Return : JSP 리턴페이지(공지사항 관리폼)
	 * @Method 설명 : FAP 공지사항 내용, 부가내용 등록 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_NOTICE_UPDATE, method = RequestMethod.POST)
	public String notice_update(Model model, Authentication auth, BoardContent boardContent, 
			SocietyFapAdminNoticeContent noticeContent, RedirectAttributes redirect, BoardFile boardFile){
		logger.info("FAP 관리자 공지사항 수정 컨트롤러 시작");
				
		boardContent.setBoard_content_udt_id((String)auth.getPrincipal());
		boardContent.setBoard_content_nm((String)auth.getPrincipal());
		sfaService.notice_update(auth, boardContent, noticeContent, boardFile);
		
		redirect.addAttribute("board_seq", boardContent.getBoard_seq());
		
		logger.info("FAP 관리자 공지사항 수정 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_FAP_NOTICE_MANAGEMENT_FORM;
	}
	
	
	/**
	 * @Method Name : update_jobfair_applicable_time
	 * @Date : 2019. 3. 04.
	 * @User : 원병호 
	 * @Param : 잡페어 추가지원 정보 객체
	 * @Return : -
	 * @Method 설명 : 잡페어 추가지원 정보 등록 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_UPDATE_JOB_APPLICABLETIME, method = RequestMethod.POST)
	public String update_jobfair_applicable_time(SocietyFapJobfairApplicableTime jobfairApplicableTime, int fap_jobfair_seq, Authentication auth){
		logger.info("FAP 관리자 잡페어 추가지원 정보 수정 시작");
		jobfairApplicableTime.setFap_jobfair_applicable_time_ins_id((String)auth.getPrincipal());
		jobfairApplicableTime.setFap_jobfair_applicable_time_udt_id((String)auth.getPrincipal());
		sfaService.update_jobfair_applicable_time_one(jobfairApplicableTime);
		logger.info("FAP 관리자 잡페어 추가지원 정보 수정 끝");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_APPLICABLE_TIME_MANAGEMENT + "?fap_jobfair_seq=" + fap_jobfair_seq;
	}
	
	/**
	 * @Method Name : delete_jobfair_applicable_time
	 * @Date : 2019. 3. 04.
	 * @User : 원병호 
	 * @Param : 잡페어 추가지원 일련번호
	 * @Return : -
	 * @Method 설명 : 잡페어 추가지원 정보 삭제
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_DELETE_JOB_APPLICABLETIME, method = RequestMethod.GET)
	public String delete_jobfair_applicable_time(int fap_jobfair_applicable_time_seq, int fap_jobfair_seq, int fap_jobfair_divide_seq, Authentication auth){
		logger.info("FAP 관리자 잡페어 추가지원 정보 삭제 시작");
		sfaService.delete_jobfair_applicable_time(fap_jobfair_applicable_time_seq, fap_jobfair_divide_seq);		
		
		logger.info("FAP 관리자 잡페어 추가지원 정보 삭제 끝");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_APPLICABLE_TIME_MANAGEMENT + "?fap_jobfair_seq=" + fap_jobfair_seq;
	}
	
	/**
	 * @Method Name : jobfair_qna_permission
	 * @Date : 2019. 3. 6.
	 * @User : 신동철 
	 * @Param : -
	 * @Return : 잡페어 지원자 채용공고 질문 승인 페이지
	 * @Method 설명 : 잡페어 지원자 채용공고 질문 승인 페이지 이동 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_QNA_PERMISSION, method = RequestMethod.GET)
	public String jobfair_qna_permission(Model model, @RequestParam(defaultValue="") String fap_comp_id,
			@RequestParam(defaultValue="0") long fap_job_ad_seq, @RequestParam(defaultValue="") String fap_job_qna_question_per, 
			@RequestParam(defaultValue="") String user_nm){
		logger.info("FAP 잡페어 지원자 채용공고 질문 승인 페이지 이동 시작");
		//질문 받은 기업 리스트 검색
		ArrayList<HashMap<String, Object>> resultList = sfaService.search_qna_comp();
		model.addAttribute("qna_comp_list", resultList);
		model.addAttribute("fap_comp_id", fap_comp_id);
		model.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		model.addAttribute("fap_job_qna_question_per", fap_job_qna_question_per);
		model.addAttribute("user_nm", user_nm);
		logger.info("FAP 잡페어 지원자 채용공고 질문 승인 페이지 이동 끝");
		return PathConstants.SEGROUP_SOCIETY +  PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_QNA_PERMISSION;
	}
	
	/**
	 * @Method Name : jobfair_user_qna_permission
	 * @Date : 2019. 3. 6.
	 * @User : 신동철 
	 * @Param : 질문 시퀀스
	 * @Return : 잡페어 지원자 채용공고 질문 승인
	 * @Method 설명 : 잡페어 지원자 채용공고 질문 승인
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_USER_QNA_PERMISSION, method = RequestMethod.GET)
	public String jobfair_user_qna_permission(Model model, @RequestParam List<Integer> fap_jobfair_user_qna_seq_list, @RequestParam(defaultValue="") String fap_comp_id,
			@RequestParam(defaultValue="0") long fap_job_ad_seq, @RequestParam(defaultValue="") String fap_job_qna_question_per, 
			@RequestParam(defaultValue="") String user_nm, RedirectAttributes redirect){
		logger.info("FAP 잡페어 지원자 채용공고 질문 승인 컨트롤러 시작");		
		//채용공고 질문 승인
		sfaService.jobfair_user_qna_permission(fap_jobfair_user_qna_seq_list);	
		redirect.addAttribute("fap_comp_id", fap_comp_id);
		redirect.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		redirect.addAttribute("fap_job_qna_question_per", fap_job_qna_question_per);
		redirect.addAttribute("user_nm", user_nm);
		logger.info("FAP 잡페어 지원자 채용공고 질문 승인 컨트롤러 끝");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_QNA_PERMISSION;
	}
	
	/**
	 * @Method Name : jobfair_user_qna_nonpermission
	 * @Date : 2019. 3. 6.
	 * @User : 신동철 
	 * @Param : 질문 시퀀스
	 * @Return : 잡페어 지원자 채용공고 질문 승인
	 * @Method 설명 : 잡페어 지원자 채용공고 질문 승인
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_USER_QNA_NONPERMISSION, method = RequestMethod.GET)
	public String jobfair_user_qna_nonpermission(Model model, @RequestParam List<Integer> fap_jobfair_user_qna_seq_list, @RequestParam(defaultValue="") String fap_comp_id,
			@RequestParam(defaultValue="0") long fap_job_ad_seq, @RequestParam(defaultValue="") String fap_job_qna_question_per, 
			@RequestParam(defaultValue="") String user_nm, RedirectAttributes redirect){
		logger.info("FAP 잡페어 지원자 채용공고 질문 미승인 컨트롤러 시작");		
		//채용공고 질문 승인
		sfaService.jobfair_user_qna_nonpermission(fap_jobfair_user_qna_seq_list);	
		redirect.addAttribute("fap_comp_id", fap_comp_id);
		redirect.addAttribute("fap_job_ad_seq", fap_job_ad_seq);
		redirect.addAttribute("fap_job_qna_question_per", fap_job_qna_question_per);
		redirect.addAttribute("user_nm", user_nm);
		logger.info("FAP 잡페어 지원자 채용공고 질문 미승인 컨트롤러 끝");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_QNA_PERMISSION;
	}
	
	/**
	 * @Method Name : insert_qna_question_refuse_reason
	 * @Date : 2019. 3. 7.
	 * @User : 신동철 
	 * @Param : 질문 시퀀스, 미승인사유
	 * @Return : -
	 * @Method 설명 : 잡페어 지원자 채용공고 미승인사유 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_INSERT_QNA_QUESTION_REFUSE_REASON, method = RequestMethod.POST)
	public String insert_qna_question_refuse_reason(long fap_job_qna_question_seq, String fap_job_qna_refuse_reason){
		logger.info("FAP 잡페어 지원자 채용공고 질문 미승인사유 등록 컨트롤러 시작");
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_qna_question_seq", fap_job_qna_question_seq);
		hashmap.put("fap_job_qna_refuse_reason", fap_job_qna_refuse_reason);
		sfaService.insert_qna_question_refuse_reason(hashmap);
		logger.info("FAP 잡페어 지원자 채용공고 질문 미승인사유 등록 컨트롤러 끝");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_QNA_PERMISSION;
	}
	
	/**
	 * @Method Name : update_qna_question_refuse_reason
	 * @Date : 2019. 3. 7.
	 * @User : 신동철 
	 * @Param : 질문 시퀀스, 미승인사유
	 * @Return : -
	 * @Method 설명 : 잡페어 지원자 채용공고 미승인사유 수정
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_UPDATE_QNA_QUESTION_REFUSE_REASON, method = RequestMethod.POST)
	public String update_qna_question_refuse_reason(long fap_job_qna_question_seq, String fap_job_qna_refuse_reason){
		logger.info("FAP 잡페어 지원자 채용공고 질문 미승인사유 수정 컨트롤러 시작");
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_job_qna_question_seq", fap_job_qna_question_seq);
		hashmap.put("fap_job_qna_refuse_reason", fap_job_qna_refuse_reason);
		sfaService.insert_qna_question_refuse_reason(hashmap);
		logger.info("FAP 잡페어 지원자 채용공고 질문 미승인사유 수정 컨트롤러 끝");
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_QNA_PERMISSION;
	}
	
	/**
	 * @Method Name : jobfair_divide_final_select
	 * @Date : 2019. 3. 13.
	 * @User : 신동철 
	 * @Param : -
	 * @Return : 잡페어 세부별 최종합격자 결정 시한 설정 페이지
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 페이지 이동
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_DIVIDE_FINAL_SELECT, method = RequestMethod.GET)
	public String jobfair_divide_final_select(Model model){
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 페이지 이동 컨트롤러 시작");
		HashMap<String, Object> jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", jobfair_map);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 페이지 이동 컨트롤러 끝");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_DIVIDE_FINAL_SELECT;
	}
	
	/**
	 * @Method Name : insert_fap_jobfair_divide_final_select
	 * @Date : 2019. 3. 13.
	 * @User : 신동철 
	 * @Param : 잡페어 세부 시퀀스, 최종합격 결정 시작일, 최종합격 결정 마감일
	 * @Return : -
	 * @Method 설명 : 잡페어 세부별 최종합격자 결정 시한 설정 등록
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_INSERT_FAP_JOBFAIR_DIVIDE_FINAL_SELECT, method = RequestMethod.POST)
	public String insert_fap_jobfair_divide_final_select(Model model, int fap_jobfair_divide_seq, String fap_jobfair_divide_final_select_st, String fap_jobfair_divide_final_select_et){
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 페이지 이동 컨트롤러 시작");
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		hashmap.put("fap_jobfair_divide_final_select_st", fap_jobfair_divide_final_select_st);
		hashmap.put("fap_jobfair_divide_final_select_et", fap_jobfair_divide_final_select_et);
		sfaService.insert_fap_jobfair_divide_final_select(hashmap);
		HashMap<String, Object> jobfair_map = sfcrService.select_jobfair();
		model.addAttribute("jobfair_map", jobfair_map);
		logger.info("FAP 잡페어 세부별 최종합격자 결정 시한 설정 페이지 이동 컨트롤러 끝");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOBFAIR_DIVIDE_FINAL_SELECT;
	}
	
	/**
	 * @Method Name : final_decision_time_form
	 * @Date : 2019. 3. 20.
	 * @User : 이종호 
	 * @Param : -
	 * @Return : 최종확정 기간 설정 폼
	 * @Method 설명 : 지원자 최종확정 기간 설정 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_FORM, method = RequestMethod.GET)
	public String final_decision_time_form(Model model) {
		logger.info("FAP 지원자 최종확정 기간 설정 폼 이동 컨트롤러 시작");
		
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList", jobfairList);
		
		logger.info("FAP 지원자 최종확정 기간 설정 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_FINAL_DECISION_TIME_FORM;
	}
	
	/**
	 * @Method Name : open_pt_management
	 * @Date : 2019. 4. 11.
	 * @User : 이종호 
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 관리 폼
	 * @Method 설명 : 오픈잡페어 설명회 관리 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_MANAGEMENT, method = RequestMethod.GET)
	public String open_pt_management(Model model) {
		logger.info("FAP 오픈잡페어 설명회 관리 폼 이동 컨트롤러 시작");
		
		ArrayList<SocietyFapOpenPt> result = sfaService.fap_open_pt_select_list();
		
		model.addAttribute("result", result);
		
		logger.info("FAP 오픈잡페어 설명회 관리 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : open_pt_insert_form
	 * @Date : 2019. 4. 11.
	 * @User : 이종호 
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 등록 폼
	 * @Method 설명 : 오픈잡페어 설명회 등록 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_INSERT_FORM, method = RequestMethod.GET)
	public String open_pt_insert_form() {
		logger.info("FAP 오픈잡페어 설명회 등록 폼 이동 컨트롤러 시작");
		logger.info("FAP 오픈잡페어 설명회 등록 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_INSERT_FORM;
	}
	
	/**
	 * @Method Name : fap_open_pt_insert
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 정보 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_INSERT, method = RequestMethod.POST)
	public String fap_open_pt_insert(SocietyFapOpenPt openPt ,Authentication auth) {
		logger.info("FAP 오픈잡페어 설명회 등록 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		openPt.setFap_open_pt_ins_id(user_id);
		openPt.setFap_open_pt_udt_id(user_id);
		
		sfaService.fap_open_pt_insert(openPt);
		logger.info("FAP 오픈잡페어 설명회 등록 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_open_pt_update_gb
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 수정정보
	 * @Return : -
	 * @Method 설명 : 오픈잡페어 설명회 구분 정보 수정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_UPDATE_GB, method = RequestMethod.POST)
	public String fap_open_pt_update_gb(SocietyFapOpenPt openPt, Authentication auth) {
		logger.info("FAP 오픈잡페어 설명회 구분 정보 수정 컨트롤러 시작");
		
		String user_id = (String)auth.getPrincipal();
		openPt.setFap_open_pt_udt_id(user_id);
		sfaService.fap_open_pt_update_gb(openPt);

		//마감처리일 경우 대기 지원자 불합격 처리
		if(openPt.getFap_open_pt_close_gb().equals("D1202")) {
			sfaService.fap_open_edu_close_fail_update(openPt);
		}
		
		logger.info("FAP 오픈잡페어 설명회 구분 정보 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_open_pt_update_form
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : 오픈잡페어 설명회 정보 수정 폼
	 * @Method 설명 : 오픈잡페어 설명회 정보 수정 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_UPDATE_FORM, method = RequestMethod.GET)
	public String fap_open_pt_update_form(int fap_open_pt_seq,Model model) {
		logger.info("FAP 오픈잡페어 설명회 수정폼 이동 컨트롤러 시작");
		
		SocietyFapOpenPt result = sfaService.fap_open_pt_select_one(fap_open_pt_seq);
		model.addAttribute("result", result);
		
		logger.info("FAP 오픈잡페어 설명회 수정폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : fap_open_pt_update
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : 오픈잡페어 설명회 정보 수정 폼
	 * @Method 설명 : 오픈잡페어 설명회 정보 수정 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_UPDATE, method = RequestMethod.POST)
	public String fap_open_pt_update(SocietyFapOpenPt openPt,Authentication auth) {
		logger.info("FAP 오픈잡페어 설명회 수정 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		openPt.setFap_open_pt_udt_id(user_id);
		
		sfaService.fap_open_pt_update(openPt);
		
		logger.info("FAP 오픈잡페어 설명회 수정 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_open_pt_delete
	 * @Date : 2019. 4. 11.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 시퀀스
	 * @Return : 오픈잡페어 설명회 정보 관리 폼
	 * @Method 설명 : 오픈잡페어 설명회 정보 삭제
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_DELETE, method = RequestMethod.POST)
	public String fap_open_pt_delete(int fap_open_pt_seq) {
		logger.info("FAP 오픈잡페어 설명회 정보 삭제 컨트롤러 시작");
		
		sfaService.fap_open_pt_delete(fap_open_pt_seq);
		
		logger.info("FAP 오픈잡페어 설명회 정보 삭제 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_management
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 설명회 지원자 관리 폼
	 * @Method 설명 : 오픈잡페어 설명회 지원자 관리 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_APPLIER_MANAGEMENT, method = RequestMethod.GET)
	public String fap_open_pt_applier_management(Model model) {
		logger.info("FAP 오픈잡페어 설명회 지원자 관리 폼 이동 컨트롤러 시작");
		
		String fap_open_pt_gb = "D1000";
		ArrayList<SocietyFapOpenPt> result = sfaService.fap_open_pt_only_list(fap_open_pt_gb);
		
		model.addAttribute("result", result);
		
		logger.info("FAP 오픈잡페어 설명회 지원자 관리 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_APPLIER_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_open_pt_edu_applier_management
	 * @Date : 2019. 4. 16.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 오픈잡페어 구직자 교육 지원자 관리 폼
	 * @Method 설명 : 오픈잡페어 구직자 교육 지원자 관리 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_EDU_APPLIER_MANAGEMENT, method = RequestMethod.GET)
	public String fap_open_pt_edu_applier_management(Model model) {
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 관리 폼 이동 컨트롤러 시작");
		
		String fap_open_pt_gb = "D1001";
		ArrayList<SocietyFapOpenPt> result = sfaService.fap_open_pt_only_list(fap_open_pt_gb);
		
		model.addAttribute("result", result);
		
		logger.info("FAP 오픈잡페어 구직자 교육 지원자 관리 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_EDU_APPLIER_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_open_pt_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 설명회 지원자 시퀀스 정보
	 * @Return : 해당 설명회 지원자 정보 리스트
	 * @Method 설명 : 해당 설명회 지원자 정보 리스트 엑셀출력용 조회
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_PT_PRINT_EXCEL, method = RequestMethod.POST)
	public void fap_open_pt_print_excel(int[] seq_list , HttpServletResponse response) throws Exception {
		logger.info("FAP 해당 설명회 지원자 정보 리스트 엑셀출력용 조회 컨트롤러 시작");
		HashMap<String, Object> paramMap = new HashMap<>();
		
		ArrayList<Integer> list = (ArrayList<Integer>)Arrays.stream(seq_list).boxed().collect(Collectors.toList());
		
		paramMap.put("seq_list", list);
		
		ArrayList<LinkedHashMap<String, Object>> result = sfaService.fap_open_pt_applier_list_excel(paramMap);
		
		ArrayList<String> excel_header = new ArrayList<>();
		excel_header.add("번호");
		excel_header.add("이름");
		excel_header.add("생년월일");
		excel_header.add("성별");
		excel_header.add("이메일");
		excel_header.add("전화번호");
		excel_header.add("최종학력");
		excel_header.add("전공");
		excel_header.add("취업희망직무");
		excel_header.add("신청일");
		
		Workbook wb = ExcelUtil.print_excel(result, excel_header);
		
		// 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode("오픈잡페어_설명회_지원자.xlsx", "UTF-8"));

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	    logger.info("FAP 해당 설명회 지원자 정보 리스트 엑셀출력용 조회 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : fap_open_edu_applier_list_excel
	 * @Date : 2019. 4. 18.
	 * @User : 이종호
	 * @Param : 오픈잡페어 구직자 교육 지원자 시퀀스 정보
	 * @Return : 해당 구직자 교육 지원자 정보 리스트
	 * @Method 설명 : 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_EDU_PRINT_EXCEL, method = RequestMethod.POST)
	public void fap_open_edu_print_excel(int[] seq_list , HttpServletResponse response) throws Exception {
		logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회 컨트롤러 시작");
		HashMap<String, Object> paramMap = new HashMap<>();
		
		ArrayList<Integer> list = (ArrayList<Integer>)Arrays.stream(seq_list).boxed().collect(Collectors.toList());
		
		paramMap.put("seq_list", list);
		
		ArrayList<LinkedHashMap<String, Object>> result = sfaService.fap_open_edu_applier_list_excel(paramMap);
		
		ArrayList<String> excel_header = new ArrayList<>();
		excel_header.add("번호");
		excel_header.add("이름");
		excel_header.add("생년월일");
		excel_header.add("성별");
		excel_header.add("이메일");
		excel_header.add("전화번호");
		excel_header.add("최종학력");
		excel_header.add("전공");
		excel_header.add("진행상태");
		excel_header.add("신청일");
		
		Workbook wb = ExcelUtil.print_excel(result, excel_header);
		
		// 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode("오픈잡페어_구직자교육_지원자.xlsx", "UTF-8"));

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	    logger.info("FAP 해당 구직자 교육 지원자 정보 리스트 엑셀출력용 조회 컨트롤러 종료");
	}
	
	/**
	 * @Method Name : applicant_resume_print_form
	 * @Date : 2019. 4. 5.
	 * @User : 이종호
	 * @Param : 이력서 시퀀스 배열
	 * @Return : 
	 * @Method 설명 : 프린트 할 이력서 정보 조회
	 */
	@RequestMapping(value = PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_RESUME_PRINT_FORM, method = RequestMethod.POST)
	public String applicant_resume_print_form(int[] fap_resume_seq, Model model) {
		logger.info("프린트 할 이력서 정보 조회 컨트롤러 시작");
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
		
		logger.info("프린트 할 이력서 정보 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_RESUME_PRINT_FORM;
	}
	
	/**
	 * @Method Name : fap_popup_insert
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : FAP 팝업 정보
	 * @Return : -
	 * @Method 설명 : FAP 팝업 정보 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_POPUP_INSERT, method = RequestMethod.POST)
	public String fap_popup_insert(SocietyFapPopup popup, Authentication auth) {
		logger.info("FAP 팝업 정보 등록 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		popup.setFap_popup_ins_id(user_id);
		popup.setFap_popup_udt_id(user_id);
		
		sfaService.fap_popup_insert(popup);
		logger.info("FAP 팝업 정보 등록 컨트롤러 종료");
		
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_POPUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_popup_management
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 팝업 관리 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_POPUP_MANAGEMENT, method = RequestMethod.GET)
	public String fap_popup_management(Model model) {
		logger.info("FAP 팝업 관리 페이지 이동 컨트롤러 시작");
		ArrayList<SocietyFapPopup> result = sfaService.fap_popup_select_list();
		model.addAttribute("result", result);
		logger.info("FAP 팝업 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_POPUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_popup_insert_form
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 팝업 등록 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_POPUP_INSERT_FORM, method = RequestMethod.GET)
	public String fap_popup_insert_form() {
		logger.info("FAP 팝업 등록 페이지 이동 컨트롤러 시작");
		logger.info("FAP 팝업 등록 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_POPUP_INSERT_FORM;
	}
	
	/**
	 * @Method Name : fap_popup_update_form
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 팝업 등록 페이지 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_POPUP_UPDATE_FORM, method = RequestMethod.GET)
	public String fap_popup_update_form(int fap_popup_seq , Model model) {
		logger.info("FAP 팝업 수정 페이지 이동 컨트롤러 시작");
		SocietyFapPopup popup = sfaService.fap_popup_select_one(fap_popup_seq);
		Gson gson = new Gson();
		model.addAttribute("popup",gson.toJson( popup));
		logger.info("FAP 팝업 수정 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_POPUP_UPDATE_FORM;
	}
	
	/**
	 * @Method Name : fap_popup_update
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : FAP 팝업 정보
	 * @Return : -
	 * @Method 설명 : FAP 팝업 정보 수정
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_POPUP_UPDATE, method = RequestMethod.POST)
	public String fap_popup_update(SocietyFapPopup popup, Authentication auth) {
		logger.info("FAP 팝업 정보 수정 컨트롤러 시작");
		String user_id = (String)auth.getPrincipal();
		popup.setFap_popup_ins_id(user_id);
		popup.setFap_popup_udt_id(user_id);
		
		sfaService.fap_popup_update(popup);
		logger.info("FAP 팝업 정보 수정 컨트롤러 종료");
		
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_POPUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_popup_delete
	 * @Date : 2019. 4. 19.
	 * @User : 이종호
	 * @Param : FAP 팝업 정보
	 * @Return : -
	 * @Method 설명 : FAP 팝업 정보 삭제
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_POPUP_DELETE, method = RequestMethod.POST)
	public String fap_popup_delete(int fap_popup_seq) {
		logger.info("FAP 팝업 정보 삭제 컨트롤러 시작");
		sfaService.fap_popup_delete(fap_popup_seq);
		logger.info("FAP 팝업 정보 삭제 컨트롤러 종료");
		
		return "redirect:" + PathConstants.SOCIETY_FAP_ADMIN_POPUP_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_job_resume_update_management
	 * @Date : 2019. 4. 30.
	 * @User : 이종호
	 * @Param : -
	 * @Return : -
	 * @Method 설명 : FAP 관리자 이력서 수정여부 관리 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_RESUME_UPDATE_MANAGEMENT, method = RequestMethod.GET)
	public String fap_job_resume_update_management() {
		logger.info("FAP 관리자 이력서 수정여부 관리 폼 이동 컨트롤러 시작");
		logger.info("FAP 관리자 이력서 수정여부 관리 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_RESUME_UPDATE_MANAGEMENT;
	}
	
	/**
	 * @Method Name : fap_job_resume_update_gb
	 * @Date : 2019. 4. 30.
	 * @User : 이종호
	 * @Param : 이력서 수정여부 판단 구분
	 * @Return : -
	 * @Method 설명 : FAP 관리자 이력서 수정여부 변경
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_RESUME_UPDATE_GB, method = RequestMethod.POST)
	public String fap_job_resume_update_gb(String fap_job_resume_update_gb) {
		logger.info("FAP 관리자 이력서 수정여부 변경 컨트롤러 시작");
		sfaService.fap_job_resume_update_gb(fap_job_resume_update_gb);
		logger.info("FAP 관리자 이력서 수정여부 변경 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_FAP_ADMIN_MAIN;
	}
	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_COMP_EXCEL, method = RequestMethod.POST)
	public void applicant_status_per_comp_excel(int jobfair_seq, HttpServletResponse response) throws Exception {
		logger.info("FAP 관리자 기업별 지원현황 엑셀 다운 컨트롤러 시작");
		
		final String excel_gb = "COMP";
		HashMap<String, Object> resultMap =  sfaService.applicant_status_per_comp_excel_one(jobfair_seq);
		
		ArrayList<ArrayList<String>> head_list = new ArrayList<>();
		ArrayList<String> head_one = new ArrayList<>();
		
		head_one.add("No");
		head_one.add("발굴관리");
		head_one.add("기업명\r\n(*:신규참가)");
		head_one.add("트랙2");
		head_one.add("K페어");
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add("J페어");
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add("Post페어");
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add("K/J/Post페어");
		head_one.add(null);
		head_one.add("입사예정일");
		head_one.add("비고");
		
		ArrayList<String> head_two = new ArrayList<>();
		head_two.add(null);
		head_two.add(null);
		head_two.add(null);
		head_two.add(null);
		head_two.add("참가여부");
		head_two.add("채용예정인원");
		head_two.add("지원자");
		head_two.add(null);
		head_two.add("불합격자");
		head_two.add(null);
		head_two.add("합격자");
		head_two.add(null);
		head_two.add("최종입사자");
		head_two.add(null);
		head_two.add("참가여부");
		head_two.add("채용예정인원");
		head_two.add("지원자");
		head_two.add(null);
		head_two.add("불합격자");
		head_two.add(null);
		head_two.add("합격자");
		head_two.add(null);
		head_two.add("예비합격자");
		head_two.add(null);
		head_two.add("최종입사자");
		head_two.add(null);
		head_two.add("참가여부");
		head_two.add("채용예정인원");
		head_two.add("지원자");
		head_two.add(null);
		head_two.add("불합격자");
		head_two.add(null);
		head_two.add("합격자");
		head_two.add(null);
		head_two.add("예비합격자");
		head_two.add(null);
		head_two.add("최종입사자");
		head_two.add(null);
		head_two.add("최종입사자");
		head_two.add(null);
		head_two.add(null);
		head_two.add(null);
		
		ArrayList<String> head_three = new ArrayList<>();
		head_three.add(null);
		head_three.add(null);
		head_three.add(null);
		head_three.add(null);
		head_three.add(null);
		head_three.add(null);
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add(null);
		head_three.add(null);
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add(null);
		head_three.add(null);
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add("인원");
		head_three.add("이름");
		head_three.add(null);
		head_three.add(null);

		head_list.add(head_one);
		head_list.add(head_two);
		head_list.add(head_three);
		
		Workbook wb = ExcelUtil.merge_excel(resultMap,head_list,excel_gb);
		
		// 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode("기업별_지원현황.xlsx", "UTF-8"));

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
		
		logger.info("FAP 관리자 기업별 지원현황 엑셀 다운 컨트롤러 종료");
	}
	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_APPLICANT_STATUS_PER_APPLIER_EXCEL, method = RequestMethod.POST)
	public void applicant_status_per_applier_excel(int jobfairSelect
			, @RequestParam(defaultValue="A0") String typeSelect
			, @RequestParam(defaultValue="") String searchName
			 , HttpServletResponse response) throws Exception {
		
		logger.info("FAP 관리자 지원자별 지원현황 엑셀 다운 컨트롤러 시작");
		
		final String excel_gb = "APPLIER";
		
		HashMap<String, Object> searchMap = new HashMap<>();
		HashMap<String, Object> resultMap = new HashMap<>();
		
		searchMap.put("jobfairSelect", jobfairSelect);
		searchMap.put("typeSelect", typeSelect);
		searchMap.put("searchName", searchName);
		
		ArrayList<LinkedHashMap<String, Object>> result = sfaService.applicant_status_per_applier_search(searchMap);
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("fap_jobfair_seq", jobfairSelect);
		params.put("fap_jobfair_divide_gb", "C0100");
		
		int k_num = sfaService.jobfair_apply_max_count(params);
		
		params.put("fap_jobfair_divide_gb", "C0101");
		int j_num = sfaService.jobfair_apply_max_count(params);
		
		resultMap.put("list", result);
		resultMap.put("k_num", k_num);
		resultMap.put("j_num", j_num);
		
		ArrayList<ArrayList<String>> head_list = new ArrayList<>();
		ArrayList<String> head_one = new ArrayList<>();
		head_one.add("No");
		head_one.add("성명");
		head_one.add("회원구분");
		head_one.add("K대상");
		head_one.add("JOB Fair 결과");
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add("K-Fair 지원현황");
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add("K-Fair");
		for(int i=0; i < k_num-1; i++) {
			head_one.add(null);
		}
		head_one.add("J-Fair 지원현황");
		head_one.add(null);
		head_one.add(null);
		head_one.add(null);
		head_one.add("J-Fair");
		for(int i=0; i < j_num-1; i++) {
			head_one.add(null);
		}
		
		head_list.add(head_one);
		ArrayList<String> head_two = new ArrayList<>();
		head_two.add(null);
		head_two.add(null);
		head_two.add(null);
		head_two.add(null);
		head_two.add("내정");
		head_two.add("예비");
		head_two.add("대기");
		head_two.add("최종불합격");
		head_two.add("지원");
		head_two.add("진행중");
		head_two.add("전형불합격");
		head_two.add("현지면접확정");
		for(int j=1; j <= k_num; j++) {
			head_two.add(j+"지망");
		}
		head_two.add("지원");
		head_two.add("진행중");
		head_two.add("전형불합격");
		head_two.add("현지면접확정");
		for(int j=1; j <= j_num; j++) {
			head_two.add(j+"지망");
		}
		head_list.add(head_two);

		Workbook wb = ExcelUtil.merge_excel(resultMap,head_list,excel_gb);
		
		// 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode("지원자별_지원현황.xlsx", "UTF-8"));

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
		
		logger.info("FAP 관리자 지원자별 지원현황 엑셀 다운 컨트롤러 종료");
	}


	/**
	 * @Method Name : fap_open_job_info_content_list
	 * @Date : 2019. 6. 27
	 * @User : 김경아
	 * @Param :  게시판그룹객체, 게시판 시퀀스 
	 * @Return :  
	 * @Method 설명 : FAP 관리자 오픈잡페어 취업정보 & 전략 게시판 리스트 조회
	 */
 
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_LIST, method=RequestMethod.POST)	
	public String fap_open_job_info_content_list(Model model, BoardGroup boardGroup, 
			@RequestParam(defaultValue="") String search_division,
			@RequestParam(defaultValue="") String search_type,
			@RequestParam(defaultValue = "1") int curPage,  
			@RequestParam(defaultValue = "10") int pageCount,
			@RequestParam(defaultValue="") String searchKey,
			@RequestParam(defaultValue="") String searchValue){  
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 리스트 컨트롤러 조회 시작");
		

		//페이징  
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    map.put("board_seq", boardGroup.getBoard_seq());
	    map.put("searchKey", searchKey);
	    map.put("searchValue", searchValue);
	    map.put("board_detail_gb", boardGroup.getBoard_detail_gb());
 	    int count = sfaService.board_contents_count(map);  //출력될 전체 글 수  
 	   
 	    AdminPager.setPAGE_SCALE(pageCount); // 페이지당 게시물 수 넣어주기 
 	    AdminPager adminPager = new AdminPager(count, curPage); //페이징 생성자 호출(페이지당 게시물 수, 현재페이지)  	    
 	    int pageBegin = adminPager.getPageBegin()-1;
 	    map.put("pageBegin",pageBegin);
 	    map.put("pageCount",pageCount);
 	    map.put("adminPager",adminPager);
 	    
 	 //취업정보 & 전략 게시판 리스트 조회
	    ArrayList<HashMap<String,Object>> jobInfoList = sfaService.fap_open_job_info_content_list(map);
 	    
 	    HashMap<String, Object> pagingMap = new HashMap<String, Object>();
 	    pagingMap.put("count", count);
 	    pagingMap.put("pageCount", pageCount);
 	    pagingMap.put("adminPager", adminPager);
 	    pagingMap.put("search_division", search_division);
 	    pagingMap.put("search_type", search_type);
 	    
 	    model.addAttribute("boardGroup",boardGroup);    
 	    model.addAttribute("jobInfoList",jobInfoList);
	    model.addAttribute("pagingMap",pagingMap);
	    model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 리스트 조회 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_LIST;
	}
	

	 	
	/**
	 * @Method Name : fap_open_job_info_content_detail
	 * @Date : 2019. 6. 27
	 * @User : 김경아
	 * @Param :  게시판그룹객체, 게시판 시퀀스, 게시판 글 시퀀스 
	 * @Return :  
	 * @Method 설명 : FAP 관리자 오픈잡페어 취업정보 & 전략 게시판 글 세부조회 
	 */
   
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_DETAIL, method=RequestMethod.POST)	
	public String fap_open_job_info_detail(Model model, BoardGroup boardGroup, @RequestParam int board_content_seq,	
			@RequestParam String board_nm,
			@RequestParam String search_division,
			@RequestParam String search_type){
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 세부조회 시작");
		
		//조회수 증가
		seaService.board_contents_hit_update(board_content_seq);
		
		//조회(공통게시판)
		HashMap<String, Object> contentMap = new HashMap<String, Object>();
		contentMap = sfcService.board_contents_detail(board_content_seq);	 
		
		//조회(취업정보&전략게시판 추가항목)
		HashMap<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("board_seq",boardGroup.getBoard_seq());
		paramMap.put("board_content_seq", board_content_seq);
		paramMap.put("board_detail_gb", boardGroup.getBoard_detail_gb());
		HashMap<String, Object> jobInfoMap = sfaService.fap_open_job_info_additional_detail(paramMap);			 
		
		model.addAttribute("boardGroup", boardGroup);
		model.addAttribute("board_nm", board_nm);
		model.addAttribute("board_content_seq", board_content_seq);
		model.addAttribute("contentMap", contentMap);
		model.addAttribute("jobInfoMap", jobInfoMap);
		Gson gson = new Gson();
		String jobinfo_Map = gson.toJson(jobInfoMap);		
		model.addAttribute("jobInfo_Map", jobinfo_Map);
		
		String content_Map = gson.toJson(contentMap);
		String replace_content_Map= content_Map.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");	
		model.addAttribute("content_Map", replace_content_Map);
		
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 세부조회 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_DETAIL;
	}

	
	/**
	 * @Method Name : open_job_info_insert_form
	 * @Date : 2019. 7. 1.
	 * @User : 김경아
	 * @Param : 게시판 글 시퀀스 
	 * @Return :  
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 글 등록 페이지로 이동
	 */
	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_INSERT_FORM, method=RequestMethod.POST)
	public String open_job_info_insert_form(Model model, @RequestParam int board_seq, @RequestParam String board_nm,
			@RequestParam String search_division,
			@RequestParam String board_detail_gb,
			@RequestParam String search_type){		
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 등록 페이지로 이동 컨트롤러 시작");	
		 model.addAttribute("board_seq",board_seq);
		 model.addAttribute("board_nm",board_nm);	
		 model.addAttribute("search_division",search_division);
		 model.addAttribute("search_type",search_type);		 
		 model.addAttribute("board_detail_gb",board_detail_gb);	
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 등록 페이지로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_INSERT_FORM;
	}
	
	
	/**
	 * @Method Name : open_job_info_insert
	 * @Date : 2019. 7. 1.
	 * @User : 김경아
	 * @Param : 게시판 글 시퀀스 
	 * @Return :  
	 * @Method 설명 : 오픈잡페어 게시판 글 등록
	 */

	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_INSERT, method=RequestMethod.POST)
	public String open_job_info_insert(Model model, Authentication auth, BoardContent boardContent, 
			BoardFile boardFile, SocietyFapOpenJobInfo openJobInfo,  SocietyFapAdminNoticeContent noticeContent,  int board_seq,  
			@RequestParam String board_nm,
			@RequestParam String board_detail_gb,
			@RequestParam String search_division,
			@RequestParam String search_type){		
			logger.debug("FAP 오픈잡페어  게시판 글 등록 컨트롤러 시작");	
			boardContent.setBoard_content_ins_id((String)auth.getPrincipal());
		    boardContent.setBoard_content_udt_id((String)auth.getPrincipal());
		    boardContent.setBoard_content_nm((String)auth.getPrincipal());	   
		    sfaService.fap_open_insert_additional_info(auth, boardContent, openJobInfo, noticeContent, boardFile, board_detail_gb);		 
		     		    	
	  	     model.addAttribute("search_division",search_division);
			 model.addAttribute("search_type",search_type);		
			 model.addAttribute("board_nm",board_nm);	
			 model.addAttribute("board_detail_gb",board_detail_gb);	
			logger.debug("FAP 오픈잡페어 글 등록 컨트롤러 종료");
			return "forward:"+ PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_LIST;
		}
	
	
	
	/**
	 * @Method Name : open_job_info_update_form
	 * @Date : 2019. 7. 1.
	 * @User : 김경아
	 * @Param : 게시판 글 시퀀스 , 게시판 시퀀스 
	 * @Return :  
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 글 수정 페이지로 이동
	 */
	
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_UPDATE_FORM, method=RequestMethod.POST)
	public String open_job_info_update_form(Model model, 
			@RequestParam int board_seq, 
			@RequestParam int board_content_seq,
			@RequestParam String board_nm,
			@RequestParam String board_detail_gb,
			@RequestParam String search_division,
			@RequestParam String search_type){		
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 수정 페이지로 이동 컨트롤러 시작");	
		
		//조회(공통게시판)
		HashMap<String, Object> contentMap = new HashMap<String, Object>();
		contentMap = sfcService.board_contents_detail(board_content_seq);	 
		//조회(취업정보&전략게시판 추가항목)
		HashMap<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("board_content_seq", board_content_seq);
		paramMap.put("board_detail_gb", board_detail_gb);
		HashMap<String, Object> jobInfoMap = sfaService.fap_open_job_info_additional_detail(paramMap);
		
		 model.addAttribute("contentMap",contentMap);
		 model.addAttribute("jobInfoMap",jobInfoMap);
		 
		Gson gson = new Gson();
		String jobinfo_Map = gson.toJson(jobInfoMap);
		model.addAttribute("jobInfo_Map", jobinfo_Map);
		
		String content_Map = gson.toJson(contentMap);
		String replace_content_Map= content_Map.replaceAll("\\\\", "\\\\\\\\").replaceAll("\\\"", "\\\\\"");	
		model.addAttribute("content_Map", replace_content_Map);
			
		 model.addAttribute("board_content_seq",board_content_seq);
		 model.addAttribute("board_seq",board_seq);
		 model.addAttribute("board_nm",board_nm);
		 model.addAttribute("search_division",search_division);
		 model.addAttribute("search_type",search_type);	
		 model.addAttribute("board_detail_gb",board_detail_gb);	
		logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 수정 페이지로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_UPDATE_FORM;
	}
	
	
	/**
	 * @Method Name : open_job_info_update
	 * @Date : 2019. 7. 1.
	 * @User : 김경아
	 * @Param : 게시판 글 시퀀스 , 게시판 시퀀스 
	 * @Return :  
	 * @Method 설명 : 오픈잡페어 취업정보 & 전략 게시판 글 수정  
	 */

	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_UPDATE, method=RequestMethod.POST)
		public String open_job_info_update(Model model, Authentication auth, BoardContent boardContent, 
				SocietyFapOpenJobInfo openJobInfo, SocietyFapAdminNoticeContent noticeContent, BoardFile boardFile,
				@RequestParam String board_detail_gb,
				@RequestParam String board_nm,
				@RequestParam String search_division,
				@RequestParam String search_type){
			logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 수정 컨트롤러 시작");	
		   
			 boardContent.setBoard_content_udt_id((String)auth.getPrincipal());
			 boardContent.setBoard_content_nm((String)auth.getPrincipal());
			
			 sfaService.fap_open_update_job_info(auth, boardContent, openJobInfo, noticeContent, boardFile, board_detail_gb);
			 
			 model.addAttribute("board_nm",board_nm);
			 model.addAttribute("search_division",search_division);
			 model.addAttribute("search_type",search_type);	
			 model.addAttribute("board_detail_gb",board_detail_gb);	
				
			logger.debug("FAP 오픈잡페어 취업정보 & 전략 게시판 글 수정 컨트롤러 종료");	
			return "forward:"+ PathConstants.SOCIETY_FAP_ADMIN_OPEN_JOB_INFO_LIST;
		}

	/**
	 * @Method Name : admin_job_advertisement_search_form
	 * @Date : 2019. 7. 25.
	 * @User : 김경아
	 * @Param : 잡페어 시퀀스, 세부잡페어 시퀀스 
	 * @Return :   관리자 채용공고검색 jsp으로 이동
	 * @Method 설명 :  관리자 채용공고검색 jsp으로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_JOB_ADVERTISEMENT_SEARCH_FORM, method=RequestMethod.GET)
	public String admin_job_advertisement_search_form(Model model
			,@RequestParam(defaultValue="0") int fap_jobfair_seq
			,@RequestParam(defaultValue="0") int fap_jobfair_divide_seq			 
			 ){
		logger.debug("FAP 관리자 잡페어 채용공고 상세검색 폼 요청 컨트롤러 시작");
		
		//잡페어&세부잡페어 선택
		Gson gson = new Gson();
		HashMap<String, Object> jobfair_map = sfcrService.select_jobfair();		
		model.addAttribute("fap_jobfair_seq", fap_jobfair_seq);
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);		 
		model.addAttribute("jobfair_map", gson.toJson(jobfair_map));
 	 
		logger.debug("FAP 관리자 잡페어 채용공고 상세검색 폼 요청 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_JOB_ADVERTISEMENT_SEARCH_FORM;
		
	}
	
	/**
	 * @Method Name : admin_notice_alim
	 * @Date : 2019. 8. 29.
	 * @User : 김경아
	 * @Param :  
	 * @Return :   관리자 알림 jsp로 이동
	 * @Method 설명 :   관리자 알림 jsp로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_NOTICE_ALIM, method=RequestMethod.GET)
	public String admin_notice_alim(Model model
			, @RequestParam(defaultValue="10") int pageCount, @RequestParam(defaultValue="1") int currentPage){
		logger.debug("FAP 관리자 알림 화면으로 이동 컨트롤러 시작");
		String selected_handle_gb ="D2300";			 
        HashMap<String,Object> alimList =  sfaService.select_admin_notice_alim_list(selected_handle_gb, pageCount, currentPage);
		model.addAttribute("alimList",alimList);
		logger.debug("FAP 관리자 알림 화면으로 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_NOTICE_ALIM;
	}
	

	/**
	 * @Method Name : mainpage_ct_management
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 - 지원자 메인페이지 기업컨텐츠 관리 페이지 이동
	 * @Method 설명 : 지원자 메인페이지 기업컨텐츠 내용 조회 후 메인페이지 관리 페이지로 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_MANAGEMENT, method=RequestMethod.GET)
	public String mainpage_ct_management(Model model) {
		logger.info("관리자 메인페이지 관리 페이지 이동 컨트롤러 시작");
		
		SocietyFapMainpageContent result = sfaService.mainpage_ct_select();
		model.addAttribute("result", result);
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList",jobfairList);
		
		logger.info("관리자 메인페이지 관리 페이지 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : mainpage_ct_insert_form
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 - 지원자 메인페이지 기업컨텐츠 등록 폼 이동 
	 * @Method 설명 : 관리자 - 지원자 메인페이지 기업컨텐츠 등록 폼 이동
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_INSERT_FORM, method=RequestMethod.GET)
	public String mainpage_ct_insert_form(Model model) {
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 폼 이동 컨트롤러 시작");
		String fap_jobfair_opening_flag = "C4502";
		HashMap<String, Object> hashmap = new HashMap<>();
		hashmap.put("fap_jobfair_opening", fap_jobfair_opening_flag);
		ArrayList<SocietyFapAdminJobfair> jobfairList = sfaService.jobfair_search_list(hashmap);
		model.addAttribute("jobfairList",jobfairList);
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_INSERT_FORM;
	}
	
	/**
	 * @Method Name : mainpage_ct_insert
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 - 지원자 메인페이지 기업컨텐츠 등록
	 * @Method 설명 : 관리자 - 지원자 메인페이지 기업컨텐츠 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_INSERT, method=RequestMethod.POST)
	public String mainpage_ct_insert(SocietyFapMainpageContent mainCt, Authentication auth) {
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 컨트롤러 시작");
		mainCt.setFap_mainpage_ct_ins_id((String)auth.getPrincipal());
		mainCt.setFap_mainpage_ct_udt_id((String)auth.getPrincipal());
		sfaService.mainpage_ct_insert(mainCt);
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 컨트롤러 종료");
		return "redirect:"+ PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : mainpage_ct_update
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 - 지원자 메인페이지 기업컨텐츠 등록
	 * @Method 설명 : 관리자 - 지원자 메인페이지 기업컨텐츠 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_UPDATE, method=RequestMethod.POST)
	public String mainpage_ct_update(SocietyFapMainpageContent mainCt, Authentication auth) {
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 컨트롤러 시작");
		mainCt.setFap_mainpage_ct_udt_id((String)auth.getPrincipal());
		sfaService.mainpage_ct_update(mainCt);
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 컨트롤러 종료");
		return "redirect:"+ PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : mainpage_ct_delete
	 * @Date : 2019. 9. 3.
	 * @User : 이종호
	 * @Param : -
	 * @Return : 관리자 - 지원자 메인페이지 기업컨텐츠 등록
	 * @Method 설명 : 관리자 - 지원자 메인페이지 기업컨텐츠 등록
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_DELETE, method=RequestMethod.POST)
	public String mainpage_ct_delete(SocietyFapMainpageContent mainCt) {
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 컨트롤러 시작");
		sfaService.mainpage_ct_delete(mainCt.getFap_mainpage_ct_seq());
		logger.info("관리자 - 지원자 메인페이지 기업컨텐츠 등록 컨트롤러 종료");
		return "redirect:"+ PathConstants.SOCIETY_FAP_ADMIN_MAINPAGE_CT_MANAGEMENT;
	}
	
	/**
	 * @Method Name : tokyofair_schedule_print_form
	 * @Date : 2019. 10. 15.
	 * @User : 이종호
	 * @Param : 세부 잡페어 시퀀스
	 * @Return : -
	 * @Method 설명 : 도쿄페어 전체 일정 인쇄
	 */
	@RequestMapping(value=PathConstants.SOCIETY_FAP_ADMIN_TOKYOFARI_SCHEDULE_PRINT_FORM, method=RequestMethod.POST)
	public String tokyofair_schedule_print_form(Model model, int fap_jobfair_divide_seq) {
		logger.info("FAP 관리자 도쿄페어 전체 일정 인쇄 컨트롤러 시작");
		model.addAttribute("fap_jobfair_divide_seq", fap_jobfair_divide_seq);
		HashMap<String, Object> tokyofairSetMap = sfaService.tokyfair_schedule_booked_search(fap_jobfair_divide_seq);
		model.addAttribute("tokyofairSetMap", tokyofairSetMap);
		logger.info("FAP 관리자 도쿄페어 전체 일정 인쇄 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_FAP_ADMIN_TOKYOFARI_SCHEDULE_PRINT_FORM;
	}
}








