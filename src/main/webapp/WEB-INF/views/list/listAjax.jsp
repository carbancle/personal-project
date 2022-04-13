<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title></title>
</head>
<body>
<div class="container">
	<div class="row mb-3">
		<div class="col">
			<form id="form-search-book" class="row row-cols-lg-auto g-3 align-items-center" method="get" action="book">
				<input type="hidden" id="page" name="page" value="1" />
				<div class="col-12">
					<select id="searchType" class="form-select" name="opt">
						<option value="" selected disabled="disabled">검색조건을 선택하세요</option>
						<option value="제목" ${'제목' eq param.opt ? 'selected' : ''}> 제목으로 검색</option>
						<option value="저자" ${'저자' eq param.opt ? 'selected' : ''}> 저자 검색</option>
						<option value="출판사" ${'출판사' eq param.opt ? 'selected' : ''}> 출판사로 검색</option>
						<option value="최소가격" ${'최소가격' eq param.opt ? 'selected' : ''}> 최소가격으로 검색</option>
						<option value="최대가격" ${'최대가격' eq param.opt ? 'selected' : ''}> 최대가격으로 검색</option>
					</select>
				</div>
				<div class="col-12">
					<input type="text" id="keyword" class="form-control" name="value" value="${param.value }">
				</div>
				<div class="col-12">
					<!-- <button type="button" class="btn btn-outline-primary btn-sm" id="btn-search-book">검색</button> -->
					<button type="button" onclick="findAll(1);" class="btn btn-primary">
				        <span aria-hidden="true" class="glyphicon glyphicon-search">검색</span>
				    </button>
				</div>
			</form>
		</div>
		<div class="col">
			<select id="rowsPerPage">
		        <option value="10">10개씩보기</option>
		        <option value="15">15개씩보기</option>
		        <option value="20">20개씩보기</option>
			</select>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<table id="list" class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>저자</th>
						<th>출판사</th>
						<th>가격</th>
						<th>할인가격</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	
	<table id="dataTableBody">
	
	</table>
	<c:if test="${pagination.totalRecords gt 0 }">
		<!-- 페이지 내비게이션 표시 -->
		<div class="row mb-3">
			<div class="col">
				<nav>
		  			<ul class="pagination justify-content-center">
		    			
		  			</ul>
				</nav>
			</div>
		</div>
	</c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	window.onload = () => {
			findAll();
			addEnterSearchEvent();
	}
	
	function addEnterSearchEvent() {
		document.getElementById('keyword').addEventListener('keyup', (e) => {
			if (e.keyCode === 13) {
				findAll();
			}
		});
	}
		
	async function getJson(uri, params) {
		if (params) {
			uri = uri + '?' + new URLSearchParams(params).toString();
		}
		
		const response = await fetch(uri);
		
		if (!response.ok) {
			await response.json().then(error => {
				throw error;
			});
		}
		
		return await response.json();
	}
		
	function findAll(page) {
		const form = document.getElementById('form-search-book');
		const params = {
				  page : 1
				, rowsPerPage : 10
				, pagesPerBlock : 10
				, searchType : form.searchType.value
				, keyword : form.keyword.value
		}
		
		getJson('/rest/listAjax', params).then(response => {
			if (!Object.keys(response).length) {
				document.getElementById('dataTableBody').innerHTML = '<td colspan="6">등록된 게시글이 없습니다.</td>';
				
				drowPages();
				
				return false;
			}
			
			
			
			let html = '';
			
			response.books.forEach((obj, idx) => {
				html += `
       				<tr>
  						<td>${obj.no}</td>
  						<td class="text-left">
  							<a href="javascript: void(0);" onclick="goView(${obj.no})">${obj.title}</a>
  						</td>
  						<td>${obj.author}</td>
  						<td>${obj.publisher}</td>
  						<td>${obj.price}</td>
  						<td>${obj.discountPrice}</td>
       				</tr>
       			`;
       		});
			
			document.getElementById('dataTableBody').innerHTML = html;
			drawPages(response.params);
			
		});
	}
	
	function drawPages(params) {
		if (!params) {
			document.querySelector('.pagination').innerHTML = '';
			return false;
		}
		
		let html = '';
		
		if (params.existPrev) {
				html += `
	 				<li><a href="javascript:void(0)" onclick="findAll(1);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
	 				<li><a href="javascript:void(0)" onclick="findAll(${params.beginPage - 1});" aria-label="Previous"><span aria-hidden="true">&lsaquo;</span></a></li>
	 			`;
	 		}
	
 		// 페이지 번호
 		for (let i = params.beginPage; i <= params.endPage; i++) {
 			const active = (i === params.pageNo) ? 'class="active"' : '';
            html += `<li ${active}><a href="javascript:void(0)" onclick="findAll(${i})">${i}</a></li>`;
 		}
 		
 		// 다음 페이지, 마지막 페이지
 		if (params.existNext) {
 			html += `
 				<li><a href="javascript:void(0)" onclick="findAll(${params.endPage + 1});" aria-label="Next"><span aria-hidden="true">&rsaquo;</span></a></li>
 				<li><a href="javascript:void(0)" onclick="findAll(${params.totalPages});" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
 			`;
 		}

	 	document.querySelector('.pagination').innerHTML = html;
	}
	
</script>
</body>
</html>