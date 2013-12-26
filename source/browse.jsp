<!DOCTYPE html>
<html>
	<%@ page import="java.util.*"%>
	<%@ page import="java.io.*"%>
	<%@ include file="database.jsp"%>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Offerings | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>

			<%
				/* This guy is used later in a few places... */
				Statement stmt = con.createStatement();

				Boolean isCompany = session.getAttribute("username_type").equals("company");

				if(session.getAttribute("username") != null && session.getAttribute("username") != "") {
			%>

		<!-- Offerings of other companies -->
					<div id="company_competitor_offerings">
						<h1>Company offerings</h1>
						<p class="description">

							<%
								if(isCompany) {
							%>

							These are the offerings available to unsuspecting consumers...

							<%
								}else{
							%>
								These are the offerings that those ripoffs are offering you. Might want to call the BBB. Wait, call the government on the government?
							<%
							}
							%>

						</p>
						<table id="offerings-chart">
							<!-- Headers -->
							<tr>
								<td>Offering ID </td>
								<td>Plan Name</td>
								<td>Provider</td>
								<td>Cost</td>
								<td>Deductible</td>
								<td>Coverage</td>
								<td>Discount</td>
							</tr>
							<%	
								ResultSet rs_offering = stmt.executeQuery("select * from offering order by offering_id");
								
								while(rs_offering.next())
								{
									Statement planStatement = con.createStatement();
									Statement comStatement = con.createStatement();
									Statement covStatement = con.createStatement();
									Statement disStatement = con.createStatement();
								
									ResultSet rs_plan = planStatement.executeQuery("select * from plan where plan_id=" + rs_offering.getString("plan_id") );
									ResultSet rs_com = comStatement.executeQuery("select * from company where company_id=" + rs_offering.getString("company_id") );
									ResultSet rs_cov = covStatement.executeQuery("select * from coverage where plan_id=" + rs_offering.getString("plan_id") + " order by cond");
									ResultSet rs_dis = disStatement.executeQuery("select * from discount where offering_id=" + rs_offering.getString("offering_id") + " order by months");
									
									rs_plan.first();			
									rs_com.first();
									
									String covString = "";
									String disString = "";
									
									while(rs_cov.next())
									{
										if(!rs_cov.isFirst())	covString += ", ";
										covString += rs_cov.getString("cond");
									}
									
									while(rs_dis.next())
									{
										if(!rs_dis.isFirst())	disString += "; ";
										disString += "$" + rs_dis.getString("discount");
										disString += "- " + rs_dis.getString("months") + "mo";
									}
									
									if(covString.isEmpty())	covString = "N/A";
									if(disString.isEmpty()) disString = "N/A";
									
									%>
										<tr>
											<td><%= rs_offering.getString("offering_id") %></td>
											<td><%= rs_plan.getString("name") %></td>
											<td><%= rs_com.getString("name") %></td>
											<td>$<%= rs_offering.getString("price") %></td>
											<td>$<%= rs_offering.getString("deductible") %></td>
											<td><%= covString %></td>
											<td><%= disString %></td>
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
