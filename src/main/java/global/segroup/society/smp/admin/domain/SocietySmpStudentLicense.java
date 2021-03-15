package global.segroup.society.smp.admin.domain;

import java.util.List;

import global.segroup.society.edu.apply.domain.SocietyEduApplyLicense;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 학력 정보
 * 
 */

public class SocietySmpStudentLicense {

	/**
	 * 자격증 시퀀스
	 */
	private int smp_license_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int smp_seq;
	
	/**
	 * 자격증 명
	 */
	private String smp_license_nm;
	
	/**
	 * 등급
	 */
	private String smp_license_grade;
	
	/**
	 * 발급기관
	 */
	private String smp_license_ag;
	
	/**
	 * 취득 일자(yyyyMMdd)
	 */
	private String smp_license_obtain_dt;
	
	/**
	 * 등록인
	 */
	private String smp_license_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_license_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_license_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_license_udt_dt;
	
	private List<SocietySmpStudentLicense> licenseList;

	public SocietySmpStudentLicense() {
		super();
	}

	public SocietySmpStudentLicense(int smp_license_seq, int smp_seq, String smp_license_nm, String smp_license_grade,
			String smp_license_ag, String smp_license_obtain_dt, String smp_license_ins_id, String smp_license_ins_dt,
			String smp_license_udt_id, String smp_license_udt_dt, List<SocietySmpStudentLicense> licenseList) {
		super();
		this.smp_license_seq = smp_license_seq;
		this.smp_seq = smp_seq;
		this.smp_license_nm = smp_license_nm;
		this.smp_license_grade = smp_license_grade;
		this.smp_license_ag = smp_license_ag;
		this.smp_license_obtain_dt = smp_license_obtain_dt;
		this.smp_license_ins_id = smp_license_ins_id;
		this.smp_license_ins_dt = smp_license_ins_dt;
		this.smp_license_udt_id = smp_license_udt_id;
		this.smp_license_udt_dt = smp_license_udt_dt;
		this.licenseList = licenseList;
	}

	public int getSmp_license_seq() {
		return smp_license_seq;
	}

	public void setSmp_license_seq(int smp_license_seq) {
		this.smp_license_seq = smp_license_seq;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public String getSmp_license_nm() {
		return smp_license_nm;
	}

	public void setSmp_license_nm(String smp_license_nm) {
		this.smp_license_nm = smp_license_nm;
	}

	public String getSmp_license_grade() {
		return smp_license_grade;
	}

	public void setSmp_license_grade(String smp_license_grade) {
		this.smp_license_grade = smp_license_grade;
	}

	public String getSmp_license_ag() {
		return smp_license_ag;
	}

	public void setSmp_license_ag(String smp_license_ag) {
		this.smp_license_ag = smp_license_ag;
	}

	public String getSmp_license_obtain_dt() {
		return smp_license_obtain_dt;
	}

	public void setSmp_license_obtain_dt(String smp_license_obtain_dt) {
		this.smp_license_obtain_dt = smp_license_obtain_dt;
	}

	public String getSmp_license_ins_id() {
		return smp_license_ins_id;
	}

	public void setSmp_license_ins_id(String smp_license_ins_id) {
		this.smp_license_ins_id = smp_license_ins_id;
	}

	public String getSmp_license_ins_dt() {
		return smp_license_ins_dt;
	}

	public void setSmp_license_ins_dt(String smp_license_ins_dt) {
		this.smp_license_ins_dt = smp_license_ins_dt;
	}

	public String getSmp_license_udt_id() {
		return smp_license_udt_id;
	}

	public void setSmp_license_udt_id(String smp_license_udt_id) {
		this.smp_license_udt_id = smp_license_udt_id;
	}

	public String getSmp_license_udt_dt() {
		return smp_license_udt_dt;
	}

	public void setSmp_license_udt_dt(String smp_license_udt_dt) {
		this.smp_license_udt_dt = smp_license_udt_dt;
	}

	public List<SocietySmpStudentLicense> getLicenseList() {
		return licenseList;
	}

	public void setLicenseList(List<SocietySmpStudentLicense> licenseList) {
		this.licenseList = licenseList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyLicense [smp_license_seq=" + smp_license_seq + ", smp_seq=" + smp_seq
				+ ", smp_license_nm=" + smp_license_nm + ", smp_license_grade=" + smp_license_grade
				+ ", smp_license_ag=" + smp_license_ag + ", smp_license_obtain_dt=" + smp_license_obtain_dt
				+ ", smp_license_ins_id=" + smp_license_ins_id + ", smp_license_ins_dt=" + smp_license_ins_dt
				+ ", smp_license_udt_id=" + smp_license_udt_id + ", smp_license_udt_dt=" + smp_license_udt_dt
				+ ", licenseList=" + licenseList + "]";
	}

}

