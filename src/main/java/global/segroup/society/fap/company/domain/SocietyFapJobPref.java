/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 우대사항 정보
 * 
 */
public class SocietyFapJobPref {
	/**
	 * 우대사항 시퀀스
	 */
	private long fap_job_pref_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 우대사항 구분(공통코드)
	 */
	private String fap_job_pref_gb;
	
	/**
	 * 상세내용
	 */
	private String fap_job_pref_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_pref_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pref_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_pref_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pref_udt_dt;
	
	private List<SocietyFapJobPref> jobPrefList;

	public SocietyFapJobPref() {
		super();
	}

	public SocietyFapJobPref(long fap_job_pref_seq, long fap_job_ad_seq, String fap_job_pref_gb,
			String fap_job_pref_dtl, String fap_job_pref_ins_id, String fap_job_pref_ins_dt, String fap_job_pref_udt_id,
			String fap_job_pref_udt_dt, List<SocietyFapJobPref> jobPrefList) {
		super();
		this.fap_job_pref_seq = fap_job_pref_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_pref_gb = fap_job_pref_gb;
		this.fap_job_pref_dtl = fap_job_pref_dtl;
		this.fap_job_pref_ins_id = fap_job_pref_ins_id;
		this.fap_job_pref_ins_dt = fap_job_pref_ins_dt;
		this.fap_job_pref_udt_id = fap_job_pref_udt_id;
		this.fap_job_pref_udt_dt = fap_job_pref_udt_dt;
		this.jobPrefList = jobPrefList;
	}

	public long getFap_job_pref_seq() {
		return fap_job_pref_seq;
	}

	public void setFap_job_pref_seq(long fap_job_pref_seq) {
		this.fap_job_pref_seq = fap_job_pref_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_pref_gb() {
		return fap_job_pref_gb;
	}

	public void setFap_job_pref_gb(String fap_job_pref_gb) {
		this.fap_job_pref_gb = fap_job_pref_gb;
	}

	public String getFap_job_pref_dtl() {
		return fap_job_pref_dtl;
	}

	public void setFap_job_pref_dtl(String fap_job_pref_dtl) {
		this.fap_job_pref_dtl = fap_job_pref_dtl;
	}

	public String getFap_job_pref_ins_id() {
		return fap_job_pref_ins_id;
	}

	public void setFap_job_pref_ins_id(String fap_job_pref_ins_id) {
		this.fap_job_pref_ins_id = fap_job_pref_ins_id;
	}

	public String getFap_job_pref_ins_dt() {
		return fap_job_pref_ins_dt;
	}

	public void setFap_job_pref_ins_dt(String fap_job_pref_ins_dt) {
		this.fap_job_pref_ins_dt = fap_job_pref_ins_dt;
	}

	public String getFap_job_pref_udt_id() {
		return fap_job_pref_udt_id;
	}

	public void setFap_job_pref_udt_id(String fap_job_pref_udt_id) {
		this.fap_job_pref_udt_id = fap_job_pref_udt_id;
	}

	public String getFap_job_pref_udt_dt() {
		return fap_job_pref_udt_dt;
	}

	public void setFap_job_pref_udt_dt(String fap_job_pref_udt_dt) {
		this.fap_job_pref_udt_dt = fap_job_pref_udt_dt;
	}
	
	public List<SocietyFapJobPref> getJobPrefList() {
		return jobPrefList;
	}

	public void setJobPrefList(List<SocietyFapJobPref> jobPrefList) {
		this.jobPrefList = jobPrefList;
	}
	
	@Override
	public String toString() {
		return "SocietyFapJobPref [fap_job_pref_seq=" + fap_job_pref_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_pref_gb=" + fap_job_pref_gb + ", fap_job_pref_dtl=" + fap_job_pref_dtl
				+ ", fap_job_pref_ins_id=" + fap_job_pref_ins_id + ", fap_job_pref_ins_dt=" + fap_job_pref_ins_dt
				+ ", fap_job_pref_udt_id=" + fap_job_pref_udt_id + ", fap_job_pref_udt_dt=" + fap_job_pref_udt_dt
				+ ", jobPrefList=" + jobPrefList + "]";
	}
	
}
