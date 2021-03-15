/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 프로젝트 정보
 * 
 */
public class SocietyFapUserResumeProject {
	
	/**
	 * 이력서 프로젝트 일련번호
	 */
	private long fap_resume_project_seq;
	
	/**
	 * 이력서 일련 번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 프로젝트명
	 */
	private String fap_resume_project_nm;

	/**
	 * 주요서비스
	 */
	private String fap_resume_project_service;
	
	/**
	 * 개발 시작일(yyyyMMdd)
	 */
	private String fap_resume_project_st;
	
	/**
	 * 개발 종료일(yyyyMMdd)
	 */
	private String fap_resume_project_et;
	
	/**
	 * 기간요약(일수)
	 */
	private String fap_resume_project_pd_summary;
	
	/**
	 * 담당분야
	 */
	private String fap_resume_project_responsibility;
	
	/**
	 * 사용기술
	 */
	private String fap_resume_project_technique;
	
	/**
	 * 참여인원
	 */
	private int fap_resume_project_peoples_num;
	
	/**
	 * 등록자
	 */
	private String fap_resume_project_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_project_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_project_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_project_udt_dt;
	
	/**
	 * 프로젝트 리스트
	 */
	private List<SocietyFapUserResumeProject> resumeProjectList;
	
	public SocietyFapUserResumeProject() {
		super();
	}

	public SocietyFapUserResumeProject(long fap_resume_project_seq, long fap_resume_seq, String fap_resume_project_nm,
			String fap_resume_project_service, String fap_resume_project_st, String fap_resume_project_et,
			String fap_resume_project_pd_summary, String fap_resume_project_responsibility,
			String fap_resume_project_technique, int fap_resume_project_peoples_num, String fap_resume_project_ins_id,
			String fap_resume_project_ins_dt, String fap_resume_project_udt_id, String fap_resume_project_udt_dt,
			List<SocietyFapUserResumeProject> resumeProjectList) {
		super();
		this.fap_resume_project_seq = fap_resume_project_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_project_nm = fap_resume_project_nm;
		this.fap_resume_project_service = fap_resume_project_service;
		this.fap_resume_project_st = fap_resume_project_st;
		this.fap_resume_project_et = fap_resume_project_et;
		this.fap_resume_project_pd_summary = fap_resume_project_pd_summary;
		this.fap_resume_project_responsibility = fap_resume_project_responsibility;
		this.fap_resume_project_technique = fap_resume_project_technique;
		this.fap_resume_project_peoples_num = fap_resume_project_peoples_num;
		this.fap_resume_project_ins_id = fap_resume_project_ins_id;
		this.fap_resume_project_ins_dt = fap_resume_project_ins_dt;
		this.fap_resume_project_udt_id = fap_resume_project_udt_id;
		this.fap_resume_project_udt_dt = fap_resume_project_udt_dt;
		this.resumeProjectList = resumeProjectList;
	}

	public long getFap_resume_project_seq() {
		return fap_resume_project_seq;
	}

	public void setFap_resume_project_seq(long fap_resume_project_seq) {
		this.fap_resume_project_seq = fap_resume_project_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_project_nm() {
		return fap_resume_project_nm;
	}

	public void setFap_resume_project_nm(String fap_resume_project_nm) {
		this.fap_resume_project_nm = fap_resume_project_nm;
	}

	public String getFap_resume_project_service() {
		return fap_resume_project_service;
	}

	public void setFap_resume_project_service(String fap_resume_project_service) {
		this.fap_resume_project_service = fap_resume_project_service;
	}

	public String getFap_resume_project_st() {
		return fap_resume_project_st;
	}

	public void setFap_resume_project_st(String fap_resume_project_st) {
		this.fap_resume_project_st = fap_resume_project_st;
	}

	public String getFap_resume_project_et() {
		return fap_resume_project_et;
	}

	public void setFap_resume_project_et(String fap_resume_project_et) {
		this.fap_resume_project_et = fap_resume_project_et;
	}

	public String getFap_resume_project_pd_summary() {
		return fap_resume_project_pd_summary;
	}

	public void setFap_resume_project_pd_summary(String fap_resume_project_pd_summary) {
		this.fap_resume_project_pd_summary = fap_resume_project_pd_summary;
	}

	public String getFap_resume_project_responsibility() {
		return fap_resume_project_responsibility;
	}

	public void setFap_resume_project_responsibility(String fap_resume_project_responsibility) {
		this.fap_resume_project_responsibility = fap_resume_project_responsibility;
	}

	public String getFap_resume_project_technique() {
		return fap_resume_project_technique;
	}

	public void setFap_resume_project_technique(String fap_resume_project_technique) {
		this.fap_resume_project_technique = fap_resume_project_technique;
	}

	public int getFap_resume_project_peoples_num() {
		return fap_resume_project_peoples_num;
	}

	public void setFap_resume_project_peoples_num(int fap_resume_project_peoples_num) {
		this.fap_resume_project_peoples_num = fap_resume_project_peoples_num;
	}

	public String getFap_resume_project_ins_id() {
		return fap_resume_project_ins_id;
	}

	public void setFap_resume_project_ins_id(String fap_resume_project_ins_id) {
		this.fap_resume_project_ins_id = fap_resume_project_ins_id;
	}

	public String getFap_resume_project_ins_dt() {
		return fap_resume_project_ins_dt;
	}

	public void setFap_resume_project_ins_dt(String fap_resume_project_ins_dt) {
		this.fap_resume_project_ins_dt = fap_resume_project_ins_dt;
	}

	public String getFap_resume_project_udt_id() {
		return fap_resume_project_udt_id;
	}

	public void setFap_resume_project_udt_id(String fap_resume_project_udt_id) {
		this.fap_resume_project_udt_id = fap_resume_project_udt_id;
	}

	public String getFap_resume_project_udt_dt() {
		return fap_resume_project_udt_dt;
	}

	public void setFap_resume_project_udt_dt(String fap_resume_project_udt_dt) {
		this.fap_resume_project_udt_dt = fap_resume_project_udt_dt;
	}

	public List<SocietyFapUserResumeProject> getResumeProjectList() {
		return resumeProjectList;
	}

	public void setResumeProjectList(List<SocietyFapUserResumeProject> resumeProjectList) {
		this.resumeProjectList = resumeProjectList;
	}

	@Override
	public String toString() {
		return "SocietyFapUserResumeProject [fap_resume_project_seq=" + fap_resume_project_seq + ", fap_resume_seq="
				+ fap_resume_seq + ", fap_resume_project_nm=" + fap_resume_project_nm + ", fap_resume_project_service="
				+ fap_resume_project_service + ", fap_resume_project_st=" + fap_resume_project_st
				+ ", fap_resume_project_et=" + fap_resume_project_et + ", fap_resume_project_pd_summary="
				+ fap_resume_project_pd_summary + ", fap_resume_project_responsibility="
				+ fap_resume_project_responsibility + ", fap_resume_project_technique=" + fap_resume_project_technique
				+ ", fap_resume_project_peoples_num=" + fap_resume_project_peoples_num + ", fap_resume_project_ins_id="
				+ fap_resume_project_ins_id + ", fap_resume_project_ins_dt=" + fap_resume_project_ins_dt
				+ ", fap_resume_project_udt_id=" + fap_resume_project_udt_id + ", fap_resume_project_udt_dt="
				+ fap_resume_project_udt_dt + ", resumeProjectList=" + resumeProjectList + "]";
	}
	
}
