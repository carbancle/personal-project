package com.sample.vo;

import java.util.Date;

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
	private Date pubDate;
	private int stock;				// 재고
	private Date createdDate;
	private Date updatedDate;
}
