package com.sample.exception;

public class CustomException extends RuntimeException {

	private static final long serialVersionUID = 9040654718873050613L;

	public CustomException(String message) {
		super(message);
	}
}
