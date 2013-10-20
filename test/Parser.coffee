COVERAGE = process.env["RUNNING_COVERAGE"]
lib_loc = "../#{if COVERAGE then "lib-cov" else "lib"}"
parser = require "#{lib_loc}/Parser"

chai = require "chai"
do chai.should

describe "Parser", ->
	it "should have good getters / setters", ->

		Parser = new parser();
		Parser.raw_args = "ceva naspa"

		(typeof Parser.raw_args).should.not.equal "undefined"
		(typeof Parser.raw_args).should.equal "object"

		Parser.raw_args.length.should.equal 2

		Parser.raw_args[0].should.equal "ceva"
		Parser.raw_args[1].should.equal "naspa"

		Parser.raw_args = ["ceva", "naspa", "ca", "dracu"]

		(typeof Parser.raw_args).should.not.equal "undefined"
		(typeof Parser.raw_args).should.equal "object"

		Parser.raw_args.length.should.equal 4

		Parser.raw_args[0].should.equal "ceva"
		Parser.raw_args[1].should.equal "naspa"
		Parser.raw_args[2].should.equal "ca"
		Parser.raw_args[3].should.equal "dracu"


	it "should get the proper things at init", ->

		Parser = new parser("some crazy batshit");

		(typeof Parser.raw_args).should.not.equal "undefined"
		(typeof Parser.raw_args).should.equal "object"

		Parser.raw_args.length.should.equal 3

		Parser.raw_args[0].should.equal "some"
		Parser.raw_args[1].should.equal "crazy"
		Parser.raw_args[2].should.equal "batshit"

	it "should get the bare arguments at init", ->

		Parser = new parser("some crazy batshit");

		(typeof Parser.bareArgs).should.not.equal "undefined"
		(typeof Parser.bareArgs).should.equal "object"

		Parser.bareArgs.length.should.equal 3

		Parser.bareArgs[0].should.equal "some"
		Parser.bareArgs[1].should.equal "crazy"
		Parser.bareArgs[2].should.equal "batshit"

	it "should get the single-quote at init", ->

		Parser = new parser("some crazy batshit -s -c");

		(typeof Parser.singleDashArgs).should.not.equal "undefined"
		(typeof Parser.singleDashArgs).should.equal "object"

		Parser.singleDashArgs.length.should.equal 2

		(typeof Parser.singleDashArgs[0]).should.equal "object"
		Parser.singleDashArgs[0].length.should.equal 0
		(typeof Parser.singleDashArgs[1]).should.equal "object"
		Parser.singleDashArgs[1].length.should.equal 0
		(typeof Parser.singleDashArgs["s"]).should.equal "object"
		Parser.singleDashArgs["s"].length.should.equal 0
		(typeof Parser.singleDashArgs["c"]).should.equal "object"
		Parser.singleDashArgs["c"].length.should.equal 0

	it "should get the single-quote at init and booleanify", ->

		Parser = new parser("some crazy batshit -s -c").booleanify();

		(typeof Parser.singleDashArgs).should.not.equal "undefined"
		(typeof Parser.singleDashArgs).should.equal "object"

		Parser.singleDashArgs.length.should.equal 2

		(typeof Parser.singleDashArgs[0]).should.equal "boolean"
		Parser.singleDashArgs[0].should.equal true
		(typeof Parser.singleDashArgs[1]).should.equal "boolean"
		Parser.singleDashArgs[1].should.equal true
		(typeof Parser.singleDashArgs["s"]).should.equal "boolean"
		Parser.singleDashArgs["s"].should.equal true
		(typeof Parser.singleDashArgs["c"]).should.equal "boolean"
		Parser.singleDashArgs["c"].should.equal true

	it "should get the single-quote at init and booleanify WITH EXPECT", ->

		Parser = new parser("some crazy batshit -s -c").expect("-s", "-p", "-c").booleanify();

		(typeof Parser.singleDashArgs).should.not.equal "undefined"
		(typeof Parser.singleDashArgs).should.equal "object"

		Parser.singleDashArgs.length.should.equal 3

		(typeof Parser.singleDashArgs[0]).should.equal "boolean"
		Parser.singleDashArgs[0].should.equal true
		(typeof Parser.singleDashArgs[1]).should.equal "boolean"
		Parser.singleDashArgs[1].should.equal true
		(typeof Parser.singleDashArgs[2]).should.equal "boolean"
		Parser.singleDashArgs[2].should.equal false
		(typeof Parser.singleDashArgs["s"]).should.equal "boolean"
		Parser.singleDashArgs["s"].should.equal true
		(typeof Parser.singleDashArgs["c"]).should.equal "boolean"
		Parser.singleDashArgs["c"].should.equal true
		(typeof Parser.singleDashArgs["p"]).should.equal "boolean"
		Parser.singleDashArgs["p"].should.equal false

	it "should get the double-quote at init", ->

		Parser = new parser("some crazy batshit --save --compile");

		(typeof Parser.doubleDashArgs).should.not.equal "undefined"
		(typeof Parser.doubleDashArgs).should.equal "object"

		Parser.doubleDashArgs.length.should.equal 2

		(typeof Parser.doubleDashArgs[0]).should.equal "object"
		Parser.doubleDashArgs[0].length.should.equal 0
		(typeof Parser.doubleDashArgs[1]).should.equal "object"
		Parser.doubleDashArgs[1].length.should.equal 0
		(typeof Parser.doubleDashArgs["save"]).should.equal "object"
		Parser.doubleDashArgs["save"].length.should.equal 0
		(typeof Parser.doubleDashArgs["compile"]).should.equal "object"
		Parser.doubleDashArgs["compile"].length.should.equal 0

	it "should get the single-quote conjoined at init", ->

		Parser = new parser("some crazy batshit -sc");

		(typeof Parser.singleDashArgs).should.not.equal "undefined"
		(typeof Parser.singleDashArgs).should.equal "object"

		Parser.singleDashArgs.length.should.equal 2

		(typeof Parser.singleDashArgs[0]).should.equal "object"
		Parser.singleDashArgs[0].length.should.equal 0
		(typeof Parser.singleDashArgs[1]).should.equal "object"
		Parser.singleDashArgs[1].length.should.equal 0
		(typeof Parser.singleDashArgs["s"]).should.equal "object"
		Parser.singleDashArgs["s"].length.should.equal 0
		(typeof Parser.singleDashArgs["c"]).should.equal "object"
		Parser.singleDashArgs["c"].length.should.equal 0


	it "should get the single-quote and arguments at init", ->

		Parser = new parser("some crazy batshit -sc ceva foarte naspa");

		(typeof Parser.singleDashArgs).should.not.equal "undefined"
		(typeof Parser.singleDashArgs).should.equal "object"

		Parser.singleDashArgs.length.should.equal 2


		(typeof Parser.singleDashArgs[0]).should.equal "object"
		Parser.singleDashArgs[0].length.should.equal 0
		(typeof Parser.singleDashArgs[1]).should.equal "object"
		Parser.singleDashArgs[1].length.should.equal 2
		(typeof Parser.singleDashArgs["s"]).should.equal "object"
		Parser.singleDashArgs["s"].length.should.equal 0
		(typeof Parser.singleDashArgs["c"]).should.equal "object"
		Parser.singleDashArgs["c"].length.should.equal 2

		Parser.singleDashArgs["c"][0].should.equal "ceva"
		Parser.singleDashArgs["c"][1].should.equal "foarte"


	it "should get the double-quote and arguments at init", ->

		Parser = new parser("some crazy batshit --save ceva foarte --compile not naspa");

		(typeof Parser.doubleDashArgs).should.not.equal "undefined"
		(typeof Parser.doubleDashArgs).should.equal "object"

		Parser.doubleDashArgs.length.should.equal 2


		(typeof Parser.doubleDashArgs[0]).should.equal "object"
		Parser.doubleDashArgs[0].length.should.equal 2
		(typeof Parser.doubleDashArgs[1]).should.equal "object"
		Parser.doubleDashArgs[1].length.should.equal 1
		(typeof Parser.doubleDashArgs["save"]).should.equal "object"
		Parser.doubleDashArgs["save"].length.should.equal 2
		(typeof Parser.doubleDashArgs["compile"]).should.equal "object"
		Parser.doubleDashArgs["compile"].length.should.equal 1

		Parser.doubleDashArgs["save"][0].should.equal "ceva"
		Parser.doubleDashArgs["save"][1].should.equal "foarte"

		Parser.doubleDashArgs["compile"][0].should.equal "not"

	it "should get the double-quote and single-quote arguments at init", ->

		Parser = new parser("some crazy batshit -sc nimic util --save ceva foarte --compile not naspa");

		(typeof Parser.doubleDashArgs).should.not.equal "undefined"
		(typeof Parser.doubleDashArgs).should.equal "object"

		Parser.doubleDashArgs.length.should.equal 2

		(typeof Parser.doubleDashArgs[0]).should.equal "object"
		Parser.doubleDashArgs[0].length.should.equal 2
		(typeof Parser.doubleDashArgs[1]).should.equal "object"
		Parser.doubleDashArgs[1].length.should.equal 1
		(typeof Parser.doubleDashArgs["save"]).should.equal "object"
		Parser.doubleDashArgs["save"].length.should.equal 2
		(typeof Parser.doubleDashArgs["compile"]).should.equal "object"
		Parser.doubleDashArgs["compile"].length.should.equal 1

		Parser.doubleDashArgs["save"][0].should.equal "ceva"
		Parser.doubleDashArgs["save"][1].should.equal "foarte"

		Parser.doubleDashArgs["compile"][0].should.equal "not"


		Parser.singleDashArgs.length.should.equal 2


		(typeof Parser.singleDashArgs[0]).should.equal "object"
		Parser.singleDashArgs[0].length.should.equal 0
		(typeof Parser.singleDashArgs[1]).should.equal "object"
		Parser.singleDashArgs[1].length.should.equal 2
		(typeof Parser.singleDashArgs["s"]).should.equal "object"
		Parser.singleDashArgs["s"].length.should.equal 0
		(typeof Parser.singleDashArgs["c"]).should.equal "object"
		Parser.singleDashArgs["c"].length.should.equal 2

		Parser.singleDashArgs["c"][0].should.equal "nimic"
		Parser.singleDashArgs["c"][1].should.equal "util"

	it "should get the double-quote and single-quote arguments and FINAL ARG at init", ->

		Parser = new parser("some crazy batshit -sc nimic util --save ceva foarte --compile not naspa");

		(typeof Parser.doubleDashArgs).should.not.equal "undefined"
		(typeof Parser.doubleDashArgs).should.equal "object"

		Parser.doubleDashArgs.length.should.equal 2

		(typeof Parser.doubleDashArgs[0]).should.equal "object"
		Parser.doubleDashArgs[0].length.should.equal 2
		(typeof Parser.doubleDashArgs[1]).should.equal "object"
		Parser.doubleDashArgs[1].length.should.equal 1
		(typeof Parser.doubleDashArgs["save"]).should.equal "object"
		Parser.doubleDashArgs["save"].length.should.equal 2
		(typeof Parser.doubleDashArgs["compile"]).should.equal "object"
		Parser.doubleDashArgs["compile"].length.should.equal 1

		Parser.doubleDashArgs["save"][0].should.equal "ceva"
		Parser.doubleDashArgs["save"][1].should.equal "foarte"

		Parser.doubleDashArgs["compile"][0].should.equal "not"

		Parser.singleDashArgs.length.should.equal 2

		(typeof Parser.singleDashArgs[0]).should.equal "object"
		Parser.singleDashArgs[0].length.should.equal 0
		(typeof Parser.singleDashArgs[1]).should.equal "object"
		Parser.singleDashArgs[1].length.should.equal 2
		(typeof Parser.singleDashArgs["s"]).should.equal "object"
		Parser.singleDashArgs["s"].length.should.equal 0
		(typeof Parser.singleDashArgs["c"]).should.equal "object"
		Parser.singleDashArgs["c"].length.should.equal 2

		Parser.singleDashArgs["c"][0].should.equal "nimic"
		Parser.singleDashArgs["c"][1].should.equal "util"

		(typeof Parser.finalArg).should.not.equal "undefined"
		(typeof Parser.finalArg).should.equal "string"

		Parser.finalArg.should.equal "naspa"

	it "should get the double-quote and single-quote arguments and WITHOUT FINAL ARG at init", ->

		Parser = new parser("some crazy batshit -sc nimic util --save ceva foarte --compile naspa");

		(typeof Parser.doubleDashArgs).should.not.equal "undefined"
		(typeof Parser.doubleDashArgs).should.equal "object"

		Parser.doubleDashArgs.length.should.equal 2

		(typeof Parser.doubleDashArgs[0]).should.equal "object"
		Parser.doubleDashArgs[0].length.should.equal 2
		(typeof Parser.doubleDashArgs[1]).should.equal "object"
		Parser.doubleDashArgs[1].length.should.equal 1
		(typeof Parser.doubleDashArgs["save"]).should.equal "object"
		Parser.doubleDashArgs["save"].length.should.equal 2
		(typeof Parser.doubleDashArgs["compile"]).should.equal "object"
		Parser.doubleDashArgs["compile"].length.should.equal 1

		Parser.doubleDashArgs["save"][0].should.equal "ceva"
		Parser.doubleDashArgs["save"][1].should.equal "foarte"

		Parser.doubleDashArgs["compile"][0].should.equal "naspa"

		Parser.singleDashArgs.length.should.equal 2

		(typeof Parser.singleDashArgs[0]).should.equal "object"
		Parser.singleDashArgs[0].length.should.equal 0
		(typeof Parser.singleDashArgs[1]).should.equal "object"
		Parser.singleDashArgs[1].length.should.equal 2
		(typeof Parser.singleDashArgs["s"]).should.equal "object"
		Parser.singleDashArgs["s"].length.should.equal 0
		(typeof Parser.singleDashArgs["c"]).should.equal "object"
		Parser.singleDashArgs["c"].length.should.equal 2

		Parser.singleDashArgs["c"][0].should.equal "nimic"
		Parser.singleDashArgs["c"][1].should.equal "util"

		(typeof Parser.finalArg).should.not.equal "string"
		(typeof Parser.finalArg).should.equal "object"

	it "should get the double-quote and single-quote arguments and FINAL ARG at init and LINK THEM", ->

		Parser = new parser("some crazy batshit -sc nimic util --save ceva foarte --compile not naspa").link "--save": "-s", "-c": "--compile";

		(typeof Parser.doubleDashArgs).should.not.equal "undefined"
		(typeof Parser.doubleDashArgs).should.equal "object"

		Parser.doubleDashArgs.length.should.equal 2

		(typeof Parser.doubleDashArgs[0]).should.equal "object"
		Parser.doubleDashArgs[0].length.should.equal 2
		(typeof Parser.doubleDashArgs[1]).should.equal "object"
		Parser.doubleDashArgs[1].length.should.equal 3
		(typeof Parser.doubleDashArgs["save"]).should.equal "object"
		Parser.doubleDashArgs["save"].length.should.equal 2
		(typeof Parser.doubleDashArgs["compile"]).should.equal "object"
		Parser.doubleDashArgs["compile"].length.should.equal 3

		Parser.doubleDashArgs["save"][0].should.equal "ceva"
		Parser.doubleDashArgs["save"][1].should.equal "foarte"

		Parser.doubleDashArgs["compile"][0].should.equal "not"
		Parser.doubleDashArgs["compile"][1].should.equal "nimic"
		Parser.doubleDashArgs["compile"][2].should.equal "util"

		Parser.singleDashArgs.length.should.equal 2

		(typeof Parser.singleDashArgs[0]).should.equal "object"
		Parser.singleDashArgs[0].length.should.equal 2
		(typeof Parser.singleDashArgs[1]).should.equal "object"
		Parser.singleDashArgs[1].length.should.equal 3
		(typeof Parser.singleDashArgs["s"]).should.equal "object"
		Parser.singleDashArgs["s"].length.should.equal 2
		(typeof Parser.singleDashArgs["c"]).should.equal "object"
		Parser.singleDashArgs["c"].length.should.equal 3

		Parser.singleDashArgs["c"][0].should.equal "nimic"
		Parser.singleDashArgs["c"][1].should.equal "util"
		Parser.singleDashArgs["c"][2].should.equal "not"

		Parser.singleDashArgs["s"][0].should.equal "ceva"
		Parser.singleDashArgs["s"][1].should.equal "foarte"

		(typeof Parser.finalArg).should.not.equal "undefined"
		(typeof Parser.finalArg).should.equal "string"

		Parser.finalArg.should.equal "naspa"


