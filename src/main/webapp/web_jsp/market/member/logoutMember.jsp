<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	session.removeAttribute("sessionId");

	session.removeAttribute("sessionName");

	session.invalidate();
	response.sendRedirect("../index.jsp");
%>