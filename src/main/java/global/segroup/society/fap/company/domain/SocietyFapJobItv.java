/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 21.
 * @Class 설명 : 면접전형 정보
 * 
 */
public class SocietyFapJobItv {
	/**
	 * 면접전형정보 시퀀스
	 */
	private long fap_job_itv_seq;
	
	/**
	 * 채용전형 시퀀스
	 */
	private long fap_job_recruit_pcs_seq;
	
	/**
	 * 면접전형구분(공통코드)
	 */
	private String fap_job_itv_gb;
	
	/**
	 * 대상자(공통코드)
	 */
	private String fap_job_itv_obj;
	
	/**
	 * 면접방식(공통코드)
	 */
	private String fap_job_itv_tp;
	
	/**
	 * 소요시간
	 */
	private String fap_job_itv_tm;
	
	/**
	 * Skype아이디 
	 */
	private String fap_job_itv_skype;
	
	/**
	 * 등록자
	 */
	private String fap_job_itv_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_itv_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_itv_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_itv_udt_dt;

	private SocietyFapJobItvTpEtc jobItvTpEtc;
	
	private SocietyFapJobItvObjEtc jobItvObjEtc;
	
	public SocietyFapJobItv() {
		super();
	}

	public SocietyFapJobItv(long fap_job_itv_seq, long fap_job_recruit_pcs_seq, String fap_job_itv_gb,
			String fap_job_itv_obj, String fap_job_itv_tp, String fap_job_itv_tm, String fap_job_itv_skype,
			String fap_job_itv_ins_id, String fap_job_itv_ins_dt, String fap_job_itv_udt_id, String fap_job_itv_udt_dt,
			SocietyFapJobItvTpEtc jobItvTpEtc, SocietyFapJobItvObjEtc jobItvObjEtc) {
		super();
		this.fap_job_itv_seq = fap_job_itv_seq;
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
		this.fap_job_itv_gb = fap_job_itv_gb;
		this.fap_job_itv_obj = fap_job_itv_obj;
		this.fap_job_itv_tp = fap_job_itv_tp;
		this.fap_job_itv_tm = fap_job_itv_tm;
		this.fap_job_itv_skype = fap_job_itv_skype;
		this.fap_job_itv_ins_id = fap_job_itv_ins_id;
		this.fap_job_itv_ins_dt = fap_job_itv_ins_dt;
		this.fap_job_itv_udt_id = fap_job_itv_udt_id;
		this.fap_job_itv_udt_dt = fap_job_itv_udt_dt;
		this.jobItvTpEtc = jobItvTpEtc;
		this.jobItvObjEtc = jobItvObjEtc;
	}

	public long getFap_job_itv_seq() {
		return fap_job_itv_seq;
	}

	public void setFap_job_itv_seq(long fap_job_itv_seq) {
		this.fap_job_itv_seq = fap_job_itv_seq;
	}

	public long getFap_job_recruit_pcs_seq() {
		return fap_job_recruit_pcs_seq;
	}

	public void setFap_job_recruit_pcs_seq(long fap_job_recruit_pcs_seq) {
		this.fap_job_recruit_pcs_seq = fap_job_recruit_pcs_seq;
	}

	public String getFap_job_itv_gb() {
		return fap_job_itv_gb;
	}

	public void setFap_job_itv_gb(String fap_job_itv_gb) {
		this.fap_job_itv_gb = fap_job_itv_gb;
	}

	public String getFap_job_itv_obj() {
		return fap_job_itv_obj;
	}

	public void setFap_job_itv_obj(String fap_job_itv_obj) {
		this.fap_job_itv_obj = fap_job_itv_obj;
	}

	public String getFap_job_itv_tp() {
		return fap_job_itv_tp;
	}

	public void setFap_job_itv_tp(String fap_job_itv_tp) {
		this.fap_job_itv_tp = fap_job_itv_tp;
	}

	public String getFap_job_itv_tm() {
		return fap_job_itv_tm;
	}

	public void setFap_job_itv_tm(String fap_job_itv_tm) {
		this.fap_job_itv_tm = fap_job_itv_tm;
	}

	public String getFap_job_itv_skype() {
		return fap_job_itv_skype;
	}

	public void setFap_job_itv_skype(String fap_job_itv_skype) {
		this.fap_job_itv_skype = fap_job_itv_skype;
	}

	public String getFap_job_itv_ins_id() {
		return fap_job_itv_ins_id;
	}

	public void setFap_job_itv_ins_id(String fap_job_itv_ins_id) {
		this.fap_job_itv_ins_id = fap_job_itv_ins_id;
	}

	public String getFap_job_itv_ins_dt() {
		return fap_job_itv_ins_dt;
	}

	public void setFap_job_itv_ins_dt(String fap_job_itv_ins_dt) {
		this.fap_job_itv_ins_dt = fap_job_itv_ins_dt;
	}

	public String getFap_job_itv_udt_id() {
		return fap_job_itv_udt_id;
	}

	public void setFap_job_itv_udt_id(String fap_job_itv_udt_id) {
		this.fap_job_itv_udt_id = fap_job_itv_udt_id;
	}

	public String getFap_job_itv_udt_dt() {
		return fap_job_itv_udt_dt;
	}

	public void setFap_job_itv_udt_dt(String fap_job_itv_udt_dt) {
		this.fap_job_itv_udt_dt = fap_job_itv_udt_dt;
	}

	public SocietyFapJobItvTpEtc getJobItvTpEtc() {
		return jobItvTpEtc;
	}

	public void setJobItvTpEtc(SocietyFapJobItvTpEtc jobItvTpEtc) {
		this.jobItvTpEtc = jobItvTpEtc;
	}

	public SocietyFapJobItvObjEtc getJobItvObjEtc() {
		return jobItvObjEtc;
	}

	public void setJobItvObjEtc(SocietyFapJobItvObjEtc jobItvObjEtc) {
		this.jobItvObjEtc = jobItvObjEtc;
	}

	@Override
	public String toString() {
		return "SocietyFapJobItv [fap_job_itv_seq=" + fap_job_itv_seq + ", fap_job_recruit_pcs_seq="
				+ fap_job_recruit_pcs_seq + ", fap_job_itv_gb=" + fap_job_itv_gb + ", fap_job_itv_obj="
				+ fap_job_itv_obj + ", fap_job_itv_tp=" + fap_job_itv_tp + ", fap_job_itv_tm=" + fap_job_itv_tm
				+ ", fap_job_itv_skype=" + fap_job_itv_skype + ", fap_job_itv_ins_id=" + fap_job_itv_ins_id
				+ ", fap_job_itv_ins_dt=" + fap_job_itv_ins_dt + ", fap_job_itv_udt_id=" + fap_job_itv_udt_id
				+ ", fap_job_itv_udt_dt=" + fap_job_itv_udt_dt + ", jobItvTpEtc=" + jobItvTpEtc + ", jobItvObjEtc="
				+ jobItvObjEtc + "]";
	}

}
