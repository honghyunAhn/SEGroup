/**
 * 
 */
package global.segroup.society.fap.user.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 사회 경력정보
 * 
 */
public class SocietyFapUserResumeCareer {
	
	/**
	 * 이력서 사회경력 일련번호
	 */
	private long fap_resume_crr_seq;
	
	/**
	 * 이력서 일련 번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 근무 시작일(yyyyMMdd)
	 */
	private String fap_resume_crr_st;

	/**
	 * 근무 종료일(yyyyMMdd)
	 */
	private String fap_resume_crr_et;
	
	/**
	 * 경력구분
	 */
	private String fap_resume_crr_gb;
	
	/**
	 * 기간요약(개월)
	 */
	private String fap_resume_crr_pd_summary;
	
	/**
	 * 회사명
	 */
	private String fap_resume_crr_comp_nm;
	
	/**
	 * 회사주요사업
	 */
	private String fap_resume_crr_major_bussiness;
	
	/**
	 * 담당업무
	 */
	private String fap_resume_crr_job_function;
	
	/**
	 * 직위
	 */
	private String fap_resume_crr_job_position;
	
	/**
	 * 등록자
	 */
	private String fap_resume_crr_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_crr_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_crr_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_crr_udt_dt;
	
	/**
	 * 사회 경력 리스트
	 */
	private List<SocietyFapUserResumeCareer> resumeCareerList;
	
	public SocietyFapUserResumeCareer() {
		super();
	}

	public SocietyFapUserResumeCareer(long fap_resume_crr_seq, long fap_resume_seq, String fap_resume_crr_st,
			String fap_resume_crr_et, String fap_resume_crr_gb, String fap_resume_crr_pd_summary,
			String fap_resume_crr_comp_nm, String fap_resume_crr_major_bussiness, String fap_resume_crr_job_function,
			String fap_resume_crr_job_position, String fap_resume_crr_ins_id, String fap_resume_crr_ins_dt,
			String fap_resume_crr_udt_id, String fap_resume_crr_udt_dt,
			List<SocietyFapUserResumeCareer> resumeCareerList) {
		super();
		this.fap_resume_crr_seq = fap_resume_crr_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_crr_st = fap_resume_crr_st;
		this.fap_resume_crr_et = fap_resume_crr_et;
		this.fap_resume_crr_gb = fap_resume_crr_gb;
		this.fap_resume_crr_pd_summary = fap_resume_crr_pd_summary;
		this.fap_resume_crr_comp_nm = fap_resume_crr_comp_nm;
		this.fap_resume_crr_major_bussiness = fap_resume_crr_major_bussiness;
		this.fap_resume_crr_job_function = fap_resume_crr_job_function;
		this.fap_resume_crr_job_position = fap_resume_crr_job_position;
		this.fap_resume_crr_ins_id = fap_resume_crr_ins_id;
		this.fap_resume_crr_ins_dt = fap_resume_crr_ins_dt;
		this.fap_resume_crr_udt_id = fap_resume_crr_udt_id;
		this.fap_resume_crr_udt_dt = fap_resume_crr_udt_dt;
		this.resumeCareerList = resumeCareerList;
	}

	public long getFap_resume_crr_seq() {
		return fap_resume_crr_seq;
	}

