package global.segroup.society.smtp.apply.domain;

public class Student_Enter_CRC_DTO {
	private int enter_crc_seq;
	private String user_id;
	private String crc_gisu_code;
	private String enter_crc_ins_id;
	private String enter_crc_ins_dt;
	private String enter_crc_udt_id;
	private String enter_crc_udt_dt;
	public Student_Enter_CRC_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getEnter_crc_seq() {
		return enter_crc_seq;
	}
	public void setEnter_crc_seq(int enter_crc_seq) {
		this.enter_crc_seq = enter_crc_seq;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getCrc_gisu_code() {
		return crc_gisu_code;
	}
	public void setCrc_gisu_code(String crc_gisu_code) {
		this.crc_gisu_code = crc_gisu_code;
	}
	public String getEnter_crc_ins_id() {
		return enter_crc_ins_id;
	}
	public void setEnter_crc_ins_id(String enter_crc_ins_id) {
		this.enter_crc_ins_id = enter_crc_ins_id;
	}
	public String getEnter_crc_ins_dt() {
		return enter_crc_ins_dt;
	}
	public void setEnter_crc_ins_dt(String enter_crc_ins_dt) {
		this.enter_crc_ins_dt = enter_crc_ins_dt;
	}
	public String getEnter_crc_udt_id() {
		return enter_crc_udt_id;
	}
	public void setEnter_crc_udt_id(String enter_crc_udt_id) {
		this.enter_crc_udt_id = enter_crc_udt_id;
	}
	public String getEnter_crc_udt_dt() {
		return enter_crc_udt_dt;
	}
	public void setEnter_crc_udt_dt(String enter_crc_udt_dt) {
		this.enter_crc_udt_dt = enter_crc_udt_dt;
	}
	@Override
	public String toString() {
		return String.format(
				"Student_Enter_CRC_DTO [enter_crc_seq=%s, user_id=%s, crc_gisu_code=%s, enter_crc_ins_id=%s, enter_crc_ins_dt=%s, enter_crc_udt_id=%s, enter_crc_udt_dt=%s]",
				enter_crc_seq, user_id, crc_gisu_code, enter_crc_ins_id, enter_crc_ins_dt, enter_crc_udt_id,
				enter_crc_udt_dt);
	}
	
	
	

}
