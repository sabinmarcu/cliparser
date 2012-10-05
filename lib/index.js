var CLI = require("./parser"),
Parser  = new CLI.Parser();

try	{
	console.log(Parser.parse(process.argv))
} catch (e) {
	console.log(e.err || e.error || e);
}
