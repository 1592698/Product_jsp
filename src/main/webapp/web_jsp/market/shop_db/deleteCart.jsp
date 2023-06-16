<%@page import="market.ver01.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="market.ver01.dao.ProductRepository" %>
<%@page import="market.ver01.dto.Product" %>

<%

/*장바구니에서 상품을 전체 삭제*/
	String orderNo = session.getId();
	CartDAO cartDAO = new CartDAO();
	cartDAO.deleteCartAll(orderNo);
	response.sendRedirect("cart.jsp");

%>