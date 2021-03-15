/**
 * 
 */
package global.segroup.society.edu.admin.domain;

/**
 * @Author : 이종호, 신동철 수정
 * @Date : 2017. 8. 4  -> 2018. 9. 17
 * @Class 설명 : Society 모집홍보 기수 정보
 * 
 */
public class SocietyEduAdminCurriculumGisu {

	/**
	 * 기수 정보 시퀀스
	 */
	private int gisu_seq;
	
	/**
	 * 과정 정보 시퀀스
	 */
	private int crc_seq;
	
	/**
	 * 기수
	 */
	private int gisu_num;
	
	/**
	 * 과정명 
	 */
	private String gisu_crc_class;
	
	/**
	 * 과정명
	 */
	private String gisu_crc_nm;
	
	/**
	 * 교육일수
	 */
	private int gisu_crc_month;
	
	/**
	 * 교육일수
	 */
	private int gisu_crc_days;
	
	/**
	 * 교육일수
	 */
	private int gisu_crc_times;
	
	/**
	 * 교육비
	 */
	private int gisu_crc_pay;

	/**
	 * 교육인원
	 */
	private int gisu_crc_personnel;

	/**
	 * 교육장소
	 */
	private String gisu_crc_location;
	
	/**
	 * 신청 시작일
	 */
	private String gisu_app_st;
	
	/**
	 * 신청 종료일
	 */
	private String gisu_app_et;
	
	/**
	 * 과정 시작일
	 */
	private String gisu_crc_st;
	
	/**
	 * 과정 종료일
	 */
	private String gisu_crc_et;
	
	/**
	 * 기수 노출 승인 여부
	 */
	private String gisu_per;
	
	/**
	 * 과정소개 
	 */
	private String gisu_crc_intro;
		
	/**
	 * 신청인
	 */
	private String gisu_ins_id;
	
	/**
	 * 신청 일자
	 */
	private String gisu_ins_dt;
	
	/**
	 * 수정인
	 */
	private String gisu_udt_id;
	
	/**
	 * 수정 일자
	 */
	private String gisu_udt_dt;
	
	/**
	 * 그림파일 수정여부(true/false)
	 */
	private boolean gisu_crc_img_updated;

	/**
	 * 과정 구분
	 */
	private String gisu_crc_division;
	
	public SocietyEduAdminCurriculumGisu() {
		super();
	}

	public SocietyEduAdminCurriculumGisu(int gisu_seq, int crc_seq, int gisu_num, String gisu_crc_class,
			String gisu_crc_nm, int gisu_crc_month, int gisu_crc_days, int gisu_crc_times, int gisu_crc_pay,
			int gisu_crc_personnel, String gisu_crc_location, String gisu_app_st, String gisu_app_et,
			String gisu_crc_st, String gisu_crc_et, String gisu_per, String gisu_crc_intro, String gisu_ins_id,
			String gisu_ins_dt, String gisu_udt_id, String gisu_udt_dt, boolean gisu_crc_img_updated,
			String gisu_crc_division) {
		super();
		this.gisu_seq = gisu_seq;
		this.crc_seq = crc_seq;
		this.gisu_num = gisu_num;
		this.gisu_crc_class = gisu_crc_class;
		this.gisu_crc_nm = gisu_crc_nm;
		this.gisu_crc_month = gisu_crc_month;
		this.gisu_crc_days = gisu_crc_days;
		this.gisu_crc_times = gisu_crc_times;
		this.gisu_crc_pay = gisu_crc_pay;
		this.gisu_crc_personnel = gisu_crc_personnel;
		this.gisu_crc_location = gisu_crc_location;
		this.gisu_app_st = gisu_app_st;
		this.gisu_app_et = gisu_app_et;
		this.gisu_crc_st = gisu_crc_st;
		this.gisu_crc_et = gisu_crc_et;
		this.gisu_per = gisu_per;
		this.gisu_crc_intro = gisu_crc_intro;
		this.gisu_ins_id = gisu_ins_id;
		this.gisu_ins_dt = gisu_ins_dt;
		this.gisu_udt_id = gisu_udt_id;
		this.gisu_udt_dt = gisu_udt_dt;
		this.gisu_crc_img_updated = gisu_crc_img_updated;
		this.gisu_crc_division = gisu_crc_division;
	}

	public int getGisu_seq() {
		return gisu_seq;
	}

	public void setGisu_seq(int gisu_seq) {
		this.gisu_seq = gisu_seq;
	}

	public int getCrc_seq() {
		return crc_seq;
	}

	public void setCrc_seq(int crc_seq) {
		this.crc_seq = crc_seq;
	}

	public int getGisu_num() {
		return gisu_num;
	}

	public void setGisu_num(int gisu_num) {
		this.gisu_num = gisu_num;
	}

	public String getGisu_crc_class() {
		return gisu_crc_class;
	}

	public void setGisu_crc_class(String gisu_crc_class) {
		this.gisu_crc_class = gisu_crc_class;
	}

	public String getGisu_crc_nm() {
		return gisu_crc_nm;
	}

	public void setGisu_crc_nm(String gisu_crc_nm) {
		this.gisu_crc_nm = gisu_crc_nm;
	}

