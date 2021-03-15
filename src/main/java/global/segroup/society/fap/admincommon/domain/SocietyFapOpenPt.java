/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 4. 11.
 * @Class 설명 : 오픈잡페어 설명회 정보
 * 
 */
public class SocietyFapOpenPt {
	private int fap_open_pt_seq;
	private String fap_open_pt_title;
	private String fap_open_pt_ct;
	private String fap_open_pt_gb;
	private String fap_open_pt_show_gb;
	private String fap_open_pt_close_gb;
	private String fap_open_pt_ins_id;
	private String fap_open_pt_ins_dt;
	private String fap_open_pt_udt_id;
	private String fap_open_pt_udt_dt;
	
	public SocietyFapOpenPt() {
		super();
	}

	public SocietyFapOpenPt(int fap_open_pt_seq, String fap_open_pt_title, String fap_open_pt_ct, String fap_open_pt_gb,
			String fap_open_pt_show_gb, String fap_open_pt_close_gb, String fap_open_pt_ins_id,
			String fap_open_pt_ins_dt, String fap_open_pt_udt_id, String fap_open_pt_udt_dt) {
		super();
		this.fap_open_pt_seq = fap_open_pt_seq;
		this.fap_open_pt_title = fap_open_pt_title;
		this.fap_open_pt_ct = fap_open_pt_ct;
		this.fap_open_pt_gb = fap_open_pt_gb;
		this.fap_open_pt_show_gb = fap_open_pt_show_gb;
		this.fap_open_pt_close_gb = fap_open_pt_close_gb;
		this.fap_open_pt_ins_id = fap_open_pt_ins_id;
		this.fap_open_pt_ins_dt = fap_open_pt_ins_dt;
		this.fap_open_pt_udt_id = fap_open_pt_udt_id;
		this.fap_open_pt_udt_dt = fap_open_pt_udt_dt;
	}

	public int getFap_open_pt_seq() {
		return fap_open_pt_seq;
	}

	public void setFap_open_pt_seq(int fap_open_pt_seq) {
		this.fap_open_pt_seq = fap_open_pt_seq;
	}

	public String getFap_open_pt_title() {
		return fap_open_pt_title;
	}

	public void setFap_open_pt_title(String fap_open_pt_title) {
		this.fap_open_pt_title = fap_open_pt_title;
	}

	public String getFap_open_pt_ct() {
		return fap_open_pt_ct;
	}

	public void setFap_open_pt_ct(String fap_open_pt_ct) {
		this.fap_open_pt_ct = fap_open_pt_ct;
	}

	public String getFap_open_pt_gb() {
		return fap_open_pt_gb;
	}

	public void setFap_open_pt_gb(String fap_open_pt_gb) {
		this.fap_open_pt_gb = fap_open_pt_gb;
	}

	public String getFap_open_pt_show_gb() {
		return fap_open_pt_show_gb;
	}

	public void setFap_open_pt_show_gb(String fap_open_pt_show_gb) {
		this.fap_open_pt_show_gb = fap_open_pt_show_gb;
	}

	public String getFap_open_pt_close_gb() {
		return fap_open_pt_close_gb;
	}

	public void setFap_open_pt_close_gb(String fap_open_pt_close_gb) {
		this.fap_open_pt_close_gb = fap_open_pt_close_gb;
	}

	public String getFap_open_pt_ins_id() {
		return fap_open_pt_ins_id;
	}

	public void setFap_open_pt_ins_id(String fap_open_pt_ins_id) {
		this.fap_open_pt_ins_id = fap_open_pt_ins_id;
	}

	public String getFap_open_pt_ins_dt() {
		return fap_open_pt_ins_dt;
	}

	public void setFap_open_pt_ins_dt(String fap_open_pt_ins_dt) {
		this.fap_open_pt_ins_dt = fap_open_pt_ins_dt;
	}

	public String getFap_open_pt_udt_id() {
		return fap_open_pt_udt_id;
	}

	public void setFap_open_pt_udt_id(String fap_open_pt_udt_id) {
		this.fap_open_pt_udt_id = fap_open_pt_udt_id;
	}

	public String getFap_open_pt_udt_dt() {
		return fap_open_pt_udt_dt;
	}

	public void setFap_open_pt_udt_dt(String fap_open_pt_udt_dt) {
		this.fap_open_pt_udt_dt = fap_open_pt_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapOpenPt [fap_open_pt_seq=" + fap_open_pt_seq + ", fap_open_pt_title=" + fap_open_pt_title
				+ ", fap_open_pt_ct=" + fap_open_pt_ct + ", fap_open_pt_gb=" + fap_open_pt_gb + ", fap_open_pt_show_gb="
				+ fap_open_pt_show_gb + ", fap_open_pt_close_gb=" + fap_open_pt_close_gb + ", fap_open_pt_ins_id="
				+ fap_open_pt_ins_id + ", fap_open_pt_ins_dt=" + fap_open_pt_ins_dt + ", fap_open_pt_udt_id="
				+ fap_open_pt_udt_id + ", fap_open_pt_udt_dt=" + fap_open_pt_udt_dt + "]";
	}
}
