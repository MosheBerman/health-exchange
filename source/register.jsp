<!DOCTYPE html>
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Registration Page - <%= request.getParameter("type") %></title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div>
			<div>	<!-- Start Login Info -->
				<form name="loginForm" action="validate.jsp" method="get">					
					<%
						String error = (String) request.getParameter("error");
						String error_msg = "";

						if(error != null)
						{
							error_msg = "Error: ";
							if(error.equals("ERROR_TYPE_USERNAME_NULL"))					error_msg += "Username cannot be empty.";
							if(error.equals("ERROR_TYPE_USERNAME_TOO_LONG"))				error_msg += "Username cannot be greater than 20 characters";
							else if(error.equals("ERROR_TYPE_NAME_NULL"))					error_msg += "Name cannot be empty.";
							else if(error.equals("ERROR_TYPE_ADDRESS_NULL"))				error_msg += "Address cannot be empty.";
							else if(error.equals("ERROR_TYPE_CITY_NULL"))					error_msg += "City cannot be empty.";
							else if(error.equals("ERROR_TYPE_STATE_NULL"))					error_msg += "State cannot be empty.";
							else if(error.equals("ERROR_TYPE_ZIP_NULL"))					error_msg += "Zip cannot be empty.";
							else if(error.equals("ERROR_TYPE_EMAIL_NULL"))					error_msg += "Email cannot be empty.";
							else if(error.equals("ERROR_TYPE_PASSWORD_NULL")) 				error_msg += "Password field cannot be empty.";
							else if(error.equals("ERROR_TYPE_CONFIRM_NULL")) 				error_msg += "Password confirmation field cannot be empty.";
							else if(error.equals("ERROR_TYPE_PASSWORD_CONFIRM_NOT_EQUAL"))	error_msg += "Password confirmation does not match password.";
							else if(error.equals("ERROR_TYPE_LOGIN_NOT_UNIQUE"))			error_msg += "Login name already exists in the database.";
						
							if(!error_msg.equals(""))
							{
								%>
								<p class="error_text"> <%= error_msg %> </p>
								<%
							}
						}
					%>
					
					Name: 		<input type="text" name="name">					<br/>
					Address:	<input type="text" name="address">				<br/>
					City:		<input type="text" name="city">					<br/>
					State:		<input type="text" name="state"> 				<br/>
					Zip:		<input type="text" name="zip">					<br/>
					<%
						// Only display e-mail when handling subscribers
						if(request.getParameter("type").equals("Subscriber"))
						{
						%>
						E-mail:		<input type="text" name="email">			<br/>
						<%
						}
					%>
					Username:	<input type="text" name="username">				<br/>
					Password:	<input type="password" name="pwd">				<br/>
					Confirm Password:	<input type="password" name="confirm">	<br/>
					<input type="hidden" name="formname" value="registration">
					<input type="hidden" name="type" value=<%=request.getParameter("type")%>>
					<input type="submit" value="Submit">
				</form>
			</div>	<!-- End Login Info -->
		</div>
	</body>
</html>