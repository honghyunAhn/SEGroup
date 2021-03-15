package global.segroup.society.smp.admin.domain;

import java.util.List;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 학력 정보
 * 
 */

public class SocietySmpStudentCareer {


	/**
	 * 경력정보 시퀀스
	 */
	private int smp_crr_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int smp_seq;
	
	/**
	 * 근무처
	 */
	private String smp_crr_place;
	
	/**
	 * 직위
	 */
	private String smp_crr_position;
	
	/**
	 * 근무기간 시작일(yyyyMMdd)
	 */
	private String smp_crr_st;
	
	/**
	 * 근무기간 종료일(yyyyMMdd)
	 */
	private String smp_crr_et;
	
	/**
	 * 근무부서
	 */
	private String smp_crr_dept;
	
	/**
	 * 회사 전화번호
	 */
	private String smp_crr_phone;
	
	/**
	 * 등록인
	 */
	private String smp_crr_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_crr_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_crr_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_crr_udt_dt;
	
	/**
	 * 지원신청서 경력정보 리스트
	 */
	private List<SocietySmpStudentCareer> careerList;

	public SocietySmpStudentCareer() {
		super();
	}

	public SocietySmpStudentCareer(int smp_crr_seq, int smp_seq, String smp_crr_place, String smp_crr_position,
			String smp_crr_st, String smp_crr_et, String smp_crr_dept, String smp_crr_phone, String smp_crr_ins_id,
			String smp_crr_ins_dt, String smp_crr_udt_id, String smp_crr_udt_dt,
			List<SocietySmpStudentCareer> careerList) {
		super();
		this.smp_crr_seq = smp_crr_seq;
		this.smp_seq = smp_seq;
		this.smp_crr_place = smp_crr_place;
		this.smp_crr_position = smp_crr_position;
		this.smp_crr_st = smp_crr_st;
		this.smp_crr_et = smp_crr_et;
		this.smp_crr_dept = smp_crr_dept;
		this.smp_crr_phone = smp_crr_phone;
		this.smp_crr_ins_id = smp_crr_ins_id;
		this.smp_crr_ins_dt = smp_crr_ins_dt;
		this.smp_crr_udt_id = smp_crr_udt_id;
		this.smp_crr_udt_dt = smp_crr_udt_dt;
		this.careerList = careerList;
	}

	public int getSmp_crr_seq() {
		return smp_crr_seq;
	}

	public void setSmp_crr_seq(int smp_crr_seq) {
		this.smp_crr_seq = smp_crr_seq;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public String getSmp_crr_place() {
		return smp_crr_place;
	}

	public void setSmp_crr_place(String smp_crr_place) {
		this.smp_crr_place = smp_crr_place;
	}

	public String getSmp_crr_position() {
		return smp_crr_position;
	}

	public void setSmp_crr_position(String smp_crr_position) {
		this.smp_crr_position = smp_crr_position;
	}

	public String getSmp_crr_st() {
		return smp_crr_st;
	}

	public void setSmp_crr_st(String smp_crr_st) {
		this.smp_crr_st = smp_crr_st;
	}

	public String getSmp_crr_et() {
		return smp_crr_et;
	}

	public void setSmp_crr_et(String smp_crr_et) {
		this.smp_crr_et = smp_crr_et;
	}

	public String getSmp_crr_dept() {
		return smp_crr_dept;
	}

	public void setSmp_crr_dept(String smp_crr_dept) {
		this.smp_crr_dept = smp_crr_dept;
	}

	public String getSmp_crr_phone() {
		return smp_crr_phone;
	}

	public void setSmp_crr_phone(String smp_crr_phone) {
		this.smp_crr_phone = smp_crr_phone;
	}

	public String getSmp_crr_ins_id() {
		return smp_crr_ins_id;
	}

	public void setSmp_crr_ins_id(String smp_crr_ins_id) {
		this.smp_crr_ins_id = smp_crr_ins_id;
	}

	public String getSmp_crr_ins_dt() {
		return smp_crr_ins_dt;
	}

	public void setSmp_crr_ins_dt(String smp_crr_ins_dt) {
		this.smp_crr_ins_dt = smp_crr_ins_dt;
	}

	public String getSmp_crr_udt_id() {
		return smp_crr_udt_id;
	}

	public void setSmp_crr_udt_id(String smp_crr_udt_id) {
		this.smp_crr_udt_id = smp_crr_udt_id;
	}

	public String getSmp_crr_udt_dt() {
		return smp_crr_udt_dt;
	}

	public void setSmp_crr_udt_dt(String smp_crr_udt_dt) {
		this.smp_crr_udt_dt = smp_crr_udt_dt;
	}

	public List<SocietySmpStudentCareer> getCareerList() {
		return careerList;
	}

	public void setCareerList(List<SocietySmpStudentCareer> careerList) {
		this.careerList = careerList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyCareer [smp_crr_seq=" + smp_crr_seq + ", smp_seq=" + smp_seq + ", smp_crr_place="
				+ smp_crr_place + ", smp_crr_position=" + smp_crr_position + ", smp_crr_st=" + smp_crr_st
				+ ", smp_crr_et=" + smp_crr_et + ", smp_crr_dept=" + smp_crr_dept + ", smp_crr_phone=" + smp_crr_phone
				+ ", smp_crr_ins_id=" + smp_crr_ins_id + ", smp_crr_ins_dt=" + smp_crr_ins_dt + ", smp_crr_udt_id="
				+ smp_crr_udt_id + ", smp_crr_udt_dt=" + smp_crr_udt_dt + ", careerList=" + careerList + "]";
	}

}

