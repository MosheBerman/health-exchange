<!DOCTYPE html>
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file="database.jsp" %>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Company Page</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<%@ include file="topbar.jsp"%>
		<div class="main_block">
			<div class="sidebar">	<!-- Start sidebar -->
				<a href="addplan.jsp">Create New Plan</a>
			</div>	<!-- End sidebar -->
			<div class="information">	<!-- Start information -->
				<!-- Offerings of other companies -->
				<div id="company_competitor_offerings">
					<h1>Company offerings</h1>
					<%
						%>
						
						<%
					%>
				</div>
				<!-- Our subscribers -->
				<div id="company_subscriber_info">
					<h1>Our subscribers</h1>
				</div>
			</div>	<!-- End information -->
		</div>
	</body>
</html>