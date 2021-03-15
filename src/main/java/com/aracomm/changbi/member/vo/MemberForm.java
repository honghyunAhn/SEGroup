package com.aracomm.changbi.member.vo;

public class MemberForm {
	private String grade;
	private String id;
	private String id1;
	private String id2;
	private String name;
	private String pw;
	private String phone;
	private String phone1;
	private String phone2;
	private String phone3;
	private String tel;
	private String tel1;
	private String tel2;
	private String tel3;
	private String email;
	private String email1;
	private String email2;
	private String birth_day;
	private String gender;
	private String post_code;
	private String addr1;
	private String addr2;
	private String recomm_id;
	private String iden_di;// 인증용
	private String belong_to;
	private SchoolForm schoolForm;

	/** 입력 폼에 존재하지 않는 항목 **/
	private String enc_pw;
	private String locale = "ko";
	private String accept_sns = "Y";
	private String accept_email = "N";
	private String accept_sms = "N";
	private String email_yn = "N";
	private String sns_cd;
	private String sns_id;
	private String sns_url;
	private String fax;
	private String user_ip;
	private String user_et;
	

	public String getUser_et() {
		return user_et;
	}

	public void setUser_et(String user_et) {
		this.user_et = user_et;
	}

	public String getUser_ip() {
		return user_ip;
	}

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

	/**
	 * @return the belong_to
	 */
	public String getBelong_to() {
		return belong_to;
	}

	/**
	 * @param belong_to the belong_to to set
	 */
	public void setBelong_to(String belong_to) {
		this.belong_to = belong_to;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth_day() {
		return birth_day;
	}
	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPost_code() {
		return post_code;
	}
	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getRecomm_id() {
		return recomm_id;
	}
	public void setRecomm_id(String recomm_id) {
		this.recomm_id = recomm_id;
	}
	public SchoolForm getSchoolForm() {
		return schoolForm;
	}
	public void setSchoolForm(SchoolForm schoolForm) {
		this.schoolForm = schoolForm;
	}
	public String getEnc_pw() {
		return enc_pw;
	}
	public void setEnc_pw(String enc_pw) {
		this.enc_pw = enc_pw;
	}
	public String getLocale() {
		return locale;
	}
	public void setLocale(String locale) {
		this.locale = locale;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getAccept_sns() {
		return accept_sns;
	}
	public void setAccept_sns(String accept_sns) {
		this.accept_sns = accept_sns;
	}
	public String getAccept_email() {
		return accept_email;
	}
	public void setAccept_email(String accept_email) {
		this.accept_email = accept_email;
	}
	public String getAccept_sms() {
		return accept_sms;
	}
	public void setAccept_sms(String accept_sms) {
		this.accept_sms = accept_sms;
	}
	public String getEmail_yn() {
		return email_yn;
	}
	public void setEmail_yn(String email_yn) {
		this.email_yn = email_yn;
	}
	public String getSns_cd() {
		return sns_cd;
	}
	public void setSns_cd(String sns_cd) {
		this.sns_cd = sns_cd;
	}
	public String getSns_id() {
		return sns_id;
	}
	public void setSns_id(String sns_id) {
		this.sns_id = sns_id;
	}
	public String getSns_url() {
		return sns_url;
	}
	public void setSns_url(String sns_url) {
		this.sns_url = sns_url;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getId1() {
		return id1;
	}
	public void setId1(String id1) {
		this.id1 = id1;
	}
	public String getId2() {
		return id2;
	}
	public void setId2(String id2) {
		this.id2 = id2;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getIden_di() {
		return iden_di;
	}
	public void setIden_di(String iden_di) {
		this.iden_di = iden_di;
	}

	@Override
	public String toString() {
		return "MemberForm [grade=" + grade + ", id=" + id + ", id1=" + id1 + ", id2=" + id2 + ", name=" + name
				+ ", pw=" + pw + ", phone=" + phone + ", phone1=" + phone1 + ", phone2=" + phone2 + ", phone3=" + phone3
				+ ", tel=" + tel + ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3 + ", email=" + email
				+ ", email1=" + email1 + ", email2=" + email2 + ", birth_day=" + birth_day + ", gender=" + gender
				+ ", post_code=" + post_code + ", addr1=" + addr1 + ", addr2=" + addr2 + ", recomm_id=" + recomm_id
				+ ", iden_di=" + iden_di + ", belong_to=" + belong_to + ", schoolForm=" + schoolForm + ", enc_pw="
				+ enc_pw + ", locale=" + locale + ", accept_sns=" + accept_sns + ", accept_email=" + accept_email
				+ ", accept_sms=" + accept_sms + ", email_yn=" + email_yn + ", sns_cd=" + sns_cd + ", sns_id=" + sns_id
				+ ", sns_url=" + sns_url + ", fax=" + fax + ", user_ip=" + user_ip + ", user_et=" + user_et + "]";
	}

	
}
