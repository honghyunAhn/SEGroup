/**
 * 
 */
package global.segroup.society.fap.user.domain;


/**
 * @Author : 신동철
 * @Date : 2019. 1. 5.
 * @Class 설명 : 내정자
 * 
 */
public class SocietyFapNominee {

	/**
	 * 내정자 시퀀스
	 */
	private long fap_nominee_seq;
	
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어 세부 시퀀스
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 회사아이디
	 */
	private String fap_comp_id;
	
	/**
	 * 회원아이디
	 */
	private String user_id;
	
	/**
	 * 내정회사입사여부(공통코드)
	 */
	private String fap_nominee_enter_gb;
	
	/**
	 * 등록자
	 */
	private String fap_nominee_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_nominee_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_nominee_udt_id;
	
	/**
	 * 수정일
	 */
	private String fap_nominee_udt_dt;


	public SocietyFapNominee() {
		super();
	}


	/**
	 * @Desc : 
	 * @param fap_nominee_seq
	 * @param fap_job_ad_seq
	 * @param fap_jobfair_seq
	 * @param fap_jobfair_divide_seq
	 * @param fap_comp_id
	 * @param user_id
	 * @param fap_nominee_enter_gb
	 * @param fap_nominee_ins_id
	 * @param fap_nominee_ins_dt
	 * @param fap_nominee_udt_id
	 * @param fap_nominee_udt_dt
	 */
	public SocietyFapNominee(long fap_nominee_seq, long fap_job_ad_seq, int fap_jobfair_seq, int fap_jobfair_divide_seq,
			String fap_comp_id, String user_id, String fap_nominee_enter_gb, String fap_nominee_ins_id,
			String fap_nominee_ins_dt, String fap_nominee_udt_id, String fap_nominee_udt_dt) {
		super();
		this.fap_nominee_seq = fap_nominee_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_comp_id = fap_comp_id;
		this.user_id = user_id;
		this.fap_nominee_enter_gb = fap_nominee_enter_gb;
		this.fap_nominee_ins_id = fap_nominee_ins_id;
		this.fap_nominee_ins_dt = fap_nominee_ins_dt;
		this.fap_nominee_udt_id = fap_nominee_udt_id;
		this.fap_nominee_udt_dt = fap_nominee_udt_dt;
	}


	public long getFap_nominee_seq() {
		return fap_nominee_seq;
	}


	public void setFap_nominee_seq(long fap_nominee_seq) {
		this.fap_nominee_seq = fap_nominee_seq;
	}


	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}


	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}


	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}


	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}


	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}


	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}


	public String getFap_comp_id() {
		return fap_comp_id;
	}


	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getFap_nominee_enter_gb() {
		return fap_nominee_enter_gb;
	}


	public void setFap_nominee_enter_gb(String fap_nominee_enter_gb) {
		this.fap_nominee_enter_gb = fap_nominee_enter_gb;
	}


	public String getFap_nominee_ins_id() {
		return fap_nominee_ins_id;
	}


	public void setFap_nominee_ins_id(String fap_nominee_ins_id) {
		this.fap_nominee_ins_id = fap_nominee_ins_id;
	}


	public String getFap_nominee_ins_dt() {
		return fap_nominee_ins_dt;
	}


	public void setFap_nominee_ins_dt(String fap_nominee_ins_dt) {
		this.fap_nominee_ins_dt = fap_nominee_ins_dt;
	}


	public String getFap_nominee_udt_id() {
		return fap_nominee_udt_id;
	}


	public void setFap_nominee_udt_id(String fap_nominee_udt_id) {
		this.fap_nominee_udt_id = fap_nominee_udt_id;
	}


	public String getFap_nominee_udt_dt() {
		return fap_nominee_udt_dt;
	}


	public void setFap_nominee_udt_dt(String fap_nominee_udt_dt) {
		this.fap_nominee_udt_dt = fap_nominee_udt_dt;
	}


	@Override
	public String toString() {
		return "SocietyFapNominee [fap_nominee_seq=" + fap_nominee_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_jobfair_seq=" + fap_jobfair_seq + ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq
				+ ", fap_comp_id=" + fap_comp_id + ", user_id=" + user_id + ", fap_nominee_enter_gb="
				+ fap_nominee_enter_gb + ", fap_nominee_ins_id=" + fap_nominee_ins_id + ", fap_nominee_ins_dt="
				+ fap_nominee_ins_dt + ", fap_nominee_udt_id=" + fap_nominee_udt_id + ", fap_nominee_udt_dt="
				+ fap_nominee_udt_dt + "]";
	}

	
	
}
