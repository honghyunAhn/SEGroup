/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 5.
 * @Class 설명 :  채용기업의 잡페어 등록정보
 * 
 */
public class SocietyFapAdminJobfairComp {

	/**
	 * 채용기업의 잡페어 등록 시퀀스
	 */
	private int fap_jobfair_comp_seq;
	
	/**
	 * 잡페어 세부 시퀀스
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 회사 아이디
	 */
	private String fap_comp_id;

	
	public SocietyFapAdminJobfairComp() {
		super();
	}

	public SocietyFapAdminJobfairComp(int fap_jobfair_comp_seq, int fap_jobfair_divide_seq, int fap_jobfair_seq,
			String fap_comp_id) {
		super();
		this.fap_jobfair_comp_seq = fap_jobfair_comp_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_comp_id = fap_comp_id;
	}

	public int getFap_jobfair_comp_seq() {
		return fap_jobfair_comp_seq;
	}

	public void setFap_jobfair_comp_seq(int fap_jobfair_comp_seq) {
		this.fap_jobfair_comp_seq = fap_jobfair_comp_seq;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_comp_id() {
		return fap_comp_id;
	}

	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairComp [fap_jobfair_comp_seq=" + fap_jobfair_comp_seq + ", fap_jobfair_divide_seq="
				+ fap_jobfair_divide_seq + ", fap_jobfair_seq=" + fap_jobfair_seq + ", fap_comp_id=" + fap_comp_id
				+ "]";
	}	
		
}
