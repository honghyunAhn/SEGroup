/**
 * 
 */
package global.segroup.society.edu.apply.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 26.
 * @Class 설명 : Society 모집홍보 지원신청서 언어능력 정보
 * 
 */
public class SocietyEduApplyLanguage {

	private int app_lang_seq;
	
	/**
	 * 지원 신청서 시퀀스
	 */
	private int app_seq;
	
	/**
	 * 언어명
	 */
	private String app_lang_nm;
	
	/**
	 * 시험명
	 */
	private String app_lang_test_nm;
	
	/**
	 * 점수/등급
	 */
	private String app_lang_grade;
	
	/**
	 * 발급기관
	 */
	private String app_lang_ag;
	
	/**
	 * 취득 일자(yyyyMMdd)
	 */
	private String app_lang_obtain_dt;
	
	/**
	 * 등록인
	 */
	private String app_lang_ins_id;
	
	/**
	 * 등록 일자(yyyyMMdd24hhmiss)
	 */
	private String app_lang_ins_dt;
	
	/**
	 * 수정인
	 */
	private String app_lang_udt_id;
	
	/**
	 * 수정 일자(yyyyMMdd24hhmiss)
	 */
	private String app_lang_udt_dt;
	
	private List<SocietyEduApplyLanguage> languageList;

	public SocietyEduApplyLanguage() {
		super();
	}

	public SocietyEduApplyLanguage(int app_lang_seq, int app_seq, String app_lang_nm, String app_lang_test_nm,
			String app_lang_grade, String app_lang_ag, String app_lang_obtain_dt, String app_lang_ins_id,
			String app_lang_ins_dt, String app_lang_udt_id, String app_lang_udt_dt,
			List<SocietyEduApplyLanguage> languageList) {
		super();
		this.app_lang_seq = app_lang_seq;
		this.app_seq = app_seq;
		this.app_lang_nm = app_lang_nm;
		this.app_lang_test_nm = app_lang_test_nm;
		this.app_lang_grade = app_lang_grade;
		this.app_lang_ag = app_lang_ag;
		this.app_lang_obtain_dt = app_lang_obtain_dt;
		this.app_lang_ins_id = app_lang_ins_id;
		this.app_lang_ins_dt = app_lang_ins_dt;
		this.app_lang_udt_id = app_lang_udt_id;
		this.app_lang_udt_dt = app_lang_udt_dt;
		this.languageList = languageList;
	}

	public int getApp_lang_seq() {
		return app_lang_seq;
	}

	public void setApp_lang_seq(int app_lang_seq) {
		this.app_lang_seq = app_lang_seq;
	}

	public int getApp_seq() {
		return app_seq;
	}

	public void setApp_seq(int app_seq) {
		this.app_seq = app_seq;
	}

	public String getApp_lang_nm() {
		return app_lang_nm;
	}

	public void setApp_lang_nm(String app_lang_nm) {
		this.app_lang_nm = app_lang_nm;
	}

	public String getApp_lang_test_nm() {
		return app_lang_test_nm;
	}

	public void setApp_lang_test_nm(String app_lang_test_nm) {
		this.app_lang_test_nm = app_lang_test_nm;
	}

	public String getApp_lang_grade() {
		return app_lang_grade;
	}

	public void setApp_lang_grade(String app_lang_grade) {
		this.app_lang_grade = app_lang_grade;
	}

	public String getApp_lang_ag() {
		return app_lang_ag;
	}

	public void setApp_lang_ag(String app_lang_ag) {
		this.app_lang_ag = app_lang_ag;
	}

	public String getApp_lang_obtain_dt() {
		return app_lang_obtain_dt;
	}

	public void setApp_lang_obtain_dt(String app_lang_obtain_dt) {
		this.app_lang_obtain_dt = app_lang_obtain_dt;
	}

	public String getApp_lang_ins_id() {
		return app_lang_ins_id;
	}

	public void setApp_lang_ins_id(String app_lang_ins_id) {
		this.app_lang_ins_id = app_lang_ins_id;
	}

	public String getApp_lang_ins_dt() {
		return app_lang_ins_dt;
	}

	public void setApp_lang_ins_dt(String app_lang_ins_dt) {
		this.app_lang_ins_dt = app_lang_ins_dt;
	}

	public String getApp_lang_udt_id() {
		return app_lang_udt_id;
	}

	public void setApp_lang_udt_id(String app_lang_udt_id) {
		this.app_lang_udt_id = app_lang_udt_id;
	}

	public String getApp_lang_udt_dt() {
		return app_lang_udt_dt;
	}

	public void setApp_lang_udt_dt(String app_lang_udt_dt) {
		this.app_lang_udt_dt = app_lang_udt_dt;
	}

	public List<SocietyEduApplyLanguage> getLanguageList() {
		return languageList;
	}

	public void setLanguageList(List<SocietyEduApplyLanguage> languageList) {
		this.languageList = languageList;
	}

	@Override
	public String toString() {
		return "SocietyEduApplyLanguage [app_lang_seq=" + app_lang_seq + ", app_seq=" + app_seq + ", app_lang_nm="
				+ app_lang_nm + ", app_lang_test_nm=" + app_lang_test_nm + ", app_lang_grade=" + app_lang_grade
				+ ", app_lang_ag=" + app_lang_ag + ", app_lang_obtain_dt=" + app_lang_obtain_dt + ", app_lang_ins_id="
				+ app_lang_ins_id + ", app_lang_ins_dt=" + app_lang_ins_dt + ", app_lang_udt_id=" + app_lang_udt_id
				+ ", app_lang_udt_dt=" + app_lang_udt_dt + ", languageList=" + languageList + "]";
	}

}
