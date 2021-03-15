/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이종호
 * @Date : 2018. 12. 26.
 * @Class 설명 : 현지 잡페어 면접 정보
 * 
 */
public class SocietyFapLaJobItv {
	
	//현지 잡페어 면접정보 시퀀스
	private int fap_la_job_itv_seq;
	//채용공고 시퀀스
	private long fap_job_ad_seq;
	//면접코드(공통 코드)
	private String fap_la_job_itv_cd;
	//면접 인원수
	private int fap_la_job_itv_cnt;
	//일정 타입(공통 코드)
	private String fap_la_job_itv_tp;
	//대상자 코드(공통 코드)
	private String fap_la_job_itv_user_cd;
	//면접 소요시간
	private String fap_la_job_itv_tm;
	//면접실 사용개수
	private int fap_la_job_itv_room_cnt;
	//면접관 수
	private int fap_la_job_itv_comp_cnt;
	//점심시간 코드(공통 코드)
	private String fap_la_job_itv_lc_cd;
	//면접일정 순서
	private int fap_la_job_itv_od;
	//기타요청사항
	private String fap_la_job_itv_etc;
	//등록인
	private String fap_la_job_itv_ins_id;
	//수정인
	private String fap_la_job_itv_udt_id;
	//등록일
	private String fap_la_job_itv_ins_dt;
	//수정일
	private String fap_la_job_itv_udt_dt;
	
	public SocietyFapLaJobItv() {
		super();
	}

	public SocietyFapLaJobItv(int fap_la_job_itv_seq, long fap_job_ad_seq, String fap_la_job_itv_cd,
			int fap_la_job_itv_cnt, String fap_la_job_itv_tp, String fap_la_job_itv_user_cd, String fap_la_job_itv_tm,
			int fap_la_job_itv_room_cnt, int fap_la_job_itv_comp_cnt, String fap_la_job_itv_lc_cd,
			int fap_la_job_itv_od, String fap_la_job_itv_etc, String fap_la_job_itv_ins_id,
			String fap_la_job_itv_udt_id, String fap_la_job_itv_ins_dt, String fap_la_job_itv_udt_dt) {
		super();
		this.fap_la_job_itv_seq = fap_la_job_itv_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_la_job_itv_cd = fap_la_job_itv_cd;
		this.fap_la_job_itv_cnt = fap_la_job_itv_cnt;
		this.fap_la_job_itv_tp = fap_la_job_itv_tp;
		this.fap_la_job_itv_user_cd = fap_la_job_itv_user_cd;
		this.fap_la_job_itv_tm = fap_la_job_itv_tm;
		this.fap_la_job_itv_room_cnt = fap_la_job_itv_room_cnt;
		this.fap_la_job_itv_comp_cnt = fap_la_job_itv_comp_cnt;
		this.fap_la_job_itv_lc_cd = fap_la_job_itv_lc_cd;
		this.fap_la_job_itv_od = fap_la_job_itv_od;
		this.fap_la_job_itv_etc = fap_la_job_itv_etc;
		this.fap_la_job_itv_ins_id = fap_la_job_itv_ins_id;
		this.fap_la_job_itv_udt_id = fap_la_job_itv_udt_id;
		this.fap_la_job_itv_ins_dt = fap_la_job_itv_ins_dt;
		this.fap_la_job_itv_udt_dt = fap_la_job_itv_udt_dt;
	}

	public int getFap_la_job_itv_seq() {
		return fap_la_job_itv_seq;
	}

