package com.aracomm.base.security.handler;

import com.aracomm.base.security.http.SuccessBody;
import com.aracomm.base.security.snack.RequestSnack;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * 인증(Consumer)된 사용자가 허가되지 않은 페이지에 접근할때 호출되는 헨들러.
 */
public class AccessFailureHandler implements AccessDeniedHandler {
	private static final Logger logger = LoggerFactory.getLogger(AccessFailureHandler.class);
	private final String loginFormUrl;
	private final String errorPage;
	private String redirectUrlParameter = "redirect_url";
	private boolean redirect = true;

	public AccessFailureHandler(String loginFormUrl, String errorPage) {
		this.loginFormUrl = loginFormUrl;
		this.errorPage = errorPage;
	}

	public void setRedirect(boolean redirect) {
		this.redirect = redirect;
	}

	/**
	 * 이동할 url 값을 담을 약속된 파라메터
	 *
	 * @param redirectUrlParameter the redirect url parameter
	 */
	public void setRedirectUrlParameter(String redirectUrlParameter) {
		this.redirectUrlParameter = redirectUrlParameter;
	}

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException exception) throws IOException, ServletException {
		logger.debug("::::::::::AccessFailureHandler::::::::::");

				
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		if(RequestSnack.isAjax(request)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");

			SuccessBody success = new SuccessBody(exception.getMessage(), true);

			ObjectMapper objectMapper = new ObjectMapper();
			String data = objectMapper.writeValueAsString(success);

			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
			out.close();
		} else {
			if (redirect) {
				response.sendRedirect(request.getContextPath() + errorPage);
			} else {
				String url = RequestSnack.getPathQueryString(request);
				request.setAttribute(redirectUrlParameter, url);
				request.setAttribute("loginFormUrl", loginFormUrl);
				request.getRequestDispatcher(request.getContextPath() + errorPage).forward(request, response);
			}
		}
	}
}