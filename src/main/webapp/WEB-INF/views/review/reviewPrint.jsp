<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="rePrint()">
<h4>리뷰</h4> 

<hr>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

function rePrint(){
	$.ajax({
		url:"replyData1", type:"get",
		
		dataType :"json",
		success : function( reviewData ){
			
			console.log("data: "+ JSON.stringify(reviewData) )
			

			let html = ""
		for( i=0; i<reviewData.length; i++){
				let date = new Date( reviewData[i].reviewDate )
				let wd = date.getFullYear()+"년";
				wd += (date.getMonth()+1) + "월";
				wd += date.getDate()+"일";
				
				
				html += "<div align='left'><b>아이디 : </b>"+reviewData[i].memberId+"님  &nbsp ";
				html += "<b>작성일 : </b>"+ wd+" &nbsp";
				html += "<b>별점 : </b>"+reviewData[i].reviewStar+"<br>";
				html += "<b>내용 : </b>"+reviewData[i].reviewContent;
				
				
				if(reviewData[i].reviewFile != 'nan'){
					html += "<div align='right'><img src='../review/download?file="+ reviewData[i].reviewFile+"' width='50' height='50'alt='이미지가 없습니다.' /></div>";
				}
				
				if('${sessionScope.loginUser}' ==  reviewData[i].memberId){
					html+= "<div>"+"<a href=delete?reviewno="+reviewData[i].reviewNo+">삭제</a>"+"</div>"
					html+= "<div>"+"<a href=modify?>수정</a>"+"</div>"
				}
			
				
				html+= "<hr></div>";
				
		}
			$("#reply").html( html )
			},
		error: function(){alert("function error")}
			
	})
	
	
}

</script>

<!-- 관리자페이지용  -->
<div id="reply"> </div> 

<input type="button" onclick="history.back()" value="이전으로 돌아가기">


</body>
</html>