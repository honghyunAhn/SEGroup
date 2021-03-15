/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : 채용공고 급여정보
 * 
 */
public class SocietyFapJobPay {
	/**
	 * 급여정보 시퀀스
	 */
	private long fap_job_pay_seq;
	
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 급여구분(공통코드)
	 */
	private String fap_job_pay_gb;
	
	/**
	 * 급여
	 */
	private int fap_job_pay_info;
	
	/**
	 * 급여내용설명
	 */
	private String fap_job_pay_dtl;
	
	/**
	 * 등록자
	 */
	private String fap_job_pay_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_pay_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_udt_dt;

	/**
	 * 채용공고 급여정보 리스트
	 */
	private List<SocietyFapJobPay> jobPayList;

	/**
	 * 기본급 정보
	 */
	private SocietyFapJobPayBase jobPayBase;
	
	/**
	 * 미나시잔업수당 정보
	 */
	private SocietyFapJobPayExtra jobPayExtra;
	
	public SocietyFapJobPay() {
		super();
	}

	public SocietyFapJobPay(long fap_job_pay_seq, long fap_job_ad_seq, String fap_job_pay_gb, int fap_job_pay_info,
			String fap_job_pay_dtl, String fap_job_pay_ins_id, String fap_job_pay_ins_dt, String fap_job_pay_udt_id,
			String fap_job_pay_udt_dt, List<SocietyFapJobPay> jobPayList, SocietyFapJobPayBase jobPayBase,
			SocietyFapJobPayExtra jobPayExtra) {
		super();
		this.fap_job_pay_seq = fap_job_pay_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_job_pay_gb = fap_job_pay_gb;
		this.fap_job_pay_info = fap_job_pay_info;
		this.fap_job_pay_dtl = fap_job_pay_dtl;
		this.fap_job_pay_ins_id = fap_job_pay_ins_id;
		this.fap_job_pay_ins_dt = fap_job_pay_ins_dt;
		this.fap_job_pay_udt_id = fap_job_pay_udt_id;
		this.fap_job_pay_udt_dt = fap_job_pay_udt_dt;
		this.jobPayList = jobPayList;
		this.jobPayBase = jobPayBase;
		this.jobPayExtra = jobPayExtra;
		
	}
	
	public long getFap_job_pay_seq() {
		return fap_job_pay_seq;
	}

	public void setFap_job_pay_seq(long fap_job_pay_seq) {
		this.fap_job_pay_seq = fap_job_pay_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_job_pay_gb() {
		return fap_job_pay_gb;
	}

	public void setFap_job_pay_gb(String fap_job_pay_gb) {
		this.fap_job_pay_gb = fap_job_pay_gb;
	}

	public int getFap_job_pay_info() {
		return fap_job_pay_info;
	}

	public void setFap_job_pay_info(int fap_job_pay_info) {
		this.fap_job_pay_info = fap_job_pay_info;
	}

	public String getFap_job_pay_dtl() {
		return fap_job_pay_dtl;
	}

	public void setFap_job_pay_dtl(String fap_job_pay_dtl) {
		this.fap_job_pay_dtl = fap_job_pay_dtl;
	}

	public String getFap_job_pay_ins_id() {
		return fap_job_pay_ins_id;
	}

	public void setFap_job_pay_ins_id(String fap_job_pay_ins_id) {
		this.fap_job_pay_ins_id = fap_job_pay_ins_id;
	}

	public String getFap_job_pay_ins_dt() {
		return fap_job_pay_ins_dt;
	}

	public void setFap_job_pay_ins_dt(String fap_job_pay_ins_dt) {
		this.fap_job_pay_ins_dt = fap_job_pay_ins_dt;
	}

	public String getFap_job_pay_udt_id() {
		return fap_job_pay_udt_id;
	}

	public void setFap_job_pay_udt_id(String fap_job_pay_udt_id) {
		this.fap_job_pay_udt_id = fap_job_pay_udt_id;
	}

	public String getFap_job_pay_udt_dt() {
		return fap_job_pay_udt_dt;
	}

	public void setFap_job_pay_udt_dt(String fap_job_pay_udt_dt) {
		this.fap_job_pay_udt_dt = fap_job_pay_udt_dt;
	}

	public List<SocietyFapJobPay> getJobPayList() {
		return jobPayList;
	}

	public void setJobPayList(List<SocietyFapJobPay> jobPayList) {
		this.jobPayList = jobPayList;
	}
	
	/**
	 * @return the jobPayBase
	 */
	public SocietyFapJobPayBase getJobPayBase() {
		return jobPayBase;
	}

	/**
	 * @param jobPayBase the jobPayBase to set
	 */
	public void setJobPayBase(SocietyFapJobPayBase jobPayBase) {
		this.jobPayBase = jobPayBase;
	}

	/**
	 * @return the jobPayExtra
	 */
	public SocietyFapJobPayExtra getJobPayExtra() {
		return jobPayExtra;
	}

	/**
	 * @param jobPayExtra the jobPayExtra to set
	 */
	public void setJobPayExtra(SocietyFapJobPayExtra jobPayExtra) {
		this.jobPayExtra = jobPayExtra;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "SocietyFapJobPay [fap_job_pay_seq=" + fap_job_pay_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_job_pay_gb=" + fap_job_pay_gb + ", fap_job_pay_info=" + fap_job_pay_info + ", fap_job_pay_dtl="
				+ fap_job_pay_dtl + ", fap_job_pay_ins_id=" + fap_job_pay_ins_id + ", fap_job_pay_ins_dt="
				+ fap_job_pay_ins_dt + ", fap_job_pay_udt_id=" + fap_job_pay_udt_id + ", fap_job_pay_udt_dt="
				+ fap_job_pay_udt_dt + ", jobPayList=" + jobPayList + ", jobPayBase=" + jobPayBase + ", jobPayExtra="
				+ jobPayExtra + "]";
	}

	
	
}
