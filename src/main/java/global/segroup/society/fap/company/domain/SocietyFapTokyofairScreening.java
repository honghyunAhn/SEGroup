/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 9. 26.
 * @Class 설명 : 도쿄페어 전형 정보
 * 
 */
public class SocietyFapTokyofairScreening {
	private int fap_tokyofair_screening_seq;
	private long fap_job_ad_seq;
	private String fap_comp_id;
	private String fap_tokyofair_screening_gb;
	private String fap_tokyofair_screening_nm;
	private String fap_tokyofair_screening_type;
	private int fap_tokyofair_screening_user_num;
	private int fap_tokyofair_screening_time;
	private int fap_tokyofair_screening_comp_num;
	private String fap_tokyofair_screening_admin_req;
	private String fap_tokyofair_screening_user_req;
	private String fap_tokyofair_screening_sch_gb;
	private String fap_tokyofair_screening_ins_id;
	private String fap_tokyofair_screening_ins_dt;
	private String fap_tokyofair_screening_udt_id;
	private String fap_tokyofair_screening_udt_dt;
	
	private SocietyFapTokyofairScrUser scrUser;

	public SocietyFapTokyofairScreening() {
		super();
	}

	public SocietyFapTokyofairScreening(int fap_tokyofair_screening_seq, long fap_job_ad_seq, String fap_comp_id,
			String fap_tokyofair_screening_gb, String fap_tokyofair_screening_nm, String fap_tokyofair_screening_type,
			int fap_tokyofair_screening_user_num, int fap_tokyofair_screening_time,
			int fap_tokyofair_screening_comp_num, String fap_tokyofair_screening_admin_req,
			String fap_tokyofair_screening_user_req, String fap_tokyofair_screening_sch_gb,
			String fap_tokyofair_screening_ins_id, String fap_tokyofair_screening_ins_dt,
			String fap_tokyofair_screening_udt_id, String fap_tokyofair_screening_udt_dt,
			SocietyFapTokyofairScrUser scrUser) {
		super();
		this.fap_tokyofair_screening_seq = fap_tokyofair_screening_seq;
		this.fap_job_ad_seq = fap_job_ad_seq;
		this.fap_comp_id = fap_comp_id;
		this.fap_tokyofair_screening_gb = fap_tokyofair_screening_gb;
		this.fap_tokyofair_screening_nm = fap_tokyofair_screening_nm;
		this.fap_tokyofair_screening_type = fap_tokyofair_screening_type;
		this.fap_tokyofair_screening_user_num = fap_tokyofair_screening_user_num;
		this.fap_tokyofair_screening_time = fap_tokyofair_screening_time;
		this.fap_tokyofair_screening_comp_num = fap_tokyofair_screening_comp_num;
		this.fap_tokyofair_screening_admin_req = fap_tokyofair_screening_admin_req;
		this.fap_tokyofair_screening_user_req = fap_tokyofair_screening_user_req;
		this.fap_tokyofair_screening_sch_gb = fap_tokyofair_screening_sch_gb;
		this.fap_tokyofair_screening_ins_id = fap_tokyofair_screening_ins_id;
		this.fap_tokyofair_screening_ins_dt = fap_tokyofair_screening_ins_dt;
		this.fap_tokyofair_screening_udt_id = fap_tokyofair_screening_udt_id;
		this.fap_tokyofair_screening_udt_dt = fap_tokyofair_screening_udt_dt;
		this.scrUser = scrUser;
	}

	public int getFap_tokyofair_screening_seq() {
		return fap_tokyofair_screening_seq;
	}

	public void setFap_tokyofair_screening_seq(int fap_tokyofair_screening_seq) {
		this.fap_tokyofair_screening_seq = fap_tokyofair_screening_seq;
	}

	public long getFap_job_ad_seq() {
		return fap_job_ad_seq;
	}

	public void setFap_job_ad_seq(long fap_job_ad_seq) {
		this.fap_job_ad_seq = fap_job_ad_seq;
	}

	public String getFap_comp_id() {
		return fap_comp_id;
	}

	public void setFap_comp_id(String fap_comp_id) {
		this.fap_comp_id = fap_comp_id;
	}

	public String getFap_tokyofair_screening_gb() {
		return fap_tokyofair_screening_gb;
	}

	public void setFap_tokyofair_screening_gb(String fap_tokyofair_screening_gb) {
		this.fap_tokyofair_screening_gb = fap_tokyofair_screening_gb;
	}

	public String getFap_tokyofair_screening_nm() {
		return fap_tokyofair_screening_nm;
	}

	public void setFap_tokyofair_screening_nm(String fap_tokyofair_screening_nm) {
		this.fap_tokyofair_screening_nm = fap_tokyofair_screening_nm;
	}

	public String getFap_tokyofair_screening_type() {
		return fap_tokyofair_screening_type;
	}

	public void setFap_tokyofair_screening_type(String fap_tokyofair_screening_type) {
		this.fap_tokyofair_screening_type = fap_tokyofair_screening_type;
	}

