package com.aracomm.base.security.filter;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.aracomm.base.security.auth.CertAuthenticationToken;
import com.aracomm.base.security.authentication.CorsAwareUsernamePasswordAuthenticationFilter;

/**
 * 인증서로그인 Filter
 * 본인인증모듈의 인증서본인인증 연동
 * @author Park
 *
 */
public class CertAuthenticationFilter extends AbstractAuthenticationProcessingFilter {
	
	private static final Logger logger = LoggerFactory.getLogger(CertAuthenticationFilter.class);

	
	
	static final String ORIGIN = "Origin";
	public static final String SPRING_SECURITY_IDEN_DI_KEY = "certkey";
	private String idenDiParameter = SPRING_SECURITY_IDEN_DI_KEY;

	
	public CertAuthenticationFilter() {
		super(new AntPathRequestMatcher("/user/certsignin", "POST"));
	}

	public String getIdenDiParameter() {
		return idenDiParameter;
	}

	public void setIdenDiParameter(String idenDiParameter) {
		this.idenDiParameter = idenDiParameter;
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException, IOException, ServletException {
		
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
		
		String di = obtainUsername(request);

		return getAuthenticationManager().authenticate(new CertAuthenticationToken(di));
	}


	protected String obtainUsername(HttpServletRequest request) {
		return request.getParameter(idenDiParameter);
	}

	@Override
	public void setFilterProcessesUrl(String filterProcessesUrl) {
		setRequiresAuthenticationRequestMatcher(new AntPathRequestMatcher(filterProcessesUrl, "POST"));
	}

}
