<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<META  http-equiv="Content-Type"  content="text/html;charset=UTF-8">
<title>Employee Management</title>
</head>
<body>
	<div class="container">
		<div class="span-12 last">
			<form:form modelAttribute="employee" action="/minihrm/employees"
				method="post">
				<fieldset>
					<legend>Employee Fields</legend>
					<table>
						<tr>
							<td><form:label for="name" path="name" cssErrorClass="error">Name</form:label>
							</td>
							<td><form:label for="sn" path="sn" cssErrorClass="error">SN</form:label>
							</td>
							<td><form:label for="personelId" path="personelId"
									cssErrorClass="error">PID</form:label></td>
							<td><form:label for="notesid" path="notesid"
									cssErrorClass="error">Notes ID</form:label></td>
							<td><form:label for="email" path="email"
									cssErrorClass="error">Email</form:label></td>
							<td><form:label for="englishName" path="englishName"
									cssErrorClass="error">English Name</form:label></td>
							<td><form:label for="salary" path="salary"
									cssErrorClass="error">Salary</form:label></td>
							<td><form:label for="onboardDate" path="onboardDate"
									cssErrorClass="error">Onboard Date</form:label></td>
							<td><form:label for="onbandDate" path="onbandDate"
									cssErrorClass="error">Onband Date</form:label></td>
							<td><form:label for="onteamDate" path="onteamDate"
									cssErrorClass="error">Onteam Date</form:label></td>
							<td><form:label for="manager" path="manager"
									cssErrorClass="error">Manager</form:label></td>
							<td><form:label for="gender" path="gender"
									cssErrorClass="error">Gender</form:label></td>
							<td><form:label for="jobRole" path="jobRole"
									cssErrorClass="error">Job Role</form:label></td>
							<td><form:label for="team" path="team" cssErrorClass="error">Team</form:label>
							</td>
							<td><form:label for="pbc1" path="pbc1" cssErrorClass="error">PBC 1</form:label>
							</td>
							<td><form:label for="pbc2" path="pbc2" cssErrorClass="error">PBC 2</form:label>
							</td>
							<td><form:label for="pbc3" path="pbc3" cssErrorClass="error">PBC 3</form:label>
							</td>
						</tr>
						<tr>
							<td><form:input path="name" style="width: 10em;"
									data-dojo-type="dijit/form/TextBox"
									data-dojo-props="trim:true, propercase:true" /> <form:errors
									path="name" /></td>
							<td><form:input path="sn" /> <form:errors path="sn" />
							</td>
							<td><form:input path="personelId" /> <form:errors
									path="personelId" /></td>
							<td><form:input path="notesid" /> <form:errors
									path="notesid" />
							</td>
							<td><form:input path="email" /> <form:errors path="name" />
							</td>
							<td><form:input path="englishName" /> <form:errors
									path="name" />
							</td>
							<td><form:input path="salary" /> <form:errors path="name" />
							</td>
							<td><form:input path="onboardDate" /> <form:errors
									path="name" /></td>
							<td><form:input path="onbandDate" /> <form:errors
									path="name" />
							</td>
							<td><form:input path="onteamDate" /> <form:errors
									path="name" /></td>
							<td><form:input path="manager" /> <form:errors path="name" />
							</td>
							<td><form:radiobutton path="gender" value="M" />M <form:radiobutton
									path="gender" value="F" />F</td>
							<td><form:select path="jobRole">
									<option value="QA">QA</option>
									<option value="Dev">Dev</option>
									<option value="Architect">Architect</option>
									<option value="PLM">PLM</option>
									<option value="PM">RM/PM</option>
								</form:select></td>
							<td><form:select path="team">
									<option value="TMS">TMS</option>
									<option value="B2B">B2B</option>
									<option value="EMP">EMP</option>
									<option value="ILOG">ILOG</option>
								</form:select></td>
							<td><form:select path="pbc1">
									<option value="1">1</option>
									<option value="2+">2+</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</form:select></td>
							<td><form:select path="pbc2">
									<option value="1">1</option>
									<option value="2+">2+</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</form:select></td>
							<td><form:select path="pbc3">
									<option value="1">1</option>
									<option value="2+">2+</option>
									<option value="2">2</option>
									<option value="3">3</option>
								</form:select></td>
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