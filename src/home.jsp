<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title> ToDo Application</title>
	<style>
	body {
  		margin: 0;
	    	padding: 0;
	    	font-family: sans-serif;
	    	background-image: url(background.jpg);
	    	background-size: cover;
	    	background-position: center;
	}
	.topnav {
		  overflow: hidden;
		  background-color: black;
	}
	.topnav a {
		  float: left;
		  text-align: center;
		  padding: 16px 24px;
		  text-decoration: none;
		  font-size: 17px;
		  color: white;
	}
	.topnav a:hover {
	  background-color: #ddd;
	  color: black;
	}
	.topnav a.active {
	  background-color: #04AA6D;
	  color: black;
	}
	.topnav-right {
		  float: right;
	}
	.img-fluid{
    		width: 46px;
    		height: 46px;
    		border-radius: 50%;
    		overflow: hidden;
    		margin-top: 4px;
	}
	.table{
		margin-top: 30;
		text-decoration: none;
		font-size: 17px;
		color: black;
		width: 450px;
	  	  box-shadow: 0 0 3px 0 rgba(0,0,0,0.3);
	  	  background: white;
	  	  padding: 10px;
	  	  margin: 5% auto 0;
	  	  text-align: center;	  
		border-radius: 20px;
	}
	</style>
</head>
<body>
	<div class="topnav">
  		<a class="active" href="home.jsp">Home</a>
  		<a  href="todo.jsp">ToDo</a>
  		<div class="topnav-right">
			<img src="User-Ico.png" class="img-fluid">
  	 		<a  class="topnav-right" href="user.jsp">User</a>
		</div>
  	</div>
	<center>
	<table class = "table" border="2" style="width:80%" >
	    <tr>
		<th> Task </th>
		<th> Date </th>
		<th> Status </th>
		<th> Update </th>
	    </tr>
	<%
	    try{
		String usr = request.getParameter("un");
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url = "jdbc:mysql://localhost:3306/todoproject";
		String un = "root";
		String pw = "abc456";
		Connection con = DriverManager.getConnection(url, un,pw);

		String sql = "select * from " + usr;
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();
		while(rs.next()){
			String task = rs.getString(1);
			java.util.Date date = rs.getDate(2);
			String status = rs.getString(3);
	%>		
	    <tr width="50%">
	    	<td><%= task %></td>
	    	<td><%= date %></td>
		<td><%= status %></td>
		<td> <a href="update.jsp" > Update </a> </td>
	    </tr>
	<%
		}
		con.close();
	    }
	    catch(SQLException e){
		out.println("Issue = " + e);
	    }
	%>
	</table>
</center>
</body> 
</html>