package com.aracomm.changbi.security.authentication;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.aracomm.changbi.user.dao.UserDao;
import com.aracomm.changbi.user.vo.UserVo;


public class UserAuthenticationDetailService implements UserDetailsService {

	private static final Logger logger = LoggerFactory.getLogger(UserAuthenticationDetailService.class);

	@Autowired
	private UserDao dao;

	public UserAuthenticationDetailService() {}

	@Override
	public UserDetails loadUserByUsername(String user_id) throws UsernameNotFoundException {
		System.out.println("tried login**************");

		HashMap<String,Object> user = dao.selectUserForLogin(user_id);

		if(user == null ) throw new UsernameNotFoundException(user_id);

		List<GrantedAuthority> gas = new ArrayList<GrantedAuthority>();
		gas.add(new SimpleGrantedAuthority((String)user.get("AUTHORITY")));

		UserVo userVo = new UserVo(
				(String)user.get("USER_ID"),
				(String)user.get("PASSWORD"),
				gas,
				(String)user.get("NAME"),
				(String)user.get("EMAIL"),
				(String)user.get("PHONE"),
				(String)user.get("SCHOOL_NAME"),
				(String)user.get("IP_USE_YN"),
				(String)user.get("PW_INIT_YN")
		);

		return userVo;
	}

}
