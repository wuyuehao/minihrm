<%@page contentType="text/html;Charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script src="/minihrm/js/bootstrap.js"></script>
<link href="/minihrm/css/bootstrap.css" rel="stylesheet">
<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>  
<script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>  
<![endif]-->
<div class="navbar ">
	<div class="navbar-inner">
		<div class="container">
			<a class="btn btn-navbar" data-toggle="collapse"
				data-target=".nav-collapse"> <span class="icon-bar"></span> <span
				class="icon-bar"></span> <span class="icon-bar"></span> </a> <a
				class="brand" href="#"><img src="/minihrm/images/w3r.png"
				width="111" height="30" alt="<fmt:message key="welcome.title" />" />
			</a>
			<div class="nav-collapse">
				<ul class="nav pull-right">
					<li class="active"><a href="/minihrm/timeline">Home</a></li>
					<li><a href="#about">About</a></li>
					<li><a href="/minihrm/j_spring_security_logout"><fmt:message
								key="logout" />
					</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
</div>