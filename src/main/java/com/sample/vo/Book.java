package com.sample.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Book {

	private int no;					// 번호
	private String title;			// 책이름
	private String author;			// 저자
	private String publisher;		// 출판사
	private Integer price;			// 가격
	private Integer discountPrice;	// 할인가격
	@JsonFormat(pattern = "yyyy년 M월 d일", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date pubDate;
	private int stock;
	@JsonFormat(pattern = "yyyy년 M월 d일 H시 m분 s초", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date updatedDate;
	@JsonFormat(pattern = "yyyy년 M월 d일 H시 m분 s초", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
	private Date createdDate;
}
