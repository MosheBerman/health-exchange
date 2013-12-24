<!DOCTYPE html>
<html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
	<head>
		<!-- Which company is selected? Update the title to reflect that. -->
		<title>Registration Page - Company</title>
	</head>
	<body>
		<%@ include file="topbar.jsp"%>
		<div>
			<div>	<!-- Start Login Info -->
				<form name="loginForm" action="register_com.jsp" method="get">
					<!-- Hidden form data to specify what type of registration this is -->
					<input type="hidden" name="company_register">
					Name: 		<input type="text" name="name">		<br/>
					Address:	<input type="text" name="address">	<br/>
					City:		<input type="text" name="city">		<br/>
					State:		<input type="text" name="state"> 	<br/>
					Zip:		<input type="text" name="zip">		<br/>
					Login:		<input type="text" name="login">	<br/>
					Password:	<input type="password" name="password">	<br/>
					Confirm Password:	<input type="password" name="confirm">	<br/>
					<input type="submit" value="Submit">
				</form>
			</div>	<!-- End Login Info -->
		</div>
	</body>
</html>