<%@page contentType="text/html;Charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<jsp:include page="../header.jsp"></jsp:include>

<script src="/minihrm/js/dojo/dojo.js"></script>
<script src="/minihrm/js/tony/list.js"></script>
<script>
function sort(input, isPrimaryKey){
	
	// clicked on column
	var orderby = input.substring(3);
	
	// get 1st key and direction
	// current sorting column on display
	var current = '${sortby}';
	var dir = normalize('${sortdir}');
	
	// get 2nd key and direction
	var current2 = '${sortby2}';
	var dir2 = normalize('${sortdir2}');
	
	// sort on 1st key
	if(isPrimaryKey == true){
		// Reverse sorting if click on same button
		if(orderby == current){
			if(dir == "Asc"){
				dir ="Desc";
			}else{
				dir ="Asc";
			}
		}
		document.location = "/minihrm/employees/sort/"+ orderby +dir;
	}else{// sort on 2nd key
		// Reverse sorting if click on same button
		if(orderby == current2){
			if(dir2 == "Asc"){
				dir2 ="Desc";
			}else{
				dir2 ="Asc";
			}
		}
		// alert("/minihrm/employees/sort/"+ current +dir+"/"+orderby+dir2);
		document.location = "/minihrm/employees/sort/"+ current +dir+"/"+orderby+dir2;
	}
}
</script>


<!-- button.action_button { -->
<!-- 	width: 2em; -->
<!-- } -->

<!-- div.errormsg { -->
<!-- 	background-color: #E0FFFF; -->
<!-- 	color: #FF8C00; -->
<!-- 	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif; -->
<!-- } -->
<!-- </style> -->
<!-- <style type="text/css"> -->
<!-- #employees { -->
<!-- 	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif; -->
<!-- 	width: 100%; -->
<!-- 	border-collapse: collapse; -->
<!-- } -->
<style type="text/css">
#employees td {
	font-size: 0.8em;
	padding: 3px 7px 2px 7px;
	cursor: pointer;
}
#employees td.highlight {
	font-size: 0.8em;
	border: 1px solid #98bf21;
	padding: 3px 7px 2px 7px;
	cursor: pointer;
	background-color: red;
}
#employees tr.alt td {
	padding-left: 1px;
	padding-right: 1px;
	border: 0px;
}
input.tonytextbox { 
width: 100%; 
} 
select.tonytextbox { 
width: 100%; 
} 

</style>

<!-- #employees th { -->
<!-- 	font-size: 0.8em; -->
<!-- 	text-align: center; -->
<!-- 	padding-top: 5px; -->
<!-- 	padding-bottom: 4px; -->
<!-- 	background-color: #A7C942; -->
<!-- 	color: #ffffff; -->
<!-- } -->

<!-- #employees th.sortable { -->
<!-- 	nowrap; -->
<!-- 	font-size: 0.8em; -->
<!-- 	text-align: center; -->
<!-- 	padding-top: 5px; -->
<!-- 	padding-bottom: 4px; -->
<!-- 	background-color: #387AFF; -->
<!-- 	color: #ffffff; -->
<!-- 	cursor: pointer; -->
<!-- } -->


<!-- </style> -->

