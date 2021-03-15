package global.segroup.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.segroup.util.AESEncryptor;

@Controller
public class AESEncryptorTestController {

	private static final Logger logger = LoggerFactory.getLogger(AESEncryptorTestController.class);
	
	@Autowired
	private AESEncryptor aesEncryptor;
	
	
	@RequestMapping(value = "aesEncryptor_test", method = RequestMethod.GET)
	public String aesEncryptor_test() {
		return "aesEncryptor_test";
	}
	
	@ResponseBody
	@RequestMapping(value = "aesEncryptor_encrypt", method = RequestMethod.POST)
	public String aesEncryptor_encrypt(String str_in) {
		String encryptStr = "";
		try {
			encryptStr = aesEncryptor.encrypt(str_in);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return encryptStr;
	}
	
	@ResponseBody
	@RequestMapping(value = "aesEncryptor_decrypt", method = RequestMethod.POST, produces = "application/text; charset=utf-8")
	public String aesEncryptor_decrypt(String str_de) {
		String result = "";
		try {
			result = aesEncryptor.decrypt(str_de);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return result;
	}
}
