/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 자격증 정보
 * 
 */
public class SocietyEduApplyLicense {
	
	/**
	 * 자격증 시퀀스
	 */
	private int app_license_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 자격증 명
	 */
	private String app_license_nm;
	
	/**
	 * 등급
	 */
	private String app_license_grade;
	
	/**
	 * 발급기관
	 */
	private String app_license_ag;
	
	/**
	 * 취득 일자(yyyyMMdd)
	 */
	private String app_license_obtain_dt;
	
	/**
	 * 등록인
	 */
	private String app_license_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String app_license_ins_dt;
	
	/**
	 * 수정인
	 */
	private String app_license_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String app_license_udt_dt;
	
	private List<SocietyEduApplyLicense> licenseList;

	public SocietyEduApplyLicense() {
		super();
	}

	public SocietyEduApplyLicense(int app_license_seq, int app_seq, String app_license_nm, String app_license_grade,
			String app_license_ag, String app_license_obtain_dt, String app_license_ins_id, String app_license_ins_dt,
			String app_license_udt_id, String app_license_udt_dt, List<SocietyEduApplyLicense> licenseList) {
		super();
		this.app_license_seq = app_license_seq;
		this.app_seq = app_seq;
		this.app_license_nm = app_license_nm;
		this.app_license_grade = app_license_grade;
		this.app_license_ag = app_license_ag;
		this.app_license_obtain_dt = app_license_obtain_dt;
		this.app_license_ins_id = app_license_ins_id;
		this.app_license_ins_dt = app_license_ins_dt;
		this.app_license_udt_id = app_license_udt_id;
		this.app_license_udt_dt = app_license_udt_dt;
		this.licenseList = licenseList;
	}

	public int getApp_license_seq() {
		return app_license_seq;
	}

	public void setApp_license_seq(int app_license_seq) {
		this.app_license_seq = app_license_seq;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_license_nm() {
		return app_license_nm;
	}

	public void setApp_license_nm(String app_license_nm) {
		this.app_license_nm = app_license_nm;
	}

	public String getApp_license_grade() {
		return app_license_grade;
	}

	public void setApp_license_grade(String app_license_grade) {
		this.app_license_grade = app_license_grade;
	}

	public String getApp_license_ag() {
		return app_license_ag;
	}

	public void setApp_license_ag(String app_license_ag) {
		this.app_license_ag = app_license_ag;
	}

	public String getApp_license_obtain_dt() {
		return app_license_obtain_dt;
	}

	public void setApp_license_obtain_dt(String app_license_obtain_dt) {
		this.app_license_obtain_dt = app_license_obtain_dt;
	}

	public String getApp_license_ins_id() {
		return app_license_ins_id;
	}

	public void setApp_license_ins_id(String app_license_ins_id) {
		this.app_license_ins_id = app_license_ins_id;
	}

	public String getApp_license_ins_dt() {
		return app_license_ins_dt;
	}

	public void setApp_license_ins_dt(String app_license_ins_dt) {
		this.app_license_ins_dt = app_license_ins_dt;
	}

	public String getApp_license_udt_id() {
		return app_license_udt_id;
	}

	public void setApp_license_udt_id(String app_license_udt_id) {
		this.app_license_udt_id = app_license_udt_id;
	}

	public String getApp_license_udt_dt() {
		return app_license_udt_dt;
	}

	public void setApp_license_udt_dt(String app_license_udt_dt) {
		this.app_license_udt_dt = app_license_udt_dt;
	}

	public List<SocietyEduApplyLicense> getLicenseList() {
		return licenseList;
	}

	public void setLicenseList(List<SocietyEduApplyLicense> licenseList) {
		this.licenseList = licenseList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyLicense [app_license_seq=" + app_license_seq + ", app_seq=" + app_seq
				+ ", app_license_nm=" + app_license_nm + ", app_license_grade=" + app_license_grade
				+ ", app_license_ag=" + app_license_ag + ", app_license_obtain_dt=" + app_license_obtain_dt
				+ ", app_license_ins_id=" + app_license_ins_id + ", app_license_ins_dt=" + app_license_ins_dt
				+ ", app_license_udt_id=" + app_license_udt_id + ", app_license_udt_dt=" + app_license_udt_dt
				+ ", licenseList=" + licenseList + "]";
	}

}