<html>
<body>
	<div id="EmployeeTable"></div>
	<div align="center">
		<fmt:message key="employee.tip" />
	</div>
	<div id="ajaxupdate" style="background-color: Red;"></div>
	<div id="error" class="errormsg"></div>
	<sec:authorize
		access="hasAnyRole('ROLE_CDL B2B SHANGHAI MGR')">
		<table id="employees" class="table table-condensed table-bordered table-striped table-hover">
			<tr>
				<th>Action</th>
				<th class="sortable" id="th_name">Name <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> 
					<img src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th id="th_sn">SN</th>
				<th id="th_personelId">personel ID</th>
				<th id="th_notesid">Notes ID</th>
				<th class="sortable" id="th_band">Band <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> 
					<img src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)" />
				</th>
				<th id="th_email">Email</th>
				<th id="th_englishName">English Name</th>
				<th class="sortable" id="th_onboardDate"
					>Onboard <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> <img
					src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th></th>
				<th class="sortable" id="th_onbandDate"
					>Onband <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> <img
					src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th></th>
				<th class="sortable" id="th_onteamDate"
					>Onteam <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> <img
					src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th></th>
				<th>Birthday</th>
				<th></th>
				<th>University</th>
				<th>Phone</th>
				<th>Weibo</th>
				<th>Hometown</th>
				<th class="sortable" id="th_manager">Manager <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> 
					<img src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th>Gender</th>
				<th class="sortable" id="th_jobRole">Role <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> 
					<img src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th class="sortable" id="th_team">Team <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> 
					<img src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th>PBC 2011</th>
				<th>PBC 2010</th>
				<th>PBC 2009</th>
				<th class="sortable" id="th_salary">Salary <img src="/minihrm/resources/pics/sort1.png"
					onclick="sort(this.parentNode.id, true)"> 
					<img src="/minihrm/resources/pics/sort.png"
					onclick="sort(this.parentNode.id, false)">
				</th>
				<th id="th_pmr">PMR</th>
				<th>Remark</th>
			</tr>

			<c:forEach var="employee" items="${employees}">
				<tr id="row_${employee.id}">
					<td nowrap><button class="btn btn-danger btn-small" onclick="del(${employee.id},this.parentNode)">DEL</button>
					</td>
					<td id="${employee.id}_name" ondblclick="edit(this.id)">${employee.name}</td>
					<td id="${employee.id}_sn" ondblclick="edit(this.id)">${employee.sn}</td>
					<td id="${employee.id}_personelId" ondblclick="edit(this.id)">${employee.personelId}</td>
					<td id="${employee.id}_notesid" ondblclick="edit(this.id)">${employee.notesid}</td>
					<td id="${employee.id}_band" ondblclick="edit(this.id)">${employee.band}</td>
					<td id="${employee.id}_email" ondblclick="edit(this.id)">${employee.email}</td>
					<td id="${employee.id}_englishName" ondblclick="edit(this.id)">${employee.englishName}</td>
					<td id="${employee.id}_onboardDate" ondblclick="edit(this.id)">${employee.onboardDate}</td>
					<script type="text/javascript">document.write(todate('${employee.onboardDate}','month'))</script>
					<td id="${employee.id}_onbandDate" ondblclick="edit(this.id)">${employee.onbandDate}</td>
					<script type="text/javascript">document.write(todate('${employee.onbandDate}','month', '30'))</script>
					<td id="${employee.id}_onteamDate" ondblclick="edit(this.id)">${employee.onteamDate}</td>
					<script type="text/javascript">document.write(todate('${employee.onteamDate}','month'))</script>
					<td id="${employee.id}_birthday" ondblclick="edit(this.id)">${employee.birthday}</td>
					<script type="text/javascript">document.write(todate('${employee.birthday}','year'))</script>
					<td id="${employee.id}_university" ondblclick="edit(this.id)">${employee.university}</td>
					<td id="${employee.id}_mp" ondblclick="edit(this.id)">${employee.mp}</td>
					<td id="${employee.id}_weibo" ondblclick="edit(this.id)">${employee.weibo}</td>
					<td id="${employee.id}_hometown" ondblclick="edit(this.id)">${employee.hometown}</td>
					<td id="${employee.id}_manager" ondblclick="edit(this.id)">${employee.manager}</td>
					<td id="${employee.id}_gender" ondblclick="edit(this.id)">${employee.gender}</td>
					<td id="${employee.id}_jobRole" ondblclick="edit(this.id)">${employee.jobRole}</td>
					<td id="${employee.id}_team" ondblclick="edit(this.id)">${employee.team}</td>
					<td id="${employee.id}_pbc1" ondblclick="edit(this.id)">${employee.pbc1}</td>
					<td id="${employee.id}_pbc2" ondblclick="edit(this.id)">${employee.pbc2}</td>
					<td id="${employee.id}_pbc3" ondblclick="edit(this.id)">${employee.pbc3}</td>
					<td id="${employee.id}_salary" ondblclick="edit(this.id)"><fmt:formatNumber
							value="${employee.salary}" pattern="#0"></fmt:formatNumber>
					</td>
					<script type="text/javascript">document.write(toPmr('${employee.salary/bandmid[employee.band]*100}', 100))</script>
					
					<td id="${employee.id}_remark" ondblclick="edit(this.id)">${employee.remark}</td>

				</tr>
			</c:forEach>
			<form:form modelAttribute="employee" action="/minihrm/employees"
				method="post">
				<tr class="alt">
					<td><input type="submit" value="Add"
						onclick="return checkall();" />
					</td>
					<td id="input_name"><form:input class="tonytextbox"
							path="name" /> <form:errors path="name" /></td>
					<td id="input_sn"><form:input class="tonytextbox" path="sn"
							value="000000" /> <form:errors path="sn" />
					</td>
					<td id="input_personelId"><form:input class="tonytextbox"
							path="personelId" value="08000000" /> <form:errors
							path="personelId" /></td>
					<td id="input_notesid"><form:input class="tonytextbox"
							path="notesid" value="/China/IBM" /> <form:errors path="notesid" />
					</td>
					<td id="input_band"><form:select path="band" class="tonytextbox">
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="B90">B90</option>
						</form:select></td>
					<td id="input_email"><form:input class="tonytextbox"
							path="email" value="sam@cn.ibm.com" /> <form:errors path="name" />
					</td>
					<td id="input_englishName"><form:input class="tonytextbox"
							path="englishName" /> <form:errors path="name" /></td>

					<td id="input_onboardDate"><form:input class="tonytextbox"
							path="onboardDate" value="2010-7-1" /> <form:errors
							path="onboardDate" /></td>
					<td />
					<td id="input_onbandDate"><form:input class="tonytextbox"
							path="onbandDate" value="2011-7-1" /> <form:errors
							path="onboardDate" /></td>
					<td />
					<td id="input_onteamDate"><form:input class="tonytextbox"
							path="onteamDate" value="2012-7-1" /> <form:errors
							path="onboardDate" /></td>
					<td />
					<td id="input_birthday"><form:input class="tonytextbox"
							path="birthday" value="1982-7-1" /> <form:errors path="birthday" />
					</td>
					<td />
					<td id="input_university"><form:input class="tonytextbox"
							path="university" />
					</td>
					<td id="input_mp"><form:input class="tonytextbox" path="mp" />
					</td>
					<td id="input_weibo"><form:input class="tonytextbox"
							path="weibo" />
					</td>
					<td id="input_hometown"><form:input class="tonytextbox"
							path="hometown" />
					</td>

					<td />
					<td id="input_gender"><form:select path="gender" class="tonytextbox">
							<option value="M">M</option>
							<option value="F">F</option>
						</form:select></td>
					<td id="input_jobRole"><form:select path="jobRole" class="tonytextbox">
							<option value="QA">QA</option>
							<option value="Dev">Dev</option>
							<option value="Architect">Arch</option>
							<option value="PLM">PLM</option>
							<option value="PM">RM/PM</option>
						</form:select></td>
					<td id="input_team"><form:select path="team" class="tonytextbox">
							<option value="TMS">TMS</option>
							<option value="B2B">B2B</option>
							<option value="EMP">EMP</option>
							<option value="ILOG">ILOG</option>
						</form:select></td>
					<td id="input_pbc1"><form:select path="pbc1" class="tonytextbox">
							<option value="1">1</option>
							<option value="2+">2+</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="D">D</option>
						</form:select></td>
					<td id="input_pbc2"><form:select path="pbc2" class="tonytextbox">
							<option value="1">1</option>
							<option value="2+">2+</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="D">D</option>
						</form:select></td>
					<td id="input_pbc3"><form:select path="pbc3" class="tonytextbox">
							<option value="1">1</option>
							<option value="2+">2+</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="D">D</option>
						</form:select></td>
					<td id="input_salary"><form:input class="tonytextbox"
							path="salary" value="10000" /> <form:errors path="name" /></td>
					<td></td>
					<td id="input_remark"><form:input class="tonytextbox"
							path="remark" />
					</td>
				</tr>
			</form:form>
		</table>
	</sec:authorize>

	<!-- <c:forEach var="band" items="${bandmid}">
		${band.key}: ${band.value } <br />
	</c:forEach> -->

	<!-- create the chart -->
	<div id="chartNode" style="width: 500px; height: 450px;"></div>
	<div id="legend" style="width: 300px; height: 250px;"></div>
	<script>
	
