/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2019. 2. 8.
 * @Class 설명 : 모집직종정보(기타)
 * 
 */
public class SocietyFapJobCategoryEtc {
	
	/**
	 * 모집직종(기타) 시퀀스
	 */
	private long fap_job_category_etc_seq;
	
	/**
	 * 모집직종 시퀀스
	 */
	private long fap_job_category_seq;
	
	/**
	 * 상세내용
	 */
	private String fap_job_category_etc_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_category_etc_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_category_etc_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_category_etc_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_category_etc_udt_dt;

	public SocietyFapJobCategoryEtc() {
		super();
	}

	public SocietyFapJobCategoryEtc(long fap_job_category_etc_seq, long fap_job_category_seq,
			String fap_job_category_etc_dtl, String fap_job_category_etc_ins_id, String fap_job_category_etc_ins_dt,
			String fap_job_category_etc_udt_id, String fap_job_category_etc_udt_dt) {
		super();
		this.fap_job_category_etc_seq = fap_job_category_etc_seq;
		this.fap_job_category_seq = fap_job_category_seq;
		this.fap_job_category_etc_dtl = fap_job_category_etc_dtl;
		this.fap_job_category_etc_ins_id = fap_job_category_etc_ins_id;
		this.fap_job_category_etc_ins_dt = fap_job_category_etc_ins_dt;
		this.fap_job_category_etc_udt_id = fap_job_category_etc_udt_id;
		this.fap_job_category_etc_udt_dt = fap_job_category_etc_udt_dt;
	}

	public long getFap_job_category_etc_seq() {
		return fap_job_category_etc_seq;
	}

	public void setFap_job_category_etc_seq(long fap_job_category_etc_seq) {
		this.fap_job_category_etc_seq = fap_job_category_etc_seq;
	}

	public long getFap_job_category_seq() {
		return fap_job_category_seq;
	}

	public void setFap_job_category_seq(long fap_job_category_seq) {
		this.fap_job_category_seq = fap_job_category_seq;
	}

	public String getFap_job_category_etc_dtl() {
		return fap_job_category_etc_dtl;
	}

	public void setFap_job_category_etc_dtl(String fap_job_category_etc_dtl) {
		this.fap_job_category_etc_dtl = fap_job_category_etc_dtl;
	}

	public String getFap_job_category_etc_ins_id() {
		return fap_job_category_etc_ins_id;
	}

	public void setFap_job_category_etc_ins_id(String fap_job_category_etc_ins_id) {
		this.fap_job_category_etc_ins_id = fap_job_category_etc_ins_id;
	}

	public String getFap_job_category_etc_ins_dt() {
		return fap_job_category_etc_ins_dt;
	}

	public void setFap_job_category_etc_ins_dt(String fap_job_category_etc_ins_dt) {
		this.fap_job_category_etc_ins_dt = fap_job_category_etc_ins_dt;
	}

	public String getFap_job_category_etc_udt_id() {
		return fap_job_category_etc_udt_id;
	}

	public void setFap_job_category_etc_udt_id(String fap_job_category_etc_udt_id) {
		this.fap_job_category_etc_udt_id = fap_job_category_etc_udt_id;
	}

	public String getFap_job_category_etc_udt_dt() {
		return fap_job_category_etc_udt_dt;
	}

	public void setFap_job_category_etc_udt_dt(String fap_job_category_etc_udt_dt) {
		this.fap_job_category_etc_udt_dt = fap_job_category_etc_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobCategoryEtc [fap_job_category_etc_seq=" + fap_job_category_etc_seq
				+ ", fap_job_category_seq=" + fap_job_category_seq + ", fap_job_category_etc_dtl="
				+ fap_job_category_etc_dtl + ", fap_job_category_etc_ins_id=" + fap_job_category_etc_ins_id
				+ ", fap_job_category_etc_ins_dt=" + fap_job_category_etc_ins_dt + ", fap_job_category_etc_udt_id="
				+ fap_job_category_etc_udt_id + ", fap_job_category_etc_udt_dt=" + fap_job_category_etc_udt_dt + "]";
	}

}
