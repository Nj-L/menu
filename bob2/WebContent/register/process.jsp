<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
   //자바코드 작성
   //한글깨짐 방지
   request.setCharacterEncoding("UTF-8");
   //username, email, password, confirm-password
    String name = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String cpassword = request.getParameter("confirm-password");
    System.out.println(name);
    System.out.println(email);
    System.out.println(password);
    System.out.println(cpassword);
   /*
    if(name.matches(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")||name==""){
    	out.print("<script> alert('only english please');location.href = '../sign.jsp';</script>");
		return;
    }
    */
    if(email==""){
    	out.print("<script> alert('email is Blank');location.href = '../sign.jsp';</script>");
		return;
    }
    
    
    if(password==""){
    	out.print("<script> alert('password is Blank');location.href = '../sign.jsp';</script>");
		return;
    }
    if(!password.equals(cpassword)){
    	/*
    	out.println("<script>"); 이런 형식도 가능 
    	out.println("alert('패스워드가 일치하지 않습니다.');");
    	out.println("location.href = '../sign.jsp';");
    	out.println("</script>");
    	*/
    	out.print("<script> alert('패스워드가 일치하지 않습니다.');location.href = '../sign.jsp';</script>");
    	
    	return;
    }
    
    
    
    
    Connection conn=null;
   
    Boolean connect = false;

    try{
    	Context init = new InitialContext();
    	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
    	conn = ds.getConnection();
        String sqll = "SELECT email FROM users WHERE email = ?";
        PreparedStatement pstmtl = conn.prepareStatement(sqll);
        pstmtl.setString(1, email);
        ResultSet rs = pstmtl.executeQuery();
        if(rs.next()){
        	out.print("<script> alert('중복된 이메일 입니다.');location.href = '../sign.jsp';</script>");
        	return;
        }
      
    	String sql = "INSERT INTO users (NAME, PW, EMAIL) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, password);
        pstmt.setString(3, email);
        pstmt.executeUpdate();
        connect = true;
        
        conn.close();
    }catch(Exception e){
        connect = false;
        e.printStackTrace();
    }
    
   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>register/process.jsp</title>
</head>
<body>
<h1>회원 가입</h1><br>
이름 : <%=name %><br>
이메일 : <%=email %><br><br>

회원 가입 완료

<a href = "../sign.jsp"><h1>로그인</h1></a>
</body>
</html>