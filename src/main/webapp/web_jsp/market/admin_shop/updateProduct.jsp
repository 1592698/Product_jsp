<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="market.ver01.dto.Product"%>
<%@ page import="market.ver01.dao.ProductRepository"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script type="text/javascript" src="./resources/js/validation.js" defer></script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 수정</h1>
		</div>
	</div>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		String productId = request.getParameter("id");
	
		String sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		if (rs.next()) {
	%>
         <div class="container">
            <div class="text-right">
               <a href="logout.jsp" class="btn btn-sm btn-success pull-right">logout</a>
            </div>
         </div>
         <div class="container">
          <form name="newProduct" action="processUpdateProduct.jsp" class="form-horizontal" method="post"
                enctype="multipart/form-data">
          <input type="hidden" id="productId" name="productId" value='<%=rs.getString("p_id") %>'> <!-- 고유값 수정 못하도록 하려고 hidden -->
             
         <div class="form-group row">
            <label class="col-sm-2">상품명</label>
            <div class="col-sm-3">
               <input type="text" name="name" class="form-control" id="name" value='<%=rs.getString("p_name") %>'>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">가격</label>
            <div class="col-sm-3">
               <input type="text" name="unitPrice" class="form-control" id="unitPrice" value='<%=rs.getString("p_unitPrice") %>'>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">상세 정보</label>
            <div class="col-sm-5">
               <textarea name="description" cols="50" rows="2" class="form-control"><%=rs.getString("p_description")%> %></textarea>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">제조사</label>
            <div class="col-sm-3">
               <input type="text" name="manufacturer" class="form-control" value='<%=rs.getString("p_manufacturer") %>'>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">분류</label>
            <div class="col-sm-3">
               <input type="text" name="category" class="form-control" value='<%=rs.getString("p_category") %>'>
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">재고 수</label>
            <div class="col-sm-3">
               <input type="text" name="unitsInStock" class="form-control" id="unitsInStock" value='<%=rs.getString("p_unitsInStock") %>'>
            </div>
         </div>         
         <div class="form-group row">
            <label class="col-sm-2">상태</label>
            <div class="col-sm-5">
               <input type="radio" name="condition" value="New" <%if (rs.getString("p_condition").equals("New")) out.print("checked"); %>> 신규 제품 
               <input type="radio" name="condition" value="Old"<%if (rs.getString("p_condition").equals("Old")) out.print("checked"); %>> 중고 제품 
               <input type="radio" name="condition" value="Refurbished"<%if (rs.getString("p_condition").equals("Refurbished")) out.print("checked"); %>> 재생 제품 
            </div>
         </div>
         <div class="form-group row">
            <label class="col-sm-2">이미지</label>
            <div class="col-sm-5">               
               <input type="file" name="productImage" class="form-control">
            </div>
         </div>
         <div class="form-group row">
            <div class="col-sm-offset-2 col-sm-10">
               <input type="button" class="btn btn-primary" value="수정" onclick ="CheckAddProduct()">
            </div>
         </div>
      </form>
   </div>
   <% 
        }
        if (rs !=null) rs.close();
        if (pstmt !=null) pstmt.close();
        if (conn !=null) conn.close();
    %>
</body>
</html>
</html>