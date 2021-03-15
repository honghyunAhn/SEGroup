package com.aracomm.changbi.payment;

/**
 * KCP결재내역 정보 bean
 * @author Park
 *
 */
public class KcpPaymentParam {
	public final static String RESULT_SUCCESS = "0000";
	public final static String BSUCC_SUCCESS = "true";
	public final static String BSUCC_FAIL = "fale";

	/* ============================================================================== */
	/* =   02. 지불 요청 정보 설정                                                  = */
	/* = -------------------------------------------------------------------------- = */
	String req_tx;						// 요청 종류
	String tran_cd;						// 처리 종류
	/* = -------------------------------------------------------------------------- = */
	String cust_ip;						// 요청 IP
	String ordr_idxx;					// 쇼핑몰 주문번호
	String good_name;					// 상품명
	/* = -------------------------------------------------------------------------- = */
	String res_cd;						// 응답코드
	String res_msg;						// 응답 메세지
	String tno;							// KCP 거래 고유 번호
	/* = -------------------------------------------------------------------------- = */
	String buyr_name;					// 주문자명
	String buyr_tel1;					// 주문자 전화번호
	String buyr_tel2;					// 주문자 핸드폰 번호
	String buyr_mail;					// 주문자 E-mail 주소
	/* = -------------------------------------------------------------------------- = */
	String use_pay_method;				// 결제 방법
	String bsucc;						// 업체 DB 처리 성공 여부
	/* = -------------------------------------------------------------------------- = */
	String app_time;					// 승인시간 (모든 결제 수단 공통)
	String amount;						// KCP 실제 거래금액
	String total_amount;				// 복합결제시 총 거래금액
	String coupon_mny;					// 쿠폰금액
	/* = -------------------------------------------------------------------------- = */
	String card_cd;						// 신용카드 코드
	String card_name;					// 신용카드 명
	String app_no;						// 신용카드 승인번호
	String noinf;						// 신용카드 무이자 여부
	String quota;						// 신용카드 할부개월
	String partcanc_yn;					// 부분취소 가능유무
	String card_bin_type_01;			// 카드구분1
	String card_bin_type_02;			// 카드구분2
	String card_mny;					// 카드결제금액
	/* = -------------------------------------------------------------------------- = */
	String bank_name;					// 은행명
	String bank_code;					// 은행코드
	String bk_mny;						// 계좌이체결제금액
	/* = -------------------------------------------------------------------------- = */
	String bankname;					// 입금 은행명
	String depositor;					// 입금 계좌 예금주 성명
	String account;						// 입금 계좌 번호
	String va_date;						// 가상계좌 입금마감시간
	/* = -------------------------------------------------------------------------- = */
	String pnt_issue;					// 결제 포인트사 코드
	String pnt_amount;					// 적립금액 or 사용금액
	String pnt_app_time;				// 승인시간
	String pnt_app_no;					// 승인번호
	String add_pnt;						// 발생 포인트
	String use_pnt;						// 사용가능 포인트
	String rsv_pnt;						// 총 누적 포인트
	/* = -------------------------------------------------------------------------- = */
	String commid;						// 통신사코드
	String mobile_no;					// 휴대폰번호
	/* = -------------------------------------------------------------------------- = */
	String shop_user_id;				// 가맹점 고객 아이디
	String tk_van_code;					// 발급사코드
	String tk_app_no;					// 승인번호
	/* = -------------------------------------------------------------------------- = */
	String cash_yn;						// 현금 영수증 등록 여부
	String cash_authno;					// 현금 영수증 승인 번호
	String cash_tr_code;				// 현금 영수증 발행 구분
	String cash_id_info;				// 현금 영수증 등록 번호
	String cash_no;						// 현금 영수증 거래 번호

	/* = -------------------------------------------------------------------------- = */
	private String enc_info;
	private String enc_data;
	/* = -------------------------------------------------------------------------- = */

	/* ============================================================================== */
	/* =   02. 지불 요청 정보 설정 END
	/* ============================================================================== */

	/* ============================================================================== */
	/* =   업체 추가 변수
	/* ============================================================================== */
	private String good_mny;		// 업체 결제요청금액 (승인시 업체 주문금액과 승인요청금액 불일치 비교를 위해 사용)
	private String reg_user;		// 등록자아이디

