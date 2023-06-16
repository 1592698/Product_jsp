<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="market.ver01.dto.Product" %>
<%@ page import ="market.ver01.dao.CartDAO" %>
<%@ page import ="market.ver01.dto.CartDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href ="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<%
String cartId = session.getId();%>
<title>장바구니</title>

</head>
<body>
	<jsp:include page="../inc/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table style ="width : 100%">
				<tr>
					<td align ="left">
					<span class="btn btn-danger" onclick ="deleteCart();"> 전체 삭제하기 </span>
					<span class="btn btn-danger" onclick ="deleteCartSel();"> 선택 삭제하기 </span>
					
					<td align ="right"><a href="../order/form.do" class="btn btn-success">주문하기</a></td>
				
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
		<script type="text/javascript" src="../resources/js/check_system.js"></script>
		<form name="frmCart" method="get">
			<input type="hidden" name="id">
			<input type="text" name="chkdID">
			<table class="table table-hover">
				<tr>
					<th><input name="chkAll" type="checkbox" onClick="setChkAll();">상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				
				<%
					int sum =0;
					CartDAO cartDAO = new CartDAO();
					String orderNo = session.getId();
					
					ArrayList<CartDTO> cartArrayList = (ArrayList<CartDTO>) request.getAttribute("carts");
					
					for(CartDTO cart : cartArrayList){
						int total = cart.getP_unitPrice() * cart.getP_cnt();
						sum +=total;
					
				%>
					<tr>
						<td>
						<input type="checkbox" name="chkID" value="<%=cart.getP_cartId() %>" onclick="setChkAlone(this);">
						<%=cart.getP_productId() %>-<%=cart.getP_name() %> </td>
						<td> <%=cart.getP_unitPrice() %></td>
						<td> <%=cart.getP_cnt()%></td>
						<td> <%=total %></td>
						<td><span class="badge badge-danger"  onclick="removeCartByID('<%=cart.getP_cartId()%>')">삭제</span></td>
					
					</tr>
					
					<%
						}
					%>		
					<tr>
						<th></th>
						<th></th>
						<th>총액</th>
						<th><%=sum %></th>
						<th></th>
					</tr>		
			</table>
		</form>
			
		</div>	
		
		
		
		<script>
			window.onload=function() {
				document.frmCart.chkAll.checked = true; //전체 체크 박스 체크
				setChkAll(); // 목록의 체크박스 체크
			}
			
			function frmName() {
				return document.frmCart;
			}
		</script>

		
		<script>
		const frm = document.frmCart;
		let removeCartByID= function(ID){
			//개별삭제
			if(confirm('삭제하시겠습니까?')){
				//frm.id.value = ID;
				//frm.action = "removeCart.jsp";
				//frm.submit();
				location.href='removeCart.jsp?id=' + ID;
			}
		}
		
		let deleteCartSel = function() {
			if(confirm('선택한 상품을 삭제하시겠습니까?')){
				frm.action="removeCartSel.jsp";
				frm.submit();
			}
		}
	
		let deleteCart=function() {
			if(confirm("상품을 장바구니에서 전체 삭제하시겠습니까?")){
				//frm.action="deleteCart.jsp";
				//frm.submit();
				location.href ='deleteCart.jsp';
			}
		}
</script>
	<a href="products.jsp" class="btn btn-secondary"> &laquo; 쇼핑계속하기</a>
	</div>
	<jsp:include page="../inc/footer.jsp"/>
</body>
</html>