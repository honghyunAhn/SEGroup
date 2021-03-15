package com.aracomm.base.exceptions;

public class UserControlException extends RuntimeException {

	public UserControlException() {
	}

	public UserControlException(String message) {
		super(message);
	}

	public UserControlException(Throwable cause) {
		super(cause);
	}

	public UserControlException(String message, Throwable cause) {
		super(message, cause);
	}

	public UserControlException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
