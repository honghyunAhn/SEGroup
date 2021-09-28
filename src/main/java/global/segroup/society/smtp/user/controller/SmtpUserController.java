package global.segroup.society.smtp.user.controller;

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
import org.json.simple.JSONObject;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.member.vo.MemberForm;
import com.aracomm.changbi.mypage.service.PointService;
import com.aracomm.changbi.mypage.vo.PointSearchVo;
import com.aracomm.changbi.user.service.UserService;
import com.aracomm.changbi.user.web.UserController;
import com.dreamsecurity.crypt.MsgCrypto;
import com.google.gson.Gson;

import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.domain.UserVerification;
import global.segroup.exception.WaitingException;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.society.smtp.apply.domain.DateAttendanceVO;
import global.segroup.society.smtp.apply.domain.InfoAttendance;
import global.segroup.society.smtp.apply.service.SocietyStudentApplyService;
import global.segroup.society.smtp.course.service.SmtpCourseService;
import global.segroup.util.AESEncryptor;
import global.segroup.util.PathConstants;

@Controller
public class SmtpUserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private AESEncryptor aesEncryptor;
	
	@Value("#{config['miniPages']}")
	private int miniPages;
	
	@Value("#{props['usr.local.cert']}")
	private static String cert;
	
	@Value("#{config['boardPages']}")
	String boardPages;
	
	//포인트 처리 관련 서비스
	@Autowired
	private PointService pService;
	
	//회원 정보 관련 서비스
	@Autowired
	private UserService service;
	
	@Autowired
	private SmtpCourseService courseService;
	
	//지원서 관련 서비스
	@Autowired
	private SocietyStudentApplyService applyService;
	
	@Autowired
	private SocietyEduUserService seuService;
	
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
		 String rtn_url = "https://www.softsociety.net/lms/user/user_mobile_verification"; //(운영서버 적용시)
		 //String rtn_url = "http://localhost:8787/lms/user/user_mobile_verification";  
		  String cpId = "sesoc"; // 회원사ID 
		  String urlCode = "01001"; // URL 코드 
		  String reqdate = day;  // 요청일시
		  
		  reqInfo = urlCode + "/" + reqNum + "/" + reqdate; //암호화 시킬 데이터 '/'로 구분해서 합친다.	 
		  encReqInfo = mscr.msgEncrypt(reqInfo, "/usr/local/cert/sesocCert.der");	//(운영서버 적용시)	
		  //encReqInfo = mscr.msgEncrypt(reqInfo,"D:/sesocCert.der");
		  
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
	
	@RequestMapping(value = "/smtp/user/sub01-01", method = RequestMethod.GET)
	public String sub01_01(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authentication auth) {
		logger.info("로그인 페이지 이동 컨트롤러 시작");
		
		Exception exception = (Exception) session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");

		if ((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException
				|| exception.getCause() instanceof BadCredentialsException)) {
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			// 휴면 계정 처리
//			if (exception.getCause() instanceof DisabledException) {
//				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_DORMANCY_FORM;
//			}
			// 탈퇴 계정 처리
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
		return "/segroup/society/smtp/user/sub01-01";
	}
	
	@RequestMapping(value = "/smtp/user/rainbow-user01-01", method = RequestMethod.GET)
	public String rainbow_user01_01(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authentication auth, 
			@RequestParam(value="error", defaultValue="0") int error, Model model) {
		logger.info("로그인 페이지 이동 컨트롤러 시작");
		Exception exception = (Exception) session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
		if (error == 1) {
			session.removeAttribute("user_id");
		}
		if ((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException
				|| exception.getCause() instanceof BadCredentialsException)) {
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			// 휴면 계정 처리
//			if (exception.getCause() instanceof DisabledException) {
//				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_DORMANCY_FORM;
//			}
			// 탈퇴 계정 처리
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
		return "/segroup/society/smtp/user/rainbow-user01-01";
	}
	
	@RequestMapping(value = "/smtp/user/user_login_success", method = RequestMethod.GET)
	public String smtp_user_login_success(Authentication auth, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response) {
		logger.info("smtp 회원 로그인 성공 컨트롤러 시작");
		
		String user_ip = service.getClintIp(request);
		logger.info(user_ip);
		
		String user_id = auth.getName();
		
		User user = service.selectRestMemberInfo(user_id);

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
		
		
		logger.info("smtp 회원 로그인 성공 컨트롤러 종료");
		return "redirect:/rainbow";
	}
	
	@RequestMapping(value = "/smtp/user/sub05-05")
	public String sub05_05(Model model, Authentication auth, PointSearchVo searchVO  ) {
		logger.info("마일리지 페이지 이동 컨트롤러 시작");
		String user_id = (auth != null ? auth.getName() : null);
		searchVO.setUser_id(user_id);
		searchVO.setPointVisiblePages(miniPages);
		model.addAttribute("pointList", pService.selectPointList(searchVO));
		model.addAttribute("pointSummary",pService.selectPointSummary(searchVO.getUser_id()));
		model.addAttribute("searchVO", searchVO);

		logger.info("마일리지 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-05";
	}
	
	@RequestMapping(value = "/smtp/user/sub05-06", method = RequestMethod.GET)
	public String sub05_06(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("개인정보수정 페이지 이동 컨트롤러 시작");

		logger.info("개인정보수정 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-06";
	}
	
	@RequestMapping(value="/smtp/user/checkPw", method = RequestMethod.POST)
	public String smtp_checkPw(Authentication auth, String userPw, Model model) {
		logger.info("비밀번호 확인 후 회원정보 수정 페이지 이동 컨트롤러 시작");
		String user_id = (String) auth.getPrincipal();	
		HashMap<String, Object> userInfo = service.selectMemberInfo(user_id);
		mobileVerificationInfo(model); //전화 본인인증 
		if(userInfo != null) {
				String user_pw = (String) userInfo.get("USER_PW");
				if(!passwordEncoder.matches(userPw, user_pw)) {
					logger.info(user_pw);
					model.addAttribute("msg", "사용자 비밀번호가 틀립니다.");
					return "/smtp/society/smtp/user/sub05-06-01";
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
				
				return "/segroup/society/smtp/user/sub05-06-01";
		} else {
			logger.debug("다시로그인해주세요.");
				return "redirect:/smtp/user/sub01-01";
		}

	}
	
	@RequestMapping(value="/smtp/user/updateUser", method=RequestMethod.POST)
	public String smtp_updateUser(MemberForm memberForm, RedirectAttributes redirectAttributes) {
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
			return "redirect:/smtp/user/sub05-06-01";
		}
		return "redirect:/smtp/user/sub05-06-02";
	}
	
	@RequestMapping(value="/smtp/user/sub05-06-02", method=RequestMethod.GET)
	public String sub05_06_02() {
		logger.info("회원정보 수정 성공 페이지 이동 컨트롤러 시작");
		logger.info("회원정보 수정 성공 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-06-02";
	}
	
	@RequestMapping(value = "/smtp/user/sub05-07", method = RequestMethod.GET)
	public String sub05_07(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("회원탈퇴 약관페이지 이동 컨트롤러 시작");

		logger.info("회원탈퇴 약관 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-07";
	}
	
	@RequestMapping(value = "/smtp/user/sub05-07-01", method = RequestMethod.GET)
	public String sub05_07_01(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("회원탈퇴 페이지 이동 컨트롤러 시작");

		logger.info("회원탈퇴 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-07-01";
	}
	
	@RequestMapping(value = "/smtp/user/optout", method = RequestMethod.POST)
	public String smtp_optout(HttpSession session, MemberForm memberForm, RedirectAttributes redirectAttributes) {
		logger.info("회원탈퇴  컨트롤러 시작");
		System.out.println("아이디 : "+memberForm.getId()+"비밀번호 : "+memberForm.getPw());
		HashMap<String, Object> userInfo = service.selectMemberInfo(memberForm.getId());
		if(userInfo != null) {
			String user_pw = (String) userInfo.get("USER_PW");
			if(!passwordEncoder.matches(memberForm.getPw(), user_pw)) {
				redirectAttributes.addFlashAttribute("msg", "사용자 비밀번호가 틀립니다.");
				return "redirect:/smtp/user/sub05-07-01";
			}
		int result = service.deleteMemberInfo(userInfo);
			if(result < 1) {
				logger.info("탈퇴오류");
				return "redirect:/segroup/society/smtp/user/sub05-07";
			}
		}else {
			redirectAttributes.addFlashAttribute("msg", "사용자 아이디가 없습니다.");
			return "redirect:/smtp/user/sub05-07-01";
		}
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			redirectAttributes.addFlashAttribute("msg", "탈퇴처리되었습니다.로그인창으로 이동합니다.");
			logger.info("회원탈퇴 컨트롤러 종료");
			return "redirect:/"; // 허브 페이지로 이동
	}
	
	@RequestMapping(value = "/smtp/user/denied", method = RequestMethod.GET)
	public String smtp_denied() {
		logger.info("smtp 회원 접근 권한 없음 컨트롤러 시작");
		logger.info("smtp 회원 접근 권한 없음 컨트롤러 종료");
		return "/segroup/society/smtp/user/denied";
	}
	
	@RequestMapping(value = "/smtp/user/sub01-02",  method = {RequestMethod.GET,RequestMethod.POST})
	public String sub01_02(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {
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
		 String rtn_url = "https://www.softsociety.net/smtp/user/user_mobile_verification"; //(운영서버 적용시)
//		 String rtn_url = "http://localhost:8080/smtp/user/user_mobile_verification";  
		  String cpId = "sesoc"; // 회원사ID 
		  String urlCode = "01001"; // URL 코드 
		  String reqdate = day;  // 요청일시
		  
		  reqInfo = urlCode + "/" + reqNum + "/" + reqdate; //암호화 시킬 데이터 '/'로 구분해서 합친다.	 
		 encReqInfo = mscr.msgEncrypt(reqInfo, "/usr/local/cert/sesocCert.der");	//(운영서버 적용시)	
//		 encReqInfo = mscr.msgEncrypt(reqInfo,"D:/sesocCert.der");
		  
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
		 
		logger.info("회원가입 이용약관 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/user/sub01-02";
	}
	
	@RequestMapping(value = "/smtp/user/rainbow-user01-02",  method = {RequestMethod.GET,RequestMethod.POST})
	public String rainbow_user01_02(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {
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
		 String rtn_url = "https://www.softsociety.net/smtp/user/user_mobile_verification"; //(운영서버 적용시)
//		 String rtn_url = "http://localhost:8080/smtp/user/user_mobile_verification";  
		  String cpId = "sesoc"; // 회원사ID 
		  String urlCode = "01001"; // URL 코드 
		  String reqdate = day;  // 요청일시
		  
		  reqInfo = urlCode + "/" + reqNum + "/" + reqdate; //암호화 시킬 데이터 '/'로 구분해서 합친다.	 
		 encReqInfo = mscr.msgEncrypt(reqInfo, "/usr/local/cert/sesocCert.der");	//(운영서버 적용시)	
//		 encReqInfo = mscr.msgEncrypt(reqInfo,"D:/sesocCert.der");
		  
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
		 
		logger.info("회원가입 이용약관 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/user/rainbow-user01-02";
	}
	
	@RequestMapping(value ="/smtp/user/user_mobile_verification", method = RequestMethod.GET)
	public String smtp_user_mobile_verification(HttpSession session ,Model model, HttpServletRequest request) {
		logger.debug("모바일인증 페이지 이동 컨트롤러 시작");
		
		String encPriInfo = request.getParameter("priinfo");

		MsgCrypto mscr = new MsgCrypto();
		String rstInfo = mscr.msgDecrypt(encPriInfo,"/usr/local/cert/sesocPri.key","sesoc@2018","EUC-KR"); //(운영서버 적용시)
//		String rstInfo = mscr.msgDecrypt(encPriInfo,"D:/sesocPri.key","sesoc@2018","EUC-KR");
		String[] rstInfoArray = rstInfo.split("\\$");
		if (rstInfoArray.length > 3) {
			model.addAttribute("mobileVerification", rstInfoArray);
			String veriPhone=rstInfoArray[3];
			UserVerification userVeri=new UserVerification();
			userVeri.setVeriPhone(veriPhone);
			userVeri=seuService.userveri_phone_select(userVeri);
			
			if(userVeri!=null){
				return "/segroup/society/smtp/user/user_mobile_verification_duplicated";
			}
			
		}else{
			return "/segroup/society/smtp/user/user_mobile_verification_failed";
		}
		logger.debug("모바일인증 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/user_mobile_verification";
	}
	
	@RequestMapping(value = "/smtp/user/sub01-02-01", method = RequestMethod.POST)
	public String sub01_02_01(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model, MemberForm memberForm, UserVerification userVeri ) {
		logger.info("회원가입 페이지 이동 컨트롤러 시작");
		model.addAttribute("user",memberForm);
		model.addAttribute("userVeri", userVeri);
		
		logger.info("회원가입 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub01-02-01";
	}
	
	@RequestMapping(value="/smtp/user/joinMember", method=RequestMethod.POST)
	public String smtp_joinMember(MemberForm memberForm, @ModelAttribute(value="userVeri") UserVerification userVeri, HttpServletRequest request) {
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
		return "redirect:/smtp/user/sub00-02-03";
	}
	
	@RequestMapping(value = "smtp/user/sub00-02-03", method = RequestMethod.GET)
	public String sub00_02_03(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		logger.info("회원가입 완료 페이지 이동 컨트롤러 시작");
		logger.info("회원가입 완료 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/user/sub01-02-02";
	}
	
	
	@RequestMapping(value = "smtp/user/sub01-03", method = RequestMethod.GET)
	public String sub01_03(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		logger.info("아이디 찾기 페이지 이동 컨트롤러 시작");
		logger.info("아이디 찾기 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/user/sub01-03";
	}
	
	@RequestMapping(value = "smtp/user/rainbow-user01-03", method = RequestMethod.GET)
	public String rainbow_user01_03(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		logger.info("아이디 찾기 페이지 이동 컨트롤러 시작");
		logger.info("아이디 찾기 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/user/rainbow-user01-03";
	}
	
	@RequestMapping(value = "/smtp/user/lostId", method = RequestMethod.POST)
	public String smtp_lostId(String email, String name, String phone, Model model, RedirectAttributes redirectAttributes) {
		logger.info("아이디 찾기 결과 페이지 이동 컨트롤러 시작");
		HashMap<String,String> findMap = new HashMap<String,String>();
		findMap.put("email", email);
		findMap.put("name", name);
		findMap.put("phone", phone);
		
		Map<String, String> user = service.selectMemberForFindId(findMap);
		if(user != null) {
			model.addAttribute("user_id", user.get("USER_ID"));
			model.addAttribute("user_nm", user.get("USER_NM"));
			model.addAttribute("msg", "id는 " + user.get("USER_ID") + "입니다.");
		} else {
			redirectAttributes.addFlashAttribute("msg", "조회결과가 없습니다. 입력정보를 확인해주세요.");
			return "redirect:/smtp/user/sub01-03";
		}
		logger.info("아이디 찾기 결과 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub01-03-01";
	}
	
	@RequestMapping(value = "/smtp/user/sub01-04-01", method = RequestMethod.GET)
	public String sub01_04_01(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("비밀번호 찾기 페이지 이동 컨트롤러 시작");

		logger.info("비밀번호 찾기 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub01-04-01";
	}
	
	@ResponseBody
	@RequestMapping(value = "/smtp/user/user_request_certification_code", method = RequestMethod.GET)
	public int smtp_user_request_certification_code(@RequestParam HashMap<String, String> param, HttpSession session) {
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
	@RequestMapping(value = "/smtp/user/sub01-04", method = RequestMethod.GET)
	public String sub01_04(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.info("비밀번호 찾기 페이지 이동 컨트롤러 시작");

		logger.info("비밀번호 찾기 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub01-04";
	}
	@ResponseBody
	@RequestMapping(value = "/smtp/user/user_check_certification_code", method = RequestMethod.GET)
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
	@RequestMapping(value="/smtp/user/resetPw", method=RequestMethod.POST)
	public String resetPw(String pw, String user_id, Authentication auth, RedirectAttributes redirectAttributes) {
		logger.info("비밀번호 수정 후 로그인 페이지 이동 컨트롤러 시작");
		String user_pw = passwordEncoder.encode(pw);
		int result = service.updatePassword(user_id, user_pw);
		if(result < 1) {
			logger.debug("비밀번호 수정 실패");
			redirectAttributes.addFlashAttribute("msg", "비밀번호 수정에 실패했습니다.");
			return "redirect:/smtp/user/sub01-04";
		} else {
			redirectAttributes.addFlashAttribute("msg", "비밀번호 수정에 성공하였습니다.");
			logger.info("비밀번호 수정 후 로그인 페이지 이동 컨트롤러 종료");
			return "redirect:/smtp/user/sub01-01";
		}
	}
	
	@RequestMapping(value = "/smtp/user/sub05-02", method = RequestMethod.GET)
	public String sub05_02(Authentication auth, Boolean message, Model model) {
		
		logger.info("지원현황 페이지 이동 시작");
		
		if(auth != null){
			String user_id = (String) auth.getPrincipal();
			ArrayList<HashMap<String, Object>> ssa = applyService.selectApplyResult(user_id);
			
			model.addAttribute("applyResult", ssa);
			model.addAttribute("message", message);
		}
		logger.info("지원현황 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-02";
	}
	
	// 나의 강의실 - 지원현황 - 지원신청서 보기
	@RequestMapping(value = "/smtp/user/sub05-02-01", method = RequestMethod.POST)
	public String sub05_02_01(Authentication auth, String gisu_id, String app_end_date, Model model) {

		logger.info("지원신청서 보기 컨트롤러 시작");
		
		if(auth != null){
			HashMap<String, Object> param = new HashMap<>();
			param.put("user_id", (String) auth.getPrincipal());
			param.put("gisu_id", gisu_id);
			
			HashMap<String, Object> applyForm = applyService.selectSmtpApply(param);
			model.addAttribute("apply", applyForm);
			model.addAttribute("app_end_date", app_end_date);
		}
		logger.info("지원신청서 보기 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-02-01";
	}
	
	@RequestMapping(value = "/smtp/user/sub05-03", method = RequestMethod.GET)
	public String sub05_03(Authentication auth) {
		
		logger.info("서류발급 페이지 이동 컨트롤러 시작");
		
		if(auth != null){
			HashMap<String, Object> param = new HashMap<>();
			param.put("user_id", (String) auth.getPrincipal());
		}
		logger.info("서류발급 페이지 이동 컨트롤러 종료");
		return "/segroup/society/smtp/user/sub05-03";
	}
	
	@RequestMapping(value = "/smtp/user/sub05-04", method = RequestMethod.GET)
	public String sub05_04(Authentication auth, Model model, @RequestParam HashMap<String, String> param, String urlParam) {
		
		logger.info("결제현황/환불 페이지 이동 컨트롤러 시작");
		
		if(auth != null) {
			String user_id = (String) auth.getPrincipal();

			if(urlParam!=null)
				if(urlParam.equals("payComplete")) {
					model.addAttribute("message","payComplete");
				} else if(urlParam.equals("payError")){
					model.addAttribute("message","payError");
			}
			
			HashMap<String, Object> memberInfo = service.selectMemberInfo(user_id);
			String user_nm = (String) memberInfo.get("USER_NM");
			
			model.addAttribute("user_nm", user_nm);
			param.put("user_id", user_id);
			ArrayList<HashMap<String, Object>> payList = service.smtpIndividualPayList(param);
			
			model.addAttribute("payList", payList);
		}
		logger.info("결제현황/환불 페이지 이동 컨트롤러 종료");
		
		return "/segroup/society/smtp/user/sub05-04";
	}
	
	@RequestMapping(value = "/smtp/user/sub05-04-list", method = RequestMethod.GET)
	public @ResponseBody Object sub05_04_list(HttpSession session, @RequestParam HashMap<String, String> param,  Model model) {
		String user_id = (String) session.getAttribute("user_id");
		param.put("user_id", user_id);
		// 시작 페이지 객체
		String startPage = StringUtils.isBlank((String) param.get("startPage")) ? "1" : (String) param.get("startPage");
		// 시작 페이지 설정
		param.put("startPage", CommonUtil.getStart(startPage, boardPages));
		// 볼 수 있는 페이지 설정
		param.put("visiblePages", boardPages);
		return service.smtpIndividualPayList(param);
	}
	
	@RequestMapping(value = "/smtp/user/paybackUpdate")
	public String smtp_paybackUpdate(Authentication auth, Model model, String learn_id, String course_name, String cardinal_name, String price, String dis_point, String real_payment, String pay_crc_seq) {
		logger.info("환불 수정 상세 페이지 이동 컨트롤러 시작");
		
//		System.out.println("Payback Update Param Check : " + learn_id + " " + course_name + " " + cardinal_name + " " + price + " " + dis_point + " " + real_payment + " " + pay_crc_seq);

		//learn_id : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		HashMap<String, String> returnValue = new HashMap<String, String>();
		
		String userId = auth.getName();
		HashMap<String, Object> map = service.getUserPayInfo(pay_crc_seq, userId);
		HashMap<String, Object> refundInfo = service.getRefundInfo(map.get("PAY_USER_SEQ").toString());
		
		int payCrcSeq = Integer.parseInt(map.get("PAY_CRC_SEQ").toString());
		
		HashMap<String, Object> eduCurriculumPayInfo = service.getEduCurriculumPayInfo(payCrcSeq);
		
//		System.out.println("Refun Info Subject Check : " + map.toString());
//		System.out.println("EduCurriculumPayInfo Check : " + eduCurriculumPayInfo.toString());
		
		String cardinal = cardinal_name + " " + eduCurriculumPayInfo.get("PAY_CRC_PAYORDER").toString() + "차";
		
		returnValue.put("learn_id", learn_id);
		returnValue.put("course_name", course_name);
		returnValue.put("cardinal_name", cardinal);
		returnValue.put("price", eduCurriculumPayInfo.get("PAY_CRC_AMOUNT").toString());
		returnValue.put("real_payment", real_payment);
		returnValue.put("pay_user_seq", map.get("PAY_USER_SEQ").toString());

   		if(!refundInfo.isEmpty()) {
   			String account = (String) refundInfo.get("PAY_REFUND_ACCNUM");
   			try {
				refundInfo.put("PAY_REFUND_ACCNUM", aesEncryptor.decrypt(account));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
//			System.out.println("Refund Info Check : " + refundInfo.toString());
			model.addAttribute("accInfo", refundInfo);
		}
   		
		model.addAttribute("refundInfo", returnValue);


		logger.info("환불 수정 상세 페이지 이동 컨트롤러 종료");

		return "/popup/sub05-view-refund-update";
	}
	
	@RequestMapping(value = "smtp/user/payback-main")
	public String smtp_payback_main(Authentication auth, Model model, String learn_id, String course_name, String cardinal_name, String price, String dis_point, String real_payment, String pay_crc_seq) {
		logger.info("환불 상세 페이지 이동 컨트롤러 시작");

		//learn_id : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		
//		System.out.println("Payback Main Param Check : " + learn_id + " " + course_name + " " + cardinal_name + " " + price + " " + dis_point + " " + real_payment + " " + pay_crc_seq);

		String userId = auth.getName();
		HashMap<String, String> returnValue = new HashMap<String, String>();
		HashMap<String, Object> map = service.getUserPayInfo(pay_crc_seq, userId);
		HashMap<String, Object> refundInfo = service.getRefundInfo(map.get("PAY_USER_SEQ").toString());
		
		returnValue.put("learn_id", learn_id);
		returnValue.put("course_name", course_name);
		returnValue.put("cardinal_name", cardinal_name);
		returnValue.put("price", price);
		returnValue.put("dis_point", dis_point);
		returnValue.put("real_payment", real_payment);
		returnValue.put("pay_crc_seq", pay_crc_seq);
		returnValue.put("pay_user_seq", map.get("PAY_USER_SEQ").toString());
   		returnValue.put("pay_user_method", (String)map.get("PAY_USER_METHOD"));
   		
//   		System.out.println("Refund Info Map Check : " + returnValue.toString());
		model.addAttribute("refundInfo", returnValue);

		logger.info("환불 상세 페이지 이동 컨트롤러 종료");

		return "/popup/sub05-view-refund";
	}	
	
	@ResponseBody
	@RequestMapping(value = "/smtp/user/sub05-04-01-submit", method = RequestMethod.POST)
	public void sub05_04_01_submit(Authentication auth, Model model, String id, String pay_crc_seq, String pay_user_seq, String pay_user_method, String bank, String account, String owner) {
		logger.info("SMTP 환불 접수 컨트롤러 시작");
		
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
			
			param.put("pay_refund_accname", owner);
			param.put("pay_refund_bank", bank);
			param.put("pay_refund_accnum", aesEncryptor.encrypt(account));
//			param.put("pay_refund_accnum", account);
			param.put("pay_user_seq", pay_user_seq);
			param.put("pay_crc_seq", pay_crc_seq);
			
//			System.out.println("Refund Param Check : " + param.toString());

			courseService.insertEduUserRefundTb(param);
			courseService.refundUpdate(pay_user_seq);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("SMTP 환불 접수 컨트롤러 종료");
	}
	
	@ResponseBody
	@RequestMapping(value = "smtp/user/paymentCancel", method = RequestMethod.POST)
	public boolean smtp_paymentCancel(String pay_user_seq) {
		logger.info("환불 요청 취소 컨트롤러 시작");

		boolean flag = false;
		
//		System.out.println("Payback PayUserSeq Check : " + pay_user_seq);

		//step1 : 환분 취소요청시 환불테이블에서 해당 칼럼을 삭제한다.
		//step2 : 환불테이블 삭제 후, 해당 수강신청 칼럼의 payment_state를 결제완료 상태로 다시 update한다.
//		int result1 = courseService.deleteRefundInfo(learn_id);
//		int result2 = courseService.updateLearnAppState(learn_id);
		
		int result1 = courseService.deletePayUserRefundTb(pay_user_seq);
		int result2 = courseService.updateEduUserPayTb(pay_user_seq);
		
		if(result1!=0&&result2!=0) {
			flag = true;
		}
			
		
		logger.info("환불 요청 취소 컨트롤러 끝");
		return flag;
	}
	@ResponseBody
	@RequestMapping(value = "/smtp/user/paybackUpdate-submit", method = RequestMethod.POST)
	public void smtp_paybackUpdate_submit(Authentication auth, Model model, String id, String bank, String account, String owner, String pay_refund_seq) {
		logger.info("환불 수정 컨트롤러 시작");
		
//		System.out.println("Enterted Payback Update Submit");
//		System.out.println("Payback Update Submit Param Check : " + id + " " + bank + " " + account + " " + owner + " " + pay_refund_seq);

		//learnAppId : 수강신청 seq
		//course_name: 해당 과정명
		//cardinal_name : 해당 기수명
		//price : 원 가격
		//dis_point : 마일리지 사용금액
		//real_payment : 실제 결제 금액
		try {
			//환불요청 테이블에 값을 세팅하여 저장한다.
			HashMap<String, Object> param = new HashMap<String, Object>();

			param.put("pay_refund_seq", pay_refund_seq);
			param.put("bank", bank);
			param.put("account", aesEncryptor.encrypt(account));
//			param.put("account", account);
			param.put("owner", owner);

			int result = courseService.payBackUpdateSubmit(param);
			
			if(result > 0) {
				System.out.println("환불 수정 성공");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("환불 수정 컨트롤러 종료");
	}
	
	@RequestMapping(value="/smtp/user/certificate", method=RequestMethod.POST)
	public String submitCertificate(Authentication auth, DateAttendanceVO date, InfoAttendance attendance){
		
		String user_id = (String) auth.getPrincipal();
		
		attendance.setRegUser(user_id);
		
		service.submitCertificate(attendance, date);
		
		return "redirect:/smtp/mypage/smtp_regist?course_id="+date.getCourseId()+"&cardinal_id="+date.getCardinalId();
	}
	@RequestMapping(value = "/smtp/user/user_access_denied", method = RequestMethod.GET)
	public String login_access_denied() {
		logger.debug("회원 접근 권한 없음 컨트롤러 시작");
		logger.debug("회원 접근 권한 없음 컨트롤러 종료");
		return "/segroup/society/smtp/user/user_access_denied";
	}
	@RequestMapping(value = "/smtp/user/user_security_invalidate", method = RequestMethod.GET)
	public String user_security_invalidate(HttpSession session) {
		logger.debug("회원 시큐리티 초기화 컨트롤러 시작");
		
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		
		logger.debug("회원 시큐리티 초기화 컨트롤러 종료");
		return "redirect:/smtp/user/sub01-01";
	}
}
