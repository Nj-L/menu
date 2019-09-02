<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% 
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String pw = request.getParameter("password");
    System.out.println(name);
    System.out.println(email);
    System.out.println(pw);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=name %>
</body>
</html>