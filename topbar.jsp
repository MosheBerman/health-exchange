<!-- Notes from Michael 
	
	1. This is a single sign-in page that will be included into the top of every file.
	2. When we're not signed in, it displays the signin form. When we are signed it, we display
		"Hello <username>" and possibly a link to the profile page.
-->

<div id="topbar">
	<div id="signin">
		<!-- Make sure we redirect the signin to the correct webpage. Remains index.jsp for now... -->
		<form method='POST' action='index.jsp'>
			<input type="text" name="username" value="username"/>
			<input type="text" name="password" value="password"/><br/>
			<input type='submit' value='sign in'/>
		</form>
	</div>
</div>