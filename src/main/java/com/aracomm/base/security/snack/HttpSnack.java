package com.aracomm.base.security.snack;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HttpSnack {
	private HttpSnack() {}
	
	public static HttpServletRequest getHttpServletRequest(ServletRequest request) {

		if (!(request instanceof HttpServletRequest)) throw new RuntimeException("Expecting an HTTP request");
		return (HttpServletRequest) request;
	}

	public static HttpServletResponse getHttpServletResponse(ServletResponse response) {

		if (!(response instanceof HttpServletResponse)) throw new RuntimeException("Expecting an HTTP response");
		return (HttpServletResponse) response;
	}
}
