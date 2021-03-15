/**
 * 
 */
package global.segroup.society.edu.user.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Random;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamsecurity.crypt.MsgCrypto;
import com.inicis.std.util.HttpUtil;
import com.inicis.std.util.ParseUtil;
import com.inicis.std.util.SignatureUtil;

import global.segroup.controller.PayController;
import global.segroup.domain.User;
import global.segroup.domain.UserVerification;
import global.segroup.exception.WaitingException;
import global.segroup.service.SEGroupCommonService;
import global.segroup.society.edu.user.domain.RefundInfo;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.util.AESEncryptor;
import global.segroup.util.PathConstants;

/**
 * @Author : 이종호
 * @Date : 2017. 8. 8.
 * @Class 설명 : 모집홍보 공통 로그인 컨트롤러
 * 
 */
@Controller
public class SocietyEduUserViewController implements PathConstants {

	private static final Logger logger = LoggerFactory.getLogger(SocietyEduUserViewController.class);

	@Autowired
	private SocietyEduUserService seuService;

	@Autowired
	private SEGroupCommonService sgcService;

	@Autowired
	private AESEncryptor aesEncryptor;
	
	/**
	 * @Method Name : login_form
	 * @Date : 2017. 8. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 로그인 폼 페이지)
	 * @Method 설명 : 모집홍보 회원 로그인 폼 페이지 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_LOGIN_FORM, method = RequestMethod.GET)
	public String login_form(HttpSession session) {
		logger.debug("모집홍보 회원 로그인 폼 이동 컨트롤러 시작");

		Exception exception = (Exception) session.getAttribute("SPRING_SECURITY_LAST_EXCEPTION");

		if ((exception != null) && !(exception.getCause() instanceof UsernameNotFoundException
				|| exception.getCause() instanceof BadCredentialsException)) {
			// 세션 초기화
			SecurityContextHolder.clearContext();
			session.invalidate();
			// 휴면 계정 처리
			if (exception.getCause() instanceof DisabledException) {
				return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_DORMANCY_FORM;
			}
			// 탈퇴 계정 처리
			else if (exception.getCause() instanceof AccountExpiredException) {
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

		logger.debug("모집홍보 회원 로그인 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_LOGIN_FORM;
	}

	/**
	 * @Method Name : login_success
	 * @Date : 2017. 8. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 로그인 성공)
	 * @Method 설명 : 모집홍보 회원 로그인 성공시 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_LOGIN_SUCCESS, method = RequestMethod.GET)
	public String login_success(HttpServletRequest request, HttpServletResponse response, HttpSession session, Authentication auth) {
		logger.debug("모집홍보 회원 로그인 성공 컨트롤러 시작");
		
		/*StringBuffer url = ((HttpServletRequest) request).getRequestURL();
		String urlLower = url.toString().toLowerCase();
		
		if (urlLower.contains("ges.sesoc.global")) {
			return "redirect:http://www.softsociety.net/ictcenter";
		} else if (urlLower.contains("scitmaster.com")) {
			return "redirect:http://www.softsociety.net/ictcenter";
		}
		
		return "redirect:/ictcenter";*/
		String user_id = auth.getName();
		session.setAttribute("user_id", user_id);
		//크롬 80 이슈관련 samesite 속성 설정
		response.addHeader("Set-Cookie", "JSESSIONID=" + request.getRequestedSessionId() + "; path=/; Secure; SameSite=None; HttpOnly;");
		
