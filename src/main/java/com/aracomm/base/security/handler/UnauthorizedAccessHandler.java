package com.aracomm.base.security.handler;

import com.aracomm.base.security.http.SuccessBody;
import com.aracomm.base.security.snack.RequestSnack;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * 인증(Consumer)되지 않은 사용자가 허가되지 않은 페이지에 접근할때 요청되는 헨들러.
 */
public class UnauthorizedAccessHandler implements AuthenticationEntryPoint {
	private static final Logger logger = LoggerFactory.getLogger(UnauthorizedAccessHandler.class);
	private final String loginFormUrl;
	private final String errorPage;
	private String redirectUrlParameter = "redirect_url";
	private boolean redirect = true;
	private final String doitFormUrl;
	private final String rainbowFormUrl;
	private final String eduFormUrl;

	public UnauthorizedAccessHandler(String loginFormUrl, String errorPage, String doitFormUrl, String rainbowFormUrl, String eduFormUrl) {
		this.loginFormUrl = loginFormUrl;
		this.errorPage = errorPage;
		this.doitFormUrl = doitFormUrl;
		this.rainbowFormUrl = rainbowFormUrl;
		this.eduFormUrl = eduFormUrl;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		String url = RequestSnack.getPathQueryString(request);
		logger.debug("::::::::::UnauthorizedAccessHandler::::::::::");
		if(RequestSnack.isAjax(request)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");
			SuccessBody success = new SuccessBody();

			success.setMessage(exception.getMessage());
			success.setError(true);

			ObjectMapper objectMapper = new ObjectMapper();
			String data = objectMapper.writeValueAsString(success);
			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
			out.close();
		} else {
			if (redirect) {
				response.sendRedirect(request.getContextPath() + loginFormUrl);
			} else {
//				String url = RequestSnack.getPathQueryString(request);
//				request.setAttribute(redirectUrlParameter, url);
//				request.setAttribute("loginFormUrl", loginFormUrl);
//				request.getRequestDispatcher(request.getContextPath() + errorPage).forward(request, response);
				//임시방편이므로 추후 수정이 필요함
				if(url.contains("/edu")) response.sendRedirect(request.getContextPath() + eduFormUrl);
				else if(url.contains("/smtp"))  response.sendRedirect(request.getContextPath() + rainbowFormUrl);
				else if(url.contains("/lms"))  response.sendRedirect(request.getContextPath() + doitFormUrl);
			}
		}
	}
}



/**
 * 커스텀 전 소스임
 * 인증(Consumer)되지 않은 사용자가 허가되지 않은 페이지에 접근할때 요청되는 헨들러.
 
public class UnauthorizedAccessHandler implements AuthenticationEntryPoint {
	private static final Logger logger = LoggerFactory.getLogger(UnauthorizedAccessHandler.class);
	private final String loginFormUrl;
	private boolean redirect = true;

	public UnauthorizedAccessHandler(String loginFormUrl) {
		this.loginFormUrl = loginFormUrl;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		logger.debug("::::::::::UnauthorizedAccessHandler::::::::::");
		if(RequestSnack.isAjax(request)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");
			SuccessBody success = new SuccessBody();

			success.setMessage(exception.getMessage());
			success.setError(true);

			ObjectMapper objectMapper = new ObjectMapper();
			String data = objectMapper.writeValueAsString(success);
			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
			out.close();
		} else {
			if (redirect) {
				response.sendRedirect(request.getContextPath() + loginFormUrl);
			} else {
				request.getRequestDispatcher(request.getContextPath() + loginFormUrl).forward(request, response);
			}
		}
	}
}
*/
