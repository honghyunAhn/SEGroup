/**
 * 
 */
package global.segroup.society.fap.adminuser.domain;

import java.util.LinkedHashMap;

/**
 * @Author : 정대영
 * @Date : 2019. 1. 11.
 * @Class 설명 : 쿼터에 충돌된 유저 정보
 * 
 */
public class SocietyFapAdminUserOfConflictedQuarter {
	/**
	 * 채용공고지원정보 시퀀스
	 */
	private long fap_job_app_info_seq;
	/**
	 * 채용공고 시퀀스
	 */
	private long fap_job_ad_seq;
	/**
	 * 유저아이디
	 */
	private String user_id;
	/**
	 * 지망순위
	 */
	private int fap_job_app_info_rank;
	/**
	 * 채용공고별 설정된 지원가능인원
	 */
	private int fap_job_app_per_settled_num;
	/**
	 * 채용공고별 지원중인 지원자 수
	 */
	private int now_apply_nums;
	/**
	 * 채용공고별 이미 지원한 지원자 수
	 * */
	private int applied_nums;
	/**
	 * 채용공고별 지원 가능 인원
	 * */
	private int applicable_num;
	
	/**
	 * 채용공고별 지원번호 시퀀스 및 지망 리스트
	 */
	private LinkedHashMap<Long, Integer> adPerApplyRankList;
	
	/**
	 * @Desc : 
	 */
	public SocietyFapAdminUserOfConflictedQuarter() {
		super();
	}

	public SocietyFapAdminUserOfConflictedQuarter(long fap_job_app_info_seq, long fap_job_ad_seq, String user_id,
			int fap_job_app_info_rank, int fap_job_app_per_settled_num, int now_apply_nums, int applied_nums,
			int applicable_num, LinkedHashMap<Long, Integer> adPerApplyRankList) {
		super();
		this.fap_job_app_info_seq = fap_job_app_info_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.user_id = user_id;
		this.fap_job_app_info_rank = fap_job_app_info_rank;
		this.fap_job_app_per_settled_num = fap_job_app_per_settled_num;
		this.now_apply_nums = now_apply_nums;
		this.applied_nums = applied_nums;
		this.applicable_num = applicable_num;
		this.adPerApplyRankList = adPerApplyRankList;
	}

	public long getFap_job_app_info_seq() {
		return fap_job_app_info_seq;
	}

	public void setFap_job_app_info_seq(long fap_job_app_info_seq) {
		this.fap_job_app_info_seq = fap_job_app_info_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getFap_job_app_info_rank() {
		return fap_job_app_info_rank;
	}

	public void setFap_job_app_info_rank(int fap_job_app_info_rank) {
		this.fap_job_app_info_rank = fap_job_app_info_rank;
	}

	public int getFap_job_app_per_settled_num() {
		return fap_job_app_per_settled_num;
	}

	public void setFap_job_app_per_settled_num(int fap_job_app_per_settled_num) {
		this.fap_job_app_per_settled_num = fap_job_app_per_settled_num;
	}

	public int getNow_apply_nums() {
		return now_apply_nums;
	}

	public void setNow_apply_nums(int now_apply_nums) {
		this.now_apply_nums = now_apply_nums;
	}

	public int getApplied_nums() {
		return applied_nums;
	}

	public void setApplied_nums(int applied_nums) {
		this.applied_nums = applied_nums;
	}

	public int getApplicable_num() {
		return applicable_num;
	}

	public void setApplicable_num(int applicable_num) {
		this.applicable_num = applicable_num;
	}

	public LinkedHashMap<Long, Integer> getAdPerApplyRankList() {
		return adPerApplyRankList;
	}

	public void setAdPerApplyRankList(LinkedHashMap<Long, Integer> adPerApplyRankList) {
		this.adPerApplyRankList = adPerApplyRankList;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminUserOfConflictedQuarter [fap_job_app_info_seq=" + fap_job_app_info_seq
				+ ", fap_job_ad_seq=" + fap_job_ad_seq + ", user_id=" + user_id + ", fap_job_app_info_rank="
				+ fap_job_app_info_rank + ", fap_job_app_per_settled_num=" + fap_job_app_per_settled_num
				+ ", now_apply_nums=" + now_apply_nums + ", applied_nums=" + applied_nums + ", applicable_num="
				+ applicable_num + ", adPerApplyRankList=" + adPerApplyRankList + "]";
	}
}
