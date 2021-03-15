package com.aracomm.base.security.filter;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.GenericFilterBean;

public class SameSiteFilter extends GenericFilterBean{

	
	private static final String SETCOOKIE = "Set-Cookie";
	private static final String SAMESITE = "None";
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		
		chain.doFilter(request, response);
		
		setSameSite(request, response);
	}

	private void setSameSite(HttpServletRequest request, HttpServletResponse response) {
		Collection<String> headers = response.getHeaders(SETCOOKIE); 
		boolean firstHeader = true; 
		for(String header : headers) { 
			if(firstHeader) { 
				response.setHeader(SETCOOKIE, String.format("%s; Secure; HttpOnly; SameSite=%s", header, SAMESITE));
//				response.setHeader(SETCOOKIE, "JSESSIONID=" + request.getRequestedSessionId() + "; path=/; Secure; SameSite=" + SAMESITE + "; HttpOnly;");
				firstHeader = false; 
				continue; 
			}
			response.addHeader(SETCOOKIE, String.format("%s; Secure; HttpOnly; SameSite=%s", header, SAMESITE));
//			response.addHeader(SETCOOKIE, "JSESSIONID=" + request.getRequestedSessionId() + "; path=/; Secure; SameSite=" + SAMESITE + "; HttpOnly;");
		}
	}
}