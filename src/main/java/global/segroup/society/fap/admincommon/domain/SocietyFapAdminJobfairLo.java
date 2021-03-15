/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 10.
 * @Class 설명 : 잡페어 개최지
 * 
 */
public class SocietyFapAdminJobfairLo {

	/**
	 * 잡페어 개최지 시퀀스
	 */
	private int fap_jobfair_lo_seq;
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어 개최지
	 */
	private String fap_jobfair_lo;

	/**
	 * 잡페어 개최지 리스트
	 */
	private List<SocietyFapAdminJobfairLo> fap_jobfair_lo_list;
	
	public SocietyFapAdminJobfairLo() {
		super();
	}

	public SocietyFapAdminJobfairLo(int fap_jobfair_lo_seq, int fap_jobfair_seq, String fap_jobfair_lo,
			List<SocietyFapAdminJobfairLo> fap_jobfair_lo_list) {
		super();
		this.fap_jobfair_lo_seq = fap_jobfair_lo_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_lo = fap_jobfair_lo;
		this.fap_jobfair_lo_list = fap_jobfair_lo_list;
	}

	public int getFap_jobfair_lo_seq() {
		return fap_jobfair_lo_seq;
	}

	public void setFap_jobfair_lo_seq(int fap_jobfair_lo_seq) {
		this.fap_jobfair_lo_seq = fap_jobfair_lo_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_jobfair_lo() {
		return fap_jobfair_lo;
	}

	public void setFap_jobfair_lo(String fap_jobfair_lo) {
		this.fap_jobfair_lo = fap_jobfair_lo;
	}

	public List<SocietyFapAdminJobfairLo> getFap_jobfair_lo_list() {
		return fap_jobfair_lo_list;
	}

	public void setFap_jobfair_lo_list(List<SocietyFapAdminJobfairLo> fap_jobfair_lo_list) {
		this.fap_jobfair_lo_list = fap_jobfair_lo_list;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairLo [fap_jobfair_lo_seq=" + fap_jobfair_lo_seq + ", fap_jobfair_seq="
				+ fap_jobfair_seq + ", fap_jobfair_lo=" + fap_jobfair_lo + ", fap_jobfair_lo_list="
				+ fap_jobfair_lo_list + "]";
	}	
	
}
