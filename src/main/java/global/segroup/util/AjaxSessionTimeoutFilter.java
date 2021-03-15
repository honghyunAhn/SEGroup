/**
 * 
 */
package global.segroup.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;

/**
 * @Author : user
 * @Date : 2019. 5. 29.
 * @Class 설명 : 
 * 
 */
public class AjaxSessionTimeoutFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger(AjaxSessionTimeoutFilter.class);
	
	private String ajaxHeader;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		logger.info("doFilter {}",req.getServletPath());
		
		if(isAjaxRequest(req)) {
			try {
				chain.doFilter(req, res);
			}catch(AccessDeniedException e) {
				res.sendError(HttpServletResponse.SC_FORBIDDEN);
			}catch(AuthenticationException e) {
				res.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			}
		} else {
			chain.doFilter(req, res);
		}
		
	}
	@Override
	public void destroy() {
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
		return req.getHeader(ajaxHeader) != null
				&& req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
	}
	
	public void setAjaxHeader(String ajaxHeader) {
		this.ajaxHeader = ajaxHeader;
	}
}
