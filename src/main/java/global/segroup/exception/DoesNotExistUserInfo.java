/**
 * 
 */
package global.segroup.exception;

/**
 * @Author : Administrator
 * @Date : 2019. 2. 25.
 * @Class 설명 : 
 * 
 */
public class DoesNotExistUserInfo extends Exception{
	
	private String id;

	public DoesNotExistUserInfo(String message, String id){
		super(message);
		this.id = id;
	}

	public String getId() {
		return id;
	}
	
}
