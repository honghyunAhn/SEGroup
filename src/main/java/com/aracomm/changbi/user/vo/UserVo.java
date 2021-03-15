package com.aracomm.changbi.user.vo;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class UserVo extends User {

	private static final long serialVersionUID = 1L;
	private String name;
	private String email;
	private String phone;
	private String school_name;
	private String ip_use_yn;
	private String pw_init_yn;
	private boolean selfCertDone = false;	// 본인인증 여부(강의실 본인인증체크용)

	public UserVo(String username
			, String password
			, Collection<? extends GrantedAuthority> authorities
			, String name
			, String email
			, String phone
			, String school_name
			, String ip_use_yn
			, String pw_init_yn) {
		super(username, password, authorities);
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.school_name = school_name;
		this.ip_use_yn = ip_use_yn;
		this.pw_init_yn = pw_init_yn;
	}
	public String getIp_use_yn() {
		return ip_use_yn;
	}
	public void setIp_use_yn(String ip_use_yn) {
		this.ip_use_yn = ip_use_yn;
	}
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}


	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getPw_init_yn() {
		return pw_init_yn;
	}
	public void setPw_init_yn(String pw_init_yn) {
		this.pw_init_yn = pw_init_yn;
	}

	public boolean isSelfCertDone() {
		return selfCertDone;
	}
	public void setSelfCertDone(boolean selfCertDone) {
		this.selfCertDone = selfCertDone;
	}
	@Override
	public String toString() {
		return "UserVo [name=" + name + ", email=" + email + ", phone=" + phone + ", school_name=" + school_name
				+ ", ip_use_yn=" + ip_use_yn + ", pw_init_yn=" + pw_init_yn + ", selfCertDone=" + selfCertDone + "]";
	}

}
