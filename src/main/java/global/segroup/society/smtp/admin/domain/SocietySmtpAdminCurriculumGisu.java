/**
 * 
 */
package global.segroup.society.smtp.admin.domain;

import java.util.Date;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @Author : 최소영
 * @Date : 2019. 12. 2.
 * @Class 설명 : 통합학사관리 기수정보
 * 
 */
public class SocietySmtpAdminCurriculumGisu {
	/**
	 * 기수코드
	 */
	private String crc_gisu_code;
	
	/**
	 * 과정코드
	 */
	private String crc_code;
	
	/**
	 * 과정명
	 */
	private String crc_nm;
	
	/**
	 * 과정기수명
	 */
	private String crc_gisu_nm;
	
	/**
	 * 과정기수번호
	 */
	private int crc_gisu_num;
	
	/**
	 * 기수과정구분
	 */
	private String crc_gisu_section;
	
	/**
	 * 기수교육구분
	 */
	private String crc_gisu_subsection;
	
	/**
	 * 과정기수소개
	 */
	private String crc_gisu_introduction;
	

	/**
	 * 과정기수 이미지 파일
	 */
	private CommonsMultipartFile crc_gisu_img_file;
	
	/**
	 * 과정기수이미지원본명
	 */
	private String crc_gisu_img_origin;
	
	/**
	 * 과정기수이미지저장명
	 */
	private String crc_gisu_img_saved;
	
	/**
	 * 교육비용
	 */
	private int crc_gisu_pay;
	
	/**
	 * 결제방식
	 */
	private String crc_gisu_pay_opt;
	
	/**
	 * 분납조건
	 */
	private String crc_gisu_division;
	
	/**
	 * 수료기준
	 */
	private String crc_gisu_graduation_opt;
	
	/**
	 * 수료요건
	 */
	private String crc_gisu_graduation_opt2;
	
	/**
	 * 서비스상태
	 */
	private String crc_gisu_status;
	
	/**
	 * 과정기수해시태그
	 */
	private String crc_gisu_hashtag;
	
	/**
	 * 분반(IT)
	 */
    private String crc_gisu_it_class;
    
    /**
     * 분반(외국어)
     */
    private String crc_gisu_foreign_class;
    
    /**
     * 기수교육인원
     */
    private int crc_gisu_occupancy;
    
    /**
     * 기수교육장소
     */
    private String crc_gisu_location;
    
    /**
     * 기수교육일수
     */
    private int crc_gisu_days;
    
    /**
     * 기수교육월수
     */
    private int crc_gisu_months;
    
    /**
     * 기수교육시간
     */
    private int crc_gisu_times;
    
    /**
     * 기수교육기간시작일
     */
    private Date crc_gisu_edu_start_dt;
    
    /**
     * 기수교육기간종료일
     */
    private Date crc_gisu_edu_end_dt;
    
    /**
     * 기수수강신청기간시작일
     */
    private Date crc_gisu_enroll_start_dt;
    
    /**
     * 기수수강신청기간종료일
     */
    private Date crc_gisu_enroll_end_dt;
    
    /**
     * 기수복습기간
     */
    private Date crc_gisu_repeat_start_dt;
    
    /**
     * 기수복습기간종료일
     */
    private Date crc_gisu_repeat_end_dt;
    
    /**
     * 등록자
     */
    private String crc_gisu_ins_id;
    
    /**
     * 등록일자
     */
    private String crc_gisu_ins_dt;
    
    /**
     * 수정자
     */
    private String crc_gisu_udt_id;
    
    /**
     * 수정일자
     */
    private String crc_gisu_udt_dt;

	/**
	 * @Desc : 
	 */
	public SocietySmtpAdminCurriculumGisu() {
		super();
	}

