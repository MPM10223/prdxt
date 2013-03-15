/**
 * New node file
 */
var querystring = require('querystring'),
	fs = require('fs'),
	formidable = require('formidable');
 
function start(res) {
  console.log('Request handler _start_ was called.');
  
  var body = '<html>'+
  	'<head>'+
  	'<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'+
  	'</head>'+
  	'<body>'+
  	'<form action="/upload" enctype="multipart/form-data" method="post">'+
  	'<input type="file" name="upload" multiple="multiple">'+
  	'<input type="submit" value="Upload file" />'+
  	'</form>'+
  	'</body>'+
  	'</html>';
  
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write(body);
  res.end();
}

function upload(res, req) {
  console.log('Request handler _upload_ was called.');
  
  var form = new formidable.IncomingForm();
  console.log('about to parse');
  form.parse(req, function(error, fields, files) {
    console.log('parsing done');
    
    fs.rename(files.upload.path, './sql/test.jpg', function(err) {
      if(err) {
        fs.unlink('./sql/test.jpg');
        fs.rename(files.upload.path, './sql/test.jpg');
      }
    });
  
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write('received image:<br/>');
    res.write('<img src="/show" />');
    res.end();
  });
}

function show(res) {
  console.log('Request handler _show_ was called.');
  fs.readFile('./sql/test.jpg', 'binary', function(error, file) {
    if(error) {
      res.writeHead(500, {'Content-Type': 'text/plain'});
      res.write(err+'\n');
      res.end();
    } else {
      res.writeHead(200, {'Content-Type': 'image/png'});
      res.write(file, 'binary');
      res.end();
    }
  });
}

function login(res, req) {
  console.log('Request handler _login_ was called.');
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.write('hello login');
  res.end();
}

exports.start = start;
exports.upload = upload;
exports.show = show;