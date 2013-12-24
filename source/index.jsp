<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="database.jsp"%>

<%
	//setupClientProperties();
	//com.mysql.jdbc.Driver d = new com.mysql.jdbc.Driver();
	//String resultHTML = "";
	//String sqlCommand = request.getParameter("query");
	//
	//if (sqlCommand != null)
	//{
	//	boolean isQuery = sqlCommand.toUpperCase().startsWith("SELECT");
	//
	//	Connection con = DriverManager.getConnection(url, user, password);
	//	Statement stmt = con.createStatement();
	//
	//	if (isQuery)
	//	{
	//		try
	//		{
	//			ResultSet results = stmt.executeQuery(sqlCommand);
	//			
	//			// INSIDE THIS WHILE WE PROCESS THE SQL STATEMENT
	//			while (results.next())
	//			{
	//				String university = results.getString("university");
	//				String course_title = results.getString("course_title");
	//				System.out.println(university+", "+course_title);
	//				resultHTML+="<li>"+university+", "+course_title+"</li>\n";
	//			}
	//			resultHTML = "<ul>\n"+resultHTML+"</ul>\n";
	//		}
	//		catch (SQLException sqle)
	//		{
	//			resultHTML = "Query failed... possibly invalid?";
	//		}
	//	}
	//	else
	//	{
	//		//int rows = stmt.executeUpdate(sqlCommand);
	//		//System.out.println(rows+" rows affected");
	//		resultHTML = "ONLY VALID SQL QUERIES PLEASE!";
	//	}
	//}
%>

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

<html>
	<head>
	   <title>DB EXAMPLE</title>
	   <link rel="stylesheet" type="text/css" href="style/site.css">
	</head>
	<body>
		<%@ include file="topbar.jsp"%>
		
		<%
			if(session.getAttribute("username") == null)
			{
		%>
		<button onclick="window.location.assign('http://vc13.vc.panix.com:22071/project/register.jsp?type=Company')">New Company?</button>
		<button onclick="window.location.assign('http://vc13.vc.panix.com:22071/project/register.jsp?type=Subscriber')">New Subscriber?</button>
		<%
			}
		%>
	</body>
</html>