<%@page import="market.ver01.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	CartDAO cartDAO = new CartDAO();
	String orderNo = session.getId();
	
	//방법 1: 배열로 넘어온 chkID를 사용. 미리 만들어진 deleteCartById() 메서드 사용
	String[] cartIds = request.getParameterValues("chkID");
	
	for(String cartId : cartIds){
		cartDAO.deleteCartById(orderNo, Integer.parseInt(cartId));
		
	}
	
	//방법 2: 문자열로 넘어온 chkdID를 사용. 새로 메서드 만듦.
	/*
	String chkdID = request.getParameter("chkdID");
	cartDAO.deleteCartBySelId(orderNo, chkdID);
	
	*/
	response.sendRedirect("cart.jsp");
	
%>