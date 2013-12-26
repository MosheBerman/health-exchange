<!DOCTYPE html>
<html>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ include file="database.jsp"%>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Add Discount | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>

			<%
				if(session.getAttribute("username") != null && session.getAttribute("username") != ""  && session.getAttribute("username_type").equals("company")) {
			%>
				<!-- The user is logged in -->

				<!-- Offer a discount -->
						<h1>Add a Discount.</h1>
						<p class="description">Why not? We're already charging an arm and a leg!</p>
						<p class="description">You may only add a discount to an offering you have posted.</p>
						<form name="discountform" action="validate.jsp" method="GET" class="styled-form">
							<%
								Statement stmt = con.createStatement();
								String error = request.getParameter("error");
								error_msg = "";
								
								if(error != null)
								{
									error_msg = "";
									if(error.equals("ERROR_DISCOUNT_DISCOUNT_NULL")) 		error_msg += "You are evil - offering a discount worth nothing?";
									else if(error.equals("ERROR_DISCOUNT_MONTHS_NULL"))		error_msg += "How long do you want your lemmings to serve you before they're eligible for a discount?";
									else if(error.equals("ERROR_DISCOUNT_INVALID_INTEGER"))	error_msg += "I'm sorry, but I don't understand that. Please enter a number in both fields.";
								}
								
								if(error_msg.length() > 0)
								{
									%>
									<p class="error_text"> <%= error_msg %> </p>
									<%
								}
							%>
							Offering Name: <select name="offeringname">
											<%
												// Get our id.
												ResultSet rs = stmt.executeQuery("select * from company where login='" + session.getAttribute("username") + "'");
												rs.first();
												Integer company_id = Integer.parseInt(rs.getString("company_id"));
											
												rs = stmt.executeQuery("select plan.name, offering.offering_id from offering left join plan on plan.plan_id=offering.plan_id where offering.company_id=" + company_id + " order by offering.plan_id");
												
												while(rs.next())
												{
												%>
													<option value=<%=rs.getString("offering_id")%>>Offering #<%=rs.getString("offering_id")%> - <%=rs.getString("name")%></option>
												<%
												}
											%>
										</select> 								
							<input type="text" name="discount" placeholder="Discount"> 		
							<input type="text" name="months" placeholder="Duration in Months"> 			
							<input type="hidden" name="formname" value="add_discount">
							<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
							<input type="submit" value="Add Discount" class="big-orange-button">
						</form>
					</div>
				</div>

			<%
				} else {
			%>
				<!-- The user is not logged in -->
			<h1>You need to log in to see that.</h1>
			<P class="description">Who are you again?</p>
			<%@ include file="redirect.jsp" %>
			<%
				}
			%>
		</div>
	</body>
</html>
