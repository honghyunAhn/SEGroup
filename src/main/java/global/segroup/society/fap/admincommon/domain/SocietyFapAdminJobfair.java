/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 3.
 * @Class 설명 : 잡페어 등록 정보
 * 
 */
public class SocietyFapAdminJobfair {

	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어 제목
	 */
	private String fap_jobfair_title;
	
	/**
	 * 잡페어 시작일
	 */
	private String fap_jobfair_st;
	
	/**
	 * 잡페어 종료일
	 */
	private String fap_jobfair_et;

	/**
	 * 잡페어 로고 파일
	 */
	private CommonsMultipartFile fap_jobfair_log_file;
	
	/**
	 * 잡페어 로고 저장이름
	 */
	private String fap_jobfair_log_saved;
	
	/**
	 * 잡페어 로고 원본이름
	 */
	private String fap_jobfair_log_origin;
	
	/**
	 * 잡페어 노출여부
	 */
	private String fap_jobfair_eps;
	
	/**
	 * 잡페어 지원가능인원 배수
	 */
	private int fap_apply_max_multiple;
	
	/**
	 * 잡페어 등록자
	 */
	private String fap_jobfair_ins_id;
	
	/**
	 * 잡페어 등록일
	 */
	private String fap_jobfair_ins_dt;
	
	/**
	 * 잡페어 수정자
	 */
	private String fap_jobfair_udt_id;
	
	/**
	 * 잡페어 수정일
	 */
	private String fap_jobfair_udt_dt;	
	
	/**
	 * 잡페어 진행상태
	 */
	private String fap_jobfair_opening_flag;
	
	public SocietyFapAdminJobfair() {
		super();
	}

	public SocietyFapAdminJobfair(int fap_jobfair_seq, String fap_jobfair_title, String fap_jobfair_st,
			String fap_jobfair_et, CommonsMultipartFile fap_jobfair_log_file, String fap_jobfair_log_saved,
			String fap_jobfair_log_origin, String fap_jobfair_eps, int fap_apply_max_multiple,
			String fap_jobfair_ins_id, String fap_jobfair_ins_dt, String fap_jobfair_udt_id, String fap_jobfair_udt_dt,
			String fap_jobfair_opening_flag) {
		super();
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_title = fap_jobfair_title;
		this.fap_jobfair_st = fap_jobfair_st;
		this.fap_jobfair_et = fap_jobfair_et;
		this.fap_jobfair_log_file = fap_jobfair_log_file;
		this.fap_jobfair_log_saved = fap_jobfair_log_saved;
		this.fap_jobfair_log_origin = fap_jobfair_log_origin;
		this.fap_jobfair_eps = fap_jobfair_eps;
		this.fap_apply_max_multiple = fap_apply_max_multiple;
		this.fap_jobfair_ins_id = fap_jobfair_ins_id;
		this.fap_jobfair_ins_dt = fap_jobfair_ins_dt;
		this.fap_jobfair_udt_id = fap_jobfair_udt_id;
		this.fap_jobfair_udt_dt = fap_jobfair_udt_dt;
		this.fap_jobfair_opening_flag = fap_jobfair_opening_flag;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_jobfair_title() {
		return fap_jobfair_title;
	}

	public void setFap_jobfair_title(String fap_jobfair_title) {
		this.fap_jobfair_title = fap_jobfair_title;
	}

	public String getFap_jobfair_st() {
		return fap_jobfair_st;
	}

	public void setFap_jobfair_st(String fap_jobfair_st) {
		this.fap_jobfair_st = fap_jobfair_st;
	}

	public String getFap_jobfair_et() {
		return fap_jobfair_et;
	}

	public void setFap_jobfair_et(String fap_jobfair_et) {
		this.fap_jobfair_et = fap_jobfair_et;
	}

	public CommonsMultipartFile getFap_jobfair_log_file() {
		return fap_jobfair_log_file;
	}

	public void setFap_jobfair_log_file(CommonsMultipartFile fap_jobfair_log_file) {
		this.fap_jobfair_log_file = fap_jobfair_log_file;
	}

	public String getFap_jobfair_log_saved() {
		return fap_jobfair_log_saved;
	}

	public void setFap_jobfair_log_saved(String fap_jobfair_log_saved) {
		this.fap_jobfair_log_saved = fap_jobfair_log_saved;
	}

	public String getFap_jobfair_log_origin() {
		return fap_jobfair_log_origin;
	}

	public void setFap_jobfair_log_origin(String fap_jobfair_log_origin) {
		this.fap_jobfair_log_origin = fap_jobfair_log_origin;
	}

	public String getFap_jobfair_eps() {
		return fap_jobfair_eps;
	}

	public void setFap_jobfair_eps(String fap_jobfair_eps) {
		this.fap_jobfair_eps = fap_jobfair_eps;
	}

	public int getFap_apply_max_multiple() {
		return fap_apply_max_multiple;
	}

	public void setFap_apply_max_multiple(int fap_apply_max_multiple) {
		this.fap_apply_max_multiple = fap_apply_max_multiple;
	}

	public String getFap_jobfair_ins_id() {
		return fap_jobfair_ins_id;
	}

	public void setFap_jobfair_ins_id(String fap_jobfair_ins_id) {
		this.fap_jobfair_ins_id = fap_jobfair_ins_id;
	}

	public String getFap_jobfair_ins_dt() {
		return fap_jobfair_ins_dt;
	}

	public void setFap_jobfair_ins_dt(String fap_jobfair_ins_dt) {
		this.fap_jobfair_ins_dt = fap_jobfair_ins_dt;
	}

	public String getFap_jobfair_udt_id() {
		return fap_jobfair_udt_id;
	}

	public void setFap_jobfair_udt_id(String fap_jobfair_udt_id) {
		this.fap_jobfair_udt_id = fap_jobfair_udt_id;
	}

	public String getFap_jobfair_udt_dt() {
		return fap_jobfair_udt_dt;
	}

	public void setFap_jobfair_udt_dt(String fap_jobfair_udt_dt) {
		this.fap_jobfair_udt_dt = fap_jobfair_udt_dt;
	}

	public String getFap_jobfair_opening_flag() {
		return fap_jobfair_opening_flag;
	}

	public void setFap_jobfair_opening_flag(String fap_jobfair_opening_flag) {
		this.fap_jobfair_opening_flag = fap_jobfair_opening_flag;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfair [fap_jobfair_seq=" + fap_jobfair_seq + ", fap_jobfair_title=" + fap_jobfair_title
				+ ", fap_jobfair_st=" + fap_jobfair_st + ", fap_jobfair_et=" + fap_jobfair_et
				+ ", fap_jobfair_log_file=" + fap_jobfair_log_file + ", fap_jobfair_log_saved=" + fap_jobfair_log_saved
				+ ", fap_jobfair_log_origin=" + fap_jobfair_log_origin + ", fap_jobfair_eps=" + fap_jobfair_eps
				+ ", fap_apply_max_multiple=" + fap_apply_max_multiple + ", fap_jobfair_ins_id=" + fap_jobfair_ins_id
				+ ", fap_jobfair_ins_dt=" + fap_jobfair_ins_dt + ", fap_jobfair_udt_id=" + fap_jobfair_udt_id
				+ ", fap_jobfair_udt_dt=" + fap_jobfair_udt_dt + ", fap_jobfair_opening_flag="
				+ fap_jobfair_opening_flag + "]";
	}
	
}
