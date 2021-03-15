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
public class SocietyFapPersonalGraduate {

	private int fap_personal_grad_seq;
	
	private int fap_personal_univ_seq;
	
	private String fap_personal_grad_nm;

	private String fap_personal_grad_ck;
	
	private String fap_personal_grad_major;
	
	private String fap_personal_grad_ins_id;
	
	private String fap_personal_grad_ins_dt;
	
	private String fap_personal_grad_udt_id;
	
	private String fap_personal_grad_udt_dt;

	/**
	 * @Desc : 
	 */
	public SocietyFapPersonalGraduate() {
		super();
	}

	/**
	 * @Desc : 
	 * @param fap_personal_grad_seq
	 * @param fap_personal_univ_seq
	 * @param fap_personal_grad_nm
	 * @param fap_personal_grad_ck
	 * @param fap_personal_grad_major
	 * @param fap_personal_grad_ins_id
	 * @param fap_personal_grad_ins_dt
	 * @param fap_personal_grad_udt_id
	 * @param fap_personal_grad_udt_dt
	 */
	public SocietyFapPersonalGraduate(int fap_personal_grad_seq, int fap_personal_univ_seq, String fap_personal_grad_nm,
			String fap_personal_grad_ck, String fap_personal_grad_major, String fap_personal_grad_ins_id,
			String fap_personal_grad_ins_dt, String fap_personal_grad_udt_id, String fap_personal_grad_udt_dt) {
		super();
		this.fap_personal_grad_seq = fap_personal_grad_seq;
		this.fap_personal_univ_seq = fap_personal_univ_seq;
		this.fap_personal_grad_nm = fap_personal_grad_nm;
		this.fap_personal_grad_ck = fap_personal_grad_ck;
		this.fap_personal_grad_major = fap_personal_grad_major;
		this.fap_personal_grad_ins_id = fap_personal_grad_ins_id;
		this.fap_personal_grad_ins_dt = fap_personal_grad_ins_dt;
		this.fap_personal_grad_udt_id = fap_personal_grad_udt_id;
		this.fap_personal_grad_udt_dt = fap_personal_grad_udt_dt;
	}

	/**
	 * @return the fap_personal_grad_seq
	 */
	public int getFap_personal_grad_seq() {
		return fap_personal_grad_seq;
	}

	/**
	 * @param fap_personal_grad_seq the fap_personal_grad_seq to set
	 */
	public void setFap_personal_grad_seq(int fap_personal_grad_seq) {
		this.fap_personal_grad_seq = fap_personal_grad_seq;
	}

	/**
	 * @return the fap_personal_univ_seq
	 */
	public int getFap_personal_univ_seq() {
		return fap_personal_univ_seq;
	}

	/**
	 * @param fap_personal_univ_seq the fap_personal_univ_seq to set
	 */
	public void setFap_personal_univ_seq(int fap_personal_univ_seq) {
		this.fap_personal_univ_seq = fap_personal_univ_seq;
	}

	/**
	 * @return the fap_personal_grad_nm
	 */
	public String getFap_personal_grad_nm() {
		return fap_personal_grad_nm;
	}

	/**
	 * @param fap_personal_grad_nm the fap_personal_grad_nm to set
	 */
	public void setFap_personal_grad_nm(String fap_personal_grad_nm) {
		this.fap_personal_grad_nm = fap_personal_grad_nm;
	}

	/**
	 * @return the fap_personal_grad_ck
	 */
	public String getFap_personal_grad_ck() {
		return fap_personal_grad_ck;
	}

	/**
	 * @param fap_personal_grad_ck the fap_personal_grad_ck to set
	 */
	public void setFap_personal_grad_ck(String fap_personal_grad_ck) {
		this.fap_personal_grad_ck = fap_personal_grad_ck;
	}

	/**
	 * @return the fap_personal_grad_major
	 */
	public String getFap_personal_grad_major() {
		return fap_personal_grad_major;
	}

	/**
	 * @param fap_personal_grad_major the fap_personal_grad_major to set
	 */
	public void setFap_personal_grad_major(String fap_personal_grad_major) {
		this.fap_personal_grad_major = fap_personal_grad_major;
	}

	/**
	 * @return the fap_personal_grad_ins_id
	 */
	public String getFap_personal_grad_ins_id() {
		return fap_personal_grad_ins_id;
	}

	/**
	 * @param fap_personal_grad_ins_id the fap_personal_grad_ins_id to set
	 */
	public void setFap_personal_grad_ins_id(String fap_personal_grad_ins_id) {
		this.fap_personal_grad_ins_id = fap_personal_grad_ins_id;
	}

	/**
	 * @return the fap_personal_grad_ins_dt
	 */
	public String getFap_personal_grad_ins_dt() {
		return fap_personal_grad_ins_dt;
	}

	/**
	 * @param fap_personal_grad_ins_dt the fap_personal_grad_ins_dt to set
	 */
	public void setFap_personal_grad_ins_dt(String fap_personal_grad_ins_dt) {
		this.fap_personal_grad_ins_dt = fap_personal_grad_ins_dt;
	}

	/**
	 * @return the fap_personal_grad_udt_id
	 */
	public String getFap_personal_grad_udt_id() {
		return fap_personal_grad_udt_id;
	}

	/**
	 * @param fap_personal_grad_udt_id the fap_personal_grad_udt_id to set
	 */
	public void setFap_personal_grad_udt_id(String fap_personal_grad_udt_id) {
		this.fap_personal_grad_udt_id = fap_personal_grad_udt_id;
	}

	/**
	 * @return the fap_personal_grad_udt_dt
	 */
	public String getFap_personal_grad_udt_dt() {
		return fap_personal_grad_udt_dt;
	}

	/**
	 * @param fap_personal_grad_udt_dt the fap_personal_grad_udt_dt to set
	 */
	public void setFap_personal_grad_udt_dt(String fap_personal_grad_udt_dt) {
		this.fap_personal_grad_udt_dt = fap_personal_grad_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapPersonalGraduate [fap_personal_grad_seq=" + fap_personal_grad_seq + ", fap_personal_univ_seq="
				+ fap_personal_univ_seq + ", fap_personal_grad_nm=" + fap_personal_grad_nm + ", fap_personal_grad_ck="
				+ fap_personal_grad_ck + ", fap_personal_grad_major=" + fap_personal_grad_major
				+ ", fap_personal_grad_ins_id=" + fap_personal_grad_ins_id + ", fap_personal_grad_ins_dt="
				+ fap_personal_grad_ins_dt + ", fap_personal_grad_udt_id=" + fap_personal_grad_udt_id
				+ ", fap_personal_grad_udt_dt=" + fap_personal_grad_udt_dt + "]";
	}
	
}
