<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<html><head><title>수강신청 조회</title></head></html>
<body>
<%@include file = "top.jsp"%>
<% if(session_id == null) response.sendRedirect("login.jsp"); %>

<table width="75%" align="center" border>
<br>
<th>과목번호</th><th>과목명</th><th>분반</th>
        <th>강의요일</th><th>강의시간</th><th>강의장소</th><th>학점</th>

<%
Connection myConn = null; Statement stmt = null;
ResultSet myResultSet = null; String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db1610193";
String passwd = "oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
int sum_course = 0;
int sum_unit = 0;


   try{
      Class.forName(dbdriver);
      myConn = DriverManager.getConnection(dburl, user, passwd);
      stmt = myConn.createStatement();
   } catch (SQLException ex){
      System.err.println("SQLException : " + ex.getMessage());
   }
   
   mySQL = "select e.s_id, e.c_id, c.c_name, e.c_id_no, c.c_unit, c.c_day, c.c_time, c.c_where, e.e_year, e.e_semester from enroll2 e, course2 c where e.c_id = c.c_id";
//where c_id not in (select c_id from enroll2 where s_id='" + session_id + "')";
//mySQL = "select c_id, c_id_no, c_unit from course where c_id not in (select c_id from enroll where s_id='" + session_id + "')";

   myResultSet = stmt.executeQuery(mySQL);

   if(myResultSet !=null){
      while(myResultSet.next()){
         String s_id = myResultSet.getString("s_id");
         String c_id = myResultSet.getString("c_id");
         String c_name = myResultSet.getString("c_name");
         int c_id_no = myResultSet.getInt("c_id_no");
         int c_unit = myResultSet.getInt("c_unit");
         String c_time = myResultSet.getString("c_time");
         String c_where = myResultSet.getString("c_where");
         String c_day = myResultSet.getString("c_day");
         int e_year = myResultSet.getInt("e_year");
         int e_semester = myResultSet.getInt("e_semester");
         sum_unit = sum_unit + c_unit;
         sum_course++;

%>

<tr>
<td align="center"><%=c_id%></td>
<td align="center"><%=c_name%></td>
<td align="center"><%=c_id_no%></td>
<td align="center"><%=c_day%></td>
<td align="center"><%=c_time%></td>
<td align="center"><%=c_where%></td>
<td align="center"><%=c_unit%></td>
</tr>
<%
}
 
}
stmt.close(); myConn.close();
%>
</table>
<br/>
<br/>
 <div width="75%" align="center" border>
     
      <p><%=sum_course %>과목, 총 <%=sum_unit %>학점 수강신청 했습니다 </p>        
      </div>
     
</body></html>