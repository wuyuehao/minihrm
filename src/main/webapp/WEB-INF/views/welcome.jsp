<%@page contentType="text/html;Charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span2">
			<!--Sidebar content-->
			<sec:authorize access="isAnonymous()">
				<h3>
					<fmt:message key="welcome.login.title" />
				</h3>
				<form class="form-horizontal well" name='f'
					action="<c:url value='/j_spring_security_check' />" method='POST'>
					<fieldset>
						<div class="control-group">
							<label class="label-control">User</label> <input type='text'
								class="input" name='j_username' value=''>
						</div>

						<div class="control-group">
							<label class="label-control">Password:</label> <input
								class="input" type='password' name='j_password' />
						</div>
						<input class="btn btn-success" name="submit" type="submit"
							value="submit" /> <input class="btn" name="reset" type="reset" />
					</fieldset>
				</form>
			</sec:authorize>
			<sec:authorize
				access="hasAnyRole('ROLE_CDL B2B SHANGHAI MGR', 'ROLE_MINIHRM TEST GROUP')">
				<h3>
					<fmt:message key="welcome.username" />
					<sec:authentication property="principal.username" />
				</h3>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_CDL B2B SHANGHAI MGR')">
				<li><a href="employees"><fmt:message
							key="welcome.menu.employees" /> </a>
				</li>
				<li><a href="#" onclick=createprofile('<sec:authentication property="principal.username"/>')><fmt:message
							key="welcome.menu.profile.team" /> </a>

					<div class="progress progress-danger progress-striped active"
						style="margin-bottom: 9px;">
						<div id="pbar" class="bar" style="width: 0%"></div>
					</div>
					<div id="mbar"></div>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
			
				<li><a href="profile"><fmt:message
							key="welcome.menu.profile" /> </a>
				</li>



				<li><fmt:message
							key="welcome.menu.follow" />
				</li>
				<table class="table">
					<c:forEach items="${users}" var="user">
						<tr>
							<td>${user.username}</td>
							<td><button id="${user.username}"
									class="btn btn-success btn-small" onclick="follow(this.id)">
									<script>
							document
									.write('${user.followed? "Unfollow": "Follow"}')
						</script>
								</button></td>
						</tr>
					</c:forEach>
				</table>
			</sec:authorize>
		</div>

		<div class="span10">
			<!--Body content-->
			<div class="leaderboard">
				<sec:authorize access="isAuthenticated()">
					<form class="form-horizontal well" action="/minihrm/timeline"
						method="post">
						<fieldset>
							<legend>What's New Today</legend>
							<div class="control-group">
								<div class="controls">
									<textarea id="textarea" name="msg" class="input-xlarge, span6"
										rows="5"></textarea>
								</div>
							</div>
							<div class="form-actions">
								<button class="btn btn-primary" type="submit">Save</button>
								<button class="btn" type="reset">Cancel</button>
							</div>
						</fieldset>
					</form>
					<div class="row-fluid">
						<c:forEach items="${messages}" var="msg">
							<div class="span10">
								<table class="table">

									<tr>
										<td><h3>${msg.sender}</h3></td>
									</tr>

									<tr>
										<td>${msg.msg}</td>
									</tr>

									<tr>
										<td align="right">Up | Forward | Comment | Delete</td>
									</tr>
								</table>
							</div>
						</c:forEach>
					</div>

				</sec:authorize>
			</div>
			<div class="row-fluid">
				<div class="span4">
					<h2>Backlog</h2>
					<p>
					<ul>
						<li>tip for deletion</li>
						<li>error handling for duplicated email</li>
						<li>Social portal. let employee talk to each other in social
							way.</li>
						<li>Add an alert system to highlight info</li>
						<li>Enhance alert system to send notification</li>
						<li>HTTPS</li>
						<li>Charting, by requirements</li>
						<li>excel export/import</li>
						<li>Dynamically update. 0 outage</li>
						<li>Incell editing not working with IE</li>
						<li>Remember Me!</li>
						<li>Server side g11n</li>
					</ul>
					<p>
						<a class="btn btn-success btn-large" href="#">More</a>
					</p>
				</div>
				<div class="span4">
					<h2>History</h2>
					<p>
					<ul>Version 0.3 - 2012-12-4
					</ul>
					<ul>
						<ul>
							<li>Add an employee portal, let them maintain their own
								non-confidential profile.</li>
							<li>Add a service for importing direct report's basic
								profile as a batch</li>
							<li>Add two level sorting</li>
							<li>Add a column for remark</li>
							<li>Sorting does not affect people not managed by you</li>
							<li>Make email unique. TODO : error handling</li>
						</ul>
					</ul>

					<ul>Version 0.2.1 - 2012-11-27
					</ul>
					<ul>
						<ul>
							<li>Add highlight for onband date and PMR; Add "D" for PBC
								(Thanks Sirius and Cindy)</li>
							<li>Expose non-confidential info to all users (Thanks
								Sirius)</li>
							<li>Bug fixes:</li>
							<ul>
								<li>Fixed salary validation problem; Fixed unicode support
									(reported by Sirius)</li>
							</ul>

							<li>Add Ldap/bluegroup authentication</li>
							<li>Integrate login page with welcome page, simplify web
								flows</li>
						</ul>
					</ul>

					<ul>Version 0.2 - 2012-11-26
					</ul>
					<ul>
						<ul>
							<li>Add sorting</li>
							<li>Add Ldap/bluegroup authentication</li>
							<li>Integrate login page with welcome page, simplify web
								flows</li>
						</ul>
					</ul>

					<a class="btn btn-success btn-large" href="#">More</a>
				</div>
			</div>
		</div>
	</div>

	<footer>
		<p>Locale = ${pageContext.response.locale}</p>
		<hr>
		<ul>
			<li><a href="?locale=zh_cn">中文</a> | <a href="?locale=en_us">English</a>
				| <a href="?locale=es_es">es</a> | <a href="?locale=de_de">de</a>
			</li>
		</ul>
	</footer>
