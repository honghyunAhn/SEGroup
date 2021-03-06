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
	 * ????????? ????????? ??????
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
	 * ???????????? ??????
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
	 * ????????? ????????? ??????
	 * ???????????? ????????? ?????? UserMustLoginException
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
	 * ????????? ????????? ?????? ??????
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
	 * ????????? ??????
	 * ???????????? ?????? ????????? exception ??????
	 * @throws UserMustLoginException
	 */
	protected Authentication getAuthenticationWithException() throws UserMustLoginException {
		Authentication authen = SecurityContextHolder.getContext().getAuthentication();
		if (authen == null || authen.getPrincipal() instanceof String) throw new UserMustLoginException();
		return authen;
	}

	/**
	 * ?????? ?????? ???????????? ?????? ??????
	 * ?????? ?????? ?????? InvalidAccessException ??????
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
