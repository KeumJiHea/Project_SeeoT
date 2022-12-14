<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/productView.css'/>" >
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body onload="rePrint()">
	<script type="text/javascript">
	var pc='', ps='';
	var cnt = 0;
	var selColCount = 0, selSizCount = 0;	
	
	function colorAdd(productColor) {
		
		if(pc == null || pc == '') {
			pc = productColor;
			const PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'white';
			PCelement.style.color = 'black';
		}else {
			PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'black';
			PCelement.style.color = 'white';
			pc = productColor;
			PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'white';
			PCelement.style.color = 'black';
		}
		
		if(ps != '') {
			PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'black';
			PSelement.style.color = 'white';
			ps = '';
		}
	}
	
	
	
	function sizeAdd(proSize) {
		if(ps == null || ps == ''){
			ps = proSize;
			const PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'white';
			PSelement.style.color = 'black';
		}else {
			PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'black';
			PSelement.style.color = 'white';
			ps = proSize;
			PSelement = document.getElementById(ps);
			PSelement.style.backgroundColor = 'white';
			PSelement.style.color = 'black';
		}
		
		if(pc != '' & ps != '') {
			productSelect();
		}
	}
	
 	function productSelect() {
		
			$.ajax({
				url: "proStackGet",
				type:"get",
				data:{
					productNo : '${pdto.productNo}',
					productColor : pc,
					productSize : ps
				},
				datatype:"json",
				success: function(data) {
					
					
					if(data != '' ) {
						
						if(document.getElementById(data.productColor + data.productSize) == null) {
							cnt++;
							$("#proOrderAdd").append("<div id='" + data.productColor + data.productSize + "' class='" +  data.productColor + data.productSize + "'>"+ data.productColor + " / " + data.productSize
									+ "<input type='hidden' name='productColor' value='" + data.productColor + "' id='productColor'> &nbsp;"
									+ "<input type='hidden' name='productSize' value='" + data.productSize + "' id='productSize'>"
								 	+ "<img src='<c:url value='/resources/images/proup.png'/>'  onClick='stackUp(this)' class='productStack" + cnt + "' id='proicon'>"
									+ "<input type='hidden' id='MaxproductStack" + cnt + "' value='" + data.productStack + "'>"
									+ "<input type='text' name='productStack' id='productStack" + cnt + "' value='1' class='pst' readonly>"
									+ "<img src='<c:url value='/resources/images/prodown.png'/>'  onClick='stackDown(this)' class ='productStack" + cnt + "' id='proicon'>"
									+ "?????? <span id='PriceproductStack" + cnt + "'>" + '${pdto.productPrice}' + "</span> ???"
									+ "&nbsp; <img src='<c:url value='/resources/images/prodelete.png'/>'  onclick='deleteSelPro(this)' class='" + data.productColor + data.productSize +"' id='proicon'></div>");
							
							proTotalSelectCount();
						}else {
							alert('?????? ?????????????????????.');
						};
					}else {
						alert('?????? ????????? ????????????.');
					};
	
				}
			});
		
		PSelement = document.getElementById(ps);
		PSelement.style.backgroundColor = 'black';
		PSelement.style.color = 'white';
		ps = '';
		
		if(pc == null || pc == '') {
			pc = '';
		}else {
			PCelement = document.getElementById(pc);
			PCelement.style.backgroundColor = 'black';
			PCelement.style.color = 'white';
			pc = '';
		}
		
	}


 	function stackUp(product_id) {
		var product_id =  $(product_id).attr('class')
		stack = $("#" + product_id).val();
		Maxstack = $("#Max" + product_id).val();
		stack++;
		if(stack > Maxstack) {
			alert('?????? ?????? ????????? ' + Maxstack + '??? ?????????.')
			stack = Maxstack;
		}
		var productPrice = ${pdto.productPrice};
		var productStackPrice = stack * productPrice;
		$('#' + product_id).val(stack);
		$( '#Price' + product_id).text( productStackPrice );
		proTotalSelectCount();
	}
	
	function stackDown(product_id) {
		var product_id =  $(product_id).attr('class')
		stack = $("#" + product_id).val();
		stack--;
		if(stack <= 0) {
			alert('?????? ?????? ????????? 1??? ?????????.')
			stack = 1;
		}
		var productPrice = ${pdto.productPrice};
		var productStackPrice = stack * productPrice;
		$('#' + product_id).val(stack);
		$( '#Price' + product_id).text( productStackPrice );
		proTotalSelectCount();
	}
	

	function deleteSelPro(id) {
		var delId =  $(id).attr('class')
		$("div").remove("#"+delId)
		proTotalSelectCount()
	}
	
	function proTotalSelectCount() {
		var total_stack = 0;
		var ProductStackTotalPrice = 0;
		var productPrice = ${pdto.productPrice};
		if(cnt > 0) {
			for (var i = 1; i <= cnt ; i++) {
				var product_stack =  parseInt($('#productStack' + i).val());
				if (isNaN(product_stack)) { // ?????? ????????? NaN?????? ?????? ??????
					product_stack = 0;
					}
				total_stack = parseInt(total_stack +  product_stack);
				var ProductStackTotalPrice = total_stack * productPrice;
				$( '#ProductStackTotalPrice').text( "??? ?????? : " + ProductStackTotalPrice + " ???");
				if(total_stack == 0) {
					$( '#ProductStackTotalPrice').text('');
				}
			}	
		}
	}
	
	
	var loginsession = '${sessionScope.loginUser}';
    function productOrder() {
      if(loginsession =='admin'){
         alert('???????????? ????????????????????????')
       }else{
          form = document.profo;
            form.method = "post";
            form.action = '${pageContext.request.contextPath }/order/ordermain'
            var name = $('.pst').attr('name');
            if(name == null){
               alert('?????? ????????? ??????????????????')
            }else{
               form.submit();
            }
          
       }
   }
   
    function productCart() {
      if(loginsession =='admin'){
         alert('???????????? ????????????????????????')
      }else{
         form = document.profo;
         form.method = "post";
         form.action = '${pageContext.request.contextPath }/cart/addcart'
         var name = $('.pst').attr('name');
         if(name == null){
            alert('?????? ????????? ??????????????????')
         }else{
            form.submit();
         }
          
      }
   }
	
	
	   
	  
	 
    /*?????? ????????????*/
	function rePrint(){
    	
	$.ajax({
		url:"../review/replyData", type:"get",
		data:{ productNo : "${pdto.productNo}"
		},
		dataType :"json", 
		success : function( reviewData ){
			let html = ""
		for( i=0; i<reviewData.length; i++){
				let date = new Date( reviewData[i].reviewDate )
				let wd = date.getFullYear()+"-";
				wd += (date.getMonth()+1) + "-";
				wd += date.getDate();
				
				html += "<div align='left'><b>????????? : </b>"+reviewData[i].memberId+"???  &nbsp ";
				html += "<b>????????? : </b>"+ wd+" &nbsp";
				html += "<b>?????? : </b>"+reviewData[i].reviewStar+"<br>";
								
				html += "<b>?????? : </b>"+reviewData[i].reviewContent;
				if(reviewData[i].reviewFile != 'nan'){
					html += "<div align='right'><img src='../review/download?file="+ reviewData[i].reviewFile+"' width='50' height='50' /></div>";
				}
				//
				if ('${sessionScope.loginUser}' ==reviewData[i].memberId) {
				html+= "<div>"+"<a href=../review/delete?reviewNo="+reviewData[i].reviewNo+"&productNo="+reviewData[i].productNo+"&reviewStar="+reviewData[i].reviewStar+">??????</a>"+"  &nbsp ";
				html+= "<a href=../review/modify_form?reviewNo="+reviewData[i].reviewNo+"&productNo="+reviewData[i].productNo+">??????</a>"+"</div>";
				}
				
				html+= "<hr></div>";
	
			}
			
			html += "<div>"+"<a href=../review/reviewMore?productNo="+${pdto.productNo}+">???????????????</a>"+"</div>";
			
			
		
			$("#reply").html( html );
		
			},
		error: function(){alert("function error")}
			
	})
	saveRecentList()
}


	
	
	</script>
	
	
	
	<table border="1">
		<tr>
			<td rowspan="10">
				<c:if test="${ pdto.productFile == 'nan' }">
					<b>????????? ???????????? ????????????.</b>
				</c:if>
				<c:if test="${ pdto.productFile != 'nan' }">
					<img width="300px" height="300px" src="${contextPath}/product/download?productFile=${pdto.productFile}">
				</c:if>
			</td>
			<th>?????? ??????</th><td colspan="2">${pdto.productName }</td>
		</tr>
		<tr>
			<th>??????</th><td colspan="2">${pdto.productPrice }</td>
		</tr>
		<tr>
			<td colspan="3">?????? ??? : ${pdto.reviewCount } / ?????? : 
				<c:if test="${pdto.reviewCount == 0}">
					0
				</c:if>
				<c:if test="${pdto.reviewCount != 0}">
					<fmt:formatNumber value="${pdto.productRating/pdto.reviewCount}" pattern=".00"/>
					
				</c:if>
			</td>
		</tr>
		<tr>
			<th colspan="3">??????</th>
		</tr>
		<tr>
			<td colspan="3">
				<c:if test="${mclist.size() == 0 }">
					<button style="background-color: white; color: black;">??????</button>
				</c:if>
				<c:forEach var="mcdto" items="${mclist }">
					<button onclick="colorAdd(this.id)" id="${mcdto.productColor }">${mcdto.productColor }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th colspan="3">?????????</th>
		</tr>
		<tr>
			<td colspan="3">
				<c:if test="${mslist.size() == 0 }">
					<button style="background-color: white; color: black;">??????</button>
				</c:if>
				<c:forEach var="msdto" items="${mslist }">
					<button onclick="sizeAdd(this.id)" id="${msdto.productSize }">${msdto.productSize }</button>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td colspan="3">
			<form id="proOrderFo" name="profo">
				<input type="hidden" name="productNo" value="${pdto.productNo }">
				<input type="hidden" name="productName" value="${pdto.productName }">
				<input type="hidden" name="productFile" value="${pdto.productFile }">
				<input type="hidden" name="productPrice" id ="productPrice" value="${pdto.productPrice }">
				<div id="proOrderAdd">
				</div>
			</form>
			</td>
		</tr>
		<tr>
			<td><span id="ProductStackTotalPrice"></span>
		</tr>
		<tr>
			<td><button type="button" onclick="productCart()">????????????</button></td>
			<td><button type="button" onclick="productOrder()">????????????</button></td>
		</tr>
	</table>
	
	<div id="proContent">
	<h2>?????? ?????? ??????</h2>
	<hr>
	<div>
	<c:if test="${ pdto.productContent == 'nan' }">
		<b>????????? ???????????? ????????????.</b>
	</c:if>
	<c:if test="${ pdto.productContent != 'nan' }">
		<img src="${contextPath}/product/download?productFile=${pdto.productContent}">
	</c:if>
	</div>
	</div><br><br>
	
	<div id="proReview">
	<h2>?????? ??????</h2>
	<hr>

	 <div>
		<div id="reply"></div>
	</div>
	
	</div><br><br>
	
	<div id="changeGuide">
	<h2>??????/??????/?????? ??????</h2>
	<hr>
	<table border="1">
		<tr>
			<th>?????? ??????</th><td>- ?????? SeeoT??? ?????? ???????????????.</td>
		</tr>
		<tr>
			<th>?????? ??????</th><td>- ?????? 3????????? ?????? ????????? ????????? ???????????????.</td>
		</tr>
		<tr>
			<th>?????? ??????</th><td>- ?????? 7??? ?????? ?????? ?????? ??? ?????? ????????? ????????? ????????? ????????? ?????????.<br>- ?????? ??????????????? ????????? ????????????.</td>
		</tr>
	</table>
	</div>
	
	

</body>
<script src="<%=request.getContextPath() %>/resources/js/sideMenu.js"></script>
</html>