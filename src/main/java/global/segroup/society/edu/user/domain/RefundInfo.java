/**
 * 
 */
package global.segroup.society.edu.user.domain;

/**
 * @Author : 전상수
 * @Date : 2017. 12. 18.
 * @Class 설명 : 환불정보를 담는 객체
 * 
 */
public class RefundInfo {

	private String reqDt;// 환불요청일
	private String comDt;// 환불완료일
	private String status;// 환불상태
	private String accName;// 요청환불계좌주
	private String accNum; // 요청환불계좌번호
	private String reason;// 환불사유
	private String memo;// 관리자환불메모
	private String bank;// 요청환불계좌은행
	private String reqId;// 요청자ID
	private String seq; // 환불하려는 결제seq
	private String pay_user_id;
	private String pay_tid;
	private String pay_moid;
	private String pay_user_method;
	private String cshr_cancelnum;
	private int pay_refund_seq;

	/**
	 * @Desc :
	 * @param reqDt
	 * @param comDt
	 * @param status
	 * @param accName
	 * @param accNum
	 * @param reason
	 * @param memo
	 * @param bank
	 * @param reqId
	 * @param seq
	 * @param pay_user_id
	 * @param pay_tid
	 * @param pay_moid
	 * @param pay_user_method
	 */

	/**
	 * @Desc :
	 */
	public RefundInfo() {
		super();
	}

	/**
	 * @Desc :
	 * @param reqDt
	 * @param comDt
	 * @param status
	 * @param accName
	 * @param accNum
	 * @param reason
	 * @param memo
	 * @param bank
	 * @param reqId
	 * @param seq
	 * @param pay_user_id
	 * @param pay_tid
	 * @param pay_moid
	 * @param pay_user_method
	 * @param cshr_cancelnum
	 * @param pay_refund_seq
	 */
	public RefundInfo(String reqDt, String comDt, String status, String accName, String accNum, String reason,
			String memo, String bank, String reqId, String seq, String pay_user_id, String pay_tid, String pay_moid,
			String pay_user_method, String cshr_cancelnum, int pay_refund_seq) {
		super();
		this.reqDt = reqDt;
		this.comDt = comDt;
		this.status = status;
		this.accName = accName;
		this.accNum = accNum;
		this.reason = reason;
		this.memo = memo;
		this.bank = bank;
		this.reqId = reqId;
		this.seq = seq;
		this.pay_user_id = pay_user_id;
		this.pay_tid = pay_tid;
		this.pay_moid = pay_moid;
		this.pay_user_method = pay_user_method;
		this.cshr_cancelnum = cshr_cancelnum;
		this.pay_refund_seq = pay_refund_seq;
	}

	public String getReqDt() {
		return reqDt;
	}

	public void setReqDt(String reqDt) {
		this.reqDt = reqDt;
	}

	public String getComDt() {
		return comDt;
	}

	public void setComDt(String comDt) {
		this.comDt = comDt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAccName() {
		return accName;
	}

	public void setAccName(String accName) {
		this.accName = accName;
	}

	public String getAccNum() {
		return accNum;
	}

	public void setAccNum(String accNum) {
		this.accNum = accNum;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getReqId() {
		return reqId;
	}

	public void setReqId(String reqId) {
		this.reqId = reqId;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getPay_user_id() {
		return pay_user_id;
	}

	public void setPay_user_id(String pay_user_id) {
		this.pay_user_id = pay_user_id;
	}

	public String getPay_tid() {
		return pay_tid;
	}

	public void setPay_tid(String pay_tid) {
		this.pay_tid = pay_tid;
	}

	public String getPay_moid() {
		return pay_moid;
	}

	public void setPay_moid(String pay_moid) {
		this.pay_moid = pay_moid;
	}

	public String getPay_user_method() {
		return pay_user_method;
	}

	public void setPay_user_method(String pay_user_method) {
		this.pay_user_method = pay_user_method;
	}

	public String getCshr_cancelnum() {
		return cshr_cancelnum;
	}

	public void setCshr_cancelnum(String cshr_cancelnum) {
		this.cshr_cancelnum = cshr_cancelnum;
	}

	public int getPay_refund_seq() {
		return pay_refund_seq;
	}

	public void setPay_refund_seq(int pay_refund_seq) {
		this.pay_refund_seq = pay_refund_seq;
	}

	@Override
	public String toString() {
		return "RefundInfo [reqDt=" + reqDt + ", comDt=" + comDt + ", status=" + status + ", accName=" + accName
				+ ", accNum=" + accNum + ", reason=" + reason + ", memo=" + memo + ", bank=" + bank + ", reqId=" + reqId
				+ ", seq=" + seq + ", pay_user_id=" + pay_user_id + ", pay_tid=" + pay_tid + ", pay_moid=" + pay_moid
				+ ", pay_user_method=" + pay_user_method + ", cshr_cancelnum=" + cshr_cancelnum + ", pay_refund_seq="
				+ pay_refund_seq + "]";
	}

}
