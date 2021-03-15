/**
 * 
 */
package global.segroup.society.edu.user.domain;

/**
 * @Author : 전상수
 * @Date : 2017. 12. 14.
 * @Class 설명 : 결제정보를 담는 객체
 * 
 */
public class Payment {

	private String pay_product_name;// 결제명

	private String pay_user_seq; // 결제 시퀀스

	private String pay_crc_seq;// 결제 정보 시퀀스

	private String pay_user_type; // 결제 타입

	private String pay_user_status; // 결제 상태

	private String pay_user_id; // 결제자 id

	private String pay_user_accname;// 결제 졔좌 예금주

	private String pay_user_accnum; // 결제 계좌번호 (무통장입금 신청시)

	private String pay_user_bankno;// 결제 은행 코드

	private String pay_user_method; // 결제방법

	private String pay_user_tid; // 거래번호

	private String pay_user_moid; // 상점주문번호

	private String pay_sell_name; // 이니시스 결제 제품명

	private String pay_rtn_data; // 이니시스 리턴데이터

	private String pay_ins_dt;// 결제일

	/**
	 * @Desc :
	 * @param pay_user_seq
	 * @param pay_crc_seq
	 * @param pay_user_type
	 * @param pay_user_status
	 * @param pay_user_id
	 * @param pay_user_accname
	 * @param pay_user_accnum
	 * @param pay_user_bankno
	 * @param pay_user_method
	 * @param pay_user_tid
	 * @param pay_user_moid
	 * @param pay_rtn_name
	 * @param pay_rtn_data
	 * @param pay_ins_dt
	 */

	/**
	 * @Desc :
	 */
	public Payment() {
		super();
	}

	/**
	 * @Desc :
	 * @param pay_product_name
	 * @param pay_user_seq
	 * @param pay_crc_seq
	 * @param pay_user_type
	 * @param pay_user_status
	 * @param pay_user_id
	 * @param pay_user_accname
	 * @param pay_user_accnum
	 * @param pay_user_bankno
	 * @param pay_user_method
	 * @param pay_user_tid
	 * @param pay_user_moid
	 * @param pay_sell_name
	 * @param pay_rtn_data
	 * @param pay_ins_dt
	 */
	public Payment(String pay_product_name, String pay_user_seq, String pay_crc_seq, String pay_user_type,
			String pay_user_status, String pay_user_id, String pay_user_accname, String pay_user_accnum,
			String pay_user_bankno, String pay_user_method, String pay_user_tid, String pay_user_moid,
			String pay_sell_name, String pay_rtn_data, String pay_ins_dt) {
		super();
		this.pay_product_name = pay_product_name;
		this.pay_user_seq = pay_user_seq;
		this.pay_crc_seq = pay_crc_seq;
		this.pay_user_type = pay_user_type;
		this.pay_user_status = pay_user_status;
		this.pay_user_id = pay_user_id;
		this.pay_user_accname = pay_user_accname;
		this.pay_user_accnum = pay_user_accnum;
		this.pay_user_bankno = pay_user_bankno;
		this.pay_user_method = pay_user_method;
		this.pay_user_tid = pay_user_tid;
		this.pay_user_moid = pay_user_moid;
		this.pay_sell_name = pay_sell_name;
		this.pay_rtn_data = pay_rtn_data;
		this.pay_ins_dt = pay_ins_dt;
	}

	public String getPay_product_name() {
		return pay_product_name;
	}

	public void setPay_product_name(String pay_product_name) {
		this.pay_product_name = pay_product_name;
	}

	public String getPay_user_seq() {
		return pay_user_seq;
	}

	public void setPay_user_seq(String pay_user_seq) {
		this.pay_user_seq = pay_user_seq;
	}

	public String getPay_crc_seq() {
		return pay_crc_seq;
	}

	public void setPay_crc_seq(String pay_crc_seq) {
		this.pay_crc_seq = pay_crc_seq;
	}

	public String getPay_user_type() {
		return pay_user_type;
	}

	public void setPay_user_type(String pay_user_type) {
		this.pay_user_type = pay_user_type;
	}

	public String getPay_user_status() {
		return pay_user_status;
	}

	public void setPay_user_status(String pay_user_status) {
		this.pay_user_status = pay_user_status;
	}

	public String getPay_user_id() {
		return pay_user_id;
	}

	public void setPay_user_id(String pay_user_id) {
		this.pay_user_id = pay_user_id;
	}

	public String getPay_user_accname() {
		return pay_user_accname;
	}

	public void setPay_user_accname(String pay_user_accname) {
		this.pay_user_accname = pay_user_accname;
	}

	public String getPay_user_accnum() {
		return pay_user_accnum;
	}

	public void setPay_user_accnum(String pay_user_accnum) {
		this.pay_user_accnum = pay_user_accnum;
	}

	public String getPay_user_bankno() {
		return pay_user_bankno;
	}

	public void setPay_user_bankno(String pay_user_bankno) {
		this.pay_user_bankno = pay_user_bankno;
	}

	public String getPay_user_method() {
		return pay_user_method;
	}

	public void setPay_user_method(String pay_user_method) {
		this.pay_user_method = pay_user_method;
	}

	public String getPay_user_tid() {
		return pay_user_tid;
	}

	public void setPay_user_tid(String pay_user_tid) {
		this.pay_user_tid = pay_user_tid;
	}

	public String getPay_user_moid() {
		return pay_user_moid;
	}

	public void setPay_user_moid(String pay_user_moid) {
		this.pay_user_moid = pay_user_moid;
	}

	public String getPay_sell_name() {
		return pay_sell_name;
	}

	public void setPay_sell_name(String pay_sell_name) {
		this.pay_sell_name = pay_sell_name;
	}

	public String getPay_rtn_data() {
		return pay_rtn_data;
	}

	public void setPay_rtn_data(String pay_rtn_data) {
		this.pay_rtn_data = pay_rtn_data;
	}

	public String getPay_ins_dt() {
		return pay_ins_dt;
	}

	public void setPay_ins_dt(String pay_ins_dt) {
		this.pay_ins_dt = pay_ins_dt;
	}

	@Override
	public String toString() {
		return "Payment [pay_product_name=" + pay_product_name + ", pay_user_seq=" + pay_user_seq + ", pay_crc_seq="
				+ pay_crc_seq + ", pay_user_type=" + pay_user_type + ", pay_user_status=" + pay_user_status
				+ ", pay_user_id=" + pay_user_id + ", pay_user_accname=" + pay_user_accname + ", pay_user_accnum="
				+ pay_user_accnum + ", pay_user_bankno=" + pay_user_bankno + ", pay_user_method=" + pay_user_method
				+ ", pay_user_tid=" + pay_user_tid + ", pay_user_moid=" + pay_user_moid + ", pay_sell_name="
				+ pay_sell_name + ", pay_rtn_data=" + pay_rtn_data + ", pay_ins_dt=" + pay_ins_dt + "]";
	}

}
