package global.segroup.society.smp.admin.domain;

import java.util.List;

import global.segroup.society.edu.apply.domain.SocietyEduApplyStudy;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 학력 정보
 * 
 */

public class SocietySmpStudentStudy {

	/**
	 * 교육이수 시퀀스
	 */
	private int smp_study_seq;
	
	/**
	 * 지원신청서 시퀀스
	 */
	private int smp_seq;
	
	/**
	 * 교육 과정명
	 */
	private String smp_study_nm;
	
	/**
	 * 교육기간 시작일(yyyyMMdd)
	 */
	private String smp_study_st;
	
	/**
	 * 교육기간 종료일(yyyyMMdd)
	 */
	private String smp_study_et;
	
	/**
	 * 기관명
	 */
	private String smp_study_ag;
	
	/**
	 * 교육내용
	 */
	private String smp_study_detail;
	
	/**
	 * 등록인
	 */
	private String smp_study_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_study_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_study_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_study_udt_dt;
	
	private List<SocietySmpStudentStudy> studyList;

	public SocietySmpStudentStudy() {
		super();
	}

	public SocietySmpStudentStudy(int smp_study_seq, int smp_seq, String smp_study_nm, String smp_study_st,
			String smp_study_et, String smp_study_ag, String smp_study_detail, String smp_study_ins_id,
			String smp_study_ins_dt, String smp_study_udt_id, String smp_study_udt_dt,
			List<SocietySmpStudentStudy> studyList) {
		super();
		this.smp_study_seq = smp_study_seq;
		this.smp_seq = smp_seq;
		this.smp_study_nm = smp_study_nm;
		this.smp_study_st = smp_study_st;
		this.smp_study_et = smp_study_et;
		this.smp_study_ag = smp_study_ag;
		this.smp_study_detail = smp_study_detail;
		this.smp_study_ins_id = smp_study_ins_id;
		this.smp_study_ins_dt = smp_study_ins_dt;
		this.smp_study_udt_id = smp_study_udt_id;
		this.smp_study_udt_dt = smp_study_udt_dt;
		this.studyList = studyList;
	}

	public int getSmp_study_seq() {
		return smp_study_seq;
	}

	public void setSmp_study_seq(int smp_study_seq) {
		this.smp_study_seq = smp_study_seq;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public String getSmp_study_nm() {
		return smp_study_nm;
	}

	public void setSmp_study_nm(String smp_study_nm) {
		this.smp_study_nm = smp_study_nm;
	}

	public String getSmp_study_st() {
		return smp_study_st;
	}

	public void setSmp_study_st(String smp_study_st) {
		this.smp_study_st = smp_study_st;
	}

	public String getSmp_study_et() {
		return smp_study_et;
	}

	public void setSmp_study_et(String smp_study_et) {
		this.smp_study_et = smp_study_et;
	}

	public String getSmp_study_ag() {
		return smp_study_ag;
	}

	public void setSmp_study_ag(String smp_study_ag) {
		this.smp_study_ag = smp_study_ag;
	}

	public String getSmp_study_detail() {
		return smp_study_detail;
	}

	public void setSmp_study_detail(String smp_study_detail) {
		this.smp_study_detail = smp_study_detail;
	}

	public String getSmp_study_ins_id() {
		return smp_study_ins_id;
	}

	public void setSmp_study_ins_id(String smp_study_ins_id) {
		this.smp_study_ins_id = smp_study_ins_id;
	}

	public String getSmp_study_ins_dt() {
		return smp_study_ins_dt;
	}

	public void setSmp_study_ins_dt(String smp_study_ins_dt) {
		this.smp_study_ins_dt = smp_study_ins_dt;
	}

	public String getSmp_study_udt_id() {
		return smp_study_udt_id;
	}

	public void setSmp_study_udt_id(String smp_study_udt_id) {
		this.smp_study_udt_id = smp_study_udt_id;
	}

	public String getSmp_study_udt_dt() {
		return smp_study_udt_dt;
	}

	public void setSmp_study_udt_dt(String smp_study_udt_dt) {
		this.smp_study_udt_dt = smp_study_udt_dt;
	}

	public List<SocietySmpStudentStudy> getStudyList() {
		return studyList;
	}

	public void setStudyList(List<SocietySmpStudentStudy> studyList) {
		this.studyList = studyList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyStudy [smp_study_seq=" + smp_study_seq + ", smp_seq=" + smp_seq + ", smp_study_nm="
				+ smp_study_nm + ", smp_study_st=" + smp_study_st + ", smp_study_et=" + smp_study_et + ", smp_study_ag="
				+ smp_study_ag + ", smp_study_detail=" + smp_study_detail + ", smp_study_ins_id=" + smp_study_ins_id
				+ ", smp_study_ins_dt=" + smp_study_ins_dt + ", smp_study_udt_id=" + smp_study_udt_id
				+ ", smp_study_udt_dt=" + smp_study_udt_dt + ", studyList=" + studyList + "]";
	}

}

