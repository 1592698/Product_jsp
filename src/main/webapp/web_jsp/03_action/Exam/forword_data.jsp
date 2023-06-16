<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int num1 = Integer.parseInt(request.getParameter("num1"));
		
		for(int i=1; i<10; i++) {
			out.print(num1 + " * " + i +" = " + (num1*i) );
			out.println("<br>");
		}
	%>
</body>
</html>