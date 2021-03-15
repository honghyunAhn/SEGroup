package global.segroup.society.smp.admin.domain;

public class SocietySmpApsSetDetail {
	
	private int smp_aps_setdetail_seq;
	private int smp_aps_setgroup_seq;
	private String smp_aps_setdetail_nm;
	private int smp_aps_setdetail_ratio;
	private String smp_aps_setdetail_ins_id;
	private String smp_aps_setdetail_ins_dt;
	private String smp_aps_setdetail_udt_id;
	private String smp_aps_setdetail_udt_dt;

	
	public SocietySmpApsSetDetail(){
	}


	public SocietySmpApsSetDetail(int smp_aps_setdetail_seq, int smp_aps_setgroup_seq, String smp_aps_setdetail_nm,
			int smp_aps_setdetail_ratio, String smp_aps_setdetail_ins_id, String smp_aps_setdetail_ins_dt,
			String smp_aps_setdetail_udt_id, String smp_aps_setdetail_udt_dt) {
		super();
		this.smp_aps_setdetail_seq = smp_aps_setdetail_seq;
		this.smp_aps_setgroup_seq = smp_aps_setgroup_seq;
		this.smp_aps_setdetail_nm = smp_aps_setdetail_nm;
		this.smp_aps_setdetail_ratio = smp_aps_setdetail_ratio;
		this.smp_aps_setdetail_ins_id = smp_aps_setdetail_ins_id;
		this.smp_aps_setdetail_ins_dt = smp_aps_setdetail_ins_dt;
		this.smp_aps_setdetail_udt_id = smp_aps_setdetail_udt_id;
		this.smp_aps_setdetail_udt_dt = smp_aps_setdetail_udt_dt;
	}


	public int getSmp_aps_setdetail_seq() {
		return smp_aps_setdetail_seq;
	}


	public void setSmp_aps_setdetail_seq(int smp_aps_setdetail_seq) {
		this.smp_aps_setdetail_seq = smp_aps_setdetail_seq;
	}


	public int getSmp_aps_setgroup_seq() {
		return smp_aps_setgroup_seq;
	}


	public void setSmp_aps_setgroup_seq(int smp_aps_setgroup_seq) {
		this.smp_aps_setgroup_seq = smp_aps_setgroup_seq;
	}


	public String getSmp_aps_setdetail_nm() {
		return smp_aps_setdetail_nm;
	}


	public void setSmp_aps_setdetail_nm(String smp_aps_setdetail_nm) {
		this.smp_aps_setdetail_nm = smp_aps_setdetail_nm;
	}


	public int getSmp_aps_setdetail_ratio() {
		return smp_aps_setdetail_ratio;
	}


	public void setSmp_aps_setdetail_ratio(int smp_aps_setdetail_ratio) {
		this.smp_aps_setdetail_ratio = smp_aps_setdetail_ratio;
	}


	public String getSmp_aps_setdetail_ins_id() {
		return smp_aps_setdetail_ins_id;
	}


	public void setSmp_aps_setdetail_ins_id(String smp_aps_setdetail_ins_id) {
		this.smp_aps_setdetail_ins_id = smp_aps_setdetail_ins_id;
	}


	public String getSmp_aps_setdetail_ins_dt() {
		return smp_aps_setdetail_ins_dt;
	}


	public void setSmp_aps_setdetail_ins_dt(String smp_aps_setdetail_ins_dt) {
		this.smp_aps_setdetail_ins_dt = smp_aps_setdetail_ins_dt;
	}


	public String getSmp_aps_setdetail_udt_id() {
		return smp_aps_setdetail_udt_id;
	}


	public void setSmp_aps_setdetail_udt_id(String smp_aps_setdetail_udt_id) {
		this.smp_aps_setdetail_udt_id = smp_aps_setdetail_udt_id;
	}


	public String getSmp_aps_setdetail_udt_dt() {
		return smp_aps_setdetail_udt_dt;
	}


	public void setSmp_aps_setdetail_udt_dt(String smp_aps_setdetail_udt_dt) {
		this.smp_aps_setdetail_udt_dt = smp_aps_setdetail_udt_dt;
	}


	@Override
	public String toString() {
		return "SmpApsSetDetail [smp_aps_setdetail_seq=" + smp_aps_setdetail_seq + ", smp_aps_setgroup_seq="
				+ smp_aps_setgroup_seq + ", smp_aps_setdetail_nm=" + smp_aps_setdetail_nm + ", smp_aps_setdetail_ratio="
				+ smp_aps_setdetail_ratio + ", smp_aps_setdetail_ins_id=" + smp_aps_setdetail_ins_id
				+ ", smp_aps_setdetail_ins_dt=" + smp_aps_setdetail_ins_dt + ", smp_aps_setdetail_udt_id="
				+ smp_aps_setdetail_udt_id + ", smp_aps_setdetail_udt_dt=" + smp_aps_setdetail_udt_dt + "]";
	}

	
	
}
