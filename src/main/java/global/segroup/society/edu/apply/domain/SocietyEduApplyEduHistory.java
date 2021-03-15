/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 학력 정보
 * 
 */
public class SocietyEduApplyEduHistory {
	
	/**
	 * 학력정보 시퀀스
	 */
	private int app_edu_seq;
	
	/**
	 * 지원 신청서 시퀀스 
	 */
	private int app_seq;
	
	/**
	 * 학교명
	 */
	private String app_edu_sc_nm;
	
	/**
	 * 전공
	 */
	private String app_edu_major;
		
	/**
	 * 졸업상태 체크(공통 코드)
	 */
	private String app_edu_gd_ck;
	
	/**
	 * 졸업 날짜(yyyyMMdd)
	 */
	private String app_edu_gd_dt;
	
	/**
	 * 소재지
	 */
	private String app_edu_sc_lo;
	
	/**
	 * 졸업요건
	 */
	private String app_edu_gd_rq;
	
	/**
	 * 등록인
	 */
	private String app_edu_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String app_edu_ins_dt;
	
	/**
	 * 수정인
	 */
	private String app_edu_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String app_edu_udt_dt;
	
	/**
	 * 지원신청서 학력정보 리스트
	 */
	private List<SocietyEduApplyEduHistory> eduHistoryList;

	public SocietyEduApplyEduHistory() {
		super();
	}

	public SocietyEduApplyEduHistory(int app_edu_seq, int app_seq, String app_edu_sc_nm, String app_edu_major,
			String app_edu_gd_ck, String app_edu_gd_dt, String app_edu_sc_lo, String app_edu_gd_rq,
			String app_edu_ins_id, String app_edu_ins_dt, String app_edu_udt_id, String app_edu_udt_dt,
			List<SocietyEduApplyEduHistory> eduHistoryList) {
		super();
		this.app_edu_seq = app_edu_seq;
		this.app_seq = app_seq;
		this.app_edu_sc_nm = app_edu_sc_nm;
		this.app_edu_major = app_edu_major;
		this.app_edu_gd_ck = app_edu_gd_ck;
		this.app_edu_gd_dt = app_edu_gd_dt;
		this.app_edu_sc_lo = app_edu_sc_lo;
		this.app_edu_gd_rq = app_edu_gd_rq;
		this.app_edu_ins_id = app_edu_ins_id;
		this.app_edu_ins_dt = app_edu_ins_dt;
		this.app_edu_udt_id = app_edu_udt_id;
		this.app_edu_udt_dt = app_edu_udt_dt;
		this.eduHistoryList = eduHistoryList;
	}

	public int getApp_edu_seq() {
		return app_edu_seq;
	}

	public void setApp_edu_seq(int app_edu_seq) {
		this.app_edu_seq = app_edu_seq;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_edu_sc_nm() {
		return app_edu_sc_nm;
	}

	public void setApp_edu_sc_nm(String app_edu_sc_nm) {
		this.app_edu_sc_nm = app_edu_sc_nm;
	}

	public String getApp_edu_major() {
		return app_edu_major;
	}

	public void setApp_edu_major(String app_edu_major) {
		this.app_edu_major = app_edu_major;
	}

	public String getApp_edu_gd_ck() {
		return app_edu_gd_ck;
	}

	public void setApp_edu_gd_ck(String app_edu_gd_ck) {
		this.app_edu_gd_ck = app_edu_gd_ck;
	}

	public String getApp_edu_gd_dt() {
		return app_edu_gd_dt;
	}

	public void setApp_edu_gd_dt(String app_edu_gd_dt) {
		this.app_edu_gd_dt = app_edu_gd_dt;
	}

	public String getApp_edu_sc_lo() {
		return app_edu_sc_lo;
	}

	public void setApp_edu_sc_lo(String app_edu_sc_lo) {
		this.app_edu_sc_lo = app_edu_sc_lo;
	}

	public String getApp_edu_gd_rq() {
		return app_edu_gd_rq;
	}

	public void setApp_edu_gd_rq(String app_edu_gd_rq) {
		this.app_edu_gd_rq = app_edu_gd_rq;
	}

	public String getApp_edu_ins_id() {
		return app_edu_ins_id;
	}

	public void setApp_edu_ins_id(String app_edu_ins_id) {
		this.app_edu_ins_id = app_edu_ins_id;
	}

	public String getApp_edu_ins_dt() {
		return app_edu_ins_dt;
	}

	public void setApp_edu_ins_dt(String app_edu_ins_dt) {
		this.app_edu_ins_dt = app_edu_ins_dt;
	}

	public String getApp_edu_udt_id() {
		return app_edu_udt_id;
	}

	public void setApp_edu_udt_id(String app_edu_udt_id) {
		this.app_edu_udt_id = app_edu_udt_id;
	}

	public String getApp_edu_udt_dt() {
		return app_edu_udt_dt;
	}

	public void setApp_edu_udt_dt(String app_edu_udt_dt) {
		this.app_edu_udt_dt = app_edu_udt_dt;
	}

	public List<SocietyEduApplyEduHistory> getEduHistoryList() {
		return eduHistoryList;
	}

	public void setEduHistoryList(List<SocietyEduApplyEduHistory> eduHistoryList) {
		this.eduHistoryList = eduHistoryList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyEduHistory [app_edu_seq=" + app_edu_seq + ", app_seq=" + app_seq + ", app_edu_sc_nm="
				+ app_edu_sc_nm + ", app_edu_major=" + app_edu_major + ", app_edu_gd_ck=" + app_edu_gd_ck
				+ ", app_edu_gd_dt=" + app_edu_gd_dt + ", app_edu_sc_lo=" + app_edu_sc_lo + ", app_edu_gd_rq="
				+ app_edu_gd_rq + ", app_edu_ins_id=" + app_edu_ins_id + ", app_edu_ins_dt=" + app_edu_ins_dt
				+ ", app_edu_udt_id=" + app_edu_udt_id + ", app_edu_udt_dt=" + app_edu_udt_dt + ", eduHistoryList="
				+ eduHistoryList + "]";
	}

}
