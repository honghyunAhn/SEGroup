/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 5.
 * @Class 설명 : 잡페어 세부구분 정보
 * 
 */
public class SocietyFapAdminJobfairDivide extends SocietyFapAdminJobfair{

	/**
	 * 잡페어 구분 시퀀스
	 */
	private int fap_jobfair_divide_seq;
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 잡페어 세부시작일
	 */
	private String fap_jobfair_divide_st;
	
	/**
	 * 잡페어 세부종료일
	 */
	private String fap_jobfair_divide_et;
	
	/**
	 * 잡페어 세부 신청 시작일
	 */
	private String fap_jobfair_divide_app_st;
	
	/**
	 * 잡페어 세부 신청 종료일
	 */
	private String fap_jobfair_divide_app_et;	
	
	/**
	 * 잡페어 세부 지망가능 개수
	 */
	private int fap_jobfair_divide_app_num;	
	
	/**
	 * 잡페어 세부설명
	 */
	private String fap_jobfair_divide_detail;
	
	/**
	 * 잡페어 세부 구분
	 */
	private String fap_jobfair_divide_gb;
	
	/**
	 * 잡페어 세부 구분 리스트
	 */
	private List<SocietyFapAdminJobfairDivide> fap_jobfair_divide_gb_list;
	
	/**
	 * 잡페어 세부 구분 노출여부
	 */
	private String fap_jobfair_divide_gb_eps;
	
	/**
	 * 등록인
	 */
	private String fap_jobfair_divide_ins_id;
	
	/**
	 * 등록일자
	 */
	private String fap_jobfair_divide_ins_dt;
	
	/**
	 * 수정인
	 */
	private String fap_jobfair_divide_udt_id;
	
	/**
	 * 수정일자
	 */
	private String fap_jobfair_divide_udt_dt;

	
	public SocietyFapAdminJobfairDivide() {
		super();
	}

