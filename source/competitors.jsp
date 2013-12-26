<!DOCTYPE html>
<html>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ include file="database.jsp"%>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Template | HealthExchange.org®</title>
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

				<!-- info of other companies -->
					<div id="other_company_info">
						<h1>The Other Guys </h1>
						<p class="description">You might want to sell insurance to the executives at the other companies. Just a thought.</p>
						<table>
							<tr>
								<td>Company Name</td>
								<td>Address</td>
								<td>City</td>
								<td>State</td>
								<td>Zip</td>
							</tr>
							
							<%
								Statement stmt = con.createStatement();
								ResultSet rs_othercompanyinfo = stmt.executeQuery("select * from company where login!='" + session.getAttribute("username") + "'");						
								while(rs_othercompanyinfo.next())
								{
								%>
									<tr>
										<td><%= rs_othercompanyinfo.getString("name")%>						</br></td>
										<td><%= rs_othercompanyinfo.getString("street_address")%>			</br></td>
										<td><%= rs_othercompanyinfo.getString("city")%>						</br></td>
										<td><%= rs_othercompanyinfo.getString("state")%>					</br></td>
										<td><%= rs_othercompanyinfo.getString("zip")%>						</td>
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
