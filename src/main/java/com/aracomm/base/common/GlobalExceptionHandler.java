package com.aracomm.base.common;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.base.exceptions.InvalidRightException;
import com.aracomm.base.exceptions.UserFileUploadException;
import com.aracomm.base.exceptions.UserMustLoginException;
import com.aracomm.base.security.snack.RequestSnack;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Global exception 핸들러
 * @author Park
 *
 */
@ControllerAdvice
public class GlobalExceptionHandler {
	final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

	@Resource(name="messageSource")
	private MessageSource messageSource;

	@ExceptionHandler(Exception.class)
	public String handleException(HttpServletRequest request, HttpServletResponse response, Exception ex) throws Exception {
		logger.debug("Exception handler executed", ex);

		String view = "error/error";
		ex.printStackTrace();
		/*String exceptionMessage = "";
		if (ex instanceof InvalidAccessException || ex instanceof UserMustLoginException || ex instanceof UserFileUploadException) {
			exceptionMessage = ex.getMessage();

			if (StringUtils.isBlank(exceptionMessage)) {
				exceptionMessage = messageSource.getMessage("msg.common.servererror", null, Locale.getDefault());
			}

		} else {
			exceptionMessage = messageSource.getMessage("msg.common.servererror", null, Locale.getDefault());
		}

		if (RequestSnack.isAjax(request, true)) {	// ajax 요청의 경우 json 응답
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");

			HashMap<String, Object> result = new HashMap<String, Object>();
			result.put(AraCommConst.AJAX_RESPONSE_CODE, AraCommConst.TEXT_FAIL);
			result.put(AraCommConst.AJAX_RESPONSE_MESSAGE, exceptionMessage);

			ObjectMapper objectMapper = new ObjectMapper();
			String json = objectMapper.writeValueAsString(result);

			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();
			return null;
		}

		if (ex instanceof UserMustLoginException || ex instanceof InvalidRightException) {
			view = "error/accessDenied";
		}*/

		return view;

	}

}
