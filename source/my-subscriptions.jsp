<!DOCTYPE html>
<html>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ include file="database.jsp"%>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>My Subscriptions | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>

			<%
				if(session.getAttribute("username") != null && session.getAttribute("username") != "" && !session.getAttribute("username_type").equals("company")) {
			%>
				<!-- The user is logged in -->

				<div>
					<h1>Subscription Details</h1>
					<p class="description">These are the offerings you have subscribed to, O, subscriber.</p>
					<table>
						<tr>
							<td>Subscription ID</td>
							<td>Offering ID</td>
							<td>Paid</td>
							<td>Duration</td>
						</tr>
						<%
							Statement stmt = con.createStatement();
							
							// Get our id.
							ResultSet rs = stmt.executeQuery("select * from subscriber where login='" + session.getAttribute("username") + "'");
							rs.first();
							Integer subscriber_id = Integer.parseInt(rs.getString("subscriber_id"));
							
							rs = stmt.executeQuery("select * from subscription where subscriber_id=" + subscriber_id);
							
							while(rs.next())
							{
								Statement offStmt = con.createStatement();
								ResultSet rs_off = offStmt.executeQuery("select price from offering where offering_id=" + rs.getString("offering_id"));
								rs_off.first();
								%>
									<tr>
										<td><%=rs.getString("subscription_id")%></td>
										<td><%=rs.getString("offering_id")%></td>
										<td>$<%=rs.getString("paid")%> / $<%=rs_off.getString("price")%></td>
										<td><%=rs.getString("months")%>mo</td>
									</tr>
								<%
							}
						%>
					</table>
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
