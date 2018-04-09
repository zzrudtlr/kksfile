/**
 * http://usejsdoc.org/
 */
var http = require('http');
var test_module = require('./home');

function onRequest(request, response) {  
    response.writeHead(200, {'Content-Type' : 'text/plain'});
    response.write('Hello World');
   //
    response.end();
}

http.createServer(onRequest).listen(8080,function(){
	console.log('Server is started...');
}); 

