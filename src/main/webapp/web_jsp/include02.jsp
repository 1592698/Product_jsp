<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%-- 
include 디렉티브 태그로 머리글과 바닥글에 외부 파일의 내용 포함하기
1) 외부 파일 Test08_header.jsp 의 내용을 포함하도록 include 디렉티브 태그 작성
2) 외부 파일 Test08_footer.jsp 의 내용을 포함하도록 include 디렉티브 태그 작성 --%>

<%@ include file="include02_header.jsp" %>
<p>방문해 주셔서 감사합니다 </p>
<%@ include file="include02_footer.jsp" %>
</body>
</html>