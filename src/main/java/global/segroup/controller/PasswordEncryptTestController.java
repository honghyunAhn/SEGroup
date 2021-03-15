/**
 * 
 */
package global.segroup.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author : 이상철
 * @Date : 2017. 7. 24.
 * @Class 설명 : 비밀번호 암호화 컨트롤러
 * 
 */


@Controller
public class PasswordEncryptTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(PasswordEncryptTestController.class);

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value = "password_encrypt_test", method = RequestMethod.GET)
	public String password_encrypt_test() {
		return "password_encrypt_test";
	}
	
	@ResponseBody
	@RequestMapping(value = "password_encrypt", method = RequestMethod.POST)
	public String password_encrypt(String password_in) {
		String encryptPassword = passwordEncoder.encode(password_in);
		return encryptPassword;
	}
	
	@ResponseBody
	@RequestMapping(value = "password_check", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	public String password_check(String password_check, String encodedPassword) {
		String result = "";
		if(passwordEncoder.matches(password_check, encodedPassword)){
			result = "계정정보 일치";
		}else{
			result = "계정정보 불일치";
		}
		return result;
	}
	
	
}
