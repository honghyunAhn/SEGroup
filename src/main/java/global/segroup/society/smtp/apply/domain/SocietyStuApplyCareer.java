/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 4.
 * @Class 설명 : Society 지원신청서 경력 정보
 * 
 */
public class SocietyStuApplyCareer {

	/**
	 * 경력정보 시퀀스
	 */
	private int stu_app_crr_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 근무처
	 */
	private String stu_app_crr_place;
	
	/**
	 * 근무부서
	 */
	private String stu_app_crr_dept;
	
	/**
	 * 직위
	 */
	private String stu_app_crr_position;
	
	/**
	 * 회사 전화번호
	 */
	private String stu_app_crr_phone;	
	
	/**
	 * 근무기간 시작일(yyyyMMdd)
	 */
	private String stu_app_crr_st;
	
	/**
	 * 근무기간 종료일(yyyyMMdd)
	 */
	private String stu_app_crr_et;
	
	/**
	 * 담당업무
	 */
	private String stu_app_crr_description;
	
	/**
	 * 등록인
	 */
	private String stu_app_crr_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_crr_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_crr_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_crr_udt_dt;
	
	/**
	 * 지원신청서 경력정보 리스트
	 */
	private List<SocietyStuApplyCareer> careerList;

	public SocietyStuApplyCareer() {
		super();
	}
	
	public SocietyStuApplyCareer(int stu_app_crr_seq, int stu_app_seq, String stu_app_crr_place,
			String stu_app_crr_dept, String stu_app_crr_position, String stu_app_crr_phone, String stu_app_crr_st,
			String stu_app_crr_et, String stu_app_crr_description, String stu_app_crr_ins_id, String stu_app_crr_ins_dt,
			String stu_app_crr_udt_id, String stu_app_crr_udt_dt, List<SocietyStuApplyCareer> careerList) {
		super();
		this.stu_app_crr_seq = stu_app_crr_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_crr_place = stu_app_crr_place;
		this.stu_app_crr_dept = stu_app_crr_dept;
		this.stu_app_crr_position = stu_app_crr_position;
		this.stu_app_crr_phone = stu_app_crr_phone;
		this.stu_app_crr_st = stu_app_crr_st;
		this.stu_app_crr_et = stu_app_crr_et;
		this.stu_app_crr_description = stu_app_crr_description;
		this.stu_app_crr_ins_id = stu_app_crr_ins_id;
		this.stu_app_crr_ins_dt = stu_app_crr_ins_dt;
		this.stu_app_crr_udt_id = stu_app_crr_udt_id;
		this.stu_app_crr_udt_dt = stu_app_crr_udt_dt;
		this.careerList = careerList;
	}

	public int getStu_app_crr_seq() {
		return stu_app_crr_seq;
	}

	public void setStu_app_crr_seq(int stu_app_crr_seq) {
		this.stu_app_crr_seq = stu_app_crr_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_crr_place() {
		return stu_app_crr_place;
	}

	public void setStu_app_crr_place(String stu_app_crr_place) {
		this.stu_app_crr_place = stu_app_crr_place;
	}

	public String getStu_app_crr_dept() {
		return stu_app_crr_dept;
	}

	public void setStu_app_crr_dept(String stu_app_crr_dept) {
		this.stu_app_crr_dept = stu_app_crr_dept;
	}

	public String getStu_app_crr_position() {
		return stu_app_crr_position;
	}

	public void setStu_app_crr_position(String stu_app_crr_position) {
		this.stu_app_crr_position = stu_app_crr_position;
	}

	public String getStu_app_crr_phone() {
		return stu_app_crr_phone;
	}

	public void setStu_app_crr_phone(String stu_app_crr_phone) {
		this.stu_app_crr_phone = stu_app_crr_phone;
	}

	public String getStu_app_crr_st() {
		return stu_app_crr_st;
	}

	public void setStu_app_crr_st(String stu_app_crr_st) {
		this.stu_app_crr_st = stu_app_crr_st;
	}

	public String getStu_app_crr_et() {
		return stu_app_crr_et;
	}

	public void setStu_app_crr_et(String stu_app_crr_et) {
		this.stu_app_crr_et = stu_app_crr_et;
	}

	public String getStu_app_crr_description() {
		return stu_app_crr_description;
	}

	public void setStu_app_crr_description(String stu_app_crr_description) {
		this.stu_app_crr_description = stu_app_crr_description;
	}

	public String getStu_app_crr_ins_id() {
		return stu_app_crr_ins_id;
	}

	public void setStu_app_crr_ins_id(String stu_app_crr_ins_id) {
		this.stu_app_crr_ins_id = stu_app_crr_ins_id;
	}

	public String getStu_app_crr_ins_dt() {
		return stu_app_crr_ins_dt;
	}

	public void setStu_app_crr_ins_dt(String stu_app_crr_ins_dt) {
		this.stu_app_crr_ins_dt = stu_app_crr_ins_dt;
	}

	public String getStu_app_crr_udt_id() {
		return stu_app_crr_udt_id;
	}

	public void setStu_app_crr_udt_id(String stu_app_crr_udt_id) {
		this.stu_app_crr_udt_id = stu_app_crr_udt_id;
	}

	public String getStu_app_crr_udt_dt() {
		return stu_app_crr_udt_dt;
	}

	public void setStu_app_crr_udt_dt(String stu_app_crr_udt_dt) {
		this.stu_app_crr_udt_dt = stu_app_crr_udt_dt;
	}

	public List<SocietyStuApplyCareer> getCareerList() {
		return careerList;
	}

	public void setCareerList(List<SocietyStuApplyCareer> careerList) {
		this.careerList = careerList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplyCareer [stu_app_crr_seq=" + stu_app_crr_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_crr_place=" + stu_app_crr_place + ", stu_app_crr_dept=" + stu_app_crr_dept
				+ ", stu_app_crr_position=" + stu_app_crr_position + ", stu_app_crr_phone=" + stu_app_crr_phone
				+ ", stu_app_crr_st=" + stu_app_crr_st + ", stu_app_crr_et=" + stu_app_crr_et
				+ ", stu_app_crr_description=" + stu_app_crr_description + ", stu_app_crr_ins_id=" + stu_app_crr_ins_id
				+ ", stu_app_crr_ins_dt=" + stu_app_crr_ins_dt + ", stu_app_crr_udt_id=" + stu_app_crr_udt_id
				+ ", stu_app_crr_udt_dt=" + stu_app_crr_udt_dt + ", careerList=" + careerList + "]";
	}
	
}
