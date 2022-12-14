<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
 <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/common.css">
<style type="text/css">
	#modal_wrap{position: fixed; z-index: 9;margin: auto; display:none;
	 top:0; left: 0; right: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.4)
	}
	#first{position: fixed; z-index: 10;margin: auto; display:none;
	 top:30px; left: 0; right: 0; width: 350px; height: 450px; background-color: white;
	}
	th, td{padding: 50px;}
	#tbody th:not(.start){
		display: none;
	}
</style>
<body>
<div id="modal_wrap">
	<div id="first">
	<br><br><br>
		<div style="width: 250px; margin: auto; padding-top: 20px;">
			<form>
				<input type="hidden" name="orderNo" id="orderNo">
				<b>취소 사유</b><br>
				<textarea rows="5" cols="30" name="reason" id="reason"></textarea>
				<hr>
				<button type="button" class="fcancel">주문취소</button>
				<button type="button" onclick="slide_hide()">접기</button>
			</form>
		</div>
	</div>
</div>


<div align="center">

	<table border="1" id="ordertable">
		<tr>
			<th>주문번호</th><th>이미지</th><th>상품명/옵션</th><th>상품금액</th><th>수량</th><th>주문상태</th>
		</tr>
		<c:if test="${sessionScope.orderdata ==null }">
			<tr>
				<th colspan="5">주문한 상품이 없습니다</th>
			</tr>
		</c:if>
		<c:if test="${sessionScope.orderdata != null }">
		<tbody id="tbody">	
			<c:forEach begin="0" end="${result-1 }" var="i" varStatus="status">			
				<tr>
					<th id="no${status.index }">${order.merchant_uid }</th><td><img width="50px" height="50px" src="${order.gfile[i] }"></td><td>${order.glist[i]}<br>옵션 : ${order.gcolor[i] } / ${order.gsize[i] }</td><td><span id="cost${status.index }">${order.gcost[i] }</span></td><td>${order.gstack[i] }</td><th id="status${status.index }"><span id="status">주문 완료</span><br><button type="button" name="cancelBtn" class='cancel' onclick="slideClick()">주문취소</button></th>
				</tr>
			</c:forEach>
		</tbody>	
		</c:if>
	</table>
	<input type="hidden" id="total">
</div>

</body>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/order/orderResult.js"></script>