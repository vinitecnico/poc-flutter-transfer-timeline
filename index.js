var express = require('express')
var app = express();

app.use(express.static(__dirname + '/web'));

app.get('/node', function (req, res) {
    var html = "<h1>Aqui é Node.js!</h1><h1><a href='/static/nginx.html'>Ir para Nginx</a></h1>";
    res.send(html);
});

app.listen(3000);