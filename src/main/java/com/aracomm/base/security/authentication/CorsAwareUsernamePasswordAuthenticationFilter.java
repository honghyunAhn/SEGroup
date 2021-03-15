package com.aracomm.base.security.authentication;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.aracomm.changbi.user.dao.UserDao;

/**
 * ssl ajax cors문제 대응 사용자폼로그인 필터 + SameSite=none 쿠키 추가
 * @author Park
 *
 */
public class CorsAwareUsernamePasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter {
	private static final Logger logger = LoggerFactory.getLogger(CorsAwareUsernamePasswordAuthenticationFilter.class);

	//ssl ajax cors문제 대응
	static final String ORIGIN = "Origin";
	
	private boolean postOnly = true;
	@Autowired
	SqlSession sqlSession;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Autowired
	private UserDao dao;
	

	public CorsAwareUsernamePasswordAuthenticationFilter() {
		super();
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {
		Authentication authentication = null;

		
		logger.debug("attemptAuthentication execute");

		// cors 응답
		String origin = request.getHeader(ORIGIN);
		if (origin != null && !"".equals(origin)) {
			response.addHeader("Access-Control-Allow-Origin", origin);
			response.addHeader("Access-Control-Allow-Methods", "GET, POST, OPTION");
			response.addHeader("Access-Control-Allow-Credentials", "true");
			response.addHeader("Access-Control-Allow-Headers",
					request.getHeader("Access-Control-Request-Headers"));
		}
	    
		if ("OPTIONS".equals(request.getMethod())) {
			try {
				response.getWriter().print("OK");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
		//상수쌤 try-catch 추가
		try {
		authentication = super.attemptAuthentication(request, response);

		}catch(Exception e) {
			e.printStackTrace();
		}


		return authentication;
	}
	

	/*@Override
	public Authentication attemptAuthentication(HttpServletRequest request,
			HttpServletResponse response) throws AuthenticationException {

		// cors 응답
		String origin = request.getHeader(ORIGIN);
		if (origin != null && !"".equals(origin)) {
			response.addHeader("Access-Control-Allow-Origin", origin);
			response.addHeader("Access-Control-Allow-Methods", "GET, POST, OPTION");
			response.addHeader("Access-Control-Allow-Credentials", "true");
			response.addHeader("Access-Control-Allow-Headers",
					request.getHeader("Access-Control-Request-Headers"));
		}
		if ("OPTIONS".equals(request.getMethod())) {
			try {
				response.getWriter().print("OK");
				response.getWriter().flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}

		if (postOnly && !request.getMethod().equals("POST")) {
			throw new AuthenticationServiceException(
					"Authentication method not supported: " + request.getMethod());
		}

		String username = obtainUsername(request);
		String password = obtainPassword(request);

		if (username == null) {
			username = "";
		}

		if (password == null) {
			password = "";
		}

		username = username.trim();

		String ip = CommonUtil.getRemoteAddr(request);

		UsernamePasswordIpAuthenticationToken authRequest = new UsernamePasswordIpAuthenticationToken(
				username, password, ip);

		// Allow subclasses to set the "details" property
		setDetails(request, authRequest);

		return this.getAuthenticationManager().authenticate(authRequest);
	}*/
}
