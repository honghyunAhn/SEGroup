package global.segroup.society.smp.admin.domain;

public class SocietySmpApsSetList {
	
	private int smp_aps_setlist_seq;
	
	private String smp_aps_setlist_nm;
	
	private String smp_aps_setlist_ins_id;
	
	private String smp_aps_setlist_ins_dt;
	
	private String smp_aps_setlist_udt_id;
	
	private String smp_aps_setlist_udt_dt;
	
	public SocietySmpApsSetList(){
	}

	
	public SocietySmpApsSetList(int smp_aps_setlist_seq, String smp_aps_setlist_nm, String smp_aps_setlist_ins_id,
			String smp_aps_setlist_ins_dt, String smp_aps_setlist_udt_id, String smp_aps_setlist_udt_dt) {
		super();
		this.smp_aps_setlist_seq = smp_aps_setlist_seq;
		this.smp_aps_setlist_nm = smp_aps_setlist_nm;
		this.smp_aps_setlist_ins_id = smp_aps_setlist_ins_id;
		this.smp_aps_setlist_ins_dt = smp_aps_setlist_ins_dt;
		this.smp_aps_setlist_udt_id = smp_aps_setlist_udt_id;
		this.smp_aps_setlist_udt_dt = smp_aps_setlist_udt_dt;
	}


	public int getSmp_aps_setlist_seq() {
		return smp_aps_setlist_seq;
	}
	public void setSmp_aps_setlist_seq(int smp_aps_setlist_seq) {
		this.smp_aps_setlist_seq = smp_aps_setlist_seq;
	}
	public String getSmp_aps_setlist_nm() {
		return smp_aps_setlist_nm;
	}
	public void setSmp_aps_setlist_nm(String smp_aps_setlist_nm) {
		this.smp_aps_setlist_nm = smp_aps_setlist_nm;
	}
	public String getSmp_aps_setlist_ins_id() {
		return smp_aps_setlist_ins_id;
	}
	public void setSmp_aps_setlist_ins_id(String smp_aps_setlist_ins_id) {
		this.smp_aps_setlist_ins_id = smp_aps_setlist_ins_id;
	}
	public String getSmp_aps_setlist_ins_dt() {
		return smp_aps_setlist_ins_dt;
	}
	public void setSmp_aps_setlist_ins_dt(String smp_aps_setlist_ins_dt) {
		this.smp_aps_setlist_ins_dt = smp_aps_setlist_ins_dt;
	}
	public String getSmp_aps_setlist_udt_id() {
		return smp_aps_setlist_udt_id;
	}
	public void setSmp_aps_setlist_udt_id(String smp_aps_setlist_udt_id) {
		this.smp_aps_setlist_udt_id = smp_aps_setlist_udt_id;
	}
	public String getSmp_aps_setlist_udt_dt() {
		return smp_aps_setlist_udt_dt;
	}
	public void setSmp_aps_setlist_udt_dt(String smp_aps_setlist_udt_dt) {
		this.smp_aps_setlist_udt_dt = smp_aps_setlist_udt_dt;
	}

	@Override
	public String toString() {
		return "SmpApsSetList [smp_aps_setlist_seq=" + smp_aps_setlist_seq + ", smp_aps_setlist_nm="
				+ smp_aps_setlist_nm + ", smp_aps_setlist_ins_id=" + smp_aps_setlist_ins_id
				+ ", smp_aps_setlist_ins_dt=" + smp_aps_setlist_ins_dt + ", smp_aps_setlist_udt_id="
				+ smp_aps_setlist_udt_id + ", smp_aps_setlist_udt_dt=" + smp_aps_setlist_udt_dt + "]";
	}
	
}
