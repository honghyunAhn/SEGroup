package com.aracomm.changbi.user.web;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.course.service.ChangbiCourseService;
import com.aracomm.changbi.member.vo.MemberForm;
import com.aracomm.changbi.mypage.service.PointService;
import com.aracomm.changbi.mypage.vo.PointSearchVo;
import com.aracomm.changbi.user.service.UserService;
import com.dreamsecurity.crypt.MsgCrypto;

import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.domain.UserVerification;
import global.segroup.exception.WaitingException;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.society.smtp.course.service.SmtpCourseService;
import global.segroup.util.AESEncryptor;
import global.segroup.util.PathConstants;

// TODO 삭제예정 -> 수정
@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	//회원 정보 관련 서비스
	@Autowired
	private UserService service;
	//포인트 처리 관련 서비스
	@Autowired
	private PointService pService;
	
	@Autowired
	private SocietyEduUserService seuService;

	@Autowired
	private ChangbiCourseService courseService;

	@Autowired
	private SmtpCourseService smtpService;
	
	@Autowired
	private AESEncryptor aesEncryptor;
	
	@Value("#{config['miniPages']}")
	private int miniPages;
	
	@Value("#{props['usr.local.cert']}")
	private static String cert;
	
	@Value("#{config['boardPages']}")
	String boardPages;

	@Value("#{domain['domain.http']}")
	private String domain;

	@Value("#{domain['domain.http']}")
	private static String staticDomain;

	@Value("#{domain['domain.location']}")
	private String location;

	@Value("#{domain['domain.location']}")
	private static String staticLocation;

	@Value("#{domain['domain.key']}")
	private String key;

	/*
	 * @RequestMapping(value = "/error/{id}") public String dispMemberMypage(Model
	 * model, @PathVariable("id") String error) { return "error/" + error; }
	 */
	
	/**
	 * @Method Name : sub00_01
	 * @Date : 2019. 12. 13
	 * @User : 최소영
	 * @Param : -
	 * @Return : JSP 리턴페이지(lms 로그인 폼 페이지)
	 * @Method 설명 : lms 회원 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = "lms/user/sub00-01", method = RequestMethod.GET)
	public String sub00_01(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("로그인 페이지 이동 컨트롤러 시작");
		
		Exception exception = (Exception) session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		
		if ((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException
				|| exception.getCause() instanceof BadCredentialsException)) {
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			// 휴면 계정 처리
			// 휴면계정은 예외처리에서 제외하고 로그인 할 수 있게 함 2020-10-21 김나영
//			if (exception.getCause() instanceof DisabledException) {
//				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_DORMANCY_FORM;
//			}
			// 탈퇴 계정 처리
			//else  -> 휴면 계정 예외처리 달라지면 위아래 주석 해제하고 사용
			if (exception.getCause() instanceof AccountExpiredException) {
				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_EXPIRED_FORM;
			}
			// 정지 계정 처리
			else if (exception.getCause() instanceof LockedException) {
				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_LOCKED_FORM;
			}
			// 승인 대기 계정 처리
			else if (exception.getCause() instanceof WaitingException) {
				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_PENDING_APPROVAL_FORM;
			}
		}
		logger.info("로그인 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub00-01";
	}
	
	/**
	 * @Method Name : login_success
	 * @Date : 2019. 12. 13
	 * @User : 최소영
	 * @Param : -
	 * @Return : JSP 리턴페이지(lms 회원 로그인 성공)
	 * @Method 설명 : lms 회원 로그인 성공시 호출되는 함수
	 */
	@RequestMapping(value = "/lms/user/user_login_success", method = RequestMethod.GET)
	public String login_success(Authentication auth, HttpSession session, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response) {
		logger.info("lms 회원 로그인 성공 컨트롤러 시작");
		
		String user_ip = service.getClintIp(request);
		logger.info(user_ip);
		
		String user_id = auth.getName();
		session.setAttribute("user_id", user_id);
		
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
		MemberForm member = new MemberForm();
		member.setId(user_id);
		member.setUser_ip(user_ip);
		service.insertUserAccInfo(member);
		
		//크롬 80 이슈관련 samesite 속성 설정
		response.addHeader("Set-Cookie", "JSESSIONID=" + request.getRequestedSessionId() + "; path=/; Secure; SameSite=None; HttpOnly;");
		
		return "redirect:/lms/main";
	}
	
	/**
	 * @Method Name : login_access_denied
	 * @Date : 2019. 12. 13
	 * @User : 최소영
	 * @Param : -
	 * @Return : JSP 리턴페이지(lms 회원 접근 권한 없음 페이지)
	 * @Method 설명 : 권한이 없는 사용자가 회원 페이지 접근시 호출되는 컨트롤러 함수
	 */
	@RequestMapping(value = "lms/user/sub00-02-04", method = RequestMethod.GET)
	public String login_access_denied() {
		logger.info("lms 회원 접근 권한 없음 컨트롤러 시작");
		logger.info("lms 회원 접근 권한 없음 컨트롤러 종료");
		return "/lms/user/sub00-02-04";
	}
	
	@RequestMapping(value = "lms/user/sub00-02",  method = {RequestMethod.GET,RequestMethod.POST})
	public String sub00_02(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {
		logger.info("회원가입 이용약관 페이지 이동 컨트롤러 시작");
		
		  //날짜 생성 
		  Calendar today = Calendar.getInstance(); 
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		  String day = sdf.format(today.getTime());
		  
		  java.util.Random ran = new Random(); 		  
		  //랜덤 문자 길이 
		  int numLength = 6; 
		  String randomStr = "";
		  
		  for (int i = 0; i < numLength; i++) { 
		  //0 ~ 9 랜덤 숫자 생성 
		    randomStr +=	 ran.nextInt(10); 
		   } 
		  //reqNum은 최대 40byte 까지 사용 가능
		  
		  MsgCrypto mscr = new MsgCrypto();
		 
		  String reqNum = day + randomStr; 
		  String reqInfo = ""; 
		  String encReqInfo = "";
		  String rtn_url = domain + "/lms/user/user_mobile_verification"; //(운영서버 적용시)
		  String cpId = "sesoc"; // 회원사ID 
		  String urlCode = "01001"; // URL 코드 
		  String reqdate = day;  // 요청일시
		  
		  reqInfo = urlCode + "/" + reqNum + "/" + reqdate; //암호화 시킬 데이터 '/'로 구분해서 합친다.	 
		  encReqInfo = mscr.msgEncrypt(reqInfo, location);
		  
		   //deprecated 되서 수정함 - 2019.03.05 이종호
		   //encReqInfo = URLEncoder.encode(encReqInfo);
			try {
				encReqInfo = URLEncoder.encode(encReqInfo,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			//msgEncrypt(암호화 시킬 값, 인증서 경로);
		  
		    model.addAttribute("cpId",cpId);
		    model.addAttribute("rtn_url",rtn_url);
		    model.addAttribute("encReqInfo",encReqInfo);
		 
		logger.info("회원가입 이용약관 페이지 이동 컨트롤러 종료");
		
		return "/lms/user/sub00-02";
	}
	
	@RequestMapping(value = "lms/user/sub00-02-02", method = RequestMethod.POST)
	public String sub00_02_02(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model, MemberForm memberForm, UserVerification userVeri ) {
		logger.info("회원가입 페이지 이동 컨트롤러 시작");
		model.addAttribute("user",memberForm);
		model.addAttribute("userVeri", userVeri);
		
		logger.info("회원가입 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub00-02-02";
	}
	
	
	/**
	 * @Method Name : user_mobile_verification
	 * @Date : 2020.01.06
	 * @User : 김경아
	 * @Param : -
	 * @Return : JSP 리턴페이지 
	 * @Method 설명 : 모바일 본인인증팝업
	 */
	@RequestMapping(value ="lms/user/user_mobile_verification", method = RequestMethod.GET)
	public String user_mobile_verification(HttpSession session ,Model model, HttpServletRequest request) {
		logger.debug("유저 회원 가입 약관 폼 이동 컨트롤러 시작");
		
		String encPriInfo = request.getParameter("priinfo");

		MsgCrypto mscr = new MsgCrypto();
		String rstInfo = mscr.msgDecrypt(encPriInfo,key,"sesoc@2018","EUC-KR"); //(운영서버 적용시)
		String[] rstInfoArray = rstInfo.split("\\$");
		if (rstInfoArray.length > 3) {
			model.addAttribute("mobileVerification", rstInfoArray);
			String veriPhone=rstInfoArray[3];
			UserVerification userVeri=new UserVerification();
			userVeri.setVeriPhone(veriPhone);
			userVeri=seuService.userveri_phone_select(userVeri);
			
			if(userVeri!=null){
				return "lms/user/user_mobile_verification_duplicated";
			}
			
		}else{
			return "lms/user/user_mobile_verification_failed";
		}
		logger.debug("유저 회원 가입 약관 폼 이동 컨트롤러 종료");
		return "lms/user/user_mobile_verification";
	}
	
	/**
	 * LMS 회원등록
	 */
	@RequestMapping(value="lms/user/joinMember", method=RequestMethod.POST)
	public String joinMember(MemberForm memberForm, @ModelAttribute(value="userVeri") UserVerification userVeri, HttpServletRequest request) {
		logger.info("회원등록 컨트롤러 시작");
		String ip = service.getClintIp(request);
		memberForm.setUser_ip(ip);
		//비밀번호 암호화
		memberForm.setEnc_pw(passwordEncoder.encode(memberForm.getPw()));
		//사용자 등록
		service.insertUser(memberForm);
		service.insertUserInfo(memberForm);
		seuService.userveri_insert(userVeri);
		logger.info("회원등록 컨트롤러 종료");
		return "redirect:/lms/user/sub00-02-03";
	}
	
	@RequestMapping(value = "lms/user/sub00-02-03", method = RequestMethod.GET)
	public String sub00_02_03(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("회원가입 완료 페이지 이동 컨트롤러 시작");
		

		logger.info("회원가입 완료 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub00-02-03";
	}
	
	
	@RequestMapping(value = "lms/user/sub00-03", method = RequestMethod.GET)
	public String sub00_03(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("아이디 찾기 페이지 이동 컨트롤러 시작");

		logger.info("아이디 찾기 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub00-03";
	}
	
	@RequestMapping(value = "lms/user/lostId", method = RequestMethod.POST)
	public String sub00_03_01(String email, String name, String phone, Model model, RedirectAttributes redirectAttributes) {
		logger.info("아이디 찾기 결과 페이지 이동 컨트롤러 시작");
		HashMap<String,String> findMap = new HashMap<String,String>();
		findMap.put("email", email);
		findMap.put("name", name);
		findMap.put("phone", phone);
		
			Map<String, String> user = service.selectMemberForFindId(findMap);
		if(user != null) {
			model.addAttribute("user_id", user.get("USER_ID"));
			model.addAttribute("user_nm", user.get("USER_NM"));
		} else {
			redirectAttributes.addFlashAttribute("msg", "입력하신 정보에 대한 아이디가 없습니다.");
			return "redirect:/lms/user/sub00-03";
		}
		logger.info("아이디 찾기 결과 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub00-03-01";
	}
	
	@RequestMapping(value = "lms/user/sub00-04", method = RequestMethod.GET)
	public String sub00_04(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("비밀번호 찾기 페이지 이동 컨트롤러 시작");

		logger.info("비밀번호 찾기 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub00-04";
	}
	
	/**
	 * @Method Name : user_request_certification_code
	 * @Date : 2020.01.13
	 * @User : 최소영
	 * @Param : hashmap
	 * @Return : 요청 결과 
	 * @Method 설명 : 인증번호를 발행하는 컨트롤러 함수
	 */	
	@ResponseBody
	@RequestMapping(value = "lms/user/user_request_certification_code", method = RequestMethod.GET)
	public int user_request_certification_code(@RequestParam HashMap<String, String> param, HttpSession session) {
		logger.info("비밀번호찾기 인증 번호 발행 컨트롤러 시작");
		int requested = service.user_request_certification_code(param);
		
		if (requested == 0) {
			session.removeAttribute("user_id");
			session.setAttribute("user_id", param.get("user_id"));
			System.out.println("유저 회원 ( "+session.getAttribute("user_id")+" ) 가입 인증 번호 발행 !");
		}
		
		logger.info("비밀번호찾기 인증 번호 발행 컨트롤러 종료");
		return requested;
	}
	
	/**
	 * @Method Name : user_check_certification_code
	 * @Date : 2020.01.13
	 * @User : 최소영
	 * @Param : 인증번호
	 * @Return : 인증결과
	 * @Method 설명 : 인증 결과를 확인 하는 컨트롤러 함수
	 */
	@ResponseBody
	@RequestMapping(value = "lms/user/user_check_certification_code", method = RequestMethod.GET)
	public boolean user_check_certification_code(CertificationCode code, HttpSession session) {
		logger.info("유저 회원 가입 인증 번호 검사 컨트롤러 시작");
		String id = (String) session.getAttribute("user_id");
		code.setUser_id(id);
		boolean isRequested = service.user_check_certification_code(code);
		// 인증 성공하면 세션에 확인 추가
		if (isRequested) {
			session.setAttribute("isCertificated", isRequested);
		}
		
		logger.info("유저 회원 가입 인증 번호 검사 컨트롤러 종료");
		return isRequested;
	}
	@RequestMapping(value = "lms/user/lostPw", method = RequestMethod.POST)
	public String sub00_04_01(String user_id, String user_email, String user_nm, String user_phone, RedirectAttributes redirectAttributes, Model model) {
		logger.info("비밀번호 재설정 페이지 이동 컨트롤러 시작");
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("user_id", user_id);
		param.put("user_email", user_email);
		param.put("user_nm", user_nm);
		param.put("user_phone", user_phone);
		HashMap<String,String> result = service.selectMemberForFindPw(param);
		if(result != null) {
			model.addAttribute("user_id", result.get("USER_ID"));
			logger.info("비밀번호 재설정 페이지 이동 컨트롤러 종료");
			return "/lms/user/sub00-04-01";
		} else {
			redirectAttributes.addFlashAttribute("msg", "입력하신 아이디 또는 이메일 정보가 없습니다.");
			return "redirect:/lms/user/sub00-04";
		}
	}
	
	@RequestMapping(value = "lms/user/sub00-04-01", method = RequestMethod.GET)
	public String sub00_04_01(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {
		logger.info("비밀번호 재설정 페이지 이동 컨트롤러 시작");
		String user_id = (String) session.getAttribute("user_id");
		model.addAttribute("user_id", user_id);
		logger.info("비밀번호 재설정 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub00-04-01";
	}
	/**
	 * LMS 비밀번호 변경 ()
	 * @param model
	 * @param page
	 * @return
	 */
	@RequestMapping(value="lms/user/resetPw", method=RequestMethod.POST)
	public String resetPw(String pw, String user_id, Authentication auth, RedirectAttributes redirectAttributes) {
		logger.info("비밀번호 수정 후 로그인 페이지 이동 컨트롤러 시작");
		String user_pw = passwordEncoder.encode(pw);
		int result = service.updatePassword(user_id, user_pw);
		if(result < 1) {
			logger.debug("비밀번호 수정 실패");
			return "redirect:/lms/main";
		} else {
			redirectAttributes.addFlashAttribute("msg", "비밀번호 수정에 성공하였습니다.");
			logger.info("비밀번호 수정 후 로그인 페이지 이동 컨트롤러 종료");
			return "redirect:/lms/user/sub00-01";
		}
	}
	

	
	@RequestMapping(value = "lms/user/sub07-04", method = RequestMethod.GET)
	public String sub07_04(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("개인정보수정 페이지 이동 컨트롤러 시작");

		logger.info("개인정보수정 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub07-04";
	}
	
	@RequestMapping(value="lms/user/checkPw", method = RequestMethod.POST)
	public String pwCheck(Authentication auth, String userPw, Model model) {
		logger.info("비밀번호 확인 후 회원정보 수정 페이지 이동 컨트롤러 시작");
		String user_id = (String) auth.getPrincipal();	
		HashMap<String, Object> userInfo = service.selectMemberInfo(user_id);
		mobileVerificationInfo(model); //전화 본인인증 
		if(userInfo != null) {
				String user_pw = (String) userInfo.get("USER_PW");
				if(!passwordEncoder.matches(userPw, user_pw)) {
					logger.info(user_pw);
					model.addAttribute("msg", "사용자 비밀번호가 틀립니다.");
					return "/lms/user/sub07-04";
				}
				HashMap<String, Object> myInfo = service.selectMemberInfo(user_id);
				//연락처
				String tel = (String) myInfo.get("USER_TEL");
				if(!StringUtils.isEmpty(tel)) {
					String [] p = CommonUtil.splitTel(tel);
					myInfo.put("TEL1", p[0]);
					myInfo.put("TEL2", p[1]);
					myInfo.put("TEL3", p[2]);
				}
				String phone = (String)myInfo.get("USER_PHONE");
				if (!StringUtils.isEmpty(phone)) {
					String [] p = CommonUtil.splitTel(phone);
					myInfo.put("PHONE1", p[0]);
					myInfo.put("PHONE2", p[1]);
					myInfo.put("PHONE3", p[2]);
				}
	
				// 이메일주소
				String email = (String)myInfo.get("USER_EMAIL");
				if (!StringUtils.isEmpty(email)) {
					String [] e = CommonUtil.splitEmail(email);
					myInfo.put("EMAIL1", e[0]);
					myInfo.put("EMAIL2", e[1]);
				}
				model.addAttribute("myInfo", myInfo);
				logger.info("비밀번호 확인 후 회원정보 수정 페이지 이동 컨트롤러 종료");
				
				return "/lms/user/sub07-04-01";
		} else {
			logger.debug("다시로그인해주세요.");
				return "redirect:/lms/user/sub00-01";
		}

	}
	
	//전화 본인인증
	public static void mobileVerificationInfo(Model model){
		  //날짜 생성 
		  Calendar today = Calendar.getInstance(); 
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		  String day = sdf.format(today.getTime());
		  
		  java.util.Random ran = new Random(); 		  
		  //랜덤 문자 길이 
		  int numLength = 6; 
		  String randomStr = "";
		  
		  for (int i = 0; i < numLength; i++) { 
		  //0 ~ 9 랜덤 숫자 생성 
		    randomStr +=	 ran.nextInt(10); 
		   } 
		  //reqNum은 최대 40byte 까지 사용 가능
		  
		  MsgCrypto mscr = new MsgCrypto();
		 
		  String reqNum = day + randomStr; 
		  String reqInfo = ""; 
		  String encReqInfo = "";
		  String rtn_url = staticDomain + "/lms/user/user_mobile_verification"; //(운영서버 적용시)
		  String cpId = "sesoc"; // 회원사ID 
		  String urlCode = "01001"; // URL 코드 
		  String reqdate = day;  // 요청일시
		  
		  reqInfo = urlCode + "/" + reqNum + "/" + reqdate; //암호화 시킬 데이터 '/'로 구분해서 합친다.	 
		  encReqInfo = mscr.msgEncrypt(reqInfo, staticLocation);
		  
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
	}
	
	@RequestMapping(value="lms/user/updateUser", method=RequestMethod.POST)
	public String updateUser(MemberForm memberForm, RedirectAttributes redirectAttributes) {
		System.out.println(memberForm.toString());
		//비밀번호 암호화
		memberForm.setEnc_pw(passwordEncoder.encode(memberForm.getPw()));
		//사용자정보수정(필수)
		int result = service.updateMemberInfo(memberForm);
		
		//사용자정보수정(선택)
		int ifAddtionalInfoExist = service.selectIfAdditionalInfoExist(memberForm.getId());
		int result2 = 0;
		if(ifAddtionalInfoExist > 0){
			result2 = service.updateAdditionalMemberInfo(memberForm);
		}else{
			result2 = service.insertAdditionalMemberInfo(memberForm);
		}
			 
		 
		if(result < 1 && result2 <1) {
			redirectAttributes.addFlashAttribute("msg", "수정에 실패하였습니다.");
			return "redirect:/lms/user/sub07-04-01";
		}
		return "redirect:/lms/user/sub07-04-02";
	}
	
	@RequestMapping(value="lms/user/sub07-04-02", method=RequestMethod.GET)
	public String sub07_04_02() {
		logger.info("회원정보 수정 성공 페이지 이동 컨트롤러 시작");
		logger.info("회원정보 수정 성공 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub07-04-02";
	}
	
	@RequestMapping(value = "lms/user/sub07-05", method = RequestMethod.GET)
	public String sub07_05(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("회원탈퇴 약관페이지 이동 컨트롤러 시작");

		logger.info("회원탈퇴 약관 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub07-05";
	}
	
	@RequestMapping(value = "lms/user/sub07-05-01", method = RequestMethod.GET)
	public String sub07_05_01(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("회원탈퇴 페이지 이동 컨트롤러 시작");

		logger.info("회원탈퇴 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub07-05-01";
	}
	
	@RequestMapping(value = "lms/user/optout", method = RequestMethod.POST)
	public String sub07_05_01(HttpSession session, MemberForm memberForm, RedirectAttributes redirectAttributes) {
		logger.info("회원탈퇴  컨트롤러 시작");
		System.out.println("아이디 : "+memberForm.getId()+"비밀번호 : "+memberForm.getPw());
		HashMap<String, Object> userInfo = service.selectMemberInfo(memberForm.getId());
		if(userInfo != null) {
			String user_pw = (String) userInfo.get("USER_PW");
			if(!passwordEncoder.matches(memberForm.getPw(), user_pw)) {
				redirectAttributes.addFlashAttribute("msg", "사용자 비밀번호가 틀립니다.");
				return "redirect:/lms/user/sub07-05-01";
			}
		int result = service.deleteMemberInfo(userInfo);
			if(result < 1) {
				logger.info("탈퇴오류");
				return "redirect:/lms/user/sub07-05";
			}
		}else {
			redirectAttributes.addFlashAttribute("msg", "사용자 아이디가 없습니다.");
			return "redirect:/lms/user/sub07-05-01";
		}
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			redirectAttributes.addFlashAttribute("msg", "탈퇴처리되었습니다.로그인창으로 이동합니다.");
			logger.info("회원탈퇴 컨트롤러 종료");
			return "redirect:/"; //허브 페이지로 이동
	}
	
	@RequestMapping(value = "lms/user/sub07-03")
	public String sub07_03(Model model, Authentication auth, PointSearchVo searchVO  ) {
		logger.info("마일리지 페이지 이동 컨트롤러 시작");
		String user_id = (auth != null ? auth.getName() : null);
		searchVO.setUser_id(user_id);
		searchVO.setPointVisiblePages(miniPages);
		model.addAttribute("pointList", pService.selectPointList(searchVO));
		model.addAttribute("pointSummary",pService.selectPointSummary(searchVO.getUser_id()));
		model.addAttribute("searchVO", searchVO);

		logger.info("마일리지 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub07-03";
	}
	
	@RequestMapping(value = "lms/user/sub07-02", method = RequestMethod.GET)
	public String sub07_02(Authentication auth, Model model,@RequestParam HashMap<String, String> param, String urlParam) {
		logger.info("결제현황/환불 페이지 이동 컨트롤러 시작");

		if(urlParam!=null)
		if(urlParam.equals("payComplete")){
			model.addAttribute("message","payComplete");
		}else if(urlParam.equals("payError")){
			model.addAttribute("message","payError");
		}
		String user_id = (auth != null ? auth.getName() : null);
		HashMap<String, Object> memberInfo = service.selectMemberInfo(user_id);
		String user_nm = (String) memberInfo.get("USER_NM");
		
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		model.addAttribute("startPage",  CommonUtil.getStart(startPage, boardPages));
		
		model.addAttribute("user_nm", user_nm);
		logger.info("결제현황/환불 페이지 이동 컨트롤러 종료");
		return "/lms/user/sub07-02";
	}
	
	@RequestMapping(value = "lms/user/sub07-02-list", method = RequestMethod.GET)
	public @ResponseBody Object sub07_02_list(HttpSession session, @RequestParam HashMap<String, String> param,  Model model) {
		String user_id = (String) session.getAttribute("user_id");
		param.put("user_id", user_id);
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		return service.individualPayList(param);
	}
	
	@RequestMapping(value = "lms/user/sub07-02-toefl", method = RequestMethod.GET)
	public @ResponseBody Object sub07_02_toefl(HttpSession session, @RequestParam HashMap<String, String> param,  Model model) {
		String user_id = (String) session.getAttribute("user_id");
		param.put("user_id", user_id);
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		return courseService.selectToeflPay(param);
	}
	
	@RequestMapping(value = "lms/user/pageInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPagingInfo(@RequestParam HashMap<String, String> param, HttpSession session) {
		
		logger.info("Ajax 페이징 정보처리 시작");
		
		HashMap<String, String> returnParam = new HashMap<String, String>();
		
		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1" : (String)param.get("startPage");
		
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		String user_id = (String) session.getAttribute("user_id");
		param.put("user_id", user_id);
		try {
			int totalCnt = service.individualPayListCnt(param);
			returnParam.put("totalCnt", String.valueOf(totalCnt));
			returnParam.put("totalPages",
					String.valueOf(CommonUtil.getTotalPage(totalCnt, Integer.parseInt(boardPages))));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 전체 게시물 갯수 설정
		returnParam.put("startPage", CommonUtil.getStart(startPage, boardPages));
		returnParam.put("visiblePages", String.valueOf(boardPages));

		logger.info("Ajax 페이징 정보처리 종료");
		
		return returnParam;
	}
	
	@RequestMapping(value = "lms/user/pageToeflInfo", method = RequestMethod.GET)
	public @ResponseBody Object getPagingToeflInfo(@RequestParam HashMap<String, String> param, HttpSession session) {
		
		logger.info("Ajax 토플 페이징 정보처리 시작");
		
		HashMap<String, String> returnParam = new HashMap<String, String>();
		
		//시작 페이지 객체
		String startPage = StringUtils.isBlank((String)param.get("startPage")) ? "1" : (String)param.get("startPage");
		
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		String user_id = (String) session.getAttribute("user_id");
		param.put("user_id", user_id);
		try {
			int totalCnt = courseService.selectToeflPayCnt(param);
			returnParam.put("totalCnt", String.valueOf(totalCnt));
			returnParam.put("totalPages",
					String.valueOf(CommonUtil.getTotalPage(totalCnt, Integer.parseInt(boardPages))));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 전체 게시물 갯수 설정
		returnParam.put("startPage", CommonUtil.getStart(startPage, boardPages));
		returnParam.put("visiblePages", String.valueOf(boardPages));

		logger.info("Ajax 토플 페이징 정보처리 종료");
		
		return returnParam;
	}
	
	@RequestMapping(value = "lms/user/sub07-02-01", method = RequestMethod.POST)
	public String sub07_02_01(Authentication auth, Model model, String pay_user_seq, String learn_id, String course_name, String cardinal_name, String price, String dis_point, String real_payment, String pay_crc_seq) {
		logger.info("환불 상세 페이지 이동 컨트롤러 시작");

		//learn_id : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액

		HashMap<String, String> returnValue = new HashMap<String, String>();
		if(dis_point.equals("undefined")) {
			dis_point = "";
		}
		returnValue.put("learn_id", learn_id);
		returnValue.put("course_name", course_name);
		returnValue.put("cardinal_name", cardinal_name);
		returnValue.put("price", price);
		returnValue.put("dis_point", dis_point);
		returnValue.put("real_payment", real_payment);
		returnValue.put("pay_user_seq", pay_user_seq);
		returnValue.put("pay_crc_seq", pay_crc_seq);
		
		model.addAttribute("refundInfo", returnValue);

		logger.info("환불 상세 페이지 이동 컨트롤러 종료");

		return "/lms/user/sub07-02-01";
	}	
	
	
	@RequestMapping(value = "/lms/user/sub07-02-01-submit", method = RequestMethod.POST)
	public String sub07_02_01_submit(Authentication auth, Model model, String pay_user_seq, String id, String bank, String account, String owner, String pay_crc_seq) {
		logger.info("환불 접수 컨트롤러 시작");
		//pay_user_seq : 결제정보 seq
		//learnAppId : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		
		try {
			//환불요청 테이블에 값을 세팅하여 저장한다.
			HashMap<String, Object> param = new HashMap<String, Object>();

			String user_id = auth.getName();
			HashMap<String, Object> user_info = service.selectMemberInfo(user_id);
			
			param.put("user_id", user_id);
			param.put("phone", (String)user_info.get("USER_PHONE"));
			param.put("email", (String)user_info.get("USER_EMAIL"));
			param.put("learnAppId", Integer.parseInt(id));
			//param.put("bank", bank);
			//param.put("account", account);
			//param.put("owner", owner);
			
			param.put("pay_refund_accname", owner);
			param.put("pay_refund_bank", bank);
			param.put("pay_refund_accnum", aesEncryptor.encrypt(account));
//			param.put("pay_refund_accnum", account);
			param.put("pay_user_seq", pay_user_seq);
			param.put("pay_crc_seq", pay_crc_seq);
			//courseService.insertLearnCancelApp(param);		

			//환불테이블에 정보 입력 후, 수강신청테이블의 payment_state의 값을 5로 변경하여 '환불 처리중'으로 변경한다
			
			//courseService.changeLearnPaymentState(id);
			
			smtpService.insertEduUserRefundTb(param);
			smtpService.refundUpdate(pay_user_seq);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("환불 접수 컨트롤러 종료");

		return "redirect:/lms/user/sub07-02";
	}		

	@RequestMapping(value = "lms/user/sub07-02-02", method = RequestMethod.POST)
	public String sub07_02_02(Authentication auth, Model model, String learn_id, String pay_crc_seq, String pay_user_seq, String course_name, String cardinal_name, String price, String dis_point, String real_payment) {
		logger.info("환불 수정 상세 페이지 이동 컨트롤러 시작");
		// pay_crc_seq : 납입 정보 seq
		// pay_user_seq : 결제 정보 seq
		//learn_id : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		HashMap<String, String> returnValue = new HashMap<String, String>();
		
		if(dis_point.equals("undefined")) {
			dis_point = "";
		}
		
		String user_id = auth.getName();
		HashMap<String, Object> refundInfo = service.getRefundInfo(pay_user_seq);
		
		HashMap<String, Object> eduCurriculumPayInfo = service.getEduCurriculumPayInfo(Integer.parseInt(pay_crc_seq));
		
		String cardinal = cardinal_name + " " + eduCurriculumPayInfo.get("PAY_CRC_PAYORDER").toString() + "차";
		
		returnValue.put("learn_id", learn_id);
		returnValue.put("course_name", course_name);
		returnValue.put("cardinal_name", cardinal);
		returnValue.put("price", price);
		returnValue.put("dis_point", dis_point);
		returnValue.put("real_payment", real_payment);
		returnValue.put("pay_user_seq", pay_user_seq);
		
		if(!refundInfo.isEmpty()) {
			String account = (String) refundInfo.get("PAY_REFUND_ACCNUM");
   			try {
				refundInfo.put("PAY_REFUND_ACCNUM", aesEncryptor.decrypt(account));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			model.addAttribute("accInfo", refundInfo);
		}
   		
		model.addAttribute("refundInfo", returnValue);
		
//		HashMap<String, String> param = new HashMap<String, String>();

//		param.put("learn_app_id", learn_id);
//		param.put("user_id", user_id);
//		HashMap<String, String> returnParam = courseService.selectLearnCancelInfo(param);
//		model.addAttribute("cancelInfo", returnParam);

		logger.info("환불 수정 상세 페이지 이동 컨트롤러 종료");

		return "/lms/user/sub07-02-02";
	}	
	
	
	@RequestMapping(value = "/lms/user/sub07-02-02-submit", method = RequestMethod.POST)
	public String sub07_02_02_submit(Authentication auth, Model model, String id, String pay_refund_seq, String bank, String account, String owner) {
		logger.info("환불 수정 컨트롤러 시작");

		//learnAppId : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		try {
			//환불요청 테이블에 값을 세팅하여 저장한다.
			HashMap<String, Object> param = new HashMap<String, Object>();

			String user_id = auth.getName();
			HashMap<String, Object> user_info = service.selectMemberInfo(user_id);
			
			param.put("user_id", user_id);
			param.put("learn_app_id", Integer.parseInt(id));
			param.put("pay_refund_seq", pay_refund_seq);
			param.put("bank", bank);
			param.put("account", aesEncryptor.encrypt(account));
//			param.put("account", account);
			param.put("owner", owner);

			//courseService.updateLearnCancelInfo(param);
			
			int result = smtpService.payBackUpdateSubmit(param);
			
			if(result > 0) {
				System.out.println("환불 수정 성공");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("환불 수정 컨트롤러 종료");

		return "redirect:/lms/user/sub07-02";
	}
	
	@RequestMapping(value = "lms/user/sub07-02-03", method = RequestMethod.POST)
	public String sub07_02_03(Authentication auth, Model model, String learn_id, String course_name, 
			String cardinal_name, String price, String dis_point, String real_payment, String accnum, 
			String bank_name, String start, String end) {
		logger.info("가상계좌 조회 페이지 이동 컨트롤러 시작");

		//learn_id : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		//accnum : 가상계좌번호
		//bank_name : 입금할은행

		System.out.println(learn_id);
		System.out.println(course_name);
		System.out.println(cardinal_name);
		System.out.println(price);
		System.out.println(dis_point);
		System.out.println(real_payment);
		
		
		HashMap<String, String> returnValue = new HashMap<String, String>();
		
		String user_id = (auth != null ? auth.getName() : null);
		HashMap<String, Object> memberInfo = service.selectMemberInfo(user_id);
		String user_nm = (String) memberInfo.get("USER_NM");
		
		returnValue.put("learn_id", learn_id);
		returnValue.put("course_name", course_name);
		returnValue.put("cardinal_name", cardinal_name);
		returnValue.put("price", price);
		returnValue.put("dis_point", dis_point);
		returnValue.put("real_payment", real_payment);
		returnValue.put("accnum", accnum);
		returnValue.put("bank_name", bank_name);
		returnValue.put("start", start);
		returnValue.put("end", end);
		returnValue.put("user_nm", user_nm);
		model.addAttribute("bankInfo", returnValue);

		logger.info("가상계좌 조회 페이지 이동 컨트롤러 종료");

		return "/lms/user/sub07-02-03";
	}	

	@ResponseBody
	@RequestMapping(value = "lms/user/sub07-02-02-cancel", method = RequestMethod.POST)
	public boolean sub07_02_02_cancel(String pay_user_seq) {
		logger.info("환불 요청 취소 컨트롤러 시작");

		boolean flag = false;

		//step1 : 환분 취소요청시 환불테이블에서 해당 칼럼을 삭제한다.
		//step2 : 환불테이블 삭제 후, 해당 수강신청 칼럼의 payment_state를 결제완료 상태로 다시 update한다.
//		int result1 = courseService.deleteRefundInfo(learn_id);
//		int result2 = courseService.updateLearnAppState(learn_id);

		int result1 = smtpService.deletePayUserRefundTb(pay_user_seq);
		int result2 = smtpService.updateEduUserPayTb(pay_user_seq);
		
		if(result1!=0&&result2!=0) {
			flag = true;
		}
			
		logger.info("환불 요청 취소 컨트롤러 끝");
		return flag;
	}	
	
	@RequestMapping(value = "/lms/user/sub07-02-04", method = RequestMethod.POST)
	public String sub07_02_04(Authentication auth, Model model, @RequestParam HashMap<String, Object> param) {
		logger.info("토플 가상계좌 조회 페이지 이동 컨트롤러 시작");
		
		String user_id = (auth != null ? auth.getName() : null);

		model.addAttribute("bankInfo", param);

		logger.info("토플 가상계좌 조회 페이지 이동 컨트롤러 종료");

		return "/lms/user/sub07-02-04";
	}
	
	@RequestMapping(value = "/lms/user/sub07-02-05", method = RequestMethod.POST)
	public String sub07_02_05(Authentication auth, Model model, @RequestParam HashMap<String, Object> param) {
		logger.info("토플 환불 페이지 이동 컨트롤러 시작");
		
		String user_id = (auth != null ? auth.getName() : null);
		
		param.put("user_id", user_id);
		model.addAttribute("refundInfo", param);

		logger.info("토플 환불 조회 페이지 이동 컨트롤러 종료");

		return "/lms/user/sub07-02-05";
	}
	
	@RequestMapping(value = "/lms/user/sub07-02-05-submit", method = RequestMethod.POST)
	public String sub07_02_05_submit(Authentication auth, Model model, @RequestParam HashMap<String, Object> param) {
		logger.info("환불 접수 컨트롤러 시작");
		
		try {
			//환불요청 테이블에 값을 세팅하여 저장한다.

			String user_id = auth.getName();
			
			courseService.insertToeflUserRefundTb(param);
			param.put("status", "F0002");
			courseService.refundToeflUpdate(param);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("환불 접수 컨트롤러 종료");

		return "redirect:/lms/user/sub07-02";
	}
	
	@RequestMapping(value = "/lms/user/sub07-02-06", method = RequestMethod.POST)
	public String sub07_02_06(Authentication auth, Model model, @RequestParam HashMap<String, Object> param) {
		logger.info("토플 환불 수정 상세 페이지 이동 컨트롤러 시작");
		logger.info(param.toString());
		String user_id = auth.getName();
		HashMap<String, Object> refundInfo = service.getToeflRefundInfo(String.valueOf(param.get("PAY_TOEFL_SEQ")));
		
		if(!refundInfo.isEmpty()) {
			model.addAttribute("accInfo", refundInfo);
		}
   		
		model.addAttribute("refundInfo", param);

		logger.info("토플 환불 수정 상세 페이지 이동 컨트롤러 종료");

		return "/lms/user/sub07-02-06";
	}
	
	@RequestMapping(value = "/lms/user/sub07-02-06-submit", method = RequestMethod.POST)
	public String sub07_02_06_submit(Authentication auth, Model model, @RequestParam HashMap<String, Object> param) {
		logger.info("토플 환불 수정 컨트롤러 시작");
		
		try {		
			String user_id = auth.getName();
			
			int result = service.toeflRefundUpdate(param);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("토플 환불 수정 컨트롤러 종료");

		return "redirect:/lms/user/sub07-02";
	}
	
	@RequestMapping(value = "/lms/user/RefundCancel", method = RequestMethod.POST)
	public String refundCancel(Authentication auth, Model model, String pay_toefl_seq) {
		logger.info("토플 환불 수정 컨트롤러 시작");
		logger.info(pay_toefl_seq);
		try {		
			String user_id = auth.getName();
			HashMap<String, Object> param = new HashMap<>();
			
			int result = service.toeflRefundDelete(pay_toefl_seq);
			param.put("status", "F0001");
			param.put("PAY_TOEFL_SEQ", pay_toefl_seq);
			courseService.refundToeflUpdate(param);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("토플 환불 수정 컨트롤러 종료");

		return "redirect:/lms/user/sub07-02";
	}
	
	@ResponseBody
	@RequestMapping(value="lms/user/select_receipt_num", method = RequestMethod.POST)
	public Object select_receipt_num(Authentication auth, String toefl_id, String course_id, String cardinal_id) {
		logger.info("영수증 일련번호/날짜 조회 컨트롤러 시작");
		//영수증 번호를 조회해 이미 존재한다면 번호값을 보내고, 존재하지 않으면 일련번호 생성 서비스로 보낸다.
			String user_id = auth.getName();
			HashMap<String, Object> selectMap = new HashMap<String,Object>();
			selectMap.put("user_id", user_id);
			selectMap.put("course_id", course_id);
			selectMap.put("cardinal_id", cardinal_id);
			selectMap.put("toefl_id", toefl_id);
			
			HashMap<String, Object> resultMap = new HashMap<String,Object>();
			resultMap = service.selectReceiptNum(selectMap);
		if(resultMap!=null) {
			return resultMap;			
		} else {
			
			resultMap = service.createReceiptNum();
			logger.info("영수증 일련번호/날짜 조회 컨트롤러 종료");
			return resultMap;
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value="lms/user/insert_receipt", method = RequestMethod.POST)
	public int insert_receipt(Authentication auth, @RequestParam HashMap<String, Object> param) {
		logger.info("영수증 입력 컨트롤러 시작");
		String user_id = auth.getName();
		param.put("user_id", user_id);
		
		int result = service.insertReceipt(param);
			if(result < 1) {
				logger.info("영수증 입력 실패");
			}
		logger.info("영수증 입력 컨트롤러 종료");

		return result;
	}
	
	/**          SMTP         **/
	
	@ResponseBody
	@RequestMapping(value="smtp/user/select_receipt_num", method = RequestMethod.POST)
	public Object smtp_select_receipt_num(Authentication auth, String course_id, String cardinal_id) {
		logger.info("영수증 일련번호/날짜 조회 컨트롤러 시작");
		//영수증 번호를 조회해 이미 존재한다면 번호값을 보내고, 존재하지 않으면 일련번호 생성 서비스로 보낸다.
			String user_id = auth.getName();
			HashMap<String, Object> selectMap = new HashMap<String,Object>();
			selectMap.put("user_id", user_id);
			selectMap.put("course_id", course_id);
			selectMap.put("cardinal_id", cardinal_id);

			HashMap<String, Object> resultMap = new HashMap<String,Object>();
			resultMap = service.selectReceiptNum(selectMap);
		if(resultMap!=null) {
			return resultMap;
		} else {
			
			resultMap = service.createReceiptNum();
			logger.info("영수증 일련번호/날짜 조회 컨트롤러 종료");
			return resultMap;
		}
		
	}
	
	@RequestMapping(value = "smtp/user/paybackFinal")
	public String paybackFinal(Authentication auth, Model model, String learn_id, String course_name, String cardinal_name, String price, String dis_point, String real_payment, String accnum, String bank_name) {
		logger.info("가상계좌 조회 페이지 이동 컨트롤러 시작");

		//learn_id : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		//accnum : 가상계좌번호
		//bank_name : 입금할은행

		HashMap<String, String> returnValue = new HashMap<String, String>();
		
		String user_id = (auth != null ? auth.getName() : null);
		HashMap<String, Object> memberInfo = service.selectMemberInfo(user_id);
		String user_nm = (String) memberInfo.get("USER_NM");
		
		returnValue.put("learn_id", learn_id);
		returnValue.put("course_name", course_name);
		returnValue.put("cardinal_name", cardinal_name);
		returnValue.put("price", price);
		returnValue.put("dis_point", dis_point);
		returnValue.put("real_payment", real_payment);
		returnValue.put("accnum", accnum);
		returnValue.put("bank_name", bank_name);
		returnValue.put("user_nm", user_nm);
		model.addAttribute("bankInfo", returnValue);

		logger.info("가상계좌 조회 페이지 이동 컨트롤러 종료");

		return "/segroup/society/smtp/user/payback-final";
	}
	
}
