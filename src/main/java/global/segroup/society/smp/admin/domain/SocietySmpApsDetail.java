package global.segroup.society.smp.admin.domain;


/**
 * @Author : 강인석
 * @Date : 2018. 9. 10.
 * @Class 설명 : Society 평가항목 VO
 * 
 */


public class SocietySmpApsDetail {

	private int smp_aps_detail_seq; // 평가 항목 상세 시퀀스

	private int smp_aps_group_seq; // 평가 항목 그룹 시퀀스

	private String smp_aps_detail_nm; // 평가 항목 상세명

	private int smp_aps_detail_ratio; // 평가 항목 상세 비율

	private String smp_aps_detail_ins_id; // 등록인

	private String smp_aps_detail_ins_dt; // 등록 일자

	private String smp_aps_detail_udt_id; // 수정인

	private String smp_aps_detail_udt_dt; // 수정 일자

	public SocietySmpApsDetail() {
		super();
	}

	public SocietySmpApsDetail(int smp_aps_detail_seq, int smp_aps_group_seq, String smp_aps_detail_nm,
			int smp_aps_detail_ratio, String smp_aps_detail_ins_id, String smp_aps_detail_ins_dt,
			String smp_aps_detail_udt_id, String smp_aps_detail_udt_dt) {
		super();
		this.smp_aps_detail_seq = smp_aps_detail_seq;
		this.smp_aps_group_seq = smp_aps_group_seq;
		this.smp_aps_detail_nm = smp_aps_detail_nm;
		this.smp_aps_detail_ratio = smp_aps_detail_ratio;
		this.smp_aps_detail_ins_id = smp_aps_detail_ins_id;
		this.smp_aps_detail_ins_dt = smp_aps_detail_ins_dt;
		this.smp_aps_detail_udt_id = smp_aps_detail_udt_id;
		this.smp_aps_detail_udt_dt = smp_aps_detail_udt_dt;
	}

	public int getSmp_aps_detail_seq() {
		return smp_aps_detail_seq;
	}

	public void setSmp_aps_detail_seq(int smp_aps_detail_seq) {
		this.smp_aps_detail_seq = smp_aps_detail_seq;
	}

	public int getSmp_aps_group_seq() {
		return smp_aps_group_seq;
	}

	public void setSmp_aps_group_seq(int smp_aps_group_seq) {
		this.smp_aps_group_seq = smp_aps_group_seq;
	}

	public String getSmp_aps_detail_nm() {
		return smp_aps_detail_nm;
	}

	public void setSmp_aps_detail_nm(String smp_aps_detail_nm) {
		this.smp_aps_detail_nm = smp_aps_detail_nm;
	}

	public int getSmp_aps_detail_ratio() {
		return smp_aps_detail_ratio;
	}

	public void setSmp_aps_detail_ratio(int smp_aps_detail_ratio) {
		this.smp_aps_detail_ratio = smp_aps_detail_ratio;
	}

	public String getSmp_aps_detail_ins_id() {
		return smp_aps_detail_ins_id;
	}

	public void setSmp_aps_detail_ins_id(String smp_aps_detail_ins_id) {
		this.smp_aps_detail_ins_id = smp_aps_detail_ins_id;
	}

	public String getSmp_aps_detail_ins_dt() {
		return smp_aps_detail_ins_dt;
	}

	public void setSmp_aps_detail_ins_dt(String smp_aps_detail_ins_dt) {
		this.smp_aps_detail_ins_dt = smp_aps_detail_ins_dt;
	}

	public String getSmp_aps_detail_udt_id() {
		return smp_aps_detail_udt_id;
	}

	public void setSmp_aps_detail_udt_id(String smp_aps_detail_udt_id) {
		this.smp_aps_detail_udt_id = smp_aps_detail_udt_id;
	}

	public String getSmp_aps_detail_udt_dt() {
		return smp_aps_detail_udt_dt;
	}

	public void setSmp_aps_detail_udt_dt(String smp_aps_detail_udt_dt) {
		this.smp_aps_detail_udt_dt = smp_aps_detail_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietySmpGradeDetail [smp_aps_detail_seq=" + smp_aps_detail_seq + ", smp_aps_group_seq="
				+ smp_aps_group_seq + ", smp_aps_detail_nm=" + smp_aps_detail_nm + ", smp_aps_detail_ratio="
				+ smp_aps_detail_ratio + ", smp_aps_detail_ins_id=" + smp_aps_detail_ins_id + ", smp_aps_detail_ins_dt="
				+ smp_aps_detail_ins_dt + ", smp_aps_detail_udt_id=" + smp_aps_detail_udt_id
				+ ", smp_aps_detail_udt_dt=" + smp_aps_detail_udt_dt + "]";
	}

}
