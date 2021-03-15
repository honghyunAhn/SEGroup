package com.aracomm.changbi.member.vo;

public class IdenForm {
	private String grade;
	private String name;
	private String birth_day;
	private String gender;
	private String phone;
	private String iden_ci;
	private String iden_di;
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getIden_ci() {
		return iden_ci;
	}
	public void setIden_ci(String iden_ci) {
		this.iden_ci = iden_ci;
	}
	public String getIden_di() {
		return iden_di;
	}
	public void setIden_di(String iden_di) {
		this.iden_di = iden_di;
	}
	@Override
	public String toString() {
		return "IdenForm [grade=" + grade + ", name=" + name + ", birth_day=" + birth_day + ", gender=" + gender
				+ ", phone=" + phone + ", iden_ci=" + iden_ci + ", iden_di=" + iden_di + "]";
	}

}
