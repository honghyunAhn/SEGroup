/**
 * 
 */
package global.segroup.util;

import java.util.Calendar;

/**
 * @Author : user
 * @Date : 2019. 7. 17.
 * @Class 설명 : 
 * 
 */
public class CommonUtil {
	
	public static int getAge(String birth) {
		Calendar cal = Calendar.getInstance();
		
		int currentYear = cal.get(Calendar.YEAR);
		int currentMonth = cal.get(Calendar.MONTH) + 1;
		int currentDay = cal.get(Calendar.DAY_OF_MONTH);
		
		int birthYear = Integer.parseInt(birth.substring(0, 4));
		int birthMonth = Integer.parseInt(birth.substring(5,7));
		int birthDay = Integer.parseInt(birth.substring(8));
		int age = currentYear - birthYear;
		
		//생일이 안 지난 경우 -1
		if(birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) {
			age--;
		}
		
		return age;
	
	}
}
