<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<script src="/minihrm/js/dojo/dojo.js"></script>
<script type="text/javascript">

	function del(id) {
			var xhrArgs = {
				url : "/minihrm/accounts/" + id,
				handleAs : "text",
				load : function(data) {
					//dojo.byId("jobroletable").Refresh();
				},
				error : function(error) {
					// We'll 404 in the demo, but that's okay.  We don't have a 'postIt' service on the
					// docs server.  This is fine.  Just treat it as a success for purposes of the example.
					//dojo.byId("response").innerHTML = "Delete completed";
				}
			}
			dojo.xhrDelete(xhrArgs);
			window.location.reload();
	}
</script>
<META  http-equiv="Content-Type"  content="text/html;charset=UTF-8">
<title>Create Employee</title>
</head>
<body>
	<div class="container">

		<h1>Create Accounts</h1>
		<div id="jobroletable" class="span-12 last">
			<table>
				<c:forEach var="account" items="${accounts}">
					<tr>
						<td>${account.username}</td>
						<td><button id="deleteButton" onclick="del(${account.id})">Delete</button>
						</td>
					</tr>
				</c:forEach>
			</table>

			<form:form modelAttribute="manager" action="/minihrm/accounts"
				method="post">
				<fieldset>
					<table>
						<tr>
							<td><form:label for="username" path="username">Account Name</form:label>
							</td>
						</tr>
						<tr>
							<td><form:input path="username" /> <form:errors
									path="username" />
							</td>
						</tr>

						<tr>
							<td><form:password path="password" /> <form:errors
									path="password" />
							</td>
						</tr>
						<tr>
							<td><form:select path="authority">
							<option value="ROLE_USER">ROLE_USER</option>
							<option value="ROLE_ADMIN">ROLE_ADMIN</option>
							</form:select> 
							
							<form:errors
									path="authority" />
							</td>
							
							<form:hidden path="enabled" value="true"/>
						</tr>
					</table>
					<p>
						<input type="submit" />
					</p>
				</fieldset>
			</form:form>
		</div>

	</div>
</body>
</html>