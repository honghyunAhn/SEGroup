/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Society 지원신청서 해외체류 정보
 * 
 */
public class SocietyStuApplyOverseas {
	
	/**
	 * 해외체류 시퀀스
	 */
	private int stu_app_overseas_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 해외체류 경험 체크
	 */
	private String stu_app_overseas_ck;
	
	/**
	 * 국가명
	 */
	private String stu_app_overseas_nm;
	
	/**
	 * 체류기간 시작일(yyyyMMdd)
	 */
	private String stu_app_overseas_st;
	
	/**
	 * 체류기간 종료일(yyyyMMdd)
	 */
	private String stu_app_overseas_et;
	
	/**
	 * 목적
	 */
	private String stu_app_overseas_purpose;
	
	/**
	 * 등록인
	 */
	private String stu_app_overseas_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_overseas_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_overseas_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_overseas_udt_dt;
	
	private List<SocietyStuApplyOverseas> overseasList;

	public SocietyStuApplyOverseas() {
		super();
	}

	public SocietyStuApplyOverseas(int stu_app_overseas_seq, int stu_app_seq, String stu_app_overseas_ck,
			String stu_app_overseas_nm, String stu_app_overseas_st, String stu_app_overseas_et,
			String stu_app_overseas_purpose, String stu_app_overseas_ins_id, String stu_app_overseas_ins_dt,
			String stu_app_overseas_udt_id, String stu_app_overseas_udt_dt,
			List<SocietyStuApplyOverseas> overseasList) {
		super();
		this.stu_app_overseas_seq = stu_app_overseas_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_overseas_ck = stu_app_overseas_ck;
		this.stu_app_overseas_nm = stu_app_overseas_nm;
		this.stu_app_overseas_st = stu_app_overseas_st;
		this.stu_app_overseas_et = stu_app_overseas_et;
		this.stu_app_overseas_purpose = stu_app_overseas_purpose;
		this.stu_app_overseas_ins_id = stu_app_overseas_ins_id;
		this.stu_app_overseas_ins_dt = stu_app_overseas_ins_dt;
		this.stu_app_overseas_udt_id = stu_app_overseas_udt_id;
		this.stu_app_overseas_udt_dt = stu_app_overseas_udt_dt;
		this.overseasList = overseasList;
	}

	public int getStu_app_overseas_seq() {
		return stu_app_overseas_seq;
	}

	public void setStu_app_overseas_seq(int stu_app_overseas_seq) {
		this.stu_app_overseas_seq = stu_app_overseas_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_overseas_ck() {
		return stu_app_overseas_ck;
	}

	public void setStu_app_overseas_ck(String stu_app_overseas_ck) {
		this.stu_app_overseas_ck = stu_app_overseas_ck;
	}

	public String getStu_app_overseas_nm() {
		return stu_app_overseas_nm;
	}

	public void setStu_app_overseas_nm(String stu_app_overseas_nm) {
		this.stu_app_overseas_nm = stu_app_overseas_nm;
	}

	public String getStu_app_overseas_st() {
		return stu_app_overseas_st;
	}

	public void setStu_app_overseas_st(String stu_app_overseas_st) {
		this.stu_app_overseas_st = stu_app_overseas_st;
	}

	public String getStu_app_overseas_et() {
		return stu_app_overseas_et;
	}

	public void setStu_app_overseas_et(String stu_app_overseas_et) {
		this.stu_app_overseas_et = stu_app_overseas_et;
	}

	public String getStu_app_overseas_purpose() {
		return stu_app_overseas_purpose;
	}

	public void setStu_app_overseas_purpose(String stu_app_overseas_purpose) {
		this.stu_app_overseas_purpose = stu_app_overseas_purpose;
	}

	public String getStu_app_overseas_ins_id() {
		return stu_app_overseas_ins_id;
	}

	public void setStu_app_overseas_ins_id(String stu_app_overseas_ins_id) {
		this.stu_app_overseas_ins_id = stu_app_overseas_ins_id;
	}

	public String getStu_app_overseas_ins_dt() {
		return stu_app_overseas_ins_dt;
	}

	public void setStu_app_overseas_ins_dt(String stu_app_overseas_ins_dt) {
		this.stu_app_overseas_ins_dt = stu_app_overseas_ins_dt;
	}

	public String getStu_app_overseas_udt_id() {
		return stu_app_overseas_udt_id;
	}

	public void setStu_app_overseas_udt_id(String stu_app_overseas_udt_id) {
		this.stu_app_overseas_udt_id = stu_app_overseas_udt_id;
	}

	public String getStu_app_overseas_udt_dt() {
		return stu_app_overseas_udt_dt;
	}

	public void setStu_app_overseas_udt_dt(String stu_app_overseas_udt_dt) {
		this.stu_app_overseas_udt_dt = stu_app_overseas_udt_dt;
	}

	public List<SocietyStuApplyOverseas> getOverseasList() {
		return overseasList;
	}

	public void setOverseasList(List<SocietyStuApplyOverseas> overseasList) {
		this.overseasList = overseasList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplyOverseas [stu_app_overseas_seq=" + stu_app_overseas_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_overseas_ck=" + stu_app_overseas_ck + ", stu_app_overseas_nm=" + stu_app_overseas_nm
				+ ", stu_app_overseas_st=" + stu_app_overseas_st + ", stu_app_overseas_et=" + stu_app_overseas_et
				+ ", stu_app_overseas_purpose=" + stu_app_overseas_purpose + ", stu_app_overseas_ins_id="
				+ stu_app_overseas_ins_id + ", stu_app_overseas_ins_dt=" + stu_app_overseas_ins_dt
				+ ", stu_app_overseas_udt_id=" + stu_app_overseas_udt_id + ", stu_app_overseas_udt_dt="
				+ stu_app_overseas_udt_dt + ", overseasList=" + overseasList + "]";
	}

}
