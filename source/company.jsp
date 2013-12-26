<!DOCTYPE html>
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file="database.jsp" %>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Company Profile | HealthExchange.org®</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<%
			/* This guy is used later in a few places... */
			Statement stmt = con.createStatement();
		%>

		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>

			<%
			if(session.getAttribute("username") != null && session.getAttribute("username") != "" && session.getAttribute("username_type").equals("company"))
			{
			%>

			<div id="profile">
				<h2>Company Profile (<%=session.getAttribute("username")%>)</h2>
				<%
					ResultSet rs_ourcompanyinfo = stmt.executeQuery("select * from company where login='" + session.getAttribute("username") + "'");
					rs_ourcompanyinfo.first();
				%>
					Name: <%= rs_ourcompanyinfo.getString("name")%>					</br>
					Street Address: <%= rs_ourcompanyinfo.getString("street_address")%>	</br>
					City: <%= rs_ourcompanyinfo.getString("city")%>					</br>
					State: <%= rs_ourcompanyinfo.getString("state")%>				</br>
					Zip: <%= rs_ourcompanyinfo.getString("zip")%>
			</div>

			<div id="dashboard-actions" style="border: 1px dotted orange">

			<h1>Dashboard</h1>
			<p class="description">Here, have a six pack (of buttons). This one will let you pursue your dreams of world power.</p>
			
				
				<a href="addplan.jsp" class="big-orange-button">Plan a Plan</a>
				<a href="offering.jsp" class="big-orange-button">Offer an Offering</a>
				<a href="discount.jsp" class="big-orange-button">Discount an Offering</a>
				<a href="browse.jsp" class="big-orange-button">See What Offerings Exist</a>
				<a href="competitors.jsp" class="big-orange-button">Spy on Competitors</a>
				<a href="subscribers.jsp" class="big-orange-button">Eavesdrop on Subscribers</a>
			</div>
		<%
		}	// if session.getAttribute("username") == null
		else
		{
		%>
			<!-- Code when we access company.jsp when: not logged in, or as a subscriber -->
			<h1>You need to log in to see that.</h1>
			<P class="description">We care about seh-quur-iddy 'round here!</p>
			<%@ include file="redirect.jsp" %>
		<%
		}
		%>
	</div>
	</body>
</html>