package com.aracomm.changbi.payment.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.changbi.payment.KCPConfig;
import com.aracomm.changbi.payment.KcpCommonReturnParam;
import com.aracomm.changbi.payment.KcpPaymentParam;
import com.aracomm.changbi.payment.dao.KcpPaymentDao;
import com.kcp.J_PP_CLI_N;

@Service
public class KcpPaymentService {
	private final static String PAYREQUEST_PAY	= "pay";	// 결제요청 종류 - 승인
	private final static String PAYREQUEST_MOD	= "mod";	// 결제요청 종류 - 취소,매입
	private final static String PAY_METHOD_CARD 	= "100000000000";		// 결제수단 - 신용카드
	private final static String PAY_METHOD_BANK 	= "010000000000";		// 결제수단 - 계좌이제
	private final static String PAY_METHOD_VBANK 	= "001000000000";		// 결제수단 - 가상계좌
	private final static String PAY_METHOD_POINT 	= "000100000000";		// 결제수단 - 포인트
	private final static String PAY_METHOD_PHONE 	= "000010000000";		// 결제수단 - 휴대폰
	private final static String PAY_METHOD_GIFT 	= "000000001000";		// 결제수단 - 상품권


	@Autowired
	private KCPConfig kcpConfig;

	@Autowired
	private KcpPaymentDao kcpPaymentDao;

