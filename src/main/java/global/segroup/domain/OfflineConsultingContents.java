/**
 * 
 */
package global.segroup.domain;

/**
 * @Author : 김지훈
 * @Date : 2018. 7. 12.
 * @Class 설명 : 오프라인 상담 신청자의 정보를 담을 객체
 * 
 */
public class OfflineConsultingContents {

	/**
	 * 생성순번
	 */
	private String seq;

	/**
	 * 신청자 이름
	 */
	private String user_nm;

	/**
	 * 신청자 성별
	 */
	private String user_sex;

	/**
	 * 신청자 나이
	 */
	private String user_age;

	/**
	 * 신청자 전공
	 */
	private String user_major;

	/**
	 * 신청자 전화번호
	 */
	private String user_phone;

	/**
	 * 신청자 이메일
	 */
	private String user_email;

	/**
	 * 신청일자
	 */
	private String apply_date;

	/**
	 * 신청시간
	 */
	private String apply_time;

	/**
	 * 신청날짜 + 시간
	 */
	private String apply_datetime;

	/**
	 * 신청제목
	 */
	private String apply_title;

	/**
	 * 신청내용
	 */
	private String apply_contents;

	/**
	 * 상담대응한 메일 제목
	 */
	private String send_mail_title;

	/**
	 * 상담대응한 메일 내용
	 */
	private String send_mail_contents;

	/**
	 * 오프라인 방문여부(방문:1,미방문0,기본값:0)
	 */
	private String user_visits;

	/**
	 * 최초 글 쓴 일자 및 시간
	 */
	private String user_ins_dt;

	/**
	 * 마지막 수정한 유저의 아이디
	 */
	private String user_udt_id;

	/**
	 * 마지막 수정된 일자 및 시간
	 */
	private String user_udt_dt;

	/**
	 * @Desc :
	 */
	public OfflineConsultingContents() {
		super();
	}
	
	/**
	 * @Desc : 
	 * @param seq
	 * @param user_nm
	 * @param user_sex
	 * @param user_age
	 * @param user_major
	 * @param user_phone
	 * @param user_email
	 * @param apply_date
	 * @param apply_time
	 * @param apply_datetime
	 * @param apply_title
	 * @param apply_contents
	 * @param send_mail_title
	 * @param send_mail_contents
	 * @param user_visits
	 * @param user_ins_dt
	 * @param user_udt_id
	 * @param user_udt_dt
	 */
	public OfflineConsultingContents(String seq, String user_nm, String user_sex, String user_age, String user_major,
			String user_phone, String user_email, String apply_date, String apply_time, String apply_datetime,
			String apply_title, String apply_contents, String send_mail_title, String send_mail_contents,
			String user_visits, String user_ins_dt, String user_udt_id, String user_udt_dt) {
		super();
		this.seq = seq;
		this.user_nm = user_nm;
		this.user_sex = user_sex;
		this.user_age = user_age;
		this.user_major = user_major;
		this.user_phone = user_phone;
		this.user_email = user_email;
		this.apply_date = apply_date;
		this.apply_time = apply_time;
		this.apply_datetime = apply_datetime;
		this.apply_title = apply_title;
		this.apply_contents = apply_contents;
		this.send_mail_title = send_mail_title;
		this.send_mail_contents = send_mail_contents;
		this.user_visits = user_visits;
		this.user_ins_dt = user_ins_dt;
		this.user_udt_id = user_udt_id;
		this.user_udt_dt = user_udt_dt;
	}

	/**
	 * @return the seq
	 */
	public String getSeq() {
		return seq;
	}

	/**
	 * @param seq the seq to set
	 */
	public void setSeq(String seq) {
		this.seq = seq;
	}

	/**
	 * @return the user_nm
	 */
	public String getUser_nm() {
		return user_nm;
	}

	/**
	 * @param user_nm the user_nm to set
	 */
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	/**
	 * @return the user_sex
	 */
	public String getUser_sex() {
		return user_sex;
	}

	/**
	 * @param user_sex the user_sex to set
	 */
	public void setUser_sex(String user_sex) {
		this.user_sex = user_sex;
	}

	/**
	 * @return the user_age
	 */
	public String getUser_age() {
		return user_age;
	}

	/**
	 * @param user_age the user_age to set
	 */
	public void setUser_age(String user_age) {
		this.user_age = user_age;
	}

	/**
	 * @return the user_major
	 */
	public String getUser_major() {
		return user_major;
	}

	/**
	 * @param user_major the user_major to set
	 */
	public void setUser_major(String user_major) {
		this.user_major = user_major;
	}

