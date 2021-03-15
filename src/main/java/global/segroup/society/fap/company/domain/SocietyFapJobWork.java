/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 채용공고 주요업무정보
 * 
 */
public class SocietyFapJobWork {
	/**
	 * 주요업무정보 시퀀스
	 */
	private long fap_job_work_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 주요업무구분(공통코드)
	 */
	private String fap_job_work_gb;
	
	/**
	 * 업무내용
	 */
	private String fap_job_work_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_work_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_work_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_work_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_work_udt_dt;
	
	private List<SocietyFapJobWork> jobWorkList;

	public SocietyFapJobWork() {
		super();
	}

	public SocietyFapJobWork(long fap_job_work_seq, long fap_job_ad_seq, String fap_job_work_gb,
			String fap_job_work_dtl, String fap_job_work_ins_id, String fap_job_work_ins_dt, String fap_job_work_udt_id,
			String fap_job_work_udt_dt, List<SocietyFapJobWork> jobWorkList) {
		super();
		this.fap_job_work_seq = fap_job_work_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_work_gb = fap_job_work_gb;
		this.fap_job_work_dtl = fap_job_work_dtl;
		this.fap_job_work_ins_id = fap_job_work_ins_id;
		this.fap_job_work_ins_dt = fap_job_work_ins_dt;
		this.fap_job_work_udt_id = fap_job_work_udt_id;
		this.fap_job_work_udt_dt = fap_job_work_udt_dt;
		this.jobWorkList = jobWorkList;
	}

	public long getFap_job_work_seq() {
		return fap_job_work_seq;
	}

	public void setFap_job_work_seq(long fap_job_work_seq) {
		this.fap_job_work_seq = fap_job_work_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_work_gb() {
		return fap_job_work_gb;
	}

	public void setFap_job_work_gb(String fap_job_work_gb) {
		this.fap_job_work_gb = fap_job_work_gb;
	}

	public String getFap_job_work_dtl() {
		return fap_job_work_dtl;
	}

	public void setFap_job_work_dtl(String fap_job_work_dtl) {
		this.fap_job_work_dtl = fap_job_work_dtl;
	}

	public String getFap_job_work_ins_id() {
		return fap_job_work_ins_id;
	}

	public void setFap_job_work_ins_id(String fap_job_work_ins_id) {
		this.fap_job_work_ins_id = fap_job_work_ins_id;
	}

	public String getFap_job_work_ins_dt() {
		return fap_job_work_ins_dt;
	}

	public void setFap_job_work_ins_dt(String fap_job_work_ins_dt) {
		this.fap_job_work_ins_dt = fap_job_work_ins_dt;
	}

	public String getFap_job_work_udt_id() {
		return fap_job_work_udt_id;
	}

	public void setFap_job_work_udt_id(String fap_job_work_udt_id) {
		this.fap_job_work_udt_id = fap_job_work_udt_id;
	}

	public String getFap_job_work_udt_dt() {
		return fap_job_work_udt_dt;
	}

	public void setFap_job_work_udt_dt(String fap_job_work_udt_dt) {
		this.fap_job_work_udt_dt = fap_job_work_udt_dt;
	}

	public List<SocietyFapJobWork> getJobWorkList() {
		return jobWorkList;
	}

	public void setJobWorkList(List<SocietyFapJobWork> jobWorkList) {
		this.jobWorkList = jobWorkList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobWork [fap_job_work_seq=" + fap_job_work_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_work_gb=" + fap_job_work_gb + ", fap_job_work_dtl=" + fap_job_work_dtl
				+ ", fap_job_work_ins_id=" + fap_job_work_ins_id + ", fap_job_work_ins_dt=" + fap_job_work_ins_dt
				+ ", fap_job_work_udt_id=" + fap_job_work_udt_id + ", fap_job_work_udt_dt=" + fap_job_work_udt_dt
				+ ", jobWorkList=" + jobWorkList + "]";
	}

}
