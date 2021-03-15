/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

/**
 * @Author : user
 * @Date : 2019. 9. 18.
 * @Class 설명 : 
 * 
 */
public class SocietyFapAdminJobfairSetTime {
	private long fap_jobfair_set_time_seq;
	private int fap_jobfair_set_date_seq;
	private String fap_jobfair_set_time;
	private int fap_jobfair_set_time_merge_num;
	private String fap_jobfair_set_time_ct;
	private String fap_jobfair_set_time_ins_id;
	private String fap_jobfair_set_time_ins_dt;
	private String fap_jobfair_set_time_udt_id;
	private String fap_jobfair_set_time_udt_dt;
	
	public SocietyFapAdminJobfairSetTime() {
		super();
	}

	public SocietyFapAdminJobfairSetTime(long fap_jobfair_set_time_seq, int fap_jobfair_set_date_seq,
			String fap_jobfair_set_time, int fap_jobfair_set_time_merge_num, String fap_jobfair_set_time_ct,
			String fap_jobfair_set_time_ins_id, String fap_jobfair_set_time_ins_dt, String fap_jobfair_set_time_udt_id,
			String fap_jobfair_set_time_udt_dt) {
		super();
		this.fap_jobfair_set_time_seq = fap_jobfair_set_time_seq;
		this.fap_jobfair_set_date_seq = fap_jobfair_set_date_seq;
		this.fap_jobfair_set_time = fap_jobfair_set_time;
		this.fap_jobfair_set_time_merge_num = fap_jobfair_set_time_merge_num;
		this.fap_jobfair_set_time_ct = fap_jobfair_set_time_ct;
		this.fap_jobfair_set_time_ins_id = fap_jobfair_set_time_ins_id;
		this.fap_jobfair_set_time_ins_dt = fap_jobfair_set_time_ins_dt;
		this.fap_jobfair_set_time_udt_id = fap_jobfair_set_time_udt_id;
		this.fap_jobfair_set_time_udt_dt = fap_jobfair_set_time_udt_dt;
	}

	public long getFap_jobfair_set_time_seq() {
		return fap_jobfair_set_time_seq;
	}

	public void setFap_jobfair_set_time_seq(long fap_jobfair_set_time_seq) {
		this.fap_jobfair_set_time_seq = fap_jobfair_set_time_seq;
	}

	public int getFap_jobfair_set_date_seq() {
		return fap_jobfair_set_date_seq;
	}

	public void setFap_jobfair_set_date_seq(int fap_jobfair_set_date_seq) {
		this.fap_jobfair_set_date_seq = fap_jobfair_set_date_seq;
	}

	public String getFap_jobfair_set_time() {
		return fap_jobfair_set_time;
	}

	public void setFap_jobfair_set_time(String fap_jobfair_set_time) {
		this.fap_jobfair_set_time = fap_jobfair_set_time;
	}

	public int getFap_jobfair_set_time_merge_num() {
		return fap_jobfair_set_time_merge_num;
	}

	public void setFap_jobfair_set_time_merge_num(int fap_jobfair_set_time_merge_num) {
		this.fap_jobfair_set_time_merge_num = fap_jobfair_set_time_merge_num;
	}

	public String getFap_jobfair_set_time_ct() {
		return fap_jobfair_set_time_ct;
	}

	public void setFap_jobfair_set_time_ct(String fap_jobfair_set_time_ct) {
		this.fap_jobfair_set_time_ct = fap_jobfair_set_time_ct;
	}

	public String getFap_jobfair_set_time_ins_id() {
		return fap_jobfair_set_time_ins_id;
	}

	public void setFap_jobfair_set_time_ins_id(String fap_jobfair_set_time_ins_id) {
		this.fap_jobfair_set_time_ins_id = fap_jobfair_set_time_ins_id;
	}

	public String getFap_jobfair_set_time_ins_dt() {
		return fap_jobfair_set_time_ins_dt;
	}

	public void setFap_jobfair_set_time_ins_dt(String fap_jobfair_set_time_ins_dt) {
		this.fap_jobfair_set_time_ins_dt = fap_jobfair_set_time_ins_dt;
	}

	public String getFap_jobfair_set_time_udt_id() {
		return fap_jobfair_set_time_udt_id;
	}

	public void setFap_jobfair_set_time_udt_id(String fap_jobfair_set_time_udt_id) {
		this.fap_jobfair_set_time_udt_id = fap_jobfair_set_time_udt_id;
	}

	public String getFap_jobfair_set_time_udt_dt() {
		return fap_jobfair_set_time_udt_dt;
	}

	public void setFap_jobfair_set_time_udt_dt(String fap_jobfair_set_time_udt_dt) {
		this.fap_jobfair_set_time_udt_dt = fap_jobfair_set_time_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairSetTime [fap_jobfair_set_time_seq=" + fap_jobfair_set_time_seq
				+ ", fap_jobfair_set_date_seq=" + fap_jobfair_set_date_seq + ", fap_jobfair_set_time="
				+ fap_jobfair_set_time + ", fap_jobfair_set_time_merge_num=" + fap_jobfair_set_time_merge_num
				+ ", fap_jobfair_set_time_ct=" + fap_jobfair_set_time_ct + ", fap_jobfair_set_time_ins_id="
				+ fap_jobfair_set_time_ins_id + ", fap_jobfair_set_time_ins_dt=" + fap_jobfair_set_time_ins_dt
				+ ", fap_jobfair_set_time_udt_id=" + fap_jobfair_set_time_udt_id + ", fap_jobfair_set_time_udt_dt="
				+ fap_jobfair_set_time_udt_dt + "]";
	}
}
