/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 PR 정보
 * 
 */
public class SocietyFapUserResumeProfile {
	
	/**
	 * 이력서 프로젝트 일련번호
	 */
	private long fap_resume_pr_seq;
	
	/**
	 * 이력서 일련번호
	 */
	private long fap_resume_seq;
	
	/**
	 * PR 구분(공통코드)
	 */
	private String fap_resume_pr_gb;

	/**
	 * 내용
	 */
	private String fap_resume_pr_content;
	
	/**
	 * 등록자
	 */
	private String fap_resume_pr_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_pr_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_pr_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_pr_udt_dt;

	/**
	 * PR 리스트
	 */
	private List<SocietyFapUserResumeProfile> resumeProfileList;
	
	public SocietyFapUserResumeProfile() {
		super();
	}

	public SocietyFapUserResumeProfile(long fap_resume_pr_seq, long fap_resume_seq, String fap_resume_pr_gb,
			String fap_resume_pr_content, String fap_resume_pr_ins_id, String fap_resume_pr_ins_dt,
			String fap_resume_pr_udt_id, String fap_resume_pr_udt_dt, List<SocietyFapUserResumeProfile> resumeProfileList) {
		super();
		this.fap_resume_pr_seq = fap_resume_pr_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_pr_gb = fap_resume_pr_gb;
		this.fap_resume_pr_content = fap_resume_pr_content;
		this.fap_resume_pr_ins_id = fap_resume_pr_ins_id;
		this.fap_resume_pr_ins_dt = fap_resume_pr_ins_dt;
		this.fap_resume_pr_udt_id = fap_resume_pr_udt_id;
		this.fap_resume_pr_udt_dt = fap_resume_pr_udt_dt;
		this.resumeProfileList = resumeProfileList;
	}

	public long getFap_resume_pr_seq() {
		return fap_resume_pr_seq;
	}

	public void setFap_resume_pr_seq(long fap_resume_pr_seq) {
		this.fap_resume_pr_seq = fap_resume_pr_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_pr_gb() {
		return fap_resume_pr_gb;
	}

	public void setFap_resume_pr_gb(String fap_resume_pr_gb) {
		this.fap_resume_pr_gb = fap_resume_pr_gb;
	}

	public String getFap_resume_pr_content() {
		return fap_resume_pr_content;
	}

	public void setFap_resume_pr_content(String fap_resume_pr_content) {
		this.fap_resume_pr_content = fap_resume_pr_content;
	}

	public String getFap_resume_pr_ins_id() {
		return fap_resume_pr_ins_id;
	}

	public void setFap_resume_pr_ins_id(String fap_resume_pr_ins_id) {
		this.fap_resume_pr_ins_id = fap_resume_pr_ins_id;
	}

	public String getFap_resume_pr_ins_dt() {
		return fap_resume_pr_ins_dt;
	}

	public void setFap_resume_pr_ins_dt(String fap_resume_pr_ins_dt) {
		this.fap_resume_pr_ins_dt = fap_resume_pr_ins_dt;
	}

	public String getFap_resume_pr_udt_id() {
		return fap_resume_pr_udt_id;
	}

	public void setFap_resume_pr_udt_id(String fap_resume_pr_udt_id) {
		this.fap_resume_pr_udt_id = fap_resume_pr_udt_id;
	}

	public String getFap_resume_pr_udt_dt() {
		return fap_resume_pr_udt_dt;
	}

	public void setFap_resume_pr_udt_dt(String fap_resume_pr_udt_dt) {
		this.fap_resume_pr_udt_dt = fap_resume_pr_udt_dt;
	}

	public List<SocietyFapUserResumeProfile> getResumeProfileList() {
		return resumeProfileList;
	}

	public void setResumeProfileList(List<SocietyFapUserResumeProfile> resumeProfileList) {
		this.resumeProfileList = resumeProfileList;
	}

	@Override
	public String toString() {
		return "ResumeProfile [fap_resume_pr_seq=" + fap_resume_pr_seq + ", fap_resume_seq=" + fap_resume_seq
				+ ", fap_resume_pr_gb=" + fap_resume_pr_gb + ", fap_resume_pr_content=" + fap_resume_pr_content
				+ ", fap_resume_pr_ins_id=" + fap_resume_pr_ins_id + ", fap_resume_pr_ins_dt=" + fap_resume_pr_ins_dt
				+ ", fap_resume_pr_udt_id=" + fap_resume_pr_udt_id + ", fap_resume_pr_udt_dt=" + fap_resume_pr_udt_dt
				+ ", resumeProfileList=" + resumeProfileList + "]";
	}

}
