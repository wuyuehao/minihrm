<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<META  http-equiv="Content-Type"  content="text/html;charset=UTF-8">
<title>Create Employee</title>
</head>
<body>
	<div class="container">
		<h1>Create Employee</h1>
		<div class="span-12 last">

			<form:form modelAttribute="jobroles" action="/minihrm/jobroles"
				method="post">
				<fieldset>
					<table>
						<tr>
							<td><form:label path="value">Job Role</form:label></td>
						</tr>
						<tr>
							<td><form:input path="name" /> <form:errors path="name" />
								<c:forEach var="jobrole" items="${jobroles}">
								${jobrole} <BR>
								</c:forEach> <form:select path="jobRole" items="${jobRoles}" /></td>
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