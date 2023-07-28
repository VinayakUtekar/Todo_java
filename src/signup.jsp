<%@  page import="java.sql.*" %>
<%@  page import="javax.mail.*" %>
<%@  page import="javax.mail.internet.*" %>
<%@  page import="javax.activation.*" %>
<%@  page import="java.util.*" %>

<html>
<head>
  <title> ToDo Project </title>
  <style>
	body{
	    margin: 0;
	    padding: 0;
	    font-family: sans-serif;
	    background-image: url(background.jpg);
	    background-size: cover;
	    background-position: center;
	}
	.h1{
	    color: black;
	    padding: 20px; 
	}
	.signup-form{
		width: 300px;
	  	  box-shadow: 0 0 3px 0 rgba(0,0,0,0.3);
	  	  background: white;
	  	  padding: 10px;
	  	  margin: 5% auto 0;
	  	  text-align: center;	  
		border-radius: 20px;
	}
	.login-form h1{
		color: #1c8adb;
		margin-bottom: 30px;
	}
	.input-box{
		padding: 10px;
		margin: 10px 0;
		width: 100%;
		border: 1px solid #999;
		outline: none;
	}
	a{
		text-decoration: none;
	}
	.or{
		background: #fff;
		width: 30px;
		margin: -19px auto 10px;
	}
	img{
		width : 70px;
		margin-top: -50px;
		border-radius: 35px;	
	}
	.signup-btn{
		background-color: #1c8adb;
		width: 100%;
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
  <div class="signup-form">
  <img src="User-Ico.png">
  <h1> Sign-up Page </h1>
  <form method="POST">
     <input type="text" class="input-box" name="un"  placeholder="Enter username" required>
     <input type="email" class="input-box" name="em"  placeholder="Enter your Email" required>
     <input type="password" class="input-box" name="pw1" placeholder="Enter Password" required>
     <input type="password" class="input-box" name="pw2" placeholder="Confirm Password" required>
     <input type="submit"  class="signup-btn" value="Sign-UP"  name="btn">
     <hr>
     <p class="or">OR</p>
     <a href="index.jsp">Already Registered ???</a>
  </form>
  </div>	
  <%
    if(request.getParameter("btn") != null){
	String usr = request.getParameter("un");
	String pw1 = request.getParameter("pw1");
	String pw2 = request.getParameter("pw2");
	String em =  request.getParameter("em");
	if(pw1.equals(pw2)){
	   try{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());

		String url = "jdbc:mysql://localhost:3306/todoproject";
		String un = "root";
		String pw = "abc456";

		Connection con = DriverManager.getConnection(url,un,pw);

		String sql1 = "select * from users where username = ?";
		PreparedStatement pst1 = con.prepareStatement(sql1);
		pst1.setString(1, usr);
		ResultSet rs1 = pst1.executeQuery();
		if(rs1.next()){
			out.println(usr + "  already registered");
		}
		else{
		String sql2 = "insert into users values (?, ?, ?)";
		PreparedStatement pst2 = con.prepareStatement(sql2);

		pst2.setString(1, usr);
		pst2.setString(2, pw1);
		pst2.setString(3, em);
		pst2.executeUpdate();

		String sql3 = "CREATE TABLE IF NOT EXISTS " + usr + " (task varchar(30),status varchar(20), eventdate varchar(30))";
            	PreparedStatement pst3 = con.prepareStatement(sql3); 
            	pst3.executeUpdate();
 %>
	<script>
		alert("Congrulation "+ usr + "  for your registeration");
	</script>
 <%
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
			msg.setText("Congrats for your subscription");
			msg.setFrom(new InternetAddress("vinayakutekar0@gmail.com"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(em));
			Transport.send(msg);
		}
		catch(Exception e){
			out.println("Issues = "+ e);
		}
		}
		con.close();
	}
	catch(SQLException e){
		out.println("issue " + e);
	}
	}
	else{		
		out.println("Password did not match");
	}
 	}
  %>
</center>
</body>
</html>