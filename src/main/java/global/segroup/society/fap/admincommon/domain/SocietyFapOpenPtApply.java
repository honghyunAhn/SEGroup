/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 4. 11.
 * @Class 설명 : 오픈잡페어 설명회 지원자 정보
 * 
 */
public class SocietyFapOpenPtApply {
	private int fap_open_pt_apply_seq;
	private int fap_open_pt_seq;
	private String user_id;
	private String fap_open_pt_apply_gb;
	private String fap_open_pt_apply_ins_id;
	private String fap_open_pt_apply_ins_dt;
	
	public SocietyFapOpenPtApply() {
		super();
	}

	public SocietyFapOpenPtApply(int fap_open_pt_apply_seq, int fap_open_pt_seq, String user_id,
			String fap_open_pt_apply_gb, String fap_open_pt_apply_ins_id, String fap_open_pt_apply_ins_dt) {
		super();
		this.fap_open_pt_apply_seq = fap_open_pt_apply_seq;
		this.fap_open_pt_seq = fap_open_pt_seq;
		this.user_id = user_id;
		this.fap_open_pt_apply_gb = fap_open_pt_apply_gb;
		this.fap_open_pt_apply_ins_id = fap_open_pt_apply_ins_id;
		this.fap_open_pt_apply_ins_dt = fap_open_pt_apply_ins_dt;
	}

	public int getFap_open_pt_apply_seq() {
		return fap_open_pt_apply_seq;
	}

	public void setFap_open_pt_apply_seq(int fap_open_pt_apply_seq) {
		this.fap_open_pt_apply_seq = fap_open_pt_apply_seq;
	}

	public int getFap_open_pt_seq() {
		return fap_open_pt_seq;
	}

	public void setFap_open_pt_seq(int fap_open_pt_seq) {
		this.fap_open_pt_seq = fap_open_pt_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFap_open_pt_apply_gb() {
		return fap_open_pt_apply_gb;
	}

	public void setFap_open_pt_apply_gb(String fap_open_pt_apply_gb) {
		this.fap_open_pt_apply_gb = fap_open_pt_apply_gb;
	}

	public String getFap_open_pt_apply_ins_id() {
		return fap_open_pt_apply_ins_id;
	}

	public void setFap_open_pt_apply_ins_id(String fap_open_pt_apply_ins_id) {
		this.fap_open_pt_apply_ins_id = fap_open_pt_apply_ins_id;
	}

	public String getFap_open_pt_apply_ins_dt() {
		return fap_open_pt_apply_ins_dt;
	}

	public void setFap_open_pt_apply_ins_dt(String fap_open_pt_apply_ins_dt) {
		this.fap_open_pt_apply_ins_dt = fap_open_pt_apply_ins_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapOpenPtApply [fap_open_pt_apply_seq=" + fap_open_pt_apply_seq + ", fap_open_pt_seq="
				+ fap_open_pt_seq + ", user_id=" + user_id + ", fap_open_pt_apply_gb=" + fap_open_pt_apply_gb
				+ ", fap_open_pt_apply_ins_id=" + fap_open_pt_apply_ins_id + ", fap_open_pt_apply_ins_dt="
				+ fap_open_pt_apply_ins_dt + "]";
	}
}
