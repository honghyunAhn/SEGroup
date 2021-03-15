/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : 신동철
 * @Date : 2019. 1. 3.
 * @Class 설명 : 취업지원자 채용공고 지원가능시간 관리
 * 
 */
public class SocietyFapJobfairApplicableTime {

	/**
	 * 취업지원자 채용공고 지원가능시간 시퀀스
	 */
	private long fap_jobfair_applicable_time_seq;
	
	/**
	 * 잡페어 세부정보 시퀀스
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 허가최초여부
	 */
	private String fap_jobfair_applicable_time_first;
	
	/**
	 * 지원시작시간
	 */
	private String fap_jobfair_applicable_time_st;
	
	/**
	 * 지원시작시간
	 */
	private String fap_jobfair_applicable_time_et;
	
	/**
	 * 지원시작일
	 */
	private String fap_jobfair_divide_user_date_st;
	
	/**
	 * 지원종료일
	 */
	private String fap_jobfair_divide_user_date_et;
	
	/**
	 * 지원시작시각
	 */
	private String fap_jobfair_divide_user_time_st;
	
	/**
	 * 지원종료시각
	 */
	private String fap_jobfair_divide_user_time_et;
	
	private String fap_jobfair_applicable_time_deadline_gb;
	
	private String fap_jobfair_divide_gb;
	
	/**
	 * k_fair 지원가능시간 리스트
	 */
	private List <SocietyFapJobfairApplicableTime> fap_k_fair_applicable_time_list;
	
	/**
	 * 프리시즌 지원가능시간 리스트
	 */
	private List <SocietyFapJobfairApplicableTime> fap_post_season_applicable_time_list;
	
	/**
	 * j_fair 지원가능시간 리스트
	 */
	private List <SocietyFapJobfairApplicableTime> fap_j_fair_applicable_time_list;
	
	/**
	 * 미스매칭 지원가능시간 리스트
	 */
	private List <SocietyFapJobfairApplicableTime> fap_missmatching_applicable_time_list;
	
	/**
	 * 일정 명칭
	 * */
	private String fap_jobfair_applicable_time_nm;
	
	/**
	 * 등록자
	 */
	private String fap_jobfair_applicable_time_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_jobfair_applicable_time_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_jobfair_applicable_time_udt_id;
	
	/**
	 * 수정일
	 */
	private String fap_jobfair_applicable_time_udt_dt;

	public SocietyFapJobfairApplicableTime() {
		super();
	}

	public SocietyFapJobfairApplicableTime(long fap_jobfair_applicable_time_seq, int fap_jobfair_divide_seq,
			String fap_jobfair_applicable_time_first, String fap_jobfair_applicable_time_st,
			String fap_jobfair_applicable_time_et, String fap_jobfair_divide_user_date_st,
			String fap_jobfair_divide_user_date_et, String fap_jobfair_divide_user_time_st,
			String fap_jobfair_divide_user_time_et, String fap_jobfair_applicable_time_deadline_gb,
			String fap_jobfair_divide_gb, List<SocietyFapJobfairApplicableTime> fap_k_fair_applicable_time_list,
			List<SocietyFapJobfairApplicableTime> fap_post_season_applicable_time_list,
			List<SocietyFapJobfairApplicableTime> fap_j_fair_applicable_time_list,
			List<SocietyFapJobfairApplicableTime> fap_missmatching_applicable_time_list,
			String fap_jobfair_applicable_time_nm, String fap_jobfair_applicable_time_ins_id,
			String fap_jobfair_applicable_time_ins_dt, String fap_jobfair_applicable_time_udt_id,
			String fap_jobfair_applicable_time_udt_dt) {
		super();
		this.fap_jobfair_applicable_time_seq = fap_jobfair_applicable_time_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_applicable_time_first = fap_jobfair_applicable_time_first;
		this.fap_jobfair_applicable_time_st = fap_jobfair_applicable_time_st;
		this.fap_jobfair_applicable_time_et = fap_jobfair_applicable_time_et;
		this.fap_jobfair_divide_user_date_st = fap_jobfair_divide_user_date_st;
		this.fap_jobfair_divide_user_date_et = fap_jobfair_divide_user_date_et;
		this.fap_jobfair_divide_user_time_st = fap_jobfair_divide_user_time_st;
		this.fap_jobfair_divide_user_time_et = fap_jobfair_divide_user_time_et;
		this.fap_jobfair_applicable_time_deadline_gb = fap_jobfair_applicable_time_deadline_gb;
		this.fap_jobfair_divide_gb = fap_jobfair_divide_gb;
		this.fap_k_fair_applicable_time_list = fap_k_fair_applicable_time_list;
		this.fap_post_season_applicable_time_list = fap_post_season_applicable_time_list;
		this.fap_j_fair_applicable_time_list = fap_j_fair_applicable_time_list;
		this.fap_missmatching_applicable_time_list = fap_missmatching_applicable_time_list;
		this.fap_jobfair_applicable_time_nm = fap_jobfair_applicable_time_nm;
		this.fap_jobfair_applicable_time_ins_id = fap_jobfair_applicable_time_ins_id;
		this.fap_jobfair_applicable_time_ins_dt = fap_jobfair_applicable_time_ins_dt;
		this.fap_jobfair_applicable_time_udt_id = fap_jobfair_applicable_time_udt_id;
		this.fap_jobfair_applicable_time_udt_dt = fap_jobfair_applicable_time_udt_dt;
	}

