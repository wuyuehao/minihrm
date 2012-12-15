<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script src="/minihrm/js/dojo/dojo.js"></script>
<script src="/minihrm/js/bootstrap.js"></script>
<link href="/minihrm/css/bootstrap.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>  
<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>  
<![endif]-->
<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="btn btn-navbar" data-toggle="collapse"
				data-target=".nav-collapse"> <span class="icon-bar"></span> <span
				class="icon-bar"></span> <span class="icon-bar"></span> </a> <a
				class="brand" href="#"><img src="/images/w3r.png" width="111"
				height="30" alt="w3resource logo" />
			</a>
			<div class="nav-collapse">
				<ul class="nav">
					<li class="active"><a href="#">Home</a>
					</li>
					<li><a href="#about">About</a>
					</li>
					<li><a href="#contact">Contact</a>
					</li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
</div>
<div class="container">
	<!-- Main hero unit for a primary marketing message or call to action -->
	<div class="leaderboard">
		<h1>w3resource Web Store</h1>
		<p>Try and purchase HTML5, JS, Ruby, PHP-MySQL based web apps to
			enhance your productivity at affordable price.</p>
		<p>
			<a class="btn btn-success btn-large">Sign Up for a 30 day free
				trial</a>
		</p>
	</div>
	<!-- Example row of columns -->
	<div class="row">
		<div class="span4">
			<h2>HTML5 and JS Apps</h2>
			<p>Donec id elit non mi porta gravida at eget metus. Fusce
				dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,ut
				fermentum massa justo sit amet risus. Etiam porta sem malesuada
				magna mollis euismod. Donec sed odio dui.</p>
			<p>
				<a class="btn btn-success btn-large" href="#">View apps</a>
			</p>
		</div>
		<div class="span4">
			<h2>Ruby Apps</h2>
			<p>Donec id elit non mi porta gravida at eget metus. Fusce
				dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,ut
				fermentum massa justo sit amet risus. Etiam porta sem malesuada
				magna mollis euismod. Donec sed odio dui.</p>
			<p>
				<a class="btn btn-success btn-large" href="#">View apps</a>
			</p>
		</div>
		<div class="span4">
			<h2>PHP MySQL Apps</h2>
			<p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in,
				egestas eget quam. Vestibulum id ligula porta felis euismod semper.
				Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum
				nibh, ut fermentum massa justo sit amet risus.</p>
			<p>
				<a class="btn btn-success btn-large" href="#">View apps</a>
			</p>
		</div>
	</div>
	<hr>
	<footer>
		<p>© Company 2012</p>
	</footer>
</div>
<!-- /container -->
<html>

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
<body>

	<!-- Navbar
================================================== -->
	<section id="navbar">
		<div class="page-header">
			<h1>Mini HRM</h1>
		</div>
		<div class="navbar">
			<div class="navbar-inner">
				<div class="container" style="width: auto;">
					<a class="btn btn-navbar" data-toggle="collapse"
						data-target=".nav-collapse"> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> </a> <a
						class="brand" href="#">Project name</a>
					<div class="nav-collapse">
						<ul class="nav">
							<li class="active"><a href="#">Home</a>
							</li>
							<li><a href="#">Link</a>
							</li>
							<li><a href="#">Link</a>
							</li>
							<li><a href="#">Link</a>
							</li>
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Dropdown <b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><a href="#">Action</a>
									</li>
									<li><a href="#">Another action</a>
									</li>
									<li><a href="#">Something else here</a>
									</li>
									<li class="divider"></li>
									<li><a href="#">Separated link</a>
									</li>
								</ul></li>
						</ul>
						<form class="navbar-search pull-left" action="">
							<input type="text" class="search-query span2"
								placeholder="Search">
						</form>
						<ul class="nav pull-right">
							<li><a href="#">Link</a>
							</li>
							<li class="divider-vertical"></li>
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Dropdown <b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><a href="#">Action</a>
									</li>
									<li><a href="#">Another action</a>
									</li>
									<li><a href="#">Something else here</a>
									</li>
									<li class="divider"></li>
									<li><a href="#">Separated link</a>
									</li>
								</ul></li>
						</ul>
					</div>
					<!-- /.nav-collapse -->
				</div>
			</div>
			<!-- /navbar-inner -->
		</div>
		<!-- /navbar -->

	</section>
	<table>

		<c:forEach items="${users}" var="user">
			<tr>
				<td>${user.username}</td>
				<td><button id="${user.username}"
						class="btn btn-success btn-small" onclick="follow(this.id)">
						<script>
							document
									.write('${user.followed? "Unfollow": "Follow"}')
						</script>
					</button>
				</td>
			</tr>
		</c:forEach>
	</table>

</body>

</html>