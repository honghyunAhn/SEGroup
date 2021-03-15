/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2018. 12. 24.
 * @Class 설명 : 현지 잡페어 설정 정보
 * 
 */
public class SocietyFapAdminJobfairSet {
	
	//현지 잡페어 설정 시퀀스
	private int fap_jobfair_set_seq;
	//상세 잡페어 시퀀스
	private int fap_jobfair_divide_seq;
	//현지 잡페어 일정 명칭
	private String fap_jobfair_set_nm;
	//현지 잡페어 장소
	private String fap_jobfair_set_addr;
	//현지 잡페어 기업 등록 시작일
	private String fap_jobfair_set_comp_sd;
	//현지 잡페어 기업 등록 종료일
	private String fap_jobfair_set_comp_ed;
	//현지 잡페어 기업 등록 시작시간
	private String fap_jobfair_set_comp_st;
	//현지 잡페어 기업 등록 종료시간
	private String fap_jobfair_set_comp_et;
	//현지 잡페어 시작일
	private String fap_jobfair_set_st;
	//현지 잡페어 종료일
	private String fap_jobfair_set_et;
	//현지 잡페어 면접장 시작시간
	private String fap_jobfair_set_room_st;
	//현지 잡페어 면접장 종료시간
	private String fap_jobfair_set_room_et;
	//현지 면접장 개수
	private String fap_jobfair_set_room_cnt;
	//학생이 하루에 보는 최대 면접의 수
	private String fap_jobfair_set_itv_cnt;
	//면접 사이의 학생 시간
	private String fap_jobfair_set_itv_stu_dt;
	//면접 사이의 기업 시간
	private String fap_jobfair_set_itv_comp_dt;
	//사용여부(공통코드)
	private String fap_jobfair_set_gb;
	//등록자
	private String fap_jobfair_set_ins_id;
	//수정자
	private String fap_jobfair_set_udt_id;
	//등록일
	private String fap_jobfair_set_ins_dt;
	//수정일
	private String fap_jobfair_set_udt_dt;
	
	private List<SocietyFapAdminJobfairSetDate> fap_jobfair_set_date_info_arr;
	
	public SocietyFapAdminJobfairSet() {
		super();
	}

	public SocietyFapAdminJobfairSet(int fap_jobfair_set_seq, int fap_jobfair_divide_seq, String fap_jobfair_set_nm,
			String fap_jobfair_set_addr, String fap_jobfair_set_comp_sd, String fap_jobfair_set_comp_ed,
			String fap_jobfair_set_comp_st, String fap_jobfair_set_comp_et, String fap_jobfair_set_st,
			String fap_jobfair_set_et, String fap_jobfair_set_room_st, String fap_jobfair_set_room_et,
			String fap_jobfair_set_room_cnt, String fap_jobfair_set_itv_cnt, String fap_jobfair_set_itv_stu_dt,
			String fap_jobfair_set_itv_comp_dt, String fap_jobfair_set_gb, String fap_jobfair_set_ins_id,
			String fap_jobfair_set_udt_id, String fap_jobfair_set_ins_dt, String fap_jobfair_set_udt_dt,
			List<SocietyFapAdminJobfairSetDate> fap_jobfair_set_date_info_arr) {
		super();
		this.fap_jobfair_set_seq = fap_jobfair_set_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_set_nm = fap_jobfair_set_nm;
		this.fap_jobfair_set_addr = fap_jobfair_set_addr;
		this.fap_jobfair_set_comp_sd = fap_jobfair_set_comp_sd;
		this.fap_jobfair_set_comp_ed = fap_jobfair_set_comp_ed;
		this.fap_jobfair_set_comp_st = fap_jobfair_set_comp_st;
		this.fap_jobfair_set_comp_et = fap_jobfair_set_comp_et;
		this.fap_jobfair_set_st = fap_jobfair_set_st;
		this.fap_jobfair_set_et = fap_jobfair_set_et;
		this.fap_jobfair_set_room_st = fap_jobfair_set_room_st;
		this.fap_jobfair_set_room_et = fap_jobfair_set_room_et;
		this.fap_jobfair_set_room_cnt = fap_jobfair_set_room_cnt;
		this.fap_jobfair_set_itv_cnt = fap_jobfair_set_itv_cnt;
		this.fap_jobfair_set_itv_stu_dt = fap_jobfair_set_itv_stu_dt;
		this.fap_jobfair_set_itv_comp_dt = fap_jobfair_set_itv_comp_dt;
		this.fap_jobfair_set_gb = fap_jobfair_set_gb;
		this.fap_jobfair_set_ins_id = fap_jobfair_set_ins_id;
		this.fap_jobfair_set_udt_id = fap_jobfair_set_udt_id;
		this.fap_jobfair_set_ins_dt = fap_jobfair_set_ins_dt;
		this.fap_jobfair_set_udt_dt = fap_jobfair_set_udt_dt;
		this.fap_jobfair_set_date_info_arr = fap_jobfair_set_date_info_arr;
	}

