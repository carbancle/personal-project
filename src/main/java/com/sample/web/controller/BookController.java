package com.sample.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sample.service.BookService;
import com.sample.vo.Book;

@Controller
@RequestMapping("/book")
public class BookController {

	@Autowired
	BookService bookService;
	
	@GetMapping("/list")
	public String books() {
		
		return "book/list";
	}
	
	@GetMapping("/detail")
	public String detail() {
		
		return "book/detail";
	}
	
	@GetMapping("/insert")
	public String insert() {
		
		return "book/insert";
	}
	
	@PostMapping("/insert")
	public String insertForm(Book book) {
		
		Book savedBook = new Book();
		
		savedBook.setTitle(book.getTitle());
		savedBook.setAuthor(book.getAuthor());
		savedBook.setPublisher(book.getPublisher());
		savedBook.setPrice(book.getPrice());
		savedBook.setDiscountPrice(book.getDiscountPrice());
		savedBook.setPubDate(book.getPubDate());
		savedBook.setStock(book.getStock());
		
		bookService.insertBook(savedBook);
		
		return "redirect:/book/list";
	}
	
}
