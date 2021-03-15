/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : 신동철
 * @Date : 2018. 12. 29.
 * @Class 설명 :  채용기업의 그룹 구분
 * 
 */
public class SocietyFapAdminJobfairCompGroup {

	/**
	 * 채용기업의 그룹 구분 설정 시퀀스
	 */
	private int fap_comp_group_set_seq;
	
	/**
	 * 잡페어 시퀀스
	 */
	private int fap_jobfair_seq;
	
	/**
	 * 채용기업 그룹그분
	 */
	private String fap_comp_groupcode;
	
	/**
	 * 채용기업 자본금
	 */
	private long fap_comp_stock;
	
	/**
	 * 채용기업 3년간 평균 매출액
	 */
	private long fap_comp_3years_avg_sales;
	
	/**
	 * 채용기업 사원수
	 */
	private int fap_comp_employee_num;
	
	/**
	 * 채용기업 그룹 구분 리스트
	 */
	private List<SocietyFapAdminJobfairCompGroup> fap_comp_group_list;
	
	/**
	 * 등록자
	 */
	private String fap_comp_group_ins_id;
	
	/**
	 * 등록일
	 */
	private String fap_comp_group_ins_dt;
	
	/**
	 * 수정자
	 */
	private String fap_comp_group_udt_id;
	
	/**
	 * 수정일
	 */
	private String fap_comp_group_udt_dt;

	public SocietyFapAdminJobfairCompGroup() {
		super();
	}

	public SocietyFapAdminJobfairCompGroup(int fap_comp_group_set_seq, int fap_jobfair_seq, String fap_comp_groupcode,
			long fap_comp_stock, long fap_comp_3years_avg_sales, int fap_comp_employee_num,
			List<SocietyFapAdminJobfairCompGroup> fap_comp_group_list, String fap_comp_group_ins_id,
			String fap_comp_group_ins_dt, String fap_comp_group_udt_id, String fap_comp_group_udt_dt) {
		super();
		this.fap_comp_group_set_seq = fap_comp_group_set_seq;
		this.fap_jobfair_seq = fap_jobfair_seq;
		this.fap_comp_groupcode = fap_comp_groupcode;
		this.fap_comp_stock = fap_comp_stock;
		this.fap_comp_3years_avg_sales = fap_comp_3years_avg_sales;
		this.fap_comp_employee_num = fap_comp_employee_num;
		this.fap_comp_group_list = fap_comp_group_list;
		this.fap_comp_group_ins_id = fap_comp_group_ins_id;
		this.fap_comp_group_ins_dt = fap_comp_group_ins_dt;
		this.fap_comp_group_udt_id = fap_comp_group_udt_id;
		this.fap_comp_group_udt_dt = fap_comp_group_udt_dt;
	}

	public int getFap_comp_group_set_seq() {
		return fap_comp_group_set_seq;
	}

	public void setFap_comp_group_set_seq(int fap_comp_group_set_seq) {
		this.fap_comp_group_set_seq = fap_comp_group_set_seq;
	}

	public int getFap_jobfair_seq() {
		return fap_jobfair_seq;
	}

	public void setFap_jobfair_seq(int fap_jobfair_seq) {
		this.fap_jobfair_seq = fap_jobfair_seq;
	}

	public String getFap_comp_groupcode() {
		return fap_comp_groupcode;
	}

	public void setFap_comp_groupcode(String fap_comp_groupcode) {
		this.fap_comp_groupcode = fap_comp_groupcode;
	}

	public long getFap_comp_stock() {
		return fap_comp_stock;
	}

	public void setFap_comp_stock(long fap_comp_stock) {
		this.fap_comp_stock = fap_comp_stock;
	}

	public long getFap_comp_3years_avg_sales() {
		return fap_comp_3years_avg_sales;
	}

	public void setFap_comp_3years_avg_sales(long fap_comp_3years_avg_sales) {
		this.fap_comp_3years_avg_sales = fap_comp_3years_avg_sales;
	}

	public int getFap_comp_employee_num() {
		return fap_comp_employee_num;
	}

	public void setFap_comp_employee_num(int fap_comp_employee_num) {
		this.fap_comp_employee_num = fap_comp_employee_num;
	}

	public List<SocietyFapAdminJobfairCompGroup> getFap_comp_group_list() {
		return fap_comp_group_list;
	}

	public void setFap_comp_group_list(List<SocietyFapAdminJobfairCompGroup> fap_comp_group_list) {
		this.fap_comp_group_list = fap_comp_group_list;
	}

	public String getFap_comp_group_ins_id() {
		return fap_comp_group_ins_id;
	}

	public void setFap_comp_group_ins_id(String fap_comp_group_ins_id) {
		this.fap_comp_group_ins_id = fap_comp_group_ins_id;
	}

	public String getFap_comp_group_ins_dt() {
		return fap_comp_group_ins_dt;
	}

	public void setFap_comp_group_ins_dt(String fap_comp_group_ins_dt) {
		this.fap_comp_group_ins_dt = fap_comp_group_ins_dt;
	}

	public String getFap_comp_group_udt_id() {
		return fap_comp_group_udt_id;
	}

	public void setFap_comp_group_udt_id(String fap_comp_group_udt_id) {
		this.fap_comp_group_udt_id = fap_comp_group_udt_id;
	}

	public String getFap_comp_group_udt_dt() {
		return fap_comp_group_udt_dt;
	}

	public void setFap_comp_group_udt_dt(String fap_comp_group_udt_dt) {
		this.fap_comp_group_udt_dt = fap_comp_group_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairCompGroup [fap_comp_group_set_seq=" + fap_comp_group_set_seq
				+ ", fap_jobfair_seq=" + fap_jobfair_seq + ", fap_comp_groupcode=" + fap_comp_groupcode
				+ ", fap_comp_stock=" + fap_comp_stock + ", fap_comp_3years_avg_sales=" + fap_comp_3years_avg_sales
				+ ", fap_comp_employee_num=" + fap_comp_employee_num + ", fap_comp_group_list=" + fap_comp_group_list
				+ ", fap_comp_group_ins_id=" + fap_comp_group_ins_id + ", fap_comp_group_ins_dt="
				+ fap_comp_group_ins_dt + ", fap_comp_group_udt_id=" + fap_comp_group_udt_id
				+ ", fap_comp_group_udt_dt=" + fap_comp_group_udt_dt + "]";
	}

}
