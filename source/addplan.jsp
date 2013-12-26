<!DOCTYPE html>
<html>
	<%@ page import="java.io.*" %>
	<%@ page import="java.util.*" %>
	<%@ include file="database.jsp" %>
	<head>
		<title>Add Plan | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
		<%@ include file="logo.jsp"%>
		<%@ include file="topbar.jsp"%>
		<%
			String error = (String) request.getParameter("error");
			error_msg = "";
		%>
		<h1>Create a Plan<sup>*</sup></h1>
		<form name="planform" action="validate.jsp" method="GET" class="styled-form">
			<%

				if(error != null)
				{
					error_msg = "";
					if(error.equals("ERROR_TYPE_PLAN_NAME_NULL")) 		error_msg += "All good schemes have a name. What's your scheme's name?";
					else if(error.equals("ERROR_TYPE_ADD_PLAN_FAILED"))	error_msg += "That plan name isn't original.";
				}
				
				if(error_msg.length() > 0)
				{
					%>
					<p class="error_text"> <%= error_msg %> </p>
					<%
				}
			%>
			<input type="hidden" name="formname" value="add_plan">
			<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
			<input type="text" name="planname" placeholder="Name Your Grand Scheme"> 
			<input type="submit" value="Create Plan" class="big-orange-button">
		</form>
		
		<h1>Add Coverage to existing plan.</h1>
		<form name="offeringform" action="validate.jsp" method="GET" class="styled-form">
			<%
				error_msg = "";
				
				if(error != null)
				{
					error_msg = "";
					if(error.equals("ERROR_TYPE_COVERAGE_PLAN_NAME_NULL")) 				error_msg += "All good schemes have a name. What's your scheme's name?";
					else if(error.equals("ERROR_TYPE_COVERAGE_CONDITION_NAME_NULL"))	error_msg += "What are you covering? (Some ideas: idiocy, impulsiveness, cripples.)";
					else if(error.equals("ERROR_TYPE_COVERAGE_PLAN_NOT_EXIST"))			error_msg += "I never heard of that plan before.";
				}
				
				if(error_msg.length() > 0)
				{
					%>
					<p class="error_text"> <%= error_msg %> </p>
					<%
				}
			%>
			Plan Name: <select name="planname">
										<%
											Statement stmt = con.createStatement();
											ResultSet rs = stmt.executeQuery("select * from plan");
											
											while(rs.next())
											{
										%>
											<option value=<%=rs.getString("name").replaceAll(" ", "_")%> ><%=rs.getString("name")%></option>
										<%
											}
										%>
									</select>	
			<input type="text" name="condition" placeholder="Condition">
			<input type="hidden" name="formname" value="add_coverage">
			<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
			<input type="submit" value="Add Coverage" class="big-orange-button">
		</form>

		<sub>*Plan, as in scheme.</sub>
	</div>
	</body>
</html>