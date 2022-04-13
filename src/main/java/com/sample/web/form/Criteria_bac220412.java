package com.sample.web.form;

import com.sample.dto.Pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria_bac220412 {

	private String page;
	private String opt;
	private String value;
	private int beginIndex;
	private int endIndex;
	private String sort;
	private Pagination pagination;
}
