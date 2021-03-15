/**
 * 
 */
package global.segroup.society.fap.company.domain;

/**
 * @Author : 이종호
 * @Date : 2019. 10. 7.
 * @Class 설명 : 도쿄페어 날짜 정보
 * 
 */
public class SocietyFapTokyofairDate {
	private int fap_tokyofair_date_seq;
	private int fap_jobfair_set_seq;
	private String fap_tokyofair_date_dt;
	private int fap_tokyofair_date_room_num;
	private String fap_tokyofair_date_ins_id;
	private String fap_tokyofair_date_ins_dt;
	private String fap_tokyofair_date_udt_id;
	private String fap_tokyofair_date_udt_dt;
	
	public SocietyFapTokyofairDate() {
		super();
	}

	public SocietyFapTokyofairDate(int fap_tokyofair_date_seq, int fap_jobfair_set_seq, String fap_tokyofair_date_dt,
			int fap_tokyofair_date_room_num, String fap_tokyofair_date_ins_id, String fap_tokyofair_date_ins_dt,
			String fap_tokyofair_date_udt_id, String fap_tokyofair_date_udt_dt) {
		super();
		this.fap_tokyofair_date_seq = fap_tokyofair_date_seq;
		this.fap_jobfair_set_seq = fap_jobfair_set_seq;
		this.fap_tokyofair_date_dt = fap_tokyofair_date_dt;
		this.fap_tokyofair_date_room_num = fap_tokyofair_date_room_num;
		this.fap_tokyofair_date_ins_id = fap_tokyofair_date_ins_id;
		this.fap_tokyofair_date_ins_dt = fap_tokyofair_date_ins_dt;
		this.fap_tokyofair_date_udt_id = fap_tokyofair_date_udt_id;
		this.fap_tokyofair_date_udt_dt = fap_tokyofair_date_udt_dt;
	}

	public int getFap_tokyofair_date_seq() {
		return fap_tokyofair_date_seq;
	}

	public void setFap_tokyofair_date_seq(int fap_tokyofair_date_seq) {
		this.fap_tokyofair_date_seq = fap_tokyofair_date_seq;
	}

	public int getFap_jobfair_set_seq() {
		return fap_jobfair_set_seq;
	}

	public void setFap_jobfair_set_seq(int fap_jobfair_set_seq) {
		this.fap_jobfair_set_seq = fap_jobfair_set_seq;
	}

	public String getFap_tokyofair_date_dt() {
		return fap_tokyofair_date_dt;
	}

	public void setFap_tokyofair_date_dt(String fap_tokyofair_date_dt) {
		this.fap_tokyofair_date_dt = fap_tokyofair_date_dt;
	}

	public int getFap_tokyofair_date_room_num() {
		return fap_tokyofair_date_room_num;
	}

	public void setFap_tokyofair_date_room_num(int fap_tokyofair_date_room_num) {
		this.fap_tokyofair_date_room_num = fap_tokyofair_date_room_num;
	}

	public String getFap_tokyofair_date_ins_id() {
		return fap_tokyofair_date_ins_id;
	}

	public void setFap_tokyofair_date_ins_id(String fap_tokyofair_date_ins_id) {
		this.fap_tokyofair_date_ins_id = fap_tokyofair_date_ins_id;
	}

	public String getFap_tokyofair_date_ins_dt() {
		return fap_tokyofair_date_ins_dt;
	}

	public void setFap_tokyofair_date_ins_dt(String fap_tokyofair_date_ins_dt) {
		this.fap_tokyofair_date_ins_dt = fap_tokyofair_date_ins_dt;
	}

	public String getFap_tokyofair_date_udt_id() {
		return fap_tokyofair_date_udt_id;
	}

	public void setFap_tokyofair_date_udt_id(String fap_tokyofair_date_udt_id) {
		this.fap_tokyofair_date_udt_id = fap_tokyofair_date_udt_id;
	}

	public String getFap_tokyofair_date_udt_dt() {
		return fap_tokyofair_date_udt_dt;
	}

	public void setFap_tokyofair_date_udt_dt(String fap_tokyofair_date_udt_dt) {
		this.fap_tokyofair_date_udt_dt = fap_tokyofair_date_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapTokyofairDate [fap_tokyofair_date_seq=" + fap_tokyofair_date_seq + ", fap_jobfair_set_seq="
				+ fap_jobfair_set_seq + ", fap_tokyofair_date_dt=" + fap_tokyofair_date_dt
				+ ", fap_tokyofair_date_room_num=" + fap_tokyofair_date_room_num + ", fap_tokyofair_date_ins_id="
				+ fap_tokyofair_date_ins_id + ", fap_tokyofair_date_ins_dt=" + fap_tokyofair_date_ins_dt
				+ ", fap_tokyofair_date_udt_id=" + fap_tokyofair_date_udt_id + ", fap_tokyofair_date_udt_dt="
				+ fap_tokyofair_date_udt_dt + "]";
	}
}
