/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 학력/관련 교육정보
 * 
 */
public class SocietyFapUserResumeEduhistory {
	
	/**
	 * 이력서 학력 일련번호
	 */
	private long fap_resume_edu_seq;
	
	/**
	 * 이력서 일련 번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 기관명/학교명
	 */
	private String fap_resume_edu_sc_nm;

	/**
	 * 단과/과정명
	 */
	private String fap_resume_edu_coll;
	
	/**
	 * 전공
	 */
	private String fap_resume_edu_major;
	
	/**
	 * 졸업여부
	 */
	private String fap_resume_edu_gd_ck;
	
	/**
	 * 입학일
	 */
	private String fap_resume_edu_er_dt;
	
	/**
	 * 졸업일
	 */
	private String fap_resume_edu_gd_dt;
	
	/**
	 * 기간요약(연도)
	 */
	private String fap_resume_edu_pd_summary;
	
	/**
	 * 비고
	 */
	private String fap_resume_edu_note;
	
	/**
	 * 전공계열
	 */
	private String fap_resume_edu_field;
	
	/**
	 * 등록자
	 */
	private String fap_resume_edu_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_edu_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_edu_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_edu_udt_dt;
	
	/**
	 * 학력/관련 교육정보 리스트
	 */
	private List<SocietyFapUserResumeEduhistory> resumeEduList;
	
	public SocietyFapUserResumeEduhistory() {
		super();
	}

	public SocietyFapUserResumeEduhistory(long fap_resume_edu_seq, long fap_resume_seq, String fap_resume_edu_sc_nm,
			String fap_resume_edu_coll, String fap_resume_edu_major, String fap_resume_edu_gd_ck,
			String fap_resume_edu_er_dt, String fap_resume_edu_gd_dt, String fap_resume_edu_pd_summary,
			String fap_resume_edu_note, String fap_resume_edu_field, String fap_resume_edu_ins_id,
			String fap_resume_edu_ins_dt, String fap_resume_edu_udt_id, String fap_resume_edu_udt_dt,
			List<SocietyFapUserResumeEduhistory> resumeEduList) {
		super();
		this.fap_resume_edu_seq = fap_resume_edu_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_edu_sc_nm = fap_resume_edu_sc_nm;
		this.fap_resume_edu_coll = fap_resume_edu_coll;
		this.fap_resume_edu_major = fap_resume_edu_major;
		this.fap_resume_edu_gd_ck = fap_resume_edu_gd_ck;
		this.fap_resume_edu_er_dt = fap_resume_edu_er_dt;
		this.fap_resume_edu_gd_dt = fap_resume_edu_gd_dt;
		this.fap_resume_edu_pd_summary = fap_resume_edu_pd_summary;
		this.fap_resume_edu_note = fap_resume_edu_note;
		this.fap_resume_edu_field = fap_resume_edu_field;
		this.fap_resume_edu_ins_id = fap_resume_edu_ins_id;
		this.fap_resume_edu_ins_dt = fap_resume_edu_ins_dt;
		this.fap_resume_edu_udt_id = fap_resume_edu_udt_id;
		this.fap_resume_edu_udt_dt = fap_resume_edu_udt_dt;
		this.resumeEduList = resumeEduList;
	}

	public long getFap_resume_edu_seq() {
		return fap_resume_edu_seq;
	}

