package global.segroup.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer Group 로그인 인터셉터 
 * 
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.debug("LoginInterceptor 실행");
		
		//세션의 로그인 정보 읽기
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		//로그인되지 않은 경우 로그인 페이지로 이동
		if (loginId == null){
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}
	
}
