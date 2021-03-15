/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : Fap 채용공고 기본 정보
 * 
 */
public class SocietyFapJobAd {
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 회사 아이디(외래키)
	 */
	private String fap_comp_id;
	
	/**
	 * JOBFAIR 세부 일련번호(외래키)
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * JOBFAIR 일련번호(외래키)
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 회사잡페어 등록정보 일련번호(외래키)
	 */
	private int fap_jobfair_comp_seq;
	
	/**
	 * 주요사업분야
	 */
	private String fap_job_ad_major_business;
	
	/**
	 * 홈페이지
	 */
	private String fap_job_ad_homepage;
	
	/**
	 * 설립일
	 */
	private String fap_job_ad_est_dt;
	
	/**
	 * 자본금
	 */
	private long fap_job_ad_stock;
	
	/**
	 * 최근3년평균매출
	 */
	private long fap_job_ad_3years_avg_sales;
	
	/**
	 * 종업원수
	 */
	private int fap_job_ad_employee_num;
	
	/**
	 * 외국인사원수
	 */
	private int fap_job_ad_foreigner_num;
	
	/**
	 * 한국인사원수
	 */
	private int fap_job_ad_korean_num;
	
	/**
	 * 우편번호
	 */
	private String fap_job_ad_postcode;
	
	/**
	 * 주소
	 */
	private String fap_job_ad_address;
	
	/**
	 * 상세주소
	 */
	private String fap_job_ad_address_dtl;
	
	/**
	 * 채용공고제목
	 */
	private String fap_job_ad_title;
	
	/**
	 * 근무시간
	 */
	private String fap_job_ad_worktime;
    
	/**
	 * 평균잔업시간
	 */
	private String fap_job_ad_overtime;
	
	/**
	 * 고용형태(공통코드)
	 */
	private String fap_job_ad_hire_type;
	
	/**
	 * 시용기간 유무(공통코드)
	 */
	private String fap_job_ad_intern;
	
	/**
	 * 채용예정인원
	 */
	private int fap_job_ad_recruit_num;
	
	/**
	 * 인재상
	 */
	private String fap_job_ad_ideal_person;
	
	/**
	 * 희망연령(공통코드)
	 */
	private String fap_job_ad_age;
	
	/**
	 * 희망성별(공통코드)
	 */
	private String fap_job_ad_gender;
	
	/**
	 * 기숙사유무(공통코드)
	 */
	private String fap_job_ad_isdorm;
	
	/**
	 * 승진
	 */
	private String fap_job_ad_promotion;
	
	/**
	 * 휴가
	 */
	private String fap_job_ad_vacation;
	
	/**
	 * 기타복리후생
	 */
	private String fap_job_ad_welfare;
	
	/**
	 * SCIT성적공개 희망여부(공통코드)
	 */
	private String fap_job_ad_open_grade;
	
	/**
	 * 재류자격 정보처리기사 필요여부(공통코드)
	 */
	private String fap_job_ad_qual_dpe;
	
	/**
	 * 채용조건 정보처리기사 필요여부(공통코드)
	 */
	private String fap_job_ad_terms_dpe;
	
	/**
	 * 과정수료 동의여부(공통코드)
	 */
	private String fap_job_ad_coc_agree;
	
	/**
	 * 중복지원 가능여부(공통코드)
	 */
	private String fap_job_ad_overlap;
	
	/**
	 * 기업그룹코드
	 */
	private String fap_job_ad_groupcode;
	
	/**
	 * 채용공고상태(공통코드)
	 */
	private String fap_job_ad_state;
	
	/**
	 * 미스매칭 여부(공통코드)
	 */
	private String fap_job_ad_is_mismatching;
	
	/**
	 * 모집직종 계열(공통코드)
	 * */
	private String fap_job_ad_category_type;
	
	/**
	 * 지원 룰 타입(공통코드)
	 * */
	private String fap_job_ad_rule_type;
	
	/**
	 * 등록자
	 */
	private String fap_job_ad_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_ad_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_ad_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_ad_udt_dt;

	public SocietyFapJobAd() {
		super();
	}

