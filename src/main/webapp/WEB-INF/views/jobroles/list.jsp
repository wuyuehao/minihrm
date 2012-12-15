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
				url : "/minihrm/jobroles/" + id,
				handleAs : "text",
				load : function(data) {
					dojo.byId("jobroletable").Refresh();
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

		<h1>Manage JobRoles</h1>
		<div id="jobroletable" class="span-12 last">
			<table>
				<c:forEach var="jobrole" items="${jobroles}">
					<tr>
						<td>${jobrole.jobRole}</td>
						<td><button id="deleteButton" onclick="del(${jobrole.id})">Delete</button>
						</td>
					</tr>
				</c:forEach>
			</table>

			<form:form modelAttribute="jobrole" action="/minihrm/jobroles"
				method="post">
				<fieldset>
					<table>
						<tr>
							<td><form:label for="jobRole" path="jobRole">Job Role</form:label>
							</td>
						</tr>
						<tr>
							<td><form:input path="jobRole" /> <form:errors
									path="jobRole" /></td>
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