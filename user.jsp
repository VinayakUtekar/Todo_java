<%@  page import="java.sql.*" %>
<%@  page import="javax.mail.*" %>
<%@  page import="javax.mail.internet.*" %>
<%@  page import="javax.activation.*" %>
<%@  page import="java.util.*" %>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title> ToDo Application</title>
	<style>
	body{
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
	  background-color: #ddd;
	  color: black;
	}
	.topnav-right {
		  float: right;
	}
	.topnav-right a.active {
	  background-color: #04AA6D;
	  color: black;
	}
	.dark-mode {
  		background-color: black;
  		color: white;
		.nav { background-color:white;	}
	}
	.img-fluid{
    		width: 46px;
    		height: 46px;
    		border-radius: 50%;
    		overflow: hidden;
    		margin-top: 4px;
	}
	.reset{
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
	.rst-btn{
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
  		<a href="todo.jsp">ToDo</a>
  		<div class="topnav-right">
			<img style=" padding: 0px 24px;"src="User-Ico.png" class="img-fluid">
  	 		<a class="active" class="topnav-right" href="user.jsp">User</a>
		</div>
  	</div>
	<div class="reset">
	<form method="Reset">
  	   <label>User Name   : </label><input type="text" class="input-box" name="un"  placeholder="Enter username" required>
     	   <label>Enter  Email: </label><input type="email" class="input-box" name="em"  placeholder="Enter your Email" required>
	   <label>Old Password: </label><input type="password" class="input-box" name="pw1" placeholder="Enter Old Password" required>
     	   <label>New Password: </label><input type="password" class="input-box" name="pw2" placeholder="Enter New Password" required>
       	   <label>Confirm : </label><input type="password" class="input-box" name="pw3" placeholder="Confirm New Password" required>
     	   <input type="submit"  class="rst-btn" value="Reset"  name="btn">
  	   <hr>
  	   <p class="or">OR</p>
  	   <a href="home.jsp">Cancel</a>
  	</form>
	</div>
  <%
	if(request.getParameter("btn") != null){
	String usr = request.getParameter("un");
	String pw1 = request.getParameter("pw1");
	String pw2 = request.getParameter("pw2");
	String pw3 = request.getParameter("pw3");
	String em =  request.getParameter("em");
	try{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url = "jdbc:mysql://localhost:3306/todoproject";
		String un = "root";
		String pw = "abc456";
		Connection con = DriverManager.getConnection(url,un,pw);
		String sql1 = "select * from users where email = ?";
		PreparedStatement pst1 = con.prepareStatement(sql1);
		pst1.setString(1, em);
		ResultSet rs1 = pst1.executeQuery();
		if(rs1.next()){
			if(pw2.equals(pw3)){
				String sql2 = "update users set name=?, password=? where email=?";
				PreparedStatement pst2 = con.prepareStatement(sql2);
				pst2.setString(1, usr);
				pst2.setString(2, pw3);
				pst2.setString(3, em);
				pst2.executeUpdate();
				out.println(usr + "  details updated");
				//mail will come from
				Properties p = System.getProperties();
				p.put("mail.smtp.host", "smtp.gmail.com");
				p.put("mail.smtp.port", 587);
				p.put("mail.smtp.auth", true);
				p.put("mail.smtp.starttls.enable", true);
				//email authentication
				Session ms = Session.getInstance(p, new Authenticator(){
					public PasswordAuthentication getPasswordAuthentication(){
						String un = "vinayakutekar0@gmail.com";
						String pw = "mbjskdovrlcanion";
						return new PasswordAuthentication(un, pw);
					}
				});
				try{
					//mail drafting and sending
					MimeMessage msg = new MimeMessage(ms);
					msg.setSubject("Mail from Vinayak Utekar");
					msg.setText("User Details Updated");
					msg.setFrom(new InternetAddress("vinayakutekar0@gmail.com"));
					msg.addRecipient(Message.RecipientType.TO, new InternetAddress(em));
					Transport.send(msg);
				}
				catch(Exception e){
					out.println("Issues = "+ e);
				}
			}
			else{		
				out.println("Password did not match");
			}
		}
		else{
			out.println(" Invalid Email");
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