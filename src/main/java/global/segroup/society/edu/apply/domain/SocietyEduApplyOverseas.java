/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 해외체류 정보
 * 
 */
public class SocietyEduApplyOverseas {
	
	/**
	 * 해외체류 시퀀스
	 */
	private int app_overseas_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 국가명
	 */
	private String app_overseas_nm;
	
	/**
	 * 체류기간 시작일(yyyyMMdd)
	 */
	private String app_overseas_st;
	
	/**
	 * 체류기간 종료일(yyyyMMdd)
	 */
	private String app_overseas_et;
	
	/**
	 * 목적
	 */
	private String app_overseas_purpose;
	
	/**
	 * 등록인
	 */
	private String app_overseas_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String app_overseas_ins_dt;
	
	/**
	 * 수정인
	 */
	private String app_overseas_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String app_overseas_udt_dt;
	
	private List<SocietyEduApplyOverseas> overseasList;

	public SocietyEduApplyOverseas() {
		super();
	}

	public SocietyEduApplyOverseas(int app_overseas_seq, int app_seq, String app_overseas_nm, String app_overseas_st,
			String app_overseas_et, String app_overseas_purpose, String app_overseas_ins_id, String app_overseas_ins_dt,
			String app_overseas_udt_id, String app_overseas_udt_dt, List<SocietyEduApplyOverseas> overseasList) {
		super();
		this.app_overseas_seq = app_overseas_seq;
		this.app_seq = app_seq;
		this.app_overseas_nm = app_overseas_nm;
		this.app_overseas_st = app_overseas_st;
		this.app_overseas_et = app_overseas_et;
		this.app_overseas_purpose = app_overseas_purpose;
		this.app_overseas_ins_id = app_overseas_ins_id;
		this.app_overseas_ins_dt = app_overseas_ins_dt;
		this.app_overseas_udt_id = app_overseas_udt_id;
		this.app_overseas_udt_dt = app_overseas_udt_dt;
		this.overseasList = overseasList;
	}

	public int getApp_overseas_seq() {
		return app_overseas_seq;
	}

	public void setApp_overseas_seq(int app_overseas_seq) {
		this.app_overseas_seq = app_overseas_seq;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_overseas_nm() {
		return app_overseas_nm;
	}

	public void setApp_overseas_nm(String app_overseas_nm) {
		this.app_overseas_nm = app_overseas_nm;
	}

	public String getApp_overseas_st() {
		return app_overseas_st;
	}

	public void setApp_overseas_st(String app_overseas_st) {
		this.app_overseas_st = app_overseas_st;
	}

	public String getApp_overseas_et() {
		return app_overseas_et;
	}

	public void setApp_overseas_et(String app_overseas_et) {
		this.app_overseas_et = app_overseas_et;
	}

	public String getApp_overseas_purpose() {
		return app_overseas_purpose;
	}

	public void setApp_overseas_purpose(String app_overseas_purpose) {
		this.app_overseas_purpose = app_overseas_purpose;
	}

	public String getApp_overseas_ins_id() {
		return app_overseas_ins_id;
	}

	public void setApp_overseas_ins_id(String app_overseas_ins_id) {
		this.app_overseas_ins_id = app_overseas_ins_id;
	}

	public String getApp_overseas_ins_dt() {
		return app_overseas_ins_dt;
	}

	public void setApp_overseas_ins_dt(String app_overseas_ins_dt) {
		this.app_overseas_ins_dt = app_overseas_ins_dt;
	}

	public String getApp_overseas_udt_id() {
		return app_overseas_udt_id;
	}

	public void setApp_overseas_udt_id(String app_overseas_udt_id) {
		this.app_overseas_udt_id = app_overseas_udt_id;
	}

	public String getApp_overseas_udt_dt() {
		return app_overseas_udt_dt;
	}

	public void setApp_overseas_udt_dt(String app_overseas_udt_dt) {
		this.app_overseas_udt_dt = app_overseas_udt_dt;
	}

	public List<SocietyEduApplyOverseas> getOverseasList() {
		return overseasList;
	}

	public void setOverseasList(List<SocietyEduApplyOverseas> overseasList) {
		this.overseasList = overseasList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyOverseas [app_overseas_seq=" + app_overseas_seq + ", app_seq=" + app_seq
				+ ", app_overseas_nm=" + app_overseas_nm + ", app_overseas_st=" + app_overseas_st + ", app_overseas_et="
				+ app_overseas_et + ", app_overseas_purpose=" + app_overseas_purpose + ", app_overseas_ins_id="
				+ app_overseas_ins_id + ", app_overseas_ins_dt=" + app_overseas_ins_dt + ", app_overseas_udt_id="
				+ app_overseas_udt_id + ", app_overseas_udt_dt=" + app_overseas_udt_dt + ", overseasList="
				+ overseasList + "]";
	}

}
