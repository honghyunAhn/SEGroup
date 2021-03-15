package com.aracomm.base.exceptions;

import org.springframework.security.core.AuthenticationException;

public class NotRegisterdIpLoginException extends AuthenticationException {

	public NotRegisterdIpLoginException(String msg) {
		super(msg);
	}

	public NotRegisterdIpLoginException(String msg, Throwable t) {
		super(msg, t);
	}

}
