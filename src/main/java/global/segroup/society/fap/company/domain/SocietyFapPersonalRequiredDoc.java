/**
 * 
 */
package global.segroup.society.fap.company.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 신동철
 * @Date : 2019. 1. 5.
 * @Class 설명 : 개인 내정서류
 * 
 */
public class SocietyFapPersonalRequiredDoc {

	/**
	 * 개인 내정서류 시퀀스
	 */
	private long fap_personal_required_doc_seq;
	
	/**
	 * 내정자 시퀀스
	 */
	private long fap_nominee_seq;
	
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 회사 아이디
	 */
	private String fap_comp_id;
	
	/**
	 * 회원 아이디
	 */
	private String user_id;
	
	/**
	 * 내정서류 제목
	 */
	private String fap_personal_required_doc_title;
	
	/**
	 * 내정서류 상세
	 */
	private String fap_personal_required_doc_detail;
	
	/**
	 * 파일원본이름
	 */
	private String fap_personal_required_doc_origin;
	
	/**
	 * 파일저장이름
	 */
	private String fap_personal_required_doc_saved;
	
	/**
	 * 내정서류 파일
	 */
	private CommonsMultipartFile fap_personal_required_doc_file;
	
	/**
	 * 업로더 구분(공통코드)
	 */
	private String fap_personal_required_doc_uploader_gb;
	
	/**
	 * 등록자
	 */
	private String fap_personal_required_doc_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_personal_required_doc_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_personal_required_doc_udt_id;
	
	/**
	 * 수정일
	 */
	private String fap_personal_required_doc_udt_dt;

	public SocietyFapPersonalRequiredDoc() {
		super();
	}

	public SocietyFapPersonalRequiredDoc(long fap_personal_required_doc_seq, long fap_nominee_seq, long fap_job_ad_seq,
			String fap_comp_id, String user_id, String fap_personal_required_doc_title,
			String fap_personal_required_doc_detail, String fap_personal_required_doc_origin,
			String fap_personal_required_doc_saved, CommonsMultipartFile fap_personal_required_doc_file,
			String fap_personal_required_doc_uploader_gb, String fap_personal_required_doc_ins_id,
			String fap_personal_required_doc_ins_dt, String fap_personal_required_doc_udt_id,
			String fap_personal_required_doc_udt_dt) {
		super();
		this.fap_personal_required_doc_seq = fap_personal_required_doc_seq;
		this.fap_nominee_seq = fap_nominee_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_comp_id = fap_comp_id;
		this.user_id = user_id;
		this.fap_personal_required_doc_title = fap_personal_required_doc_title;
		this.fap_personal_required_doc_detail = fap_personal_required_doc_detail;
		this.fap_personal_required_doc_origin = fap_personal_required_doc_origin;
		this.fap_personal_required_doc_saved = fap_personal_required_doc_saved;
		this.fap_personal_required_doc_file = fap_personal_required_doc_file;
		this.fap_personal_required_doc_uploader_gb = fap_personal_required_doc_uploader_gb;
		this.fap_personal_required_doc_ins_id = fap_personal_required_doc_ins_id;
		this.fap_personal_required_doc_ins_dt = fap_personal_required_doc_ins_dt;
		this.fap_personal_required_doc_udt_id = fap_personal_required_doc_udt_id;
		this.fap_personal_required_doc_udt_dt = fap_personal_required_doc_udt_dt;
	}

	public long getFap_personal_required_doc_seq() {
		return fap_personal_required_doc_seq;
	}

	public void setFap_personal_required_doc_seq(long fap_personal_required_doc_seq) {
		this.fap_personal_required_doc_seq = fap_personal_required_doc_seq;
	}

	public long getFap_nominee_seq() {
		return fap_nominee_seq;
	}

