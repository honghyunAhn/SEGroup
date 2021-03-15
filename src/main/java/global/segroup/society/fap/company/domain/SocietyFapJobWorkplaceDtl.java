/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 상세근무예정지 정보
 * 
 */
public class SocietyFapJobWorkplaceDtl {
	/**
	 * 상세근무예정지 시퀀스
	 */
	private long fap_job_workplace_dtl_seq;
	
	/**
	 * 근무예정지 시퀀스
	 */
	private long fap_job_workplace_seq;
	
	/**
	 * 상세근무예정지(공통코드)
	 */
	private String fap_job_workplace_dtl_gb;
	
	/**
	 * 등록자
	 */
	private String fap_job_workplace_dtl_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_workplace_dtl_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_workplace_dtl_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_workplace_dtl_udt_dt;
	
	private List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtlList;

	public SocietyFapJobWorkplaceDtl() {
		super();
	}

	public SocietyFapJobWorkplaceDtl(long fap_job_workplace_dtl_seq, long fap_job_workplace_seq,
			String fap_job_workplace_dtl_gb, String fap_job_workplace_dtl_ins_id, String fap_job_workplace_dtl_ins_dt,
			String fap_job_workplace_dtl_udt_id, String fap_job_workplace_dtl_udt_dt,
			List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtlList) {
		super();
		this.fap_job_workplace_dtl_seq = fap_job_workplace_dtl_seq;
		this.fap_job_workplace_seq = fap_job_workplace_seq;
		this.fap_job_workplace_dtl_gb = fap_job_workplace_dtl_gb;
		this.fap_job_workplace_dtl_ins_id = fap_job_workplace_dtl_ins_id;
		this.fap_job_workplace_dtl_ins_dt = fap_job_workplace_dtl_ins_dt;
		this.fap_job_workplace_dtl_udt_id = fap_job_workplace_dtl_udt_id;
		this.fap_job_workplace_dtl_udt_dt = fap_job_workplace_dtl_udt_dt;
		this.jobWorkplaceDtlList = jobWorkplaceDtlList;
	}

	public long getFap_job_workplace_dtl_seq() {
		return fap_job_workplace_dtl_seq;
	}

	public void setFap_job_workplace_dtl_seq(long fap_job_workplace_dtl_seq) {
		this.fap_job_workplace_dtl_seq = fap_job_workplace_dtl_seq;
	}

	public long getFap_job_workplace_seq() {
		return fap_job_workplace_seq;
	}

	public void setFap_job_workplace_seq(long fap_job_workplace_seq) {
		this.fap_job_workplace_seq = fap_job_workplace_seq;
	}

	public String getFap_job_workplace_dtl_gb() {
		return fap_job_workplace_dtl_gb;
	}

	public void setFap_job_workplace_dtl_gb(String fap_job_workplace_dtl_gb) {
		this.fap_job_workplace_dtl_gb = fap_job_workplace_dtl_gb;
	}

	public String getFap_job_workplace_dtl_ins_id() {
		return fap_job_workplace_dtl_ins_id;
	}

	public void setFap_job_workplace_dtl_ins_id(String fap_job_workplace_dtl_ins_id) {
		this.fap_job_workplace_dtl_ins_id = fap_job_workplace_dtl_ins_id;
	}

	public String getFap_job_workplace_dtl_ins_dt() {
		return fap_job_workplace_dtl_ins_dt;
	}

	public void setFap_job_workplace_dtl_ins_dt(String fap_job_workplace_dtl_ins_dt) {
		this.fap_job_workplace_dtl_ins_dt = fap_job_workplace_dtl_ins_dt;
	}

	public String getFap_job_workplace_dtl_udt_id() {
		return fap_job_workplace_dtl_udt_id;
	}

	public void setFap_job_workplace_dtl_udt_id(String fap_job_workplace_dtl_udt_id) {
		this.fap_job_workplace_dtl_udt_id = fap_job_workplace_dtl_udt_id;
	}

	public String getFap_job_workplace_dtl_udt_dt() {
		return fap_job_workplace_dtl_udt_dt;
	}

	public void setFap_job_workplace_dtl_udt_dt(String fap_job_workplace_dtl_udt_dt) {
		this.fap_job_workplace_dtl_udt_dt = fap_job_workplace_dtl_udt_dt;
	}

	public List<SocietyFapJobWorkplaceDtl> getJobWorkplaceDtlList() {
		return jobWorkplaceDtlList;
	}

	public void setJobWorkplaceDtlList(List<SocietyFapJobWorkplaceDtl> jobWorkplaceDtlList) {
		this.jobWorkplaceDtlList = jobWorkplaceDtlList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobWorkplaceDtl [fap_job_workplace_dtl_seq=" + fap_job_workplace_dtl_seq
				+ ", fap_job_workplace_seq=" + fap_job_workplace_seq + ", fap_job_workplace_dtl_gb="
				+ fap_job_workplace_dtl_gb + ", fap_job_workplace_dtl_ins_id=" + fap_job_workplace_dtl_ins_id
				+ ", fap_job_workplace_dtl_ins_dt=" + fap_job_workplace_dtl_ins_dt + ", fap_job_workplace_dtl_udt_id="
				+ fap_job_workplace_dtl_udt_id + ", fap_job_workplace_dtl_udt_dt=" + fap_job_workplace_dtl_udt_dt
				+ ", jobWorkplaceDtlList=" + jobWorkplaceDtlList + "]";
	}

}
