/**
 * 
 */
package global.segroup.exception;

/**
 * @Author : 이종호
 * @Date : 2017. 10. 3.
 * @Class 설명 : 
 * 
 */
public class AccountStatusException extends org.springframework.security.authentication.AccountStatusException {
	
	public AccountStatusException(String msg, Throwable t) {
		super(msg, t);
	}
}
