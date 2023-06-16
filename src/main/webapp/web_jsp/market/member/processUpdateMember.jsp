<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


<%
   request.setCharacterEncoding("UTF-8");
   
   String id = (String) session.getAttribute("sessionId");   //아이디 해킹 당하지 않기 위해 세션으로
   String password = request.getParameter("password");
   String name = request.getParameter("name");
   String gender = request.getParameter("gender");
   String year = request.getParameter("birthyy");
   String month = request.getParameterValues("birthmm")[0];
   String day = request.getParameter("birthdd");
   String birth = year + "/" + month + "/" + day;
   String mail1 = request.getParameter("mail1");
   String mail2 = request.getParameterValues("mail2")[0];
   String mail = mail1 + "@" + mail2;
   String phone = request.getParameter("phone");
   String address = request.getParameter("address");    
   
%>

<sql:setDataSource var="dataSource"
   url="jdbc:mariadb://localhost:3306/webMarketDB"
   driver="org.mariadb.jdbc.Driver" user="root" password="0528" />

<sql:update dataSource="${dataSource}" var="resultSet">
   UPDATE member SET password=?, name=?, gender=?, birth=?, mail=?, phone=?, address=? WHERE id=?
   <sql:param value="<%=password %>" />
    <sql:param value="<%=name %>" />
    <sql:param value="<%=gender %>" />
    <sql:param value="<%=birth %>" />
    <sql:param value="<%=mail %>" />
    <sql:param value="<%=phone %>" />
    <sql:param value="<%=address %>" />
    <sql:param value="<%=id %>" />
</sql:update>

<c:if test="${resultSet>=1}" >
   <c:redirect url="resultMember.jsp?msg=0" />
</c:if>