package com.aracomm.changbi.payment;

public class KcpCommonReturnParam {
	public final static String TX_CD_VANK = "TX00";		// 업무처리 구분: 가상계좌 입금 통보
	public final static String TX_CD_MBANK = "TX08";	// 업무처리 구분: 모바일계좌이체 통보
	public final static String OP_CD_WRONG_IPGM = "13";	// 잘못된 입금

	/** kcp에서 전달되는 파라메터 **/
	String site_cd		= "";	// 사이트 코드
	String tno			= "";	// KCP 거래번호
	String order_no		= "";	// 업무처리 구분 코드
	String tx_cd		= "";	// 업무처리 구분 코드
	String tx_tm		= "";	// 업무처리 완료 시간

	String ipgm_name	= "";	// 주문자명
	String remitter		= "";	// 입금자명
	String ipgm_mnyx	= "";	// 입금 금액
	String totl_mnyx 	= "";	// 가상계좌 입금 총액
	String ipgm_time  	= "";	// 가상계좌 입금 시간
	String bank_code	= "";	// 은행코드
	String account		= "";	// 가상계좌 입금계좌번호
	String op_cd		= "";	// 처리구분 코드
	String noti_id		= "";	// 통보 아이디
	String cash_a_no	= "";	// 현금영수증 승인번호
	String cash_a_dt	= "";	// 현금영수증 승인시간
	String cash_no		= "";	// 현금영수증 거래번호

	/** 사용자 추가  **/
	String appId		= "";	// 신청ID(연수신청, 교재신청)
	boolean partialPayment;		// 가상계좌  일부입금 여부
	String result		= "";	// kcp에 전달되는 코드로서 통보에 대한 정상 처리를 구분하는 코드 (0000이면 정상처리, 그 이외는 실패로 kcp에서는 다시 통보하도록 되어 있음)
	String resultMessage = "";	// 처리 메시지 (Controller에서 사용)

	public String getSite_cd() {
		return site_cd;
	}

	public void setSite_cd(String site_cd) {
		this.site_cd = site_cd;
	}


	public String getTno() {
		return tno;
	}

	public void setTno(String tno) {
		this.tno = tno;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getTx_cd() {
		return tx_cd;
	}

	public void setTx_cd(String tx_cd) {
		this.tx_cd = tx_cd;
	}

	public String getTx_tm() {
		return tx_tm;
	}

	public void setTx_tm(String tx_tm) {
		this.tx_tm = tx_tm;
	}

	public String getIpgm_name() {
		return ipgm_name;
	}

	public void setIpgm_name(String ipgm_name) {
		this.ipgm_name = ipgm_name;
	}

	public String getRemitter() {
		return remitter;
	}

	public void setRemitter(String remitter) {
		this.remitter = remitter;
	}

	public String getIpgm_mnyx() {
		return ipgm_mnyx;
	}

	public void setIpgm_mnyx(String ipgm_mnyx) {
		this.ipgm_mnyx = ipgm_mnyx;
	}

	public String getBank_code() {
		return bank_code;
	}

	public void setBank_code(String bank_code) {
		this.bank_code = bank_code;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getOp_cd() {
		return op_cd;
	}

	public void setOp_cd(String op_cd) {
		this.op_cd = op_cd;
	}

	public String getNoti_id() {
		return noti_id;
	}

	public void setNoti_id(String noti_id) {
		this.noti_id = noti_id;
	}

	public String getCash_a_no() {
		return cash_a_no;
	}

	public void setCash_a_no(String cash_a_no) {
		this.cash_a_no = cash_a_no;
	}

	public String getCash_a_dt() {
		return cash_a_dt;
	}

	public void setCash_a_dt(String cash_a_dt) {
		this.cash_a_dt = cash_a_dt;
	}

	public String getCash_no() {
		return cash_no;
	}

	public void setCash_no(String cash_no) {
		this.cash_no = cash_no;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getResultMessage() {
		return resultMessage;
	}

	public void setResultMessage(String resultMessage) {
		this.resultMessage = resultMessage;
	}


	public String getTotl_mnyx() {
		return totl_mnyx;
	}

	public void setTotl_mnyx(String totl_mnyx) {
		this.totl_mnyx = totl_mnyx;
	}

	public String getIpgm_time() {
		return ipgm_time;
	}

	public void setIpgm_time(String ipgm_time) {
		this.ipgm_time = ipgm_time;
	}


	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public boolean isPartialPayment() {
		return partialPayment;
	}

	public void setPartialPayment(boolean partialPayment) {
		this.partialPayment = partialPayment;
	}

	@Override
	public String toString() {
		return "KcpCommonReturnParam [site_cd=" + site_cd + ", tno=" + tno + ", order_no=" + order_no + ", tx_cd="
				+ tx_cd + ", tx_tm=" + tx_tm + ", ipgm_name=" + ipgm_name + ", remitter=" + remitter + ", ipgm_mnyx="
				+ ipgm_mnyx + ", totl_mnyx=" + totl_mnyx + ", ipgm_time=" + ipgm_time + ", bank_code=" + bank_code
				+ ", account=" + account + ", op_cd=" + op_cd + ", noti_id=" + noti_id + ", cash_a_no=" + cash_a_no
				+ ", cash_a_dt=" + cash_a_dt + ", cash_no=" + cash_no + ", appId=" + appId + ", partialPayment="
				+ partialPayment + ", result=" + result + ", resultMessage=" + resultMessage + "]";
	}



}
