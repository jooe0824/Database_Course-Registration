<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title></title>
<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	Connection myConn = null;
	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db1610193";
	String passwd = "oracle";
	Statement stmt = null;	
	String mySQL = null;	
	ResultSet myResultSet = null; 
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");
%>
</head>
<body>
<%
	try{
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		mySQL = "select s_id, s_pwd from student2 where s_id='" + userID + "' and s_pwd='"+ userPassword +"'";
		myResultSet = stmt.executeQuery(mySQL);
	}catch(SQLException e){
	    System.err.println("SQLException : " + e.getMessage());
	}finally{
		if(myResultSet != null){
			if (myResultSet.next()) {
			session.setAttribute("user", userID);
%>
				<script> 
					alert("로그인 되었습니다."); 
					location.href="main.jsp";  
				</script>
<%
			}
			else {
%>
				<script> 
					alert("아이디/패스워드가 틀렸습니다."); 
					location.href="login.jsp";  
				</script>  
<%
			}
		}	
		stmt.close();
		myConn.close();
	}
%>
</body>
</html>