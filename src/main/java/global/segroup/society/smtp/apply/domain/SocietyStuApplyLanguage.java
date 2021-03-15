/**
 * 
 */
package global.segroup.society.smtp.apply.domain;

import java.util.List;

/**
 * @Author : 김성미
 * @Date : 2020. 8. 5.
 * @Class 설명 : Society 지원신청서 언어능력 정보
 * 
 */
public class SocietyStuApplyLanguage {

	/**
	 * 언어능력 정보 시퀀스
	 */
	private int stu_app_lang_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int stu_app_seq;
	
	/**
	 * 시험명
	 */
	private String stu_app_lang_test_nm;
	
	/**
	 * 점수/등급
	 */
	private String stu_app_lang_grade;
	
	/**
	 * 발급기관
	 */
	private String stu_app_lang_ag;
	
	/**
	 * 취득 일자(yyyyMMdd)
	 */
	private String stu_app_lang_obtain_dt;

	/**
	 * 비고
	 */
	private String stu_app_lang_note;
	
	/**
	 * 등록인
	 */
	private String stu_app_lang_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_lang_ins_dt;
	
	/**
	 * 수정인
	 */
	private String stu_app_lang_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String stu_app_lang_udt_dt;
	
	private List<SocietyStuApplyLanguage> languageList;

	public SocietyStuApplyLanguage() {
		super();
	}

	public SocietyStuApplyLanguage(int stu_app_lang_seq, int stu_app_seq, String stu_app_lang_test_nm,
			String stu_app_lang_grade, String stu_app_lang_ag, String stu_app_lang_obtain_dt, String stu_app_lang_note,
			String stu_app_lang_ins_id, String stu_app_lang_ins_dt, String stu_app_lang_udt_id,
			String stu_app_lang_udt_dt, List<SocietyStuApplyLanguage> languageList) {
		super();
		this.stu_app_lang_seq = stu_app_lang_seq;
		this.stu_app_seq = stu_app_seq;
		this.stu_app_lang_test_nm = stu_app_lang_test_nm;
		this.stu_app_lang_grade = stu_app_lang_grade;
		this.stu_app_lang_ag = stu_app_lang_ag;
		this.stu_app_lang_obtain_dt = stu_app_lang_obtain_dt;
		this.stu_app_lang_note = stu_app_lang_note;
		this.stu_app_lang_ins_id = stu_app_lang_ins_id;
		this.stu_app_lang_ins_dt = stu_app_lang_ins_dt;
		this.stu_app_lang_udt_id = stu_app_lang_udt_id;
		this.stu_app_lang_udt_dt = stu_app_lang_udt_dt;
		this.languageList = languageList;
	}

	public int getStu_app_lang_seq() {
		return stu_app_lang_seq;
	}

	public void setStu_app_lang_seq(int stu_app_lang_seq) {
		this.stu_app_lang_seq = stu_app_lang_seq;
	}

	public int getStu_app_seq() {
		return stu_app_seq;
	}

	public void setStu_app_seq(int stu_app_seq) {
		this.stu_app_seq = stu_app_seq;
	}

	public String getStu_app_lang_test_nm() {
		return stu_app_lang_test_nm;
	}

	public void setStu_app_lang_test_nm(String stu_app_lang_test_nm) {
		this.stu_app_lang_test_nm = stu_app_lang_test_nm;
	}

	public String getStu_app_lang_grade() {
		return stu_app_lang_grade;
	}

	public void setStu_app_lang_grade(String stu_app_lang_grade) {
		this.stu_app_lang_grade = stu_app_lang_grade;
	}

	public String getStu_app_lang_ag() {
		return stu_app_lang_ag;
	}

	public void setStu_app_lang_ag(String stu_app_lang_ag) {
		this.stu_app_lang_ag = stu_app_lang_ag;
	}

	public String getStu_app_lang_obtain_dt() {
		return stu_app_lang_obtain_dt;
	}

	public void setStu_app_lang_obtain_dt(String stu_app_lang_obtain_dt) {
		this.stu_app_lang_obtain_dt = stu_app_lang_obtain_dt;
	}

	public String getStu_app_lang_note() {
		return stu_app_lang_note;
	}

	public void setStu_app_lang_note(String stu_app_lang_note) {
		this.stu_app_lang_note = stu_app_lang_note;
	}

	public String getStu_app_lang_ins_id() {
		return stu_app_lang_ins_id;
	}

	public void setStu_app_lang_ins_id(String stu_app_lang_ins_id) {
		this.stu_app_lang_ins_id = stu_app_lang_ins_id;
	}

	public String getStu_app_lang_ins_dt() {
		return stu_app_lang_ins_dt;
	}

	public void setStu_app_lang_ins_dt(String stu_app_lang_ins_dt) {
		this.stu_app_lang_ins_dt = stu_app_lang_ins_dt;
	}

	public String getStu_app_lang_udt_id() {
		return stu_app_lang_udt_id;
	}

	public void setStu_app_lang_udt_id(String stu_app_lang_udt_id) {
		this.stu_app_lang_udt_id = stu_app_lang_udt_id;
	}

	public String getStu_app_lang_udt_dt() {
		return stu_app_lang_udt_dt;
	}

	public void setStu_app_lang_udt_dt(String stu_app_lang_udt_dt) {
		this.stu_app_lang_udt_dt = stu_app_lang_udt_dt;
	}

	public List<SocietyStuApplyLanguage> getLanguageList() {
		return languageList;
	}

	public void setLanguageList(List<SocietyStuApplyLanguage> languageList) {
		this.languageList = languageList;
	}

	@Override
	public String toString() {
		return "SocietyStuApplyLanguage [stu_app_lang_seq=" + stu_app_lang_seq + ", stu_app_seq=" + stu_app_seq
				+ ", stu_app_lang_test_nm=" + stu_app_lang_test_nm + ", stu_app_lang_grade=" + stu_app_lang_grade
				+ ", stu_app_lang_ag=" + stu_app_lang_ag + ", stu_app_lang_obtain_dt=" + stu_app_lang_obtain_dt
				+ ", stu_app_lang_note=" + stu_app_lang_note + ", stu_app_lang_ins_id=" + stu_app_lang_ins_id
				+ ", stu_app_lang_ins_dt=" + stu_app_lang_ins_dt + ", stu_app_lang_udt_id=" + stu_app_lang_udt_id
				+ ", stu_app_lang_udt_dt=" + stu_app_lang_udt_dt + ", languageList=" + languageList + "]";
	}

}
