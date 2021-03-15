package com.aracomm.changbi.security.handler;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.aracomm.base.security.http.SuccessBody;
import com.aracomm.base.security.snack.RequestSnack;
import com.aracomm.changbi.user.dao.UserDao;
import com.aracomm.changbi.user.vo.UserVo;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 로그인 성공후 후처리를 하는 handler
 *
 */
public class SignInSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	private static final Logger logger = LoggerFactory.getLogger(SignInSuccessHandler.class);
	private static String COOKIE_SAVEDID_USE_PARAM = "saveIdChecked";
	private static String COOKIE_SAVEDID_NAME = "__cbuser__";
	private static int COOKIE_SAVEDID_MAX_AGE = 60 * 60 * 24 * 31;	// 한달
	private static String COOKIE_INIT_PASSWORD_NAME = "__initpass__";

	private boolean httpRedirect = true;
	private int httpPort = 80;

	@Autowired
	private UserDao userDao;	// Service autowired가 되지 않음 (xml과 annotation 통한 빈생성 순위...)

	public void setHttpRedirect(boolean httpRedirect) {
		this.httpRedirect = httpRedirect;
	}

	public void setHttpPort(int httpPort) {
		this.httpPort = httpPort;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		logger.debug("::::::::::SignInSuccessHandler::::::::::");
		
		UserVo userVo = (UserVo)authentication.getPrincipal();

		// 로그인일시 갱신
		try {
			userDao.updateLastLogin(userVo.getUsername());
		} catch (Exception ex) {
			logger.error("last login update failed", ex);
		}

		// 아이디 저장 쿠키
		String saveIdChecked = request.getParameter(COOKIE_SAVEDID_USE_PARAM);
		if ("Y".equals(saveIdChecked)) {
			String userid = userVo.getUsername();
			Cookie cookie = new Cookie(COOKIE_SAVEDID_NAME, userid);
			cookie.setPath("/");
			cookie.setMaxAge(COOKIE_SAVEDID_MAX_AGE);
			response.addCookie(cookie);

			// 패스워드 변경 필요 여부 쿠키
			cookie = new Cookie(COOKIE_INIT_PASSWORD_NAME, userVo.getPw_init_yn());
			cookie.setPath("/");
			response.addCookie(cookie);

		} else {
			Cookie cookie = new Cookie(COOKIE_SAVEDID_NAME, "");
			cookie.setPath("/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}

		response.setStatus(HttpServletResponse.SC_OK);
		if (RequestSnack.isAjax(request)) {
			response.setContentType("application/json");
			response.setCharacterEncoding("utf-8");

			SuccessBody success = new SuccessBody();

			success.setError(false);


			Map<String, Object> data = new HashMap<String, Object>();

			String redirectUrl = determineTargetUrl(request, response);
			if (request.isSecure() && httpRedirect) {
				redirectUrl = "http://"+getRemoteDomain(request)+(httpPort==80?"":(":"+httpPort))+redirectUrl;
				logger.debug("switch to http : " + redirectUrl);
			}
			data.put("redirectUrl", redirectUrl);

			success.setData(data);

			ObjectMapper objectMapper = new ObjectMapper();
			String json = objectMapper.writeValueAsString(success);

			PrintWriter out = response.getWriter();
			out.print(json);
			out.flush();
			out.close();

		} else {
			super.onAuthenticationSuccess(request, response, authentication);
		}
	}


	@Override
	protected void handle(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		String targetUrl = determineTargetUrl(request, response);

		RedirectStrategy redirectStrategy = getRedirectStrategy();

		if (response.isCommitted()) {
			logger.debug("Response has already been committed. Unable to redirect to "
					+ targetUrl);
			return;
		}

		if (request.isSecure() && httpRedirect) {
			targetUrl = "http://"+getRemoteDomain(request)+(httpPort==80?"":(":"+httpPort))+targetUrl;
			logger.debug("switch to http : " + targetUrl);
		}

		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	/**
	 * 도메인 추출
	 * @param request
	 * @return
	 */
	private String getRemoteDomain(HttpServletRequest request) {
		String domain = "";
		String url = request.getRequestURL().toString();


		String u1 = url.replaceFirst("https?://", "");
		int idx = u1.indexOf(":");
		if (idx < 0) idx = u1.indexOf("/");

		if (idx < 0) domain = u1;
		else domain = u1.substring(0, idx);

		return domain;
	}

	/**
	 * 현재요청과 이전요청이 동일한 protocol인지 여부
	 * TODO 삭제예정
	 * @param request
	 * @return
	 */
	private boolean isSameProtocalWithFrom(HttpServletRequest request) {
		String referer = request.getHeader("REFERER");
		String requestUrl = request.getRequestURL().toString();

		if (referer == null) referer = "";
		String fromProtocol = referer.substring(0, referer.indexOf("://"));
		String thisProtocol = requestUrl.substring(0, requestUrl.indexOf("://"));


		return thisProtocol.equals(fromProtocol);

	}
}