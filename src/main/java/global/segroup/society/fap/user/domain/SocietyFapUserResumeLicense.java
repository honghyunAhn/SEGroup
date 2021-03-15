/**
 * 
 */
package global.segroup.society.fap.user.domain;

import java.util.List;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 이력서 자격 정보
 * 
 */
public class SocietyFapUserResumeLicense {
	
	/**
	 * 이력서 정보 일련번호
	 */
	private long fap_resume_license_seq;
	
	/**
	 * 이력서 일련 번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 취득년도(yyyy)
	 */
	private String fap_resume_license_get_year;

	/**
	 * 취득월(MM)
	 */
	private String fap_resume_license_get_month;
	
	/**
	 * 면허/자격이름
	 */
	private String fap_resume_license_nm;
	
	/**
	 * 점수
	 */
	private double fap_resume_license_score;
	
	/**
	 * 발행기관
	 */
	private String fap_resume_license_issuing_organization;
	
	/**
	 * 비고
	 */
	private String fap_resume_license_note;
	
	/**
	 * 등록자
	 */
	private String fap_resume_license_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_license_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_resume_license_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_license_udt_dt;

	/**
	 * 자격증 리스트
	 */
	private List<SocietyFapUserResumeLicense> resumeLicenseList;
	
	public SocietyFapUserResumeLicense() {
		super();
	}

	public SocietyFapUserResumeLicense(long fap_resume_license_seq, long fap_resume_seq,
			String fap_resume_license_get_year, String fap_resume_license_get_month, String fap_resume_license_nm,
			double fap_resume_license_score, String fap_resume_license_issuing_organization,
			String fap_resume_license_note, String fap_resume_license_ins_id, String fap_resume_license_ins_dt,
			String fap_resume_license_udt_id, String fap_resume_license_udt_dt,
			List<SocietyFapUserResumeLicense> resumeLicenseList) {
		super();
		this.fap_resume_license_seq = fap_resume_license_seq;
		this.fap_resume_seq = fap_resume_seq;
		this.fap_resume_license_get_year = fap_resume_license_get_year;
		this.fap_resume_license_get_month = fap_resume_license_get_month;
		this.fap_resume_license_nm = fap_resume_license_nm;
		this.fap_resume_license_score = fap_resume_license_score;
		this.fap_resume_license_issuing_organization = fap_resume_license_issuing_organization;
		this.fap_resume_license_note = fap_resume_license_note;
		this.fap_resume_license_ins_id = fap_resume_license_ins_id;
		this.fap_resume_license_ins_dt = fap_resume_license_ins_dt;
		this.fap_resume_license_udt_id = fap_resume_license_udt_id;
		this.fap_resume_license_udt_dt = fap_resume_license_udt_dt;
		this.resumeLicenseList = resumeLicenseList;
	}

	public long getFap_resume_license_seq() {
		return fap_resume_license_seq;
	}

	public void setFap_resume_license_seq(long fap_resume_license_seq) {
		this.fap_resume_license_seq = fap_resume_license_seq;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getFap_resume_license_get_year() {
		return fap_resume_license_get_year;
	}

	public void setFap_resume_license_get_year(String fap_resume_license_get_year) {
		this.fap_resume_license_get_year = fap_resume_license_get_year;
	}

	public String getFap_resume_license_get_month() {
		return fap_resume_license_get_month;
	}

	public void setFap_resume_license_get_month(String fap_resume_license_get_month) {
		this.fap_resume_license_get_month = fap_resume_license_get_month;
	}

	public String getFap_resume_license_nm() {
		return fap_resume_license_nm;
	}

	public void setFap_resume_license_nm(String fap_resume_license_nm) {
		this.fap_resume_license_nm = fap_resume_license_nm;
	}

	public double getFap_resume_license_score() {
		return fap_resume_license_score;
	}

	public void setFap_resume_license_score(double fap_resume_license_score) {
		this.fap_resume_license_score = fap_resume_license_score;
	}

	public String getFap_resume_license_issuing_organization() {
		return fap_resume_license_issuing_organization;
	}

	public void setFap_resume_license_issuing_organization(String fap_resume_license_issuing_organization) {
		this.fap_resume_license_issuing_organization = fap_resume_license_issuing_organization;
	}

	public String getFap_resume_license_note() {
		return fap_resume_license_note;
	}

	public void setFap_resume_license_note(String fap_resume_license_note) {
		this.fap_resume_license_note = fap_resume_license_note;
	}

	public String getFap_resume_license_ins_id() {
		return fap_resume_license_ins_id;
	}

	public void setFap_resume_license_ins_id(String fap_resume_license_ins_id) {
		this.fap_resume_license_ins_id = fap_resume_license_ins_id;
	}

	public String getFap_resume_license_ins_dt() {
		return fap_resume_license_ins_dt;
	}

	public void setFap_resume_license_ins_dt(String fap_resume_license_ins_dt) {
		this.fap_resume_license_ins_dt = fap_resume_license_ins_dt;
	}

	public String getFap_resume_license_udt_id() {
		return fap_resume_license_udt_id;
	}

	public void setFap_resume_license_udt_id(String fap_resume_license_udt_id) {
		this.fap_resume_license_udt_id = fap_resume_license_udt_id;
	}

	public String getFap_resume_license_udt_dt() {
		return fap_resume_license_udt_dt;
	}

	public void setFap_resume_license_udt_dt(String fap_resume_license_udt_dt) {
		this.fap_resume_license_udt_dt = fap_resume_license_udt_dt;
	}

	public List<SocietyFapUserResumeLicense> getResumeLicenseList() {
		return resumeLicenseList;
	}

	public void setResumeLicenseList(List<SocietyFapUserResumeLicense> resumeLicenseList) {
		this.resumeLicenseList = resumeLicenseList;
	}

	@Override
	public String toString() {
		return "SocietyFapUserResumeLicense [fap_resume_license_seq=" + fap_resume_license_seq + ", fap_resume_seq="
				+ fap_resume_seq + ", fap_resume_license_get_year=" + fap_resume_license_get_year
				+ ", fap_resume_license_get_month=" + fap_resume_license_get_month + ", fap_resume_license_nm="
				+ fap_resume_license_nm + ", fap_resume_license_score=" + fap_resume_license_score
				+ ", fap_resume_license_issuing_organization=" + fap_resume_license_issuing_organization
				+ ", fap_resume_license_note=" + fap_resume_license_note + ", fap_resume_license_ins_id="
				+ fap_resume_license_ins_id + ", fap_resume_license_ins_dt=" + fap_resume_license_ins_dt
				+ ", fap_resume_license_udt_id=" + fap_resume_license_udt_id + ", fap_resume_license_udt_dt="
				+ fap_resume_license_udt_dt + ", resumeLicenseList=" + resumeLicenseList + "]";
	}

}
