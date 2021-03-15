/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 모집직종정보
 * 
 */
public class SocietyFapJobCategory {
	/**
	 * 모집직종 시퀀스
	 */
	private long fap_job_category_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 직종분류(공통코드)
	 */
	private String fap_job_category_gb;
	
	/**
	 * 등록자
	 */
	private String fap_job_category_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_category_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_category_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_category_udt_dt;
	
	private List<SocietyFapJobCategory> jobCategoryList;

	private SocietyFapJobCategoryEtc JobCategoryEtc;
	
	public SocietyFapJobCategory() {
		super();
	}

	public SocietyFapJobCategory(long fap_job_category_seq, long fap_job_ad_seq, String fap_job_category_gb,
			String fap_job_category_ins_id, String fap_job_category_ins_dt, String fap_job_category_udt_id,
			String fap_job_category_udt_dt, List<SocietyFapJobCategory> jobCategoryList,
			SocietyFapJobCategoryEtc jobCategoryEtc) {
		super();
		this.fap_job_category_seq = fap_job_category_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_category_gb = fap_job_category_gb;
		this.fap_job_category_ins_id = fap_job_category_ins_id;
		this.fap_job_category_ins_dt = fap_job_category_ins_dt;
		this.fap_job_category_udt_id = fap_job_category_udt_id;
		this.fap_job_category_udt_dt = fap_job_category_udt_dt;
		this.jobCategoryList = jobCategoryList;
		JobCategoryEtc = jobCategoryEtc;
	}

	public long getFap_job_category_seq() {
		return fap_job_category_seq;
	}

	public void setFap_job_category_seq(long fap_job_category_seq) {
		this.fap_job_category_seq = fap_job_category_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_category_gb() {
		return fap_job_category_gb;
	}

	public void setFap_job_category_gb(String fap_job_category_gb) {
		this.fap_job_category_gb = fap_job_category_gb;
	}

	public String getFap_job_category_ins_id() {
		return fap_job_category_ins_id;
	}

	public void setFap_job_category_ins_id(String fap_job_category_ins_id) {
		this.fap_job_category_ins_id = fap_job_category_ins_id;
	}

	public String getFap_job_category_ins_dt() {
		return fap_job_category_ins_dt;
	}

	public void setFap_job_category_ins_dt(String fap_job_category_ins_dt) {
		this.fap_job_category_ins_dt = fap_job_category_ins_dt;
	}

	public String getFap_job_category_udt_id() {
		return fap_job_category_udt_id;
	}

	public void setFap_job_category_udt_id(String fap_job_category_udt_id) {
		this.fap_job_category_udt_id = fap_job_category_udt_id;
	}

	public String getFap_job_category_udt_dt() {
		return fap_job_category_udt_dt;
	}

	public void setFap_job_category_udt_dt(String fap_job_category_udt_dt) {
		this.fap_job_category_udt_dt = fap_job_category_udt_dt;
	}

	public List<SocietyFapJobCategory> getJobCategoryList() {
		return jobCategoryList;
	}

	public void setJobCategoryList(List<SocietyFapJobCategory> jobCategoryList) {
		this.jobCategoryList = jobCategoryList;
	}

	public SocietyFapJobCategoryEtc getJobCategoryEtc() {
		return JobCategoryEtc;
	}

	public void setJobCategoryEtc(SocietyFapJobCategoryEtc jobCategoryEtc) {
		JobCategoryEtc = jobCategoryEtc;
	}

	@Override
	public String toString() {
		return "SocietyFapJobCategory [fap_job_category_seq=" + fap_job_category_seq + ", fap_job_ad_seq="
				+ fap_job_ad_seq + ", fap_job_category_gb=" + fap_job_category_gb + ", fap_job_category_ins_id="
				+ fap_job_category_ins_id + ", fap_job_category_ins_dt=" + fap_job_category_ins_dt
				+ ", fap_job_category_udt_id=" + fap_job_category_udt_id + ", fap_job_category_udt_dt="
				+ fap_job_category_udt_dt + ", jobCategoryList=" + jobCategoryList + ", JobCategoryEtc="
				+ JobCategoryEtc + "]";
	}

}
