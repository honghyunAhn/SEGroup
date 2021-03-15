/**
 * 
 */
package global.segroup.society.fap.user.domain;

/**
 * @Author : Administrator
 * @Date : 2018. 12. 13.
 * @Class 설명 : 
 * 
 */
public class SocietyFapPersonalUser {

	private int fap_personal_user_seq;
	
	private String user_id;
	
	private String fap_personal_user_edu_level;
	
	private String fap_personal_user_edu_ct_nm;
	
	private String fap_personal_user_job_objective;
	
	private String fap_personal_user_edu_course_nm;
	
	private String fap_personal_user_ins_id;
	 
	private String fap_personal_user_ins_dt;
	
	private String fap_personal_user_udt_id;
	
	private String fap_personal_user_udt_dt;

	/**
	 * @Desc : 
	 */
	public SocietyFapPersonalUser() {
		super();
	}

	public SocietyFapPersonalUser(int fap_personal_user_seq, String user_id, String fap_personal_user_edu_level,
			String fap_personal_user_edu_ct_nm, String fap_personal_user_job_objective,
			String fap_personal_user_edu_course_nm, String fap_personal_user_ins_id, String fap_personal_user_ins_dt,
			String fap_personal_user_udt_id, String fap_personal_user_udt_dt) {
		super();
		this.fap_personal_user_seq = fap_personal_user_seq;
		this.user_id = user_id;
		this.fap_personal_user_edu_level = fap_personal_user_edu_level;
		this.fap_personal_user_edu_ct_nm = fap_personal_user_edu_ct_nm;
		this.fap_personal_user_job_objective = fap_personal_user_job_objective;
		this.fap_personal_user_edu_course_nm = fap_personal_user_edu_course_nm;
		this.fap_personal_user_ins_id = fap_personal_user_ins_id;
		this.fap_personal_user_ins_dt = fap_personal_user_ins_dt;
		this.fap_personal_user_udt_id = fap_personal_user_udt_id;
		this.fap_personal_user_udt_dt = fap_personal_user_udt_dt;
	}

	public int getFap_personal_user_seq() {
		return fap_personal_user_seq;
	}

	public void setFap_personal_user_seq(int fap_personal_user_seq) {
		this.fap_personal_user_seq = fap_personal_user_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getFap_personal_user_edu_level() {
		return fap_personal_user_edu_level;
	}

	public void setFap_personal_user_edu_level(String fap_personal_user_edu_level) {
		this.fap_personal_user_edu_level = fap_personal_user_edu_level;
	}

	public String getFap_personal_user_edu_ct_nm() {
		return fap_personal_user_edu_ct_nm;
	}

	public void setFap_personal_user_edu_ct_nm(String fap_personal_user_edu_ct_nm) {
		this.fap_personal_user_edu_ct_nm = fap_personal_user_edu_ct_nm;
	}

	public String getFap_personal_user_job_objective() {
		return fap_personal_user_job_objective;
	}

	public void setFap_personal_user_job_objective(String fap_personal_user_job_objective) {
		this.fap_personal_user_job_objective = fap_personal_user_job_objective;
	}

	public String getFap_personal_user_edu_course_nm() {
		return fap_personal_user_edu_course_nm;
	}

	public void setFap_personal_user_edu_course_nm(String fap_personal_user_edu_course_nm) {
		this.fap_personal_user_edu_course_nm = fap_personal_user_edu_course_nm;
	}

	public String getFap_personal_user_ins_id() {
		return fap_personal_user_ins_id;
	}

	public void setFap_personal_user_ins_id(String fap_personal_user_ins_id) {
		this.fap_personal_user_ins_id = fap_personal_user_ins_id;
	}

	public String getFap_personal_user_ins_dt() {
		return fap_personal_user_ins_dt;
	}

	public void setFap_personal_user_ins_dt(String fap_personal_user_ins_dt) {
		this.fap_personal_user_ins_dt = fap_personal_user_ins_dt;
	}

	public String getFap_personal_user_udt_id() {
		return fap_personal_user_udt_id;
	}

	public void setFap_personal_user_udt_id(String fap_personal_user_udt_id) {
		this.fap_personal_user_udt_id = fap_personal_user_udt_id;
	}

	public String getFap_personal_user_udt_dt() {
		return fap_personal_user_udt_dt;
	}

	public void setFap_personal_user_udt_dt(String fap_personal_user_udt_dt) {
		this.fap_personal_user_udt_dt = fap_personal_user_udt_dt;
	}

	@Override
	public String toString() {
		return "SocietyFapPersonalUser [fap_personal_user_seq=" + fap_personal_user_seq + ", user_id=" + user_id
				+ ", fap_personal_user_edu_level=" + fap_personal_user_edu_level + ", fap_personal_user_edu_ct_nm="
				+ fap_personal_user_edu_ct_nm + ", fap_personal_user_job_objective=" + fap_personal_user_job_objective
				+ ", fap_personal_user_edu_course_nm=" + fap_personal_user_edu_course_nm + ", fap_personal_user_ins_id="
				+ fap_personal_user_ins_id + ", fap_personal_user_ins_dt=" + fap_personal_user_ins_dt
				+ ", fap_personal_user_udt_id=" + fap_personal_user_udt_id + ", fap_personal_user_udt_dt="
				+ fap_personal_user_udt_dt + "]";
	}
}
