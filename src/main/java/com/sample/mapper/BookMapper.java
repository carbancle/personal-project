package com.sample.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sample.vo.Book;
import com.sample.web.form.Criteria;

@Mapper
public interface BookMapper {

	void insertBook(Book book);
	
	void updateBook(Book book);
		
	Book getBookByNo(int no);
	
	int getBooksTotalRows(Criteria criteria);
	
	List<Book> getAllBooks(Criteria criteria);
}