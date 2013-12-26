<!DOCTYPE html>
<html>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ include file="database.jsp"%>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Add an Offering | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>

			<%
				if(session.getAttribute("username") != null && session.getAttribute("username") != "") {

				/* This guy is used later in a few places... */
				Statement stmt = con.createStatement();
			%>
				<!-- The user is logged in -->

				<div id="Offering">

						<!-- Add an offering to a plan -->
						<h1>Add Offering to existing plan.</h1>
						<p class="description">Think of this as the bait. It's how you get customers to buy into your schemes.</p>
						<form name="offeringform" action="validate.jsp" method="POST" class="styled-form">
							<%
								String error = request.getParameter("error");
								error_msg = "";
								
								if(error != null)
								{
									error_msg = "";
									if(error.equals("ERROR_OFFERING_PRICE_NULL")) 				error_msg += "You didn't enter a number for a price. Giving this away for free, are we?";
									else if(error.equals("ERROR_OFFERING_DEDUCTIBLE_NULL"))		error_msg += "You didn't enter a number for a deductible. I'm surprised, you'd probably want this really high.";
									else if(error.equals("ERROR_TYPE_OFFERING_PLAN_NOT_EXIST")) error_msg += "Never heard of that plan before.";
								}
								
								if(error_msg.length() > 0)
								{
									%>
									<p class="error_text"> <%= error_msg %> </p>
									<%
								}
							%>
							Plan To Bait: <select name="planname">
											<%
												ResultSet rs = stmt.executeQuery("select * from plan");
												
												while(rs.next())
												{
											%>
												<option value=<%=rs.getString("name").replaceAll(" ", "_")%> ><%=rs.getString("name")%></option>
											<%
												}
											%>
										</select> 								<br/>
							<input type="text" name="price" placeholder="Price"> 			
							<input type="text" name="deductible" placeholder="Deductible"> 	
							<input type="hidden" name="formname" value="add_offering">
							<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
							<input type="submit" value="Add Offering" class="big-orange-button">
						</form>

			<%
				} else {
			%>
				<!-- The user is not logged in -->
				<h2>Unauthorized</h2>
				<p class="description">
					Sure, you're privileged, but not that much. So...
				</p>
				<%@ include file="redirect.jsp" %>
			<%
				}
			%>
		</div>
	</body>
</html>
