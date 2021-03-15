/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Society 지원신청서 자격증 정보
 * 
 */
public class SocietyStuApplyLicense {
	
	/**
	 * 자격증 시퀀스
	 */
	private int stu_app_license_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 자격증 명
	 */
	private String stu_app_license_nm;
	
	/**
	 * 발급기관
	 */
	private String stu_app_license_ag;
	
	/**
	 * 취득 일자(yyyyMMdd)
	 */
	private String stu_app_license_obtain_dt;
	
	/**
	 * 비고
	 */
	private String stu_app_license_note;
	
	/**
	 * 등록인
	 */
	private String stu_app_license_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_license_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_license_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_license_udt_dt;
	
	private List<SocietyStuApplyLicense> licenseList;

	public SocietyStuApplyLicense() {
		super();
	}

	public SocietyStuApplyLicense(int stu_app_license_seq, int stu_app_seq, String stu_app_license_nm,
			String stu_app_license_ag, String stu_app_license_obtain_dt, String stu_app_license_note,
			String stu_app_license_ins_id, String stu_app_license_ins_dt, String stu_app_license_udt_id,
			String stu_app_license_udt_dt, List<SocietyStuApplyLicense> licenseList) {
		super();
		this.stu_app_license_seq = stu_app_license_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_license_nm = stu_app_license_nm;
		this.stu_app_license_ag = stu_app_license_ag;
		this.stu_app_license_obtain_dt = stu_app_license_obtain_dt;
		this.stu_app_license_note = stu_app_license_note;
		this.stu_app_license_ins_id = stu_app_license_ins_id;
		this.stu_app_license_ins_dt = stu_app_license_ins_dt;
		this.stu_app_license_udt_id = stu_app_license_udt_id;
		this.stu_app_license_udt_dt = stu_app_license_udt_dt;
		this.licenseList = licenseList;
	}

	public int getStu_app_license_seq() {
		return stu_app_license_seq;
	}

	public void setStu_app_license_seq(int stu_app_license_seq) {
		this.stu_app_license_seq = stu_app_license_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_license_nm() {
		return stu_app_license_nm;
	}

	public void setStu_app_license_nm(String stu_app_license_nm) {
		this.stu_app_license_nm = stu_app_license_nm;
	}

	public String getStu_app_license_ag() {
		return stu_app_license_ag;
	}

	public void setStu_app_license_ag(String stu_app_license_ag) {
		this.stu_app_license_ag = stu_app_license_ag;
	}

	public String getStu_app_license_obtain_dt() {
		return stu_app_license_obtain_dt;
	}

	public void setStu_app_license_obtain_dt(String stu_app_license_obtain_dt) {
		this.stu_app_license_obtain_dt = stu_app_license_obtain_dt;
	}

	public String getStu_app_license_note() {
		return stu_app_license_note;
	}

	public void setStu_app_license_note(String stu_app_license_note) {
		this.stu_app_license_note = stu_app_license_note;
	}

	public String getStu_app_license_ins_id() {
		return stu_app_license_ins_id;
	}

	public void setStu_app_license_ins_id(String stu_app_license_ins_id) {
		this.stu_app_license_ins_id = stu_app_license_ins_id;
	}

	public String getStu_app_license_ins_dt() {
		return stu_app_license_ins_dt;
	}

	public void setStu_app_license_ins_dt(String stu_app_license_ins_dt) {
		this.stu_app_license_ins_dt = stu_app_license_ins_dt;
	}

	public String getStu_app_license_udt_id() {
		return stu_app_license_udt_id;
	}

	public void setStu_app_license_udt_id(String stu_app_license_udt_id) {
		this.stu_app_license_udt_id = stu_app_license_udt_id;
	}

	public String getStu_app_license_udt_dt() {
		return stu_app_license_udt_dt;
	}

	public void setStu_app_license_udt_dt(String stu_app_license_udt_dt) {
		this.stu_app_license_udt_dt = stu_app_license_udt_dt;
	}

	public List<SocietyStuApplyLicense> getLicenseList() {
		return licenseList;
	}

	public void setLicenseList(List<SocietyStuApplyLicense> licenseList) {
		this.licenseList = licenseList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplyLicense [stu_app_license_seq=" + stu_app_license_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_license_nm=" + stu_app_license_nm + ", stu_app_license_ag=" + stu_app_license_ag
				+ ", stu_app_license_obtain_dt=" + stu_app_license_obtain_dt + ", stu_app_license_note="
				+ stu_app_license_note + ", stu_app_license_ins_id=" + stu_app_license_ins_id
				+ ", stu_app_license_ins_dt=" + stu_app_license_ins_dt + ", stu_app_license_udt_id="
				+ stu_app_license_udt_id + ", stu_app_license_udt_dt=" + stu_app_license_udt_dt + ", licenseList="
				+ licenseList + "]";
	}

}
