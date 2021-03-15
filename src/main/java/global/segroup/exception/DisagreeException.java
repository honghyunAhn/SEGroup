/**
 * 
 */
package global.segroup.exception;

/**
 * @Author : 김준영
 * @Date : 2019. 1. 23.
 * @Class 설명 : 회원가입 미동의 예외
 * 
 */
public class DisagreeException extends Exception{
	
	private String id;
	
	public DisagreeException(String message, String id){
		
		super(message);
		this.id = id;
	}
	
	public String getId(){
		return this.id;
	}
	
}
