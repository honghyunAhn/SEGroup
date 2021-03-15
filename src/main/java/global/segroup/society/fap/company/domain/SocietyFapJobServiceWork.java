/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이재준
 * @Date : 2018. 12. 20.
 * @Class 설명 : 채용공고 서비스 잔업수당정보
 * 
 */
public class SocietyFapJobServiceWork {
	/**
	 * 서비스 잔업수당 시퀀스
	 */
	private long fap_job_service_work_seq;
	
	/**
	 * 기본급 시퀀스
	 */
	private long fap_job_pay_base_seq;
	
	/**
	 * 금액
	 */
	//private int fap_job_service_work_info;
	
	/**
	 * 시간
	 */
	private String fap_job_service_work_tm;
	
	/**
	 * 등록자
	 */
	private String fap_job_service_work_ins_id;
	
	/**
	 * 등록일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_service_work_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_service_work_udt_id;
	
	/**
	 * 수정일(yyyyMMdd24hhmiss)
	 */
	private String fap_job_service_work_udt_dt;

	public SocietyFapJobServiceWork() {
		super();
	}

	public SocietyFapJobServiceWork(long fap_job_service_work_seq, long fap_job_pay_base_seq,
			int fap_job_service_work_info, String fap_job_service_work_tm, String fap_job_service_work_ins_id,
			String fap_job_service_work_ins_dt, String fap_job_service_work_udt_id,
			String fap_job_service_work_udt_dt) {
		super();
		this.fap_job_service_work_seq = fap_job_service_work_seq;
		this.fap_job_pay_base_seq = fap_job_pay_base_seq;
		//this.fap_job_service_work_info = fap_job_service_work_info;
		this.fap_job_service_work_tm = fap_job_service_work_tm;
		this.fap_job_service_work_ins_id = fap_job_service_work_ins_id;
		this.fap_job_service_work_ins_dt = fap_job_service_work_ins_dt;
		this.fap_job_service_work_udt_id = fap_job_service_work_udt_id;
		this.fap_job_service_work_udt_dt = fap_job_service_work_udt_dt;
	}

	public long getFap_job_service_work_seq() {
		return fap_job_service_work_seq;
	}

	public void setFap_job_service_work_seq(long fap_job_service_work_seq) {
		this.fap_job_service_work_seq = fap_job_service_work_seq;
	}

	public long getFap_job_pay_base_seq() {
		return fap_job_pay_base_seq;
	}

	public void setFap_job_pay_base_seq(long fap_job_pay_base_seq) {
		this.fap_job_pay_base_seq = fap_job_pay_base_seq;
	}

	/*public int getFap_job_service_work_info() {
		return fap_job_service_work_info;
	}

	public void setFap_job_service_work_info(int fap_job_service_work_info) {
		this.fap_job_service_work_info = fap_job_service_work_info;
	}*/

	public String getFap_job_service_work_tm() {
		return fap_job_service_work_tm;
	}

	public void setFap_job_service_work_tm(String fap_job_service_work_tm) {
		this.fap_job_service_work_tm = fap_job_service_work_tm;
	}

	public String getFap_job_service_work_ins_id() {
		return fap_job_service_work_ins_id;
	}

	public void setFap_job_service_work_ins_id(String fap_job_service_work_ins_id) {
		this.fap_job_service_work_ins_id = fap_job_service_work_ins_id;
	}

	public String getFap_job_service_work_ins_dt() {
		return fap_job_service_work_ins_dt;
	}

	public void setFap_job_service_work_ins_dt(String fap_job_service_work_ins_dt) {
		this.fap_job_service_work_ins_dt = fap_job_service_work_ins_dt;
	}

	public String getFap_job_service_work_udt_id() {
		return fap_job_service_work_udt_id;
	}

	public void setFap_job_service_work_udt_id(String fap_job_service_work_udt_id) {
		this.fap_job_service_work_udt_id = fap_job_service_work_udt_id;
	}

	public String getFap_job_service_work_udt_dt() {
		return fap_job_service_work_udt_dt;
	}

	public void setFap_job_service_work_udt_dt(String fap_job_service_work_udt_dt) {
		this.fap_job_service_work_udt_dt = fap_job_service_work_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobServiceWork [fap_job_service_work_seq=" + fap_job_service_work_seq
				+ ", fap_job_pay_base_seq=" + fap_job_pay_base_seq + ", fap_job_service_work_tm=" + fap_job_service_work_tm
				+ ", fap_job_service_work_ins_id=" + fap_job_service_work_ins_id + ", fap_job_service_work_ins_dt="
				+ fap_job_service_work_ins_dt + ", fap_job_service_work_udt_id=" + fap_job_service_work_udt_id
				+ ", fap_job_service_work_udt_dt=" + fap_job_service_work_udt_dt + "]";
	}
	
}
