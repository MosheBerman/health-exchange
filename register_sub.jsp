<!DOCTYPE html>
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Registration Page - Subscriber</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<%@ include file="topbar.jsp"%>
		<div>
			<div>	<!-- Start Login Info -->
				<form name="loginForm" action="authenticate_registration.jsp" method="get">
					<!-- Hidden form data to specify what type of registration this is -->
					<input type="hidden" name="subscriber_register">
					
					<%
						String error = (String) request.getParameter("error");
						String error_msg = "";

						if(error != null)
						{
							error_msg = "Error: ";
							if(error.equals("ERROR_TYPE_USERNAME_NULL"))					error_msg += "Username cannot be empty.";
							else if(error.equals("ERROR_TYPE_NAME_NULL"))					error_msg += "Name cannot be empty.";
							else if(error.equals("ERROR_TYPE_ADDRESS_NULL"))				error_msg += "Address cannot be empty.";
							else if(error.equals("ERROR_TYPE_CITY_NULL"))					error_msg += "City cannot be empty.";
							else if(error.equals("ERROR_TYPE_STATE_NULL"))					error_msg += "State cannot be empty.";
							else if(error.equals("ERROR_TYPE_ZIP_NULL"))					error_msg += "Zip cannot be empty.";
							else if(error.equals("ERROR_TYPE_EMAIL_NULL"))					error_msg += "Email cannot be empty.";
							else if(error.equals("ERROR_TYPE_PASSWORD_NULL")) 				error_msg += "Password field cannot be empty.";
							else if(error.equals("ERROR_TYPE_CONFIRM_NULL")) 				error_msg += "Password confirmation field cannot be empty.";
							else if(error.equals("ERROR_TYPE_PASSWORD_CONFIRM_NOT_EQUAL"))	error_msg += "Password confirmation does not match password.";
						
							if(!error_msg.equals(""))
							{
								%>
								<p class="error_text"> <%= error_msg %> </p>
								<%
							}
						}
					%>
					
					Name: 		<input type="text" name="name">			<br/>
					Address:	<input type="text" name="address">	<br/>
					City:		<input type="text" name="city">			<br/>
					State:		<input type="text" name="state"> 		<br/>
					Zip:		<input type="text" name="zip">			<br/>
					E-mail:		<input type="text" name="email">		<br/>
					Username:	<input type="text" name="username" id="username" value= <%= username %>>	<br/>
					Password:	<input type="password" name="password" id="password">	<br/>
					Confirm Password:	<input type="password" name="confirm" id="confirm">	<br/>
					
					<input type="submit" value="Submit">
				</form>
			</div>	<!-- End Login Info -->
		</div>
	</body>
</html>