	public void setFap_la_job_itv_seq(int fap_la_job_itv_seq) {
		this.fap_la_job_itv_seq = fap_la_job_itv_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_la_job_itv_cd() {
		return fap_la_job_itv_cd;
	}

	public void setFap_la_job_itv_cd(String fap_la_job_itv_cd) {
		this.fap_la_job_itv_cd = fap_la_job_itv_cd;
	}

	public int getFap_la_job_itv_cnt() {
		return fap_la_job_itv_cnt;
	}

	public void setFap_la_job_itv_cnt(int fap_la_job_itv_cnt) {
		this.fap_la_job_itv_cnt = fap_la_job_itv_cnt;
	}

	public String getFap_la_job_itv_tp() {
		return fap_la_job_itv_tp;
	}

	public void setFap_la_job_itv_tp(String fap_la_job_itv_tp) {
		this.fap_la_job_itv_tp = fap_la_job_itv_tp;
	}

	public String getFap_la_job_itv_user_cd() {
		return fap_la_job_itv_user_cd;
	}

	public void setFap_la_job_itv_user_cd(String fap_la_job_itv_user_cd) {
		this.fap_la_job_itv_user_cd = fap_la_job_itv_user_cd;
	}

	public String getFap_la_job_itv_tm() {
		return fap_la_job_itv_tm;
	}

	public void setFap_la_job_itv_tm(String fap_la_job_itv_tm) {
		this.fap_la_job_itv_tm = fap_la_job_itv_tm;
	}

	public int getFap_la_job_itv_room_cnt() {
		return fap_la_job_itv_room_cnt;
	}

	public void setFap_la_job_itv_room_cnt(int fap_la_job_itv_room_cnt) {
		this.fap_la_job_itv_room_cnt = fap_la_job_itv_room_cnt;
	}

	public int getFap_la_job_itv_comp_cnt() {
		return fap_la_job_itv_comp_cnt;
	}

	public void setFap_la_job_itv_comp_cnt(int fap_la_job_itv_comp_cnt) {
		this.fap_la_job_itv_comp_cnt = fap_la_job_itv_comp_cnt;
	}

	public String getFap_la_job_itv_lc_cd() {
		return fap_la_job_itv_lc_cd;
	}

	public void setFap_la_job_itv_lc_cd(String fap_la_job_itv_lc_cd) {
		this.fap_la_job_itv_lc_cd = fap_la_job_itv_lc_cd;
	}

	public int getFap_la_job_itv_od() {
		return fap_la_job_itv_od;
	}

	public void setFap_la_job_itv_od(int fap_la_job_itv_od) {
		this.fap_la_job_itv_od = fap_la_job_itv_od;
	}

	public String getFap_la_job_itv_etc() {
		return fap_la_job_itv_etc;
	}

	public void setFap_la_job_itv_etc(String fap_la_job_itv_etc) {
		this.fap_la_job_itv_etc = fap_la_job_itv_etc;
	}

	public String getFap_la_job_itv_ins_id() {
		return fap_la_job_itv_ins_id;
	}

	public void setFap_la_job_itv_ins_id(String fap_la_job_itv_ins_id) {
		this.fap_la_job_itv_ins_id = fap_la_job_itv_ins_id;
	}

	public String getFap_la_job_itv_udt_id() {
		return fap_la_job_itv_udt_id;
	}

	public void setFap_la_job_itv_udt_id(String fap_la_job_itv_udt_id) {
		this.fap_la_job_itv_udt_id = fap_la_job_itv_udt_id;
	}

	public String getFap_la_job_itv_ins_dt() {
		return fap_la_job_itv_ins_dt;
	}

	public void setFap_la_job_itv_ins_dt(String fap_la_job_itv_ins_dt) {
		this.fap_la_job_itv_ins_dt = fap_la_job_itv_ins_dt;
	}

	public String getFap_la_job_itv_udt_dt() {
		return fap_la_job_itv_udt_dt;
	}

	public void setFap_la_job_itv_udt_dt(String fap_la_job_itv_udt_dt) {
		this.fap_la_job_itv_udt_dt = fap_la_job_itv_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapLaJobItv [fap_la_job_itv_seq=" + fap_la_job_itv_seq + ", fap_job_ad_seq=" + fap_job_ad_seq
				+ ", fap_la_job_itv_cd=" + fap_la_job_itv_cd + ", fap_la_job_itv_cnt=" + fap_la_job_itv_cnt
				+ ", fap_la_job_itv_tp=" + fap_la_job_itv_tp + ", fap_la_job_itv_user_cd=" + fap_la_job_itv_user_cd
				+ ", fap_la_job_itv_tm=" + fap_la_job_itv_tm + ", fap_la_job_itv_room_cnt=" + fap_la_job_itv_room_cnt
				+ ", fap_la_job_itv_comp_cnt=" + fap_la_job_itv_comp_cnt + ", fap_la_job_itv_lc_cd="
				+ fap_la_job_itv_lc_cd + ", fap_la_job_itv_od=" + fap_la_job_itv_od + ", fap_la_job_itv_etc="
				+ fap_la_job_itv_etc + ", fap_la_job_itv_ins_id=" + fap_la_job_itv_ins_id + ", fap_la_job_itv_udt_id="
				+ fap_la_job_itv_udt_id + ", fap_la_job_itv_ins_dt=" + fap_la_job_itv_ins_dt
				+ ", fap_la_job_itv_udt_dt=" + fap_la_job_itv_udt_dt + "]";
	}
}
