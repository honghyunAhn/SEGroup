/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 8. 7.
 * @Class 설명 : 지원 룰 정보
 * 
 */
public class SocietyFapAdminJobfairApplyRule {

	private long fap_jobfair_apply_rule_seq;
	private long fap_job_ad_seq;
	private long fap_jobfair_applicable_time_seq;
	private String fap_jobfair_apply_rule_gb;
	private String fap_jobfair_apply_rule_ins_id;
	private String fap_jobfair_apply_rule_ins_dt;
	private String fap_jobfair_apply_rule_udt_id;
	private String fap_jobfair_apply_rule_udt_dt;
	
	public SocietyFapAdminJobfairApplyRule() {
		super();
	}

	public SocietyFapAdminJobfairApplyRule(long fap_jobfair_apply_rule_seq, long fap_job_ad_seq,
			long fap_jobfair_applicable_time_seq, String fap_jobfair_apply_rule_gb,
			String fap_jobfair_apply_rule_ins_id, String fap_jobfair_apply_rule_ins_dt,
			String fap_jobfair_apply_rule_udt_id, String fap_jobfair_apply_rule_udt_dt) {
		super();
		this.fap_jobfair_apply_rule_seq = fap_jobfair_apply_rule_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_jobfair_applicable_time_seq = fap_jobfair_applicable_time_seq;
		this.fap_jobfair_apply_rule_gb = fap_jobfair_apply_rule_gb;
		this.fap_jobfair_apply_rule_ins_id = fap_jobfair_apply_rule_ins_id;
		this.fap_jobfair_apply_rule_ins_dt = fap_jobfair_apply_rule_ins_dt;
		this.fap_jobfair_apply_rule_udt_id = fap_jobfair_apply_rule_udt_id;
		this.fap_jobfair_apply_rule_udt_dt = fap_jobfair_apply_rule_udt_dt;
	}

	public long getFap_jobfair_apply_rule_seq() {
		return fap_jobfair_apply_rule_seq;
	}

	public void setFap_jobfair_apply_rule_seq(long fap_jobfair_apply_rule_seq) {
		this.fap_jobfair_apply_rule_seq = fap_jobfair_apply_rule_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public long getFap_jobfair_applicable_time_seq() {
		return fap_jobfair_applicable_time_seq;
	}

	public void setFap_jobfair_applicable_time_seq(long fap_jobfair_applicable_time_seq) {
		this.fap_jobfair_applicable_time_seq = fap_jobfair_applicable_time_seq;
	}

	public String getFap_jobfair_apply_rule_gb() {
		return fap_jobfair_apply_rule_gb;
	}

	public void setFap_jobfair_apply_rule_gb(String fap_jobfair_apply_rule_gb) {
		this.fap_jobfair_apply_rule_gb = fap_jobfair_apply_rule_gb;
	}

	public String getFap_jobfair_apply_rule_ins_id() {
		return fap_jobfair_apply_rule_ins_id;
	}

	public void setFap_jobfair_apply_rule_ins_id(String fap_jobfair_apply_rule_ins_id) {
		this.fap_jobfair_apply_rule_ins_id = fap_jobfair_apply_rule_ins_id;
	}

	public String getFap_jobfair_apply_rule_ins_dt() {
		return fap_jobfair_apply_rule_ins_dt;
	}

	public void setFap_jobfair_apply_rule_ins_dt(String fap_jobfair_apply_rule_ins_dt) {
		this.fap_jobfair_apply_rule_ins_dt = fap_jobfair_apply_rule_ins_dt;
	}

	public String getFap_jobfair_apply_rule_udt_id() {
		return fap_jobfair_apply_rule_udt_id;
	}

	public void setFap_jobfair_apply_rule_udt_id(String fap_jobfair_apply_rule_udt_id) {
		this.fap_jobfair_apply_rule_udt_id = fap_jobfair_apply_rule_udt_id;
	}

	public String getFap_jobfair_apply_rule_udt_dt() {
		return fap_jobfair_apply_rule_udt_dt;
	}

	public void setFap_jobfair_apply_rule_udt_dt(String fap_jobfair_apply_rule_udt_dt) {
		this.fap_jobfair_apply_rule_udt_dt = fap_jobfair_apply_rule_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairApplyRule [fap_jobfair_apply_rule_seq=" + fap_jobfair_apply_rule_seq
				+ ", fap_job_ad_seq=" + fap_job_ad_seq + ", fap_jobfair_applicable_time_seq="
				+ fap_jobfair_applicable_time_seq + ", fap_jobfair_apply_rule_gb=" + fap_jobfair_apply_rule_gb
				+ ", fap_jobfair_apply_rule_ins_id=" + fap_jobfair_apply_rule_ins_id
				+ ", fap_jobfair_apply_rule_ins_dt=" + fap_jobfair_apply_rule_ins_dt
				+ ", fap_jobfair_apply_rule_udt_id=" + fap_jobfair_apply_rule_udt_id
				+ ", fap_jobfair_apply_rule_udt_dt=" + fap_jobfair_apply_rule_udt_dt + "]";
	}
}
