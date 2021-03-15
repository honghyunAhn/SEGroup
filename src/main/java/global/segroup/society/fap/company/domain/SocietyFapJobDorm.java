/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 기숙사 정보
 * 
 */
public class SocietyFapJobDorm {
	/**
	 * 기숙사 정보 시퀀스
	 */
	private long fap_job_dorm_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 위치
	 */
	private String fap_job_dorm_lo;
	
	/**
	 * 자기부담금
	 */
	private String fap_job_dorm_cost;
	
	/**
	 * 비고
	 */
	private String fap_job_dorm_note;
	
	/**
	 * 등록자
	 */
	private String fap_job_dorm_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_dorm_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_dorm_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_dorm_udt_dt;

	public SocietyFapJobDorm() {
		super();
	}

	public SocietyFapJobDorm(long fap_job_dorm_seq, long fap_job_ad_seq, String fap_job_dorm_lo,
			String fap_job_dorm_cost, String fap_job_dorm_note, String fap_job_dorm_ins_id, String fap_job_dorm_ins_dt,
			String fap_job_dorm_udt_id, String fap_job_dorm_udt_dt) {
		super();
		this.fap_job_dorm_seq = fap_job_dorm_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_dorm_lo = fap_job_dorm_lo;
		this.fap_job_dorm_cost = fap_job_dorm_cost;
		this.fap_job_dorm_note = fap_job_dorm_note;
		this.fap_job_dorm_ins_id = fap_job_dorm_ins_id;
		this.fap_job_dorm_ins_dt = fap_job_dorm_ins_dt;
		this.fap_job_dorm_udt_id = fap_job_dorm_udt_id;
		this.fap_job_dorm_udt_dt = fap_job_dorm_udt_dt;
	}

	public long getFap_job_dorm_seq() {
		return fap_job_dorm_seq;
	}

	public void setFap_job_dorm_seq(long fap_job_dorm_seq) {
		this.fap_job_dorm_seq = fap_job_dorm_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_dorm_lo() {
		return fap_job_dorm_lo;
	}

	public void setFap_job_dorm_lo(String fap_job_dorm_lo) {
		this.fap_job_dorm_lo = fap_job_dorm_lo;
	}

	public String getFap_job_dorm_cost() {
		return fap_job_dorm_cost;
	}

	public void setFap_job_dorm_cost(String fap_job_dorm_cost) {
		this.fap_job_dorm_cost = fap_job_dorm_cost;
	}

	public String getFap_job_dorm_note() {
		return fap_job_dorm_note;
	}

	public void setFap_job_dorm_note(String fap_job_dorm_note) {
		this.fap_job_dorm_note = fap_job_dorm_note;
	}

	public String getFap_job_dorm_ins_id() {
		return fap_job_dorm_ins_id;
	}

	public void setFap_job_dorm_ins_id(String fap_job_dorm_ins_id) {
		this.fap_job_dorm_ins_id = fap_job_dorm_ins_id;
	}

	public String getFap_job_dorm_ins_dt() {
		return fap_job_dorm_ins_dt;
	}

	public void setFap_job_dorm_ins_dt(String fap_job_dorm_ins_dt) {
		this.fap_job_dorm_ins_dt = fap_job_dorm_ins_dt;
	}

	public String getFap_job_dorm_udt_id() {
		return fap_job_dorm_udt_id;
	}

	public void setFap_job_dorm_udt_id(String fap_job_dorm_udt_id) {
		this.fap_job_dorm_udt_id = fap_job_dorm_udt_id;
	}

	public String getFap_job_dorm_udt_dt() {
		return fap_job_dorm_udt_dt;
	}

	public void setFap_job_dorm_udt_dt(String fap_job_dorm_udt_dt) {
		this.fap_job_dorm_udt_dt = fap_job_dorm_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobDorm [fap_job_dorm_seq=" + fap_job_dorm_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_dorm_lo=" + fap_job_dorm_lo + ", fap_job_dorm_cost=" + fap_job_dorm_cost
				+ ", fap_job_dorm_note=" + fap_job_dorm_note + ", fap_job_dorm_ins_id=" + fap_job_dorm_ins_id
				+ ", fap_job_dorm_ins_dt=" + fap_job_dorm_ins_dt + ", fap_job_dorm_udt_id=" + fap_job_dorm_udt_id
				+ ", fap_job_dorm_udt_dt=" + fap_job_dorm_udt_dt + "]";
	}
	
}
