var WebSocketServer = require('websocket').server;
var http = require('http');


var server = http.createServer(function(request, response) {
	// process HTTP request. Since we're writing just WebSockets server
	// we don't have to implement anything.
});
server.listen(8888, function() {
});

// create the server
wsServer = new WebSocketServer({
	httpServer : server
});

// WebSocket server
wsServer.on('request', function(request) {
	var connection = request.accept(null, request.origin);

	// This is the most important callback for us, we'll handle
	// all messages from users here.
	connection.on('message', function(message) {
		if (message.type === 'utf8') {
			console.log("connected");
			var name = message.utf8Data;
			
			var request = require('request');
			request('http://bluepages.ibm.com/BpHttpApisv3/wsapi?byInternetAddr='+name, function (error, response, body) {
			  if (!error && response.statusCode == 200) {
			    var str = body.replace(new RegExp("\n","gm"),'","').replace(new RegExp(":","gm"),'":"');
			    var obj = JSON.parse('{"' +str.substring(0, str.indexOf('#')-2) + '}');
			    request('http://bluepages.ibm.com/BpHttpApisv3/wsapi?directReportsOfLite='+obj.CNUM.trim(), process);
			  }
			});
			
			function process(error, response, body){
				
				var msg = new Array;
				var person ='{';
				var all = new Array();
				body.split('\n').forEach(function(line, index, array){
					var p = new RegExp(/(.+): (.+)/);
					var m = line.match(p);
					if(m!=null && m.length ==3){
						if(m[1] == 'NAME'){
							m[1] = 'name'
								console.log('Found: ' +m[2]);
							msg.push('Found: '+ m[2]);
						}else if(m[1] == 'NOTESID'){
							m[1] = 'notesid';
							m[2] = m[2].replace(new RegExp(/CN=|OU=|O=|@IBMCN/g), '');
							console.log('notesid: ' + m[2]);
						}else if (m[1] == 'INTERNET'){
							m[1] = 'email';
						}else if (m[1] == 'EMPNUM'){
							m[1] = 'sn';
						}else if (m[1] == 'XPHONE'){
							m[1] = 'mp';
						}else if (m[1] !='MNUM'){
							return;
						}
						
						if (m[1] == 'MNUM'){
							person= person.substring(0, person.length-1) + '}';
							all.push(person);
							person='{';
						}else{
							person+= '"'+m[1]+'":"'+m[2]+'"';
							person+=',';
						}
					}
				});
				console.log(all);
				
				connection.send('{ "interval":"20", "msg":"Preparing..."}');
				
				console.log(all.length);
				var interval = 80/all.length;
				var i =1;
				
				all.forEach(function(obj){
					// 
					connection.send('{ "interval":"'+(20+i*interval)+'", "msg":"'+msg[i-1] + '", "json":'+all[i-1]+'}');
					sleep(700);
					i++;
					
				})
				
				connection.send('{ "interval":"100", "msg":"Done"}');
			}
		}
	});
});
				
function sleep(milliSeconds) {
	var startTime = new Date().getTime();
	while (new Date().getTime() < startTime + milliSeconds)
		;
}
