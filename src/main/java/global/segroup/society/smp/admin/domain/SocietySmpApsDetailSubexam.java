/**
 * 
 */
package global.segroup.society.smp.admin.domain;

/**
 * @Author : 김홍일
 * @Date : 2019. 1. 14.
 * @Class 설명 : Society 평가항목 상세평가 과목평가 VO
 * 
 */
public class SocietySmpApsDetailSubexam {

	private int smp_aps_detail_subexam_seq; // 평가 항목 그룹 시퀀스

	private int smp_aps_group_subexam_seq; // 평가 항목 종합 시퀀스

	private String smp_aps_detail_subexam_nm; // 평가 항목 그룹명

	private int smp_aps_detail_subexam_pp; // 평가 항목 합격점

	private String smp_aps_detail_subexam_ct; // 평가 항목 평가 내용

	private String smp_aps_detail_subexam_ins_id;// 등록인

	private String smp_aps_detail_subexam_ins_dt;// 등록 일자

	private String smp_aps_detail_subexam_udt_id;// 수정인

	private String smp_aps_detail_subexam_udt_dt;// 수정일자
	
	public SocietySmpApsDetailSubexam() {
		super();
	}

	public SocietySmpApsDetailSubexam(int smp_aps_detail_subexam_seq, int smp_aps_group_subexam_seq,
			String smp_aps_detail_subexam_nm, int smp_aps_detail_subexam_pp, String smp_aps_detail_subexam_ct,
			String smp_aps_detail_subexam_ins_id, String smp_aps_detail_subexam_ins_dt,
			String smp_aps_detail_subexam_udt_id, String smp_aps_detail_subexam_udt_dt) {
		super();
		this.smp_aps_detail_subexam_seq = smp_aps_detail_subexam_seq;
		this.smp_aps_group_subexam_seq = smp_aps_group_subexam_seq;
		this.smp_aps_detail_subexam_nm = smp_aps_detail_subexam_nm;
		this.smp_aps_detail_subexam_pp = smp_aps_detail_subexam_pp;
		this.smp_aps_detail_subexam_ct = smp_aps_detail_subexam_ct;
		this.smp_aps_detail_subexam_ins_id = smp_aps_detail_subexam_ins_id;
		this.smp_aps_detail_subexam_ins_dt = smp_aps_detail_subexam_ins_dt;
		this.smp_aps_detail_subexam_udt_id = smp_aps_detail_subexam_udt_id;
		this.smp_aps_detail_subexam_udt_dt = smp_aps_detail_subexam_udt_dt;
	}

	public int getSmp_aps_detail_subexam_seq() {
		return smp_aps_detail_subexam_seq;
	}

	public void setSmp_aps_detail_subexam_seq(int smp_aps_detail_subexam_seq) {
		this.smp_aps_detail_subexam_seq = smp_aps_detail_subexam_seq;
	}

	public int getSmp_aps_group_subexam_seq() {
		return smp_aps_group_subexam_seq;
	}

	public void setSmp_aps_group_subexam_seq(int smp_aps_group_subexam_seq) {
		this.smp_aps_group_subexam_seq = smp_aps_group_subexam_seq;
	}

	public String getSmp_aps_detail_subexam_nm() {
		return smp_aps_detail_subexam_nm;
	}

	public void setSmp_aps_detail_subexam_nm(String smp_aps_detail_subexam_nm) {
		this.smp_aps_detail_subexam_nm = smp_aps_detail_subexam_nm;
	}

	public int getSmp_aps_detail_subexam_pp() {
		return smp_aps_detail_subexam_pp;
	}

	public void setSmp_aps_detail_subexam_pp(int smp_aps_detail_subexam_pp) {
		this.smp_aps_detail_subexam_pp = smp_aps_detail_subexam_pp;
	}

	public String getSmp_aps_detail_subexam_ct() {
		return smp_aps_detail_subexam_ct;
	}

	public void setSmp_aps_detail_subexam_ct(String smp_aps_detail_subexam_ct) {
		this.smp_aps_detail_subexam_ct = smp_aps_detail_subexam_ct;
	}

	public String getSmp_aps_detail_subexam_ins_id() {
		return smp_aps_detail_subexam_ins_id;
	}

	public void setSmp_aps_detail_subexam_ins_id(String smp_aps_detail_subexam_ins_id) {
		this.smp_aps_detail_subexam_ins_id = smp_aps_detail_subexam_ins_id;
	}

	public String getSmp_aps_detail_subexam_ins_dt() {
		return smp_aps_detail_subexam_ins_dt;
	}

	public void setSmp_aps_detail_subexam_ins_dt(String smp_aps_detail_subexam_ins_dt) {
		this.smp_aps_detail_subexam_ins_dt = smp_aps_detail_subexam_ins_dt;
	}

	public String getSmp_aps_detail_subexam_udt_id() {
		return smp_aps_detail_subexam_udt_id;
	}

	public void setSmp_aps_detail_subexam_udt_id(String smp_aps_detail_subexam_udt_id) {
		this.smp_aps_detail_subexam_udt_id = smp_aps_detail_subexam_udt_id;
	}

	public String getSmp_aps_detail_subexam_udt_dt() {
		return smp_aps_detail_subexam_udt_dt;
	}

	public void setSmp_aps_detail_subexam_udt_dt(String smp_aps_detail_subexam_udt_dt) {
		this.smp_aps_detail_subexam_udt_dt = smp_aps_detail_subexam_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietySmpApsDetailSubexam [smp_aps_detail_subexam_seq=" + smp_aps_detail_subexam_seq
				+ ", smp_aps_group_subexam_seq=" + smp_aps_group_subexam_seq + ", smp_aps_detail_subexam_nm="
				+ smp_aps_detail_subexam_nm + ", smp_aps_detail_subexam_pp=" + smp_aps_detail_subexam_pp
				+ ", smp_aps_detail_subexam_ct=" + smp_aps_detail_subexam_ct + ", smp_aps_detail_subexam_ins_id="
				+ smp_aps_detail_subexam_ins_id + ", smp_aps_detail_subexam_ins_dt=" + smp_aps_detail_subexam_ins_dt
				+ ", smp_aps_detail_subexam_udt_id=" + smp_aps_detail_subexam_udt_id
				+ ", smp_aps_detail_subexam_udt_dt=" + smp_aps_detail_subexam_udt_dt + "]";
	}

}
