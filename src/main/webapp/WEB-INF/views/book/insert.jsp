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
	<div class="row">
		<div class="col">
			<div class="mb-3">
				<h3>도서 등록</h3>
			</div>
			<form method="post" action="insert">
				<div class="mb-3">
					<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요." />				
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" name="author" placeholder="저자를 입력하세요." />				
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" name="publisher" placeholder="출판사를 입력하세요." />
				</div>
				<div class="mb-3">
					<input type="number" class="form-control" name="price" placeholder="가격을 입력하세요." />
				</div>
				<div class="mb-3">
					<input type="number" class="form-control" name="discountPrice" placeholder="할인 가격을 입력하세요." />
				</div>
				<div class="mb-3">
					<input type="date" class="form-control" name="pubDate" />
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" name="stock" placeholder="재고를 입력하세요." />
				</div>
				<div>
					<button type="submit" class="btn btn-primary mb-3">제출</button>
				</div>
			</form>			
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</body>
</html>