	public void setFap_resume_edu_seq(long fap_resume_edu_seq) {
		this.fap_resume_edu_seq = fap_resume_edu_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_edu_sc_nm() {
		return fap_resume_edu_sc_nm;
	}

	public void setFap_resume_edu_sc_nm(String fap_resume_edu_sc_nm) {
		this.fap_resume_edu_sc_nm = fap_resume_edu_sc_nm;
	}

	public String getFap_resume_edu_coll() {
		return fap_resume_edu_coll;
	}

	public void setFap_resume_edu_coll(String fap_resume_edu_coll) {
		this.fap_resume_edu_coll = fap_resume_edu_coll;
	}

	public String getFap_resume_edu_major() {
		return fap_resume_edu_major;
	}

	public void setFap_resume_edu_major(String fap_resume_edu_major) {
		this.fap_resume_edu_major = fap_resume_edu_major;
	}

	public String getFap_resume_edu_gd_ck() {
		return fap_resume_edu_gd_ck;
	}

	public void setFap_resume_edu_gd_ck(String fap_resume_edu_gd_ck) {
		this.fap_resume_edu_gd_ck = fap_resume_edu_gd_ck;
	}

	public String getFap_resume_edu_er_dt() {
		return fap_resume_edu_er_dt;
	}

	public void setFap_resume_edu_er_dt(String fap_resume_edu_er_dt) {
		this.fap_resume_edu_er_dt = fap_resume_edu_er_dt;
	}

	public String getFap_resume_edu_gd_dt() {
		return fap_resume_edu_gd_dt;
	}

	public void setFap_resume_edu_gd_dt(String fap_resume_edu_gd_dt) {
		this.fap_resume_edu_gd_dt = fap_resume_edu_gd_dt;
	}

	public String getFap_resume_edu_pd_summary() {
		return fap_resume_edu_pd_summary;
	}

	public void setFap_resume_edu_pd_summary(String fap_resume_edu_pd_summary) {
		this.fap_resume_edu_pd_summary = fap_resume_edu_pd_summary;
	}

	public String getFap_resume_edu_note() {
		return fap_resume_edu_note;
	}

	public void setFap_resume_edu_note(String fap_resume_edu_note) {
		this.fap_resume_edu_note = fap_resume_edu_note;
	}

	public String getFap_resume_edu_field() {
		return fap_resume_edu_field;
	}

	public void setFap_resume_edu_field(String fap_resume_edu_field) {
		this.fap_resume_edu_field = fap_resume_edu_field;
	}

	public String getFap_resume_edu_ins_id() {
		return fap_resume_edu_ins_id;
	}

	public void setFap_resume_edu_ins_id(String fap_resume_edu_ins_id) {
		this.fap_resume_edu_ins_id = fap_resume_edu_ins_id;
	}

	public String getFap_resume_edu_ins_dt() {
		return fap_resume_edu_ins_dt;
	}

	public void setFap_resume_edu_ins_dt(String fap_resume_edu_ins_dt) {
		this.fap_resume_edu_ins_dt = fap_resume_edu_ins_dt;
	}

	public String getFap_resume_edu_udt_id() {
		return fap_resume_edu_udt_id;
	}

	public void setFap_resume_edu_udt_id(String fap_resume_edu_udt_id) {
		this.fap_resume_edu_udt_id = fap_resume_edu_udt_id;
	}

	public String getFap_resume_edu_udt_dt() {
		return fap_resume_edu_udt_dt;
	}

	public void setFap_resume_edu_udt_dt(String fap_resume_edu_udt_dt) {
		this.fap_resume_edu_udt_dt = fap_resume_edu_udt_dt;
	}

	public List<SocietyFapUserResumeEduhistory> getResumeEduList() {
		return resumeEduList;
	}

	public void setResumeEduList(List<SocietyFapUserResumeEduhistory> resumeEduList) {
		this.resumeEduList = resumeEduList;
	}

	@Override
	public String toString() {
		return "ResumeEduhistory [fap_resume_edu_seq=" + fap_resume_edu_seq + ", fap_resume_seq=" + fap_resume_seq
				+ ", fap_resume_edu_sc_nm=" + fap_resume_edu_sc_nm + ", fap_resume_edu_coll=" + fap_resume_edu_coll
				+ ", fap_resume_edu_major=" + fap_resume_edu_major + ", fap_resume_edu_gd_ck=" + fap_resume_edu_gd_ck
				+ ", fap_resume_edu_er_dt=" + fap_resume_edu_er_dt + ", fap_resume_edu_gd_dt=" + fap_resume_edu_gd_dt
				+ ", fap_resume_edu_pd_summary=" + fap_resume_edu_pd_summary + ", fap_resume_edu_note="
				+ fap_resume_edu_note + ", fap_resume_edu_field=" + fap_resume_edu_field + ", fap_resume_edu_ins_id="
				+ fap_resume_edu_ins_id + ", fap_resume_edu_ins_dt=" + fap_resume_edu_ins_dt
				+ ", fap_resume_edu_udt_id=" + fap_resume_edu_udt_id + ", fap_resume_edu_udt_dt="
				+ fap_resume_edu_udt_dt + ", resumeEduList=" + resumeEduList + "]";
	}
	
}
