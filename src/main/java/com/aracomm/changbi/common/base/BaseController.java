package com.aracomm.changbi.common.base;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.aracomm.base.common.AraCommConst;
import com.aracomm.base.exceptions.InvalidAccessException;
import com.aracomm.base.exceptions.UserMustLoginException;
import com.aracomm.changbi.user.vo.UserVo;

public class BaseController {

	protected String getMessage(MessageSource messageSource, String code) {
		return messageSource.getMessage(code, null, Locale.getDefault());
	}

	protected String getMessage(MessageSource messageSource, Object [] arguments, String code) {
		return messageSource.getMessage(code, arguments, Locale.getDefault());
	}

	protected HashMap<String, Object> getAjaxFailResult(String message) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put(AraCommConst.AJAX_RESPONSE_CODE, AraCommConst.TEXT_FAIL);
		result.put(AraCommConst.AJAX_RESPONSE_MESSAGE, message);
		return result;
	}

	protected HashMap<String, Object> getDefaultAjaxSuccessResult() {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put(AraCommConst.AJAX_RESPONSE_CODE, AraCommConst.TEXT_SUCCESS);
		return result;
	}

	protected HashMap<String, Object> getAjaxSuccessResult(String message) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put(AraCommConst.AJAX_RESPONSE_CODE, AraCommConst.TEXT_SUCCESS);
		result.put(AraCommConst.AJAX_RESPONSE_MESSAGE, message);
		return result;
	}

	protected HashMap<String, Object> getSimpleAjaxResult() {
		HashMap<String, Object> result = new HashMap<String, Object>();
		return result;
	}

	protected String forward() {
		return "forward:"+AraCommConst.URL_FORWARD;
	}

	protected String forward(String strForwardURL) {
		return "forward:" + strForwardURL;
	}

	protected String getMessageAndBackScript(String message) {
		return "alert('"+cr2slashn(message)+"'); history.back();";
	}

	protected String getMessageAndMoveUrlScript(String message, String url) {
		return "alert('"+cr2slashn(message)+"'); location.href='"+url + "';";
	}

	public String cr2slashn(String str) {
		return str.replaceAll("\\n", "\\\\n");
	}

	/**
	 * 로그인 아이디 조회
	 * @return
	 * @throws UserMustLoginException
	 */
	protected String getLoginUserId() {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {
			return null;
		}
		return authen.getName();
	}

	/**
	 * 로그인명 조회
	 * @return
	 */
	protected String getLoginUserName() {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {
			return null;
		}
		UserVo userVo = (UserVo)authen.getPrincipal();
		return userVo.getName();
	}

	/**
	 * 로그인 아이디 조회
	 * 로그인이 안됐을 경우 UserMustLoginException
	 * @return
	 * @throws UserMustLoginException
	 */
	protected String getLoginUserIdWithException() throws UserMustLoginException {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {
			throw new UserMustLoginException();
		}
		return authen.getName();
	}

	/**
	 * 로그인 사용자 정보 조회
	 * @return
	 * @throws UserMustLoginException
	 */
	protected UserVo getLoginUserInfo() {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) {
			return null;
		}
		return (UserVo)authen.getPrincipal();
	}

	/**
	 * 로그인 체크
	 * 로그인이 없는 접근은 exception 발생
	 * @throws UserMustLoginException
	 */
	protected Authentication getAuthenticationWithException() throws UserMustLoginException {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) throw new UserMustLoginException();
		return authen;
	}

	/**
	 * 필수 입력 파라메터 입력 체크
	 * 값이 없을 경우 InvalidAccessException 발생
	 * @param fields
	 * @param target
	 */
	protected void checkNullParameterWithException(String [] fields, Map<String, String> target) throws InvalidAccessException {
		if (fields == null || fields.length < 1) return;
		if (target == null) throw new InvalidAccessException();
		String field;
		for(int i=0; i<fields.length; i++) {
			field = fields[i];
			if (StringUtils.isBlank(target.get(field))) {
				throw new InvalidAccessException();
			}
		}
	}
}
