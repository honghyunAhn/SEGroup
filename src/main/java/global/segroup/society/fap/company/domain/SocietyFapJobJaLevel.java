/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 업무에 필요한 일본어 능력
 * 
 */
public class SocietyFapJobJaLevel {
	/**
	 * 업무에 필요한 일본어 능력 시퀀스
	 */
	private long fap_job_ja_level_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * JLPT 급수 (공통코드)
	 */
	private String fap_job_ja_level_gb;
	
	/**
	 * 상세내용
	 */
	private String fap_job_ja_level_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_ja_level_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_ja_level_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_ja_level_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_ja_level_udt_dt;

	public SocietyFapJobJaLevel() {
		super();
	}

	public SocietyFapJobJaLevel(long fap_job_ja_level_seq, long fap_job_ad_seq, String fap_job_ja_level_gb,
			String fap_job_ja_level_dtl, String fap_job_ja_level_ins_id, String fap_job_ja_level_ins_dt,
			String fap_job_ja_level_udt_id, String fap_job_ja_level_udt_dt) {
		super();
		this.fap_job_ja_level_seq = fap_job_ja_level_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_ja_level_gb = fap_job_ja_level_gb;
		this.fap_job_ja_level_dtl = fap_job_ja_level_dtl;
		this.fap_job_ja_level_ins_id = fap_job_ja_level_ins_id;
		this.fap_job_ja_level_ins_dt = fap_job_ja_level_ins_dt;
		this.fap_job_ja_level_udt_id = fap_job_ja_level_udt_id;
		this.fap_job_ja_level_udt_dt = fap_job_ja_level_udt_dt;
	}

	public long getFap_job_ja_level_seq() {
		return fap_job_ja_level_seq;
	}

	public void setFap_job_ja_level_seq(long fap_job_ja_level_seq) {
		this.fap_job_ja_level_seq = fap_job_ja_level_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_ja_level_gb() {
		return fap_job_ja_level_gb;
	}

	public void setFap_job_ja_level_gb(String fap_job_ja_level_gb) {
		this.fap_job_ja_level_gb = fap_job_ja_level_gb;
	}

	public String getFap_job_ja_level_dtl() {
		return fap_job_ja_level_dtl;
	}

	public void setFap_job_ja_level_dtl(String fap_job_ja_level_dtl) {
		this.fap_job_ja_level_dtl = fap_job_ja_level_dtl;
	}

	public String getFap_job_ja_level_ins_id() {
		return fap_job_ja_level_ins_id;
	}

	public void setFap_job_ja_level_ins_id(String fap_job_ja_level_ins_id) {
		this.fap_job_ja_level_ins_id = fap_job_ja_level_ins_id;
	}

	public String getFap_job_ja_level_ins_dt() {
		return fap_job_ja_level_ins_dt;
	}

	public void setFap_job_ja_level_ins_dt(String fap_job_ja_level_ins_dt) {
		this.fap_job_ja_level_ins_dt = fap_job_ja_level_ins_dt;
	}

	public String getFap_job_ja_level_udt_id() {
		return fap_job_ja_level_udt_id;
	}

	public void setFap_job_ja_level_udt_id(String fap_job_ja_level_udt_id) {
		this.fap_job_ja_level_udt_id = fap_job_ja_level_udt_id;
	}

	public String getFap_job_ja_level_udt_dt() {
		return fap_job_ja_level_udt_dt;
	}

	public void setFap_job_ja_level_udt_dt(String fap_job_ja_level_udt_dt) {
		this.fap_job_ja_level_udt_dt = fap_job_ja_level_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobJaLevel [fap_job_ja_level_seq=" + fap_job_ja_level_seq + ", fap_job_ad_seq="
				+ fap_job_ad_seq + ", fap_job_ja_level_gb=" + fap_job_ja_level_gb + ", fap_job_ja_level_dtl="
				+ fap_job_ja_level_dtl + ", fap_job_ja_level_ins_id=" + fap_job_ja_level_ins_id
				+ ", fap_job_ja_level_ins_dt=" + fap_job_ja_level_ins_dt + ", fap_job_ja_level_udt_id="
				+ fap_job_ja_level_udt_id + ", fap_job_ja_level_udt_dt=" + fap_job_ja_level_udt_dt + "]";
	}
	
}
