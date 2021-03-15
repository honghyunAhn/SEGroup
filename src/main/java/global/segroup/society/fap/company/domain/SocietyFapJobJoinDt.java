/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 입사예정일 정보
 * 
 */
public class SocietyFapJobJoinDt {
	/**
	 * 입사예정일 정보 시퀀스
	 */
	private long fap_job_join_dt_seq;
	
	/**
	 * 채용공고정보 시퀀스
	 */
	private long fap_job_ad_seq;

	/**
	 * 입사예정일(공통코드)
	 */
	private String fap_job_join_dt_gb;
	
	/**
	 * 상세내용
	 */
	private String fap_job_join_dt_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_join_dt_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_join_dt_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_join_dt_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_join_dt_udt_dt;
	
	private List<SocietyFapJobJoinDt> jobJoinDtList;

	public SocietyFapJobJoinDt() {
		super();
	}

	public SocietyFapJobJoinDt(long fap_job_join_dt_seq, long fap_job_ad_seq, String fap_job_join_dt_gb,
			String fap_job_join_dt_dtl, String fap_job_join_dt_ins_id, String fap_job_join_dt_ins_dt,
			String fap_job_join_dt_udt_id, String fap_job_join_dt_udt_dt, List<SocietyFapJobJoinDt> jobJoinDtList) {
		super();
		this.fap_job_join_dt_seq = fap_job_join_dt_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_join_dt_gb = fap_job_join_dt_gb;
		this.fap_job_join_dt_dtl = fap_job_join_dt_dtl;
		this.fap_job_join_dt_ins_id = fap_job_join_dt_ins_id;
		this.fap_job_join_dt_ins_dt = fap_job_join_dt_ins_dt;
		this.fap_job_join_dt_udt_id = fap_job_join_dt_udt_id;
		this.fap_job_join_dt_udt_dt = fap_job_join_dt_udt_dt;
		this.jobJoinDtList = jobJoinDtList;
	}

	public long getFap_job_join_dt_seq() {
		return fap_job_join_dt_seq;
	}

	public void setFap_job_join_dt_seq(long fap_job_join_dt_seq) {
		this.fap_job_join_dt_seq = fap_job_join_dt_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_join_dt_gb() {
		return fap_job_join_dt_gb;
	}

	public void setFap_job_join_dt_gb(String fap_job_join_dt_gb) {
		this.fap_job_join_dt_gb = fap_job_join_dt_gb;
	}

	public String getFap_job_join_dt_dtl() {
		return fap_job_join_dt_dtl;
	}

	public void setFap_job_join_dt_dtl(String fap_job_join_dt_dtl) {
		this.fap_job_join_dt_dtl = fap_job_join_dt_dtl;
	}

	public String getFap_job_join_dt_ins_id() {
		return fap_job_join_dt_ins_id;
	}

	public void setFap_job_join_dt_ins_id(String fap_job_join_dt_ins_id) {
		this.fap_job_join_dt_ins_id = fap_job_join_dt_ins_id;
	}

	public String getFap_job_join_dt_ins_dt() {
		return fap_job_join_dt_ins_dt;
	}

	public void setFap_job_join_dt_ins_dt(String fap_job_join_dt_ins_dt) {
		this.fap_job_join_dt_ins_dt = fap_job_join_dt_ins_dt;
	}

	public String getFap_job_join_dt_udt_id() {
		return fap_job_join_dt_udt_id;
	}

	public void setFap_job_join_dt_udt_id(String fap_job_join_dt_udt_id) {
		this.fap_job_join_dt_udt_id = fap_job_join_dt_udt_id;
	}

	public String getFap_job_join_dt_udt_dt() {
		return fap_job_join_dt_udt_dt;
	}

	public void setFap_job_join_dt_udt_dt(String fap_job_join_dt_udt_dt) {
		this.fap_job_join_dt_udt_dt = fap_job_join_dt_udt_dt;
	}

	public List<SocietyFapJobJoinDt> getJobJoinDtList() {
		return jobJoinDtList;
	}

	public void setJobJoinDtList(List<SocietyFapJobJoinDt> jobJoinDtList) {
		this.jobJoinDtList = jobJoinDtList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobJoinDt [fap_job_join_dt_seq=" + fap_job_join_dt_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_join_dt_gb=" + fap_job_join_dt_gb + ", fap_job_join_dt_dtl=" + fap_job_join_dt_dtl
				+ ", fap_job_join_dt_ins_id=" + fap_job_join_dt_ins_id + ", fap_job_join_dt_ins_dt="
				+ fap_job_join_dt_ins_dt + ", fap_job_join_dt_udt_id=" + fap_job_join_dt_udt_id
				+ ", fap_job_join_dt_udt_dt=" + fap_job_join_dt_udt_dt + ", jobJoinDtList=" + jobJoinDtList + "]";
	}

}