// require([
//		 Require the basic chart class
// 		"dojox/charting/Chart",

//		Require the theme of our choosing
// 		"dojox/charting/themes/Claro",
		
//		Charting plugins: 

//			We want to plot a Pie chart
// 		"dojox/charting/plot2d/Pie",

//		Retrieve the Legend, Tooltip, and MoveSlice classes
// 		"dojox/charting/action2d/Tooltip",
// 		"dojox/charting/action2d/MoveSlice",
		
//			We want to use Markers
// 		"dojox/charting/plot2d/Markers",

//			We'll use default x/y axes
// 		"dojox/charting/axis2d/Default",
		
// 		"dojox/charting/widget/Legend",

//		Wait until the DOM is ready
// 		"dojo/domReady!"
// 	], function(Chart, theme, Pie, Tooltip, MoveSlice, Legend) {

// 		var list = dojo.query("[id$=_band]");
// 		list.pop();
// 		var a = [0,0,0,0,0];
// 		list.forEach(function(node, index, array){ 
// 			if(node.innerHTML == 'B90'){
// 				a[4]++;
// 			}else{
// 				a[node.innerHTML-6]++;
// 			}
// 		});
//		Define the data
// 		var chartData = [{x: 0, y : a[0]}, {x: 1, y : a[1]}, {x: 2, y : a[2]}, {x: 'band 9', y : a[3]}, {x: 'band 90', y : a[4]}];
	    
//		Create the chart within it's "holding" node
// 		var chart = new Chart("chartNode");

//		Set the theme
// 		chart.setTheme(theme);

//		Add the only/default plot 
// 		chart.addPlot("default", {
// 			type: Pie,
// 			markers: true,
// 			radius:200,
// 			labelStyle: 'default',
// 			label: true
			
// 		});
		
//		Add axes
// 		chart.addAxis("x", { min: 0, max: 30, vertical: true, fixLower: "minor", fixUpper: "major" });
// 		chart.addAxis("y", { min: 0, max: 30, vertical: true, fixLower: "minor", fixUpper: "major" });

//		Add the series of data
// 		chart.addSeries("Band Structure",chartData);
		
// 		var tooltipFormatter = function(o){
//			console.log(o);
// 			return ['band 6', 'band 7', 'band 8', 'band 9', 'band 90'][o.x];
// 		};
		
//		Create the tooltip
// 		var tip = new Tooltip(chart,"default", {text: tooltipFormatter});
		
//		Create the slice mover
		//		var mag = new MoveSlice(chart,"default");
		
		
//		Render the chart!
// 		chart.render();
		
// 		var legend = new Legend({ chart: chart }, "legend");

// 	});
         </script>
</body>
</html>