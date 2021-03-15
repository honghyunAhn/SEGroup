/**
 * 
 */
package global.segroup.society.fap.admincommon.domain;

import java.util.List;

/**
 * @Author : user
 * @Date : 2019. 9. 18.
 * @Class 설명 : 
 * 
 */
public class SocietyFapAdminJobfairSetDate {
	private int fap_jobfair_set_date_seq;
	private int fap_jobfair_set_seq;
	private String fap_jobfair_set_date_dt;
	private int fap_jobfair_set_date_room_num;
	private String fap_jobfair_set_date_room_hid_gb;
	private String fap_jobfair_set_date_ins_id;
	private String fap_jobfair_set_date_ins_dt;
	private String fap_jobfair_set_date_udt_id;
	private String fap_jobfair_set_date_udt_dt;
	
	private List<SocietyFapAdminJobfairSetTime> fap_jobfair_set_time_arr;

	public SocietyFapAdminJobfairSetDate() {
		super();
	}

	public SocietyFapAdminJobfairSetDate(int fap_jobfair_set_date_seq, int fap_jobfair_set_seq,
			String fap_jobfair_set_date_dt, int fap_jobfair_set_date_room_num, String fap_jobfair_set_date_room_hid_gb,
			String fap_jobfair_set_date_ins_id, String fap_jobfair_set_date_ins_dt, String fap_jobfair_set_date_udt_id,
			String fap_jobfair_set_date_udt_dt, List<SocietyFapAdminJobfairSetTime> fap_jobfair_set_time_arr) {
		super();
		this.fap_jobfair_set_date_seq = fap_jobfair_set_date_seq;
		this.fap_jobfair_set_seq = fap_jobfair_set_seq;
		this.fap_jobfair_set_date_dt = fap_jobfair_set_date_dt;
		this.fap_jobfair_set_date_room_num = fap_jobfair_set_date_room_num;
		this.fap_jobfair_set_date_room_hid_gb = fap_jobfair_set_date_room_hid_gb;
		this.fap_jobfair_set_date_ins_id = fap_jobfair_set_date_ins_id;
		this.fap_jobfair_set_date_ins_dt = fap_jobfair_set_date_ins_dt;
		this.fap_jobfair_set_date_udt_id = fap_jobfair_set_date_udt_id;
		this.fap_jobfair_set_date_udt_dt = fap_jobfair_set_date_udt_dt;
		this.fap_jobfair_set_time_arr = fap_jobfair_set_time_arr;
	}

	public int getFap_jobfair_set_date_seq() {
		return fap_jobfair_set_date_seq;
	}

	public void setFap_jobfair_set_date_seq(int fap_jobfair_set_date_seq) {
		this.fap_jobfair_set_date_seq = fap_jobfair_set_date_seq;
	}

	public int getFap_jobfair_set_seq() {
		return fap_jobfair_set_seq;
	}

	public void setFap_jobfair_set_seq(int fap_jobfair_set_seq) {
		this.fap_jobfair_set_seq = fap_jobfair_set_seq;
	}

	public String getFap_jobfair_set_date_dt() {
		return fap_jobfair_set_date_dt;
	}

	public void setFap_jobfair_set_date_dt(String fap_jobfair_set_date_dt) {
		this.fap_jobfair_set_date_dt = fap_jobfair_set_date_dt;
	}

	public int getFap_jobfair_set_date_room_num() {
		return fap_jobfair_set_date_room_num;
	}

	public void setFap_jobfair_set_date_room_num(int fap_jobfair_set_date_room_num) {
		this.fap_jobfair_set_date_room_num = fap_jobfair_set_date_room_num;
	}

	public String getFap_jobfair_set_date_room_hid_gb() {
		return fap_jobfair_set_date_room_hid_gb;
	}

	public void setFap_jobfair_set_date_room_hid_gb(String fap_jobfair_set_date_room_hid_gb) {
		this.fap_jobfair_set_date_room_hid_gb = fap_jobfair_set_date_room_hid_gb;
	}

	public String getFap_jobfair_set_date_ins_id() {
		return fap_jobfair_set_date_ins_id;
	}

	public void setFap_jobfair_set_date_ins_id(String fap_jobfair_set_date_ins_id) {
		this.fap_jobfair_set_date_ins_id = fap_jobfair_set_date_ins_id;
	}

	public String getFap_jobfair_set_date_ins_dt() {
		return fap_jobfair_set_date_ins_dt;
	}

	public void setFap_jobfair_set_date_ins_dt(String fap_jobfair_set_date_ins_dt) {
		this.fap_jobfair_set_date_ins_dt = fap_jobfair_set_date_ins_dt;
	}

	public String getFap_jobfair_set_date_udt_id() {
		return fap_jobfair_set_date_udt_id;
	}

	public void setFap_jobfair_set_date_udt_id(String fap_jobfair_set_date_udt_id) {
		this.fap_jobfair_set_date_udt_id = fap_jobfair_set_date_udt_id;
	}

	public String getFap_jobfair_set_date_udt_dt() {
		return fap_jobfair_set_date_udt_dt;
	}

	public void setFap_jobfair_set_date_udt_dt(String fap_jobfair_set_date_udt_dt) {
		this.fap_jobfair_set_date_udt_dt = fap_jobfair_set_date_udt_dt;
	}

	public List<SocietyFapAdminJobfairSetTime> getFap_jobfair_set_time_arr() {
		return fap_jobfair_set_time_arr;
	}

	public void setFap_jobfair_set_time_arr(List<SocietyFapAdminJobfairSetTime> fap_jobfair_set_time_arr) {
		this.fap_jobfair_set_time_arr = fap_jobfair_set_time_arr;
	}

	@Override
	public String toString() {
		return "SocietyFapAdminJobfairSetDate [fap_jobfair_set_date_seq=" + fap_jobfair_set_date_seq
				+ ", fap_jobfair_set_seq=" + fap_jobfair_set_seq + ", fap_jobfair_set_date_dt="
				+ fap_jobfair_set_date_dt + ", fap_jobfair_set_date_room_num=" + fap_jobfair_set_date_room_num
				+ ", fap_jobfair_set_date_room_hid_gb=" + fap_jobfair_set_date_room_hid_gb
				+ ", fap_jobfair_set_date_ins_id=" + fap_jobfair_set_date_ins_id + ", fap_jobfair_set_date_ins_dt="
				+ fap_jobfair_set_date_ins_dt + ", fap_jobfair_set_date_udt_id=" + fap_jobfair_set_date_udt_id
				+ ", fap_jobfair_set_date_udt_dt=" + fap_jobfair_set_date_udt_dt + ", fap_jobfair_set_time_arr="
				+ fap_jobfair_set_time_arr + "]";
	}
}
