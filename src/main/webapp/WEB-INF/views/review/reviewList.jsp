<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#reviewForm fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#reviewForm fieldset legend{
    text-align: right;
}
#reviewForm input[type=radio]{
    display: none;
}
#reviewForm label{
    font-size: 3em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#reviewForm label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewForm label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewForm input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#reviewContent {
    width: 100%;
    height: 150px;
    padding: 10px;
    box-sizing: border-box;
    border: solid 1.5px #D3D3D3;
    border-radius: 5px;
    font-size: 16px;
    resize: none;
}
</style>
 <link href="/assets/css/star.css" rel="stylesheet"/>
 
 
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
function review(){
	var queryString = $('reviewForm').serialize();
	var memberId = "seeotuser"
	var productNo = 10001
//	var reviewFile=$("textarea[name='reviewFile']")
	var reviewFile = "nan" //이미지 저장 기능 만드고 주석으로바꾸기
//	var memberId = $("input[name='memberId']").val()  //회원아이디 입력받게 만들기
	var reviewContent = $("textarea[name='reviewContent']").val()
	var reviewStar =$('[name=reviewStar]:checked').val() 
	
	
	//	var formData = new FormData();
	// formData.append('file', $('#uploadFile')[0].files[0]);

	//var reviewFile =$("file[name='reviewFile']").val     reviewFile:reviewFile
	
	var form = {memberId:memberId, reviewContent:reviewContent 
			,productNo:productNo, reviewFile:reviewFile, reviewStar:reviewStar }

	console.log(form)
	
	$.ajax({
	url:"addReview" , type:"post",
	contentType:"application/json; charset=utf-8",
	data:JSON.stringify(form),
	dataType:"json",
	success:function(data){
		alert('리뷰등록');
		replyData();
	},error:function(data){alert('문제발생'), console.log(form)}
})

}

function readURL(input) {
	   var file = input.files[0] //파일에 대한 정보
	   console.log(file)
   if (file != '') {
	      var reader = new FileReader();
	      reader.readAsDataURL(file); //파일의 정보를 토대로 파일을 읽고 
	      reader.onload = function (e) { // 파일 로드한 값을 표현한다
	    	//e : 이벤트 안에 result값이 파일의 정보를 가지고 있다.
	        $('#reviewFile').attr('file', e.target.result);
       }
   }
}  
function replyData(){
	console.log('reply')
	$.ajax({
		//url: "replyData?productNo="+${dto.productNo} //productNo으로 리뷰그룹 나누기
		url: "replyData/"+${dto.productNo}, type: "get",
		dataType:"json",
		success:function(rep){
			console.log(rep)
			let html = ""
			for(i=0; i<rep.length; i++){
				let date = new Date(rep[i].reviewDate)
				let wd = date.getFullYear()+"년";
				wd += (date.getMonth()+1) + "월";  //0월부터 시작
				wd += date.getDate()+"일"
				
				html += "<div align='left'><b>아이디 : </b>"+rep[i].reviewId+"님 / "
				html += "<b>작성일 : </b>"+ wd +"<br>"
				html += "<b>별점 : </b>"+rep[i].reviewStar+"<br>"
				html += "<b>내용 : </b>"+rep[i].reviewContent+"<hr></div>"
			}
			$("#review").html( html )
		}
	})
}

//댓글불러오기 때  data.length 넣어서 리뷰수 적어주기
 </script>


<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!--  
<c:forEach var="dto" items="${reviewList }">
작성자: ${dto.memberId }	
내용: ${dto.reviewContent }	
별점: ${dto.reviewStar }	
상품: ${dto.productNo }	
등록일: ${dto.reviewDate }	<br>
</c:forEach>
-->


<div>
            <div>
                <span><strong>REVIEW</strong></span> <span id="cCnt"></span><hr>
            </div><!-- cCnt 댓글 개수, 리뷰 평균점수 표현 -->
            </div>

 	<form class="mb-3" name="reviewForm" id="reviewForm" >
 	<!--  action="${contextPath}/review/reviwSave" method="post" enctype="multipart/form-data"-->
 
	<fieldset> 
	<!--<input type="text" name="memberId" value="${dto.memberId }"> -->
		<span class="text-bold">별점을 선택해주세요</span>
		<input type="radio" name="reviewStar" value=5 id="rate1"><label
			for="rate1">★</label>
		<input type="radio" name="reviewStar" value=4 id="rate2"><label
			for="rate2">★</label>
		<input type="radio" name="reviewStar" value=3 id="rate3"><label
			for="rate3">★</label>
		<input type="radio" name="reviewStar" value=2 id="rate4"><label
			for="rate4">★</label>
		<input type="radio" name="reviewStar" value=1 id="rate5"><label
			for="rate5">★</label>
	</fieldset>
	<div>
	
	<!-- 
	<input type="hidden" id="reviewDate" value="${dto.reviewDate }">
	<input type="hidden" id="productNo" value="${dto.productNo }"> -->
		<textarea class="reviewContent" type="text" id="reviewContent" name="reviewContent"
				  placeholder="리뷰작성"></textarea>
				  <!-- --> 
	<c:if test="${ dto.reviewFile == '' }"> <b>이미지가 없습니다</b> </c:if>
	<c:if test="${ dto.reviewFile != 'nan' }">			
	<input type="file" name="reviewFile" id="reviewFile" onchange="readURL(this);" /> 
	</c:if>
	
	<form>
	
	</form>
	<input type="button" onclick="review()" value="후기등록">
	<input type="button" onclick="replyData()" value="replydata">
	
	<div id=review></div>
	</div>
</form>	
</body>
</html>