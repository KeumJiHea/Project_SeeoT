<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
myReview<br>
<c:if test="${ myReview.size() == 0}">
작성한 리뷰가 없습니다.<br>
</c:if >
<c:if  test="${ myReview.size() != 0}">
<c:forEach var="rdto" items="${myReview}">
<b>작성일 : </b>  ${rdto.reviewDate } &nbsp;
<b>별점 : </b>${rdto.reviewStar } <br>
<b>내용 : </b> ${rdto.reviewContent }<br>
		<c:if test="${rdto.reviewFile ne 'nan'}">
					<div align='right'>
					<img src="download?file=${rdto.reviewFile }" width="50" height="50" />
					</div>
				</c:if>
<div>

	<a href="delete?reviewNo=${rdto.reviewNo }&productNo=${rdto.productNo }&reviewStar=${rdto.reviewStar }">삭제</a> &nbsp 
	<a href="my_modifyform?reviewNo=${rdto.reviewNo }&productNo=${rdto.productNo }">수정</a>
</div>

<a href="../product/productView?productNo=${rdto.productNo}">제품 보러가기</a>
<hr>

</c:forEach>
</c:if>
<input type="button" onclick="history.back()" value="이전으로 돌아가기">

</body>
</html>