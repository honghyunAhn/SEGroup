/**
 * 
 */
package global.segroup.society.fap.company.domain;

import java.util.ArrayList;

/**
 * @Author : 신동철
 * @Date : 2019. 2. 21.
 * @Class 설명 : 최종결과 정보
 * 
 */
public class SocietyFapJobApplyFinalResult {
	
	/**
	 * 최종결과 일련번호
	 */
	private long fap_job_app_final_rt_seq;
	
	/**
	 * 정규지원 최종 합격여부(공통코드 - 기업용)
	 */
	private String fap_job_app_final_rt_acp;

	/**
	 * 정규지원 최종 합격여부(공통코드 - 지원자용)
	 */
	private String fap_job_app_final_rt_acp_user;
	
	/**
	 * 미스매칭 최종 합격여부(공통코드)
	 */
	private String fap_job_app_final_rt_acp_miss;
	
	/**
	 * 예비합격순위(기업용)
	 */
	private String fap_job_app_standby_rank;
	
	/**
	 * 예비합격순위(지원자용)
	 */
	private String fap_job_app_standby_rank_user;
	
	/**
	 * 합격회사 선택여부(공통코드)
	 */
	private String fap_job_app_choice_comp_gb;
	
	/**
	 * 관리자 승인여부(공통코드)
	 */
	private String fap_job_app_approval_gb;
	
	/**
	 * 등록자
	 */
	private String fap_job_app_final_rt_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_job_app_final_rt_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_job_app_final_rt_udt_id;
	
	/**
	 * 수정일
	 */
	private String fap_job_app_final_rt_udt_dt;

	/**
	 * 합격사유
	 */
	private String fap_job_app_pass_comment;
	
	/**
	 * 채용공고일련번호
	 */
	private long fap_job_ad_seq;
	
	/**
	 * 회사 아이디
	 */
	private String fap_comp_id;
	
	/**
	 * 지원자 아이디
	 */
	private String user_id;
	
	/**
	 * 확정버튼 노출 여부
	 * */
	private String fap_job_app_final_btn_gb;
	
	/**
	 * 지원자 리스트
	 */
	private ArrayList<SocietyFapJobApplyFinalResult> fap_job_apply_info_list;
	
	
	public SocietyFapJobApplyFinalResult() {
		super();
	}


	public SocietyFapJobApplyFinalResult(long fap_job_app_final_rt_seq, String fap_job_app_final_rt_acp,
			String fap_job_app_final_rt_acp_user, String fap_job_app_final_rt_acp_miss, String fap_job_app_standby_rank,
			String fap_job_app_standby_rank_user, String fap_job_app_choice_comp_gb, String fap_job_app_approval_gb,
			String fap_job_app_final_rt_ins_id, String fap_job_app_final_rt_ins_dt, String fap_job_app_final_rt_udt_id,
			String fap_job_app_final_rt_udt_dt, String fap_job_app_pass_comment, long fap_job_ad_seq,
			String fap_comp_id, String user_id, String fap_job_app_final_btn_gb,
			ArrayList<SocietyFapJobApplyFinalResult> fap_job_apply_info_list) {
		super();
		this.fap_job_app_final_rt_seq = fap_job_app_final_rt_seq;
		this.fap_job_app_final_rt_acp = fap_job_app_final_rt_acp;
		this.fap_job_app_final_rt_acp_user = fap_job_app_final_rt_acp_user;
		this.fap_job_app_final_rt_acp_miss = fap_job_app_final_rt_acp_miss;
		this.fap_job_app_standby_rank = fap_job_app_standby_rank;
		this.fap_job_app_standby_rank_user = fap_job_app_standby_rank_user;
		this.fap_job_app_choice_comp_gb = fap_job_app_choice_comp_gb;
		this.fap_job_app_approval_gb = fap_job_app_approval_gb;
		this.fap_job_app_final_rt_ins_id = fap_job_app_final_rt_ins_id;
		this.fap_job_app_final_rt_ins_dt = fap_job_app_final_rt_ins_dt;
		this.fap_job_app_final_rt_udt_id = fap_job_app_final_rt_udt_id;
		this.fap_job_app_final_rt_udt_dt = fap_job_app_final_rt_udt_dt;
		this.fap_job_app_pass_comment = fap_job_app_pass_comment;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_comp_id = fap_comp_id;
		this.user_id = user_id;
		this.fap_job_app_final_btn_gb = fap_job_app_final_btn_gb;
		this.fap_job_apply_info_list = fap_job_apply_info_list;
	}


	public long getFap_job_app_final_rt_seq() {
		return fap_job_app_final_rt_seq;
	}


	public void setFap_job_app_final_rt_seq(long fap_job_app_final_rt_seq) {
		this.fap_job_app_final_rt_seq = fap_job_app_final_rt_seq;
	}


	public String getFap_job_app_final_rt_acp() {
		return fap_job_app_final_rt_acp;
	}


	public void setFap_job_app_final_rt_acp(String fap_job_app_final_rt_acp) {
		this.fap_job_app_final_rt_acp = fap_job_app_final_rt_acp;
	}


	public String getFap_job_app_final_rt_acp_user() {
		return fap_job_app_final_rt_acp_user;
	}


	public void setFap_job_app_final_rt_acp_user(String fap_job_app_final_rt_acp_user) {
		this.fap_job_app_final_rt_acp_user = fap_job_app_final_rt_acp_user;
	}


