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
			<div id="form-search-book" class="row row-cols-lg-auto g-3 align-items-center">
			<!-- <form id="form-search-book" class="row row-cols-lg-auto g-3 align-items-center" method="get" action="book"> -->
				<input type="hidden" name="page" value="1" />
				<div class="col-12">
					<select class="form-select" name="opt">
						<option value="" selected disabled="disabled">검색조건을 선택하세요</option>
						<option value="제목" ${'제목' eq param.opt ? 'selected' : ''}> 제목으로 검색</option>
						<option value="저자" ${'저자' eq param.opt ? 'selected' : ''}> 저자 검색</option>
						<option value="출판사" ${'출판사' eq param.opt ? 'selected' : ''}> 출판사로 검색</option>
						<option value="최소가격" ${'최소가격' eq param.opt ? 'selected' : ''}> 최소가격으로 검색</option>
						<option value="최대가격" ${'최대가격' eq param.opt ? 'selected' : ''}> 최대가격으로 검색</option>
					</select>
				</div>
				<div class="col-12">
					<input type="text" class="form-control" name="value" value="${param.value }">
				</div>
				<div class="col-12">
					<button type="button" class="btn btn-outline-primary btn-sm" id="btn-search-book">검색</button>
				</div>
			<!-- </form> -->
			</div>
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
			<table class="table">
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
	
	<!-- 페이지 내비게이션 표시 -->
	<div class="row mb-3">
		<div class="col">
			<nav>
	  			<ul class="pagination justify-content-center">
	    			
	  			</ul>
			</nav>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(function() {		
		getPage(1);
		getSearchResult();
	});
	
	function getPage(page) {
		
		var rowsPerPage = $("#rowsPerPage").val();
		var opt = $("#form-search-book select").val();
		var keyword = $("#form-search-book input[name=value]").val();
		
		console.log(rowsPerPage);
		
		$.ajax({
			
			url : "/rest/bookList",
			type : "get",
			datatype : "json",
			data : {
				  page : page					// 페이지 정보
				, rowsPerPage : rowsPerPage		// 페이지당 표시할 데이터 갯수 정보
				, pagesPerBlock : 5				// 페이지네이션에 표시될 블록 갯수
				, opt : opt
				, value : keyword
			},
			success : function(data) {
				
				var criteria = data.criteria;
				var pagination = criteria.pagination;
				var books = data.books;
				
				var str = "";
				
				for (var i = criteria.pagination.begin - 1; i < criteria.pagination.end; i++) {
					
					if(books[i] == null) {
						break;
					}
					
					str += "<tr>";
					str += "<td>" + books[i].no + "</td>";
					str += "<td>" + books[i].title + "</td>";
					str += "<td>" + books[i].author + "</td>";
					str += "<td>" + books[i].publisher + "</td>";
					str += "<td>" + books[i].price + "</td>";
					str += "<td>" + books[i].discountPrice + "</td>";
					str += "</tr>"
				}
			
				$(".table tbody").html(str);
				
				paging(criteria, pagination, page);
				// //데이터 호출 영역				
				
				$("#rowsPerPage").change(function(){
					criteria.rowsPerPage = $("#rowsPerPage").val();
					
					getPage(page, criteria.rowsPerPage);
				})
				
				console.log("현재 페이지번호 : " + page);
				console.log("현재 블록의 값 : " + pagination.currentBlock);
				console.log("전체 블록의 값 : " + pagination.totalBlocks);
				console.log("전체 페이지 : " + pagination.totalPages);
			},
			error : function() {
				alert('data load error');
			}
		});
	
	}
	
	function paging(criteria, pagination, page) {
		// 페이징 영역
		var pageHtml = "";
		
		if (pagination.existPrev) {
			pageHtml += "<li class='page-item'>"
			pageHtml += "<a class='page-link' href='/list/book?page=" + pagination.prevPage + "' data-page='" + pagination.prevPage + "'>이전</a>"
    		pageHtml += "</li>"
		} else {
			pageHtml += "<li class='page-item disabled'>"
			pageHtml += "<a class='page-link' href='/list/book?page=" + pagination.prevPage + "' data-page='" + pagination.prevPage + "'>이전</a>"
    		pageHtml += "</li>"
		}
		
		//페이징 번호 표시
		for (var i = pagination.beginPage; i <= pagination.endPage; i++) {
			if (i == criteria.page) {
				pageHtml += "<li class='page-item active'>"
				pageHtml +=	"<a class='page-link' href='/list/book?page=" + i + "' data-page=" + i + ">" + i + "</a>"
	    		pageHtml += "</li>"
			} else {
				pageHtml += "<li class='page-item'>"
				pageHtml +=	"<a class='page-link' href='/list/book?page=" + i + "' data-page=" + i + ">" + i + "</a>"
	    		pageHtml += "</li>"
			}
		}
		
		if (pagination.existNext) {
			pageHtml += "<li class='page-item'>"
			pageHtml += "<a class='page-link' href='/list/book?page=" + pagination.nextPage + "' data-page='" + pagination.nextPage + "'>다음</a>"
    		pageHtml += "</li>"
		} else {
			pageHtml += "<li class='page-item disabled'>"
			pageHtml += "<a class='page-link' href='/list/book?page=" + pagination.nextPage + "' data-page='" + pagination.nextPage + "'>다음</a>"
    		pageHtml += "</li>"
		}
		
		$(".pagination").html(pageHtml);
		
		$(".pagination a").click(function(event) {
			event.preventDefault();
			// 클릭한 페이지내비게이션의 페이지번호 조회하기
			selectedPageNo = $(this).attr("data-page");
			
			console.log("선택한 페이지 번호" + selectedPageNo);
			
			page = selectedPageNo;
			
			console.log("변경된 페이지 번호" + page);
			
			getPage(page, rowsPerPage);
			
			var currentURL = "/list/book?page=" + page;
			
			history.pushState(null, null, currentURL);
			
		})
		// //페이징 영역
	}
	
	function getSearchResult() {
		$("#form-search-book input[name=value]").keyup(function(e){
			if(e.keyCode === 13) {
				console.log('검색기능작동');
				console.log($("#form-search-book input[name=value]").val());
				getPage(1);
			}
		})
	}
	
	/*
		해결해야할 문제
		1. 페이지네이션의 링크를 클릭시 데이터는 페이지에 맞는 내용으로 변경되지만, 상단의 페이지 경로가 변경되지 않음.
			=> 변경은 가능하나 새로고침시 현재 상태가 유지되지 않음. 새로고침시에 변경된 정보들을 가지고 갈 수 있어야함
		
		추가해볼만한기능
		1. 검색기능 - (완료)
		2. 데이터 갯수 보기를 변경하는 기능(5개, 10개, 15개) - (완료)
		
		완료된 사항
		1. 전체 데이터는 138개이지만 현재 9페이지 (135개) 이후 10페이지에서 남는 데이터 3개를 확인할 수 없음.
			=> 해결. for문 내부에 if문을 활용하여 데이터가 null일 시 해당 for문을 종료되도록 해서 해결함.
				=> 참조. 이는 서버 데이터를 전달 받을 때 rowsPerPage를 활용하여 제한을 걸고 javascript 단에서 foreach로 배열을 전달받는 방식도 있다.
		2.(new) 데이터를 불러오는 것만 jquery로 처리하고 다른 기능은 java 및 서버쪽에서 처리 가능하도록 구조 변경
			=> BookRestController에서 List<Book>의 정보를 호출하는 것이 아니라 Map(String, Object)의 구조로 값을 전달받음
			=> 해당 구조로 변경하여 BookRestController에서 Pagination 정보를 가져올 수 있도록 기능 변경
			=> script에서 변경된 정보를 전달하여 restController에서 전달받아 정보를 변경해야하는데 이부분을 해결하지 못하고 있음
				데이터를 전달받을때마다 rest/bookList 경로가 변경되어야함
				ex) rest/bookList?page=2&opt=&value= 등의 구조로
			=> Criteria에서 Pagination정보를 불러와서 rest에서 criteria 및 pagination 정보를 한꺼번에 불러오도록 구조 변경
				=> 위 방식으로 변경하니 정상적으로 전달되는 값이 restController 값에 대입되어 변경된 값을 확인 가능하며 검색도 가능해짐
		3.(new) 페이지네이션 작동시 마지막 블록에서 표현되지 않아야할 블록이 나타나는 현상이 있음
			=> 해결 totalBlocks 의 계산식 오류가 있어 해당식을 수정
	*/
</script>
</body>
</html>