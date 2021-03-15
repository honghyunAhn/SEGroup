package com.aracomm.base.security.snack;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

public class RequestSnack {
	private RequestSnack() {}

	public static String getPathQueryString(HttpServletRequest request) {
		
		String servlet_path = request.getServletPath();
		String query_string = request.getQueryString();
		query_string = ( StringUtils.isEmpty(query_string) ) ? "" : "?" + query_string;
		String servlet_url = servlet_path + query_string;

		return servlet_url;
	}

	public static boolean isAjax(HttpServletRequest request) {
		return isAjax(request, false);
	}

	public static boolean isAjax(HttpServletRequest request, boolean ignoreAccept) {
		String accept = request.getHeader("accept");
		String ajax = request.getHeader("X-Requested-With");

		return ((ignoreAccept || StringUtils.indexOf(accept, "json") > -1) && StringUtils.isNotEmpty(ajax));
	}

}
