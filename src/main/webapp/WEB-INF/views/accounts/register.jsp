
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<title>Login Page</title>
<style>
.errorblock {
	color: #ff0000;
	background-color: #ffEEEE;
	border: 3px solid #ff0000;
	padding: 8px;
	margin: 16px;
}

div.errormsg {
	background-color: #E0FFFF;
	color: #FF8C00;
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
}
</style>
<script src="/minihrm/js/dojo/dojo.js"></script>
<script>
dojo.require("dojox.validate");

function validate(value, name){
	var errormsg=check(value, name);
	dojo.byId("error").innerHTML=errormsg;
	//alert(errormsg + value);
	if(errormsg.length>0){
		return false;
	}
	return true;
}

function check(value, name){
		var errormsg ="";
		switch(name){
		case "username":
			//alert(value.length);
			
			// why the 2nd param is surounding with {}
			if(!dojox.validate.isText(value, {minlength:6,maxlength:20})){
				//alert(value);
				errormsg = "Name must be 6-20 charaters";
			}
			break
		case "password":
			if(!dojox.validate.isText(value, {minlength:6,maxlength:20})){
				errormsg = "Password must be 6+ charaters";
			}
			break
		default:
		}
		
		return errormsg;
	}
	
	function checkall(){
		
		var errormsg=""
		var temp=check(dojo.byId("username").value, "username");
		if(temp.length>0){
			errormsg="<li>"+temp+"</li>";
		}
		
		if(check(dojo.byId("pwd").value,"password").length>0 || check(dojo.byId("pwd2").value,"password").length>0){
			
		errormsg+="<li>password must have 6+ characters</li>";
			
		}
		
		
		if(dojo.byId("pwd").value != dojo.byId("pwd2").value){
			errormsg+="<li>2 passwords entered are different</li>";
		}
		
		dojo.byId("error").innerHTML=errormsg;
		
		//alert(errormsg);
		if(errormsg.length>0){
			return false;
		}
		return true;
		
	}
	</script>
</head>
<body>
	<h3>Register a new user</h3>
	
	<form:form modelAttribute="manager" action="/minihrm/accounts/register"
		method="post">
		<fieldset>
			<table>
				<tr>
					<td>Account Name</td>
				</tr>
				<tr>
					<td><form:input id="username" path="username"
							onblur="checkall()" /> <form:errors path="username"/></td>
				</tr>

				<tr>
					<td><form:input id="pwd" type="password" path="password"
							onblur="checkall()" />
					</td>
				</tr>
				<tr>
					<td><input id="pwd2" type="password" name="password2"
						onblur="checkall()" />
					</td>
				</tr>
				<tr>
					<td><input type="hidden" name="authority" value="ROLE_USER" />
					<input type="hidden" name="enabled" value="true" /></td>
				</tr>
			</table>
			<p>
				<input type="submit" value="SUBMIT" onclick="return checkall()" />
			</p>
		</fieldset>
	</form:form>
	<div id="error" class="errormsg"></div>
	
	<div id="res"><a href="/minihrm/login">Login</a></div>
</body>
</html>
