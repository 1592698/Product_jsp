<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int num1 = 5;
	%>
	<jsp:include page="sample_02_include.jsp" flush="false" />
	<br>
	<%--
		out.println(num1 * num2);
	--%>
</body>
</html>