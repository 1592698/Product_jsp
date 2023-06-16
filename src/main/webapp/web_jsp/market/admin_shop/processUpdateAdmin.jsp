<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="../inc/dbconn.jsp" %>

<%
   request.setCharacterEncoding("UTF-8");
   
   String id = (String) session.getAttribute("sessionAdminId");
   String password = request.getParameter("password");
   String name = request.getParameter("name");

   String sql="update admin set password = ?, name = ? where id = ?";
   pstmt = conn.prepareStatement(sql);
   pstmt.setString(1, password);
   pstmt.setString(2, name);
   pstmt.setString(3, id);

  int result = pstmt.executeUpdate();
  if(result ==1){
	  session.setAttribute("sessionAdminName", name);
	  response.sendRedirect("index.jsp");
  }
  else{
   response.sendRedirect("updateAdmin.jsp");
	  
  }
%>
