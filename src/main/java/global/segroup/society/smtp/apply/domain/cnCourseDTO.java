package global.segroup.society.smtp.apply.domain;

public class cnCourseDTO {
	private String cardinal_id;
	private String course_id;
	public cnCourseDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public cnCourseDTO(String cardinal_id, String course_id) {
		super();
		this.cardinal_id = cardinal_id;
		this.course_id = course_id;
	}
	public String getCardinal_id() {
		return cardinal_id;
	}
	public void setCardinal_id(String cardinal_id) {
		this.cardinal_id = cardinal_id;
	}
	public String getCourse_id() {
		return course_id;
	}
	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}
	@Override
	public String toString() {
		return String.format("cnCourseDTO [cardinal_id=%s, course_id=%s]", cardinal_id, course_id);
	}
	
	

}
