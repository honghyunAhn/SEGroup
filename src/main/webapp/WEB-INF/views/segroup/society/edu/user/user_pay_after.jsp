
<%@ page  contentType="text/html; charset=utf-8" %><%@
	page import = "java.io.*" %><%@
	page import ="java.util.ArrayList"%><%@
	page import ="java.util.LinkedList"%><%@
	page import ="java.util.HashMap"%><%@
	page import = "java.util.Calendar" %> <%@
	page import ="global.segroup.society.edu.user.dao.SocietyEduUserDAO;" %> <%
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

	request.setCharacterEncoding("EUC-KR");


//	String file_path = "C:/INIpay50/vaact";
	String file_path = "/data1/workspace/common/INIpay50/vaact";



	id_merchant = request.getParameter("id_merchant");
	no_tid 		= request.getParameter("tid"); 		// 거래번호
	no_oid 		= request.getParameter("moid"); 		// 주문번호
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
	hmParam.put("p_tm_trans", new String((request.getParameter("tm_trans")).getBytes("UTF-8"), "UTF-8"));
	hmParam.put("p_no_vacct", no_vacct);
	hmParam.put("p_amt_input", amt_input);
	hmParam.put("p_amt_check", request.getParameter("amt_check"));
	hmParam.put("p_flg_close", request.getParameter("flg_close"));
	hmParam.put("p_type_msg", request.getParameter("type_msg"));
	hmParam.put("p_nm_inputbank", new String(nm_inputbank.getBytes("UTF-8"), "UTF-8"));
	hmParam.put("p_nm_input", new String(nm_input.getBytes("UTF-8"), "UTF-8"));
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
	SocietyEduUserDAO sdao=new SocietyEduUserDAO();
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

        sdao.user_udate_payinfo(hmParam);
        sdao.user_toefl_udate_payinfo(hmParam);
        retMsg = "OK";
	

	} catch ( Exception e ) {
		retMsg = "FAILED";
		out.print(e.getMessage());
	} finally {
		out.print(retMsg); // 절대로 지우지 마세요
	}
%>
<%!
	private String id_merchant;
	private String no_tid;
	private String no_oid;
	private String no_vacct;
	private String amt_input;
	private String nm_inputbank;
	private String nm_input;
	private StringBuffer times;

	private String getDate() {
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
	}

	private String getTime() {
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
	}

	private void writeLog(String file_path) throws Exception {

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
	}
%>