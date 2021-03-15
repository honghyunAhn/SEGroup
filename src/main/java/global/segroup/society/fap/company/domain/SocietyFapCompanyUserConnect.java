/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 김준영
 * @Date : 2018. 12. 12.
 * @Class 설명 : 회사-담당자 연결
 * 
 */
public class SocietyFapCompanyUserConnect {

	private int fap_comp_user_connect_seq;
	
	private String user_id;
	
	private String fap_comp_id;

	private String fap_comp_user_connect_ck;

	/**
	 * @Desc : 
	 */
	public SocietyFapCompanyUserConnect() {
		super();
	}

	/**
	 * @Desc : 
	 * @param fap_comp_user_connect_seq
	 * @param user_id
	 * @param fap_comp_id
	 * @param fap_comp_user_connect_ck
	 */
	public SocietyFapCompanyUserConnect(int fap_comp_user_connect_seq, String user_id, String fap_comp_id,
			String fap_comp_user_connect_ck) {
		super();
		this.fap_comp_user_connect_seq = fap_comp_user_connect_seq;
		this.user_id = user_id;
		this.fap_comp_id = fap_comp_id;
		this.fap_comp_user_connect_ck = fap_comp_user_connect_ck;
	}

	/**
	 * @return the fap_comp_user_connect_seq
	 */
	public int getFap_comp_user_connect_seq() {
		return fap_comp_user_connect_seq;
	}

	/**
	 * @param fap_comp_user_connect_seq the fap_comp_user_connect_seq to set
	 */
	public void setFap_comp_user_connect_seq(int fap_comp_user_connect_seq) {
		this.fap_comp_user_connect_seq = fap_comp_user_connect_seq;
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
	 * @return the fap_comp_id
	 */
	public String getFap_comp_id() {
		return fap_comp_id;
	}

	/**
	 * @param fap_comp_id the fap_comp_id to set
	 */
	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}

	/**
	 * @return the fap_comp_user_connect_ck
	 */
	public String getFap_comp_user_connect_ck() {
		return fap_comp_user_connect_ck;
	}

	/**
	 * @param fap_comp_user_connect_ck the fap_comp_user_connect_ck to set
	 */
	public void setFap_comp_user_connect_ck(String fap_comp_user_connect_ck) {
		this.fap_comp_user_connect_ck = fap_comp_user_connect_ck;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapCompanyUserConnect [fap_comp_user_connect_seq=" + fap_comp_user_connect_seq + ", user_id="
				+ user_id + ", fap_comp_id=" + fap_comp_id + ", fap_comp_user_connect_ck=" + fap_comp_user_connect_ck
				+ "]";
	}
	
}
