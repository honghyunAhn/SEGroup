/**
 * 
 */
package global.segroup.domain;

import java.io.Serializable;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer Group 유저 정보
 * 
 */
public class User implements Serializable {

	private static final long serialVersionUID = 5032262132645423960L;

	/**
	 * User 아이디
	 */
	private String user_id;
	
	/**
	 * User 비밀번호
	 */
	private String user_pw;
	
	/**
	 * User 이름
	 */
	private String user_nm;
	
	/**
	 * User 전화번호
	 */
	private String user_phone;
	
	/**
	 * User 이메일
	 */
	private String user_email;

	/**
	 * User 생년월일
	 */
	private String user_birth;
	
	/**
	 * User 성별
	 */
	private String user_sex;
	
	/**
	 * User 구분
	 * ( 일반, 마스터 재학생 , 마스터 졸업생 , 채용 기업 , 에이전시 )
	 */
	private String user_flag;
	
	/**
	 * User 상태
	 * ( 사용중 , 휴면계정 , 탈퇴계정 )
	 */
	private String user_state;
	
	/**
	 * User 정보 등록 일자
	 */
	private String user_ins_dt;
	
	/**
	 * User 정보 수정 일자
	 */
	private String user_udt_dt;
	
	/**
	 * User 정보 등록인
	 */
	private String user_ins_id;
	
	/**
	 * User 정보 수정인
	 */
	private String user_udt_id;
	
	/*
	 * User 약관 동의 체크
	 */
	private String user_terms_ck;
	
	public User() {
		super();
	}

	public User(String user_id, String user_pw, String user_nm, String user_phone, String user_email, String user_birth,
			String user_sex, String user_flag, String user_state, String user_ins_dt, String user_udt_dt,
			String user_ins_id, String user_udt_id, String user_terms_ck) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_nm = user_nm;
		this.user_phone = user_phone;
		this.user_email = user_email;
		this.user_birth = user_birth;
		this.user_sex = user_sex;
		this.user_flag = user_flag;
		this.user_state = user_state;
		this.user_ins_dt = user_ins_dt;
		this.user_udt_dt = user_udt_dt;
		this.user_ins_id = user_ins_id;
		this.user_udt_id = user_udt_id;
		this.user_terms_ck = user_terms_ck;
	}
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_nm() {
		return user_nm;
	}

	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}

	public String getUser_sex() {
		return user_sex;
	}

	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}

	public String getUser_flag() {
		return user_flag;
	}

	public void setUser_flag(String user_flag) {
		this.user_flag = user_flag;
	}

	public String getUser_state() {
		return user_state;
	}

	public void setUser_state(String user_state) {
		this.user_state = user_state;
	}

	public String getUser_ins_dt() {
		return user_ins_dt;
	}

	public void setUser_ins_dt(String user_ins_dt) {
		this.user_ins_dt = user_ins_dt;
	}

	public String getUser_udt_dt() {
		return user_udt_dt;
	}

	public void setUser_udt_dt(String user_udt_dt) {
		this.user_udt_dt = user_udt_dt;
	}

	public String getUser_ins_id() {
		return user_ins_id;
	}

	public void setUser_ins_id(String user_ins_id) {
		this.user_ins_id = user_ins_id;
	}

	public String getUser_udt_id() {
		return user_udt_id;
	}

	public void setUser_udt_id(String user_udt_id) {
		this.user_udt_id = user_udt_id;
	}

	public String getUser_terms_ck() {
		return user_terms_ck;
	}

	public void setUser_terms_ck(String user_terms_ck) {
		this.user_terms_ck = user_terms_ck;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", user_pw=" + user_pw + ", user_nm=" + user_nm + ", user_phone="
				+ user_phone + ", user_email=" + user_email + ", user_birth=" + user_birth + ", user_sex=" + user_sex
				+ ", user_flag=" + user_flag + ", user_state=" + user_state + ", user_ins_dt=" + user_ins_dt
				+ ", user_udt_dt=" + user_udt_dt + ", user_ins_id=" + user_ins_id + ", user_udt_id=" + user_udt_id
				+ ", user_terms_ck=" + user_terms_ck + "]";
	}

	

}
