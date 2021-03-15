/**
 * 
 */
package global.segroup.domain;

import java.io.Serializable;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer Group 관리자 정보
 * 
 */
public class Admin implements Serializable {

	private static final long serialVersionUID = -690966666031282865L;

	/**
	 * Admin 아이디
	 */
	private String admin_id;
	
	/**
	 * Admin 비밀번호
	 */
	private String admin_pw;
	
	/**
	 * Admin 이름
	 */
	private String admin_nm;
	
	/**
	 * Admin 등급
	 * ( 수퍼 관리자 , 주 관리자 , 부 관리자 )
	 */
	private String admin_grade;
	
	/**
	 * Admin 상태
	 * ( 정상 , 휴면, 탈퇴 , 정지 )
	 */
	private String admin_state;
	
	/**
	 * Admin 소속 프로젝트
	 * ( FS , 도서관리 , 모집홍보 )
	 */
	private String admin_project;
	
	/**
	 * Admin 권한 기간 시작일
	 * */
	private String admin_expired_st;
	
	/**
	 * Admin 권한 기간 종료일
	 * */
	private String admin_expired_et;
	
	/**
	 * Admin 정보 등록 일자
	 */
	private String admin_ins_dt;
	
	/**
	 * Admin 정보 수정 일자
	 */
	private String admin_udt_dt;
	
	/**
	 * Admin 정보 등록인
	 */
	private String admin_ins_id;
	
	/**
	 * Admin 정보 수정인
	 */
	private String admin_udt_id;
	
	
	public Admin() {
		super();
	}

	public Admin(String admin_id, String admin_pw, String admin_nm, String admin_grade, String admin_state,
			String admin_project, String admin_expired_st, String admin_expired_et, String admin_ins_dt,
			String admin_udt_dt, String admin_ins_id, String admin_udt_id) {
		super();
		this.admin_id = admin_id;
		this.admin_pw = admin_pw;
		this.admin_nm = admin_nm;
		this.admin_grade = admin_grade;
		this.admin_state = admin_state;
		this.admin_project = admin_project;
		this.admin_expired_st = admin_expired_st;
		this.admin_expired_et = admin_expired_et;
		this.admin_ins_dt = admin_ins_dt;
		this.admin_udt_dt = admin_udt_dt;
		this.admin_ins_id = admin_ins_id;
		this.admin_udt_id = admin_udt_id;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdmin_pw() {
		return admin_pw;
	}

	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}

	public String getAdmin_nm() {
		return admin_nm;
	}

	public void setAdmin_nm(String admin_nm) {
		this.admin_nm = admin_nm;
	}

	public String getAdmin_grade() {
		return admin_grade;
	}

	public void setAdmin_grade(String admin_grade) {
		this.admin_grade = admin_grade;
	}

	public String getAdmin_state() {
		return admin_state;
	}

	public void setAdmin_state(String admin_state) {
		this.admin_state = admin_state;
	}

	public String getAdmin_project() {
		return admin_project;
	}

	public void setAdmin_project(String admin_project) {
		this.admin_project = admin_project;
	}

	public String getAdmin_expired_st() {
		return admin_expired_st;
	}

	public void setAdmin_expired_st(String admin_expired_st) {
		this.admin_expired_st = admin_expired_st;
	}

	public String getAdmin_expired_et() {
		return admin_expired_et;
	}

	public void setAdmin_expired_et(String admin_expired_et) {
		this.admin_expired_et = admin_expired_et;
	}

	public String getAdmin_ins_dt() {
		return admin_ins_dt;
	}

	public void setAdmin_ins_dt(String admin_ins_dt) {
		this.admin_ins_dt = admin_ins_dt;
	}

	public String getAdmin_udt_dt() {
		return admin_udt_dt;
	}

	public void setAdmin_udt_dt(String admin_udt_dt) {
		this.admin_udt_dt = admin_udt_dt;
	}

	public String getAdmin_ins_id() {
		return admin_ins_id;
	}

	public void setAdmin_ins_id(String admin_ins_id) {
		this.admin_ins_id = admin_ins_id;
	}

	public String getAdmin_udt_id() {
		return admin_udt_id;
	}

	public void setAdmin_udt_id(String admin_udt_id) {
		this.admin_udt_id = admin_udt_id;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Admin [admin_id=" + admin_id + ", admin_pw=" + admin_pw + ", admin_nm=" + admin_nm + ", admin_grade="
				+ admin_grade + ", admin_state=" + admin_state + ", admin_project=" + admin_project
				+ ", admin_expired_st=" + admin_expired_st + ", admin_expired_et=" + admin_expired_et
				+ ", admin_ins_dt=" + admin_ins_dt + ", admin_udt_dt=" + admin_udt_dt + ", admin_ins_id=" + admin_ins_id
				+ ", admin_udt_id=" + admin_udt_id + "]";
	}

}
