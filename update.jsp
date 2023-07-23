<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
	
	.topnav-right {
		float: right;
		background-color: #04AA6D;
	 	color: black;
	}
	.img-fluid{
    		width: 46px;
    		height: 46px;
    		border-radius: 50%;
    		overflow: hidden;
    		margin-top: 4px;
	}
	.todo{
		width: 450px;
	  	  box-shadow: 0 0 3px 0 rgba(0,0,0,0.3);
	  	  background: white;
	  	  padding: 10px;
	  	  margin: 5% auto 0;
	  	  text-align: center;	  
		border-radius: 20px;
	}
	.input-box{
		padding: 10px;
		margin: 10px 0;
		width: 100%;
		border: 1px solid #999;
		outline: none;
	}
	.save-btn{
		background-color: #1c8adb;
		width: 25%;
		padding: 10px;
		border-radius: 20px;
		font-size: 15px;
		margin: 10px 0;
		border: none;
		outline: none;
		cursor: pointer;
	}
	</style>
</head>
<body>
	<div class="topnav">
  		<a href="home.jsp">Home</a>
  		<div class="topnav-right">
			<img style="padding: 0px 24px;"src="User-Ico.png" class="img-fluid">
  	 		<a class="topnav-right" href="update.jsp">Update</a>
		</div>
  	</div>
	<div class="todo">
	<form method="ToDo">
  	   <input readonly type="text" class="input-box"  name="task" placeholder="Update The Task">
     	   <input type="date" class="input-box" name="dat"  placeholder="Enter Deadline Date" required>
	   <input type="text" class="input-box" name="stat" placeholder="Enter Status" required>
     	   <input type="submit"  class="save-btn" value="Save"  name="btn">
  	   <hr>
  	   <p class="or">OR</p>
  	   <a href="home.jsp">Cancel</a>
  	</form>
	</div>	
	<%
	if(request.getParameter("btn") != null){
	    SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date dte = format1.parse(request.getParameter("dat"));
	    java.sql.Date Date = new java.sql.Date( dte.getTime() );
	    String stat = request.getParameter("stat");
	    try{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url = "jdbc:mysql://localhost:3306/todoproject";
		String un = "root";
		String pw = "abc456";
		Connection con = DriverManager.getConnection(url, un,pw);
	
		String sql = "update task set date=?,stat=?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setDate(1, Date);
		pst.setString(2, stat);
		pst.executeUpdate();
		out.println("Task Updated");
		con.close();
	    }
	    catch(SQLException e){
		out.println("Issue = " + e);
	    }
	}
	%>
</body> 
</html>