	public int getFap_tokyofair_screening_user_num() {
		return fap_tokyofair_screening_user_num;
	}

	public void setFap_tokyofair_screening_user_num(int fap_tokyofair_screening_user_num) {
		this.fap_tokyofair_screening_user_num = fap_tokyofair_screening_user_num;
	}

	public int getFap_tokyofair_screening_time() {
		return fap_tokyofair_screening_time;
	}

	public void setFap_tokyofair_screening_time(int fap_tokyofair_screening_time) {
		this.fap_tokyofair_screening_time = fap_tokyofair_screening_time;
	}

	public int getFap_tokyofair_screening_comp_num() {
		return fap_tokyofair_screening_comp_num;
	}

	public void setFap_tokyofair_screening_comp_num(int fap_tokyofair_screening_comp_num) {
		this.fap_tokyofair_screening_comp_num = fap_tokyofair_screening_comp_num;
	}

	public String getFap_tokyofair_screening_admin_req() {
		return fap_tokyofair_screening_admin_req;
	}

	public void setFap_tokyofair_screening_admin_req(String fap_tokyofair_screening_admin_req) {
		this.fap_tokyofair_screening_admin_req = fap_tokyofair_screening_admin_req;
	}

	public String getFap_tokyofair_screening_user_req() {
		return fap_tokyofair_screening_user_req;
	}

	public void setFap_tokyofair_screening_user_req(String fap_tokyofair_screening_user_req) {
		this.fap_tokyofair_screening_user_req = fap_tokyofair_screening_user_req;
	}

	public String getFap_tokyofair_screening_sch_gb() {
		return fap_tokyofair_screening_sch_gb;
	}

	public void setFap_tokyofair_screening_sch_gb(String fap_tokyofair_screening_sch_gb) {
		this.fap_tokyofair_screening_sch_gb = fap_tokyofair_screening_sch_gb;
	}

	public String getFap_tokyofair_screening_ins_id() {
		return fap_tokyofair_screening_ins_id;
	}

	public void setFap_tokyofair_screening_ins_id(String fap_tokyofair_screening_ins_id) {
		this.fap_tokyofair_screening_ins_id = fap_tokyofair_screening_ins_id;
	}

	public String getFap_tokyofair_screening_ins_dt() {
		return fap_tokyofair_screening_ins_dt;
	}

	public void setFap_tokyofair_screening_ins_dt(String fap_tokyofair_screening_ins_dt) {
		this.fap_tokyofair_screening_ins_dt = fap_tokyofair_screening_ins_dt;
	}

	public String getFap_tokyofair_screening_udt_id() {
		return fap_tokyofair_screening_udt_id;
	}

	public void setFap_tokyofair_screening_udt_id(String fap_tokyofair_screening_udt_id) {
		this.fap_tokyofair_screening_udt_id = fap_tokyofair_screening_udt_id;
	}

	public String getFap_tokyofair_screening_udt_dt() {
		return fap_tokyofair_screening_udt_dt;
	}

	public void setFap_tokyofair_screening_udt_dt(String fap_tokyofair_screening_udt_dt) {
		this.fap_tokyofair_screening_udt_dt = fap_tokyofair_screening_udt_dt;
	}

	public SocietyFapTokyofairScrUser getScrUser() {
		return scrUser;
	}

	public void setScrUser(SocietyFapTokyofairScrUser scrUser) {
		this.scrUser = scrUser;
	}

	@Override
	public String toString() {
		return "SocietyFapTokyofairScreening [fap_tokyofair_screening_seq=" + fap_tokyofair_screening_seq
				+ ", fap_job_ad_seq=" + fap_job_ad_seq + ", fap_comp_id=" + fap_comp_id
				+ ", fap_tokyofair_screening_gb=" + fap_tokyofair_screening_gb + ", fap_tokyofair_screening_nm="
				+ fap_tokyofair_screening_nm + ", fap_tokyofair_screening_type=" + fap_tokyofair_screening_type
				+ ", fap_tokyofair_screening_user_num=" + fap_tokyofair_screening_user_num
				+ ", fap_tokyofair_screening_time=" + fap_tokyofair_screening_time
				+ ", fap_tokyofair_screening_comp_num=" + fap_tokyofair_screening_comp_num
				+ ", fap_tokyofair_screening_admin_req=" + fap_tokyofair_screening_admin_req
				+ ", fap_tokyofair_screening_user_req=" + fap_tokyofair_screening_user_req
				+ ", fap_tokyofair_screening_sch_gb=" + fap_tokyofair_screening_sch_gb
				+ ", fap_tokyofair_screening_ins_id=" + fap_tokyofair_screening_ins_id
				+ ", fap_tokyofair_screening_ins_dt=" + fap_tokyofair_screening_ins_dt
				+ ", fap_tokyofair_screening_udt_id=" + fap_tokyofair_screening_udt_id
				+ ", fap_tokyofair_screening_udt_dt=" + fap_tokyofair_screening_udt_dt + ", scrUser=" + scrUser + "]";
	}

}
