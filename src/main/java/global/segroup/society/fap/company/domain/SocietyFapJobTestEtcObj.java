/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 기타전형대상자(기타) 정보 
 * 
 */
public class SocietyFapJobTestEtcObj {
	/**
	 * 기타전형대상자 시퀀스
	 */
	private long fap_job_test_etc_obj_seq;
	
	/**
	 * 기타전형정보 시퀀스
	 */
	private long fap_job_test_etc_seq;
	
	/**
	 * 상세내용
	 */
	private String fap_job_test_etc_obj_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_test_etc_obj_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_test_etc_obj_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_test_etc_obj_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_test_etc_obj_udt_dt;

	public SocietyFapJobTestEtcObj() {
		super();
	}

	public SocietyFapJobTestEtcObj(long fap_job_test_etc_obj_seq, long fap_job_test_etc_seq,
			String fap_job_test_etc_obj_dtl, String fap_job_test_etc_obj_ins_id, String fap_job_test_etc_obj_ins_dt,
			String fap_job_test_etc_obj_udt_id, String fap_job_test_etc_obj_udt_dt) {
		super();
		this.fap_job_test_etc_obj_seq = fap_job_test_etc_obj_seq;
		this.fap_job_test_etc_seq = fap_job_test_etc_seq;
		this.fap_job_test_etc_obj_dtl = fap_job_test_etc_obj_dtl;
		this.fap_job_test_etc_obj_ins_id = fap_job_test_etc_obj_ins_id;
		this.fap_job_test_etc_obj_ins_dt = fap_job_test_etc_obj_ins_dt;
		this.fap_job_test_etc_obj_udt_id = fap_job_test_etc_obj_udt_id;
		this.fap_job_test_etc_obj_udt_dt = fap_job_test_etc_obj_udt_dt;
	}

	public long getFap_job_test_etc_obj_seq() {
		return fap_job_test_etc_obj_seq;
	}

	public void setFap_job_test_etc_obj_seq(long fap_job_test_etc_obj_seq) {
		this.fap_job_test_etc_obj_seq = fap_job_test_etc_obj_seq;
	}

	public long getFap_job_test_etc_seq() {
		return fap_job_test_etc_seq;
	}

	public void setFap_job_test_etc_seq(long fap_job_test_etc_seq) {
		this.fap_job_test_etc_seq = fap_job_test_etc_seq;
	}

	public String getFap_job_test_etc_obj_dtl() {
		return fap_job_test_etc_obj_dtl;
	}

	public void setFap_job_test_etc_obj_dtl(String fap_job_test_etc_obj_dtl) {
		this.fap_job_test_etc_obj_dtl = fap_job_test_etc_obj_dtl;
	}

	public String getFap_job_test_etc_obj_ins_id() {
		return fap_job_test_etc_obj_ins_id;
	}

	public void setFap_job_test_etc_obj_ins_id(String fap_job_test_etc_obj_ins_id) {
		this.fap_job_test_etc_obj_ins_id = fap_job_test_etc_obj_ins_id;
	}

	public String getFap_job_test_etc_obj_ins_dt() {
		return fap_job_test_etc_obj_ins_dt;
	}

	public void setFap_job_test_etc_obj_ins_dt(String fap_job_test_etc_obj_ins_dt) {
		this.fap_job_test_etc_obj_ins_dt = fap_job_test_etc_obj_ins_dt;
	}

	public String getFap_job_test_etc_obj_udt_id() {
		return fap_job_test_etc_obj_udt_id;
	}

	public void setFap_job_test_etc_obj_udt_id(String fap_job_test_etc_obj_udt_id) {
		this.fap_job_test_etc_obj_udt_id = fap_job_test_etc_obj_udt_id;
	}

	public String getFap_job_test_etc_obj_udt_dt() {
		return fap_job_test_etc_obj_udt_dt;
	}

	public void setFap_job_test_etc_obj_udt_dt(String fap_job_test_etc_obj_udt_dt) {
		this.fap_job_test_etc_obj_udt_dt = fap_job_test_etc_obj_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobTestEtcObj [fap_job_test_etc_obj_seq=" + fap_job_test_etc_obj_seq
				+ ", fap_job_test_etc_seq=" + fap_job_test_etc_seq + ", fap_job_test_etc_obj_dtl="
				+ fap_job_test_etc_obj_dtl + ", fap_job_test_etc_obj_ins_id=" + fap_job_test_etc_obj_ins_id
				+ ", fap_job_test_etc_obj_ins_dt=" + fap_job_test_etc_obj_ins_dt + ", fap_job_test_etc_obj_udt_id="
				+ fap_job_test_etc_obj_udt_id + ", fap_job_test_etc_obj_udt_dt=" + fap_job_test_etc_obj_udt_dt + "]";
	}
	
}