	/**
	 * KCP 승인요청
	 * @param kcpPaymentParam
	 * @return
	 */
	public KcpPaymentParam requestApproval(KcpPaymentParam kcpPaymentParam) {
		// 계좌이체,가상계좌,카드,휴대폰 요청만 허용
		if ( !PAY_METHOD_CARD.equals(kcpPaymentParam.getUse_pay_method()) &&
				!PAY_METHOD_BANK.equals(kcpPaymentParam.getUse_pay_method()) &&
				!PAY_METHOD_VBANK.equals(kcpPaymentParam.getUse_pay_method()) &&
				!PAY_METHOD_PHONE.equals(kcpPaymentParam.getUse_pay_method()) ) {
			throw new InvalidAccessException("invalid payment type: "+kcpPaymentParam.getUse_pay_method());
		}

	    /* ============================================================================== */
	    /* =   03. 인스턴스 생성 및 초기화(변경 불가)                                   = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =       결제에 필요한 인스턴스를 생성하고 초기화 합니다.                     = */
	    /* = -------------------------------------------------------------------------- = */
	    J_PP_CLI_N c_PayPlus = new J_PP_CLI_N();

	    c_PayPlus.mf_init( "", kcpConfig.getG_conf_gw_url(), kcpConfig.getG_conf_gw_port(), kcpConfig.getG_conf_tx_mode(), kcpConfig.getG_conf_log_dir() );
	    c_PayPlus.mf_init_set();

	    /* ============================================================================== */
	    /* =   03. 인스턴스 생성 및 초기화 END                                          = */
	    /* ============================================================================== */


	    /* ============================================================================== */
	    /* =   04. 처리 요청 정보 설정                                                  = */
	    /* = -------------------------------------------------------------------------- = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =   04-1. 승인 요청 정보 설정                                                = */
	    /* = -------------------------------------------------------------------------- = */
	    if ( PAYREQUEST_PAY.equals(kcpPaymentParam.getReq_tx()) )
	    {
	            c_PayPlus.mf_set_enc_data( f_get_parm( kcpPaymentParam.getEnc_data() ),
	                                       f_get_parm( kcpPaymentParam.getEnc_info() ) );

	            /* 1 원은 실제로 업체에서 결제하셔야 될 원 금액을 넣어주셔야 합니다. 결제금액 유효성 검증 */

	            int ordr_data_set_no;

	            ordr_data_set_no = c_PayPlus.mf_add_set( "ordr_data" );

	            c_PayPlus.mf_set_us( ordr_data_set_no, "ordr_mony", kcpPaymentParam.getGood_mny() );

	    }
	    /* = -------------------------------------------------------------------------- = */
	    /* =   04. 처리 요청 정보 설정 END                                              = */
	    /* = ========================================================================== = */


	    /* = ========================================================================== = */
	    /* =   05. 실행                                                                 = */
	    /* = -------------------------------------------------------------------------- = */
	    String tran_cd = kcpPaymentParam.getTran_cd();
	    if ( tran_cd != null && tran_cd.trim().length() > 0 )
	    {
	        c_PayPlus.mf_do_tx( kcpConfig.getG_conf_site_cd(), kcpConfig.getG_conf_site_key(), kcpPaymentParam.getTran_cd(), "", kcpPaymentParam.getOrdr_idxx(), kcpConfig.getG_conf_log_level(), "0" );
	    }
	    else
	    {
	        c_PayPlus.m_res_cd  = "9562";
	        c_PayPlus.m_res_msg = "연동 오류|tran_cd값이 설정되지 않았습니다.";
	    }

	    kcpPaymentParam.setRes_cd(c_PayPlus.m_res_cd);		// 결과 코드
	    kcpPaymentParam.setRes_msg(c_PayPlus.m_res_msg);	// 결과 메시지

	    /* = -------------------------------------------------------------------------- = */
	    /* =   05. 실행 END                                                             = */
	    /* ============================================================================== */


	    /* ============================================================================== */
	    /* =   06. 승인 결과 값 추출                                                    = */
	    /* = -------------------------------------------------------------------------- = */
	    if ( PAYREQUEST_PAY.equals(kcpPaymentParam.getReq_tx()) )
	    {
	        if ( KcpPaymentParam.RESULT_SUCCESS.equals(kcpPaymentParam.getRes_cd()) )
	        {
	        	kcpPaymentParam.setTno(c_PayPlus.mf_get_res( "tno" )); 				// KCP 거래 고유 번호
	        	kcpPaymentParam.setAmount(c_PayPlus.mf_get_res( "amount" )); 		// KCP 실제 거래 금액
	        	kcpPaymentParam.setPnt_issue(c_PayPlus.mf_get_res( "pnt_issue" )); 	// 결제 포인트사 코드
	        	kcpPaymentParam.setCoupon_mny(c_PayPlus.mf_get_res( "coupon_mny" ));// 쿠폰금액

	    /* = -------------------------------------------------------------------------- = */
	    /* =   06-1. 신용카드 승인 결과 처리                                            = */
	    /* = -------------------------------------------------------------------------- = */
				if ( PAY_METHOD_CARD.equals(kcpPaymentParam.getUse_pay_method()) )
				{
					kcpPaymentParam.setCard_cd( c_PayPlus.mf_get_res( "card_cd"   ) ); // 카드사 코드
					kcpPaymentParam.setCard_name( c_PayPlus.mf_get_res( "card_name" ) ); // 카드사 명
					kcpPaymentParam.setApp_time( c_PayPlus.mf_get_res( "app_time"  ) ); // 승인시간
					kcpPaymentParam.setApp_no( c_PayPlus.mf_get_res( "app_no"    ) ); // 승인번호
					kcpPaymentParam.setNoinf( c_PayPlus.mf_get_res( "noinf"     ) ); // 무이자 여부
					kcpPaymentParam.setQuota( c_PayPlus.mf_get_res( "quota"     ) ); // 할부 개월 수
					kcpPaymentParam.setPartcanc_yn( c_PayPlus.mf_get_res( "partcanc_yn"     ) ); // 부분취소 가능유무
					kcpPaymentParam.setCard_bin_type_01( c_PayPlus.mf_get_res( "card_bin_type_01" ) ); // 카드구분1
					kcpPaymentParam.setCard_bin_type_02( c_PayPlus.mf_get_res( "card_bin_type_02" ) ); // 카드구분2
					kcpPaymentParam.setCard_mny( c_PayPlus.mf_get_res( "card_mny" ) ); // 카드결제금액

					/* = -------------------------------------------------------------- = */
					/* =   06-1.1. 복합결제(포인트+신용카드) 승인 결과 처리             = */
					/* = -------------------------------------------------------------- = */
					if ( "SCSK".equals(kcpPaymentParam.getPnt_issue()) || "SCWB".equals(kcpPaymentParam.getPnt_issue()) )
					{
						kcpPaymentParam.setPnt_amount( c_PayPlus.mf_get_res( "pnt_amount"   ) ); // 적립금액 or 사용금액
						kcpPaymentParam.setPnt_app_time( c_PayPlus.mf_get_res( "pnt_app_time" ) ); // 승인시간
						kcpPaymentParam.setPnt_app_no( c_PayPlus.mf_get_res( "pnt_app_no"   ) ); // 승인번호
						kcpPaymentParam.setAdd_pnt( c_PayPlus.mf_get_res( "add_pnt"      ) ); // 발생 포인트
						kcpPaymentParam.setUse_pnt( c_PayPlus.mf_get_res( "use_pnt"      ) ); // 사용가능 포인트
						kcpPaymentParam.setRsv_pnt( c_PayPlus.mf_get_res( "rsv_pnt"      ) ); // 총 누적 포인트
						kcpPaymentParam.setTotal_amount( String.valueOf(Integer.valueOf(kcpPaymentParam.getAmount()) + Integer.valueOf(kcpPaymentParam.getPnt_amount())) );                    // 복합결제시 총 거래금액
					}
				}

		/* = -------------------------------------------------------------------------- = */
		/* =   06-2. 계좌이체 승인 결과 처리                                            = */
		/* = -------------------------------------------------------------------------- = */
				if ( PAY_METHOD_BANK.equals(kcpPaymentParam.getUse_pay_method()) )
				{
					kcpPaymentParam.setApp_time( c_PayPlus.mf_get_res( "app_time"  ) ); // 승인시간
					kcpPaymentParam.setBank_name( c_PayPlus.mf_get_res( "bank_name" ) ); // 은행명
					kcpPaymentParam.setBank_code( c_PayPlus.mf_get_res( "bank_code" ) ); // 은행코드
					kcpPaymentParam.setBk_mny( c_PayPlus.mf_get_res( "bk_mny"    ) ); // 계좌이체결제금액
				}

		/* = -------------------------------------------------------------------------- = */
		/* =   06-3. 가상계좌 승인 결과 처리                                            = */
		/* = -------------------------------------------------------------------------- = */
				if ( PAY_METHOD_VBANK.equals(kcpPaymentParam.getUse_pay_method()) )
				{
					kcpPaymentParam.setBankname( c_PayPlus.mf_get_res( "bankname"  ) ); // 입금할 은행 이름
					kcpPaymentParam.setDepositor( c_PayPlus.mf_get_res( "depositor" ) ); // 입금할 계좌 예금주
					kcpPaymentParam.setAccount( c_PayPlus.mf_get_res( "account"   ) ); // 입금할 계좌 번호
					kcpPaymentParam.setVa_date( c_PayPlus.mf_get_res( "va_date"   ) ); // 가상계좌 입금마감시간
				}

		/* = -------------------------------------------------------------------------- = */
		/* =   06-4. 포인트 승인 결과 처리                                              = */
		/* = -------------------------------------------------------------------------- = */
				if ( PAY_METHOD_POINT.equals(kcpPaymentParam.getUse_pay_method()) )
				{
					kcpPaymentParam.setPnt_amount( c_PayPlus.mf_get_res( "pnt_amount"   ) ); // 적립금액 or 사용금액
					kcpPaymentParam.setPnt_app_time( c_PayPlus.mf_get_res( "pnt_app_time" ) ); // 승인시간
					kcpPaymentParam.setPnt_app_no( c_PayPlus.mf_get_res( "pnt_app_no"   ) ); // 승인번호
					kcpPaymentParam.setAdd_pnt( c_PayPlus.mf_get_res( "add_pnt"      ) ); // 발생 포인트
					kcpPaymentParam.setUse_pnt( c_PayPlus.mf_get_res( "use_pnt"      ) ); // 사용가능 포인트
					kcpPaymentParam.setRsv_pnt( c_PayPlus.mf_get_res( "rsv_pnt"      ) ); // 총 누적 포인트
				}

		/* = -------------------------------------------------------------------------- = */
		/* =   06-5. 휴대폰 승인 결과 처리                                              = */
		/* = -------------------------------------------------------------------------- = */
				if ( PAY_METHOD_PHONE.equals(kcpPaymentParam.getUse_pay_method()) )
				{
					kcpPaymentParam.setApp_time( c_PayPlus.mf_get_res( "hp_app_time" ) ); // 승인 시간
					kcpPaymentParam.setCommid( c_PayPlus.mf_get_res( "commid"      ) ); // 통신사 코드
					kcpPaymentParam.setMobile_no( c_PayPlus.mf_get_res( "mobile_no"   ) ); // 휴대폰 번호
				}

		/* = -------------------------------------------------------------------------- = */
		/* =   06-6. 상품권 승인 결과 처리                                              = */
		/* = -------------------------------------------------------------------------- = */
				if ( PAY_METHOD_GIFT.equals(kcpPaymentParam.getUse_pay_method()) )
				{
					kcpPaymentParam.setApp_time( c_PayPlus.mf_get_res( "tk_app_time" ) ); // 승인 시간
					kcpPaymentParam.setTk_van_code( c_PayPlus.mf_get_res( "tk_van_code" ) ); // 발급사 코드
					kcpPaymentParam.setTk_app_no( c_PayPlus.mf_get_res( "tk_app_no"   ) ); // 승인 번호
				}

		/* = -------------------------------------------------------------------------- = */
		/* =   06-7. 현금영수증 승인 결과 처리                                          = */
		/* = -------------------------------------------------------------------------- = */
				kcpPaymentParam.setCash_authno( c_PayPlus.mf_get_res( "cash_authno" ) ); // 현금영수증 승인번호
				kcpPaymentParam.setCash_no( c_PayPlus.mf_get_res( "cash_no"     ) ); // 현금영수증 거래번호
			}
		}
	    /* = -------------------------------------------------------------------------- = */
	    /* =   06. 승인 결과 처리 END                                                   = */
	    /* ============================================================================== */


	    /* = ========================================================================== = */
	    /* =   07. 승인 및 실패 결과 DB 처리                                            = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =      결과를 업체 자체적으로 DB 처리 작업하시는 부분입니다.                 = */
	    /* = -------------------------------------------------------------------------- = */

	    // 승인결과 DB저장 등 이하 다른 곳에서 처리 함

	    return kcpPaymentParam;
	}

