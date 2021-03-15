package com.aracomm.changbi.common.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aracomm.base.common.util.CommonUtil;
import com.aracomm.changbi.common.GlobalConst;

import Kisinfo.Check.IPINClient;

@Controller
@RequestMapping(value = "/iden")
public class IdenIpinController {
	private static final Logger logger = LoggerFactory.getLogger(IdenIpinController.class);

	@Value("#{config['iden.nice.ipin.siteCode']}")
	private String iden_nice_ipin_siteCode;

	@Value("#{config['iden.nice.ipin.sitePw']}")
	private String iden_nice_ipin_sitePw;

	@Value("#{config['iden.nice.ipin.returnUrl']}")
	private String iden_nice_ipin_returnUrl;

	@RequestMapping(value = "/nice/ipin")
	public String checkplus(@RequestParam String iden_gbn, HttpSession session, Model model) {
		session.removeAttribute(GlobalConst.SESSION_KEY_IDEN_DI);	// 본인인증을 거쳤는지 체크하는 세션변수로 DI값 보관

		/********************************************************************************************************************************************
			NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

			서비스명 : 가상주민번호서비스 (IPIN) 서비스
			페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
		*********************************************************************************************************************************************/

		String sSiteCode				= iden_nice_ipin_siteCode;			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
		String sSitePw					= iden_nice_ipin_sitePw;			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)


		/*
		┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
			NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
			따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.

			* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
			* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.

			아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
			예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
		└────────────────────────────────────────────────────────────────────
		*/
		String sReturnURL				= iden_nice_ipin_returnUrl;


		/*
		┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
			[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.

			CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
			데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.

			따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
		└────────────────────────────────────────────────────────────────────
		*/
		String sCPRequest				= "";



		// 객체 생성
		IPINClient pClient = new IPINClient();


		// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
		sCPRequest = pClient.getRequestNO(sSiteCode);

		// CP 요청번호를 세션에 저장합니다.
		// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
		// 필수사항은 아니며, 보안을 위한 권고사항입니다.
		session.setAttribute("CPREQUEST" , sCPRequest);


		// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);

		String sRtnMsg					= "";			// 처리결과 메세지
		String sEncData					= "";			// 암호화 된 데이타

		// Method 결과값에 따른 처리사항
		if (iRtn == 0) {

			// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
			// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
			sEncData = pClient.getCipherData();		//암호화 된 데이타

			//sRtnMsg = "정상 처리되었습니다.";

		}
		else if (iRtn == -1 || iRtn == -2) sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
				"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
		else if (iRtn == -9) sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		else sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";


		model.addAttribute("error", sRtnMsg);
		model.addAttribute("EncodeData", sEncData);
		model.addAttribute("iden_gbn", iden_gbn);