	public int getGisu_crc_month() {
		return gisu_crc_month;
	}

	public void setGisu_crc_month(int gisu_crc_month) {
		this.gisu_crc_month = gisu_crc_month;
	}

	public int getGisu_crc_days() {
		return gisu_crc_days;
	}

	public void setGisu_crc_days(int gisu_crc_days) {
		this.gisu_crc_days = gisu_crc_days;
	}

	public int getGisu_crc_times() {
		return gisu_crc_times;
	}

	public void setGisu_crc_times(int gisu_crc_times) {
		this.gisu_crc_times = gisu_crc_times;
	}

	public int getGisu_crc_pay() {
		return gisu_crc_pay;
	}

	public void setGisu_crc_pay(int gisu_crc_pay) {
		this.gisu_crc_pay = gisu_crc_pay;
	}

	public int getGisu_crc_personnel() {
		return gisu_crc_personnel;
	}

	public void setGisu_crc_personnel(int gisu_crc_personnel) {
		this.gisu_crc_personnel = gisu_crc_personnel;
	}

	public String getGisu_crc_location() {
		return gisu_crc_location;
	}

	public void setGisu_crc_location(String gisu_crc_location) {
		this.gisu_crc_location = gisu_crc_location;
	}

	public String getGisu_app_st() {
		return gisu_app_st;
	}

	public void setGisu_app_st(String gisu_app_st) {
		this.gisu_app_st = gisu_app_st;
	}

	public String getGisu_app_et() {
		return gisu_app_et;
	}

	public void setGisu_app_et(String gisu_app_et) {
		this.gisu_app_et = gisu_app_et;
	}

	public String getGisu_crc_st() {
		return gisu_crc_st;
	}

	public void setGisu_crc_st(String gisu_crc_st) {
		this.gisu_crc_st = gisu_crc_st;
	}

	public String getGisu_crc_et() {
		return gisu_crc_et;
	}

	public void setGisu_crc_et(String gisu_crc_et) {
		this.gisu_crc_et = gisu_crc_et;
	}

	public String getGisu_per() {
		return gisu_per;
	}

	public void setGisu_per(String gisu_per) {
		this.gisu_per = gisu_per;
	}

	public String getGisu_crc_intro() {
		return gisu_crc_intro;
	}

	public void setGisu_crc_intro(String gisu_crc_intro) {
		this.gisu_crc_intro = gisu_crc_intro;
	}

	public String getGisu_ins_id() {
		return gisu_ins_id;
	}

	public void setGisu_ins_id(String gisu_ins_id) {
		this.gisu_ins_id = gisu_ins_id;
	}

	public String getGisu_ins_dt() {
		return gisu_ins_dt;
	}

	public void setGisu_ins_dt(String gisu_ins_dt) {
		this.gisu_ins_dt = gisu_ins_dt;
	}

	public String getGisu_udt_id() {
		return gisu_udt_id;
	}

	public void setGisu_udt_id(String gisu_udt_id) {
		this.gisu_udt_id = gisu_udt_id;
	}

	public String getGisu_udt_dt() {
		return gisu_udt_dt;
	}

	public void setGisu_udt_dt(String gisu_udt_dt) {
		this.gisu_udt_dt = gisu_udt_dt;
	}

	public boolean isGisu_crc_img_updated() {
		return gisu_crc_img_updated;
	}

	public void setGisu_crc_img_updated(boolean gisu_crc_img_updated) {
		this.gisu_crc_img_updated = gisu_crc_img_updated;
	}

	public String getGisu_crc_division() {
		return gisu_crc_division;
	}

	public void setGisu_crc_division(String gisu_crc_division) {
		this.gisu_crc_division = gisu_crc_division;
	}

	@Override
	public String toString() {
		return "SocietyEduAdminCurriculumGisu [gisu_seq=" + gisu_seq + ", crc_seq=" + crc_seq + ", gisu_num=" + gisu_num
				+ ", gisu_crc_class=" + gisu_crc_class + ", gisu_crc_nm=" + gisu_crc_nm + ", gisu_crc_month="
				+ gisu_crc_month + ", gisu_crc_days=" + gisu_crc_days + ", gisu_crc_times=" + gisu_crc_times
				+ ", gisu_crc_pay=" + gisu_crc_pay + ", gisu_crc_personnel=" + gisu_crc_personnel
				+ ", gisu_crc_location=" + gisu_crc_location + ", gisu_app_st=" + gisu_app_st + ", gisu_app_et="
				+ gisu_app_et + ", gisu_crc_st=" + gisu_crc_st + ", gisu_crc_et=" + gisu_crc_et + ", gisu_per="
				+ gisu_per + ", gisu_crc_intro=" + gisu_crc_intro + ", gisu_ins_id=" + gisu_ins_id + ", gisu_ins_dt="
				+ gisu_ins_dt + ", gisu_udt_id=" + gisu_udt_id + ", gisu_udt_dt=" + gisu_udt_dt
				+ ", gisu_crc_img_updated=" + gisu_crc_img_updated + ", gisu_crc_division=" + gisu_crc_division + "]";
	}

}
