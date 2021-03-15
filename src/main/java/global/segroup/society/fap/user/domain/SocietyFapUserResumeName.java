/**
 * 
 */
package global.segroup.society.fap.user.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 성명 정보 
 * 
 */
public class SocietyFapUserResumeName {
	
	/**
	 * 이력서 성명 일련번호
	 */
	private long fap_resume_nm_seq;
	
	/**
	 * 이력서 일련 번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 언어구분(공통코드)
	 */
	private String fap_resume_lang_gb;

	/**
	 * 성명
	 */
	private String fap_resume_nm;
	
	/**
	 * 등록자
	 */
	private String fap_resume_nm_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_nm_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_nm_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_nm_udt_dt;
	
	/**
	 * 성명 리스트 
	 */
	private List<SocietyFapUserResumeName> resumeNameList;

	public SocietyFapUserResumeName() {
		super();
	}

	public SocietyFapUserResumeName(long fap_resume_nm_seq, long fap_resume_seq, String fap_resume_lang_gb, String fap_resume_nm,
			String fap_resume_nm_ins_id, String fap_resume_nm_ins_dt, String fap_resume_nm_udt_id,
			String fap_resume_nm_udt_dt, List<SocietyFapUserResumeName> resumeNameList) {
		super();
		this.fap_resume_nm_seq = fap_resume_nm_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_lang_gb = fap_resume_lang_gb;
		this.fap_resume_nm = fap_resume_nm;
		this.fap_resume_nm_ins_id = fap_resume_nm_ins_id;
		this.fap_resume_nm_ins_dt = fap_resume_nm_ins_dt;
		this.fap_resume_nm_udt_id = fap_resume_nm_udt_id;
		this.fap_resume_nm_udt_dt = fap_resume_nm_udt_dt;
		this.resumeNameList = resumeNameList;
	}

	public long getFap_resume_nm_seq() {
		return fap_resume_nm_seq;
	}

	public void setFap_resume_nm_seq(long fap_resume_nm_seq) {
		this.fap_resume_nm_seq = fap_resume_nm_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_lang_gb() {
		return fap_resume_lang_gb;
	}

	public void setFap_resume_lang_gb(String fap_resume_lang_gb) {
		this.fap_resume_lang_gb = fap_resume_lang_gb;
	}

	public String getFap_resume_nm() {
		return fap_resume_nm;
	}

	public void setFap_resume_nm(String fap_resume_nm) {
		this.fap_resume_nm = fap_resume_nm;
	}

	public String getFap_resume_nm_ins_id() {
		return fap_resume_nm_ins_id;
	}

	public void setFap_resume_nm_ins_id(String fap_resume_nm_ins_id) {
		this.fap_resume_nm_ins_id = fap_resume_nm_ins_id;
	}

	public String getFap_resume_nm_ins_dt() {
		return fap_resume_nm_ins_dt;
	}

	public void setFap_resume_nm_ins_dt(String fap_resume_nm_ins_dt) {
		this.fap_resume_nm_ins_dt = fap_resume_nm_ins_dt;
	}

	public String getFap_resume_nm_udt_id() {
		return fap_resume_nm_udt_id;
	}

	public void setFap_resume_nm_udt_id(String fap_resume_nm_udt_id) {
		this.fap_resume_nm_udt_id = fap_resume_nm_udt_id;
	}

	public String getFap_resume_nm_udt_dt() {
		return fap_resume_nm_udt_dt;
	}

	public void setFap_resume_nm_udt_dt(String fap_resume_nm_udt_dt) {
		this.fap_resume_nm_udt_dt = fap_resume_nm_udt_dt;
	}

	public List<SocietyFapUserResumeName> getResumeNameList() {
		return resumeNameList;
	}

	public void setResumeNameList(List<SocietyFapUserResumeName> resumeNameList) {
		this.resumeNameList = resumeNameList;
	}

	@Override
	public String toString() {
		return "ResumeName [fap_resume_nm_seq=" + fap_resume_nm_seq + ", fap_resume_seq=" + fap_resume_seq
				+ ", fap_resume_lang_gb=" + fap_resume_lang_gb + ", fap_resume_nm=" + fap_resume_nm
				+ ", fap_resume_nm_ins_id=" + fap_resume_nm_ins_id + ", fap_resume_nm_ins_dt=" + fap_resume_nm_ins_dt
				+ ", fap_resume_nm_udt_id=" + fap_resume_nm_udt_id + ", fap_resume_nm_udt_dt=" + fap_resume_nm_udt_dt
				+ ", resumeNameList=" + resumeNameList + "]";
	}
	
}
