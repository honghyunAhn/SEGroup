/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 채용공고 보험정보
 * 
 */
public class SocietyFapJobIsr {
	/**
	 * 보험정보 시퀀스
	 */
	private long fap_job_isr_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 보험구분(공통코드)
	 */
	private String fap_job_isr_gb;
	
	/**
	 * 등록자
	 */
	private String fap_job_isr_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_isr_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_isr_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_isr_udt_dt;

	private List<SocietyFapJobIsr> jobIsrList;
	
	public SocietyFapJobIsr() {
		super();
	}

	public SocietyFapJobIsr(long fap_job_isr_seq, long fap_job_ad_seq, String fap_job_isr_gb, String fap_job_isr_ins_id,
			String fap_job_isr_ins_dt, String fap_job_isr_udt_id, String fap_job_isr_udt_dt,
			List<SocietyFapJobIsr> jobIsrList) {
		super();
		this.fap_job_isr_seq = fap_job_isr_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_isr_gb = fap_job_isr_gb;
		this.fap_job_isr_ins_id = fap_job_isr_ins_id;
		this.fap_job_isr_ins_dt = fap_job_isr_ins_dt;
		this.fap_job_isr_udt_id = fap_job_isr_udt_id;
		this.fap_job_isr_udt_dt = fap_job_isr_udt_dt;
		this.jobIsrList = jobIsrList;
	}

	public long getFap_job_isr_seq() {
		return fap_job_isr_seq;
	}

	public void setFap_job_isr_seq(long fap_job_isr_seq) {
		this.fap_job_isr_seq = fap_job_isr_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_isr_gb() {
		return fap_job_isr_gb;
	}

	public void setFap_job_isr_gb(String fap_job_isr_gb) {
		this.fap_job_isr_gb = fap_job_isr_gb;
	}

	public String getFap_job_isr_ins_id() {
		return fap_job_isr_ins_id;
	}

	public void setFap_job_isr_ins_id(String fap_job_isr_ins_id) {
		this.fap_job_isr_ins_id = fap_job_isr_ins_id;
	}

	public String getFap_job_isr_ins_dt() {
		return fap_job_isr_ins_dt;
	}

	public void setFap_job_isr_ins_dt(String fap_job_isr_ins_dt) {
		this.fap_job_isr_ins_dt = fap_job_isr_ins_dt;
	}

	public String getFap_job_isr_udt_id() {
		return fap_job_isr_udt_id;
	}

	public void setFap_job_isr_udt_id(String fap_job_isr_udt_id) {
		this.fap_job_isr_udt_id = fap_job_isr_udt_id;
	}

	public String getFap_job_isr_udt_dt() {
		return fap_job_isr_udt_dt;
	}

	public void setFap_job_isr_udt_dt(String fap_job_isr_udt_dt) {
		this.fap_job_isr_udt_dt = fap_job_isr_udt_dt;
	}
	
	public List<SocietyFapJobIsr> getJobIsrList() {
		return jobIsrList;
	}

	public void setJobIsrList(List<SocietyFapJobIsr> jobIsrList) {
		this.jobIsrList = jobIsrList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobIsr [fap_job_isr_seq=" + fap_job_isr_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_isr_gb=" + fap_job_isr_gb + ", fap_job_isr_ins_id=" + fap_job_isr_ins_id
				+ ", fap_job_isr_ins_dt=" + fap_job_isr_ins_dt + ", fap_job_isr_udt_id=" + fap_job_isr_udt_id
				+ ", fap_job_isr_udt_dt=" + fap_job_isr_udt_dt + ", jobIsrList=" + jobIsrList + "]";
	}

}