	public String getReq_tx() {
		return req_tx;
	}
	public void setReq_tx(String req_tx) {
		this.req_tx = req_tx;
	}
	public String getTran_cd() {
		return tran_cd;
	}
	public void setTran_cd(String tran_cd) {
		this.tran_cd = tran_cd;
	}
	public String getCust_ip() {
		return cust_ip;
	}
	public void setCust_ip(String cust_ip) {
		this.cust_ip = cust_ip;
	}
	public String getOrdr_idxx() {
		return ordr_idxx;
	}
	public void setOrdr_idxx(String ordr_idxx) {
		this.ordr_idxx = ordr_idxx;
	}
	public String getGood_name() {
		return good_name;
	}
	public void setGood_name(String good_name) {
		this.good_name = good_name;
	}
	public String getRes_cd() {
		return res_cd;
	}
	public void setRes_cd(String res_cd) {
		this.res_cd = res_cd;
	}
	public String getRes_msg() {
		return res_msg;
	}
	public void setRes_msg(String res_msg) {
		this.res_msg = res_msg;
	}
	public String getTno() {
		return tno;
	}
	public void setTno(String tno) {
		this.tno = tno;
	}
	public String getBuyr_name() {
		return buyr_name;
	}
	public void setBuyr_name(String buyr_name) {
		this.buyr_name = buyr_name;
	}
	public String getBuyr_tel1() {
		return buyr_tel1;
	}
	public void setBuyr_tel1(String buyr_tel1) {
		this.buyr_tel1 = buyr_tel1;
	}
	public String getBuyr_tel2() {
		return buyr_tel2;
	}
	public void setBuyr_tel2(String buyr_tel2) {
		this.buyr_tel2 = buyr_tel2;
	}
	public String getBuyr_mail() {
		return buyr_mail;
	}
	public void setBuyr_mail(String buyr_mail) {
		this.buyr_mail = buyr_mail;
	}
	public String getUse_pay_method() {
		return use_pay_method;
	}
	public void setUse_pay_method(String use_pay_method) {
		this.use_pay_method = use_pay_method;
	}
	public String getBsucc() {
		return bsucc;
	}
	public void setBsucc(String bsucc) {
		this.bsucc = bsucc;
	}
	public String getApp_time() {
		return app_time;
	}
	public void setApp_time(String app_time) {
		this.app_time = app_time;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(String total_amount) {
		this.total_amount = total_amount;
	}
	public String getCoupon_mny() {
		return coupon_mny;
	}
	public void setCoupon_mny(String coupon_mny) {
		this.coupon_mny = coupon_mny;
	}
	public String getCard_cd() {
		return card_cd;
	}
	public void setCard_cd(String card_cd) {
		this.card_cd = card_cd;
	}
	public String getCard_name() {
		return card_name;
	}
	public void setCard_name(String card_name) {
		this.card_name = card_name;
	}
	public String getApp_no() {
		return app_no;
	}
	public void setApp_no(String app_no) {
		this.app_no = app_no;
	}
	public String getNoinf() {
		return noinf;
	}
	public void setNoinf(String noinf) {
		this.noinf = noinf;
	}
	public String getQuota() {
		return quota;
	}
	public void setQuota(String quota) {
		this.quota = quota;
	}
	public String getPartcanc_yn() {
		return partcanc_yn;
	}
	public void setPartcanc_yn(String partcanc_yn) {
		this.partcanc_yn = partcanc_yn;
	}
	public String getCard_bin_type_01() {
		return card_bin_type_01;
	}
	public void setCard_bin_type_01(String card_bin_type_01) {
		this.card_bin_type_01 = card_bin_type_01;
	}
	public String getCard_bin_type_02() {
		return card_bin_type_02;
	}
	public void setCard_bin_type_02(String card_bin_type_02) {
		this.card_bin_type_02 = card_bin_type_02;
	}
	public String getCard_mny() {
		return card_mny;
	}
	public void setCard_mny(String card_mny) {
		this.card_mny = card_mny;
	}
	public String getBank_name() {
		return bank_name;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public String getBank_code() {
		return bank_code;
	}
	public void setBank_code(String bank_code) {
		this.bank_code = bank_code;
	}
	public String getBk_mny() {
		return bk_mny;
	}
	public void setBk_mny(String bk_mny) {
		this.bk_mny = bk_mny;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	public String getDepositor() {
		return depositor;
	}
	public void setDepositor(String depositor) {
		this.depositor = depositor;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getVa_date() {
		return va_date;
	}
	public void setVa_date(String va_date) {
		this.va_date = va_date;
	}
	public String getPnt_issue() {
		return pnt_issue;
	}
	public void setPnt_issue(String pnt_issue) {
		this.pnt_issue = pnt_issue;
	}
	public String getPnt_amount() {
		return pnt_amount;
	}
	public void setPnt_amount(String pnt_amount) {
		this.pnt_amount = pnt_amount;
	}
	public String getPnt_app_time() {
		return pnt_app_time;
	}
	public void setPnt_app_time(String pnt_app_time) {
		this.pnt_app_time = pnt_app_time;
	}
	public String getPnt_app_no() {
		return pnt_app_no;
	}
	public void setPnt_app_no(String pnt_app_no) {
		this.pnt_app_no = pnt_app_no;
	}
	public String getAdd_pnt() {
		return add_pnt;
	}
	public void setAdd_pnt(String add_pnt) {
		this.add_pnt = add_pnt;
	}
	public String getUse_pnt() {
		return use_pnt;
	}
	public void setUse_pnt(String use_pnt) {
		this.use_pnt = use_pnt;
	}
	public String getRsv_pnt() {
		return rsv_pnt;
	}
	public void setRsv_pnt(String rsv_pnt) {
		this.rsv_pnt = rsv_pnt;
	}
	public String getCommid() {
		return commid;
	}
	public void setCommid(String commid) {
		this.commid = commid;
	}
	public String getMobile_no() {
		return mobile_no;
	}
	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}
	public String getShop_user_id() {
		return shop_user_id;
	}
	public void setShop_user_id(String shop_user_id) {
		this.shop_user_id = shop_user_id;
	}
	public String getTk_van_code() {
		return tk_van_code;
	}
	public void setTk_van_code(String tk_van_code) {
		this.tk_van_code = tk_van_code;
	}
	public String getTk_app_no() {
		return tk_app_no;
	}
	public void setTk_app_no(String tk_app_no) {
		this.tk_app_no = tk_app_no;
	}
	public String getCash_yn() {
		return cash_yn;
	}
	public void setCash_yn(String cash_yn) {
		this.cash_yn = cash_yn;
	}
	public String getCash_authno() {
		return cash_authno;
	}
	public void setCash_authno(String cash_authno) {
		this.cash_authno = cash_authno;
	}
	public String getCash_tr_code() {
		return cash_tr_code;
	}
	public void setCash_tr_code(String cash_tr_code) {
		this.cash_tr_code = cash_tr_code;
	}
	public String getCash_id_info() {
		return cash_id_info;
	}
	public void setCash_id_info(String cash_id_info) {
		this.cash_id_info = cash_id_info;
	}
	public String getCash_no() {
		return cash_no;
	}
	public void setCash_no(String cash_no) {
		this.cash_no = cash_no;
	}
	public String getEnc_info() {
		return enc_info;
	}
	public void setEnc_info(String enc_info) {
		this.enc_info = enc_info;
	}
	public String getEnc_data() {
		return enc_data;
	}
	public void setEnc_data(String enc_data) {
		this.enc_data = enc_data;
	}
	public String getGood_mny() {
		return good_mny;
	}
	public void setGood_mny(String good_mny) {
		this.good_mny = good_mny;
	}
	public String getReg_user() {
		return reg_user;
	}
	public void setReg_user(String reg_user) {
		this.reg_user = reg_user;
	}
	@Override
	public String toString() {
		return "KcpPaymentParam [req_tx=" + req_tx + ", tran_cd=" + tran_cd + ", cust_ip=" + cust_ip + ", ordr_idxx="
				+ ordr_idxx + ", good_name=" + good_name + ", res_cd=" + res_cd + ", res_msg=" + res_msg + ", tno="
				+ tno + ", buyr_name=" + buyr_name + ", buyr_tel1=" + buyr_tel1 + ", buyr_tel2=" + buyr_tel2
				+ ", buyr_mail=" + buyr_mail + ", use_pay_method=" + use_pay_method + ", bsucc=" + bsucc + ", app_time="
				+ app_time + ", amount=" + amount + ", total_amount=" + total_amount + ", coupon_mny=" + coupon_mny
				+ ", card_cd=" + card_cd + ", card_name=" + card_name + ", app_no=" + app_no + ", noinf=" + noinf
				+ ", quota=" + quota + ", partcanc_yn=" + partcanc_yn + ", card_bin_type_01=" + card_bin_type_01
				+ ", card_bin_type_02=" + card_bin_type_02 + ", card_mny=" + card_mny + ", bank_name=" + bank_name
				+ ", bank_code=" + bank_code + ", bk_mny=" + bk_mny + ", bankname=" + bankname + ", depositor="
				+ depositor + ", account=" + account + ", va_date=" + va_date + ", pnt_issue=" + pnt_issue
				+ ", pnt_amount=" + pnt_amount + ", pnt_app_time=" + pnt_app_time + ", pnt_app_no=" + pnt_app_no
				+ ", add_pnt=" + add_pnt + ", use_pnt=" + use_pnt + ", rsv_pnt=" + rsv_pnt + ", commid=" + commid
				+ ", mobile_no=" + mobile_no + ", shop_user_id=" + shop_user_id + ", tk_van_code=" + tk_van_code
				+ ", tk_app_no=" + tk_app_no + ", cash_yn=" + cash_yn + ", cash_authno=" + cash_authno
				+ ", cash_tr_code=" + cash_tr_code + ", cash_id_info=" + cash_id_info + ", cash_no=" + cash_no
				+ ", enc_info=" + enc_info + ", enc_data=" + enc_data + ", good_mny=" + good_mny + ", reg_user="
				+ reg_user + "]";
	}


}
