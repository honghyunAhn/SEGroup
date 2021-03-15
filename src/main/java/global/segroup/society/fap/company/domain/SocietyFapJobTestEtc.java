/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 기타전형정보
 * 
 */
public class SocietyFapJobTestEtc {
	/**
	 * 기타전형정보 시퀀스
	 */
	private long fap_job_test_etc_seq;
	
	/**
	 * 채용전형정보 시퀀스
	 */
	private long fap_job_recruit_pcs_seq;
	
	/**
	 * 대상자(공통코드)
	 */
	private String fap_job_test_etc_obj;
	
	/**
	 * 상세내용
	 */
	private String fap_job_test_etc_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_test_etc_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_test_etc_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_test_etc_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_test_etc_udt_dt;

	private SocietyFapJobTestEtcObj jobTestEtcObj;
	
	public SocietyFapJobTestEtc() {
		super();
	}

	public SocietyFapJobTestEtc(long fap_job_test_etc_seq, long fap_job_recruit_pcs_seq, String fap_job_test_etc_obj,
			String fap_job_test_etc_dtl, String fap_job_test_etc_ins_id, String fap_job_test_etc_ins_dt,
			String fap_job_test_etc_udt_id, String fap_job_test_etc_udt_dt, SocietyFapJobTestEtcObj jobTestEtcObj) {
		super();
		this.fap_job_test_etc_seq = fap_job_test_etc_seq;
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
		this.fap_job_test_etc_obj = fap_job_test_etc_obj;
		this.fap_job_test_etc_dtl = fap_job_test_etc_dtl;
		this.fap_job_test_etc_ins_id = fap_job_test_etc_ins_id;
		this.fap_job_test_etc_ins_dt = fap_job_test_etc_ins_dt;
		this.fap_job_test_etc_udt_id = fap_job_test_etc_udt_id;
		this.fap_job_test_etc_udt_dt = fap_job_test_etc_udt_dt;
		this.jobTestEtcObj = jobTestEtcObj;
	}

	public long getFap_job_test_etc_seq() {
		return fap_job_test_etc_seq;
	}

	public void setFap_job_test_etc_seq(long fap_job_test_etc_seq) {
		this.fap_job_test_etc_seq = fap_job_test_etc_seq;
	}

	public long getFap_job_recruit_pcs_seq() {
		return fap_job_recruit_pcs_seq;
	}

	public void setFap_job_recruit_pcs_seq(long fap_job_recruit_pcs_seq) {
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
	}

	public String getFap_job_test_etc_obj() {
		return fap_job_test_etc_obj;
	}

	public void setFap_job_test_etc_obj(String fap_job_test_etc_obj) {
		this.fap_job_test_etc_obj = fap_job_test_etc_obj;
	}

	public String getFap_job_test_etc_dtl() {
		return fap_job_test_etc_dtl;
	}

	public void setFap_job_test_etc_dtl(String fap_job_test_etc_dtl) {
		this.fap_job_test_etc_dtl = fap_job_test_etc_dtl;
	}

	public String getFap_job_test_etc_ins_id() {
		return fap_job_test_etc_ins_id;
	}

	public void setFap_job_test_etc_ins_id(String fap_job_test_etc_ins_id) {
		this.fap_job_test_etc_ins_id = fap_job_test_etc_ins_id;
	}

	public String getFap_job_test_etc_ins_dt() {
		return fap_job_test_etc_ins_dt;
	}

	public void setFap_job_test_etc_ins_dt(String fap_job_test_etc_ins_dt) {
		this.fap_job_test_etc_ins_dt = fap_job_test_etc_ins_dt;
	}

	public String getFap_job_test_etc_udt_id() {
		return fap_job_test_etc_udt_id;
	}

	public void setFap_job_test_etc_udt_id(String fap_job_test_etc_udt_id) {
		this.fap_job_test_etc_udt_id = fap_job_test_etc_udt_id;
	}

	public String getFap_job_test_etc_udt_dt() {
		return fap_job_test_etc_udt_dt;
	}

	public void setFap_job_test_etc_udt_dt(String fap_job_test_etc_udt_dt) {
		this.fap_job_test_etc_udt_dt = fap_job_test_etc_udt_dt;
	}

	public SocietyFapJobTestEtcObj getJobTestEtcObj() {
		return jobTestEtcObj;
	}

	public void setJobTestEtcObj(SocietyFapJobTestEtcObj jobTestEtcObj) {
		this.jobTestEtcObj = jobTestEtcObj;
	}

	@Override
	public String toString() {
		return "SocietyFapJobTestEtc [fap_job_test_etc_seq=" + fap_job_test_etc_seq + ", fap_job_recruit_pcs_seq="
				+ fap_job_recruit_pcs_seq + ", fap_job_test_etc_obj=" + fap_job_test_etc_obj + ", fap_job_test_etc_dtl="
				+ fap_job_test_etc_dtl + ", fap_job_test_etc_ins_id=" + fap_job_test_etc_ins_id
				+ ", fap_job_test_etc_ins_dt=" + fap_job_test_etc_ins_dt + ", fap_job_test_etc_udt_id="
				+ fap_job_test_etc_udt_id + ", fap_job_test_etc_udt_dt=" + fap_job_test_etc_udt_dt + ", jobTestEtcObj="
				+ jobTestEtcObj + "]";
	}

}
