package com.sample.dto;

import com.sample.web.form.Criteria;

import lombok.Getter;

@Getter
public class Pagination {
	
	private int totalRecords;				// 총 데이터 갯수
	private int totalPages;					// 총 페이지 갯수
	private int beginPage;					// 현재 블록번호에 해당하는 시작 페이지 번호
	private int endPage;					// 현재 블록번호에 해당하는 끝 페이지 번호
	private int begin;						// 현재 페이지번호에 해당하는 데이터 조회 시작 순번
	private int end;						// 현재 페이지번호에 해당하는 데이터 조회 끝 순번
	private boolean isExistPrev;			// 이전 페이지 존재 여부
	private boolean isExistNext;			// 다음 페이지 존재 여부
	private int totalBlocks;				// 총 페이지블록 갯수
	private int currentBlock;				// 현재 페이지 번호에 해당하는 현재 블록 번호
	private int prevPage;					// 이전 블록의 페이지번호
	private int nextPage;					// 다음 블록의 페이지번호
	
	public Pagination(int totalRecords, Criteria criteria) {
		if(totalRecords > 0) {
			this.totalRecords = totalRecords;
			this.init(criteria);
		}
	}
	
	private void init(Criteria criteria) {
		// 전체 페이지 수를 계산한다. (0으로 나눌시 에러가 나는 것을 if문으로 예방 => 추후 전역 예외설정에서 예외처리되도록 할 것)
		if (criteria.getRowsPerPage() != 0) {
			totalPages = (int)(Math.ceil((double)totalRecords / criteria.getRowsPerPage()));
		}
		
		// 전체 블록 수를 계산한다. (0으로 나눌시 에러가 나는 것을 if문으로 예방 => 추후 전역 예외설정에서 예외처리되도록 할 것)
		if (criteria.getPagesPerBlock() != 0) {			
			totalBlocks = (int)(Math.ceil((double)totalPages / criteria.getPagesPerBlock()));
		}
		
		// 현재 페이지가 전체페이지보다 커지는 경우 전체페이지 값을 현재 페이지에 대입한다.
		if (criteria.getPage() > totalPages) {
			criteria.setPage(totalPages);
		}
		
		// 현재 페이지번호에 해당하는 데이터조회 시작 순번과 끝 순번을 계산해서 멤버변수에 대입한다.
		begin = (criteria.getPage() - 1)* criteria.getRowsPerPage() + 1;
		end = (criteria.getPage()) * criteria.getRowsPerPage();
		
		// 현재 블록을 계산해서 멤버변수에 대입한다. (0으로 나눌시 에러가 나는 것을 if문으로 예방 => 추후 전역 예외설정에서 예외처리되도록 할 것)
		if (criteria.getPagesPerBlock() != 0) {
			currentBlock = (int)(Math.ceil((double)criteria.getPage() / criteria.getPagesPerBlock()));			
		}
		
		// 시작 페이지와 끝 페이지를 계산해서 멤버변수에 대입한다.			
		beginPage = (currentBlock - 1) * criteria.getPagesPerBlock() + 1;
		endPage = currentBlock * criteria.getPagesPerBlock();
		
		// 현재 블록과 마지막 블록의 값이 동일한 경우 전체페이지의 값을 마지막 페이지에 대입한다.
		if (currentBlock == totalBlocks) {
			endPage = totalPages;
		}
		
		// 현재 페이지번호에 대한 이전 블록의 페이지번호를 계산해서 멤버변수에 대입한다.
		if (currentBlock > 1) {
			prevPage = (currentBlock - 1) * criteria.getPagesPerBlock();
		}
		// 현재 페이지번호에 대한 다음 블록의 페이지번호를 계산해서 멤버변수에 대입한다.
		if (currentBlock < totalBlocks) {
			nextPage = currentBlock * criteria.getPagesPerBlock() + 1;
		}
		
		// 시작페이지가 1이 아닌경우 이전페이지의 존재 여부를 true로 반환
		isExistPrev= beginPage != 1;
		
		// 마지막페이지와 페이지당 데이터 표현 갯수의 곱이 전체 데이터 갯수를 초과하지 않는 경우 다음페이지의 존재 여부를 true로 반환한다.
		isExistNext = (endPage * criteria.getRowsPerPage()) < totalRecords;
		
	}
	
}