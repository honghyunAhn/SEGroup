package global.segroup.society.smp.admin.domain;

import java.util.List;

import global.segroup.society.edu.apply.domain.SocietyEduApplyLanguage;

/**
 * @Author : 여명환
 * @Date : 2018. 8. 23.
 * @Class 설명 : Society 학생 학력 정보
 * 
 */

public class SocietySmpStudentLanguage {


	private int smp_lang_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int smp_seq;
	
	/**
	 * 언어명
	 */
	private String smp_lang_nm;
	
	/**
	 * 시험명
	 */
	private String smp_lang_test_nm;
	
	/**
	 * 점수/등급
	 */
	private String smp_lang_grade;
	
	/**
	 * 발급기관
	 */
	private String smp_lang_ag;
	
	/**
	 * 취득 일자(yyyyMMdd)
	 */
	private String smp_lang_obtain_dt;
	
	/**
	 * 등록인
	 */
	private String smp_lang_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_lang_ins_dt;
	
	/**
	 * 수정인
	 */
	private String smp_lang_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String smp_lang_udt_dt;
	
	private List<SocietySmpStudentLanguage> languageList;

	public SocietySmpStudentLanguage() {
		super();
	}

	public SocietySmpStudentLanguage(int smp_lang_seq, int smp_seq, String smp_lang_nm, String smp_lang_test_nm,
			String smp_lang_grade, String smp_lang_ag, String smp_lang_obtain_dt, String smp_lang_ins_id,
			String smp_lang_ins_dt, String smp_lang_udt_id, String smp_lang_udt_dt,
			List<SocietySmpStudentLanguage> languageList) {
		super();
		this.smp_lang_seq = smp_lang_seq;
		this.smp_seq = smp_seq;
		this.smp_lang_nm = smp_lang_nm;
		this.smp_lang_test_nm = smp_lang_test_nm;
		this.smp_lang_grade = smp_lang_grade;
		this.smp_lang_ag = smp_lang_ag;
		this.smp_lang_obtain_dt = smp_lang_obtain_dt;
		this.smp_lang_ins_id = smp_lang_ins_id;
		this.smp_lang_ins_dt = smp_lang_ins_dt;
		this.smp_lang_udt_id = smp_lang_udt_id;
		this.smp_lang_udt_dt = smp_lang_udt_dt;
		this.languageList = languageList;
	}

	public int getSmp_lang_seq() {
		return smp_lang_seq;
	}

	public void setSmp_lang_seq(int smp_lang_seq) {
		this.smp_lang_seq = smp_lang_seq;
	}

	public int getSmp_seq() {
		return smp_seq;
	}

	public void setSmp_seq(int smp_seq) {
		this.smp_seq = smp_seq;
	}

	public String getSmp_lang_nm() {
		return smp_lang_nm;
	}

	public void setSmp_lang_nm(String smp_lang_nm) {
		this.smp_lang_nm = smp_lang_nm;
	}

	public String getSmp_lang_test_nm() {
		return smp_lang_test_nm;
	}

	public void setSmp_lang_test_nm(String smp_lang_test_nm) {
		this.smp_lang_test_nm = smp_lang_test_nm;
	}

	public String getSmp_lang_grade() {
		return smp_lang_grade;
	}

	public void setSmp_lang_grade(String smp_lang_grade) {
		this.smp_lang_grade = smp_lang_grade;
	}

	public String getSmp_lang_ag() {
		return smp_lang_ag;
	}

	public void setSmp_lang_ag(String smp_lang_ag) {
		this.smp_lang_ag = smp_lang_ag;
	}

	public String getSmp_lang_obtain_dt() {
		return smp_lang_obtain_dt;
	}

	public void setSmp_lang_obtain_dt(String smp_lang_obtain_dt) {
		this.smp_lang_obtain_dt = smp_lang_obtain_dt;
	}

	public String getSmp_lang_ins_id() {
		return smp_lang_ins_id;
	}

	public void setSmp_lang_ins_id(String smp_lang_ins_id) {
		this.smp_lang_ins_id = smp_lang_ins_id;
	}

	public String getSmp_lang_ins_dt() {
		return smp_lang_ins_dt;
	}

	public void setSmp_lang_ins_dt(String smp_lang_ins_dt) {
		this.smp_lang_ins_dt = smp_lang_ins_dt;
	}

	public String getSmp_lang_udt_id() {
		return smp_lang_udt_id;
	}

	public void setSmp_lang_udt_id(String smp_lang_udt_id) {
		this.smp_lang_udt_id = smp_lang_udt_id;
	}

	public String getSmp_lang_udt_dt() {
		return smp_lang_udt_dt;
	}

	public void setSmp_lang_udt_dt(String smp_lang_udt_dt) {
		this.smp_lang_udt_dt = smp_lang_udt_dt;
	}

	public List<SocietySmpStudentLanguage> getLanguageList() {
		return languageList;
	}

	public void setLanguageList(List<SocietySmpStudentLanguage> languageList) {
		this.languageList = languageList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyLanguage [smp_lang_seq=" + smp_lang_seq + ", smp_seq=" + smp_seq + ", smp_lang_nm="
				+ smp_lang_nm + ", smp_lang_test_nm=" + smp_lang_test_nm + ", smp_lang_grade=" + smp_lang_grade
				+ ", smp_lang_ag=" + smp_lang_ag + ", smp_lang_obtain_dt=" + smp_lang_obtain_dt + ", smp_lang_ins_id="
				+ smp_lang_ins_id + ", smp_lang_ins_dt=" + smp_lang_ins_dt + ", smp_lang_udt_id=" + smp_lang_udt_id
				+ ", smp_lang_udt_dt=" + smp_lang_udt_dt + ", languageList=" + languageList + "]";
	}

}

