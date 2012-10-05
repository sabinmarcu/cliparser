var ERRORS = [
	"Beginning",
	"Application did not receive arguments!"
	], color, require = require || null;



try {
	color = require("colors")
	color = function(what: any, color: string) {
		return what[color];
	}
 } catch (e) {
	color = function(value: any) { return value }
}



class ErrorReporter {
	private errno : number;
	public  msg   : string;
	public  err   : string;

	constructor(errno: number){
		this.errno = errno;
		this.msg = ERRORS[this.errno];
		this.err = color("ERROR", "red") + " [" + this.errno + "]: " + this.msg;
	}
}

export class Parser{
	private argv : string[];
	private s    : string[];
	private ds   : {};
	private dds  : {};

	constructor(argv: string[]) {
		if (argv && argv.length > 0) {
			this.parse(argv)
		}
	}
	public parse(argv: string[]) {
		if (!argv || argv.length <= 0) { throw new ErrorReporter(1)	}

		this.argv            = argv
		var i : number       = 0;
		var resSet: string[] = [];

		this.s   = [];
		this.ds  = {};
		this.dds = {};

		while (this.argv[i] && this.argv[i][0] !== "-") this.s.push(this.argv[i++]);

		if (i < this.argv.length)
		while (i < this.argv.length) {
			if (this.argv[i][0] === "-") {
				resSet = this.walk(i + 1)

				if (this.argv[i][1] === "-") this.dds[this.argv[i].substr(2)] = resSet
				else this.ds[this.argv[i].substr(1)] = resSet;

				i += resSet.length + 1;
			}
		}
		return {
			"single": this.s,
			"dash": this.ds,
			"doubledash": this.dds
		}
	}
	private walk(from: number) {
		var list = []
		if (from >= this.argv.length) return [];
		while (this.argv[from] && this.argv[from][0] !==  "-") {
			list.push(this.argv[from])
			from++;
		}
		return list;
	}
	public dash() { return this.ds }
	public doubledash() { return this.dds }
}
