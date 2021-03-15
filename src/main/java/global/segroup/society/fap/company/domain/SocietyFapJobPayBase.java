/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : 채용공고 기본급정보
 * 
 */
public class SocietyFapJobPayBase {
	/**
	 * 기본급 시퀀스
	 */
	private long fap_job_pay_base_seq;
	
	/**
	 * 급여정보 시퀀스
	 */
	private long fap_job_pay_seq;
	
	/**
	 * 기본급 구분(공통코드)
	 */
	private String fap_job_pay_base_gb;
	
	/**
	 * 급여(액수)
	 */
	private int fap_job_pay_base_info;
	
	/**
	 * 등록자
	 */
	private String fap_job_pay_base_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_base_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_pay_base_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_base_udt_dt;
	
	/**
	 * 기본급 리스트
	 */
	private List<SocietyFapJobPayBase> jobPayBaseList;

	private SocietyFapJobServiceWork jobServiceWork;
	
	private SocietyFapJobPayEtc jobPayEtc;
	
	public SocietyFapJobPayBase() {
		super();
	}

	public SocietyFapJobPayBase(long fap_job_pay_base_seq, long fap_job_pay_seq, String fap_job_pay_base_gb,
			int fap_job_pay_base_info, String fap_job_pay_base_ins_id, String fap_job_pay_base_ins_dt,
			String fap_job_pay_base_udt_id, String fap_job_pay_base_udt_dt, List<SocietyFapJobPayBase> jobPayBaseList,
			SocietyFapJobServiceWork jobServiceWork, SocietyFapJobPayEtc jobPayEtc) {
		super();
		this.fap_job_pay_base_seq = fap_job_pay_base_seq;
		this.fap_job_pay_seq = fap_job_pay_seq;
		this.fap_job_pay_base_gb = fap_job_pay_base_gb;
		this.fap_job_pay_base_info = fap_job_pay_base_info;
		this.fap_job_pay_base_ins_id = fap_job_pay_base_ins_id;
		this.fap_job_pay_base_ins_dt = fap_job_pay_base_ins_dt;
		this.fap_job_pay_base_udt_id = fap_job_pay_base_udt_id;
		this.fap_job_pay_base_udt_dt = fap_job_pay_base_udt_dt;
		this.jobPayBaseList = jobPayBaseList;
		this.jobServiceWork = jobServiceWork;
		this.jobPayEtc = jobPayEtc;
	}

	public long getFap_job_pay_base_seq() {
		return fap_job_pay_base_seq;
	}

	public void setFap_job_pay_base_seq(long fap_job_pay_base_seq) {
		this.fap_job_pay_base_seq = fap_job_pay_base_seq;
	}

	public long getFap_job_pay_seq() {
		return fap_job_pay_seq;
	}

	public void setFap_job_pay_seq(long fap_job_pay_seq) {
		this.fap_job_pay_seq = fap_job_pay_seq;
	}

	public String getFap_job_pay_base_gb() {
		return fap_job_pay_base_gb;
	}

	public void setFap_job_pay_base_gb(String fap_job_pay_base_gb) {
		this.fap_job_pay_base_gb = fap_job_pay_base_gb;
	}

	public int getFap_job_pay_base_info() {
		return fap_job_pay_base_info;
	}

	public void setFap_job_pay_base_info(int fap_job_pay_base_info) {
		this.fap_job_pay_base_info = fap_job_pay_base_info;
	}

	public String getFap_job_pay_base_ins_id() {
		return fap_job_pay_base_ins_id;
	}

	public void setFap_job_pay_base_ins_id(String fap_job_pay_base_ins_id) {
		this.fap_job_pay_base_ins_id = fap_job_pay_base_ins_id;
	}

	public String getFap_job_pay_base_ins_dt() {
		return fap_job_pay_base_ins_dt;
	}

	public void setFap_job_pay_base_ins_dt(String fap_job_pay_base_ins_dt) {
		this.fap_job_pay_base_ins_dt = fap_job_pay_base_ins_dt;
	}

	public String getFap_job_pay_base_udt_id() {
		return fap_job_pay_base_udt_id;
	}

	public void setFap_job_pay_base_udt_id(String fap_job_pay_base_udt_id) {
		this.fap_job_pay_base_udt_id = fap_job_pay_base_udt_id;
	}

	public String getFap_job_pay_base_udt_dt() {
		return fap_job_pay_base_udt_dt;
	}

	public void setFap_job_pay_base_udt_dt(String fap_job_pay_base_udt_dt) {
		this.fap_job_pay_base_udt_dt = fap_job_pay_base_udt_dt;
	}

	public List<SocietyFapJobPayBase> getJobPayBaseList() {
		return jobPayBaseList;
	}

	public void setJobPayBaseList(List<SocietyFapJobPayBase> jobPayBaseList) {
		this.jobPayBaseList = jobPayBaseList;
	}

	public SocietyFapJobServiceWork getJobServiceWork() {
		return jobServiceWork;
	}

	public void setJobServiceWork(SocietyFapJobServiceWork jobServiceWork) {
		this.jobServiceWork = jobServiceWork;
	}

	public SocietyFapJobPayEtc getJobPayEtc() {
		return jobPayEtc;
	}

	public void setJobPayEtc(SocietyFapJobPayEtc jobPayEtc) {
		this.jobPayEtc = jobPayEtc;
	}

	@Override
	public String toString() {
		return "SocietyFapJobPayBase [fap_job_pay_base_seq=" + fap_job_pay_base_seq + ", fap_job_pay_seq="
				+ fap_job_pay_seq + ", fap_job_pay_base_gb=" + fap_job_pay_base_gb + ", fap_job_pay_base_info="
				+ fap_job_pay_base_info + ", fap_job_pay_base_ins_id=" + fap_job_pay_base_ins_id
				+ ", fap_job_pay_base_ins_dt=" + fap_job_pay_base_ins_dt + ", fap_job_pay_base_udt_id="
				+ fap_job_pay_base_udt_id + ", fap_job_pay_base_udt_dt=" + fap_job_pay_base_udt_dt + ", jobPayBaseList="
				+ jobPayBaseList + ", jobServiceWork=" + jobServiceWork + ", jobPayEtc=" + jobPayEtc + "]";
	}

	
	
}
