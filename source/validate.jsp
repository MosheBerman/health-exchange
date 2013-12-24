<!DOCTYPE html>
<html>
	<%@ page import="java.io.*" %>
	<%@ page import="java.util.*" %>
	<%@ include file="database.jsp" %>
	<%
		String form_name = request.getParameter("formname");
		
		// Which form is this?
		if(form_name != null)
		{
			// Site Registration
			if(form_name.equals("registration"))
			{
				String regSite 	= "http://vc13.vc.panix.com:22071/project/register.jsp";
				String subSite 	= "http://vc13.vc.panix.com:22071/project/subscriber.jsp";
				String comSite 	= "http://vc13.vc.panix.com:22071/project/company.jsp";
				
				// FORM INPUT VALIDATION
				String type = 		request.getParameter("type");
				String name = 		request.getParameter("name");
				String address = 	request.getParameter("address");
				String city = 		request.getParameter("city");
				String state = 		request.getParameter("state");
				String zip = 		request.getParameter("zip");
				String email = 		request.getParameter("email");
				String username = 	request.getParameter("username");
				String pwd = 		request.getParameter("pwd");
				String confirm = 	request.getParameter("confirm");		
				String error = 		"NO_ERROR";
				
				// Handle any verification errors here
				// I would prefer error be an enum, but let's not worry about that...like ever...
				if(name == "")									error = "ERROR_TYPE_NAME_NULL";
				else if(address == "")							error = "ERROR_TYPE_ADDRESS_NULL";
				else if(city == "")								error = "ERROR_TYPE_CITY_NULL";
				else if(state == "")							error = "ERROR_TYPE_STATE_NULL";
				else if(zip == "")								error = "ERROR_TYPE_ZIP_NULL";
				else if(email == "" && type == "Subscriber")	error = "ERROR_TYPE_EMAIL_NULL";
				else if(username == "")							error = "ERROR_TYPE_USERNAME_NULL";
				else if(username.length() > 20)					error = "ERROR_TYPE_USERNAME_TOO_LONG";
				else if(pwd == "")								error = "ERROR_TYPE_PASSWORD_NULL";
				else if(confirm == "")							error = "ERROR_TYPE_CONFIRM_NULL";
				else if(!pwd.equals(confirm)) 					error = "ERROR_TYPE_PASSWORD_CONFIRM_NOT_EQUAL";
					
				setupClientProperties();
				com.mysql.jdbc.Driver d = new com.mysql.jdbc.Driver();
				
				// SQL command to make sure we don't accidentally have duplicate logins
				
				String sqlCommand = "select * from company where login='" + username + "'";

				Connection con = DriverManager.getConnection(url, user, password);
				Statement stmt = con.createStatement();
				
				// Run twice - check company and subscriber tables
				try
				{
					ResultSet results = stmt.executeQuery(sqlCommand);
					
					// is the result set NOT empty? (something in company had this login already...)
					if(results.next())
					{
						error = "ERROR_TYPE_LOGIN_NOT_UNIQUE";
					}
				}
				catch (SQLException sqle)
				{
					out.println(sqle.getMessage() + "Query failed... possibly invalid?");
				}
				
				// Check subscriber if company lookup succeeded
				if(error == "NO_ERROR")
				{
					sqlCommand = "select * from subscriber where login='" + username + "'";

					// Run twice - check company and subscriber tables
					try
					{
						ResultSet results = stmt.executeQuery(sqlCommand);
						
						// is the result set NOT empty? (something in subscriber had this login already...)
						if(results.next())
						{
							error = "ERROR_TYPE_LOGIN_NOT_UNIQUE";
						}
					}
					catch (SQLException sqle)
					{
						out.println(sqle.getMessage() + "Query failed... possibly invalid?");
					}
				}	
				
				// Found an error!
				if(error != "NO_ERROR")	response.sendRedirect(regSite + "?type=" + type + "&error=" + error);
				
				////////////////////////////////////////////////////////////
				// IF THERE IS AN ERROR ABOVE, THE BELOW WILL NOT EXECUTE //
				////////////////////////////////////////////////////////////
				
				// Build the SQL command to insert into the database
				sqlCommand = "";
				
				if(type.equals("Subscriber"))
				{
					sqlCommand = "INSERT INTO subscriber (name, street_address, city, state, zip, email, login, password) VALUES ('"
						+ name 		+ "', '"
						+ address 	+ "', '"
						+ city 		+ "', '"
						+ state 	+ "', '"
						+ zip 		+ "', '"
						+ email 	+ "', '"
						+ username 	+ "', '"
						+ pwd 		+ "');";
				}
				else if(type.equals("Company"))
				{
					sqlCommand = "INSERT INTO company (name, street_address, city, state, zip, login, password) VALUES ('"
						+ name 		+ "', '"
						+ address 	+ "', '"
						+ city 		+ "', '"
						+ state 	+ "', '"
						+ zip 		+ "', '"
						+ username 	+ "', '"
						+ pwd 		+ "');";
				}
				
				boolean success = false;
				
				if (sqlCommand != null)
				{			
					try
					{
						int row = stmt.executeUpdate(sqlCommand);
						out.println("Registration complete.");
						success = true;
					}
					catch (SQLException sqle)
					{
						String err_msg = sqle.getMessage();
						out.println(sqle.getMessage() + "Update failed... possibly invalid?");
						success = true;
					}
				}
				
				if(success)
				{
					// Setting the attribute will log us in
					session.setAttribute("username", username);
					session.setAttribute("username_type", type.toLowerCase());
					
					if(type.equals("Subscriber"))
					{
						response.sendRedirect(subSite);
					}
					else if(type.equals("Company"))
					{
						response.sendRedirect(comSite);
					}
				}
			}
			
			// Site Log-In
			else if(form_name.equals("signin"))
			{
				setupClientProperties();
				com.mysql.jdbc.Driver d = new com.mysql.jdbc.Driver();
				
				String username = (String) request.getParameter("username");
				String pwd = (String) request.getParameter("pwd");
				boolean bSuccess = false;
				String error = "NO_ERROR";
				
				if(username == "")		error = "ERROR_TYPE_USER_NULL";
				else if(pwd == "")	error = "ERROR_TYPE_PWD_NULL";
				
				if(!error.equals("NO_ERROR")) response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				
				String sqlComCommand 	= "select * from company where login='" + username + "' and password='" + pwd + "'";
				String sqlSubCommand 	= "select * from subscriber where login='" + username + "' and password='" + pwd + "'";
				
				Connection con = DriverManager.getConnection(url, user, password);
				Statement stmt = con.createStatement();
				
				// Company
				try
				{
					ResultSet results = stmt.executeQuery(sqlComCommand);
					
					// Found results!
					if(results.next())
					{
						bSuccess = true;
						
						// Set this session type as company
						session.setAttribute("username_type", "company");
					}
				}
				catch (SQLException sqle)
				{
					out.println(sqle.getMessage() + "Query failed... possibly invalid?");
				}
				
				// Subscriber
				if(!bSuccess)
				{
					try
					{
						ResultSet results = stmt.executeQuery(sqlSubCommand);
						
						// Found results!
						if(results.next())
						{
							bSuccess = true;
							
							// Set this session type as subscriber
							session.setAttribute("username_type", "subscriber");
						}
					}
					catch (SQLException sqle)
					{
						out.println(sqle.getMessage() + "Query failed... possibly invalid?");
					}
				}
				
				if(bSuccess)
				{
					// Log us in and return us to where we came from.
					session.setAttribute("username", username);
					response.sendRedirect(request.getParameter("from_url"));
				}
				else
				{
					error = "ERROR_TYPE_LOGIN_FAILED";
					response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				}
			}
		
			// Adding a plan
			else if(form_name.equals("add_plan"))
			{
				setupClientProperties();
				com.mysql.jdbc.Driver d = new com.mysql.jdbc.Driver();
				
				String plan_name = (String) request.getParameter("plan_name");
				boolean bSuccess = true;
				String error = "NO_ERROR";
				
				if(plan_name == "")		error = "ERROR_TYPE_PLAN_NAME_NULL";
			
				if(!error.equals("NO_ERROR")) response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
			
				String sqlCommand = "select * from plan where name='" + plan_name + "'";
				
				out.println(sqlCommand);
				
				Connection con = DriverManager.getConnection(url, user, password);
				Statement stmt = con.createStatement();
				
				// Company
				try
				{
					ResultSet results = stmt.executeQuery(sqlCommand);
					
					// Found results!
					if(results.next())
					{
						bSuccess = false;
					}
				}
				catch (SQLException sqle)
				{
					out.println(sqle.getMessage() + "Query failed... possibly invalid?");
				}
				
				if(bSuccess)
				{
					// Add the plan to the database, and then ???
					sqlCommand = "INSERT INTO plan (name) VALUES ('"
							+ plan_name + "');";
					
					out.println(sqlCommand);
					
					boolean success = false;
					
					if (sqlCommand != null)
					{			
						try
						{
							int row = stmt.executeUpdate(sqlCommand);
							success = true;
						}
						catch (SQLException sqle)
						{
						
						}
					}
					
					if(success)
					{
						// Go back to whence we came!
						response.sendRedirect(request.getParameter("from_url"));
					}
				}
				else
				{
					error = "ERROR_TYPE_ADD_PLAN_FAILED";
					response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				}
			}
			// Adding offering to plan
			else if(form_name.equals("add_offering"))
			{
			
			}
			// Add coverage to plan
			else if(form_name.equals("add_coverage"))
			{
			
			}
			// Add discount to offering
			else if(form_name.equals("add_discount"))
			{
			
			}
		}	
		// form_name != null
	%>
	<head>
	</head>
	<body>
	</body>
</html>