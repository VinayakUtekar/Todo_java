<%@ page import="java.sql.*" %>
<html>
<head>
<title> ToDo Application</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="login-form">
        <img src="User-Ico.png">
	<h1>Login Page </h1>
	<form method="POST">
     	  <input type="text"  class="input-box" name="un"  placeholder="Enter username" required>
     	  <input type="password"  class="input-box" name="pw" placeholder="Enter Password" required>
     	  <p><span><input type="checkbox"></span>I agree to the terms of services</p>
     	  <input type="submit" class="login-btn" value="Login"  name="btn">
	  <hr>
	  <p class="or">OR</p>
  	  <a href="signup.jsp">New User </a>
  	</form>
    </div>
    <%
    	if(request.getParameter("btn") != null){
	try{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());

		String url = "jdbc:mysql://localhost:3306/todoproject";
		String un = "root";
		String pw = "abc456";

		Connection con = DriverManager.getConnection(url,un,pw);

		String sql = "select * from users where name = ? and password = ?";
		PreparedStatement pst = con.prepareStatement(sql);
		String username = request.getParameter("un"); 
		String password = request.getParameter("pw");
		pst.setString(1, username);
		pst.setString(2, password);
		ResultSet rs = pst.executeQuery();
		if(rs.next()){
			request.getSession().setAttribute("user", username);
			response.sendRedirect("home.jsp");
		}
		else{
			out.println("Invalid Input");
		}
		con.close();
	}
	catch(SQLException e){
		out.println("issue " + e);
    	} 
   	}   
    %>
</body> 
</html>