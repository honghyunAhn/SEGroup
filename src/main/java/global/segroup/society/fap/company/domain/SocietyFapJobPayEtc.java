/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.List;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 채용공고 기타수당정보
 * 
 */
public class SocietyFapJobPayEtc {
	/**
	 * 기타수당 시퀀스
	 */
	private long fap_job_pay_etc_seq;
	
	/**
	 * 기본급 시퀀스
	 */
	private long fap_job_pay_base_seq;
	
	/**
	 * 수당이름
	 */
	private String fap_job_pay_etc_nm;
	
	/**
	 * 금액
	 */
	private int fap_job_pay_etc_info;
	
	/**
	 * 등록자
	 */
	private String fap_job_pay_etc_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_etc_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_pay_etc_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_pay_etc_udt_dt;
	
	/**
	 * 
	 */
	private List<SocietyFapJobPayEtc> jobPayEtcList;

	public SocietyFapJobPayEtc() {
		super();
	}

	public SocietyFapJobPayEtc(long fap_job_pay_etc_seq, long fap_job_pay_base_seq, String fap_job_pay_etc_nm,
			int fap_job_pay_etc_info, String fap_job_pay_etc_ins_id, String fap_job_pay_etc_ins_dt,
			String fap_job_pay_etc_udt_id, String fap_job_pay_etc_udt_dt, List<SocietyFapJobPayEtc> jobPayEtcList) {
		super();
		this.fap_job_pay_etc_seq = fap_job_pay_etc_seq;
		this.fap_job_pay_base_seq = fap_job_pay_base_seq;
		this.fap_job_pay_etc_nm = fap_job_pay_etc_nm;
		this.fap_job_pay_etc_info = fap_job_pay_etc_info;
		this.fap_job_pay_etc_ins_id = fap_job_pay_etc_ins_id;
		this.fap_job_pay_etc_ins_dt = fap_job_pay_etc_ins_dt;
		this.fap_job_pay_etc_udt_id = fap_job_pay_etc_udt_id;
		this.fap_job_pay_etc_udt_dt = fap_job_pay_etc_udt_dt;
		this.jobPayEtcList = jobPayEtcList;
	}

	public long getFap_job_pay_etc_seq() {
		return fap_job_pay_etc_seq;
	}

	public void setFap_job_pay_etc_seq(long fap_job_pay_etc_seq) {
		this.fap_job_pay_etc_seq = fap_job_pay_etc_seq;
	}

	public long getFap_job_pay_base_seq() {
		return fap_job_pay_base_seq;
	}

	public void setFap_job_pay_base_seq(long fap_job_pay_base_seq) {
		this.fap_job_pay_base_seq = fap_job_pay_base_seq;
	}

	public String getFap_job_pay_etc_nm() {
		return fap_job_pay_etc_nm;
	}

	public void setFap_job_pay_etc_nm(String fap_job_pay_etc_nm) {
		this.fap_job_pay_etc_nm = fap_job_pay_etc_nm;
	}

	public int getFap_job_pay_etc_info() {
		return fap_job_pay_etc_info;
	}

	public void setFap_job_pay_etc_info(int fap_job_pay_etc_info) {
		this.fap_job_pay_etc_info = fap_job_pay_etc_info;
	}

	public String getFap_job_pay_etc_ins_id() {
		return fap_job_pay_etc_ins_id;
	}

	public void setFap_job_pay_etc_ins_id(String fap_job_pay_etc_ins_id) {
		this.fap_job_pay_etc_ins_id = fap_job_pay_etc_ins_id;
	}

	public String getFap_job_pay_etc_ins_dt() {
		return fap_job_pay_etc_ins_dt;
	}

	public void setFap_job_pay_etc_ins_dt(String fap_job_pay_etc_ins_dt) {
		this.fap_job_pay_etc_ins_dt = fap_job_pay_etc_ins_dt;
	}

	public String getFap_job_pay_etc_udt_id() {
		return fap_job_pay_etc_udt_id;
	}

	public void setFap_job_pay_etc_udt_id(String fap_job_pay_etc_udt_id) {
		this.fap_job_pay_etc_udt_id = fap_job_pay_etc_udt_id;
	}

	public String getFap_job_pay_etc_udt_dt() {
		return fap_job_pay_etc_udt_dt;
	}

	public void setFap_job_pay_etc_udt_dt(String fap_job_pay_etc_udt_dt) {
		this.fap_job_pay_etc_udt_dt = fap_job_pay_etc_udt_dt;
	}

	public List<SocietyFapJobPayEtc> getJobPayEtcList() {
		return jobPayEtcList;
	}

	public void setJobPayEtcList(List<SocietyFapJobPayEtc> jobPayEtcList) {
		this.jobPayEtcList = jobPayEtcList;
	}

	@Override
	public String toString() {
		return "SocietyFapJobPayEtc [fap_job_pay_etc_seq=" + fap_job_pay_etc_seq + ", fap_job_pay_base_seq="
				+ fap_job_pay_base_seq + ", fap_job_pay_etc_nm=" + fap_job_pay_etc_nm + ", fap_job_pay_etc_info="
				+ fap_job_pay_etc_info + ", fap_job_pay_etc_ins_id=" + fap_job_pay_etc_ins_id
				+ ", fap_job_pay_etc_ins_dt=" + fap_job_pay_etc_ins_dt + ", fap_job_pay_etc_udt_id="
				+ fap_job_pay_etc_udt_id + ", fap_job_pay_etc_udt_dt=" + fap_job_pay_etc_udt_dt + ", jobPayEtcList="
				+ jobPayEtcList + "]";
	}
	
}
