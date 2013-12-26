<!DOCTYPE html>
<html>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ include file="database.jsp"%>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Subscribe | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>

			<%
				if(session.getAttribute("username") != null && session.getAttribute("username") != "") {
			%>
				<!-- The user is logged in -->

				<div>
					<h1>Subscribe to an Offering</h1>
					<form name="chooseOfferingForm" action="validate.jsp" method="POST" class="styled-form">
						<%
							String error = request.getParameter("error");
							error_msg = "";
							
							if(error != null)
							{
								error_msg = "";
								if(error.equals("ERROR_SUBSCRIPTION_PAID_NULL")) 			error_msg += "I'm sorry, but you have to pay something up front.";
								else if(error.equals("ERROR_SUBSCRIPTION_MONTHS_NULL"))		error_msg += "You must specify the amount of months.";
								else if(error.equals("ERROR_SUBSCRIPTION_PAID_NOT_ENOUGH")) error_msg += "You must cover the deductible of the offering.";
								else if(error.equals("ERROR_SUBSCRIPTION_INVALID_MONTHS")) 	error_msg += "I'm sorry, but you entered an invalid amount of months.";
								else if(error.equals("ERROR_DISCOUNT_INVALID_INTEGER"))		error_msg += "You entered gibberish in one of the fields. They must be numbers!";
							}
							
							if(error_msg.length() > 0)
							{
								%>
								<p class="error_text"> <%= error_msg %> </p>
								<%
							}
						%>
						Select an offering:	<br/>
						<select name="offeringname">
							<%
								Statement stmt = con.createStatement();
								
								ResultSet rs = stmt.executeQuery("select plan.name, offering.offering_id from offering left join plan on plan.plan_id=offering.plan_id order by offering.plan_id");
								
								while(rs.next())
								{
								%>
									<option value=<%=rs.getString("offering_id")%>>Offering ID: <%=rs.getString("offering_id")%> - <%=rs.getString("name")%></option>
								<%
								}
							%>
						</select>											
						<input type="text" name="paid" placeholder="Pay Now">
						<input type="text" name="months" placeholder="Number of Months"> <br/>
						<input type="submit" value="Add Subscription" class="big-orange-button">
						<input type="hidden" name="formname" value="add_subscription">
						<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
					</form>
				</div>

			<%
				} else {
			%>
				<!-- The user is not logged in -->
			<h1>You need to log in to see that.</h1>
			<P class="description">We care about seh-quur-iddy 'round here!</p>
			<%@ include file="redirect.jsp" %>
			<%
				}
			%>
		</div>
	</body>
</html>
