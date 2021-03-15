/**
 * 
 */
package global.segroup.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * @Author : 이종호
 * @Date : 2017. 7. 17.
 * @Class 설명 : 웹 애플리케이션의 공통 예외 처리 클래스
 * 
 */
@ControllerAdvice
public class SEExceptionHandler {
	
	/**
	 * @Method Name : errorHandler
	 * @Date : 2017. 7. 17.
	 * @User : 이종호
	 * @Param : Exception 
	 * @Method 설명 : 모든 종류의 Exception 처리
	 * @Return : JSP 페이지
	 */
	@ExceptionHandler (Exception.class)
	public String errorHandler(Exception e) {
		e.printStackTrace();
		return "/error";
	}
}
