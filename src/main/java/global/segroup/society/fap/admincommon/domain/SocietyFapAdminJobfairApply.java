/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 5.
 * @Class 설명 : 지원자의 잡페어 등록정보
 * 
 */
public class SocietyFapAdminJobfairApply {
	
	/**
	 * 지원자의 잡페어 등록 시퀀스
	 */
	private int fap_jobfair_user_seq;
	
	/**
	 * 잡페어 세부 시퀀스
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 회원 아이디
	 */
	private String user_id;
	
	/**
	 * 지원자 잡페어 참가승인 여부(공통코드)
	 */
	private String fap_jobfair_user_per;

	/**
	 * 지원자 잡페어 참가승인 담당자
	 */
	private String fap_jobfair_user_per_id;
	
	/**
	 * 지원자 잡페어 참가승인 일자
	 */
	private String fap_jobfair_user_per_dt;
	
	public SocietyFapAdminJobfairApply() {
		super();
	}

	public SocietyFapAdminJobfairApply(int fap_jobfair_user_seq, int fap_jobfair_divide_seq, int fap_jobfair_seq,
			String user_id, String fap_jobfair_user_per, String fap_jobfair_user_per_id,
			String fap_jobfair_user_per_dt) {
		super();
		this.fap_jobfair_user_seq = fap_jobfair_user_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.user_id = user_id;
		this.fap_jobfair_user_per = fap_jobfair_user_per;
		this.fap_jobfair_user_per_id = fap_jobfair_user_per_id;
		this.fap_jobfair_user_per_dt = fap_jobfair_user_per_dt;
	}

	public int getFap_jobfair_user_seq() {
		return fap_jobfair_user_seq;
	}

	public void setFap_jobfair_user_seq(int fap_jobfair_user_seq) {
		this.fap_jobfair_user_seq = fap_jobfair_user_seq;
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

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFap_jobfair_user_per() {
		return fap_jobfair_user_per;
	}

	public void setFap_jobfair_user_per(String fap_jobfair_user_per) {
		this.fap_jobfair_user_per = fap_jobfair_user_per;
	}

	public String getFap_jobfair_user_per_id() {
		return fap_jobfair_user_per_id;
	}

	public void setFap_jobfair_user_per_id(String fap_jobfair_user_per_id) {
		this.fap_jobfair_user_per_id = fap_jobfair_user_per_id;
	}

	public String getFap_jobfair_user_per_dt() {
		return fap_jobfair_user_per_dt;
	}

	public void setFap_jobfair_user_per_dt(String fap_jobfair_user_per_dt) {
		this.fap_jobfair_user_per_dt = fap_jobfair_user_per_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairApply [fap_jobfair_user_seq=" + fap_jobfair_user_seq + ", fap_jobfair_divide_seq="
				+ fap_jobfair_divide_seq + ", fap_jobfair_seq=" + fap_jobfair_seq + ", user_id=" + user_id
				+ ", fap_jobfair_user_per=" + fap_jobfair_user_per + ", fap_jobfair_user_per_id="
				+ fap_jobfair_user_per_id + ", fap_jobfair_user_per_dt=" + fap_jobfair_user_per_dt + "]";
	}

		
}
