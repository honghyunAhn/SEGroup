package global.segroup.society.smp.admin.domain;

public class SocietySmpApsSetTotal {
	
	private int smp_aps_settotal_seq;
	private int smp_aps_setlist_seq;
	private String smp_aps_settotal_nm;
	private int smp_aps_settotal_ratio;
	private String smp_aps_settotal_ins_id;
	private String smp_aps_settotal_ins_dt;
	private String smp_aps_settotal_udt_id;
	private String smp_aps_settotal_udt_dt;
	
	public SocietySmpApsSetTotal(){
	}
	
	
	public SocietySmpApsSetTotal(int smp_aps_settotal_seq, int smp_aps_setlist_seq, String smp_aps_settotal_nm,
			int smp_aps_settotal_ratio, String smp_aps_settotal_ins_id, String smp_aps_settotal_ins_dt,
			String smp_aps_settotal_udt_id, String smp_aps_settotal_udt_dt) {
		super();
		this.smp_aps_settotal_seq = smp_aps_settotal_seq;
		this.smp_aps_setlist_seq = smp_aps_setlist_seq;
		this.smp_aps_settotal_nm = smp_aps_settotal_nm;
		this.smp_aps_settotal_ratio = smp_aps_settotal_ratio;
		this.smp_aps_settotal_ins_id = smp_aps_settotal_ins_id;
		this.smp_aps_settotal_ins_dt = smp_aps_settotal_ins_dt;
		this.smp_aps_settotal_udt_id = smp_aps_settotal_udt_id;
		this.smp_aps_settotal_udt_dt = smp_aps_settotal_udt_dt;
	}


	public int getSmp_aps_settotal_seq() {
		return smp_aps_settotal_seq;
	}
	public void setSmp_aps_settotal_seq(int smp_aps_settotal_seq) {
		this.smp_aps_settotal_seq = smp_aps_settotal_seq;
	}
	public int getSmp_aps_setlist_seq() {
		return smp_aps_setlist_seq;
	}
	public void setSmp_aps_setlist_seq(int smp_aps_setlist_seq) {
		this.smp_aps_setlist_seq = smp_aps_setlist_seq;
	}
	public String getSmp_aps_settotal_nm() {
		return smp_aps_settotal_nm;
	}
	public void setSmp_aps_settotal_nm(String smp_aps_settotal_nm) {
		this.smp_aps_settotal_nm = smp_aps_settotal_nm;
	}
	public int getSmp_aps_settotal_ratio() {
		return smp_aps_settotal_ratio;
	}
	public void setSmp_aps_settotal_ratio(int smp_aps_settotal_ratio) {
		this.smp_aps_settotal_ratio = smp_aps_settotal_ratio;
	}
	public String getSmp_aps_settotal_ins_id() {
		return smp_aps_settotal_ins_id;
	}
	public void setSmp_aps_settotal_ins_id(String smp_aps_settotal_ins_id) {
		this.smp_aps_settotal_ins_id = smp_aps_settotal_ins_id;
	}
	public String getSmp_aps_settotal_ins_dt() {
		return smp_aps_settotal_ins_dt;
	}
	public void setSmp_aps_settotal_ins_dt(String smp_aps_settotal_ins_dt) {
		this.smp_aps_settotal_ins_dt = smp_aps_settotal_ins_dt;
	}
	public String getSmp_aps_settotal_udt_id() {
		return smp_aps_settotal_udt_id;
	}
	public void setSmp_aps_settotal_udt_id(String smp_aps_settotal_udt_id) {
		this.smp_aps_settotal_udt_id = smp_aps_settotal_udt_id;
	}
	public String getSmp_aps_settotal_udt_dt() {
		return smp_aps_settotal_udt_dt;
	}
	public void setSmp_aps_settotal_udt_dt(String smp_aps_settotal_udt_dt) {
		this.smp_aps_settotal_udt_dt = smp_aps_settotal_udt_dt;
	}

	@Override
	public String toString() {
		return "SmpApsSetTotal [smp_aps_settotal_seq=" + smp_aps_settotal_seq + ", smp_aps_setlist_seq="
				+ smp_aps_setlist_seq + ", smp_aps_settotal_nm=" + smp_aps_settotal_nm + ", smp_aps_settotal_ratio="
				+ smp_aps_settotal_ratio + ", smp_aps_settotal_ins_id=" + smp_aps_settotal_ins_id
				+ ", smp_aps_settotal_ins_dt=" + smp_aps_settotal_ins_dt + ", smp_aps_settotal_udt_id="
				+ smp_aps_settotal_udt_id + ", smp_aps_settotal_udt_dt=" + smp_aps_settotal_udt_dt + "]";
	}
	
}
