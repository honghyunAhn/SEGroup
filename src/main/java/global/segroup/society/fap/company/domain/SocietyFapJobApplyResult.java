/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.ArrayList;

/**
 * @Author : 신동철
 * @Date : 2019. 2. 21.
 * @Class 설명 : 전형별 지원결과 정보
 * 
 */
public class SocietyFapJobApplyResult {
	
	/**
	 * 전형별 지원 결과 일련번호
	 */
	private long fap_job_app_rt_seq;
	
	/**
	 * 정규지원 전형별 합격여부(공통코드)
	 */
	private String fap_job_app_rt_acp;
	
	/**
	 * 미스매칭 전형별 합격여부(공통코드)
	 */
	private String fap_job_app_rt_acp_miss;
	
	/**
	 * 등록자
	 */
	private String fap_job_app_rt_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_job_app_rt_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_app_rt_udt_id;
	
	/**
	 * 수정일
	 */
	private String fap_job_app_rt_udt_dt;
	
	/**
	 * 전형별 지원결과 리스트
	 */
	private ArrayList<SocietyFapJobApplyResult> fap_job_app_rt_list;

	/**
	 * 지원자 정보 리스트
	 */
	private ArrayList<SocietyFapJobApplyResult> fap_job_apply_info_list;
	
	private SocietyFapJobApplyResult jobApplyResult;
	
	public SocietyFapJobApplyResult() {
		super();
	}

	/**
	 * @Desc : 
	 * @param fap_job_app_rt_seq
	 * @param fap_job_app_rt_acp
	 * @param fap_job_app_rt_acp_miss
	 * @param fap_job_app_rt_ins_id
	 * @param fap_job_app_rt_ins_dt
	 * @param fap_job_app_rt_udt_id
	 * @param fap_job_app_rt_udt_dt
	 * @param fap_job_app_rt_list
	 * @param fap_job_apply_info_list
	 * @param jobApplyResult
	 */
	public SocietyFapJobApplyResult(long fap_job_app_rt_seq, String fap_job_app_rt_acp, String fap_job_app_rt_acp_miss,
			String fap_job_app_rt_ins_id, String fap_job_app_rt_ins_dt, String fap_job_app_rt_udt_id,
			String fap_job_app_rt_udt_dt, ArrayList<SocietyFapJobApplyResult> fap_job_app_rt_list,
			ArrayList<SocietyFapJobApplyResult> fap_job_apply_info_list, SocietyFapJobApplyResult jobApplyResult) {
		super();
		this.fap_job_app_rt_seq = fap_job_app_rt_seq;
		this.fap_job_app_rt_acp = fap_job_app_rt_acp;
		this.fap_job_app_rt_acp_miss = fap_job_app_rt_acp_miss;
		this.fap_job_app_rt_ins_id = fap_job_app_rt_ins_id;
		this.fap_job_app_rt_ins_dt = fap_job_app_rt_ins_dt;
		this.fap_job_app_rt_udt_id = fap_job_app_rt_udt_id;
		this.fap_job_app_rt_udt_dt = fap_job_app_rt_udt_dt;
		this.fap_job_app_rt_list = fap_job_app_rt_list;
		this.fap_job_apply_info_list = fap_job_apply_info_list;
		this.jobApplyResult = jobApplyResult;
	}

	public long getFap_job_app_rt_seq() {
		return fap_job_app_rt_seq;
	}

	public void setFap_job_app_rt_seq(long fap_job_app_rt_seq) {
		this.fap_job_app_rt_seq = fap_job_app_rt_seq;
	}

	public String getFap_job_app_rt_acp() {
		return fap_job_app_rt_acp;
	}

	public void setFap_job_app_rt_acp(String fap_job_app_rt_acp) {
		this.fap_job_app_rt_acp = fap_job_app_rt_acp;
	}

	public String getFap_job_app_rt_acp_miss() {
		return fap_job_app_rt_acp_miss;
	}

	public void setFap_job_app_rt_acp_miss(String fap_job_app_rt_acp_miss) {
		this.fap_job_app_rt_acp_miss = fap_job_app_rt_acp_miss;
	}

	public String getFap_job_app_rt_ins_id() {
		return fap_job_app_rt_ins_id;
	}

	public void setFap_job_app_rt_ins_id(String fap_job_app_rt_ins_id) {
		this.fap_job_app_rt_ins_id = fap_job_app_rt_ins_id;
	}

	public String getFap_job_app_rt_ins_dt() {
		return fap_job_app_rt_ins_dt;
	}

	public void setFap_job_app_rt_ins_dt(String fap_job_app_rt_ins_dt) {
		this.fap_job_app_rt_ins_dt = fap_job_app_rt_ins_dt;
	}

	public String getFap_job_app_rt_udt_id() {
		return fap_job_app_rt_udt_id;
	}

	public void setFap_job_app_rt_udt_id(String fap_job_app_rt_udt_id) {
		this.fap_job_app_rt_udt_id = fap_job_app_rt_udt_id;
	}

	public String getFap_job_app_rt_udt_dt() {
		return fap_job_app_rt_udt_dt;
	}

	public void setFap_job_app_rt_udt_dt(String fap_job_app_rt_udt_dt) {
		this.fap_job_app_rt_udt_dt = fap_job_app_rt_udt_dt;
	}

	public ArrayList<SocietyFapJobApplyResult> getFap_job_app_rt_list() {
		return fap_job_app_rt_list;
	}

	public void setFap_job_app_rt_list(ArrayList<SocietyFapJobApplyResult> fap_job_app_rt_list) {
		this.fap_job_app_rt_list = fap_job_app_rt_list;
	}

	public ArrayList<SocietyFapJobApplyResult> getFap_job_apply_info_list() {
		return fap_job_apply_info_list;
	}

	public void setFap_job_apply_info_list(ArrayList<SocietyFapJobApplyResult> fap_job_apply_info_list) {
		this.fap_job_apply_info_list = fap_job_apply_info_list;
	}

	public SocietyFapJobApplyResult getJobApplyResult() {
		return jobApplyResult;
	}

	public void setJobApplyResult(SocietyFapJobApplyResult jobApplyResult) {
		this.jobApplyResult = jobApplyResult;
	}

	@Override
	public String toString() {
		return "SocietyFapJobApplyResult [fap_job_app_rt_seq=" + fap_job_app_rt_seq + ", fap_job_app_rt_acp="
				+ fap_job_app_rt_acp + ", fap_job_app_rt_acp_miss=" + fap_job_app_rt_acp_miss
				+ ", fap_job_app_rt_ins_id=" + fap_job_app_rt_ins_id + ", fap_job_app_rt_ins_dt="
				+ fap_job_app_rt_ins_dt + ", fap_job_app_rt_udt_id=" + fap_job_app_rt_udt_id
				+ ", fap_job_app_rt_udt_dt=" + fap_job_app_rt_udt_dt + ", fap_job_app_rt_list=" + fap_job_app_rt_list
				+ ", fap_job_apply_info_list=" + fap_job_apply_info_list + ", jobApplyResult=" + jobApplyResult + "]";
	}

	
	
}
