<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="database.jsp"%>

<%
	setupClientProperties();
	com.mysql.jdbc.Driver d = new com.mysql.jdbc.Driver();
	String resultHTML = "";
	String sqlCommand = request.getParameter("query");
	
	if (sqlCommand != null)
	{
		boolean isQuery = sqlCommand.toUpperCase().startsWith("SELECT");
 
		Connection con = DriverManager.getConnection(url, user, password);
		Statement stmt = con.createStatement();
 
		if (isQuery)
		{
			try
			{
				ResultSet results = stmt.executeQuery(sqlCommand);
				
				// INSIDE THIS WHILE WE PROCESS THE SQL STATEMENT
				while (results.next())
				{
					String university = results.getString("university");
					String course_title = results.getString("course_title");
					System.out.println(university+", "+course_title);
					resultHTML+="<li>"+university+", "+course_title+"</li>\n";
				}
				resultHTML = "<ul>\n"+resultHTML+"</ul>\n";
			}
			catch (SQLException sqle)
			{
				resultHTML = "Query failed... possibly invalid?";
			}
		}
		else
		{
			//int rows = stmt.executeUpdate(sqlCommand);
			//System.out.println(rows+" rows affected");
			resultHTML = "ONLY VALID SQL QUERIES PLEASE!";
		}
	}
%>

<html>
	<head>
	   <title>DB EXAMPLE</title>
	   <script src="utilities.js"></script>
	</head>
	<body>
		<%@ include file="topbar.jsp"%>
		
		<button onclick="window.location.assign('http://vc13.vc.panix.com:22071/project/register_com.jsp')">New Company?</button>
		<button onclick="window.location.assign('http://vc13.vc.panix.com:22071/project/register_sub.jsp')">New Subscriber?</button>
		
		<h1>THE BELOW IS JUST A DATABASE TEST. PLEASE REMOVE WHEN DATABASE CAN BE MANIPULATED CORRECTLY.</h1>
		<p> sample query: select * from Zsection where section_id&lt;22 </p>
		<form action="index.jsp" method="POST">
		query: <input type="text" name="query"><br>
		<input type="submit">
		</form>
		<%=resultHTML%>
	</body>
</html>