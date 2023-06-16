<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
1) 변수 pageCount에 값을 저장하고 변수 값을 1씩 증가시키는 함수
addCount()를 선언하도록 선언문 태그를 작성
2) 함수 addCount()를 호출하도록 스클립틀릿 태그를 작성
3) 변수 pageCount()의 값을 출력하도록 표현문 태그를 작성
--%>

<%!
	int pageCount =0;
	void addCount() {
		pageCount++;
	}
%>
<%
	addCount();
%>
<p> 이 사이트 방문은 <%=pageCount%>번째 입니다.</p>