package com.sample.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sample.service.BookService;

@Controller
@RequestMapping("/list")
public class BookController {

	@Autowired
	BookService bookService;
	
	@GetMapping("/book")
	public String books() {
		
		return "list/book";
	}
	
}
