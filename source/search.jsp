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
				if(session.getAttribute("username") != null && session.getAttribute("username") != "") {
			%>
				<!-- The user is logged in -->
				<div>
					<h1>Search</h1>
					<form name="SearchOffering" action="search.jsp" method="GET" class="styled-form">
						<input type="text" name="search_max_deduct" placeholder="Maximum Deductible">
						<input type="text" name="search_extra_coverage" placeholder="Extra Coverage (Zombies; Fire; Flood)">
						<input type="submit" value="Search!" class="big-orange-button"/>
					</form>
					
					<%
						Integer maxDeductible, maxDuration;
						
						String extraCoverage = "";
						
						if(request.getParameter("search_extra_coverage") != null)
							extraCoverage = request.getParameter("search_extra_coverage");
						
						extraCoverage = extraCoverage.replaceAll("; ", ";");
						
						String[] parts = extraCoverage.split(";");
						boolean checkString = true;
						
						if(extraCoverage.equals(""))
						{
							checkString = false;
						}
						
						if(request.getParameter("search_max_deduct") == null || request.getParameter("search_max_deduct").equals(""))
							maxDeductible = -1;
						else
						{
							try	{
								maxDeductible = Integer.parseInt(request.getParameter("search_max_deduct"));
							}
							catch(NumberFormatException e)	{
								maxDeductible = -1;
							}
						}
						
						String sqlCommand = "select * from offering";
						
						if(maxDeductible > 0)
						{
							sqlCommand += " where ";
						}
						
						if(maxDeductible > 0)
						{
							sqlCommand += "deductible <= " + maxDeductible;
						}
						
						// if sqlCommand string still equals the default, then do nothing because nothing was searched.
						if(!sqlCommand.equals("select * from offering") || !extraCoverage.equals(""))
						{
							%>
							<table>
								<tr>
									<td>Offering ID</td>
									<td>Plan Name</td>
									<td>Company Name</td>
									<td>Price</td>
									<td>Deductible</td>
									<td>Coverage</td>
									<td>Discount</td>
								</tr>
								<%
								Statement stmt = con.createStatement();
								ResultSet rs = stmt.executeQuery(sqlCommand + " order by price desc");
								while(rs.next())
								{
									Statement planStmt = con.createStatement();
									Statement comStmt = con.createStatement();
									Statement covStmt = con.createStatement();
									Statement disStmt = con.createStatement();
									
									ResultSet rs_plan = planStmt.executeQuery("select * from plan where plan_id=" + rs.getString("plan_id"));
									ResultSet rs_com = comStmt.executeQuery("select * from company where company_id=" + rs.getString("company_id"));
									ResultSet rs_cov = covStmt.executeQuery("select * from coverage where plan_id=" + rs.getString("plan_id") + " order by cond");
									ResultSet rs_dis = disStmt.executeQuery("select * from discount where offering_id=" + rs.getString("offering_id") + " order by months");
									
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
									
									if(covString.isEmpty())	covString = "No Coverages.";
									if(disString.isEmpty()) disString = "No Discount.";
								
									// Actually don't show anything if one of the parameters is missing!
									if(!covString.isEmpty() && checkString)
									{
										boolean notFound = false;
										for(int i=0; i < parts.length; i++)
										{
											if(!(covString.toLowerCase()).contains(parts[i].toLowerCase()))
											{
												notFound = true;
											}
										}
										
										if(notFound) continue;
									}
								
									%>
										<tr>
											<td><%=rs.getString("offering_id")%></td>
											<td><%=rs_plan.getString("name")%></td>
											<td><%=rs_com.getString("name")%></td>
											<td>$<%=rs.getString("price")%></td>
											<td>$<%=rs.getString("deductible")%></td>
											<td><%=covString%></td>
											<td><%=disString%></td>
										</tr>
									<%
								}
							%>
							</table>
							<%
						}
					%>
				</div>
			</div>	<!-- End information -->
			<%
				} else {
			%>
				<!-- The user is not logged in -->
			<h1>Only subscribers can search.</h1>
			<P class="description">They need to feel like they're getting some value.</p>
			<%@ include file="redirect.jsp" %>				
			<%
				}
			%>
		</div>
	</body>
</html>
