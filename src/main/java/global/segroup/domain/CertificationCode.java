/**
 * 
 */
package global.segroup.domain;

import java.util.Date;

/**
 * @Author : user
 * @Date : 2017. 10. 16.
 * @Class 설명 : 
 * 
 */
public class CertificationCode {
	private int certification_code;	
	private String user_id;
	private Date certification_ck_st;
	private Date certification_ck_et;
	
	/**
	 * @Desc : 
	 */
	public CertificationCode() {}
	
	/**
	 * @param certification_code
	 * @param user_id
	 * @param certification_ck_st
	 * @param certification_ck_et
	 */
	public CertificationCode(int certification_code, String user_id, Date certification_ck_st,
			Date certification_ck_et) {
		super();
		this.certification_code = certification_code;
		this.user_id = user_id;
		this.certification_ck_st = certification_ck_st;
		this.certification_ck_et = certification_ck_et;
	}
	

	/**
	 * @return the certification_code
	 */
	public int getCertification_code() {
		return certification_code;
	}

	/**
	 * @param certification_code the certification_code to set
	 */
	public void setCertification_code(int certification_code) {
		this.certification_code = certification_code;
	}

	/**
	 * @return the user_id
	 */
	public String getUser_id() {
		return user_id;
	}

	/**
	 * @param user_id the user_id to set
	 */
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	/**
	 * @return the certification_ck_st
	 */
	public Date getCertification_ck_st() {
		return certification_ck_st;
	}

	/**
	 * @param certification_ck_st the certification_ck_st to set
	 */
	public void setCertification_ck_st(Date certification_ck_st) {
		this.certification_ck_st = certification_ck_st;
	}

	/**
	 * @return the certification_ck_et
	 */
	public Date getCertification_ck_et() {
		return certification_ck_et;
	}

	/**
	 * @param certification_ck_et the certification_ck_et to set
	 */
	public void setCertification_ck_et(Date certification_ck_et) {
		this.certification_ck_et = certification_ck_et;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CertificationCode [certification_code=" + certification_code + ", user_id=" + user_id
				+ ", certification_ck_st=" + certification_ck_st + ", certification_ck_et=" + certification_ck_et
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
}
