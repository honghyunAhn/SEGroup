/**
 * 
 */
package global.segroup.society.fap.company.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 신동철
 * @Date : 2019. 1. 1.
 * @Class 설명 : 공통내정서류
 * 
 */
public class SocietyFapCommonRequiredDoc {

	/**
	 * 공통 내정서류 시퀀스
	 */
	private long fap_common_required_doc_seq;
	
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어 세부 시퀀스
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 회사아이디
	 */
	private String fap_comp_id;
	
	/**
	 * 내정서류 제목
	 */
	private String fap_common_required_doc_title;
	
	/**
	 * 내정서류 상세
	 */
	private String fap_common_required_doc_detail;
	
	/**
	 * 파일원본이름
	 */
	private String fap_common_required_doc_origin;
	
	/**
	 * 파일저장이름
	 */
	private String fap_common_required_doc_saved;
	
	/**
	 * 내정서류 파일
	 */
	private CommonsMultipartFile fap_common_required_doc_file;
		
	/**
	 * 등록자
	 */
	private String fap_common_required_doc_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_common_required_doc_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_common_required_doc_udt_id;
	
	/**
	 * 수정일
	 */
	private String fap_common_required_doc_udt_dt;

	public SocietyFapCommonRequiredDoc() {
		super();
	}

	public SocietyFapCommonRequiredDoc(long fap_common_required_doc_seq, long fap_job_ad_seq, int fap_jobfair_seq,
			int fap_jobfair_divide_seq, String fap_comp_id, String fap_common_required_doc_title,
			String fap_common_required_doc_detail, String fap_common_required_doc_origin,
			String fap_common_required_doc_saved, CommonsMultipartFile fap_common_required_doc_file,
			String fap_common_required_doc_ins_id, String fap_common_required_doc_ins_dt,
			String fap_common_required_doc_udt_id, String fap_common_required_doc_udt_dt) {
		super();
		this.fap_common_required_doc_seq = fap_common_required_doc_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_comp_id = fap_comp_id;
		this.fap_common_required_doc_title = fap_common_required_doc_title;
		this.fap_common_required_doc_detail = fap_common_required_doc_detail;
		this.fap_common_required_doc_origin = fap_common_required_doc_origin;
		this.fap_common_required_doc_saved = fap_common_required_doc_saved;
		this.fap_common_required_doc_file = fap_common_required_doc_file;
		this.fap_common_required_doc_ins_id = fap_common_required_doc_ins_id;
		this.fap_common_required_doc_ins_dt = fap_common_required_doc_ins_dt;
		this.fap_common_required_doc_udt_id = fap_common_required_doc_udt_id;
		this.fap_common_required_doc_udt_dt = fap_common_required_doc_udt_dt;
	}

	public long getFap_common_required_doc_seq() {
		return fap_common_required_doc_seq;
	}

	public void setFap_common_required_doc_seq(long fap_common_required_doc_seq) {
		this.fap_common_required_doc_seq = fap_common_required_doc_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public String getFap_comp_id() {
		return fap_comp_id;
	}

	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}

	public String getFap_common_required_doc_title() {
		return fap_common_required_doc_title;
	}

	public void setFap_common_required_doc_title(String fap_common_required_doc_title) {
		this.fap_common_required_doc_title = fap_common_required_doc_title;
	}

	public String getFap_common_required_doc_detail() {
		return fap_common_required_doc_detail;
	}

	public void setFap_common_required_doc_detail(String fap_common_required_doc_detail) {
		this.fap_common_required_doc_detail = fap_common_required_doc_detail;
	}

	public String getFap_common_required_doc_origin() {
		return fap_common_required_doc_origin;
	}

	public void setFap_common_required_doc_origin(String fap_common_required_doc_origin) {
		this.fap_common_required_doc_origin = fap_common_required_doc_origin;
	}

	public String getFap_common_required_doc_saved() {
		return fap_common_required_doc_saved;
	}

	public void setFap_common_required_doc_saved(String fap_common_required_doc_saved) {
		this.fap_common_required_doc_saved = fap_common_required_doc_saved;
	}

	public CommonsMultipartFile getFap_common_required_doc_file() {
		return fap_common_required_doc_file;
	}

	public void setFap_common_required_doc_file(CommonsMultipartFile fap_common_required_doc_file) {
		this.fap_common_required_doc_file = fap_common_required_doc_file;
	}

	public String getFap_common_required_doc_ins_id() {
		return fap_common_required_doc_ins_id;
	}

	public void setFap_common_required_doc_ins_id(String fap_common_required_doc_ins_id) {
		this.fap_common_required_doc_ins_id = fap_common_required_doc_ins_id;
	}

	public String getFap_common_required_doc_ins_dt() {
		return fap_common_required_doc_ins_dt;
	}

	public void setFap_common_required_doc_ins_dt(String fap_common_required_doc_ins_dt) {
		this.fap_common_required_doc_ins_dt = fap_common_required_doc_ins_dt;
	}

	public String getFap_common_required_doc_udt_id() {
		return fap_common_required_doc_udt_id;
	}

	public void setFap_common_required_doc_udt_id(String fap_common_required_doc_udt_id) {
		this.fap_common_required_doc_udt_id = fap_common_required_doc_udt_id;
	}

	public String getFap_common_required_doc_udt_dt() {
		return fap_common_required_doc_udt_dt;
	}

	public void setFap_common_required_doc_udt_dt(String fap_common_required_doc_udt_dt) {
		this.fap_common_required_doc_udt_dt = fap_common_required_doc_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapCommonRequiredDoc [fap_common_required_doc_seq=" + fap_common_required_doc_seq
				+ ", fap_job_ad_seq=" + fap_job_ad_seq + ", fap_jobfair_seq=" + fap_jobfair_seq
				+ ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", fap_comp_id=" + fap_comp_id
				+ ", fap_common_required_doc_title=" + fap_common_required_doc_title
				+ ", fap_common_required_doc_detail=" + fap_common_required_doc_detail
				+ ", fap_common_required_doc_origin=" + fap_common_required_doc_origin
				+ ", fap_common_required_doc_saved=" + fap_common_required_doc_saved + ", fap_common_required_doc_file="
				+ fap_common_required_doc_file + ", fap_common_required_doc_ins_id=" + fap_common_required_doc_ins_id
				+ ", fap_common_required_doc_ins_dt=" + fap_common_required_doc_ins_dt
				+ ", fap_common_required_doc_udt_id=" + fap_common_required_doc_udt_id
				+ ", fap_common_required_doc_udt_dt=" + fap_common_required_doc_udt_dt + "]";
	}

	
}
