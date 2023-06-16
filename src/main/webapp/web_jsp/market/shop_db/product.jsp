<%@page import="market.ver01.dao.ProductDAO"%>
<%@page import="market.ver01.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="market.ver01.dto.Product" %>

<%--jsp:useBean id="productDAO" class="market.ver01.dao.ProductRepository" scope="session" --%>

<%--추가 부분 --%>
<%@ page import ="market.ver01.dao.ProductRepository" %>
<%@ page errorPage = "exceptionNoProductId.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href ="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 상세 정보</title>
<script type="text/javascript">
	function addToCart() {
		if(confirm("상품을 장바구니에 추가하시겠습니까?")){
			document.addForm.submit();
		}else {
			document.addForm.reset();
		}
	}

</script>
</head>
<body>

<jsp:include page="../inc/menu.jsp" />
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3">상품정보</h1>
	</div>
</div>

<%
	String productId = request.getParameter("id"); //추가부분
	ProductDAO productDAO = new ProductDAO();
	Product product = productDAO.getProductById(productId); 
%>
<div class="container">
	<div class= "row">
		<div class="col-md-5">
			<img src="../resources/images/<%=product.getFilename() %>"
			style="width: 100%"/>
		</div>
		<div class="col-md-6">
			<h3><%=product.getPname() %></h3>
			<p><%=product.getDescription() %>
			<p><b>상품코드 : </b><span class="badge badge-danger"> <%=product.getProductId() %></span>
			<p><b>제조사</b> : <%=product.getManufacturer()%>
			<p><b>분류</b> : <%=product.getCategory()%>
			<p><b>재고 수</b> : <%=product.getUnitsInStock()%>
			<h4><%=product.getUnitPrice()%>원</h4>
			<p>
				<form name="addForm" action="@addCart.jsp?id=<%=product.getProductId() %>" method="post">
					<a href = "#" class="btn btn-info" onclick="addToCart()">상품주문 &raquo; </a>
					<a href = "cart.jsp" class="btn btn-warning"> 장바구니 &raquo;</a>
					<a href="products.jsp" class="btn btn-secondary">상품 목록 &raquo;</a>
				</form>			
		</div>
	</div>
</div>
<jsp:include page="../inc/footer.jsp"/>
</body>
</html>