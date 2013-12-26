<!DOCTYPE html>
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file="database.jsp" %>
	<head>
		<!-- Which subscriber is selected? Update the title to reflect that. -->
		<title>Subscriber Page</title>
		<link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<div id="content-area">
			<%@ include file="logo.jsp" %>
		 	<%@ include file="topbar.jsp"%>
			<div>	<!-- Start sidebar -->
				
			</div>	<!-- End sidebar -->
			

				<a href="browse.jsp" class="big-orange-button">See What Offerings Exist</a>
				<a href="subscribe.jsp" class="big-orange-button">Subscribe</a>
				<a href="my-subscriptions.jsp" class="big-orange-button">See my Subscriptions</a>
				<a href="search.jsp" class="big-orange-button">Search</a>

		</div>
	</body>
</html>