	/**
	 * @Desc : 
	 * @param crc_gisu_code
	 * @param crc_code
	 * @param crc_nm
	 * @param crc_gisu_nm
	 * @param crc_gisu_num
	 * @param crc_gisu_section
	 * @param crc_gisu_subsection
	 * @param crc_gisu_introduction
	 * @param crc_gisu_img_file
	 * @param crc_gisu_img_origin
	 * @param crc_gisu_img_saved
	 * @param crc_gisu_pay
	 * @param crc_gisu_pay_opt
	 * @param crc_gisu_division
	 * @param crc_gisu_graduation_opt
	 * @param crc_gisu_graduation_opt2
	 * @param crc_gisu_status
	 * @param crc_gisu_hashtag
	 * @param crc_gisu_it_class
	 * @param crc_gisu_foreign_class
	 * @param crc_gisu_occupancy
	 * @param crc_gisu_location
	 * @param crc_gisu_days
	 * @param crc_gisu_months
	 * @param crc_gisu_times
	 * @param crc_gisu_edu_start_dt
	 * @param crc_gisu_edu_end_dt
	 * @param crc_gisu_enroll_start_dt
	 * @param crc_gisu_enroll_end_dt
	 * @param crc_gisu_repeat_start_dt
	 * @param crc_gisu_repeat_end_dt
	 * @param crc_gisu_ins_id
	 * @param crc_gisu_ins_dt
	 * @param crc_gisu_udt_id
	 * @param crc_gisu_udt_dt
	 */
	public SocietySmtpAdminCurriculumGisu(String crc_gisu_code, String crc_code, String crc_nm, String crc_gisu_nm,
			int crc_gisu_num, String crc_gisu_section, String crc_gisu_subsection, String crc_gisu_introduction,
			CommonsMultipartFile crc_gisu_img_file, String crc_gisu_img_origin, String crc_gisu_img_saved,
			int crc_gisu_pay, String crc_gisu_pay_opt, String crc_gisu_division, String crc_gisu_graduation_opt,
			String crc_gisu_graduation_opt2, String crc_gisu_status, String crc_gisu_hashtag, String crc_gisu_it_class,
			String crc_gisu_foreign_class, int crc_gisu_occupancy, String crc_gisu_location, int crc_gisu_days,
			int crc_gisu_months, int crc_gisu_times, Date crc_gisu_edu_start_dt, Date crc_gisu_edu_end_dt,
			Date crc_gisu_enroll_start_dt, Date crc_gisu_enroll_end_dt, Date crc_gisu_repeat_start_dt,
			Date crc_gisu_repeat_end_dt, String crc_gisu_ins_id, String crc_gisu_ins_dt, String crc_gisu_udt_id,
			String crc_gisu_udt_dt) {
		super();
		this.crc_gisu_code = crc_gisu_code;
		this.crc_code = crc_code;
		this.crc_nm = crc_nm;
		this.crc_gisu_nm = crc_gisu_nm;
		this.crc_gisu_num = crc_gisu_num;
		this.crc_gisu_section = crc_gisu_section;
		this.crc_gisu_subsection = crc_gisu_subsection;
		this.crc_gisu_introduction = crc_gisu_introduction;
		this.crc_gisu_img_file = crc_gisu_img_file;
		this.crc_gisu_img_origin = crc_gisu_img_origin;
		this.crc_gisu_img_saved = crc_gisu_img_saved;
		this.crc_gisu_pay = crc_gisu_pay;
		this.crc_gisu_pay_opt = crc_gisu_pay_opt;
		this.crc_gisu_division = crc_gisu_division;
		this.crc_gisu_graduation_opt = crc_gisu_graduation_opt;
		this.crc_gisu_graduation_opt2 = crc_gisu_graduation_opt2;
		this.crc_gisu_status = crc_gisu_status;
		this.crc_gisu_hashtag = crc_gisu_hashtag;
		this.crc_gisu_it_class = crc_gisu_it_class;
		this.crc_gisu_foreign_class = crc_gisu_foreign_class;
		this.crc_gisu_occupancy = crc_gisu_occupancy;
		this.crc_gisu_location = crc_gisu_location;
		this.crc_gisu_days = crc_gisu_days;
		this.crc_gisu_months = crc_gisu_months;
		this.crc_gisu_times = crc_gisu_times;
		this.crc_gisu_edu_start_dt = crc_gisu_edu_start_dt;
		this.crc_gisu_edu_end_dt = crc_gisu_edu_end_dt;
		this.crc_gisu_enroll_start_dt = crc_gisu_enroll_start_dt;
		this.crc_gisu_enroll_end_dt = crc_gisu_enroll_end_dt;
		this.crc_gisu_repeat_start_dt = crc_gisu_repeat_start_dt;
		this.crc_gisu_repeat_end_dt = crc_gisu_repeat_end_dt;
		this.crc_gisu_ins_id = crc_gisu_ins_id;
		this.crc_gisu_ins_dt = crc_gisu_ins_dt;
		this.crc_gisu_udt_id = crc_gisu_udt_id;
		this.crc_gisu_udt_dt = crc_gisu_udt_dt;
	}

