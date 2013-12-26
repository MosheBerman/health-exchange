<!DOCTYPE html>
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Register as a <%= request.getParameter("type") %> | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
		<%@ include file="logo.jsp"%>
		<%@ include file="topbar.jsp"%>
			<div>	<!-- Start Login Info -->

				<% 
				if(session.getAttribute("username") != null && session.getAttribute("username") != ""){ 

				%>
					<h1>You're Already Registered!</h1>
					<p class="description">
						We can't let you register twice. That's like having three cell phones.
					</p>
					<%@ include file="redirect.jsp"%>

				<% 
				}
				else
					{ 
				%>
				<div id="register-description">
				<%
						// Only display e-mail when handling subscribers
						if(request.getParameter("type").equals("Subscriber"))
						{
						%>
							<p class="description">
								Are you ready to sell your soul to the health-care devil? Tell us all about yourself, just short of your social insecurity number, and we'll handle the rest. Once you're a <em>subscriber</em>, you'll be good to go.
							</p>
						<%
					}
					else
					{
					%>
					<p class="description">
						Are you ready for world domination? Sign up here to be a <em>provider</em>. We'll need a few, um, details. Yea, that's it. Details.
					</p>
					<%
				}
				%>
			</div>
				<form name="loginForm" action="validate.jsp" method="get" id="registration-form" class="styled-form">					
					<%
						String error = (String) request.getParameter("error");
						error_msg = "";

						if(error != null)
						{
							error_msg = "Error: ";
							if(error.equals("ERROR_TYPE_REGISTER_USERNAME_NULL"))					error_msg += "Username cannot be empty.";
							if(error.equals("ERROR_TYPE_REGISTER_USERNAME_TOO_LONG"))				error_msg += "Username cannot be greater than 20 characters";
							else if(error.equals("ERROR_TYPE_REGISTER_NAME_NULL"))					error_msg += "Name cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_ADDRESS_NULL"))				error_msg += "Address cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_CITY_NULL"))					error_msg += "City cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_STATE_NULL"))					error_msg += "State cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_ZIP_NULL"))					error_msg += "Zip cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_EMAIL_NULL"))					error_msg += "Email cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_PASSWORD_NULL")) 				error_msg += "Password field cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_CONFIRM_NULL")) 				error_msg += "Password confirmation field cannot be empty.";
							else if(error.equals("ERROR_TYPE_REGISTER_PASSWORD_CONFIRM_NOT_EQUAL"))	error_msg += "Password confirmation does not match password.";
							else if(error.equals("ERROR_TYPE_REGISTER_LOGIN_NOT_UNIQUE"))			error_msg += "Login name already exists in the database.";
							else if(error.equals("ERROR_TYPE_REGISTER_ZIP_INVALID"))					error_msg += "Zip code is invalid.";
							else if(error.equals("ERROR_TYPE_REGISTER_EMAIL_INVALID"))				error_msg += "Email is invalid.";
						
							if(!error_msg.equals(""))
							{
								%>
								<p class="error-text"> <%= error_msg %> </p>
								<%
							}
						}
					%>
					
					<input type="text" name="name" placeholder="Name">					
					<input type="text" name="address" placeholder="Address">			
					<input type="text" name="city" placeholder="City">					
					<input type="text" name="state" placeholder="State"> 				
					<input type="text" name="zip" placeholder="ZIP">				
					<%
						// Only display e-mail when handling subscribers
						if(request.getParameter("type").equals("Subscriber"))
						{
						%>
						<input type="text" name="email" placeholder="Email">			
						<%
						}
					%>
					<input type="text" name="username" placeholder="Username">				
					<input type="password" name="pwd" placeholder="Password">				
					<input type="password" name="confirm" placeholder="Confirm Password">	
					<input type="hidden" name="formname" value="registration">
					<input type="hidden" name="type" value=<%=request.getParameter("type")%>>
					<input type="submit" value="Submit" class="big-orange-button">
				</form>
			</div>	<!-- End Login Info -->

	<%

}
			%>
		</div>
	</body>
</html>