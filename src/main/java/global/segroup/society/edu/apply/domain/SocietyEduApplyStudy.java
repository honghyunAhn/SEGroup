/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 교육이수 정보
 * 
 */
public class SocietyEduApplyStudy {
	
	/**
	 * 교육이수 시퀀스
	 */
	private int app_study_seq;
	
	/**
	 * 지원신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 교육 과정명
	 */
	private String app_study_nm;
	
	/**
	 * 교육기간 시작일(yyyyMMdd)
	 */
	private String app_study_st;
	
	/**
	 * 교육기간 종료일(yyyyMMdd)
	 */
	private String app_study_et;
	
	/**
	 * 기관명
	 */
	private String app_study_ag;
	
	/**
	 * 교육내용
	 */
	private String app_study_detail;
	
	/**
	 * 등록인
	 */
	private String app_study_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String app_study_ins_dt;
	
	/**
	 * 수정인
	 */
	private String app_study_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String app_study_udt_dt;
	
	private List<SocietyEduApplyStudy> studyList;

	public SocietyEduApplyStudy() {
		super();
	}

	public SocietyEduApplyStudy(int app_study_seq, int app_seq, String app_study_nm, String app_study_st,
			String app_study_et, String app_study_ag, String app_study_detail, String app_study_ins_id,
			String app_study_ins_dt, String app_study_udt_id, String app_study_udt_dt,
			List<SocietyEduApplyStudy> studyList) {
		super();
		this.app_study_seq = app_study_seq;
		this.app_seq = app_seq;
		this.app_study_nm = app_study_nm;
		this.app_study_st = app_study_st;
		this.app_study_et = app_study_et;
		this.app_study_ag = app_study_ag;
		this.app_study_detail = app_study_detail;
		this.app_study_ins_id = app_study_ins_id;
		this.app_study_ins_dt = app_study_ins_dt;
		this.app_study_udt_id = app_study_udt_id;
		this.app_study_udt_dt = app_study_udt_dt;
		this.studyList = studyList;
	}

	public int getApp_study_seq() {
		return app_study_seq;
	}

	public void setApp_study_seq(int app_study_seq) {
		this.app_study_seq = app_study_seq;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_study_nm() {
		return app_study_nm;
	}

	public void setApp_study_nm(String app_study_nm) {
		this.app_study_nm = app_study_nm;
	}

	public String getApp_study_st() {
		return app_study_st;
	}

	public void setApp_study_st(String app_study_st) {
		this.app_study_st = app_study_st;
	}

	public String getApp_study_et() {
		return app_study_et;
	}

	public void setApp_study_et(String app_study_et) {
		this.app_study_et = app_study_et;
	}

	public String getApp_study_ag() {
		return app_study_ag;
	}

	public void setApp_study_ag(String app_study_ag) {
		this.app_study_ag = app_study_ag;
	}

	public String getApp_study_detail() {
		return app_study_detail;
	}

	public void setApp_study_detail(String app_study_detail) {
		this.app_study_detail = app_study_detail;
	}

	public String getApp_study_ins_id() {
		return app_study_ins_id;
	}

	public void setApp_study_ins_id(String app_study_ins_id) {
		this.app_study_ins_id = app_study_ins_id;
	}

	public String getApp_study_ins_dt() {
		return app_study_ins_dt;
	}

	public void setApp_study_ins_dt(String app_study_ins_dt) {
		this.app_study_ins_dt = app_study_ins_dt;
	}

	public String getApp_study_udt_id() {
		return app_study_udt_id;
	}

	public void setApp_study_udt_id(String app_study_udt_id) {
		this.app_study_udt_id = app_study_udt_id;
	}

	public String getApp_study_udt_dt() {
		return app_study_udt_dt;
	}

	public void setApp_study_udt_dt(String app_study_udt_dt) {
		this.app_study_udt_dt = app_study_udt_dt;
	}

	public List<SocietyEduApplyStudy> getStudyList() {
		return studyList;
	}

	public void setStudyList(List<SocietyEduApplyStudy> studyList) {
		this.studyList = studyList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyStudy [app_study_seq=" + app_study_seq + ", app_seq=" + app_seq + ", app_study_nm="
				+ app_study_nm + ", app_study_st=" + app_study_st + ", app_study_et=" + app_study_et + ", app_study_ag="
				+ app_study_ag + ", app_study_detail=" + app_study_detail + ", app_study_ins_id=" + app_study_ins_id
				+ ", app_study_ins_dt=" + app_study_ins_dt + ", app_study_udt_id=" + app_study_udt_id
				+ ", app_study_udt_dt=" + app_study_udt_dt + ", studyList=" + studyList + "]";
	}

}
