/**
 * 
 */
package global.segroup.society.fap.user.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 남유송
 * @Date : 2018. 12. 6.
 * @Class 설명 : 통합잡페어(FAP) 이력서 기본정보
 * 
 */
public class SocietyFapUserResumeForm {
	
	/**
	 * 이력서 일련번호
	 */
	private long fap_resume_seq;
	
	/**
	 * 회원 아이디
	 */
	private String user_id;

	/**
	 * 이력서 제목
	 */
	private String fap_resume_title;
	
	/**
	 * 성별(공통코드)
	 */
	private String fap_resume_gender;
	
	/**
	 * 혼인여부(공통코드)
	 */
	private String fap_resume_marital;
	
	/**
	 * 국적
	 */
	private String fap_resume_nationality;
	
	/**
	 * 이력서 사진 
	 */
	private String fap_resume_pic_saved;
	
	/**
	 * 이력서 사진 원본
	 */
	private String fap_resume_pic_origin;
	
	/**
	 * 이력서 사진 파일
	 */
	private CommonsMultipartFile fap_resume_pic;
	/**
	 * 생년월일
	 */
	private String fap_resume_birth;
	
	/**
	 * 부양가족
	 */
	private String fap_resume_dependents;
	
	/**
	 * URL
	 * */
	private String fap_resume_url;
	
	/**
	 * 등록일자(yyyyMMdd24hhmiss) 
	 */
	private String fap_resume_ins_dt;
	
	/**
	 * 등록자 
	 */
	private String fap_resume_ins_id;
	
	/**
	 * 수정일자(yyyyMMdd24hhmiss)
	 */
	private String fap_resume_udt_dt;
	
	/**
	 * 수정자 
	 */
	private String fap_resume_udt_id;

	public SocietyFapUserResumeForm() {
		super();
		
	}

	public SocietyFapUserResumeForm(long fap_resume_seq, String user_id, String fap_resume_title,
			String fap_resume_gender, String fap_resume_marital, String fap_resume_nationality,
			String fap_resume_pic_saved, String fap_resume_pic_origin, CommonsMultipartFile fap_resume_pic,
			String fap_resume_birth, String fap_resume_dependents, String fap_resume_url, String fap_resume_ins_dt,
			String fap_resume_ins_id, String fap_resume_udt_dt, String fap_resume_udt_id) {
		super();
		this.fap_resume_seq = fap_resume_seq;
		this.user_id = user_id;
		this.fap_resume_title = fap_resume_title;
		this.fap_resume_gender = fap_resume_gender;
		this.fap_resume_marital = fap_resume_marital;
		this.fap_resume_nationality = fap_resume_nationality;
		this.fap_resume_pic_saved = fap_resume_pic_saved;
		this.fap_resume_pic_origin = fap_resume_pic_origin;
		this.fap_resume_pic = fap_resume_pic;
		this.fap_resume_birth = fap_resume_birth;
		this.fap_resume_dependents = fap_resume_dependents;
		this.fap_resume_url = fap_resume_url;
		this.fap_resume_ins_dt = fap_resume_ins_dt;
		this.fap_resume_ins_id = fap_resume_ins_id;
		this.fap_resume_udt_dt = fap_resume_udt_dt;
		this.fap_resume_udt_id = fap_resume_udt_id;
	}

	public long getFap_resume_seq() {
		return fap_resume_seq;
	}

	public void setFap_resume_seq(long fap_resume_seq) {
		this.fap_resume_seq = fap_resume_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFap_resume_title() {
		return fap_resume_title;
	}

	public void setFap_resume_title(String fap_resume_title) {
		this.fap_resume_title = fap_resume_title;
	}

	public String getFap_resume_gender() {
		return fap_resume_gender;
	}

	public void setFap_resume_gender(String fap_resume_gender) {
		this.fap_resume_gender = fap_resume_gender;
	}

	public String getFap_resume_marital() {
		return fap_resume_marital;
	}

	public void setFap_resume_marital(String fap_resume_marital) {
		this.fap_resume_marital = fap_resume_marital;
	}

	public String getFap_resume_nationality() {
		return fap_resume_nationality;
	}

	public void setFap_resume_nationality(String fap_resume_nationality) {
		this.fap_resume_nationality = fap_resume_nationality;
	}

	public String getFap_resume_pic_saved() {
		return fap_resume_pic_saved;
	}

	public void setFap_resume_pic_saved(String fap_resume_pic_saved) {
		this.fap_resume_pic_saved = fap_resume_pic_saved;
	}

	public String getFap_resume_pic_origin() {
		return fap_resume_pic_origin;
	}

	public void setFap_resume_pic_origin(String fap_resume_pic_origin) {
		this.fap_resume_pic_origin = fap_resume_pic_origin;
	}

	public CommonsMultipartFile getFap_resume_pic() {
		return fap_resume_pic;
	}

	public void setFap_resume_pic(CommonsMultipartFile fap_resume_pic) {
		this.fap_resume_pic = fap_resume_pic;
	}

	public String getFap_resume_birth() {
		return fap_resume_birth;
	}

	public void setFap_resume_birth(String fap_resume_birth) {
		this.fap_resume_birth = fap_resume_birth;
	}

	public String getFap_resume_dependents() {
		return fap_resume_dependents;
	}

	public void setFap_resume_dependents(String fap_resume_dependents) {
		this.fap_resume_dependents = fap_resume_dependents;
	}

	public String getFap_resume_url() {
		return fap_resume_url;
	}

	public void setFap_resume_url(String fap_resume_url) {
		this.fap_resume_url = fap_resume_url;
	}

	public String getFap_resume_ins_dt() {
		return fap_resume_ins_dt;
	}

	public void setFap_resume_ins_dt(String fap_resume_ins_dt) {
		this.fap_resume_ins_dt = fap_resume_ins_dt;
	}

	public String getFap_resume_ins_id() {
		return fap_resume_ins_id;
	}

	public void setFap_resume_ins_id(String fap_resume_ins_id) {
		this.fap_resume_ins_id = fap_resume_ins_id;
	}

	public String getFap_resume_udt_dt() {
		return fap_resume_udt_dt;
	}

	public void setFap_resume_udt_dt(String fap_resume_udt_dt) {
		this.fap_resume_udt_dt = fap_resume_udt_dt;
	}

	public String getFap_resume_udt_id() {
		return fap_resume_udt_id;
	}

	public void setFap_resume_udt_id(String fap_resume_udt_id) {
		this.fap_resume_udt_id = fap_resume_udt_id;
	}

	@Override
	public String toString() {
		return "SocietyFapUserResumeForm [fap_resume_seq=" + fap_resume_seq + ", user_id=" + user_id
				+ ", fap_resume_title=" + fap_resume_title + ", fap_resume_gender=" + fap_resume_gender
				+ ", fap_resume_marital=" + fap_resume_marital + ", fap_resume_nationality=" + fap_resume_nationality
				+ ", fap_resume_pic_saved=" + fap_resume_pic_saved + ", fap_resume_pic_origin=" + fap_resume_pic_origin
				+ ", fap_resume_pic=" + fap_resume_pic + ", fap_resume_birth=" + fap_resume_birth
				+ ", fap_resume_dependents=" + fap_resume_dependents + ", fap_resume_url=" + fap_resume_url
				+ ", fap_resume_ins_dt=" + fap_resume_ins_dt + ", fap_resume_ins_id=" + fap_resume_ins_id
				+ ", fap_resume_udt_dt=" + fap_resume_udt_dt + ", fap_resume_udt_id=" + fap_resume_udt_id + "]";
	}
	
}
