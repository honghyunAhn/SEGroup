/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 계약사원정보
 * 
 */
public class SocietyFapJobJitEmployee {
	/**
	 * 계약사원정보 시퀀스
	 */
	private long fap_job_jit_employee_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 전환여부(공통코드)
	 */
	private String fap_job_jit_employee_isswitch;
	
	/**
	 * 계약기간
	 */
	private String fap_job_jit_employee_term;
	
	/**
	 * 조건
	 */
	private String fap_job_jit_employee_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_jit_employee_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_jit_employee_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_jit_employee_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_jit_employee_udt_dt;

	public SocietyFapJobJitEmployee() {
		super();
	}

	public SocietyFapJobJitEmployee(long fap_job_jit_employee_seq, long fap_job_ad_seq,
			String fap_job_jit_employee_isswitch, String fap_job_jit_employee_term, String fap_job_jit_employee_dtl,
			String fap_job_jit_employee_ins_id, String fap_job_jit_employee_ins_dt, String fap_job_jit_employee_udt_id,
			String fap_job_jit_employee_udt_dt) {
		super();
		this.fap_job_jit_employee_seq = fap_job_jit_employee_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_jit_employee_isswitch = fap_job_jit_employee_isswitch;
		this.fap_job_jit_employee_term = fap_job_jit_employee_term;
		this.fap_job_jit_employee_dtl = fap_job_jit_employee_dtl;
		this.fap_job_jit_employee_ins_id = fap_job_jit_employee_ins_id;
		this.fap_job_jit_employee_ins_dt = fap_job_jit_employee_ins_dt;
		this.fap_job_jit_employee_udt_id = fap_job_jit_employee_udt_id;
		this.fap_job_jit_employee_udt_dt = fap_job_jit_employee_udt_dt;
	}

	public long getFap_job_jit_employee_seq() {
		return fap_job_jit_employee_seq;
	}

	public void setFap_job_jit_employee_seq(long fap_job_jit_employee_seq) {
		this.fap_job_jit_employee_seq = fap_job_jit_employee_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_jit_employee_isswitch() {
		return fap_job_jit_employee_isswitch;
	}

	public void setFap_job_jit_employee_isswitch(String fap_job_jit_employee_isswitch) {
		this.fap_job_jit_employee_isswitch = fap_job_jit_employee_isswitch;
	}

	public String getFap_job_jit_employee_term() {
		return fap_job_jit_employee_term;
	}

	public void setFap_job_jit_employee_term(String fap_job_jit_employee_term) {
		this.fap_job_jit_employee_term = fap_job_jit_employee_term;
	}

	public String getFap_job_jit_employee_dtl() {
		return fap_job_jit_employee_dtl;
	}

	public void setFap_job_jit_employee_dtl(String fap_job_jit_employee_dtl) {
		this.fap_job_jit_employee_dtl = fap_job_jit_employee_dtl;
	}

	public String getFap_job_jit_employee_ins_id() {
		return fap_job_jit_employee_ins_id;
	}

	public void setFap_job_jit_employee_ins_id(String fap_job_jit_employee_ins_id) {
		this.fap_job_jit_employee_ins_id = fap_job_jit_employee_ins_id;
	}

	public String getFap_job_jit_employee_ins_dt() {
		return fap_job_jit_employee_ins_dt;
	}

	public void setFap_job_jit_employee_ins_dt(String fap_job_jit_employee_ins_dt) {
		this.fap_job_jit_employee_ins_dt = fap_job_jit_employee_ins_dt;
	}

	public String getFap_job_jit_employee_udt_id() {
		return fap_job_jit_employee_udt_id;
	}

	public void setFap_job_jit_employee_udt_id(String fap_job_jit_employee_udt_id) {
		this.fap_job_jit_employee_udt_id = fap_job_jit_employee_udt_id;
	}

	public String getFap_job_jit_employee_udt_dt() {
		return fap_job_jit_employee_udt_dt;
	}

	public void setFap_job_jit_employee_udt_dt(String fap_job_jit_employee_udt_dt) {
		this.fap_job_jit_employee_udt_dt = fap_job_jit_employee_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobJitEmployee [fap_job_jit_employee_seq=" + fap_job_jit_employee_seq + ", fap_job_ad_seq="
				+ fap_job_ad_seq + ", fap_job_jit_employee_isswitch=" + fap_job_jit_employee_isswitch
				+ ", fap_job_jit_employee_term=" + fap_job_jit_employee_term + ", fap_job_jit_employee_dtl="
				+ fap_job_jit_employee_dtl + ", fap_job_jit_employee_ins_id=" + fap_job_jit_employee_ins_id
				+ ", fap_job_jit_employee_ins_dt=" + fap_job_jit_employee_ins_dt + ", fap_job_jit_employee_udt_id="
				+ fap_job_jit_employee_udt_id + ", fap_job_jit_employee_udt_dt=" + fap_job_jit_employee_udt_dt + "]";
	}

}
