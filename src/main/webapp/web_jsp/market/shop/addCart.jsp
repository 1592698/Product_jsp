<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="market.ver01.dto.Product"%>
<%@ page import="market.ver01.dao.ProductDAO" %>
<%@ page import="market.ver01.dao.CartDAO" %>

<%
   String productId = request.getParameter("id");
   if (productId == null || productId.trim().equals("")) {
      response.sendRedirect("products.jsp");
      return;
   }
   
   ProductDAO productDAO = new ProductDAO();
	 Product productDTO = productDAO.getProductById(productId);
   if (productDTO == null) {
	   response.sendRedirect("exceptionNoProductId.jsp");
   }
  
   String orderNo= session.getId();
   String memberId = (String) session.getAttribute("sessionId");
   CartDAO cartDAO = new CartDAO();
   boolean flag = cartDAO.updateCart(productDTO, orderNo, memberId);
   
   response.sendRedirect("product.jsp?id=" + productId);
%> 