</div>
<!-- /container -->

<html>
<script src="/minihrm/js/dojo/dojo.js"></script>

<script>
	function createprofile(name) {
		require([ "dijit/ProgressBar", "dojo/ready" ], function(ProgressBar,
				ready) {
			ready(function() {
				dojo.byId("mbar").innerHTML = "";
				var ws = new WebSocket("ws://${node_server}:8888/");
				ws.onmessage = function(evt) {
					console.log(evt);
					var obj = JSON.parse(evt.data);

					if (obj.json != null) {
						post(dojo.toJson(obj.json), obj.msg);
					} else {
						dojo.byId("mbar").innerHTML += '<li>' + obj.msg
								+ '</li>';
					}
					dojo.style("pbar", {"width": obj.interval+'%'});
				};

				ws.onclose = function() {
				};

				ws.onopen = function() {
					ws.send(name);
				};
			});
		});
	}

	if (!window.WebSocket) {
		alert("WebSocket not supported by this browser!");
	}
</script>

<script>
	function post(json, msg) {
		var xhrArgs = {
			url : "/minihrm/employees/json",
			postData : json,
			contentType : "application/json",
			load : function(data) {
				dojo.byId("mbar").innerHTML += "<li>" + msg + " - " + data
						+ "</li>";
			},
			error : function(error) {
				// dojo.byId("legend").innerHTML = error;
			}
		}
		dojo.xhrPost(xhrArgs);
	}
</script>
<script>
	function follow(name) {
		var xhrArgs = {
			url : "/minihrm/social/follow/" + name,
			handleAs : "text",
			load : function(data) {
				dojo.byId(name).innerHTML = data;
			},
			error : function(error) {
				// dojo.byId("legend").innerHTML = error;
			}
		}
		dojo.xhrPost(xhrArgs);
	}

	//alert('${users}');
</script>

</html>