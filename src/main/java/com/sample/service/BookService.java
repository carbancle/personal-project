package com.sample.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sample.dto.Pagination;
import com.sample.mapper.BookMapper;
import com.sample.vo.Book;
import com.sample.web.form.Criteria;

@Service
public class BookService {

	@Autowired
	BookMapper bookMapper;
	
	public void insertBook(Book book) {
		bookMapper.insertBook(book);
	}
	
	// 전체 도서 리스트의 갯수를 조회
	public int getTotalRows(Criteria criteria) {
		return bookMapper.getBooksTotalRows(criteria);
	}
	
	// 해당 도서 정보를 조회
	public Book getBookByNo(int no) {
		return bookMapper.getBookByNo(no);
	}
	
	// 전체 도서 리스트를 조회
	public Map<String, Object> getAllBooks(Criteria criteria) {
		int totalRecords = bookMapper.getBooksTotalRows(criteria);
		
		if (totalRecords < 1) {
			return Collections.emptyMap();
		}
		
		Pagination pagination = new Pagination(totalRecords, criteria);
		criteria.setPagination(pagination);
		
		List<Book> books = bookMapper.getAllBooks(criteria);
		
		Map<String, Object> response = new HashMap<>();
		response.put("criteria", criteria);
		response.put("books", books);
		return response;
	}
}
