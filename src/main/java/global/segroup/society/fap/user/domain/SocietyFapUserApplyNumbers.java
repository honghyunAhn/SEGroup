/**
 * 
 */
package global.segroup.society.fap.user.domain;

import java.util.ArrayList;

/**
 * @Author : Administrator
 * @Date : 2019. 2. 25.
 * @Class 설명 : 잡페어별 취업지원자 지망개수 설정
 * 
 */
public class SocietyFapUserApplyNumbers {

	/**
	 * 잡페어별 취업지원자 지망개수설정 일련번호
	 */
	private long fap_user_apply_numbers_seq;
	
	/**
	 * 회원 아이디
	 */
	private  String user_id;
	
	/**
	 * 잡페어 세부 일련번호
	 */
	private int fap_jobfair_divide_seq;

	/**
	 * 잡페어별 취업지원자의 설정된 지망 개수
	 */
	private int fap_user_apply_numbers_fixed;	
	
	/**
	 * 잡페어별 취업지원자 현재 지망한 개수
	 */
	private int fap_user_apply_numbers_count;	
	
	/**
	 * 자동/수동 설정구분(공통코드)
	 */
	private String fap_user_apply_numbers_auto_gb;	
	
	/**
	 * 등록자
	 */
	private String fap_user_apply_numbers_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_user_apply_numbers_ins_dt;	
	
	/**
	 * 수정자
	 */
	private String fap_user_apply_numbers_udt_id;	
	
	/**
	 * 수정일
	 */
	private String fap_user_apply_numbers_udt_dt;

	/**
	 * 리스트
	 */
	private ArrayList<SocietyFapUserApplyNumbers> fap_user_apply_numbers_list;
	
	public SocietyFapUserApplyNumbers() {
		super();
	}

	public SocietyFapUserApplyNumbers(long fap_user_apply_numbers_seq, String user_id, int fap_jobfair_divide_seq,
			int fap_user_apply_numbers_fixed, int fap_user_apply_numbers_count, String fap_user_apply_numbers_auto_gb,
			String fap_user_apply_numbers_ins_id, String fap_user_apply_numbers_ins_dt,
			String fap_user_apply_numbers_udt_id, String fap_user_apply_numbers_udt_dt,
			ArrayList<SocietyFapUserApplyNumbers> fap_user_apply_numbers_list) {
		super();
		this.fap_user_apply_numbers_seq = fap_user_apply_numbers_seq;
		this.user_id = user_id;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_user_apply_numbers_fixed = fap_user_apply_numbers_fixed;
		this.fap_user_apply_numbers_count = fap_user_apply_numbers_count;
		this.fap_user_apply_numbers_auto_gb = fap_user_apply_numbers_auto_gb;
		this.fap_user_apply_numbers_ins_id = fap_user_apply_numbers_ins_id;
		this.fap_user_apply_numbers_ins_dt = fap_user_apply_numbers_ins_dt;
		this.fap_user_apply_numbers_udt_id = fap_user_apply_numbers_udt_id;
		this.fap_user_apply_numbers_udt_dt = fap_user_apply_numbers_udt_dt;
		this.fap_user_apply_numbers_list = fap_user_apply_numbers_list;
	}

	public long getFap_user_apply_numbers_seq() {
		return fap_user_apply_numbers_seq;
	}

	public void setFap_user_apply_numbers_seq(long fap_user_apply_numbers_seq) {
		this.fap_user_apply_numbers_seq = fap_user_apply_numbers_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public int getFap_user_apply_numbers_fixed() {
		return fap_user_apply_numbers_fixed;
	}

	public void setFap_user_apply_numbers_fixed(int fap_user_apply_numbers_fixed) {
		this.fap_user_apply_numbers_fixed = fap_user_apply_numbers_fixed;
	}

	public int getFap_user_apply_numbers_count() {
		return fap_user_apply_numbers_count;
	}

	public void setFap_user_apply_numbers_count(int fap_user_apply_numbers_count) {
		this.fap_user_apply_numbers_count = fap_user_apply_numbers_count;
	}

	public String getFap_user_apply_numbers_auto_gb() {
		return fap_user_apply_numbers_auto_gb;
	}

	public void setFap_user_apply_numbers_auto_gb(String fap_user_apply_numbers_auto_gb) {
		this.fap_user_apply_numbers_auto_gb = fap_user_apply_numbers_auto_gb;
	}

	public String getFap_user_apply_numbers_ins_id() {
		return fap_user_apply_numbers_ins_id;
	}

	public void setFap_user_apply_numbers_ins_id(String fap_user_apply_numbers_ins_id) {
		this.fap_user_apply_numbers_ins_id = fap_user_apply_numbers_ins_id;
	}

	public String getFap_user_apply_numbers_ins_dt() {
		return fap_user_apply_numbers_ins_dt;
	}

	public void setFap_user_apply_numbers_ins_dt(String fap_user_apply_numbers_ins_dt) {
		this.fap_user_apply_numbers_ins_dt = fap_user_apply_numbers_ins_dt;
	}

	public String getFap_user_apply_numbers_udt_id() {
		return fap_user_apply_numbers_udt_id;
	}

	public void setFap_user_apply_numbers_udt_id(String fap_user_apply_numbers_udt_id) {
		this.fap_user_apply_numbers_udt_id = fap_user_apply_numbers_udt_id;
	}

	public String getFap_user_apply_numbers_udt_dt() {
		return fap_user_apply_numbers_udt_dt;
	}

	public void setFap_user_apply_numbers_udt_dt(String fap_user_apply_numbers_udt_dt) {
		this.fap_user_apply_numbers_udt_dt = fap_user_apply_numbers_udt_dt;
	}

	public ArrayList<SocietyFapUserApplyNumbers> getFap_user_apply_numbers_list() {
		return fap_user_apply_numbers_list;
	}

	public void setFap_user_apply_numbers_list(ArrayList<SocietyFapUserApplyNumbers> fap_user_apply_numbers_list) {
		this.fap_user_apply_numbers_list = fap_user_apply_numbers_list;
	}

	@Override
	public String toString() {
		return "SocietyFapUserApplyNumbers [fap_user_apply_numbers_seq=" + fap_user_apply_numbers_seq + ", user_id="
				+ user_id + ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", fap_user_apply_numbers_fixed="
				+ fap_user_apply_numbers_fixed + ", fap_user_apply_numbers_count=" + fap_user_apply_numbers_count
				+ ", fap_user_apply_numbers_auto_gb=" + fap_user_apply_numbers_auto_gb
				+ ", fap_user_apply_numbers_ins_id=" + fap_user_apply_numbers_ins_id
				+ ", fap_user_apply_numbers_ins_dt=" + fap_user_apply_numbers_ins_dt
				+ ", fap_user_apply_numbers_udt_id=" + fap_user_apply_numbers_udt_id
				+ ", fap_user_apply_numbers_udt_dt=" + fap_user_apply_numbers_udt_dt + ", fap_user_apply_numbers_list="
				+ fap_user_apply_numbers_list + "]";
	}

}
