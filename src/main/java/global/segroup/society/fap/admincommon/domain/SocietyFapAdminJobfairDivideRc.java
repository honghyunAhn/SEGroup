/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 10.
 * @Class 설명 :  잡페어 세부채용대상
 * 
 */
public class SocietyFapAdminJobfairDivideRc {

	/**
	 * 잡페어 세부 채용대상 시퀀스
	 */
	private int fap_jobfair_divide_rc_seq;
	
	/**
	 * 잡페어 세부 일련번호
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 잡페어 일련번호
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어 세부채용대상(공통코드)
	 */
	private String fap_jobfair_divide_rc;
	
	/**
	 * 잡페어 K-fair 채용대상 리스트
	 */
	private List<SocietyFapAdminJobfairDivideRc> fap_jobfair_k_fair_rc_list;
	
	/**
	 * 잡페어 프리시즌 채용대상 리스트
	 */
	private List<SocietyFapAdminJobfairDivideRc> fap_jobfair_post_season_rc_list;	
	
	/**
	 * 잡페어 J-fair 채용대상 리스트
	 */
	private List<SocietyFapAdminJobfairDivideRc> fap_jobfair_j_fair_rc_list;
	
	/**
	 * 잡페어 미스매칭 채용대상 리스트
	 */
	private List<SocietyFapAdminJobfairDivideRc> fap_jobfair_missmatching_rc_list;
	
	/**
	 * 잡페어 세부채용대상 리스트
	 */
	private List<SocietyFapAdminJobfairDivideRc> fap_jobfair_divide_rc_list;


	public SocietyFapAdminJobfairDivideRc() {
		super();
	}

	public SocietyFapAdminJobfairDivideRc(int fap_jobfair_divide_rc_seq, int fap_jobfair_divide_seq,
			int fap_jobfair_seq, String fap_jobfair_divide_rc,
			List<SocietyFapAdminJobfairDivideRc> fap_jobfair_k_fair_rc_list,
			List<SocietyFapAdminJobfairDivideRc> fap_jobfair_post_season_rc_list,
			List<SocietyFapAdminJobfairDivideRc> fap_jobfair_j_fair_rc_list,
			List<SocietyFapAdminJobfairDivideRc> fap_jobfair_missmatching_rc_list,
			List<SocietyFapAdminJobfairDivideRc> fap_jobfair_divide_rc_list) {
		super();
		this.fap_jobfair_divide_rc_seq = fap_jobfair_divide_rc_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_divide_rc = fap_jobfair_divide_rc;
		this.fap_jobfair_k_fair_rc_list = fap_jobfair_k_fair_rc_list;
		this.fap_jobfair_post_season_rc_list = fap_jobfair_post_season_rc_list;
		this.fap_jobfair_j_fair_rc_list = fap_jobfair_j_fair_rc_list;
		this.fap_jobfair_missmatching_rc_list = fap_jobfair_missmatching_rc_list;
		this.fap_jobfair_divide_rc_list = fap_jobfair_divide_rc_list;
	}


	public int getFap_jobfair_divide_rc_seq() {
		return fap_jobfair_divide_rc_seq;
	}


	public void setFap_jobfair_divide_rc_seq(int fap_jobfair_divide_rc_seq) {
		this.fap_jobfair_divide_rc_seq = fap_jobfair_divide_rc_seq;
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


	public String getFap_jobfair_divide_rc() {
		return fap_jobfair_divide_rc;
	}


	public void setFap_jobfair_divide_rc(String fap_jobfair_divide_rc) {
		this.fap_jobfair_divide_rc = fap_jobfair_divide_rc;
	}


	public List<SocietyFapAdminJobfairDivideRc> getFap_jobfair_k_fair_rc_list() {
		return fap_jobfair_k_fair_rc_list;
	}


	public void setFap_jobfair_k_fair_rc_list(List<SocietyFapAdminJobfairDivideRc> fap_jobfair_k_fair_rc_list) {
		this.fap_jobfair_k_fair_rc_list = fap_jobfair_k_fair_rc_list;
	}


	public List<SocietyFapAdminJobfairDivideRc> getFap_jobfair_post_season_rc_list() {
		return fap_jobfair_post_season_rc_list;
	}


	public void setFap_jobfair_post_season_rc_list(List<SocietyFapAdminJobfairDivideRc> fap_jobfair_post_season_rc_list) {
		this.fap_jobfair_post_season_rc_list = fap_jobfair_post_season_rc_list;
	}


	public List<SocietyFapAdminJobfairDivideRc> getFap_jobfair_j_fair_rc_list() {
		return fap_jobfair_j_fair_rc_list;
	}


	public void setFap_jobfair_j_fair_rc_list(List<SocietyFapAdminJobfairDivideRc> fap_jobfair_j_fair_rc_list) {
		this.fap_jobfair_j_fair_rc_list = fap_jobfair_j_fair_rc_list;
	}


	public List<SocietyFapAdminJobfairDivideRc> getFap_jobfair_missmatching_rc_list() {
		return fap_jobfair_missmatching_rc_list;
	}


	public void setFap_jobfair_missmatching_rc_list(List<SocietyFapAdminJobfairDivideRc> fap_jobfair_missmatching_rc_list) {
		this.fap_jobfair_missmatching_rc_list = fap_jobfair_missmatching_rc_list;
	}


	public List<SocietyFapAdminJobfairDivideRc> getFap_jobfair_divide_rc_list() {
		return fap_jobfair_divide_rc_list;
	}


	public void setFap_jobfair_divide_rc_list(List<SocietyFapAdminJobfairDivideRc> fap_jobfair_divide_rc_list) {
		this.fap_jobfair_divide_rc_list = fap_jobfair_divide_rc_list;
	}


	@Override
	public String toString() {
		return "SocietyFapAdminJobfairDivideRc [fap_jobfair_divide_rc_seq=" + fap_jobfair_divide_rc_seq
				+ ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", fap_jobfair_seq=" + fap_jobfair_seq
				+ ", fap_jobfair_divide_rc=" + fap_jobfair_divide_rc + ", fap_jobfair_k_fair_rc_list="
				+ fap_jobfair_k_fair_rc_list + ", fap_jobfair_post_season_rc_list=" + fap_jobfair_post_season_rc_list
				+ ", fap_jobfair_j_fair_rc_list=" + fap_jobfair_j_fair_rc_list + ", fap_jobfair_missmatching_rc_list="
				+ fap_jobfair_missmatching_rc_list + ", fap_jobfair_divide_rc_list=" + fap_jobfair_divide_rc_list + "]";
	}

	
}
