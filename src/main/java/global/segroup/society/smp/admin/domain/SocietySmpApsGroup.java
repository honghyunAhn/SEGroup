package global.segroup.society.smp.admin.domain;


/**
 * @Author : 강인석
 * @Date : 2018. 9. 10.
 * @Class 설명 : Society 평가항목 VO
 * 
 */
/**
 * @Author : 김홍일(수정)
 * @Date : 2019. 1. 14.
 * @Class 설명 : Society 평가항목 VO
 * 
 */


public class SocietySmpApsGroup {

	private int smp_aps_group_seq; // 평가 항목 그룹 시퀀스

	private int smp_aps_total_seq; // 평가 항목 종합 시퀀스

	private String smp_aps_group_tp; // 평가 항목 그룹 타입(공통코드)

	private String smp_aps_group_ins_id;// 등록인

	private String smp_aps_group_ins_dt;// 등록 일자

	private String smp_aps_group_udt_id;// 수정인

	private String smp_aps_group_udt_dt;// 수정일자

	public SocietySmpApsGroup() {
		super();
	}

	public SocietySmpApsGroup(int smp_aps_group_seq, int smp_aps_total_seq, String smp_aps_group_nm, int smp_aps_group_ratio,
			String smp_aps_group_tp, String smp_aps_group_ins_id, String smp_aps_group_ins_dt,
			String smp_aps_group_udt_id, String smp_aps_group_udt_dt) {
		super();
		this.smp_aps_group_seq = smp_aps_group_seq;
		this.smp_aps_total_seq = smp_aps_total_seq;
		this.smp_aps_group_tp = smp_aps_group_tp;
		this.smp_aps_group_ins_id = smp_aps_group_ins_id;
		this.smp_aps_group_ins_dt = smp_aps_group_ins_dt;
		this.smp_aps_group_udt_id = smp_aps_group_udt_id;
		this.smp_aps_group_udt_dt = smp_aps_group_udt_dt;
	}

	public int getSmp_aps_group_seq() {
		return smp_aps_group_seq;
	}

	public void setSmp_aps_group_seq(int smp_aps_group_seq) {
		this.smp_aps_group_seq = smp_aps_group_seq;
	}

	public int getSmp_aps_total_seq() {
		return smp_aps_total_seq;
	}

	public void setSmp_aps_total_seq(int smp_aps_total_seq) {
		this.smp_aps_total_seq = smp_aps_total_seq;
	}

	public String getSmp_aps_group_tp() {
		return smp_aps_group_tp;
	}

	public void setSmp_aps_group_tp(String smp_aps_group_tp) {
		this.smp_aps_group_tp = smp_aps_group_tp;
	}

	public String getSmp_aps_group_ins_id() {
		return smp_aps_group_ins_id;
	}

	public void setSmp_aps_group_ins_id(String smp_aps_group_ins_id) {
		this.smp_aps_group_ins_id = smp_aps_group_ins_id;
	}

	public String getSmp_aps_group_ins_dt() {
		return smp_aps_group_ins_dt;
	}

	public void setSmp_aps_group_ins_dt(String smp_aps_group_ins_dt) {
		this.smp_aps_group_ins_dt = smp_aps_group_ins_dt;
	}

	public String getSmp_aps_group_udt_id() {
		return smp_aps_group_udt_id;
	}

	public void setSmp_aps_group_udt_id(String smp_aps_group_udt_id) {
		this.smp_aps_group_udt_id = smp_aps_group_udt_id;
	}

	public String getSmp_aps_group_udt_dt() {
		return smp_aps_group_udt_dt;
	}

	public void setSmp_aps_group_udt_dt(String smp_aps_group_udt_dt) {
		this.smp_aps_group_udt_dt = smp_aps_group_udt_dt;
	}

	@Override
	public String toString() {
		return "SmpApsGroup [smp_aps_group_seq=" + smp_aps_group_seq + ", smp_aps_total_seq=" + smp_aps_total_seq
				+ ", smp_aps_group_tp=" + smp_aps_group_tp + ", smp_aps_group_ins_id=" + smp_aps_group_ins_id
				+ ", smp_aps_group_ins_dt=" + smp_aps_group_ins_dt + ", smp_aps_group_udt_id=" + smp_aps_group_udt_id
				+ ", smp_aps_group_udt_dt=" + smp_aps_group_udt_dt + "]";
	}
	
	
}
