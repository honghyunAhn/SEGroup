/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 1. 26.
 * @Class 설명 : 회사별 임시 결제 VO
 * 
 */
public class SocietyFapPerCompTempPayment {
	private int fap_per_comp_temp_payment_seq;
	private String fap_comp_id;
	private int fap_per_jobfair_temp_group_seq;
	private String fap_per_comp_temp_payment_gb;
	private String fap_per_comp_temp_payment_ins_id;
	private String fap_per_comp_temp_payment_ins_dt;
	private String fap_per_comp_temp_payment_udt_id;
	private String fap_per_comp_temp_payment_udt_dt;
	
	public SocietyFapPerCompTempPayment() {
		super();
	}

	public SocietyFapPerCompTempPayment(int fap_per_comp_temp_payment_seq, String fap_comp_id,
			int fap_per_jobfair_temp_group_seq, String fap_per_comp_temp_payment_gb,
			String fap_per_comp_temp_payment_ins_id, String fap_per_comp_temp_payment_ins_dt,
			String fap_per_comp_temp_payment_udt_id, String fap_per_comp_temp_payment_udt_dt) {
		super();
		this.fap_per_comp_temp_payment_seq = fap_per_comp_temp_payment_seq;
		this.fap_comp_id = fap_comp_id;
		this.fap_per_jobfair_temp_group_seq = fap_per_jobfair_temp_group_seq;
		this.fap_per_comp_temp_payment_gb = fap_per_comp_temp_payment_gb;
		this.fap_per_comp_temp_payment_ins_id = fap_per_comp_temp_payment_ins_id;
		this.fap_per_comp_temp_payment_ins_dt = fap_per_comp_temp_payment_ins_dt;
		this.fap_per_comp_temp_payment_udt_id = fap_per_comp_temp_payment_udt_id;
		this.fap_per_comp_temp_payment_udt_dt = fap_per_comp_temp_payment_udt_dt;
	}

	public int getFap_per_comp_temp_payment_seq() {
		return fap_per_comp_temp_payment_seq;
	}

	public void setFap_per_comp_temp_payment_seq(int fap_per_comp_temp_payment_seq) {
		this.fap_per_comp_temp_payment_seq = fap_per_comp_temp_payment_seq;
	}

	public String getFap_comp_id() {
		return fap_comp_id;
	}

	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}

	public int getFap_per_jobfair_temp_group_seq() {
		return fap_per_jobfair_temp_group_seq;
	}

	public void setFap_per_jobfair_temp_group_seq(int fap_per_jobfair_temp_group_seq) {
		this.fap_per_jobfair_temp_group_seq = fap_per_jobfair_temp_group_seq;
	}

	public String getFap_per_comp_temp_payment_gb() {
		return fap_per_comp_temp_payment_gb;
	}

	public void setFap_per_comp_temp_payment_gb(String fap_per_comp_temp_payment_gb) {
		this.fap_per_comp_temp_payment_gb = fap_per_comp_temp_payment_gb;
	}

	public String getFap_per_comp_temp_payment_ins_id() {
		return fap_per_comp_temp_payment_ins_id;
	}

	public void setFap_per_comp_temp_payment_ins_id(String fap_per_comp_temp_payment_ins_id) {
		this.fap_per_comp_temp_payment_ins_id = fap_per_comp_temp_payment_ins_id;
	}

	public String getFap_per_comp_temp_payment_ins_dt() {
		return fap_per_comp_temp_payment_ins_dt;
	}

	public void setFap_per_comp_temp_payment_ins_dt(String fap_per_comp_temp_payment_ins_dt) {
		this.fap_per_comp_temp_payment_ins_dt = fap_per_comp_temp_payment_ins_dt;
	}

	public String getFap_per_comp_temp_payment_udt_id() {
		return fap_per_comp_temp_payment_udt_id;
	}

	public void setFap_per_comp_temp_payment_udt_id(String fap_per_comp_temp_payment_udt_id) {
		this.fap_per_comp_temp_payment_udt_id = fap_per_comp_temp_payment_udt_id;
	}

	public String getFap_per_comp_temp_payment_udt_dt() {
		return fap_per_comp_temp_payment_udt_dt;
	}

	public void setFap_per_comp_temp_payment_udt_dt(String fap_per_comp_temp_payment_udt_dt) {
		this.fap_per_comp_temp_payment_udt_dt = fap_per_comp_temp_payment_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapPerCompTempPayment [fap_per_comp_temp_payment_seq=" + fap_per_comp_temp_payment_seq
				+ ", fap_comp_id=" + fap_comp_id + ", fap_per_jobfair_temp_group_seq=" + fap_per_jobfair_temp_group_seq
				+ ", fap_per_comp_temp_payment_gb=" + fap_per_comp_temp_payment_gb
				+ ", fap_per_comp_temp_payment_ins_id=" + fap_per_comp_temp_payment_ins_id
				+ ", fap_per_comp_temp_payment_ins_dt=" + fap_per_comp_temp_payment_ins_dt
				+ ", fap_per_comp_temp_payment_udt_id=" + fap_per_comp_temp_payment_udt_id
				+ ", fap_per_comp_temp_payment_udt_dt=" + fap_per_comp_temp_payment_udt_dt + "]";
	}
}
