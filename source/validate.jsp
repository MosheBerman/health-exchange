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
				String type = 		(String) request.getParameter("type");
				String name = 		(String) request.getParameter("name");
				String address = 	(String) request.getParameter("address");
				String city = 		(String) request.getParameter("city");
				String state = 		(String) request.getParameter("state");
				String zip = 		(String) request.getParameter("zip");
				String email = 		(String) request.getParameter("email");
				String username = 	(String) request.getParameter("username");
				String pwd = 		(String) request.getParameter("pwd");
				String confirm = 	(String) request.getParameter("confirm");		
				String error = 		"NO_ERROR";
				
				// Handle any verification errors here
				// I would prefer error be an enum, but let's not worry about that...like ever...
				if(name.isEmpty())										error = "ERROR_TYPE_REGISTER_NAME_NULL";
				else if(address.isEmpty())								error = "ERROR_TYPE_REGISTER_ADDRESS_NULL";
				else if(city.isEmpty())									error = "ERROR_TYPE_REGISTER_CITY_NULL";
				else if(state.isEmpty())								error = "ERROR_TYPE_REGISTER_STATE_NULL";
				else if(zip.isEmpty())									error = "ERROR_TYPE_REGISTER_ZIP_NULL";
				else if(zip.length() > 5)								error = "ERROR_TYPE_REGISTER_ZIP_INVALID";
				else if(email.isEmpty() && type.equals("Subscriber"))	error = "ERROR_TYPE_REGISTER_EMAIL_NULL";
				else if(!email.contains("@"))							error = "ERROR_TYPE_REGISTER_EMAIL_INVALID";
				else if(username.isEmpty())								error = "ERROR_TYPE_REGISTER_USERNAME_NULL";
				else if(username.length() > 20)							error = "ERROR_TYPE_REGISTER_USERNAME_TOO_LONG";
				else if(pwd.isEmpty())									error = "ERROR_TYPE_REGISTER_PASSWORD_NULL";
				else if(confirm.isEmpty())								error = "ERROR_TYPE_REGISTER_CONFIRM_NULL";
				else if(!pwd.equals(confirm)) 							error = "ERROR_TYPE_REGISTER_PASSWORD_CONFIRM_NOT_EQUAL";
				
				// Additional error evaluation
				if(error.equals("NO_ERROR"))
				{
					try	{
						Integer.parseInt(zip);
					}
					catch(NumberFormatException e)	{
						error = "ERROR_TYPE_REGISTER_INVALID_ZIP";
					}
				}
				
				if(!error.equals("NO_ERROR"))
				{
					response.sendRedirect(regSite + "?type=" + type + "&error=" + error);
				}				
				
				Statement comStmt = con.createStatement();
				Statement subStmt = con.createStatement();
				Statement addStmt = con.createStatement();
				
				ResultSet rs_com = comStmt.executeQuery("select * from company where login=\"" + username + "\"");
				ResultSet rs_sub = subStmt.executeQuery("select * from subscriber where login=\"" + username + "\"");
				
				// check company for existing login
				if(rs_com.next() || rs_sub.next())
				{
					error = "ERROR_TYPE_REGISTER_LOGIN_NOT_UNIQUE";
				}
				
				// Found an error!
				if(!error.equals("NO_ERROR"))
				{
					response.sendRedirect(regSite + "?type=" + type + "&error=" + error + "&spc=found_error");
				}
				else
				{
					// Build the SQL command to insert into the database
					String sqlCommand = "";
					
					if(type.equals("Subscriber"))
					{
						sqlCommand = "INSERT INTO subscriber (name, street_address, city, state, zip, email, login, password) VALUES (\""
							+ name 		+ "\", \""
							+ address 	+ "\", \""
							+ city 		+ "\", \""
							+ state 	+ "\", \""
							+ zip 		+ "\", \""
							+ email 	+ "\", \""
							+ username 	+ "\", \""
							+ pwd 		+ "\");";
					}
					else if(type.equals("Company"))
					{
						sqlCommand = "INSERT INTO company (name, street_address, city, state, zip, login, password) VALUES (\""
							+ name 		+ "\", \""
							+ address 	+ "\", \""
							+ city 		+ "\", \""
							+ state 	+ "\", \""
							+ zip 		+ "\", \""
							+ username 	+ "\", \""
							+ pwd 		+ "\");";
					}
					
					boolean success = false;
												
					int row = addStmt.executeUpdate(sqlCommand);
					
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
				
				String username = (String) request.getParameter("username");
				String pwd = (String) request.getParameter("pwd");
				boolean bSuccess = false;
				String error = "NO_ERROR";
				
				String redirectAddress = request.getParameter("from_url");
				
				// Fixes a bug
				if(redirectAddress.isEmpty() || redirectAddress.contains("register.jsp"))
				{
					redirectAddress = "http://vc13.vc.panix.com:22071/project/index.jsp";
				}
				
				if(username == "")	error = "ERROR_TYPE_USER_NULL";
				else if(pwd == "")	error = "ERROR_TYPE_PWD_NULL";
				
				if(!error.equals("NO_ERROR")) response.sendRedirect(redirectAddress + "?error=" + error);
				
				String sqlComCommand 	= "select * from company where login=\"" + username + "\" and password=\"" + pwd + "\"";
				String sqlSubCommand 	= "select * from subscriber where login=\"" + username + "\" and password=\"" + pwd + "\"";
				
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
					response.sendRedirect(redirectAddress);
				}
				else
				{
					session.setAttribute("username", null);
					error = "ERROR_TYPE_LOGIN_FAILED";
					response.sendRedirect(redirectAddress + "?error=" + error);
				}
			}
		
			// Adding a plan
			else if(form_name.equals("add_plan"))
			{	
				String plan_name = (String) request.getParameter("planname");
				plan_name = plan_name.replaceAll("_", " ");
				plan_name = plan_name.replaceAll("\"", "");
				boolean bSuccess = true;
				String error = "NO_ERROR";
				
				if(plan_name == null || plan_name.isEmpty())		error = "ERROR_TYPE_PLAN_NAME_NULL";
			
				if(!error.equals("NO_ERROR")) response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				else
				{	
					Statement stmt = con.createStatement();
					
					ResultSet results = stmt.executeQuery("select * from plan where name=\"" + plan_name + "\"");
					
					// Don't want to find results, this means a plan has already been inserted
					if(!results.next())
					{
						int row = stmt.executeUpdate("INSERT INTO plan (name) VALUES (\"" + plan_name + "\");");

						response.sendRedirect(request.getParameter("from_url"));
					}
					else
					{
						error = "ERROR_TYPE_ADD_PLAN_FAILED";
						response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
					}
				}
			}
			// Adding offering to plan
			else if(form_name.equals("add_offering"))
			{
				String plan_name 	= (String) request.getParameter("planname");
				plan_name = plan_name.replaceAll("_", " ");
				
				String error = "NO_ERROR";
				
				Integer price, deductible;
				
				if(request.getParameter("price") == null || request.getParameter("price").isEmpty())				error = "ERROR_OFFERING_PRICE_NULL";
				else if(request.getParameter("deductible") == null || request.getParameter("deductible").isEmpty())	error = "ERROR_OFFERING_DEDUCTIBLE_NULL";
				
				if(!error.equals("NO_ERROR"))
				{
					response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				}
				else
				{
					price 		= Integer.parseInt(request.getParameter("price"));
					deductible 	= Integer.parseInt(request.getParameter("deductible"));
					
					Statement stmt = con.createStatement();
					
					ResultSet results = stmt.executeQuery("select * from company where login=\"" + session.getAttribute("username") + "\";");
					results.first();
					
					Integer company_id = Integer.parseInt(results.getString("company_id"));
					
					// Check to see if a valid plan
					String sqlCommand = "select * from plan where name=\"" + plan_name + "\"";
					results = stmt.executeQuery(sqlCommand);
					
					// Did not find results. Don't add coverage to a null plan.
					if(!results.next())
					{
						error = "ERROR_TYPE_OFFERING_PLAN_NOT_EXIST";
						response.sendRedirect(request.getParameter("from_url") + "?error=" + error+ "&"+ plan_name);
					}
					else
					{				
						results = stmt.executeQuery("select * from plan where name = \"" + plan_name + "\";");
						results.first();
						int plan_id = Integer.parseInt(results.getString("plan_id"));
						
						sqlCommand = "INSERT INTO offering (plan_id, company_id, price, deductible) VALUES (" + plan_id + ", " + company_id + ", " + price + ", " + deductible + ");";
								
						// Database command: Insert the coverage into coverage table.
						int row = stmt.executeUpdate(sqlCommand);
						
						response.sendRedirect(request.getParameter("from_url"));
					}
				}
			}
			// Add coverage to plan
			else if(form_name.equals("add_coverage"))
			{
				String plan_name = (String) request.getParameter("planname");
				plan_name = plan_name.replaceAll("_", " ");
				
				String condition = (String) request.getParameter("condition");
				boolean bSuccess = true;
				String error = "NO_ERROR";
				
				if(plan_name.isEmpty())			error = "ERROR_TYPE_COVERAGE_PLAN_NAME_NULL";
				else if(condition.isEmpty())	error = "ERROR_TYPE_COVERAGE_CONDITION_NAME_NULL";
				
				if(!error.equals("NO_ERROR"))
				{
					response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				}
				else
				{
					Statement stmt = con.createStatement();
	
					ResultSet results = stmt.executeQuery("select * from plan where name=\"" + plan_name + "\"");
					
					// Did not find results. Don't add coverage to a null plan.
					if(!results.next())
					{
						error = "ERROR_TYPE_COVERAGE_PLAN_NOT_EXIST";
						response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
					}
					else
					// Query succeeded: plan is valid and does exist in the database
					{				
						results = stmt.executeQuery("select * from plan where name = \"" + plan_name + "\";");
						results.first();
						int plan_id = Integer.parseInt(results.getString("plan_id"));
								
						// Database command: Insert the coverage into coverage table.
						int row = stmt.executeUpdate("INSERT INTO coverage (plan_id, cond) VALUES (" + plan_id + ", \"" + condition + "\");");
						
						response.sendRedirect(request.getParameter("from_url"));
					}
				}
			}
			// Add discount to offering
			else if(form_name.equals("add_discount"))
			{
				Integer offering_id	= Integer.parseInt(request.getParameter("offeringname"));
				
				Integer discount, months;
				
				String error = "NO_ERROR";
				
				if(request.getParameter("discount") == null || request.getParameter("discount").isEmpty())	error = "ERROR_DISCOUNT_DISCOUNT_NULL";
				else if(request.getParameter("months") == null || request.getParameter("months").isEmpty())	error = "ERROR_DISCOUNT_MONTHS_NULL";
				
				if(error.equals("NO_ERROR"))
				{
					try	{
						Integer.parseInt(request.getParameter("discount"));
						Integer.parseInt(request.getParameter("months"));
					}
					catch (NumberFormatException e)	{
						error = "ERROR_DISCOUNT_INVALID_INTEGER";
					}
				}

				
				if(!error.equals("NO_ERROR"))
				{
					response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				}
				else
				{					
					discount = Integer.parseInt(request.getParameter("discount"));
					months = Integer.parseInt(request.getParameter("months"));
				
					Statement stmt = con.createStatement();
					
					Integer company_id = 0;
					
					// Get the company_id from the login.
					ResultSet results = stmt.executeQuery("select * from company where login=\"" + session.getAttribute("username") + "\";");
					results.first();
					company_id = Integer.parseInt(results.getString("company_id"));
					
					// Add the discount....
					int row = stmt.executeUpdate("INSERT INTO discount (offering_id, discount, months) VALUES (" + offering_id + ", " + discount + ", " + months + ")");
					response.sendRedirect(request.getParameter("from_url"));
				}
			}
			// add subscription
			else if(form_name.equals("add_subscription"))
			{
				Integer offering_id	= Integer.parseInt(request.getParameter("offeringname"));
				
				Integer paid, months, subscriber_id;
				
				Statement stmt = con.createStatement();
				ResultSet results = stmt.executeQuery("select * from offering where offering_id=" + offering_id);
				results.first();
				Integer deductible = Integer.parseInt(results.getString("deductible"));
				
				String error = "NO_ERROR";
				
				if(request.getParameter("paid") == null || request.getParameter("paid").isEmpty())			error = "ERROR_SUBSCRIPTION_PAID_NULL";
				else if(request.getParameter("months") == null || request.getParameter("months").isEmpty())	error = "ERROR_SUBSCRIPTION_MONTHS_NULL";
				
				if(error.equals("NO_ERROR"))
				{
					try	{
						Integer.parseInt(request.getParameter("paid"));
						Integer.parseInt(request.getParameter("months"));
					}
					catch (NumberFormatException e)	{
						error = "ERROR_DISCOUNT_INVALID_INTEGER";
					}
				}
				
				if(!error.equals("NO_ERROR"))
				{
					response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
				}
				else
				{
					paid = Integer.parseInt(request.getParameter("paid"));
					months = Integer.parseInt(request.getParameter("months"));
					
					if(paid < deductible)	error = "ERROR_SUBSCRIPTION_PAID_NOT_ENOUGH";
					else if(months <= 0)	error = "ERROR_SUBSCRIPTION_INVALID_MONTHS";
					
					if(!error.equals("NO_ERROR"))
					{
						response.sendRedirect(request.getParameter("from_url") + "?error=" + error);
					}
					else
					{
						// Get the subscriber_id from the login.
						results = stmt.executeQuery("select * from subscriber where login=\"" + session.getAttribute("username") + "\";");
						results.first();
						subscriber_id = Integer.parseInt(results.getString("subscriber_id"));
						
						// Add the subscription....
						int row = stmt.executeUpdate("INSERT INTO subscription (subscriber_id, offering_id, paid, months) VALUES (" + subscriber_id + ", " + offering_id + ", " + paid + ", " + months + ")");
						response.sendRedirect(request.getParameter("from_url"));
					}
				}
			}
		}	
		// form_name != null
	%>
	<head>
	</head>
	<body>
	</body>
</html>