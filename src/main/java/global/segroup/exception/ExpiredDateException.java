/**
 * 
 */
package global.segroup.exception;

/**
 * @Author : 이종호
 * @Date : 2018. 9. 13.
 * @Class 설명 : 관리자 권한 기간 만료 예외 
 * 
 */
public class ExpiredDateException extends Exception {

	public ExpiredDateException(String message){
		super(message);
	}
}
