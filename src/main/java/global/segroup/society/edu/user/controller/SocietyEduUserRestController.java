/**
 * 
 */
package global.segroup.society.edu.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.domain.CertificationCode;
import global.segroup.domain.User;
import global.segroup.service.SEGroupCommonService;
import global.segroup.society.edu.user.dao.SocietyEduUserDAO;
import global.segroup.society.edu.user.service.SocietyEduUserService;
import global.segroup.util.PathConstants;

/**
 * @Author : user
 * @Date : 2017. 8. 29.
 * @Class 설명 : 
 * 
 */
@Controller
public class SocietyEduUserRestController {
	
	
	

	private static final Logger logger = LoggerFactory.getLogger(SocietyEduUserRestController.class);
	
	private String id_merchant;
	private String no_tid;
	private String no_oid;
	private String no_vacct;
	private String amt_input;
	private String nm_inputbank;
	private String nm_input;
	//private StringBuffer times;
	
	@Autowired
	private SEGroupCommonService sgcService;
	
	@Autowired
	private SocietyEduUserDAO sdao;
	
	/**
	 * 공통 유저 관련 DAO
	 */
	@Autowired
	private SocietyEduUserService seuService;

	/**
	 * @Method Name : user_duplicated
	 * @Date : 2017. 8. 29.
	 * @User : 한진규
	 * @Param : 
	 * @Return :  중복되면 true / 중복되지 않으면 false
	 * @Method 설명 : 유저 정보가 중복하는지 검사하는 함수
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_DUPLICATED, method = RequestMethod.GET)
	public boolean user_duplicated(User user) {
		logger.debug("유저 회원 가입 아이디 중복 검사 컨트롤러 시작");
		boolean isDuplicated = seuService.user_duplicated(user);
		logger.debug("유저 회원 가입 아이디 중복 검사 컨트롤러 종료");
		return isDuplicated;
	}
	
	/**
	 * @Method Name : user_request_auth_code
	 * @Date : 2017. 10. 13.
	 * @User : 한진규
	 * @Param : 
	 * @Return : 발급됐다면 true, 아니면 false
	 * @Method 설명 : 일치하는 유저 정보가 있다면 그 정보를 가지고 와서 인증 코드를 보낸다 
	 */
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_REQUEST_CERTIFICATION_CODE, method = RequestMethod.GET)
	public int user_request_certification_code(User user, HttpSession session) {
		logger.debug("유저 회원 가입 인증 번호 발행 컨트롤러 시작");
		int requested = seuService.user_request_certification_code(user);
		
		if (requested == 0) {
			session.removeAttribute("user_id");
			session.setAttribute("user_id", user.getUser_id());
			System.out.println("유저 회원 ( "+session.getAttribute("user_id")+" ) 가입 인증 번호 발행 !");
		}
		
		logger.debug("유저 회원 가입 인증 번호 발행 컨트롤러 종료");
		return requested;
	}
	
	@ResponseBody
	@RequestMapping(value = PathConstants.SOCIETY_COM_USER_CHECK_CERTIFICATION_CODE, method = RequestMethod.GET)
	public boolean user_check_certification_code(CertificationCode code, HttpSession session) {
		logger.debug("유저 회원 가입 인증 번호 검사 컨트롤러 시작");
		String id = (String) session.getAttribute("user_id");
		code.setUser_id(id);
		boolean isRequested = seuService.user_check_certification_code(code);
		
		// 인증 성공하면 세션에 확인 추가
		if (isRequested) {
			session.setAttribute("isCertificated", isRequested);
		}
		
		logger.debug("유저 회원 가입 인증 번호 검사 컨트롤러 종료");
		return isRequested;
	}
	
	@RequestMapping(value = PathConstants.SOCIETY_EDU_USER_AFTERPAY, method = RequestMethod.POST)
	public String user_pay_after( HttpServletRequest request, HttpServletResponse response) {
		
		PrintWriter out=null;
		try {
			out = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		/*******************************************************************************
		 * FILE NAME : doVaActProc.jsp
		 * DATE : 2009.07
		 * 이니시스 가상계좌 입금내역 처리demon으로 넘어오는 파라메터를 control 하는 부분 입니다.
		 * [수신정보] 자세한 내용은 메뉴얼 참조
		 * 변수명           한글명
		 * no_tid           거래번호
		 * no_oid           주문번호
		 * cd_bank          거래발생 기관코드
		 * cd_deal          취급기관코드
		 * dt_trans         거래일자
		 * tm_trans         거래시각
		 * no_vacct         계좌번호
		 * amt_input        입금금액
		 * amt_check        미결제타점권금액
		 * flg_close        마감구분
		 * type_msg         거래구분
		 * nm_inputbank     입금은행명
		 * nm_input         입금자명
		 * dt_inputstd      입금기준일자
		 * dt_calculstd     정산기준일자
		 * dt_transbase     거래기준일자
		 * cl_trans         거래구분코드 "1100"
		 * cl_close         마감전후 구분,  0:마감점, 1마감후
		 * cl_kor           한글구분코드, 2:KSC5601
		 *
		 * (가상계좌채번시 현금영수증 자동발급신청시에만 전달)
		 * dt_cshr          현금영수증 발급일자
		 * tm_cshr          현금영수증 발급시간
		 * no_cshr_appl     현금영수증 발급번호
		 * no_cshr_tid      현금영수증 발급TID
		 *******************************************************************************/

		/***********************************************************************************
		 * 이니시스가 전달하는 가상계좌이체의 결과를 수신하여 DB 처리 하는 부분 입니다.
		 * 필요한 파라메터에 대한 DB 작업을 수행하십시오.
		 ***********************************************************************************/

		try {
			request.setCharacterEncoding("EUC-KR");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}


//		String file_path = "C:/INIpay50/vaact";
		//String file_path = "/data1/workspace/common/INIpay50/vaact";



		id_merchant = request.getParameter("id_merchant");
		no_tid 		= request.getParameter("no_tid"); 		// 거래번호
		no_oid 		= request.getParameter("no_oid"); 		// 주문번호
		no_vacct 	= request.getParameter("no_vacct"); 	// 계좌번호
		amt_input 	= request.getParameter("amt_input");	// 입금금액
		nm_inputbank = request.getParameter("nm_inputbank");// 입금은행명
		nm_input 	= request.getParameter("nm_input"); 	// 입금자명

		/*
		System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "ISO-8859-1"));
		System.out.println(new String(nm_inputbank.getBytes("ISO-8859-1"), "UTF-8"));
		System.out.println(new String(nm_inputbank.getBytes("ISO-8859-1"), "EUC-KR"));
		System.out.println(new String(nm_inputbank.getBytes("ISO-8859-1"), "ISO-8859-1"));

		System.out.println(new String(nm_inputbank.getBytes("UTF-8"), "UTF-8"));
		System.out.println(new String(nm_inputbank.getBytes("UTF-8"), "EUC-KR"));
		System.out.println(new String(nm_inputbank.getBytes("UTF-8"), "ISO-8859-1"));

		System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "UTF-8"));
		System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "EUC-KR"));
		System.out.println(new String(nm_inputbank.getBytes("EUC-KR"), "ISO-8859-1"));
		*/

		HashMap<String,String> hmParam = new HashMap<String,String>();
		hmParam.put("id_merchant", id_merchant);
		hmParam.put("p_no_tid", no_tid);
		hmParam.put("p_moid", no_oid);
		hmParam.put("p_cd_bank", request.getParameter("cd_bank"));
		hmParam.put("p_cd_deal", request.getParameter("cd_deal"));
		hmParam.put("p_dt_trans", request.getParameter("dt_trans"));
		try {
			hmParam.put("p_tm_trans", new String((request.getParameter("tm_trans")).getBytes("UTF-8"), "UTF-8"));
			hmParam.put("p_nm_inputbank", new String(nm_inputbank.getBytes("UTF-8"), "UTF-8"));
			hmParam.put("p_nm_input", new String(nm_input.getBytes("UTF-8"), "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		hmParam.put("p_no_vacct", no_vacct);
		hmParam.put("p_amt_input", amt_input);
		hmParam.put("p_amt_check", request.getParameter("amt_check"));
		hmParam.put("p_flg_close", request.getParameter("flg_close"));
		hmParam.put("p_type_msg", request.getParameter("type_msg"));
		
		hmParam.put("p_dt_inputstd", request.getParameter("dt_inputstd"));
		hmParam.put("p_dt_calculstd", request.getParameter("dt_calculstd"));
		hmParam.put("p_dt_transbase", request.getParameter("dt_transbase"));
		hmParam.put("p_cl_trans", request.getParameter("cl_trans"));
		hmParam.put("p_cl_close", request.getParameter("cl_close"));
		hmParam.put("p_cl_kor", request.getParameter("cl_kor"));
		hmParam.put("p_dt_cshr", request.getParameter("dt_cshr"));
		hmParam.put("p_tm_cshr", request.getParameter("tm_cshr"));
		hmParam.put("p_no_cshr_appl", request.getParameter("no_cshr_appl"));
		hmParam.put("p_no_cshr_tid", request.getParameter("no_cshr_tid"));

		String retMsg = null;
		try {
	       // writeLog(file_path);

			//***********************************************************************************
			//
			//	위에서 상점 데이터베이스에 등록 성공유무에 따라서 성공시에는 "OK"를 이니시스로
			//	리턴하셔야합니다. 아래 조건에 데이터베이스 성공시 받는 FLAG 변수를 넣으세요
			//	(주의) OK를 리턴하지 않으시면 이니시스 지불 서버는 "OK"를 수신할때까지 계속 재전송을 시도합니다
			//	기타 다른 형태의 out.println(response.write)는 하지 않으시기 바랍니다
			//	if (데이터베이스 등록 성공 유무 조건변수 = true)
			//  {
			//        	out.print("OK"); // 절대로 지우지 마세요
			//  }
			//***********************************************************************************

			logger.debug("가상계좌 업데이트 시작");
			logger.debug("가상계좌 업데이트 정보 {}", hmParam);
			logger.debug("가상계좌 업데이트 시작");
			
			
	        sdao.user_udate_payinfo(hmParam);
	        sdao.user_toefl_udate_payinfo(hmParam);
	        retMsg = "OK";
		

		} catch ( Exception e ) {
			retMsg = "FAILED";
			out.print(e.getMessage());
		} finally {
			out.print(retMsg); // 절대로 지우지 마세요
		}
		
		//결제 ID로 회원 ID획득
		String user_id = seuService.select_pay_user_id(no_oid);
		
		//일반 회원을 K-Move(광주) 학생으로 변경
//		HashMap<String, String> params = new HashMap<String, String>();
//		params.put("user_id", user_id);
//		params.put("user_flag", "A0106");
		
//		sgcService.updateUserFlag(params);
		
		return PathConstants.SEGROUP_SOCIETY + PathConstants.SOCIETY_EDU_USER_AFTERPAY;
	}
	
	/*private String getDate() {
		Calendar calendar = Calendar.getInstance();

		times = new StringBuffer();
		times.append(Integer.toString(calendar.get(Calendar.YEAR)));
		if ( (calendar.get(Calendar.MONTH)+1) < 10 ) {
			times.append("0");
		}

		times.append(Integer.toString(calendar.get(Calendar.MONTH)+1));
		if ( (calendar.get(Calendar.DATE)) < 10 ) {
			times.append("0");
		}

		times.append(Integer.toString(calendar.get(Calendar.DATE)));

		return times.toString();
	}*/

	/*private String getTime() {
		Calendar calendar = Calendar.getInstance();

		times = new StringBuffer();

		times.append("[");
		if ( (calendar.get(Calendar.HOUR_OF_DAY)) < 10 ) {
			times.append("0");
		}

		times.append(Integer.toString(calendar.get(Calendar.HOUR_OF_DAY)));
		times.append(":");
		if ( (calendar.get(Calendar.MINUTE)) < 10 ) {
			times.append("0");
		}

		times.append(Integer.toString(calendar.get(Calendar.MINUTE)));
		times.append(":");
		if ( (calendar.get(Calendar.SECOND)) < 10 ) {
			times.append("0");
		}

		times.append(Integer.toString(calendar.get(Calendar.SECOND)));
		times.append("]");

		return times.toString();
	}*/

	/*private void writeLog(String file_path) throws Exception {

		File file = new File(file_path);
		file.createNewFile();

		FileWriter file2 = new FileWriter(file_path+"/vacctinput_"+getDate()+".log", true);
//		FileWriter file2 = new FileWriter(file_path+"//vacctinput_"+getDate()+".log", true);


		file2.write("\n************************************************\n");
		file2.write("PageCall time : " + getTime());
		file2.write("\nID_MERCHANT : " + id_merchant);
		file2.write("\nNO_TID : " + no_tid);
		file2.write("\nNO_OID : " + no_oid);
		file2.write("\nNO_VACCT : " + no_vacct);
		file2.write("\nAMT_INPUT : " + amt_input);
		file2.write("\nNM_INPUTBANK : " + nm_inputbank);
		file2.write("\nNM_INPUT : " + nm_input);
		file2.write("\n************************************************\n");

		file2.close();
	}*/
}
