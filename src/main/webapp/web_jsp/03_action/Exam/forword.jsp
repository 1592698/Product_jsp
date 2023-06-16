<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Action Tag</title>
</head>
<body>
	<%-- 문제
		 1. forword 액션 태그를 이용하여 다음 조건에 맞게 JSP 애플리케이션을 만들고 실행 결과를 확인하라.
		 1) forword 파일을 생성하여 <h4> 태그에 "구구단 출력하기" 를 작성
		 2) forword 액션 태그로 구구단을 출력하는 forword_data.jsp 파일로 이동하도록 작성
		 3) param 액션 태그로 숫자 5를 출력하는 forword_data.jsp 파일에 전달하도록 작성
		 
		 2. forword_data.jsp 파일을 생성
		 1) 전달 받은 숫자 5의 구구단을 출력하도록 작성 --%>
		 
	<h4>구구단 출력하기</h4>
	<jsp:forward page="forword_data.jsp">
		<jsp:param name="num1" value="5" />
	</jsp:forward>
</body>
</html>