	/**
	 * KCP 승인이 성공이지만 DB저장이 실패하였을 경우 승인취소
	 * @param kcpPaymentParam
	 * @return
	 */
	public KcpPaymentParam requestCancelApproval(KcpPaymentParam kcpPaymentParam) {

		if (!PAYREQUEST_PAY.equals(kcpPaymentParam.getReq_tx()) || !KcpPaymentParam.RESULT_SUCCESS.equals(kcpPaymentParam.getRes_cd())) {
			throw new InvalidAccessException("only successed pay can be canceled");
		}
	    /* = ========================================================================== = */
	    /* =   08. 승인 결과 DB 처리 실패시 : 자동취소                                  = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =      승인 결과를 DB 작업 하는 과정에서 정상적으로 승인된 건에 대해         = */
	    /* =      DB 작업을 실패하여 DB update 가 완료되지 않은 경우, 자동으로          = */
	    /* =      승인 취소 요청을 하는 프로세스가 구성되어 있습니다.                   = */
	    /* =                                                                            = */
	    /* =      DB 작업이 실패 한 경우, bSucc 라는 변수(String)의 값을 "false"        = */
	    /* =      로 설정해 주시기 바랍니다. (DB 작업 성공의 경우에는 "false" 이외의    = */
	    /* =      값을 설정하시면 됩니다.)                                              = */
	    /* = -------------------------------------------------------------------------- = */
		J_PP_CLI_N c_PayPlus = new J_PP_CLI_N();

	    // 승인 결과 DB 처리 에러시 bSucc값을 false로 설정하여 거래건을 취소 요청
        int mod_data_set_no;

        c_PayPlus.mf_init_set();

        String tran_cd = "00200000";
        kcpPaymentParam.setTran_cd(tran_cd);

        mod_data_set_no = c_PayPlus.mf_add_set( "mod_data" );

        c_PayPlus.mf_set_us( mod_data_set_no, "tno",      kcpPaymentParam.getTno()      ); // KCP 원거래 거래번호
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_type", "STSC"   ); // 원거래 변경 요청 종류
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_ip",   kcpPaymentParam.getCust_ip()  ); // 변경 요청자 IP
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_desc", "가맹점 결과 처리 오류 - 가맹점에서 취소 요청"  ); // 변경 사유

        c_PayPlus.mf_do_tx( kcpConfig.getG_conf_site_cd(), kcpConfig.getG_conf_site_key(), tran_cd, "", kcpPaymentParam.getOrdr_idxx(), kcpConfig.getG_conf_log_level(), "0" );

        kcpPaymentParam.setRes_cd( c_PayPlus.m_res_cd );                                 // 결과 코드
        kcpPaymentParam.setRes_msg( c_PayPlus.m_res_msg );                                // 결과 메시지

	    return kcpPaymentParam;
	}


