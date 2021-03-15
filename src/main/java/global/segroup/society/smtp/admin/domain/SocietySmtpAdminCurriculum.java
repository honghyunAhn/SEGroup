/**
 * 
 */
package global.segroup.society.smtp.admin.domain;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 김슬기
 * @Date : 2019. 12. 2.
 * @Class 설명 :  Society 통합학사관리 과정 정보
 * 
 */
public class SocietySmtpAdminCurriculum {
	
	/**
	 * 과정 코드
	 */
	private String crc_code;
	
	/**
	 * 과정 구분
	 */
	private String crc_section;
	
	/**
	 * 교육 구분
	 */
	private String crc_subsection;
	
	/**
	 * 과정명
	 */
	private String crc_nm;
	
	/**
	 * 과정 소개
	 */
	private String crc_introduction;
	
	/**
	 * 과정 이미지 파일
	 */
	private CommonsMultipartFile crc_img_file;
	
	/**
	 * 과정 이미지 원본명
	 */
	private String crc_img_origin;
	
	/**
	 * 과정 이미지 저장명
	 */
	private String crc_img_saved;
	
	/**
	 * 교육비
	 */
	private int crc_pay;
	
	/**
	 * 결제 방식
	 */
	private String crc_pay_opt;
	
	/**
	 * 분납 여부
	 */
	private String crc_pay_division;
	
	/**
	 * 수료 기준
	 */
	private String crc_graduation_opt;
	
	/**
	 * 수료 요건
	 */
	private String crc_graduation_opt2;
	
	/**
	 * 서비스 상태
	 */
	private String crc_status;
	
	/**
	 * 해시태그
	 */
	private String crc_hashtag;
	
	/**
	 * 등록자
	 */
	private String crc_ins_id;
	
	/**
	 * 등록일
	 */
	private String crc_ins_dt;
	
	/**
	 * 수정자
	 */
	private String crc_udt_id;
	
	/**
	 * 수정일
	 */
	private String crc_udt_dt;

	/**
	 * @Desc : 
	 */
	public SocietySmtpAdminCurriculum() {
		super();
	}

	/**
	 * @Desc : 
	 * @param crc_code
	 * @param crc_section
	 * @param crc_subsection
	 * @param crc_nm
	 * @param crc_introduction
	 * @param crc_img_file
	 * @param crc_img_origin
	 * @param crc_img_saved
	 * @param crc_pay
	 * @param crc_pay_opt
	 * @param crc_pay_division
	 * @param crc_graduation_opt
	 * @param crc_graduation_opt2
	 * @param crc_status
	 * @param crc_hashtag
	 * @param crc_ins_id
	 * @param crc_ins_dt
	 * @param crc_udt_id
	 * @param crc_udt_dt
	 */
	public SocietySmtpAdminCurriculum(String crc_code, String crc_section, String crc_subsection, String crc_nm,
			String crc_introduction, CommonsMultipartFile crc_img_file, String crc_img_origin, String crc_img_saved,
			int crc_pay, String crc_pay_opt, String crc_pay_division, String crc_graduation_opt,
			String crc_graduation_opt2, String crc_status, String crc_hashtag, String crc_ins_id, String crc_ins_dt,
			String crc_udt_id, String crc_udt_dt) {
		super();
		this.crc_code = crc_code;
		this.crc_section = crc_section;
		this.crc_subsection = crc_subsection;
		this.crc_nm = crc_nm;
		this.crc_introduction = crc_introduction;
		this.crc_img_file = crc_img_file;
		this.crc_img_origin = crc_img_origin;
		this.crc_img_saved = crc_img_saved;
		this.crc_pay = crc_pay;
		this.crc_pay_opt = crc_pay_opt;
		this.crc_pay_division = crc_pay_division;
		this.crc_graduation_opt = crc_graduation_opt;
		this.crc_graduation_opt2 = crc_graduation_opt2;
		this.crc_status = crc_status;
		this.crc_hashtag = crc_hashtag;
		this.crc_ins_id = crc_ins_id;
		this.crc_ins_dt = crc_ins_dt;
		this.crc_udt_id = crc_udt_id;
		this.crc_udt_dt = crc_udt_dt;
	}

	/**
	 * @return the crc_code
	 */
	public String getCrc_code() {
		return crc_code;
	}

	/**
	 * @param crc_code the crc_code to set
	 */
	public void setCrc_code(String crc_code) {
		this.crc_code = crc_code;
	}

	/**
	 * @return the crc_section
	 */
	public String getCrc_section() {
		return crc_section;
	}

	/**
	 * @param crc_section the crc_section to set
	 */
	public void setCrc_section(String crc_section) {
		this.crc_section = crc_section;
	}

	/**
	 * @return the crc_subsection
	 */
	public String getCrc_subsection() {
		return crc_subsection;
	}

	/**
	 * @param crc_subsection the crc_subsection to set
	 */
	public void setCrc_subsection(String crc_subsection) {
		this.crc_subsection = crc_subsection;
	}

	/**
	 * @return the crc_nm
	 */
	public String getCrc_nm() {
		return crc_nm;
	}

	/**
	 * @param crc_nm the crc_nm to set
	 */
	public void setCrc_nm(String crc_nm) {
		this.crc_nm = crc_nm;
	}

	/**
	 * @return the crc_introduction
	 */
	public String getCrc_introduction() {
		return crc_introduction;
	}

	/**
	 * @param crc_introduction the crc_introduction to set
	 */
	public void setCrc_introduction(String crc_introduction) {
		this.crc_introduction = crc_introduction;
	}

