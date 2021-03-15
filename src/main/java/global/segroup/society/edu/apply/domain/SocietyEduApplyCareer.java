/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 경력 정보
 * 
 */
public class SocietyEduApplyCareer {

	/**
	 * 경력정보 시퀀스
	 */
	private int app_crr_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 근무처
	 */
	private String app_crr_place;
	
	/**
	 * 직위
	 */
	private String app_crr_position;
	
	/**
	 * 근무기간 시작일(yyyyMMdd)
	 */
	private String app_crr_st;
	
	/**
	 * 근무기간 종료일(yyyyMMdd)
	 */
	private String app_crr_et;
	
	/**
	 * 근무부서
	 */
	private String app_crr_dept;
	
	/**
	 * 회사 전화번호
	 */
	private String app_crr_phone;
	
	/**
	 * 등록인
	 */
	private String app_crr_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String app_crr_ins_dt;
	
	/**
	 * 수정인
	 */
	private String app_crr_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String app_crr_udt_dt;
	
	/**
	 * 지원신청서 경력정보 리스트
	 */
	private List<SocietyEduApplyCareer> careerList;

	public SocietyEduApplyCareer() {
		super();
	}

	public SocietyEduApplyCareer(int app_crr_seq, int app_seq, String app_crr_place, String app_crr_position,
			String app_crr_st, String app_crr_et, String app_crr_dept, String app_crr_phone, String app_crr_ins_id,
			String app_crr_ins_dt, String app_crr_udt_id, String app_crr_udt_dt,
			List<SocietyEduApplyCareer> careerList) {
		super();
		this.app_crr_seq = app_crr_seq;
		this.app_seq = app_seq;
		this.app_crr_place = app_crr_place;
		this.app_crr_position = app_crr_position;
		this.app_crr_st = app_crr_st;
		this.app_crr_et = app_crr_et;
		this.app_crr_dept = app_crr_dept;
		this.app_crr_phone = app_crr_phone;
		this.app_crr_ins_id = app_crr_ins_id;
		this.app_crr_ins_dt = app_crr_ins_dt;
		this.app_crr_udt_id = app_crr_udt_id;
		this.app_crr_udt_dt = app_crr_udt_dt;
		this.careerList = careerList;
	}

	public int getApp_crr_seq() {
		return app_crr_seq;
	}

	public void setApp_crr_seq(int app_crr_seq) {
		this.app_crr_seq = app_crr_seq;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_crr_place() {
		return app_crr_place;
	}

	public void setApp_crr_place(String app_crr_place) {
		this.app_crr_place = app_crr_place;
	}

	public String getApp_crr_position() {
		return app_crr_position;
	}

	public void setApp_crr_position(String app_crr_position) {
		this.app_crr_position = app_crr_position;
	}

	public String getApp_crr_st() {
		return app_crr_st;
	}

	public void setApp_crr_st(String app_crr_st) {
		this.app_crr_st = app_crr_st;
	}

	public String getApp_crr_et() {
		return app_crr_et;
	}

	public void setApp_crr_et(String app_crr_et) {
		this.app_crr_et = app_crr_et;
	}

	public String getApp_crr_dept() {
		return app_crr_dept;
	}

	public void setApp_crr_dept(String app_crr_dept) {
		this.app_crr_dept = app_crr_dept;
	}

	public String getApp_crr_phone() {
		return app_crr_phone;
	}

	public void setApp_crr_phone(String app_crr_phone) {
		this.app_crr_phone = app_crr_phone;
	}

	public String getApp_crr_ins_id() {
		return app_crr_ins_id;
	}

	public void setApp_crr_ins_id(String app_crr_ins_id) {
		this.app_crr_ins_id = app_crr_ins_id;
	}

	public String getApp_crr_ins_dt() {
		return app_crr_ins_dt;
	}

	public void setApp_crr_ins_dt(String app_crr_ins_dt) {
		this.app_crr_ins_dt = app_crr_ins_dt;
	}

	public String getApp_crr_udt_id() {
		return app_crr_udt_id;
	}

	public void setApp_crr_udt_id(String app_crr_udt_id) {
		this.app_crr_udt_id = app_crr_udt_id;
	}

	public String getApp_crr_udt_dt() {
		return app_crr_udt_dt;
	}

	public void setApp_crr_udt_dt(String app_crr_udt_dt) {
		this.app_crr_udt_dt = app_crr_udt_dt;
	}

	public List<SocietyEduApplyCareer> getCareerList() {
		return careerList;
	}

	public void setCareerList(List<SocietyEduApplyCareer> careerList) {
		this.careerList = careerList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyCareer [app_crr_seq=" + app_crr_seq + ", app_seq=" + app_seq + ", app_crr_place="
				+ app_crr_place + ", app_crr_position=" + app_crr_position + ", app_crr_st=" + app_crr_st
				+ ", app_crr_et=" + app_crr_et + ", app_crr_dept=" + app_crr_dept + ", app_crr_phone=" + app_crr_phone
				+ ", app_crr_ins_id=" + app_crr_ins_id + ", app_crr_ins_dt=" + app_crr_ins_dt + ", app_crr_udt_id="
				+ app_crr_udt_id + ", app_crr_udt_dt=" + app_crr_udt_dt + ", careerList=" + careerList + "]";
	}

}
