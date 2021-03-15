/**
 * 
 */
package global.segroup.society.edu.admin.domain;

import java.util.List;

import global.segroup.society.edu.apply.domain.SocietyEduApplyStudy;

/**
 * @Author : user
 * @Date : 2017. 12. 4.
 * @Class 설명 :
 * 
 */
public class SocietyEduAdminPayment {

	private String seq;

	private String amount;

	private String pay_st;

	private String pay_end;

	private String pay_order;

	private String adminId;

	private List<SocietyEduAdminPayment> paymentList;

	/**
	 * @Desc :
	 */
	public SocietyEduAdminPayment() {
		super();
	}

	/**
	 * @Desc :
	 * @param amount
	 * @param pay_st
	 * @param pay_end
	 * @param pay_order
	 * @param paymentList
	 */
	public SocietyEduAdminPayment(String amount, String pay_st, String pay_end, String pay_order,
			List<SocietyEduAdminPayment> paymentList) {
		super();
		this.amount = amount;
		this.pay_st = pay_st;
		this.pay_end = pay_end;
		this.pay_order = pay_order;
		this.paymentList = paymentList;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getPay_st() {
		return pay_st;
	}

	public void setPay_st(String pay_st) {
		this.pay_st = pay_st;
	}

	public String getPay_end() {
		return pay_end;
	}

	public void setPay_end(String pay_end) {
		this.pay_end = pay_end;
	}

	public List<SocietyEduAdminPayment> getPaymentList() {
		return paymentList;
	}

	public void setPaymentList(List<SocietyEduAdminPayment> paymentList) {
		this.paymentList = paymentList;
	}

	public String getPay_order() {
		return pay_order;
	}

	public void setPay_order(String pay_order) {
		this.pay_order = pay_order;
	}

	@Override
	public String toString() {
		return "SocietyEduAdminPayment [seq=" + seq + ", amount=" + amount + ", pay_st=" + pay_st + ", pay_end="
				+ pay_end + ", pay_order=" + pay_order + ", paymentList=" + paymentList + "]";
	}

}
