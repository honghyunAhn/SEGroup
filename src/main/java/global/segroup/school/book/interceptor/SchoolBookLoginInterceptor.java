/**
 * 
 */
package global.segroup.school.book.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import global.segroup.interceptor.LoginInterceptor;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : Soft Engineer School 로그인 인터셉터
 * 
 */
public class SchoolBookLoginInterceptor extends LoginInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//로그인되지 않은 경우 로그인 페이지로 이동
		if(!super.preHandle(request, response, handler)){
			//request.getContextPath()로 루트 경로를 구하여 절대 경로로 처리
			response.sendRedirect(request.getContextPath() + "/login");
		}
		return true;
	}

}