	/**
	 * @return the user_phone
	 */
	public String getUser_phone() {
		return user_phone;
	}

	/**
	 * @param user_phone the user_phone to set
	 */
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	/**
	 * @return the user_email
	 */
	public String getUser_email() {
		return user_email;
	}

	/**
	 * @param user_email the user_email to set
	 */
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	/**
	 * @return the apply_date
	 */
	public String getApply_date() {
		return apply_date;
	}

	/**
	 * @param apply_date the apply_date to set
	 */
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}

	/**
	 * @return the apply_time
	 */
	public String getApply_time() {
		return apply_time;
	}

	/**
	 * @param apply_time the apply_time to set
	 */
	public void setApply_time(String apply_time) {
		this.apply_time = apply_time;
	}

	/**
	 * @return the apply_datetime
	 */
	public String getApply_datetime() {
		if (apply_datetime == null) {
			return apply_date + " " + apply_time + ":00";
		}
		return apply_datetime;
	}

	/**
	 * @param apply_datetime
	 *            the apply_datetime to set
	 */
	public void setApply_datetime(String apply_datetime) {
		this.apply_datetime = apply_datetime;
	}

	/**
	 * @param apply_datetime
	 *            the apply_datetime to set
	 */
	public void setApply_datetime(String date, String time) {
		String beforeFomatDateTime = date + " " + time + ":00";
		System.out.println(beforeFomatDateTime);
		this.apply_datetime = beforeFomatDateTime;
	}

	/**
	 * @return the apply_title
	 */
	public String getApply_title() {
		return apply_title;
	}

	/**
	 * @param apply_title the apply_title to set
	 */
	public void setApply_title(String apply_title) {
		this.apply_title = apply_title;
	}

	/**
	 * @return the apply_contents
	 */
	public String getApply_contents() {
		return apply_contents;
	}

	/**
	 * @param apply_contents the apply_contents to set
	 */
	public void setApply_contents(String apply_contents) {
		this.apply_contents = apply_contents;
	}

	/**
	 * @return the send_mail_title
	 */
	public String getSend_mail_title() {
		return send_mail_title;
	}

	/**
	 * @param send_mail_title the send_mail_title to set
	 */
	public void setSend_mail_title(String send_mail_title) {
		this.send_mail_title = send_mail_title;
	}

	/**
	 * @return the send_mail_contents
	 */
	public String getSend_mail_contents() {
		return send_mail_contents;
	}

	/**
	 * @param send_mail_contents the send_mail_contents to set
	 */
	public void setSend_mail_contents(String send_mail_contents) {
		this.send_mail_contents = send_mail_contents;
	}

	/**
	 * @return the user_visits
	 */
	public String getUser_visits() {
		return user_visits;
	}

	/**
	 * @param user_visits the user_visits to set
	 */
	public void setUser_visits(String user_visits) {
		this.user_visits = user_visits;
	}

	/**
	 * @return the user_ins_dt
	 */
	public String getUser_ins_dt() {
		return user_ins_dt;
	}

	/**
	 * @param user_ins_dt the user_ins_dt to set
	 */
	public void setUser_ins_dt(String user_ins_dt) {
		this.user_ins_dt = user_ins_dt;
	}

	/**
	 * @return the user_udt_id
	 */
	public String getUser_udt_id() {
		return user_udt_id;
	}

	/**
	 * @param user_udt_id the user_udt_id to set
	 */
	public void setUser_udt_id(String user_udt_id) {
		this.user_udt_id = user_udt_id;
	}

	/**
	 * @return the user_udt_dt
	 */
	public String getUser_udt_dt() {
		return user_udt_dt;
	}

	/**
	 * @param user_udt_dt the user_udt_dt to set
	 */
	public void setUser_udt_dt(String user_udt_dt) {
		this.user_udt_dt = user_udt_dt;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "OfflineConsultingContents [seq=" + seq + ", user_nm=" + user_nm + ", user_sex=" + user_sex
				+ ", user_age=" + user_age + ", user_major=" + user_major + ", user_phone=" + user_phone
				+ ", user_email=" + user_email + ", apply_date=" + apply_date + ", apply_time=" + apply_time
				+ ", apply_datetime=" + apply_datetime + ", apply_title=" + apply_title + ", apply_contents="
				+ apply_contents + ", send_mail_title=" + send_mail_title + ", send_mail_contents=" + send_mail_contents
				+ ", user_visits=" + user_visits + ", user_ins_dt=" + user_ins_dt + ", user_udt_id=" + user_udt_id
				+ ", user_udt_dt=" + user_udt_dt + "]";
	}

}
