/**
 * 
 */
package global.segroup.society.edu.admin.domain;

/**
 * @Author : 이종호
 * @Date : 2017. 8. 4.
 * @Class 설명 : Society 모집홍보 과정 정보
 * 
 */
public class SocietyEduAdminCurriculum {
	
	/**
	 * 과정 정보 시퀀스
	 */
	private int crc_seq;
	
	/**
	 * 과정명 
	 */
	private String crc_class;
	
	/**
	 * 과정명 
	 */
	private String crc_nm;
	
	/**
	 * 과정 분류 (공통 코드)
	 */
	private String crc_tp;
	
	/**
	 * 교육 일수
	 */
	private int crc_month;
	
	/**
	 * 교육 일수
	 */
	private int crc_days;
	
	/**
	 * 교육 일수
	 */
	private int crc_times;
	
	/**
	 * 교육비
	 */
	private int crc_pay;
	
	/**
	 * 승인 구분 (공통 코드)
	 */
	private String crc_per;
	
	/**
	 * 과정소개 
	 */
	private String crc_intro;
	
	/**
	 * 등록인
	 */
	private String crc_ins_id;
	
	/**
	 * 등록 일자
	 */
	private String crc_ins_dt;
	
	/**
	 * 수정인
	 */
	private String crc_udt_id;
	
	/**
	 * 수정 일자
	 */
	private String crc_udt_dt;
	
	/**
	 * @Desc : 
	 */
	public SocietyEduAdminCurriculum() {
		super();
	}

	public SocietyEduAdminCurriculum(int crc_seq, String crc_class, String crc_nm, String crc_tp, int crc_month,
			int crc_days, int crc_times, int crc_pay, String crc_per, String crc_intro, String crc_ins_id,
			String crc_ins_dt, String crc_udt_id, String crc_udt_dt) {
		super();
		this.crc_seq = crc_seq;
		this.crc_class = crc_class;
		this.crc_nm = crc_nm;
		this.crc_tp = crc_tp;
		this.crc_month = crc_month;
		this.crc_days = crc_days;
		this.crc_times = crc_times;
		this.crc_pay = crc_pay;
		this.crc_per = crc_per;
		this.crc_intro = crc_intro;
		this.crc_ins_id = crc_ins_id;
		this.crc_ins_dt = crc_ins_dt;
		this.crc_udt_id = crc_udt_id;
		this.crc_udt_dt = crc_udt_dt;
	}

	public int getCrc_seq() {
		return crc_seq;
	}

	public void setCrc_seq(int crc_seq) {
		this.crc_seq = crc_seq;
	}

	public String getCrc_class() {
		return crc_class;
	}

	public void setCrc_class(String crc_class) {
		this.crc_class = crc_class;
	}

	public String getCrc_nm() {
		return crc_nm;
	}

	public void setCrc_nm(String crc_nm) {
		this.crc_nm = crc_nm;
	}

	public String getCrc_tp() {
		return crc_tp;
	}

	public void setCrc_tp(String crc_tp) {
		this.crc_tp = crc_tp;
	}

	public int getCrc_month() {
		return crc_month;
	}

	public void setCrc_month(int crc_month) {
		this.crc_month = crc_month;
	}

	public int getCrc_days() {
		return crc_days;
	}

	public void setCrc_days(int crc_days) {
		this.crc_days = crc_days;
	}

	public int getCrc_times() {
		return crc_times;
	}

	public void setCrc_times(int crc_times) {
		this.crc_times = crc_times;
	}

	public int getCrc_pay() {
		return crc_pay;
	}

	public void setCrc_pay(int crc_pay) {
		this.crc_pay = crc_pay;
	}

	public String getCrc_per() {
		return crc_per;
	}

	public void setCrc_per(String crc_per) {
		this.crc_per = crc_per;
	}

	public String getCrc_intro() {
		return crc_intro;
	}

	public void setCrc_intro(String crc_intro) {
		this.crc_intro = crc_intro;
	}

	public String getCrc_ins_id() {
		return crc_ins_id;
	}

	public void setCrc_ins_id(String crc_ins_id) {
		this.crc_ins_id = crc_ins_id;
	}

	public String getCrc_ins_dt() {
		return crc_ins_dt;
	}

	public void setCrc_ins_dt(String crc_ins_dt) {
		this.crc_ins_dt = crc_ins_dt;
	}

	public String getCrc_udt_id() {
		return crc_udt_id;
	}

	public void setCrc_udt_id(String crc_udt_id) {
		this.crc_udt_id = crc_udt_id;
	}

	public String getCrc_udt_dt() {
		return crc_udt_dt;
	}

	public void setCrc_udt_dt(String crc_udt_dt) {
		this.crc_udt_dt = crc_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyEduAdminCurriculum [crc_seq=" + crc_seq + ", crc_class=" + crc_class + ", crc_nm=" + crc_nm
				+ ", crc_tp=" + crc_tp + ", crc_month=" + crc_month + ", crc_days=" + crc_days + ", crc_times="
				+ crc_times + ", crc_pay=" + crc_pay + ", crc_per=" + crc_per + ", crc_intro=" + crc_intro
				+ ", crc_ins_id=" + crc_ins_id + ", crc_ins_dt=" + crc_ins_dt + ", crc_udt_id=" + crc_udt_id
				+ ", crc_udt_dt=" + crc_udt_dt + "]";
	}

}
