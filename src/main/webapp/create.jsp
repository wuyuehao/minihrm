<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
	<META http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>Create Employee</title>
</head>	
<body>
<div class="container">
	<h1>
		Create Employee
	</h1>
	<div class="span-12 last">	
		<form:form modelAttribute="employee" action="employees" method="post">
		  	<fieldset>		
				<legend>Account Fields</legend>
				<p>
					<form:label	for="name" path="name" cssErrorClass="error">Name</form:label><br/>
					<form:input path="name" /> <form:errors path="name" />			
				</p>
				<p>	
					<form:label for="sn" path="sn" cssErrorClass="error">SN</form:label><br/>
					<form:input path="sn" /> <form:errors path="balance" />
				</p>
				<p>
					<form:label for="salary" path="salary" cssErrorClass="error">Salary</form:label><br/>
					<form:input path="salary" /> <form:errors path="equityAllocation" />
				</p>
				<p>	
					<form:label for="onboardDate" path="onboardDate" cssErrorClass="error">Onboard Date</form:label><br/>
					<form:input path="onboardDate" /> <form:errors path="renewalDate" />
				</p>
				<p>	
					<input type="submit" />
				</p>
			</fieldset>
		</form:form>
	</div>
	<hr>	
	<ul>
		<li> <a href="?locale=en_us">us</a> |  <a href="?locale=en_gb">gb</a> | <a href="?locale=es_es">es</a> | <a href="?locale=de_de">de</a> </li>
	</ul>	
</div>
</body>
</html>