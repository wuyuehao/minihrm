<%@page contentType="text/html;Charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
	<jsp:include page="../header.jsp"></jsp:include>

<head>
<META  http-equiv="Content-Type"  content="text/html;charset=UTF-8">
<title>Create Account</title>
</head>
<script src="/minihrm/js/dojo/dojo.js"></script>
<script>
dojo.require("dojox.validate");
dojo.require("dojox.validate.web");


function check(name, value){
		var errormsg ="";
		switch(name){
		case "name":
			// alert(value.length);
			
			// why the 2nd param is surounding with {}
			if(!dojox.validate.isText(value, {minlength:2,maxlength:20})){
				// alert(value);
				errormsg = "Name must be 2-20 charaters";
			}
			break
		case "sn":
			if(!dojox.validate.isNumberFormat(value, {format: "######"})){
				errormsg = "SN format is wrong";
			}
			break
		case "personelId":
			if(!dojox.validate.isNumberFormat(value, {format: "########"})){
				errormsg = "Personel ID format is wrong";
			}
			break
		case "notesid":
			if(!dojox.validate.isText(value, {minlength:10})){
				errormsg = "Notes format is wrong";
			}
			break
		case "email":
			if(!dojox.validate.isEmailAddress(value)){
				errormsg = "Email format is wrong";
			}
			break
		case "englishName":
			if(!dojox.validate.isText(value, {minlength:2,maxlength:20})){
				// alert(value);
				errormsg = "English name must be 2-20 charaters";
			}
			break
		case "salary":
			if(!dojox.validate.isNumberFormat(value, {format: "####?"})){
				errormsg = "Salary format is wrong";
			}
			break
		case "onboardDate":
		case "onbandDate":
		case "onteamDate":
		case "birthday":
			if(!dojox.validate.isNumberFormat(value, {format: "####-#?-#?"})){
				errormsg = "YYYY-MM-DD is the format";
			}
			break
		case "mp":
			if(!dojox.validate.isNumberFormat(value, {format: "#??????????"})){
				errormsg = "only numbers 0-9 are accepted";
			}
			break
		default:
		}
		return errormsg;
	}
	
	function edit(td, select) {
		var text = td.innerHTML;
		dojo.removeAttr(td, "onclick");
		// prepare a edit node
		var input;
		if(select){
			input = "<select value='"+text+"' onblur='update("+td.id+", this.value, true)'> <option value='M'>M</option><option value='F'>F</option></select>";			
		}else{
			input = "<input type='text' value='"+text+"' size='25' onblur='update("+td.id+", this.value)'/>";
		}
		td.innerHTML = input;
	}

	function validate(name, value){
		var errormsg = check(name, value);
		
		if(errormsg != ""){
			showmsg("errormsg", name, errormsg);
			return false;
		}
		return true;
	}
	
	function showmsg(id, td, text){
		dojo.byId(id).innerHTML = text;
		dojo.style(id, {
			"position" : "absolute",
			"opacity" : 1,
			"color" : 'white',
			"left" : dojo.position(td).x,
			"top" : dojo.position(td).y,
			"width" : dojo.position(td).w,
			"height" : dojo.position(td).h
		});
		var fadeArgs = {
			node : id,
			duration : 5000,
		};
		dojo.fadeOut(fadeArgs).play();
	}
	// value = this.value
	// id = id of td
	function update(td, value, select) {
		var name = td.id;
		if (validate(name, value)) {
			var putMe = name + ":" + value;
			var xhrArgs = {
				url : "/minihrm/employees/" + ${employee.id},
				putData : putMe,
				handleAs : "text",
				load : function(data) {
					showmsg("ajaxupdate", td, data);
				},
				error : function(error) {
					showmsg("errormsg", td, error);
				}
			}
			dojo.xhrPut(xhrArgs);
		td.innerHTML=value;
		dojo.setAttr(td, "onclick", "edit(this, "+ select+")");
		}
	}
</script>
<body>
	<div id="ajaxupdate" style="background-color: Green;"></div>
	<div id="errormsg" style="background-color: Red;"></div>
	<div class=well>
	<div class="container">
		<h1>Maintain Your Profile Here</h1>

		<div class="alert alert-info">
			<a class="close">×</a> <h4><strong>Tip: </strong> Edit your profile inline.
			Click the one you want to update!</h4>
		</div>

		<div class="span12 last">
			<table id="employees"
				class="table table-boardered table-striped table-hover table-">

				<tr>
					<td><span class="badge badge-default">Fixed</span> Name:</td>
					<td>${employee.name}</td>
				</tr>

				<tr>
					<td><span class="badge badge-default">Fixed</span> SN:</td>
					<td>${employee.sn}</td>
				</tr>

				<tr>
					<td><span class="badge badge-default">Fixed</span> Manager:</td>
					<td>${employee.manager}</td>
				</tr>

				<tr>
					<td><span class="badge badge-default">Fixed</span> Email:</td>
					<td>${employee.email}</td>
				</tr>

				<tr>
					<td><span class="badge badge-default">Fixed</span> Notesid:</td>
					<td>${employee.notesid}</td>
				</tr>

				<tr>
					<td><span class="badge badge-success">Editable</span> Gender:</td>
					<td id="gender" onclick="edit(this, true)">${employee.gender}</td>
				</tr>

				<tr>
					<td><span class="badge badge-success">Editable</span> English Name:</td>
					<td id="englishName" onclick="edit(this)">${employee.englishName}</td>
				</tr>

				<tr>
					<td><span class="badge badge-success">Editable</span> University:</td>
					<td id="university" onclick="edit(this)">${employee.university}</td>
				</tr>
				<tr>
					<td><span class="badge badge-success">Editable</span> Mobile Phone:</td>
					<td id="mp" onclick="edit(this)">${employee.mp}</td>
				</tr>

				<tr>
					<td><span class="badge badge-success">Editable</span> Weibo:</td>
					<td id="weibo" onclick="edit(this)">${employee.weibo}</td>
				</tr>
				<tr>
					<td><span class="badge badge-success">Editable</span> Hometown:</td>
					<td id="hometown" onclick="edit(this)">${employee.hometown}</td>
				</tr>

				<tr>
					<td><span class="badge badge-success">Editable</span> Birthday:</td>
					<td id="birthday" onclick="edit(this)">${employee.birthday}</td>
				</tr>

			</table>

		</div>
	</div>
	</div>

	<footer>
		<p>Locale = ${pageContext.response.locale}</p>
		<hr>
		<ul>
			<li><a href="?locale=zh_cn">中文</a> | <a href="?locale=en_us">English</a>
				| <a href="?locale=es_es">es</a> | <a href="?locale=de_de">de</a></li>
		</ul>
	</footer>
</body>
</html>