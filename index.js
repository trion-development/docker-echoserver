const http = require("http");
const port = 3000;

var process = require('process')
process.on('SIGINT', () => {
  console.info("Interrupted")
  process.exit(0)
});
process.on('SIGTERM', () => {
  console.info("TERM")
  process.exit(0)
});



http
  .createServer((req, res) => {
    const headers = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "OPTIONS, POST, GET, PUT",
      "Access-Control-Max-Age": 2592000, // 30 days
      "Access-Control-Allow-Headers": "*",
      "Content-Type": "text/plain",
    };

    if (req.method === "OPTIONS") {
      res.writeHead(204, headers);
      res.end();
      return;
    }

    if (["GET", "POST", "PUT"].indexOf(req.method) > -1) {
      res.writeHead(200, headers);
      let body = [];
      req.on('data', (chunk) => {
        body.push(chunk);
      }).on('end', () => {
        body = Buffer.concat(body).toString();

        res.write("(server latest)\n")
        res.write("headers\n")
        res.write("===============\n\n")

        for (const header in req.headers) {
            res.write(`${header}: ${req.headers[header]}\n`);
        }
        res.write("\n\n");
        res.write("body\n")
        res.write("===============\n\n")

        res.write(body);
        res.write("\n\n===============\nend.\n")
        res.end();
      });
      return;
    }

    res.writeHead(405, headers);
    res.end(`${req.method} is not allowed for the request.`);
  })
  .listen(port);
console.log("listening on port " + port);