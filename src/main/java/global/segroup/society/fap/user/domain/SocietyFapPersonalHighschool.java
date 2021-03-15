/**
 * 
 */
package global.segroup.society.fap.user.domain;

/**
 * @Author : Administrator
 * @Date : 2018. 12. 13.
 * @Class 설명 : 
 * 
 */
public class SocietyFapPersonalHighschool {

	private int fap_personal_hs_seq;
	
	private int fap_personal_user_seq;
	
	private String fap_personal_hs_nm;
	
	private String fap_personal_hs_field;
	
	private String fap_personal_hs_ins_id;
	
	private String fap_personal_hs_ins_dt;
	
	private String fap_personal_hs_udt_id;
	
	private String fap_personal_hs_udt_dt;

	/**
	 * @Desc : 
	 */
	public SocietyFapPersonalHighschool() {
		super();
	}

	/**
	 * @Desc : 
	 * @param fap_personal_hs_seq
	 * @param fap_personal_user_seq
	 * @param fap_personal_hs_nm
	 * @param fap_personal_hs_field
	 * @param fap_personal_hs_ins_id
	 * @param fap_personal_hs_ins_dt
	 * @param fap_personal_hs_udt_id
	 * @param fap_personal_hs_udt_dt
	 */
	public SocietyFapPersonalHighschool(int fap_personal_hs_seq, int fap_personal_user_seq, String fap_personal_hs_nm,
			String fap_personal_hs_field, String fap_personal_hs_ins_id, String fap_personal_hs_ins_dt,
			String fap_personal_hs_udt_id, String fap_personal_hs_udt_dt) {
		super();
		this.fap_personal_hs_seq = fap_personal_hs_seq;
		this.fap_personal_user_seq = fap_personal_user_seq;
		this.fap_personal_hs_nm = fap_personal_hs_nm;
		this.fap_personal_hs_field = fap_personal_hs_field;
		this.fap_personal_hs_ins_id = fap_personal_hs_ins_id;
		this.fap_personal_hs_ins_dt = fap_personal_hs_ins_dt;
		this.fap_personal_hs_udt_id = fap_personal_hs_udt_id;
		this.fap_personal_hs_udt_dt = fap_personal_hs_udt_dt;
	}

	/**
	 * @return the fap_personal_hs_seq
	 */
	public int getFap_personal_hs_seq() {
		return fap_personal_hs_seq;
	}

	/**
	 * @param fap_personal_hs_seq the fap_personal_hs_seq to set
	 */
	public void setFap_personal_hs_seq(int fap_personal_hs_seq) {
		this.fap_personal_hs_seq = fap_personal_hs_seq;
	}

	/**
	 * @return the fap_personal_user_seq
	 */
	public int getFap_personal_user_seq() {
		return fap_personal_user_seq;
	}

	/**
	 * @param fap_personal_user_seq the fap_personal_user_seq to set
	 */
	public void setFap_personal_user_seq(int fap_personal_user_seq) {
		this.fap_personal_user_seq = fap_personal_user_seq;
	}

	/**
	 * @return the fap_personal_hs_nm
	 */
	public String getFap_personal_hs_nm() {
		return fap_personal_hs_nm;
	}

	/**
	 * @param fap_personal_hs_nm the fap_personal_hs_nm to set
	 */
	public void setFap_personal_hs_nm(String fap_personal_hs_nm) {
		this.fap_personal_hs_nm = fap_personal_hs_nm;
	}

	/**
	 * @return the fap_personal_hs_field
	 */
	public String getFap_personal_hs_field() {
		return fap_personal_hs_field;
	}

	/**
	 * @param fap_personal_hs_field the fap_personal_hs_field to set
	 */
	public void setFap_personal_hs_field(String fap_personal_hs_field) {
		this.fap_personal_hs_field = fap_personal_hs_field;
	}

	/**
	 * @return the fap_personal_hs_ins_id
	 */
	public String getFap_personal_hs_ins_id() {
		return fap_personal_hs_ins_id;
	}

	/**
	 * @param fap_personal_hs_ins_id the fap_personal_hs_ins_id to set
	 */
	public void setFap_personal_hs_ins_id(String fap_personal_hs_ins_id) {
		this.fap_personal_hs_ins_id = fap_personal_hs_ins_id;
	}

	/**
	 * @return the fap_personal_hs_ins_dt
	 */
	public String getFap_personal_hs_ins_dt() {
		return fap_personal_hs_ins_dt;
	}

	/**
	 * @param fap_personal_hs_ins_dt the fap_personal_hs_ins_dt to set
	 */
	public void setFap_personal_hs_ins_dt(String fap_personal_hs_ins_dt) {
		this.fap_personal_hs_ins_dt = fap_personal_hs_ins_dt;
	}

	/**
	 * @return the fap_personal_hs_udt_id
	 */
	public String getFap_personal_hs_udt_id() {
		return fap_personal_hs_udt_id;
	}

	/**
	 * @param fap_personal_hs_udt_id the fap_personal_hs_udt_id to set
	 */
	public void setFap_personal_hs_udt_id(String fap_personal_hs_udt_id) {
		this.fap_personal_hs_udt_id = fap_personal_hs_udt_id;
	}

	/**
	 * @return the fap_personal_hs_udt_dt
	 */
	public String getFap_personal_hs_udt_dt() {
		return fap_personal_hs_udt_dt;
	}

	/**
	 * @param fap_personal_hs_udt_dt the fap_personal_hs_udt_dt to set
	 */
	public void setFap_personal_hs_udt_dt(String fap_personal_hs_udt_dt) {
		this.fap_personal_hs_udt_dt = fap_personal_hs_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapPersonalHighschool [fap_personal_hs_seq=" + fap_personal_hs_seq + ", fap_personal_user_seq="
				+ fap_personal_user_seq + ", fap_personal_hs_nm=" + fap_personal_hs_nm + ", fap_personal_hs_field="
				+ fap_personal_hs_field + ", fap_personal_hs_ins_id=" + fap_personal_hs_ins_id
				+ ", fap_personal_hs_ins_dt=" + fap_personal_hs_ins_dt + ", fap_personal_hs_udt_id="
				+ fap_personal_hs_udt_id + ", fap_personal_hs_udt_dt=" + fap_personal_hs_udt_dt + "]";
	}
	
}
