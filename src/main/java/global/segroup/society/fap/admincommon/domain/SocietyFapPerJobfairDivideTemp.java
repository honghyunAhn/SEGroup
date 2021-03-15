/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : 이종호
 * @Date : 2019. 1. 26.
 * @Class 설명 : 세부 잡페어별 임시 결제 VO
 * 
 */
public class SocietyFapPerJobfairDivideTemp {
    private int fap_per_jobfair_divide_temp_seq;
	private int fap_jobfair_divide_seq;
	private int fap_per_jobfair_temp_group_seq;
	private String fap_per_jobfair_divide_temp_cost;
	private String fap_per_jobfair_divide_temp_ins_id;
	private String fap_per_jobfair_divide_temp_ins_dt;
	private String fap_per_jobfair_divide_temp_udt_id;
	private String fap_per_jobfair_divide_temp_udt_dt;
	private List<SocietyFapPerJobfairDivideTemp> perJobfairDivideList;
	
	public SocietyFapPerJobfairDivideTemp() {
		super();
	}

	public SocietyFapPerJobfairDivideTemp(int fap_per_jobfair_divide_temp_seq, int fap_jobfair_divide_seq,
			int fap_per_jobfair_temp_group_seq, String fap_per_jobfair_divide_temp_cost,
			String fap_per_jobfair_divide_temp_ins_id, String fap_per_jobfair_divide_temp_ins_dt,
			String fap_per_jobfair_divide_temp_udt_id, String fap_per_jobfair_divide_temp_udt_dt,
			List<SocietyFapPerJobfairDivideTemp> perJobfairDivideList) {
		super();
		this.fap_per_jobfair_divide_temp_seq = fap_per_jobfair_divide_temp_seq;
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
		this.fap_per_jobfair_temp_group_seq = fap_per_jobfair_temp_group_seq;
		this.fap_per_jobfair_divide_temp_cost = fap_per_jobfair_divide_temp_cost;
		this.fap_per_jobfair_divide_temp_ins_id = fap_per_jobfair_divide_temp_ins_id;
		this.fap_per_jobfair_divide_temp_ins_dt = fap_per_jobfair_divide_temp_ins_dt;
		this.fap_per_jobfair_divide_temp_udt_id = fap_per_jobfair_divide_temp_udt_id;
		this.fap_per_jobfair_divide_temp_udt_dt = fap_per_jobfair_divide_temp_udt_dt;
		this.perJobfairDivideList = perJobfairDivideList;
	}

	public int getFap_per_jobfair_divide_temp_seq() {
		return fap_per_jobfair_divide_temp_seq;
	}

	public void setFap_per_jobfair_divide_temp_seq(int fap_per_jobfair_divide_temp_seq) {
		this.fap_per_jobfair_divide_temp_seq = fap_per_jobfair_divide_temp_seq;
	}

	public int getFap_jobfair_divide_seq() {
		return fap_jobfair_divide_seq;
	}

	public void setFap_jobfair_divide_seq(int fap_jobfair_divide_seq) {
		this.fap_jobfair_divide_seq = fap_jobfair_divide_seq;
	}

	public int getFap_per_jobfair_temp_group_seq() {
		return fap_per_jobfair_temp_group_seq;
	}

	public void setFap_per_jobfair_temp_group_seq(int fap_per_jobfair_temp_group_seq) {
		this.fap_per_jobfair_temp_group_seq = fap_per_jobfair_temp_group_seq;
	}

	public String getFap_per_jobfair_divide_temp_cost() {
		return fap_per_jobfair_divide_temp_cost;
	}

	public void setFap_per_jobfair_divide_temp_cost(String fap_per_jobfair_divide_temp_cost) {
		this.fap_per_jobfair_divide_temp_cost = fap_per_jobfair_divide_temp_cost;
	}

	public String getFap_per_jobfair_divide_temp_ins_id() {
		return fap_per_jobfair_divide_temp_ins_id;
	}

	public void setFap_per_jobfair_divide_temp_ins_id(String fap_per_jobfair_divide_temp_ins_id) {
		this.fap_per_jobfair_divide_temp_ins_id = fap_per_jobfair_divide_temp_ins_id;
	}

	public String getFap_per_jobfair_divide_temp_ins_dt() {
		return fap_per_jobfair_divide_temp_ins_dt;
	}

	public void setFap_per_jobfair_divide_temp_ins_dt(String fap_per_jobfair_divide_temp_ins_dt) {
		this.fap_per_jobfair_divide_temp_ins_dt = fap_per_jobfair_divide_temp_ins_dt;
	}

	public String getFap_per_jobfair_divide_temp_udt_id() {
		return fap_per_jobfair_divide_temp_udt_id;
	}

	public void setFap_per_jobfair_divide_temp_udt_id(String fap_per_jobfair_divide_temp_udt_id) {
		this.fap_per_jobfair_divide_temp_udt_id = fap_per_jobfair_divide_temp_udt_id;
	}

	public String getFap_per_jobfair_divide_temp_udt_dt() {
		return fap_per_jobfair_divide_temp_udt_dt;
	}

	public void setFap_per_jobfair_divide_temp_udt_dt(String fap_per_jobfair_divide_temp_udt_dt) {
		this.fap_per_jobfair_divide_temp_udt_dt = fap_per_jobfair_divide_temp_udt_dt;
	}

	public List<SocietyFapPerJobfairDivideTemp> getPerJobfairDivideList() {
		return perJobfairDivideList;
	}

	public void setPerJobfairDivideList(List<SocietyFapPerJobfairDivideTemp> perJobfairDivideList) {
		this.perJobfairDivideList = perJobfairDivideList;
	}

	@Override
	public String toString() {
		return "SocietyFapPerJobfairDivideTemp [fap_per_jobfair_divide_temp_seq=" + fap_per_jobfair_divide_temp_seq
				+ ", fap_jobfair_divide_seq=" + fap_jobfair_divide_seq + ", fap_per_jobfair_temp_group_seq="
				+ fap_per_jobfair_temp_group_seq + ", fap_per_jobfair_divide_temp_cost="
				+ fap_per_jobfair_divide_temp_cost + ", fap_per_jobfair_divide_temp_ins_id="
				+ fap_per_jobfair_divide_temp_ins_id + ", fap_per_jobfair_divide_temp_ins_dt="
				+ fap_per_jobfair_divide_temp_ins_dt + ", fap_per_jobfair_divide_temp_udt_id="
				+ fap_per_jobfair_divide_temp_udt_id + ", fap_per_jobfair_divide_temp_udt_dt="
				+ fap_per_jobfair_divide_temp_udt_dt + ", perJobfairDivideList=" + perJobfairDivideList + "]";
	}
}
