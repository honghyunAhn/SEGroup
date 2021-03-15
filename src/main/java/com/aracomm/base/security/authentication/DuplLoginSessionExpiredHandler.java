package com.aracomm.base.security.authentication;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.security.web.session.SessionInformationExpiredEvent;
import org.springframework.security.web.session.SessionInformationExpiredStrategy;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.security.http.StatusCode;
import com.aracomm.base.security.http.SuccessBody;
import com.aracomm.base.security.snack.RequestSnack;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 중복로그인으로 세션이 만료되었을 경우 처리하는 handler
 * @author Park
 *
 */
public class DuplLoginSessionExpiredHandler implements SessionInformationExpiredStrategy {
	private static final Logger logger = LoggerFactory.getLogger(DuplLoginSessionExpiredHandler.class);

	@Resource(name="messageSource")
	private MessageSource messageSource;

	private final String expiredUrl;

	public DuplLoginSessionExpiredHandler(String expiredUrl) {
		this.expiredUrl = expiredUrl;
	}

	@Override
	public void onExpiredSessionDetected(SessionInformationExpiredEvent sessionInformationExpiredEvent) throws IOException, ServletException {
		HttpServletRequest request = sessionInformationExpiredEvent.getRequest();
		HttpServletResponse response = sessionInformationExpiredEvent.getResponse();

		logger.info("onExpiredSessionDetected");

		// ajax 요청 구분
		if(RequestSnack.isAjax(request)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");

			SuccessBody success = new SuccessBody();

			success.setError(true);
			success.setStatusCode(StatusCode.CheckIdPassword);
			success.setMessage(messageSource.getMessage("msg.security.dupllogin", null, Locale.getDefault()));

			ObjectMapper objectMapper = new ObjectMapper();
			String json = objectMapper.writeValueAsString(success);
			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();
		} else {
			request.setAttribute(AraCommConst.ACTION_MESSAGE_NAME, messageSource.getMessage("msg.security.dupllogin", null, Locale.getDefault()));
			request.getRequestDispatcher(expiredUrl).forward(request, response);
		}

	}

}
