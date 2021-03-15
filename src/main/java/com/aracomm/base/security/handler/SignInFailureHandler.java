package com.aracomm.base.security.handler;

import com.aracomm.base.security.http.StatusCode;
import com.aracomm.base.security.http.SuccessBody;
import com.aracomm.base.security.snack.RequestSnack;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;

/**
 * 로그인 실패할 경우 호출되는 헨들러
 *
 */
public class SignInFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	private static final Logger logger = LoggerFactory.getLogger(SignInFailureHandler.class);

	@Resource(name="messageSource")
	private MessageSource messageSource;

	public SignInFailureHandler() {}

	public SignInFailureHandler(String defaultFailureUrl) {
		super(defaultFailureUrl);
	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		logger.debug("::::::::::SignInFailureHandler::::::::::");
		
		if(RequestSnack.isAjax(request)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");

			SuccessBody success = new SuccessBody();

			success.setError(true);
			success.setStatusCode(StatusCode.CheckIdPassword);
			success.setMessage(messageSource.getMessage("msg.security.notfound", null, Locale.getDefault()));

			ObjectMapper objectMapper = new ObjectMapper();
			String json = objectMapper.writeValueAsString(success);
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();
		} else {
			super.onAuthenticationFailure(request, response, exception);
		}
	}
}