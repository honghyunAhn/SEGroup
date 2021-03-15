/**
 * 
 */
package global.segroup.society.smp.admin.domain;

/**
 * @Author : 김홍일
 * @Date : 2019. 1. 14.
 * @Class 설명 : Society 평가항목 그룹평가 정규시험 VO
 * 
 */
public class SocietySmpApsGroupExam {

	private int smp_aps_group_exam_seq; // 평가 항목 그룹 시퀀스

	private int smp_aps_group_seq; // 평가 항목 종합 시퀀스

	private String smp_aps_group_exam_nm; // 평가 항목 그룹명

	private String smp_aps_group_exam_ratio; // 평가 항목 그룹 비율

	private String smp_aps_group_exam_pp; // 평가 항목 합격점

	private String smp_aps_group_exam_ct; // 평가 항목 평가 내용

	private String smp_aps_group_exam_ins_id;// 등록인

	private String smp_aps_group_exam_ins_dt;// 등록 일자

	private String smp_aps_group_exam_udt_id;// 수정인

	private String smp_aps_group_exam_udt_dt;// 수정일자

	public SocietySmpApsGroupExam() {
		super();
	}

	public SocietySmpApsGroupExam(int smp_aps_group_exam_seq, int smp_aps_group_seq, String smp_aps_group_exam_nm,
			String smp_aps_group_exam_ratio, String smp_aps_group_exam_pp, String smp_aps_group_exam_ct,
			String smp_aps_group_exam_ins_id, String smp_aps_group_exam_ins_dt, String smp_aps_group_exam_udt_id,
			String smp_aps_group_exam_udt_dt) {
		super();
		this.smp_aps_group_exam_seq = smp_aps_group_exam_seq;
		this.smp_aps_group_seq = smp_aps_group_seq;
		this.smp_aps_group_exam_nm = smp_aps_group_exam_nm;
		this.smp_aps_group_exam_ratio = smp_aps_group_exam_ratio;
		this.smp_aps_group_exam_pp = smp_aps_group_exam_pp;
		this.smp_aps_group_exam_ct = smp_aps_group_exam_ct;
		this.smp_aps_group_exam_ins_id = smp_aps_group_exam_ins_id;
		this.smp_aps_group_exam_ins_dt = smp_aps_group_exam_ins_dt;
		this.smp_aps_group_exam_udt_id = smp_aps_group_exam_udt_id;
		this.smp_aps_group_exam_udt_dt = smp_aps_group_exam_udt_dt;
	}



	public int getSmp_aps_group_exam_seq() {
		return smp_aps_group_exam_seq;
	}



	public void setSmp_aps_group_exam_seq(int smp_aps_group_exam_seq) {
		this.smp_aps_group_exam_seq = smp_aps_group_exam_seq;
	}



	public int getSmp_aps_group_seq() {
		return smp_aps_group_seq;
	}



	public void setSmp_aps_group_seq(int smp_aps_group_seq) {
		this.smp_aps_group_seq = smp_aps_group_seq;
	}



	public String getSmp_aps_group_exam_nm() {
		return smp_aps_group_exam_nm;
	}



	public void setSmp_aps_group_exam_nm(String smp_aps_group_exam_nm) {
		this.smp_aps_group_exam_nm = smp_aps_group_exam_nm;
	}



	public String getSmp_aps_group_exam_ratio() {
		return smp_aps_group_exam_ratio;
	}



	public void setSmp_aps_group_exam_ratio(String smp_aps_group_exam_ratio) {
		this.smp_aps_group_exam_ratio = smp_aps_group_exam_ratio;
	}



	public String getSmp_aps_group_exam_pp() {
		return smp_aps_group_exam_pp;
	}



	public void setSmp_aps_group_exam_pp(String smp_aps_group_exam_pp) {
		this.smp_aps_group_exam_pp = smp_aps_group_exam_pp;
	}



	public String getSmp_aps_group_exam_ct() {
		return smp_aps_group_exam_ct;
	}



	public void setSmp_aps_group_exam_ct(String smp_aps_group_exam_ct) {
		this.smp_aps_group_exam_ct = smp_aps_group_exam_ct;
	}



	public String getSmp_aps_group_exam_ins_id() {
		return smp_aps_group_exam_ins_id;
	}



	public void setSmp_aps_group_exam_ins_id(String smp_aps_group_exam_ins_id) {
		this.smp_aps_group_exam_ins_id = smp_aps_group_exam_ins_id;
	}



	public String getSmp_aps_group_exam_ins_dt() {
		return smp_aps_group_exam_ins_dt;
	}



	public void setSmp_aps_group_exam_ins_dt(String smp_aps_group_exam_ins_dt) {
		this.smp_aps_group_exam_ins_dt = smp_aps_group_exam_ins_dt;
	}



	public String getSmp_aps_group_exam_udt_id() {
		return smp_aps_group_exam_udt_id;
	}



	public void setSmp_aps_group_exam_udt_id(String smp_aps_group_exam_udt_id) {
		this.smp_aps_group_exam_udt_id = smp_aps_group_exam_udt_id;
	}



	public String getSmp_aps_group_exam_udt_dt() {
		return smp_aps_group_exam_udt_dt;
	}



	public void setSmp_aps_group_exam_udt_dt(String smp_aps_group_exam_udt_dt) {
		this.smp_aps_group_exam_udt_dt = smp_aps_group_exam_udt_dt;
	}



	@Override
	public String toString() {
		return "SocietySmpApsGroupExam [smp_aps_group_exam_seq=" + smp_aps_group_exam_seq + ", smp_aps_group_seq="
				+ smp_aps_group_seq + ", smp_aps_group_exam_nm=" + smp_aps_group_exam_nm + ", smp_aps_group_exam_ratio="
				+ smp_aps_group_exam_ratio + ", smp_aps_group_exam_pp=" + smp_aps_group_exam_pp
				+ ", smp_aps_group_exam_ct=" + smp_aps_group_exam_ct + ", smp_aps_group_exam_ins_id="
				+ smp_aps_group_exam_ins_id + ", smp_aps_group_exam_ins_dt=" + smp_aps_group_exam_ins_dt
				+ ", smp_aps_group_exam_udt_id=" + smp_aps_group_exam_udt_id + ", smp_aps_group_exam_udt_dt="
				+ smp_aps_group_exam_udt_dt + "]";
	}

}