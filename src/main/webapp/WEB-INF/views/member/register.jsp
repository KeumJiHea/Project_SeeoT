<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/daum_post.js"></script>

<div align="center">
<form action="register" method="post">
<div>
<input type="text" name="id" placeholder="아이디 입력">
</div>
<div>
<input type="text" name="pw" placeholder="비밀번호 입력">
</div>
<div>
<input type="text" name="name" placeholder="이름 입력">
</div>
<div>
<input type="text" name="phone" placeholder="휴대폰 번호를 '-' 없이 입력">
</div>
<div>
<input type="text" name="email" placeholder="이메일 주소 입력">
</div>
<div>
<input type="text" readonly id="addr1" name="addr" placeholder="우편번호">
<button type="button" onclick="daumPost()">우편번호찾기</button><br>
<input type="text" readonly id="addr2" name="addr" placeholder="주소"><br>
<input type="text" name="addr" id="addr3" placeholder="상세주소">
</div>
<div>
<input type="submit" value="가입">
</div>
</form>
</div>
	
	
	
	
	
	
</body>
</html>






