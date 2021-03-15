/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 1. 26.
 * @Class 설명 : 잡페어별 임시 결제 그룹 VO
 * 
 */
public class SocietyFapPerJobfairTempGroup {
	private int fap_per_jobfair_temp_group_seq;
	private int fap_jobfair_seq;
	private String fap_per_jobfair_temp_group_nm;
	private String fap_per_jobfair_temp_group_ins_id;
	private String fap_per_jobfair_temp_group_ins_dt;
	private String fap_per_jobfair_temp_group_udt_id;
	private String fap_per_jobfair_temp_group_udt_dt;
	
	public SocietyFapPerJobfairTempGroup() {
		super();
	}

	public SocietyFapPerJobfairTempGroup(int fap_per_jobfair_temp_group_seq, int fap_jobfair_seq,
			String fap_per_jobfair_temp_group_nm, String fap_per_jobfair_temp_group_ins_id,
			String fap_per_jobfair_temp_group_ins_dt, String fap_per_jobfair_temp_group_udt_id,
			String fap_per_jobfair_temp_group_udt_dt) {
		super();
		this.fap_per_jobfair_temp_group_seq = fap_per_jobfair_temp_group_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_per_jobfair_temp_group_nm = fap_per_jobfair_temp_group_nm;
		this.fap_per_jobfair_temp_group_ins_id = fap_per_jobfair_temp_group_ins_id;
		this.fap_per_jobfair_temp_group_ins_dt = fap_per_jobfair_temp_group_ins_dt;
		this.fap_per_jobfair_temp_group_udt_id = fap_per_jobfair_temp_group_udt_id;
		this.fap_per_jobfair_temp_group_udt_dt = fap_per_jobfair_temp_group_udt_dt;
	}

	public int getFap_per_jobfair_temp_group_seq() {
		return fap_per_jobfair_temp_group_seq;
	}

	public void setFap_per_jobfair_temp_group_seq(int fap_per_jobfair_temp_group_seq) {
		this.fap_per_jobfair_temp_group_seq = fap_per_jobfair_temp_group_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_per_jobfair_temp_group_nm() {
		return fap_per_jobfair_temp_group_nm;
	}

	public void setFap_per_jobfair_temp_group_nm(String fap_per_jobfair_temp_group_nm) {
		this.fap_per_jobfair_temp_group_nm = fap_per_jobfair_temp_group_nm;
	}

	public String getFap_per_jobfair_temp_group_ins_id() {
		return fap_per_jobfair_temp_group_ins_id;
	}

	public void setFap_per_jobfair_temp_group_ins_id(String fap_per_jobfair_temp_group_ins_id) {
		this.fap_per_jobfair_temp_group_ins_id = fap_per_jobfair_temp_group_ins_id;
	}

	public String getFap_per_jobfair_temp_group_ins_dt() {
		return fap_per_jobfair_temp_group_ins_dt;
	}

	public void setFap_per_jobfair_temp_group_ins_dt(String fap_per_jobfair_temp_group_ins_dt) {
		this.fap_per_jobfair_temp_group_ins_dt = fap_per_jobfair_temp_group_ins_dt;
	}

	public String getFap_per_jobfair_temp_group_udt_id() {
		return fap_per_jobfair_temp_group_udt_id;
	}

	public void setFap_per_jobfair_temp_group_udt_id(String fap_per_jobfair_temp_group_udt_id) {
		this.fap_per_jobfair_temp_group_udt_id = fap_per_jobfair_temp_group_udt_id;
	}

	public String getFap_per_jobfair_temp_group_udt_dt() {
		return fap_per_jobfair_temp_group_udt_dt;
	}

	public void setFap_per_jobfair_temp_group_udt_dt(String fap_per_jobfair_temp_group_udt_dt) {
		this.fap_per_jobfair_temp_group_udt_dt = fap_per_jobfair_temp_group_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapPerJobfairTempGroup [fap_per_jobfair_temp_group_seq=" + fap_per_jobfair_temp_group_seq
				+ ", fap_jobfair_seq=" + fap_jobfair_seq + ", fap_per_jobfair_temp_group_nm="
				+ fap_per_jobfair_temp_group_nm + ", fap_per_jobfair_temp_group_ins_id="
				+ fap_per_jobfair_temp_group_ins_id + ", fap_per_jobfair_temp_group_ins_dt="
				+ fap_per_jobfair_temp_group_ins_dt + ", fap_per_jobfair_temp_group_udt_id="
				+ fap_per_jobfair_temp_group_udt_id + ", fap_per_jobfair_temp_group_udt_dt="
				+ fap_per_jobfair_temp_group_udt_dt + "]";
	}

}
