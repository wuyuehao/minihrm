<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="js/jquery/jquery-1.8.2.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.9.1.custom/js/jquery-ui-1.9.1.custom.min.js"
	type="text/javascript"></script>

<!-- Include one of jTable styles. -->
<link href="js/jtable/themes/standard/blue/jtable_blue.css"
	rel="stylesheet" type="text/css" />

<!-- Include jTable script file. -->
<script src="js/jtable/jquery.jtable.min.js" type="text/javascript"></script>

<html>
<body>
	<div id="PersonTableContainer"></div>

	<table>
		<tr>
			<td>Name</td>
			<td>SN</td>
			<td>personel ID</td>
			<td>Notes ID</td>
			<td>Email</td>
			<td>English Name</td>
			<td>Salary</td>
			<td>Onboard Date</td>
			<td>Onband Date</td>
			<td>Onteam Date</td>
			<td>Manager</td>
			<td>Gender</td>
			<td>Job Role</td>
			<td>Team</td>
			<td>PBC 1</td>
			<td>PBC 2</td>
			<td>PBC 3</td>
		</tr>
		<!-- could be genereate according to Entity? -->
		<tr>
			<td>${employee.name}</td>
			<td>${employee.sn}</td>
			<td>${employee.personelId}</td>
			<td>${employee.notesid}</td>
			<td>${employee.email}</td>
			<td>${employee.englishName}</td>
			<td>${employee.salary}</td>
			<td>${employee.onboardDate}</td>
			<td>${employee.onbandDate}</td>
			<td>${employee.onteamDate}</td>
			<td>${employee.manager}</td>
			<td>${employee.gender}</td>
			<td>${employee.jobRole}</td>
			<td>${employee.team}</td>
			<td>${employee.pbc1}</td>
			<td>${employee.pbc2}</td>
			<td>${employee.pbc3}</td>
		</tr>

	</table>

</body>

</html>