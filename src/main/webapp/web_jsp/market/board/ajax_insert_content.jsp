<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file ="../inc/dbconn.jsp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="mvc.model.RippleDTO" %>
<%@ page import="mvc.model.RippleDAO" %>
<%
    RippleDAO dao = RippleDAO.getInstance();
    RippleDTO ripple = new RippleDTO();

    request.setCharacterEncoding("UTF-8");

    ripple.setBoardName(request.getParameter("boardName"));
    ripple.setBoardNum(Integer.parseInt(request.getParameter("num")));
    ripple.setMemberId((String) session.getAttribute("sessionId"));
    ripple.setName(request.getParameter("name"));
    ripple.setContent(request.getParameter("content"));
    ripple.setIp(request.getRemoteAddr());

    if (dao.insertRipple(ripple)) {%>
{"result" : "true"}
<%
}

else {%>
{"result" : "false"}
<%}
%>