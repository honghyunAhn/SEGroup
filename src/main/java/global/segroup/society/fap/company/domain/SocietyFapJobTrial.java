/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 시용기간 정보
 * 
 */
public class SocietyFapJobTrial {
	/**
	 * 시용기간 시퀀스
	 */
	private long fap_job_trial_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 시용기간
	 */
	private String fap_job_trial_pd;
	
	/**
	 * 시용기간 급여
	 */
	private String fap_job_trial_pay;
	
	/**
	 * 시용기간 급여조건(공통코드)
	 */
	private String fap_job_trial_pay_equal;
	
	/**
	 * 등록자
	 */
	private String fap_job_trial_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_trial_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_trial_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_trial_udt_dt;

	public SocietyFapJobTrial() {
		super();
	}

	public SocietyFapJobTrial(long fap_job_trial_seq, long fap_job_ad_seq, String fap_job_trial_pd,
			String fap_job_trial_pay, String fap_job_trial_pay_equal, String fap_job_trial_ins_id,
			String fap_job_trial_ins_dt, String fap_job_trial_udt_id, String fap_job_trial_udt_dt) {
		super();
		this.fap_job_trial_seq = fap_job_trial_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_trial_pd = fap_job_trial_pd;
		this.fap_job_trial_pay = fap_job_trial_pay;
		this.fap_job_trial_pay_equal = fap_job_trial_pay_equal;
		this.fap_job_trial_ins_id = fap_job_trial_ins_id;
		this.fap_job_trial_ins_dt = fap_job_trial_ins_dt;
		this.fap_job_trial_udt_id = fap_job_trial_udt_id;
		this.fap_job_trial_udt_dt = fap_job_trial_udt_dt;
	}

	public long getFap_job_trial_seq() {
		return fap_job_trial_seq;
	}

	public void setFap_job_trial_seq(long fap_job_trial_seq) {
		this.fap_job_trial_seq = fap_job_trial_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_trial_pd() {
		return fap_job_trial_pd;
	}

	public void setFap_job_trial_pd(String fap_job_trial_pd) {
		this.fap_job_trial_pd = fap_job_trial_pd;
	}

	public String getFap_job_trial_pay() {
		return fap_job_trial_pay;
	}

	public void setFap_job_trial_pay(String fap_job_trial_pay) {
		this.fap_job_trial_pay = fap_job_trial_pay;
	}

	public String getFap_job_trial_pay_equal() {
		return fap_job_trial_pay_equal;
	}

	public void setFap_job_trial_pay_equal(String fap_job_trial_pay_equal) {
		this.fap_job_trial_pay_equal = fap_job_trial_pay_equal;
	}

	public String getFap_job_trial_ins_id() {
		return fap_job_trial_ins_id;
	}

	public void setFap_job_trial_ins_id(String fap_job_trial_ins_id) {
		this.fap_job_trial_ins_id = fap_job_trial_ins_id;
	}

	public String getFap_job_trial_ins_dt() {
		return fap_job_trial_ins_dt;
	}

	public void setFap_job_trial_ins_dt(String fap_job_trial_ins_dt) {
		this.fap_job_trial_ins_dt = fap_job_trial_ins_dt;
	}

	public String getFap_job_trial_udt_id() {
		return fap_job_trial_udt_id;
	}

	public void setFap_job_trial_udt_id(String fap_job_trial_udt_id) {
		this.fap_job_trial_udt_id = fap_job_trial_udt_id;
	}

	public String getFap_job_trial_udt_dt() {
		return fap_job_trial_udt_dt;
	}

	public void setFap_job_trial_udt_dt(String fap_job_trial_udt_dt) {
		this.fap_job_trial_udt_dt = fap_job_trial_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobTrial [fap_job_trial_seq=" + fap_job_trial_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_trial_pd=" + fap_job_trial_pd + ", fap_job_trial_pay=" + fap_job_trial_pay
				+ ", fap_job_trial_pay_equal=" + fap_job_trial_pay_equal + ", fap_job_trial_ins_id="
				+ fap_job_trial_ins_id + ", fap_job_trial_ins_dt=" + fap_job_trial_ins_dt + ", fap_job_trial_udt_id="
				+ fap_job_trial_udt_id + ", fap_job_trial_udt_dt=" + fap_job_trial_udt_dt + "]";
	}
	
}
