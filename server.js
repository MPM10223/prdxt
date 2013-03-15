var http = require('http');
var url = require('url');

function start(route, handle) {
	var port = process.env.PORT || 1337;

	function onRequest(req, res) {
	  var pathname = url.parse(req.url).pathname;
	  console.log('Request for ' + pathname + ' received.');
	  route(handle, pathname, res, req);
	}

	http.createServer(onRequest).listen(port);
	console.log('Server has started.');
}

exports.start = start;