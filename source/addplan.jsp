<!DOCTYPE html>
<html>
	<%@ page import="java.io.*" %>
	<%@ page import="java.util.*" %>

	<head>
		<title>Add Plan</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<%@ include file="topbar.jsp"%>
		<h1>Create a new plan.</h1>
		<form name="planform" action="validate.jsp" method="GET">
			<%
				String error = (String) request.getParameter("error");
				String error_msg = "";

				if(error != null)
				{
					error_msg = "Error: ";
					if(error.equals("ERROR_TYPE_PLAN_NAME_NULL")) 		error_msg += "Must enter a plan name";
					else if(error.equals("ERROR_TYPE_ADD_PLAN_FAILED"))	error_msg += "Plan Name already exists in database.";
				}
				
				if(!error_msg.equals(""))
				{
					%>
					<p class="error_text"> <%= error_msg %> </p>
					<%
				}
			%>
			<input type="hidden" name="formname" value="add_plan">
			<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
			Name: <input type="text" name="plan_name"> <br/>
			<input type="submit" value="Create Plan">
		</form>
		
		<h1>Add Offering to existing plan.</h1>
		<form name="offeringform" action="validate.jsp" method="GET">
			Plan Name: <input type="text" name="planname"> 		<br/>
			Price: <input type="text" name="price"> 			<br/>
			Deductible: <input type="text" name="deductible"> 	<br/>
			<input type="submit" value="Add Offering">
			<input type="hidden" name="formname" value="add_offering">
			<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
		</form>
		
		<h1>Add Coverage to existing plan.</h1>
		<form name="offeringform" action="validate.jsp" method="GET">
			Condition: <input type="text" name="condition"> 	<br/>
			Plan Name: <input type="text" name="planname"> 		<br/>
			<input type="submit" value="Add Coverage">
			<input type="hidden" name="formname" value="add_coverage">
			<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
		</form>
		
		<h1>Add Discount to existing offering.</h1>
		<form name="offeringform" action="validate.jsp" method="GET">
			Offering Name: <input type="text" name="offeringname"> 	<br/>
			Discount: <input type="text" name="discount"> 			<br/>
			Months: <input type="text" name="months"> 				<br/>
			<input type="submit" value="Add Discount">
			<input type="hidden" name="formname" value="add_discount">
			<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
		</form>
	</body>
</html>