	public int getFap_jobfair_set_seq() {
		return fap_jobfair_set_seq;
	}

	public void setFap_jobfair_set_seq(int fap_jobfair_set_seq) {
		this.fap_jobfair_set_seq = fap_jobfair_set_seq;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public String getFap_jobfair_set_nm() {
		return fap_jobfair_set_nm;
	}

	public void setFap_jobfair_set_nm(String fap_jobfair_set_nm) {
		this.fap_jobfair_set_nm = fap_jobfair_set_nm;
	}

	public String getFap_jobfair_set_addr() {
		return fap_jobfair_set_addr;
	}

	public void setFap_jobfair_set_addr(String fap_jobfair_set_addr) {
		this.fap_jobfair_set_addr = fap_jobfair_set_addr;
	}

	public String getFap_jobfair_set_comp_sd() {
		return fap_jobfair_set_comp_sd;
	}

	public void setFap_jobfair_set_comp_sd(String fap_jobfair_set_comp_sd) {
		this.fap_jobfair_set_comp_sd = fap_jobfair_set_comp_sd;
	}

	public String getFap_jobfair_set_comp_ed() {
		return fap_jobfair_set_comp_ed;
	}

	public void setFap_jobfair_set_comp_ed(String fap_jobfair_set_comp_ed) {
		this.fap_jobfair_set_comp_ed = fap_jobfair_set_comp_ed;
	}

	public String getFap_jobfair_set_comp_st() {
		return fap_jobfair_set_comp_st;
	}

	public void setFap_jobfair_set_comp_st(String fap_jobfair_set_comp_st) {
		this.fap_jobfair_set_comp_st = fap_jobfair_set_comp_st;
	}

	public String getFap_jobfair_set_comp_et() {
		return fap_jobfair_set_comp_et;
	}

	public void setFap_jobfair_set_comp_et(String fap_jobfair_set_comp_et) {
		this.fap_jobfair_set_comp_et = fap_jobfair_set_comp_et;
	}

	public String getFap_jobfair_set_st() {
		return fap_jobfair_set_st;
	}

	public void setFap_jobfair_set_st(String fap_jobfair_set_st) {
		this.fap_jobfair_set_st = fap_jobfair_set_st;
	}

	public String getFap_jobfair_set_et() {
		return fap_jobfair_set_et;
	}

	public void setFap_jobfair_set_et(String fap_jobfair_set_et) {
		this.fap_jobfair_set_et = fap_jobfair_set_et;
	}

	public String getFap_jobfair_set_room_st() {
		return fap_jobfair_set_room_st;
	}

	public void setFap_jobfair_set_room_st(String fap_jobfair_set_room_st) {
		this.fap_jobfair_set_room_st = fap_jobfair_set_room_st;
	}

	public String getFap_jobfair_set_room_et() {
		return fap_jobfair_set_room_et;
	}

	public void setFap_jobfair_set_room_et(String fap_jobfair_set_room_et) {
		this.fap_jobfair_set_room_et = fap_jobfair_set_room_et;
	}

	public String getFap_jobfair_set_room_cnt() {
		return fap_jobfair_set_room_cnt;
	}

	public void setFap_jobfair_set_room_cnt(String fap_jobfair_set_room_cnt) {
		this.fap_jobfair_set_room_cnt = fap_jobfair_set_room_cnt;
	}

	public String getFap_jobfair_set_itv_cnt() {
		return fap_jobfair_set_itv_cnt;
	}

	public void setFap_jobfair_set_itv_cnt(String fap_jobfair_set_itv_cnt) {
		this.fap_jobfair_set_itv_cnt = fap_jobfair_set_itv_cnt;
	}

	public String getFap_jobfair_set_itv_stu_dt() {
		return fap_jobfair_set_itv_stu_dt;
	}

	public void setFap_jobfair_set_itv_stu_dt(String fap_jobfair_set_itv_stu_dt) {
		this.fap_jobfair_set_itv_stu_dt = fap_jobfair_set_itv_stu_dt;
	}

	public String getFap_jobfair_set_itv_comp_dt() {
		return fap_jobfair_set_itv_comp_dt;
	}

	public void setFap_jobfair_set_itv_comp_dt(String fap_jobfair_set_itv_comp_dt) {
		this.fap_jobfair_set_itv_comp_dt = fap_jobfair_set_itv_comp_dt;
	}

	public String getFap_jobfair_set_gb() {
		return fap_jobfair_set_gb;
	}

	public void setFap_jobfair_set_gb(String fap_jobfair_set_gb) {
		this.fap_jobfair_set_gb = fap_jobfair_set_gb;
	}

	public String getFap_jobfair_set_ins_id() {
		return fap_jobfair_set_ins_id;
	}

	public void setFap_jobfair_set_ins_id(String fap_jobfair_set_ins_id) {
		this.fap_jobfair_set_ins_id = fap_jobfair_set_ins_id;
	}

	public String getFap_jobfair_set_udt_id() {
		return fap_jobfair_set_udt_id;
	}

	public void setFap_jobfair_set_udt_id(String fap_jobfair_set_udt_id) {
		this.fap_jobfair_set_udt_id = fap_jobfair_set_udt_id;
	}

	public String getFap_jobfair_set_ins_dt() {
		return fap_jobfair_set_ins_dt;
	}

	public void setFap_jobfair_set_ins_dt(String fap_jobfair_set_ins_dt) {
		this.fap_jobfair_set_ins_dt = fap_jobfair_set_ins_dt;
	}

	public String getFap_jobfair_set_udt_dt() {
		return fap_jobfair_set_udt_dt;
	}

	public void setFap_jobfair_set_udt_dt(String fap_jobfair_set_udt_dt) {
		this.fap_jobfair_set_udt_dt = fap_jobfair_set_udt_dt;
	}

	public List<SocietyFapAdminJobfairSetDate> getFap_jobfair_set_date_info_arr() {
		return fap_jobfair_set_date_info_arr;
	}

	public void setFap_jobfair_set_date_info_arr(List<SocietyFapAdminJobfairSetDate> fap_jobfair_set_date_info_arr) {
		this.fap_jobfair_set_date_info_arr = fap_jobfair_set_date_info_arr;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairSet [fap_jobfair_set_seq=" + fap_jobfair_set_seq + ", fap_jobfair_divide_seq="
				+ fap_jobfair_divide_seq + ", fap_jobfair_set_nm=" + fap_jobfair_set_nm + ", fap_jobfair_set_addr="
				+ fap_jobfair_set_addr + ", fap_jobfair_set_comp_sd=" + fap_jobfair_set_comp_sd
				+ ", fap_jobfair_set_comp_ed=" + fap_jobfair_set_comp_ed + ", fap_jobfair_set_comp_st="
				+ fap_jobfair_set_comp_st + ", fap_jobfair_set_comp_et=" + fap_jobfair_set_comp_et
				+ ", fap_jobfair_set_st=" + fap_jobfair_set_st + ", fap_jobfair_set_et=" + fap_jobfair_set_et
				+ ", fap_jobfair_set_room_st=" + fap_jobfair_set_room_st + ", fap_jobfair_set_room_et="
				+ fap_jobfair_set_room_et + ", fap_jobfair_set_room_cnt=" + fap_jobfair_set_room_cnt
				+ ", fap_jobfair_set_itv_cnt=" + fap_jobfair_set_itv_cnt + ", fap_jobfair_set_itv_stu_dt="
				+ fap_jobfair_set_itv_stu_dt + ", fap_jobfair_set_itv_comp_dt=" + fap_jobfair_set_itv_comp_dt
				+ ", fap_jobfair_set_gb=" + fap_jobfair_set_gb + ", fap_jobfair_set_ins_id=" + fap_jobfair_set_ins_id
				+ ", fap_jobfair_set_udt_id=" + fap_jobfair_set_udt_id + ", fap_jobfair_set_ins_dt="
				+ fap_jobfair_set_ins_dt + ", fap_jobfair_set_udt_dt=" + fap_jobfair_set_udt_dt
				+ ", fap_jobfair_set_date_info_arr=" + fap_jobfair_set_date_info_arr + "]";
	}
}