	public int applyCommonReturn(KcpCommonReturnParam kcpCommonReturnParam, KcpCommonReturnSavableService service) {
		int affected = 0;
	    /* ============================================================================== */
	    /* =   03. 공통 통보 결과를 업체 자체적으로 DB 처리 작업하시는 부분입니다.      = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =   통보 결과를 DB 작업 하는 과정에서 정상적으로 통보된 건에 대해 DB 작업에  = */
	    /* =   실패하여 DB update 가 완료되지 않은 경우, 결과를 재통보 받을 수 있는     = */
	    /* =   프로세스가 구성되어 있습니다.                                            = */
	    /* =                                                                            = */
	    /* =   * DB update가 정상적으로 완료된 경우                                     = */
	    /* =   하단의 [04. result 값 세팅 하기] 에서 result 값의 value값을 0000으로     = */
	    /* =   설정해 주시기 바랍니다.                                                  = */
	    /* =                                                                            = */
	    /* =   * DB update가 실패한 경우                                                = */
	    /* =   하단의 [04. result 값 세팅 하기] 에서 result 값의 value값을 0000이외의   = */
	    /* =   값으로 설정해 주시기 바랍니다.                                           = */
	    /* = -------------------------------------------------------------------------- = */

	    /* = -------------------------------------------------------------------------- = */
	    /* =   03-1. 가상계좌 입금 통보 데이터 DB 처리 작업 부분                        = */
	    /* = -------------------------------------------------------------------------- = */
	    if ( kcpCommonReturnParam.TX_CD_VANK.equals(kcpCommonReturnParam.getTx_cd()) )
	    {
	    	affected = service.updateVbankReturn(kcpCommonReturnParam);
	    }


	    /* = -------------------------------------------------------------------------- = */
	    /* =   03-2. 모바일계좌이체 통보 데이터 DB 처리 작업 부분                       = */
	    /* = -------------------------------------------------------------------------- = */
	    else if ( kcpCommonReturnParam.TX_CD_MBANK.equals(kcpCommonReturnParam.getTx_cd()) )
	    {
	    }
	    /* ============================================================================== */

	    /* ============================================================================== */
	    /* =   04. result 값 세팅 하기                                                  = */
	    /* = -------------------------------------------------------------------------- = */
	    /* =   정상적으로 처리된 경우 value값을 0000으로 설정하여 주시기 바랍니다.      = */
	    /* ============================================================================== */

	    return affected;
	}



	/**
	 * KCP 결제내역 정보 등록
	 * @param kcpPaymentParam
	 * @return
	 */
	public int insertKcpPayment(KcpPaymentParam kcpPaymentParam) {
		return kcpPaymentDao.insertKcpPayment(kcpPaymentParam);
	}

	/**
	 * 거래번호로 가상계좌 결제 내역 조회
	 * @param tno
	 * @return
	 */
	public Map<String, Object> selectVankKcpPaymentByTno(String tno) {
		return kcpPaymentDao.selectVankKcpPaymentByTno(tno);
	}

	private String f_get_parm( String val ) {
      if ( val == null ) val = "";
      return  val;
    }

	public Map<String, Object> selectApplyByOrderIdx(String ordr_idxx) {
		return kcpPaymentDao.selectApplyByOrderIdx(ordr_idxx);
	}


}