	public String getFap_job_app_final_rt_acp_miss() {
		return fap_job_app_final_rt_acp_miss;
	}


	public void setFap_job_app_final_rt_acp_miss(String fap_job_app_final_rt_acp_miss) {
		this.fap_job_app_final_rt_acp_miss = fap_job_app_final_rt_acp_miss;
	}


	public String getFap_job_app_standby_rank() {
		return fap_job_app_standby_rank;
	}


	public void setFap_job_app_standby_rank(String fap_job_app_standby_rank) {
		this.fap_job_app_standby_rank = fap_job_app_standby_rank;
	}


	public String getFap_job_app_standby_rank_user() {
		return fap_job_app_standby_rank_user;
	}


	public void setFap_job_app_standby_rank_user(String fap_job_app_standby_rank_user) {
		this.fap_job_app_standby_rank_user = fap_job_app_standby_rank_user;
	}


	public String getFap_job_app_choice_comp_gb() {
		return fap_job_app_choice_comp_gb;
	}


	public void setFap_job_app_choice_comp_gb(String fap_job_app_choice_comp_gb) {
		this.fap_job_app_choice_comp_gb = fap_job_app_choice_comp_gb;
	}


	public String getFap_job_app_approval_gb() {
		return fap_job_app_approval_gb;
	}


	public void setFap_job_app_approval_gb(String fap_job_app_approval_gb) {
		this.fap_job_app_approval_gb = fap_job_app_approval_gb;
	}


	public String getFap_job_app_final_rt_ins_id() {
		return fap_job_app_final_rt_ins_id;
	}


	public void setFap_job_app_final_rt_ins_id(String fap_job_app_final_rt_ins_id) {
		this.fap_job_app_final_rt_ins_id = fap_job_app_final_rt_ins_id;
	}


	public String getFap_job_app_final_rt_ins_dt() {
		return fap_job_app_final_rt_ins_dt;
	}


	public void setFap_job_app_final_rt_ins_dt(String fap_job_app_final_rt_ins_dt) {
		this.fap_job_app_final_rt_ins_dt = fap_job_app_final_rt_ins_dt;
	}


	public String getFap_job_app_final_rt_udt_id() {
		return fap_job_app_final_rt_udt_id;
	}


	public void setFap_job_app_final_rt_udt_id(String fap_job_app_final_rt_udt_id) {
		this.fap_job_app_final_rt_udt_id = fap_job_app_final_rt_udt_id;
	}


	public String getFap_job_app_final_rt_udt_dt() {
		return fap_job_app_final_rt_udt_dt;
	}


	public void setFap_job_app_final_rt_udt_dt(String fap_job_app_final_rt_udt_dt) {
		this.fap_job_app_final_rt_udt_dt = fap_job_app_final_rt_udt_dt;
	}


	public String getFap_job_app_pass_comment() {
		return fap_job_app_pass_comment;
	}


	public void setFap_job_app_pass_comment(String fap_job_app_pass_comment) {
		this.fap_job_app_pass_comment = fap_job_app_pass_comment;
	}


	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}


	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}


	public String getFap_comp_id() {
		return fap_comp_id;
	}


	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}


	public String getUser_id() {
		return user_id;
	}


	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}


	public String getFap_job_app_final_btn_gb() {
		return fap_job_app_final_btn_gb;
	}


	public void setFap_job_app_final_btn_gb(String fap_job_app_final_btn_gb) {
		this.fap_job_app_final_btn_gb = fap_job_app_final_btn_gb;
	}


	public ArrayList<SocietyFapJobApplyFinalResult> getFap_job_apply_info_list() {
		return fap_job_apply_info_list;
	}


	public void setFap_job_apply_info_list(ArrayList<SocietyFapJobApplyFinalResult> fap_job_apply_info_list) {
		this.fap_job_apply_info_list = fap_job_apply_info_list;
	}


	@Override
	public String toString() {
		return "SocietyFapJobApplyFinalResult [fap_job_app_final_rt_seq=" + fap_job_app_final_rt_seq
				+ ", fap_job_app_final_rt_acp=" + fap_job_app_final_rt_acp + ", fap_job_app_final_rt_acp_user="
				+ fap_job_app_final_rt_acp_user + ", fap_job_app_final_rt_acp_miss=" + fap_job_app_final_rt_acp_miss
				+ ", fap_job_app_standby_rank=" + fap_job_app_standby_rank + ", fap_job_app_standby_rank_user="
				+ fap_job_app_standby_rank_user + ", fap_job_app_choice_comp_gb=" + fap_job_app_choice_comp_gb
				+ ", fap_job_app_approval_gb=" + fap_job_app_approval_gb + ", fap_job_app_final_rt_ins_id="
				+ fap_job_app_final_rt_ins_id + ", fap_job_app_final_rt_ins_dt=" + fap_job_app_final_rt_ins_dt
				+ ", fap_job_app_final_rt_udt_id=" + fap_job_app_final_rt_udt_id + ", fap_job_app_final_rt_udt_dt="
				+ fap_job_app_final_rt_udt_dt + ", fap_job_app_pass_comment=" + fap_job_app_pass_comment
				+ ", fap_job_ad_seq=" + fap_job_ad_seq + ", fap_comp_id=" + fap_comp_id + ", user_id=" + user_id
				+ ", fap_job_app_final_btn_gb=" + fap_job_app_final_btn_gb + ", fap_job_apply_info_list="
				+ fap_job_apply_info_list + "]";
	}
	
}