	public void setFap_nominee_seq(long fap_nominee_seq) {
		this.fap_nominee_seq = fap_nominee_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_comp_id() {
		return fap_comp_id;
	}

	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFap_personal_required_doc_title() {
		return fap_personal_required_doc_title;
	}

	public void setFap_personal_required_doc_title(String fap_personal_required_doc_title) {
		this.fap_personal_required_doc_title = fap_personal_required_doc_title;
	}

	public String getFap_personal_required_doc_detail() {
		return fap_personal_required_doc_detail;
	}

	public void setFap_personal_required_doc_detail(String fap_personal_required_doc_detail) {
		this.fap_personal_required_doc_detail = fap_personal_required_doc_detail;
	}

	public String getFap_personal_required_doc_origin() {
		return fap_personal_required_doc_origin;
	}

	public void setFap_personal_required_doc_origin(String fap_personal_required_doc_origin) {
		this.fap_personal_required_doc_origin = fap_personal_required_doc_origin;
	}

	public String getFap_personal_required_doc_saved() {
		return fap_personal_required_doc_saved;
	}

	public void setFap_personal_required_doc_saved(String fap_personal_required_doc_saved) {
		this.fap_personal_required_doc_saved = fap_personal_required_doc_saved;
	}

	public CommonsMultipartFile getFap_personal_required_doc_file() {
		return fap_personal_required_doc_file;
	}

	public void setFap_personal_required_doc_file(CommonsMultipartFile fap_personal_required_doc_file) {
		this.fap_personal_required_doc_file = fap_personal_required_doc_file;
	}

	public String getFap_personal_required_doc_uploader_gb() {
		return fap_personal_required_doc_uploader_gb;
	}

	public void setFap_personal_required_doc_uploader_gb(String fap_personal_required_doc_uploader_gb) {
		this.fap_personal_required_doc_uploader_gb = fap_personal_required_doc_uploader_gb;
	}

	public String getFap_personal_required_doc_ins_id() {
		return fap_personal_required_doc_ins_id;
	}

	public void setFap_personal_required_doc_ins_id(String fap_personal_required_doc_ins_id) {
		this.fap_personal_required_doc_ins_id = fap_personal_required_doc_ins_id;
	}

	public String getFap_personal_required_doc_ins_dt() {
		return fap_personal_required_doc_ins_dt;
	}

	public void setFap_personal_required_doc_ins_dt(String fap_personal_required_doc_ins_dt) {
		this.fap_personal_required_doc_ins_dt = fap_personal_required_doc_ins_dt;
	}

	public String getFap_personal_required_doc_udt_id() {
		return fap_personal_required_doc_udt_id;
	}

	public void setFap_personal_required_doc_udt_id(String fap_personal_required_doc_udt_id) {
		this.fap_personal_required_doc_udt_id = fap_personal_required_doc_udt_id;
	}

	public String getFap_personal_required_doc_udt_dt() {
		return fap_personal_required_doc_udt_dt;
	}

	public void setFap_personal_required_doc_udt_dt(String fap_personal_required_doc_udt_dt) {
		this.fap_personal_required_doc_udt_dt = fap_personal_required_doc_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapPersonalRequiredDoc [fap_personal_required_doc_seq=" + fap_personal_required_doc_seq
				+ ", fap_nominee_seq=" + fap_nominee_seq + ", fap_job_ad_seq=" + fap_job_ad_seq + ", fap_comp_id="
				+ fap_comp_id + ", user_id=" + user_id + ", fap_personal_required_doc_title="
				+ fap_personal_required_doc_title + ", fap_personal_required_doc_detail="
				+ fap_personal_required_doc_detail + ", fap_personal_required_doc_origin="
				+ fap_personal_required_doc_origin + ", fap_personal_required_doc_saved="
				+ fap_personal_required_doc_saved + ", fap_personal_required_doc_file=" + fap_personal_required_doc_file
				+ ", fap_personal_required_doc_uploader_gb=" + fap_personal_required_doc_uploader_gb
				+ ", fap_personal_required_doc_ins_id=" + fap_personal_required_doc_ins_id
				+ ", fap_personal_required_doc_ins_dt=" + fap_personal_required_doc_ins_dt
				+ ", fap_personal_required_doc_udt_id=" + fap_personal_required_doc_udt_id
				+ ", fap_personal_required_doc_udt_dt=" + fap_personal_required_doc_udt_dt + "]";
	}

	
}