	/**
	 * @return the crc_gisu_code
	 */
	public String getCrc_gisu_code() {
		return crc_gisu_code;
	}

	/**
	 * @param crc_gisu_code the crc_gisu_code to set
	 */
	public void setCrc_gisu_code(String crc_gisu_code) {
		this.crc_gisu_code = crc_gisu_code;
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
	 * @return the crc_gisu_nm
	 */
	public String getCrc_gisu_nm() {
		return crc_gisu_nm;
	}

	/**
	 * @param crc_gisu_nm the crc_gisu_nm to set
	 */
	public void setCrc_gisu_nm(String crc_gisu_nm) {
		this.crc_gisu_nm = crc_gisu_nm;
	}

	/**
	 * @return the crc_gisu_num
	 */
	public int getCrc_gisu_num() {
		return crc_gisu_num;
	}

	/**
	 * @param crc_gisu_num the crc_gisu_num to set
	 */
	public void setCrc_gisu_num(int crc_gisu_num) {
		this.crc_gisu_num = crc_gisu_num;
	}

	/**
	 * @return the crc_gisu_section
	 */
	public String getCrc_gisu_section() {
		return crc_gisu_section;
	}

	/**
	 * @param crc_gisu_section the crc_gisu_section to set
	 */
	public void setCrc_gisu_section(String crc_gisu_section) {
		this.crc_gisu_section = crc_gisu_section;
	}

	/**
	 * @return the crc_gisu_subsection
	 */
	public String getCrc_gisu_subsection() {
		return crc_gisu_subsection;
	}

	/**
	 * @param crc_gisu_subsection the crc_gisu_subsection to set
	 */
	public void setCrc_gisu_subsection(String crc_gisu_subsection) {
		this.crc_gisu_subsection = crc_gisu_subsection;
	}

	/**
	 * @return the crc_gisu_introduction
	 */
	public String getCrc_gisu_introduction() {
		return crc_gisu_introduction;
	}

	/**
	 * @param crc_gisu_introduction the crc_gisu_introduction to set
	 */
	public void setCrc_gisu_introduction(String crc_gisu_introduction) {
		this.crc_gisu_introduction = crc_gisu_introduction;
	}

	/**
	 * @return the crc_gisu_img_file
	 */
	public CommonsMultipartFile getCrc_gisu_img_file() {
		return crc_gisu_img_file;
	}

	/**
	 * @param crc_gisu_img_file the crc_gisu_img_file to set
	 */
	public void setCrc_gisu_img_file(CommonsMultipartFile crc_gisu_img_file) {
		this.crc_gisu_img_file = crc_gisu_img_file;
	}

	/**
	 * @return the crc_gisu_img_origin
	 */
	public String getCrc_gisu_img_origin() {
		return crc_gisu_img_origin;
	}

	/**
	 * @param crc_gisu_img_origin the crc_gisu_img_origin to set
	 */
	public void setCrc_gisu_img_origin(String crc_gisu_img_origin) {
		this.crc_gisu_img_origin = crc_gisu_img_origin;
	}

	/**
	 * @return the crc_gisu_img_saved
	 */
	public String getCrc_gisu_img_saved() {
		return crc_gisu_img_saved;
	}

	/**
	 * @param crc_gisu_img_saved the crc_gisu_img_saved to set
	 */
	public void setCrc_gisu_img_saved(String crc_gisu_img_saved) {
		this.crc_gisu_img_saved = crc_gisu_img_saved;
	}

	/**
	 * @return the crc_gisu_pay
	 */
	public int getCrc_gisu_pay() {
		return crc_gisu_pay;
	}

	/**
	 * @param crc_gisu_pay the crc_gisu_pay to set
	 */
	public void setCrc_gisu_pay(int crc_gisu_pay) {
		this.crc_gisu_pay = crc_gisu_pay;
	}

	/**
	 * @return the crc_gisu_pay_opt
	 */
	public String getCrc_gisu_pay_opt() {
		return crc_gisu_pay_opt;
	}

	/**
	 * @param crc_gisu_pay_opt the crc_gisu_pay_opt to set
	 */
	public void setCrc_gisu_pay_opt(String crc_gisu_pay_opt) {
		this.crc_gisu_pay_opt = crc_gisu_pay_opt;
	}

	/**
	 * @return the crc_gisu_division
	 */
	public String getCrc_gisu_division() {
		return crc_gisu_division;
	}

	/**
	 * @param crc_gisu_division the crc_gisu_division to set
	 */
	public void setCrc_gisu_division(String crc_gisu_division) {
		this.crc_gisu_division = crc_gisu_division;
	}

	/**
	 * @return the crc_gisu_graduation_opt
	 */
	public String getCrc_gisu_graduation_opt() {
		return crc_gisu_graduation_opt;
	}

	/**
	 * @param crc_gisu_graduation_opt the crc_gisu_graduation_opt to set
	 */
	public void setCrc_gisu_graduation_opt(String crc_gisu_graduation_opt) {
		this.crc_gisu_graduation_opt = crc_gisu_graduation_opt;
	}

	/**
	 * @return the crc_gisu_graduation_opt2
	 */
	public String getCrc_gisu_graduation_opt2() {
		return crc_gisu_graduation_opt2;
	}

	/**
	 * @param crc_gisu_graduation_opt2 the crc_gisu_graduation_opt2 to set
	 */
	public void setCrc_gisu_graduation_opt2(String crc_gisu_graduation_opt2) {
		this.crc_gisu_graduation_opt2 = crc_gisu_graduation_opt2;
	}

	/**
	 * @return the crc_gisu_status
	 */
	public String getCrc_gisu_status() {
		return crc_gisu_status;
	}

	/**
	 * @param crc_gisu_status the crc_gisu_status to set
	 */
	public void setCrc_gisu_status(String crc_gisu_status) {
		this.crc_gisu_status = crc_gisu_status;
	}

	/**
	 * @return the crc_gisu_hashtag
	 */
	public String getCrc_gisu_hashtag() {
		return crc_gisu_hashtag;
	}

	/**
	 * @param crc_gisu_hashtag the crc_gisu_hashtag to set
	 */
	public void setCrc_gisu_hashtag(String crc_gisu_hashtag) {
		this.crc_gisu_hashtag = crc_gisu_hashtag;
	}

	/**
	 * @return the crc_gisu_it_class
	 */
	public String getCrc_gisu_it_class() {
		return crc_gisu_it_class;
	}

	/**
	 * @param crc_gisu_it_class the crc_gisu_it_class to set
	 */
	public void setCrc_gisu_it_class(String crc_gisu_it_class) {
		this.crc_gisu_it_class = crc_gisu_it_class;
	}

	/**
	 * @return the crc_gisu_foreign_class
	 */
	public String getCrc_gisu_foreign_class() {
		return crc_gisu_foreign_class;
	}

	/**
	 * @param crc_gisu_foreign_class the crc_gisu_foreign_class to set
	 */
	public void setCrc_gisu_foreign_class(String crc_gisu_foreign_class) {
		this.crc_gisu_foreign_class = crc_gisu_foreign_class;
	}

	/**
	 * @return the crc_gisu_occupancy
	 */
	public int getCrc_gisu_occupancy() {
		return crc_gisu_occupancy;
	}

	/**
	 * @param crc_gisu_occupancy the crc_gisu_occupancy to set
	 */
	public void setCrc_gisu_occupancy(int crc_gisu_occupancy) {
		this.crc_gisu_occupancy = crc_gisu_occupancy;
	}

	/**
	 * @return the crc_gisu_location
	 */
	public String getCrc_gisu_location() {
		return crc_gisu_location;
	}

	/**
	 * @param crc_gisu_location the crc_gisu_location to set
	 */
	public void setCrc_gisu_location(String crc_gisu_location) {
		this.crc_gisu_location = crc_gisu_location;
	}

	/**
	 * @return the crc_gisu_days
	 */
	public int getCrc_gisu_days() {
		return crc_gisu_days;
	}

	/**
	 * @param crc_gisu_days the crc_gisu_days to set
	 */
	public void setCrc_gisu_days(int crc_gisu_days) {
		this.crc_gisu_days = crc_gisu_days;
	}

	/**
	 * @return the crc_gisu_months
	 */
	public int getCrc_gisu_months() {
		return crc_gisu_months;
	}

	/**
	 * @param crc_gisu_months the crc_gisu_months to set
	 */
	public void setCrc_gisu_months(int crc_gisu_months) {
		this.crc_gisu_months = crc_gisu_months;
	}

	/**
	 * @return the crc_gisu_times
	 */
	public int getCrc_gisu_times() {
		return crc_gisu_times;
	}

	/**
	 * @param crc_gisu_times the crc_gisu_times to set
	 */
	public void setCrc_gisu_times(int crc_gisu_times) {
		this.crc_gisu_times = crc_gisu_times;
	}

	/**
	 * @return the crc_gisu_edu_start_dt
	 */
	public Date getCrc_gisu_edu_start_dt() {
		return crc_gisu_edu_start_dt;
	}

	/**
	 * @param crc_gisu_edu_start_dt the crc_gisu_edu_start_dt to set
	 */
	public void setCrc_gisu_edu_start_dt(Date crc_gisu_edu_start_dt) {
		this.crc_gisu_edu_start_dt = crc_gisu_edu_start_dt;
	}

	/**
	 * @return the crc_gisu_edu_end_dt
	 */
	public Date getCrc_gisu_edu_end_dt() {
		return crc_gisu_edu_end_dt;
	}

	/**
	 * @param crc_gisu_edu_end_dt the crc_gisu_edu_end_dt to set
	 */
	public void setCrc_gisu_edu_end_dt(Date crc_gisu_edu_end_dt) {
		this.crc_gisu_edu_end_dt = crc_gisu_edu_end_dt;
	}

	/**
	 * @return the crc_gisu_enroll_start_dt
	 */
	public Date getCrc_gisu_enroll_start_dt() {
		return crc_gisu_enroll_start_dt;
	}

	/**
	 * @param crc_gisu_enroll_start_dt the crc_gisu_enroll_start_dt to set
	 */
	public void setCrc_gisu_enroll_start_dt(Date crc_gisu_enroll_start_dt) {
		this.crc_gisu_enroll_start_dt = crc_gisu_enroll_start_dt;
	}

	/**
	 * @return the crc_gisu_enroll_end_dt
	 */
	public Date getCrc_gisu_enroll_end_dt() {
		return crc_gisu_enroll_end_dt;
	}

	/**
	 * @param crc_gisu_enroll_end_dt the crc_gisu_enroll_end_dt to set
	 */
	public void setCrc_gisu_enroll_end_dt(Date crc_gisu_enroll_end_dt) {
		this.crc_gisu_enroll_end_dt = crc_gisu_enroll_end_dt;
	}

	/**
	 * @return the crc_gisu_repeat_start_dt
	 */
	public Date getCrc_gisu_repeat_start_dt() {
		return crc_gisu_repeat_start_dt;
	}

	/**
	 * @param crc_gisu_repeat_start_dt the crc_gisu_repeat_start_dt to set
	 */
	public void setCrc_gisu_repeat_start_dt(Date crc_gisu_repeat_start_dt) {
		this.crc_gisu_repeat_start_dt = crc_gisu_repeat_start_dt;
	}

	/**
	 * @return the crc_gisu_repeat_end_dt
	 */
	public Date getCrc_gisu_repeat_end_dt() {
		return crc_gisu_repeat_end_dt;
	}

	/**
	 * @param crc_gisu_repeat_end_dt the crc_gisu_repeat_end_dt to set
	 */
	public void setCrc_gisu_repeat_end_dt(Date crc_gisu_repeat_end_dt) {
		this.crc_gisu_repeat_end_dt = crc_gisu_repeat_end_dt;
	}

	/**
	 * @return the crc_gisu_ins_id
	 */
	public String getCrc_gisu_ins_id() {
		return crc_gisu_ins_id;
	}

	/**
	 * @param crc_gisu_ins_id the crc_gisu_ins_id to set
	 */
	public void setCrc_gisu_ins_id(String crc_gisu_ins_id) {
		this.crc_gisu_ins_id = crc_gisu_ins_id;
	}

	/**
	 * @return the crc_gisu_ins_dt
	 */
	public String getCrc_gisu_ins_dt() {
		return crc_gisu_ins_dt;
	}

	/**
	 * @param crc_gisu_ins_dt the crc_gisu_ins_dt to set
	 */
	public void setCrc_gisu_ins_dt(String crc_gisu_ins_dt) {
		this.crc_gisu_ins_dt = crc_gisu_ins_dt;
	}

	/**
	 * @return the crc_gisu_udt_id
	 */
	public String getCrc_gisu_udt_id() {
		return crc_gisu_udt_id;
	}

	/**
	 * @param crc_gisu_udt_id the crc_gisu_udt_id to set
	 */
	public void setCrc_gisu_udt_id(String crc_gisu_udt_id) {
		this.crc_gisu_udt_id = crc_gisu_udt_id;
	}

	/**
	 * @return the crc_gisu_udt_dt
	 */
	public String getCrc_gisu_udt_dt() {
		return crc_gisu_udt_dt;
	}

	/**
	 * @param crc_gisu_udt_dt the crc_gisu_udt_dt to set
	 */
	public void setCrc_gisu_udt_dt(String crc_gisu_udt_dt) {
		this.crc_gisu_udt_dt = crc_gisu_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietySmtpAdminCurriculumGisu [crc_gisu_code=" + crc_gisu_code + ", crc_code=" + crc_code + ", crc_nm="
				+ crc_nm + ", crc_gisu_nm=" + crc_gisu_nm + ", crc_gisu_num=" + crc_gisu_num + ", crc_gisu_section="
				+ crc_gisu_section + ", crc_gisu_subsection=" + crc_gisu_subsection + ", crc_gisu_introduction="
				+ crc_gisu_introduction + ", crc_gisu_img_file=" + crc_gisu_img_file + ", crc_gisu_img_origin="
				+ crc_gisu_img_origin + ", crc_gisu_img_saved=" + crc_gisu_img_saved + ", crc_gisu_pay=" + crc_gisu_pay
				+ ", crc_gisu_pay_opt=" + crc_gisu_pay_opt + ", crc_gisu_division=" + crc_gisu_division
				+ ", crc_gisu_graduation_opt=" + crc_gisu_graduation_opt + ", crc_gisu_graduation_opt2="
				+ crc_gisu_graduation_opt2 + ", crc_gisu_status=" + crc_gisu_status + ", crc_gisu_hashtag="
				+ crc_gisu_hashtag + ", crc_gisu_it_class=" + crc_gisu_it_class + ", crc_gisu_foreign_class="
				+ crc_gisu_foreign_class + ", crc_gisu_occupancy=" + crc_gisu_occupancy + ", crc_gisu_location="
				+ crc_gisu_location + ", crc_gisu_days=" + crc_gisu_days + ", crc_gisu_months=" + crc_gisu_months
				+ ", crc_gisu_times=" + crc_gisu_times + ", crc_gisu_edu_start_dt=" + crc_gisu_edu_start_dt
				+ ", crc_gisu_edu_end_dt=" + crc_gisu_edu_end_dt + ", crc_gisu_enroll_start_dt="
				+ crc_gisu_enroll_start_dt + ", crc_gisu_enroll_end_dt=" + crc_gisu_enroll_end_dt
				+ ", crc_gisu_repeat_start_dt=" + crc_gisu_repeat_start_dt + ", crc_gisu_repeat_end_dt="
				+ crc_gisu_repeat_end_dt + ", crc_gisu_ins_id=" + crc_gisu_ins_id + ", crc_gisu_ins_dt="
				+ crc_gisu_ins_dt + ", crc_gisu_udt_id=" + crc_gisu_udt_id + ", crc_gisu_udt_dt=" + crc_gisu_udt_dt
				+ "]";
	}
    
}