	public SocietyFapJobAd(long fap_job_ad_seq, String fap_comp_id, int fap_jobfair_divide_seq, int fap_jobfair_seq,
			int fap_jobfair_comp_seq, String fap_job_ad_major_business, String fap_job_ad_homepage,
			String fap_job_ad_est_dt, long fap_job_ad_stock, long fap_job_ad_3years_avg_sales,
			int fap_job_ad_employee_num, int fap_job_ad_foreigner_num, int fap_job_ad_korean_num,
			String fap_job_ad_postcode, String fap_job_ad_address, String fap_job_ad_address_dtl,
			String fap_job_ad_title, String fap_job_ad_worktime, String fap_job_ad_overtime,
			String fap_job_ad_hire_type, String fap_job_ad_intern, int fap_job_ad_recruit_num,
			String fap_job_ad_ideal_person, String fap_job_ad_age, String fap_job_ad_gender, String fap_job_ad_isdorm,
			String fap_job_ad_promotion, String fap_job_ad_vacation, String fap_job_ad_welfare,
			String fap_job_ad_open_grade, String fap_job_ad_qual_dpe, String fap_job_ad_terms_dpe,
			String fap_job_ad_coc_agree, String fap_job_ad_overlap, String fap_job_ad_groupcode,
			String fap_job_ad_state, String fap_job_ad_is_mismatching, String fap_job_ad_category_type,
			String fap_job_ad_rule_type, String fap_job_ad_ins_id, String fap_job_ad_ins_dt, String fap_job_ad_udt_id,
			String fap_job_ad_udt_dt) {
		super();
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_comp_id = fap_comp_id;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_comp_seq = fap_jobfair_comp_seq;
		this.fap_job_ad_major_business = fap_job_ad_major_business;
		this.fap_job_ad_homepage = fap_job_ad_homepage;
		this.fap_job_ad_est_dt = fap_job_ad_est_dt;
		this.fap_job_ad_stock = fap_job_ad_stock;
		this.fap_job_ad_3years_avg_sales = fap_job_ad_3years_avg_sales;
		this.fap_job_ad_employee_num = fap_job_ad_employee_num;
		this.fap_job_ad_foreigner_num = fap_job_ad_foreigner_num;
		this.fap_job_ad_korean_num = fap_job_ad_korean_num;
		this.fap_job_ad_postcode = fap_job_ad_postcode;
		this.fap_job_ad_address = fap_job_ad_address;
		this.fap_job_ad_address_dtl = fap_job_ad_address_dtl;
		this.fap_job_ad_title = fap_job_ad_title;
		this.fap_job_ad_worktime = fap_job_ad_worktime;
		this.fap_job_ad_overtime = fap_job_ad_overtime;
		this.fap_job_ad_hire_type = fap_job_ad_hire_type;
		this.fap_job_ad_intern = fap_job_ad_intern;
		this.fap_job_ad_recruit_num = fap_job_ad_recruit_num;
		this.fap_job_ad_ideal_person = fap_job_ad_ideal_person;
		this.fap_job_ad_age = fap_job_ad_age;
		this.fap_job_ad_gender = fap_job_ad_gender;
		this.fap_job_ad_isdorm = fap_job_ad_isdorm;
		this.fap_job_ad_promotion = fap_job_ad_promotion;
		this.fap_job_ad_vacation = fap_job_ad_vacation;
		this.fap_job_ad_welfare = fap_job_ad_welfare;
		this.fap_job_ad_open_grade = fap_job_ad_open_grade;
		this.fap_job_ad_qual_dpe = fap_job_ad_qual_dpe;
		this.fap_job_ad_terms_dpe = fap_job_ad_terms_dpe;
		this.fap_job_ad_coc_agree = fap_job_ad_coc_agree;
		this.fap_job_ad_overlap = fap_job_ad_overlap;
		this.fap_job_ad_groupcode = fap_job_ad_groupcode;
		this.fap_job_ad_state = fap_job_ad_state;
		this.fap_job_ad_is_mismatching = fap_job_ad_is_mismatching;
		this.fap_job_ad_category_type = fap_job_ad_category_type;
		this.fap_job_ad_rule_type = fap_job_ad_rule_type;
		this.fap_job_ad_ins_id = fap_job_ad_ins_id;
		this.fap_job_ad_ins_dt = fap_job_ad_ins_dt;
		this.fap_job_ad_udt_id = fap_job_ad_udt_id;
		this.fap_job_ad_udt_dt = fap_job_ad_udt_dt;
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

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public int getFap_jobfair_comp_seq() {
		return fap_jobfair_comp_seq;
	}

	public void setFap_jobfair_comp_seq(int fap_jobfair_comp_seq) {
		this.fap_jobfair_comp_seq = fap_jobfair_comp_seq;
	}

	public String getFap_job_ad_major_business() {
		return fap_job_ad_major_business;
	}

	public void setFap_job_ad_major_business(String fap_job_ad_major_business) {
		this.fap_job_ad_major_business = fap_job_ad_major_business;
	}

	public String getFap_job_ad_homepage() {
		return fap_job_ad_homepage;
	}

	public void setFap_job_ad_homepage(String fap_job_ad_homepage) {
		this.fap_job_ad_homepage = fap_job_ad_homepage;
	}

	public String getFap_job_ad_est_dt() {
		return fap_job_ad_est_dt;
	}

	public void setFap_job_ad_est_dt(String fap_job_ad_est_dt) {
		this.fap_job_ad_est_dt = fap_job_ad_est_dt;
	}

	public long getFap_job_ad_stock() {
		return fap_job_ad_stock;
	}

	public void setFap_job_ad_stock(long fap_job_ad_stock) {
		this.fap_job_ad_stock = fap_job_ad_stock;
	}

	public long getFap_job_ad_3years_avg_sales() {
		return fap_job_ad_3years_avg_sales;
	}

	public void setFap_job_ad_3years_avg_sales(long fap_job_ad_3years_avg_sales) {
		this.fap_job_ad_3years_avg_sales = fap_job_ad_3years_avg_sales;
	}

	public int getFap_job_ad_employee_num() {
		return fap_job_ad_employee_num;
	}

	public void setFap_job_ad_employee_num(int fap_job_ad_employee_num) {
		this.fap_job_ad_employee_num = fap_job_ad_employee_num;
	}

	public int getFap_job_ad_foreigner_num() {
		return fap_job_ad_foreigner_num;
	}

	public void setFap_job_ad_foreigner_num(int fap_job_ad_foreigner_num) {
		this.fap_job_ad_foreigner_num = fap_job_ad_foreigner_num;
	}

	public int getFap_job_ad_korean_num() {
		return fap_job_ad_korean_num;
	}

	public void setFap_job_ad_korean_num(int fap_job_ad_korean_num) {
		this.fap_job_ad_korean_num = fap_job_ad_korean_num;
	}

	public String getFap_job_ad_postcode() {
		return fap_job_ad_postcode;
	}

	public void setFap_job_ad_postcode(String fap_job_ad_postcode) {
		this.fap_job_ad_postcode = fap_job_ad_postcode;
	}

	public String getFap_job_ad_address() {
		return fap_job_ad_address;
	}

	public void setFap_job_ad_address(String fap_job_ad_address) {
		this.fap_job_ad_address = fap_job_ad_address;
	}

	public String getFap_job_ad_address_dtl() {
		return fap_job_ad_address_dtl;
	}

	public void setFap_job_ad_address_dtl(String fap_job_ad_address_dtl) {
		this.fap_job_ad_address_dtl = fap_job_ad_address_dtl;
	}

	public String getFap_job_ad_title() {
		return fap_job_ad_title;
	}

	public void setFap_job_ad_title(String fap_job_ad_title) {
		this.fap_job_ad_title = fap_job_ad_title;
	}

	public String getFap_job_ad_worktime() {
		return fap_job_ad_worktime;
	}

	public void setFap_job_ad_worktime(String fap_job_ad_worktime) {
		this.fap_job_ad_worktime = fap_job_ad_worktime;
	}

	public String getFap_job_ad_overtime() {
		return fap_job_ad_overtime;
	}

	public void setFap_job_ad_overtime(String fap_job_ad_overtime) {
		this.fap_job_ad_overtime = fap_job_ad_overtime;
	}

	public String getFap_job_ad_hire_type() {
		return fap_job_ad_hire_type;
	}

	public void setFap_job_ad_hire_type(String fap_job_ad_hire_type) {
		this.fap_job_ad_hire_type = fap_job_ad_hire_type;
	}

	public String getFap_job_ad_intern() {
		return fap_job_ad_intern;
	}

	public void setFap_job_ad_intern(String fap_job_ad_intern) {
		this.fap_job_ad_intern = fap_job_ad_intern;
	}

	public int getFap_job_ad_recruit_num() {
		return fap_job_ad_recruit_num;
	}

	public void setFap_job_ad_recruit_num(int fap_job_ad_recruit_num) {
		this.fap_job_ad_recruit_num = fap_job_ad_recruit_num;
	}

	public String getFap_job_ad_ideal_person() {
		return fap_job_ad_ideal_person;
	}

	public void setFap_job_ad_ideal_person(String fap_job_ad_ideal_person) {
		this.fap_job_ad_ideal_person = fap_job_ad_ideal_person;
	}

	public String getFap_job_ad_age() {
		return fap_job_ad_age;
	}

	public void setFap_job_ad_age(String fap_job_ad_age) {
		this.fap_job_ad_age = fap_job_ad_age;
	}

	public String getFap_job_ad_gender() {
		return fap_job_ad_gender;
	}

	public void setFap_job_ad_gender(String fap_job_ad_gender) {
		this.fap_job_ad_gender = fap_job_ad_gender;
	}

	public String getFap_job_ad_isdorm() {
		return fap_job_ad_isdorm;
	}

	public void setFap_job_ad_isdorm(String fap_job_ad_isdorm) {
		this.fap_job_ad_isdorm = fap_job_ad_isdorm;
	}

	public String getFap_job_ad_promotion() {
		return fap_job_ad_promotion;
	}

	public void setFap_job_ad_promotion(String fap_job_ad_promotion) {
		this.fap_job_ad_promotion = fap_job_ad_promotion;
	}

	public String getFap_job_ad_vacation() {
		return fap_job_ad_vacation;
	}

	public void setFap_job_ad_vacation(String fap_job_ad_vacation) {
		this.fap_job_ad_vacation = fap_job_ad_vacation;
	}

	public String getFap_job_ad_welfare() {
		return fap_job_ad_welfare;
	}

	public void setFap_job_ad_welfare(String fap_job_ad_welfare) {
		this.fap_job_ad_welfare = fap_job_ad_welfare;
	}

	public String getFap_job_ad_open_grade() {
		return fap_job_ad_open_grade;
	}

	public void setFap_job_ad_open_grade(String fap_job_ad_open_grade) {
		this.fap_job_ad_open_grade = fap_job_ad_open_grade;
	}

	public String getFap_job_ad_qual_dpe() {
		return fap_job_ad_qual_dpe;
	}

	public void setFap_job_ad_qual_dpe(String fap_job_ad_qual_dpe) {
		this.fap_job_ad_qual_dpe = fap_job_ad_qual_dpe;
	}

	public String getFap_job_ad_terms_dpe() {
		return fap_job_ad_terms_dpe;
	}

	public void setFap_job_ad_terms_dpe(String fap_job_ad_terms_dpe) {
		this.fap_job_ad_terms_dpe = fap_job_ad_terms_dpe;
	}

	public String getFap_job_ad_coc_agree() {
		return fap_job_ad_coc_agree;
	}

	public void setFap_job_ad_coc_agree(String fap_job_ad_coc_agree) {
		this.fap_job_ad_coc_agree = fap_job_ad_coc_agree;
	}

	public String getFap_job_ad_overlap() {
		return fap_job_ad_overlap;
	}

	public void setFap_job_ad_overlap(String fap_job_ad_overlap) {
		this.fap_job_ad_overlap = fap_job_ad_overlap;
	}

	public String getFap_job_ad_groupcode() {
		return fap_job_ad_groupcode;
	}

	public void setFap_job_ad_groupcode(String fap_job_ad_groupcode) {
		this.fap_job_ad_groupcode = fap_job_ad_groupcode;
	}

	public String getFap_job_ad_state() {
		return fap_job_ad_state;
	}

	public void setFap_job_ad_state(String fap_job_ad_state) {
		this.fap_job_ad_state = fap_job_ad_state;
	}

	public String getFap_job_ad_is_mismatching() {
		return fap_job_ad_is_mismatching;
	}

	public void setFap_job_ad_is_mismatching(String fap_job_ad_is_mismatching) {
		this.fap_job_ad_is_mismatching = fap_job_ad_is_mismatching;
	}

	public String getFap_job_ad_category_type() {
		return fap_job_ad_category_type;
	}

	public void setFap_job_ad_category_type(String fap_job_ad_category_type) {
		this.fap_job_ad_category_type = fap_job_ad_category_type;
	}

	public String getFap_job_ad_rule_type() {
		return fap_job_ad_rule_type;
	}

	public void setFap_job_ad_rule_type(String fap_job_ad_rule_type) {
		this.fap_job_ad_rule_type = fap_job_ad_rule_type;
	}

	public String getFap_job_ad_ins_id() {
		return fap_job_ad_ins_id;
	}

	public void setFap_job_ad_ins_id(String fap_job_ad_ins_id) {
		this.fap_job_ad_ins_id = fap_job_ad_ins_id;
	}

	public String getFap_job_ad_ins_dt() {
		return fap_job_ad_ins_dt;
	}

	public void setFap_job_ad_ins_dt(String fap_job_ad_ins_dt) {
		this.fap_job_ad_ins_dt = fap_job_ad_ins_dt;
	}

	public String getFap_job_ad_udt_id() {
		return fap_job_ad_udt_id;
	}

	public void setFap_job_ad_udt_id(String fap_job_ad_udt_id) {
		this.fap_job_ad_udt_id = fap_job_ad_udt_id;
	}

	public String getFap_job_ad_udt_dt() {
		return fap_job_ad_udt_dt;
	}

	public void setFap_job_ad_udt_dt(String fap_job_ad_udt_dt) {
		this.fap_job_ad_udt_dt = fap_job_ad_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobAd [fap_job_ad_seq=" + fap_job_ad_seq + ", fap_comp_id=" + fap_comp_id
				+ ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", fap_jobfair_seq=" + fap_jobfair_seq
				+ ", fap_jobfair_comp_seq=" + fap_jobfair_comp_seq + ", fap_job_ad_major_business="
				+ fap_job_ad_major_business + ", fap_job_ad_homepage=" + fap_job_ad_homepage + ", fap_job_ad_est_dt="
				+ fap_job_ad_est_dt + ", fap_job_ad_stock=" + fap_job_ad_stock + ", fap_job_ad_3years_avg_sales="
				+ fap_job_ad_3years_avg_sales + ", fap_job_ad_employee_num=" + fap_job_ad_employee_num
				+ ", fap_job_ad_foreigner_num=" + fap_job_ad_foreigner_num + ", fap_job_ad_korean_num="
				+ fap_job_ad_korean_num + ", fap_job_ad_postcode=" + fap_job_ad_postcode + ", fap_job_ad_address="
				+ fap_job_ad_address + ", fap_job_ad_address_dtl=" + fap_job_ad_address_dtl + ", fap_job_ad_title="
				+ fap_job_ad_title + ", fap_job_ad_worktime=" + fap_job_ad_worktime + ", fap_job_ad_overtime="
				+ fap_job_ad_overtime + ", fap_job_ad_hire_type=" + fap_job_ad_hire_type + ", fap_job_ad_intern="
				+ fap_job_ad_intern + ", fap_job_ad_recruit_num=" + fap_job_ad_recruit_num
				+ ", fap_job_ad_ideal_person=" + fap_job_ad_ideal_person + ", fap_job_ad_age=" + fap_job_ad_age
				+ ", fap_job_ad_gender=" + fap_job_ad_gender + ", fap_job_ad_isdorm=" + fap_job_ad_isdorm
				+ ", fap_job_ad_promotion=" + fap_job_ad_promotion + ", fap_job_ad_vacation=" + fap_job_ad_vacation
				+ ", fap_job_ad_welfare=" + fap_job_ad_welfare + ", fap_job_ad_open_grade=" + fap_job_ad_open_grade
				+ ", fap_job_ad_qual_dpe=" + fap_job_ad_qual_dpe + ", fap_job_ad_terms_dpe=" + fap_job_ad_terms_dpe
				+ ", fap_job_ad_coc_agree=" + fap_job_ad_coc_agree + ", fap_job_ad_overlap=" + fap_job_ad_overlap
				+ ", fap_job_ad_groupcode=" + fap_job_ad_groupcode + ", fap_job_ad_state=" + fap_job_ad_state
				+ ", fap_job_ad_is_mismatching=" + fap_job_ad_is_mismatching + ", fap_job_ad_category_type="
				+ fap_job_ad_category_type + ", fap_job_ad_rule_type=" + fap_job_ad_rule_type + ", fap_job_ad_ins_id="
				+ fap_job_ad_ins_id + ", fap_job_ad_ins_dt=" + fap_job_ad_ins_dt + ", fap_job_ad_udt_id="
				+ fap_job_ad_udt_id + ", fap_job_ad_udt_dt=" + fap_job_ad_udt_dt + "]";
	}

}
