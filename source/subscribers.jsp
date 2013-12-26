<!DOCTYPE html>
<html>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ include file="database.jsp"%>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Subscribers | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>

			<%
				if(session.getAttribute("username") != null && session.getAttribute("username") != "" && session.getAttribute("username_type").equals("company"))
				 {
			%>
				<!-- The user is logged in -->
				<!-- Our subscribers -->
					<div id="company_subscription_info">
						<h1>Our subscribers</h1>
						<table>
							<tr>
								<td>ID</td>
								<td>Subscriber</td>
								<td>Offering</td>
								<td>Amount Paid</td>
								<td>Price</td>
								<td>Months</td>
							</tr>
						
							<%
								Statement stmt = con.createStatement();
								ResultSet rs_subinfo = stmt.executeQuery("select * from subscription");						
								while(rs_subinfo.next())
								{
								
									Statement subStatement = con.createStatement();
									Statement offStatement = con.createStatement();
									Statement planStatement = con.createStatement();
								
									ResultSet rs_sub = subStatement.executeQuery("select * from subscriber where subscriber_id=" + rs_subinfo.getString("subscriber_id") );
									ResultSet rs_off = offStatement.executeQuery("select * from offering where offering_id=" + rs_subinfo.getString("offering_id") );
									
									rs_sub.first();			
									rs_off.first();
									
									ResultSet rs_plan = planStatement.executeQuery("select * from plan where plan_id=" + rs_off.getString("plan_id"));
									
									rs_plan.first();
								%>
									<tr>
										<td><%= rs_subinfo.getString("subscriber_id")%></td>
										<td><%= rs_sub.getString("name")%></td>	
										<td><%= rs_off.getString("offering_id") + " - " + rs_plan.getString("name")%></td>
										<td>$<%= rs_subinfo.getString("paid")%></td>
										<td>$<%= rs_off.getString("price")%></td>
										<td><%= rs_subinfo.getString("months")%>mo.</td>
									</tr>
								<%
								}
							%>
						</table>
					</div>
				</div>	<!-- End information -->
			<%
				} else {
			%>
				<!-- The user is not logged in -->
								<!-- The user is not logged in -->
				<h1>You need to log in to see that.</h1>
				<P class="description">That? That's private, man!</p>
				<%@ include file="redirect.jsp" %>

			<%
				}
			%>
		</div>
	</body>
</html>
