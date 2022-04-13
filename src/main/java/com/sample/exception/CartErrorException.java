package com.sample.exception;

public class CartErrorException extends CustomException {

	private static final long serialVersionUID = -8218008046724716557L;

	public CartErrorException(String message) {
		super(message);
	}
}
