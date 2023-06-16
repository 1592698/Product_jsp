<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%--
	1. 전송된 id값과 name 값을 받도록 request 내장 객체의 getParameterr() 메소드를 작성
	2. name 값을 출력하도록 표현문 태그를 작성
	한글이 깨지지 않도록 java.net.URLDecoder.decode() 메소드로 전송된 데이터를 받음 --%>

	<p>아이디 : <%=request.getParameter("id") %>
	<%
		String name = request.getParameter("name");	
	%>
	<p>이름 : <%=java.net.URLDecoder.decode(name)%></p>
</body>
</html>