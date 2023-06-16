<%--
  Created by IntelliJ IDEA.
  User: parksohee
  Date: 2023/01/18
  Time: 9:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<html>
<head>
    <title>아이디 중복 확인</title>
</head>
<body>
  <%
    request.setCharacterEncoding("UTF-8");
    String id = request.getParameter("id");
  %>
  <%@include file="../inc/dbconn_jstl.jsp"%>

  <sql:query dataSource = "${dataSource}" var="resultSet">
    SELECT COUNT(*) AS cnt FROM member WHERE id =?
    <sql:param value="<%=id%>"/>
  </sql:query>
  <c:forEach var="row" items="${resultSet.rows}">
    <c:choose>
      <c:when test ="${row.cnt==1}">
        동일한 아이디가 있습니다.
      </c:when>
      <c:otherwise>
        동일한 아이디가 없습니다.
      </c:otherwise>
    </c:choose>
  </c:forEach>
</body>
</html>
