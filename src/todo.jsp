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
  		<a class="active" href="todo.jsp">ToDo</a>
  		<div class="topnav-right">
			<img style="padding: 0px 24px;"src="User-Ico.png" class="img-fluid">
  	 		<a class="topnav-right" href="user.jsp">User</a>
		</div>
  	</div>
	<div class="todo">
	<form method="ToDo">
  	   <input type="text" class="input-box" name="task"  placeholder="Enter Task" required>
     	   <input type="date" class="input-box" name="dat"  placeholder="Enter Deadline Date" required>
	   <input type="text" class="input-box" name="stat" placeholder="Enter Status" required>
     	   <input type="submit"  class="save-btn" value="Save"  name="btn">
  	   <hr>
  	   <p class="or">OR</p>
  	   <a href="home.jsp">Cancel</a>
  	</form>
	</div>	
	<%-- Get the form data --%>
	<%
	if(request.getParameter("btn") != null){
	    String usr = request.getParameter("un");
	    String task = request.getParameter("task");
    	    String stat = request.getParameter("stat");
    	    String dateInput = request.getParameter("dat");
	    try {
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            String url = "jdbc:mysql://localhost:3306/todoproject";
            String username = "your_mysql_username";
            String password = "your_mysql_password";
            Connection connection = DriverManager.getConnection(url, username, password);

            String sql = "INSERT INTO " + usr + " (task, stat, dat) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, task);
            preparedStatement.setString(2, stat);
            preparedStatement.setString(3, dateInput);

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                out.println("Data inserted successfully!");
            } else {
                out.println("Error: Data not inserted.");
            }

            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    	} else {
    	    out.println("Error: Invalid date format.");
    	}
	%>
</body> 
</html>