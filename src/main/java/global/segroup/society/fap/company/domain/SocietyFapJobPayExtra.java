/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : 채용공고 잔업수당정보
 * 
 */
public class SocietyFapJobPayExtra {
	/**
	 * 잔업수당 시퀀스
	 */
	private long fap_job_pay_extra_seq;
	
	/**
	 * 급여정보 시퀀스
	 */
	private long fap_job_pay_seq;
	
	/**
	 * 시간
	 */
	private String fap_job_pay_extra_tm;
	
	/**
	 * 등록자
	 */
	private String fap_job_pay_extra_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_extra_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_pay_extra_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_extra_udt_dt;

	public SocietyFapJobPayExtra() {
		super();
	}

	public SocietyFapJobPayExtra(long fap_job_pay_extra_seq, long fap_job_pay_seq, String fap_job_pay_extra_tm,
			String fap_job_pay_extra_ins_id, String fap_job_pay_extra_ins_dt, String fap_job_pay_extra_udt_id,
			String fap_job_pay_extra_udt_dt) {
		super();
		this.fap_job_pay_extra_seq = fap_job_pay_extra_seq;
		this.fap_job_pay_seq = fap_job_pay_seq;
		this.fap_job_pay_extra_tm = fap_job_pay_extra_tm;
		this.fap_job_pay_extra_ins_id = fap_job_pay_extra_ins_id;
		this.fap_job_pay_extra_ins_dt = fap_job_pay_extra_ins_dt;
		this.fap_job_pay_extra_udt_id = fap_job_pay_extra_udt_id;
		this.fap_job_pay_extra_udt_dt = fap_job_pay_extra_udt_dt;
	}

	public long getFap_job_pay_extra_seq() {
		return fap_job_pay_extra_seq;
	}

	public void setFap_job_pay_extra_seq(long fap_job_pay_extra_seq) {
		this.fap_job_pay_extra_seq = fap_job_pay_extra_seq;
	}

	public long getFap_job_pay_seq() {
		return fap_job_pay_seq;
	}

	public void setFap_job_pay_seq(long fap_job_pay_seq) {
		this.fap_job_pay_seq = fap_job_pay_seq;
	}

	public String getFap_job_pay_extra_tm() {
		return fap_job_pay_extra_tm;
	}

	public void setFap_job_pay_extra_tm(String fap_job_pay_extra_tm) {
		this.fap_job_pay_extra_tm = fap_job_pay_extra_tm;
	}

	public String getFap_job_pay_extra_ins_id() {
		return fap_job_pay_extra_ins_id;
	}

	public void setFap_job_pay_extra_ins_id(String fap_job_pay_extra_ins_id) {
		this.fap_job_pay_extra_ins_id = fap_job_pay_extra_ins_id;
	}

	public String getFap_job_pay_extra_ins_dt() {
		return fap_job_pay_extra_ins_dt;
	}

	public void setFap_job_pay_extra_ins_dt(String fap_job_pay_extra_ins_dt) {
		this.fap_job_pay_extra_ins_dt = fap_job_pay_extra_ins_dt;
	}

	public String getFap_job_pay_extra_udt_id() {
		return fap_job_pay_extra_udt_id;
	}

	public void setFap_job_pay_extra_udt_id(String fap_job_pay_extra_udt_id) {
		this.fap_job_pay_extra_udt_id = fap_job_pay_extra_udt_id;
	}

	public String getFap_job_pay_extra_udt_dt() {
		return fap_job_pay_extra_udt_dt;
	}

	public void setFap_job_pay_extra_udt_dt(String fap_job_pay_extra_udt_dt) {
		this.fap_job_pay_extra_udt_dt = fap_job_pay_extra_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobPayExtra [fap_job_pay_extra_seq=" + fap_job_pay_extra_seq + ", fap_job_pay_seq="
				+ fap_job_pay_seq + ", fap_job_pay_extra_tm=" + fap_job_pay_extra_tm + ", fap_job_pay_extra_ins_id="
				+ fap_job_pay_extra_ins_id + ", fap_job_pay_extra_ins_dt=" + fap_job_pay_extra_ins_dt
				+ ", fap_job_pay_extra_udt_id=" + fap_job_pay_extra_udt_id + ", fap_job_pay_extra_udt_dt="
				+ fap_job_pay_extra_udt_dt + "]";
	}
	
}