	public long getFap_jobfair_applicable_time_seq() {
		return fap_jobfair_applicable_time_seq;
	}

	public void setFap_jobfair_applicable_time_seq(long fap_jobfair_applicable_time_seq) {
		this.fap_jobfair_applicable_time_seq = fap_jobfair_applicable_time_seq;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public String getFap_jobfair_applicable_time_first() {
		return fap_jobfair_applicable_time_first;
	}

	public void setFap_jobfair_applicable_time_first(String fap_jobfair_applicable_time_first) {
		this.fap_jobfair_applicable_time_first = fap_jobfair_applicable_time_first;
	}

	public String getFap_jobfair_applicable_time_st() {
		return fap_jobfair_applicable_time_st;
	}

	public void setFap_jobfair_applicable_time_st(String fap_jobfair_applicable_time_st) {
		this.fap_jobfair_applicable_time_st = fap_jobfair_applicable_time_st;
	}

	public String getFap_jobfair_applicable_time_et() {
		return fap_jobfair_applicable_time_et;
	}

	public void setFap_jobfair_applicable_time_et(String fap_jobfair_applicable_time_et) {
		this.fap_jobfair_applicable_time_et = fap_jobfair_applicable_time_et;
	}

	public String getFap_jobfair_divide_user_date_st() {
		return fap_jobfair_divide_user_date_st;
	}

	public void setFap_jobfair_divide_user_date_st(String fap_jobfair_divide_user_date_st) {
		this.fap_jobfair_divide_user_date_st = fap_jobfair_divide_user_date_st;
	}

	public String getFap_jobfair_divide_user_date_et() {
		return fap_jobfair_divide_user_date_et;
	}

	public void setFap_jobfair_divide_user_date_et(String fap_jobfair_divide_user_date_et) {
		this.fap_jobfair_divide_user_date_et = fap_jobfair_divide_user_date_et;
	}

	public String getFap_jobfair_divide_user_time_st() {
		return fap_jobfair_divide_user_time_st;
	}

	public void setFap_jobfair_divide_user_time_st(String fap_jobfair_divide_user_time_st) {
		this.fap_jobfair_divide_user_time_st = fap_jobfair_divide_user_time_st;
	}

	public String getFap_jobfair_divide_user_time_et() {
		return fap_jobfair_divide_user_time_et;
	}

	public void setFap_jobfair_divide_user_time_et(String fap_jobfair_divide_user_time_et) {
		this.fap_jobfair_divide_user_time_et = fap_jobfair_divide_user_time_et;
	}

	public String getFap_jobfair_applicable_time_deadline_gb() {
		return fap_jobfair_applicable_time_deadline_gb;
	}

	public void setFap_jobfair_applicable_time_deadline_gb(String fap_jobfair_applicable_time_deadline_gb) {
		this.fap_jobfair_applicable_time_deadline_gb = fap_jobfair_applicable_time_deadline_gb;
	}

	public String getFap_jobfair_divide_gb() {
		return fap_jobfair_divide_gb;
	}

	public void setFap_jobfair_divide_gb(String fap_jobfair_divide_gb) {
		this.fap_jobfair_divide_gb = fap_jobfair_divide_gb;
	}

	public List<SocietyFapJobfairApplicableTime> getFap_k_fair_applicable_time_list() {
		return fap_k_fair_applicable_time_list;
	}

	public void setFap_k_fair_applicable_time_list(List<SocietyFapJobfairApplicableTime> fap_k_fair_applicable_time_list) {
		this.fap_k_fair_applicable_time_list = fap_k_fair_applicable_time_list;
	}

	public List<SocietyFapJobfairApplicableTime> getFap_post_season_applicable_time_list() {
		return fap_post_season_applicable_time_list;
	}

	public void setFap_post_season_applicable_time_list(
			List<SocietyFapJobfairApplicableTime> fap_post_season_applicable_time_list) {
		this.fap_post_season_applicable_time_list = fap_post_season_applicable_time_list;
	}

	public List<SocietyFapJobfairApplicableTime> getFap_j_fair_applicable_time_list() {
		return fap_j_fair_applicable_time_list;
	}

	public void setFap_j_fair_applicable_time_list(List<SocietyFapJobfairApplicableTime> fap_j_fair_applicable_time_list) {
		this.fap_j_fair_applicable_time_list = fap_j_fair_applicable_time_list;
	}

	public List<SocietyFapJobfairApplicableTime> getFap_missmatching_applicable_time_list() {
		return fap_missmatching_applicable_time_list;
	}

	public void setFap_missmatching_applicable_time_list(
			List<SocietyFapJobfairApplicableTime> fap_missmatching_applicable_time_list) {
		this.fap_missmatching_applicable_time_list = fap_missmatching_applicable_time_list;
	}

	public String getFap_jobfair_applicable_time_nm() {
		return fap_jobfair_applicable_time_nm;
	}

	public void setFap_jobfair_applicable_time_nm(String fap_jobfair_applicable_time_nm) {
		this.fap_jobfair_applicable_time_nm = fap_jobfair_applicable_time_nm;
	}

	public String getFap_jobfair_applicable_time_ins_id() {
		return fap_jobfair_applicable_time_ins_id;
	}

	public void setFap_jobfair_applicable_time_ins_id(String fap_jobfair_applicable_time_ins_id) {
		this.fap_jobfair_applicable_time_ins_id = fap_jobfair_applicable_time_ins_id;
	}

	public String getFap_jobfair_applicable_time_ins_dt() {
		return fap_jobfair_applicable_time_ins_dt;
	}

	public void setFap_jobfair_applicable_time_ins_dt(String fap_jobfair_applicable_time_ins_dt) {
		this.fap_jobfair_applicable_time_ins_dt = fap_jobfair_applicable_time_ins_dt;
	}

	public String getFap_jobfair_applicable_time_udt_id() {
		return fap_jobfair_applicable_time_udt_id;
	}

	public void setFap_jobfair_applicable_time_udt_id(String fap_jobfair_applicable_time_udt_id) {
		this.fap_jobfair_applicable_time_udt_id = fap_jobfair_applicable_time_udt_id;
	}

	public String getFap_jobfair_applicable_time_udt_dt() {
		return fap_jobfair_applicable_time_udt_dt;
	}

	public void setFap_jobfair_applicable_time_udt_dt(String fap_jobfair_applicable_time_udt_dt) {
		this.fap_jobfair_applicable_time_udt_dt = fap_jobfair_applicable_time_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapJobfairApplicableTime [fap_jobfair_applicable_time_seq=" + fap_jobfair_applicable_time_seq
				+ ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", fap_jobfair_applicable_time_first="
				+ fap_jobfair_applicable_time_first + ", fap_jobfair_applicable_time_st="
				+ fap_jobfair_applicable_time_st + ", fap_jobfair_applicable_time_et=" + fap_jobfair_applicable_time_et
				+ ", fap_jobfair_divide_user_date_st=" + fap_jobfair_divide_user_date_st
				+ ", fap_jobfair_divide_user_date_et=" + fap_jobfair_divide_user_date_et
				+ ", fap_jobfair_divide_user_time_st=" + fap_jobfair_divide_user_time_st
				+ ", fap_jobfair_divide_user_time_et=" + fap_jobfair_divide_user_time_et
				+ ", fap_jobfair_applicable_time_deadline_gb=" + fap_jobfair_applicable_time_deadline_gb
				+ ", fap_jobfair_divide_gb=" + fap_jobfair_divide_gb + ", fap_k_fair_applicable_time_list="
				+ fap_k_fair_applicable_time_list + ", fap_post_season_applicable_time_list="
				+ fap_post_season_applicable_time_list + ", fap_j_fair_applicable_time_list="
				+ fap_j_fair_applicable_time_list + ", fap_missmatching_applicable_time_list="
				+ fap_missmatching_applicable_time_list + ", fap_jobfair_applicable_time_nm="
				+ fap_jobfair_applicable_time_nm + ", fap_jobfair_applicable_time_ins_id="
				+ fap_jobfair_applicable_time_ins_id + ", fap_jobfair_applicable_time_ins_dt="
				+ fap_jobfair_applicable_time_ins_dt + ", fap_jobfair_applicable_time_udt_id="
				+ fap_jobfair_applicable_time_udt_id + ", fap_jobfair_applicable_time_udt_dt="
				+ fap_jobfair_applicable_time_udt_dt + "]";
	}
	
}
