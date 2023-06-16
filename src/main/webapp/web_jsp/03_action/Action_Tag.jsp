<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Action Tag</title>
</head>
<body>
	<%-- forword 액션 태그로 현재 날짜와 시각을 출력하는 페이지로 이동하기.
	1. 외부 파일 forward_date.jsp 의 내용을 출력하도록 forward 액션 태그의 page 속성을 작성 --%>
	
	<h2>forward 액션 태그</h2>
	<jsp:forward page="forward_date.jsp" />
	<p>---------------------------------</p>
</body>
</html>