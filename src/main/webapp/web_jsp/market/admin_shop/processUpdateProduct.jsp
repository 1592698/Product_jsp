<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import ="java.sql.*" %>
<%@ include file = "../inc/dbconn.jsp" %>
    <%
    request.setCharacterEncoding("UTF-8");
	
	String realPath = request.getServletContext().getRealPath("resources/images"); //파일저장된 경로
	File dir = new File(realPath);//dir directory(=폴더)
	if(!dir.exists()){
		dir.mkdirs(); //makedirectorys 폴더없으면 폴더 만들어라
	}
	
	String filename="";
	String encType="UTF-8"; //인코딩 타입
	int maxSize = 5 *1024 *1024; //최대 업르도될 파일의 크기 5mb

	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, encType, new DefaultFileRenamePolicy());
    
    	String productId = multi.getParameter("productId");
    	String name = multi.getParameter("name");
    	String unitPrice = multi.getParameter("unitPrice");
    	String description = multi.getParameter("description");
    	String manufacturer = multi.getParameter("manufacturer");
    	String category = multi.getParameter("category");
    	String unitsInStock = multi.getParameter("unitsInStock");
    	String condition = multi.getParameter("condition");
    	
    	Integer price;
    	
    	if(unitPrice.isEmpty())
    		price = 0;
    	
    	else 
    		price = Integer.valueOf(unitPrice);
    	
    	long stock;
    	if(unitsInStock.isEmpty())
    		stock =0;
    	else
    		stock = Long.valueOf(unitsInStock);
    	
    	
    	Enumeration files = multi.getFileNames();
    	String fname = (String) files.nextElement();
    	String fileName = multi.getFilesystemName(fname);

    	
    	String sql = "select * from product where p_id = ?";
    	pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1, productId);
    	rs= pstmt.executeQuery();
    	
    	if (rs.next()) {
    		if (fileName != null) {
		    	sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, "
		    		+ "p_unitsInStock=?, p_condition=?, p_fileName=? WHERE p_id=?";
		    	pstmt = conn.prepareStatement(sql);
		    	pstmt.setString(1, name);
		    	pstmt.setInt (2, price);
		    	pstmt.setString(3, description);
		    	pstmt.setString(4, manufacturer);
		    	pstmt.setString(5, category);
		    	pstmt.setLong(6, stock);
		    	pstmt.setString(7, condition);
		    	pstmt.setString(8, fileName);
		    	pstmt.setString(9, productId);
		    	pstmt.executeUpdate();
		    	} else {
			    	sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, "
			    		+ "p_unitsInStock=?, p_condition=? WHERE p_id=?";
			    	pstmt=conn.prepareStatement(sql);
			    	pstmt.setString(1, name);
			    	pstmt.setInt (2, price);
			    	pstmt.setString(3, description);
			    	pstmt.setString(4, manufacturer);
			    	pstmt.setString(5, category);
			    	pstmt.setLong (6, stock);
			    	pstmt.setString(7, condition);
			    	pstmt.setString(8, productId);
			    	pstmt.executeUpdate();
		    	}
    	}

        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
        
        response.sendRedirect("editProduct.jsp?edit=update");

 %>
    	