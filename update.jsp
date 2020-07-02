<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*" %>

<html><head><title>수강신청 사용자 정보 수정</title>
</head>
<body>
<%@ include file="top.jsp" %>

<%
   Connection myConn = null;
   String dbdriver = "oracle.jdbc.driver.OracleDriver";
   String dburl= "jdbc:oracle:thin:@localhost:1521:orcl";
   String user="db1610193"; //user는 다 다르게…
   String password="oracle";
   String mySQL = "";
   String userAddress = "";
   String userPassword = "";
   Statement stmt = null;
   ResultSet rs = null;    
   Class.forName(dbdriver);
 %>
<%
   if (session_id==null) {%>
   <script>
     alert("로그인 후 사용하세요.");
     location.href="login.jsp";
   </script>
<%
   } else{
        try{
           myConn = DriverManager.getConnection(dburl, user, password); //연결하기
           stmt = myConn.createStatement();
           mySQL = "select s_addr, s_pwd from student2 where s_id='" + session_id + "'" ;
           rs= stmt.executeQuery(mySQL); //sql에서 쿼리해오기
         } catch (SQLException ex){
           System.err.println("SQLException : " + ex.getMessage());  //sql exception오류시에 메시지
         } finally{
         if(rs != null){
          if (rs.next()) { //쿼리 성공시에
          userAddress = rs.getString("s_addr");
          userPassword = rs.getString("s_pwd");
            }
         else {
%>
      <script>
       alert("다시 로그인 해주세요.");
        location.href="login.jsp";
       </script>
<%
     }
}//if(rs!=null)문 끝남
%>
<form method="post" action="update_verify.jsp">
   <table width="75%" align="center" bgcolor="#FFFF99" border>
 
<tr>
  <td><div align="center">아이디</div></td>
  <td colspan="3"><div align="center">
<input id = "update_id" type="text" name="userID" size="50" style="text-align: center;" value=<%=session_id%> readonly >
  </td></tr>

<tr>
<td><div align="center">비밀번호</div></td>
  <td colspan="3"><div align="center">
<input id = "update_pwd" type="password" name="userPassword" size="10" style="text-align: center;" value=<%=userPassword%> >
  </td>
  <td><div align="center">확인</div></td>
  <td colspan="3"><div align="center">
<input id = "update_pwd" type="password" name="passwordconfirm" size="10" style="text-align: center;" >
  </td>
  </tr>

  <tr>
  <td><div align="center">주소</div></td>
  <td colspan="3"><div align="center">
  <input id = "update_add" type="text" name="address" size="50" style="text-align: center;" value=<%=userAddress%> > </td>
   </tr>
 
<tr>
   <td colspan=2><div align="center" >
   <INPUT TYPE = "SUBMIT" NAME="Submit" VALUE="수정" >
   <INPUT TYPE="RESET" VALUE="취소" >
   </div>
   </td>
</tr>

</table>
</form>
<%
stmt.close();
myConn.close();
}//finally문 끝남
}//if문 끝남
%>
</body></html>