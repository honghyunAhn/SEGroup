/**
 * 
 */
package global.segroup.society.fap.agency.domain;

/**
 * @Author : Administrator
 * @Date : 2018. 12. 18.
 * @Class 설명 : 
 * 
 */
public class SocietyFapAgencyCompanyConnect {

	private int fap_ag_comp_connect_seq;
	
	private String fap_ag_id;
	
	private String fap_comp_id;
	
	private String fap_ag_comp_connect_ck;

	/**
	 * @Desc : 
	 */
	public SocietyFapAgencyCompanyConnect() {
		super();
	}

	public SocietyFapAgencyCompanyConnect(int fap_ag_comp_connect_seq, String fap_ag_id, String fap_comp_id,
			String fap_ag_comp_connect_ck) {
		super();
		this.fap_ag_comp_connect_seq = fap_ag_comp_connect_seq;
		this.fap_ag_id = fap_ag_id;
		this.fap_comp_id = fap_comp_id;
		this.fap_ag_comp_connect_ck = fap_ag_comp_connect_ck;
	}

	/**
	 * @return the fap_ag_comp_connect_seq
	 */
	public int getFap_ag_comp_connect_seq() {
		return fap_ag_comp_connect_seq;
	}

	/**
	 * @param fap_ag_comp_connect_seq the fap_ag_comp_connect_seq to set
	 */
	public void setFap_ag_comp_connect_seq(int fap_ag_comp_connect_seq) {
		this.fap_ag_comp_connect_seq = fap_ag_comp_connect_seq;
	}

	/**
	 * @return the fap_ag_id
	 */
	public String getFap_ag_id() {
		return fap_ag_id;
	}

	/**
	 * @param fap_ag_id the fap_ag_id to set
	 */
	public void setFap_ag_id(String fap_ag_id) {
		this.fap_ag_id = fap_ag_id;
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
	 * @return the fap_ag_comp_connect_ck
	 */
	public String getFap_ag_comp_connect_ck() {
		return fap_ag_comp_connect_ck;
	}

	/**
	 * @param fap_ag_comp_connect_ck the fap_ag_comp_connect_ck to set
	 */
	public void setFap_ag_comp_connect_ck(String fap_ag_comp_connect_ck) {
		this.fap_ag_comp_connect_ck = fap_ag_comp_connect_ck;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapAgencyCompanyConnect [fap_ag_comp_connect_seq=" + fap_ag_comp_connect_seq + ", fap_ag_id="
				+ fap_ag_id + ", fap_comp_id=" + fap_comp_id + ", fap_ag_comp_connect_ck=" + fap_ag_comp_connect_ck
				+ "]";
	}
	
}
