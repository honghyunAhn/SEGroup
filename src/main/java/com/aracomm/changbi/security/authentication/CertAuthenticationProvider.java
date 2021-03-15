package com.aracomm.changbi.security.authentication;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.aracomm.base.security.auth.CertAuthenticationToken;
import com.aracomm.changbi.user.dao.UserDao;
import com.aracomm.changbi.user.vo.UserVo;

/**
 * 인증서 로그인 인증 privider
 * @author Park
 *
 */
public class CertAuthenticationProvider implements AuthenticationProvider {
	private static final Logger logger = LoggerFactory.getLogger(CertAuthenticationProvider.class);

	@Autowired
	private UserDao dao;


	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String iden_di = authentication.getName();

		System.out.println("2121");
		
		Map<String,Object> user = dao.selectUserForLoginByIdenDi(iden_di);

		if(user == null ) throw new UsernameNotFoundException("iden_id");

		List<GrantedAuthority> gas = new ArrayList<GrantedAuthority>();
		gas.add(new SimpleGrantedAuthority((String)user.get("AUTHORITY")));

		UserVo principal = new UserVo(
				(String)user.get("USER_ID"),
				"[cert di authentication]",
				gas,
				(String)user.get("NAME"),
				(String)user.get("EMAIL"),
				(String)user.get("PHONE"),
				(String)user.get("SCHOOL_NAME"),
				(String)user.get("IP_USE_YN"),
				(String)user.get("PW_INIT_YN")
		);

		principal.setSelfCertDone(true);

		CertAuthenticationToken token = new CertAuthenticationToken(principal, gas);

		return token;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return (CertAuthenticationToken.class
				.isAssignableFrom(authentication));
	}

}
