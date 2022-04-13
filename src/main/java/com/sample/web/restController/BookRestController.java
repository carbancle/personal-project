package com.sample.web.restController;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sample.service.BookService;
import com.sample.web.form.Criteria;

@RestController
@RequestMapping("/rest")
public class BookRestController {

	@Autowired
	private BookService bookService;

	@GetMapping("/bookList")
	public Map<String, Object> getAllBooks(Criteria criteria) {
		return bookService.getAllBooks(criteria);
	}
 
}