		return "common/iden/nice/ipin";
	}

	@RequestMapping(value = "/nice/ipin_process")
	public String checkplus_success(HttpServletRequest request, HttpSession session, Model model) {
		Map<String, String> result = new HashMap<String, String>();
		String di = null;

		/*********************************************************************************************
			NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

			서비스명 : 가상주민번호서비스 (IPIN) 서비스
			페이지명 : 가상주민번호서비스 (IPIN) 사용자 인증 정보 처리 페이지

					   수신받은 데이터(인증결과)를 메인화면으로 되돌려주고, close를 하는 역활을 합니다.
		**********************************************************************************************/

		// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다. (ipin_main.jsp 페이지에서 암호화된 데이타와는 다릅니다.)
		String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");

		// ipin_main.jsp 페이지에서 설정한 데이타가 있다면, 아래와 같이 확인가능합니다.
		String sReservedParam1  = requestReplace(request.getParameter("param_r1"), "");
		String sReservedParam2  = requestReplace(request.getParameter("param_r2"), "");
		String sReservedParam3  = requestReplace(request.getParameter("param_r3"), "");



		// 암호화된 사용자 정보가 존재하는 경우
		String sRtnMsg				= "";							// 처리결과 메세지
		if (!StringUtils.isBlank(sResponseData)) {
			/********************************************************************************************************************************************
				NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

				서비스명 : 가상주민번호서비스 (IPIN) 서비스
				페이지명 : 가상주민번호서비스 (IPIN) 결과 페이지
			*********************************************************************************************************************************************/

			String sSiteCode				= iden_nice_ipin_siteCode;			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
			String sSitePw					= iden_nice_ipin_sitePw;			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)


			// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다.
			//String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");

			// CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
			String sCPRequest = (String)session.getAttribute("CPREQUEST");


			// 객체 생성
			IPINClient pClient = new IPINClient();


			/*
			┌ 복호화 함수 설명  ──────────────────────────────────────────────────────────
				Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.

				fnResponse 함수는 결과 데이타를 복호화 하는 함수이며,
				'sCPRequest'값을 추가로 보내시면 CP요청번호 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)

				따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
			└────────────────────────────────────────────────────────────────────
			*/
			//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
			int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);

			//String sRtnMsg				= "";							// 처리결과 메세지
			String sVNumber				= pClient.getVNumber();			// 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
			String sName				= pClient.getName();			// 이름
			String sDupInfo				= pClient.getDupInfo();			// 중복가입 확인값 (DI - 64 byte 고유값)
			String sAgeCode				= pClient.getAgeCode();			// 연령대 코드 (개발 가이드 참조)
			String sGenderCode			= pClient.getGenderCode();		// 성별 코드 (개발 가이드 참조)
			String sBirthDate			= pClient.getBirthDate();		// 생년월일 (YYYYMMDD)
			String sNationalInfo		= pClient.getNationalInfo();	// 내/외국인 정보 (개발 가이드 참조)
			String sCPRequestNum		= pClient.getCPRequestNO();		// CP 요청번호

			// Method 결과값에 따른 처리사항
			if (iRtn == 1) {
				/*
					다음과 같이 사용자 정보를 추출할 수 있습니다.
					사용자에게 보여주는 정보는, '이름' 데이타만 노출 가능합니다.

					사용자 정보를 다른 페이지에서 이용하실 경우에는
					보안을 위하여 암호화 데이타(sResponseData)를 통신하여 복호화 후 이용하실것을 권장합니다. (현재 페이지와 같은 처리방식)

					만약, 복호화된 정보를 통신해야 하는 경우엔 데이타가 유출되지 않도록 주의해 주세요. (세션처리 권장)
					form 태그의 hidden 처리는 데이타 유출 위험이 높으므로 권장하지 않습니다.
				*/

				// 사용자 인증정보에 대한 변수

				if(logger.isDebugEnabled()) {
					Map<String, String> mapresult = new HashMap<String, String>();
					mapresult.put("RtnMsg", sRtnMsg);
					mapresult.put("VNumber", sVNumber);
					mapresult.put("Name", sName);
					mapresult.put("DupInfo", sDupInfo);
					mapresult.put("AgeCode", sAgeCode);
					mapresult.put("GenderCode", sGenderCode);
					mapresult.put("BirthDate", sBirthDate);
					mapresult.put("NationalInfo", sNationalInfo);
					mapresult.put("CPRequestNum", sCPRequestNum);
					logger.debug("result: {}", mapresult);
				}

				//sRtnMsg = "정상 처리되었습니다.";

			}
			else if (iRtn == -1 || iRtn == -4) sRtnMsg = "서버 환경정보를 정확히 확인하여 주시기 바랍니다.";
			else if (iRtn == -6) sRtnMsg ="당사는 한글 charset 정보를 euc-kr 로 처리하고 있으니, euc-kr 에 대해서 허용해 주시기 바랍니다.<BR>" +
					"한글 charset 정보가 명확하다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
			else if (iRtn == -9) sRtnMsg = "입력값 오류 : fnResponse 함수 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
			else if (iRtn == -12) sRtnMsg = "CP 비밀번호 불일치 : IPIN 서비스 사이트 패스워드를 확인해 주시기 바랍니다.";
			else if (iRtn == -13) sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 sCPRequest 데이타를 확인해 주시기 바랍니다.";
			else sRtnMsg = "iRtn 값 확인 후, NICE평가정보 전산 담당자에게 문의해 주세요.";


			// START 창비코드
			String name = sName;
			String birth = CommonUtil.getFormattedBirthday(sBirthDate);
			String sex = "";
			if ("0".equals(sGenderCode)) sex = "F";
			else if ("1".equals(sGenderCode)) sex = "M";
			String vnumber = sVNumber;
			di = sDupInfo;
			// END 창비코드

			result.put("name", name);
			result.put("birth", birth);
			result.put("sex", sex);
			result.put("vnumber", vnumber);
			result.put("di", di);


		} else {
			sRtnMsg = "인증정보없음";
		}

		model.addAttribute("error", sRtnMsg);
		model.addAttribute("result", result);

		// 본인인증 성공을 세션변수에 설정
		if (StringUtils.isEmpty(sRtnMsg)) {
			session.setAttribute(GlobalConst.SESSION_KEY_IDEN_DI, di);
		}

		return "common/iden/nice/ipin_result";
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

			if(gubun != "encodeData"){
				paramValue = paramValue.replaceAll("\\+", "");
				paramValue = paramValue.replaceAll("/", "");
				paramValue = paramValue.replaceAll("=", "");
			}

			result = paramValue;

		}
		return result;
	}
}
