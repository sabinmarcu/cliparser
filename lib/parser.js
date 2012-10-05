var ERRORS = [
    "Beginning", 
    "Application did not receive arguments!"
];
var color;
var require = require || null;

try  {
    color = require("colors");
    color = function (what, color) {
        return what[color];
    };
} catch (e) {
    color = function (value) {
        return value;
    };
}
var ErrorReporter = (function () {
    function ErrorReporter(errno) {
        this.errno = errno;
        this.msg = ERRORS[this.errno];
        this.err = color("ERROR", "red") + " [" + this.errno + "]: " + this.msg;
    }
    return ErrorReporter;
})();
var Parser = (function () {
    function Parser(argv) {
        if(argv && argv.length > 0) {
            this.parse(argv);
        }
    }
    Parser.prototype.parse = function (argv) {
        if(!argv || argv.length <= 0) {
            throw new ErrorReporter(1);
        }
        this.argv = argv;
        var i = 0;
        var resSet = [];
        this.s = [];
        this.ds = {
        };
        this.dds = {
        };
        while(this.argv[i] && this.argv[i][0] !== "-") {
            this.s.push(this.argv[i++]);
        }
        if(i < this.argv.length) {
            while(i < this.argv.length) {
                if(this.argv[i][0] === "-") {
                    resSet = this.walk(i + 1);
                    if(this.argv[i][1] === "-") {
                        this.dds[this.argv[i].substr(2)] = resSet;
                    } else {
                        this.ds[this.argv[i].substr(1)] = resSet;
                    }
                    i += resSet.length + 1;
                }
            }
        }
        return {
            "single": this.s,
            "dash": this.ds,
            "doubledash": this.dds
        };
    };
    Parser.prototype.walk = function (from) {
        var list = [];
        if(from >= this.argv.length) {
            return [];
        }
        while(this.argv[from] && this.argv[from][0] !== "-") {
            list.push(this.argv[from]);
            from++;
        }
        return list;
    };
    Parser.prototype.dash = function () {
        return this.ds;
    };
    Parser.prototype.doubledash = function () {
        return this.dds;
    };
    return Parser;
})();
exports.Parser = Parser;

