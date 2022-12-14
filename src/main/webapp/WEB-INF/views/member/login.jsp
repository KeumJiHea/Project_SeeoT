<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link href="<c:url value='/resources/css/members.css'/>"rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('888f5917a6c2c4548d9e1432697cc0e0'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
	jQuery( document ).ready( function ( $ ) {

	 	 $('#username').on('keyup', enter);  
  		 $('#password').on('keyup', enter);
  		 
		function enter() {
	  		if (window.event.keyCode == 13) {
	 			loginChk();
			}
 		}
		
		$('#kakao-button').on('click', function() {
		    Kakao.Auth.login({
		      success: function (response) {
		        Kakao.API.request({
		          url: '/v2/user/me',
		          success: function (response) {
		        	  kakaoLoginPro(response);
		          },
		          fail: function (error) {
		            console.log(error);
		          },
		        })
		      },
		      fail: function (error) {
		        console.log(error);
		      },
		    })
		});

		function kakaoLoginPro(response){
			console.log(response);
			var data = {id:response.id,email:response.kakao_account.email}
			$.ajax({
				type : 'POST',
				url : 'kakaoLoginPro.do',
				data : data,
				dataType : 'json',
				success : function(data){
					if(data.JavaData == "login"){
						alert("로그인 되었습니다.");
						location.href = '/seeot/member/successLogin?id=' + data.id;
					}if(data.JavaData == "newlogin"){
						alert("가입 되었습니다.");
						location.href = '/seeot/member/successLogin?id=' + data.id;
					}
				},
				error: function(xhr, status, error){
					console.log("error" + data);
					alert("로그인에 실패했습니다."+error);
				}
			});
			
		}
    } );
		
  </script>
<header>

</header>
<div class="members-wrapper login">
    <div class="header">
    </div>
    <div class="kakao-login">
        <h2 class="title">로그인</h2>
        <p class="text">아이디와 비밀번호 입력하기 귀찮으시죠?<br>카카오로 1초 만에 로그인 하세요.</p>
        <a class="button kakao-button" id="kakao-button">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 208 191.94" style="width: 20px;margin-right: 5px;"><g><polygon class="cls-1" points="76.01 89.49 87.99 89.49 87.99 89.49 82 72.47 76.01 89.49"></polygon><path class="cls-1" d="M104,0C46.56,0,0,36.71,0,82c0,29.28,19.47,55,48.75,69.48-1.59,5.49-10.24,35.34-10.58,37.69,0,0-.21,1.76.93,2.43a3.14,3.14,0,0,0,2.48.15c3.28-.46,38-24.81,44-29A131.56,131.56,0,0,0,104,164c57.44,0,104-36.71,104-82S161.44,0,104,0ZM52.53,69.27c-.13,11.6.1,23.8-.09,35.22-.06,3.65-2.16,4.74-5,5.78a1.88,1.88,0,0,1-1,.07c-3.25-.64-5.84-1.8-5.92-5.84-.23-11.41.07-23.63-.09-35.23-2.75-.11-6.67.11-9.22,0-3.54-.23-6-2.48-5.85-5.83s1.94-5.76,5.91-5.82c9.38-.14,21-.14,30.38,0,4,.06,5.78,2.48,5.9,5.82s-2.3,5.6-5.83,5.83C59.2,69.38,55.29,69.16,52.53,69.27Zm50.4,40.45a9.24,9.24,0,0,1-3.82.83c-2.5,0-4.41-1-5-2.65l-3-7.78H72.85l-3,7.78c-.58,1.63-2.49,2.65-5,2.65a9.16,9.16,0,0,1-3.81-.83c-1.66-.76-3.25-2.86-1.43-8.52L74,63.42a9,9,0,0,1,8-5.92,9.07,9.07,0,0,1,8,5.93l14.34,37.76C106.17,106.86,104.58,109,102.93,109.72Zm30.32,0H114a5.64,5.64,0,0,1-5.75-5.5V63.5a6.13,6.13,0,0,1,12.25,0V98.75h12.75a5.51,5.51,0,1,1,0,11Zm47-4.52A6,6,0,0,1,169.49,108L155.42,89.37l-2.08,2.08v13.09a6,6,0,0,1-12,0v-41a6,6,0,0,1,12,0V76.4l16.74-16.74a4.64,4.64,0,0,1,3.33-1.34,6.08,6.08,0,0,1,5.9,5.58A4.7,4.7,0,0,1,178,67.55L164.3,81.22l14.77,19.57A6,6,0,0,1,180.22,105.23Z"></path></g></svg>
            카카오 1초 로그인/회원가입
        </a>
       	<form name="kakaoForm" id="kakaoForm" method = "post" action="/member/setSnsInfo.do">
			<input type="hidden" name="email" id="kakaoEmail" />
			<input type="hidden" name="id" id="kakaoId" />
			<input type="hidden" name="flag" id="flag" value="kakao" />
		</form>
    </div>
    <div class="user-login">
        <!-- <div class="event-wrap">
            <div class="event-column">
                <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik0yMi41MiAxMi45MzhjLTEuMDEgMi4xMDEtMi45MTEgMy42NzctNS40MjUgMy4zMDFsLS4wOTYgMS4yMjItMS4yMzktLjY0OS44OTQtLjc5MWMtLjI5My0uMjk3LTEuMTU2LS45NjItMS4zNy0yLjg3NSAxLjQzMS0xLjMxIDIuNTU1LTMuMzQ1IDIuNjg3LTUuOTEuOTYxLS40ODUgMi4wNTgtLjUwOSAzLjExLjA0MSAyLjI5NCAxLjIwMiAyLjM3NiAzLjcwOSAxLjQzOSA1LjY2MW0tMTAuMzIzLjg0bC42ODIuOTIzaC0xLjc4bC42NzktLjkxOGMtNC43My0xLjQwOC00Ljg0LTYuNjQ3LTQuODQtNy4xNTQgMC0yLjg2MyAxLjU1Ny01LjY5MSA1LjAzNC01LjY5MSAzLjQ3OCAwIDUuMDM0IDIuNzk2IDUuMDM0IDUuNjYgMCAuNDk1LS4xNzQgNS44NTUtNC44MDkgNy4xOG0tNC44NjggMi4yNDNsLjg5Mi43OTEtMS4yNC42NDktLjA5NS0xLjIyMmMtMi4yMi41MjUtNC40MzUtMS4yNC01LjQyNC0zLjMwMS0uOTM4LTEuOTUyLS44NTYtNC40NTkgMS40MzgtNS42NjEgMS4wMzctLjU0MyAyLjEyLS41MyAzLjA3Mi0uMDY2LjEyNSAyLjYyNCAxLjI2NyA0LjY4NSAyLjcyMSA1Ljk5MS0uMDUuNDA5LS4yNDUgMS45MjItMS4zNjQgMi44MTltMTQuMTY5LTkuNTQxYy0xLjE2OS0uNjExLTIuNDAxLS42NDEtMy41MTItLjIxMS0uMTk1LTMuNzEzLTIuNjEtNi4yNjktNi4wMTQtNi4yNjktMy4zODUgMC01Ljc5MSAyLjUyNS02LjAxMSA2LjIwMy0uNDUxLS4xNjctLjkyNC0uMjU2LTEuNDA5LS4yNTYtLjY5NyAwLTEuMzkyLjE3OS0yLjA2OC41MzMtMS42MTMuODQ1LTIuNDg0IDIuMzg2LTIuNDg0IDQuMTQ0IDAgLjg2OC4yMTIgMS43ODkuNjUyIDIuNzA0IDEuMzA2IDIuNzE4IDMuNjMxIDMuOTIgNS40MSAzLjkxbC4xMjkgMS42NTIgMS40MjgtLjc0N2MuODQ0IDEuNTUgMS4xMDQgMy4yMzMuODA3IDUuMjg1LS4wNDEuMjc4LjE2NS41NzMuNDk0LjU3My4yNDUgMCAuNDU3LS4xOC40OTQtLjQyOC4zMjQtMi4yNC4wMjMtNC4xNjgtLjkxMS01Ljg5M2wxLjI5MS0uNjc3LTEuMTgzLTEuMDQ3Yy40MjItLjU1My43MjgtMS4yODguOS0yLjExOC4yNjYuMTc4LjUzNi4zMzUuODA4LjQ2NmwtLjk1OCAxLjM5N2gyLjE4M2MtLjY5MSAyLjA2NS0uMzU4IDMuMjcyLS4wMDQgNC4xNTQuMzQyLjg1My42MzkgMS41ODktLjEzMiAzLjQ1NS0uMTM3LjMzMS4xMDguNjkxLjQ2MS42OTEuMTk2IDAgLjM4MS0uMTE3LjQ2MS0uMzA5LjkyNi0yLjI0My41MDctMy4yODguMTM2LTQuMjEtLjMzNi0uODM2LS41OTItMS44NTcuMTMtMy43ODFoMi4wMmwtLjk2OS0xLjQxOGMuMjczLS4xMzcuNTQ4LS4yOTguODE2LS40ODMuMTY5Ljg0Ni40NzggMS41OTQuOTA3IDIuMTU2bC0xLjE4NCAxLjA0NyAxLjI5Mi42NzdjLS45MzQgMS43MjQtMS4yMzUgMy42NTQtLjkxIDUuODkzLjAzNS4yNDguMjQ5LjQyOC40OTMuNDI4LjMzIDAgLjUzNS0uMjk1LjQ5NS0uNTczLS4yOTgtMi4wNTItLjAzOS0zLjczNi44MDYtNS4yODVsMS40MjguNzQ3LjEyOS0xLjY1MmMzLjEyOS0uMDE1IDYuMDYyLTMuMzk5IDYuMDYyLTYuNjE0IDAtMS43NTgtLjg3LTMuMjk5LTIuNDgzLTQuMTQ0bS0uNDE1LTMuMTY4bC40ODEuMjcyLjA5MS41NDUuNDA2LS4zNzMuNTQ4LjA4MS0uMjMxLS41MDMuMjQ3LS40OTQtLjU0OS4wNjMtLjM5My0uMzg3LS4xMDkuNTQxLS40OTEuMjU1em0uMDI2IDIuNDA1bC0uMjcxLTEuNjI1LTEuNDMyLS44MDkgMS40Ni0uNzU5LjMyNi0xLjYxNSAxLjE3MyAxLjE1NiAxLjYzNS0uMTg5LS43MzYgMS40NzQuNjg1IDEuNDk4LTEuNjI4LS4yNDUtMS4yMTIgMS4xMTR6bS0xOC44MTggMTQuNDlsLjUxNi4zNjkuMDI3LS42MzQuNTEtLjM3Ny0uNTk1LS4yMjMtLjItLjYwMS0uMzk0LjQ5Ny0uNjM0LjAwNS4zNTEuNTI5LS4xOTEuNjA0LjYxLS4xNjl6bTEuMjUxIDEuODc3bC0xLjQwNC0xLjAwNS0xLjY2My40NjQuNTItMS42NDgtLjk1NS0xLjQzOSAxLjcyNy0uMDE1IDEuMDczLTEuMzU0LjU0NiAxLjY0IDEuNjE4LjYwNC0xLjM4OCAxLjAyNy0uMDc0IDEuNzI2em0uNjMyLTIxLjE3OGMtLjUyIDAtLjk0Mi40MjMtLjk0Mi45NDQgMCAuNTIuNDIyLjk0Mi45NDIuOTQycy45NDItLjQyMi45NDItLjk0MmMwLS41MjEtLjQyMi0uOTQ0LS45NDItLjk0NG0wIDIuNzg3Yy0xLjAxNSAwLTEuODQxLS44MjctMS44NDEtMS44NDNzLjgyNi0xLjg0NCAxLjg0MS0xLjg0NGMxLjAxNSAwIDEuODQxLjgyOCAxLjg0MSAxLjg0NHMtLjgyNiAxLjg0My0xLjg0MSAxLjg0M20tMi42OTUuNDk4Yy0uMzAzIDAtLjU0OS4yNDctLjU0OS41NSAwIC4zMDMuMjQ2LjU1LjU0OS41NS4zMDMgMCAuNTQ5LS4yNDcuNTQ5LS41NSAwLS4zMDMtLjI0Ni0uNTUtLjU0OS0uNTVtMCAyYy0uNzk4IDAtMS40NDgtLjY1MS0xLjQ0OC0xLjQ1IDAtLjc5OS42NS0xLjQ0OSAxLjQ0OC0xLjQ0OS43OTggMCAxLjQ0OS42NSAxLjQ0OSAxLjQ0OXMtLjY1MSAxLjQ1LTEuNDQ5IDEuNDVtMTcuMDgtNS4zOTFjLS4yNjIgMC0uNDc0LjIxNC0uNDc0LjQ3NSAwIC4yNjIuMjEyLjQ3NS40NzQuNDc1cy40NzQtLjIxMy40NzQtLjQ3NWMwLS4yNjEtLjIxMi0uNDc1LS40NzQtLjQ3NW0wIDEuNzQ5Yy0uNzAyIDAtMS4yNzMtLjU3MS0xLjI3My0xLjI3NCAwLS43MDMuNTcxLTEuMjc1IDEuMjczLTEuMjc1czEuMjczLjU3MiAxLjI3MyAxLjI3NS0uNTcxIDEuMjc0LTEuMjczIDEuMjc0bTIuNDM1IDE2LjAyM2MtLjU3OCAwLTEuMDQ5LjQ3LTEuMDQ5IDEuMDUgMCAuNTc5LjQ3MSAxLjA0OSAxLjA0OSAxLjA0OXMxLjA0Ny0uNDcgMS4wNDctMS4wNDljMC0uNTgtLjQ2OS0xLjA1LTEuMDQ3LTEuMDVtMCAyLjk5OWMtMS4wNzUgMC0xLjk0OS0uODc0LTEuOTQ5LTEuOTQ5IDAtMS4wNzYuODc0LTEuOTUgMS45NDktMS45NSAxLjA3MyAwIDEuOTQ3Ljg3NCAxLjk0NyAxLjk1IDAgMS4wNzUtLjg3NCAxLjk0OS0xLjk0NyAxLjk0OSIvPjwvc3ZnPg==">
                매달 진행하는<br>다양한 이벤트
            </div>
            <div class="event-column">
                <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik0wIDIzdi0xMC42NjhjMC0uOTkuMDgyLTEuOTUyIDEuMzI0LTIuMjIzIDEuNDMzLS4zMTIgMi43NjgtLjU4NiAyLjEyMS0xLjczNi0xLjk2Ni0zLjUwMS0uNTIxLTUuMzczIDEuNTU1LTUuMzczIDIuMTE3IDAgMy41MjcgMS45NDQgMS41NTYgNS4zNzMtLjMxMS41NDEtLjE3NS44ODguMjAxIDEuMTM2LjIyNS0uMjA4LjUyOC0uMzY3LjkzNC0uNDYxIDEuNjg0LS4zODkgMy4zNDQtLjczNiAyLjU0NS0yLjIwOS0yLjM2Ni00LjM2NC0uNjc0LTYuODM5IDEuODY2LTYuODM5IDIuNDkxIDAgNC4yMjYgMi4zODMgMS44NjYgNi44MzktLjc3NSAxLjQ2NC44MjYgMS44MTIgMi41NDUgMi4yMDkuMzUyLjA4MS42MjcuMjEyLjg0LjM4LjI5LS4yNDIuMzY5LS41NzEuMDkxLTEuMDU1LTEuOTcxLTMuNDI5LS41NjEtNS4zNzMgMS41NTYtNS4zNzMgMi4wNzYgMCAzLjUyMSAxLjg3MiAxLjU1NSA1LjM3My0uNjQ3IDEuMTUuNjg4IDEuNDI0IDIuMTIxIDEuNzM2IDEuMjQyLjI3MSAxLjMyNCAxLjIzMyAxLjMyNCAyLjIyM3YxMC42NjhjMCAuNTUyLS40NDggMS0xIDFoLTIyYy0uNTUyIDAtMS0uNDQ4LTEtMXptMjMtOGgtMjJ2OGgyMnYtOHptLTE4LjE5MyAxbC0uOTc2IDIuMDE0LTIuMjE3LjMwNSAxLjYxNSAxLjU1Mi0uMzk1IDIuMjA0IDEuOTczLTEuMDU3IDEuOTczIDEuMDU2LS4zOTMtMi4yMDMgMS42MTMtMS41NTItMi4yMTctLjMwNS0uOTc2LTIuMDE0em03LjE5MyAwbC0uOTc2IDIuMDE0LTIuMjE3LjMwNSAxLjYxNSAxLjU1Mi0uMzk1IDIuMjA0IDEuOTczLTEuMDU3IDEuOTczIDEuMDU2LS4zOTMtMi4yMDMgMS42MTMtMS41NTItMi4yMTctLjMwNS0uOTc2LTIuMDE0em03LjE5MyAwbC0uOTc2IDIuMDE0LTIuMjE3LjMwNSAxLjYxNSAxLjU1Mi0uMzk1IDIuMjA0IDEuOTczLTEuMDU3IDEuOTczIDEuMDU2LS4zOTMtMi4yMDMgMS42MTMtMS41NTItMi4yMTctLjMwNS0uOTc2LTIuMDE0em0tMTQuODg2IDMuNTJsLS41MTItLjQ5MS43MDItLjA5Ny4zMS0uNjM5LjMxLjYzOS43MDMuMDk3LS41MTEuNDkxLjEyNS42OTktLjYyNy0uMzM1LS42MjUuMzM0LjEyNS0uNjk4em03LjE5MyAwbC0uNTEyLS40OTEuNzAyLS4wOTcuMzEtLjYzOS4zMS42MzkuNzAzLjA5Ny0uNTExLjQ5MS4xMjUuNjk5LS42MjctLjMzNS0uNjI1LjMzNC4xMjUtLjY5OHptNy4xOTMgMGwtLjUxMi0uNDkxLjcwMi0uMDk3LjMxLS42MzkuMzEuNjM5LjcwMy4wOTctLjUxMS40OTEuMTI1LjY5OS0uNjI3LS4zMzUtLjYyNS4zMzQuMTI1LS42OTh6bS0xMi41ODktNS41MmwtLjAwMS0yLjEyNmMwLS41MjYuMDE4LTEuMDQ2LjE0Ny0xLjQ5OC0uMzE5LS4xOTktLjU3My0uNDU4LS43MjktLjgxMS0uMTYtLjM2LS4yNjEtLjk0NS4xNjgtMS42OS43OTItMS4zNzkgMS4wMTktMi41NjQuNjIyLTMuMjUxLS40ODctLjg0LTIuMTMtLjgzMS0yLjYwOC0uMDE0LS4zOTcuNjc5LS4xNzQgMS44NzEuNjE0IDMuMjczLjQxOS43NDcuMzE2IDEuMzMuMTU2IDEuNjg4LS4yMjkuNTA5LS41MzUuOTg3LTIuOTM2IDEuNTE2LS4zNjkuMDgtLjUzNy4xMTYtLjUzNyAxLjI0NWwuMDAxIDEuNjY4aDUuMTAzem0xMC45OTggMHYtMi4xMjJjMC0xLjQzOC0uMTkzLTEuNzEzLS44MTMtMS44NTYtMi43NDYtLjYzMy0zLjA5OC0xLjE3Mi0zLjM1OS0xLjc0NC0uMTgxLS4zOTUtLjMwMS0xLjA0OC4xNTQtMS45MDcgMS4wMjItMS45MjkgMS4yNzgtMy41ODIuNzAzLTQuNTM4LS42NzItMS4xMTUtMi43MDQtMS4xMjUtMy4zODQuMDE3LS41NzcuOTY5LS4zMTggMi42MTMuNzEyIDQuNTEyLjQ2NS44NTcuMzQ4IDEuNTEuMTY5IDEuOTA5LS40OTEgMS4wODgtMS44MzggMS4zOTktMy4yNjUgMS43MjctLjgyOS4xOTYtLjkxNi41ODctLjkxNiAxLjg3NmwuMDAxIDIuMTI2aDkuOTk4em01Ljg5NyAwbC4wMDEtMS42NjhjMC0xLjEyOS0uMTY4LTEuMTY1LS41MzctMS4yNDUtMi40MDEtLjUyOS0yLjcwNy0xLjAwNy0yLjkzNi0xLjUxNi0uMTYtLjM1OC0uMjYzLS45NDEuMTU2LTEuNjg4Ljc4OC0xLjQwMiAxLjAxMS0yLjU5NC42MTQtMy4yNzMtLjQ3OC0uODE3LTIuMTIxLS44MjYtMi42MDguMDE0LS4zOTcuNjg3LS4xNyAxLjg3Mi42MjIgMy4yNTEuNDI5Ljc0NS4zMjggMS4zMy4xNjggMS42OS0uMTI3LjI4OC0uMzIuNTEzLS41NTkuNjk1LjE2Mi40NzguMTgyIDEuMDQ0LjE4MiAxLjYxOHYyLjEyMmg0Ljg5N3oiLz48L3N2Zz4=">
                멤버쉽 등급 별<br>할인 제공
            </div>
            <div class="event-column">
                <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiPjxwYXRoIGQ9Ik03IDI0aC01di05aDV2MS43MzVjLjYzOC0uMTk4IDEuMzIyLS40OTUgMS43NjUtLjY4OS42NDItLjI4IDEuMjU5LS40MTcgMS44ODctLjQxNyAxLjIxNCAwIDIuMjA1LjQ5OSA0LjMwMyAxLjIwNS42NC4yMTQgMS4wNzYuNzE2IDEuMTc1IDEuMzA2IDEuMTI0LS44NjMgMi45Mi0yLjI1NyAyLjkzNy0yLjI3LjM1Ny0uMjg0Ljc3My0uNDM0IDEuMi0uNDM0Ljk1MiAwIDEuNzUxLjc2MyAxLjc1MSAxLjcwOCAwIC40OS0uMjE5Ljk3Ny0uNjI3IDEuMzU2LTEuMzc4IDEuMjgtMi40NDUgMi4yMzMtMy4zODcgMy4wNzQtLjU2LjUwMS0xLjA2Ni45NTItMS41NDggMS4zOTMtLjc0OS42ODctMS41MTggMS4wMDYtMi40MjEgMS4wMDYtLjQwNSAwLS44MzItLjA2NS0xLjMwOC0uMi0yLjc3My0uNzgzLTQuNDg0LTEuMDM2LTUuNzI3LTEuMTA1djEuMzMyem0tMS04aC0zdjdoM3YtN3ptMSA1LjY2NGMyLjA5Mi4xMTggNC40MDUuNjk2IDUuOTk5IDEuMTQ3LjgxNy4yMzEgMS43NjEuMzU0IDIuNzgyLS41ODEgMS4yNzktMS4xNzIgMi43MjItMi40MTMgNC45MjktNC40NjMuODI0LS43NjUtLjE3OC0xLjc4My0xLjAyMi0xLjExMyAwIDAtMi45NjEgMi4yOTktMy42ODkgMi44NDMtLjM3OS4yODUtLjY5NS41MTktMS4xNDguNTE5LS4xMDcgMC0uMjIzLS4wMTMtLjM0OS0uMDQyLS42NTUtLjE1MS0xLjg4My0uNDI1LTIuNzU1LS43MDEtLjU3NS0uMTgzLS4zNzEtLjk5My4yNjgtLjg1OC40NDcuMDkzIDEuNTk0LjM1IDIuMjAxLjUyIDEuMDE3LjI4MSAxLjI3Ni0uODY3LjQyMi0xLjE1Mi0uNTYyLS4xOS0uNTM3LS4xOTgtMS44ODktLjY2NS0xLjMwMS0uNDUxLTIuMjE0LS43NTMtMy41ODUtLjE1Ni0uNjM5LjI3OC0xLjQzMi42MTYtMi4xNjQuODE0djMuODg4em0zLjc5LTE5LjkxM2wzLjIxLTEuNzUxIDcgMy44NnY3LjY3N2wtNyAzLjczNS03LTMuNzM1di03LjcxOWwzLjc4NC0yLjA2NC4wMDItLjAwNS4wMDQuMDAyem0yLjcxIDYuMDE1bC01LjUtMi44NjR2Ni4wMzVsNS41IDIuOTM1di02LjEwNnptMSAuMDAxdjYuMTA1bDUuNS0yLjkzNXYtNmwtNS41IDIuODN6bTEuNzctMi4wMzVsLTUuNDctMi44NDgtMi4yMDIgMS4yMDIgNS40MDQgMi44MTMgMi4yNjgtMS4xNjd6bS00LjQxMi0zLjQyNWw1LjUwMSAyLjg2NCAyLjA0Mi0xLjA1MS01LjQwNC0yLjk3OS0yLjEzOSAxLjE2NnoiLz48L3N2Zz4=">
                주말마다<br>무료배송
            </div>
            <div class="event-column">
                <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0Ij48cGF0aCBkPSJNMjAgOS4zNTJjMC00Ljg1Mi00Ljc1LTguMzUyLTEwLTguMzUyLTUuMjgxIDAtMTAgMy41MjctMTAgOC4zNTIgMCAxLjcxLjYxNSAzLjM5IDEuNzA1IDQuNjk1LjA0NyAxLjUyNy0uODUgMy43MTktMS42NiA1LjMxMiAyLjE2OC0uMzkxIDUuMjUyLTEuMjU4IDYuNjQ4LTIuMTE1IDcuNjk4IDEuODc3IDEzLjMwNy0yLjg0MiAxMy4zMDctNy44OTJ6bS0xMy45MiAyLjIxYy0uMzQ3LjI3NS0uODMuNDEzLTEuNDUuNDEzLS41MyAwLTEuMDAxLS4xMDItMS40MDgtLjMwNmwuMjI4LS45MDJjLjQxMi4yMDguODI4LjMxMiAxLjI1MS4zMTIuMjQ0IDAgLjQzNS0uMDQ2LjU3MS0uMTM5LjI2Mi0uMTc5LjI3OC0uNTM5LjAyLS43NDMtLjEyNS0uMDk3LS4zMzctLjE5Ny0uNjQxLS4yOTgtLjkxNS0uMzA1LTEuMzcxLS43ODEtMS4zNzEtMS40MyAwLS40Mi4xNjctLjc2NS41MDMtMS4wMzYuMzM3LS4yNzEuNzg2LS40MDcgMS4zNDQtLjQwNy40ODggMCAuOTEzLjA4MyAxLjI3OS4yNDlsLS4yNDguODczYy0uMzM0LS4xNTYtLjY4NC0uMjMzLTEuMDQ1LS4yMzMtLjIyMSAwLS4zOTYuMDQzLS41MjIuMTI4LS4yNS4xNjktLjI0NS40NzUtLjAzLjY1NS4xMDYuMDg5LjM1Ni4yMDUuNzU5LjM0Ny40NDIuMTU2Ljc2Ny4zNS45NzMuNTgxLjIwNS4yMzEuMzA4LjUxOC4zMDguODYxIDAgLjQ0MS0uMTc1Ljc5OS0uNTIxIDEuMDc1em01LjUzMS4zMzRjLS4wNzYtMS45MDEtLjExMy0zLjE5MS0uMTEzLTMuODY4aC0uMDIzYy0uMTE0LjUwOS0uNTAzIDEuNzczLTEuMTY1IDMuNzg5aC0uODU5Yy0uMzk3LTEuMzkxLS45ODEtMy43ODktLjk4MS0zLjc4OWgtLjAxNWwtLjE2OSAzLjg2OGgtMS4wMjVsLjMwNS00Ljc5MmgxLjQ5MmwuODQ1IDMuMzA2IDEuMDI0LTMuMzA2aDEuNTA5bC4yNTcgNC43OTJoLTEuMDgyem00LjYzNy0uMzE0Yy0uMzQ4LjI3Ny0uODQyLjQxOC0xLjQ2NS40MTgtLjUwNiAwLS45ODMtLjA4OS0xLjQzOS0uMzE3bC4yNDEtLjk1NmMuNC4yMDUuODExLjMyNSAxLjI2OS4zMjUuMjM3IDAgLjQyNS0uMDQ0LjU1NS0uMTM1LjI1Mi0uMTY5LjI2Mi0uNTA4LjAyLS43LS4xMjItLjA5NS0uMzM0LS4xOTMtLjYzMi0uMjk0LS45MjMtLjMwNi0xLjM5Mi0uNzk0LTEuMzkyLTEuNDU0IDAtLjQyNS4xNzQtLjc4MS41MTYtMS4wNTYuMzM4LS4yNzUuNzk2LS40MTMgMS4zNTgtLjQxMy40OSAwIC45MjQuMDg0IDEuMjkxLjI1bC4wMi4wMS0uMjY0LjkyNmMtLjMzNy0uMTU5LS42NzQtLjI0Ni0xLjA2MS0uMjQ2LS4yMTUgMC0uMzg3LjA0Mi0uNTA5LjEyNC0uMjM0LjE2MS0uMjI5LjQ0NC0uMDI2LjYxNS4xMDMuMDg1LjM1NC4yMDEuNzUuMzQyLjQ0NS4xNTYuNzc1LjM1NS45ODIuNTg4LjIwOS4yMzYuMzE2LjUzLjMxNi44NzkuMDAxLjQ0Ny0uMTc4LjgxNS0uNTMgMS4wOTR6bTYuNjM2IDcuOTM5Yy0uMDI5IDEuMDAxLjU1OCAyLjQzNSAxLjA4OCAzLjQ3OS0xLjQxOS0uMjU4LTMuNDM4LS44MjQtNC4zNTItMS4zODUtMy4yNzkuNzk4LTYuMDY0LS4yMjMtNy41NzctMi4xLjU5Ni0uMDg2IDEuMTc4LS4yMDUgMS43NC0uMzY0IDEuODI0IDEuNTUyIDMuOTYyIDEuMzc0IDYuMDg5Ljg1NS42ODcuNDIyLjc3My41MDcgMS42NjUuODEzLS4xODctLjgxNi0uMTU4LTEuMTItLjEzOC0xLjg2NSAxLjc5My0yLjE0IDEuMjEzLTQuMTA0LS40NjQtNS4zNjUuMjM5LS40NTUuNDM5LS45MjguNjAxLTEuNDE2IDIuODkxIDEuOTEzIDMuMTAzIDUuMjUxIDEuMzQ4IDcuMzQ4eiIvPjwvc3ZnPg==">
                SNS 공유 시<br>리워드 지급
            </div>
        </div> -->
        <div class="form-wrapper">
            <form name="fo" action="<%=request.getContextPath()%>/member/login_check" method="post">
                <div>
                    <div class="input-box">
                        <input id="username" type="text" name="id" placeholder="아이디"">
                        <input id="password" type="password" name="pw" placeholder="비밀번호">
                    </div>
                    <div class="login-checkbox">
                        <input type="checkbox" name="autoLogin"><label for="save_id">로그인 상태 유지</label>
                        <div class="util-menu">
                            <a href="id_find_form">아이디</a> | <a href="pw_find_form">비밀번호 찾기</a>
                        </div>
                    </div>
                    <button type="button" class="button login-button" onclick="loginChk()">로그인</button>
                    <a href="register_form" class="button register-button">회원가입</a>
                </div>
            </form>
        </div>
    </div>
</div>
	<script type="text/javascript">
		function loginChk() {
			var form = document.fo;
			if (!form.id.value) {
				alert("아이디를 입력해주세요.");
				form.id.focus();
				return;
			}

			if (!form.pw.value) {
				alert("비밀번호를 입력해주세요.");
				form.pw.focus();
				return;
			}
			form.action = "<%=request.getContextPath()%>/member/login_check";
		    form.submit();
		}
		</script>
		
<footer>

</footer>
</body>
</html>













