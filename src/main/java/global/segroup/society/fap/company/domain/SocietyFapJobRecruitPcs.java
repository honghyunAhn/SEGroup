/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 채용전형 정보
 * 
 */
public class SocietyFapJobRecruitPcs {
	/**
	 * 채용전형 시퀀스
	 */
	private long fap_job_recruit_pcs_seq;
	
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 전형구분(공통코드)
	 */
	private String fap_job_recruit_pcs_gb;
	
	/**
	 * 상세내용
	 */
	private String fap_job_recruit_pcs_dtl;
	
	/**
	 * 전형순서
	 */
	private int fap_job_recruit_pcs_od;
	
	/**
	 * 등록자
	 */
	private String fap_job_recruit_pcs_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_recruit_pcs_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_recruit_pcs_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_recruit_pcs_udt_dt;
	
	private List<SocietyFapJobRecruitPcs> jobRecruitPcsList;
	
	private SocietyFapJobExam jobExam;

	private SocietyFapJobItv jobItv;
	
	private SocietyFapJobTestEtc jobTestEtc;
	
	public SocietyFapJobRecruitPcs() {
		super();
	}

	public SocietyFapJobRecruitPcs(long fap_job_recruit_pcs_seq, long fap_job_ad_seq, String fap_job_recruit_pcs_gb,
			String fap_job_recruit_pcs_dtl, int fap_job_recruit_pcs_od, String fap_job_recruit_pcs_ins_id,
			String fap_job_recruit_pcs_ins_dt, String fap_job_recruit_pcs_udt_id, String fap_job_recruit_pcs_udt_dt,
			List<SocietyFapJobRecruitPcs> jobRecruitPcsList, SocietyFapJobExam jobExam, SocietyFapJobItv jobItv,
			SocietyFapJobTestEtc jobTestEtc) {
		super();
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_recruit_pcs_gb = fap_job_recruit_pcs_gb;
		this.fap_job_recruit_pcs_dtl = fap_job_recruit_pcs_dtl;
		this.fap_job_recruit_pcs_od = fap_job_recruit_pcs_od;
		this.fap_job_recruit_pcs_ins_id = fap_job_recruit_pcs_ins_id;
		this.fap_job_recruit_pcs_ins_dt = fap_job_recruit_pcs_ins_dt;
		this.fap_job_recruit_pcs_udt_id = fap_job_recruit_pcs_udt_id;
		this.fap_job_recruit_pcs_udt_dt = fap_job_recruit_pcs_udt_dt;
		this.jobRecruitPcsList = jobRecruitPcsList;
		this.jobExam = jobExam;
		this.jobItv = jobItv;
		this.jobTestEtc = jobTestEtc;
	}

	public long getFap_job_recruit_pcs_seq() {
		return fap_job_recruit_pcs_seq;
	}

	public void setFap_job_recruit_pcs_seq(long fap_job_recruit_pcs_seq) {
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_recruit_pcs_gb() {
		return fap_job_recruit_pcs_gb;
	}

	public void setFap_job_recruit_pcs_gb(String fap_job_recruit_pcs_gb) {
		this.fap_job_recruit_pcs_gb = fap_job_recruit_pcs_gb;
	}

	public String getFap_job_recruit_pcs_dtl() {
		return fap_job_recruit_pcs_dtl;
	}

	public void setFap_job_recruit_pcs_dtl(String fap_job_recruit_pcs_dtl) {
		this.fap_job_recruit_pcs_dtl = fap_job_recruit_pcs_dtl;
	}

	public int getFap_job_recruit_pcs_od() {
		return fap_job_recruit_pcs_od;
	}

	public void setFap_job_recruit_pcs_od(int fap_job_recruit_pcs_od) {
		this.fap_job_recruit_pcs_od = fap_job_recruit_pcs_od;
	}

	public String getFap_job_recruit_pcs_ins_id() {
		return fap_job_recruit_pcs_ins_id;
	}

	public void setFap_job_recruit_pcs_ins_id(String fap_job_recruit_pcs_ins_id) {
		this.fap_job_recruit_pcs_ins_id = fap_job_recruit_pcs_ins_id;
	}

	public String getFap_job_recruit_pcs_ins_dt() {
		return fap_job_recruit_pcs_ins_dt;
	}

	public void setFap_job_recruit_pcs_ins_dt(String fap_job_recruit_pcs_ins_dt) {
		this.fap_job_recruit_pcs_ins_dt = fap_job_recruit_pcs_ins_dt;
	}

	public String getFap_job_recruit_pcs_udt_id() {
		return fap_job_recruit_pcs_udt_id;
	}

	public void setFap_job_recruit_pcs_udt_id(String fap_job_recruit_pcs_udt_id) {
		this.fap_job_recruit_pcs_udt_id = fap_job_recruit_pcs_udt_id;
	}

	public String getFap_job_recruit_pcs_udt_dt() {
		return fap_job_recruit_pcs_udt_dt;
	}

	public void setFap_job_recruit_pcs_udt_dt(String fap_job_recruit_pcs_udt_dt) {
		this.fap_job_recruit_pcs_udt_dt = fap_job_recruit_pcs_udt_dt;
	}

	public List<SocietyFapJobRecruitPcs> getJobRecruitPcsList() {
		return jobRecruitPcsList;
	}

	public void setJobRecruitPcsList(List<SocietyFapJobRecruitPcs> jobRecruitPcsList) {
		this.jobRecruitPcsList = jobRecruitPcsList;
	}

	public SocietyFapJobExam getJobExam() {
		return jobExam;
	}

	public void setJobExam(SocietyFapJobExam jobExam) {
		this.jobExam = jobExam;
	}

	public SocietyFapJobItv getJobItv() {
		return jobItv;
	}

	public void setJobItv(SocietyFapJobItv jobItv) {
		this.jobItv = jobItv;
	}

	public SocietyFapJobTestEtc getJobTestEtc() {
		return jobTestEtc;
	}

	public void setJobTestEtc(SocietyFapJobTestEtc jobTestEtc) {
		this.jobTestEtc = jobTestEtc;
	}

	@Override
	public String toString() {
		return "SocietyFapJobRecruitPcs [fap_job_recruit_pcs_seq=" + fap_job_recruit_pcs_seq + ", fap_job_ad_seq="
				+ fap_job_ad_seq + ", fap_job_recruit_pcs_gb=" + fap_job_recruit_pcs_gb + ", fap_job_recruit_pcs_dtl="
				+ fap_job_recruit_pcs_dtl + ", fap_job_recruit_pcs_od=" + fap_job_recruit_pcs_od
				+ ", fap_job_recruit_pcs_ins_id=" + fap_job_recruit_pcs_ins_id + ", fap_job_recruit_pcs_ins_dt="
				+ fap_job_recruit_pcs_ins_dt + ", fap_job_recruit_pcs_udt_id=" + fap_job_recruit_pcs_udt_id
				+ ", fap_job_recruit_pcs_udt_dt=" + fap_job_recruit_pcs_udt_dt + ", jobRecruitPcsList="
				+ jobRecruitPcsList + ", jobExam=" + jobExam + ", jobItv=" + jobItv + ", jobTestEtc=" + jobTestEtc
				+ "]";
	}

}
