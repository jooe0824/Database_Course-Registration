<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
<title>수강신청 사용자 정보 수정</title>
</head>
<body>
<%


   Connection myConn = null;
   String dbdriver = "oracle.jdbc.driver.OracleDriver";
   String dburl= "jdbc:oracle:thin:@localhost:1521:orcl";
   String user="db1610193";   String password="oracle";
   PreparedStatement pstmt = null;
   Class.forName(dbdriver);
   myConn=DriverManager.getConnection(dburl, user, password);
   
   String ID = request.getParameter("userID");
   String Password = request.getParameter("userPassword");
   String Passwordconfirm = request.getParameter("passwordconfirm");
   String Address = request.getParameter("address");

   if(Password.equals(Passwordconfirm)) {
      
      try{

      pstmt = myConn.prepareStatement("update student2 set s_pwd=?, s_addr=? where s_id=?");
      pstmt.setString(1, Password);
      pstmt.setString(2, Address);
      pstmt.setString(3, ID);
      pstmt.executeUpdate(); 
      
      %>
      <script>
      alert("수정이 완료되었습니다.");
      location.href="main.jsp";
      </script>
      <%
      
      }catch(SQLException ex) {
      
      String sMessage = "";
      if(ex.getErrorCode() == 20002)
         sMessage = "암호는 4자리 이상이어야 합니다.";
      else if(ex.getErrorCode() == 20003)
         sMessage = "암호에 공란은 입력되지 않습니다.";
      else
         sMessage = "잠시 후 다시 시도하십시오.";
      %>
      <script>
      alert("<%=sMessage%>");
      location.href="update.jsp";
      </script>
      <%
      }finally{
      if(pstmt != null) try{pstmt.close();}catch(SQLException e){}
      if(myConn != null) try{myConn.close();}catch(SQLException e){}    
      }
   }
      
   else{
      %>
      <script>
      alert("비밀번호가 일치하지 않습니다.");
      location.href="update.jsp";
      </script>
      <%
   }
   

%>
</body>
</html>