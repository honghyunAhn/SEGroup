package com.aracomm.changbi.common.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;

@Controller
@RequestMapping(value = "/iden")
public class IdenCheckPlusController {
	private static final Logger logger = LoggerFactory.getLogger(IdenCheckPlusController.class);

	private static final String IDENT_USER_AUTH_TYPE_PHONE = "phone";	// 휴대폰
	private static final String IDENT_USER_AUTH_TYPE_CARD = "card";		// 신용카드
	private static final String IDENT_USER_AUTH_TYPE_CERT = "cert";		// 인증서

	@Value("#{config['iden.nice.checkplus.siteCode']}")
	private String iden_nice_checkplus_siteCode;

	@Value("#{config['iden.nice.checkplus.sitePw']}")
	private String iden_nice_checkplus_sitePw;

	@Value("#{config['iden.nice.checkplus.successUrl']}")
	private String iden_nice_checkplus_successUrl;

	@Value("#{config['iden.nice.checkplus.errorUrl']}")
	private String iden_nice_checkplus_errorUrl;

	/**
	 * 본인인증화면(휴대폰,인증서,신용카드)
	 * @param iden_gbn
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/nice/checkplus")
	public String checkplus(@RequestParam String iden_gbn, HttpServletRequest request, HttpSession session, Model model) {
		session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);	// 본인인증을 거쳤는지 체크하는 세션변수로 DI값 보관

		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

		String sSiteCode = iden_nice_checkplus_siteCode;	// NICE로부터 부여받은 사이트 코드
		String sSitePassword = iden_nice_checkplus_sitePw;	// NICE로부터 부여받은 사이트 패스워드

		String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
															// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
		sRequestNumber = niceCheck.getRequestNO(sSiteCode);
		session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

		String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

		// START 창비코드
		if (IDENT_USER_AUTH_TYPE_PHONE.equals(iden_gbn)) sAuthType = "M";
		else if (IDENT_USER_AUTH_TYPE_CARD.equals(iden_gbn)) sAuthType = "C";
		else if (IDENT_USER_AUTH_TYPE_CERT.equals(iden_gbn)) sAuthType = "X";
		// END 창비코드

		String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

		String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자

		// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
		//String sReturnUrl = "http://www.test.co.kr/checkplus_success.jsp";      // 성공시 이동될 URL
		//String sErrorUrl = "http://www.test.co.kr/checkplus_fail.jsp";          // 실패시 이동될 URL
		String sReturnUrl = iden_nice_checkplus_successUrl;      	// 성공시 이동될 URL
		String sErrorUrl = iden_nice_checkplus_errorUrl;          	// 실패시 이동될 URL

		// 입력될 plain 데이타를 만든다.
		String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
							"8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
							"9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
							"7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
							"7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
							"11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
							"9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
							"6:GENDER" + sGender.getBytes().length + ":" + sGender;

		String sMessage = "";
		String sEncData = "";

		int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
		if( iReturn == 0 ) sEncData = niceCheck.getCipherData();
		else if( iReturn == -1) sMessage = "암호화 시스템 에러입니다.";
		else if( iReturn == -2) sMessage = "암호화 처리오류입니다.";
		else if( iReturn == -3) sMessage = "암호화 데이터 오류입니다.";
		else if( iReturn == -9) sMessage = "입력 데이터 오류입니다.";
		else sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;


		model.addAttribute("error", sMessage);
		model.addAttribute("EncodeData", sEncData);
		model.addAttribute("iden_gbn", iden_gbn);
		model.addAttribute("iden_callback_success", requestReplace(request.getParameter("iden_callback_success"),""));

		return "common/iden/nice/checkplus";
	}

	// TODO 삭제할 것 - 임시 테스트용 코드
	@RequestMapping(value = "/nice/ajaxGetEncData")
	public @ResponseBody Map<String, String> ajaxGetEncData(HttpServletRequest request, HttpSession session) {
		Map<String, String> result = new HashMap<String, String>();

		String iden_gbn = request.getParameter("iden_gbn");

		session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);	// 본인인증을 거쳤는지 체크하는 세션변수로 DI값 보관

		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

		String sSiteCode = iden_nice_checkplus_siteCode;	// NICE로부터 부여받은 사이트 코드
		String sSitePassword = iden_nice_checkplus_sitePw;	// NICE로부터 부여받은 사이트 패스워드

		String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
															// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
		sRequestNumber = niceCheck.getRequestNO(sSiteCode);
		session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

		String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

		// START 창비코드
		if (IDENT_USER_AUTH_TYPE_PHONE.equals(iden_gbn)) sAuthType = "M";
		else if (IDENT_USER_AUTH_TYPE_CARD.equals(iden_gbn)) sAuthType = "C";
		else if (IDENT_USER_AUTH_TYPE_CERT.equals(iden_gbn)) sAuthType = "X";
		// END 창비코드

		String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지

		String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자

		// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
		//String sReturnUrl = "http://www.test.co.kr/checkplus_success.jsp";      // 성공시 이동될 URL
		//String sErrorUrl = "http://www.test.co.kr/checkplus_fail.jsp";          // 실패시 이동될 URL
		String sReturnUrl = iden_nice_checkplus_successUrl;      	// 성공시 이동될 URL
		String sErrorUrl = iden_nice_checkplus_errorUrl;          	// 실패시 이동될 URL

		// 입력될 plain 데이타를 만든다.
		String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
							"8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
							"9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
							"7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
							"7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
							"11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
							"9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
							"6:GENDER" + sGender.getBytes().length + ":" + sGender;

		String sMessage = "";
		String sEncData = "";

		int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
		if( iReturn == 0 ) sEncData = niceCheck.getCipherData();
		else if( iReturn == -1) sMessage = "암호화 시스템 에러입니다.";
		else if( iReturn == -2) sMessage = "암호화 처리오류입니다.";
		else if( iReturn == -3) sMessage = "암호화 데이터 오류입니다.";
		else if( iReturn == -9) sMessage = "입력 데이터 오류입니다.";
		else sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;

		result.put("iden_gbn", iden_gbn);
		result.put("errorMessage", sMessage);
		result.put("EncodeData", sEncData);

		return result;
	}

	/**
	 * 인증서 로그인을 위한 본인인증화면 화면(인증서인증)
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/nice/checkplusForCertLogin")
	public String checkplusForCertLogin(HttpServletRequest request, HttpSession session, Model model) {
		return checkplus(IDENT_USER_AUTH_TYPE_CERT, request, session, model);
	}

	/**
	 * 본인인증 성공
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/nice/checkplus_success")
	public String checkplus_success(HttpServletRequest request, HttpSession session, Model model) {
		Map<String, String> result = new HashMap<String, String>();

		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

		String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

		logger.debug("EncodeData: {}", sEncodeData);

		String sSiteCode = iden_nice_checkplus_siteCode;	// NICE로부터 부여받은 사이트 코드
		String sSitePassword = iden_nice_checkplus_sitePw;	// NICE로부터 부여받은 사이트 패스워드

		String sCipherTime = "";			// 복호화한 시간
		String sRequestNumber = "";			// 요청 번호
		String sResponseNumber = "";		// 인증 고유번호
		String sAuthType = "";				// 인증 수단
		String sName = "";					// 성명
		String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
		String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
		String sBirthDate = "";				// 생년월일(YYYYMMDD)
		String sGender = "";				// 성별
		String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
		String sMobileNo = "";				// 휴대폰번호
		String sMobileCo = "";				// 통신사
		String sMessage = "";
		String sPlainData = "";

		int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

		if( iReturn == 0 ) {
			sPlainData = niceCheck.getPlainData();
			sCipherTime = niceCheck.getCipherDateTime();

			// 데이타를 추출합니다.
			java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

			logger.debug("result: {}", mapresult);

			sRequestNumber  = (String)mapresult.get("REQ_SEQ");
			sResponseNumber = (String)mapresult.get("RES_SEQ");
			sAuthType		= (String)mapresult.get("AUTH_TYPE");
			sName			= (String)mapresult.get("NAME");
			//sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
			sBirthDate		= (String)mapresult.get("BIRTHDATE");
			sGender			= (String)mapresult.get("GENDER");
			sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
			sDupInfo		= (String)mapresult.get("DI");
			sConnInfo		= (String)mapresult.get("CI");
			sMobileNo		= (String)mapresult.get("MOBILE_NO");
			sMobileCo		= (String)mapresult.get("MOBILE_CO");

			String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
			if(!sRequestNumber.equals(session_sRequestNumber))
			{
				sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
				sResponseNumber = "";
				sAuthType = "";
			}
		}
		else if( iReturn == -1) sMessage = "복호화 시스템 에러입니다.";
		else if( iReturn == -4) sMessage = "복호화 처리오류입니다.";
		else if( iReturn == -5) sMessage = "복호화 해쉬 오류입니다.";
		else if( iReturn == -6) sMessage = "복호화 데이터 오류입니다.";
		else if( iReturn == -9) sMessage = "입력 데이터 오류입니다.";
		else if( iReturn == -12) sMessage = "사이트 패스워드 오류입니다.";
		else sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;

		logger.debug("checkplus return: {}, message {}", String.valueOf(iReturn), sMessage);

		// START 창비코드
		String name = sName;
		String birth = CommonUtil.getFormattedBirthday(sBirthDate);
		String sex = "";
		if ("0".equals(sGender)) sex = "F";
		else if ("1".equals(sGender)) sex = "M";
		String phone = CommonUtil.removeTelSeparator(sMobileNo);
		String ci = sConnInfo;
		String di = sDupInfo;
		String iden_gbn = requestReplace(request.getParameter("param_r1"), "");
		String iden_callback_success = requestReplace(request.getParameter("param_r2"), "");
		// END 창비코드

		result.put("iden_gbn", iden_gbn);
		result.put("iden_callback_success", iden_callback_success);
		result.put("name", name);
		result.put("name", name);
		result.put("birth", birth);
		result.put("sex", sex);
		result.put("phone", phone);
		result.put("ci", ci);
		result.put("di", di);

		model.addAttribute("result", result);

		// 본인인증 성공을 세션변수에 설정
		if (StringUtils.isEmpty(sMessage)) {
			session.setAttribute(GlobalConst.SESSION_KEY_IDEN_DI, di);
		}

		if (iReturn == 0) {
			return "common/iden/nice/checkplus_success";
		} else {
			model.addAttribute("error", sMessage);
			return "common/iden/nice/checkplus_fail";
		}
	}

	/**
	 * 본인인증 실패
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/nice/checkplus_fail")
	public String checkplus_fail(HttpServletRequest request, Model model) {
		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

		String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

		logger.debug("EncodeData: {}", sEncodeData);

		String sSiteCode = iden_nice_checkplus_siteCode;	// NICE로부터 부여받은 사이트 코드
		String sSitePassword = iden_nice_checkplus_sitePw;	// NICE로부터 부여받은 사이트 패스워드

		String sCipherTime = "";			// 복호화한 시간
		String sRequestNumber = "";			// 요청 번호
		String sErrorCode = "";				// 인증 결과코드
		String sAuthType = "";				// 인증 수단
		String sMessage = "";
		String sPlainData = "";

		int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

		if( iReturn == 0 ) {
			sPlainData = niceCheck.getPlainData();
			sCipherTime = niceCheck.getCipherDateTime();

			// 데이타를 추출합니다.
			java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);
			logger.debug("result: {}", mapresult);

			sRequestNumber 	= (String)mapresult.get("REQ_SEQ");
			sErrorCode 		= (String)mapresult.get("ERR_CODE");
			sAuthType 		= (String)mapresult.get("AUTH_TYPE");
		}
		else if( iReturn == -1) sMessage = "복호화 시스템 에러입니다.";
		else if( iReturn == -4) sMessage = "복호화 처리오류입니다.";
		else if( iReturn == -5) sMessage = "복호화 해쉬 오류입니다.";
		else if( iReturn == -6) sMessage = "복호화 데이터 오류입니다.";
		else if( iReturn == -9) sMessage = "입력 데이터 오류입니다.";
		else if( iReturn == -12) sMessage = "사이트 패스워드 오류입니다.";
		else sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;

		logger.debug("checkplus return: {}, message {}", String.valueOf(iReturn), sMessage);

		model.addAttribute("error", sMessage);

		return "common/iden/nice/checkplus_fail";
	}

	private String requestReplace (String paramValue, String gubun) {

		String result = "";

		if (paramValue != null) {

			paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

			paramValue = paramValue.replaceAll("\\*", "");
			paramValue = paramValue.replaceAll("\\?", "");
			paramValue = paramValue.replaceAll("\\[", "");
			paramValue = paramValue.replaceAll("\\{", "");
			paramValue = paramValue.replaceAll("\\(", "");
			paramValue = paramValue.replaceAll("\\)", "");
			paramValue = paramValue.replaceAll("\\^", "");
			paramValue = paramValue.replaceAll("\\$", "");
			paramValue = paramValue.replaceAll("'", "");
			paramValue = paramValue.replaceAll("@", "");
			paramValue = paramValue.replaceAll("%", "");
			paramValue = paramValue.replaceAll(";", "");
			paramValue = paramValue.replaceAll(":", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll("#", "");
			paramValue = paramValue.replaceAll("--", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll(",", "");

			if(!"encodeData".equals(gubun)){
				paramValue = paramValue.replaceAll("\\+", "");
				paramValue = paramValue.replaceAll("/", "");
				paramValue = paramValue.replaceAll("=", "");
			}

			result = paramValue;

		}
		return result;
  }
}
