package global.segroup.society.smtp.apply.domain;

public class Student_Resume_Apply_History_DTO {
	private int student_apply_history_seq;
	private String id;
	private String user_id;
	private String student_apply_history_ins_dt;
	private String student_apply_history_ins_id;
	private String student_apply_history_state;
	public Student_Resume_Apply_History_DTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Student_Resume_Apply_History_DTO(int student_apply_history_seq, String id, String user_id,
			String student_apply_history_ins_dt, String student_apply_history_ins_id,
			String student_apply_history_state) {
		super();
		this.student_apply_history_seq = student_apply_history_seq;
		this.id = id;
		this.user_id = user_id;
		this.student_apply_history_ins_dt = student_apply_history_ins_dt;
		this.student_apply_history_ins_id = student_apply_history_ins_id;
		this.student_apply_history_state = student_apply_history_state;
	}
	public int getStudent_apply_history_seq() {
		return student_apply_history_seq;
	}
	public void setStudent_apply_history_seq(int student_apply_history_seq) {
		this.student_apply_history_seq = student_apply_history_seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getStudent_apply_history_ins_dt() {
		return student_apply_history_ins_dt;
	}
	public void setStudent_apply_history_ins_dt(String student_apply_history_ins_dt) {
		this.student_apply_history_ins_dt = student_apply_history_ins_dt;
	}
	public String getStudent_apply_history_ins_id() {
		return student_apply_history_ins_id;
	}
	public void setStudent_apply_history_ins_id(String student_apply_history_ins_id) {
		this.student_apply_history_ins_id = student_apply_history_ins_id;
	}
	public String getStudent_apply_history_state() {
		return student_apply_history_state;
	}
	public void setStudent_apply_history_state(String student_apply_history_state) {
		this.student_apply_history_state = student_apply_history_state;
	}
	@Override
	public String toString() {
		return String.format(
				"Student_Resume_Apply_History_DTO [student_apply_history_seq=%s, id=%s, user_id=%s, student_apply_history_ins_dt=%s, student_apply_history_ins_id=%s, student_apply_history_state=%s]",
				student_apply_history_seq, id, user_id, student_apply_history_ins_dt, student_apply_history_ins_id,
				student_apply_history_state);
	}
	

	

}
