<!-- Notes from Michael 
	
	1. This is a single sign-in page that will be included into the top of every file.
	2. When we're not signed in, it displays the signin form. When we are signed it, we display
		"Hello <username>" and possibly a link to the profile page.
-->
<!-- This file is included in every html, so the jsp should run fine without includes. NEVER redirect a user to this .jps file -->
	<div id="topbar">
		<div id="signin" class="topbar">
			<!-- Make sure we redirect the signin to the correct webpage. Remains index.jsp for now... -->

			<%			
			if(session.getAttribute("username") == null)
			{
			
				String error = request.getParameter("error");
				String error_msg = "";
				
				if(error != null)
				{
					error_msg = "Error: ";
					if(error.equals("ERROR_TYPE_USER_NULL")) 			error_msg += "Username cannot be empty.";
					else if(error.equals("ERROR_TYPE_PWD_NULL")) 		error_msg += "Password cannot be empty.";
					else if(error.equals("ERROR_TYPE_LOGIN_FAILED"))	error_msg += "Username and/or password does not match records in the database.";
				}
				if(!error_msg.equals(""))
				{
					%>
					<p class="error_text"> <%= error_msg %> </p>
					<%
				}
				%>
				<form method='POST' action='validate.jsp'>
					User Name <input type="text" name="username"/><br/>
					Password <input type="text" name="pwd"/>
					<input type="hidden" name="formname" value="signin">
					<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
					<input type='submit' value='Log In'/>
				</form>
				<%
				}
				else
				{
					String dest = "http://vc13.vc.panix.com:22071/project/" + session.getAttribute("username_type") + ".jsp";
				%>
					<p>Greetings, <a href="<%=dest%>"><%=session.getAttribute("username")%></a></b></p>
					<form method='POST' action='index.jsp'>
						<input type="hidden" name="logout" value="yes"/>
						<input type="submit" value="Log Out"/>
					</form>
				<%
				}
			%>
		</div>
	</div>