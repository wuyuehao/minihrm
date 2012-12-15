	dojo.require("dojo.dom");
	dojo.require("dojo.NodeList-traverse");
	dojo.require("dojo.NodeList");
	dojo.require("dojo.query");
	dojo.require("dojo.dom-construct");
	dojo.require("dojo.dom-attr");
	dojo.require("dojox.validate");
	dojo.require("dojox.validate.web");
	dojo.require("dojo.date");
	dojo.require("dojo.date.locale");
	dojo.require("dojox/charting/Chart");
	dojo.require("dojox/charting/themes/Claro");
	
	function todate(date, flag, limit){
		  if(date == undefined || date.length==0){
			  return "<td></td>";
		  }
		  var date = dojo.date.locale.parse(date, {datePattern: "yyyy-MM-dd", selector: "date"});
		  var diff = dojo.date.difference(date, null, flag);
		  var ret;
		  
		  if(limit ==undefined || diff < limit){
			  ret = "<td>"+ diff + "" + flag[0] + "</td>";
		  }else{
			  ret = "<td class='highlight'>"+diff + flag[0] + "</td>";
		  }
		  return ret;
	}
	
	function toPmr(salary, limit){
		if(limit == undefined || salary < limit ){
			return "<td>"+ Math.ceil(salary) +"</td>";
		}else{
			return "<td class='highlight'>"+ Math.ceil(salary) +"</td>";
		}
	}
	  
	function del(id, td) {
			var xhrArgs = {
				url : "/minihrm/employees/" + id,
				handleAs : "text",
				load : function(data) {
					dojo.byId("ajaxupdate").innerHTML = data;
			    	  dojo.style("ajaxupdate", {
			    		  "position": "absolute",
			              "opacity": 1,
			              "color" : 'white',
			              "left": dojo.position(td).x,
			              "top" : dojo.position(td).y
			              });
			          var fadeArgs = {
			            node: "ajaxupdate",
			            duration: 5000,
			          };
			          dojo.fadeOut(fadeArgs).play();
				},
				error : function(error) {
					// We'll 404 in the demo, but that's okay. We don't have a
					// 'postIt' service on the
					// docs server. This is fine. Just treat it as a success for
					// purposes of the example.
					// dojo.byId("response").innerHTML = "Delete completed";
				}
			}
			dojo.xhrDelete(xhrArgs);
			window.location.reload();
	}
	
	function edit(id) {
		
		var s=id.split("_");
		var eid=s[0];
		var name = s[1];
		var td = dojo.byId(id);
		var text = td.innerHTML;
		// prepare a edit node
		var rid = "input_"+name;
		var rinput = dojo.clone(dojo.byId(rid).firstChild);
		// alert(rinput);
		// var replacecontent = replace.children()[0].clone();
		dojo.setAttr(rinput, "onblur", "update(this.value, this.parentNode.id)");
		rinput.value = text;
		dojo.removeAttr(id, "ondblclick");
		
		
		// var append = "<input type=\"text\" class=\"tonytextbox\" name=\""+
		// name +"\" value =\" "+ text +"\" onblur=\"update(this.value,
		// this.parentNode.id)\"/> ";
		// alert(append);
		dojo.empty(td);
		dojo.place(rinput, td, "first");
		// td.innerHTML = rinput.outerHTML;
	}
	
	// value = this.value
	// id = id of td
	function update(value, id){
		if(validate(value, id)){
		
		// alert (value +":" + id)
		// will get error if some entity fileds contain a _
		var s=id.split("_");
		var eid=s[0];
		var name = s[1];
		var td = dojo.byId(id);
		td.innerHTML = value;
		dojo.setAttr(id, "ondblclick", "edit(this.id, '"+ name +"')");
		
		// ajax post
		
		var putMe = name + ":" +value;
		var xhrArgs = {
			      url: "/minihrm/employees/"+eid,
			      putData: putMe,
			      handleAs: "text",
			      load: function(data){
			        dojo.byId("ajaxupdate").innerHTML = data;
			    	  dojo.style("ajaxupdate", {
			    		  "position": "absolute",
			              "opacity": 1,
			              "color" : 'white',
			              "left": dojo.position(td).x,
			              "top" : dojo.position(td).y,
			              "height": dojo.position(td).h,
			              "width" : dojo.position(td).w
			              });
			          var fadeArgs = {
			            node: "ajaxupdate",
			            duration: 5000,
			          };
			          dojo.fadeOut(fadeArgs).play();
			      },
			      error: function(error){
			        // dojo.byId("legend").innerHTML = error;
			      }
			    }
			        dojo.byId("ajaxupdate").innerHTML = "Message being sent.";
		dojo.xhrPut(xhrArgs);
		}
	}
	
	function validate(value, id){
		var name = id.split("_")[1];
		var errormsg=check(value, name);
		dojo.byId("error").innerHTML=errormsg;
		// alert(errormsg + value);
		if(errormsg.length>0){
			return false;
		}
		return true;
	}
	
	function check(value, name){
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
				errormsg = "Date format is wrong";
			}
			break
		case "mp":
// if(!dojox.validate.isNumberFormat(value, {format: "#??????????"})){
// errormsg = "Telephone format is wrong";
// }
			break
		default:
		}
		return errormsg;
	}
	
	function checkall(){
		var errormsg="";
		
		dojo.query("[id^=input_]").forEach(function(node, index, array){ 
			var id=dojo.getAttr(node, "id");
			// alert(id);
			var name = id.split("_")[1];
			var value = dojo.byId(id).firstChild.value;
			var chkresult = check(value, name);
			if(chkresult.length>0){
				errormsg += "<li>"+check(value, name)+"</li>";
			}
		 }); 
		
		dojo.byId("error").innerHTML=errormsg;
		
		if(errormsg.length>0){
			return false;
		}
		return true;
		
	}
	
	function normalize(dir){
		if(dir == undefined || dir ==''){
			return "Asc";
		}
		return dir;
	}
	
	