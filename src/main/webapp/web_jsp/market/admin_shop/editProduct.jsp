<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="market.ver01.dto.Product"%>
<%@ page import="market.ver01.dao.ProductRepository"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품편집</title>
<script type="text/javascript">
   function deleteConfirm(id) {
      if (confirm("해당 상품을 삭제합니다!!") == true)
         location.href = "./deleteProduct.jsp?id=" + id;
      else
         return;
   }
</script>
</head>
<%
   String edit = request.getParameter("edit");
   // 파라미터(값) 받는 부분
%>
<body>
   <jsp:include page="../inc/menu.jsp" />
   <div class="jumbotron">
      <div class="container">
         <h1 class="display-3">상품편집</h1>
      </div>
   </div>
   
   <div class="container">
   <%@ include file="../inc/dbconn.jsp" %>
      <div class="row" align="center">
         <% 
            String sql = "select * from product";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
         %>
         <div class="col-md-4">
            <img src="${pageContext.request.contextPath}/resources/images/<%=rs.getString("p_fileName")%>"
               style = "width: 300px" alt="">
            <h3><%=rs.getString("p_name")%></h3>
            <p><%=rs.getString("p_description") %></p>
            <p><%=rs.getString("p_UnitPrice") %>원
            <p>
               <%
                  if(edit.equals("update")) {                  
               %>
               <a href="updateProduct.jsp?id=<%=rs.getString("p_id")%>" class="btn btn-success" role="button">
               수정 &raquo;></a>
               <% 
                  } else if (edit.equals("delete")) {
                     
               %>
               <a href="#" onclick="deleteConfirm('<%=rs.getString("p_id") %>')" class="btn btn-danger" role="button">
               삭제 &raquo;></a>

               <% 
                  }
               %>
         </div>
         <% 
            }
            
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         %>
      </div>
      <hr>
   </div>
   <jsp:include page="../inc/footer.jsp" />
</body>
</html>