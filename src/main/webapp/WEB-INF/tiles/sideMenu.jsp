<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="side-menu">
	<div class="recentBtn">
		<i class="fa-solid fa-clock-rotate-left"></i>
		<br>
		<span><b>최근 본 상품</b></span>
		<div class="recentList">
			<ul></ul>
		</div>
	</div>
	<div class="cartBtn" onclick="location.href='<%=request.getContextPath() %>/cart/mycart'">
		<i class="fa-solid fa-cart-shopping"></i>
		<br>
		<span><b>장바구니</b></span>
	</div>
	<div class="topBtn">
		<i class="fa-solid fa-arrow-up"></i>
		<br>
		<span><b>TOP</b></span>
	</div>
</div>
<script src="<%=request.getContextPath() %>/resources/js/common/sideMenu.js"></script>