<!DOCTYPE html>
<html>
	<%@ page import="java.io.*" %>
	<%@ page import="java.util.*" %>
	<%@ include file="database.jsp" %>

	<%
		String comRegSite	= "http://vc13.vc.panix.com:22071/project/register_com.jsp";
		String subRegSite 	= "http://vc13.vc.panix.com:22071/project/register_sub.jsp";
		String subSite 		= "http://vc13.vc.panix.com:22071/project/subscriber.jsp";
		
		// FORM INPUT VALIDATION
		String name = 		request.getParameter("name");
		String address = 	request.getParameter("address");
		String city = 		request.getParameter("city");
		String state = 		request.getParameter("state");
		String zip = 		request.getParameter("zip");
		String email = 		request.getParameter("email");
		String username = 	request.getParameter("username");
		String password = 	request.getParameter("password");
		String confirm = 	request.getParameter("confirm");		
		String error = 		"NO_ERROR";
		
		// Handle any verification errors here
		if(name == "")						error = "ERROR_TYPE_NAME_NULL";
		else if(address == "")				error = "ERROR_TYPE_ADDRESS_NULL";
		else if(city == "")					error = "ERROR_TYPE_CITY_NULL";
		else if(state == "")				error = "ERROR_TYPE_STATE_NULL";
		else if(zip == "")					error = "ERROR_TYPE_ZIP_NULL";
		else if(email == "")				error = "ERROR_TYPE_EMAIL_NULL";
		else if(username == "")				error = "ERROR_TYPE_USERNAME_NULL";
		else if(password == "")				error = "ERROR_TYPE_PASSWORD_NULL";
		else if(confirm == "")				error = "ERROR_TYPE_CONFIRM_NULL";
		else if(!password.equals(confirm)) 	error = "ERROR_TYPE_PASSWORD_CONFIRM_NOT_EQUAL";
		
		// Found an error!
		if(error != "NO_ERROR")	response.sendRedirect(subRegSite
		+ "?error=" 	+ error
		);
		
		// IF THERE IS AN ERROR ABOVE, THE BELOW WILL NOT EXECUTE
		
		// SEARCH THROUGH DATABASE TO ENSURE THAT USERNAME DOES NOT ALREADY EXIST
		
		
		// INSERT INTO DATABASE
		
		// COMPANY (NYI)
		
		// SUBSCRIBER
		//setupClientProperties();
		//com.mysql.jdbc.Driver d = new com.mysql.jdbc.Driver();
		//
		//// Build the SQL command to insert into the database
		//String sqlCommand = "INSERT INTO subscriber (name, street_address, city, state, zip, email, login, password) VALUES ("
		//	+ name + ", "
		//	+ address + ", "
		//	+ city + ", "
		//	+ state + ", "
		//	+ zip + ", "
		//	+ email + ", "
		//	+ username + ", "
		//	+ password+ ");";
		//
		//if (sqlCommand != null)
		//{
		//	boolean isQuery = sqlCommand.toUpperCase().startsWith("SELECT");
		//
		//	Connection con = DriverManager.getConnection(url, user, password);
		//	Statement stmt = con.createStatement();
		//	
		//}
		//
		//// For now we redirect to correct site...
		//response.sendRedirect(subSite);
	%>
	
	<head>
	
	</head>
	<body>
		
	</body>
<html>