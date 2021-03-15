/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 3. 21.
 * @Class 설명 : 최종확정 기간 설정 도메인
 * 
 */
public class SocietyFapAdminFinalDecisionTime {
	private long fap_jobfair_final_decision_time_seq;
	private int fap_jobfair_divide_seq;
	private String fap_jobfair_final_decision_time_gb;
	private String fap_jobfair_final_decision_time_st;
	private String fap_jobfair_final_decision_time_et;
	private String fap_jobfair_final_decision_time_ct;
	private String fap_jobfair_final_decision_time_ins_id;
	private String fap_jobfair_final_decision_time_ins_dt;
	private String fap_jobfair_final_decision_time_udt_id;
	private String fap_jobfair_final_decision_time_udt_dt;
	
	public SocietyFapAdminFinalDecisionTime() {
		super();
	}

	public SocietyFapAdminFinalDecisionTime(long fap_jobfair_final_decision_time_seq, int fap_jobfair_divide_seq,
			String fap_jobfair_final_decision_time_gb, String fap_jobfair_final_decision_time_st,
			String fap_jobfair_final_decision_time_et, String fap_jobfair_final_decision_time_ct,
			String fap_jobfair_final_decision_time_ins_id, String fap_jobfair_final_decision_time_ins_dt,
			String fap_jobfair_final_decision_time_udt_id, String fap_jobfair_final_decision_time_udt_dt) {
		super();
		this.fap_jobfair_final_decision_time_seq = fap_jobfair_final_decision_time_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_final_decision_time_gb = fap_jobfair_final_decision_time_gb;
		this.fap_jobfair_final_decision_time_st = fap_jobfair_final_decision_time_st;
		this.fap_jobfair_final_decision_time_et = fap_jobfair_final_decision_time_et;
		this.fap_jobfair_final_decision_time_ct = fap_jobfair_final_decision_time_ct;
		this.fap_jobfair_final_decision_time_ins_id = fap_jobfair_final_decision_time_ins_id;
		this.fap_jobfair_final_decision_time_ins_dt = fap_jobfair_final_decision_time_ins_dt;
		this.fap_jobfair_final_decision_time_udt_id = fap_jobfair_final_decision_time_udt_id;
		this.fap_jobfair_final_decision_time_udt_dt = fap_jobfair_final_decision_time_udt_dt;
	}

	public long getFap_jobfair_final_decision_time_seq() {
		return fap_jobfair_final_decision_time_seq;
	}

	public void setFap_jobfair_final_decision_time_seq(long fap_jobfair_final_decision_time_seq) {
		this.fap_jobfair_final_decision_time_seq = fap_jobfair_final_decision_time_seq;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public String getFap_jobfair_final_decision_time_gb() {
		return fap_jobfair_final_decision_time_gb;
	}

	public void setFap_jobfair_final_decision_time_gb(String fap_jobfair_final_decision_time_gb) {
		this.fap_jobfair_final_decision_time_gb = fap_jobfair_final_decision_time_gb;
	}

	public String getFap_jobfair_final_decision_time_st() {
		return fap_jobfair_final_decision_time_st;
	}

	public void setFap_jobfair_final_decision_time_st(String fap_jobfair_final_decision_time_st) {
		this.fap_jobfair_final_decision_time_st = fap_jobfair_final_decision_time_st;
	}

	public String getFap_jobfair_final_decision_time_et() {
		return fap_jobfair_final_decision_time_et;
	}

	public void setFap_jobfair_final_decision_time_et(String fap_jobfair_final_decision_time_et) {
		this.fap_jobfair_final_decision_time_et = fap_jobfair_final_decision_time_et;
	}

	public String getFap_jobfair_final_decision_time_ct() {
		return fap_jobfair_final_decision_time_ct;
	}

	public void setFap_jobfair_final_decision_time_ct(String fap_jobfair_final_decision_time_ct) {
		this.fap_jobfair_final_decision_time_ct = fap_jobfair_final_decision_time_ct;
	}

	public String getFap_jobfair_final_decision_time_ins_id() {
		return fap_jobfair_final_decision_time_ins_id;
	}

	public void setFap_jobfair_final_decision_time_ins_id(String fap_jobfair_final_decision_time_ins_id) {
		this.fap_jobfair_final_decision_time_ins_id = fap_jobfair_final_decision_time_ins_id;
	}

	public String getFap_jobfair_final_decision_time_ins_dt() {
		return fap_jobfair_final_decision_time_ins_dt;
	}

	public void setFap_jobfair_final_decision_time_ins_dt(String fap_jobfair_final_decision_time_ins_dt) {
		this.fap_jobfair_final_decision_time_ins_dt = fap_jobfair_final_decision_time_ins_dt;
	}

	public String getFap_jobfair_final_decision_time_udt_id() {
		return fap_jobfair_final_decision_time_udt_id;
	}

	public void setFap_jobfair_final_decision_time_udt_id(String fap_jobfair_final_decision_time_udt_id) {
		this.fap_jobfair_final_decision_time_udt_id = fap_jobfair_final_decision_time_udt_id;
	}

	public String getFap_jobfair_final_decision_time_udt_dt() {
		return fap_jobfair_final_decision_time_udt_dt;
	}

	public void setFap_jobfair_final_decision_time_udt_dt(String fap_jobfair_final_decision_time_udt_dt) {
		this.fap_jobfair_final_decision_time_udt_dt = fap_jobfair_final_decision_time_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminFinalDecisionTime [fap_jobfair_final_decision_time_seq="
				+ fap_jobfair_final_decision_time_seq + ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq
				+ ", fap_jobfair_final_decision_time_gb=" + fap_jobfair_final_decision_time_gb
				+ ", fap_jobfair_final_decision_time_st=" + fap_jobfair_final_decision_time_st
				+ ", fap_jobfair_final_decision_time_et=" + fap_jobfair_final_decision_time_et
				+ ", fap_jobfair_final_decision_time_ct=" + fap_jobfair_final_decision_time_ct
				+ ", fap_jobfair_final_decision_time_ins_id=" + fap_jobfair_final_decision_time_ins_id
				+ ", fap_jobfair_final_decision_time_ins_dt=" + fap_jobfair_final_decision_time_ins_dt
				+ ", fap_jobfair_final_decision_time_udt_id=" + fap_jobfair_final_decision_time_udt_id
				+ ", fap_jobfair_final_decision_time_udt_dt=" + fap_jobfair_final_decision_time_udt_dt + "]";
	}

}