	/**
	 * @return the crc_img_file
	 */
	public CommonsMultipartFile getCrc_img_file() {
		return crc_img_file;
	}

	/**
	 * @param crc_img_file the crc_img_file to set
	 */
	public void setCrc_img_file(CommonsMultipartFile crc_img_file) {
		this.crc_img_file = crc_img_file;
	}

	/**
	 * @return the crc_img_origin
	 */
	public String getCrc_img_origin() {
		return crc_img_origin;
	}

	/**
	 * @param crc_img_origin the crc_img_origin to set
	 */
	public void setCrc_img_origin(String crc_img_origin) {
		this.crc_img_origin = crc_img_origin;
	}

	/**
	 * @return the crc_img_saved
	 */
	public String getCrc_img_saved() {
		return crc_img_saved;
	}

	/**
	 * @param crc_img_saved the crc_img_saved to set
	 */
	public void setCrc_img_saved(String crc_img_saved) {
		this.crc_img_saved = crc_img_saved;
	}

	/**
	 * @return the crc_pay
	 */
	public int getCrc_pay() {
		return crc_pay;
	}

	/**
	 * @param crc_pay the crc_pay to set
	 */
	public void setCrc_pay(int crc_pay) {
		this.crc_pay = crc_pay;
	}

	/**
	 * @return the crc_pay_opt
	 */
	public String getCrc_pay_opt() {
		return crc_pay_opt;
	}

	/**
	 * @param crc_pay_opt the crc_pay_opt to set
	 */
	public void setCrc_pay_opt(String crc_pay_opt) {
		this.crc_pay_opt = crc_pay_opt;
	}

	/**
	 * @return the crc_pay_division
	 */
	public String getCrc_pay_division() {
		return crc_pay_division;
	}

	/**
	 * @param crc_pay_division the crc_pay_division to set
	 */
	public void setCrc_pay_division(String crc_pay_division) {
		this.crc_pay_division = crc_pay_division;
	}

	/**
	 * @return the crc_graduation_opt
	 */
	public String getCrc_graduation_opt() {
		return crc_graduation_opt;
	}

	/**
	 * @param crc_graduation_opt the crc_graduation_opt to set
	 */
	public void setCrc_graduation_opt(String crc_graduation_opt) {
		this.crc_graduation_opt = crc_graduation_opt;
	}

	/**
	 * @return the crc_graduation_opt2
	 */
	public String getCrc_graduation_opt2() {
		return crc_graduation_opt2;
	}

	/**
	 * @param crc_graduation_opt2 the crc_graduation_opt2 to set
	 */
	public void setCrc_graduation_opt2(String crc_graduation_opt2) {
		this.crc_graduation_opt2 = crc_graduation_opt2;
	}

	/**
	 * @return the crc_status
	 */
	public String getCrc_status() {
		return crc_status;
	}

	/**
	 * @param crc_status the crc_status to set
	 */
	public void setCrc_status(String crc_status) {
		this.crc_status = crc_status;
	}

	/**
	 * @return the crc_hashtag
	 */
	public String getCrc_hashtag() {
		return crc_hashtag;
	}

	/**
	 * @param crc_hashtag the crc_hashtag to set
	 */
	public void setCrc_hashtag(String crc_hashtag) {
		this.crc_hashtag = crc_hashtag;
	}

	/**
	 * @return the crc_ins_id
	 */
	public String getCrc_ins_id() {
		return crc_ins_id;
	}

	/**
	 * @param crc_ins_id the crc_ins_id to set
	 */
	public void setCrc_ins_id(String crc_ins_id) {
		this.crc_ins_id = crc_ins_id;
	}

	/**
	 * @return the crc_ins_dt
	 */
	public String getCrc_ins_dt() {
		return crc_ins_dt;
	}

	/**
	 * @param crc_ins_dt the crc_ins_dt to set
	 */
	public void setCrc_ins_dt(String crc_ins_dt) {
		this.crc_ins_dt = crc_ins_dt;
	}

	/**
	 * @return the crc_udt_id
	 */
	public String getCrc_udt_id() {
		return crc_udt_id;
	}

	/**
	 * @param crc_udt_id the crc_udt_id to set
	 */
	public void setCrc_udt_id(String crc_udt_id) {
		this.crc_udt_id = crc_udt_id;
	}

	/**
	 * @return the crc_udt_dt
	 */
	public String getCrc_udt_dt() {
		return crc_udt_dt;
	}

	/**
	 * @param crc_udt_dt the crc_udt_dt to set
	 */
	public void setCrc_udt_dt(String crc_udt_dt) {
		this.crc_udt_dt = crc_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietySmtpAdminCurriculum [crc_code=" + crc_code + ", crc_section=" + crc_section + ", crc_subsection="
				+ crc_subsection + ", crc_nm=" + crc_nm + ", crc_introduction=" + crc_introduction + ", crc_img_file="
				+ crc_img_file + ", crc_img_origin=" + crc_img_origin + ", crc_img_saved=" + crc_img_saved
				+ ", crc_pay=" + crc_pay + ", crc_pay_opt=" + crc_pay_opt + ", crc_pay_division=" + crc_pay_division
				+ ", crc_graduation_opt=" + crc_graduation_opt + ", crc_graduation_opt2=" + crc_graduation_opt2
				+ ", crc_status=" + crc_status + ", crc_hashtag=" + crc_hashtag + ", crc_ins_id=" + crc_ins_id
				+ ", crc_ins_dt=" + crc_ins_dt + ", crc_udt_id=" + crc_udt_id + ", crc_udt_dt=" + crc_udt_dt + "]";
	}
	
	
}
