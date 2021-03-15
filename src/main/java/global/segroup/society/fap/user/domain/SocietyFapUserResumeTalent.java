/**
 * 
 */
package global.segroup.society.fap.user.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 역량/재능
 * 
 */
public class SocietyFapUserResumeTalent {
	
	/**
	 * 이력서 프로젝트 일련번호
	 */
	private long fap_resume_talent_seq;
	
	/**
	 * 이력서 역량/재능
	 */
	private long fap_resume_seq;
	
	/**
	 * 이력서 내용
	 */
	private String fap_resume_talent_content;

	/**
	 * 등록자
	 */
	private String fap_resume_talent_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_talent_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_talent_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_talent_udt_dt;
	
	/**
	 * 역량/재능 리스트
	 */
	private List<SocietyFapUserResumeTalent> resumeTalentList;

	public SocietyFapUserResumeTalent() {
		super();
	}

	public SocietyFapUserResumeTalent(long fap_resume_talent_seq, long fap_resume_seq, String fap_resume_talent_content,
			String fap_resume_talent_ins_id, String fap_resume_talent_ins_dt,
			String fap_resume_talent_udt_id, String fap_resume_talent_udt_dt, List<SocietyFapUserResumeTalent> resumeTalentList) {
		super();
		this.fap_resume_talent_seq = fap_resume_talent_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_talent_content = fap_resume_talent_content;
		this.fap_resume_talent_ins_id = fap_resume_talent_ins_id;
		this.fap_resume_talent_ins_dt = fap_resume_talent_ins_dt;
		this.fap_resume_talent_udt_id = fap_resume_talent_udt_id;
		this.fap_resume_talent_udt_dt = fap_resume_talent_udt_dt;
		this.resumeTalentList = resumeTalentList;
	}

	public long getFap_resume_talent_seq() {
		return fap_resume_talent_seq;
	}

	public void setFap_resume_talent_seq(long fap_resume_talent_seq) {
		this.fap_resume_talent_seq = fap_resume_talent_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_talent_content() {
		return fap_resume_talent_content;
	}

	public void setFap_resume_talent_content(String fap_resume_talent_content) {
		this.fap_resume_talent_content = fap_resume_talent_content;
	}

	public String getFap_resume_talent_ins_id() {
		return fap_resume_talent_ins_id;
	}

	public void setFap_resume_talent_ins_id(String fap_resume_talent_ins_id) {
		this.fap_resume_talent_ins_id = fap_resume_talent_ins_id;
	}

	public String getFap_resume_talent_ins_dt() {
		return fap_resume_talent_ins_dt;
	}

	public void setFap_resume_talent_ins_dt(String fap_resume_talent_ins_dt) {
		this.fap_resume_talent_ins_dt = fap_resume_talent_ins_dt;
	}

	public String getFap_resume_talent_udt_id() {
		return fap_resume_talent_udt_id;
	}

	public void setFap_resume_talent_udt_id(String fap_resume_talent_udt_id) {
		this.fap_resume_talent_udt_id = fap_resume_talent_udt_id;
	}

	public String getFap_resume_talent_udt_dt() {
		return fap_resume_talent_udt_dt;
	}

	public void setFap_resume_talent_udt_dt(String fap_resume_talent_udt_dt) {
		this.fap_resume_talent_udt_dt = fap_resume_talent_udt_dt;
	}

	public List<SocietyFapUserResumeTalent> getResumeTalentList() {
		return resumeTalentList;
	}

	public void setResumeTalentList(List<SocietyFapUserResumeTalent> resumeTalentList) {
		this.resumeTalentList = resumeTalentList;
	}

	@Override
	public String toString() {
		return "ResumeTalent [fap_resume_talent_seq=" + fap_resume_talent_seq + ", fap_resume_seq=" + fap_resume_seq
				+ ", fap_resume_talent_content=" + fap_resume_talent_content + ", fap_resume_talent_ins_id=" + fap_resume_talent_ins_id
				+ ", fap_resume_talent_ins_dt=" + fap_resume_talent_ins_dt + ", fap_resume_talent_udt_id="
				+ fap_resume_talent_udt_id + ", fap_resume_talent_udt_dt=" + fap_resume_talent_udt_dt
				+ ", resumeTalentList=" + resumeTalentList + "]";
	}
	
}
