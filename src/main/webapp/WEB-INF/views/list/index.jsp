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
	<div id="tabl1"></div>
	<div id="tabl2"></div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
function books(tab) {
	var formData = new FormData(); //formData 객체 생성
	formData.append("tab", tab);
	$.ajax({
		url : "/list/listAjax",
		type : "get",
		dataType : "text",
		data : formData,
		contentType: false,
		processData: false,
		cache : false
	}).done(function(result)
		{ console.log("결과확인");
		var html = jQuery('<div>').html(result);
			var contents = html.find("div#indexListAjax").html();
			if(tab == "ing"){
				$("#tabl1").html(contents);
			}else if(tab == "end"){
				$("#tabl2").html(contents);
			}
	}).fail(function (jqXHR, textStatus, errorThrown){
		console.log("에러");
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	});
}

books();
</script>
</body>
</html>