	public SocietyFapAdminJobfairDivide(int fap_jobfair_divide_seq, int fap_jobfair_seq, String fap_jobfair_divide_st,
			String fap_jobfair_divide_et, String fap_jobfair_divide_app_st, String fap_jobfair_divide_app_et,
			int fap_jobfair_divide_app_num, String fap_jobfair_divide_detail, String fap_jobfair_divide_gb,
			List<SocietyFapAdminJobfairDivide> fap_jobfair_divide_gb_list, String fap_jobfair_divide_gb_eps,
			String fap_jobfair_divide_ins_id, String fap_jobfair_divide_ins_dt, String fap_jobfair_divide_udt_id,
			String fap_jobfair_divide_udt_dt) {
		super();
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_jobfair_divide_st = fap_jobfair_divide_st;
		this.fap_jobfair_divide_et = fap_jobfair_divide_et;
		this.fap_jobfair_divide_app_st = fap_jobfair_divide_app_st;
		this.fap_jobfair_divide_app_et = fap_jobfair_divide_app_et;
		this.fap_jobfair_divide_app_num = fap_jobfair_divide_app_num;
		this.fap_jobfair_divide_detail = fap_jobfair_divide_detail;
		this.fap_jobfair_divide_gb = fap_jobfair_divide_gb;
		this.fap_jobfair_divide_gb_list = fap_jobfair_divide_gb_list;
		this.fap_jobfair_divide_gb_eps = fap_jobfair_divide_gb_eps;
		this.fap_jobfair_divide_ins_id = fap_jobfair_divide_ins_id;
		this.fap_jobfair_divide_ins_dt = fap_jobfair_divide_ins_dt;
		this.fap_jobfair_divide_udt_id = fap_jobfair_divide_udt_id;
		this.fap_jobfair_divide_udt_dt = fap_jobfair_divide_udt_dt;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_jobfair_divide_st() {
		return fap_jobfair_divide_st;
	}

	public void setFap_jobfair_divide_st(String fap_jobfair_divide_st) {
		this.fap_jobfair_divide_st = fap_jobfair_divide_st;
	}

	public String getFap_jobfair_divide_et() {
		return fap_jobfair_divide_et;
	}

	public void setFap_jobfair_divide_et(String fap_jobfair_divide_et) {
		this.fap_jobfair_divide_et = fap_jobfair_divide_et;
	}

	public String getFap_jobfair_divide_app_st() {
		return fap_jobfair_divide_app_st;
	}

	public void setFap_jobfair_divide_app_st(String fap_jobfair_divide_app_st) {
		this.fap_jobfair_divide_app_st = fap_jobfair_divide_app_st;
	}

	public String getFap_jobfair_divide_app_et() {
		return fap_jobfair_divide_app_et;
	}

	public void setFap_jobfair_divide_app_et(String fap_jobfair_divide_app_et) {
		this.fap_jobfair_divide_app_et = fap_jobfair_divide_app_et;
	}

	public int getFap_jobfair_divide_app_num() {
		return fap_jobfair_divide_app_num;
	}

	public void setFap_jobfair_divide_app_num(int fap_jobfair_divide_app_num) {
		this.fap_jobfair_divide_app_num = fap_jobfair_divide_app_num;
	}

	public String getFap_jobfair_divide_detail() {
		return fap_jobfair_divide_detail;
	}

	public void setFap_jobfair_divide_detail(String fap_jobfair_divide_detail) {
		this.fap_jobfair_divide_detail = fap_jobfair_divide_detail;
	}

	public String getFap_jobfair_divide_gb() {
		return fap_jobfair_divide_gb;
	}

	public void setFap_jobfair_divide_gb(String fap_jobfair_divide_gb) {
		this.fap_jobfair_divide_gb = fap_jobfair_divide_gb;
	}

	public List<SocietyFapAdminJobfairDivide> getFap_jobfair_divide_gb_list() {
		return fap_jobfair_divide_gb_list;
	}

	public void setFap_jobfair_divide_gb_list(List<SocietyFapAdminJobfairDivide> fap_jobfair_divide_gb_list) {
		this.fap_jobfair_divide_gb_list = fap_jobfair_divide_gb_list;
	}

	public String getFap_jobfair_divide_gb_eps() {
		return fap_jobfair_divide_gb_eps;
	}

	public void setFap_jobfair_divide_gb_eps(String fap_jobfair_divide_gb_eps) {
		this.fap_jobfair_divide_gb_eps = fap_jobfair_divide_gb_eps;
	}

	public String getFap_jobfair_divide_ins_id() {
		return fap_jobfair_divide_ins_id;
	}

	public void setFap_jobfair_divide_ins_id(String fap_jobfair_divide_ins_id) {
		this.fap_jobfair_divide_ins_id = fap_jobfair_divide_ins_id;
	}

	public String getFap_jobfair_divide_ins_dt() {
		return fap_jobfair_divide_ins_dt;
	}

	public void setFap_jobfair_divide_ins_dt(String fap_jobfair_divide_ins_dt) {
		this.fap_jobfair_divide_ins_dt = fap_jobfair_divide_ins_dt;
	}

	public String getFap_jobfair_divide_udt_id() {
		return fap_jobfair_divide_udt_id;
	}

	public void setFap_jobfair_divide_udt_id(String fap_jobfair_divide_udt_id) {
		this.fap_jobfair_divide_udt_id = fap_jobfair_divide_udt_id;
	}

	public String getFap_jobfair_divide_udt_dt() {
		return fap_jobfair_divide_udt_dt;
	}

	public void setFap_jobfair_divide_udt_dt(String fap_jobfair_divide_udt_dt) {
		this.fap_jobfair_divide_udt_dt = fap_jobfair_divide_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairDivide [fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", fap_jobfair_seq="
				+ fap_jobfair_seq + ", fap_jobfair_divide_st=" + fap_jobfair_divide_st + ", fap_jobfair_divide_et="
				+ fap_jobfair_divide_et + ", fap_jobfair_divide_app_st=" + fap_jobfair_divide_app_st
				+ ", fap_jobfair_divide_app_et=" + fap_jobfair_divide_app_et + ", fap_jobfair_divide_app_num="
				+ fap_jobfair_divide_app_num + ", fap_jobfair_divide_detail=" + fap_jobfair_divide_detail
				+ ", fap_jobfair_divide_gb=" + fap_jobfair_divide_gb + ", fap_jobfair_divide_gb_list="
				+ fap_jobfair_divide_gb_list + ", fap_jobfair_divide_gb_eps=" + fap_jobfair_divide_gb_eps
				+ ", fap_jobfair_divide_ins_id=" + fap_jobfair_divide_ins_id + ", fap_jobfair_divide_ins_dt="
				+ fap_jobfair_divide_ins_dt + ", fap_jobfair_divide_udt_id=" + fap_jobfair_divide_udt_id
				+ ", fap_jobfair_divide_udt_dt=" + fap_jobfair_divide_udt_dt + "]";
	}

	
}
