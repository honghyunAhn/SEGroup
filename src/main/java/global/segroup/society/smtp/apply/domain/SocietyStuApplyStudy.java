/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Society 지원신청서 교육이수 정보
 * 
 */
public class SocietyStuApplyStudy {
	
	/**
	 * 교육이수 시퀀스
	 */
	private int stu_app_study_seq;
	
	/**
	 * 지원신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 교육 과정명
	 */
	private String stu_app_study_nm;
	
	/**
	 * 교육기간 시작일(yyyyMMdd)
	 */
	private String stu_app_study_st;
	
	/**
	 * 교육기간 종료일(yyyyMMdd)
	 */
	private String stu_app_study_et;
	
	/**
	 * 기관명
	 */
	private String stu_app_study_ag;
	
	/**
	 * 교육내용
	 */
	private String stu_app_study_detail;
	
	/**
	 * 등록인
	 */
	private String stu_app_study_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_study_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_study_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_study_udt_dt;
	
	private List<SocietyStuApplyStudy> studyList;

	public SocietyStuApplyStudy() {
		super();
	}

	public SocietyStuApplyStudy(int stu_app_study_seq, int stu_app_seq, String stu_app_study_nm,
			String stu_app_study_st, String stu_app_study_et, String stu_app_study_ag, String stu_app_study_detail,
			String stu_app_study_ins_id, String stu_app_study_ins_dt, String stu_app_study_udt_id,
			String stu_app_study_udt_dt, List<SocietyStuApplyStudy> studyList) {
		super();
		this.stu_app_study_seq = stu_app_study_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_study_nm = stu_app_study_nm;
		this.stu_app_study_st = stu_app_study_st;
		this.stu_app_study_et = stu_app_study_et;
		this.stu_app_study_ag = stu_app_study_ag;
		this.stu_app_study_detail = stu_app_study_detail;
		this.stu_app_study_ins_id = stu_app_study_ins_id;
		this.stu_app_study_ins_dt = stu_app_study_ins_dt;
		this.stu_app_study_udt_id = stu_app_study_udt_id;
		this.stu_app_study_udt_dt = stu_app_study_udt_dt;
		this.studyList = studyList;
	}

	public int getStu_app_study_seq() {
		return stu_app_study_seq;
	}

	public void setStu_app_study_seq(int stu_app_study_seq) {
		this.stu_app_study_seq = stu_app_study_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_study_nm() {
		return stu_app_study_nm;
	}

	public void setStu_app_study_nm(String stu_app_study_nm) {
		this.stu_app_study_nm = stu_app_study_nm;
	}

	public String getStu_app_study_st() {
		return stu_app_study_st;
	}

	public void setStu_app_study_st(String stu_app_study_st) {
		this.stu_app_study_st = stu_app_study_st;
	}

	public String getStu_app_study_et() {
		return stu_app_study_et;
	}

	public void setStu_app_study_et(String stu_app_study_et) {
		this.stu_app_study_et = stu_app_study_et;
	}

	public String getStu_app_study_ag() {
		return stu_app_study_ag;
	}

	public void setStu_app_study_ag(String stu_app_study_ag) {
		this.stu_app_study_ag = stu_app_study_ag;
	}

	public String getStu_app_study_detail() {
		return stu_app_study_detail;
	}

	public void setStu_app_study_detail(String stu_app_study_detail) {
		this.stu_app_study_detail = stu_app_study_detail;
	}

	public String getStu_app_study_ins_id() {
		return stu_app_study_ins_id;
	}

	public void setStu_app_study_ins_id(String stu_app_study_ins_id) {
		this.stu_app_study_ins_id = stu_app_study_ins_id;
	}

	public String getStu_app_study_ins_dt() {
		return stu_app_study_ins_dt;
	}

	public void setStu_app_study_ins_dt(String stu_app_study_ins_dt) {
		this.stu_app_study_ins_dt = stu_app_study_ins_dt;
	}

	public String getStu_app_study_udt_id() {
		return stu_app_study_udt_id;
	}

	public void setStu_app_study_udt_id(String stu_app_study_udt_id) {
		this.stu_app_study_udt_id = stu_app_study_udt_id;
	}

	public String getStu_app_study_udt_dt() {
		return stu_app_study_udt_dt;
	}

	public void setStu_app_study_udt_dt(String stu_app_study_udt_dt) {
		this.stu_app_study_udt_dt = stu_app_study_udt_dt;
	}

	public List<SocietyStuApplyStudy> getStudyList() {
		return studyList;
	}

	public void setStudyList(List<SocietyStuApplyStudy> studyList) {
		this.studyList = studyList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplyStudy [stu_app_study_seq=" + stu_app_study_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_study_nm=" + stu_app_study_nm + ", stu_app_study_st=" + stu_app_study_st
				+ ", stu_app_study_et=" + stu_app_study_et + ", stu_app_study_ag=" + stu_app_study_ag
				+ ", stu_app_study_detail=" + stu_app_study_detail + ", stu_app_study_ins_id=" + stu_app_study_ins_id
				+ ", stu_app_study_ins_dt=" + stu_app_study_ins_dt + ", stu_app_study_udt_id=" + stu_app_study_udt_id
				+ ", stu_app_study_udt_dt=" + stu_app_study_udt_dt + ", studyList=" + studyList + "]";
	}

}
