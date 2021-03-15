/**
 * 
 */
package global.segroup.exception;

/**
 * @Author : 김준영
 * @Date : 2019. 1. 23.
 * @Class 설명 : 승인 대기 계정 예외
 * 
 */
public class WaitingException extends Exception{

	public WaitingException(String message){
		super(message);
	}
	
}
