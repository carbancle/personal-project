package com.sample.web.form;

import com.sample.dto.Pagination;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int page;
	private String opt;
	private String value;
	private int rowsPerPage;
	private int pagesPerBlock;
	private String sort;
	private Pagination pagination;
}
