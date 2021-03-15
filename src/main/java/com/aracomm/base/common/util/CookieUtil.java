package com.aracomm.base.common.util;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {


	public static String getCookieObject(HttpServletRequest request, String cookieName, String replace) {
		String value = getCookieObject(request, cookieName);
		return (value == null || ("null".equals(value)))? replace : value;
	}

	public static String getCookieObject(HttpServletRequest request, String cookieName) {
	    String value = null;

		try {
		    Cookie [] cookies = request.getCookies();

	    	if (cookies==null) return null;
	    	for(int i=0;i<cookies.length;i++) {

	    		if(cookieName.equals(cookies[i].getName())) {
					value = cookies[i].getValue();
					if ("".equals(value)) value = null;
		    			break;
	    		}
		    }

		} catch (Exception e) {}

    	return value;
	}

	public static String cookieToString(HttpServletRequest request) {
		String str = "";
		try {
		    Cookie [] cookies = request.getCookies();

	    	if (cookies==null) return str;
	    	for(int i=0;i<cookies.length;i++) {
	    		str += "["+cookies[i].getName() + "=" + cookies[i].getValue() + "]";
		    }

		} catch (Exception e) {}
		return str;
	}

	public static void setCookieObject(HttpServletResponse response,
                                 String name,
                                 String value) {
		setCookieObject(response, name, value, null, -1);
    }

	public static void setCookieObject(HttpServletResponse response,
            String name,
            String value,
            int minuteAge) {
		setCookieObject(response, name, value, null, minuteAge);
	}

	public static void setCookieObject(HttpServletResponse response,
            String name,
            String value,
            String domain,
            int minuteAge) {

		try {
	    	Cookie cookie = new Cookie(name, URLEncoder.encode(value, "UTF-8"));
	    	cookie.setPath("/");
	    	if (minuteAge >= 0) cookie.setMaxAge(60 * minuteAge);
	    	if (domain != null) cookie.setDomain(domain);
	    	response.addCookie(cookie);
		} catch (Exception e) {}
	}

	public static void invalidateCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
		invalidateCookie(request, response, cookieName, null);
	}

	public static void invalidateCookie(HttpServletRequest request, HttpServletResponse response, String cookieName, String domain) {
		Cookie cookie = new Cookie(cookieName, "");
		if (domain != null) cookie.setDomain(domain);
		cookie.setPath("/");
	    cookie.setMaxAge(0);
	    response.addCookie(cookie);
	}

}
