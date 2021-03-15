/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 근무예정지 정보
 * 
 */
public class SocietyFapJobWorkplace {
	/**
	 * 근무예정지 시퀀스
	 */
	private long fap_job_workplace_seq;
	
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 근무예정지(공통코드)
	 */
	private String fap_job_workplace_gb;
	
	/**
	 * 등록자
	 */
	private String fap_job_workplace_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_workplace_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_workplace_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_workplace_udt_dt;

	private List<SocietyFapJobWorkplace> jobWorkplaceList;
	
	private SocietyFapJobWorkplaceDtl jobWorkplaceDtl;
	
	private SocietyFapJobWorkplaceEtc JobWorkplaceEtc;
	
	public SocietyFapJobWorkplace() {
		super();
	}

	public SocietyFapJobWorkplace(long fap_job_workplace_seq, long fap_job_ad_seq, String fap_job_workplace_gb,
			String fap_job_workplace_ins_id, String fap_job_workplace_ins_dt, String fap_job_workplace_udt_id,
			String fap_job_workplace_udt_dt, List<SocietyFapJobWorkplace> jobWorkplaceList,
			SocietyFapJobWorkplaceDtl jobWorkplaceDtl, SocietyFapJobWorkplaceEtc jobWorkplaceEtc) {
		super();
		this.fap_job_workplace_seq = fap_job_workplace_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_workplace_gb = fap_job_workplace_gb;
		this.fap_job_workplace_ins_id = fap_job_workplace_ins_id;
		this.fap_job_workplace_ins_dt = fap_job_workplace_ins_dt;
		this.fap_job_workplace_udt_id = fap_job_workplace_udt_id;
		this.fap_job_workplace_udt_dt = fap_job_workplace_udt_dt;
		this.jobWorkplaceList = jobWorkplaceList;
		this.jobWorkplaceDtl = jobWorkplaceDtl;
		JobWorkplaceEtc = jobWorkplaceEtc;
	}

	public long getFap_job_workplace_seq() {
		return fap_job_workplace_seq;
	}

	public void setFap_job_workplace_seq(long fap_job_workplace_seq) {
		this.fap_job_workplace_seq = fap_job_workplace_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_workplace_gb() {
		return fap_job_workplace_gb;
	}

	public void setFap_job_workplace_gb(String fap_job_workplace_gb) {
		this.fap_job_workplace_gb = fap_job_workplace_gb;
	}

	public String getFap_job_workplace_ins_id() {
		return fap_job_workplace_ins_id;
	}

	public void setFap_job_workplace_ins_id(String fap_job_workplace_ins_id) {
		this.fap_job_workplace_ins_id = fap_job_workplace_ins_id;
	}

	public String getFap_job_workplace_ins_dt() {
		return fap_job_workplace_ins_dt;
	}

	public void setFap_job_workplace_ins_dt(String fap_job_workplace_ins_dt) {
		this.fap_job_workplace_ins_dt = fap_job_workplace_ins_dt;
	}

	public String getFap_job_workplace_udt_id() {
		return fap_job_workplace_udt_id;
	}

	public void setFap_job_workplace_udt_id(String fap_job_workplace_udt_id) {
		this.fap_job_workplace_udt_id = fap_job_workplace_udt_id;
	}

	public String getFap_job_workplace_udt_dt() {
		return fap_job_workplace_udt_dt;
	}

	public void setFap_job_workplace_udt_dt(String fap_job_workplace_udt_dt) {
		this.fap_job_workplace_udt_dt = fap_job_workplace_udt_dt;
	}

	public List<SocietyFapJobWorkplace> getJobWorkplaceList() {
		return jobWorkplaceList;
	}

	public void setJobWorkplaceList(List<SocietyFapJobWorkplace> jobWorkplaceList) {
		this.jobWorkplaceList = jobWorkplaceList;
	}

	public SocietyFapJobWorkplaceDtl getJobWorkplaceDtl() {
		return jobWorkplaceDtl;
	}

	public void setJobWorkplaceDtl(SocietyFapJobWorkplaceDtl jobWorkplaceDtl) {
		this.jobWorkplaceDtl = jobWorkplaceDtl;
	}

	public SocietyFapJobWorkplaceEtc getJobWorkplaceEtc() {
		return JobWorkplaceEtc;
	}

	public void setJobWorkplaceEtc(SocietyFapJobWorkplaceEtc jobWorkplaceEtc) {
		JobWorkplaceEtc = jobWorkplaceEtc;
	}

	@Override
	public String toString() {
		return "SocietyFapJobWorkplace [fap_job_workplace_seq=" + fap_job_workplace_seq + ", fap_job_ad_seq="
				+ fap_job_ad_seq + ", fap_job_workplace_gb=" + fap_job_workplace_gb + ", fap_job_workplace_ins_id="
				+ fap_job_workplace_ins_id + ", fap_job_workplace_ins_dt=" + fap_job_workplace_ins_dt
				+ ", fap_job_workplace_udt_id=" + fap_job_workplace_udt_id + ", fap_job_workplace_udt_dt="
				+ fap_job_workplace_udt_dt + ", jobWorkplaceList=" + jobWorkplaceList + ", jobWorkplaceDtl="
				+ jobWorkplaceDtl + ", JobWorkplaceEtc=" + JobWorkplaceEtc + "]";
	}

}