	public void setFap_resume_crr_seq(long fap_resume_crr_seq) {
		this.fap_resume_crr_seq = fap_resume_crr_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_crr_st() {
		return fap_resume_crr_st;
	}

	public void setFap_resume_crr_st(String fap_resume_crr_st) {
		this.fap_resume_crr_st = fap_resume_crr_st;
	}

	public String getFap_resume_crr_et() {
		return fap_resume_crr_et;
	}

	public void setFap_resume_crr_et(String fap_resume_crr_et) {
		this.fap_resume_crr_et = fap_resume_crr_et;
	}

	public String getFap_resume_crr_gb() {
		return fap_resume_crr_gb;
	}

	public void setFap_resume_crr_gb(String fap_resume_crr_gb) {
		this.fap_resume_crr_gb = fap_resume_crr_gb;
	}

	public String getFap_resume_crr_pd_summary() {
		return fap_resume_crr_pd_summary;
	}

	public void setFap_resume_crr_pd_summary(String fap_resume_crr_pd_summary) {
		this.fap_resume_crr_pd_summary = fap_resume_crr_pd_summary;
	}

	public String getFap_resume_crr_comp_nm() {
		return fap_resume_crr_comp_nm;
	}

	public void setFap_resume_crr_comp_nm(String fap_resume_crr_comp_nm) {
		this.fap_resume_crr_comp_nm = fap_resume_crr_comp_nm;
	}

	public String getFap_resume_crr_major_bussiness() {
		return fap_resume_crr_major_bussiness;
	}

	public void setFap_resume_crr_major_bussiness(String fap_resume_crr_major_bussiness) {
		this.fap_resume_crr_major_bussiness = fap_resume_crr_major_bussiness;
	}

	public String getFap_resume_crr_job_function() {
		return fap_resume_crr_job_function;
	}

	public void setFap_resume_crr_job_function(String fap_resume_crr_job_function) {
		this.fap_resume_crr_job_function = fap_resume_crr_job_function;
	}

	public String getFap_resume_crr_job_position() {
		return fap_resume_crr_job_position;
	}

	public void setFap_resume_crr_job_position(String fap_resume_crr_job_position) {
		this.fap_resume_crr_job_position = fap_resume_crr_job_position;
	}

	public String getFap_resume_crr_ins_id() {
		return fap_resume_crr_ins_id;
	}

	public void setFap_resume_crr_ins_id(String fap_resume_crr_ins_id) {
		this.fap_resume_crr_ins_id = fap_resume_crr_ins_id;
	}

	public String getFap_resume_crr_ins_dt() {
		return fap_resume_crr_ins_dt;
	}

	public void setFap_resume_crr_ins_dt(String fap_resume_crr_ins_dt) {
		this.fap_resume_crr_ins_dt = fap_resume_crr_ins_dt;
	}

	public String getFap_resume_crr_udt_id() {
		return fap_resume_crr_udt_id;
	}

	public void setFap_resume_crr_udt_id(String fap_resume_crr_udt_id) {
		this.fap_resume_crr_udt_id = fap_resume_crr_udt_id;
	}

	public String getFap_resume_crr_udt_dt() {
		return fap_resume_crr_udt_dt;
	}

	public void setFap_resume_crr_udt_dt(String fap_resume_crr_udt_dt) {
		this.fap_resume_crr_udt_dt = fap_resume_crr_udt_dt;
	}

	public List<SocietyFapUserResumeCareer> getResumeCareerList() {
		return resumeCareerList;
	}

	public void setResumeCareerList(List<SocietyFapUserResumeCareer> resumeCareerList) {
		this.resumeCareerList = resumeCareerList;
	}

	@Override
	public String toString() {
		return "SocietyFapUserResumeCareer [fap_resume_crr_seq=" + fap_resume_crr_seq + ", fap_resume_seq="
				+ fap_resume_seq + ", fap_resume_crr_st=" + fap_resume_crr_st + ", fap_resume_crr_et="
				+ fap_resume_crr_et + ", fap_resume_crr_gb=" + fap_resume_crr_gb + ", fap_resume_crr_pd_summary="
				+ fap_resume_crr_pd_summary + ", fap_resume_crr_comp_nm=" + fap_resume_crr_comp_nm
				+ ", fap_resume_crr_major_bussiness=" + fap_resume_crr_major_bussiness
				+ ", fap_resume_crr_job_function=" + fap_resume_crr_job_function + ", fap_resume_crr_job_position="
				+ fap_resume_crr_job_position + ", fap_resume_crr_ins_id=" + fap_resume_crr_ins_id
				+ ", fap_resume_crr_ins_dt=" + fap_resume_crr_ins_dt + ", fap_resume_crr_udt_id="
				+ fap_resume_crr_udt_id + ", fap_resume_crr_udt_dt=" + fap_resume_crr_udt_dt + ", resumeCareerList="
				+ resumeCareerList + "]";
	}
	
}