		logger.debug("모집홍보 회원 로그인 성공 컨트롤러 종료");
		return "redirect:/ictcenter";
	}

	/**
	 * @Method Name : login_access_denied
	 * @Date : 2017. 8. 9.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 접근 권한 없음 페이지)
	 * @Method 설명 : 권한이 없는 사용자가 회원 페이지 접근시 호출되는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_ACCESS_DENIED, method = RequestMethod.GET)
	public String login_access_denied() {
		logger.debug("모집홍보 회원 접근 권한 없음 컨트롤러 시작");
		logger.debug("모집홍보 회원 접근 권한 없음 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_ACCESS_DENIED;
	}

	/**
	 * @Method Name : forgot_id_form
	 * @Date : 2017. 10. 12.
	 * @User : 한진규
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 아이디 찾기 페이지)
	 * @Method 설명 : 모집홍보 회원 아이디 찾을 때 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_FORGOT_ID, method = RequestMethod.GET)
	public String forgot_id() {
		logger.debug("모집홍보 회원 아이디 찾기 컨트롤러 시작");
		logger.debug("모집홍보 회원 아이디 찾기 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_FORGOT_ID;
	}

	/**
	 * @throws Exception
	 * @Method Name : forgot_id
	 * @Date : 2017. 10. 12.
	 * @User : 한진규
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 아이디 찾기 결과 페이지)
	 * @Method 설명 : 모집홍보 회원 아이디 찾을 때 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_FORGOT_ID_RESULT, method = RequestMethod.GET)
	public String forgot_id_result(HttpSession session, Model model) throws Exception {
		logger.debug("모집홍보 회원 아이디 찾기 결과 컨트롤러 시작");

		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");

		User user = new User();
		user.setUser_id(user_id);

		String found_id = seuService.user_forgot_id(user);

		// 찾은 데이터를 모델에 담아서 보냄
		model.addAttribute("found", found_id);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");

		logger.debug("모집홍보 회원 아이디 찾기 결과 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_FORGOT_ID_RESULT;
	}

	/**
	 * @Method Name : forgot_id_form
	 * @Date : 2017. 10. 12.
	 * @User : 한진규
	 * @Param : -
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 비밀번호 찾기 페이지)
	 * @Method 설명 : 모집홍보 회원 비밀번호 찾을 때 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_FORGOT_PASSWORD, method = RequestMethod.GET)
	public String forgot_password() {
		logger.debug("모집홍보 회원 비밀번호 찾기 컨트롤러 시작");
		logger.debug("모집홍보 회원 비밀번호 찾기 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_FORGOT_PASSWORD;
	}

	/**
	 * @Method Name : forgot_password_form
	 * @Date : 2017. 10. 23.
	 * @User : 한진규
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 비밀번호 변경 페이지)
	 * @Method 설명 : 모집홍보 회원 비밀번호 변경할 때 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_FORGOT_PASSWORD_FORM, method = RequestMethod.GET)
	public String forgot_password_form(HttpSession session) throws Exception {
		logger.debug("모집홍보 회원 비밀번호 변경 폼 컨트롤러 시작");

		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");
		if (user_id == null) {
			throw new Exception();
		}

		logger.debug("모집홍보 회원 비밀번호 변경 폼 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_FORGOT_PASSWORD_FORM;
	}

	/**
	 * @Method Name : forgot_password
	 * @Date : 2017. 10. 16.
	 * @User : 한진규
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 모집홍보 회원 비밀번호 찾기 결과 페이지)
	 * @Method 설명 : 모집홍보 회원 비밀번호 변경할 때 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_FORGOT_PASSWORD_CHANGE, method = RequestMethod.POST)
	public String forgot_password_change(HttpSession session, Model model, String user_pw) throws Exception {
		logger.debug("모집홍보 회원 비밀번호 변경 컨트롤러 시작");

		boolean isCertificated = (boolean) session.getAttribute("isCertificated");
		if (isCertificated == false) {
			throw new Exception();
		}

		String user_id = (String) session.getAttribute("user_id");

		boolean canChange = seuService.user_forgot_password(user_id, user_pw);
		model.addAttribute("canChange", canChange);

		// 세션으로부터 정보 삭제함
		session.removeAttribute("isCertificated");
		session.removeAttribute("user_id");

		logger.debug("모집홍보 회원 비밀번호 변경 컨트롤러 시작");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_FORGOT_PASSWORD_RESULT;
	}

	/**
	 * @Method Name : join_terms
	 * @Date : 2017. 8. 30.
	 * @User : 한진규
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 약관 폼)
	 * @Method 설명 : 유저 회원 가입시 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_JOIN_TERMS, method = {RequestMethod.GET,RequestMethod.POST})
	public String join_terms(Model model) {
		logger.debug("유저 회원 가입 약관 폼 이동 컨트롤러 시작");
		//날짜 생성
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
            randomStr += ran.nextInt(10);
        }
		//reqNum은 최대 40byte 까지 사용 가능
       
        MsgCrypto mscr = new MsgCrypto();
        
        String reqNum = day + randomStr;
        String reqInfo    = "";
		String encReqInfo = "";
		String rtn_url = "http://www.softsociety.net/edu/user/user_mobile_verification";
		String cpId       = "sesoc";        // 회원사ID
		String urlCode    = "01001";     // URL 코드
		String reqdate    = day;        // 요청일시

		reqInfo = urlCode + "/" + reqNum + "/" + reqdate;  //암호화 시킬 데이터 '/'로 구분해서 합친다.
		encReqInfo = mscr.msgEncrypt(reqInfo,"/usr/local/cert/sesocCert.der");
		
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
		logger.debug("유저 회원 가입 약관 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_COM_USER_JOIN_TERMS;
	}
	
	/**
	 * @Method Name : user_mobile_verification
	 * @Date : 2018. 9. 5.
	 * @User : 전상수
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 약관 폼)
	 * @Method 설명 : 모바일 본인인증팝업
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_MOBILE_VERIFICATION, method = RequestMethod.GET)
	public String user_mobile_verification(HttpSession session ,Model model, HttpServletRequest request) {
		logger.debug("유저 회원 가입 약관 폼 이동 컨트롤러 시작");
		
		String encPriInfo = request.getParameter("priinfo");

		MsgCrypto mscr = new MsgCrypto();
		String rstInfo = mscr.msgDecrypt(encPriInfo,"/usr/local/cert/sesocPri.key","sesoc@2018","EUC-KR");
		String[] rstInfoArray = rstInfo.split("\\$");
		if (rstInfoArray.length > 3) {
			model.addAttribute("mobileVerification", rstInfoArray);
			String veriPhone=rstInfoArray[3];
			UserVerification userVeri=new UserVerification();
			userVeri.setVeriPhone(veriPhone);
			userVeri=seuService.userveri_phone_select(userVeri);
			
			if(userVeri!=null){
				return PathConstants.SEGROUP_SOCIETY +PathConstants.SOCIETY_COM_USER_MOBILE_VERIFICATION_DUPLICATED;
			}
		
		}else{
			return PathConstants.SEGROUP_SOCIETY +PathConstants.SOCIETY_COM_USER_MOBILE_VERIFICATION_FAILED;
		}
		logger.debug("유저 회원 가입 약관 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY +PathConstants.SOCIETY_COM_USER_MOBILE_VERIFICATION;
	}
	

	/**
	 * @Method Name : join_terms
	 * @Date : 2017. 8. 30.
	 * @User : 한진규
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 약관 폼)
	 * @Method 설명 : 유저 회원 가입시 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_JOIN_TERMS_AGREE, method = RequestMethod.GET)
	public String join_terms_agree(HttpSession session) {
		logger.debug("유저 회원 가입 약관 동의 컨트롤러 시작");

		// 약관 동의를 저장
		session.setAttribute("join_terms_agree", true);

		logger.debug("유저 회원 가입 약관 동의 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_COM_USER_JOIN_FORM;
	}

	/**
	 * @Method Name : join_form
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 가입 폼)
	 * @Method 설명 : 유저 회원 가입시 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_JOIN_FORM, method = RequestMethod.GET)
	public String join_form(HttpSession session, Model model) {
		logger.debug("유저 회원 가입 폼 이동 컨트롤러 시작");

		// 동의를 안 했을 시엔 동의서로 보낸다
		if (session.getAttribute("join_terms_agree") == null) {
			return "redirect:" + PathConstants.SOCIETY_COM_USER_JOIN_TERMS;
		}
		//날짜 생성
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
		            randomStr += ran.nextInt(10);
		        }
				//reqNum은 최대 40byte 까지 사용 가능
		       
		        MsgCrypto mscr = new MsgCrypto();
		        
		        String reqNum = day + randomStr;
		        String reqInfo    = "";
				String encReqInfo = "";
				String rtn_url = "http://www.softsociety.net/edu/user/user_mobile_verification";
				String cpId       = "sesoc";        // 회원사ID
				String urlCode    = "01001";     // URL 코드
				String reqdate    = day;        // 요청일시

				reqInfo = urlCode + "/" + reqNum + "/" + reqdate;  //암호화 시킬 데이터 '/'로 구분해서 합친다.
				encReqInfo = mscr.msgEncrypt(reqInfo,"/usr/local/cert/sesocCert.der");
				
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

		Calendar c = Calendar.getInstance();

		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int date = c.get(Calendar.DATE);

		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", date);

		// 세션의 동의 정보를 지운다
		session.removeAttribute("join_terms_agree");

		logger.debug("유저 회원 가입 폼 이동 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_COM_USER_JOIN_FORM;
	}

	/**
	 * @Method Name : join
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param :
	 * @Return : 리다이렉트(SMART Cloud IT마스터 가입 성공 폼 / 실패 폼)
	 * @Method 설명 : 유저가 회원 가입 폼으로부터 정보를 전송시 호출되는 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_JOIN, method = RequestMethod.POST)
	public String join(User user,UserVerification userVeri, HttpSession session, RedirectAttributes rAttr) {
		logger.debug("유저 회원 가입 컨트롤러 시작");
		logger.debug(user.toString());
		
		//USER_FLAG(회원 종류)를 A0100(일반 회원)로 등록
		user.setUser_flag("A0100");
		userVeri.setUser_id(user.getUser_id());
		// 실제 데이터 등록
		seuService.user_insert(user);
		seuService.userveri_insert(userVeri);
		// 세션에 등록했다는 표시 저장
		session.setAttribute("join_success", true);

		// 결과창에 보일 아이디 이메일을 flash로 저장
		rAttr.addFlashAttribute("user_id", user.getUser_id());
		rAttr.addFlashAttribute("user_email", user.getUser_email());

		logger.debug("유저 회원 가입 컨트롤러 종료");
		return "redirect:" + PathConstants.SOCIETY_COM_USER_JOIN_SUCCESS;
	}

	/**
	 * @Method Name : join_success
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param :
	 * @Return : JSP 리턴페이지(SMART Cloud IT마스터 가입 성공 폼)
	 * @Method 설명 :
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_JOIN_SUCCESS, method = RequestMethod.GET)
	public String join_success(HttpSession session) {
		logger.debug("유저 회원 가입 성공 컨트롤러 시작");

		// 가입 성공한 것이 확인되지 않으면 가입창으로 돌려보낸다
		if (session.getAttribute("join_success") == null) {
			return "redirect:" + PathConstants.SOCIETY_COM_USER_JOIN_FORM;
		}

		// 성공시엔 세션의 정보를 모두 지운다
		session.removeAttribute("join_terms_agree");
		session.removeAttribute("join_success");

		logger.debug("유저 회원 가입 성공 컨트롤러 종료");
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_COM_USER_JOIN_SUCCESS;
	}

	/**
	 * @Method Name : user_update_form
	 * @Date : 2017. 9. 1.
	 * @User : 이종호
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 로그인 한 유저 정보 수정 페이지 폼 으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_UPDATE_FORM)
	public String user_update_form(Model model, RedirectAttributes rttr, Authentication auth, HttpServletRequest request) {

		Calendar c = Calendar.getInstance();

		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int date = c.get(Calendar.DATE);

		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", date);

		User userInfo = new User();
		if(auth != null) {
			userInfo.setUser_id(auth.getName());
			User user = seuService.user_select(userInfo);

			model.addAttribute("user", user);
		} else {
			rttr.addAttribute("sessionExpire", "sessionExpire");
			return "redirect:/ictcenter";
		}
				
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_COM_USER_UPDATE_FORM;
	}

	/**
	 * @Method Name : user_update_form
	 * @Date : 2017. 12. 14.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 로그인 한 유저 결제현황 정보를 가져오는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_PAY_STATUS, method = RequestMethod.GET)
	public @ResponseBody ArrayList<HashMap<String, Object>> user_pay_status(Model model, Authentication auth) {

		ArrayList<HashMap<String, Object>> payList = null; // 결제내역리스트

		payList = seuService.user_pay_status(auth.getName());

		return payList;
	}

	/**
	 * @Method Name : user_refund_req
	 * @Date : 2017. 12. 18.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 사용자 환불을 요청하는 컨트롤러
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_REFUND_REQ)
	public String user_refund_req(Model model, Authentication auth, RefundInfo refundInfo) {

		refundInfo.setReqId(auth.getName());
		try {
			refundInfo.setAccNum(aesEncryptor.encrypt(refundInfo.getAccNum()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		seuService.user_refund_req(refundInfo);

		return "redirect:" + PathConstants.SOCIETY_COM_USER_UPDATE_FORM;
	}

	/**
	 * @Method Name : user_update_form
	 * @Date : 2017. 12. 14.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 환불정보를 가져오는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_REFUND_STATUS, method = RequestMethod.GET)
	public @ResponseBody RefundInfo user_refund_status(Model model, Authentication auth, String seq) {

		RefundInfo info = new RefundInfo();
		info = seuService.user_refund_status(seq);
		try {
			info.setAccNum(aesEncryptor.decrypt(info.getAccNum()));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return info;
	}
	
	/**
	 * @Method Name : user_update_form
	 * @Date : 2018. 07. 31.
	 * @User : 김도훈
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 로그인 한 유저 온라인상담 정보를 가져오는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_CONSULTING_STATUS, method = RequestMethod.GET)
	public @ResponseBody ArrayList<HashMap<String, Object>> user_consulting_list(Model model, Authentication auth) {

		ArrayList<HashMap<String, Object>> consultingList = null; // 상담내역리스트

		consultingList = seuService.user_consulting_list(auth.getName());

		return consultingList;
	}

	/**
	 * @Method Name : user_pay_ini
	 * @Date : 2017. 12. 15.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSP 리턴페이지(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 로그인 한 유저 정보 수정 페이지 폼 으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_PAY_INI)
	public String user_pay_ini(Model model, Authentication auth, HttpServletRequest request,
			HttpServletResponse response, String price, String goodname, String pay_seq, String buyertel,
			String pay_from, String pay_to) {

		User userInfo = new User();
		if(auth==null){
			return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_LOGIN_FORM;
		}
		
		userInfo.setUser_id(auth.getName());
		User user = seuService.user_select(userInfo);

		
		PayController pc = new PayController();
		try {
			model = pc.payInfo(model, request, user, price, goodname, pay_seq, pay_from, pay_to);
		    model.addAttribute("user_id",auth.getName());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_COM_USER_PAY_INI;
	}

	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_PAY_INFO)
	public String user_pay_info(Model model, HttpServletRequest request, HttpServletResponse response,
			Authentication auth) {

		String retUrl = "segroup/society/edu/user/user_pay_cancel";

		/**********************************************************************************************
		 * INIpay 모듈 세팅 시작
		 **********************************************************************************************/

		// #############################
		// 인증결과 파라미터 일괄 수신
		// #############################
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Map<String, String> paramMap = new Hashtable<String, String>();

		Enumeration<String> elems = request.getParameterNames();

		String temp = "";

		while (elems.hasMoreElements()) {
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));

		}

		// #####################
		// 인증이 성공일 경우만
		// #####################
		if ("0000".equals(paramMap.get("resultCode"))) {

			// ############################################
			// 1.전문 필드 값 설정(***가맹점 개발수정***)
			// ############################################

			String mid = paramMap.get("mid"); // 가맹점 ID 수신 받은 데이터로 설정

			//String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 가맹점에 제공된
			// 키(이니라이트키)
			// (가맹점
			// 수정후
			// 고정)
			// !!!절대!!
			// 전문
			// 데이터로
			// 설정금지

			String timestamp = SignatureUtil.getTimestamp(); // util에 의해서
			// 자동생성

			String charset = "UTF-8"; // 리턴형식[UTF-8,EUC-KR](가맹점 수정후 고정)
			String format = "NVP"; // 리턴형식[XML,JSON,NVP](가맹점 수정후 고정)

			// 추가적 noti가 필요한 경우(필수아님, 공백일 경우 미발송, 승인은 성공시, 실패시 모두 Noti발송됨)
			// 미사용
			// String notiUrl = "";

			String authToken = paramMap.get("authToken"); // 취소 요청 tid에 따라서
															// 유동적(가맹점 수정후 고정)

			String authUrl = paramMap.get("authUrl"); // 승인요청 API url(수신 받은값으로
														// 설정, 임의 세팅 금지)

			//String netCancel = paramMap.get("netCancelUrl"); // 망취소 API url (수신
																// 받은값으로 설정, 임의
																// 세팅 금지)

			// #####################
			// 2.signature 생성
			// #####################
			Map<String, String> signParam = new HashMap<String, String>();

			signParam.put("authToken", authToken); // 필수
			signParam.put("timestamp", timestamp); // 필수

			// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로
			// 나열해 hash)
			String signature = null;
			try {
				signature = SignatureUtil.makeSignature(signParam);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			String price = ""; // 가맹점에서 최종 결제 가격 표기 (필수입력)

			// 1. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// String oid = "";

			// #####################
			// 3.API 요청 전문 생성
			// #####################
			Map<String, String> authMap = new Hashtable<String, String>();

			authMap.put("mid", mid); // 필수
			authMap.put("authToken", authToken); // 필수
			authMap.put("signature", signature); // 필수
			authMap.put("timestamp", timestamp); // 필수
			authMap.put("charset", charset); // default=UTF-8
			authMap.put("format", format); // default=XML
			authMap.put("price", price); // 필수 (가격위변조체크기능)
			// 이니시스 창에서 X(닫기)를 눌러 cancel(결제진행취소)를 했을 때 이전창으로 돌아가기위한 정보담기.
			model.addAttribute("authMap", authMap);
			
			// 2. 가맹점에서 승인시 주문번호가 변경될 경우 (선택입력) 하위 연결.
			// authMap.put("oid", oid);

			// if(null != notiUrl && notiUrl.length() > 0){
			// authMap.put("notiUrl" ,notiUrl);
			// }

			HttpUtil httpUtil = new HttpUtil();

			// #####################
			// 4.API 통신 시작
			// #####################

			String authResultString = "";

			try {
				authResultString = httpUtil.processHTTP(authMap, authUrl);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// ############################################################
			// 5.API 통신결과 처리(***가맹점 개발수정***)
			// ############################################################

			String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ", "")
					.replace("\n", "").replace("}", "").replace("{", "");

			Map<String, String> resultMap = new HashMap<String, String>();

			try {
				resultMap = ParseUtil.parseStringToMap(test);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // 문자열을 MAP형식으로 파싱

			if ("0000".equals(resultMap.get("resultCode"))) {
				/*****************************************************************************
				 * 여기에 가맹점 내부 DB에 결제 결과를 반영하는 관련 프로그램 코드를 구현한다.
				 * 
				 * [중요!] 승인내용에 이상이 없음을 확인한 뒤 가맹점 DB에 해당건이 정상처리 되었음을 반영함 처리중 에러 발생시 망취소를 한다.
				 ******************************************************************************/
				model.addAttribute("tid", resultMap.get("tid"));
				model.addAttribute("payMethod", resultMap.get("payMethod"));
				model.addAttribute("TotPrice", resultMap.get("TotPrice"));
				model.addAttribute("MOID", resultMap.get("MOID"));
				model.addAttribute("applDate", resultMap.get("applDate"));
				model.addAttribute("applTime", resultMap.get("applTime"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));
				model.addAttribute("resultCode", resultMap.get("resultCode"));
				model.addAttribute("VACT_Num", resultMap.get("VACT_Num"));

				System.out.println(test);
				
				String seq = paramMap.get("merchantData").split(",")[0];
				String id = paramMap.get("merchantData").split(",")[1];
				
				resultMap.put("seq", seq);
				resultMap.put("pay_rtn_data", test);
				resultMap.put("id", id);

				HashMap<String, String> copy = new HashMap<String, String>(resultMap);
				if (resultMap.get("payMethod").equals("VBank")) {

					copy.put("status", "0");
					seuService.user_pay_info(copy);

				} else {

					copy.put("status", "1");
					seuService.user_pay_info(copy);
					
					//일반 회원을 K-Move(광주) 학생으로 변경
					HashMap<String, String> params = new HashMap<String, String>();
					params.put("user_id", id);
					params.put("user_flag", "A0106");
					
					sgcService.updateUserFlag(params);
					
				}

				retUrl = "segroup/society/edu/user/user_pay_result";

			} else {

				// 결제오류
				model.addAttribute("errorMsg", resultMap.get("resultMsg"));
				retUrl = "segroup/society/edu/user/user_pay_failed";

			}
		}

		return retUrl;

	}

	/**
	 * @Method Name : user_update_json
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSON 정보(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 로그인 한 유저 정보 수정 페이지 폼 으로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_UPDATE_JSON, method = RequestMethod.GET)
	public @ResponseBody User user_update_json(Model model, Authentication auth) {

		Calendar c = Calendar.getInstance();

		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int date = c.get(Calendar.DATE);

		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("date", date);

		User userInfo = new User();
		userInfo.setUser_id(auth.getName());

		User user = seuService.user_select(userInfo);

		return user;
	}

	/**
	 * @Method Name : user_apply_history
	 * @Date : 2017. 11. 23.
	 * @User : 전상수
	 * @Param : -
	 * @Return : JSON 정보(유저 정보 수정 페이지 폼)
	 * @Method 설명 : 로그인 한 유저 수강신청현황
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_APPLY_HISTORY, method = RequestMethod.GET)
	public @ResponseBody ArrayList<ArrayList<HashMap<String, Object>>> user_apply_history(Model model,
			Authentication auth) {

		ArrayList<HashMap<String, Object>> applyList = null; // 과정 신청리스트
		ArrayList<HashMap<String, Object>> payList = null; // 과정 신청 리스트중 결제 가능 리스트
		ArrayList<ArrayList<HashMap<String, Object>>> applyPayList = new ArrayList<ArrayList<HashMap<String, Object>>>(); // 뷰에
																															// 넘겨주는
																															// 과정
																															// 신청
																															// 리스트중
																															// 결제
																															// 가능
																															// 리스트(1)

		applyList = seuService.user_apply_history(auth.getName());

		if (applyList.size() > 0) {
			applyPayList.add(applyList);
			for (int i = 0; i < applyList.size(); i++) {
				String seq = "" + applyList.get(i).get("gisu_seq");
				payList = seuService.user_payment(seq, auth.getName());
				applyPayList.add(payList);
			}
		}

		return applyPayList;
	}

	/**
	 * @Method Name : user_update
	 * @Date : 2017. 9. 1.
	 * @User : 이종호
	 * @Param : 수정 할 회원 정보 객체
	 * @Return : JSP 리턴 페이지(메인페이지)
	 * @Method 설명 : 회원 정보를 수정하고 메인페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_UPDATE, method = RequestMethod.POST)
	public String user_update(User user) {
		logger.debug("회원 정보 수정 컨트롤러 시작");

		seuService.user_update(user);

		logger.debug("회원 정보 수정 컨트롤러 종료");
		return "redirect:/ictcenter";
	}

	/**
	 * @Method Name : user_delete
	 * @Date : 2018. 7. 10.
	 * @User : 김지훈
	 * @Param : 탈퇴 할 회원 정보 객체
	 * @Return : JSP 리턴 페이지(메인페이지)
	 * @Method 설명 : 회원탈퇴하고 메인페이지로 이동하는 컨트롤러 함수
	 */
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_DELETE, method = RequestMethod.POST)
	public String user_delete(User user, HttpSession session) {
		logger.debug("회원 탈퇴 컨트롤러 시작");

		// 회원탈퇴조치 서비스
		seuService.user_delete(user);

		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();

		logger.debug("회원 탈퇴 컨트롤러 종료");
		return "redirect:/ictcenter";
	}

	/**
	 * @Method Name : user_password_check
	 * @Date : 2018. 7. 10.
	 * @User : 김지훈
	 * @Param : 입력받은 아이디와 패스워드
	 * @Return : 탈퇴 비밀번호 확인 페이지
	 * @Method 설명 : 비밀번호를 확인 후 그 결과를 리턴한다.
	 */
	@ResponseBody
	@RequestMapping(value = "/edu/user/user_password_check", method = RequestMethod.POST)
	public String user_password_check(String user_id, String user_pw) {
		logger.debug("비밀번호 확인 컨트롤러 시작");

		String result = "null";
		if (seuService.checkPassword(user_id, user_pw)) {
			result = "success";
		} else {
			logger.debug("사용자 비밀번호가 틀립니다.");
			System.out.println("사용자 비밀번호가 틀립니다.");
		}

		logger.debug("비밀번호 확인 컨트롤러 종료");

		return result;
	}

	/**
	 * @Method Name : user_refund_cancel
	 * @Date : 2018. 2. 12.
	 * @User : 윤상혁
	 * @Param : -
	 * @Return : 유저 결제현황 데이터
	 * @Method 설명 : 유저가 요청했던 환불을 취소하는 경우
	 */
	@ResponseBody
	@RequestMapping(value = "/edu/user/user_refund_cancel", method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> user_refund_cancel(int pay_refund_seq, Model model, Authentication auth) {
		logger.debug("환불요청 취소 컨트롤러 시작");
		seuService.user_refund_cancel(pay_refund_seq);
		logger.debug("환불요청 취소 컨트롤러 종료");
		return user_pay_status(model, auth);
	}

	/**
	 * @Method Name : user_pay_cancel
	 * @Date : 2018. 2. 14.
	 * @User : 윤상혁
	 * @Param : -
	 * @Return : 유저 결제현황 데이터
	 * @Method 설명 : 유저가 요청했던 결제를 취소하는 경우
	 */
	@ResponseBody
	@RequestMapping(value = "/edu/user/user_pay_cancel", method = RequestMethod.POST)
	public ArrayList<HashMap<String, Object>> user_pay_cancel(int pay_user_seq, Model model, Authentication auth) {
		logger.debug("결제요청 취소 컨트롤러 시작");
		seuService.user_pay_cancel(pay_user_seq);
		logger.debug("결제요청 취소 컨트롤러 종료");
		return user_pay_status(model, auth);
	}
	
	@RequestMapping(value = "/edu/user/user_pay_failed")
	public String user_pay_failed() {
		logger.debug("결제요청 실패 컨트롤러 시작");
		logger.debug("결제요청 실패 컨트롤러 종료");
		return "segroup/society/edu/user/user_pay_failed";
	}
	
	/**
	 * @Method Name : user_security_invalidate
	 * @Date : 2018. 9. 12
	 * @User : 이종호
	 * @Param : 세션정보
	 * @Return : 회원 로그인 페이지
	 * @Method 설명 : 현재 세션정보를 초기화 하고 회원 로그인 페이지로 이동 
	 */
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_SECURITY_INVALIDATE , method = RequestMethod.GET)
	public String user_security_invalidate(HttpSession session) {
		logger.debug("회원 시큐리티 초기화 컨트롤러 시작");
		
		// 세션 초기화
		SecurityContextHolder.clearContext();
		session.invalidate();
		
		logger.debug("회원 시큐리티 초기화 컨트롤러 종료");
		return "redirect:"+PathConstants.SOCIETY_EDU_USER_LOGIN_FORM;
	}
}
