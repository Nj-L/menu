<%@page import="javafx.scene.control.Alert"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
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
   String email = request.getParameter("username");
  
 
   String password = request.getParameter("password");
   
   
   System.out.println(email);
   System.out.println(password);
   
  
   boolean  isLogin = false;
   Connection conn=null;
   
   Boolean connect = false;
	String hello = "";
   try{
   	Context init = new InitialContext();
   	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
   	conn = ds.getConnection();
   	String sql = "select * from users where email = ? and pw = ?";
       PreparedStatement pstmt = conn.prepareStatement(sql);
       pstmt.setString(1, email);
       pstmt.setString(2, password);
   	ResultSet rs = pstmt.executeQuery();
    
   	if(rs.next()){
   		
   		 System.out.print(rs.getString("name"));
   		 System.out.println("님 반갑습니다.");
   		 System.out.println("로그인 성공");
   		 hello = rs.getString("name");
   		
   		 isLogin = true;
   		 
   	 }else{
   		 System.out.println("아이디가 없거나 패스워드가 틀립니다.");
   	 }
    	
    
    
     rs.close();
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
<title>login/process.jsp</title>
</head>
<body>
<h1>로그인 성공</h1><br>

<%if(isLogin){%>
 	
 	<script type = " text/javascript">
	var hellot ="<%=hello%>";
	alert(hellot+"님 반갑습니다");
	</script>
	
<script>
	location.href="https://nj-l.github.io/Homepage/#page-top"
</script>
<br>
<% }else{%>
<script>alert("로그인 실패!! 아이디가 없거나 패스워드가 틀립니다.");</script>
<script>
	location.href="../sign.jsp"
</script>
<%} %>

</body>
</html>