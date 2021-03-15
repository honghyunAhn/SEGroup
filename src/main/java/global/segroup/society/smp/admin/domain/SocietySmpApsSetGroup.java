package global.segroup.society.smp.admin.domain;

public class SocietySmpApsSetGroup {
	
	private int smp_aps_setgroup_seq;
	private int smp_aps_settotal_seq;
	private String smp_aps_setgroup_nm;
	private int smp_aps_setgroup_ratio;
	private String smp_aps_setgroup_tp;
	private String smp_aps_setgroup_ins_id;
	private String smp_aps_setgroup_ins_dt;
	private String smp_aps_setgroup_udt_id;
	private String smp_aps_setgroup_udt_dt;
	
	public SocietySmpApsSetGroup(){
	}

	public SocietySmpApsSetGroup(int smp_aps_setgroup_seq, int smp_aps_settotal_seq, String smp_aps_setgroup_nm,
			int smp_aps_setgroup_ratio, String smp_aps_setgroup_tp, String smp_aps_setgroup_ins_id,
			String smp_aps_setgroup_ins_dt, String smp_aps_setgroup_udt_id, String smp_aps_setgroup_udt_dt) {
		super();
		this.smp_aps_setgroup_seq = smp_aps_setgroup_seq;
		this.smp_aps_settotal_seq = smp_aps_settotal_seq;
		this.smp_aps_setgroup_nm = smp_aps_setgroup_nm;
		this.smp_aps_setgroup_ratio = smp_aps_setgroup_ratio;
		this.smp_aps_setgroup_tp = smp_aps_setgroup_tp;
		this.smp_aps_setgroup_ins_id = smp_aps_setgroup_ins_id;
		this.smp_aps_setgroup_ins_dt = smp_aps_setgroup_ins_dt;
		this.smp_aps_setgroup_udt_id = smp_aps_setgroup_udt_id;
		this.smp_aps_setgroup_udt_dt = smp_aps_setgroup_udt_dt;
	}

	public int getSmp_aps_setgroup_seq() {
		return smp_aps_setgroup_seq;
	}

	public void setSmp_aps_setgroup_seq(int smp_aps_setgroup_seq) {
		this.smp_aps_setgroup_seq = smp_aps_setgroup_seq;
	}

	public int getSmp_aps_settotal_seq() {
		return smp_aps_settotal_seq;
	}

	public void setSmp_aps_settotal_seq(int smp_aps_settotal_seq) {
		this.smp_aps_settotal_seq = smp_aps_settotal_seq;
	}

	public String getSmp_aps_setgroup_nm() {
		return smp_aps_setgroup_nm;
	}

	public void setSmp_aps_setgroup_nm(String smp_aps_setgroup_nm) {
		this.smp_aps_setgroup_nm = smp_aps_setgroup_nm;
	}

	public int getSmp_aps_setgroup_ratio() {
		return smp_aps_setgroup_ratio;
	}

	public void setSmp_aps_setgroup_ratio(int smp_aps_setgroup_ratio) {
		this.smp_aps_setgroup_ratio = smp_aps_setgroup_ratio;
	}

	public String getSmp_aps_setgroup_tp() {
		return smp_aps_setgroup_tp;
	}

	public void setSmp_aps_setgroup_tp(String smp_aps_setgroup_tp) {
		this.smp_aps_setgroup_tp = smp_aps_setgroup_tp;
	}

	public String getSmp_aps_setgroup_ins_id() {
		return smp_aps_setgroup_ins_id;
	}

	public void setSmp_aps_setgroup_ins_id(String smp_aps_setgroup_ins_id) {
		this.smp_aps_setgroup_ins_id = smp_aps_setgroup_ins_id;
	}

	public String getSmp_aps_setgroup_ins_dt() {
		return smp_aps_setgroup_ins_dt;
	}

	public void setSmp_aps_setgroup_ins_dt(String smp_aps_setgroup_ins_dt) {
		this.smp_aps_setgroup_ins_dt = smp_aps_setgroup_ins_dt;
	}

	public String getSmp_aps_setgroup_udt_id() {
		return smp_aps_setgroup_udt_id;
	}

	public void setSmp_aps_setgroup_udt_id(String smp_aps_setgroup_udt_id) {
		this.smp_aps_setgroup_udt_id = smp_aps_setgroup_udt_id;
	}

	public String getSmp_aps_setgroup_udt_dt() {
		return smp_aps_setgroup_udt_dt;
	}

	public void setSmp_aps_setgroup_udt_dt(String smp_aps_setgroup_udt_dt) {
		this.smp_aps_setgroup_udt_dt = smp_aps_setgroup_udt_dt;
	}

	@Override
	public String toString() {
		return "SmpApsSetGroup [smp_aps_setgroup_seq=" + smp_aps_setgroup_seq + ", smp_aps_settotal_seq="
				+ smp_aps_settotal_seq + ", smp_aps_setgroup_nm=" + smp_aps_setgroup_nm + ", smp_aps_setgroup_ratio="
				+ smp_aps_setgroup_ratio + ", smp_aps_setgroup_tp=" + smp_aps_setgroup_tp + ", smp_aps_setgroup_ins_id="
				+ smp_aps_setgroup_ins_id + ", smp_aps_setgroup_ins_dt=" + smp_aps_setgroup_ins_dt
				+ ", smp_aps_setgroup_udt_id=" + smp_aps_setgroup_udt_id + ", smp_aps_setgroup_udt_dt="
				+ smp_aps_setgroup_udt_dt + "]";
	}
	
}
