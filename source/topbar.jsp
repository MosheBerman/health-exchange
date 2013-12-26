<!-- Notes from Michael 
	
	1. This is a single sign-in page that will be included into the top of every file.
	2. When we're not signed in, it displays the signin form. When we are signed it, we display
		"Hello <username>" and possibly a link to the profile page.
-->
<!-- This file is included in every html, so the jsp should run fine without includes. NEVER redirect a user to this .jsp file -->
	<div id="topbar">
			<!-- Make sure we redirect the signin to the correct webpage. Remains index.jsp for now... -->

			<%		

			String error_msg = "";

			if(session.getAttribute("username") == null || session.getAttribute("username").equals(""))
			{
			
				String error = (String)request.getParameter("error");
				
				if(error != null && error.length() > 0)
				{
					error_msg = "";
					if(error.equals("ERROR_TYPE_USER_NULL")) 			error_msg += "Username cannot be empty.";
					else if(error.equals("ERROR_TYPE_PWD_NULL")) 		error_msg += "Password cannot be empty.";
					else if(error.equals("ERROR_TYPE_LOGIN_FAILED"))	error_msg += "Username and/or password does not match records in the database.";

					%>

					<%
				}
				%>
				<form method='POST' action='validate.jsp' id="login-form">
					<input type="text" name="username" placeholder="Username" /> 
					<input type="password" name="pwd" placeholder="Password" />
					<input type="hidden" name="formname" value="signin"> 
					<input type="hidden" name="from_url" value=<%=request.getRequestURL()%>>
					<input type='submit' value='Log In' class="small-orange-button last-form-element"/>
				</form>
			<%
			}
			else
			{
				String dest = "http://vc13.vc.panix.com:22071/project/" + session.getAttribute("username_type") + ".jsp";
			%>
				<p id="greeting">
					<span class="left-element" style="margin: 0 10px;">
						Greetings, <%=session.getAttribute("username")%>!
					</span>
					<a href="<%=dest%>" class="left-element" id="dashboard-link">
						Go To Dashboard
					</a>
				</p>
				<form method='POST' action='index.jsp' id="logout-form">
					<input type="hidden" name="logout" value="yes"/>
					<input type="submit" value="Log Out" class="small-orange-button last-form-element"/>
				</form>
			<%
			}
			%>
	</div>

	<%
		if(error_msg.length() > 0){
	%>
		<p class="error_text"> <%= error_msg %> </p>
	<% 
		}
	%>