/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 회사명 정보
 * 
 */
public class SocietyFapJobComp {
	/**
	 * 회사명 시퀀스
	 */
	private long fap_job_comp_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 채용공고 회사명
	 */
	private String fap_job_comp_nm;
	
	/**
	 * 언어구분(공통코드)
	 */
	private String fap_job_comp_gb;
	
	/**
	 * 등록자
	 */
	private String fap_job_comp_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_comp_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_comp_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_comp_udt_dt;
	
	/**
	 * 회사명 리스트
	 */
	private List<SocietyFapJobComp> jobCompList;

	public SocietyFapJobComp() {
		super();
	}

	public SocietyFapJobComp(long fap_job_comp_seq, long fap_job_ad_seq, String fap_job_comp_nm, String fap_job_comp_gb,
			String fap_job_comp_ins_id, String fap_job_comp_ins_dt, String fap_job_comp_udt_id,
			String fap_job_comp_udt_dt, List<SocietyFapJobComp> jobCompList) {
		super();
		this.fap_job_comp_seq = fap_job_comp_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_comp_nm = fap_job_comp_nm;
		this.fap_job_comp_gb = fap_job_comp_gb;
		this.fap_job_comp_ins_id = fap_job_comp_ins_id;
		this.fap_job_comp_ins_dt = fap_job_comp_ins_dt;
		this.fap_job_comp_udt_id = fap_job_comp_udt_id;
		this.fap_job_comp_udt_dt = fap_job_comp_udt_dt;
		this.jobCompList = jobCompList;
	}

	public long getFap_job_comp_seq() {
		return fap_job_comp_seq;
	}

	public void setFap_job_comp_seq(long fap_job_comp_seq) {
		this.fap_job_comp_seq = fap_job_comp_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_comp_nm() {
		return fap_job_comp_nm;
	}

	public void setFap_job_comp_nm(String fap_job_comp_nm) {
		this.fap_job_comp_nm = fap_job_comp_nm;
	}

	public String getFap_job_comp_gb() {
		return fap_job_comp_gb;
	}

	public void setFap_job_comp_gb(String fap_job_comp_gb) {
		this.fap_job_comp_gb = fap_job_comp_gb;
	}

	public String getFap_job_comp_ins_id() {
		return fap_job_comp_ins_id;
	}

	public void setFap_job_comp_ins_id(String fap_job_comp_ins_id) {
		this.fap_job_comp_ins_id = fap_job_comp_ins_id;
	}

	public String getFap_job_comp_ins_dt() {
		return fap_job_comp_ins_dt;
	}

	public void setFap_job_comp_ins_dt(String fap_job_comp_ins_dt) {
		this.fap_job_comp_ins_dt = fap_job_comp_ins_dt;
	}

	public String getFap_job_comp_udt_id() {
		return fap_job_comp_udt_id;
	}

	public void setFap_job_comp_udt_id(String fap_job_comp_udt_id) {
		this.fap_job_comp_udt_id = fap_job_comp_udt_id;
	}

	public String getFap_job_comp_udt_dt() {
		return fap_job_comp_udt_dt;
	}

	public void setFap_job_comp_udt_dt(String fap_job_comp_udt_dt) {
		this.fap_job_comp_udt_dt = fap_job_comp_udt_dt;
	}

	public List<SocietyFapJobComp> getJobCompList() {
		return jobCompList;
	}

	public void setJobCompList(List<SocietyFapJobComp> jobCompList) {
		this.jobCompList = jobCompList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobComp [fap_job_comp_seq=" + fap_job_comp_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_comp_nm=" + fap_job_comp_nm + ", fap_job_comp_gb=" + fap_job_comp_gb
				+ ", fap_job_comp_ins_id=" + fap_job_comp_ins_id + ", fap_job_comp_ins_dt=" + fap_job_comp_ins_dt
				+ ", fap_job_comp_udt_id=" + fap_job_comp_udt_id + ", fap_job_comp_udt_dt=" + fap_job_comp_udt_dt
				+ ", jobCompList=" + jobCompList + "]";
	}

}
