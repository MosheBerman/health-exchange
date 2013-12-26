<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="database.jsp"%>

<%
	String logOut = request.getParameter("logout");
	
	if(logOut != null)
	{
		// We logged out.
		if(logOut.equals("yes"))
		{
			session.setAttribute("username_type", null);
			session.setAttribute("username", null);
		}
	}
%>
<!DOCTYPE html>
<html>
	<head>
	   <title>HealthExchange.org</title>
	   <link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
		<%@ include file="logo.jsp"%>
		<%@ include file="topbar.jsp"%>
		
		<%
			if(session.getAttribute("username") == null || ((String)session.getAttribute("username")).length() == 0)
			{

		%>

		<p class="description">Log in to trade your physical health in for an insurance plan. 
		Or, if you're a provider, you'll be given the opportunity 
		to bait people for their health. Isn't that nice?</p>

		<p class="description">If you're new here, you can sign up with one 
		of these big, bright, and shiny orange buttons below.</p>

		<p class="description">
			If you get lost, click on the site logo to go home.
		</p>

		<a class="big-orange-button" href="http://vc13.vc.panix.com:22071/project/register.jsp?type=Subscriber">New Subscriber?</a>
		<a class="big-orange-button" href="http://vc13.vc.panix.com:22071/project/register.jsp?type=Company">New Provider?</a>
		<%
			}else if(session.getAttribute("username_type").equals("company")){
		%>
			<p class="description">
			Great! You're logged in and ready for world domination. Take <a href="./company.jsp">a leap over to your dashboard</a> and check out all the cool things you can do.
			</p>
			<a href="./company.jsp" class="big-orange-button block clear-both center">Give Me Superpowers</a>
		<%
		}else{
		%>
			<p class="description">
				You're almost set. Why don't you <a href="./subscriber.jsp">go to your dashboard</a> and sign up for idiot insurance? In case someone you know is an idiot.
			</p>
			<a href="./subscriber.jsp" class="big-orange-button block clear-both center">Show Me My Dashboard</a>
		<%
		}
		%>

	</div>
	</body>
</html>